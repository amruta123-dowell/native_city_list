package com.example.city_list

import android.content.Context
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.FrameLayout
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class CityAdapter(private val cityList: List<CityModel>, private val getCityDetailsHandler:GetStateListPlatformHandler) :
    RecyclerView.Adapter<CityAdapter.CityViewHolder>() {

    class CityViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val textViewItem: TextView = itemView.findViewById(R.id.textViewItem)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CityViewHolder {
        // Inflate the item_button.xml layout for each item
        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_button, parent, false)
        return CityViewHolder(view)
    }

    override fun onBindViewHolder(holder: CityViewHolder, position: Int) {
        val cityName = cityList[position]

        // Set data to TextView
        holder.textViewItem.text = cityName.name

        // Set up the button click listener
        holder.itemView.setOnClickListener {
            onItemClick(position)
        }
    }

    private fun onItemClick(position: Int) {
        println("position---> $position")
      val selectedDetails =  cityList[position].state
    getCityDetailsHandler.sendEvent(selectedDetails)

    }

    override fun getItemCount(): Int {

        return cityList.size
    }
}
