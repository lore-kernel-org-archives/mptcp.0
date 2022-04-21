Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680167A
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 14:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1650550841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnjGadD6ccpqBfveBes2YRSiqHUFgLrxA78oJ6O23Ng=;
	b=WZ6dBOzjj13hNnsb+1ervq4aTreRmLQAVXXTN8eFGtNKKa84CxEZSqE5CI58U+53Z+f4Kz
	NGsO7iod8prsFFMnuvw/yv5QFbrX9P1EP6TOOUwjyXHh3KxwO/W0aPzligNR7uMQ23a4Th
	D11+ya0Wq+tIcXOVG1C39qj02pW+cBo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-8s3NTryAMOq96tQ9aHWBMg-1; Thu, 21 Apr 2022 10:20:39 -0400
X-MC-Unique: 8s3NTryAMOq96tQ9aHWBMg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AFEF3834C05
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 14:20:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.32.181.152])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4CD5614A4F80
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 14:20:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 3/5] tcp: allow MPTCP to update the announced window.
Date: Thu, 21 Apr 2022 16:20:17 +0200
Message-Id: <d06ca0f4b5a2d9f2e583b28531922478742a2a28.1650550242.git.pabeni@redhat.com>
In-Reply-To: <cover.1650550242.git.pabeni@redhat.com>
References: <cover.1650550242.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The MPTCP RFC requires that the MPTCP-level receive window's
right edge never moves backward. Currently the MPTCP code
enforces such constraint while tracking the right edge, but it
does not reflects it on the wire, as MPTCP lacks a suitable hook
to update accordingly the TCP header.

This change modifies the existing mptcp_write_options() hook,
providing the current packet's TCP header to the MPTCP protocol,
so that the next patch could implement the above mentioned
constraint.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - Use a single hdr/opt argument (Mat)
---
 include/net/mptcp.h   |  2 +-
 net/ipv4/tcp_output.c | 14 ++++++++------
 net/mptcp/options.c   |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 877077b53200..6b07011c060d 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -125,7 +125,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       struct mptcp_out_options *opts);
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
 
-void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
+void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 			 struct mptcp_out_options *opts);
 
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index c221f3bce975..7d64c3fc5d40 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -444,12 +444,13 @@ struct tcp_out_options {
 	struct mptcp_out_options mptcp;
 };
 
-static void mptcp_options_write(__be32 *ptr, const struct tcp_sock *tp,
+static void mptcp_options_write(struct tcphdr *th, __be32 *ptr,
+				struct tcp_sock *tp,
 				struct tcp_out_options *opts)
 {
 #if IS_ENABLED(CONFIG_MPTCP)
 	if (unlikely(OPTION_MPTCP & opts->options))
-		mptcp_write_options(ptr, tp, &opts->mptcp);
+		mptcp_write_options(th, ptr, tp, &opts->mptcp);
 #endif
 }
 
@@ -605,9 +606,10 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
  * At least SACK_PERM as the first option is known to lead to a disaster
  * (but it may well be that other scenarios fail similarly).
  */
-static void tcp_options_write(__be32 *ptr, struct tcp_sock *tp,
+static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			      struct tcp_out_options *opts)
 {
+	__be32 *ptr = (__be32 *)(th + 1);
 	u16 options = opts->options;	/* mungable copy */
 
 	if (unlikely(OPTION_MD5 & options)) {
@@ -701,7 +703,7 @@ static void tcp_options_write(__be32 *ptr, struct tcp_sock *tp,
 
 	smc_options_write(ptr, &options);
 
-	mptcp_options_write(ptr, tp, opts);
+	mptcp_options_write(th, ptr, tp, opts);
 }
 
 static void smc_set_option(const struct tcp_sock *tp,
@@ -1354,7 +1356,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 		th->window	= htons(min(tp->rcv_wnd, 65535U));
 	}
 
-	tcp_options_write((__be32 *)(th + 1), tp, &opts);
+	tcp_options_write(th, tp, &opts);
 
 #ifdef CONFIG_TCP_MD5SIG
 	/* Calculate the MD5 hash, as we have all we need now */
@@ -3590,7 +3592,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	/* RFC1323: The window in SYN & SYN/ACK segments is never scaled. */
 	th->window = htons(min(req->rsk_rcv_wnd, 65535U));
-	tcp_options_write((__be32 *)(th + 1), NULL, &opts);
+	tcp_options_write(th, NULL, &opts);
 	th->doff = (tcp_header_size >> 2);
 	__TCP_INC_STATS(sock_net(sk), TCP_MIB_OUTSEGS);
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e05d9458a025..2570911735ab 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1265,7 +1265,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
 				 ~csum_unfold(mpext->csum));
 }
 
-void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
+void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
 	const struct sock *ssk = (const struct sock *)tp;
-- 
2.35.1

