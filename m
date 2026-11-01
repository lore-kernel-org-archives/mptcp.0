Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793517663;
	b=nf+RRAwvEdn1KOCdOsfxBVbj4jLKRIDJNzP8Wd3HONh6IavR2XWdrh4bhs3gQJTkyA80
	 UHu8GB7C/h9SqcxJec1Fuo9OgZvv9hLgbpWDTjVc3P8en6tG2sFryJLyMjWex+015jBXm
	 t1cPNs07hONHvYk8eXysfIL+NaTBYeeVkJGTsvjlntoG2FXU/ZQhgo/1SXLVVXpgr6B5M
	 3e4qgt9RoyfJqqIXd+Cib2es6cYWhncy4ldiRYujstwSORg8PLKQZb62H79VYfbvNRRPi
	 QMjNzlM4vwuxZ0EKM7zuVBvHpsl3Chgv6W3ZRO8MZuOKftWgmLjPieWJd46Ea8DDzWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793517663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GMa51ST4XjCQkd4qYSnBFNlKaUJYxzH2Que0Zxlz+Ok=;
	b=2uGc4MtCrmj+7j1dwjSsJVZHzwywOnAKL3e6vrCOkkF5aPyeKofzuM5+j+c1kSXBTJg9
	 F/sXpLK8JDT+ZbxBERogOviploB2LzckjQvznlxBdt7GlyCHgmtNg2WJIaq+n5VVe5XlM
	 1o4A/T3oq7krZI5Kj8dTZ8NXzz1FF1Pq9iZH5ibrFWFWYADyf4huRElpWObf+qbgnvGeI
	 E1n6hsO5i6md8tBtzRoc7UTv2JEvE02ajwzKwoHWvf5RMOuzVBU4ldudL/Uqbdtn0Wq3Y
	 qkpwfEUJ+Ql7I7edFjPrrKAtKyCQdytggu1bouzQ9M/GIpy/SwY+qE/vm6T2GDUOFcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=smS7w95Y;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C22606A327
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 07:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1C22606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=smS7w95Y
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b1ce85287aso33301c88.0
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 00:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793517662; x=1794122462; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GMa51ST4XjCQkd4qYSnBFNlKaUJYxzH2Que0Zxlz+Ok=;
        b=smS7w95Yi6umm6oCRRXiAQLmY/K24sWdVy7LBT2YNQkBZBu3QN790v7z4VOt6DRxET
         5ShoFqQFkeG9eMuDGEH8x85CatpQDx02DnjgDz+pp+MVrPNTFLOyJ6zCudZYNNfIreXg
         E1jYWdmHGyqlfZuFvafAHCsoUQWNQ8usErdPXF3jUtXnN3U6DS5JetiXxS1a+yLAW+ok
         c1Z2APji9SnGUGyIIdNE5ScjjU45BpetEhg18dfuVWd+atvsnxCPDtGv7/jVX8p5VAd2
         q8vIa3RPJtOfQwTP4+VgCoLRMTrqUpO6vlFDdKHJgL+mOpG72MJfltq1WQl0cQZO1JDK
         dEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793517662; x=1794122462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GMa51ST4XjCQkd4qYSnBFNlKaUJYxzH2Que0Zxlz+Ok=;
        b=wNBTey9+hzHfX1+a3Sad4aYiPkTqcjhjGoHo67Vo2M2ZiTZfSDy8wmcMVwEtU75tTS
         0/6RqKB5nHcRcvSFPFI2lfwhKr3k5/QXOjCgXDpQvpRZG3qLaPjmslEQ2hdRZH+zxx5D
         79olG60IVtAPEfk2HmVRoftw5wcClVpBE0EsD/GxoK5/xSVutvX7zlWJ4mWqecTkiytm
         ZxFXNHKOXA1kCuQGQpujZEFln2J6Ck7Hyk5Z4oDHQrQosEt+uISHbRRX6U61iPu2vpS4
         UMFOCskiFHY1NoUU997NRtkfmMczwU+P6DNPBpZx7hpZcCe3dliQ0yx5scW4O4I5isyD
         vNyw==
X-Gm-Message-State: AFq9FYIzL9imh6u5wJeVtT8ULQbz8iBIinysNakquNaUzfHw1QmabjxL
	nxR7wsG86Y1IXQbkQ1Lz7S67sC/MiG6EhiJs9zpFW8N2t93W8nN3kKHmJk532g==
X-Gm-Gg: AYBFou0/mPLoRNBoKGm4cXHMw+5rgj9f8CS0kL+h26PT37a0GNf2o3t0gZyjrj9Qrb2
	uZMMPm2/QtkBQeKvx2FSb8aoM7+wmgvjly2m8fUsuiTZ9Kn4BzsXKi1KPU3/Yz9wkhbwr+ut+gZ
	jSIctVrvixl1xlLvZkzkAMVMCyeFEX5sqC9QsKi3TUG66TNr7F++AkHnSPNsUNfoctqv7rPNPYa
	BJqa3EddcZYA/6YqxJyg/VwyXQuZZw0W2FmQO6+uaOzYnON8iWwk+efWxm4z5daZC1MDIwzFCYw
	Eky06I86EJZsXkPtHfb956ZD57QoDudQroJvjHaHJahTLp6Ke1nqAHZe0eIpIdjqLqZotaU3ZlT
	/RE8Zc4Ma7C9wvPyVsGcj5ldvQpcQk7Yok8dn4QdLH2D06hOaHdrH/EqXT80nkwvbjNORTI1djJ
	Ztez/h4chN79KQOu6iK7DSR87WPLpbanZ2i0Op3WneqtbG09tGVIDtOCqAu3cRcueuWc4FKhy+v
	eAeNgSOJb9YKKWZJi7/PcfY80dsU2WDrriboaOq/b0ZP9M8JLv84JOVrHUJbkT5HCCwSzR5vANx
	qMSiqOfY7YsZHOzb5NvgbkKk6FtLO5aM6kBf2VkmfAOMbsMNpSBLMCJQnQt3zWNJ0g7YkaRiXAw
	/SLHdwLzvlZn8FHrhyjA/WRq5Pqp9g7NKXjxG/H0XZ5YSSSNbEv+WglQ13VXvxrqjeAvm5sVoVR
	I=
X-Received: by 2002:a05:7022:f20b:b0:136:c443:80e5 with SMTP id a92af1059eb24-1ac56d94b0amr10494082c88.6.1793517661588;
        Sun, 01 Nov 2026 00:21:01 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm29851495c88.6.2026.11.01.00.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 00:21:01 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v14 3/6] mptcp: pm: in-kernel: add the subflow-retries limit
Date: Sun,  1 Nov 2026 07:20:48 +0000
Message-Id: <20261101072051.3853492-4-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261101072051.3853492-1-anilkaushikwireless@gmail.com>
References: <20261101072051.3853492-1-anilkaushikwireless@gmail.com>
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

