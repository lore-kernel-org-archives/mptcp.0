Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258952C83
	for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 16:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637685456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1mY7UFdQVRSDeafvZWZ10zEPnX1i9Jjr2qNMeJH7g8=;
	b=h+dAQHRSZ90ZJEQn2TW3/4mtEqDJYRjAmTSXay9JDMXKwnXF6vxxYx7AbMkCkgMJl4jeHQ
	1dsYZ1FmMg34oNTJapcVlqgpDcYkurjbsko2ShWM0QkuPEsb0CLK5OjOCrxK+3IE606Dy1
	x3a0SYphRVTZquRaLlbR2H1RcBnTMug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-70fgiZ7cM_qaZ7APdJ6Rxg-1; Tue, 23 Nov 2021 11:37:33 -0500
X-MC-Unique: 70fgiZ7cM_qaZ7APdJ6Rxg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E95C102CB2E;
	Tue, 23 Nov 2021 16:37:32 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.149])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 63EFA67842;
	Tue, 23 Nov 2021 16:37:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Phil Greenland <phil@quantulum.co.uk>
Subject: [PATCH mptcp-next 1/3] mptcp: clean-up MPJ option writing.
Date: Tue, 23 Nov 2021 17:37:10 +0100
Message-Id: <5e98a57b75ff1d45305bc5b6ba7fcbd24d355b65.1637684792.git.pabeni@redhat.com>
In-Reply-To: <cover.1637684792.git.pabeni@redhat.com>
References: <cover.1637684792.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

