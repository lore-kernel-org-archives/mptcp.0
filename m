Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184DF2F80
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620164558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pMwgjYLZJ4WxNrUqVq64YM77NpkI/D+0sjgAlW5EOtk=;
	b=Xo4kHzyLt3HykmpT8OqAdzI8w6AT9SluiDs5Oae8wnxCnrai1QrlyxN1ukZOERbbJzSljG
	s/9p1iZPnLLC36CrGJydF6NTEt6ST0sUu15sGY6YnXdQiOAu74sUpSg/7zGEPT9YMmzNMK
	Qn5tqCR7QPqTas1HT06GU+jBRG+6EP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-ywyLxNQOM2yUMWYVhSkn3w-1; Tue, 04 May 2021 17:42:36 -0400
X-MC-Unique: ywyLxNQOM2yUMWYVhSkn3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEE8C189DF43
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:35 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-126.ams2.redhat.com [10.36.114.126])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3624C5C22A
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:35 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v6 mptcp-next 07/22] mptcp: send out checksum for DSS
Date: Tue,  4 May 2021 23:41:55 +0200
Message-Id: <96baa1d7ec44553aebf095a7d5d5d615ee175952.1620163861.git.pabeni@redhat.com>
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

In mptcp_write_options, If the checksum is enabled, adjust the option
length and send out the data checksum with DSS suboption.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d18a686aab7d..8ff840bca481 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -549,6 +549,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	bool ret = false;
 	u64 ack_seq;
 
+	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
 	mpext = skb ? mptcp_get_ext(skb) : NULL;
 
 	if (!skb || (mpext && mpext->use_map) || snd_data_fin_enable) {
@@ -1350,6 +1351,9 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			flags |= MPTCP_DSS_HAS_MAP | MPTCP_DSS_DSN64;
 			if (mpext->data_fin)
 				flags |= MPTCP_DSS_DATA_FIN;
+
+			if (opts->csum_reqd)
+				len += TCPOLEN_MPTCP_DSS_CHECKSUM;
 		}
 
 		*ptr++ = mptcp_option(MPTCPOPT_DSS, len, 0, flags);
@@ -1369,8 +1373,13 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			ptr += 2;
 			put_unaligned_be32(mpext->subflow_seq, ptr);
 			ptr += 1;
-			put_unaligned_be32(mpext->data_len << 16 |
-					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
+			if (opts->csum_reqd) {
+				put_unaligned_be32(mpext->data_len << 16 |
+						   (__force u16)mpext->csum, ptr);
+			} else {
+				put_unaligned_be32(mpext->data_len << 16 |
+						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
+			}
 		}
 	}
 
-- 
2.26.2

