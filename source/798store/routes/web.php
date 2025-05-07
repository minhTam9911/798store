<?php

use Illuminate\Support\Facades\Route;
use App\Livewire\Servers\Dashboard\DashboardIndex;

Route::get('/',DashboardIndex::class)->name('dashboard.index');
