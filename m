Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7109C5812E
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082945; cv=none; b=ZFNbDEhptMOo7++ZEy8oYWgav40qoNF2MEeLuoSPZ+gx7wPC74XNSJGrAdxOqjxHw5cLaWz7NV7Crs8RQlwYvtqxU5zT5NTZqYdtoN1Y8qag6zlWnVlZSCytrHkZ3hYh8b5bfErKuWYwQOu2QdmfhipbU13BjyR/RUWcoFon2b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082945; c=relaxed/simple;
	bh=7xLWgioPD76VOHt3ac9Ugx2r7cchIrYpELG+chgRU4k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZljMV+5+jI05gQmT43pnO74wiEaiP6+9MyX9hBCfIiKtRtk29mA6zXp+rSPGmQOixYgYSsAFztqvQFid6rxt7JzwC0DnpcCEf4EjVcL8B7lwPMaXBZ0QUJyb13Dz60Ol2Xr3IFPqhqIauj70NITYborxfnosBq31KRRGcIbcxVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFc0I9PM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFc0I9PM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708082942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6M7igZRDpRM4znsE9g5+FpnwEphhdinHJGeQTW6SyOA=;
	b=VFc0I9PMB0Mx7Qlan24G0Ki8c0OrZxtt7W8kQGsLte0J5oPHgvF8S3d/KkPC1gPov8wjEN
	28gnKVW1QIN/DN0/F+d138jFqskv9Au/FS3ZyrtayhbTr852J3c/3oTEYggPHTUUm2WbtM
	6Xl5lnDxHWb59/BUkWF0KoljbfKG0Rc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-uUcPgAv7PjKs0CAvUQZDzA-1; Fri, 16 Feb 2024 06:29:01 -0500
X-MC-Unique: uUcPgAv7PjKs0CAvUQZDzA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8767185A780
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:29:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 78079492BE2
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:29:00 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 net-next 4/7] mptcp: cleanup writer wake-up
Date: Fri, 16 Feb 2024 12:28:15 +0100
Message-ID: <e6e91b7df862653078e10c89841ae9c9fd5cc473.1708082765.git.pabeni@redhat.com>
In-Reply-To: <cover.1708082765.git.pabeni@redhat.com>
References: <cover.1708082765.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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
index 738705207652..3414e7705835 100644
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

