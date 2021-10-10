//
//  ViewController.swift
//  Chapter93_AVSpeechSynthesizer
//
//  Created by 小鍋涼太 on 2021/10/10.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBAction func didTapButton(_ sender: Any) {
        // 端末じゃないと動かなさそう。消音モードでも動かない。
        let speaker = AVSpeechSynthesizer()
        let speech = AVSpeechUtterance(string: "こんにちは")
        speaker.speak(speech)
    }
    
}

