import java.awt.Color
import java.awt.Font
import javax.swing.JFrame
import javax.swing.JLabel
import javax.swing.SwingConstants
import javax.swing.WindowConstants

fun showOSErrorScreen() {
    val frame = JFrame("Critical Error")
    frame.defaultCloseOperation = WindowConstants.EXIT_ON_CLOSE
    frame.background = Color.RED
    frame.contentPane.background = Color.RED
    frame.layout = null
    frame.setSize(700, 300)
    frame.setLocationRelativeTo(null)

    val label = JLabel(
        "<html><div style='text-align: center;'>Your OS switch has failed<br>due to a big unexpected error that could<br>brick your computer</div></html>",
        SwingConstants.CENTER
    )
    label.setBounds(0, 0, 700, 300)
    label.font = Font("Arial", Font.BOLD, 28)
    label.foreground = Color.BLACK
    frame.add(label)

    frame.isAlwaysOnTop = true
    frame.isVisible = true
}

fun main() {
    // Simulate detecting a fatal error
    val fatalError = true // Replace with real error detection logic
    if (fatalError) {
        showOSErrorScreen()
    }
}
