Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793166115;
	b=dZG/obfi0wDKeIx7DiAcfd0n7d8JaJStFArVsFhGfMIXEf5K9NV+vUJONR0gobDz4FTD
	 3XAoq0H6GDr5+mOlZKx2pT5lk4CSbBUf9HBlL27zcTnimujt2Nih0STlUDArLh288uT5I
	 9XppmnJ1Onga9mtWC1VdT+Tz9mhIj1jxaLziKrjhkHUF315AI8qpKLEjbCQhqjAcyxxpw
	 zU51siC/CnfxFk573LTaF4x06OnZEFS3zdJQtkOM4Fy9iytbw4PGsMSUlBhLdhLg1Egwn
	 owHzQMp4A3FB7MMORV/pNBUc9YPH7JlZpSz6lb0LRU76NZ+PvwqTdNCvpBBTqbotZNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GMa51ST4XjCQkd4qYSnBFNlKaUJYxzH2Que0Zxlz+Ok=;
	b=s6pCOofxLaOB2mldCVcb6sCslXITUxvmHWdBRMn/nuG/3itTDQXVs6bBem7ISbiBxOQi
	 kGZDJE1ojTlaBSZNS7CEEqe71w4aFtuJenn00TdRGWiYVXUYSPAvEp36MU+pIyQe91GRs
	 f7r3yJbKPIQWo5XMKkdWv5Myzsem/7rLqI0RpI4m9zs8smFKnItIcEsaPq9UhotTqTBK0
	 U7yS43ITzN+AVf5oOL6GMnceKv+218vX8s5+eJX+v2l5fu5N6P+1y2R/Vr1UXjxhtrD2I
	 gjlk2ZhXEjxV8q/Hj9XJu6/BanyYLnKaBSXM42Tq4NY0BNJKyKWKtBNl+fU2fjnBUjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OHHPOaif;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC8C606A31A
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 05:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAC8C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OHHPOaif
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33fb4680717so1332651eec.1
        for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 22:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793166114; x=1793770914; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GMa51ST4XjCQkd4qYSnBFNlKaUJYxzH2Que0Zxlz+Ok=;
        b=OHHPOaiftJl8sJAgbioga/eSufDEooLY3tfPiJdoxcikeBAuz+w3mZ7MYTg9TfdSL2
         349lfvRUlxjranUQ0lmDdfsrXhLBaBpbZ7Tg1LxeOgCGuuzakgix/vvLm5BIHf60ptiN
         IQTrz5dVDjcWEKwdLA/u+75+a2Et9HBbRX6XJgcJNmKq5f/IZzsOBdVw5Dos/dj1WhA1
         6DJQNYb0opcCn6P0CKylGpKJfsZue6jOQQLw5CrVZg5R+6qzsigX11wLk57QBMNGRn+J
         fNeRzekovSjre5NG2Q8PxOlikuNwQUiZxdw3AKsLaOSj5yNS4clQkNpKeoNDm7i4IiJF
         4HEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793166114; x=1793770914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GMa51ST4XjCQkd4qYSnBFNlKaUJYxzH2Que0Zxlz+Ok=;
        b=fCTQPZTOVPV74NAymNznfFjgSAV8TC1fqmPeQmAbwnrVqi+s5kMdgia0SMXom6tDGP
         Oayo/OUz9wVj3KQJe85mN+R9s1inUDJt+emt55i2243u9CLOMAp2fTKDM9FFcv3vobra
         Cm78JgDbmww3U9Wjlq7xqWNuN+ir84bDKYjNlDJTdp5VAdqPy6J8r4NLhUOks5O152kN
         WCnP82p/Es3OVNIQX629oprUvPwStYGWwAlNuAgMN2+ZoXXdi7TCB74ZfOOuY1MRNJOV
         BOXGCbnshtEovaCtOw2z7+RrfstfR1nURxoJB5KaIU9Z7KSxBHZP0e7SzwflcooZjyH8
         JMLA==
X-Gm-Message-State: AFq9FYJ6ZpUjHNpLs69hRSy4qYqmtCcgBnEpNwlG8KN0Zpi8HniJ/xxm
	SM5uAKpVHfRuZO8gElMRpHBcmWW0Wwzl+ECXLAH1QOU+2F/RSmJB7bLDFwoRjQ==
X-Gm-Gg: AYBFou0J5+dAXXTNDseeKMBWLmI172kzxvKSy6IUSrw/ZW5wYfbpfwXBXkIkIP6KOvr
	o0qKRIeyuFRX4QeEQH1bkSXN+Kzhg5ek72wJ1xTVjsF5ewd6eORtsnXitXS5J7Emh4sAgWJbgwJ
	xBrHcNmJC5XfLxvSwTO/1y5Zv4LIVVytbC12vhMQ6uUoyE3k231F5a4uIg6DuRqOvzZW7+n8Bvv
	lpfNDgf2DhE1UvynfMUpAwidNrqPBuRcJoAPdxonT5+FnNDAjukdcj/bWBjyrvfegGk1nj8cHfZ
	RPCuQi/93vrEOd11X3R0WXOBPA6BpWV9DtONStPQcaGVd88O/BdldN98e95a2b/C5/EgZ9zjg/2
	vjwrVnqqMh7WWC6WJ0Skv+p6tXrzp0X9oL5z4BTxI0/zZG61lDxVO048GNZSjVXGFSGoe83wVwF
	Q0hQrfEI6yXgDfgRbylCfeyA39VQwn7DtRtB1y81BVUwSx2cSCfBjOzzMZKlJyiVKsCODp+TTck
	qniDhBpVfufnEeMXWY97+FEYREO3C5HfCRpc485YArx1wMR82EQ/Bk6tqH+cNRF2MJNI6+iOaPD
	w+QG4RWqC3j139yyTOt5Q8Q4DUHG4jw8vL3IaFWjTbiWLHO7EPzoShw83nTRmeCwTYje4C3msM8
	LGgopqKN+i/HEAF2J+bGwHt71b1tMG9U1aTCFyBJoYSJQ5ypRPVNJ8GeNpccyIhiAAKMIP2hrlQ
	==
X-Received: by 2002:a05:7301:180c:b0:369:f2f4:b227 with SMTP id 5a478bee46e88-36a203e4a69mr2244164eec.18.1793166113830;
        Tue, 27 Oct 2026 22:41:53 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a237be80csm5860973eec.2.2026.10.27.22.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 22:41:53 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v12 3/6] mptcp: pm: in-kernel: add the subflow-retries limit
Date: Wed, 28 Oct 2026 05:41:40 +0000
Message-Id: <20261028054143.3222998-4-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261028054143.3222998-1-anilkaushikwireless@gmail.com>
References: <20261028054143.3222998-1-anilkaushikwireless@gmail.com>
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

