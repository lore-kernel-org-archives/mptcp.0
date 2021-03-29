Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2885F
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 10:41:20 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id q5so9584804pfh.10
        for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 03:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJ0jwalJrmvHxpkF1A6iMmN4RHW0mrshqU2ZU8tPI/I=;
        b=tlWhU/f4pvI/REDnOn70jSYeSFyVIeAO9F5wwA9U77DtcT2yUFkgs+MOZZcHMgHGg+
         wlU7lVIrhM2d4ut3V0S/p3o6D0Ef41SYpKHkHjRZ86X9kfHala/tMbTQ6f9tG1jBXTaG
         GSoXHajgUkNe4dBgxesZmGph2p3EE1OujyuyNpd4vNgaKWXPR49HgieOCJ4Mn5li0gPd
         WoEFhaG7c6Yb6Wwy7P52g0SYIhzVwsZx+tL06fe23tWQb03G3DZHFNO5oL/J82ypb0LF
         EK8Pl+P0XvVvBAXF4SwA7DqPUV4dVSJBfXk8wpFBRMBjm5gdwAX18wBWRVSSXAomv0J7
         zF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJ0jwalJrmvHxpkF1A6iMmN4RHW0mrshqU2ZU8tPI/I=;
        b=OMUll4ID0E/j9wLq+nKZ0/tYL2jHNLLlQ1pldboKMgYkSdx2g1mKLFblO7hD5eiMyA
         14OCBcrr38dm7grNtTK/H4l0NDVgwPkrid0nd5aflXbw7rl/JxzaL97J55ogZxdjF7v1
         FUZnLOy4lybD9FXsBMiksH9ShGbpS1tThR45ObExM0CgA1y+QuUa4uGrEZPibahLOQoP
         A/ZQVCC2sz9nU05JW73ozyW17wXHsFHTo9qsyvOW4UABFw+PVYc5hII81mN7jiIfk4lD
         h3VuSrCjMxvBGZyXbOi3IUpq0JEIBwCIS5WEs1W0KaF7pCc3CSSfdn1rFvKJEbSXuYTN
         HhVw==
X-Gm-Message-State: AOAM532AY8Yh+WCLNCvjmV+kEXjcgzFX1o4+4uEVJ4Fxd8EF/h9DSVHQ
	3W/Mm5ifnl8YrdRgerYI+Mi0OEX+1abSng==
X-Google-Smtp-Source: ABdhPJxBz39PidcX9ooBqx00V0zhnyHlL7QP/qTJjewjcr/ctzZpv9FFX9n74t/3zt5VLIUzOzKCYA==
X-Received: by 2002:a63:f40b:: with SMTP id g11mr8761968pgi.133.1617014479672;
        Mon, 29 Mar 2021 03:41:19 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id mp1sm14915032pjb.48.2021.03.29.03.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:41:18 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 08/16] mptcp: receive checksum for MP_CAPABLE with data
Date: Mon, 29 Mar 2021 18:40:39 +0800
Message-Id: <4c7e346e9d1005e8838dd8cf742d8324ef7553c0.1617014019.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1c0a240472edcc1afbcb822bd9af3cf03800759e.1617014019.git.geliangtang@gmail.com>
References: <cover.1617014019.git.geliangtang@gmail.com> <ee1d26bf90397d9cbec5e4a165fc369ffab60d3e.1617014019.git.geliangtang@gmail.com> <26ccf630ac9be0aee87f4ccfcefc46515c9d61e8.1617014019.git.geliangtang@gmail.com> <a138746729a11cf08e8236d2c8cdf91226936690.1617014019.git.geliangtang@gmail.com> <14b6923c9fd052b140d5af261dfd2575d94b3e05.1617014019.git.geliangtang@gmail.com> <08ab4ce9f13e954b45d24c9e7842f7a6a9798d54.1617014019.git.geliangtang@gmail.com> <d8a242cfe08b2ab0ccb4752a15c8ea8ef0226ac1.1617014019.git.geliangtang@gmail.com> <1c0a240472edcc1afbcb822bd9af3cf03800759e.1617014019.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new member named csum in struct mptcp_options_received.

