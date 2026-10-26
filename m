Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019237;
	b=PFgFWfQHDk0XUHWC4Rb7ShXidc8pUeoe4mmpcchvESabjNqRTM/Dd8yfzgu1pgNJjJRH
	 pr/og+eV8052RRby2O0sm8ymhYO4oaLSidkU8uzVxWntBoxG+y/EtG/z7aBo6WFiXSKzl
	 RtquEMx12y2H+92TyyEKa7cUGokwp/UnB7NS+HDmw1y7NBS1kzLaaIXWolkCxhmKKCg07
	 YMBTm2aIqfx8ZZKUO6T/0cpvm/ywDtV4BsOmvdJlx8ExG8FcgxuumNP02QeXzLRk/s/mH
	 FULZ+I5j+QYNY8SndoBhm96qb9AhniK2cahkUInGFzrUOyU2lSycL5thO4bVpeKl2ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GMa51ST4XjCQkd4qYSnBFNlKaUJYxzH2Que0Zxlz+Ok=;
	b=JH2JJp8rtzS86C5UWVRhrvPUEj/ugpvFkh2u0VzHhb4FDPqYJSIEcK28lmW0syjvWtxn
	 ZNiifo6BQjLi9QNT3/OxDtj79qYBs1njOscNPF/xMSwZpXzGTitw68ILWpwuayRo/KGn/
	 lzSVnm2MW9yGS/QQzVAv0usXF96+7aRzNxDP4gYth5v1/v4tv5xls32LjIaih5ZtQP/n5
	 qK1dXlfYE1ykhhWWAz0IVo/EqSTJcPs0jbbIg2bEmPezpdygs3ApurO2Df5U95t6KNyhu
	 bXtyUlKxLwFCg0U8tBBZJ7xHAv34xqBLLNhh9X8aX536R0Cgxm6Tfvy0VBuqHTwZRuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xwl8Wk+O;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED133606A31D
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 12:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED133606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xwl8Wk+O
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35943f55c06so4064413eec.0
        for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 05:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793019236; x=1793624036; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GMa51ST4XjCQkd4qYSnBFNlKaUJYxzH2Que0Zxlz+Ok=;
        b=Xwl8Wk+ORljhkZ6BjysuNwdccLKsAeaEreIelzbGQ57SyMRoU0URKMdoIvoJSZhkCn
         ChGUf7QKylA73xhxFmRvZS72QxEyxNmMrI/2Ulq0sS/XQHaA+gTHA3I/Eag3OdA9cUMs
         7raqKCTJ2amAOpU3oWij8dDR19nTV9lTTkYQj3sRtyaB10lLV12tPoZt1Alz3XDfZlmr
         ORvOVHv0r9s4HEpqNi3/3+oEu+ZF77gvhIZkq1MtmPD7FU15PSZmIDco2aexWgt/mIxe
         r5sT7hhg2kh+lD+KW4uIsGK9MsebAmayv+OWwwFqVrGQhosPyRwZKmdsyopIs6AgxgLM
         NzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793019236; x=1793624036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GMa51ST4XjCQkd4qYSnBFNlKaUJYxzH2Que0Zxlz+Ok=;
        b=xdSQ3Lw4YE8cvIf6Qes4ItwiYAwXmHNL04CsAkyxxGHtbDNatudhXruTDnbrUSDrWo
         MSD2M+HMi/+gcXQQ9sGGq87FSWD5GbJU2Q1dH5tf3klDF2H2UOqK2LRf4CiJ3YaPPTku
         SuZ/CeuEmtk68G8hOKNxswbmY4atvR6lLq542vygp48mfCjsKsvMfw53tGTXQTiSizF8
         Levj2qOB6uoFIbt/tRjUznVfr5FwqGJwSiY6igzEeXGODQxb6pb1kBJfr4ST1hWeBqXJ
         04Jy7I9olElUKFEve+o0ZNtnmhAp6hEbbdvq7gq05De3m5h9YU1jLgIOLs99MCsan1kK
         xMlw==
