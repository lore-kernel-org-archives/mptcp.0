Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AAF70
	for <mptcp@lists.linux.dev>; Fri, 16 Jul 2021 03:05:01 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id p14-20020a17090ad30eb02901731c776526so8036269pju.4
        for <mptcp@lists.linux.dev>; Thu, 15 Jul 2021 20:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wdXl/scdu+aOjEJ+XMG9rmUt+DtfUR+HgJGFZLVXi+c=;
        b=qqXqy08PJKnDhOi5RfocswgsClrTWZ2ssNQRzpCAZPm4jEySoMU16z7NhJpI4RoW39
         IP9rPZ1CaKlRNa1ixmlq70LwhCplXtlzCPa1pCXIvBg8G+UhqwX2DfNWQwx6qScM3Kcs
         lpvrSagXzNSRBO94hVwI9+HBi2JOYO1Y6AnCDqLkA/EtP62wTk1PwnARVJs4OZ9M26Qm
         usdOTT4qY4hetG1cMzl2C6EhKBZDoodCfrhx6FEcq/igTC5fdfQ2uLBeifvIqt1XXCN0
         9FsoSe61P28unhrB9B2uQ0X8xZ1TmFbp2/XYj/3eVK8L34LhESAglY8PeN06LGgpNwY1
         dg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdXl/scdu+aOjEJ+XMG9rmUt+DtfUR+HgJGFZLVXi+c=;
        b=CZVPPLnIYZ7ImjF/pMTmz3ZCapvIgVFp9pJk2pMb53W26aEX8YvfqML+1pUia29B/Q
         sJdTIiFM/HYTHaG3rPl1c0wFIAsrWaAFUI3368Gnfz9TitgCbozvNU/oH0rnBc2AMvit
         zlag+YtTKlhoa8FM+LDL8ypEryZiTHxa7F8yKZprJr77RaCo9iwBohWkYfOfIjy/QY3t
         aWAko9qzLfUrwBMWTtpkf+rldMrviji1UeQB7ijrfgfA0EHcJll2IS0KHYu4y9vL8jK+
         GBPPpZryT6O6iMLsnLCTgGn8s3eHlH/EtMDGsj9b17w1z5P8F+KDRNt72dq7VzL7jaN2
         60aw==
X-Gm-Message-State: AOAM530u2vmjBQrgyWg9S0mQ5wgZf+0cBXzcSRJx0arM+8v2AL7NVui4
	xIQ2L4KMM21Q9Vl/7PzXGqYXJiPUr8sgHw==
X-Google-Smtp-Source: ABdhPJwVdQ4XREAYurYp5RDHN4ombNiCFgEsqmAZ8B+rcjKyQlmmWwpJ9mPQJLxn50iNuzwhV9WfVQ==
X-Received: by 2002:a17:90a:17eb:: with SMTP id q98mr13329335pja.183.1626404701375;
        Thu, 15 Jul 2021 20:05:01 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id s15sm8344119pfu.97.2021.07.15.20.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 20:05:01 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Yonglong Li <liyonglong@chinatelecom.cn>,
	Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v9 mptcp-next 3/6] mptcp: fix ADD_ADDR and RM_ADDR maybe flush addr_signal each other
Date: Fri, 16 Jul 2021 11:04:35 +0800
Message-Id: <6a400c9de23c2254e57d472ce7e49d16aec2e294.1626404090.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <26aadb84ac57a74e69d5a81dbdc84c4770117b20.1626404090.git.geliangtang@gmail.com>
References: <cover.1626404090.git.geliangtang@gmail.com> <a742beea506017b809bbb5f52c2b9aaabd18bc4d.1626404090.git.geliangtang@gmail.com> <26aadb84ac57a74e69d5a81dbdc84c4770117b20.1626404090.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonglong Li <liyonglong@chinatelecom.cn>

ADD_ADDR shares pm.addr_signal with RM_ADDR, so after RM_ADDR/ADD_ADDR
has done, we should not clean ADD_ADDR/RM_ADDR's addr_signal.

Co-developed-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 net/mptcp/pm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 311336ce1247..046ad6ad6692 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -259,6 +259,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 			      bool *port, bool *drop_other_suboptions)
 {
 	int ret = false;
+	u8 add_addr;
 
 	spin_lock_bh(&msk->pm.lock);
 
@@ -281,7 +282,11 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 		goto out_unlock;
 
 	*saddr = msk->pm.local;
-	WRITE_ONCE(msk->pm.addr_signal, 0);
+	if (*echo)
+		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
+	else
+		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL);
+	WRITE_ONCE(msk->pm.addr_signal, add_addr);
 	ret = true;
 
 out_unlock:
@@ -293,6 +298,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list)
 {
 	int ret = false, len;
+	u8 rm_addr;
 
 	spin_lock_bh(&msk->pm.lock);
 
@@ -300,16 +306,17 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 	if (!mptcp_pm_should_rm_signal(msk))
 		goto out_unlock;
 
+	rm_addr = msk->pm.addr_signal & ~BIT(MPTCP_RM_ADDR_SIGNAL);
 	len = mptcp_rm_addr_len(&msk->pm.rm_list_tx);
 	if (len < 0) {
-		WRITE_ONCE(msk->pm.addr_signal, 0);
+		WRITE_ONCE(msk->pm.addr_signal, rm_addr);
 		goto out_unlock;
 	}
 	if (remaining < len)
 		goto out_unlock;
 
 	*rm_list = msk->pm.rm_list_tx;
-	WRITE_ONCE(msk->pm.addr_signal, 0);
+	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
 	ret = true;
 
 out_unlock:
-- 
2.31.1