When parsing the MP_CAPABLE with data, if the checksum is enabled,
adjust the expected_opsize. If the receiving option length matches the
length with the data checksum, get the checksum value and save it in
mp_opt->csum. And in mptcp_incoming_options, pass it to mpext->csum.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c  | 23 ++++++++++++++++++-----
 net/mptcp/protocol.h |  1 +
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cb423cba5c3b..e3a28633ac2c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -25,6 +25,8 @@ static void mptcp_parse_option(const struct sock *sk,
 			       const unsigned char *ptr, int opsize,
 			       struct mptcp_options_received *mp_opt)
 {
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	u8 subtype = *ptr >> 4;
 	int expected_opsize;
 	u8 version;
@@ -35,10 +37,13 @@ static void mptcp_parse_option(const struct sock *sk,
 	case MPTCPOPT_MP_CAPABLE:
 		/* strict size checking */
 		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
-			if (skb->len > tcp_hdr(skb)->doff << 2)
+			if (skb->len > tcp_hdr(skb)->doff << 2) {
 				expected_opsize = TCPOLEN_MPTCP_MPC_ACK_DATA;
-			else
+				if (READ_ONCE(msk->csum_enabled))
+					expected_opsize += TCPOLEN_MPTCP_DSS_CHECKSUM;
+			} else {
 				expected_opsize = TCPOLEN_MPTCP_MPC_ACK;
+			}
 		} else {
 			if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK)
 				expected_opsize = TCPOLEN_MPTCP_MPC_SYNACK;
@@ -85,7 +90,7 @@ static void mptcp_parse_option(const struct sock *sk,
 			mp_opt->rcvr_key = get_unaligned_be64(ptr);
 			ptr += 8;
 		}
-		if (opsize == TCPOLEN_MPTCP_MPC_ACK_DATA) {
+		if (opsize >= TCPOLEN_MPTCP_MPC_ACK_DATA) {
 			/* Section 3.1.:
 			 * "the data parameters in a MP_CAPABLE are semantically
 			 * equivalent to those in a DSS option and can be used
@@ -97,9 +102,13 @@ static void mptcp_parse_option(const struct sock *sk,
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 		}
-		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d",
+		if (opsize == TCPOLEN_MPTCP_MPC_ACK_DATA + TCPOLEN_MPTCP_DSS_CHECKSUM) {
+			mp_opt->csum = (__force __sum16)get_unaligned_be16(ptr);
+			ptr += 2;
+		}
+		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u",
 			 version, flags, opsize, mp_opt->sndr_key,
-			 mp_opt->rcvr_key, mp_opt->data_len);
+			 mp_opt->rcvr_key, mp_opt->data_len, mp_opt->csum);
 		break;
 
 	case MPTCPOPT_MP_JOIN:
@@ -343,6 +352,7 @@ void mptcp_get_options(const struct sock *sk,
 	mp_opt->mp_prio = 0;
 	mp_opt->reset = 0;
 	mp_opt->csum_reqd = 0;
+	mp_opt->csum = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);
@@ -1110,6 +1120,9 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		}
 		mpext->data_len = mp_opt.data_len;
 		mpext->use_map = 1;
+
+		if (READ_ONCE(msk->csum_enabled))
+			mpext->csum = mp_opt.csum;
 	}
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cfdecfb90776..6be10ebabcd5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -123,6 +123,7 @@ struct mptcp_options_received {
 	u64	data_seq;
 	u32	subflow_seq;
 	u16	data_len;
+	__sum16	csum;
 	u16	mp_capable : 1,
 		mp_join : 1,
 		fastclose : 1,
-- 
2.30.2

