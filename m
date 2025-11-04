Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ACB28032D
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271965; cv=none; b=M9i1bpC7zOoVziq5wDg8kikE02jGda2jG6btlcOybPF4eRsd1RVXd8ipEO0qeduPGWhBTu94BS6U8TSZ2WILbC+gXeQ5fB0TTCg4ODRcMiWdzDCpA1Lee6DypQpHwDvLZwBbK/VTHosghclIYITK+D6epsTQMOr+NH9fmG5tdAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271965; c=relaxed/simple;
	bh=APowSCFY/y88QKi4pr5g8/0V/a6QFZcL2u0ze0hBmAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=HyFoDsoXvl/eyNEcaZJyU3UwvbQHefxN1bIYsc5H6gC+lHypP+OHd6dIpbO+npzN/TEIgyEPjvZfIHNIHWQGDe218iP1X3pZcvBvZSkU6WD5U68hig+l3jqzpidsbnRSZ8jX9UzVemcW87wG4MrMqCVEbfGNM17llNQKZ3nz/q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MnaoxEwO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnaoxEwO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762271962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJXo/Md/4Hl5pvjgUtejckAebv4YkT+a5OgknFkwbA0=;
	b=MnaoxEwOS33TjRLhAXWLnxPOZ5jjnpQTOMBAgXgkTtZPC6wcUW2OqXfvsFPnNHEZozPcWw
	pRq/JeJjd/VZOHEp5dJQBnfWsC11PVcUzFfpMcZKeqAUQ/eocKrTkKr7n9AKikicTgl+y1
	727+gWrtJqg4+29qkwxIgUFB+uNSh9g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-txP5NJyQPkO3IK15uDqyfA-1; Tue,
 04 Nov 2025 10:59:19 -0500
X-MC-Unique: txP5NJyQPkO3IK15uDqyfA-1
X-Mimecast-MFC-AGG-ID: txP5NJyQPkO3IK15uDqyfA_1762271958
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61CD61954197;
	Tue,  4 Nov 2025 15:59:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.199])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B8CD1800451;
	Tue,  4 Nov 2025 15:59:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
Subject: [PATCH mptcp-next v8 1/4] mptcp: handle first subflow closing consistently
Date: Tue,  4 Nov 2025 16:59:01 +0100
Message-ID: <977fc494e8237ad11d5f9b827a036d33cabbe82e.1762271864.git.pabeni@redhat.com>
In-Reply-To: <cover.1762271864.git.pabeni@redhat.com>
References: <cover.1762271864.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l4wCVejh6oF-iZnkxaLD3t5NGiwg7ZNZNom8LbgIsao_1762271958
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently, as soon as the PM closes a subflow, the msk stops accepting data
from it, even if the TCP socket could be still formally open in the
incoming direction, with the notable exception of the first subflow.

The root cause of such behavior is that code currently piggy back two
separate semantic on the subflow->disposable bit: the subflow context
must be released and that the subflow must stop accepting incoming
data.

The first subflow is never disposed, so it also never stop accepting
incoming data. Use a separate bit to mark to mark the latter status
and set such bit in __mptcp_close_ssk() for all subflows.

Beyond making per subflow behaviour more consistent this will also
simplify the next patch.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 14 +++++++++-----
 net/mptcp/protocol.h |  3 ++-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e2cb3cfbcdae..6eb21584b1c8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -842,10 +842,10 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	/* The peer can send data while we are shutting down this
-	 * subflow at msk destruction time, but we must avoid enqueuing
+	 * subflow at subflow destruction time, but we must avoid enqueuing
 	 * more data to the msk receive queue
 	 */
-	if (unlikely(subflow->disposable))
+	if (unlikely(subflow->closing))
 		return;
 
 	mptcp_data_lock(sk);
@@ -2430,6 +2430,13 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool dispose_it, need_push = false;
 
+	/* Do not pass RX data to the msk, even if the subflow socket is not
+	 * going to be freed (i.e. even for the first subflow on graceful
+	 * subflow close.
+	 */
+	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	subflow->closing = 1;
+
 	/* If the first subflow moved to a close state before accept, e.g. due
 	 * to an incoming reset or listener shutdown, the subflow socket is
 	 * already deleted by inet_child_forget() and the mptcp socket can't
@@ -2440,7 +2447,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		/* ensure later check in mptcp_worker() will dispose the msk */
 		sock_set_flag(sk, SOCK_DEAD);
 		mptcp_set_close_tout(sk, tcp_jiffies32 - (mptcp_close_timeout(sk) + 1));
-		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 		mptcp_subflow_drop_ctx(ssk);
 		goto out_release;
 	}
@@ -2449,8 +2455,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (dispose_it)
 		list_del(&subflow->node);
 
-	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
-
 	if ((flags & MPTCP_CF_FASTCLOSE) && !__mptcp_check_fallback(msk)) {
 		/* be sure to force the tcp_close path
 		 * to generate the egress reset
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cd6350073144..9f7e5f2c964d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -536,12 +536,13 @@ struct mptcp_subflow_context {
 		send_infinite_map : 1,
 		remote_key_valid : 1,        /* received the peer key from */
 		disposable : 1,	    /* ctx can be free at ulp release time */
+		closing : 1,	    /* must not pass rx data to msk anymore */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
-		__unused : 9;
+		__unused : 8;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
-- 
2.51.0

