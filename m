Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6C336881
	for <mptcp@lists.linux.dev>; Thu,  5 Mar 2026 04:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772683555; cv=none; b=mt+Kx1p/HkoziDzQoVT+G//12TFFR0pUCXu6D5GJ0Trj+MzTHxisNGs2YgEozeQwWhDnrWxNRKTIQuoLj3DTergA/u/P8/fqPRP8uDPD3efD3lE6dCQkvVYugOSFXVPX46QTourfi8ENQXQhpLpAMTquxEjInjiBRy/NZnEvYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772683555; c=relaxed/simple;
	bh=JiC4drRexB923fNGx/D1LWDjs3IVzUljzNF1ghhTK5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NzgxKF48NH2mwgsdc0KsmUmFb5pmggGuUQM08YP9OM83XM4F1xzD5O1xlNqKqNgf4yP+56gQ387l/LwJf6jpUuo1DEpZ4iI6wamtm0EEI1GiC09GG3Pvj80Z8add6GbycowgxB0Rg6qDTI7ppngFiCbHIXy1K8vdp6dJEp5XLso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1bmXMG2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1bmXMG2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77ABFC116C6;
	Thu,  5 Mar 2026 04:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772683555;
	bh=JiC4drRexB923fNGx/D1LWDjs3IVzUljzNF1ghhTK5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1bmXMG2ARx+jzy3EnNQAFoWeCggcFZBzlhH5S9NXJix8Lrj3tlXkN2NzCAWdVeiX
	 wO10jDEIhJgtWkINQncWdrqItm7//OYYIS6WOjyiEwnR/wu38DvpFqCyXaEg2y1B0m
	 fFkLuVwwcf7ImJ0S/LevXQaZa65jJt1Rg0hMMm9pbD8YnXVgK3vXjWH2o14JiorIMj
	 1WG+6PIJj2JLlGdiFzhDMM3wUm96AjzpuNNvDJ2fc1czEKlZZN8o+0O4cCG1k08JMs
	 pwYnymqetdUXGu7vqs6lE44k6y9AG81wJUoDhG41hCFWEP/aVhzPh/WhoCPgefAz8j
	 PHpTqNIX3sWtg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	hare@suse.de
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v4 4/8] mptcp: add sock_set_nodelay
Date: Thu,  5 Mar 2026 12:05:22 +0800
Message-ID: <5f99af6432d129772550d3545d4d67f472262587.1772683110.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772683110.git.tanggeliang@kylinos.cn>
References: <cover.1772683110.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch introduces an MPTCP-specific helper, mptcp_sock_set_nodelay,
which sets the TCP_NODELAY option for every subflow socket within an
MPTCP connection. It is utilized on both the target and host sides in
the 'NVMe over MPTCP' implementation.

Using tcp_sock_set_nodelay() with MPTCP will cause list corruption:

  nvmet: adding nsid 1 to subsystem nqn.2014-08.org.nvmexpress.mptcpdev
  nvmet_tcp: enabling port 1234 (127.0.0.1:4420)
   slab MPTCP start ffff8880108f0b80 pointer offset 2480 size 2816
  list_add corruption. prev->next should be next (ffff8880108f1530), but
  was ffff8885108f1530. (prev=ffff8880108f1530).
  ------------[ cut here ]------------
  kernel BUG at lib/list_debug.c:32!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  CPU: 1 UID: 0 PID: 182 Comm: nvme Not tainted 6.16.0-rc3+ #1 PREEMPT(full)
  Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011

Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c   |  2 ++
 drivers/nvme/target/tcp.c |  2 ++
 include/net/mptcp.h       |  4 ++++
 net/mptcp/protocol.c      | 17 +++++++++++++++++
 4 files changed, 25 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8446630cceca..dc5b3ecdd885 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1810,6 +1810,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	tcp_sock_set_syncnt(queue->sock->sk, 1);
 
 	/* Set TCP no delay */
+	sk_is_msk(queue->sock->sk) ?
+	mptcp_sock_set_nodelay(queue->sock->sk) :
 	tcp_sock_set_nodelay(queue->sock->sk);
 
 	/*
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5a58b544f258..8452d38614a6 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2087,6 +2087,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	port->data_ready = port->sock->sk->sk_data_ready;
 	port->sock->sk->sk_data_ready = nvmet_tcp_listen_data_ready;
 	sock_set_reuseaddr(port->sock->sk);
+	sk_is_msk(port->sock->sk) ?
+	mptcp_sock_set_nodelay(port->sock->sk) :
 	tcp_sock_set_nodelay(port->sock->sk);
 	if (so_priority > 0)
 		sock_set_priority(port->sock->sk, so_priority);
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 82660374859a..60cbf29448b0 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -244,6 +244,8 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 }
 
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
+
+void mptcp_sock_set_nodelay(struct sock *sk);
 #else
 
 static inline void mptcp_init(void)
@@ -335,6 +337,8 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
+
+static inline void mptcp_sock_set_nodelay(struct sock *sk) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c8fcc46ed042..451bc4df4fa4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3806,6 +3806,23 @@ static void mptcp_sock_check_graft(struct sock *sk, struct sock *ssk)
 	}
 }
 
+void mptcp_sock_set_nodelay(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		lock_sock(ssk);
+		__tcp_sock_set_nodelay(ssk, true);
+		release_sock(ssk);
+	}
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_nodelay);
+
 bool mptcp_finish_join(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-- 
2.53.0

