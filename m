Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD52F83
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 20:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619036435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VnQL9rB1RW7nq+Cr8glUJnL5NOD7hyfAN3H2O5iar7k=;
	b=DqzHkbBoiuR+6bDxoDzejlM0rf5nATMhcWogekUsn7mXtwFc3vyZq4eF2QmmbvNYdx/cE4
	RdC451BXP/jzH4qPC1TXmt5GWPIova+6qlf6xNlHmSuFTAZZuRc4oDAZRM0Ic5wPw/mEPi
	cz/Ku2fEA2pyF1ftqJTY1fMnp9I3pvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-PBa33nMMNXygsF0xw3Yd7A-1; Wed, 21 Apr 2021 16:20:33 -0400
X-MC-Unique: PBa33nMMNXygsF0xw3Yd7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 356C31898296;
	Wed, 21 Apr 2021 20:20:32 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-15.ams2.redhat.com [10.36.112.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 698B56085A;
	Wed, 21 Apr 2021 20:20:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v3 mptcp-next 03/21] Squash-to: "mptcp: generate the data checksum"
Date: Wed, 21 Apr 2021 22:17:52 +0200
Message-Id: <5522102b338b435d651205ba4c69c1c02abe6317.1619035356.git.pabeni@redhat.com>
In-Reply-To: <cover.1619035356.git.pabeni@redhat.com>
References: <cover.1619035356.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

We must generate the csum for zero window probe, too.

Additionally we must update the checksum when setting the data_fin
on a data packet.

Note that in a later patch we will skip unneeded csum related
operation. Changes not included here to keep the delta small.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c  | 3 +++
 net/mptcp/protocol.c | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 99fc21406168..ebce0326e3b6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -519,6 +519,9 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
 		 */
 		ext->data_fin = 1;
 		ext->data_len++;
+
+		/* the pseudo header has changed, update the csum accordingly */
+		csum_replace2(&ext->csum, ext->data_len - 1, ext->data_len);
 	}
 }
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index abcb22848a5c..d012b9998fdd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1271,6 +1271,9 @@ static bool mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk)
 	return __mptcp_alloc_tx_skb(sk, ssk, sk->sk_allocation);
 }
 
+/* note: this always recompute the csum on the whole skb, even
+ * if we just appended a single frag. More status info needed
+ */
 static __sum16 mptcp_generate_data_checksum(struct sk_buff *skb)
 {
 	struct csum_pseudo_header header;
@@ -1384,8 +1387,10 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	if (zero_window_probe) {
 		mptcp_subflow_ctx(ssk)->rel_write_seq += ret;
 		mpext->frozen = 1;
-		ret = 0;
+		if (READ_ONCE(msk->csum_enabled))
+			mpext->csum = mptcp_generate_data_checksum(tail);
 		tcp_push_pending_frames(ssk);
+		return 0;
 	}
 out:
 	if (READ_ONCE(msk->csum_enabled))
-- 
2.26.2

