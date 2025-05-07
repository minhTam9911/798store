<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Str;
use App\Models\Product;
use App\Models\Category;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Product::creating(function ($model) {
            $model->slug = Str::slug($model->name);
        });

        Category::creating(function ($model) {
            $model->slug = Str::slug($model->name);
        });
    }
}
