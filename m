Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD7522F772
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767519318; cv=none; b=FDU8kxkpuGCWb6U4jJzD/Hjjf2cFpa31fXxoaCHuoJUvBOTyNRLLYLHP9shb8JZytj7CBB1X3rSOUoQXq8aML4JejeG3t+q1c/0N0FDiInqhuLeDpExRU8oWY5E5gMcpeRQHI5ndN3e8Hylc1ZQlhie34uRAVK3Q3g+7ABbA8As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767519318; c=relaxed/simple;
	bh=6m+cE1u1XbpqaJNA0zd0drM14tcrscpRtKxOLtrWHzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ppjwv3oWAGKPYZvcSQJMQAz1Qwqe18XCCXJFxVR41G58Ihiqcd0UeRjTh6H9gyp1v6ZNHdrvrgk7d+KY6PFCJ0w2WaRpb871piQsaK4a29DEuN3SV0IQbB0Z2g+rBBLXHaf+XaQK7ZKYvPHpexSjUOf8gbjEENnWBT/A8OIqPIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gd/O+IlR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd/O+IlR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0456C116C6;
	Sun,  4 Jan 2026 09:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767519318;
	bh=6m+cE1u1XbpqaJNA0zd0drM14tcrscpRtKxOLtrWHzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gd/O+IlRnFO2FHapk31q+ISmgZUzA5Np11K2m+9sJunTHN2EG2CxBkI43tujvhY4Q
	 s+VkrFyjGUH+42ksnKhaOJtAveskJUVaQ/T8yxznVs91hK0m/FV5rLw7kg1pCSDoJR
	 isePaOzUQ0Ai/IyZhqQo9OXRRTjviqMPcSR0aB4B/xq1J7ioJe0u8GxQ54qOMrqTIA
	 F+IVrC+z9dn6kfjyu12LxlIRd23LXseCcGcxBGyTvfO9CQCUhLy+cBRDiT3uS7WktH
	 oRvfvy+6O0noYiOKxFY7wD4gTOHdZFMp4Al1fq5wfXT6IwEnLvqtKFkjDnxzReKYjk
	 1PChEDP/seRgQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v6 01/10] tls: introduce struct tls_prot_ops
Date: Sun,  4 Jan 2026 17:35:02 +0800
Message-ID: <f1c4f2b1536ad480364108a86df20405d5dd17c6.1767518836.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1767518836.git.tanggeliang@kylinos.cn>
References: <cover.1767518836.git.tanggeliang@kylinos.cn>
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
 include/net/tls.h  | 17 +++++++++++
 net/tls/tls_main.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/include/net/tls.h b/include/net/tls.h
index ebd2550280ae..34c39d3d284f 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -220,6 +220,23 @@ struct tls_prot_info {
 	u16 tail_size;
 };
 
+struct tls_prot_ops {
+	int			protocol;
+	struct module		*owner;
+	struct list_head	list;
+
+	int (*inq)(struct sock *sk);
+	int (*sendmsg_locked)(struct sock *sk, struct msghdr *msg, size_t size);
+	struct sk_buff *(*recv_skb)(struct sock *sk, u32 seq, u32 *off);
+	void (*read_done)(struct sock *sk, size_t len);
+	u32 (*get_seq)(struct sk_buff *skb);
+	int (*read_sock)(struct sock *sk, read_descriptor_t *desc,
+			 sk_read_actor_t recv_actor);
+	__poll_t (*poll)(struct file *file, struct socket *sock,
+			 struct poll_table_struct *wait);
+	bool (*epollin_ready)(const struct sock *sk, int target);
+};
+
 struct tls_context {
 	/* read-only cache line */
 	struct tls_prot_info prot_info;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 56ce0bc8317b..42d72539ecd3 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -632,6 +632,57 @@ static int validate_crypto_info(const struct tls_crypto_info *crypto_info,
 	return 0;
 }
 
+static DEFINE_SPINLOCK(tls_prot_ops_lock);
+static LIST_HEAD(tls_prot_ops_list);
+
+/* Must be called with rcu read lock held */
+static struct tls_prot_ops *tls_prot_ops_find(int protocol)
+{
+	struct tls_prot_ops *ops, *ret = NULL;
+
+	list_for_each_entry_rcu(ops, &tls_prot_ops_list, list) {
+		if (ops->protocol == protocol) {
+			ret = ops;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int tls_validate_prot_ops(const struct tls_prot_ops *ops)
+{
+	if (!ops->inq || !ops->sendmsg_locked ||
+	    !ops->recv_skb || !ops->read_done ||
+	    !ops->get_seq || !ops->read_sock ||
+	    !ops->poll || !ops->epollin_ready) {
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
 static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 				  unsigned int optlen, int tx)
 {
@@ -1044,6 +1095,23 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 #endif
 }
 
+static u32 tcp_get_seq(struct sk_buff *skb)
+{
+	return TCP_SKB_CB(skb)->seq;
+}
+
+static struct tls_prot_ops tls_tcp_ops = {
+	.protocol	= IPPROTO_TCP,
+	.inq		= tcp_inq,
+	.sendmsg_locked	= tcp_sendmsg_locked,
+	.recv_skb	= tcp_recv_skb,
+	.read_done	= tcp_read_done,
+	.get_seq	= tcp_get_seq,
+	.read_sock	= tcp_read_sock,
+	.poll		= tcp_poll,
+	.epollin_ready	= tcp_epollin_ready,
+};
+
 static int tls_init(struct sock *sk)
 {
 	struct tls_context *ctx;
@@ -1051,6 +1119,8 @@ static int tls_init(struct sock *sk)
 
 	tls_build_proto(sk);
 
+	tls_register_prot_ops(&tls_tcp_ops);
+
 #ifdef CONFIG_TLS_TOE
 	if (tls_toe_bypass(sk))
 		return 0;
-- 
2.51.0

