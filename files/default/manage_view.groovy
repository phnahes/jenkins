// Add Job on a Specific View
//
// Author: Paulo Nahes

import jenkins.model.*
import hudson.model.*

def job = Hudson.instance.getView("All").getItem(this.args[0])
def new_view = Hudson.instance.getView(this.args[1])

//def jobName = this.args[0]
def jobName = job.displayName
def viewName = this.args[1]

// Check if exists view
if (new_view) {
        println("Adding Job: "+jobName+" on View: "+viewName)
        new_view.add(job)
} else {
        println("Creating View: "+viewName)
        // Create the view if not exists
        def v = new ListView(viewName)

        Jenkins.instance.addView(v)
        Jenkins.instance.getItems().each {
                if (it.name.startsWith(viewName)){
                        v.add(it)
                }
        }
        println("Adding Job: "+jobName+" on View: "+viewName)
        // Include Job on view
        Hudson.instance.getView(viewName).add(job)
}
