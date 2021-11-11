Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6365A2C81
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636647714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2vrRq51JyO0I8j9iK839of93i0SLamlXsDgfHfpob7Q=;
	b=Kl2Sd0ra7MkDIar8HG1l1yVVj7uZVBnT4+3KqYdQFAMLTEVlJICURLnTZ9CV6ejMmajv7k
	vEQXNRQlAERcgWHSE0C+7aiNHyGF6CBlfbTY36fAIl1PHvkQfMGI1O5EyL09vHagVc+4xx
	7nCA5eqxImi+K5PoB5J4kIxvfeHjFF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-h5ZZPpO_MKOmTv6QrjlFEw-1; Thu, 11 Nov 2021 11:21:53 -0500
X-MC-Unique: h5ZZPpO_MKOmTv6QrjlFEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F9E887D542
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:52 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DF01F5D6D7
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 3/7] mptcp: implement fastclose xmit path
Date: Thu, 11 Nov 2021 17:21:38 +0100
Message-Id: <4955d076f71b1890678734681af02050d68e5925.1636647623.git.pabeni@redhat.com>
In-Reply-To: <cover.1636647623.git.pabeni@redhat.com>
References: <cover.1636647623.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Allow the MPTCP xmit path to add MP_FASTCLOSE suboption
on RST egress packets.

Additionally reorder related options writing to reduce
the number of conditionals required in the fast path.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c  | 57 +++++++++++++++++++++++++++++++-------------
 net/mptcp/protocol.h |  1 +
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 68a9a1c79200..8a1020e4285c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -768,6 +768,28 @@ static noinline bool mptcp_established_options_rst(struct sock *sk, struct sk_bu
 	return true;
 }
 
+static bool mptcp_established_options_fastclose(struct sock *sk,
+						unsigned int *size,
+						unsigned int remaining,
+						struct mptcp_out_options *opts)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+
+	if (likely(!subflow->send_fastclose))
+		return false;
+
+	if (remaining < TCPOLEN_MPTCP_FASTCLOSE)
+		return false;
+
+	*size = TCPOLEN_MPTCP_FASTCLOSE;
+	opts->suboptions |= OPTION_MPTCP_FASTCLOSE;
+	opts->rcvr_key = msk->remote_key;
+
+	pr_debug("FASTCLOSE key=%llu", opts->rcvr_key);
+	return true;
+}
+
 static bool mptcp_established_options_mp_fail(struct sock *sk,
 					      unsigned int *size,
 					      unsigned int remaining,
@@ -806,11 +828,9 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 		return false;
 
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
-		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
-			*size += opt_size;
-			remaining -= opt_size;
-		}
-		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
+		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
+		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
+		    mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
 			*size += opt_size;
 			remaining -= opt_size;
 		}
@@ -1251,17 +1271,8 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		ptr += 2;
 	}
 
-	/* RST is mutually exclusive with everything else */
-	if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
-		*ptr++ = mptcp_option(MPTCPOPT_RST,
-				      TCPOLEN_MPTCP_RST,
-				      opts->reset_transient,
-				      opts->reset_reason);
-		return;
-	}
-
-	/* DSS, MPC, MPJ and ADD_ADDR are mutually exclusive, see
-	 * mptcp_established_options*()
+	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
+	 * see mptcp_established_options*()
 	 */
 	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
 		struct mptcp_ext *mpext = &opts->ext_copy;
@@ -1447,6 +1458,20 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 				ptr += 1;
 			}
 		}
+	} else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
+		/* RST is mutually exclusive with everything else */
+		*ptr++ = mptcp_option(MPTCPOPT_RST,
+				      TCPOLEN_MPTCP_RST,
+				      opts->reset_transient,
+				      opts->reset_reason);
+		return;
+	} else if (unlikely(OPTION_MPTCP_FASTCLOSE & opts->suboptions)) {
+		/* FASTCLOSE is mutually exclusive with everything else */
+		*ptr++ = mptcp_option(MPTCPOPT_MP_FASTCLOSE,
+				      TCPOLEN_MPTCP_FASTCLOSE,
+				      0, 0);
+		put_unaligned_be64(opts->rcvr_key, ptr);
+		return;
 	}
 
 	if (OPTION_MPTCP_PRIO & opts->suboptions) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e77de7662df0..cee323de1a1c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -422,6 +422,7 @@ struct mptcp_subflow_context {
 		backup : 1,
 		send_mp_prio : 1,
 		send_mp_fail : 1,
+		send_fastclose : 1,
 		send_infinite_map : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
-- 
2.33.1

