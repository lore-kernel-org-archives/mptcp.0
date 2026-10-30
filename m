Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336859;
	b=NJXPAGkngOJ27wgAAaiyrjOaMzDdI8gXsmZdj8C3dZhF1edegXfPpX6XtQW4vrFUSX3n
	 J6OHxH46RjqLJw5cCHWe++uCkBjTdx76W9IBW2pJqk74Woks5f5suqPvhwpT+QTb3tc04
	 FuG4P5z1gQpOiFo6FDyBPIjCkM1f6hBBCLa3q5x5UCk6572BcIZMmoj561aJ0WJJQYkgP
	 iLLdPD94HhAeDiXfiBhVe3iI9PPoh1fTofnRsHM3atUjR6dM6UaB3FwziI01rJFwjugLa
	 qmRhRwMvKNvmP38mMVRrhpwe8IpH+JssdhmmLJXO9dJ6SNHnXm9Or3uT4NRqvIiuT9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GMa51ST4XjCQkd4qYSnBFNlKaUJYxzH2Que0Zxlz+Ok=;
	b=23M8+dnL8IgiHqx8u43XifD/spc3Afd1fazXJ6O+KWTpnG6FiF55BaG3wDqEGnplmgoE
	 ebmD4RelZdouN2MNRUfyEhdwvbA4gYQMtJtha4Xb6F9cPFxWngS8i+0wi4Ser3ilD7GYW
	 /j7PyF0YjrhxR3k2sV5gu9ETPfPI1o4g6bfH/ix47zUj+ujzjfinGlaJ5YlyN1lkt7ZE5
	 zM2QU0QoJ5tXoqe8wbG3EXyJDrRJxHQot4OL/uVIR0Fi/X5L37dIydE6seVpPIPs7HHDC
	 dREj+xPhdXA9BrU2gbNQcV7Ez929vQLTfZIU6t3UF4k7MCdOLdocOc07NG7+lxgnKVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ALQJbIS8;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1122A606A31C
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 05:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1122A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ALQJbIS8
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1931ff67a29so940198c88.1
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 22:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793336858; x=1793941658; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GMa51ST4XjCQkd4qYSnBFNlKaUJYxzH2Que0Zxlz+Ok=;
        b=ALQJbIS8r07ntk6frUtW2nR5dZ+u1svtPGgUxEWrVTuQRxjU9+gngN3BpatHVUqnaj
         znv9ctbfS5+dOJWPHeA/GNNaV7HDqJFMpUtoia96qDik+3XLO82WwAWHLr98ERFtsw1d
         nzKlF7B0PM9039eoBra+9cMu7IqEvW/eT1uQc8lJ1tho/5Q30bBCuUEmA6nTLkN1LY2y
         6CcxVHz1KXH8ryJMTy7IXti7X3fcrSNmp4ngcIa4HXg8NRutHH2Cc/RXKeC89RdC/6mO
         T7AcoQM+jq4T6X02fmaCW1ujv3m4vWCpMCmD5o+PNViYPc5KMv3x5MFqC1ushqOGFM/i
         zHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793336858; x=1793941658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GMa51ST4XjCQkd4qYSnBFNlKaUJYxzH2Que0Zxlz+Ok=;
        b=KH5eSNmIVtJU38Ec7ebUB2Op7Lsg6kcRmnwYCfcJxT+KL2vo9+Qtm6UX/AmVC5R5FW
         DXSVXIiaTBRdfozZWCzw1Etqsz0XkWnZXwMtMsjXNxOack7ESmpKMvMhu9cKVxGAFaoh
         A3xo1gJsWF5GkoW7npDdeWeK9xhcys8L0Gp157ZLdVQBSZ6zwstGN97fARYGrVN8NI6U
         A2SRNvjvlLxIWfLydoM1dTQdpm4u5mKJmY/tNSgQioASbOfEaKv7sSx7o1gdDoa+oXgL
         zp41+1MNA5/i3uK1UI2Jdhk6DxDmTPdhWvgjNNJtf1rH3oK76QAXQSSF28ToySM4oAck
         WAkg==
X-Gm-Message-State: AFq9FYIbo1KzAv0KxZIc7VhCKqcvldEI2LdTkgYEirZf7lYP3k+eLal9
	s5EAojC2qWK8YD9FwCI6NDwX3JMSKl3hq+xfpFT6hjeq4vcdD3+5AfYMj4FK2g==
X-Gm-Gg: AYBFou0SbKKGUfziPy7+Zg5fbYToeQRgFM6+1bx5lT6WwBQebLHULoLFYDSzIpAfs/h
	8sErp86zv70IaiO+OU7Wo9LV8Hmrnz3MRmVk3IgaTcFhu4aagkuYSConahkWG0AcoDQqbX32mFh
	QMu74iMIHzfroQME5Fk8O+z/fjIhWqqhBYFgInsNnFlm3FS9JfU+Sk8Y9FwEVMcrmB4RWbidfDT
	BxxBOEbiXRMywOgB3vtQAxOnVBexlK8sMBSBLFPgNZU/CFz88y3Ld+dQ1cVJ8OiHuES0MQKfLYQ
	LqK/sagYwrOgGRqvOdv2HFrPnWEKsW/GD1w+ySuI2F3h2OTQ/xaHIhR/tfDsquGWNQLlygxkJ2i
	aezHDLxaM+IYWOiA4xhkwkDmd3H5vvNq1RG3yzdWc9ECxbHIqqowKU+gnHKZ2aCCCLjuv3zY0Bz
	OuABD8W1KY5RSajNFKwLyjz8NUFdvl65k60UBsUvoJGCv+BZQL/8+D3Qd3dsmMvvTsfSnnyUwH5
	zE2w4/G6eVo6Rh+aUgjiAFYPHn8XcaLclfESSvgRXuFBRj8XTcyL1yDF7++W4t/dDAgwICl6e7z
	v3ZnStDjqsfPD0IUysvwJzz3Y6HBqiEyxLGbYJKVxGiWmrtkTxu6o6FJ8IW/Yv7fEIl4hAlsOmi
	Py3QFYw2Hi34aRKD0gQ+cnOjDsmahhrT2Qa/3BbekIKpzX1kin31IgSbgPKhxPdOLU/K7D6ee0A
	==
X-Received: by 2002:a05:7022:1117:b0:195:49ee:94c7 with SMTP id a92af1059eb24-1ac5a0b579emr1648343c88.8.1793336857996;
        Thu, 29 Oct 2026 22:07:37 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm3512702c88.23.2026.10.29.22.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 22:07:37 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v13 3/6] mptcp: pm: in-kernel: add the subflow-retries limit
Date: Fri, 30 Oct 2026 05:07:24 +0000
Message-Id: <20261030050727.3534304-4-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261030050727.3534304-1-anilkaushikwireless@gmail.com>
References: <20261030050727.3534304-1-anilkaushikwireless@gmail.com>
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

