Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D809A3101D8
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 05:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080467; cv=pass; b=bKrWc/RHdcLzp7E9ZcCG7Sbvdch9RE6oMvUYzVbl4LTqCwG2rANWyXwJ9RYohhEr0P0e2tjXsZ1PIBLozSGrV8IgtFg1kLehrsxcpjGLvwxgGLTV4GLIK2JhX8opljZXLGnJT/4iKiEu5/Zz1EFvy8avt5oDWPRyPaSl4UyWq1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080467; c=relaxed/simple;
	bh=6sB1VFoygR8uu9YgQfwGhObgtxZG4J1pwbnv76+z8uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QLcGOjI3vNC/JHwcpBR0BxcME5jeHe4UnTXF/snZ2bdxWVD6GjWELaU85ic1wJKotTe2V+2dniK7LL8vazhj1qY/rR1+S6Jt6bnGYUlmVVOPG841u8ne/scxXb7wl5FcLuSQj+1Kg5hq+uJmi2LSuajdlAYiCqGJTgcXZsnDu4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=uGKrqiBE reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="uGKrqiBE"
ARC-Seal: i=1; a=rsa-sha256; t=1779080459; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OrxyplDDKjzFk8NLMg8VY1VfE14gjgoxJDLgaZYv/gs8CCZ1CiRrXowqtfWYZKuf/PUOuUkGdNpFMzFXybotc/9l2ZE8uaWX/GTIBOy/uZG6DJpWJdUghZv3nNMR0O3LIT4zVt+PWAguwmrSDojsl+zplmI4pIbqizqKa/AHcb0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779080459; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MI2ltPOwBZfuXhlGq+QE704sakg8edAtXqFqRzHvxsk=; 
	b=baA2nwWpblp+amSr1N/y/L0FB5XfVS8m1eJSNwRYXwa6gnNWThinV4XYRZBuFmfWOn3PIl+2f/6nEZFkK2OlY4u7CcGAcySTaiNRKVHBWYpyV5rEx1KIWi2vbjUlnPV4xm5rTfOFFtmUReENY+n+W5+uEqOwEYZUJJNpuS3/p7E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779080458;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=MI2ltPOwBZfuXhlGq+QE704sakg8edAtXqFqRzHvxsk=;
	b=uGKrqiBEer9CGDUD6iceQfmCN21AJyp/dpiTsX5F/U0q7mtKpn51sMl6oCR7xqhR
	kjJ9o5PfEjICZ/Ud3810c8b4NIoZavxnDRbypzI/5q0eZIVt9aaNT6+gZEoIoB1RyUn
	sehN9h1hKhNiFm9l9XrcfeIwyZGou4sUriK1pNNY=
Received: by mx.zohomail.com with SMTPS id 1779080456882407.4574792129248;
	Sun, 17 May 2026 22:00:56 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	shardulsb08@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH net v2] mptcp: prevent stale backlog references to closing subflows
Date: Mon, 18 May 2026 10:30:47 +0530
Message-ID: <20260518050048.161374-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Backlog entries may retain references to a subflow socket through
skb->sk. These references are later cleaned up during subflow teardown.

Currently, backlog cleanup is not synchronized with RX-side backlog
enqueue, which is serialized under mptcp_data_lock(). This allows a
race where teardown misses an skb referencing the subflow socket, and
the stale skb->sk pointer survives after the socket is released.

Later backlog purge may then dereference the stale pointer, leading to
memory accounting warnings in inet_sock_destruct() followed by a
use-after-free in mptcp_backlog_purge().

Prevent this by synchronizing backlog cleanup against RX enqueue while
the subflow is being closed, ensuring no stale skb->sk references
survive teardown.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/621
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Suggested-by: Paolo Abeni <pabeni@redhat.com>

---
v1:
- Detect and clear stale skb->sk references from the MPTCP backlog during subflow teardown to prevent use-after-free in backlog purge.
v2:
- Rework backlog cleanup based on Paolo Abeni's suggestion to serialize cleanup with RX-side backlog enqueue under mptcp_data_lock().
- Move cleanup into __mptcp_close_ssk() while holding the subflow socket lock, ensuring no new backlog skb can retain a reference to the closing subflow after cleanup completes.
- Keep the fallback cleanup path for detached subflows after releasing the subflow socket, preserving correctness for that teardown path.

 net/mptcp/protocol.c | 48 +++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 718e910ff..3dcffe4b5 100644
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
@@ -2540,6 +2556,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 			      unsigned int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
 	bool dispose_it, need_push = false;
 	int fwd_remaining;
 
@@ -2549,6 +2566,22 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	 */
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 	subflow->closing = 1;
+
+	/* Remove any reference from the backlog to this ssk; backlog skbs
+	 * consume space in the msk receive queue, no need to touch
+	 * sk->sk_rmem_alloc. Serialize with mptcp_data_ready() under
+	 * mptcp_data_lock() while the ssk lock is still held, so the
+	 * cleanup is exhaustive: no new skb can be enqueued after this point.
+	 */
+	mptcp_data_lock(sk);
+	list_for_each_entry(skb, &msk->backlog_list, list) {
+		if (skb->sk != ssk)
+			continue;
+
+		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
+		skb->sk = NULL;
+	}
+	mptcp_data_unlock(sk);
 
 	/* Borrow the fwd allocated page left-over; fwd memory for the subflow
 	 * could be negative at this point, but will be reach zero soon - when
@@ -2587,6 +2620,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		__mptcp_subflow_disconnect(ssk, subflow, msk->fastclosing);
 		release_sock(ssk);
 
+		mptcp_cleanup_ssk_backlog(sk, ssk);
 		goto out;
 	}
 
@@ -2641,9 +2675,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
-	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct sk_buff *skb;
-
 	/* The first subflow can already be closed or disconnected */
 	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
 		return;
@@ -2653,17 +2684,6 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
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

