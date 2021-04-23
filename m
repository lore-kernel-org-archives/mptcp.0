Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714F32FA1
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 14:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619189433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pS69zFo6ZIJdmg0O2tXHXhZ25nMGODKF4k8vJLCWceo=;
	b=PpNvMghMCOpD1mNiVPgs7IpSgqztrT2lmxSGc3YP8CIp7ct4BzfviLvKZvI77Cs0U8cCDs
	R6K2C7YUFy0xoVDcsa8PXW4SmcdHcgfFv8hdriiYTDntDkRMXuEXu8byHqZv65GgBHrFgF
	6GxfyHEQvFm5N7+qnfMseX0oBHOActI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-3Goah9pdMKSWKdY7JobRvA-1; Fri, 23 Apr 2021 10:50:31 -0400
X-MC-Unique: 3Goah9pdMKSWKdY7JobRvA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13E055020D;
	Fri, 23 Apr 2021 14:50:31 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-60.ams2.redhat.com [10.36.115.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2F51219705;
	Fri, 23 Apr 2021 14:50:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v4 mptcp-next 14/22] Squash-to: "mptcp: receive checksum for DSS"
Date: Fri, 23 Apr 2021 16:49:53 +0200
Message-Id: <3bb8d79fb3f2f2dd06ef8619a65608a54c52c083.1619189145.git.pabeni@redhat.com>
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

Similar to the previous squash to patch, always parse
the DSS option regardless of csum presence.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 91c36d06ca73..9af54a1a3040 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -165,7 +165,6 @@ static void mptcp_parse_option(const struct sock *sk,
 		mp_opt->use_map = (flags & MPTCP_DSS_HAS_MAP) != 0;
 		mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
 		mp_opt->use_ack = (flags & MPTCP_DSS_HAS_ACK);
-		mp_opt->csum_reqd = READ_ONCE(msk->csum_enabled);
 
 		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d",
 			 mp_opt->data_fin, mp_opt->dsn64,
@@ -186,17 +185,13 @@ static void mptcp_parse_option(const struct sock *sk,
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP64;
 			else
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP32;
-
-			if (mp_opt->csum_reqd)
-				expected_opsize += TCPOLEN_MPTCP_DSS_CHECKSUM;
 		}
 
-		/* RFC 6824, Section 3.3:
-		 * If a checksum is present, but its use had
-		 * not been negotiated in the MP_CAPABLE handshake,
-		 * the checksum field MUST be ignored.
+		/* Always parse any csum presence combination, we will enforce
+		 * RFC 8684 Section 3.3.0 checks later in subflow_data_ready
 		 */
-		if (opsize != expected_opsize)
+		if (opsize != expected_opsize &&
+		    opsize != expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM)
 			break;
 
 		mp_opt->dss = 1;
@@ -228,14 +223,15 @@ static void mptcp_parse_option(const struct sock *sk,
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 
-			if (mp_opt->csum_reqd) {
+			if (opsize == expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM) {
+				mp_opt->csum_reqd = 1;
 				mp_opt->csum = (__force __sum16)get_unaligned_be16(ptr);
 				ptr += 2;
 			}
 
-			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%u",
+			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%d:%u",
 				 mp_opt->data_seq, mp_opt->subflow_seq,
-				 mp_opt->data_len, mp_opt->csum);
+				 mp_opt->data_len, mp_opt->csum_reqd, mp_opt->csum);
 		}
 
 		break;
-- 
2.26.2

