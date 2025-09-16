Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ACF374279
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040064; cv=none; b=PJCzD705rd9jHImzdqSJuhh45Q4A3DIOgSEH3iWCK06tJ0FCdDy+dbr34yHlE0xJNqYpeYfKi1sNxPa0H2TrcL2VNtL1RkHJOPPYiux+4rz5iiLZu6/xqZLjIvBzR54Zj9wn8fokooEMmpKvxtuDZnoFWLPDHGekppJtr8EEXN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040064; c=relaxed/simple;
	bh=BIJ8IVHYsAVzv8+xsF+ojFBqIaY5kmu6LjJkLZMWlvw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=NWYJDrew70KEkB4psNgKZGlT+VhizjB9ZIzJ2ksilsN0WqKNwFBgqzgcjFubGM0r8TKNGEiLwcRJ5yybPt5d1Si/8Qh/PkAFNkM8fRFJ1IYJA8urNFJ855EcPH+mggCOjbPIwdS4n6gwJ8h0aAj8dM6sNVDSvLca6z0HiTfKOdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DZ7G5r4U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZ7G5r4U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758040061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDUcih6KYkyyo6nbKLPecOvpIZ7zrypSdMPS6+Z6AbU=;
	b=DZ7G5r4UVaYSIPlnVqdNOnyrs2+TvBkqEGh/n37AG47QDX525Ad9Uta2eu5io4x/ojIWu7
	NkZzs8rh5GHuG1hF35hE7ptbYJRuoQI3Nd+kn41DJC2uv7+Rkwl8JevHLXgXqexXgpud5A
	h8tvKWxWVDLZWoJxG8LKw42yRUvelsg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-xr8e80JUOjyIHYc4pGf_7g-1; Tue,
 16 Sep 2025 12:27:40 -0400
X-MC-Unique: xr8e80JUOjyIHYc4pGf_7g-1
X-Mimecast-MFC-AGG-ID: xr8e80JUOjyIHYc4pGf_7g_1758040059
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41D60180034D
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.160])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6BE2E19560B8
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next 08/12] mptcp: cleanup fallback data fin reception
Date: Tue, 16 Sep 2025 18:27:18 +0200
Message-ID: <a7c435489c49ccf587bbd7fcebae845accdd8ac0.1758039775.git.pabeni@redhat.com>
In-Reply-To: <cover.1758039775.git.pabeni@redhat.com>
References: <cover.1758039775.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b8UEdpYEDbHChGYHFiGeEEjZgeXwA-jX8_X6LwLxXcI_1758040059
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
receive queue empty is catched via the generic 'all subflows closed'
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
index c8a7e4b59db11..5339a00528a7a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1293,14 +1293,6 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
 
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
@@ -1433,6 +1425,14 @@ static bool subflow_check_data_avail(struct sock *ssk)
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

