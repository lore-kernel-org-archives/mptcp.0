Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E408883F
	for <mptcp@lists.linux.dev>; Mon,  6 Apr 2026 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775478000; cv=none; b=k4EXrGykUWxi3bHC1msHB9pUFfeo2rxZNkUCAnMnHFg0Qor8DkuOhs3NPcmKLsvHQi73Ax9uII979s5DxgTM7JIjEqpvn0Q/mbNx4odUG7QOddasUyATsioxSd4apaN500o8s/OUDK7rQZkddjamfwr80sT4eJvYPNKqSsBya4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775478000; c=relaxed/simple;
	bh=JCT1VgVcT6ACNnlVRa4l7Tn+8UPTB2hzof2tqggz/ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nk6bgh850zIvdJ07Yr40RqtHBsAap5SxOp6TEfkNoT0IwzNLAoRJOnCqGX/eD8dJ6tDaHwGY04236lz23Q18SF2DVEJ80JYsUVPA4cvXIGZ1hdd6T7GFf2c43YwfNzh0o50ErTjEPwgMjjrgIyS8ShO/sr/AEVosil7BtgdqCKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wl06Re1T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wl06Re1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D9FC19425;
	Mon,  6 Apr 2026 12:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775478000;
	bh=JCT1VgVcT6ACNnlVRa4l7Tn+8UPTB2hzof2tqggz/ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wl06Re1T58G2DCxGC7XGSQVLDD8vKzcOuYx3y9LHhtfrgEt1aLLNlfhAJ97UWdXva
	 5Ch94/G54e4Y7K+WzICR5+KOqGWuIYDeGmnR8UowDvDTW48h4OHI0KSDJBnplRoscs
	 UGSfN7xBQBWFucTF6i9LZxP7wFvk0YQJrmX0m0980Ywu/26NAT3aFRPngZFf4o9aKM
	 qfdYoEuhGbIqkshz2IjDDT2yI8qto3uva+ANqBCi/m9dmOvk7JQY1EzDLObFWjpbtG
	 6Bdrz3jf8PqJaY+41Bxux5TiVHSZyv0WSHAqhSHzJLDtu0dtBPdJ1Ugn1mmDFOURoR
	 t0UVHNWwf/Mww==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v14 02/15] tls: introduce struct tls_prot_ops
Date: Mon,  6 Apr 2026 20:18:42 +0800
Message-ID: <c4fd8a9ce7c51e27c9f8b1aae46ac7de6e1f491b.1775476921.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775476921.git.tanggeliang@kylinos.cn>
References: <cover.1775476921.git.tanggeliang@kylinos.cn>
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
 include/net/tls.h  | 19 +++++++++
 net/tls/tls_main.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/include/net/tls.h b/include/net/tls.h
index f65604270932..3c73e61ce4a3 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -220,6 +220,25 @@ struct tls_prot_info {
 	u16 tail_size;
 };
 
+struct tls_prot_ops {
+	int			protocol;
+	struct module		*owner;
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
 	struct list_head		list;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 8cd12614a12b..9a555793fd76 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -115,9 +115,27 @@ CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_256, tls12_crypto_info_aria_gcm_256);
 
 static LIST_HEAD(tls_proto_list);
 static DEFINE_MUTEX(tls_proto_mutex);
+static LIST_HEAD(tls_prot_ops_list);
+static DEFINE_SPINLOCK(tls_prot_ops_lock);
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 			 const struct proto *base);
 
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
 	struct tls_proto *proto = ctx->proto;
@@ -1258,6 +1276,82 @@ static struct tcp_ulp_ops tcp_tls_ulp_ops __read_mostly = {
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
+	if (tls_prot_ops_find(ops->protocol)) {
+		spin_unlock(&tls_prot_ops_lock);
+		return -EEXIST;
+	}
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
@@ -1276,6 +1370,8 @@ static int __init tls_register(void)
 
 	tcp_register_ulp(&tcp_tls_ulp_ops);
 
+	tls_register_prot_ops(&tls_tcp_ops);
+
 	return 0;
 err_strp:
 	tls_strp_dev_exit();
@@ -1287,6 +1383,7 @@ static int __init tls_register(void)
 static void __exit tls_unregister(void)
 {
 	tls_proto_cleanup();
+	tls_unregister_prot_ops(&tls_tcp_ops);
 	tcp_unregister_ulp(&tcp_tls_ulp_ops);
 	tls_strp_dev_exit();
 	tls_device_cleanup();
-- 
2.51.0

