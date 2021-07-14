Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCBB72
	for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 10:42:03 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id s18so1969798pgq.3
        for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 03:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HndaFrbl2FV4bvudnaupK4xxDh2lCvigR1rTj6P2gis=;
        b=htbk85wdxGFqNhLjt9QO005F7hpZ2TTf9N8pMaBwKq2gcUPFaAKVLSOLyv70eoVT81
         7BmLIrut6H1H04pW8RSlZ9VtoMZTRd5SdoQzEAO68lo3/wszXNXUzfR9hmB7V1Dfo9my
         nD+m4LS74979N1n0nbASOtHuaXePSNszYlk30dWly549goD4irfGQdaKSw8bYMp2Ci6x
         01dpF4oldjd1k4iBRe58otgAh89DrvzCALXaD+Qd/pa1CNGq3lk1DKRcSlWhmCn+Y0E1
         ZXDp9CyQinQRJDtLILqJLVsWmGDPJ2OxLmkUb9geGNO8HKZ/dHCSOibx+/8MEpc5Kfkc
         Kbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HndaFrbl2FV4bvudnaupK4xxDh2lCvigR1rTj6P2gis=;
        b=bojAhwcW1179hL85TwVqtrX3gvwhDcKz1vyTTluow+4jZlpVsNlxC37RFnuLi7qyRv
         UDGYUbD78e5gT6XihohrCak/apJvZih++LPgnHY0akssZ24SS0KEzhyEdvu+NngjTmVE
         oFygam0Mh8s4YAaBGMK2cvo1/wvPbY/Qn6fofaXS5N0HIz3v0zgWRE/7I8AX8W3zAkGU
         s2xbkqPethyijZ4RJh42KGJy488bhlhCY/zum9wlIiK0JPs9PvXl/b6bg99vbCs3kvHo
         mv5eLhedT9uam4IKbY7UbTDwhThQWhy69fTtquZTMZ13I8SOng7GqPEfTkrOeA5Lx6ri
         Hiwg==
X-Gm-Message-State: AOAM533M4182epBxdKIOo1Y8egl5VGCwJKl5ZmiMKJlWrwsgufF0fonW
	cBO3RNtnOUG87tf+Aa9KoNWciERCSH6BDw==
X-Google-Smtp-Source: ABdhPJx7h9csFsMTMe+jONVeLN/eaMl2Z/D81x7FO3lbtlZbWFNhlR9ypJ7b1Lc5wRscKuiLJ9qc+Q==
X-Received: by 2002:a05:6a00:9a5:b029:30d:fad7:4515 with SMTP id u37-20020a056a0009a5b029030dfad74515mr9660649pfg.28.1626259322648;
        Wed, 14 Jul 2021 03:42:02 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id x18sm2122904pfh.48.2021.07.14.03.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 03:42:02 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v4 mptcp-next 1/5] mptcp: MP_FAIL suboption sending
Date: Wed, 14 Jul 2021 18:41:53 +0800
Message-Id: <d719e2be68d4f75b1cb392f67516261a59e94c5b.1626258797.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626258797.git.geliangtang@gmail.com>
References: <cover.1626258797.git.geliangtang@gmail.com>
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

An MP_FAIL option could be included in a RST or on the subflow-level
ACK.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/net/mptcp.h  |  5 +++-
 net/mptcp/options.c  | 61 +++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  3 +++
 3 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 8b5af683a818..66fb9a51ead8 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -60,7 +60,10 @@ struct mptcp_out_options {
 	u16 suboptions;
 	u64 sndr_key;
 	u64 rcvr_key;
-	u64 ahmac;
+	union {
+		u64 ahmac;
+		u64 fail_seq;
+	};
 	struct mptcp_addr_info addr;
 	struct mptcp_rm_list rm_list;
 	u8 join_id;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4452455aef7f..db7d0ad417d0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -755,7 +755,7 @@ static bool mptcp_established_options_mp_prio(struct sock *sk,
 	return true;
 }
 
-static noinline void mptcp_established_options_rst(struct sock *sk, struct sk_buff *skb,
+static noinline bool mptcp_established_options_rst(struct sock *sk, struct sk_buff *skb,
 						   unsigned int *size,
 						   unsigned int remaining,
 						   struct mptcp_out_options *opts)
@@ -763,12 +763,36 @@ static noinline void mptcp_established_options_rst(struct sock *sk, struct sk_bu
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
@@ -787,15 +811,30 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
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
+				ret = true;
+			}
+		}
+	}
 
 	/* we reserved enough space for the above options, and exceeding the
 	 * TCP option space would be fatal
@@ -1341,6 +1380,20 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
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
index 0f0c026c5f8b..5a38d850f564 100644
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
 
@@ -425,6 +427,7 @@ struct mptcp_subflow_context {
 		mpc_map : 1,
 		backup : 1,
 		send_mp_prio : 1,
+		send_mp_fail : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1;	    /* ctx can be free at ulp release time */
-- 
2.31.1

