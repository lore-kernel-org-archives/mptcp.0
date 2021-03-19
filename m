Return-Path: <SRS0=nStN=IR=lists.01.org=mptcp-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_50,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C91C433DB
	for <mptcp@archiver.kernel.org>; Fri, 19 Mar 2021 07:13:41 +0000 (UTC)
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD28F64F69
	for <mptcp@archiver.kernel.org>; Fri, 19 Mar 2021 07:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD28F64F69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mptcp-bounces@lists.01.org
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5E42C100F227A;
	Fri, 19 Mar 2021 00:13:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=geliangtang@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3D71D100EB341
	for <mptcp@lists.01.org>; Fri, 19 Mar 2021 00:13:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so8065533pjb.0
        for <mptcp@lists.01.org>; Fri, 19 Mar 2021 00:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ryejb1ZuStawcSIZb1ZWChBEdbe6QiP6F7yfiVxe6bs=;
        b=PnJ0QHxn2mzKmxeiMx8a3fLyoL4U1JCgGDj9X1WQEIunRqU9BPBguLKaCMsHoL7cWS
         hlTCQK2xN7sMgVoOdL2XBpuITeZrbkiKahzwQVpiqDHh53ULm22x3W2RtVGt+cO397Zu
         MIAN5eoxw1tPl64m7m8jaZKjUmzV9CqwjnfbM9R/lpQfoh6b690csVBb5a9CgPtKGafp
         aFH4VEzUITUpthqKGtJV8S4/sq+//Z9q1uCFmmW97k8iaZpzlIc3YLkDAmHU7DS7LGgZ
         nLoOh+2EnwRX9A1tEx1RXlcxwAmv0bgoKHPAmOg+o0/7MKDPWzzfjZBSglDRek6Z3kpX
         s6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ryejb1ZuStawcSIZb1ZWChBEdbe6QiP6F7yfiVxe6bs=;
        b=Kwolai0O0H9vUcqhnwRl+KSRGs7/eND8LsSs4i4Z2GY/fVCmLQGEdqI9g/EdTGnK7x
         XsA18tCBwzbO1AaUarcbxNWEVY85Nz9L6Y90aH/hH1HGhwT4FNsl8eXPPeCgpy2eztLf
         jVCLECCDNCovyVMuBDBuAn9/whiMc32g98tSSr5NQ/t3azkIFXd1SUcJ5j+HWd/xvdJn
         Y3mRDIhgKYmbufi/tWF4m2cVpB5yI1MBKiuJoPap6mwq9lElm8NV6hKOdzC/KFYDXVul
         8WRstEbY7HaFf7Myh+OSkqsumOEzqJxTDJzCYec4oKVmpiB8V2cPAMgyR0ImEM+/TedG
         HzbQ==
X-Gm-Message-State: AOAM533TouZnLivS1K2eCKYDT47Nbm34mp56FttJ2w02vtGPO8OnQNX7
	TyGlDh/S0z0CVSclV6b1NMBoijUF2wvDWg==
X-Google-Smtp-Source: ABdhPJz69KGzIFNjn45dJYzQuVixr7f0Unw2aG2M2PQflG6EyG24LJm77NdiaTJ517wq5mMB1ykLug==
X-Received: by 2002:a17:90b:154c:: with SMTP id ig12mr8043289pjb.184.1616138016777;
        Fri, 19 Mar 2021 00:13:36 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id z9sm4004266pgs.32.2021.03.19.00.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 00:13:36 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.01.org
Date: Fri, 19 Mar 2021 15:13:27 +0800
Message-Id: <99e83637796c7294222b5490f528dc77b4d558d7.1616137939.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Message-ID-Hash: NWXMYYDF5HAK7XXWMLXBJLY4WGQCQK2M
X-Message-ID-Hash: NWXMYYDF5HAK7XXWMLXBJLY4WGQCQK2M
X-MailFrom: geliangtang@gmail.com
X-Mailman-Rule-Hits: member-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address
CC: Geliang Tang <geliangtang@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash to "mptcp: use mptcp_addr_info in mptcp_out_options"
List-Id: Discussions regarding MPTCP upstreaming <mptcp.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/message/NWXMYYDF5HAK7XXWMLXBJLY4WGQCQK2M/>
List-Archive: <https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/>
List-Help: <mailto:mptcp-request@lists.01.org?subject=help>
List-Post: <mailto:mptcp@lists.01.org>
List-Subscribe: <mailto:mptcp-join@lists.01.org>
List-Unsubscribe: <mailto:mptcp-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use a whole sa_family_t for the address family.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/net/mptcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 80d98a7db3c6..83f23774b908 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -43,7 +43,7 @@ struct mptcp_rm_list {
 
 struct mptcp_addr_info {
 	u8			id;
-	sa_family_t		family : 4;
+	sa_family_t		family;
 	__be16			port;
 	union {
 		struct in_addr	addr;
-- 
2.30.2
_______________________________________________
mptcp mailing list -- mptcp@lists.01.org
To unsubscribe send an email to mptcp-leave@lists.01.org
