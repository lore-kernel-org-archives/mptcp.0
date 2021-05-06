Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9318172
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 06:40:09 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id m12so4025199pgr.9
        for <mptcp@lists.linux.dev>; Wed, 05 May 2021 23:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vVjigd1qX519ndNq/Ykljn9j8iBmrrAjlLeHceG/21g=;
        b=c6KOt9Btqb957+5tXUeF9ThLAB0jE7Pd39kNeU/v0m4GM7TxKFJKwZk62wWjKdOYgi
         WakU4C1oFZUcR5Dl8JwXO2SpDFk/tJs4x5FtHypT3NTZo6E/HzHefOlr2tOE34QaK832
         vPrN+z0yL52lsZc8G6BdrPWGMrOl/g1oUjyi53VLA6o4SanREAewmKxEpcDZhgvudk26
         Xm81sGKnD8FAs2SCbJAmL2UUNyz8bnKZxPWHcRkgqXmVGw6y++XyPNNVMcLQ7RtUnIuW
         JofT7UILh4vMIO740tYeRUBLA98RCbv7U9upmIhix7r4wSiKLngXXlX6BZju6s+tNjO6
         QYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vVjigd1qX519ndNq/Ykljn9j8iBmrrAjlLeHceG/21g=;
        b=VuPQxow0a0zS3zPUGzdlQ4rbIUyQAP6QhTyLZ8+0g9Lj/zZPlSZez5i+4DSK5CdaQd
         8EY7rwPbYc2gQyNvE1INQ11UPXYh64yk0urv+Sxyvbjg1WNEjH+aqUIsXJB5L0uM0yVR
         KC/uyFYtHBDiqsTVG7LU3G2WBfZGRI1KNvgoPHkVGZvM/KgyuFH6GUYzueDuwA6BUZgG
         mlzWYOeSXnOoK3VuCO8Z4JRVmTkqP1FotbWUHYwdpjb2KqxZ63tynv/jPwAWxVPAjYk4
         2LTKG3MDBhaBH70aDa4iBk5QVz9wi0TzmhSK9Numl4Dxxl/sUbGkNVic/GFvailc94cK
         mjJw==
X-Gm-Message-State: AOAM533HCX2bdM7BZo1gjdn4xo28pYoFmbqSt96uLGGAidZmCnwGswBh
	z2Zy6avQr0zoy48BtaWUuKdoJeBWaXs=
X-Google-Smtp-Source: ABdhPJx7MYAc7ZveHrmgRI/0KA79bVfrO//H5HJkpYNMv2RdSlzfKWLaDfvsvA1o/qGyhN3M5Z8aZw==
X-Received: by 2002:a63:4512:: with SMTP id s18mr2767150pga.275.1620283209089;
        Wed, 05 May 2021 23:40:09 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id a5sm1081580pja.37.2021.05.05.23.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 23:40:08 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 3/3] mptcp: send out MP_FAIL when data checksum fail
Date: Thu,  6 May 2021 14:39:53 +0800
Message-Id: <f46dabaf1055b87b5613b126372d9e506c178264.1620282930.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <bbdc6ded86ae034f443853b6e207aea2b3b2c519.1620282929.git.geliangtang@gmail.com>
References: <cover.1620282929.git.geliangtang@gmail.com> <f158cbfcb748b9b6792d9b316b8fa810e5cb044a.1620282929.git.geliangtang@gmail.com> <bbdc6ded86ae034f443853b6e207aea2b3b2c519.1620282929.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a bad checksum is detected, send out the MP_FAIL suboption.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/subflow.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 659b8842ae3b..efd84ff61015 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -906,6 +906,8 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 	csum = csum_partial(&header, sizeof(header), subflow->map_data_csum);
 	if (unlikely(csum_fold(csum))) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCSUMERR);
+		subflow->send_mp_fail = 1;
+		subflow->fail_seq = subflow->map_seq;
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
 	}
 
-- 
2.31.1

