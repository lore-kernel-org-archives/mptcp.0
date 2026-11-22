Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795308488;
	b=1WhahS8J5v+taoj4wByOfWmUxD9DdpCc8/0bbTW/WnuDK3P2/IvusQahwS4+lZcF7uP1
	 BgiE1nvOHFQRlfiq8PCFEM+xp7b01TVX92XuQOBd2z47GLKnz0QkTZJUImeRZl2BzcXMM
	 yYcn6gIhQIUEzOBBMDWSUrbZKLH8kUpBZn3KLUMZjcFCgSe6dMJlWgSjuk+AGxBSYsfDn
	 GlydLnNMlzWkt++2zG1jb8H9Zt7lKSfkSMtzz8yX9dDSJGCXXLtWbzaKvcDfDkGuKKi9C
	 x5i9XBN6LyCHlR6QMLkm+WUkfaXkSCtEZZAmzxKB02E/Nfue7dcD5M7umG/mPGn9TpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795308488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tuVXiS4klaKCKGxtuXsteZknPAW993llSdYZGMd3ItQ=;
	b=M9geHjLDe5t2lSclx8VdCy5XGhnG2rk+ydf+DSf93f+UqHJJ3vjJ1yvloZD5GHuD1rC/
	 pyZdwdWBY6rwaN2DOERcRtAI6m1ArBbE4iCYbitpCJyWhBnVuhpJb/v+uh0RirZdWlhf+
	 IOXlbFzCHMTETwNa1NdArSudy+v5liNQUF+vX5H0A8sScBbkloj74tIp4b7reYTMw3UDd
	 du2CK0bA0iYaqqVbdI+3wIJAFUaW1UCfa4ei0YAvwexESjIsZaw9QEGYTSI9FMYar/nkS
	 uZnKxmpw2smCGJHnusxucbBoxa2DDGpp4i7SjQO8nUT+2fGJ8f3ywDPAM1Odx3cgO5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KWV7Pk2O;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FBC606A320
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 00:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23FBC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KWV7Pk2O
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-38587f3de36so2591903eec.0
        for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 16:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795308487; x=1795913287; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tuVXiS4klaKCKGxtuXsteZknPAW993llSdYZGMd3ItQ=;
        b=KWV7Pk2Ozvtud8yWNeQTuaFvFpdxPeLZuaVt70v2Au1oOrtsnHwm4zVHgCTuVpy9Mi
         O7oEk/mJncst5TwnmLMAEyJ4gceoqe6cWBS9vwMWgA0BQPUKHV2XuhmqdGIeTSGdSnGz
         jp0PY7a+204rSo74G3q+rmXmG0WijDowlWNoVXCucXzwtAzWOI+daTrDvbZweJGcbn8Q
         XqD6wQ4R0f7agkfvKq8xq2Nf0loFfqNRxB7dJAMyjZwwaiy/EZ56U4nEmZ9aixB88pwC
         TwCnU1h+4fQZR/SRr8EEAX/llsFoxrtjTVcPFy+Vsr/hgcUYKCms00p7719BVv/bjuE3
         SHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795308487; x=1795913287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tuVXiS4klaKCKGxtuXsteZknPAW993llSdYZGMd3ItQ=;
        b=Yqy5DHmfsemPcXuF/F3Sf9DGFIrjIiBg6ragASK42WZt+Khb6cIv3oh4buOfJU/5YI
         5Nd4uYgGhjVH5O1CMvM4ElpwjTKUqky/PkKm7DkHOS4B44w0F2+RE6g681MOtslbTiBX
         p1vOuq4BIymboIPCAjZPW8QFgUQZhHlnALDkWuTp3a8seyqzqL1t+6TE8RmIoI0qvw5F
         EqrOjiVmOIeVrAeLpLvzAGm51FwxcKDLqm9Zv+zuF7YMA5arVkS1Dzz3Wb5HbLK+XaPm
         K/eNY+d8+q5H9PSAa9mrgWOhGQ/+T66fzYisLFsnj/NhzhI+Pf9B2i4oMpA0gMWGPVOz
         M93Q==
X-Gm-Message-State: APuU4Z/WK4vfxd/tnFZ4GuAEGxA9pGUnA1SUfheRkTn5iR6W054fXQnm
	ebEBFe077aR0i8cHFjYHG390pUuK9wnGWRX2HVWDU14c+Wrx9+PGeuJhxb0h6Q==
