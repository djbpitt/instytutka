document.addEventListener('DOMContentLoaded', () => {
    const divider = document.getElementById('divider');
    const container = document.body;
    const leftPanel = document.getElementById('reading');
    const rightPanel = document.getElementById('ling');
    
    if (! divider || ! leftPanel || ! rightPanel) {
        console.error("Layout elements not found!");
        return;
    }
    
    // --- Modern Pointer Capture Resizing ---
    divider.addEventListener('pointerdown', (e) => {
        e.preventDefault();
        // Captures all pointer events so selection/flicker outside the divider stops
        divider.setPointerCapture(e.pointerId);
    });
    
    divider.addEventListener('pointermove', (e) => {
        // Only resize if the pointer is actively captured (prevents moving on simple hover)
        if (! divider.hasPointerCapture(e.pointerId)) return;
        
        const containerRect = container.getBoundingClientRect();
        let leftWidth = e.clientX - containerRect.left;
        let totalWidth = containerRect.width;
        
        let leftPercentage = (leftWidth / totalWidth) * 100;
        leftPercentage = Math.max(15, Math.min(85, leftPercentage));
        let rightPercentage = 100 - leftPercentage;
        
        leftPanel.style.flex = `0 0 ${leftPercentage}%`;
        rightPanel.style.flex = `0 0 ${rightPercentage}%`;
    });
    
    divider.addEventListener('pointerup', (e) => {
        if (divider.hasPointerCapture(e.pointerId)) {
            divider.releasePointerCapture(e.pointerId);
        }
    });
    
    // Track the currently highlighted elements in *both* panels
    let activeReadingElement = null;
    let activeLingElement = null;
    
    // Intercept clicks on links/fragments in *either* panel
    document.addEventListener('click', (e) => {
        const link = e.target.closest('a');
        
        if (link && link.getAttribute('href') && link.getAttribute('href').startsWith('#')) {
            e.preventDefault();
            
            const hrefValue = link.getAttribute('href').substring(1);
            
            let clickedElement = link;
            let partnerElement;
            
            // Determine direction and find the partner element via prefix swapping.
            // hrefValue is the ID of the target we want to scroll to and highlight.
            // We search inside the opposite panel's DOM tree using CSS.escape()
            // to safely treat the generated ID string as a literal CSS selector.
            if (hrefValue.startsWith('l-')) {
                partnerElement = rightPanel.querySelector(`#${CSS.escape(hrefValue)}`);
            } else if (hrefValue.startsWith('r-')) {
                partnerElement = leftPanel.querySelector(`#${CSS.escape(hrefValue)}`);
            }
            
            if (partnerElement) {
                // 1. Clear previous highlights from BOTH panels
                if (activeReadingElement) activeReadingElement.classList.remove('highlighted-target');
                if (activeLingElement) activeLingElement.classList.remove('highlighted-target');
                
                // 2. Assign new active elements and apply highlights
                if (hrefValue.startsWith('l-')) {
                    activeReadingElement = clickedElement;
                    activeLingElement = partnerElement;
                } else {
                    activeLingElement = clickedElement;
                    activeReadingElement = partnerElement;
                }
                
                activeReadingElement.classList.add('highlighted-target');
                activeLingElement.classList.add('highlighted-target');
                
                // 3. Scroll ONLY the target counterpart element inside the opposite panel
                partnerElement.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
                
                history.pushState(null, null, `#${hrefValue}`);
            }
        }
    });
});