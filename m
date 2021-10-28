Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81282C87
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635426523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqJmOXQJgdGlxJF0fJEfIeg/KvywkkxkT464zJL0R4w=;
	b=J0ye6ltnG33rs5CcVMX6ydHL2a67/O+tU0/XZfM6m8N2v8uh2p3uH8b9XQhKET5fK07jdp
	erzt2ILTaR58hI9gTC6TK/jkPD8sKznCHnexF5Fe6rbmzNi2on7Qv0z8AsJYWNJWB5e7mq
	mN7+PBCdQA6WTxMHDFQJDqn6ibwFpFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-iH8LFPq5MmKbLxI0CXgQqQ-1; Thu, 28 Oct 2021 09:08:41 -0400
X-MC-Unique: iH8LFPq5MmKbLxI0CXgQqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 057BFBBF10
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 13:08:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.218])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6FE5D19D9F
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 13:08:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp <mptcp@lists.linux.dev>
Subject: [PATCH mptcp-net 1/2] mptcp: fix delack timer
Date: Thu, 28 Oct 2021 15:08:32 +0200
Message-Id: <9f483991d5eb9d42d142fb887a2940664fcb1041.1635426465.git.pabeni@redhat.com>
In-Reply-To: <cover.1635426465.git.pabeni@redhat.com>
References: <cover.1635426465.git.pabeni@redhat.com>
Precedence: bulk
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

From: Eric Dumazet <edumazet@google.com>

To compute the rtx timeout schedule_3rdack_retransmission() does multiple
things in the wrong way: srtt_us is measures in usec/8 and the timeout
itself is an absolute vale.

Fixes: ec3edaa7ca6ce02f ("mptcp: Add handling of outgoing MP_JOIN requests")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
commit message typos added by me
---
 net/mptcp/options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 422f4acfb3e6..465d4143d555 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -434,9 +434,10 @@ static void schedule_3rdack_retransmission(struct sock *sk)
 
 	/* reschedule with a timeout above RTT, as we must look only for drop */
 	if (tp->srtt_us)
-		timeout = tp->srtt_us << 1;
+		timeout = usecs_to_jiffies(tp->srtt_us >> (3-1));
 	else
 		timeout = TCP_TIMEOUT_INIT;
+	timeout += jiffies;
 
 	WARN_ON_ONCE(icsk->icsk_ack.pending & ICSK_ACK_TIMER);
 	icsk->icsk_ack.pending |= ICSK_ACK_SCHED | ICSK_ACK_TIMER;
-- 
2.26.3

