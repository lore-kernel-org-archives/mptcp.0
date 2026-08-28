Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06153E5598
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912305; cv=none; b=CJ0CJL/FF79146FYrboiQTpRcvarRd/sffNFKg8mzTbySGHIhTw105RAqNWmKxDs1jUB8XMP3NivYLQNMVSD7dnsNaKeFUgU0TP+zs0HDvwsJGnVz9GL0y/EaDnJfcHuCK6USToRx6pySysKX0qOljdTWJiuKOgfQ/wrsbsdfPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912305; c=relaxed/simple;
	bh=wWkmHEZF0pc+fXcQSL8EYCoH/0PecPjJp07eqIJ9B9E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=r9skCXyR5fcJQpEWMeLfq8787V2RBaJAX7uc9aqNGVB2+tzouGY+27MI/LXJTYQ4OX1FE1kJv5dAuEohCmUfbBI9TDi3ACxacwTs+LO2f+U+K49GsNsfUwVL4foSPG8SD23SyOko8XTjafvCWH+uBYSjKXFmOT04ezQ9CEeWUI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZVGelJf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZVGelJf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787912300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQwKfd6jIJ8KE3EPtGle4t17zrsYhCY8X3uL40KvQ0c=;
	b=EZVGelJf11/Uu3IyPA50amAjPSLSCo5KdLOiU0zaXepclQVIyke4yWu1+zVeaaBCgMfEWg
	jPBtdvlWGUoOQmf7W+fgAXmbum2oc3beqR5hSTiVUqBrQcx+OSmvjBtBvKwUFgV0WDNy/u
	Nyw5UIs5HX5lnRd096AD0elbHNB+lbc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-IX_ccPhvNRerYnBkwV4Ssw-1; Fri,
 28 Aug 2026 06:18:19 -0400
X-MC-Unique: IX_ccPhvNRerYnBkwV4Ssw-1
X-Mimecast-MFC-AGG-ID: IX_ccPhvNRerYnBkwV4Ssw_1787912298
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3315C185FD81
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 10:18:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5CDF93001D37
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 10:18:17 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v3 2/2] Squash-to: "mptcp: do not reschedule the RTX timer for fallback sockets"
Date: Fri, 28 Aug 2026 12:17:14 +0200
Message-ID: <18efc48d4288baa509ab8305e24c1c8b10d78b16.1787911017.git.pabeni@redhat.com>
In-Reply-To: <cover.1787911017.git.pabeni@redhat.com>
References: <cover.1787911017.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4FhDCoYKmcxACMomlcUTLWLqH7r9_MF4BrcBYtldVN0_1787912298
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Sashiko noted that the 'RTX disabled' status is carried over
across connect() failures, potentially to subsequent successful connect()
or listen().

Explicitly control the RTX enabling status across the whole msk life-cycle.
To make the code more straight forward switch the newly introduced flag
semantic.

To be appended to the squash-to commit message:

"""
The RTX enable bit is clear at close time and set before the msk could
start retransmitting, with a couple of caveats:
- passive sockets inherit the bit from the listener msk; set the bit on
  such socket to avoid flipping it in the fast-path, even if the listener
  will obviously never retransmit.
- while fastopening, mptcp_sendmsg_fastopen still ends-up calling
  mptcp_connect via tcp_sendmsg_fastopen ->
  __inet_stream_connect(ssk->sk_socket), and the first subflow sk_socket
  points to the msk one.
"""

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---

v2 -> v3:
  - roll back to v1, sashiko review was wrong and I should have noticed :(
    hopefully the update changelog should guide sashiko review to avoid
    repeating the sloop, in any case the issue reported here:

https://sashiko.dev/#/patchset/f1e8ffe44c3756195391a25ecf60e56e02e0f34f.1787739122.git.pabeni%40redhat.com

    is a false positive (see the above changelog).

v1 -> v2:
  - consolidate enable, fix missing enable for fastopen
---
 net/mptcp/protocol.c | 8 +++++---
 net/mptcp/protocol.h | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1e7e59d497c5..08e06511cd6f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -96,7 +96,7 @@ bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib)
 
 	msk->allow_subflows = false;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
-	set_bit(MPTCP_RTX_DISABLED, &msk->flags);
+	clear_bit(MPTCP_RTX_ENABLED, &msk->flags);
 	__MPTCP_INC_STATS(net, fb_mib);
 	spin_unlock_bh(&msk->fallback_lock);
 	return true;
@@ -1126,7 +1126,7 @@ static void mptcp_reset_rtx_timer(struct sock *sk)
 	unsigned long tout;
 
 	/* Prevent rescheduling on close and in case of fallback. */
-	if (test_bit(MPTCP_RTX_DISABLED, &msk->flags))
+	if (!test_bit(MPTCP_RTX_ENABLED, &msk->flags))
 		return;
 
 	tout = msk->timer_ival;
@@ -3363,7 +3363,7 @@ void mptcp_set_state(struct sock *sk, int state)
 		 */
 		break;
 	case TCP_CLOSE:
-		set_bit(MPTCP_RTX_DISABLED, &mptcp_sk(sk)->flags);
+		clear_bit(MPTCP_RTX_ENABLED, &mptcp_sk(sk)->flags);
 		fallthrough;
 	default:
 		if (oldstate == TCP_ESTABLISHED || oldstate == TCP_CLOSE_WAIT)
@@ -4189,6 +4189,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	if (IS_ERR(ssk))
 		return PTR_ERR(ssk);
 
+	set_bit(MPTCP_RTX_ENABLED, &msk->flags);
 	mptcp_set_state(sk, TCP_SYN_SENT);
 	subflow = mptcp_subflow_ctx(ssk);
 #ifdef CONFIG_TCP_MD5SIG
@@ -4336,6 +4337,7 @@ static int mptcp_listen(struct socket *sock, int backlog)
 		goto unlock;
 	}
 
+	set_bit(MPTCP_RTX_ENABLED, &msk->flags);
 	mptcp_set_state(sk, TCP_LISTEN);
 	sock_set_flag(sk, SOCK_RCU_FREE);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3d250e8204d5..482d4a549881 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -116,7 +116,7 @@
 #define MPTCP_WORK_RTX		1
 #define MPTCP_FALLBACK_DONE	2
 #define MPTCP_WORK_CLOSE_SUBFLOW 3
-#define MPTCP_RTX_DISABLED	4
+#define MPTCP_RTX_ENABLED	4
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
-- 
2.55.0

