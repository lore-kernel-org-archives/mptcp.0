Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63DF2F83
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 20:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619036448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80x24cVV2h2YdImwZKgNbR2wxIP4Tq8ks/u8WQbB8yY=;
	b=BfCmYk4xBVbVgxpl7Eg3JIY1cspwbBsaNxklyhZFbGPCLAncIL9rsBoK2Gxr/tSmes2W9b
	g2n4mv+2uW2jXNbGG/g8Js5wsFh/CM6+47m0fmrRZns2MMuU/xJK/pWNaeoGD6EN5oAN4J
	mmSIvv+gWS7xkgKOn6CQkDif5S9HFWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-7HccqQn8OkS_GojkOwyAWw-1; Wed, 21 Apr 2021 16:20:40 -0400
X-MC-Unique: 7HccqQn8OkS_GojkOwyAWw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 920B4801814;
	Wed, 21 Apr 2021 20:20:39 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-15.ams2.redhat.com [10.36.112.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 65E046085A;
	Wed, 21 Apr 2021 20:20:37 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v3 mptcp-next 07/21] mptcp: send out checksum for DSS
Date: Wed, 21 Apr 2021 22:17:56 +0200
Message-Id: <275afcc53246d0c673e7c6d83f3b974364614799.1619035356.git.pabeni@redhat.com>
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

In mptcp_write_options, If the checksum is enabled, adjust the option
length and send out the data checksum with DSS suboption.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 814fc43ee97b..01caff4cdd25 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -549,6 +549,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	bool ret = false;
 	u64 ack_seq;
 
+	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
 	mpext = skb ? mptcp_get_ext(skb) : NULL;
 
 	if (!skb || (mpext && mpext->use_map) || snd_data_fin_enable) {
@@ -1331,6 +1332,9 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			flags |= MPTCP_DSS_HAS_MAP | MPTCP_DSS_DSN64;
 			if (mpext->data_fin)
 				flags |= MPTCP_DSS_DATA_FIN;
+
+			if (opts->csum_reqd)
+				len += TCPOLEN_MPTCP_DSS_CHECKSUM;
 		}
 
 		*ptr++ = mptcp_option(MPTCPOPT_DSS, len, 0, flags);
@@ -1350,8 +1354,13 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
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

