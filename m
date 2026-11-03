Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695978;
	b=GlpxQCTzmSNxCpcwiyImUDZdATV1DSK1zSZaSspWdDjNXBJGKdT65t/rQRPSHKr/QoZz
	 QgC6xzsKU70PuU1kb/qMxBg4W4NkLHpKg4wQjPcAIWiVEXT2UUgGmPvIoS22yltp67vhK
	 jISHpjHr33JMKBTzXb7wL+M3qcFFGonMDK1oIMmlKxzIse41tOD6ZuAzU7U3dDvzY0RRq
	 o11C5ByrFKbRb/uq3xUcXhIPxj9ExgV514CRu2a3VnOOYbYExKlgzShCVM7kdX8imhmIe
	 Ix6zljtW0lAbHK+qkm0LjP54KpxG+/X4Q+5Wb/0RLZCJXQ1TXaSdLQynHyUsIb9+QvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6PB4DCzsc9cKJM/W4Yiq3L1K4+NCR5yt0/X2juO9xzk=;
	b=2DPhinkkg/syipgFQa6CvdNPnUcD4meMDXEEXAuKCprqyznIG9UaHsbyfeQgebzff6od
	 1NoXP71TlqEejxddbQ7IjFwCNNkta/H1lk8jeucagk61Kt+bOu/6LfXnjuNvJGf3xe5b2
	 k8Pb/qcaL75gSts7pwN654pAspdB1yoHoMWPkIm7j6xgAEioPZtBJOFo3mZ7/Mzg6KY8I
	 6LU/9oQ4FhYL1YVtNASQrEm3c3qnz6A1lkyUgghGmbR4Mm8w9z0T+ICBOMMbtSFAzL9r6
	 hFEFgVq80wsCT81T8IL1JsrVe0atVmidEomKuiXhErNxrOWOFgiYS9d7mBFIw1zTxqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m4YoZga7;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E365606A324
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 08:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E365606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m4YoZga7
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso4922865eec.1
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 00:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793695977; x=1794300777; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6PB4DCzsc9cKJM/W4Yiq3L1K4+NCR5yt0/X2juO9xzk=;
        b=m4YoZga713ZtCK6YUyWoohQaK+rxFPcJZy8fQlOEGHAKIenFzQdl932BFuazNxwCxu
         w0ZbJHyqeJY3xyhtMRk3k2RR26FBH+78SKsJ8y9JRFsX9p3+D1IZIbxY8++wQ2ah+KRh
         6EJ95LOQ+q1QlwGaheU+06Kn9Wx1QTJUKvESAwk5j3e0QhhzxRIpj93jrcCrMxcEHpgI
         MGvi8Du/1Acs107aiNTybMwvyq+ubuvc6U/8FZsVbnmpLtPQGjWG4JsjnXEjPuXTprvh
         l8Ud21EcsoFO9XTbFmg03DjJ6tO2QY7U86rWG5Vtkm73uz6eVpYg7I3LbGoQj93940Ql
         9hXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695977; x=1794300777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6PB4DCzsc9cKJM/W4Yiq3L1K4+NCR5yt0/X2juO9xzk=;
        b=WcjhvuQW2HLFwgxm/BbI8N8YFXzgDqEMVrOnpmYHljA52WQ4nda+Y6gzwBZGH5tfgX
         NhXkbv1eLHrmM8cBgc1IqPl2P18Fa8KI//o0/QBB/V82SgHOFg7+6NxCTjGqiY0fHREm
         MxBcdTRUOYs48czG/5VM0XwUlWrmP3XwJ8zT1zkGrs3JYyyczZLLc7y2Aa5qJX4mcQKn
         9vBLEBwb2Kl5iRnaMWolzQPLo6V49spJS+Ji5HL5wVunPBPEEHGTtI/K5nnLvA1OZwIq
         7223su1gRmTyHrtlXSgRDV7eN/hpXS0VqUMzmgP2xhMASARPqVrQymZ2LSUQa9snZWi6
         UOnQ==
X-Gm-Message-State: APuU4Z/V8ycqbcDh206MXKFLRsDY8F6Dck+7u1occp8o/azDwKp2PMJM
	mGCV016OU4ydoJarVK2Cx7G5tJRjpDD8Z8LmbbxZJ1UlD88t1ZZEVeH9tzdiww==
