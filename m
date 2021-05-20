Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B3C2FB6
	for <mptcp@lists.linux.dev>; Thu, 20 May 2021 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621521994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Thnzn8dQeE69UlFWUiME0xJUJWWheWh0sKg+hY2o9k=;
	b=PY397p7sEV9rj0h+5pEgaYiXXhxmk6XCfhtnCuUFxMHBopAJCTGls0FobWtLVhYalTLscH
	e+Ne1H1EpfKLvmjXmj6WMEuJfrEG36uBUT18u8H84pe9ZLMp0cZ9yiMgQ8YZj2sjq1/L4n
	njrdf8Ra7/osHRJaqTIizG+vbywkLK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-oM-TX_EuNaG_rdsLbO-xhQ-1; Thu, 20 May 2021 10:46:30 -0400
X-MC-Unique: oM-TX_EuNaG_rdsLbO-xhQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 364E7107ACE6
	for <mptcp@lists.linux.dev>; Thu, 20 May 2021 14:46:30 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-166.ams2.redhat.com [10.36.114.166])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9F12710027C4
	for <mptcp@lists.linux.dev>; Thu, 20 May 2021 14:46:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-net 2/3] mptcp: do not reset MP_CAPABLE subflow on mapping errors
Date: Thu, 20 May 2021 16:46:14 +0200
Message-Id: <d1935d23fff36674a64477cbf4f9b205a301624c.1621521884.git.pabeni@redhat.com>
In-Reply-To: <7e97e8e3c7d9265dcbf098b57f12da11d0b383b1.1621521884.git.pabeni@redhat.com>
References: <7e97e8e3c7d9265dcbf098b57f12da11d0b383b1.1621521884.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

When some mapping related errors occours we close the main
MPC subflow with a RST. We should instead fallback gracefully
to TCP, and do the reset only for MPJ subflows.

Fixes: d22f4988ffec ("mptcp: process MP_CAPABLE data option")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/192
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - change the fallback/rst test to better suite the RFC
---
 net/mptcp/subflow.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 278986585088..a39d99d96900 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1110,10 +1110,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
 		status = get_mapping_status(ssk, msk);
 		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
-		if (unlikely(status == MAPPING_INVALID)) {
-			ssk->sk_err = EBADMSG;
-			goto fatal;
-		}
+		if (unlikely(status == MAPPING_INVALID))
+			goto fallback;
+
 		if (unlikely(status == MAPPING_DUMMY))
 			goto fallback;
 
@@ -1128,10 +1127,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		 * MP_CAPABLE-based mapping
 		 */
 		if (unlikely(!READ_ONCE(msk->can_ack))) {
-			if (!subflow->mpc_map) {
-				ssk->sk_err = EBADMSG;
-				goto fatal;
-			}
+			if (!subflow->mpc_map)
+				goto fallback;
 			WRITE_ONCE(msk->remote_key, subflow->remote_key);
 			WRITE_ONCE(msk->ack_seq, subflow->map_seq);
 			WRITE_ONCE(msk->can_ack, true);
@@ -1160,19 +1157,22 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	subflow_sched_work_if_closed(msk, ssk);
 	return false;
 
-fatal:
-	/* fatal protocol error, close the socket */
-	/* This barrier is coupled with smp_rmb() in tcp_poll() */
-	smp_wmb();
-	ssk->sk_error_report(ssk);
-	tcp_set_state(ssk, TCP_CLOSE);
-	subflow->reset_transient = 0;
-	subflow->reset_reason = MPTCP_RST_EMPTCP;
-	tcp_send_active_reset(ssk, GFP_ATOMIC);
-	subflow->data_avail = 0;
-	return false;
-
 fallback:
+	/* RFC 8684 section 3.7. */
+	if (subflow->mp_join || subflow->fully_established) {
+		/* fatal protocol error, close the socket.
+		 * subflow_error_report() will introduce the apprpriate barriers
+		*/
+		ssk->sk_err = EBADMSG;
+		ssk->sk_error_report(ssk);
+		tcp_set_state(ssk, TCP_CLOSE);
+		subflow->reset_transient = 0;
+		subflow->reset_reason = MPTCP_RST_EMPTCP;
+		tcp_send_active_reset(ssk, GFP_ATOMIC);
+		subflow->data_avail = 0;
+		return false;
+	}
+
 	__mptcp_do_fallback(msk);
 	skb = skb_peek(&ssk->sk_receive_queue);
 	subflow->map_valid = 1;
-- 
2.26.3

