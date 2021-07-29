Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A2C70
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 08:40:20 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id j18-20020a17090aeb12b029017737e6c349so5195508pjz.0
        for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 01:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ae+Quuo3lACamn6Amu3Z9WGlEG/gt5BPFAu4zZZKGsM=;
        b=aVVxB4K9aqaKjMRd/lIWkTxGNeDdcpJA8erIpt/l2tcUjOgLoNKSTD6WfJ5HXejUG6
         WuSAJyGLlfTKAqmiCnRUQtqhdBbcrTqU4eF1pxOe1g9zWYEcupd8m0oklvXhoPgswEfz
         bwnzSIyPDzkH/FnKBXq+z5A5tTVN3QwtT68SNHJ2YthUnUfkuHkyh1SCXSSCpR+yQFwu
         JalD8sBRPXt5FW8rI1OIQGZwf18zAFMMKgGG7MBI9I+FkVtfsCjUSm8Lzk1xKN7GzfTa
         veZcG8ML1ALIa/OrOI/M+iA9cdGWfg1YhQQj8YQ9eFnkzrm1kuh/YI+JVfYsID9hGnFj
         vapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ae+Quuo3lACamn6Amu3Z9WGlEG/gt5BPFAu4zZZKGsM=;
        b=kF5lK1/0Yq3akPNFBbMN3E8GVhofvdvm1ablErrkNfVGijKGvbfSOMOgZFZf4JS1js
         EPr0mmUQW15ykq6jKxTn9mpJ+vSUaC0XqSS/9tQxx2JeD94Ad/KnqPFLqBJ5PM/sN7A0
         VP52brFG4kMqkz7IQiMnDIqzNtKJhR0yq/RxOSS9DcmfpwxrS1tsyauitCS0YGocnRLl
         NPcU8QlO3uXZ291oPMZaHZDAFBRBMVZU17hR/FvwFs850E2mEkRe88RKCvk7xX39uTOj
         4LMgRDGaYjRhOyemh/1ZwkGb/khF1PR910YE8l9tsSSmN7goljmq3tUv1H+NtFfLgkAs
         ZV3g==
X-Gm-Message-State: AOAM532Tltn5PooNe0Lr8Kmzo+4cHpnlvEqUAoklgW8ZMtz6monn/m2r
	iqxLEzEumsqFOeNZfxT7igz5shRjZQI=
X-Google-Smtp-Source: ABdhPJyWKxAn9Qk/aMPd+K/hDG80wo24i1yuwr482c+aT0TVMxFdKlvoCgnAJESTef7ePgH5Qd/gEQ==
X-Received: by 2002:a62:ab0a:0:b029:33b:6d08:2a45 with SMTP id p10-20020a62ab0a0000b029033b6d082a45mr3818776pff.38.1627548020460;
        Thu, 29 Jul 2021 01:40:20 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id f5sm2401539pjo.23.2021.07.29.01.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 01:40:20 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v7 mptcp-next 1/5] mptcp: MP_FAIL suboption sending
Date: Thu, 29 Jul 2021 16:40:09 +0800
Message-Id: <d04456a7439e4cdab65aea27a035e5b89d5c0e2a.1627547666.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627547666.git.geliangtang@xiaomi.com>
References: <cover.1627547666.git.geliangtang@xiaomi.com>
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

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 include/net/mptcp.h  |  5 +++-
 net/mptcp/options.c  | 59 +++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  3 +++
 3 files changed, 62 insertions(+), 5 deletions(-)

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
index 753d6ac43bff..6db24cf72ac0 100644
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
+	if (likely(!subflow->send_mp_fail))
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
@@ -795,15 +819,28 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
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
+		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
+			*size += opt_size;
+			remaining -= opt_size;
+			return true;
+		}
+	}
 
 	/* we reserved enough space for the above options, and exceeding the
 	 * TCP option space would be fatal
@@ -1210,6 +1247,20 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
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

