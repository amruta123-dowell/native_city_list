package com.example.city_list

data class CityModel(
    val id: String,
    val name: String,
    val state: String
){
    fun toMap(): Map<String, Any?> {
        return mapOf(
            "id" to id,
            "name" to name,
            "state" to state
        )
    }
}