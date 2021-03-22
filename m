Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697386E
	for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 11:37:48 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so10341764pjq.5
        for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 04:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZ5jhRRx19UicZJ6IpAdt6agkoRbNlLsUN2q3Q1F1ho=;
        b=UgDhXCIaukSWZZbk/yEfbQwjITAakC77HEP+o8WOQ78f5cexx/VnQ8bOFWaFI/f3wJ
         OlZBZziTOB5/wjZOhf/+2LT/Px/6Q4Am43R6a6NU1JTv2ZbSbb4ECGPNo6ZlHI/q3YPi
         YHh3dm4H+UZCiVp9Nlix3rGxSYP9sY4BdhAs1u0SBpUZq3K7wshF1yGYXIdVx5DcU4vm
         GmAFNQcWYfcdTf15TY95cFiTsO1pPBS3xurMbqH4hw9zU2PaYb3iItbcFO6jsNqD29V4
         rK2efxNuYyd3u382ZJWVp5DtSd4GIAgyGzSVIfZxJ+d/okLXYiFF8GTdhqrEBjXX9MSi
         nkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZ5jhRRx19UicZJ6IpAdt6agkoRbNlLsUN2q3Q1F1ho=;
        b=JrzsPYoo/oBFzTi4stgnnAiozyWq20BARFh/LiU+29MjA15sze3LYJJ+qdbogtQYeQ
         ctBUAWQp3zm4lqiHP5/MbJh3j8ftl2g+2n4sPnr++uLm74lQXTl5CcNgoVZoSDkcnu/x
         2ty3tYK/majuKeCOLet7otj2MsT+rSw7S1WTPQaiLnxHhwrWTt0oXk93fAyfuSEOdVCh
         VEHJcC0mriugajQLOjZRgPosZSmPnyfEwxUtttAJH2cbg4i1wIIywtFkVghHh7LgbDPo
         DzILyGx7cT24MD8viAJeuFc8Pzu+1XjaRKe+twd4+Ds/HOxb783y73fj/GR4ePts9ZK/
         V2wg==
X-Gm-Message-State: AOAM530d8TrMjuNmC6QWf2PoNujhE3hFxjvYGLj7TxtRuYAnhNoIwZ5M
	0Yb/5HSHGI2qskZMNsdb0r0mEPPBuKRo5A==
X-Google-Smtp-Source: ABdhPJw/WxdmcuJcCoFCIS+T8JLgWbLZEIan8eHKI2+FjKP4Iu/AyfvogEnfDjWYBLWRZ9zQTR127w==
X-Received: by 2002:a17:902:343:b029:e6:bc94:48c7 with SMTP id 61-20020a1709020343b02900e6bc9448c7mr26820497pld.72.1616413068045;
        Mon, 22 Mar 2021 04:37:48 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id fa21sm14786155pjb.41.2021.03.22.04.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:37:47 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.01.org,
	mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 4/6] mptcp: add the DSS checksum sending
Date: Mon, 22 Mar 2021 19:37:28 +0800
Message-Id: <643a31ae30f00dd0d1d49834f6e996b3fe637c47.1616412490.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <33da8b854a7397e7ecc807b335a0c7e69e023ca6.1616412490.git.geliangtang@gmail.com>
References: <cover.1616412490.git.geliangtang@gmail.com> <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com> <7ad133370d4bb939ba69e35203797494181873b0.1616412490.git.geliangtang@gmail.com> <33da8b854a7397e7ecc807b335a0c7e69e023ca6.1616412490.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mptcp_established_options_dss, use the new function
mptcp_generate_dss_csum to generate the DSS checksum value.

In mptcp_write_options, send out DSS with the checksum value.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/options.c  | 41 ++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  7 +++++++
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 36fb6907aa6f..869a6d98a72e 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -32,6 +32,7 @@ struct mptcp_ext {
 			frozen:1,
 			reset_transient:1;
 	u8		reset_reason:4;
+	u16		csum;
 };
 
 #define MPTCP_RM_IDS_MAX	8
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index bdced173edff..69eb15ef9385 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -521,6 +521,30 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
 	}
 }
 
+static u16 mptcp_generate_dss_csum(struct sk_buff *skb)
+{
+	struct csum_pseudo_header header;
+	struct mptcp_ext *mpext;
+	__wsum csum;
+
+	if (!skb)
+		return 0;
+
+	mpext = mptcp_get_ext(skb);
+	if (!mpext || !mpext->use_map)
+		return 0;
+
+	header.data_seq = mpext->data_seq;
+	header.subflow_seq = mpext->subflow_seq;
+	header.data_len = mpext->data_len;
+	header.csum = 0;
+
+	csum = skb_checksum(skb, 0, skb->len, 0);
+	csum = csum_partial(&header, sizeof(header), csum);
+
+	return csum_fold(csum);
+}
+
 static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 					  bool snd_data_fin_enable,
 					  unsigned int *size,
@@ -544,8 +568,11 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 
 		remaining -= map_size;
 		dss_size = map_size;
-		if (mpext)
+		if (mpext) {
+			if (msk->csum_reqd)
+				mpext->csum = mptcp_generate_dss_csum(skb);
 			opts->ext_copy = *mpext;
+		}
 
 		if (skb && snd_data_fin_enable)
 			mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
@@ -1304,6 +1331,9 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			flags |= MPTCP_DSS_HAS_MAP | MPTCP_DSS_DSN64;
 			if (mpext->data_fin)
 				flags |= MPTCP_DSS_DATA_FIN;
+
+			if (mpext->csum)
+				len += TCPOLEN_MPTCP_DSS_CHECKSUM;
 		}
 
 		*ptr++ = mptcp_option(MPTCPOPT_DSS, len, 0, flags);
@@ -1323,8 +1353,13 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			ptr += 2;
 			put_unaligned_be32(mpext->subflow_seq, ptr);
 			ptr += 1;
-			put_unaligned_be32(mpext->data_len << 16 |
-					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
+			if (mpext->csum) {
+				put_unaligned_be32(mpext->data_len << 16 |
+						   mpext->csum, ptr);
+			} else {
+				put_unaligned_be32(mpext->data_len << 16 |
+						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
+			}
 		}
 	}
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4fc4871595ef..f62cea8635f0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -333,6 +333,13 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(const struct sock *sk)
 	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, list);
 }
 
+struct csum_pseudo_header {
+	u64 data_seq;
+	u32 subflow_seq;
+	u16 data_len;
+	u16 csum;
+};
+
 struct mptcp_subflow_request_sock {
 	struct	tcp_request_sock sk;
 	u16	mp_capable : 1,
-- 
2.30.2

