Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A070D2DEA9D
	for <mptcp@lists.linux.dev>; Thu,  7 May 2026 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778138903; cv=pass; b=Q1xlxwuIOpPQbdVBOMIfNfJW6tdIA7ZieTVeQrebiH+qV0k22Bb6VmvSkO0qmaVAxHMNj4byx1GgueSpSIa73BOS/F+/XOtd4aJbOAJ7Mn11tefeYX49XERf9LnrSPRSDfrqHDlp4Gy/FkZa7uwoknyi2o3pNYOBWwjmseNOJXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778138903; c=relaxed/simple;
	bh=TCRmuExTfLETreVxmsAnbi6E0acKYtfNtUPhlE1yn7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WOviW2+BXemaQWH+Izx0fN8danYktMEJ/N8nIfd9Y39w/nW7JGYSk1ktFpwo51eJEKprgIrzXtaUXyASXKvYfSY98XvNCUNVyjFg5hh7x8b6LFIouv0sF1jrp4isPrDryFzvFEzFifIlrUZQUySucEW3A2ByADkw2vR0sVlBrCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=UTRjS/7Z reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="UTRjS/7Z"
ARC-Seal: i=1; a=rsa-sha256; t=1778138895; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cA1aG1egAVm1Hd19ns1w68wn3QuAjGXjGwjfJ6MWR4/h523i0+FJtIbkGvhDJjRpW9OchTr+ik0zenCtZlj4i+8TQzY6akl+7V4lj8wdYStF5oVgnOD9KVI2SgzSjbDq/Dm02EWKS1mKtQ6Tnjmy8fv3ye4y9EA5hZWUC3Ex2GQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778138895; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QiJVXgyayyHMLKMZWZK+mVkIdqGHeFdd2k+GP/rQTfc=; 
	b=QFewyrJw4VYoKB8Q3ZvqZFnsWk/T7b9MmLqH5vECOxm65lPoftmANTN4mOZ0vX0QWCURtw/o/0wyClQ/k4rOtM2TGTgcrfq70VMavbVMkPDCHfxK12oBDBBi3JqAQ5F9aT06JzkkKG2J9m6TRvsOafLnUBZiPp2TUhxrfYTX9EI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778138895;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QiJVXgyayyHMLKMZWZK+mVkIdqGHeFdd2k+GP/rQTfc=;
	b=UTRjS/7Zu+5hmDoWo6p2Y0KZAfVWRWiwVGlmJsBCkvxqJXVEYMDpn28TpQHb13s+
	T2xPCLIzCnCtvKQrtJD0cqeDnCvt5bkcFLGRWUZYsSPkD1flyCk9gd3LZqcG3Zn/Lce
	Z5p4m5IwcHabVACFX8bsl2pGqan/Vq+40sIiqd/Q=
Received: by mx.zohomail.com with SMTPS id 177813889302023.93978241630691;
	Thu, 7 May 2026 00:28:13 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: matttbe@kernel.org,
	martineau@kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	shardulsb08@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH] mptcp: serialize subflow->closing with RX path
Date: Thu,  7 May 2026 12:58:02 +0530
Message-ID: <20260507072802.612125-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

There is a race between mptcp_data_ready() (RX path) and
mptcp_close_ssk() (teardown path) when accessing subflow->closing.

Currently, mptcp_data_ready() checks subflow->closing before acquiring
mptcp_data_lock(), while mptcp_close_ssk() may concurrently set
subflow->closing and purge backlog entries. This creates a classic
time-of-check vs time-of-use (TOCTOU) race:

  CPU A (close path)              CPU B (RX path)
  ----------------------         -------------------------
  set closing = 1
                                 read closing == 0
  purge backlog
                                 enqueue skb to backlog

As a result, skb entries referencing the subflow socket (ssk) may be
enqueued after the subflow is marked closing and scheduled for cleanup.
This can lead to:

  - WARN in inet_sock_destruct() due to non-zero sk_rmem_alloc
  - potential use-after-free via stale skb->sk references

Fix this by serializing both the closing check and backlog enqueue
under mptcp_data_lock(). This ensures that subflow->closing state and
backlog operations are observed atomically, preventing new skb from
being enqueued once teardown begins.

Also protect backlog cleanup in mptcp_close_ssk() with the same lock
to guarantee mutual exclusion with the RX path.

This restores proper synchronization between RX and teardown paths
and prevents stale skb references to closing subflows.

Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
 net/mptcp/protocol.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 718e910ff..295f8e1c0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -910,14 +910,34 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	/*
+	 * The close path can set subflow->closing while we are racing
+	 * from BH context here. The old check was done before taking
+	 * mptcp_data_lock(), leaving a TOCTOU window:
+	 *
+	 *   CPU A: close path sets closing = 1 and purges backlog
+	 *   CPU B: already observed closing == 0 and later enqueues skb
+	 *
+	 * That skb keeps skb->sk == ssk and can later trigger:
+	 * - WARN in inet_sock_destruct() (ssk->sk_rmem_alloc != 0)
+	 * - UAF in backlog purge via stale skb->sk
+	 */
+
 	/* The peer can send data while we are shutting down this
 	 * subflow at subflow destruction time, but we must avoid enqueuing
 	 * more data to the msk receive queue
 	 */
-	if (unlikely(subflow->closing))
-		return;
 
 	mptcp_data_lock(sk);
+
+	/* Serialize closing check with backlog enqueue */
+	if (unlikely(subflow->closing)) {
+		mptcp_data_unlock(sk);
+		return;
+	}
+
 	mptcp_rcv_rtt_update(msk, subflow);
 	if (!sock_owned_by_user(sk)) {
 		/* Wake-up the reader only for in-sequence data */
@@ -2653,9 +2673,12 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 
-	/* Remove any reference from the backlog to this ssk; backlog skbs consume
+	/* Remove any reference from the backlog to this ssk.
+	 * Serialize cleanup with RX-side enqueue using mptcp_data_lock().
+	 * Backlog skbs consume
 	 * space in the msk receive queue, no need to touch sk->sk_rmem_alloc
 	 */
+	mptcp_data_lock(sk);
 	list_for_each_entry(skb, &msk->backlog_list, list) {
 		if (skb->sk != ssk)
 			continue;
@@ -2663,6 +2686,8 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
 		skb->sk = NULL;
 	}
+	mptcp_data_unlock(sk);
+
 
 	/* subflow aborted before reaching the fully_established status
 	 * attempt the creation of the next subflow
-- 
2.43.0
