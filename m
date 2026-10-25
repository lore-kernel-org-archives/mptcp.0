Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792936161;
	b=zFqoFUYZ/P6V5AoDhkHpdHM8H7IM5Gh0oPh3uC3M+d12UF2jVnC7OWkBgEB8oCHBRzu3
	 ACIrT3Ppdq4wVQR9POUU9t2zPoiJKlTDNSsZEQT/W5neyJSY2jaJyPoCTvSY8cy48B44h
	 SBW8ww+oCzQiUVRRsW/dHuKiuRnKGeRRngLvNOzDosjaNDisVrkXguY+TpuP+ACpCLjkU
	 q6dg5Fyie0keOSqsYMlc0k0clcSAVa/ru28E4Rl19mE6OPjMsIUoQYecND0tOHu5zjQaf
	 6Exk7/V3kfvbPQ1ep8NxX3uSgdfq+1wDeDfUBIHL24o9eQdXo8UVk9lDBG6aP++ZX0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792936161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QYrJBSfkXW+dXRK+TgyPz0qRu/ngvO9Nzw6QrGK4VQY=;
	b=ExB+rqJ62K3+EZ9UvTFfqoslHwXsXP68p6yxgUV9Z085ENz+sl0fynCB0jQT3CYw1Kw+
	 0TD8zQNwz514OIzUpbL7QxhG14sE6qt6QHxKqmcUJsUXevQ2icONTc7MFzw9KXhjvRzNK
	 AqJVFvGkgmH+wkAMmNejCNSRwIUxAlmJyGCZcacOyCSLBWbBGfj3rQkkHS51APqJ4JkN3
	 CtR6toDP4Szm0kI9/Sbd4lc1H680uXkb42U1/xm/zvk6VIfZ/sEZ4VZAwdTrPvFDOmszY
	 xT3D0+6UJM0WaL8gdWgXE8QMzd+5jp0xvfAfb+aVX7J9eG1uOKn3WvgGpdTGOBO7azg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="JpE+/0Oa";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9922606A31D
	for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 13:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9922606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JpE+/0Oa
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso3877988eec.1
        for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 06:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792936160; x=1793540960; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QYrJBSfkXW+dXRK+TgyPz0qRu/ngvO9Nzw6QrGK4VQY=;
        b=JpE+/0Oa7VNZZeFTF86XOOXv5HyAS0FcgJK7sSIsfoUWGL9bZ9Jdr/VSM8Svo4pYA4
         TnePfLnoqYNT9fnxA/sn2iSWVWrrdR/tfG+uVUlC7EB3xcJVqr+UAj7Qu4lnV1zSGUnG
         8ULxpfnDSPohCUxnQxn/Bt47vr3K3AQTRrZyYlBmajmNlTsK8VSJup9BTmc2Ytb11Mgf
         jCPjQ3X9YFLB9VT9re+KTiEw2NXdD850ysvmYdZZkxOPqIDIIrsDPunMFA3s+BH63I7H
         a5JqEx4QzKLpGoVH4ZR/JVup83tCr6ungpeeqSQQLZ5ssAmNWK8Xki+M8WzPOtTX+5l/
         zhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792936160; x=1793540960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QYrJBSfkXW+dXRK+TgyPz0qRu/ngvO9Nzw6QrGK4VQY=;
        b=CRHRG+GR/eOoH6vKoOdJm6gaIe2CR9Z58yMuItdUU+AtgIv4Jt7p789UWjB6z4yZE8
         RbCM16/9QoKMTGTEuOEm5p4YvQbMj4npUbiy0Tr9xwbXGLAatSkpjb2iDqP5ZIYRnR/B
         v6sl5byx64skKVGbDwYTky5nSX4cSAzVCW2Wj823hqJ47VrpaxmV34VidTsjHBCqcwCa
         /a/VnYfqvcfseIZLw94J/rf75gOkqM8SEjB2rwA5LAH7YxHkxzKlnF3KzkV8sj+WpLWA
         2eAZ8luuEWVc5d4JlXd6ZUN54dIvVmUxHWGrzwCzdra0tedkb9/POwQVASZa6r26hwD/
         /lXA==
X-Gm-Message-State: AFq9FYJikacSoST0XUzzIk+Y3tr9uTw1jPhb1S6KY94jWL/dCocKXBy+
	nvwTY5tgLvW8kcZHssWJbIp1g4K/5ZTjKmmHKjJLy5FWkDsapc22s1l8Ux1zYg==
X-Gm-Gg: AYBFou2PCPXeEMyZQ5/A5l/olIvzesB0adySqMzCN0cXCTN92IxFSxdSwVTjEDJP/fk
	0vO7qQmVJtuAN7BSl+8cMHcgqGFW+g6NKXzQNYu4iwXWjUkyLmU30HaWNdZn1n7lLw9gNQl/74F
	u2HXVVwE+R9tVaG6/yUb0J4qLJo1jf+CHQbKlPS044OwKhPj/rkpQQWrd5898gqizIpKqEZogXQ
	W+2RFV7dJHV0Er26ZAcO5T0zGyv991cCJ2jJRFaEo3Gr3m0So+p2sxqZxqPwuJE2/teWZe5U0lS
	pq0bKSAY7ui5HhH6YmG9XmXcW12NQ9yFmXp9061iOZzRxdw4JrZGVYPOzYHt/PhB6qzpl4aqZaF
	Fza8/UEki5gOodU8DslKXFU/oOXawYWX3MRXL3Hdu1yzWZszY5+YfIzaFEa52+oWX6ic8IpuDpg
	mujjK8C8kmTurmt/hYsFHO3YvB1LDGlZVFHAiARh8Qdm2VcOaQItXhPT7LrOmnPt9jkG1ayy82A
	fSziXdi3mbZ5Foy/7mD7rV7HcfYgtd2q4W4eauqghCgM3br7QClhyygqtzNmr88nsJyOBuceHRK
	IVND1tux8L6s5I0Y9M5+dfyRalLPmVuF3he5P4cT16wVivC5zfOBX3x36LN8+qx6VuSuKF+W059
	O5kL0z0yQ2VaFQKt/YfWQssUR
X-Received: by 2002:a05:7300:5724:b0:369:fbc5:ce29 with SMTP id 5a478bee46e88-369fbc5cfd4mr2489017eec.38.1792936159268;
        Sun, 25 Oct 2026 06:49:19 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a002a486csm1188159eec.22.2026.10.25.06.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 06:49:18 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v9 3/6] mptcp: pm: in-kernel: add the subflow-retries limit
Date: Sun, 25 Oct 2026 13:49:06 +0000
Message-Id: <20261025134909.2794368-4-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261025134909.2794368-1-anilkaushikwireless@gmail.com>
References: <20261025134909.2794368-1-anilkaushikwireless@gmail.com>
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

Assisted-by: LLM
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

