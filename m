Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE042F83
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 20:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619036472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ufqEGkaGVoMtku0tV4rLY2SLWuF4ieUygLv8bLdlO8=;
	b=P28zRinDSo6GX4P9pX7IqEYwqLHLhvgujIwb59bIwHcBpF/BgBFJNWSEEofbBmfvHQAKeb
	RYIj+fiQKdEC5diCehm/td6UONALKIYBkhdXP056L2ER7YmM2vho8/gCC4xHSgUhz1EzqY
	lWv08SK72OIYPzgENlWE4mzt4P7zGmg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-pX9nBKfCMqKSMDOEIzlRpw-1; Wed, 21 Apr 2021 16:20:30 -0400
X-MC-Unique: pX9nBKfCMqKSMDOEIzlRpw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A74F107ACCA;
	Wed, 21 Apr 2021 20:20:30 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-15.ams2.redhat.com [10.36.112.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2212F6085A;
	Wed, 21 Apr 2021 20:20:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v3 mptcp-next 02/21] mptcp: generate the data checksum
Date: Wed, 21 Apr 2021 22:17:51 +0200
Message-Id: <7a7d3e8cb0e91808ff19f2682b35d90b0c391f1d.1619035356.git.pabeni@redhat.com>
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

From: Geliang Tang <geliangtang@gmail.com>

This patch added a new member named csum in struct mptcp_ext, implemented
a new function named mptcp_generate_data_checksum().

Generate the data checksum in mptcp_sendmsg_frag, save it in mpext->csum.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/protocol.c | 21 +++++++++++++++++++++
 net/mptcp/protocol.h |  7 +++++++
 3 files changed, 29 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 83f23774b908..23bbd439e115 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -23,6 +23,7 @@ struct mptcp_ext {
 	u64		data_seq;
 	u32		subflow_seq;
 	u16		data_len;
+	__sum16		csum;
 	u8		use_map:1,
 			dsn64:1,
 			data_fin:1,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5b6bb1d27af5..abcb22848a5c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1271,6 +1271,25 @@ static bool mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk)
 	return __mptcp_alloc_tx_skb(sk, ssk, sk->sk_allocation);
 }
 
+static __sum16 mptcp_generate_data_checksum(struct sk_buff *skb)
+{
+	struct csum_pseudo_header header;
+	struct mptcp_ext *mpext;
+	__wsum csum;
+
+	mpext = mptcp_get_ext(skb);
+
+	header.data_seq = mpext->data_seq;
+	header.subflow_seq = mpext->subflow_seq;
+	header.data_len = mpext->data_len;
+	header.csum = 0;
+
+	csum = skb_checksum(skb, 0, skb->len, 0);
+	csum = csum_partial(&header, sizeof(header), csum);
+
+	return csum_fold(csum);
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1369,6 +1388,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		tcp_push_pending_frames(ssk);
 	}
 out:
+	if (READ_ONCE(msk->csum_enabled))
+		mpext->csum = mptcp_generate_data_checksum(tail);
 	mptcp_subflow_ctx(ssk)->rel_write_seq += ret;
 	return ret;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 240a5d9bc7da..e9e2d3c1a142 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -335,6 +335,13 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(const struct sock *sk)
 	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, list);
 }
 
+struct csum_pseudo_header {
+	u64 data_seq;
+	u32 subflow_seq;
+	u16 data_len;
+	__sum16 csum;
+};
+
 struct mptcp_subflow_request_sock {
 	struct	tcp_request_sock sk;
 	u16	mp_capable : 1,
-- 
2.26.2

