Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E7B399364
	for <mptcp@lists.linux.dev>; Sun, 18 Oct 2026 04:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792297088; cv=none; b=HwTdtwcR7xQGh1AufWoDAmEVNMoZivJr9AMJyXfGNQxeCp1rHyA9c52jMWk7YzE1AhoYinrZlyC2h6lTDG10sYEbbVlM/pHHVUxbECo/PYotiP1hY3rvfsq2inKDlhR/T5tZ0/8hG9hEl4x0G/vhyaXJKlc5TMcGFFST3eTmTgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792297088; c=relaxed/simple;
	bh=YDOdwzcux4i2j0KLcd+lKxQdHDLz3mj6m6slza3xTg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NJPk2OFgNiqeojZvm8wFmp9wdTbZIt0IKGh6kcjuv75VfquDUTohrX5fCSZ6UrisK0zRqT5u3nMguwt9ZDoiKXsDuP+lQ1vQfDhH3E6Cn1IQKiqZio0sndmq66T93ntzC+1N+UPE8+O0dLp+f3L6r9YtuPDOhLp6yAjKVBzkJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjL90WFO; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjL90WFO"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3282db206d3so818834eec.0
        for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 21:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792297079; x=1792901879; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iRxa/T4fzT8xBuwCtmCmiFEABn9k8IGHBCfEcpQWbiI=;
        b=bjL90WFOzHdfYkZgSrX4sIMnR3OC0TWnPOZ3OSm6nXAvSil+IZ1UVn+8hLYsAxtAWg
         GlUxalIugpogZ3MUVvwgGDtKYyvUV1nxQOHbM+5Vg8ig9ojNVywBNO6SlBhkpNC3k7Rt
         PkpTyPR+soPnUF4zTCGWcqHpD8JzmM7erSScLU+GbikPOb6YYIVbezQNs8Oc1JsOPe7W
         XsKOotwkPrm4HQTOwoGEMuqVAO1Uk71ZuPhMe4F2JDaYE2gfjxFFSf9YujB3ajrd7eAf
         DzslG/xzDnMfNzh5367Hvl5FQKd0tnA0mKHtvpidHoLGmdeYxlJqcHulWB0w48cQDwe/
         58lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792297079; x=1792901879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iRxa/T4fzT8xBuwCtmCmiFEABn9k8IGHBCfEcpQWbiI=;
        b=IzlWnp1Xhe4TXxQqHE/XbX0qyLUq/eLINZJjMyQbt/aYqapA+jDjXOSrSgX/H31qg8
         RlGC1up7tgroCXVmbQdSnGvPpE4aY53WeaVYGKNhkb2MNXCRUjLGwbUj8dgGRNlckEsQ
         dyvw7RZnnHGqSVe1Nx0ZMuKDyLSHa8tWEqLA4eNxzQaHvS0yTBPeg1FlUx2V1Kmn2INy
         AXvSqL+4B34FdlA9i472hEME8k9nXT3ovizzvNmaFkA02lkHUI3LhdzWnC/Nh4IQ/T/6
         58XAJ1B2hS9AaOHlnW+ofbGrt90eeemhgUQBeOBC9sbZ2Wt2G0A+tjJ+I4U+NLdHIApd
         dGWA==
X-Gm-Message-State: AFq9FYItOUAAm0DQ7GYTowRUlF5lcULQibVoUQyKdfFXItubxc3I/flA
	XdAc//Z7drsuJktL6r+l63cPnVKMA9fX6Z1uEu7KIyCiWmh9bbLoesGiXe7tuA==
X-Gm-Gg: AYBFou3EBupRLj8fJaM3/vbv5z/GROmXeauv3fsC4AA+KCTLSfXBc/cardrEGiVixKt
	aRiOMPAUSNZW2Myxmyb3CO9fF/Mtn6i9ZOfMe5Dl11Qgk7QfIPIZSEVx7w90UKflD39u8o+03dL
	pOH2Qa2eA+MXduNh9P8EN99/mMd8vl9IwF6IVbYJdrORjjONy5kyhBmY0OxKAw7nagXYgyl7SC1
	OpNx16wLOCi1XME7+Dfaa1itljel0dAq0DlF6nJz8WiQrqejXIKOmp2hZcVR4rSE9RpiQfBpFYx
	N9469vqLdedtgVhdj/0ErymtfAj/HoZBImTR+oZdZNLlivP/KoKlMYaFrssiPUeLqcvRCx8LKC9
	I3UCdhO6dRcLucXoIgYo/s7NxjKa427XlMygIi/mHa6CNU+o1OgjCRSd6CsJzsUOZTfMZ4kPwCJ
	SG+o4LLetj+043Q8L+UmAv8Ca0xCaQYZCXxW20OqsNMysc+/671RzxiinlgQyPMkHK+I0MyFu7O
	07yJGOiMDxoacYedmT6l0NOG4ZrQjNQn6suC940gig9GMBS28Hm0rjW5gjYOs3WvKPthMNXN/BN
	DfZQld0nZnARcwbKXMLpGQk/iIDKMYdsHEIyo11IQo16
X-Received: by 2002:a05:7023:a89:b0:188:531f:d48e with SMTP id a92af1059eb24-188531fd89bmr1541511c88.12.1792297078988;
        Sat, 17 Oct 2026 21:17:58 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831919fdfesm17867932c88.7.2026.10.17.21.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 21:17:58 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v6 3/6] mptcp: pm: in-kernel: add the subflow-retries limit
Date: Sun, 18 Oct 2026 04:17:45 +0000
Message-Id: <20261018041748.1655711-4-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261018041748.1655711-1-anilkaushikwireless@gmail.com>
References: <20261018041748.1655711-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new limit for the in-kernel PM, set and read with the other limits:
the number of SYN retries of a subflow re-created after an error, like
the TCP_SYNCNT socket option. 15 by default, about 20 minutes, and 0
to not re-create it. The netlink policy checks the maximum value,
MAX_TCP_SYNCNT.

It is also exposed in struct mptcp_info, in place of the reserved field.

The next patch uses it.

Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
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
index d3014bf57bf3..0379e1495cf4 100644
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
+	/* about 20 minutes with the default RTO values */
+	pernet->limit_subflow_retries = 15;
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

