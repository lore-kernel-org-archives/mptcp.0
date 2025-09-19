Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1039B31CA72
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297233; cv=none; b=t8NOKEu1Hw+hvqc9ARCItBcMgyeLBkcxceX2AXRFSdvGiW26sUfLFV+WXoCIJh91YuaS4BK+IW5dqlq3aiFLtBVjEtsf/uUrv6+BtYNzb4uN0g2V83Kwo+ybJ9Qa8cR6hNMhMKCbIohHi9fqRSRERyDDQD5kchFzJkHSOlcFTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297233; c=relaxed/simple;
	bh=XuJG5/sJHfin2N+OpNjYOCGv2SEQQwQiIY760zsHBFc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rT5120TjWYf37+56witaYv3KDUF9INMRbcPKaDQdoloqRL/SLjlj3c2fRc6XtSjJudhCTt/qtCjycCZelBGukwIqA8FmafZxQkm9ShAHlsN0eTyFqDVWDaNbkDQu1CebGfnRDS/87S0l0WcgTAEzuA3HdRYLFn0OdcGTyCRr5VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtyoXMvH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtyoXMvH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758297231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJYzfpmni0bBnSsOT+Wc4kDdBSkWFUQzBLXgN+BULkw=;
	b=YtyoXMvHOxKlbrs8Xm22khYt0yfIKbIDrV+P96kltY6xMvj3IKbzbhL71K4xCNWjj/5pbE
	bDE59s7B67J4lVSwiqbwcrC9O+GIvxh91zTj1njsJ6he0FdcUhG18WQxGFij2qnMhrKaVW
	LqXQLt+4qfbKIy0EqcTfKM2p9V8n2b8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-0v_ITWhaN2-NIjWD-0xm5Q-1; Fri,
 19 Sep 2025 11:53:49 -0400
X-MC-Unique: 0v_ITWhaN2-NIjWD-0xm5Q-1
X-Mimecast-MFC-AGG-ID: 0v_ITWhaN2-NIjWD-0xm5Q_1758297229
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E11401800451
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:48 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.255])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0EF0F180035E
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:47 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next v3 08/12] mptcp: cleanup fallback data fin reception
Date: Fri, 19 Sep 2025 17:53:22 +0200
Message-ID: <48b486e75249911cbee4325706622116e3a41a66.1758296923.git.pabeni@redhat.com>
In-Reply-To: <cover.1758296923.git.pabeni@redhat.com>
References: <cover.1758296923.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fc9j5uLDdJ_9A3gMeD_9BiEKhMMsDJwmltyEUkH5Xp8_1758297229
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

MPTCP currently generate a dummy data_fin for fallback socket
when the fallback subflow has completed data reception using
the current ack_seq.

We are going to introduce backlog usage for the msk soon, even
for fallback sockets: the ack_seq value will not match the most recent
sequence number seen by the fallback subflow socket, as it will ignore
data_seq sitting in the backlog.

Instead use the last map sequence number to set the data_fin,
as fallback (dummy) map sequences are always in sequence.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
  - keep the close check in subflow_sched_work_if_closed, fix
    CI failures
---
 net/mptcp/subflow.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e8325890a3223..b9455c04e8a46 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1285,6 +1285,7 @@ static bool subflow_is_done(const struct sock *sk)
 /* sched mptcp worker for subflow cleanup if no more data is pending */
 static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ssk)
 {
+	const struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
 
 	if (likely(ssk->sk_state != TCP_CLOSE &&
@@ -1303,7 +1304,8 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
 	 */
 	if (__mptcp_check_fallback(msk) && subflow_is_done(ssk) &&
 	    msk->first == ssk &&
-	    mptcp_update_rcv_data_fin(msk, READ_ONCE(msk->ack_seq), true))
+	    mptcp_update_rcv_data_fin(msk, subflow->map_seq +
+				      subflow->map_data_len, true))
 		mptcp_schedule_work(sk);
 }
 
-- 
2.51.0

