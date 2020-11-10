﻿using ChallengeAPIPevaar.Extensions;
using ChallengeAPIPevaar.Models;
using ChallengeDataObjects.Context;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ChallengeAPIPevaar.Services
{
    public class ProductService : IProductService
    {
        private readonly MasterContext _masterContext;
        private readonly ILogger<IProductService> _logger;

        public ProductService(MasterContext masterContext,
                              ILogger<IProductService> logger)
        {
            _masterContext = masterContext;
            _logger = logger;
        }

        public IEnumerable<ProductDetailModel> Get(Guid? id)
        {
            if (id.HasValue)
                return _masterContext
                        .Products.Include(x => x.TypeNavigation)
                        .AsNoTracking()
                        .Where(x => x.Id == id.Value)
                        .Select(x => x.GetDetails());

            return _masterContext.Products.Include(x => x.TypeNavigation).AsNoTracking()
                                 .Select(x => x.GetDetails());
        }

        public bool Insert(ProductEntryModel model)
        {
            return true;
        }

        public IEnumerable<ProductDetailModel> Search(string q)
        {
            var result = _masterContext.Products.Include(x => x.TypeNavigation).AsNoTracking()
                                       .Where(x => x.Description.ToLower().Contains(q.ToLower()));

            return result.Select(x => x.GetDetails());
        }

        public bool Update(Guid id, ProductEntryModel product)
        {
            var original = _masterContext.Products.Include(x => x.TypeNavigation).FirstOrDefault(prd => prd.Id == id);
            if (original == null) return false;

            original.Description = product.Description;
            original.IsActive = product.IsActive;
            original.Type = (int)product.Type;
            original.Value = product.Value;

            return _masterContext.SaveChanges() != 0;
        }
    }
}