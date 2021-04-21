Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C952F83
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 20:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619036453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+koqOpAnqLmuqM9yi6SXCZQXl/ZPrmSWXU/7b0vdJA=;
	b=f3lCQHNpy03ye++M0hIGcVbDEaHqdk4ssVZn6zslZ9k0AA/GhrLAJaITXFZq1IGvC2LNFO
	YBE/y5r4z6GRA35NA83cxvpx+Y+yJC5qPUL2xx0USwLU1NgM7FxsxkzIaFTQxsWJCtzw78
	1XPrLpfgSovXxqRFoasDd8zHDsyvT5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-FxeSEuWZOZiDoK0-Bs3M0A-1; Wed, 21 Apr 2021 16:20:51 -0400
X-MC-Unique: FxeSEuWZOZiDoK0-Bs3M0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B56E1898296;
	Wed, 21 Apr 2021 20:20:50 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-15.ams2.redhat.com [10.36.112.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 47AB36085A;
	Wed, 21 Apr 2021 20:20:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v3 mptcp-next 13/21] mptcp: receive checksum for DSS
Date: Wed, 21 Apr 2021 22:18:02 +0200
Message-Id: <5405aeac5e0a44dececbca0d01c65a9ca0fc300e.1619035356.git.pabeni@redhat.com>
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

In mptcp_parse_option, adjust the expected_opsize, and parse the data
checksum value from the receiving DSS, then save it in mp_opt->csum.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 83a981684bbf..43e454c14160 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -166,6 +166,7 @@ static void mptcp_parse_option(const struct sock *sk,
 		mp_opt->use_map = (flags & MPTCP_DSS_HAS_MAP) != 0;
 		mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
 		mp_opt->use_ack = (flags & MPTCP_DSS_HAS_ACK);
+		mp_opt->csum_reqd = READ_ONCE(msk->csum_enabled);
 
 		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d",
 			 mp_opt->data_fin, mp_opt->dsn64,
@@ -186,6 +187,9 @@ static void mptcp_parse_option(const struct sock *sk,
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP64;
 			else
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP32;
+
+			if (mp_opt->csum_reqd)
+				expected_opsize += TCPOLEN_MPTCP_DSS_CHECKSUM;
 		}
 
 		/* RFC 6824, Section 3.3:
@@ -193,8 +197,7 @@ static void mptcp_parse_option(const struct sock *sk,
 		 * not been negotiated in the MP_CAPABLE handshake,
 		 * the checksum field MUST be ignored.
 		 */
-		if (opsize != expected_opsize &&
-		    opsize != expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM)
+		if (opsize != expected_opsize)
 			break;
 
 		mp_opt->dss = 1;
@@ -226,9 +229,14 @@ static void mptcp_parse_option(const struct sock *sk,
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

