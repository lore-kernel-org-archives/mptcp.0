Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE15D34F49F
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966344; cv=pass; b=OeGU0YP5P0CJpMNWEihz7iakKT2XRAHNlJpLdrIp0eB2ZrKCHS7xjd3u6X6GJNfKlMbNEXdSqIMEqKom2JepjFAMItagNo+WQrEKlyDCiW77YXCfuz6f6OpgtlSuRIqXrLB9OYWIWe8veu8BL5pSqKdj/pz0OyZYYcU/p55RWDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966344; c=relaxed/simple;
	bh=jTpmFWiyM7AcRnvv1obk6l2wwaIcmWwpL6OFXCQjzVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=priNXBiX/fWhki+86yspXF3EQDIvMwtuApwRYMAmmt7b4pj3ELY6sndyybFHrid6E5IBj180VqmBp9D85H8GkMzKBbD55INvQimtDKikC98kR/4lz17az9coYDavfBUvdesnKG5dAQgrVdfvJj7q/kiWa1zOvr2/qS++rm1rDmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=cIKeBzRQ reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="cIKeBzRQ"
ARC-Seal: i=1; a=rsa-sha256; t=1786966336; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CSAvJJeR7o1tTODVnKnx1fCoPI64uUQcgMtUEIOnZXdG00huTshX0pH+vXyKSTZougUxp3PIL50eDfLJcKeuiV7Gt7c8U4T4VVsdNnaRLUp1tQB7xauydlkQ7ZYy6tFaArogOmIrfgCiUN/gV8oEodDsEOClIGXAnlLCB4Dbt2M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786966336; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6/jgFhx4OPrKV4I47cGQeYD4qkJtqNBuH/npqFRh7QI=; 
	b=npCkqa0+zxgn99PocTrcyZBJ3W+8g1eADhUep+lRGsfNrdpbKZxUqjt6sNjay75kpDYArWkxY+hvnUy7ertMYcH70XkDL1fdFaL/6gpCDGqd+v9XvQRW5MGwedPM2OJXRAqWUE9LcbHOQDipgzV8HY7rosFUW2HEI6AgD/p4tQY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786966336;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6/jgFhx4OPrKV4I47cGQeYD4qkJtqNBuH/npqFRh7QI=;
	b=cIKeBzRQuOWC6jrcI4hjiUIGjxT6bmQUUi3w7kTjhFL9jqmPcJX4kaMp20PTgo1w
	/f/Ni6I3m51xpfXWnNCQ2z4tkEqLP4wuovTc6IhPdCa8SWDio82oJSuxwMDDpBZqB7E
	3N6RfsY3AUr0hwEAZiYJDmjHqqad5iMBN7I46CAM=
Received: by mx.zohomail.com with SMTPS id 1786966332898118.89738306234233;
	Mon, 17 Aug 2026 04:32:12 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH mptcp-net v4] mptcp: bpf: don't expose bpf_skc_to_mptcp_sock() to tracing progs
Date: Mon, 17 Aug 2026 17:02:02 +0530
Message-ID: <20260817113202.1832692-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

bpf_mptcp_sock_from_subflow() can be reached from tracing programs
via bpf_skc_to_mptcp_sock() on any socket, with no subflow lock held.
It assumes sk_is_mptcp(sk) means ->conn is a valid pointer to the
parent mptcp_sock, but that's not true during fallback, init, the
passive MPC path in subflow_syn_recv_sock(), and subflow teardown -
a lockless reader can hit a NULL ctx, a NULL ->conn, or a freed one.

sock_ops and cg_sockopt, the other two places this helper is
reachable from, always hold the subflow lock, so they don't have
this problem.

Drop it from tracing_prog_func_proto(), as suggested by Paolo.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Fixes: 3bc253c2e652 ("bpf: Add bpf_skc_to_mptcp_sock_proto")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/622
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---

Changes in v4:
- Instead of hardening the lockless read (rcu_dereference/acquire-
release/SOCK_RCU_FREE from v3), just drop tracing's access to the
helper, per Paolo. sock_ops and cg_sockopt already hold the subflow
lock so they're not affected, and nothing in-tree uses this from a
tracing program anyway. Patch is now a 2-line removal in
kernel/trace/bpf_trace.c, everything else from v3 is dropped.

Changes in v3:
- Fix the publish race in subflow_syn_recv_sock() that v2 missed
(Sashiko): the passive MPC path stored the freshly cloned parent into
->conn with a plain assignment on an already-hashed child. Publish with
smp_store_release() and pair the helper read with smp_load_acquire(), so
a lockless reader observing a non-NULL ->conn also sees the initialised
parent.
- Clear ->conn before sock_put() in mptcp_subflow_drop_ctx() too, not just
subflow_ulp_release(): it had the same stale-pointer teardown pattern.
- Audited the SOCK_RCU_FREE change: __mptcp_destroy_sock() does all msk
teardown before the final sock_put() and shares mptcp_destroy_common()
with the already-RCU-freed listener, so deferring the free is safe.

Changes in v2:
- Lockless access fixes (Li Xiasong): load the subflow context with
rcu_dereference_check() instead of a plain dereference, and read ->conn
once.
- Fix the teardown use-after-free that v1 did not address: clear ->conn
before dropping the parent reference in subflow_ulp_release(), and give
the parent msk RCU-grace lifetime via SOCK_RCU_FREE.
- Stop exposing the helper to sleepable BPF programs, where classic RCU
gives no lifetime guarantee.

v1: https://lore.kernel.org/all/20260612072643.2313900-1-kalpan.jani@mpiricsoftware.com/
v2: https://lore.kernel.org/all/20260626125058.868855-1-kalpan.jani@mpiricsoftware.com/
v3: https://lore.kernel.org/all/20260629105020.1670781-1-kalpan.jani@mpiricsoftware.com/

 kernel/trace/bpf_trace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 82f8feea6931..43a5517fde47 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1745,8 +1745,6 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_skc_to_udp6_sock_proto;
 	case BPF_FUNC_skc_to_unix_sock:
 		return &bpf_skc_to_unix_sock_proto;
-	case BPF_FUNC_skc_to_mptcp_sock:
-		return &bpf_skc_to_mptcp_sock_proto;
 	case BPF_FUNC_sk_storage_get:
 		return &bpf_sk_storage_get_tracing_proto;
 	case BPF_FUNC_sk_storage_delete:
-- 
2.43.0

