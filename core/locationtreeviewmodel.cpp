#include "locationtreeviewmodel.h"
#include "locationmodel.h"

LocationTreeViewModel::LocationTreeViewModel(QObject *parent)
    : TreeViewModel(parent)
{
    m_locationModel = new LocationModel(this);
    setSourceModel(m_locationModel);

    connect(m_locationModel, SIGNAL(showOnlyGreenhouseLocationsChanged()), this,
            SIGNAL(showOnlyGreenhouseLocationsChanged()));
    connect(m_locationModel, SIGNAL(depthChanged()), this, SIGNAL(depthChanged()));
    connect(m_locationModel, SIGNAL(countChanged()), this, SIGNAL(countChanged()));
}

bool LocationTreeViewModel::showOnlyGreenhouseLocations() const
{
    return m_locationModel->showOnlyEmptyLocations();
}

void LocationTreeViewModel::setShowOnlyGreenhouseLocations(bool show)
{
    m_locationModel->setShowOnlyGreenhouseLocations(show);
}

int LocationTreeViewModel::depth() const
{
    return m_locationModel->depth();
}
