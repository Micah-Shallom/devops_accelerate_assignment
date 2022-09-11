all:
	kubectl get all

apply:
	kubectl apply -f $(filename)

clean: 
	kubectl delete all --all

build_app:
	docker build -t mshallom/app-frontend:latest ../

push_app:
	docker push mshallom/app-frontend:latest