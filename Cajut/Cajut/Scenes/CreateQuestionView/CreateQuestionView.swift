//
//  CreateQuestionView.swift
//  Cajut
//
//  Created by Paulo Vázquez Acosta on 25/5/22.
//

import SwiftUI
import AlertToast

struct CreateQuestionView: View {
    
    @StateObject private var viewModel: CreateQuestionViewModel
    
    init(gameshowId: String) {
        _viewModel = StateObject(wrappedValue: CreateQuestionViewModel(gameshowId: gameshowId))
    }
    
    var body: some View {
        
        ZStack(alignment: .center) {
            VStack(spacing: 20) {
                
                Text(viewModel.createQuestionMainTitle) // <- Queda aquí porque no conseguí modificarlo si lo pongo como título de la vista
                    .bold()
                
                CustomTextFieldView(title: viewModel.questionTextFieldTitle, placeholder: viewModel.questionPlaceholderTextFieldStringKey, size: .big, value: $viewModel.question)
                    .disabled(viewModel.isTextFieldDisabled)
                
                ScrollView {
                    ForEach(0..<viewModel.answers.count) { number in
                        CustomTextFieldView(title: "Answer \(number + 1)", placeholder: viewModel.answerPlaceholderTextFieldStringKey, value: $viewModel.answers[number])
                            .disabled(viewModel.isTextFieldDisabled)
                    }
                }
                
                Spacer()
                
                HStack {
                    switch viewModel.viewState {
                    case .normal, .errorServer, .noNetworkError, . errorNil:
                        MainButtonView(style: .blue,
                                       text: viewModel.createGameButtonStringKey) {
                            viewModel.createQuestion()
                        }
                        .disabled(viewModel.isCreateButtonIsDisabled)
                            .accessibilityLabel("createQuestion.createbutton")
                    case .loading:
                        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                    case .success:
                        if let createdQuestion = viewModel.createdQuestion {
                            AlertToast(type: .regular, title: "Question created")
                        }
                    }
                }
                .padding(.bottom, 30)
            }
            
            switch viewModel.viewState {
            case .errorServer:
                CreateGameshowErrorView(errorText: viewModel.errorServerStringKey)
            case .noNetworkError:
                CreateGameshowErrorView(errorText: viewModel.noNetworkStringKey)
            default:
                EmptyView()
            }
        }
        .foregroundColor(.white)
        .background(Color.appBackground.ignoresSafeArea())
    }
}

struct CreateQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateQuestionView(gameshowId: "123456")
        }
    }
}
