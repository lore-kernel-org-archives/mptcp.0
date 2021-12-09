Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29122CB2
	for <mptcp@lists.linux.dev>; Thu,  9 Dec 2021 17:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639071052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1mY7UFdQVRSDeafvZWZ10zEPnX1i9Jjr2qNMeJH7g8=;
	b=Qp5r+Rc1godnRkVgehz/J8pKxv1rKqZG+clJEx3GPsoY6FKmgNjQWjg0IK/M/nQLsVmcQW
	uEgdGe8ELMx4nzu2Exldr1aag3TmSrxc0xHbgj2JEMfG889UIF/KSbx0KzBlgbnzTvxu6S
	EL0C3j24hr5Yx25j15UFAkBnENKrpAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-gcwnJYkSOqefW-P4erij-w-1; Thu, 09 Dec 2021 12:30:50 -0500
X-MC-Unique: gcwnJYkSOqefW-P4erij-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3B9481EE61
	for <mptcp@lists.linux.dev>; Thu,  9 Dec 2021 17:30:49 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 53B355ED27
	for <mptcp@lists.linux.dev>; Thu,  9 Dec 2021 17:30:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v5 2/5] mptcp: clean-up MPJ option writing.
Date: Thu,  9 Dec 2021 18:30:39 +0100
Message-Id: <c1d3d63aad8c5263b9a1d346ef7c60d1a4a99c03.1639070864.git.pabeni@redhat.com>
In-Reply-To: <cover.1639070864.git.pabeni@redhat.com>
References: <cover.1639070864.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

