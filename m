Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D386441C71
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701617; cv=none; b=Vmy2k+Cv1fQFew96pZelF+d21+Pi6T/5RyRxmsLcsb40YO85m17mVgmZ/GeHqVpbbwyw77hrV5gGR6V6bCa8NvMjDSVK9yLTKnR7P9OR1X8tigHSJgZj81ylI+trRwunw1IFIKO1ZmbS64fMYQ9rUfzeQPWDfe3+8ui2dvLIxqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701617; c=relaxed/simple;
	bh=dmQUNx2Wth2lyUaaifFX4EPbFI3r6V7tKXx15E8xjJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6leICYgryoBEiNky2U823Azmis28B9nYaOoVuGIfrVLs2ySkJ5IH89ddl7atdQU7O2/UIAO+DQJBS/6REBo/SFuYpZCXJGn6ThEavaUq0fXR6GLP8XohnVFsMfuquu3uriOqNZmUNx332ebESn6MsW8DHulweewTwPXbe55Ths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mbdfm+JV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mbdfm+JV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA2E1F00A3A;
	Mon, 25 May 2026 09:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779701615;
	bh=cmy7/7JbpOQfydrZvsCSYgYe1jo6Kvdj0SVWpV7DzcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mbdfm+JV8HyoKKYROEFNllQXHC0ewPgPYE43ECyM+Jkq+jGa0Ac1w8J62lDQLQ7tt
	 0SIeNFsIjKR0UaEHAI22jdZkIODhYkxT5aTXDhBnU/hlLr6x68YnRCfCGkoLCOI+Sn
	 ROwm81pFvXFFooi5JkrI3bmb62n+0CGqSu6EGkwYeD0U0EcYlIbp+3PqHf7i/skcvR
	 t//rAZhzdm4Vr13sly2/9ZmH77PQErmg9zwtCO48aMnggE08C92NHnHQ3CvhOv3FF9
	 zlriScPWnJQOmcrxEPwW901lkW3iBJYwH8wSrF/aZsgq8MrCcW0gl1Av0V5C0grlq1
	 r4NGaCrXVP3ng==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v17 01/14] nvmet-tcp: define listen socket ops
Date: Mon, 25 May 2026 17:32:56 +0800
Message-ID: <ed372c493faf7203c1fd249a56f33ad1b92c8806.1779701391.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779701391.git.tanggeliang@kylinos.cn>
References: <cover.1779701391.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To support MPTCP on the target side, the listen socket needs to pass
IPPROTO_MPTCP to sock_create() for MPTCP ports, and use MPTCP-specific
setsockopt functions.

This patch adds struct nvmet_tcp_proto_ops to hold listen socket protocol
operations (protocol, set_reuseaddr, set_nodelay, set_priority). A TCP
version is defined and used for TCP ports.

v2:
 - use trtype instead of tsas (Hannes).

v3:
 - check mptcp protocol from disc_addr.trtype instead of passing a
parameter (Hannes).

v4:
 - check CONFIG_MPTCP.

Cc: Hannes Reinecke <hare@suse.de>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 20f150d17a96..094f8eb0107e 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2043,8 +2043,23 @@ static void nvmet_tcp_listen_data_ready(struct sock *sk)
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
+struct nvmet_tcp_proto_ops {
+	int			protocol;
+	void (*set_reuseaddr)(struct sock *sk);
+	void (*set_nodelay)(struct sock *sk);
+	void (*set_priority)(struct sock *sk, u32 priority);
+};
+
+static const struct nvmet_tcp_proto_ops nvmet_tcp_proto_ops = {
+	.protocol	= IPPROTO_TCP,
+	.set_reuseaddr	= sock_set_reuseaddr,
+	.set_nodelay	= tcp_sock_set_nodelay,
+	.set_priority	= sock_set_priority,
+};
+
 static int nvmet_tcp_add_port(struct nvmet_port *nport)
 {
+	const struct nvmet_tcp_proto_ops *ops;
 	struct nvmet_tcp_port *port;
 	__kernel_sa_family_t af;
 	int ret;
@@ -2067,6 +2082,13 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		goto err_port;
 	}
 
+	if (nport->disc_addr.trtype == NVMF_TRTYPE_TCP) {
+		ops = &nvmet_tcp_proto_ops;
+	} else {
+		ret = -EINVAL;
+		goto err_port;
+	}
+
 	ret = inet_pton_with_scope(&init_net, af, nport->disc_addr.traddr,
 			nport->disc_addr.trsvcid, &port->addr);
 	if (ret) {
@@ -2081,7 +2103,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
 	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
-				IPPROTO_TCP, &port->sock);
+				ops->protocol, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
 		goto err_port;
@@ -2090,10 +2112,10 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	port->sock->sk->sk_user_data = port;
 	port->data_ready = port->sock->sk->sk_data_ready;
 	port->sock->sk->sk_data_ready = nvmet_tcp_listen_data_ready;
-	sock_set_reuseaddr(port->sock->sk);
-	tcp_sock_set_nodelay(port->sock->sk);
+	ops->set_reuseaddr(port->sock->sk);
+	ops->set_nodelay(port->sock->sk);
 	if (so_priority > 0)
-		sock_set_priority(port->sock->sk, so_priority);
+		ops->set_priority(port->sock->sk, so_priority);
 
 	ret = kernel_bind(port->sock, (struct sockaddr_unsized *)&port->addr,
 			sizeof(port->addr));
-- 
2.53.0

