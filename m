Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF1E258EF0
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738346; cv=none; b=UMKW7SNAF5eQpewK7RewnB8Wy9kHG5m9bPe10jqdrLPa6REZSrS7q470SqPD/cZRQYcDc9t0mL8SFfFAHS5yjxmrcgd9pS0J1LCJHSZc/lSKSeM4GDsJ67rDoWuaoRLl0WzKXkJ9K7DRooHUzLc1caNfoQ4FdRJGFczPTpTA+L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738346; c=relaxed/simple;
	bh=dsxWGTzWDZtaQ9AJL/wO2gPuo0PORH8K6KoRXJpuvqo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=AVi5lBrVbnSfFTo1VFoZ3TZASOLQcReyMwKHQ0N2WkyWfN/7bcFWpo8lmDVzmGX4hXoGSrb1Vz9v9YeGN39iNR67DzbXSFhB4qGP6Jf54rjrAaG+1r4EPJEDXlhOKRDrjWUOf/hhi2pRR6O8xNtEv6XaDaDwgcLSzUyxkbUP/aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwA64Isk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwA64Isk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759738343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGpf85DuHdtMCHWzEwbJ5upLCsIcp0p3rQ5QVj0Z7xQ=;
	b=dwA64IskGfA3dN6UsR2Y64G87QhBDfakxIHAB7a0NCeYwYNN2chFIcny4NHB/hdWtDtZy5
	yiZEdLSa1YJnzn2gYIxd0rXJ9C4kPRBJtIoA9zbAqmUVnGJ14sD0Q+fBv0RYshj9pvQJwc
	eDVF5lgfQpks2KIqeie/S4FZpODkUbc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-rShWAkiuNPeNuQ3YHkz26g-1; Mon,
 06 Oct 2025 04:12:22 -0400
X-MC-Unique: rShWAkiuNPeNuQ3YHkz26g-1
X-Mimecast-MFC-AGG-ID: rShWAkiuNPeNuQ3YHkz26g_1759738341
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14D7019560B4
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:21 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 352291800577
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:19 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v5 mptcp-next 04/10] mptcp: fix MSG_PEEK stream corruption
Date: Mon,  6 Oct 2025 10:12:03 +0200
Message-ID: <1f161922203105181ea1cad8ccc6d55328f03a01.1759737859.git.pabeni@redhat.com>
In-Reply-To: <cover.1759737859.git.pabeni@redhat.com>
References: <cover.1759737859.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FFdOz5-Da9FT5LTPyRl_hXYiBX-4UYfcYLXVjLeymbw_1759738341
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

If a MSG_PEEK | MSG_WAITALL read operation consumes all the bytes in the
receive queue and recvmsg() need to waits for more data - i.e. it's a
blocking one - upon arrival of the next packet the MPTCP protocol will
start again copying the oldest data present in the receive queue,
corrupting the data stream.

Address the issue explicitly tracking the peeked sequence number,
restarting from the last peeked byte.

Fixes: ca4fb892579f ("mptcp: add MSG_PEEK support")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
This may sound quite esoteric, but it will soon become very easy to
reproduce with mptcp_connect, thanks to the backlog.
---
 net/mptcp/protocol.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 12f201aa81f43..ce1238f620c33 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1947,22 +1947,36 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
 
-static int __mptcp_recvmsg_mskq(struct sock *sk,
-				struct msghdr *msg,
-				size_t len, int flags,
+static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
+				size_t len, int flags, int copied_total,
 				struct scm_timestamping_internal *tss,
 				int *cmsg_flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *skb, *tmp;
+	int total_data_len = 0;
 	int copied = 0;
 
 	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
-		u32 offset = MPTCP_SKB_CB(skb)->offset;
+		u32 delta, offset = MPTCP_SKB_CB(skb)->offset;
 		u32 data_len = skb->len - offset;
-		u32 count = min_t(size_t, len - copied, data_len);
+		u32 count;
 		int err;
 
+		if (flags & MSG_PEEK) {
+			/* skip already peeked skbs*/
+			if (total_data_len + data_len <= copied_total) {
+				total_data_len += data_len;
+				continue;
+			}
+
+			/* skip the already peeked data in the current skb */
+			delta = copied_total - total_data_len;
+			offset += delta;
+			data_len -= delta;
+		}
+
+		count = min_t(size_t, len - copied, data_len);
 		if (!(flags & MSG_TRUNC)) {
 			err = skb_copy_datagram_msg(skb, offset, msg, count);
 			if (unlikely(err < 0)) {
@@ -1979,16 +1993,14 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 
 		copied += count;
 
-		if (count < data_len) {
-			if (!(flags & MSG_PEEK)) {
+		if (!(flags & MSG_PEEK)) {
+			msk->bytes_consumed += count;
+			if (count < data_len) {
 				MPTCP_SKB_CB(skb)->offset += count;
 				MPTCP_SKB_CB(skb)->map_seq += count;
-				msk->bytes_consumed += count;
+				break;
 			}
-			break;
-		}
 
-		if (!(flags & MSG_PEEK)) {
 			/* avoid the indirect call, we know the destructor is sock_rfree */
 			skb->destructor = NULL;
 			skb->sk = NULL;
@@ -1996,7 +2008,6 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 			sk_mem_uncharge(sk, skb->truesize);
 			__skb_unlink(skb, &sk->sk_receive_queue);
 			skb_attempt_defer_free(skb);
-			msk->bytes_consumed += count;
 		}
 
 		if (copied >= len)
@@ -2194,7 +2205,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	while (copied < len) {
 		int err, bytes_read;
 
-		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags, &tss, &cmsg_flags);
+		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags,
+						  copied, &tss, &cmsg_flags);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
 				copied = bytes_read;
-- 
2.51.0

