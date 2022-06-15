Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C328623B9
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 09:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655284627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tJS/33G/jdeIT0WGkXjxwdl7IgG+gCx7SWlT7UoUkzE=;
	b=M6KD87MDXrQJ5Tb94EOxqZRWoo7+Fm1nQm0GvguQzh8b+GycQ7KZi/UERYJn6IUg4VzLqN
	CGi0CC9chAwgYbs+FUO1u0JZse/YvdiMUvFu2U6t5TySPUf6ak7J/0DRsY3I4VS3cXKztu
	77QWR5JTj/1hryrCQcp9aV73th+ObGs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-dq32oLHiP_2qDt90JgfBOA-1; Wed, 15 Jun 2022 05:17:06 -0400
X-MC-Unique: dq32oLHiP_2qDt90JgfBOA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 677F180B70A
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 09:17:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.220])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EB7DEC23DBF
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 09:17:05 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 5/5] mptcp: consistent map handling on failure
Date: Wed, 15 Jun 2022 11:16:16 +0200
Message-Id: <979dc4297888128f0d058ba7631e17415b894666.1655283387.git.pabeni@redhat.com>
In-Reply-To: <cover.1655283387.git.pabeni@redhat.com>
References: <cover.1655283387.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
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
index 75fdc6474d0e..bec36e2bcc32 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1246,17 +1246,12 @@ static bool subflow_check_data_avail(struct sock *ssk)
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
 
@@ -1264,10 +1259,14 @@ static bool subflow_check_data_avail(struct sock *ssk)
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

