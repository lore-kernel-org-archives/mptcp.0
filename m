Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E289070
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 16:08:40 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id s6so2160343edu.10
        for <mptcp@lists.linux.dev>; Wed, 26 May 2021 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UdeRqN/el4dU4A9dNuI5DWIl6pMo3kfvcBuIGtKGPns=;
        b=Auw0ZIlkVcvvv0QeS3Kv7t93SCR3MVC/lxxFK9oIPFgeyYVtPrzRkjVvNm6QouXENG
         f6pcTiyCKMrZvcmocqk6sqYLRpcUbA/fWhEtKjRu9sbipwpXhdzXTEsKFN4NxUXaxqn3
         E8NMxYyKfh7qG1jVW/drkC2DKIguZ4jj4z9mDjZbomukvxuDkcR8qWlx/ZJjN4UJfXG4
         qC84Adl7PkDNWJ8TkQjmbwR1fKYS6J998SvIBg5meDC8VyhMTd4n+bZ830rKL5HWxtFo
         Ti9Y1etKy68pRpL8OnPbwDdYlf/mtezRXHuqVIK+Zas072Ebiplb//5rycrwIQF6zTyJ
         HsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UdeRqN/el4dU4A9dNuI5DWIl6pMo3kfvcBuIGtKGPns=;
        b=WZx+sWb15MMDBizX2v8NbJ6eYY3DBWxf8CqBxNooaQOCw0cEjupap0vbsZYYiiFADV
         IJNqv8D0nWE28XBkP3n4tKsjynpdk/kYQGtQcu1QEVLqtVuZCffeKmNicQfJdYfISosp
         JGomJO4JzBh/zlGQYmr7kYaHC1yKmqhRmTqhTKoq9IQph8wqS8gRFBkl+66ZYcsc1bdF
         cZDQJ/6Er4QKmT0mkhKFdOWBpQcfqfIomXv0tRnN1eRAVxVgJuy5nytibSrIBlX1cDfO
         rbF0n13gvWCNlSJSOPEOWnERa8FtS6B9fvF/Ua7GfK6Ey+F/3NZnhUYX0igEDsY6pBVA
         bB1Q==
X-Gm-Message-State: AOAM5310mugmxhOfDy0FURCkIZDBKyKiDk4wwko5OZZxslW8y4RBg2Hi
	CSMvbtf3K22hvlCUe1HIFQC3ABghH1c0UjGs
X-Google-Smtp-Source: ABdhPJxNR6+9wwUpzqgFnvavY52xe/4YNQo54Y12VleZ/BLa4JBxHgrnY09XkytTFF98+si52Q+EaQ==
X-Received: by 2002:aa7:da99:: with SMTP id q25mr39406599eds.198.1622045319257;
        Wed, 26 May 2021 09:08:39 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id j7sm931655ejk.51.2021.05.26.09.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:08:38 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [RESEND] [MPTCP][PATCH mptcp-next 1/3] mptcp: MP_FAIL suboption sending
Date: Wed, 26 May 2021 18:08:11 +0200
Message-ID: <f158cbfcb748b9b6792d9b316b8fa810e5cb044a.1620282929.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526160813.4160315-1-matthieu.baerts@tessares.net>
References: <20210526160813.4160315-1-matthieu.baerts@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20210526160811.W9bwqKWzZFyPBsgBAa4XPyH8iqiovjANWYSUuPsASvU@z>

From: Geliang Tang <geliangtang@gmail.com>

This patch added the MP_FAIL suboption sending support.

Add a new flag named send_mp_fail in struct mptcp_subflow_context. If
this flag is set, send out MP_FAIL suboption.

Add a new member fail_seq in struct mptcp_out_options to save the data
sequence number to put into the MP_FAIL suboption.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/options.c  | 46 +++++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h |  4 ++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index cb580b06152f..f48d3b5a3fd4 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -72,6 +72,7 @@ struct mptcp_out_options {
 	u32 nonce;
 	u64 thmac;
 	u32 token;
+	u64 fail_seq;
 	u8 hmac[20];
 	struct mptcp_ext ext_copy;
 #endif
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4179287bd647..485c5a77e71b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -777,6 +777,28 @@ static noinline void mptcp_established_options_rst(struct sock *sk, struct sk_bu
 	opts->reset_reason = subflow->reset_reason;
 }
 
+static bool mptcp_established_options_mp_fail(struct sock *sk,
+					      unsigned int *size,
+					      unsigned int remaining,
+					      struct mptcp_out_options *opts)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+
+	if (!subflow->send_mp_fail)
+		return false;
+
+	if (remaining < TCPOLEN_MPTCP_FAIL)
+		return false;
+
+	*size = TCPOLEN_MPTCP_FAIL;
+	opts->suboptions |= OPTION_MPTCP_FAIL;
+	opts->fail_seq = subflow->fail_seq;
+
+	pr_debug("MP_FAIL fail_seq=%llu", opts->fail_seq);
+
+	return true;
+}
+
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts)
@@ -792,8 +814,16 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	if (unlikely(__mptcp_check_fallback(msk)))
 		return false;
 
+	if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
+		*size += opt_size;
+		remaining -= opt_size;
+		ret = true;
+	}
+
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
-		mptcp_established_options_rst(sk, skb, size, remaining, opts);
+		mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts);
+		*size += opt_size;
+		remaining -= opt_size;
 		return true;
 	}
 
@@ -1338,6 +1368,20 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 				      opts->backup, TCPOPT_NOP);
 	}
 
+	if (OPTION_MPTCP_FAIL & opts->suboptions) {
+		const struct sock *ssk = (const struct sock *)tp;
+		struct mptcp_subflow_context *subflow;
+
+		subflow = mptcp_subflow_ctx(ssk);
+		subflow->send_mp_fail = 0;
+
+		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
+				      TCPOLEN_MPTCP_FAIL,
+				      0, 0);
+		put_unaligned_be64(opts->fail_seq, ptr);
+		ptr += 2;
+	}
+
 	if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
 		*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
 				      TCPOLEN_MPTCP_MPJ_SYN,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 41baa2ffc9a9..ff70b3e97dd0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -26,6 +26,7 @@
 #define OPTION_MPTCP_FASTCLOSE	BIT(8)
 #define OPTION_MPTCP_PRIO	BIT(9)
 #define OPTION_MPTCP_RST	BIT(10)
+#define OPTION_MPTCP_FAIL	BIT(11)
 
 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
@@ -67,6 +68,7 @@
 #define TCPOLEN_MPTCP_PRIO_ALIGN	4
 #define TCPOLEN_MPTCP_FASTCLOSE		12
 #define TCPOLEN_MPTCP_RST		4
+#define TCPOLEN_MPTCP_FAIL		12
 
 #define TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM	(TCPOLEN_MPTCP_DSS_CHECKSUM + TCPOLEN_MPTCP_MPC_ACK_DATA)
 
@@ -419,6 +421,7 @@ struct mptcp_subflow_context {
 		mpc_map : 1,
 		backup : 1,
 		send_mp_prio : 1,
+		send_mp_fail : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1;	    /* ctx can be free at ulp release time */
@@ -433,6 +436,7 @@ struct mptcp_subflow_context {
 	u8	reset_seen:1;
 	u8	reset_transient:1;
 	u8	reset_reason:4;
+	u64	fail_seq;
 
 	long	delegated_status;
 	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */
