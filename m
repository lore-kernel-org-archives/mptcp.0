Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A91C36B08
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751161; cv=none; b=JHBkLMGtBfqdXLuhpSgLx3YcKAFnSeScj0GAEELtj7Y4jukkU0ZL9lpEG25+9vcMejTl2pOp/eLt2lCDH+sZZ5eED4N2lNPO98V8ZEn1MPnoUMzZjxaUzN36KcwCsrI5nItLhTlVHuV0nE5Juzgmbo13vp/4uW6edVYmvS/Hipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751161; c=relaxed/simple;
	bh=lds5teJS8fubOPuPITGq6r+pRYXmMAt4OVhAIoVMG4s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMif1+ON9v8vdtRGiiQp9U+CmJ0b5pFAUnLUY0m7V80///5AY+by+gMcEoW7XqGOO3xrYsMcA+XW3iq4Ps0sS9iGnrUiKvqgCVW6abg5sqjM2aCbEomSfPcfkD//XbExyYaqIHALNvsQKGBfk2JG0t/2G5fzDrfYZBDZgu9dHGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agw+1IwM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agw+1IwM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707751158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pR+DY3qfgYOrpIL/ECay5t1YrB7/xOqoerwTlTl3k0=;
	b=agw+1IwMEODLuol9eTh/yLQsauF+xF2yNBt+rM78dQlkAp5iX27Z/lVSE7314HgUAWIiId
	kAZBU/NTdvUE74abYwl12CSECdH5UXLcAJw5nxd7ZHbavU3bUsEntiEIK+dAKH3WljVVSA
	njoXu0aTCemSFIBtBb1SuLj4auRVuzg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-dmW2ooIrNsOmkoZMUG4vjA-1; Mon, 12 Feb 2024 10:19:17 -0500
X-MC-Unique: dmW2ooIrNsOmkoZMUG4vjA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDC8C811E81
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 15:19:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7CDAB492BC6
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 15:19:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [mptcp-next v2 4/7] mptcp: cleanup writer wake-up
Date: Mon, 12 Feb 2024 16:18:59 +0100
Message-ID: <29aa1523f11bdc4b5605f9b33ca03f2529c87811.1707739536.git.pabeni@redhat.com>
In-Reply-To: <cover.1707739536.git.pabeni@redhat.com>
References: <cover.1707739536.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

After commit 5cf92bbadc58 ("mptcp: re-enable sndbuf autotune"), the
MPTCP_NOSPACE bit is redundant: it is always set and cleared together with
SOCK_NOSPACE.

Let's drop the first and always relay on the latter, dropping a bunch
of useless code.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 15 +++------------
 net/mptcp/protocol.h | 16 ++++++----------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7c3cb97214b8..def01e030121 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1692,15 +1692,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 	}
 }
 
-static void mptcp_set_nospace(struct sock *sk)
-{
-	/* enable autotune */
-	set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
-
-	/* will be cleared on avail space */
-	set_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags);
-}
-
 static int mptcp_disconnect(struct sock *sk, int flags);
 
 static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
@@ -1874,7 +1865,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		continue;
 
 wait_for_memory:
-		mptcp_set_nospace(sk);
+		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		__mptcp_push_pending(sk, msg->msg_flags);
 		ret = sk_stream_wait_memory(sk, &timeo);
 		if (ret)
@@ -3896,8 +3887,8 @@ static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
 	if (sk_stream_is_writeable(sk))
 		return EPOLLOUT | EPOLLWRNORM;
 
-	mptcp_set_nospace(sk);
-	smp_mb__after_atomic(); /* msk->flags is changed by write_space cb */
+	set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+	smp_mb__after_atomic(); /* NOSPACE is changed by mptcp_write_space() */
 	if (sk_stream_is_writeable(sk))
 		return EPOLLOUT | EPOLLWRNORM;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2e197262a42e..0aa77c03643d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -113,10 +113,9 @@
 #define MPTCP_RST_TRANSIENT	BIT(0)
 
 /* MPTCP socket atomic flags */
-#define MPTCP_NOSPACE		1
-#define MPTCP_WORK_RTX		2
-#define MPTCP_FALLBACK_DONE	4
-#define MPTCP_WORK_CLOSE_SUBFLOW 5
+#define MPTCP_WORK_RTX		1
+#define MPTCP_FALLBACK_DONE	2
+#define MPTCP_WORK_CLOSE_SUBFLOW 3
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
@@ -799,12 +798,9 @@ static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 
 static inline void mptcp_write_space(struct sock *sk)
 {
-	if (sk_stream_is_writeable(sk)) {
-		/* pairs with memory barrier in mptcp_poll */
-		smp_mb();
-		if (test_and_clear_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags))
-			sk_stream_write_space(sk);
-	}
+	/* pairs with memory barrier in mptcp_poll */
+	smp_mb();
+	sk_stream_write_space(sk);
 }
 
 static inline void __mptcp_sync_sndbuf(struct sock *sk)
-- 
2.43.0

