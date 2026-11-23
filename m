Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795437501;
	b=1oewhiK4ZmOys20FIfsTfO2oeUinrxGveahQintXgkqNpzPKIKrHDmManvg9lJRHW0Mk
	 2pMmUkGJw1VIl7wFcoyC2mVJFXPelgbjxb3gDrDNqwR6WSvSMkOQL9vO2Pk+qQxZwQm/k
	 ZaUsTV51Z9rr99rt1SAycvI3MirmTMxEt/dw5bAj45voxOTh82k0mD6kjGM/si57ypgQM
	 dOek6ELNxneL5VH7bYbQch6P3PQReFrNRFGA0W0NnmXHpEQmeOzL+1QhyugpclktfYYYH
	 EayBUS9FZEe9QwEFmMSRv4RqJI57Oq56A6zT1YOzv5kL0GhxTcLNzSfdJ5rD1CWVqow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437501;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=uF0SgHYiwUp2jRHtFW+Plv06XPuN5g0RAoVUUL6yCRU=;
	b=l/n0RcozyOa4B+nNNmtnuWJyeCfnOSv/Zwk47pmQS0QLsuHju6jozkDa7EQW2t1F9e/1
	 K8QxyPhWSCItzduVTkzmUrvvN6HEkI9BOSirj0fjZPojqDz0eOSNi3gavHYlst82lEO+k
	 X0g5gLfChXJmJNY1lr2a2jGXp3BEf9leeeAm/hAS3hoNyBZO5YCrsui1sptEU19U3GNGz
	 cDMM6T78swFFQxV94pfx97HSwB/Y+p5j6YhbsJfidFTHvTSLVPL36CzE8fSfeGBm5A/xo
	 Wjvo4Tyd2XqxXKm5sHp6zn8J+UE3mmZNjmzH4CNJOs0TkbYxJcND03uv141NdUsqvlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B412606A32E
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 12:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B412606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1795437471; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HqhYwbYwJA4tzY2stam3FUsU5SiUxKu3WTkgigtP+FsxU6YP1PI4X8YTyPgRI6tU5q9GdEn1jSTV2leUy9CXEl2Wq1K/4Bp9MY+XBUBZ5gpxKuVmmGuv4AAl1LueUC0OBnqimEKfbtMgpjO001uL9A7zzEGLDqu9BSIy2E0SAaY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795437471; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uF0SgHYiwUp2jRHtFW+Plv06XPuN5g0RAoVUUL6yCRU=; 
	b=KaN3K6VJkD4Cyer3cbalj1dHHfKoePsNmX1qrZczyhF9umOiF+7BqP/wiMCLVrmHpGFrV0wnjLqLxIr+QP7+D93KTV//l2Yn7qQQNTF9RjTccUXuqlN7mbqQgwD/sLC8G9dg2vZfF99QP2D9yu5Suz4wULwRotcxFfuRgJj+Yg4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=XkEtK5NGt3WczB8pPDG8DQw5QIYQu3j3WUCEnOqcg2IdD9jrrOX6I8Dh7VPWy5hL/+PhyyjmnjzZ4flb88jvLQ8xb+OrZerQm7BPlXSnrVl/FvrMX2PHpVGXXTQbELJ/ihTOtTrh2iRxnp+kr2Gr0dW8/7beRZ733r+CPaOVULQ=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=uF0SgHYiwUp2jRHtFW+Plv06XPuN5g0RAoVUUL6yCRU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795437469250737.5816325045392;
	Mon, 23 Nov 2026 04:37:49 -0800 (PST)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v7 1/2] mptcp: sched: add subflow avoid flag for BPF schedulers
Date: Mon, 23 Nov 2026 18:07:29 +0530
Message-ID: <20261123123730.3265284-2-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123123730.3265284-1-kalpan.jani@mpiricsoftware.com>
References: <20261123123730.3265284-1-kalpan.jani@mpiricsoftware.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The core benches a subflow via the "stale" bit after
net.mptcp.stale_loss_cnt retransmission intervals without progress.
That bit belongs to the core and is tightly coupled to the RTO: it
gets cleared as soon as a packet is acked on the subflow
(mptcp_subflow_active() calls mptcp_subflow_set_active() once
rcv_tstamp moves forward).

