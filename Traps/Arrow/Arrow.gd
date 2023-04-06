extends Node2D





func _on_booster_area_entered(area):
	$AnimationPlayer.play("Death")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Death":
		queue_free()
