Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC8B3016E7
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053266; cv=none; b=mSuYvmWQJ5GYizHpiD7LQspgmkQPnKke2JrUGHASDlz7BHzBjKQr+3rieDnrcZ39UenlqspbTXlM6PomTgNH+nMhyFPLEwYMQYvyH1+7dcZf6kPRhSgxjNMtQk42yb+nV1CUHg/9tmSXjOLKJIXgD5PKFrBCIZ2Kd3dr/zaqYlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053266; c=relaxed/simple;
	bh=zDO9HJc1I5EIUxxU6atIh0/SOz/dpoCLhx9u+JMw7As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4NzXDHD7BFhks69wfA1i9ALEPXzVvyPgiuO7AkLr3LAC9greU2Rmcvnw3Bzr66pvFAnYJtirb383+sIyrTjxee8CWf7vc46DtexRbwykQKmB4PGO8P9JmbM675RW6tJ+aVWAiH2pM00HCuqhvErsEKnCHg6WM4JGtJEBP7ng9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEQgM6rr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEQgM6rr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C861F00893;
	Fri, 29 May 2026 11:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780053265;
	bh=yT/ss49zrB8lQ3GJfif3Im6isQWPnmiw2M6vttbIYXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PEQgM6rrP7bkJQYvwfb/f/LmCgKlzbxeCKL2a0kDXLGuhctEbkiu5OZvCpcAjly/C
	 iLORMUfv5IgIe5ZrmB6go6kpn6MtfeHws+e1kgx3DAz/NgVjX6yAvm+mwx9Ao2Z5Hm
	 03TOuq40YTdWIuPDc1vf9RzNWsvJ8RBZTBQgLJ86KS66unHSh8pZKulyyPBZqhZX/y
	 3jG8W9YxTNPBSkdyYcwJ2IubfIpo6VYzKLmAOegD3IMVD7A5Ma0zxcYOE+fDKbvsEj
	 DEZqYcy1ZzciSPRL71BTBgUNDBEO3+bRIZ5xhj8bEwbzugP1ctpbG579EtfJsGxKRz
	 ej3nBd6vKdqrA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v22 06/20] tls: introduce tls protocol ops structure
Date: Fri, 29 May 2026 19:13:48 +0800
Message-ID: <da05b025a22b0289716502a83edb9a59bb902b2d.1780052851.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780052851.git.tanggeliang@kylinos.cn>
References: <cover.1780052851.git.tanggeliang@kylinos.cn>
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

Register TCP-specific structure tls_tcp_ops in tls_register().

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls.h  |  22 ++++++++++
 net/tls/tls_main.c | 106 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 7ff4d4566d41..e13894c054ad 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -220,6 +220,28 @@ struct tls_prot_info {
 	u16 tail_size;
 };
 
+struct tls_prot_ops {
+	struct module		*owner;
+	int			protocol;
+	struct list_head	list;
+
+	int (*inq)(struct sock *sk);
+	int (*sendmsg_locked)(struct sock *sk, struct msghdr *msg,
+			      size_t size);
+	struct sk_buff *(*recv_skb)(struct sock *sk, u32 *off);
+	bool (*lock_is_held)(struct sock *sk);
+	int (*read_sock)(struct sock *sk, read_descriptor_t *desc,
+			 sk_read_actor_t recv_actor);
+	void (*read_done)(struct sock *sk, size_t len);
+	u32 (*get_skb_seq)(struct sk_buff *skb);
+	int (*skb_copy_bits)(const struct sk_buff *skb, int offset,
+			     void *to, int len);
+	__poll_t (*poll)(struct file *file, struct socket *sock,
+			 struct poll_table_struct *wait);
+	bool (*epollin_ready)(const struct sock *sk);
+	void (*check_app_limited)(struct sock *sk);
+};
+
 struct tls_prot {
 	struct rcu_head			rcu;
 	refcount_t			refcnt;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index cdf0fb05fc99..2d9e10507f4b 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -120,6 +120,7 @@ CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_128, tls12_crypto_info_aria_gcm_128);
 CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_256, tls12_crypto_info_aria_gcm_256);
 
 static LIST_HEAD(tls_prot_list);
