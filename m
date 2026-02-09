Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F5326958
	for <mptcp@lists.linux.dev>; Mon,  9 Feb 2026 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627886; cv=none; b=IFCD2zCBXnPLs8fjQPN8Qz9FwPmaesI5ERRgPuGSurFJIsi29JZ4eFIT8PYvVsypocZf0eXy32VXtFYvPQOEa/ctj8Mv4CZMhD3ctJnb714nmqEzF574ui+mAYR7rZ75W7yzl+Usih63svY2W4iRZyKP9iaM9XQg1uWec2duqBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627886; c=relaxed/simple;
	bh=k2RLL4tdrek15Tot3Ev0+KIO527easR/iHR4DftlC5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H48mEvOdgGB4/6cHpDtdL3ofKiAHPIYtRCRdQGmzf4x+/d2xktTjYBErfdzS/UQdRFe1OtxEA5Pe8B4PBDILNkOOJPnRAyQnKG+vGygflTqjXN/XQDow/qybONO2rATGGGPhOwZQsgNceVmgRu2EoxWtvYb9lLsnjhn2pVCVHY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcMQhBUp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcMQhBUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C949C19424;
	Mon,  9 Feb 2026 09:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770627886;
	bh=k2RLL4tdrek15Tot3Ev0+KIO527easR/iHR4DftlC5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UcMQhBUpNg5OBkd6d88xJO/SZsto1qDWRa3eOQ1qgshLVSrdy0vBFjbcRynw6eViu
	 zZG1pOJBn7AQIKrcxAcSLLfAIg87m7kKceF0/huXtV13YGpnI8wSZ0DmNjOEgo3m0w
	 Tk+MlaExecNgEv+4YjwOH+/5KeYOn/ib8UEHyFaC46oeNEcWz+foe6ox1pu6LNv5Gu
	 b9pvstL0u+/IGCsUsLo+I2Bt5oWCYtdnE/yZpLTRc+5hseF/pX+474zleOUl0NHZSQ
	 lgxXFr2+PQ475iewR9JQmWkYU7vjeJ+x/kOWnWARNpN2KvjR0D2KBAQsENxC2OlVeP
	 GOVacnqkH7m1g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v3 5/7] mptcp: add sock_set_reuseaddr
Date: Mon,  9 Feb 2026 17:04:20 +0800
Message-ID: <59d9d179531b44c04e932f3e8eacfe7ce2d5694e.1770627071.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1770627071.git.tanggeliang@kylinos.cn>
References: <cover.1770627071.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch introduces a dedicated MPTCP helper, sock_set_reuseaddr, which
sets the address reuse flag on the first subflow socket of an MPTCP
connection, and applies it to the target side in the 'NVMe over MPTCP'
implementation.

Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c |  2 ++
 include/net/mptcp.h       |  4 ++++
 net/mptcp/protocol.c      | 15 +++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 488f6161d5ae..9864bb62cf5b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2070,6 +2070,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	port->sock->sk->sk_user_data = port;
 	port->data_ready = port->sock->sk->sk_data_ready;
 	port->sock->sk->sk_data_ready = nvmet_tcp_listen_data_ready;
+	sk_is_msk(port->sock->sk) ?
+	mptcp_sock_set_reuseaddr(port->sock->sk) :
 	sock_set_reuseaddr(port->sock->sk);
 	sk_is_msk(port->sock->sk) ?
 	mptcp_sock_set_nodelay(port->sock->sk) :
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 60cbf29448b0..63b64b7699e3 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -246,6 +246,8 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
 
 void mptcp_sock_set_nodelay(struct sock *sk);
+
+void mptcp_sock_set_reuseaddr(struct sock *sk);
 #else
 
 static inline void mptcp_init(void)
@@ -339,6 +341,8 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return hto
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
 
 static inline void mptcp_sock_set_nodelay(struct sock *sk) { }
+
+static inline void mptcp_sock_set_reuseaddr(struct sock *sk) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 661a27a27b1a..5aa11062230e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3823,6 +3823,21 @@ void mptcp_sock_set_nodelay(struct sock *sk)
 }
 EXPORT_SYMBOL(mptcp_sock_set_nodelay);
 
+void mptcp_sock_set_reuseaddr(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk;
+
+	lock_sock(sk);
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk))
+		goto unlock;
+	ssk->sk_reuse = SK_CAN_REUSE;
+unlock:
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_reuseaddr);
+
 bool mptcp_finish_join(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-- 
2.53.0

