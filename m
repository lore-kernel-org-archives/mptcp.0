Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4023404BD5
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567290; cv=pass; b=ArBbGb3Z3wFoN2G/Hv59y2PqeWTU9kfu4C9XTASamiNeL6fgOdWwEZuh76QoZ0pPMtViR05BA99dPxttg2WY0GHWg1s3mKBFom0Wpebeit/lTQQgQ2ZzvIpS0lQqLStsr29RkLmj8hSGNjwUJ71fDjz0lIkl28zMAL6zdprFqig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567290; c=relaxed/simple;
	bh=A8ODt8hnUNHxWnP+1A6DmcXgFl2zKgJe2zv2sN/Mtd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwHhYMnZ3arVoTE3VxAuvmTeReyD3TKU/pF6rKdHtKrlnsrKsHU7bXPi1TFEkf0vqREJhCha79jMP+LbIQqcNuhTCGv+jOf9226HId4koFoS0+v38NUuqpWg21lEQYwVYjqTJIME+6+5464f1A+9EtkYOTukejX37edB1IvyGNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=UTbs7/Yy reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="UTbs7/Yy"
ARC-Seal: i=1; a=rsa-sha256; t=1787567275; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MAKQGYbQHEfc2YXCO4BYwSimxqkVnyfEIsCNtEarOtDHSlwdTYKugeBh1SW0FvdQPwmD0fdOlUG+soes+XWKxfT1P7ET1rDwqi5dO3DUcSm4ukWivvTgieGxnvuAb2MJcrhTMDFK1hU6riZ1CA21/fwEMhvS6IZPr8lkXRv5mSY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787567275; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lXJFg2gh8PxRiyEL7FK+MaQC+pYD19sEKaw9+gNQ4k0=; 
	b=geOOpxcq6V5fn168w2aPYHq5W2ZeDXkusJCLiW91wYowWJFlpmPFh3NIXsNlcNpHH4ZGlFDwCoutfFH4uiSaGgkGV6A6ttZPM4fCcymIn6MJTAv4gujYYNUzblj7gxHv3/wYVwnz2t2Mpqob1/PR0eAo8JObp+exTCiQQ9bNdNM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787567275;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=lXJFg2gh8PxRiyEL7FK+MaQC+pYD19sEKaw9+gNQ4k0=;
	b=UTbs7/YyxB1KHZsvirc4rFPHhjC5rE+Ugdbu/Cv4BUWyoojM2ru2woH56hrzrsqZ
	OURYVmeewtSVUODgtOuf3YfNGE7zEOr3F345N1bGk8qIHHLCXP/3lQesI0GC1XJHyJN
	6iOOJoVaD+/f3Ib80H1lm+ncfSpurVgKcCrOyUSI=
Received: by mx.zohomail.com with SMTPS id 1787567274159883.0568675579015;
	Mon, 24 Aug 2026 03:27:54 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com
Subject: [PATCH mptcp-next v2 1/2] mptcp: sched: add subflow avoid flag and enforce it in core
Date: Mon, 24 Aug 2026 15:57:40 +0530
Message-ID: <20260824102741.347492-2-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824102741.347492-1-kalpan.jani@mpiricsoftware.com>
References: <20260824102741.347492-1-kalpan.jani@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
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

Add a scheduler-owned "avoid" bit to mptcp_subflow_context:

 - only mptcp_subflow_set_avoid() touches it, never the core. It's
   exposed to BPF struct_ops schedulers as a kfunc with the same
   registration and filter as mptcp_subflow_set_scheduled(), so only
   a scheduler can call it;

 - it sits in the existing __unused:8 padding of the flag bitfield
   rather than as its own bool, so the struct doesn't grow;

 - it lives in the struct_group(reset) block, so it clears on
   subflow reset and a re-established path starts fresh;

 - mptcp_subflow_get_send() and mptcp_subflow_get_retrans() -- the
   default in-kernel subflow picker -- now skip an avoided subflow
   next to the existing active-subflow check. This runs regardless of
   whether a custom scheduler is loaded, so the flag has real weight
   on core selection and isn't only meaningful to whatever BPF
   program happens to read it back. avoid defaults to false and only
   an explicit set_avoid() call flips it, so this is a no-op for
   anyone who doesn't use it;

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

