Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119583161AC
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215720; cv=none; b=pfM5h9v7dtx+pfQtICblt3tYpKXJawkBg+nlC48Jbmrv4T5+mW98wYOpw9N38Nq03ZMeQCgVjHI0aTcxr7Fr8a4JIvy9sFkdq+t7lURREOpfpHZ94GfAYdXR9L8pXhbPdI5Sj0nSKOh9zf2BiElv1tQS43rw5W+QrjTjEF8Le88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215720; c=relaxed/simple;
	bh=Kcnh3IB3f3aXnG50sE8Mk7fnAzZaLwhRrM5e/XWqAnE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=LZDV4Wwqsl44FyPnXOGVAcIgKlQAg4CI1Wqo6P7nIyYjV+/G4uIIjscelUo49GUCR5MRBHDoYfEDXrmsflhXKqp4WSeWv3NwD2Cnf8HvuMv2S+rFffnMnLrbu0oP8Y2I9B9q2+ld7QcN2lsS0lxQ7KCb7nLv6EMuOC7hRTu9Eo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dlw5qVD6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dlw5qVD6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758215718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDKbRh5hSHwbALeG12Liz7LnDWI0E7przxPdD0pxMAg=;
	b=Dlw5qVD6DlsoOShqqSbsTu3VXZOQz5BHsMNiKrWc4Jbm6FeR8dOchUoXDpAn5QaA9Yc9b7
	xPZ+P6MREtWtFBvbHiOA0WXtI0KyfSsRnXkII6ufR6iBhpqkngR8PUa3jCLL2Mjc5VEbsX
	QqQEIv9MX/NUQ2m4CRWd1eOVmlPGNNY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-wb4PAYZiPgKqr7-Dr6aS9g-1; Thu,
 18 Sep 2025 13:15:16 -0400
X-MC-Unique: wb4PAYZiPgKqr7-Dr6aS9g-1
X-Mimecast-MFC-AGG-ID: wb4PAYZiPgKqr7-Dr6aS9g_1758215715
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CF5A195605E
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C9E0030002C6
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 08/12] mptcp: cleanup fallback data fin reception
Date: Thu, 18 Sep 2025 19:14:50 +0200
Message-ID: <2f7ce035835dfba0f4b03ea23be74a0bca760b8e.1758214564.git.pabeni@redhat.com>
In-Reply-To: <cover.1758214563.git.pabeni@redhat.com>
References: <cover.1758214563.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nfP8sZlQs7IdXOQn-7-LE9_40tib43L6DgxvJJqTZdU_1758215715
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

MPTCP currently generate a dummy data_fin for fallback socket
when the fallback subflow has completed data reception using
the current ack_seq.

We are going to introduce backlog usage for the msk soon, even
for fallback sockets: the above condition will be not be correct
as it will ignore data_seq sitting in the backlog.

Instead generate the dummy data_fin when the last data packet is
extracted by the fallback subflow.

The scenario with fallback socket receiving a reset while the
receive queue empty is caught via the generic 'all subflows closed'
timeout: ensure such timeout is zero for fallback sockets.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/ctrl.c    |  2 ++
 net/mptcp/subflow.c | 16 ++++++++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index fed40dae5583a..4f7795968abe2 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -74,6 +74,8 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net)
 
 unsigned int mptcp_close_timeout(const struct sock *sk)
 {
+	if (__mptcp_check_fallback(mptcp_sk(sk)))
+		return 0;
 	if (sock_flag(sk, SOCK_DEAD))
 		return TCP_TIMEWAIT_LEN;
 	return mptcp_get_pernet(sock_net(sk))->close_timeout;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e8325890a3223..9baf3e54e46f2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1297,14 +1297,6 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
 
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
 		mptcp_schedule_work(sk);
-
-	/* when the fallback subflow closes the rx side, trigger a 'dummy'
-	 * ingress data fin, so that the msk state will follow along
-	 */
-	if (__mptcp_check_fallback(msk) && subflow_is_done(ssk) &&
-	    msk->first == ssk &&
-	    mptcp_update_rcv_data_fin(msk, READ_ONCE(msk->ack_seq), true))
-		mptcp_schedule_work(sk);
 }
 
 static bool mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
@@ -1437,6 +1429,14 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	subflow->map_data_len = skb->len;
 	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
 	WRITE_ONCE(subflow->data_avail, true);
+
+	/* last skb in closed fallback subflow: we are at data fin */
+	if (subflow_is_done(ssk) && ssk == msk->first &&
+	    skb == skb_peek_tail(&ssk->sk_receive_queue)) {
+		mptcp_update_rcv_data_fin(msk, subflow->map_seq +
+					  subflow->map_data_len, true);
+		subflow->map_data_fin = 1;
+	}
 	return true;
 }
 
-- 
2.51.0

