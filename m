Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702D136CDFD
	for <mptcp@lists.linux.dev>; Sat, 16 May 2026 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778920142; cv=none; b=XBSqnPwj38N953+R2eEdA6PpnQJyjRXhsy1hxCSj+0C9wZ+8xH49nmKSUGu8VvL5CwtJXiQz1coHuf691gA8o8GGBKpXX8r1nOI/NZ116PHhB/yhJG3qUQJ//2UrWGw9QbPB3R4+Q40dD2mXVlfS5/Zys7/S7zaSgtROdwdvwHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778920142; c=relaxed/simple;
	bh=zIEu3Tbq4u0Ak9NYh4lD4Ah96s2t9fq1T8XcX4eNn+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MT6d07xw+ELGHbiFzKmuufT922+FTfbeELOlnjtb7mOmkR0ao2gbSEC4BPtrpZ2j+7osepV7TZCXuNf4Urjxv9GW2+vmy6zqTSxKaYNuAwc6kwPd3xYSpo5Z8mLk/5fB7R4Cc6LVNvzmdBEJuXD22E/cWTWaBY60Na3Axtjjabk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJTKBG7M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJTKBG7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CC9C2BCB7;
	Sat, 16 May 2026 08:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778920142;
	bh=zIEu3Tbq4u0Ak9NYh4lD4Ah96s2t9fq1T8XcX4eNn+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kJTKBG7MP2nE6OqIDkQZbJ2kTvEAKR7RJEX4EGnn4WJ8z3JxMKk7HNJDKG3DMCpxl
	 c7Bz2cEda2uaLGdPAZ1oJHllIHhBkILAMtYZVPZT1zOPaD3DXM16B8WJZa5zHsGn0a
	 xdw0B5wZ6tsP53YHYIlXKovb2DaRDTMgFyfPBTiGYuWKzr1Uvy+nHZz96AP1C1xRK8
	 rsCTAWy5RzycIdy87D7jHRkDRrA8DXbQeEl63eHvens18VMWIrExBQ2TBKmGdZDoc+
	 DOOGCupSkx7jqGGLuidXTFsuLTUNsxS7vS2SbjzuA9BeVnpu0Gf3LUOAgcDPJViXHd
	 8OHsbyCXcIcXw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v10 7/9] nvme-tcp: implement host mptcp proto
Date: Sat, 16 May 2026 16:27:55 +0800
Message-ID: <a196a5242922b739e756ee25eeac438c5fbf9ee2.1778919284.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778919284.git.tanggeliang@kylinos.cn>
References: <cover.1778919284.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

An MPTCP-specific version of struct nvme_tcp_proto is implemented,
and it is assigned to ctrl->proto when the transport string is "mptcp".

The socket option setting logic is similar to the target side, except that
mptcp_sock_set_syncnt is newly defined for the host side.

It sets the value on the first subflow socket of an MPTCP connection.
The value is then synchronized to other newly created subflows in
sync_socket_options().

A separate nvme_mptcp_ctrl_ops structure with .name = "mptcp" is defined
and used for MPTCP controllers.

Cc: Hannes Reinecke <hare@suse.de>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 34 ++++++++++++++++++++++++++++++++++
 include/net/mptcp.h     |  7 +++++++
 net/mptcp/protocol.h    |  1 +
 net/mptcp/sockopt.c     | 21 +++++++++++++++++++++
 4 files changed, 63 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bad18d7c323e..22fcfc3b5c2a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2896,6 +2896,24 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.get_virt_boundary	= nvmf_get_virt_boundary,
 };
 
