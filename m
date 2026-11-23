Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795428546;
	b=G0ZxLUUU5Lm5BjrMA2QPxEXF1k3BxErR8TLWiRkd/WkOuctrFgrfWw1Y2GQrYfKm4mlP
	 z0HqZLXINQJR/QnO1GOSv3bNhqGAi5XpGxXTnrsbc1Mxn7ovp64Gov57qDg0++tdg3cDt
	 8QQicceKOwjIxvqlkUfN1vzSKXmnZCpaNquMVfnXEpeOEU/E1Qwzkdjwf/CzP6qByI/YM
	 3EnDUmTODjAU6PPXyTKgvkfyC0uf3Rxya0Il7VXqNgzKsOsXdpUp2Gw0O+Gep7Czeyrr7
	 JcsYDbhTlbxtNCwAsl+FUrAwWK6/T9+/1z180Atfz1xSdKovR4RkH3j2TXdHExtZW+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428546;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=8i++qpaQKl4a3l72yMCB8letGCWot0T4utJRPP/yrRw=;
	b=IURT3+q/oHgMum4W8wdt8uAXcUimvmRGR1svk9KNIDYNJSMw1JIAgUOU07YgaqN0nWBg
	 KTHK8Vlko+86zqHa72rq/knRkH3G+DFHqsyp7FWWNG32/+01TQaRc26m8c9VxjadTPapr
	 RFoaf+i0csfzG8a8ZLlZPdJdCBPM+BooA7pgd7kbnwtsWh64pFbtPVVbpGRBrTVs77jwK
	 84ltwDJWInbd4llxcB9XYHyxho4KoptvojN92DyoUkchaYI9iLX2VLWrUJ6a3jcoCXOr5
	 h3dyFbInhBHQDEIcuZ3qnf1NHl7jTBUkra8cb9qqszkSKRhbFDKK55G0kVC/ePKVZAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EC7606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 10:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4EC7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1795428533; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=T7MzBaBao6RCr2AVSGt1ZTZLBMzxgTm/vEM/1fFVsFNtp7f3MQZfRVlgDC3zpFzdCtMX4sB9F7oE68S8llvtGKjwIonK6ZhKCtVwwnUc6n36gsfCOXVV1RTwt+ZBAfAropTDPvBOzO2UP0N73sRyEblEGZPny3iRevR8Pi87/H0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795428533; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8i++qpaQKl4a3l72yMCB8letGCWot0T4utJRPP/yrRw=; 
	b=Fi/+huuSB6WXkKfqc6iaV0OlGwbNY6I+jfn93OWrJrc3KsR8xlqTtUymrS4zbgq2skJNdGHoyAnoDGknFUokFk1uxKEkjWd+HC6Fwnocqxuj11l1ifKx2UJJSn6zXDKH5FJDWm514tnoI7FhE4+Gao9PMgEgHRMcr1wPFyOQzdk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=U51nYIDnd6+3rlKhOU0gmcvBwPhxNH7ezepWp7ZsMVlmeSO4Q7oJnilc3XAVe9OCNiqcveiIaV6uRLQ1w5f/pdirMJ2KkCWca/cm+tKsW/DPv3rvTJpDgV53qG6scupdDqq43Smf8NACTPhSqQDHkoX217b/F72V9cQCNU5wzSg=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=8i++qpaQKl4a3l72yMCB8letGCWot0T4utJRPP/yrRw=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795428530682268.79241478874997;
	Mon, 23 Nov 2026 02:08:50 -0800 (PST)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v6 1/2] mptcp: sched: add subflow avoid flag and enforce it in default sched
Date: Mon, 23 Nov 2026 15:38:20 +0530
Message-ID: <20261123100821.2228839-2-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123100821.2228839-1-kalpan.jani@mpiricsoftware.com>
References: <20261123100821.2228839-1-kalpan.jani@mpiricsoftware.com>
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

 - only mptcp_subflow_set_avoid() touches it, never the core. It's
   exposed to BPF struct_ops schedulers as a kfunc with the same
   registration and filter as mptcp_subflow_set_scheduled(), so only
   a scheduler can call it;

 - it is a standalone bool, alongside "scheduled" and "data_avail",
   rather than a bit in the adjacent flag bitfield.
   mptcp_subflow_data_available()
   clears map_valid, a bit in that bitfield, from the subflow's own
   receive path without holding the msk lock, while set_avoid() runs
   under the msk lock from BPF scheduler context. Bitfield writes
   are a non-atomic read-modify-write on the whole containing word, so
   placing avoid there would race with that update and risk silently
   corrupting map_valid or other neighbouring bits. The standalone
   bools next to it are accessed with READ_ONCE()/WRITE_ONCE() for
   the same reason;

 - the default in-kernel subflow picker, mptcp_subflow_get_send() and
   mptcp_subflow_get_retrans(), now skips an avoided subflow next to
   the existing active-subflow check. This only applies when no
   custom scheduler is loaded (mptcp_sched_default_get_send() /
   _get_retrans() are what msk->sched->get_send() falls back to); a
   custom BPF scheduler bypasses this default picker entirely, so it
   only honours avoid if it explicitly checks subflow->avoid itself,
   exactly as the selftest scheduler in patch 2 does. avoid defaults
   to false and only an explicit set_avoid() call flips it, so this
   is a no-op for anyone who doesn't use it;

 - it's surfaced through MPTCP diag as MPTCP_SUBFLOW_FLAG_AVOID,
   alongside the existing BKUP/FULLY_ESTABLISHED flags.

set_avoid() has no C callers in-tree, unlike set_scheduled() which
the core send/retrans/close paths call directly -- mark it
__bpf_kfunc so it survives LTO/dead-code-elimination before
resolve_btfids looks for it in BTF.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
Changes since v5:
- Rebased onto the latest mptcp/export tree.
- No functional changes.

v5 : https://lore.kernel.org/all/20260915093506.465110-2-kalpan.jani@mpiricsoftware.com/
---
 include/uapi/linux/mptcp.h | 1 +
 net/mptcp/bpf.c            | 1 +
 net/mptcp/diag.c           | 2 ++
 net/mptcp/protocol.c       | 4 ++--
 net/mptcp/protocol.h       | 3 +++
 net/mptcp/sched.c          | 6 ++++++
 6 files changed, 15 insertions(+), 2 deletions(-)

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
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index be23768b6d051..8a2894293e70c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1650,7 +1650,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 		trace_mptcp_subflow_get_send(subflow);
 		ssk =  mptcp_subflow_tcp_sock(subflow);
-		if (!mptcp_subflow_active(subflow))
+		if (!mptcp_subflow_active(subflow) || READ_ONCE(subflow->avoid))
 			continue;
 
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
@@ -2575,7 +2575,7 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		if (!__mptcp_subflow_active(subflow))
+		if (!__mptcp_subflow_active(subflow) || READ_ONCE(subflow->avoid))
 			continue;
 
 		/* still data outstanding at TCP level? skip this */
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

