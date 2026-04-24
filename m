Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880B2385515
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027138; cv=none; b=h4+s2GeRtZ6KKgDYuAIiXKUxu9+Fks5zFtCo3Tcna1aJhL4xVUHYJ35UO4lGtZTfWDfLyimMF3xkerih5fk0HWUApQ8mL85NmwWg3h07hwyH/8DKFM/k/PtBHQY9fqnd4rmhvugqzzOL772Kt+smA73o1K28/PH8fIn+wLCkZZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027138; c=relaxed/simple;
	bh=/2HIhxmtRy8PAEhht7mdhvnLJb5p9zEBOB7SGJHqYno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdJwJpx7fgZx1sDoyP1eTxo1VEYZFNoP5JoOZJgA0N8/CRGDfaeU6jWkjdnQk5i3bojVghRN2Cg0k6sXf/AJIxoSD1hcYbYL8heYSW9LCrQptHaZ3ceknRs06jxOrbcS8hR+ySdltFyR9BkshLyEP/vWWKrpxY/rkp/DsEidGKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvzZantj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvzZantj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB11C2BCB4;
	Fri, 24 Apr 2026 10:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027138;
	bh=/2HIhxmtRy8PAEhht7mdhvnLJb5p9zEBOB7SGJHqYno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MvzZantjJpNfZfxqJNETnOUf5Baq8S9xTo2pEeDMgQluR3qJccgsgirIxFwQoTVHs
	 8hJe9WFNEKdmQkziYTrT46hf9rQjC9koA5bBSQ1//cVDuziNMBAmnC19Qo83PxRIHx
	 WEcmX808Wt4WUUPLNIrvQ/Q6IaA+PlPQO3+p4+aHalpNY9DgRyuzOb/A4OdLg8SELG
	 D0WU/yOyYCKT4Z2vWh+fyJAB33vLwU59OXjEf07M/AebI9AREiqbfp5L+siMVlLb8M
	 aJxtxqd+EHE3+qEc43qgkWXrEb8bt9uQO9SZxZm0pp5CfbFGl9Uv/1/wwSC7e3TsS1
	 fi1AQ2CMwxg8g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v17 02/15] tls: introduce struct tls_prot_ops
Date: Fri, 24 Apr 2026 18:38:26 +0800
Message-ID: <570e2ca5ad43a3d53eb3c17c8aa8b94e2c6551e1.1777026753.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777026753.git.tanggeliang@kylinos.cn>
References: <cover.1777026753.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To extend MPTCP support based on TCP TLS, a tls_prot_ops structure has
been introduced for TLS, encapsulating TCP-specific helpers within this
structure.

Add registering, validating and finding functions for this structure to
add, validate and find a tls_prot_ops on the global list tls_prot_ops_list.

Register TCP-specific structure tls_tcp_ops in tls_init().

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls.h  |  18 ++++++++
 net/tls/tls_main.c | 102 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/include/net/tls.h b/include/net/tls.h
index 094e4be3361a..032a618d4a87 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -226,6 +226,24 @@ struct tls_prot_info {
 	u16 tail_size;
 };
 
+struct tls_prot_ops {
+	int			protocol;
+	struct list_head	list;
+
+	int (*inq)(struct sock *sk);
+	int (*sendmsg_locked)(struct sock *sk, struct msghdr *msg, size_t size);
+	struct sk_buff *(*recv_skb)(struct sock *sk, u32 *off);
+	bool (*lock_is_held)(struct sock *sk);
+	int (*read_sock)(struct sock *sk, read_descriptor_t *desc,
+			 sk_read_actor_t recv_actor);
+	void (*read_done)(struct sock *sk, size_t len);
+	u32 (*get_skb_seq)(struct sk_buff *skb);
+	__poll_t (*poll)(struct file *file, struct socket *sock,
+			 struct poll_table_struct *wait);
+	bool (*epollin_ready)(const struct sock *sk);
+	void (*check_app_limited)(struct sock *sk);
+};
+
 struct tls_proto {
 	struct rcu_head			rcu;
 	refcount_t			refcnt;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 9b6cf9cad573..76faed44fcad 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -115,6 +115,8 @@ CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_256, tls12_crypto_info_aria_gcm_256);
 
 static LIST_HEAD(tls_proto_list);
 static DEFINE_MUTEX(tls_proto_mutex);
+static LIST_HEAD(tls_prot_ops_list);
+static DEFINE_SPINLOCK(tls_prot_ops_lock);
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 			 const struct proto *base);
 
