<?php

namespace App\Livewire\Servers\Dashboard;

use Livewire\Component;
use Livewire\Attributes\Layout;
use Illuminate\Support\Str;

#[Layout('layouts.servers.app')]
class DashboardIndex extends Component
{

    public $title = '';

    public function mount()
    {
        $this->title = Str::slug('Dashboard');
    }


    public function render()
    {
        return view('livewire.servers.dashboard.index')->title($this->title);
    }
}
