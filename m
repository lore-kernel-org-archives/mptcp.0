Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D63D36402A;
	Mon, 22 Jun 2026 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125104; cv=none; b=GwlDUqnBV3TfkeyPBnd0CiVje4LtW7EMwuiLSxmvAQVTsPTVFY3AkAxIIFhdJ+UKdAfCTgZqDRB8xcYUr9asKr4MHEpxGcHGj9yCg49WA3Xt6EsyE18tdu+E5Pa3jSCg9FtFLCdIi/IiQbN4SNlqjAceshUK5VFj6Gdx+GcYXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125104; c=relaxed/simple;
	bh=XFMs3iW8wVB7PHYBQMT4cKn8M02CMRfibowf/8LKbx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXixAnc79HoTzN+jQDcD3BcX3n+bvrj/43shLrzO8fQ9iMwKkkQPCE2w++3Hx0B4h7lHV4lpU4njs7Pn4sbfd+AravjEhdEArTldg7H4toCqROSchgpXHKO8aevwRRw2RBmbTPtiXrTAga3old6ejgwChS2ctTbGZ945VGA+YUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQFu9Ppz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQFu9Ppz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44241F000E9;
	Mon, 22 Jun 2026 10:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125103;
	bh=Blrcz2kDLGnJzXXbDekEWDQd2L26ysCgfs+yZXqDpU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hQFu9Ppz9vmoxOf2novo44dagqMHXF8ihe8EHI4QhoRjinsl3mXOYMj79J9XO3XTc
	 X1yHAcDhyvo2K9T2wjwvJyNyv+ViOGCNNLpnxWv+cc/s71uYO3tfKdQLp6BG2fr09z
	 Mlb3sB93w18TEt8R5UPUq/oFYrpDtTY4tL1c9siUl/56H4prLrsWEMuuczQwy/Oo2x
	 MlWii7B9PPG05dhut52LXsZ9xX3qET2hWGgryXjoO1Jck/UUHmDWDH0jt+jVzbFYsy
	 dnwCKJKOYT0EVzl0w7SdEtdklzZbNckBgEU7pAX0CYQfhQPz3lcur6aqAaGlhyDnew
	 kGBe2r2OmtiVw==
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	Gang Yan <yangang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [RFC net-next 09/17] tls: introduce tls protocol ops structure
Date: Mon, 22 Jun 2026 18:43:29 +0800
Message-ID: <eacfe3e5929c07d35d08cab6663c61d40fac8649.1782123118.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782123118.git.tanggeliang@kylinos.cn>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
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
Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls.h  |  15 +++++++
 net/tls/tls_main.c | 101 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index aee4f74dc3d9..500fe87b50d2 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -224,6 +224,21 @@ struct tls_prot_info {
 	u16 tail_size;
 };
 
+struct tls_prot_ops {
+	struct module		*owner;
+	struct list_head	list;
+	int			protocol;
+
+	struct sk_buff *(*recv_skb)(struct sock *sk, u32 *off);
+	bool (*lock_is_held)(struct sock *sk);
+	void (*read_done)(struct sock *sk, size_t len);
+	u32 (*get_skb_seq)(struct sk_buff *skb);
+	int (*skb_get_header)(const struct sk_buff *skb, int offset,
+			      void *to, int len);
+	bool (*epollin_ready)(const struct sock *sk);
+	void (*check_app_limited)(struct sock *sk);
+};
+
 struct tls_context {
 	/* read-only cache line */
 	struct tls_prot_info prot_info;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index c9499bfd7a1d..296d133fa61f 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -137,6 +137,8 @@ static struct proto_ops
 tls_proto_ops[TLS_NUM_FAMILY][TLS_NUM_PROTO][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 			 const struct proto *base);
+static LIST_HEAD(tls_prot_ops_list);
+static DEFINE_SPINLOCK(tls_prot_ops_lock);
 
 static void update_sk_prot(struct sock *sk, struct tls_context *ctx)
 {
@@ -1059,6 +1061,22 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 #endif
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
 static int tls_init(struct sock *sk)
 {
 	struct tls_context *ctx;
@@ -1245,6 +1263,80 @@ static struct tcp_ulp_ops tcp_tls_ulp_ops __read_mostly = {
 	.get_info_size		= tls_get_info_size,
 };
 
+static int tls_validate_prot_ops(const struct tls_prot_ops *ops)
+{
+	if (!ops->recv_skb || !ops->lock_is_held ||
+	    !ops->read_done || !ops->get_skb_seq ||
+	    !ops->skb_get_header || !ops->epollin_ready ||
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
+	spin_lock_bh(&tls_prot_ops_lock);
+	if (tls_prot_ops_find(ops->protocol)) {
+		spin_unlock_bh(&tls_prot_ops_lock);
+		return -EEXIST;
+	}
+
+	list_add_tail_rcu(&ops->list, &tls_prot_ops_list);
+	spin_unlock_bh(&tls_prot_ops_lock);
+
+	pr_debug("tls_prot_ops %d registered\n", ops->protocol);
+	return 0;
+}
+
+static void tls_unregister_prot_ops(struct tls_prot_ops *ops)
+{
+	spin_lock_bh(&tls_prot_ops_lock);
+	list_del_rcu(&ops->list);
+	spin_unlock_bh(&tls_prot_ops_lock);
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
+	.recv_skb		= tls_tcp_recv_skb,
+	.lock_is_held		= tls_tcp_lock_is_held,
+	.read_done		= tcp_read_done,
+	.get_skb_seq		= tls_tcp_get_skb_seq,
+	.skb_get_header		= skb_copy_bits,
+	.epollin_ready		= tls_tcp_epollin_ready,
+	.check_app_limited	= tcp_rate_check_app_limited,
+};
+
 static int __init tls_register(void)
 {
 	int err;
@@ -1257,13 +1349,19 @@ static int __init tls_register(void)
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
@@ -1274,6 +1372,7 @@ static int __init tls_register(void)
 static void __exit tls_unregister(void)
 {
 	tcp_unregister_ulp(&tcp_tls_ulp_ops);
+	tls_unregister_prot_ops(&tls_tcp_ops);
 	tls_strp_dev_exit();
 	tls_device_cleanup();
 	unregister_pernet_subsys(&tls_proc_ops);
-- 
2.53.0