X-Gm-Gg: AYBFou0FpGNBTeVpzdO6BVep2GLE2xjEnZRmWnFM8C19wKG6T7pDKfJgf/KpdLVmmZz
	qhhh9H8Z9uiGkVDdR4i1W4LP6LWPgTqWlDFYqiIMlPPklpSwOpEA6YNsV5RTjHLbxpTEEm3ttIZ
	jfglWmAD+LxCYiYX16Ira2kTtiIzWTa2gLae3HpmWCpyCtA027poyh7wCUC6ugDzZQIroQtihai
	lMk1bPJTRdi8M4tS2lmCNXCO41H6jdpmiAWSD3tws+fwWw67i6kR6KfItu9ucT1or9yzNGP5DCQ
	GetonY0+wtIfwhKYEYzGxpFUc1CQ64E8X+0wAZGJ5wAgC1ieOeMdmMvaczF8jDGfNB/j/UaAp9L
	vCBXVeb5M3rJ1dRVeU2zPLWaFa7b0ak6bUuKyyCvP4hkrCT17UjkorxtdlsF5pekG0UmGFB605X
	qH99VQYNUbuQwGrFrij8LPfx1aZ5J2fIqoKbJ2RkunfK8jFq7nB8jGsEoVt2N/lfbbYaXrytFpi
	MusYPJSX1+kZKTl5yVakk03afwWlOfHVB7PGiYXOzedBDSgHnD/p1KqYjLUpppd+eKQQsza7wr0
	3NqXqE88peDZFL1sKRGXmg1q0QYL/wweR2lCgxrwD26auxg6oUtf0kNt5JvBK6C5gF867pWKGn4
	yZBa0RMOdOPeLqA/Ui8npIiBGMk95ycCo4d5ZlPxRtKgn9I3Hch9nzJI3o16Dql57PGPvSJ7RJQ
	==
X-Received: by 2002:a05:7301:77c1:b0:35f:b0f:d15c with SMTP id 5a478bee46e88-36a42452cf1mr19348280eec.39.1793695976478;
        Tue, 03 Nov 2026 00:52:56 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm53065635eec.25.2026.11.03.00.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:52:56 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v15 4/7] mptcp: pm: in-kernel: add the subflow-retries limit
Date: Tue,  3 Nov 2026 08:52:41 +0000
Message-Id: <20261103085244.23064-5-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103085244.23064-1-anilkaushikwireless@gmail.com>
References: <20261103085244.23064-1-anilkaushikwireless@gmail.com>
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
    v15:
     - no export for the new getter: it has no module user
     - the limit is read like the two other ones, new patch 2
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
 net/mptcp/pm_kernel.c      | 19 ++++++++++++++++++-
 net/mptcp/protocol.h       |  1 +
 net/mptcp/sockopt.c        |  2 ++
 4 files changed, 22 insertions(+), 2 deletions(-)

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
index 08a36191b5c0..07ce4c7887e1 100644
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
@@ -95,6 +96,13 @@ u8 mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_limit_extra_subflows);
 
+u8 mptcp_pm_get_limit_subflow_retries(const struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	return READ_ONCE(pernet->limit_subflow_retries);
+}
+
 static bool has_subflow_daddr(const struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *daddr)
 {
@@ -1401,8 +1409,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
+	unsigned int rcv_addrs, subflows, retries;
 	struct nlattr **attrs = info->attrs;
-	unsigned int rcv_addrs, subflows;
 
 	/* the maximums are checked by the policy */
 	spin_lock_bh(&pernet->lock);
@@ -1410,9 +1418,12 @@ int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 					pernet->limit_add_addr_accepted);
 	subflows = nla_get_u32_default(attrs[MPTCP_PM_ATTR_SUBFLOWS],
 				       pernet->limit_extra_subflows);
+	retries = nla_get_u32_default(attrs[MPTCP_PM_ATTR_SUBFLOW_RETRIES],
+				      pernet->limit_subflow_retries);
 
 	WRITE_ONCE(pernet->limit_add_addr_accepted, rcv_addrs);
 	WRITE_ONCE(pernet->limit_extra_subflows, subflows);
+	WRITE_ONCE(pernet->limit_subflow_retries, retries);
 	spin_unlock_bh(&pernet->lock);
 
 	return 0;
@@ -1441,6 +1452,10 @@ int mptcp_pm_nl_get_limits_doit(struct sk_buff *skb, struct genl_info *info)
 			READ_ONCE(pernet->limit_extra_subflows)))
 		goto fail;
 
+	if (nla_put_u32(msg, MPTCP_PM_ATTR_SUBFLOW_RETRIES,
+			READ_ONCE(pernet->limit_subflow_retries)))
+		goto fail;
+
 	genlmsg_end(msg, reply);
 	return genlmsg_reply(msg, info);
 
@@ -1595,6 +1610,8 @@ static int __net_init pm_nl_init_net(struct net *net)
 
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

