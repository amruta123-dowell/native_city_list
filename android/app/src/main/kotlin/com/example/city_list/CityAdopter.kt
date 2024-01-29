package com.example.city_list

import android.content.Context
import android.view.Gravity
import android.view.ViewGroup
import android.widget.Button
import android.widget.FrameLayout
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class CityAdapter(private val cityList: List<CityModel>,  val getCityDetailsHandler:GetStateListPlatformHandler) :
    RecyclerView.Adapter<CityAdapter.CityViewHolder>() {

    class CityViewHolder( context: Context) : RecyclerView.ViewHolder(FrameLayout(context)) {
        val cityNameTextView: TextView = TextView(context)
        val cityButton: Button = Button(context)

        init {
            // Set up the layout parameters for FrameLayout
            val layoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.WRAP_CONTENT
            )
            itemView.layoutParams = layoutParams

            // Set up the layout parameters for TextView
            cityNameTextView.textSize = 18f
            val textLayoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.WRAP_CONTENT,
                FrameLayout.LayoutParams.WRAP_CONTENT
            )
            cityNameTextView.layoutParams = textLayoutParams

            // Set up the layout parameters for Button
            val buttonLayoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.WRAP_CONTENT,
                FrameLayout.LayoutParams.WRAP_CONTENT
            )
            buttonLayoutParams.gravity = Gravity.END
            cityButton.layoutParams = buttonLayoutParams

            // Add TextView and Button to the FrameLayout
            (itemView as FrameLayout).addView(cityNameTextView)
            (itemView as FrameLayout).addView(cityButton)
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CityViewHolder {
        return CityViewHolder(parent.context)
    }

    override fun onBindViewHolder(holder: CityViewHolder, position: Int) {
        val cityName = cityList[position]

        // Set data to TextView
        holder.cityNameTextView.text = cityName.name

        // Set up the button click listener
        holder.cityButton.setOnClickListener {
            onItemClick(position)
        }
    }

    private fun onItemClick(position: Int) {
        println("position---> $position")
      val selectedDetails =  cityList[position].state
    getCityDetailsHandler.sendEvent(selectedDetails)

//      val  itemDetails =
//          mapOf("name" to cityList[position].name, "id" to  cityList[position].id,
//                     "state" to cityList[position].state)



    }

    override fun getItemCount(): Int {

        return cityList.size
    }
}
