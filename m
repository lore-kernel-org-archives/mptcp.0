Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4AF70
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620164552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIruEmVQ2HncBCBe0dQIReFaLjwuI4FEAG/PR4CG0I4=;
	b=BgAy/iSyBjPVc1T997HiYqw1sqJM1ScrMfGdR6JzFpNBVRClDrUW0JiUOELmDEHkEwtYBD
	mqT7MxQyhGL8egtv656DKPacxLS/28Miyrd1MmJ0mUbhrpeUCgIzEdav2yXSdSvBbZHMc7
	CbELogaUGpTpZDPEMXTCpjEUglNXbXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-Zy-Qy_v-PdKhW9NC9X5pzQ-1; Tue, 04 May 2021 17:42:31 -0400
X-MC-Unique: Zy-Qy_v-PdKhW9NC9X5pzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D3ED1006C81
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:30 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-126.ams2.redhat.com [10.36.114.126])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D8E1D5C22A
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v6 mptcp-next 02/22] mptcp: generate the data checksum
Date: Tue,  4 May 2021 23:41:50 +0200
Message-Id: <3084d7d24b452d871d26309b89b32af449c573f1.1620163861.git.pabeni@redhat.com>
In-Reply-To: <cover.1620163861.git.pabeni@redhat.com>
References: <cover.1620163861.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
index 4cf8965fae4a..2a094d35a099 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1279,6 +1279,25 @@ static bool mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk)
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
@@ -1377,6 +1396,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		tcp_push_pending_frames(ssk);
 	}
 out:
+	if (READ_ONCE(msk->csum_enabled))
+		mpext->csum = mptcp_generate_data_checksum(tail);
 	mptcp_subflow_ctx(ssk)->rel_write_seq += ret;
 	return ret;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6cbbe7403402..63a1651f9069 100644
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

