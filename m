Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792996628;
	b=QtiVfSZu3TO4HTXTzZvujHNqSPY+WoU1vBqWLD+xwZO0LH+80z7HYsmUbStQJUapeGEN
	 FK3K8zDWvUPaEh/Bn3Be5yhTe+L17kuu7LRXOACFaJENlkmWd63aMT9KwgB1HPxZo39TQ
	 AUWAsJtbCNgoUKEtVa0UJxGZyfPxhlTGqB9S3WmMq1dLuW21UP7Jn1sOqqWLEIef8hSPW
	 L+Tly7qKIwvAtZrXOnjFBjv5vNK2UamgVn3eupVqnRyBgQl0ZU/9BE8x6kjNP/B+VfvNb
	 mZ/C5SBkH9XpDhHrTyB+3qNTVENdd/vfXqGT1Nj7QnX2kF3uuJeUD8oH0VAppFVrDgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792996628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GMa51ST4XjCQkd4qYSnBFNlKaUJYxzH2Que0Zxlz+Ok=;
	b=IcTzA2HLVcvEP91ewTeSTLzzMI2vGYgKGchsMH5cgUJaJ0X8lDGVjBwJN2t8FUbg4qBX
	 5K+N+A4GSfqAuUDIBhClP+fVyCvRlZzCMxaHQxCU7/lniPRnHZGaRzWCsQd7mU5vWZzIi
	 i6DpvzCG2554hpPsXQ5LR5VGY3SkkLam3M8bDpDxgSbn2zrdie6J2Bg+kuxiyiBE4AGGv
	 N32MMQ5w7MeYFcjBtTPyPfrcMyww7jApjeOTulMmGJBj49HeIwDQftWSSWh6KEd6AzE3N
	 bbyrBQ6C9vbcq7qg3ZZUxC77TZBdhj+KOIAUHik8IckZBTTDMYn6nOg89VtJ7Q07tDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Oe2QY0bh;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569D2606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 06:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 569D2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Oe2QY0bh
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-369f3e9e431so373857eec.1
        for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 23:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792996627; x=1793601427; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GMa51ST4XjCQkd4qYSnBFNlKaUJYxzH2Que0Zxlz+Ok=;
        b=Oe2QY0bhthBz08Df3515YtJNTGLVzWCKhUh8FDWNpd6GlF8HMRrKdYh2f9khQCMJPT
         fVCb/3A5/4EgkQNAjrOWkoNqUXhMl2EDY/ArCjnWEpfEHlFQVzgEoTVqxuw6iDCCYa1a
         NOMwUO87G5cggdyiRcS7Aed3LRGhweZTmJKR5uRvoR6DAGMVaCPrpcT7ciQeOmJY1CFi
         KGy/rI9k/nQuKOPX4+u1xWIviMhe5wDHCx6sPp6TZ5IqdILPdLaOlXZmvfWezqlYKNjN
         iHmyaRVqlBcmnEUr4oaskpsFgH6/a9tO3DfelFxqcueRl27L2TQeMQLmwyf0eq7/fkI8
         oXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792996627; x=1793601427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GMa51ST4XjCQkd4qYSnBFNlKaUJYxzH2Que0Zxlz+Ok=;
        b=HFP6MbfvAoNyF/by8CSmstiEoYP/3B4uYdan1uMLHPcPPmTsGu03Bd+6Op6snn2aIt
         sTx0CNINKvFwT0mAjoGf8VTryKwr+zFgLVmA0I2x6IsFWKwt63CHTku2qKMVWeSmCdrf
         57hPIgwIH2GNFFfrMQ8b1ekJ61sgYAM5K6Kk2K2UNdNCMstX9SmdP0/NrwAVNSUDWpns
         a33VF0Zzr4BMQL5uuklQTS8G+6ORf7t0XTINy0FrxdEd4AWASGHh7HBoWYWQOWxkiCvx
         7G9mKxxoQ6TGZo64Jcqsaf6s9W/hlyv4duHpd/EA2bAGg1aFuURVz8OIVFhn3xjjFEwu
         GDkg==
X-Gm-Message-State: AFq9FYKx3onALNBs0W57nlXlC76/cOO1ocGh26vJNd/UGWuI5AKzprJQ
	09AcPTpjP0W+eqGi/n3cuLmWT99Mg9bdVQ+VPAIOezga8rqk83tWBrAfyShXAw==
X-Gm-Gg: AYBFou0vOnt18/twV5U14vynBewVuEM/k8iwoaV6nLZDJABHji2n8F+DYyxttcKjgUA
	LMoK7rjZamuHnueWn0tosia5cT+W4F+FCkqpRL0hlY1TCPBeYAhpWERRufJVQY82Rz9j86cv7yP
	zstdYKcaUCBhqzd01shn/Jy2brN8gjZVh//fta2kmE6VoHafH+41T4VY9Mkffl0g5Z+zb12Xyp1
	0tNm+EVdVrgf7zOqMKdk8JwJTVj1bXAo9iEmB/OStKtmb/tcuVy7fsp+EGmse/ngBBuXrs/1jqU
	nmQdNHUJtrulxipbKf+wYfDcgHAfnLDZP4iaGzRda+Wq2FWoVy1oNBUlfAUFRpQUuBW772aqblz
	7gMOTIftCQMBuTlodCNXeWj1D5VComAJlN4J1kqdRueZNjVzVgkURCSclVY14XQ242ILxrX+cui
	PbuSghPGVqb0oH0oJYZ/Cr2OaQhJh3EroP+ZKZoXHJ3Vf/PXzGg25mKnx6sYKkfehSaIAvtmYiA
	eIPThLTJvpl30AJoc2JpgKhyk7Q1U1xIl5DY7K2yrOlUWGNPtoGlF9vfHYe7ybOVb/mRWDojr+l
	9ZCSoktHlRczwo29QvNe5uWlb7PaRQlmcdhC39LOMDkT7fhC4A+Hr0aXAFEo8pW61qoBQwfYkmy
	84AAy3MEz+4YRfRDV0V9xpjey
X-Received: by 2002:a05:693c:88ca:b0:366:6c79:212b with SMTP id 5a478bee46e88-369e85043a7mr7149926eec.25.1792996626897;
        Sun, 25 Oct 2026 23:37:06 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ef6a71a4sm21191609eec.8.2026.10.25.23.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:37:06 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v10 3/6] mptcp: pm: in-kernel: add the subflow-retries limit
Date: Mon, 26 Oct 2026 06:36:54 +0000
Message-Id: <20261026063657.2955783-4-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261026063657.2955783-1-anilkaushikwireless@gmail.com>
References: <20261026063657.2955783-1-anilkaushikwireless@gmail.com>
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

