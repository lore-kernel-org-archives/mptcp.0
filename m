Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792681904;
	b=34XdIjRCjIP2zPmpbndWdf+dsayrN41tQk0N+zuAoDVom0fwqBcyaAcvMbDhYq8fBohC
	 Ak3oovky3ukiL0C+vwy64RPxy7yNu4PL/Rhl+YH3V63ykxx35P6DNzoqkQSxCow0B2jvJ
	 tqC9XSYLaw9kB0kcOnLAf0lYWkmCyUEPFGiqlLvdbTPcsD02Dk37SEtCX/YFunMDxPKak
	 pPXdIN2jMrVQ3dcA6oPlTelvbS3LIxf8B6YpSRDDSEXFJsOnpgRrgtidZSGRu7XZwHLoK
	 /DGy3F8mORt+1e+krKXs9aPLa3UD1AIFXwKWU/hU56lrtHnfP+bmgSAMKrVFZiEGraw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792681904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yFs9vCrwsYaTAeol6U7OIwI0C9Qips/cPC6c/i+H0c8=;
	b=lf4FpN3xS8aI4m25Ir3tM5ZGuSbGnLMDyiAGdhsOcdQbwi8Rt3qcXy5aSwagRO0UC6LH
	 +s+HTxeyPBFlYc/xxegwCx+gv/b9ULzEllmtZRYbVdNzo7STKxmZI2A5rrB+ViSL8fDNv
	 6qbEsEz6teG6oN/zU26rmheG9uYjfnlNE803N7CTl+nmSjgFVn0bK4vLXcsHGPKtIuAhb
	 951kgcq/zbrHt5OEBcHo2EvQaKUZ/KLKkSBMmkE6AjxiIFlv+DgE0eQG8SyoXULyVHu8K
	 bWaIAfNIn0C67Tc1s6FFwk6UCVxeCDSSYbHs3+BAEuRy4etq+btBEn/DkP2t2OPn18w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fiDu7E6R;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D4160A6F66
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 15:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70D4160A6F66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fiDu7E6R
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35f036b17easo116804eec.1
        for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792681902; x=1793286702; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yFs9vCrwsYaTAeol6U7OIwI0C9Qips/cPC6c/i+H0c8=;
        b=fiDu7E6RnDspeFDVUo0uqBiTrJyFje3a3EDMhXUxr04OM2V0khnK5H3ERUJ83odTiB
         5cyzhsL2L4LuayCRxBmGG5rcV88MkS1TxVPDQ5sl+Gp5jIVYOQSWNRhwhVxEF7Z1Ne5D
         Yympx8QROQyizzdpUeMzfCDM9j5Nilr+xtxiHJLcDzTBjDBwUy8oWEm43FdDB8aD0ECw
         koxsl85ZQYL9uBJ2hUwJqPzYRf+0160yOsfOo7RnXqlsssxRvDUh9m4JLawhw6yE15u8
         8SDdC32G0msLM3vg/RPpZq0U2cF6m6QMGdGgEe0lpBxw3vaZ6NGlmK7Kvv0FNh0vRtty
         GqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792681902; x=1793286702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yFs9vCrwsYaTAeol6U7OIwI0C9Qips/cPC6c/i+H0c8=;
        b=d+ekmsGG/LQmTDrnWoeuKdokTU7fnPjhKbLFHx8Sb+y81WPmyw5ACSSfS3OOqHhXGI
         IZh8stx/DveJo1divh4QIdaZBoohJzgb7000GcPyqmD2mWZWuTaoxQq6j+sQpApgV6fF
         g5NPDRuuaRbKGzaCQJpZMVWJ5xvvv7bWW5rka7vWm/u5YmjxyhMmf/VroRZSq723NkU4
         cTg3a874MgVeTaeTXC5p1mdpgfyzmLcvUu2TTgRI7FjJkXjnLeZOdbKe6VmX1USDHD6+
         8z7B7DcZwPiJGolcHg2yTPV88FCLMu8ofDylF+hVCySHo3Id8kuKONfKrADYQ2jNtEB7
         vHuQ==
X-Gm-Message-State: AFq9FYKkC4OW7u7Cr420f2j/Mzf6gTWoQyVSNU5Naa9K0Jp50DxQGgXp
	M/Lc08JBFYWAw0/BcElkCVXmOYkYDy1z9ST9w9tu1Jo5R4rPbJampzd2euWRig==
X-Gm-Gg: AYBFou0YiDidWHejtWfvzUOxjZrQJYd+gg1aC7oOfNEE2qnJDWD5+ZyVUD9Nx5/i8Pr
	B/i2yn1xQ3nGr+VOazYfA6F+PBExLJ8Tk/CqifsHl3JDT1OBWyqq7CR0jzu8lY3o3i4RwHdVJk1
	FoW83bn+SQx/JNcoLgVW1guQproF/zxSqA15M2EvGfXK+jFA5iVnNNkbrgXOGdSQq8mCtSL11tc
	KJynkM5faIm4zipslrP+H4Ubjf2jUqUFE/wV1X5RT0ae3J3OjYTQrxUeVBDqCN4f0yLy8ANijY4
	94J5Uy8ki39vjGHR6QgYJY5pWaL0jcklb1LisXzi5d16BO+7wdTAYKxso/wT9pqQPjHQ+DnAO/c
	lyUzyq3c56gmozYOEMoZmWAprpeciQBSLbY23BdpW2Uu9+b12xei4Ieb0OE5SrY4vqApyqyyyji
	Vs1cVyoKUbpmFgog2cKQLe9F+hEUA2VtlksMWoPpVJn857qZfU0RKLsx4I71Dqx4R0S5o55Jp/T
	pcZE6GQprVpdYAP/XgD74eJRDYwGXmxeXGq7agR8R21iWkPo/oDSqxZydNRjKIt9AsJA3Fj20KJ
	2mbX2NJyvrDvopHt3YcLgt/EVrXAxhhiokoTfMa8y4YM6CBfzVkZ+EbG6No+zCIHHGovcPG/WGS
	W55bobhlm9nUIz2rE47o6it38
X-Received: by 2002:a05:693c:864e:10b0:351:7444:8bfd with SMTP id 5a478bee46e88-367508e2cfemr7870045eec.39.1792681902251;
        Thu, 22 Oct 2026 08:11:42 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741e71eaesm36327560eec.26.2026.10.22.08.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:11:41 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v8 3/6] mptcp: pm: in-kernel: add the subflow-retries limit
Date: Thu, 22 Oct 2026 15:11:27 +0000
Message-Id: <20261022151130.2285198-4-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261022151130.2285198-1-anilkaushikwireless@gmail.com>
References: <20261022151130.2285198-1-anilkaushikwireless@gmail.com>
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
the number of SYN retries of a subflow re-created after an error, like
the TCP_SYNCNT socket option. The default is the maximum, MAX_TCP_SYNCNT
(127), about 4 hours, and 0 to not re-create it. The netlink policy
checks this maximum value.

It is also exposed in struct mptcp_info, in place of the reserved field.

The next patch uses it.

Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
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
index d3014bf57bf3..67bf421d117b 100644
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
+	/* the maximum, MAX_TCP_SYNCNT: about 4 hours with the default RTOs */
+	pernet->limit_subflow_retries = 127;
 	pernet->next_id = 1;
 	spin_lock_init(&pernet->lock);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ed2f363bb915..6d571328aca9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1264,6 +1264,7 @@ u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk);
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

