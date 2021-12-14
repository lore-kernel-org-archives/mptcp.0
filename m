Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58812CB2
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 16:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639501164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1mY7UFdQVRSDeafvZWZ10zEPnX1i9Jjr2qNMeJH7g8=;
	b=gTCbeKHuU9XofQ833SJ4ySoX2FWHGwGs8Is8jV22dVkQAiUjPdXwfQkKLIwwR1SiWGg0Lv
	48tWAT3YcKVdtqVTYjdpnZ3RlDBJdtqXDc+69E6p+hCMZJ8pisrMJqdcupIUR9pMalQLOI
	LAQ6pm0D2xbC9LKeZEevabjqFZ0PXIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-oxJjpXLgOXuDQ4g6ZvsdSQ-1; Tue, 14 Dec 2021 11:59:22 -0500
X-MC-Unique: oxJjpXLgOXuDQ4g6ZvsdSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0280801AAB
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 16:59:21 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2706D106A7AE
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 16:59:20 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v6 mptcp-next 2/7] mptcp: clean-up MPJ option writing.
Date: Tue, 14 Dec 2021 17:58:52 +0100
Message-Id: <ee52d7d98c27ec935090f13affd1624ef3b787e2.1639500873.git.pabeni@redhat.com>
In-Reply-To: <cover.1639500873.git.pabeni@redhat.com>
References: <cover.1639500873.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Check for all MPJ variant at once, this reduces the number
of conditionals traversed on average and will simplify the
next patch.

No functional change intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1020e4285c..7a6a39b71633 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1381,27 +1381,29 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 
 		/* MPC is additionally mutually exclusive with MP_PRIO */
 		goto mp_capable_done;
-	} else if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
-		*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
-				      TCPOLEN_MPTCP_MPJ_SYN,
-				      opts->backup, opts->join_id);
-		put_unaligned_be32(opts->token, ptr);
-		ptr += 1;
-		put_unaligned_be32(opts->nonce, ptr);
-		ptr += 1;
-	} else if (OPTION_MPTCP_MPJ_SYNACK & opts->suboptions) {
-		*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
-				      TCPOLEN_MPTCP_MPJ_SYNACK,
-				      opts->backup, opts->join_id);
-		put_unaligned_be64(opts->thmac, ptr);
-		ptr += 2;
-		put_unaligned_be32(opts->nonce, ptr);
-		ptr += 1;
-	} else if (OPTION_MPTCP_MPJ_ACK & opts->suboptions) {
-		*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
-				      TCPOLEN_MPTCP_MPJ_ACK, 0, 0);
-		memcpy(ptr, opts->hmac, MPTCPOPT_HMAC_LEN);
-		ptr += 5;
+	} else if (OPTIONS_MPTCP_MPJ & opts->suboptions) {
+		if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
+			*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
+					      TCPOLEN_MPTCP_MPJ_SYN,
+					      opts->backup, opts->join_id);
+			put_unaligned_be32(opts->token, ptr);
+			ptr += 1;
+			put_unaligned_be32(opts->nonce, ptr);
+			ptr += 1;
+		} else if (OPTION_MPTCP_MPJ_SYNACK & opts->suboptions) {
+			*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
+					      TCPOLEN_MPTCP_MPJ_SYNACK,
+					      opts->backup, opts->join_id);
+			put_unaligned_be64(opts->thmac, ptr);
+			ptr += 2;
+			put_unaligned_be32(opts->nonce, ptr);
+			ptr += 1;
+		} else {
+			*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
+					      TCPOLEN_MPTCP_MPJ_ACK, 0, 0);
+			memcpy(ptr, opts->hmac, MPTCPOPT_HMAC_LEN);
+			ptr += 5;
+		}
 	} else if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
 		u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
 		u8 echo = MPTCP_ADDR_ECHO;
-- 
2.33.1

