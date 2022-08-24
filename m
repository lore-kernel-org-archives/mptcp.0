Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4692139F
	for <mptcp@lists.linux.dev>; Wed, 24 Aug 2022 11:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661339905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sA4NgqFVtLhtuschY9R88Cjx4hfhiSukNOUqbDcNRhI=;
	b=TWYwGYbQnPjdrg6oV48kYKw/tfgJFnpJfT6Rk9lWOFhCmgENeHhVtsarJm3wJ1FDRrzij9
	bhrAgeWBanzQeW6/0Uoi2+lQA+YkUwQSw9lenm4zyZm8b22/ata44Q0YVuk8KO+KpPTYK7
	O/UyxNQVdi2RfEtQYqB79v+mH/yXua4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-AtzR4Xi1MXa3630lbZIJCQ-1; Wed, 24 Aug 2022 07:18:24 -0400
X-MC-Unique: AtzR4Xi1MXa3630lbZIJCQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 476233C0ED55
	for <mptcp@lists.linux.dev>; Wed, 24 Aug 2022 11:18:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CB784492C3B
	for <mptcp@lists.linux.dev>; Wed, 24 Aug 2022 11:18:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/2] mptcp: never re-inject data on a single subflow
Date: Wed, 24 Aug 2022 13:18:14 +0200
Message-Id: <cfe4fd464d2e7701008b5e1b39030b74f3e9a606.1661339834.git.pabeni@redhat.com>
In-Reply-To: <cover.1661339834.git.pabeni@redhat.com>
References: <cover.1661339834.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

If the MPTCP-level data ack is delayed WRT to the TCP-level ack,
there is a single subflow and the user-space stops pushing data,
the MPTCP-level retransmit may trigger in, fooling (disallowing)
infinite mapping fallback.

All the above is triggered quite reliably by the self-tests, once
we move the MPTCP receive path under the msk socket lock - delaying
the MPTCP-level acks.

Plain TCP is good enough to handle retransmissions as needed.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note that there are a couple of sad untold stories here. The first one
is as follow: with the delayed mptcp-level ack, at MPC handshake time we have:

MPC + SYN ->
	<- MPC + SYN_ACK(1)
MPC + ACK(1) ->
	<- DSS(n bytes) + ACK(1)
DSS_ACK(1) + ACK(n+1)

and no more acks from the client side, even after reading the
incoming n bytes data. So a possible alternative solution would be
to tweek mptcp_cleanup_rbuf() to properly handle this scenario.

Additionally, possibly, still due to the mptcp-level delyated ack,
we could need to tweek mptcp_cleanup_rbuf() more - e.g. do we need
to force mptcp-level ack when there is a large enough amount of newly
"ackable" data due to __mptcp_move_skbs() action? I don't know.

I guess/hope that the condition on mptcp-level window update already
implemented in mptcp_cleanup_rbuf() should also cover for the above,
but I'm not sure.

The other point is that I can't recall the previous discussion about
avoiding re-injection with a single subflow. I now think that is bad,
at least with delayed mptcp-level ack, and I don't see a need for that,
but possibly/likely I'm forgetting something?!?
---
 net/mptcp/sched.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 044c5ec8bbfb..409e832085c2 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -162,6 +162,10 @@ struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	if (__mptcp_check_fallback(msk))
 		return NULL;
 
+	/* never retransmit when there is a single subflow */
+	if (list_is_singular(&msk->conn_list) && list_empty(&msk->join_list))
+		return NULL;
+
 	if (!msk->sched)
 		return mptcp_subflow_get_retrans(msk);
 
-- 
2.37.1

