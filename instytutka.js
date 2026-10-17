document.addEventListener('DOMContentLoaded', () => {
  const divider = document.getElementById('divider');
  const container = document.body;
  const leftPanel = document.getElementById('reading');
  const rightPanel = document.getElementById('ling');
  
  // Track the currently highlighted elements in *both* panels
  let activeReadingElement = null;
  let activeLingElement = null;
  
  if (! divider || ! leftPanel || ! rightPanel) {
    console.error("Layout elements not found!");
    return;
  }
  
  divider.addEventListener('mousedown', (e) => {
    e.preventDefault();
    
    const onMouseMove = (e) => {
      const containerRect = container.getBoundingClientRect();
      let leftWidth = e.clientX - containerRect.left;
      let totalWidth = containerRect.width;
      
      let leftPercentage = (leftWidth / totalWidth) * 100;
      leftPercentage = Math.max(15, Math.min(85, leftPercentage));
      let rightPercentage = 100 - leftPercentage;
      
      leftPanel.style.flex = `0 0 ${leftPercentage}%`;
      rightPanel.style.flex = `0 0 ${rightPercentage}%`;
    };
    
    const onMouseUp = () => {
      document.removeEventListener('mousemove', onMouseMove);
      document.removeEventListener('mouseup', onMouseUp);
      divider.classList.remove('is-dragging');
    };
    
    document.addEventListener('mousemove', onMouseMove);
    document.addEventListener('mouseup', onMouseUp);
    divider.classList.add('is-dragging');
  });
  
  // Intercept clicks on links/fragments in *either* panel
  // Intercept clicks on links/fragments in *either* panel
  // Intercept clicks on links/fragments in *either* panel
  // Intercept clicks on links/fragments in *either* panel
  document.addEventListener('click', (e) => {
    const link = e.target.closest('a');
    
    if (link && link.getAttribute('href') && link.getAttribute('href').startsWith('#')) {
      e.preventDefault();
      
      const hrefValue = link.getAttribute('href').substring(1);
      // e.g., "l-d1e7" or "r-d1e7"
      
      let clickedElement = link;
      let partnerElement, panelToScroll;
      
      // Determine direction and find the partner element via prefix swapping
      if (hrefValue.startsWith('l-')) {
        // Clicked in #reading, targeting #ling
        partnerElement = rightPanel.querySelector(`#${CSS.escape(hrefValue)}`);
        panelToScroll = rightPanel;
      } else if (hrefValue.startsWith('r-')) {
        // Clicked in #ling, targeting #reading
        partnerElement = leftPanel.querySelector(`#${CSS.escape(hrefValue)}`);
        panelToScroll = leftPanel;
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