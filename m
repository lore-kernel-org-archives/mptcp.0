Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628694195B5
	for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377634; cv=pass; b=BG8G/M3I159jOrXJ32QdhORjvVm4FVdUbwq9YS4X4BgXTzRSIOsy5hBSI1PxdQio9VRUmY6W5nyyAY8Hc2s7aij1UGTUGfi25hWe60iHjC3scDrYV55YQgc+CQCFRARFL7u+bUOd0q8CNKonAZ+9l9gwRycZe1AiAHSQ0CP12JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377634; c=relaxed/simple;
	bh=1sLHBFlyTfbBE36W9ew9kX6DLDtiFr3vjC/jETscQlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8gebZSaehIIJ4zgVC74VMMpjERfVVdKRb+dMrSsYC/RSoBN35DZ0VDL2jsqhWXpLlUjuBIf/4GntwrzhVxLXJIUeeQq4sRHrxFgWZCStUdac4TMIYKkwjscxHDu43fMe5SwQPzQ77qQeDYxjfVnX0ExjGBqH/eenvqUsAj63PY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=J9zS9Ugl reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.182.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="J9zS9Ugl"
ARC-Seal: i=1; a=rsa-sha256; t=1789377619; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q+Yr2ZI9BwmU1dsgP2T7zAVF4a79s98uiWfuvfI/QLGlfzeT1/VDSQ5yqb6pXiFL5H8nD22JER0fidNcRQk7fuIwrp8dOctLqAgCbE80FGx5oZOeJU1suwcgR3U+O5cjmma7XqWt6yJEjZivwDINHbnQIY2GkxiMWHJB8kxXpxQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789377619; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8kDSA/2A4VevC+5hQraUYgw7nPcvfDueIzTGTkIfGyI=; 
	b=RBjY7qBc2RS9/3fBHaMG8migOY1YmuhAroC8o4yHpivYya5dHz8nLZFhZmP7ZSpBTB5rbVt/xiCKpqSPzs2WOiChO0Uc8DrRjXBRGY3cpkWlO7YO5OlR94vN7pq3zn6wmuZ7IqmNHD80rZ9JJowvswVn6H/TkPJPd8nmKFcAysM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789377619;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8kDSA/2A4VevC+5hQraUYgw7nPcvfDueIzTGTkIfGyI=;
	b=J9zS9UglDGR514O6jNMAF1BQZs6UZx5ueg/k7wv7BX6/hz/bB39jfo4q8erTAfh3
	2ICuvZ8bBxZKA/SCYUrZgrxJN5fWPpX0oP/ML8dDxgIPqFcBOL7xCQuOJw/FP3CQ3MZ
	o9p15bQ7WRZl6o29/TmQ8Qu71nZhqQd7/ncSs09Q=
Received: by smtp.zohomail.com with SMTPS id 1789377617952117.10437647247102;
	Mon, 14 Sep 2026 02:20:17 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com
Subject: [PATCH mptcp-next v4 1/2] mptcp: sched: add subflow avoid flag and enforce it in default sched
Date: Mon, 14 Sep 2026 14:49:59 +0530
Message-ID: <20260914092000.1306968-2-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914092000.1306968-1-kalpan.jani@mpiricsoftware.com>
References: <20260914092000.1306968-1-kalpan.jani@mpiricsoftware.com>
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
   under the msk lock from BPF scheduler context. Bitfield writes are
   a non-atomic read-modify-write on the whole containing word, so
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

Changes since v3:
- moved avoid back out of the __unused bitfield padding into a
  standalone bool, and restored READ_ONCE()/WRITE_ONCE() on every
  access. Sashiko flagged that mptcp_subflow_data_available() clears
  map_valid, a bit in the same bitfield word, without the msk lock
  held, so a scheduler setting avoid under the msk lock could race
  with it and corrupt neighbouring bits via the non-atomic
  read-modify-write. This reintroduces the 4-byte struct hole v2
  removed; correctness takes priority over that optimisation.
- corrected the commit message: avoid is only enforced by the
  default in-kernel subflow picker, not by every custom scheduler
  unconditionally. mptcp_sched_get_send()/_get_retrans() call the
  registered scheduler's own get_send()/get_retrans() directly when
  one is loaded, bypassing mptcp_subflow_get_send()/_get_retrans()
  entirely. A custom scheduler only honours avoid if it checks the
  field itself.

Changes since v2:
- rebased onto the current export tree. v2 was generated against a
  stale local snapshot that predated several unrelated commits
  touching the same bitfield region in mptcp_subflow_context; applying
  v2 there produced a merge conflict in protocol.h.

Changes since v1:
- moved avoid from a standalone bool into the existing __unused
  bitfield padding: the extra bool pushed lent_mem_frag onto a
  4-byte-aligned boundary, adding a 4-byte hole. The bitfield slot was
  already reserved and unused. (Reverted in v4, see above.)
- marked mptcp_subflow_set_avoid() __bpf_kfunc: no C callers, unlike
  set_scheduled(), so it could be dropped under LTO before
  resolve_btfids finds it in BTF.
- mptcp_subflow_get_send() and mptcp_subflow_get_retrans() now skip a
  subflow with avoid set, next to the existing active-subflow check:
  previously nothing in the core consulted the flag.
- exposed avoid via MPTCP diag as MPTCP_SUBFLOW_FLAG_AVOID, next to
  the existing BKUP_LOC/FULLY_ESTABLISHED flags.

v3: https://lore.kernel.org/all/20260831094651.2682660-2-kalpan.jani@mpiricsoftware.com/
v2: https://lore.kernel.org/all/20260824102741.347492-2-kalpan.jani@mpiricsoftware.com/
v1: https://lore.kernel.org/all/20260715101148.2601045-2-kalpan.jani@mpiricsoftware.com/
---
 include/uapi/linux/mptcp.h | 1 +
 net/mptcp/bpf.c            | 1 +
 net/mptcp/diag.c           | 2 ++
 net/mptcp/protocol.c       | 4 ++--
 net/mptcp/protocol.h       | 3 +++
 net/mptcp/sched.c          | 6 ++++++
 6 files changed, 15 insertions(+), 2 deletions(-)

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
index 82b0ad25f700..3a229e28960d 100644
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
index 70cf9ebce833..7a2c40a63dfa 100644
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
index f22d64ab1c53..56c9f1f878fb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1645,7 +1645,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 		trace_mptcp_subflow_get_send(subflow);
 		ssk =  mptcp_subflow_tcp_sock(subflow);
-		if (!mptcp_subflow_active(subflow))
+		if (!mptcp_subflow_active(subflow) || READ_ONCE(subflow->avoid))
 			continue;
 
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
@@ -2563,7 +2563,7 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		if (!__mptcp_subflow_active(subflow))
+		if (!__mptcp_subflow_active(subflow) || READ_ONCE(subflow->avoid))
 			continue;
 
 		/* still data outstanding at TCP level? skip this */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3d250e8204d5..e6135ab87e3e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -589,6 +589,7 @@ struct mptcp_subflow_context {
 		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
+	bool	avoid;		    /* pkt scheduler: skip subflow if possible */
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	bool	fully_established;  /* path validated */
 	u32	lent_mem_frag;
@@ -902,6 +903,8 @@ static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 
 void mptcp_subflow_set_active(struct mptcp_subflow_context *subflow);
 
+void mptcp_subflow_set_avoid(struct mptcp_subflow_context *subflow, bool avoid);
+
 bool mptcp_subflow_active(struct mptcp_subflow_context *subflow);
 
 void mptcp_subflow_drop_ctx(struct sock *ssk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 1e59072d478c..0ce59eb093df 100644
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