X-Gm-Message-State: AFq9FYLWQlEuqlHgrIJBVd13DXLBH2afQ3GPg+CACyF0gR6JlyQxgpVs
	s8El7kdzlb2cklFbV+YI5z723WTOxLTnRSzAs0by5c5LE1rv4kmh1RIKeFn9/Q==
X-Gm-Gg: AYBFou2nA4YW8sBeZQCnqj6DUP/VBSeuMMWO7TvJsChHdVAaHO27bUWzANoD9hEpwnR
	8JtEFn/QtlfirMLbDTjq9tLCuSl1ILdLPHelKnB4WXS1K0rgaLKpZxnnAc7bO2T9vy3fPO6p7h9
	gFbPwuHIaGGH0jkVUtXIvP3b80J6XEkltbBo+dMLp91MGcxu5aIkXiBTKqq5GHYWkiE3WgmR4Si
	oiuU64Mz1QA8iv9I4VUl+EgzbuN8tZmecWZd4d8BFbHeLxyEO2zPtOUEd5iTG493o3iHjtA6Z47
	D45fMO0NezkeK4oWysP5KLlQyPQK5z1DpdQc6Tsydq8NKX3BLfnGbQx+ZDs0w76BHy6W/UQHosv
	hzKassXDoIstqCxE6pHRMU+o++Qh7eoMm3I/kWzUna+BcHy/hdOAn1CgvxJBIYypx8NQGUi84fN
	iuDnJ7m6ShJBwyrLzq4atE1likmrZIdASCG+wkWekmPXib2w34iPl6ptX+WIZ/Vj8ms2/sYMM3E
	pDhpE8VbJgdZyKZqIWChhLhVaJZBOavqkOZEcLFB7Q5bAWRCDpxDwdQkP6YxFgCGKEWK5AAxx1F
	pZ5F3K7rbiHMvBn7180j348bA+aWviDJrmCyW7LmzyYY+XwyEs8TK3w2iWKXCglTlvW6BqmFcpb
	fFGR5PoSXC7NYXXO3CgRctfSC
X-Received: by 2002:a05:7300:ea83:b0:369:f3a3:fad6 with SMTP id 5a478bee46e88-369f3a3ff8bmr6774603eec.4.1793019235683;
        Mon, 26 Oct 2026 05:53:55 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f4164886sm18377923eec.7.2026.10.26.05.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:53:55 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v11 3/6] mptcp: pm: in-kernel: add the subflow-retries limit
Date: Mon, 26 Oct 2026 12:53:42 +0000
Message-Id: <20261026125345.3019372-4-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261026125345.3019372-1-anilkaushikwireless@gmail.com>
References: <20261026125345.3019372-1-anilkaushikwireless@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new limit for the in-kernel PM, set and read with the other limits:
the number of SYN retries of a subflow re-created after a timeout, like
the TCP_SYNCNT socket option. The default is the maximum, MAX_TCP_SYNCNT
(127), about 4 hours, and 0 to not re-create it. The netlink policy
checks this maximum value.

It is also exposed in struct mptcp_info, in place of the reserved field.

