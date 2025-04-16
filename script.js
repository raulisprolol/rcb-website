function downloadWindows() {
    // Download RCB installer for Windows
    window.open('download/installer/install_rcb.bat', '_blank');
    
    // Download VS Code extension for Windows
    window.open('https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools', '_blank');
    
    // Download Visual Studio Build Tools (required for Windows)
    window.open('https://visualstudio.microsoft.com/visual-cpp-build-tools/', '_blank');
}

function downloadMac() {
    // Download RCB installer for macOS
    window.open('download/installer/install_rcb_macos.sh', '_blank');
    
    // Download VS Code extension for macOS
    window.open('https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools', '_blank');
    
    // Download Homebrew (required for macOS)
    window.open('https://brew.sh/', '_blank');
}

function downloadLinux() {
    // Download RCB installer for Linux
    window.open('download/installer/install_rcb.sh', '_blank');
    
    // Download VS Code extension for Linux
    window.open('https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools', '_blank');
    
    // Download GCC (required for Linux)
    window.open('https://gcc.gnu.org/', '_blank');
}

function downloadVSCode() {
    // Open VS Code download page
    window.open('https://code.visualstudio.com/download', '_blank');
    
    // Open RCB VS Code extension page
    window.open('https://marketplace.visualstudio.com/items?itemName=rcb-language.rcb', '_blank');
}

// Initialize Monaco editor
const editor = monaco.editor.create(document.getElementById('code-editor'), {
    value: '// Try some RCB code!\n#include <rcb.h>\n#include <stdio.h>\n\nint main() {\n    printf("Welcome to RCB Playground!\n");\n    return 0;\n}',
    language: 'c',
    theme: 'vs-dark',
    automaticLayout: true
});

// Initialize output area
const outputDiv = document.getElementById('code-output');

// Run code button
const runButton = document.getElementById('run-code');
runButton.addEventListener('click', async () => {
    const code = editor.getValue();
    try {
        // Clear output
        outputDiv.textContent = '';
        
        // Simulate code execution
        const result = await simulateCodeExecution(code);
        outputDiv.textContent = result;
    } catch (error) {
        outputDiv.textContent = `Error: ${error.message}`;
    }
});

// Clear code button
const clearButton = document.getElementById('clear-code');
if (clearButton) {
    clearButton.addEventListener('click', () => {
        editor.setValue('// Try some RCB code!\n#include <rcb.h>\n#include <stdio.h>\n\nint main() {\n    printf("Welcome to RCB Playground!\n");\n    return 0;\n}');
        outputDiv.textContent = '// Output will appear here';
    });
}

// Save code button
const saveButton = document.getElementById('save-code');
if (saveButton) {
    saveButton.addEventListener('click', () => {
        const code = editor.getValue();
        const blob = new Blob([code], { type: 'text/plain' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'program.rcb';
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
    });
}

// Simulate code execution (in real implementation, this would compile and run the code)
async function simulateCodeExecution(code) {
    // This is a mock implementation
    return new Promise((resolve) => {
        setTimeout(() => {
            resolve('Program executed successfully!\n\n' + 
                   'Output:\n' +
                   'Welcome to RCB Playground!\n' +
                   'Code compiled in 0.123 seconds\n' +
                   'Memory usage: 1.2MB');
        }, 1000);
    });
}
