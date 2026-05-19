Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C1D3E1682
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182578; cv=pass; b=dKrn7NyywV55e5f6E0HgAPtmkdKJETzEJhIkcirDv8I9YtNIkB9n71R+8Yl2L+TRyG6fVsImYwoo1CbD8OOLT5vGvRjUxrm4dvNhJz+OI4g7IS8fGBK7GuJP9GYRpttcZ6sZHBjXEgUhBjhj34XvxglIsie6mi6ICAIRy5bwyjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182578; c=relaxed/simple;
	bh=wU0qE6m9P0gxPJb6FjWJFmlHU+s0D0DdWtTkKm6q2VE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LX1UF6LK5jhd/2m06CZKuMBXwWNZGyEg91BZTUuuLujKRW2UzxBUMqIN3J706Yr779lEdQSipbjJ+PD/vis8GiYRziVIST36DQHgYA2hWt3H4eZFpj61QJWS5ZptwvH7ecF5AncIyKPSSKHCU1bxCMXzMO3az0dxncusr7nkcdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=UDuzbKaG reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="UDuzbKaG"
ARC-Seal: i=1; a=rsa-sha256; t=1779182573; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a/Q3ggJvthX0SY5qN7a81yP27F4UjVUvNYWfUKYD+PS3wfSQvIhL2syyfXP5m1IOax87vizaCFiX/AkIkEeOSgJ+6WZEWm+oKJwDxl0YUmNKJJVZ56bA2IgTPoN7aVfU0W/HN0bWvD/W3y4CsdidVDTJoEyiA/z5uaWjafP6uxU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779182573; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ShdX3YSyo2pK+lqtZfrstucHxHovhim0hgl2kks47qM=; 
	b=CJEi1Gs9ZIy0cbk8+NTBcnhlzarj0NxLhIxvbcvTRL1xCflKGCtIYvlsD2x3/1PJyuiyA6H5AOGRo4n2bg02PBiD8ZYrK+JqqnHPBW08nq7qVe0kER6brnWQvDcvlfH+Kj3AibTLCZF1l0awTl4RhvrsolWctY2eIOS9A00scfI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779182573;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ShdX3YSyo2pK+lqtZfrstucHxHovhim0hgl2kks47qM=;
	b=UDuzbKaGZe7FEqzRA6IRaZop+RXBaZNZRKlk8B/fJskUQohqjd2DpNEOB/7jrUKz
	lK8qBYmdbXUzKGKL9Hodw5juKoj+zZrtOCAOVh3x3NKFntjljM7X8+KpEGA+/39WrO0
	C4K595/f0YhfM1QslDU/4xq44LsbPtfKKfqM+Q9E=
Received: by mx.zohomail.com with SMTPS id 1779182571666550.4987664006346;
	Tue, 19 May 2026 02:22:51 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	shardulsb08@gmail.com
Subject: [PATCH net v3] mptcp: fix stale skb->sk reference on subflow close
Date: Tue, 19 May 2026 14:52:43 +0530
Message-ID: <20260519092243.1242351-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The backlog list is updated by mptcp_data_ready() under
mptcp_data_lock(), but the cleanup of references to a closing subflow
in mptcp_close_ssk() was done after release_sock(ssk) without holding
that lock.

Once release_sock(ssk) returns, the RX path can acquire the ssk lock,
call mptcp_data_ready(), and enqueue a new skb under mptcp_data_lock()
before the close path reaches its list_for_each traversal. That skb is
missed by cleanup, leaving skb->sk pointing to the freed ssk.

Fix this by moving the backlog cleanup into __mptcp_close_ssk(), after
subflow->closing is set to 1 and while the ssk lock is still held,
serialized under mptcp_data_lock(). The cleanup runs only on the push
path (MPTCP_CF_PUSH), where backlog references accumulate; on other
teardown paths the caller already handles cleanup.

With both locks held simultaneously, any concurrent mptcp_data_ready()
either completes its enqueue before the purge runs and gets caught, or
observes closing=1 while the ssk lock is still held and bails without
enqueuing. After mptcp_data_unlock(), no new skbs can be enqueued.
The cleanup is exhaustive.

Remove the unprotected traversal from mptcp_close_ssk() entirely.

Tested with the MPTCP kernel selftests on the patched kernel:
- tools/testing/selftests/net/mptcp/mptcp_join.sh: all tests pass
- tools/testing/selftests/net/mptcp/mptcp_connect.sh: 68/68 pass

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reported-by: syzkaller <syzkaller@googlegroups.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/621
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
v3: follow Paolo's suggestion exactly — use mptcp_cleanup_ssk_backlog() helper under MPTCP_CF_PUSH condition only; remove inline loop duplication and second call from !dispose_it path.
v2: moved cleanup into __mptcp_close_ssk() but duplicated logic and added redundant second call; incorrect approach.
v1: incorrect race analysis around subflow->closing flag.

 net/mptcp/protocol.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 718e910ff..149f816fe 100644
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
@@ -2550,6 +2566,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 	subflow->closing = 1;
 
+	if (flags & MPTCP_CF_PUSH)
+		mptcp_cleanup_ssk_backlog(sk, ssk);
+
 	/* Borrow the fwd allocated page left-over; fwd memory for the subflow
 	 * could be negative at this point, but will be reach zero soon - when
 	 * the data allocated using such fragment will be freed.
@@ -2641,9 +2660,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
-	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct sk_buff *skb;
-
 	/* The first subflow can already be closed or disconnected */
 	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
 		return;
@@ -2653,17 +2669,6 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
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

