Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2691F4E34
	for <mptcp@lists.linux.dev>; Mon, 27 Oct 2025 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577118; cv=none; b=T991/XeSFbBqFlhzoMt4HDYh/a/XnR7cwfovxpl+Bo8kLDPVy5TmlFMagIrWwUVhkUOLN03nMn/Lu/bGsChvQL5TiAYr+YPKSBkseiRyF5OW1EdMasrvmDbgiQCo0hmdYwDh8e7CToSVqC9w4J9JK0RP6S4ktxwCnBBQ3intRv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577118; c=relaxed/simple;
	bh=sNkaqU5h/Yp4WgAY63jsWZdNg0tALq4lhdYGKoN+IB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=fenCp+mkSCCu9SfOJSxXyQU9h7YtevLxETTbpj1ZK0wL+AoxEUXFgMeK4xSfkuHGSR95m9NYRy45dU/aXofWQiGjkuUtUbazH5uHhDGyHSJKPNeJdMdro2/3lrK/lpebvttoLC+HaZWpH6m1patfEt0VLDw4cShdcHJp4+fnxqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h+YjPPwm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+YjPPwm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761577115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3BX4HU2AUYk/Z/zbwLBbvkzZ9CJMg/EDsNpMW6dzK6M=;
	b=h+YjPPwmTTLpo7qulbhZ1OVy7SLmkONiHmL3Al3NVI9V2rn8ORfSUeXhMWjo3LQeKywVbD
	BSfUhsge14NPjwMDEhOKPKbuhhalDyGQPki56OB808MWeuE0EkIR6fBBUWOxgAyxb45Jxu
	rFJpS3EMzUuxlRLHSD3eU4AsiCvFbxY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-s7_EDLDLNGihsdS3VBFh0g-1; Mon,
 27 Oct 2025 10:58:32 -0400
X-MC-Unique: s7_EDLDLNGihsdS3VBFh0g-1
X-Mimecast-MFC-AGG-ID: s7_EDLDLNGihsdS3VBFh0g_1761577111
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88A1718002C0;
	Mon, 27 Oct 2025 14:58:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2831919560AD;
	Mon, 27 Oct 2025 14:58:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	geliang@kernel.org
Subject: [PATCH RESENT v7 mptcp-next 1/4] mptcp: handle first subflow closing consistently
Date: Mon, 27 Oct 2025 15:57:59 +0100
Message-ID: <b6e277b9987659459f76909eba224cd46e954758.1761576117.git.pabeni@redhat.com>
In-Reply-To: <cover.1761576117.git.pabeni@redhat.com>
References: <cover.1761576117.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M7hly-iqDGBYz_4gVBM1PCUdqdurosNtXbnqPMxXso8_1761577111
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
index f4e3d0be7c87..74be417be980 100644
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
@@ -2429,6 +2429,13 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
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
@@ -2439,7 +2446,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		/* ensure later check in mptcp_worker() will dispose the msk */
 		sock_set_flag(sk, SOCK_DEAD);
 		mptcp_set_close_tout(sk, tcp_jiffies32 - (mptcp_close_timeout(sk) + 1));
-		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 		mptcp_subflow_drop_ctx(ssk);
 		goto out_release;
 	}
@@ -2448,8 +2454,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
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

