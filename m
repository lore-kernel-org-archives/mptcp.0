Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8383FE1
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 11:51:32 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id m26so1551285pff.3
        for <mptcp@lists.linux.dev>; Thu, 09 Sep 2021 04:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=km0MgSxm6Kn0tQW3gAMPUaS+5fn6Xw5BCs9fkD362dI=;
        b=MFk+Wty206EdkK7e3s6wN2L+4ACHiysGLSaGBGlykz53rAgMsLtzM7/r2YUdX9Ndvd
         ViOZkzxSGNanHk1BSKsI1uo++zeYs8E4howAVQ0Qaf0cgGho4+qMobk7E0GAsAPvRh91
         +y/o/cSJVSTQmbmMBedCdZ0SUaNdLqXMThBQdq2CV+nkIBf8r/nntgmMlfXNzQby7zM0
         Li1IU6Fps7l7cdFqAp3SvpVbdaqfm1XVR/1iAQEsSgSKYDITRCym9rZWO+e6dzozPMpj
         VVzFmsQyCAEzN+ngIZLcwEaNBH/ZPEPY3Oys2ERwjdy5ahz3lfWX9y43LWZOsQVUlVsd
         RtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=km0MgSxm6Kn0tQW3gAMPUaS+5fn6Xw5BCs9fkD362dI=;
        b=Z8p5sn2feLLri03dsqF438S7bKURwNu7MSfgwDhi4TUCtrOTepaNBPJtFBQYWZYhs7
         gaGpcirO0iJ9J/x5wdEOByKPohbWWbbB5TweFpaMURVLHUVvdEqOi5qgdQj9VOa9Swg9
         RfGouekZ/CIsu6GnnZWsmfKo/GcvLGat+oKpqX7xnu6ctwbB5kJ+GEFg/wfSXUiu9VGc
         ORwgk3lj9kDtRtfOYwxQ+jwdxJCMIlmf6fp2ijenq12B5KczWFjhOwtq2s5aMX9Wq+Ol
         8Kef9RE4PV6jTAmRVOh4eWRtrhPbaszyWopB5eUaH8BUAUcZ1mO9N0aSCIDdFYn9DP46
         iC1A==
X-Gm-Message-State: AOAM532IqHNuwWd5BHaZYOMlUGNIJALvx6MhYPvwxuxq7BVV4+GS909T
	ePDgLmmbia6pM/y2Egx6WcXyFAmb9dI=
X-Google-Smtp-Source: ABdhPJwmBeNInp5niZcl5ajw1IzR0VvnCKtsxxm9st4UF73Y2SeBZXGTNR7gjvNTFjDFibgAzaBNng==
X-Received: by 2002:a63:d456:: with SMTP id i22mr2296905pgj.421.1631188292229;
        Thu, 09 Sep 2021 04:51:32 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id n14sm2458225pjm.5.2021.09.09.04.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 04:51:31 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH mptcp-next v2 7/9] mptcp: add a mib for the infinite mapping sending
Date: Thu,  9 Sep 2021 19:51:09 +0800
Message-Id: <bc4f152b11b7860a1202b19acfb03d610597f922.1631188109.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631188109.git.geliangtang@xiaomi.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added a new mib named MPTCP_MIB_INFINITEMAPTX, increase it
when a infinite mapping has been sent out.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/mib.c      | 1 +
 net/mptcp/mib.h      | 1 +
 net/mptcp/protocol.c | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index b21ff9be04c6..ab55afdcae22 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -24,6 +24,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
+	SNMP_MIB_ITEM("InfiniteMapTx", MPTCP_MIB_INFINITEMAPTX),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
 	SNMP_MIB_ITEM("DSSNoMatchTCP", MPTCP_MIB_DSSTCPMISMATCH),
 	SNMP_MIB_ITEM("DataCsumErr", MPTCP_MIB_DATACSUMERR),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index ecd3d8b117e0..7901f1338d15 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -17,6 +17,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
+	MPTCP_MIB_INFINITEMAPTX,	/* Sent an infinite mapping */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
 	MPTCP_MIB_DSSTCPMISMATCH,	/* DSS-mapping did not map with TCP's sequence numbers */
 	MPTCP_MIB_DATACSUMERR,		/* The data checksum fail */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4ebbbc6f1d01..7036c78ccef2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1280,6 +1280,8 @@ static void mptcp_update_data_checksum(struct sk_buff *skb, int added)
 
 static void mptcp_update_infinite_mapping(struct mptcp_sock *msk, struct mptcp_ext *mpext)
 {
+	struct sock *sk = (struct sock *)msk;
+
 	if (!mpext)
 		return;
 
@@ -1288,6 +1290,7 @@ static void mptcp_update_infinite_mapping(struct mptcp_sock *msk, struct mptcp_e
 	mpext->data_len = 0;
 	mpext->csum = 0;
 
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_INFINITEMAPTX);
 	WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
 	pr_infinite(msk);
 	__mptcp_do_infinite(msk);
-- 
2.31.1

