Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978C51B87C9;
	Sun, 16 Aug 2026 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786842049; cv=none; b=BxXLAf2w+Ec48W2RbJwj2vAP4/OGQOAE5Dm4x1PpNLSwQ8TlvopOwUBrcuUWAhaGiZuiOKabTbAb7fQ0M5EuS97BMGh1jTsWPzNzF+mqXpAEfMI5WMLV3YWHsQp0TPt4O30yUlAVAo3Qf+GQBF5nf1wyQ3mFtGX42rN3oiQAR6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786842049; c=relaxed/simple;
	bh=0gLLbCETGqIDMHTROtbKJGWQZ+BGog2ZU2IoJ1/V160=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0lAZstf1BK8hBCwfn3VHKwaQM4+AOQzcaeJug+KZCp7bb2jSRjThtzzDILmBggiUhCGu7gFfE9MvPmjDQ0820IM3NPqoh277f+pQ3Q0XzazjbeJ9raThu2NSdxyxO5DpNFS764Kr6PumwtibxuDdV0nMd/q6m9lnrqeVKfOV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6VYUGYk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6VYUGYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D391F00A3A;
	Sun, 16 Aug 2026 01:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786842048;
	bh=yCcubPVYOzasxpeWtOUgFoT/f0kMOVIUWQrcf4APNck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J6VYUGYkRpSNzEahtVFMpW4zA0dAnRQmhIhNxQ5qLPtwdnEav5VV1TbcyUX4/z6Yh
	 isfrNYYRM0DE6iiNDW42OxF6DFA6ju/4LCQbdaJqWKAnAml+SUgFDxXXaqq+WYvOw3
	 Semu5bwHy2q5TYqK73MMVLf3YVovz48kVMwHnogYN9C+tONibGKV/2Ou0Hwt/sfa8s
	 cK+HqB+NAwyXGwkmdC6ldDdVvAFjjIF5xMxrE+k3y1osgOJMgmNN+cDs/ekDCEWGC4
	 gyt87Ta71klzKynqbW7l9//UEIF2dhnnlN1k0Bdcw1KBob+MAREjxBQrhNnEFs9leM
	 nw/VMP42dLFMQ==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH v3 1/4] nvmet-tcp: unify sockopt with do_sock_setsockopt
Date: Sun, 16 Aug 2026 08:59:57 +0800
Message-ID: <d06dd395575d7f639cd8bc3f984692704fd40e56.1786841319.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786841319.git.tanggeliang@kylinos.cn>
References: <cover.1786841319.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch consolidates socket option settings in nvmet-tcp by utilizing
the generic do_sock_setsockopt() helper for options including SO_LINGER,
SO_PRIORITY, SO_REUSEADDR, TCP_NODELAY, and IP_TOS. This change eliminates
the need to export and use specialized helpers for each individual socket
option.

A key benefit of this refactoring is that it decouples the socket option
configuration from the underlying transport protocol. This makes it
easier to extend nvmet-tcp to support other protocols, such as MPTCP, in
the future, as do_sock_setsockopt() abstracts away protocol-specific
differences without requiring per-option protocol-specific wrappers.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 53 +++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 75a276d73be3..e64592b79257 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1696,10 +1696,48 @@ static void nvmet_tcp_state_change(struct sock *sk)
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
+static void nvmet_tcp_sock_no_linger(struct sock *sk)
+{
+	struct linger ling = { .l_onoff = 1, .l_linger = 0 };
+
+	do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET, SO_LINGER,
+			   KERNEL_SOCKPTR(&ling), sizeof(ling));
+}
+
+static void nvmet_tcp_sock_set_priority(struct sock *sk, u32 priority)
+{
+	do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET, SO_PRIORITY,
+			   KERNEL_SOCKPTR(&priority), sizeof(priority));
+}
+
+static void nvmet_tcp_sock_set_reuseaddr(struct sock *sk)
+{
+	int val = SK_CAN_REUSE;
+
+	do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET, SO_REUSEADDR,
+			   KERNEL_SOCKPTR(&val), sizeof(val));
+}
+
+static void nvmet_tcp_sock_set_nodelay(struct sock *sk)
+{
+	int val = 1;
+
+	do_sock_setsockopt(sk->sk_socket, false, SOL_TCP, TCP_NODELAY,
+			   KERNEL_SOCKPTR(&val), sizeof(val));
+}
+
+static void nvmet_tcp_sock_set_tos(struct sock *sk)
+{
+	u8 tos = inet_sk(sk)->rcv_tos;
+
+	if (tos > 0)
+		do_sock_setsockopt(sk->sk_socket, false, SOL_IP, IP_TOS,
+				   KERNEL_SOCKPTR(&tos), sizeof(tos));
+}
+
 static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
-	struct inet_sock *inet = inet_sk(sock->sk);
 	int ret;
 
 	ret = kernel_getsockname(sock,
@@ -1717,14 +1755,13 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	sock_no_linger(sock->sk);
+	nvmet_tcp_sock_no_linger(sock->sk);
 
 	if (so_priority > 0)
-		sock_set_priority(sock->sk, so_priority);
+		nvmet_tcp_sock_set_priority(sock->sk, so_priority);
 
 	/* Set socket type of service */
-	if (inet->rcv_tos > 0)
-		ip_sock_set_tos(sock->sk, inet->rcv_tos);
+	nvmet_tcp_sock_set_tos(sock->sk);
 
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
@@ -2098,10 +2135,10 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	port->sock->sk->sk_user_data = port;
 	port->data_ready = port->sock->sk->sk_data_ready;
 	port->sock->sk->sk_data_ready = nvmet_tcp_listen_data_ready;
-	sock_set_reuseaddr(port->sock->sk);
-	tcp_sock_set_nodelay(port->sock->sk);
+	nvmet_tcp_sock_set_reuseaddr(port->sock->sk);
+	nvmet_tcp_sock_set_nodelay(port->sock->sk);
 	if (so_priority > 0)
-		sock_set_priority(port->sock->sk, so_priority);
+		nvmet_tcp_sock_set_priority(port->sock->sk, so_priority);
 
 	ret = kernel_bind(port->sock, (struct sockaddr_unsized *)&port->addr,
 			sizeof(port->addr));
-- 
2.53.0

