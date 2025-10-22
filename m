Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BFF34C996
	for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143536; cv=none; b=EZVwyG8C66ftCPHYDpySJrP39Nqf/P5yQmibxTF2vV2Iu3nyWStH+44F5y2eLmR1v9GWcZOS+lQbhOJBfysRHfLhiJJS+UHnwUmGidLsKZRF7MbV5Iy8/So1wyO7Jw6v046kVP1WMI5BLAukRIqjAsFq4jHw0RTpJfy0MYhUzR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143536; c=relaxed/simple;
	bh=wcFbRlFn09cO8JrFl3jDJjSD6lD1/6FbycDMfK2/uvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=FH191E3VffrOwdkXY3JTtoYd3phG4gMaDzFuqZB5Vc8ZOgz6kwpErf4senLgfYmF0+u1T4KhoJwX/Ht7EHQmAaflofuwKoI47qRs+I9rsnq8VJjAZkvFoXfzrMvG/RZeWoAA7PC/2lugeeR1iWbDpYgwhhBGlivvVh8UzoPzeS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zn7B3jK5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zn7B3jK5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761143532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t26jJwvEzgZECrnxA8C544K1Fn9+fuNz+u1NXmq+UJE=;
	b=Zn7B3jK51B69hsA5LV4WImokzhbQSKQeV8Yk60Zw76aEJ9BgcKvWJ+o+jV7KPWwb10ryOA
	oAkMX0KTBnYC4yq1Nl9qcd8aoDmvgyn+QBz3crZPKHPVIw+lKuGNeDrE1HPHaNyqWvSj3W
	Gntp0BTx+rIQbu5zVNLcDTBwP1+7waY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-r4SP96U_OFek7JAA0wSk9g-1; Wed,
 22 Oct 2025 10:32:11 -0400
X-MC-Unique: r4SP96U_OFek7JAA0wSk9g-1
X-Mimecast-MFC-AGG-ID: r4SP96U_OFek7JAA0wSk9g_1761143530
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 820D41800D81;
	Wed, 22 Oct 2025 14:32:10 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.237])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B40E1956056;
	Wed, 22 Oct 2025 14:32:08 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH v6 mptcp-next 05/11] mptcp: fix MSG_PEEK stream corruption
Date: Wed, 22 Oct 2025 16:31:48 +0200
Message-ID: <d110f41af91c7b3feb17b6b5942c21cdcec93c13.1761142784.git.pabeni@redhat.com>
In-Reply-To: <cover.1761142784.git.pabeni@redhat.com>
References: <cover.1761142784.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vJc-eb8GeyGbpARA6GBAFBwMkuGvfDnOonHO20UfJfc_1761143530
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
index 51c55a45aeaccd..200b657080eb3e 100644
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