Changes since v1:
- moved avoid from a standalone bool into the existing __unused:8
  bitfield padding: the extra bool pushed lent_mem_frag onto a
  4-byte-aligned boundary, adding a 4-byte hole. The bitfield slot was
  already reserved and unused.
- marked mptcp_subflow_set_avoid() __bpf_kfunc: no C callers, unlike
  set_scheduled(), so it could be dropped under LTO before
  resolve_btfids finds it in BTF.
- switched subflow->avoid access from WRITE_ONCE()/READ_ONCE() to
  plain assignment/read: it's a bitfield member now, and
  {READ,WRITE}_ONCE() require taking its address, which bitfields
  don't allow.
- mptcp_subflow_get_send() and mptcp_subflow_get_retrans() now skip a
  subflow with avoid set, next to the existing active-subflow check:
  previously nothing in the core consulted the flag.
- exposed avoid via MPTCP diag as MPTCP_SUBFLOW_FLAG_AVOID, next to
  the existing BKUP_LOC/FULLY_ESTABLISHED flags.

v1: https://lore.kernel.org/all/20260715101148.2601045-2-kalpan.jani@mpiricsoftware.com/
---
 include/uapi/linux/mptcp.h | 1 +
 net/mptcp/bpf.c            | 1 +
 net/mptcp/diag.c           | 2 ++
 net/mptcp/protocol.c       | 4 ++--
 net/mptcp/protocol.h       | 5 ++++-
 net/mptcp/sched.c          | 6 ++++++
 6 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 72a5d030154e..b4ca97e07445 100644
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
index 0845061ddc65..ca6e3e2c3c60 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -318,6 +318,7 @@ BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock, KF_RET_NULL)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
+BTF_ID_FLAGS(func, mptcp_subflow_set_avoid)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 70cf9ebce833..3e98125a9c0c 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -49,6 +49,8 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin
 		flags |= MPTCP_SUBFLOW_FLAG_BKUP_LOC;
 	if (READ_ONCE(sf->fully_established))
 		flags |= MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED;
+	if (sf->avoid)
+		flags |= MPTCP_SUBFLOW_FLAG_AVOID;
 	if (sf->conn_finished)
 		flags |= MPTCP_SUBFLOW_FLAG_CONNECTED;
 	if (sf->map_valid)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ffcf5a1788f6..3de919eee3ec 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1582,7 +1582,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 		trace_mptcp_subflow_get_send(subflow);
 		ssk =  mptcp_subflow_tcp_sock(subflow);
-		if (!mptcp_subflow_active(subflow))
+		if (!mptcp_subflow_active(subflow) || subflow->avoid)
 			continue;
 
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
@@ -2501,7 +2501,7 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		if (!__mptcp_subflow_active(subflow))
+		if (!__mptcp_subflow_active(subflow) || subflow->avoid)
 			continue;
 
 		/* still data outstanding at TCP level? skip this */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index da40c6f3705f..b754e26be134 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -584,7 +584,8 @@ struct mptcp_subflow_context {
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
-		__unused : 8;
+		avoid : 1,	    /* pkt scheduler: skip subflow if possible */
+		__unused : 7;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
@@ -897,6 +898,8 @@ static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 
 void mptcp_subflow_set_active(struct mptcp_subflow_context *subflow);
 
+void mptcp_subflow_set_avoid(struct mptcp_subflow_context *subflow, bool avoid);
+
 bool mptcp_subflow_active(struct mptcp_subflow_context *subflow);
 
 void mptcp_subflow_drop_ctx(struct sock *ssk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 1e59072d478c..0b85f1932d57 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -165,6 +165,12 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
 
+__bpf_kfunc void mptcp_subflow_set_avoid(struct mptcp_subflow_context *subflow,
+					 bool avoid)
+{
+	subflow->avoid = avoid;
+}
+
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-- 
2.43.0

