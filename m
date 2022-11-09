Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C98DEBE2
	for <mptcp@lists.linux.dev>; Wed,  9 Nov 2022 14:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668005574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Oj81ZqsLRLykgk3AbaE4nH4uhQUv9UgA9QlZT130oMY=;
	b=Ydp2VnykBmfyXNs8w1VorIcb/cUJbKvvKtpK8m47We7i7ZMLnXTegQT1lWPKqBA1uleBaN
	dBOQqE6TAaZVGgje/yOvJpy7ra84bBdXTxKx1Wm5wT51t3FGe+XM2YERJ6UN4Wf3x7NwGk
	WQqznRxWLP7zRtjWYw+DTD1yPv45FzY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-QadpnyXlPB6GqwdNBotVwA-1; Wed, 09 Nov 2022 09:52:42 -0500
X-MC-Unique: QadpnyXlPB6GqwdNBotVwA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42118858F13;
	Wed,  9 Nov 2022 14:52:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.116])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 91223202903F;
	Wed,  9 Nov 2022 14:52:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Subject: [PATCH mptcp-next 1.5/5] mptcp: track accuratelly the incoming MPC suboption type.
Date: Wed,  9 Nov 2022 15:52:29 +0100
Message-Id: <4edc02c8a8e040d0ac212ff61d9256c8148f2429.1667993416.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Currently in the receive path we don't need to discriminate
between MPC SYN, MPC SYN-ACK adn MPC ACK, but soon the fastopen
code will need that info to properly track the fully established
status.

Track the exact MPC suboption type into the receive opt bitmap.
No functional change intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 30d289044e71..784a205e80da 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -26,6 +26,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 {
 	u8 subtype = *ptr >> 4;
 	int expected_opsize;
+	u16 subopt;
 	u8 version;
 	u8 flags;
 	u8 i;
@@ -38,11 +39,15 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				expected_opsize = TCPOLEN_MPTCP_MPC_ACK_DATA;
 			else
 				expected_opsize = TCPOLEN_MPTCP_MPC_ACK;
+			subopt = OPTION_MPTCP_MPC_ACK;
 		} else {
-			if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK)
+			if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) {
 				expected_opsize = TCPOLEN_MPTCP_MPC_SYNACK;
-			else
+				subopt = OPTION_MPTCP_MPC_SYNACK;
+			} else {
 				expected_opsize = TCPOLEN_MPTCP_MPC_SYN;
+				subopt = OPTION_MPTCP_MPC_SYN;
+			}
 		}
 
 		/* Cfr RFC 8684 Section 3.3.0:
@@ -85,7 +90,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 
 		mp_opt->deny_join_id0 = !!(flags & MPTCP_CAP_DENY_JOIN_ID0);
 
-		mp_opt->suboptions |= OPTIONS_MPTCP_MPC;
+		mp_opt->suboptions |= subopt;
 		if (opsize >= TCPOLEN_MPTCP_MPC_SYNACK) {
 			mp_opt->sndr_key = get_unaligned_be64(ptr);
 			ptr += 8;
-- 
2.38.1