X-Gm-Gg: AZFdTZfcwnyShToAe3UD1GK/ktL3DsAWQrcvNXtvlEPP49aApj+Wo2aUjG3Al52auPy
	UoKBausd2IprqgnfKqFowsrzEaz2nhE1P+hPBTGzPcXVM3Ov+YsW+fvjIxbYkj5tDH54GKBajkk
	VUMOB/JPfLpXIbeKf8H9SKvlQbfo9f/FKw2JKvkQ3gIFT1Buvg0ICWWLstkH7VyPlWGIivlqoNp
	cnsjbfXYJLOxRiTSJ/5tFZlWfOvwI9PP5ax7IySQ8U5Y7Q+pFbgd4YsJ2MVFfX9Cocsa5W8fFTn
	qqpe6dsLlfNZOHLuu/wJ2GCvjfuj0507fi9p+pjfzWnKsLygzT/NS/0pCZY9d7FQkhZqKojfBJn
	39BoVhFIkHIa1CFrSbr4zq1npD7HNIXRCVqMlNIOOmmJK45d7TKojNOXrOW2LMz38V5dbKOCAvY
	8D2XArb1eJiE6as8V83uhnmbTWuFUqgAQPAXv8wW/AyiDv1kFn6LFmvapRocNqZN4+oPTDgYLlT
	r7XZJHNCaVimCViGGS3sPysPB26F5G+BWtpqqSPVdqyS+k+dGP0YLakKvigbcfs+YOrGG3CHCGd
	o9iSMeNgMg7wTYSPrWEmAEj+Ls9gSRJxWecUOhy93EyAtMHihJcEuP2p9P4UhycgKvPJL4Ei9b4
	Dw0R07Ww/4RQoJtegvoGLpPQJpGsCQoapEHtTRUtqPkdJpCq4HWJtlqB1VI0OUjhKf20dD9rTTQ
	==
X-Received: by 2002:a05:693c:87d2:20b0:381:ad6f:75ea with SMTP id 5a478bee46e88-3856f14748amr7366011eec.13.1795308486915;
        Sat, 21 Nov 2026 16:48:06 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm20219599eec.16.2026.11.21.16.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 16:48:06 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: anilkaushikwireless@gmail.com
Subject: [PATCH mptcp-next v16 4/7] mptcp: pm: in-kernel: add the subflow-retries limit
Date: Sun, 22 Nov 2026 00:47:51 +0000
Message-Id: <20261122004754.2276802-5-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261122004754.2276802-1-anilkaushikwireless@gmail.com>
References: <20261122004754.2276802-1-anilkaushikwireless@gmail.com>
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
index eb66e0c1c797..f9ec8dc26b34 100644
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
@@ -1404,8 +1412,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
+	unsigned int rcv_addrs, subflows, retries;
 	struct nlattr **attrs = info->attrs;
-	unsigned int rcv_addrs, subflows;
 
 	/* the maximums are checked by the policy */
 	spin_lock_bh(&pernet->lock);
@@ -1413,9 +1421,12 @@ int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -1444,6 +1455,10 @@ int mptcp_pm_nl_get_limits_doit(struct sk_buff *skb, struct genl_info *info)
 			READ_ONCE(pernet->limit_extra_subflows)))
 		goto fail;
 
+	if (nla_put_u32(msg, MPTCP_PM_ATTR_SUBFLOW_RETRIES,
+			READ_ONCE(pernet->limit_subflow_retries)))
+		goto fail;
+
 	genlmsg_end(msg, reply);
 	return genlmsg_reply(msg, info);
 
@@ -1598,6 +1613,8 @@ static int __net_init pm_nl_init_net(struct net *net)
 
 	/* Cit. 2 subflows ought to be enough for anybody. */
 	pernet->limit_extra_subflows = 2;
+	/* the maximum: about 4 hours with the default RTOs */
+	pernet->limit_subflow_retries = MAX_TCP_SYNCNT;
 	pernet->next_id = 1;
 	spin_lock_init(&pernet->lock);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9febcaf84762..805d9cccb4d6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1280,6 +1280,7 @@ u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk);
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

