Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25E92210E5
	for <mptcp@lists.linux.dev>; Thu, 12 Dec 2024 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022711; cv=none; b=pXh+QkyP5S+mYLbWzLB2eTRgT2oAA7VOrPOh5TVQ6eWKoQMK/bbPyU8jTCv3cdX2zr5JHuXUbRsCUn3TmOwiXSIdCLloC7iJvU32+Q7Grxnzzmwk7yxzWAg7YPWvs1trgBxWhqCFOSjW1wLUEVIWKHlOvWRZW2eUlPPgHD7sKP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022711; c=relaxed/simple;
	bh=iWjKOedt/NI9TP5Po9NXQhbOD+Bx9BSXXKjZN2NLQoI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=JAPRrWIBW58wQNFpSAZ/SLxjP8vHVc5iw2pEozX/uHuI+qPmsDiLd8MESkVa8Xb+o2hTIliCZLF/3gtcP54Arfk3/iX6PLh8v5YNwivy38HuPXBWGx+E1cf2eOB2NaUw2r711pI0hRloePBDTg5HaO8GQXoTgrQBHQwlT1BSm+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9CsxXZG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9CsxXZG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734022708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDjkDK1NScoqP6dKawwluexe6bxv7pOkJDu2RITIuJU=;
	b=K9CsxXZGkqGbvwGQ5FHoYucnzUDem+vEZ4bmX3GOzDE08Rdgu3RUlADPQFomrQmaHXBq0u
	KMz7Qb/3G1DiOQgVuQOA5TQaetIIxgUT9gFgBxFNOC/aw9N5Q0/8krP1z+1/+jGOuhLz0L
	dShv5HAuz3EbBm9z1OfHKrbvh/HgxmY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-cVudKz08P3a_k-HuD-IFmA-1; Thu,
 12 Dec 2024 11:58:27 -0500
X-MC-Unique: cVudKz08P3a_k-HuD-IFmA-1
X-Mimecast-MFC-AGG-ID: cVudKz08P3a_k-HuD-IFmA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 481241955F43
	for <mptcp@lists.linux.dev>; Thu, 12 Dec 2024 16:58:26 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.108])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88DA7195394B
	for <mptcp@lists.linux.dev>; Thu, 12 Dec 2024 16:58:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/2] mptcp: dismiss __mptcp_rmem()
Date: Thu, 12 Dec 2024 17:58:13 +0100
Message-ID: <0807affc4ee98d08f290669338db153e5045ee09.1734022547.git.pabeni@redhat.com>
In-Reply-To: <cover.1734022547.git.pabeni@redhat.com>
References: <cover.1734022547.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X8MWOOnUXPA_901s7tDyvr9AV0rP-yDMSiNnJYYW1sI_1734022706
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

After the RX path refactor, it become a wrapper for sk_rmem_alloc
access, with a slightly misleading name. Just drop it.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c |  8 ++++----
 net/mptcp/protocol.h | 11 ++---------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4f27b0cafac5..d6e8295b9404 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -494,7 +494,7 @@ static void mptcp_cleanup_rbuf(struct mptcp_sock *msk, int copied)
 	bool cleanup, rx_empty;
 
 	cleanup = (space > 0) && (space >= (old_space << 1)) && copied;
-	rx_empty = !__mptcp_rmem(sk) && copied;
+	rx_empty = !sk_rmem_alloc_get(sk) && copied;
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -643,7 +643,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		WRITE_ONCE(tp->copied_seq, seq);
 		more_data_avail = mptcp_subflow_data_available(ssk);
 
-		if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf) {
+		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf) {
 			done = true;
 			break;
 		}
@@ -780,7 +780,7 @@ static void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	__mptcp_rcvbuf_update(sk, ssk);
 
 	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
-	if (__mptcp_rmem(sk) > sk->sk_rcvbuf)
+	if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
 		return;
 
 	/* Wake-up the reader only for in-sequence data */
@@ -2045,7 +2045,7 @@ static bool __mptcp_move_skbs(struct sock *sk)
 		mptcp_for_each_subflow(msk, subflow)
 			__mptcp_rcvbuf_update(sk, subflow->tcp_sock);
 
-	if (__mptcp_rmem(sk) > sk->sk_rcvbuf)
+	if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
 		return false;
 
 	do {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a0d46b69746d..35a74b59541b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -377,14 +377,6 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 #define mptcp_sk(ptr) container_of_const(ptr, struct mptcp_sock, sk.icsk_inet.sk)
 #endif
 
-/* the msk socket don't use the backlog, also account for the bulk
- * free memory
- */
-static inline int __mptcp_rmem(const struct sock *sk)
-{
-	return atomic_read(&sk->sk_rmem_alloc);
-}
-
 static inline int mptcp_win_from_space(const struct sock *sk, int space)
 {
 	return __tcp_win_from_space(mptcp_sk(sk)->scaling_ratio, space);
@@ -397,7 +389,8 @@ static inline int mptcp_space_from_win(const struct sock *sk, int win)
 
 static inline int __mptcp_space(const struct sock *sk)
 {
-	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) - __mptcp_rmem(sk));
+	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
+				    sk_rmem_alloc_get(sk));
 }
 
 static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
-- 
2.45.2

