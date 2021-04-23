Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736912FA3
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 14:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619189433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ynmzz8gUbIlCLW+L+GTGzA5B/Q5D1kWHZmOt/MBNNXU=;
	b=BnYXc5oG21aSj5OEuLjfM8rXRguYpdXhv4qVv6lHp85kvOmPZMxV1aXj8E239GyTmtgkJq
	aK82hq3F5WZ5u0QpoXaYTvnoMjuFdrYN5uv/dhHvTV+wo/OhuzNqZhHWsnqFzTSps/w+g5
	YRTl8DmJLzevbxWqKR1W9/LMNMlis+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-VW7AW_7jPsO2n0WFFFO4dQ-1; Fri, 23 Apr 2021 10:50:31 -0400
X-MC-Unique: VW7AW_7jPsO2n0WFFFO4dQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C70ED10054F6;
	Fri, 23 Apr 2021 14:50:29 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-60.ams2.redhat.com [10.36.115.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0738D19D9B;
	Fri, 23 Apr 2021 14:50:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v4 mptcp-next 13/22] mptcp: receive checksum for DSS
Date: Fri, 23 Apr 2021 16:49:52 +0200
Message-Id: <cc03a8f538196750ae275cff8740995955499916.1619189145.git.pabeni@redhat.com>
In-Reply-To: <cover.1619189145.git.pabeni@redhat.com>
References: <cover.1619189145.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

From: Geliang Tang <geliangtang@gmail.com>

In mptcp_parse_option, adjust the expected_opsize, and parse the data
checksum value from the receiving DSS, then save it in mp_opt->csum.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
v3 -> v4:
 - drop unneeded brackets (geliang)
---
 net/mptcp/options.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 83a981684bbf..91c36d06ca73 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -37,11 +37,10 @@ static void mptcp_parse_option(const struct sock *sk,
 	case MPTCPOPT_MP_CAPABLE:
 		/* strict size checking */
 		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
-			if (skb->len > tcp_hdr(skb)->doff << 2) {
+			if (skb->len > tcp_hdr(skb)->doff << 2)
 				expected_opsize = TCPOLEN_MPTCP_MPC_ACK_DATA;
-			} else {
+			else
 				expected_opsize = TCPOLEN_MPTCP_MPC_ACK;
-			}
 		} else {
 			if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK)
 				expected_opsize = TCPOLEN_MPTCP_MPC_SYNACK;
@@ -166,6 +165,7 @@ static void mptcp_parse_option(const struct sock *sk,
 		mp_opt->use_map = (flags & MPTCP_DSS_HAS_MAP) != 0;
 		mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
 		mp_opt->use_ack = (flags & MPTCP_DSS_HAS_ACK);
+		mp_opt->csum_reqd = READ_ONCE(msk->csum_enabled);
 
 		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d",
 			 mp_opt->data_fin, mp_opt->dsn64,
@@ -186,6 +186,9 @@ static void mptcp_parse_option(const struct sock *sk,
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP64;
 			else
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP32;
+
+			if (mp_opt->csum_reqd)
+				expected_opsize += TCPOLEN_MPTCP_DSS_CHECKSUM;
 		}
 
 		/* RFC 6824, Section 3.3:
@@ -193,8 +196,7 @@ static void mptcp_parse_option(const struct sock *sk,
 		 * not been negotiated in the MP_CAPABLE handshake,
 		 * the checksum field MUST be ignored.
 		 */
-		if (opsize != expected_opsize &&
-		    opsize != expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM)
+		if (opsize != expected_opsize)
 			break;
 
 		mp_opt->dss = 1;
@@ -226,9 +228,14 @@ static void mptcp_parse_option(const struct sock *sk,
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 
-			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u",
+			if (mp_opt->csum_reqd) {
+				mp_opt->csum = (__force __sum16)get_unaligned_be16(ptr);
+				ptr += 2;
+			}
+
+			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%u",
 				 mp_opt->data_seq, mp_opt->subflow_seq,
-				 mp_opt->data_len);
+				 mp_opt->data_len, mp_opt->csum);
 		}
 
 		break;
-- 
2.26.2

