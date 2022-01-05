Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4758B2CA3
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 15:57:33 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id z29so163798399edl.7
        for <mptcp@lists.linux.dev>; Wed, 05 Jan 2022 07:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NqeY/CeV1WVqI+B6x+o4V50N25t9dNLAiKSFr3ItOYc=;
        b=ISuBzIEIeDbLO6R5YOPnPj3Z9l1KHSf4xFvQWhn4MoX3demSxivdqcNeuN0RgY515U
         BKVHxzqqWMxgQDDH0FmGjoMqMz75NYhxeTu5ZaHMnz2+hvwmwEnObkv+nD3vWT4jycNQ
         vT4Am5o/vHTZrZ4lImf4Ptokx3UquO5uGNKQoYSubmrdZVwtTg4vWd90LFyzTcnum2xf
         29Zq7yv9Z7BU9RRPmpXaYU1tZd4Yc5UZXXXRG6VWQjsGxNXxtYhzh1g9X+bBnHio8o0Y
         Lgy91mxzsNrL5/s94Xhqmp6MZULMiMn2/0elalSRGhGC03TLtI4cY+fzRZ5cIJMYGHgH
         eAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NqeY/CeV1WVqI+B6x+o4V50N25t9dNLAiKSFr3ItOYc=;
        b=Wy8Clk9Hlwe7dYza9PZMY+DxRq2piB56aTcBB4XGXVzI+Ahml1CgumD3gh60B5tCf0
         wSlEMK9syFL6LHTdCET++yqYeyMdW/9tl1xFNZK+3WnyG9vs0yfMIrEQ4qtbx5X4K/tm
         DbKiz+wmetswzlZT19Tdw9Tq8K1TPN6ukB//6g/9Hcj32zmEN8mrDfhQH9q3gNsrB767
         sFt38zrbpLoiLJbXrCsz2Ummbg5naUpi3y/iuGD4JgEdA4/VqCKBMUdrW5R8r8lyXlsB
         sXTNcKdltP+JYx73XCU9oIjLP/Nlnq9tXr2Kt3Oq0rcwWZA5IqTpWmTlRZUZIGw6sxPY
         H/aw==
X-Gm-Message-State: AOAM531ivMjo/MxBk9izuQLmwFJsxsnQ3RAGt7Gq3t8uzSDhnW/h9TFu
	3RilUvSsB6sHps2CDMMsKWcmVn6XM9l+MtQzv9Y=
X-Google-Smtp-Source: ABdhPJzwF5r7ZdWzc0vXlGixKVg9aHCThad4z5modelRmwgPTWv4Gg+f48vAhoex9XVEBy7cpc8gKA==
X-Received: by 2002:a17:906:58c7:: with SMTP id e7mr42138947ejs.146.1641398251345;
        Wed, 05 Jan 2022 07:57:31 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id c30sm12399684ejj.190.2022.01.05.07.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 07:57:30 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 4/8] mptcp: reduce branching when writing MP_FAIL option
Date: Wed,  5 Jan 2022 16:56:58 +0100
Message-Id: <20220105155702.165123-5-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220105155702.165123-1-matthieu.baerts@tessares.net>
References: <20220105155702.165123-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MP_FAIL should be use in very rare cases, either when the TCP RST flag
is set -- with or without an MP_RST -- or with a DSS, see
mptcp_established_options().

Here, we do the same in mptcp_write_options().

Co-developed-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index bbf61dedb4b5..2f94069808a4 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1264,21 +1264,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
-	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
-		const struct sock *ssk = (const struct sock *)tp;
-		struct mptcp_subflow_context *subflow;
-
-		subflow = mptcp_subflow_ctx(ssk);
-		subflow->send_mp_fail = 0;
-
-		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
-				      TCPOLEN_MPTCP_FAIL,
-				      0, 0);
-		put_unaligned_be64(opts->fail_seq, ptr);
-		ptr += 2;
-	}
-
-	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
+	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and FAIL are mutually exclusive,
 	 * see mptcp_established_options*()
 	 */
 	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
@@ -1336,6 +1322,10 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			}
 			ptr += 1;
 		}
+
+		/* We might need to add MP_FAIL options in rare cases */
+		if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions))
+			goto mp_fail;
 	} else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
 		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
 
@@ -1476,6 +1466,25 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		put_unaligned_be64(opts->rcvr_key, ptr);
 		ptr += 2;
 
+		if (OPTION_MPTCP_RST & opts->suboptions)
+			goto mp_rst;
+		return;
+	} else if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions))
+mp_fail:
+	{
+		/* MP_FAIL is mutually exclusive with others except RST */
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
+
 		if (OPTION_MPTCP_RST & opts->suboptions)
 			goto mp_rst;
 		return;
-- 
2.33.1

