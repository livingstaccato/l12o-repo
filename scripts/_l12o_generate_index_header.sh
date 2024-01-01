#!/bin/bash

function generate_header() {
  directory="$1"
  repo_dir="$(sed 's|/repo||g' <<< ${directory})/"


  cat <<EOF
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>index of ${repo_dir}</title>
  <style>
    /* Your existing CSS styles for the page */
    body {
      font-family: 'Fira Mono', monospace;
      font-size: 16px;
      background-color: #ccc; /* Default background color (light mode) */
      color: #222; /* Default text color (light mode) */
      transition: background-color 0.3s, color 0.3s;
    }

    /* Dark mode */
    body.dark-mode {
      background-color: #222; /* Very dark grey background in dark mode */
      color: #999; /* Light grey/cream-colored text in dark mode */
    }

    /* Terminal green for code text in dark mode */
    body.dark-mode .code-block {
      color: #11ff11;
    }

    .container {
      max-width: 100%;
      margin: 0 auto;
      padding: 20px;
    }

    h1 {
      text-align: left;
      color: #333;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
      font-size: 16px; /* Default font size for tables */
    }

    table, th, td {
      border-top: 1px solid #ccc;
      border-bottom: 1px solid #ccc;
    }

    th, td {
      padding: 10px;
      text-align: left;
    }

    /* Background color tint shift on row hover */
    tr:hover {
      background-color: rgba(255, 255, 0, 0.1); /* Adjust the color and opacity as desired */
    }

    /* Responsive code blocks */
    @media screen and (max-width: 600px) {
      table {
        font-size: 14px;
      }

      .code-block {
        font-size: 18px; /* Adjust the font size for smaller screens */
      }
    }

    /* Increase font size for high-resolution vertical screens */
    @media screen and (min-resolution: 192dpi) and (orientation: portrait) {
      table {
        font-size: 20px; /* Increase font size for high-resolution vertical screens */
      }
    }

    /* Code block styles */
    .code-block {
      font-weight: bold;
      width: 100%;
      max-width: 100%;
      overflow-x: auto;
      white-space: pre-wrap;
      font-family: monospace;
      font-size: 16px;
      background-color: #f5f5f5; /* Default code block background color (light mode) */
      padding: 20px;
      margin-top: 20px;
    }

    /* Dark mode code block background color */
    body.dark-mode .code-block {
      background-color: #111;
    }

    body.dark-mode h1 {
      color: #999;
    }

    /* Ensure legible links on dark background */
    a {
      color: #007acc; /* Default link color (light mode) */
    }

    /* Link color in dark mode */
    body.dark-mode a {
      color: #00aaff; /* Adjust the link color in dark mode for better legibility */
    }
  </style>


  <script>
    // Wait for the DOM content to be fully loaded
  document.addEventListener('DOMContentLoaded', function() {
    // Check if dark mode is preferred by the user's system
    if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
      // Make sure the 'body' element exists before accessing its classList
      if (document.body) {
        document.body.classList.add('dark-mode');
      }
    }
  });
  </script>
</head>
<body>
  <div class="container">
    <pre class="code-block">
                  ,.
               (\(\)
,_              ;  o >    _     _    __                                       
{\`-.          /  (_)     (_ ) /' ) /'__\`                                     
\`={\`-._____/\`    |        | |(_, |(_)  ) )   _       _ __   __   _ _      _   
 \`-{ /    -=\`\   |        | |  | |   /' /  /'_\`\\    ( '__)/'__\`\\( '_\`\\  /'_\`\\ 
  \`={  -= = _/   /        | |  | | /' /( )( (_) )   | |  (  ___/| (_) )( (_) )
     \`\\  .-'   /\`        (___) (_)(_____/'\`\\___/'   (_)  \`\\____)| ,__/\`\\____/'
      {\`-,__.'===,_                                             | |           
      //\`        \`\\\\                                            (_)           
     //
    \`\\=
    </pre>
    <h1>index of ${repo_dir}</h1>
    <table class="table">
      <thead>
        <tr>
          <th>File Name</th>
          <th>Size</th>
          <th>Last Modified</th>
        </tr>
      </thead>
      <tbody>
EOF
}
