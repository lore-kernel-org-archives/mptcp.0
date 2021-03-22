Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A29C6E
	for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 11:37:51 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id u19so8427103pgh.10
        for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 04:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pJKCaTEyvLAv8MXVjqA+7bEj7KqsXMwugveyZV8YiWw=;
        b=QOwnedf5Y9UUuTI0njR78Epj1l15fFrQChVTd0iLf8raGSi1jtHJyAELAuq2kCzikU
         FsnL+TkVgIPA0dEShPOgVHNtXsoDuGRSo92gCR0Chnmd75fXHit+o0e8/xuboVYfK86j
         u1GK1JoYH6u9suLiBJktn9A52Vkf/C3qhmDFbzKEqHywiYfbVY/oUDmaMdOuZjKfGtNd
         x8TK2RJkpaVXJ0FaXTLxbx4IEDHlq1Mezhq51mD4irZwwnDvjEkAEthU3NzFVL7ky/N7
         Hb3D/cYZ+0cNt+KKbSAo5gPJP9sYjbtj/3ungLpvqI3gT981q3S1A56vOdgeAsTrEXD2
         NGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pJKCaTEyvLAv8MXVjqA+7bEj7KqsXMwugveyZV8YiWw=;
        b=XFW8nu1DXf66jLgQS9jqqw0o82ur46d/mbPdAiWqDctl9jV5RJrZ2YtXMBXp+LKfNk
         1OhFyn/IjM4d2wX4eW/HFcIE6eQHUTadwtemwqf6yIf+S3eA/iYdgxdx7L1fvw5pWy0S
         KFpHRhM4s/vmm5AX5ro14hGBsnNr8DIFCtjnKeyM8Y+h3h/UtukMvRki0Ha/V3p0AZTo
         FzT7rUSpSjZbaW2t0QMyLff3iavP6ZuoeVgmupPBIheace+b6/6WTTZIj6pVMIrjQOEt
         npmZ27JxmmrtaIPS1u7a12RW3hcf/6/+ndQzQDzxH7vh9SrUBioxm4AesNtoGxGLGMuj
         B6Ew==
X-Gm-Message-State: AOAM533BCVVXAiF3xiBXTw6e8usGQ7IYm4YTIy0q/h1n4F+5gwN0GtBe
	YYSGpHmLkoxNQWO76v9j+F0=
X-Google-Smtp-Source: ABdhPJwGMaQbVb7tyEj013nWevZOkqNAj/VzFLCZHupAAriFMDa/7oSX7E3lPp1J77Tzu3PBo+AS3A==
X-Received: by 2002:a65:4ccf:: with SMTP id n15mr11146708pgt.405.1616413070822;
        Mon, 22 Mar 2021 04:37:50 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id a19sm13209394pfn.181.2021.03.22.04.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:37:50 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.01.org,
	mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 5/6] mptcp: add the DSS checksum receiving
Date: Mon, 22 Mar 2021 19:37:29 +0800
Message-Id: <7762b80e2310ae0f1a09ec5a4324293d8e9943eb.1616412490.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <643a31ae30f00dd0d1d49834f6e996b3fe637c47.1616412490.git.geliangtang@gmail.com>
References: <cover.1616412490.git.geliangtang@gmail.com> <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com> <7ad133370d4bb939ba69e35203797494181873b0.1616412490.git.geliangtang@gmail.com> <33da8b854a7397e7ecc807b335a0c7e69e023ca6.1616412490.git.geliangtang@gmail.com> <643a31ae30f00dd0d1d49834f6e996b3fe637c47.1616412490.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new member csum in struct mptcp_options_received. In
mptcp_parse_option, parse the checksum value from the receiving DSS, and
save it in mp_opt->csum. In mptcp_incoming_options, pass it to
mpext->csum.

In validate_mapping, use the new function validate_dss_csum to validata
the DSS checksum.

In validate_dss_csum, if the data has been split in different packets,
skip validating.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c  | 13 +++++++++++--
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 69eb15ef9385..ed89f6c2ed49 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -206,9 +206,14 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 
-			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u",
+			if (opsize == expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM) {
+				mp_opt->csum = get_unaligned_be16(ptr);
+				ptr += 2;
+			}
+
+			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%u",
 				 mp_opt->data_seq, mp_opt->subflow_seq,
-				 mp_opt->data_len);
+				 mp_opt->data_len, mp_opt->csum);
 		}
 
 		break;
@@ -339,6 +344,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 	mp_opt->mp_prio = 0;
 	mp_opt->reset = 0;
 	mp_opt->csum_reqd = 0;
+	mp_opt->csum = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);
@@ -1124,6 +1130,9 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		}
 		mpext->data_len = mp_opt.data_len;
 		mpext->use_map = 1;
+
+		if (READ_ONCE(msk->csum_reqd))
+			mpext->csum = mp_opt.csum;
 	}
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f62cea8635f0..51ef3173a2e5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -123,6 +123,7 @@ struct mptcp_options_received {
 	u64	data_seq;
 	u32	subflow_seq;
 	u16	data_len;
+	u16	csum;
 	u16	mp_capable : 1,
 		mp_join : 1,
 		fastclose : 1,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9fec1a273100..2eeea7d527f0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -799,10 +799,45 @@ static bool skb_is_fully_mapped(struct sock *ssk, struct sk_buff *skb)
 					  mptcp_subflow_get_map_offset(subflow);
 }
 
+static bool validate_dss_csum(struct sock *ssk, struct sk_buff *skb)
+{
+	struct csum_pseudo_header header;
+	struct mptcp_ext *mpext;
+	__wsum csum;
+
+	if (!skb)
+		goto out;
+
+	mpext = mptcp_get_ext(skb);
+	if (!mpext || !mpext->use_map || !mpext->csum ||
+	    mpext->data_len != skb->len)
+		goto out;
+
+	header.data_seq = mpext->data_seq;
+	header.subflow_seq = mpext->subflow_seq;
+	header.data_len = mpext->data_len;
+	header.csum = mpext->csum;
+
+	csum = skb_checksum(skb, 0, skb->len, 0);
+	csum = csum_partial(&header, sizeof(header), csum);
+
+	if (csum_fold(csum)) {
+		pr_err("DSS checksum error! data_seq=%llu subflow_seq=%u data_len=%u csum=%u %u",
+		       header.data_seq, header.subflow_seq, header.data_len,
+		       header.csum, csum_fold(csum));
+
+		return false;
+	}
+
+out:
+	return true;
+}
+
 static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	u32 ssn = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 
 	if (unlikely(before(ssn, subflow->map_subflow_seq))) {
 		/* Mapping covers data later in the subflow stream,
@@ -817,6 +852,8 @@ static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
 		warn_bad_map(subflow, ssn + skb->len);
 		return false;
 	}
+	if (READ_ONCE(msk->csum_reqd))
+		validate_dss_csum(ssk, skb);
 	return true;
 }
 
-- 
2.30.2

