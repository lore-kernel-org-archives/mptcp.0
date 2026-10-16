Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1717452B1F3
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166982; cv=none; b=cnJfoAjJegSEsZTXfwobtMPNBpE4YzYUHVzjRtdfEJ2jcD2p66eUuCkRgthiCyivueSMtsBOxYwKJWtx9GZMRlb3a8x4ifmkgvcVERO8Czix7+WTf/+fHL2S5Gs5YOEurvDLl1/+wvLfPziAKuFLzhaYg3g+Wgg4EEtRBYxsj1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166982; c=relaxed/simple;
	bh=bPFpNghEa/fKWnuKp9rOvRcjYCU/W8+zF42iyzkeMo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cbtmfna+3OLrEEwgNBYN6eIYycYjpPwSgwXhaJbZvSQjyGnktGZrzHLKur+O6ikC7E7LuW2y7TooJReLNXVZbeglF6ttG+NPyRf+TK/SwS3WftYTpiF17YT6XVR/EWHNxitQuokKJ4bbv6o0TY+knEMe7LnyMrippDRW3aM2gmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBRQCcVm; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBRQCcVm"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso113836eec.0
        for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 09:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792166975; x=1792771775; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dm9p5Il3jt34qBdNvZ/JgPdUzIu3543f8H1hdITTFrY=;
        b=RBRQCcVm3MkaUOOrx2yPhFjUPSkMzhBL/fX6jBRpHcLIMBUu9v5meVwVhChiHbVam2
         3KqpvvanQWceDJ/Vem2MQHPWZB5OUka5juM42anW22oF9xdOARL0AsWcvEnzF64uhB/d
         tJhJ4xV366OhRrWiIQiKkNVGzWklnjBfchPsCtboxLE3bchsDyZapEQ4H3D4I4ceocuK
         c3yOlyhSDXlQaHV7jnEvE+geWmOKNok3XCsjsblclyBphsC6VHk4qegs4aLN3AyuSRVV
         Fde17QWnIRO8VKtNN/lDerW8PyObpSXJr9UBZdnzhEKLMcf90ZqlCqZMYZJHFSune7jX
         4eGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166975; x=1792771775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dm9p5Il3jt34qBdNvZ/JgPdUzIu3543f8H1hdITTFrY=;
        b=hXVH08jsRBHvET75RJNc6lKD4FIXFRwnbaZZqoy+Ek/biR4rFX2eON/5lEfsGkcuy7
         KyHzdtPq89S9O5XZMaYTnS6E7yU2uzqmBxQmKojTg+CRsH8JNUw2CVE+VaD9MlCL04B4
         iRm2zqk89LB860ps061OeSdGIFCNHqflXVasOV9t+3NL4iiRwFvAa4Gxad7hYYGUmX3w
         /q317VUd1lvaVdYl3Y575OzBTMwpURTjTHpFM9NDmJa8ki4jyKb9pkQqH1/b/F4/Q4eK
         QX4f2kHikBDX0OLbBErjtgPk6XDP6BoRcx2QqEeHTrngfUE/va2v1unpKoJIXp6Z1XJC
         W4+A==
X-Gm-Message-State: AFq9FYIBPgxNHmnP9HJcDgUwIYUCQH/mac+7dVT6RB4SEmp+pBtw4So1
	zsWEC6ZejqDxwg/wQhuCqWJb4PkkElMgcD0fjtFVH/KpGYE/bSa6eD18SKtuvA==
X-Gm-Gg: AYBFou1x6Z7ZVhcf3e2ZnA3qpe5UZqoZqFlP0u9icdInPO+Jgt7j3yO6trM/WPCyAKL
	5rtCmGmHxJndxbMOOkX0fdY8NgTXu2vDLXBgZo7qAoNtVFiqZuVlGpk5T0ycqsyaJG9YY06RNGA
	bei+Uz3ndTrT8WT+b9O17/hUyNqOm+V0yfawbh/gXjUhAd4tlZkru5d9dsQ8IhMlnzB2bn+HyYZ
	H7c4utbTY1F7hdBqK5Au9joA0qkySbItjl8tpykQn5PgDcD9lC1F7QB6iR5SgaHbZECa6fw03BW
	znGwmU5rzLsYFQ8o+pqT0X+KH/EkGgipL/4s7ODZ525m62PKoC14qTvDcoHe0iF+qujl5bMEXx6
	uXfuhKTRT/ViEdiuCGLE7JsyLKJPLb6Htx+ypn0PhFwf6HAB8fItjn8sOqmwm0xL/8r2IVfCVvK
	itvV+q/fFd3sjXT7WrFAsSFKa2swJGKmlaZgdiObyOlFECwL8LnYYXc/o/5XoNYNEsSkRRixp0I
	SZLiWw3VtTmpOofRHofJ++37GGjZjRZscVzmWte96OlQOrj5KZXTsryFmMd70DgMeL2IsCmPx3f
	nr+NM3B7GLVUfmfAaV9QUUezJLNGX2KhiDNt1Msng/Y=
X-Received: by 2002:a05:7301:1748:b0:350:2a5c:56c with SMTP id 5a478bee46e88-361a1862b4dmr261885eec.20.1792166974670;
        Fri, 16 Oct 2026 09:09:34 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6791sm9099098eec.6.2026.10.16.09.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:09:34 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v5 2/7] mptcp: pm: in-kernel: pass the maximum value to parse_limit()
Date: Fri, 16 Oct 2026 16:09:21 +0000
Message-Id: <20261016160926.1155262-3-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261016160926.1155262-1-anilkaushikwireless@gmail.com>
References: <20261016160926.1155262-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The subflow-retries limit added in a later patch does not have the same
maximum value as the other limits. Pass it to parse_limit().

No behaviour change.

Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v5:
     - new, split from the retry patch (Matthieu)

 net/mptcp/pm_kernel.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d3014bf57bf3..b662eb914958 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1399,7 +1399,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 	return msg->len;
 }
 
-static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
+static int parse_limit(struct genl_info *info, int id, unsigned int *limit,
+		       unsigned int max)
 {
 	struct nlattr *attr = info->attrs[id];
 
@@ -1407,10 +1408,9 @@ static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 		return 0;
 
 	*limit = nla_get_u32(attr);
-	if (*limit > MPTCP_PM_SUBFLOWS_MAX) {
+	if (*limit > max) {
 		NL_SET_ERR_MSG_ATTR_FMT(info->extack, attr,
-					"limit greater than maximum (%u)",
-					MPTCP_PM_SUBFLOWS_MAX);
+					"limit greater than maximum (%u)", max);
 		return -EINVAL;
 	}
 	return 0;
@@ -1424,12 +1424,14 @@ int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 
 	spin_lock_bh(&pernet->lock);
 	rcv_addrs = pernet->limit_add_addr_accepted;
-	ret = parse_limit(info, MPTCP_PM_ATTR_RCV_ADD_ADDRS, &rcv_addrs);
+	ret = parse_limit(info, MPTCP_PM_ATTR_RCV_ADD_ADDRS, &rcv_addrs,
+			  MPTCP_PM_SUBFLOWS_MAX);
 	if (ret)
 		goto unlock;
 
 	subflows = pernet->limit_extra_subflows;
-	ret = parse_limit(info, MPTCP_PM_ATTR_SUBFLOWS, &subflows);
+	ret = parse_limit(info, MPTCP_PM_ATTR_SUBFLOWS, &subflows,
+			  MPTCP_PM_SUBFLOWS_MAX);
 	if (ret)
 		goto unlock;
 
-- 
2.25.1

