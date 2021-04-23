Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBA42FA3
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 14:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619189440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=liYXD3aH+XS+xSjwjrnHnVgX3MGVWYDaUVAd3sxu+c0=;
	b=JT3Ac03YIwqIiUVFpEDmrKMP450FJEDcgeTjtI+hwZh19P9zhZ4+oFY8PMDPjysNDYuESq
	8XXXrVvRvTmiLnJgHtePJGAOL6G2K8XWQBblElWwQQ2RXetE1LYp5HHdI440Xj7Z+hbAut
	5b8bPnin7oCfuYan9GDLa6buYjqIeq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-CkrQA6OIOiuzAbLXzFNYUw-1; Fri, 23 Apr 2021 10:50:35 -0400
X-MC-Unique: CkrQA6OIOiuzAbLXzFNYUw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E19B18A0862;
	Fri, 23 Apr 2021 14:50:34 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-60.ams2.redhat.com [10.36.115.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B103F19D9B;
	Fri, 23 Apr 2021 14:50:33 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v4 mptcp-next 17/22] mptcp: cleanup error path in subflow_check_data_avail()
Date: Fri, 23 Apr 2021 16:49:56 +0200
Message-Id: <3594e05b1973d5de82cd3ff3b9ba9a32c4989504.1619189145.git.pabeni@redhat.com>
In-Reply-To: <cover.1619189145.git.pabeni@redhat.com>
References: <cover.1619189145.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Move fallback code out of the main loop and adds some
brench prediction annotations.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
 - moved here from previous patch
 - added unlikely annotations

possibly not the best time ever for this kind of cleanup...
---
 net/mptcp/subflow.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0ee568a99da1..b61ebadd796c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1106,21 +1106,12 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
 		status = get_mapping_status(ssk, msk);
 		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
-		if (status == MAPPING_INVALID) {
+		if (unlikely(status == MAPPING_INVALID)) {
 			ssk->sk_err = EBADMSG;
 			goto fatal;
 		}
-		if (status == MAPPING_DUMMY) {
-			__mptcp_do_fallback(msk);
-			skb = skb_peek(&ssk->sk_receive_queue);
-			subflow->map_valid = 1;
-			subflow->map_seq = READ_ONCE(msk->ack_seq);
-			subflow->map_data_len = skb->len;
-			subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq -
-						   subflow->ssn_offset;
-			subflow->data_avail = MPTCP_SUBFLOW_DATA_AVAIL;
-			return true;
-		}
+		if (unlikely(status == MAPPING_DUMMY))
+			goto fallback;
 
 		if (status != MAPPING_OK)
 			goto no_data;
@@ -1164,6 +1155,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 no_data:
 	subflow_sched_work_if_closed(msk, ssk);
 	return false;
+
 fatal:
 	/* fatal protocol error, close the socket */
 	/* This barrier is coupled with smp_rmb() in tcp_poll() */
@@ -1175,6 +1167,16 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	tcp_send_active_reset(ssk, GFP_ATOMIC);
 	subflow->data_avail = 0;
 	return false;
+
+fallback:
+	__mptcp_do_fallback(msk);
+	skb = skb_peek(&ssk->sk_receive_queue);
+	subflow->map_valid = 1;
+	subflow->map_seq = READ_ONCE(msk->ack_seq);
+	subflow->map_data_len = skb->len;
+	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq -subflow->ssn_offset;
+	subflow->data_avail = MPTCP_SUBFLOW_DATA_AVAIL;
+	return true;
 }
 
 bool mptcp_subflow_data_available(struct sock *sk)
-- 
2.26.2