+static LIST_HEAD(tls_prot_ops_list);
 static DEFINE_SPINLOCK(tls_prot_lock);
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 			 const struct proto *base);
@@ -161,6 +162,22 @@ static void tls_prot_cleanup(void)
 	rcu_barrier();
 }
 
+static struct tls_prot_ops *tls_prot_ops_find(int protocol)
+{
+	struct tls_prot_ops *ops, *ret = NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ops, &tls_prot_ops_list, list) {
+		if (ops->protocol == protocol) {
+			ret = ops;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
 void update_sk_prot(struct sock *sk, struct tls_context *ctx)
 {
 	struct tls_prot *prot = ctx->prot;
@@ -1326,6 +1343,86 @@ static struct tcp_ulp_ops tcp_tls_ulp_ops __read_mostly = {
 	.get_info_size		= tls_get_info_size,
 };
 
+static int tls_validate_prot_ops(const struct tls_prot_ops *ops)
+{
+	if (!ops->inq || !ops->sendmsg_locked ||
+	    !ops->recv_skb || !ops->lock_is_held ||
+	    !ops->read_sock || !ops->read_done ||
+	    !ops->get_skb_seq || !ops->skb_copy_bits ||
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
+	spin_lock_bh(&tls_prot_lock);
+	if (tls_prot_ops_find(ops->protocol)) {
+		spin_unlock_bh(&tls_prot_lock);
+		return -EEXIST;
+	}
+
+	list_add_tail_rcu(&ops->list, &tls_prot_ops_list);
+	spin_unlock_bh(&tls_prot_lock);
+
+	pr_debug("tls_prot_ops %d registered\n", ops->protocol);
+	return 0;
+}
+
+static void tls_unregister_prot_ops(struct tls_prot_ops *ops)
+{
+	spin_lock_bh(&tls_prot_lock);
+	list_del_rcu(&ops->list);
+	spin_unlock_bh(&tls_prot_lock);
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
+	.owner			= THIS_MODULE,
+	.protocol		= IPPROTO_TCP,
+	.inq			= tcp_inq,
+	.sendmsg_locked		= tcp_sendmsg_locked,
+	.recv_skb		= tls_tcp_recv_skb,
+	.lock_is_held		= tls_tcp_lock_is_held,
+	.read_sock		= tcp_read_sock,
+	.read_done		= tcp_read_done,
+	.get_skb_seq		= tls_tcp_get_skb_seq,
+	.skb_copy_bits		= skb_copy_bits,
+	.poll			= tcp_poll,
+	.epollin_ready		= tls_tcp_epollin_ready,
+	.check_app_limited	= tcp_rate_check_app_limited,
+};
+
 static int __init tls_register(void)
 {
 	int err;
@@ -1338,13 +1435,19 @@ static int __init tls_register(void)
 	if (err)
 		goto err_pernet;
 
-	err = tls_device_init();
+	err = tls_register_prot_ops(&tls_tcp_ops);
 	if (err)
 		goto err_strp;
 
+	err = tls_device_init();
+	if (err)
+		goto err_ops;
+
 	tcp_register_ulp(&tcp_tls_ulp_ops);
 
 	return 0;
+err_ops:
+	tls_unregister_prot_ops(&tls_tcp_ops);
 err_strp:
 	tls_strp_dev_exit();
 err_pernet:
@@ -1355,6 +1458,7 @@ static int __init tls_register(void)
 static void __exit tls_unregister(void)
 {
 	tcp_unregister_ulp(&tcp_tls_ulp_ops);
+	tls_unregister_prot_ops(&tls_tcp_ops);
 	tls_prot_cleanup();
 	tls_strp_dev_exit();
 	tls_device_cleanup();
-- 
2.53.0