The next patch uses it.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v9:
     - MAX_TCP_SYNCNT instead of 127 for the default
     - after a timeout, not any error
    v8:
     - the default is the maximum, 127, about 4 hours (Matthieu)
    v6:
     - the netlink policy checks the maximum, no more parse_limit() change
       (netdev Sashiko)
     - the limit works like TCP_SYNCNT, say so (netdev Sashiko)
    v5:
     - new, split from the retry patch (Matthieu)
     - the limit is also in struct mptcp_info (Matthieu)

 include/uapi/linux/mptcp.h |  2 +-
 net/mptcp/pm_kernel.c      | 23 ++++++++++++++++++++++-
 net/mptcp/protocol.h       |  1 +
 net/mptcp/sockopt.c        |  2 ++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 72a5d030154e..d7e3f359773d 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -72,7 +72,7 @@ struct mptcp_info {
 	__u8	mptcpi_subflows_total;
 	__u8	mptcpi_endp_laminar_max;
 	__u8	mptcpi_endp_fullmesh_max;
-	__u8	reserved;
+	__u8	mptcpi_limit_subflow_retries;
 	__u32	mptcpi_last_data_sent;
 	__u32	mptcpi_last_data_recv;
 	__u32	mptcpi_last_ack_recv;
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d3014bf57bf3..7fb4c7874340 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -25,6 +25,7 @@ struct pm_nl_pernet {
 	u8			endp_fullmesh_max;
 	u8			limit_add_addr_accepted;
 	u8			limit_extra_subflows;
+	u8			limit_subflow_retries;
 	u8			next_id;
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 };
@@ -96,6 +97,14 @@ u8 mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_limit_extra_subflows);
 
+u8 mptcp_pm_get_limit_subflow_retries(const struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	return READ_ONCE(pernet->limit_subflow_retries);
+}
+EXPORT_SYMBOL_GPL(mptcp_pm_get_limit_subflow_retries);
+
 static bool has_subflow_daddr(const struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *daddr)
 {
@@ -1419,7 +1428,8 @@ static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	unsigned int rcv_addrs, subflows;
+	unsigned int rcv_addrs, subflows, retries;
+	struct nlattr *attr;
 	int ret;
 
 	spin_lock_bh(&pernet->lock);
@@ -1433,8 +1443,13 @@ int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret)
 		goto unlock;
 
+	/* the maximum, MAX_TCP_SYNCNT, is checked by the policy */
+	attr = info->attrs[MPTCP_PM_ATTR_SUBFLOW_RETRIES];
+	retries = nla_get_u32_default(attr, pernet->limit_subflow_retries);
+
 	WRITE_ONCE(pernet->limit_add_addr_accepted, rcv_addrs);
 	WRITE_ONCE(pernet->limit_extra_subflows, subflows);
+	WRITE_ONCE(pernet->limit_subflow_retries, retries);
 
 unlock:
 	spin_unlock_bh(&pernet->lock);
@@ -1464,6 +1479,10 @@ int mptcp_pm_nl_get_limits_doit(struct sk_buff *skb, struct genl_info *info)
 			READ_ONCE(pernet->limit_extra_subflows)))
 		goto fail;
 
+	if (nla_put_u32(msg, MPTCP_PM_ATTR_SUBFLOW_RETRIES,
+			READ_ONCE(pernet->limit_subflow_retries)))
+		goto fail;
+
 	genlmsg_end(msg, reply);
 	return genlmsg_reply(msg, info);
 
@@ -1618,6 +1637,8 @@ static int __net_init pm_nl_init_net(struct net *net)
 
 	/* Cit. 2 subflows ought to be enough for anybody. */
 	pernet->limit_extra_subflows = 2;
+	/* the maximum: about 4 hours with the default RTOs */
+	pernet->limit_subflow_retries = MAX_TCP_SYNCNT;
 	pernet->next_id = 1;
 	spin_lock_init(&pernet->lock);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3be60da12924..4aa4aedb2ba7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1266,6 +1266,7 @@ u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_fullmesh_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
+u8 mptcp_pm_get_limit_subflow_retries(const struct mptcp_sock *msk);
 
 /* called under PM lock */
 static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 922f6ae5c80c..d3c4abf59ec5 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1075,6 +1075,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 			mptcp_pm_get_endp_laminar_max(msk);
 		info->mptcpi_endp_fullmesh_max =
 			mptcp_pm_get_endp_fullmesh_max(msk);
+		info->mptcpi_limit_subflow_retries =
+			mptcp_pm_get_limit_subflow_retries(msk);
 	}
 
 	if (__mptcp_check_fallback(msk))
-- 
2.25.1

