Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FA76F
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 10:41:30 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id h3so9580916pfr.12
        for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 03:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lkI1YfNezztBFl7RFT7KNKrTmnbZ9JhHiLrL7p0fq2o=;
        b=EBwyOknzWurK/bsidvmLBsICrWJw7fEX96QL2g7pFy+SVsUZQ47JNPRcetA0avAk6c
         9cruxH9iZQgUAmqszg+tBAZNo0U0RH+hob6qOQ+UxT7owb9HgGdbqYpYXv6YvM+VKqoO
         hG5MgatvFpw0FSjf2WEryp7PCCjlg9Ams65ud4IW+4DG7A5UzpqyeIfLquEeHGsXgqiQ
         MzFbXgJVKVNItr7zb9cUBEUCscSV3bgZEDeCWZgS0mnTXXXdSTYC8M5IGYZVHElKoyRB
         /7ToDb7j+4nC/C3QLskHSBMkgOwGA7w7I2sQG/bfDgONtUvGugKYgNNeFkJ5p/oz5OgY
         Oxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lkI1YfNezztBFl7RFT7KNKrTmnbZ9JhHiLrL7p0fq2o=;
        b=CeY01yh37W4LLYF40k2uJAFeTu1k4JnEkfK/Hg61/YHjryO9bIKyFua5+hevGH0lKE
         vdzIeekzavAObr6n0pyaoHYBJ6NwQ9Xq5bvGFNusfmmyttgIu3rod6OfwPdEyLYbg6ou
         UiHl318XkkDKcAxE1DtahduADeLpQQaKkjfKx4sG1DX+L1GmECj1jVQrEDm/doAtU14y
         WOheoGZDdeKkRYivQQOmira9vXo2CszJ7s7CrPatwphdXncSzLFZCA+7Bz4jShfWuzIv
         p7f7DSeZZ01SHpEadsLGxnEpBULNsL5u+QQvY1r6dG75/QpOz2G3yJUPg7rp7LnEPKff
         i0zw==
X-Gm-Message-State: AOAM533aZV98QPMCHaoTiTd36lIC7pOblN8q+1trTsmrtT743R9R/OPN
	jLqkFM3oDAQQt7sv1ciftemOfTgRHUD7Ug==
X-Google-Smtp-Source: ABdhPJxQCd6YOaGORDaeBuJriO0AEjQB4KgD3QYs/UhUybctAOQexEIFUrYfZzqRsdyeu0zwxHfObA==
X-Received: by 2002:a63:1266:: with SMTP id 38mr21929783pgs.427.1617014489248;
        Mon, 29 Mar 2021 03:41:29 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id a18sm11847738pfa.18.2021.03.29.03.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:41:28 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 11/16] mptcp: add the mib for data checksum
Date: Mon, 29 Mar 2021 18:40:42 +0800
Message-Id: <95dff6615e84496cab649de3d74917790f6a571f.1617014019.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <07856073b42a0343f81e6b6e468d6965b693fc5d.1617014019.git.geliangtang@gmail.com>
References: <cover.1617014019.git.geliangtang@gmail.com> <ee1d26bf90397d9cbec5e4a165fc369ffab60d3e.1617014019.git.geliangtang@gmail.com> <26ccf630ac9be0aee87f4ccfcefc46515c9d61e8.1617014019.git.geliangtang@gmail.com> <a138746729a11cf08e8236d2c8cdf91226936690.1617014019.git.geliangtang@gmail.com> <14b6923c9fd052b140d5af261dfd2575d94b3e05.1617014019.git.geliangtang@gmail.com> <08ab4ce9f13e954b45d24c9e7842f7a6a9798d54.1617014019.git.geliangtang@gmail.com> <d8a242cfe08b2ab0ccb4752a15c8ea8ef0226ac1.1617014019.git.geliangtang@gmail.com> <1c0a240472edcc1afbcb822bd9af3cf03800759e.1617014019.git.geliangtang@gmail.com> <4c7e346e9d1005e8838dd8cf742d8324ef7553c0.1617014019.git.geliangtang@gmail.com> <4a289b981d90fcfda872ade12ec94d27d47bc01f.1617014019.git.geliangtang@gmail.com> <07856073b42a0343f81e6b6e468d6965b693fc5d.1617014019.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the mib for the data checksum, MPTCP_MIB_DSSCSUMERR.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/mib.c      | 1 +
 net/mptcp/mib.h      | 1 +
 net/mptcp/protocol.c | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index eb2dc6dbe212..c7042e3317b5 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -25,6 +25,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
+	SNMP_MIB_ITEM("DSSCsumErr", MPTCP_MIB_DSSCSUMERR),
 	SNMP_MIB_ITEM("OFOQueueTail", MPTCP_MIB_OFOQUEUETAIL),
 	SNMP_MIB_ITEM("OFOQueue", MPTCP_MIB_OFOQUEUE),
 	SNMP_MIB_ITEM("OFOMerge", MPTCP_MIB_OFOMERGE),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index f0da4f060fe1..c407358eced8 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -18,6 +18,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
+	MPTCP_MIB_DSSCSUMERR,		/* The DSS checksum fail */
 	MPTCP_MIB_OFOQUEUETAIL,	/* Segments inserted into OoO queue tail */
 	MPTCP_MIB_OFOQUEUE,		/* Segments inserted into OoO queue */
 	MPTCP_MIB_OFOMERGE,		/* Segments merged in OoO queue */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0b4ab35e234a..e414ff940727 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -552,8 +552,10 @@ static bool mptcp_validate_data_checksum(struct sock *ssk)
 
 	csum = csum_partial(&header, sizeof(header), subflow->data_csum);
 
-	if (csum_fold(csum))
+	if (csum_fold(csum)) {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCSUMERR);
 		return false;
+	}
 	subflow->data_csum = 0;
 	subflow->csum_len = 0;
 
-- 
2.30.2

