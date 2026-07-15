Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D279743B6E3
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110337; cv=pass; b=gNKGHlqyBudxIQkG4gug+FLU2Z5x8ZaLwb1XqaqjcTwv42HE3nGdLUkBwT7O9IigZ/atYvsxO0/mk+B8AXjSk3KJkKvn+U5eBmrKewOUoUwCkyEtvcdBfKXsmvaQ9P3lPTW2bfGnd4hG9XPiB9CUcbaE5uwLuj3lhg01uqyoV9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110337; c=relaxed/simple;
	bh=IwR9m2j2add3z/XBeSIajuz4GTbw+bCHTHPBC8eNiUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1C29mNB02JxP4s0Wz2zHyPDtEsSGja07vbSp0KcrH9ikCl2R7DDx7BQMkWNO76zJXtMANJ/2/oeXbFweq9wTrwkcUt0EoUU5OrMwkhczdXi5YISWnQh7/NSyNzxlvGLJNOZ3Uy9i2d6/0lt2etrumLeKt71auZ9L/W0b4KZ2Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=tf+Zm5jx reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="tf+Zm5jx"
ARC-Seal: i=1; a=rsa-sha256; t=1784110325; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZjOdk71SKGhl/cqBqug402D4xdwAwGgUvS9zvZFBNWjq/Crr8tfNDGoddrBXdNjIutQMwJLLw7dSHaU4VIRQxistGOa2trISjQNE/crMllExnedXWnH3hN79X+idOJv/TbRmOQCnl+k/7msfUDG/A8+HnQnD7KgEvDn/G8lI0wo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784110325; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ijw1ShYjQ2W8OgkzFXnqZjzKP6K/NiSscggCXaTVklI=; 
	b=G//n9bewuvPE5ELdKqSNW7xWIqKuUS96c8FJr8D4nRI5oz2f6jbY3VRFbBSFVnMk7ezRPUVLPCJ1TbZX/ltrPDwRiYO+tl6wkp9cS18ofCIyNPlIH/urE5EcsDOV7rla8Lvdd+9wECyc1iAlPsBpjDIIZldtuPprTrJ+Nwjbcfo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784110325;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Ijw1ShYjQ2W8OgkzFXnqZjzKP6K/NiSscggCXaTVklI=;
	b=tf+Zm5jxx/4iexTKyLsotTtXemvN2Z1r5AM+ZnivDRG5l3/InYvCXldnOsU3AjQC
	MKTwZhJOMawmr4moZoLPn47Ujxmro7giGGe092lyJ1xyVagDo7oNEofofAf86NIlVYq
	eM4CMGsf7qFJjdPotSedydzyQvUcTJdlXTpIQRes=
Received: by mx.zohomail.com with SMTPS id 1784110322161139.0277025904428;
	Wed, 15 Jul 2026 03:12:02 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	akshit@mpiricsoftware.com
Subject: [PATCH mptcp-next 1/2] mptcp: sched: add subflow avoid flag and kfunc
Date: Wed, 15 Jul 2026 15:41:47 +0530
Message-ID: <20260715101148.2601045-2-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715101148.2601045-1-kalpan.jani@mpiricsoftware.com>
References: <20260715101148.2601045-1-kalpan.jani@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The core benches a subflow via the "stale" bit after
net.mptcp.stale_loss_cnt retransmission intervals without progress. That
bit is owned by the core and tightly coupled to the RTO: it is cleared
automatically as soon as a packet is acked on the subflow
(mptcp_subflow_active() calls mptcp_subflow_set_active() when rcv_tstamp
advances).

A packet scheduler may want to bench a subflow for unrelated reasons
(too high latency, too unstable) and keep it benched until it decides
otherwise. Reusing the stale bit does not work: the core would clear it
on the next incoming ack.

Add a separate, scheduler-owned "avoid" flag to mptcp_subflow_context:

 - it is never set or cleared by the core, only through
   mptcp_subflow_set_avoid(), exposed to BPF struct_ops schedulers as a
   kfunc, with the same registration and filter as
   mptcp_subflow_set_scheduled() so only schedulers can call it;

 - it lives in the struct_group(reset) block and is therefore cleared
   when the subflow is reset, so a re-established path is re-evaluated.

The flag is scheduler-local state: a scheduler sets it to remember that a
subflow should be skipped, and consults it when picking a subflow to send
on. The core send and retransmit paths are left unchanged.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
 net/mptcp/bpf.c      | 1 +
 net/mptcp/protocol.h | 3 +++
 net/mptcp/sched.c    | 6 ++++++
 3 files changed, 10 insertions(+)

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
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index da40c6f3705f..6485629acd63 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -587,6 +587,7 @@ struct mptcp_subflow_context {
 		__unused : 8;
 	bool	data_avail;
 	bool	scheduled;
+	bool	avoid;		    /* pkt scheduler: skip subflow if possible */
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	bool	fully_established;  /* path validated */
 	u32	lent_mem_frag;
@@ -897,6 +898,8 @@ static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 
 void mptcp_subflow_set_active(struct mptcp_subflow_context *subflow);
 
+void mptcp_subflow_set_avoid(struct mptcp_subflow_context *subflow, bool avoid);
+
 bool mptcp_subflow_active(struct mptcp_subflow_context *subflow);
 
 void mptcp_subflow_drop_ctx(struct sock *ssk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 1e59072d478c..09163f9742b9 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -165,6 +165,12 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
 
+void mptcp_subflow_set_avoid(struct mptcp_subflow_context *subflow,
+			     bool avoid)
+{
+	WRITE_ONCE(subflow->avoid, avoid);
+}
+
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-- 
2.43.0

