package com.ecommerce.repository.impl;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.lang.reflect.ParameterizedType;
import java.util.List;
import java.util.Optional;

import com.ecommerce.repository.BaseRepository;

public abstract class BaseRepositoryImpl<T, ID> implements BaseRepository<T, ID> {

    @Autowired
    protected SessionFactory sessionFactory;

    private final Class<T> entityClass;

    @SuppressWarnings("unchecked")
    protected BaseRepositoryImpl() {
        this.entityClass = (Class<T>)
            ((ParameterizedType) getClass().getGenericSuperclass())
            .getActualTypeArguments()[0];
    }

    @Override
    public T save(T entity) {
        sessionFactory.getCurrentSession().save(entity);
        return entity;
    }

    @Override
    public T update(T entity) {
        sessionFactory.getCurrentSession().update(entity);
        return entity;
    }

    @Override
    public void delete(T entity) {
        sessionFactory.getCurrentSession().delete(entity);
    }

    @Override
    public void deleteById(ID id) {
        T entity = sessionFactory.getCurrentSession().get(entityClass, (java.io.Serializable) id);
        if (entity != null) {
            sessionFactory.getCurrentSession().delete(entity);
        }
    }

    @Override
    public Optional<T> findById(ID id) {
        T entity = sessionFactory.getCurrentSession().get(entityClass, (java.io.Serializable) id);
        return Optional.ofNullable(entity);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<T> findAll() {
        return sessionFactory.getCurrentSession()
            .createQuery("FROM " + entityClass.getName(), entityClass)
            .getResultList();
    }

    @Override
    public long count() {
        return (Long) sessionFactory.getCurrentSession()
            .createQuery("SELECT COUNT(e) FROM " + entityClass.getName() + " e")
            .getSingleResult();
    }
}
