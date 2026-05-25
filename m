Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35272EDD6B
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701638; cv=none; b=p3XyUXQ3FvtfMAJwrGxEUjcOGNL4eqqxru3XotNQy6Qc3zjxPCyXwbNRgRJR0bWjPtooN+7IzRYCul9i9tpvj64MWHEsVe2hEOi1H+fA8qIo3we93G2Snet7yM2JwKlmT2IJ8uAVCGyXN0TV7igwTC/ZIM/57x4XGmCVZXkPTJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701638; c=relaxed/simple;
	bh=aYHWoIXanMnv7qBBelhKhdB6SGqkDGOrxdzo8PJoaL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNx1RigHTO+rdPOM5m/9N0nszvi/UjFC6ROEcjR8woIajMpVe/bUBjWdpr5wrxTD5AmSdvgHU4rhonvdGc3RUxEsqN8hOFZEh/JTq/Bq9Vj31H8A+RDzpMVTnxdAtxDxUJjEJUYzkHNUYzFeIQzL61quFrBEDPyERu7AxFVAbig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4DwK9KX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4DwK9KX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04ED81F000E9;
	Mon, 25 May 2026 09:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779701636;
	bh=77zcnKNMFNSyGnZK3VynpGkDJG1w0Yt2ls1JAkvUxZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T4DwK9KXAyhXlMSJUc64YCIXoNHZEXV5ZNm4I2FIicqscG2KITDAXE3iOlT5SaIhZ
	 BhOLEIlafe52MBEtN/GMSvzdNExVUA4uHyfC9KoBk2zx/xRaUo/FcGDHLoCRLO7oo+
	 /v2NBBhNPGdms8xVz8qTO3TnCu/OJ/ICThPfjWuzilGlxLnHi0EZLrVTgfHQOK+Nm8
	 YW13F85QWOgQVddPQrSWANIODNGUZl7MT9IK5vCT4+lL7WGmF0WDl/NvnRXpsWUuHx
	 //IcdakYuS40UJPmwZJ1x7gSLmpj99yG+BBq+i5Z5jMFjlvRPGWzH5jYTeMR0OpkE0
	 73g+/UMPSIurg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v17 08/14] nvme-tcp: implement host mptcp proto
Date: Mon, 25 May 2026 17:33:03 +0800
Message-ID: <5217d46d662389e8679a4838b26fa03d504d86b9.1779701391.git.tanggeliang@kylinos.cn>
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

An MPTCP-specific version of struct nvme_tcp_proto is implemented,
and it is assigned to ctrl->proto when the transport string is "mptcp".

The socket option setting logic is similar to the target side, except that
mptcp_sock_set_syncnt is newly defined for the host side.

These helpers set the values on all existing subflows of an MPTCP
connection, except for set_reuseaddr which only applies to the first
subflow. The values are then synchronized to other newly created
subflows in sync_socket_options().

A separate nvme_mptcp_ctrl_ops structure with .name = "mptcp" is defined
and used for MPTCP controllers.

"mptcp" is planned to be introduced as a new NVMe transport type into the
NVMe Base Specification in the future.

Currently, the Discovery Log does not yet recognize trtype=4 (MPTCP), and
will show "trtype: unrecognized" for such entries:

 =====Discovery Log Entry 0======
 trtype:  unrecognized
 adrfam:  ipv4
 subtype: current discovery subsystem
 treq:    not specified, sq flow control disable supported
 portid:  23106
 trsvcid: 23601
 subnqn:  nqn.2014-08.org.nvmexpress.discovery
 traddr:  10.1.1.1
 eflags:  none

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
 include/net/mptcp.h     | 11 +++++++++++
 net/mptcp/sockopt.c     | 30 +++++++++++++++++++++++++++++-
 3 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 305624d59c50..2388a8c443cc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2895,6 +2895,24 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
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
 
 };
 
+#ifdef CONFIG_MPTCP
+static const struct nvme_tcp_proto nvme_mptcp_proto = {
+	.protocol	= IPPROTO_MPTCP,
+	.set_syncnt	= mptcp_sock_set_syncnt,
+	.set_nodelay	= mptcp_sock_set_nodelay,
+	.no_linger	= mptcp_sock_no_linger,
+	.set_priority	= mptcp_sock_set_priority,
+	.set_tos	= __mptcp_sock_set_tos,
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
index 8eacb9424b37..9d5f0bf49d31 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -246,7 +246,11 @@ void mptcp_sock_set_priority(struct sock *sk, u32 priority);
 
 void mptcp_sock_no_linger(struct sock *sk);
 
+void __mptcp_sock_set_tos(struct sock *sk, int val);
+
 void mptcp_sock_set_tos(struct sock *sk);
+
+int mptcp_sock_set_syncnt(struct sock *sk, int val);
 #else
 
 static inline void mptcp_init(void)
@@ -342,7 +346,14 @@ static inline void mptcp_sock_set_priority(struct sock *sk, u32 priority) { }
 
 static inline void mptcp_sock_no_linger(struct sock *sk) { }
 
+static inline void __mptcp_sock_set_tos(struct sock *sk, int val) { }
+
 static inline void mptcp_sock_set_tos(struct sock *sk) { }
+
+static inline int mptcp_sock_set_syncnt(struct sock *sk, int val)
+{
+	return 0;
+}
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 730e945bf8cd..8ed7c8b875ed 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1598,6 +1598,8 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
 
 	ssk->sk_reuse = sk->sk_reuse;
+	if (inet_csk(sk)->icsk_syn_retries > 0)
+		tcp_sock_set_syncnt(ssk, inet_csk(sk)->icsk_syn_retries);
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
@@ -1749,7 +1751,7 @@ void mptcp_sock_no_linger(struct sock *sk)
 }
 EXPORT_SYMBOL(mptcp_sock_no_linger);
 
-static void __mptcp_sock_set_tos(struct sock *sk, int val)
+void __mptcp_sock_set_tos(struct sock *sk, int val)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
@@ -1768,6 +1770,7 @@ static void __mptcp_sock_set_tos(struct sock *sk, int val)
 	}
 	release_sock(sk);
 }
+EXPORT_SYMBOL(__mptcp_sock_set_tos);
 
 void mptcp_sock_set_tos(struct sock *sk)
 {
@@ -1783,3 +1786,28 @@ void mptcp_sock_set_tos(struct sock *sk)
 		__mptcp_sock_set_tos(sk, val);
 }
 EXPORT_SYMBOL(mptcp_sock_set_tos);
+
+int mptcp_sock_set_syncnt(struct sock *sk, int val)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk;
+
+	if (val < 1 || val > MAX_TCP_SYNCNT)
+		return -EINVAL;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	inet_csk(sk)->icsk_syn_retries = val;
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (ssk) {
+			lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+			tcp_sock_set_syncnt(ssk, val);
+			release_sock(ssk);
+		}
+	}
+	release_sock(sk);
+	return 0;
+}
+EXPORT_SYMBOL(mptcp_sock_set_syncnt);
-- 
2.53.0