@@ -147,6 +149,18 @@ static void tls_proto_cleanup(void)
 	mutex_unlock(&tls_proto_mutex);
 }
 
+static struct tls_prot_ops *tls_prot_ops_find(int protocol)
+{
+	struct tls_prot_ops *ops;
+
+	list_for_each_entry_rcu(ops, &tls_prot_ops_list, list) {
+		if (ops->protocol == protocol)
+			return ops;
+	}
+
+	return NULL;
+}
+
 void update_sk_prot(struct sock *sk, struct tls_context *ctx)
 {
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
@@ -1282,6 +1296,87 @@ static struct tcp_ulp_ops tcp_tls_ulp_ops __read_mostly = {
 	.get_info_size		= tls_get_info_size,
 };
 
+static int tls_validate_prot_ops(const struct tls_prot_ops *ops)
+{
+	if (!ops->inq || !ops->sendmsg_locked ||
+	    !ops->recv_skb || !ops->lock_is_held ||
+	    !ops->read_sock || !ops->read_done ||
+	    !ops->get_skb_seq ||
+	    !ops->poll || !ops->epollin_ready ||
+	    !ops->check_app_limited) {
+		pr_err("%d does not implement required ops\n", ops->protocol);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tls_register_prot_ops(struct tls_prot_ops *ops)
+{
+	int ret;
+
+	ret = tls_validate_prot_ops(ops);
+	if (ret)
+		return ret;
+
+	spin_lock(&tls_prot_ops_lock);
+	rcu_read_lock();
+	if (tls_prot_ops_find(ops->protocol)) {
+		rcu_read_unlock();
+		spin_unlock(&tls_prot_ops_lock);
+		return -EEXIST;
+	}
+	rcu_read_unlock();
+	list_add_tail_rcu(&ops->list, &tls_prot_ops_list);
+	spin_unlock(&tls_prot_ops_lock);
+
+	pr_debug("tls_prot_ops %d registered\n", ops->protocol);
+	return 0;
+}
+
+static void tls_unregister_prot_ops(struct tls_prot_ops *ops)
+{
+	spin_lock(&tls_prot_ops_lock);
+	list_del_rcu(&ops->list);
+	spin_unlock(&tls_prot_ops_lock);
+
+	synchronize_rcu();
+}
+
+static struct sk_buff *tls_tcp_recv_skb(struct sock *sk, u32 *off)
+{
+	return tcp_recv_skb(sk, tcp_sk(sk)->copied_seq, off);
+}
+
+static bool tls_tcp_lock_is_held(struct sock *sk)
+{
+	return sock_owned_by_user_nocheck(sk);
+}
+
+static u32 tls_tcp_get_skb_seq(struct sk_buff *skb)
+{
+	return TCP_SKB_CB(skb)->seq;
+}
+
+static bool tls_tcp_epollin_ready(const struct sock *sk)
+{
+	return tcp_epollin_ready(sk, INT_MAX);
+}
+
+static struct tls_prot_ops tls_tcp_ops = {
+	.protocol		= IPPROTO_TCP,
+	.inq			= tcp_inq,
+	.sendmsg_locked		= tcp_sendmsg_locked,
+	.recv_skb		= tls_tcp_recv_skb,
+	.lock_is_held		= tls_tcp_lock_is_held,
+	.read_sock		= tcp_read_sock,
+	.read_done		= tcp_read_done,
+	.get_skb_seq		= tls_tcp_get_skb_seq,
+	.poll			= tcp_poll,
+	.epollin_ready		= tls_tcp_epollin_ready,
+	.check_app_limited	= tcp_rate_check_app_limited,
+};
+
 static int __init tls_register(void)
 {
 	int err;
@@ -1298,9 +1393,15 @@ static int __init tls_register(void)
 	if (err)
 		goto err_strp;
 
+	err = tls_register_prot_ops(&tls_tcp_ops);
+	if (err)
+		goto err_dev;
+
 	tcp_register_ulp(&tcp_tls_ulp_ops);
 
 	return 0;
+err_dev:
+	tls_device_cleanup();
 err_strp:
 	tls_strp_dev_exit();
 err_pernet:
@@ -1311,6 +1412,7 @@ static int __init tls_register(void)
 static void __exit tls_unregister(void)
 {
 	tls_proto_cleanup();
+	tls_unregister_prot_ops(&tls_tcp_ops);
 	tcp_unregister_ulp(&tcp_tls_ulp_ops);
 	tls_strp_dev_exit();
 	tls_device_cleanup();
-- 
2.53.0

