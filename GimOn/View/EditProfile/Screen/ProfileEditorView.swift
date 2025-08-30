//
//  ProfileEditorView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 08/08/25.
//

import SwiftUI

struct ProfileEditorView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var showDiscardAlert = false
    @State private var showEmptyInputAlert = false
    @State private var initialInput: String = ""
    
    let navTitle: String
    let inputPlaceholder: String
    let instruction: String
    @Binding var inputValue: String
    var onSave: (() -> Void)?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                TextField(inputPlaceholder, text: $inputValue)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text(instruction)
                    .foregroundStyle(AppColors.primaryTextColor)
                    .multilineTextAlignment(.leading)
                
                HStack(spacing: 12) {
                    BorderedButton("Cancel", fixedWidth: false) {
                        handleCancel()
                    }
                    
                    BorderedButton("Save", fixedWidth: false) {
                        handleSave()
                    }
                }
                .padding(.top, 12)
            }
            .padding(.horizontal)
            .padding(.top, 24)
        }
        .font(.custom(AppFonts.regular, size: AppFontSizes.body))
        .toolbarBackground(.black, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackArrowButton { handleCancel() }
            }
            
            ToolbarItem(placement: .principal) {
                Text(navTitle)
                    .font(.custom(AppFonts.bold, size: AppFontSizes.title3))
                    .foregroundStyle(AppColors.primaryColor)
            }
        }
        .onAppear {
            initialInput = inputValue
        }
        .alert("Discard Changes?", isPresented: $showDiscardAlert) {
            Button("Discard", role: .destructive) {
                handleDiscard()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("You have unsaved changes. \nAre you sure you want to discard them?")
        }
        .alert("Cannot Save", isPresented: $showEmptyInputAlert) {
            Button("Ok", role: .cancel) { }
        } message: {
            Text("This field cannot be left empty.")
        }
        .background(.black)
    }
}

private extension ProfileEditorView {
    var trimmedValue: String {
        inputValue.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private func handleDiscard() {
        inputValue = initialInput
        dismiss()
    }
    
    private func handleCancel() {
        if inputValue != initialInput {
            showDiscardAlert = true
        } else {
            dismiss()
        }
    }
    
    private func handleSave() {
        guard !trimmedValue.isEmpty else {
            showEmptyInputAlert = true
            return
        }
        
        onSave?()
        dismiss()
    }
}
