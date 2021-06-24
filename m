Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16772FB7
	for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 12:02:52 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id a127so4949791pfa.10
        for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 05:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=euvRsgH+6zapYNWH/75Urb1wo2ZNhN2Zg1lBQv5J/hg=;
        b=gotZ4dsjuB9BWLpQRYODUgEE5lQjV9qT04aKLKK7CXVdGytW6rmlxEy5B/Cb2dWt8J
         g92VyCvOTfcS8OWPK80fpiMqXgiv7SE2ok1Nj4VvtQYg44Xj7WwmC/dML+su8SNsquhh
         djVmcSApTbuSfiUHnIbDc8KTPi6ZEGCbJ9ArSp8L62VrjjCJzj5pwEtEFXXx3NiFmJmT
         2UO8AdohrPctrA/ImcNN8pty530YVEzmQ0kpID0ahmGuiurujk9ClRmh6v/4xt822ieA
         FAPkVF544Gv2LnPcvu30Mf4rjzDHs5UIwH0TTUBHDmn/K14UhEOgeggRz9Nta/sLXXre
         Ug6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=euvRsgH+6zapYNWH/75Urb1wo2ZNhN2Zg1lBQv5J/hg=;
        b=resJc1186VGs8NSvTxnOaIDgECHs07RS4do4Km5GPYdW3ApmF7F1b0j29DdE0Po/ah
         KLqerCBoktgKUqrUl63NhVT7bHtB1MFZZc7Gjv4uIZ7V4eQr6LE/OnE5KymliCAnltj4
         pj7Y34KWI9aRvvb5GxugdLSHoCfOsItsAYvfswI2K7gRICgxN4hd4jNuCk6Fe5N5rlfH
         pZAjk5VI1BBCLvSv5T1nBT4bo0NZW0W/n2ir0d4g2fY18FjVHeIWWpOekx6XqZoVLuXJ
         9NMBEvAnI0yi3YW8K+FD1woNbYeYa7PoA18A28Ml/uUIAxrlLq3mUOfqiWb5cVT/wDU5
         Iszw==
X-Gm-Message-State: AOAM531hT1p+zbY+G/FejV2FAcyANf/k/KmP3JbbfC/4mnfdA/et3Vbt
	Mr3NarBjYaNeG05F8u9uUId1JsyDLO6LsQ==
X-Google-Smtp-Source: ABdhPJzKp5EDWdTEtFNqb+2NWcqY706CMIa54m8Kdm7p50e5RYfJXvqb54grlHoSpCp+ZKdrsI1NRQ==
X-Received: by 2002:a62:5285:0:b029:2e9:e0d5:67dc with SMTP id g127-20020a6252850000b02902e9e0d567dcmr4753956pfb.79.1624536172459;
        Thu, 24 Jun 2021 05:02:52 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id h24sm2863824pfn.180.2021.06.24.05.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 05:02:52 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 1/5] mptcp: MP_FAIL suboption sending
Date: Thu, 24 Jun 2021 20:02:42 +0800
Message-Id: <a3f24604a58ac18c29284160503bd8fd19169334.1624535761.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624535761.git.geliangtang@gmail.com>
References: <cover.1624535761.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the MP_FAIL suboption sending support.

Add a new flag named send_mp_fail in struct mptcp_subflow_context. If
this flag is set, send out MP_FAIL suboption.

Add a new member fail_seq in struct mptcp_out_options to save the data
sequence number to put into the MP_FAIL suboption.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/options.c  | 46 +++++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h |  3 +++
 3 files changed, 49 insertions(+), 1 deletion(-)

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
index b5850afea343..eac23ceb9843 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -771,6 +771,28 @@ static noinline void mptcp_established_options_rst(struct sock *sk, struct sk_bu
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
+	opts->fail_seq = subflow->map_seq;
+
+	pr_debug("MP_FAIL fail_seq=%llu", opts->fail_seq);
+
+	return true;
+}
+
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts)
@@ -786,8 +808,16 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
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
 
@@ -1334,6 +1364,20 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
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
index 426ed80fe72f..fd36c743c638 100644
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
 
@@ -417,6 +419,7 @@ struct mptcp_subflow_context {
 		mpc_map : 1,
 		backup : 1,
 		send_mp_prio : 1,
+		send_mp_fail : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1;	    /* ctx can be free at ulp release time */
-- 
2.31.1

