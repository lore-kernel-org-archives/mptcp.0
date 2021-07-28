Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA67272
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 09:35:21 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id n10so1968680plf.4
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+nucA0AaG/IxWnxJps06L5Bm8x/S0+UE/HTAd/YRgtU=;
        b=eo9MY5kARt2oWibG14q3vZYU+wfxOdn9B8fhkiS3qY+nMFk8RPLbqgkvwsfkgqnK6i
         YcMw68i1PO2a0aUTmUo2Si0wNrnkxlMaXdGwb+qnb0L/JHRCwaKV8/9/QLE6r6vT+eDv
         vhw3J3Mizk9DN7G620z0SBp2NQJsTipvBZ/UsFDsxOaBgDqhBC/TC0PocAfsYHiOPuRa
         F4mXCRUELSNvvcaiFA8cCkuu4UQ5zt1EiWq5mB+G1A9ZzvwrTO7DRNGjIefGfwOjMUBo
         f5DAfWPcKA0wfY0NZrsCWMr0h6eFv+KTd2xlZ2Q+kn9SqPiyeXmtKZu5UAQlK5IQER6Q
         4ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+nucA0AaG/IxWnxJps06L5Bm8x/S0+UE/HTAd/YRgtU=;
        b=BObiFp/i3PRrEdE829S78BOcYwH1ukmmjFtez7g0HcoPiD4tVAsMasSUCJPibS1bt0
         wkfL7nlf8pVRw6kcQZYB7z8wPyoCWsYIUH799xh/RmDgRG/JmXtWYMgozUVAA+bK0XLz
         KcFjQfwPq5rMN0jQkBjtc1aXWmqjJRb5ixr2M79q0kn5qjNHPBmJbn6sZ+PHllUMocA2
         A5Q82a/KXtsChZnzFqf9EyC5uD/H5DS+A5PJ3xn0rZodqT+NnrAinqSmFygLy73jY0Fu
         G5AMjK8mtawiaPp6oluQwQw4X+zp+mrVooDW2gX1ZFec0fhweRv2/AaHvhNe/dnjx8Yg
         0WKw==
X-Gm-Message-State: AOAM531rD5KUV9qidoWuXIOV/bGyQh7bty4Lq55rabi9wp+WM0QeZUmh
	ZKb6Mvo6nHvrQtKYDMsHmry2MlAl0lk=
X-Google-Smtp-Source: ABdhPJw1GPAXOnaZdNo60XgEJ0SsB7JCoRiFSrnVeWHpi4cuhswm+4Pt+eZeDh1HE3jwfIGDDG7OiQ==
X-Received: by 2002:aa7:8806:0:b029:32a:8632:e35e with SMTP id c6-20020aa788060000b029032a8632e35emr28196374pfo.10.1627464921334;
        Wed, 28 Jul 2021 02:35:21 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id v10sm5312560pjd.29.2021.07.28.02.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 02:35:21 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v6 mptcp-next 1/5] mptcp: MP_FAIL suboption sending
Date: Wed, 28 Jul 2021 17:35:08 +0800
Message-Id: <277ac1e6d1fde4c180eba3f1bb1846ea58679915.1627464017.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627464017.git.geliangtang@xiaomi.com>
References: <cover.1627464017.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added the MP_FAIL suboption sending support.

Add a new flag named send_mp_fail in struct mptcp_subflow_context. If
this flag is set, send out MP_FAIL suboption.

Add a new member fail_seq in struct mptcp_out_options to save the data
sequence number to put into the MP_FAIL suboption.

An MP_FAIL option could be included in a RST or on the subflow-level
ACK.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 include/net/mptcp.h  |  5 +++-
 net/mptcp/options.c  | 61 +++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  3 +++
 3 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 3236010afa29..6026bbefbffd 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -74,7 +74,10 @@ struct mptcp_out_options {
 			struct mptcp_addr_info addr;
 			u64 ahmac;
 		};
-		struct mptcp_ext ext_copy;
+		struct {
+			struct mptcp_ext ext_copy;
+			u64 fail_seq;
+		};
 		struct {
 			u32 nonce;
 			u32 token;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 753d6ac43bff..2b15063c8009 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -763,7 +763,7 @@ static bool mptcp_established_options_mp_prio(struct sock *sk,
 	return true;
 }
 
-static noinline void mptcp_established_options_rst(struct sock *sk, struct sk_buff *skb,
+static noinline bool mptcp_established_options_rst(struct sock *sk, struct sk_buff *skb,
 						   unsigned int *size,
 						   unsigned int remaining,
 						   struct mptcp_out_options *opts)
@@ -771,12 +771,36 @@ static noinline void mptcp_established_options_rst(struct sock *sk, struct sk_bu
 	const struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
 	if (remaining < TCPOLEN_MPTCP_RST)
-		return;
+		return false;
 
 	*size = TCPOLEN_MPTCP_RST;
 	opts->suboptions |= OPTION_MPTCP_RST;
 	opts->reset_transient = subflow->reset_transient;
 	opts->reset_reason = subflow->reset_reason;
+
+	return true;
+}
+
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
+	opts->fail_seq = subflow->map_seq;
+
+	pr_debug("MP_FAIL fail_seq=%llu", opts->fail_seq);
+
+	return true;
 }
 
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
@@ -795,15 +819,30 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 		return false;
 
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
-		mptcp_established_options_rst(sk, skb, size, remaining, opts);
+		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
+			*size += opt_size;
+			remaining -= opt_size;
+		}
+		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
+			*size += opt_size;
+			remaining -= opt_size;
+		}
 		return true;
 	}
 
 	snd_data_fin = mptcp_data_fin_enabled(msk);
 	if (mptcp_established_options_mp(sk, skb, snd_data_fin, &opt_size, remaining, opts))
 		ret = true;
-	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, remaining, opts))
+	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, remaining, opts)) {
 		ret = true;
+		if (opts->ext_copy.use_ack) {
+			if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
+				*size += opt_size;
+				remaining -= opt_size;
+				return true;
+			}
+		}
+	}
 
 	/* we reserved enough space for the above options, and exceeding the
 	 * TCP option space would be fatal
@@ -1210,6 +1249,20 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
+	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
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
 	/* RST is mutually exclusive with everything else */
 	if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
 		*ptr++ = mptcp_option(MPTCPOPT_RST,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e8a36ff52af6..b389fec18c89 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -27,6 +27,7 @@
 #define OPTION_MPTCP_PRIO	BIT(9)
 #define OPTION_MPTCP_RST	BIT(10)
 #define OPTION_MPTCP_DSS	BIT(11)
+#define OPTION_MPTCP_FAIL	BIT(12)
 
 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
@@ -68,6 +69,7 @@
 #define TCPOLEN_MPTCP_PRIO_ALIGN	4
 #define TCPOLEN_MPTCP_FASTCLOSE		12
 #define TCPOLEN_MPTCP_RST		4
+#define TCPOLEN_MPTCP_FAIL		12
 
 #define TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM	(TCPOLEN_MPTCP_DSS_CHECKSUM + TCPOLEN_MPTCP_MPC_ACK_DATA)
 
@@ -429,6 +431,7 @@ struct mptcp_subflow_context {
 		mpc_map : 1,
 		backup : 1,
 		send_mp_prio : 1,
+		send_mp_fail : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
-- 
2.31.1

