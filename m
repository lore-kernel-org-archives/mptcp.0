Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AAD7F6
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 11:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655724411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Av8TpUGC4VOlwFitGVrmLJhb2bsuI5u1JkTtFTjnxjA=;
	b=KuS/2D2uOz7mEzco6nT0vm0abQLL8hOMmNeqt+BOdd5o5eSZfv5Nk13LkvfMmUqOp6YZT0
	3WPrByOGbWjlcbBRAMvPJzadmLXUlJsj/cJjIHjgH5kT4Wspq6vfwQjSucNErSHqwoewni
	tQVbYwO5M0TDKqYuQ01mpZhvNKjONfI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-Oi2xkLiePuqKilrw02tzvA-1; Mon, 20 Jun 2022 07:26:49 -0400
X-MC-Unique: Oi2xkLiePuqKilrw02tzvA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97BB2101AA45
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 11:26:49 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 27AA840BB4F
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 11:26:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v4 5/6] mptcp: consistent map handling on failure
Date: Mon, 20 Jun 2022 13:26:35 +0200
Message-Id: <1d9852cc1346d6cec5f18153d821aae69cb1840b.1655723410.git.pabeni@redhat.com>
In-Reply-To: <cover.1655723410.git.pabeni@redhat.com>
References: <cover.1655723410.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

When the MPTCP receive path reach a non fatal fall-back condition, e.g.
when the MPC sockets must fall-back to TCP, the existing code is a little
self-inconsistent: it reports that new data is available - return true -
but sets the MPC flag to the opposite value.

As the consequence read operations in some exceptional scenario may block
unexpectedly.

Address the issue setting the correct MPC read status. Additionally avoid
some code duplication in the fatal fall-back scenario.

Fixes: 9c81be0dbc89 ("mptcp: add MP_FAIL response support")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 77fccc49d05c..5c87a269af80 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1252,17 +1252,12 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			subflow->send_mp_fail = 1;
 
 			if (!READ_ONCE(msk->allow_infinite_fallback)) {
-				ssk->sk_err = EBADMSG;
-				tcp_set_state(ssk, TCP_CLOSE);
 				subflow->reset_transient = 0;
 				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
-				tcp_send_active_reset(ssk, GFP_ATOMIC);
-				while ((skb = skb_peek(&ssk->sk_receive_queue)))
-					sk_eat_skb(ssk, skb);
-			} else {
-				mptcp_subflow_fail(msk, ssk);
+				goto reset;
 			}
-			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
+			mptcp_subflow_fail(msk, ssk);
+			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
 			return true;
 		}
 
@@ -1270,10 +1265,14 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
-			ssk->sk_err = EBADMSG;
-			tcp_set_state(ssk, TCP_CLOSE);
 			subflow->reset_transient = 0;
 			subflow->reset_reason = MPTCP_RST_EMPTCP;
+
+reset:
+			ssk->sk_err = EBADMSG;
+			tcp_set_state(ssk, TCP_CLOSE);
+			while ((skb = skb_peek(&ssk->sk_receive_queue)))
+				sk_eat_skb(ssk, skb);
 			tcp_send_active_reset(ssk, GFP_ATOMIC);
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return false;
-- 
2.35.3

