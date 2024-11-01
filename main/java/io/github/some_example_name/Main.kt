package io.github.some_example_name

import com.badlogic.gdx.Game
import com.badlogic.gdx.Screen
import com.badlogic.gdx.graphics.g2d.SpriteBatch

class Main : Game() {
    lateinit var batch: SpriteBatch
    var lastScreen: Screen? = null

    override fun create() {
        batch = SpriteBatch()
        // Ustawienie początkowego ekranu na MainScreen
        this.screen = MainScreen(this)
    }

    override fun render() {
        super.render() // Renderuje aktualny ekran
    }

    override fun dispose() {
        batch.dispose()
        screen?.dispose() // Zwalnia zasoby ekranu, jeśli istnieje
    }
}
