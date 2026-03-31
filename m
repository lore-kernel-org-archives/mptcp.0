Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579563EDADB
	for <mptcp@lists.linux.dev>; Tue, 31 Mar 2026 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952920; cv=none; b=DMqYlhfbYtT/YZTNUUxKpNF8xAxL6Zku0pQ2X3jbnJDeby2UoOlzAZUtmBJBIyAoGxJDRtmq1sEM3EntnOX20uJ9WGYFD0f17WaRhtVWjiI1D04nOdmmSDKwusgxTWxXsKhuO4FOi6PrEotMIlUYqKna2dFS6VfQoQGsy5tClTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952920; c=relaxed/simple;
	bh=0/tZA/5bGFdGSJopCPeV59LWuPC37pi1VzZul6wBc0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmmkXWEn8b6+Md2sgmvlbtER8zAi2BCKYLFMT05H+UcioTzX/WMVAB7e3ztWegoX6hyZIMYmsifSq+2hiTY4z9YBXFr7my09s9Rtht/ko5KkIj4opF+iV2LXdSWZiV0M0gOu7ucwxWRt98XzE9Nu5iMSb9gfw2uaKtaPRxbJydQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nB1+D74f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nB1+D74f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9ACC2BCB0;
	Tue, 31 Mar 2026 10:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774952919;
	bh=0/tZA/5bGFdGSJopCPeV59LWuPC37pi1VzZul6wBc0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nB1+D74fXs6Cs69Qg1Swp5FLFBOvjBtCctqQeSRo1hTW0VTKzvMk6sSPUZ7hernPw
	 0r00p2h3aljLGtFFhJe4NSlnJWutxI6hbdzdTQVTYXS6X0KVWfODy4e+hMYPlizDtA
	 JAwv6LnwprxWoLykp6HjmvjxSiX+6VB9wAmnWhOI3CY7raBHkMOHqGeuIoAe7HqMW0
	 lLuaSsDr8ghDzuiH9MNchnFHLSNNl+JsLCcc+ldeKqoqgtIxGSuAL4oBjtF3oJWPTG
	 7BRnbO6wBJ7pXb31UG3tE2KJrZvqmRoi903y6yOKITqgMt60GU7BZBdkPGsv1SWnIA
	 eCBpIZbzlOrrg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v7 1/7] nvmet-tcp: define target tcp_sockops struct
Date: Tue, 31 Mar 2026 18:28:25 +0800
Message-ID: <c2c9fb08609db27f6983336857fe81cdd1d0fc79.1774952107.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1774952107.git.tanggeliang@kylinos.cn>
References: <cover.1774952107.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To add MPTCP support in "NVMe over TCP", the target side needs to pass
IPPROTO_MPTCP to sock_create() instead of IPPROTO_TCP to create an MPTCP
socket. Additionally, the setsockopt operations for this socket need to
be switched to a set of MPTCP-specific functions.

This patch defines the nvmet_tcp_sockops structure, which contains the
protocol of the socket and a set of function pointers for these socket
operations. A "sockops" field is also added to struct nvmet_tcp_port.

A TCP-specific version of struct nvmet_tcp_sockops is defined. In
nvmet_tcp_add_port(), port->sockops is set to nvmet_tcp_sockops based on
whether trtype is TCP. All locations that previously called TCP setsockopt
functions are updated to call the corresponding function pointers in the
nvmet_tcp_sockops structure.

Cc: Hannes Reinecke <hare@suse.de>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 43 ++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index acc71a26733f..dc1207d96b30 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -198,12 +198,22 @@ struct nvmet_tcp_queue {
 	void (*write_space)(struct sock *);
 };
 
+struct nvmet_tcp_sockops {
+	int			proto;
+	void (*set_reuseaddr)(struct sock *sk);
+	void (*set_nodelay)(struct sock *sk);
+	void (*set_priority)(struct sock *sk, u32 priority);
+	void (*no_linger)(struct sock *sk);
+	void (*set_tos)(struct sock *sk, int val);
+};
+
 struct nvmet_tcp_port {
 	struct socket		*sock;
 	struct work_struct	accept_work;
 	struct nvmet_port	*nport;
 	struct sockaddr_storage addr;
 	void (*data_ready)(struct sock *);
+	const struct nvmet_tcp_sockops *sockops;
 };
 
 static DEFINE_IDA(nvmet_tcp_queue_ida);
@@ -1698,19 +1708,22 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	if (ret < 0)
 		return ret;
 
+	if (!queue->port || !queue->port->sockops)
+		return -EINVAL;
+
 	/*
 	 * Cleanup whatever is sitting in the TCP transmit queue on socket
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	sock_no_linger(sock->sk);
+	queue->port->sockops->no_linger(sock->sk);
 
 	if (so_priority > 0)
-		sock_set_priority(sock->sk, so_priority);
+		queue->port->sockops->set_priority(sock->sk, so_priority);
 
 	/* Set socket type of service */
 	if (inet->rcv_tos > 0)
-		ip_sock_set_tos(sock->sk, inet->rcv_tos);
+		queue->port->sockops->set_tos(sock->sk, inet->rcv_tos);
 
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
@@ -2030,6 +2043,15 @@ static void nvmet_tcp_listen_data_ready(struct sock *sk)
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
+static const struct nvmet_tcp_sockops nvmet_tcp_sockops = {
+	.proto		= IPPROTO_TCP,
+	.set_reuseaddr	= sock_set_reuseaddr,
+	.set_nodelay	= tcp_sock_set_nodelay,
+	.set_priority	= sock_set_priority,
+	.no_linger	= sock_no_linger,
+	.set_tos	= ip_sock_set_tos,
+};
+
 static int nvmet_tcp_add_port(struct nvmet_port *nport)
 {
 	struct nvmet_tcp_port *port;
@@ -2054,6 +2076,13 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		goto err_port;
 	}
 
+	if (nport->disc_addr.trtype == NVMF_TRTYPE_TCP) {
+		port->sockops = &nvmet_tcp_sockops;
+	} else {
+		ret = -EINVAL;
+		goto err_port;
+	}
+
 	ret = inet_pton_with_scope(&init_net, af, nport->disc_addr.traddr,
 			nport->disc_addr.trsvcid, &port->addr);
 	if (ret) {
@@ -2068,7 +2097,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
 	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
-				IPPROTO_TCP, &port->sock);
+				port->sockops->proto, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
 		goto err_port;
@@ -2077,10 +2106,10 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	port->sock->sk->sk_user_data = port;
 	port->data_ready = port->sock->sk->sk_data_ready;
 	port->sock->sk->sk_data_ready = nvmet_tcp_listen_data_ready;
-	sock_set_reuseaddr(port->sock->sk);
-	tcp_sock_set_nodelay(port->sock->sk);
+	port->sockops->set_reuseaddr(port->sock->sk);
+	port->sockops->set_nodelay(port->sock->sk);
 	if (so_priority > 0)
-		sock_set_priority(port->sock->sk, so_priority);
+		port->sockops->set_priority(port->sock->sk, so_priority);
 
 	ret = kernel_bind(port->sock, (struct sockaddr_unsized *)&port->addr,
 			sizeof(port->addr));
-- 
2.51.0

