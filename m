Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD0B1FF7A1
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487057; cv=none; b=irx1j/Eq0rJNGZ1LveMERUfSV4vG+duqxt9z97RBGWWzGPsTd4ntyZ4nzhzMvYWpb8bHimvvkCVGOC3KN5ZQuEgIrY7k4sBvXFJnDpMgT4lobVEhwtCQ2hCpmIO+o3Z4Ltljnwk2QUKhAbqK6zTdgJ6BjpBeiqok3Yv57e+LQe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487057; c=relaxed/simple;
	bh=9TTSho1zKZX7E/HlQiibtnxacoc/i/pQ42ZFMOxzCRA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rfhoj7ik84h15jdQPdamLkJC+jNeONA560DS/+Pb6fTWx7Mldpsr7IWlNjccEH2WyXaOTYdkCNbUuhrfVOcbE4WVyLqaJkYkztIsQol4ClrjYlQ+cSp4ke3lvr73iMHCou3c2KuRyCLwJTIn9L6BGWMIyZksiGdZWKHNG7es5Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NxruYWNP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxruYWNP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733487054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1h7GX4QIhVML5zb8rD8wWeDqRe2mzYX00Ccxks2Qvw=;
	b=NxruYWNPJuQMnNzVeSil99z/Gh7WTAtU+oTT76xddkVIL2RePVkUcUsNVXu3SyQtf7FZgA
	+wToIce8Ajh/VX6V7gUB2Tn24QWIzj2IBqK/kTmc3Z3kHk41meivpIWgQ75mFxleVY1OG+
	X+97dYxdaZZef/ff008CC0QJ6UXViL0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-w4m0YmA1MvW7CsoQ0adVnw-1; Fri,
 06 Dec 2024 07:10:53 -0500
X-MC-Unique: w4m0YmA1MvW7CsoQ0adVnw-1
X-Mimecast-MFC-AGG-ID: w4m0YmA1MvW7CsoQ0adVnw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 819161955D9A
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:10:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.243])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6548300019E
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:10:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 3/7] mptcp: don't always assume copied data in mptcp_cleanup_rbuf()
Date: Fri,  6 Dec 2024 13:10:47 +0100
Message-ID: <045648bc48950d4d1e78b295131f08b655179c08.1733486870.git.pabeni@redhat.com>
In-Reply-To: <cover.1733486870.git.pabeni@redhat.com>
References: <cover.1733486870.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: akKWu5azS7ppk6C_nNszPLwYwPgQJCSYbePtbd4OLno_1733487052
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Under some corner cases the MPTCP protocol can end-up invoking
mptcp_cleanup_rbuf() when no data has been copied, but such helper
assumes the opposite condition.

Explicitly drop such assumption and performs the costly call only
when strictly needed - before releasing the msk socket lock.

Fixes: fd8976790a6c ("mptcp: be careful on MPTCP-level ack.")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bca8c2c046c3..690614816749 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -529,13 +529,13 @@ static void mptcp_send_ack(struct mptcp_sock *msk)
 		mptcp_subflow_send_ack(mptcp_subflow_tcp_sock(subflow));
 }
 
-static void mptcp_subflow_cleanup_rbuf(struct sock *ssk)
+static void mptcp_subflow_cleanup_rbuf(struct sock *ssk, int copied)
 {
 	bool slow;
 
 	slow = lock_sock_fast(ssk);
 	if (tcp_can_send_ack(ssk))
-		tcp_cleanup_rbuf(ssk, 1);
+		tcp_cleanup_rbuf(ssk, copied);
 	unlock_sock_fast(ssk, slow);
 }
 
@@ -552,7 +552,7 @@ static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
 			      (ICSK_ACK_PUSHED2 | ICSK_ACK_PUSHED)));
 }
 
-static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
+static void mptcp_cleanup_rbuf(struct mptcp_sock *msk, int copied)
 {
 	int old_space = READ_ONCE(msk->old_wspace);
 	struct mptcp_subflow_context *subflow;
@@ -560,14 +560,14 @@ static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
 	int space =  __mptcp_space(sk);
 	bool cleanup, rx_empty;
 
-	cleanup = (space > 0) && (space >= (old_space << 1));
-	rx_empty = !__mptcp_rmem(sk);
+	cleanup = (space > 0) && (space >= (old_space << 1)) && copied;
+	rx_empty = !__mptcp_rmem(sk) && copied;
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		if (cleanup || mptcp_subflow_could_cleanup(ssk, rx_empty))
-			mptcp_subflow_cleanup_rbuf(ssk);
+			mptcp_subflow_cleanup_rbuf(ssk, copied);
 	}
 }
 
@@ -2221,9 +2221,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		/* be sure to advertise window change */
-		mptcp_cleanup_rbuf(msk);
-
 		if (skb_queue_empty(&msk->receive_queue) && __mptcp_move_skbs(msk))
 			continue;
 
@@ -2272,6 +2269,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 
 		pr_debug("block timeout %ld\n", timeo);
+		mptcp_cleanup_rbuf(msk, copied);
 		err = sk_wait_data(sk, &timeo, NULL);
 		if (err < 0) {
 			err = copied ? : err;
@@ -2279,6 +2277,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 	}
 
+	mptcp_cleanup_rbuf(msk, copied);
+
 out_err:
 	if (cmsg_flags && copied >= 0) {
 		if (cmsg_flags & MPTCP_CMSG_TS)
-- 
2.45.2

