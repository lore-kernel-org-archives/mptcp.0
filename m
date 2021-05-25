Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F8C2FB1
	for <mptcp@lists.linux.dev>; Tue, 25 May 2021 17:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621964263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=am/xBEvQZd7yTJypSRhSUnla6evNiXgF9ZJM7S6uRqw=;
	b=FsVBcs/2SwE62qSlt6a2W3PsWU0/IQoWSF5T+mGF/VuVzfJS80w2KhLU/ZfPo3f+F9VDzu
	69tFcFnKYGjBiw/rY74FuFHmSVV+5JkefgRRHnb3wF6e6zhwF19hqDgH0qTWEw7hCidQtH
	ulalV64XReaDlyDdkGk7PqtHGCYUGJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-MB3JAqAqO5Kcfc7q8pr_ZQ-1; Tue, 25 May 2021 13:37:41 -0400
X-MC-Unique: MB3JAqAqO5Kcfc7q8pr_ZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0160107ACE4
	for <mptcp@lists.linux.dev>; Tue, 25 May 2021 17:37:40 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-92.ams2.redhat.com [10.36.115.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EEC24100E113;
	Tue, 25 May 2021 17:37:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: fwestpha@redhat.com
Subject: [RFC PATCH 2/4] mptcp: don't clear MPTCP_DATA_READY in sk_wait_event()
Date: Tue, 25 May 2021 19:37:18 +0200
Message-Id: <ff00de7453de85a39e136b77e4288a293fec3d9f.1621963632.git.pabeni@redhat.com>
In-Reply-To: <cover.1621963632.git.pabeni@redhat.com>
References: <cover.1621963632.git.pabeni@redhat.com>
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

If we don't flush entirely the receive queue, we need set
again such bit later. We can simply avoid clearing it.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e85ec0e84e06..6050431f4c86 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1707,7 +1707,7 @@ static void mptcp_wait_data(struct sock *sk, long *timeo)
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 
 	sk_wait_event(sk, timeo,
-		      test_and_clear_bit(MPTCP_DATA_READY, &msk->flags), &wait);
+		      test_bit(MPTCP_DATA_READY, &msk->flags), &wait);
 
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	remove_wait_queue(sk_sleep(sk), &wait);
@@ -2028,10 +2028,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		 */
 		if (unlikely(__mptcp_move_skbs(msk)))
 			set_bit(MPTCP_DATA_READY, &msk->flags);
-	} else if (unlikely(!test_bit(MPTCP_DATA_READY, &msk->flags))) {
-		/* data to read but mptcp_wait_data() cleared DATA_READY */
-		set_bit(MPTCP_DATA_READY, &msk->flags);
 	}
+
 out_err:
 	if (cmsg_flags && copied >= 0) {
 		if (cmsg_flags & MPTCP_CMSG_TS)
-- 
2.26.3