+#ifdef CONFIG_MPTCP
+static const struct nvme_ctrl_ops nvme_mptcp_ctrl_ops = {
+	.name			= "mptcp",
+	.module			= THIS_MODULE,
+	.flags			= NVME_F_FABRICS | NVME_F_BLOCKING,
+	.reg_read32		= nvmf_reg_read32,
+	.reg_read64		= nvmf_reg_read64,
+	.reg_write32		= nvmf_reg_write32,
+	.subsystem_reset	= nvmf_subsystem_reset,
+	.free_ctrl		= nvme_tcp_free_ctrl,
+	.submit_async_event	= nvme_tcp_submit_async_event,
+	.delete_ctrl		= nvme_tcp_delete_ctrl,
+	.get_address		= nvme_tcp_get_address,
+	.stop_ctrl		= nvme_tcp_stop_ctrl,
+	.get_virt_boundary	= nvmf_get_virt_boundary,
+};
+#endif
+
 static bool
 nvme_tcp_existing_controller(struct nvmf_ctrl_options *opts)
 {
@@ -2923,6 +2941,18 @@ static const struct nvme_tcp_proto nvme_tcp_proto = {
 	.ops		= &nvme_tcp_ctrl_ops,
 };
 
+#ifdef CONFIG_MPTCP
+static const struct nvme_tcp_proto nvme_mptcp_proto = {
+	.protocol	= IPPROTO_MPTCP,
+	.set_syncnt	= mptcp_sock_set_syncnt,
+	.set_nodelay	= mptcp_sock_set_nodelay,
+	.no_linger	= mptcp_sock_no_linger,
+	.set_priority	= mptcp_sock_set_priority,
+	.set_tos	= mptcp_sock_set_tos,
+	.ops		= &nvme_mptcp_ctrl_ops,
+};
+#endif
+
 static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
@@ -2989,6 +3019,10 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 
 	if (!strcmp(ctrl->ctrl.opts->transport, "tcp")) {
 		ctrl->proto = &nvme_tcp_proto;
+#ifdef CONFIG_MPTCP
+	} else if (!strcmp(ctrl->ctrl.opts->transport, "mptcp")) {
+		ctrl->proto = &nvme_mptcp_proto;
+#endif
 	} else {
 		ret = -EINVAL;
 		goto out_free_ctrl;
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 91ce7b9b639d..49031a111e69 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -247,6 +247,8 @@ void mptcp_sock_set_priority(struct sock *sk, u32 priority);
 void mptcp_sock_no_linger(struct sock *sk);
 
 void mptcp_sock_set_tos(struct sock *sk, int val);
+
+int mptcp_sock_set_syncnt(struct sock *sk, int val);
 #else
 
 static inline void mptcp_init(void)
@@ -343,6 +345,11 @@ static inline void mptcp_sock_set_priority(struct sock *sk, u32 priority) { }
 static inline void mptcp_sock_no_linger(struct sock *sk) { }
 
 static inline void mptcp_sock_set_tos(struct sock *sk, int val) { }
+
+static inline int mptcp_sock_set_syncnt(struct sock *sk, int val)
+{
+	return 0;
+}
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 661600f8b573..0096cabdccd2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -336,6 +336,7 @@ struct mptcp_sock {
 	int		keepalive_idle;
 	int		keepalive_intvl;
 	int		maxseg;
+	int		icsk_syn_retries;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 062ed4a43e5a..afd5a4c511dc 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1602,6 +1602,8 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	priority = READ_ONCE(sk->sk_priority);
 	if (priority > 0)
 		sock_set_priority(ssk, priority);
+	if (msk->icsk_syn_retries > 0)
+		tcp_sock_set_syncnt(ssk, msk->icsk_syn_retries);
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
@@ -1768,3 +1770,22 @@ void mptcp_sock_set_tos(struct sock *sk, int val)
 	release_sock(sk);
 }
 EXPORT_SYMBOL(mptcp_sock_set_tos);
+
+int mptcp_sock_set_syncnt(struct sock *sk, int val)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk;
+
+	if (val < 1 || val > MAX_TCP_SYNCNT)
+		return -EINVAL;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	msk->icsk_syn_retries = val;
+	ssk = __mptcp_nmpc_sk(msk);
+	if (!IS_ERR(ssk))
+		tcp_sock_set_syncnt(ssk, val);
+	release_sock(sk);
+	return 0;
+}
+EXPORT_SYMBOL(mptcp_sock_set_syncnt);
-- 
2.53.0

