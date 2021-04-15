Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417406D13
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618502539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iOHM92Yej9K9CSF9XVh2xWi+uCa8vLYiECJkZyq1YKc=;
	b=DUNfLCnY+T9s8YWDvGS8DfRddDZmCICoEM9U0R7GvtYX5KRfV3CEywSfI/qy90ibBM/i+C
	Rcv59HWMuOiXTfetRDFn5M0iFjFe366p1UhPfc7ty+0Lc/s+95puu2KQEbcnSV+XlaQuCg
	c8THzmfzaEImqrvrNI9GlmI1QBxZ7ac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-mM8af9BwO4iYbeLWXtNfqA-1; Thu, 15 Apr 2021 12:02:17 -0400
X-MC-Unique: mM8af9BwO4iYbeLWXtNfqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90803195D598
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 16:02:16 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-128.ams2.redhat.com [10.36.115.128])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EF55B51F18
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 16:02:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH net-next 2/3] mptcp: implement MSG_TRUNC support
Date: Thu, 15 Apr 2021 18:02:06 +0200
Message-Id: <1a088075a75c545c92597828e933ded0a8ff0ed7.1618502178.git.pabeni@redhat.com>
In-Reply-To: <cover.1618502178.git.pabeni@redhat.com>
References: <cover.1618502178.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The mentioned flag is currently silenlty ignored. This
change implementes the TCP-like behaviour, dropping the
pending data up to the specified length.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note: this will conflict with the pending MSG_PEEK,
with hopefully simple conflict resolutions (same change in both patches)
---
 net/mptcp/protocol.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ed9ada31f2da..e6d1c293a615 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1739,7 +1739,7 @@ static void mptcp_wait_data(struct sock *sk, long *timeo)
 
 static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 				struct msghdr *msg,
-				size_t len)
+				size_t len, int flags)
 {
 	struct sk_buff *skb;
 	int copied = 0;
@@ -1750,11 +1750,13 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 		u32 count = min_t(size_t, len - copied, data_len);
 		int err;
 
-		err = skb_copy_datagram_msg(skb, offset, msg, count);
-		if (unlikely(err < 0)) {
-			if (!copied)
-				return err;
-			break;
+		if (!(flags & MSG_TRUNC)) {
+			err = skb_copy_datagram_msg(skb, offset, msg, count);
+			if (unlikely(err < 0)) {
+				if (!copied)
+					return err;
+				break;
+			}
 		}
 
 		copied += count;
@@ -1966,7 +1968,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	while (copied < len) {
 		int bytes_read;
 
-		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied);
+		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
 				copied = bytes_read;
-- 
2.26.2

