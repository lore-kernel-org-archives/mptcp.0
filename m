Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC8F2367CF
	for <mptcp@lists.linux.dev>; Mon,  1 Jun 2026 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302665; cv=pass; b=cluU4/mNQa90LLs6bADNX9Nxw1tWwiluU39MezyJFqwV0FlYm6QpRD1SqUFeHWlFqvSOT7+fYCXgeUxjusGEaAnWVnIuo1LW9FRdskQFJEbNqiPKmJjq9m8D4wYrs3lvdmaWJ21qSGJnzHOV6OuWZKXcmJ8MnuOwvXlX61hw/FI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302665; c=relaxed/simple;
	bh=4gr0UiT8SFS9xlf5JzP1QGxKdFto7+DFGJyBHsWmYXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HUnZ9EiIKTLrYTIQXx4kLcB33M1lJ75AffXWITupQB/P1Hw11m3br4umbvMcoO0cgVxiy5GgJ8WkvjN+givAGTRo5es5YE52d4i1VSi7TVyWGFnbzd1/ciEuu6FvBMCiLSA4yisBdCcMw0SVgW6ogl4XHrGSMqlayR58+L11kdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=VsTIMGOn reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="VsTIMGOn"
ARC-Seal: i=1; a=rsa-sha256; t=1780302658; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GKX6FcLXhnP9PmN519EaiyQHjhQNhMWv29N+3V/G8AX2rLwfsr3bO5zWuW2Ta1AzbXLXE9kaTka1y9Ec4clK7U9t5YYr9/g0X4l4iS/FSHrDoKSucCIRNpwecx1oBh0I3Q67iciiKbanYUF2mzwarDXpQTHr0Ar1sqEZkdU+yPo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780302658; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=krr885sZSbRLGmiHMX77sJfLxIZNMo1ueE3a+pAE8bo=; 
	b=RWZLGHonHFVWxYuP8CVEkke3XmOApj1QRHjoZV4J66/nqmRKq5dKnuqMC50YThmTbeoEOKZ5XnfTD2CbsrDx8iCksP+ZlnokOWfAKJDr2UjzE9SwfVCvfHMkT+1EyUFjCsCJew2Nr3C9jw5RZX1rrs28e+CybcW6Lcl3isUr4v4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780302658;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=krr885sZSbRLGmiHMX77sJfLxIZNMo1ueE3a+pAE8bo=;
	b=VsTIMGOnaK3qjLLyCtTmFfMAHjhmTf230OCGQTYzf84x4PAtRTH2tHlDggCVPu4H
	BweK7aiW2Hkw2WEfCdQq8pRQPkC53Ck+mkZAqYnFLZufGgNEjhQ2GYqcxHzpllWXb4v
	MSIVpIQ2y6byswAsNKy1TJKCeH16hcSBXyTtUqXo=
Received: by mx.zohomail.com with SMTPS id 1780302654242846.8653708396714;
	Mon, 1 Jun 2026 01:30:54 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	shardulsb08@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
	Paolo Abeni <pabeni@redhat.com>,
	syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH net v4] mptcp: fix stale skb->sk reference on subflow close
Date: Mon,  1 Jun 2026 14:00:10 +0530
Message-ID: <20260601083010.924938-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The backlog list is updated by mptcp_data_ready() under
mptcp_data_lock(). The cleanup of backlog references to a closing
subflow, however, was performed in mptcp_close_ssk(), before
__mptcp_close_ssk() acquires the ssk lock, and while holding neither
the ssk lock nor mptcp_data_lock().

Because that traversal ran without mptcp_data_lock(), concurrent softirq
RX processing on another CPU (subflow_data_ready() -> mptcp_data_ready()
-> __mptcp_add_backlog(), under mptcp_data_lock()) could add a backlog
entry referencing the ssk while the cleanup loop was in progress. Such
an entry could be missed by the cleanup, or the concurrent list update
could corrupt the traversal, leaving skb->sk pointing at the ssk after
it is freed.

A later mptcp_backlog_purge() then dereferences the stale pointer,
triggering a warning in inet_sock_destruct() (ssk->sk_rmem_alloc != 0)
followed by a use-after-free in mptcp_backlog_purge().

Fix this by moving the backlog cleanup into __mptcp_close_ssk(), after
subflow->closing is set to 1 and while the ssk lock is still held,
serialized under mptcp_data_lock(). The cleanup runs only on the push
path (MPTCP_CF_PUSH), where backlog references accumulate; on other
teardown paths the caller already handles cleanup.

With subflow->closing set and mptcp_data_lock() held across the purge,
any concurrent mptcp_data_ready() either completes its enqueue before
the purge runs and is caught, or observes closing=1 and bails out. Once
mptcp_data_unlock() is reached, no new skb referencing the ssk can be
enqueued, so the cleanup is exhaustive.

Remove the unprotected traversal from mptcp_close_ssk() entirely.

Tested with the MPTCP kernel selftests on the patched kernel:
- tools/testing/selftests/net/mptcp/mptcp_join.sh: all tests pass
- tools/testing/selftests/net/mptcp/mptcp_connect.sh: 68/68 pass

Fixes: ee458a3f314e ("mptcp: introduce mptcp-level backlog")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reported-by: syzkaller <syzkaller@googlegroups.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/621
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
 net/mptcp/protocol.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4546a8b09884..37efcea99dc1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2527,6 +2527,22 @@ static void __mptcp_subflow_disconnect(struct sock *ssk,
 	}
 }
 
+static void mptcp_cleanup_ssk_backlog(struct sock *sk, struct sock *ssk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+
+	mptcp_data_lock(sk);
+	list_for_each_entry(skb, &msk->backlog_list, list) {
+		if (skb->sk != ssk)
+			continue;
+
+		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
+		skb->sk = NULL;
+	}
+	mptcp_data_unlock(sk);
+}
+
 /* subflow sockets can be either outgoing (connect) or incoming
  * (accept).
  *
@@ -2550,6 +2567,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 	subflow->closing = 1;
 
+	if (flags & MPTCP_CF_PUSH)
+		mptcp_cleanup_ssk_backlog(sk, ssk);
+
 	/* Borrow the fwd allocated page left-over; fwd memory for the subflow
 	 * could be negative at this point, but will be reach zero soon - when
 	 * the data allocated using such fragment will be freed.
@@ -2641,9 +2661,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
-	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct sk_buff *skb;
-
 	/* The first subflow can already be closed or disconnected */
 	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
 		return;
@@ -2653,17 +2670,6 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 
-	/* Remove any reference from the backlog to this ssk; backlog skbs consume
-	 * space in the msk receive queue, no need to touch sk->sk_rmem_alloc
-	 */
-	list_for_each_entry(skb, &msk->backlog_list, list) {
-		if (skb->sk != ssk)
-			continue;
-
-		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
-		skb->sk = NULL;
-	}
-
 	/* subflow aborted before reaching the fully_established status
 	 * attempt the creation of the next subflow
 	 */
-- 
2.43.0

