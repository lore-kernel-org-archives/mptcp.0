Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CA02F7AB0
	for <mptcp@lists.linux.dev>; Fri, 21 Nov 2025 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763715199; cv=none; b=NpWu6ZNHWvLZSSBca7jcKFFGwIxIsVx2XAfMCstxDKqzIJu2JSMk4adyOOgfvPeJ+qk4Q4QhA/4Sqzd7RlXJ8dEKwGIK3+fKMZO8GLJTEoQg2u9d4PMZTvdpUkdQs5otEquGP+6AsfeCoBs5xykjZLWOiIIGPaRGdfrd2d+LIJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763715199; c=relaxed/simple;
	bh=/ha7ZfOyzQgiJ6fjsAWhQyQykVlpjYnkixOSa3N8YO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=h9Jk3i/Md2M8bpmAr0FXluZxkrWGws5CaC3B0i/YAuj3tLJiWKYqd1zmJOrZba1FumniFTcTtDA4o5ZKxeYQAHkFVafPqtikU7IY62+/TkyH6otAVY9DqdnYvJSkj48kP+o35dCRpz91Z7w4PE/BGnQaNx0E5WssYdXIpfemVJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LiWdyttO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiWdyttO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763715195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/mxxtMnf3n6aW5xL1e33rpT5/zupHOjzicjpzU6AhBU=;
	b=LiWdyttOd1XH2x4yFVnTuzF8wKFq40VMgGABWKTZDb12+7tP2m9q/QahgvmP7pRXAT2tJa
	03yJFXhX2FjCy3FRn8JgylReXESiKpuYsw22FfZeH00aiI5iDr6KcENOLJ18dLi5YNsi9V
	uz9SHYwEZn/Gl9y5w+gZZRHGy87FUY8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-lZRCI3VHP_u_9TPDERQCpw-1; Fri,
 21 Nov 2025 03:53:14 -0500
X-MC-Unique: lZRCI3VHP_u_9TPDERQCpw-1
X-Mimecast-MFC-AGG-ID: lZRCI3VHP_u_9TPDERQCpw_1763715193
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47B7E1956080
	for <mptcp@lists.linux.dev>; Fri, 21 Nov 2025 08:53:13 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.201])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4389A180047F;
	Fri, 21 Nov 2025 08:53:12 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: dcaratti@redhat.com
Subject: [PATCH mptcp-net] mptcp: schedule rtx timer only after pushing data
Date: Fri, 21 Nov 2025 09:52:59 +0100
Message-ID: <9f5e5b6c05fa0e6d303126c6a68a19305d166d36.1763715034.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MTGjRdNn5BppXW_UfG18ik7JMUXWLkVKqsOMWfBbn2U_1763715193
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The MPTCP protocol usually schedule the retransmission timer only
when there is some chances for such retransmissions to happen.

With a notable exception: __mptcp_push_pending() currently schedule
such timer unconditionally, potentially leading to unnecessary rtx
timer expiration.

The issue is present since the blamed commit below but become easily
reproducible after commit 27b0e701d387 ("mptcp: drop bogus optimization in
__mptcp_check_push()")

Fixes: 33d41c9cd74c ("mptcp: more accurate timeout")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note that the blamed commit states we always need to rearm the timer even
with no data pending, to catch link failures. That sounds weird/possibly
tied to broken zero window probes?!? Hopefully mp_join self test should
catch that
---
 net/mptcp/protocol.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3b327e9ccb78..b3122f53827f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1649,7 +1649,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
-	bool do_check_data_fin = false;
+	bool copied = false;
 	int push_count = 1;
 
 	while (mptcp_send_head(sk) && (push_count > 0)) {
@@ -1691,7 +1691,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 						push_count--;
 					continue;
 				}
-				do_check_data_fin = true;
+				copied = true;
 			}
 		}
 	}
@@ -1700,11 +1700,14 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	if (ssk)
 		mptcp_push_release(ssk, &info);
 
-	/* ensure the rtx timer is running */
-	if (!mptcp_rtx_timer_pending(sk))
-		mptcp_reset_rtx_timer(sk);
-	if (do_check_data_fin)
+	/* Avoid scheduling the rtx timer if no data has been pushed; the timer
+	 * will be updated on positive acks by __mptcp_cleanup_una().
+	 */
+	if (copied) {
+		if (!mptcp_rtx_timer_pending(sk))
+			mptcp_reset_rtx_timer(sk);
 		mptcp_check_send_data_fin(sk);
+	}
 }
 
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
-- 
2.51.1

