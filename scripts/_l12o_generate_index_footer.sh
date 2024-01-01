#!/bin/bash

function generate_footer() {
  cat <<EOF
      </tbody>
    </table>
  </div>
</section>
 <script>
    // Dark mode toggle
    const body = document.querySelector('body');
    document.addEventListener('DOMContentLoaded', () => {
      const darkModeToggle = document.createElement('button');
      darkModeToggle.textContent = '🔦';
      darkModeToggle.classList.add('dark-mode-toggle');
      document.body.appendChild(darkModeToggle);

      darkModeToggle.addEventListener('click', () => {
        body.classList.toggle('dark-mode');
      });
    });
  </script>
</body>
</html>
EOF
}
