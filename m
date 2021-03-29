Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221315F
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 10:41:10 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id e14so4194391plj.2
        for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 03:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WmeYzXP2q9XEMdtitRHsoIKFq3C8mgkLCtHSUGMY6E4=;
        b=YkRhet7iYRHaZz4BP2W3mlHlMxz1yLF+Vdni4Ta1BprRLz5zaFZ3oBfX0t4OmjQDtZ
         Q6uEM0T7xCBXvt6migSfn2UVaru8OB2XHMYg4LDPZ8lMS13haZH+uHQp6O3aKmqipAVJ
         eNldNWBP66sJAv3bIs/BN9iSqr+MU4YqBEJn6J5ZlCKCFCFuEMbAeuJbA5vAm/GJKniY
         Sx9OVOxT25Q96ze07FaetTRREiOyoBx4FLe43jZgd4Sf8dJ2+zVifW00/qvL93rN/UE2
         anoOSmLK1roaSOtGRgobIrOKfVizGKC1fOCbobSB20sn888kLqMVk5Ygkbzc6aYw3K6T
         Dobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WmeYzXP2q9XEMdtitRHsoIKFq3C8mgkLCtHSUGMY6E4=;
        b=lyoQlCYyIgtEw9wDBEbYHOifmMKTH9C3CXNZ4ytwZiK68Xb5tO98yoNtQUy+P7pPkn
         i2fJzbvYF2kjizfwzbv65tZM1Md+X+EjICck61cFkRbwtvjR0vntFUNjik4/6h+OblNX
         u+BpsWLYUJiwQLB2BLUpcEJjKEwpCO/SGvOrK5WufFp4AlY6InLhqOdFkrW45j90WcSX
         KcD63bQqV8gxQpAatIisUL1dQVmzASSI0UiUTXlLJzPK/WyAXnJQoQRFa4Plv/Kjl/EJ
         4ADwc7uWD1VD79mIqXmEQr+FS2OXXw1x4mdi/EvbWbJi0RRstJ/srtFXFKdbhxoz/Xpw
         qwzg==
X-Gm-Message-State: AOAM533nm4UpxKmkqWPmwoSx2MQk5jQHuvKjW+m1mLFN9JlkUZ8dyZ3a
	aIACAsqjjaaZHC7B5vNtaCP3755kRu3SyQ==
X-Google-Smtp-Source: ABdhPJxLO3VDwftd7Jtzzd8CdtfBHNsyfmmztzTKkpFirDiiDOmshJDtvlHQuhZnwzyVYSuHf4DiIw==
X-Received: by 2002:a17:90a:3cc6:: with SMTP id k6mr25851857pjd.212.1617014469277;
        Mon, 29 Mar 2021 03:41:09 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id f23sm16323605pfa.85.2021.03.29.03.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:41:08 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 05/16] mptcp: send out checksum for DSS
Date: Mon, 29 Mar 2021 18:40:36 +0800
Message-Id: <08ab4ce9f13e954b45d24c9e7842f7a6a9798d54.1617014019.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <14b6923c9fd052b140d5af261dfd2575d94b3e05.1617014019.git.geliangtang@gmail.com>
References: <cover.1617014019.git.geliangtang@gmail.com> <ee1d26bf90397d9cbec5e4a165fc369ffab60d3e.1617014019.git.geliangtang@gmail.com> <26ccf630ac9be0aee87f4ccfcefc46515c9d61e8.1617014019.git.geliangtang@gmail.com> <a138746729a11cf08e8236d2c8cdf91226936690.1617014019.git.geliangtang@gmail.com> <14b6923c9fd052b140d5af261dfd2575d94b3e05.1617014019.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mptcp_write_options, If the checksum is enabled, adjust the option
length and send out the data checksum with DSS suboption.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1ea41f9f05f3..0f9abe8ea7cd 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -547,6 +547,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	bool ret = false;
 	u64 ack_seq;
 
+	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
 	mpext = skb ? mptcp_get_ext(skb) : NULL;
 
 	if (!skb || (mpext && mpext->use_map) || snd_data_fin_enable) {
@@ -1325,6 +1326,9 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			flags |= MPTCP_DSS_HAS_MAP | MPTCP_DSS_DSN64;
 			if (mpext->data_fin)
 				flags |= MPTCP_DSS_DATA_FIN;
+
+			if (opts->csum_reqd)
+				len += TCPOLEN_MPTCP_DSS_CHECKSUM;
 		}
 
 		*ptr++ = mptcp_option(MPTCPOPT_DSS, len, 0, flags);
@@ -1344,8 +1348,13 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			ptr += 2;
 			put_unaligned_be32(mpext->subflow_seq, ptr);
 			ptr += 1;
-			put_unaligned_be32(mpext->data_len << 16 |
-					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
+			if (opts->csum_reqd) {
+				put_unaligned_be32(mpext->data_len << 16 |
+						   (__force u16)mpext->csum, ptr);
+			} else {
+				put_unaligned_be32(mpext->data_len << 16 |
+						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
+			}
 		}
 	}
 
-- 
2.30.2

