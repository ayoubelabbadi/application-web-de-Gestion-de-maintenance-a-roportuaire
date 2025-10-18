document.getElementById('searchForm').addEventListener('submit', async (event) => {
    event.preventDefault();
    
    const query = document.getElementById('searchInput').value;
    
    if (query) {
      try {
        const response = await fetch(`/api/search?q=${query}`);
        const results = await response.json();
  
        // Afficher les résultats
        console.log(results);
        displayResults(results);
      } catch (error) {
        console.error('Error searching:', error);
      }
    } else {
      alert('Please enter a search query');
    }
  });
  
  function displayResults(results) {
    const resultsContainer = document.getElementById('resultsContainer');
    resultsContainer.innerHTML = '';
  
    // Afficher les résultats d'équipement
    results.equipmentResults.forEach(equipment => {
      const div = document.createElement('div');
      div.innerHTML = `Equipment Name: ${equipment.Name}`;
      resultsContainer.appendChild(div);
    });
  
    // Afficher les résultats d'ingénieur
    results.engineerResults.forEach(engineer => {
      const div = document.createElement('div');
      div.innerHTML = `Engineer Name: ${engineer.FName} ${engineer.LName}`;
      resultsContainer.appendChild(div);
    });
  
    // Ajouter des affichages supplémentaires selon les besoins
  }
  