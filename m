Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A763771
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 10:41:06 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id l123so9592925pfl.8
        for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v0l6cfuWc9En8A5DePInckAaHbjeoAtD/4L2Ja/zsDU=;
        b=uUixONNfJu1ZQ9zLRVwHx9aclV1C6WXZOE/dxcTpBNwVP9XudGDddZ0iVHc9JW3trU
         un1pZcoswpfvyDUjfKw4scvXaLoOF0kCjpzEJJg0Go1kUbgSynFM5CeNPDjEV2es7FbB
         SrFzJXzOHiaWZSU4z7WYa9or4tkaNgv76NAHvzr+8Z5sAV0oA/m6auaacB7vB7ITpKWp
         x1hepZ+/ZaV6gLnohd8ztzBagn5xKMfWurDcDbJB8YqxkQXjnIXiJ0KkY2VedEy1Sh4G
         lXk5xlf0UEliXH5NKVxH3vrroQ6j4KQ0itcF3tbcd4RLHh3U1+NMYmfIGDH++4CscRHD
         s2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v0l6cfuWc9En8A5DePInckAaHbjeoAtD/4L2Ja/zsDU=;
        b=fvfD4q4+tfl2z9GF9M0GCfbOA7Ji85qivmMUucI3zAhP/HDXHT3npWQUm5XqCEhiOY
         RnjPedTgbONEjtkJc4IW4j78FT+f/MF3F2+8vqvFJhjNm1Ezl+RJ0KS3KPmceaU5Xf85
         ebvlOrMRCIseqUsfQVZcmzLSLPItdVL4z8g9a/YyPgLVo1Az3EoEVN8it9iC3EPc2LO8
         OWshag7lQI5Fm7N6bKyrfvW+d/E17a68wLQn4NY2RXjZjuhK3cM3dUO+kKZc/fi2tCfE
         zexkFd4laRRoDT5+oa47x56aTgN7ToIMwlMQ18zucBOcIwa0ILn/VP+M3TIIB/5Q/C4/
         kPsw==
X-Gm-Message-State: AOAM532C9nah66VTvwY6uVt9LyPY2weApM/UqBLkIXRtHU8mzbeFhHvo
	MCp2R/VNOpC0F+BNDy34yuLDFHfUq9W6dA==
X-Google-Smtp-Source: ABdhPJywYM6a71gyVHqkq58g2UOCU+WH1q5BSVHjcy8zZJALEDt9/O9M46hbVt0u1EUT4Mae0gBjhQ==
X-Received: by 2002:a62:7a09:0:b029:1f1:5cf4:3fd7 with SMTP id v9-20020a627a090000b02901f15cf43fd7mr24213598pfc.66.1617014465573;
        Mon, 29 Mar 2021 03:41:05 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id i4sm17298304pfo.14.2021.03.29.03.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:41:05 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 04/16] mptcp: send out checksum for MP_CAPABLE with data
Date: Mon, 29 Mar 2021 18:40:35 +0800
Message-Id: <14b6923c9fd052b140d5af261dfd2575d94b3e05.1617014019.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <a138746729a11cf08e8236d2c8cdf91226936690.1617014019.git.geliangtang@gmail.com>
References: <cover.1617014019.git.geliangtang@gmail.com> <ee1d26bf90397d9cbec5e4a165fc369ffab60d3e.1617014019.git.geliangtang@gmail.com> <26ccf630ac9be0aee87f4ccfcefc46515c9d61e8.1617014019.git.geliangtang@gmail.com> <a138746729a11cf08e8236d2c8cdf91226936690.1617014019.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the checksum is enabled, send out the data checksum with the
MP_CAPABLE suboption with data.

In mptcp_established_options_mp, save the data checksum in
opts->ext_copy.csum. In mptcp_write_options, adjust the option length and
send it out with the MP_CAPABLE suboption.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c57b2a03b756..1ea41f9f05f3 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -439,6 +439,8 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_ext *mpext;
 	unsigned int data_len;
+	__sum16 csum;
+	u8 len;
 
 	/* When skb is not available, we better over-estimate the emitted
 	 * options len. A full DSS option (28 bytes) is longer than
@@ -458,6 +460,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 	if (subflow->mp_capable) {
 		mpext = mptcp_get_ext(skb);
 		data_len = mpext ? mpext->data_len : 0;
+		csum = mpext ? mpext->csum : 0;
 
 		/* we will check ext_copy.data_len in mptcp_write_options() to
 		 * discriminate between TCPOLEN_MPTCP_MPC_ACK_DATA and
@@ -468,16 +471,22 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		opts->sndr_key = subflow->local_key;
 		opts->rcvr_key = subflow->remote_key;
 		opts->csum_reqd = mptcp_is_checksum_enabled(sock_net(sk));
+		if (opts->csum_reqd)
+			opts->ext_copy.csum = csum;
 
 		/* Section 3.1.
 		 * The MP_CAPABLE option is carried on the SYN, SYN/ACK, and ACK
 		 * packets that start the first subflow of an MPTCP connection,
 		 * as well as the first packet that carries data
 		 */
-		if (data_len > 0)
-			*size = ALIGN(TCPOLEN_MPTCP_MPC_ACK_DATA, 4);
-		else
+		if (data_len > 0) {
+			len = TCPOLEN_MPTCP_MPC_ACK_DATA;
+			if (opts->csum_reqd)
+				len += TCPOLEN_MPTCP_DSS_CHECKSUM;
+			*size = ALIGN(len, 4);
+		} else {
 			*size = TCPOLEN_MPTCP_MPC_ACK;
+		}
 
 		pr_debug("subflow=%p, local_key=%llu, remote_key=%llu map_len=%d",
 			 subflow, subflow->local_key, subflow->remote_key,
@@ -1125,14 +1134,17 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 	     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
 		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
 
-		if (OPTION_MPTCP_MPC_SYN & opts->suboptions)
+		if (OPTION_MPTCP_MPC_SYN & opts->suboptions) {
 			len = TCPOLEN_MPTCP_MPC_SYN;
-		else if (OPTION_MPTCP_MPC_SYNACK & opts->suboptions)
+		} else if (OPTION_MPTCP_MPC_SYNACK & opts->suboptions) {
 			len = TCPOLEN_MPTCP_MPC_SYNACK;
-		else if (opts->ext_copy.data_len)
+		} else if (opts->ext_copy.data_len) {
 			len = TCPOLEN_MPTCP_MPC_ACK_DATA;
-		else
+			if (opts->csum_reqd)
+				len += TCPOLEN_MPTCP_DSS_CHECKSUM;
+		} else {
 			len = TCPOLEN_MPTCP_MPC_ACK;
+		}
 
 		if (opts->csum_reqd)
 			flag |= MPTCP_CAP_CHECKSUM_REQD;
@@ -1155,8 +1167,13 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		if (!opts->ext_copy.data_len)
 			goto mp_capable_done;
 
-		put_unaligned_be32(opts->ext_copy.data_len << 16 |
-				   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
+		if (opts->csum_reqd) {
+			put_unaligned_be32(opts->ext_copy.data_len << 16 |
+					   (__force u16)opts->ext_copy.csum, ptr);
+		} else {
+			put_unaligned_be32(opts->ext_copy.data_len << 16 |
+					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
+		}
 		ptr += 1;
 	}
 
-- 
2.30.2

