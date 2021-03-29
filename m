Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB5171
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 10:41:23 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id s21so5804463pjq.1
        for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 03:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tFKSnsc2WoZVY1RmbSvcoM1w1DYMXkJArQ22ZXGSNNo=;
        b=HZoCPWL7MOTbwzh2HGzASWeZM6k4gXTC6RLSqOhEHvg67PgYtV1DDfz7OjnskVEa2D
         gkQer5Wws5LlceMJgzDi+sa6tbA5fWT1nfNNajzFKuZZu0DdRf9uNQF6ylDE+PBnulC/
         I50ry+sfDOTEZdQZ59JPffZmZyXy/Y528sIhEb1qMIvYbVwPyhwmc0oA6VD8Gx5khql6
         2X68me8w2BtX9YjgaLbScTNef9WH5R05qkkvTv0t7M4p34G6Lufb0xzK84l2zSaodZRP
         7AazLLKs8aUBNH6SouK7pBPP9k5IKxSd6G1Fk3p24E2qtwFdQ60StaciXuUhCfH9cHFz
         nQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tFKSnsc2WoZVY1RmbSvcoM1w1DYMXkJArQ22ZXGSNNo=;
        b=BZcDaW6FF0UAYHN2MZZiLQr/JY8C/FqG2aaQJZesjTup/2j7ciXlgE6/Dc7GpM46JF
         DeNuQbPxdCPEydIh9XOpA2ikLlqxTNpA5WA3xGzvr11I5RQ1wabk3oLk7Qx5LgX/zXAV
         yNxwzQm6GzkX1+yfhDsGWGtTXAmvU2S2YgoXNOqSW5B4Jw+tkp7+H/azUeB/Q7o0yPbL
         QgtZ7LCSuAofTrNR4tOvq3zUgLkc1rJm+IWMH9EzUqKV+4L9MSD69ADWu3TJyJMboN3/
         vGl45mqX2rpj73uMb7nhK4f/72Z1mmf0E8PTz1F9N1mg5yOCuNkxzIyzEKJtB+6zWh7V
         YLEA==
X-Gm-Message-State: AOAM531nzZ5R3r2jFqdxRooG9A3F7RbA+Joyl9PPuw1M2AMzFZpGa/bi
	V/TNG3sF17TRhzShCu6z3tF+s5H3e/s5AA==
X-Google-Smtp-Source: ABdhPJzgJ+xPXzE9tvoAvJ7y6ttgL+Bzj9II82KJxc7zkkanHqXixzNnVE1KYrL+NpbVqz+jan9adw==
X-Received: by 2002:a17:902:eb4a:b029:e5:e7d0:5aa with SMTP id i10-20020a170902eb4ab02900e5e7d005aamr27810208pli.3.1617014483232;
        Mon, 29 Mar 2021 03:41:23 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id gf20sm15063072pjb.39.2021.03.29.03.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:41:22 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 09/16] mptcp: receive checksum for DSS
Date: Mon, 29 Mar 2021 18:40:40 +0800
Message-Id: <4a289b981d90fcfda872ade12ec94d27d47bc01f.1617014019.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <4c7e346e9d1005e8838dd8cf742d8324ef7553c0.1617014019.git.geliangtang@gmail.com>
References: <cover.1617014019.git.geliangtang@gmail.com> <ee1d26bf90397d9cbec5e4a165fc369ffab60d3e.1617014019.git.geliangtang@gmail.com> <26ccf630ac9be0aee87f4ccfcefc46515c9d61e8.1617014019.git.geliangtang@gmail.com> <a138746729a11cf08e8236d2c8cdf91226936690.1617014019.git.geliangtang@gmail.com> <14b6923c9fd052b140d5af261dfd2575d94b3e05.1617014019.git.geliangtang@gmail.com> <08ab4ce9f13e954b45d24c9e7842f7a6a9798d54.1617014019.git.geliangtang@gmail.com> <d8a242cfe08b2ab0ccb4752a15c8ea8ef0226ac1.1617014019.git.geliangtang@gmail.com> <1c0a240472edcc1afbcb822bd9af3cf03800759e.1617014019.git.geliangtang@gmail.com> <4c7e346e9d1005e8838dd8cf742d8324ef7553c0.1617014019.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mptcp_parse_option, adjust the expected_opsize, and parse the data
checksum value from the receiving DSS, then save it in mp_opt->csum.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e3a28633ac2c..4646947dea45 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -158,6 +158,7 @@ static void mptcp_parse_option(const struct sock *sk,
 		mp_opt->use_map = (flags & MPTCP_DSS_HAS_MAP) != 0;
 		mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
 		mp_opt->use_ack = (flags & MPTCP_DSS_HAS_ACK);
+		mp_opt->csum_reqd = READ_ONCE(msk->csum_enabled);
 
 		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d",
 			 mp_opt->data_fin, mp_opt->dsn64,
@@ -178,6 +179,9 @@ static void mptcp_parse_option(const struct sock *sk,
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP64;
 			else
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP32;
+
+			if (mp_opt->csum_reqd)
+				expected_opsize += TCPOLEN_MPTCP_DSS_CHECKSUM;
 		}
 
 		/* RFC 6824, Section 3.3:
@@ -185,8 +189,7 @@ static void mptcp_parse_option(const struct sock *sk,
 		 * not been negotiated in the MP_CAPABLE handshake,
 		 * the checksum field MUST be ignored.
 		 */
-		if (opsize != expected_opsize &&
-		    opsize != expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM)
+		if (opsize != expected_opsize)
 			break;
 
 		mp_opt->dss = 1;
@@ -218,9 +221,14 @@ static void mptcp_parse_option(const struct sock *sk,
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 
-			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u",
+			if (mp_opt->csum_reqd) {
+				mp_opt->csum = (__force __sum16)get_unaligned_be16(ptr);
+				ptr += 2;
+			}
+
+			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%u",
 				 mp_opt->data_seq, mp_opt->subflow_seq,
-				 mp_opt->data_len);
+				 mp_opt->data_len, mp_opt->csum);
 		}
 
 		break;
-- 
2.30.2