"scheduled" doesn't cover this either. The core clears it right after
every send/retrans pass the scheduler set it in, so there's no way to
express "leave this subflow alone across future rounds" with it, and
nothing outside the scheduler that set it ever sees the value.

Add a scheduler-owned "avoid" bool to mptcp_subflow_context:

 - only mptcp_subflow_set_avoid() writes it. It is exposed to BPF
   struct_ops schedulers as a kfunc with the same registration and
   filter as mptcp_subflow_set_scheduled(), so only a BPF scheduler
   can change its value;

 - it is a standalone bool, alongside "scheduled" and "data_avail",
   rather than a bit in the adjacent flag bitfield.
   mptcp_subflow_data_available()
   clears map_valid, a bit in that bitfield, from the subflow's own
   receive path without holding the msk lock, while set_avoid() runs
   under the msk lock from BPF scheduler context. Bitfield writes
   are a non-atomic read-modify-write on the whole containing word, so
   placing avoid there would race with that update and risk silently
   corrupting map_valid or other neighbouring bits. The standalone
   bool is accessed with READ_ONCE()/WRITE_ONCE() for the same reason;

 - the flag is exported through MPTCP diagnostics, allowing userspace
   to observe whether a subflow has been marked as avoided.

BPF schedulers must explicitly check subflow->avoid when selecting
subflows. The flag is scheduler-owned and does not change the behavior
of the default in-kernel scheduler.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
Changes since v6:
- Removed the unreachable avoid checks from the default send and
  retransmission subflow pickers.
- Clarified that the avoid flag is owned and enforced by BPF schedulers.

v6: https://lore.kernel.org/all/20261123100821.2228839-2-kalpan.jani@mpiricsoftware.com/
---
 include/uapi/linux/mptcp.h | 1 +
 net/mptcp/bpf.c            | 1 +
 net/mptcp/diag.c           | 2 ++
 net/mptcp/protocol.h       | 3 +++
 net/mptcp/sched.c          | 6 ++++++
 5 files changed, 13 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 72a5d030154e1..b4ca97e074453 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -22,6 +22,7 @@
 #define MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED	_BITUL(6)
 #define MPTCP_SUBFLOW_FLAG_CONNECTED		_BITUL(7)
 #define MPTCP_SUBFLOW_FLAG_MAPVALID		_BITUL(8)
+#define MPTCP_SUBFLOW_FLAG_AVOID		_BITUL(9)
 
 #define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
 #define MPTCP_PM_EV_GRP_NAME	"mptcp_pm_events"
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 74648ca1e99b5..6fcd2bb5e6bdd 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -312,6 +312,7 @@ BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock, KF_RET_NULL)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
+BTF_ID_FLAGS(func, mptcp_subflow_set_avoid)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 70cf9ebce8338..7a2c40a63dfa4 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -49,6 +49,8 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin
 		flags |= MPTCP_SUBFLOW_FLAG_BKUP_LOC;
 	if (READ_ONCE(sf->fully_established))
 		flags |= MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED;
+	if (READ_ONCE(sf->avoid))
+		flags |= MPTCP_SUBFLOW_FLAG_AVOID;
 	if (sf->conn_finished)
 		flags |= MPTCP_SUBFLOW_FLAG_CONNECTED;
 	if (sf->map_valid)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9febcaf84762d..24e2540c05caa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -607,6 +607,7 @@ struct mptcp_subflow_context {
 		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
+	bool	avoid;		    /* pkt scheduler: skip subflow if possible */
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	bool	fully_established;  /* path validated */
 	bool	close_event_done;   /* has done the post-closed part,
@@ -935,6 +936,8 @@ static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 
 void mptcp_subflow_set_active(struct mptcp_subflow_context *subflow);
 
+void mptcp_subflow_set_avoid(struct mptcp_subflow_context *subflow, bool avoid);
+
 bool mptcp_subflow_active(struct mptcp_subflow_context *subflow);
 
 void mptcp_subflow_drop_ctx(struct sock *ssk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 1e59072d478c9..0ce59eb093df6 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -165,6 +165,12 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
 
+__bpf_kfunc void mptcp_subflow_set_avoid(struct mptcp_subflow_context *subflow,
+					 bool avoid)
+{
+	WRITE_ONCE(subflow->avoid, avoid);
+}
+
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-- 
2.43.0

