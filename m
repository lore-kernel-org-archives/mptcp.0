Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CCD3FBB5C
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106090; cv=none; b=DBHV8cShHWFgVLvlZOAcU4bdmVwpZ/JFqVnQRKfSifudwuOiXxLAiFXbF1+r72Jnc85diCaZEus9fYqZSSqIRqLpNH+2qbu8dCyuVNMuimSqScev/qvUNntcAej5rmE7Z1OwL/DcTGiqsjqihFYyWxsNdBMX0qgpZW75WN80ihM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106090; c=relaxed/simple;
	bh=O3bXL2fBO+OMBP01NvgAQ/8Cx7GuF/QMGzG0z2GAG4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8/mH0fEggwJSjHTMWyn4T6GEBAaRXlNLJOCKqDS5jn1C25p3RKKEzR917pzF+LjVZL6dZCaAxww2K5dfmU5ocrFZ/RbLetGf5qAvy8tOSmVdf1Zo7okvkOy5X/4R94oKtkjujuuTwN8yJ426Jh/DAgfF3DKumdeeBj7FFf70Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOcUcnkY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOcUcnkY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C609C2BCB8;
	Mon, 18 May 2026 12:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779106090;
	bh=O3bXL2fBO+OMBP01NvgAQ/8Cx7GuF/QMGzG0z2GAG4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AOcUcnkYvDLGPhRHXDASwZtH5frrBEZG+z3CQCLnkDKGHYFhPTBJaIiat5mYCmyyz
	 g9meOfM0P+bFH3SdpMF+QsdwPIOrtrMTxINRFYMsue7Q/7Pnv2eWDexnS4OFDhvBFd
	 hivhuTi4aM9IgBuRl1HHtwmVbXXe7h2DlEdTJ2TNpHmj+5UlFtqvIxjE4AhL0YKHFb
	 WJgrob7hKYH36XqpcaH4WjpHOSfrNoxZZ04WnlxBNIXSXalsXo+OX9MurfLzf1iGRz
	 OUkoNIiII075OZd9ZD86mKhclI9lBN9Ccmg+5w/WA77Pe55oduvSILGg0L52w9zn3G
	 i98tgnod+dNVw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v13 07/12] nvme-tcp: implement host mptcp proto
Date: Mon, 18 May 2026 20:07:32 +0800
Message-ID: <14959d6716913cca12866057661831550835f25c.1779104752.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779104752.git.tanggeliang@kylinos.cn>
References: <cover.1779104752.git.tanggeliang@kylinos.cn>
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
 net/mptcp/sockopt.c     | 35 ++++++++++++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 1 deletion(-)

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
index be245babef30..90bfb37930da 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1598,6 +1598,8 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
 
 	ssk->sk_reuse = sk->sk_reuse;
+	if (inet_csk(sk)->icsk_syn_retries > 0)
+		tcp_sock_set_syncnt(ssk, inet_csk(sk)->icsk_syn_retries);
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
@@ -1769,7 +1771,7 @@ void mptcp_sock_no_linger(struct sock *sk)
 }
 EXPORT_SYMBOL(mptcp_sock_no_linger);
 
-static void __mptcp_sock_set_tos(struct sock *sk, int val)
+void __mptcp_sock_set_tos(struct sock *sk, int val)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk;
@@ -1793,6 +1795,7 @@ static void __mptcp_sock_set_tos(struct sock *sk, int val)
 	}
 	release_sock(sk);
 }
+EXPORT_SYMBOL(__mptcp_sock_set_tos);
 
 void mptcp_sock_set_tos(struct sock *sk)
 {
@@ -1815,3 +1818,33 @@ void mptcp_sock_set_tos(struct sock *sk)
 		__mptcp_sock_set_tos(sk, val);
 }
 EXPORT_SYMBOL(mptcp_sock_set_tos);
+
+int mptcp_sock_set_syncnt(struct sock *sk, int val)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk;
+	struct sock *ssk;
+
+	if (val < 1 || val > MAX_TCP_SYNCNT)
+		return -EINVAL;
+
+	if (sk->sk_protocol != IPPROTO_MPTCP)
+		return -EINVAL;
+
+	msk = mptcp_sk(sk);
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

