Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEA2525D
	for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 10:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679654092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tIw/VtFfVdg6nQUM/kSfBPQv2hxcq7hQQs7y1p3yEVc=;
	b=Jb5JKMSkiDLh7H4D5Rzo9ALAW4W5HvTvFzApFhPvrKUc2yZMaOv+Ne6FIZmsgmOgIWj4gR
	JzFXkOmXWSEzloMx9Mwy64AMVz70PtnIIZdlBS8hCEx7snPna8Exr87ZRvuSLzD+xEqeR7
	wPnpXkAY0EKYJVzomUiJ7jgGN6lkRss=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-tTjvTv0xO_ODqRw90Jq8dw-1; Fri, 24 Mar 2023 06:34:50 -0400
X-MC-Unique: tTjvTv0xO_ODqRw90Jq8dw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93F5C801206
	for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 10:34:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.233])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 30C652166B29
	for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 10:34:50 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 1/2] mptcp: use mptcp_schedule_work instead of open-codying it
Date: Fri, 24 Mar 2023 11:34:38 +0100
Message-Id: <9aa2681941d55c2ae198167c86c3d0b8ecfbf551.1679654040.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Beyond reducing code duplication this also avoiding scheduling
the mptcp_worker on a closed socket on some edge scenarios.

The addressed issue is actually older than the blamed commit
below, but this fix need it as a pre-requisite.

Fixes: ba8f48f7a4d7 ("mptcp: introduce mptcp_schedule_work")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 5 ++---
 net/mptcp/subflow.c | 9 ++++-----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 99c4f9e9bb90..cd3b885c8faa 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1192,9 +1192,8 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
 		if (mp_opt.data_fin && mp_opt.data_len == 1 &&
-		    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64) &&
-		    schedule_work(&msk->work))
-			sock_hold(subflow->conn);
+		    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))
+			mptcp_schedule_work((struct sock *)msk);
 
 		return true;
 	}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fe02d1222f43..e90c6f6a676a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -408,9 +408,8 @@ void mptcp_subflow_reset(struct sock *ssk)
 
 	tcp_send_active_reset(ssk, GFP_ATOMIC);
 	tcp_done(ssk);
-	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags) &&
-	    schedule_work(&mptcp_sk(sk)->work))
-		return; /* worker will put sk for us */
+	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
+		mptcp_schedule_work(sk);
 
 	sock_put(sk);
 }
@@ -1101,8 +1100,8 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 				skb_ext_del(skb, SKB_EXT_MPTCP);
 				return MAPPING_OK;
 			} else {
-				if (updated && schedule_work(&msk->work))
-					sock_hold((struct sock *)msk);
+				if (updated)
+					mptcp_schedule_work((struct sock *)msk);
 
 				return MAPPING_DATA_FIN;
 			}
-- 
2.39.2

