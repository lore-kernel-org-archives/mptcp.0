Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792466245;
	b=rR8mLMCcMTzrMrWMsepeKgwhfS+S0jrOSBhOblCSxN9tq3Vkl1etk0P7YXtz3pkQiiH2
	 FTQt1+mWQ7YOLxp02oYBig6FTccidBFvKZzK6LoYgqq5OxmlFS6O+ELK/lfPtg+gueDQG
	 BEZRxSIe6Kfz/PW8FqPzjzzhtXVc5zuaCbUuFHI74V9BFlmhi/9ZuG3iwW/XG5Bne9cEH
	 ygH451lBRfSOiOFoEU16ojxhZ91eTlE0Z5HneICd1FtkDEIZ3z87dFMznPw5cuINE7exE
	 eMvxagwdVynqnpdEGhWqaWLl42ETYB5XE4/M/dYxtqUiFZxFxvwUSAtCWtoZgrhAOKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792466245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iRxa/T4fzT8xBuwCtmCmiFEABn9k8IGHBCfEcpQWbiI=;
	b=o12hVXcQTq0GNbvIBcW18vCyjXlqdgX9KG0hdxoENuk+Q+mL4y0yX2vwat4aMHgFxLux
	 H+WihZrw/QR0gzggvpdbf90DyT5DhXuZkE+urYnGwOGQqlXXmj3jr/VL7w1ZR/c8eIjuN
	 lUqgRr3oKmRzfDDPaA24CW0oT9545JJVBZXwWtZUI745dEPNGgju3vd43jb2Rs4EP/jd5
	 NOsWNybDo+68wNF17eIt3KZKwMRarUWSonGp/mHmSIT2/TJeHW+bRD7qoIJ6xCJp4uBkN
	 2+xIF6h51zMhM3XXYOmQSxMFyhH1EM6FtA2rdCOTj5twZbzilXvWBfsfgw/AvDpnuFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=chg6MGxE;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6785606A319
	for <mptcp@lists.linux.dev>; Tue, 20 Oct 2026 03:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6785606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=chg6MGxE
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35ef6b49813so5225405eec.0
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 20:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792466244; x=1793071044; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iRxa/T4fzT8xBuwCtmCmiFEABn9k8IGHBCfEcpQWbiI=;
        b=chg6MGxEzduFcl9KQqrKo9KOR1iXtS9xcq9bqrcon7xw9Slw6PMOTh6j1j/YRIabv2
         XJ2zYiJbdLDPxq4Og97nOw3i7xVzeG6dV5VnV91+qN1eeKXqdAzp3pebn5vW63D/m4gq
         la5pGdo7Pvd0/gn8Fwm0Bh702tnJv/QMK+s86LLtUBtR7/73Rj6otqeCTTi5mvyiApq4
         cdMdcJlJmbqLXBzx7P8FnEIMcKKl2wnT/JmqPEts/4F1Hi194+qwVb3DpVeQMoy+4kOa
         aI6paayqwRaRrHACi1PBJnRBb7MgkaFIiG4+e1UPkYQvcQktYPrujG/glTDfdtc86s+U
         k/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792466244; x=1793071044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iRxa/T4fzT8xBuwCtmCmiFEABn9k8IGHBCfEcpQWbiI=;
        b=iU+fnWcTmKdTObRdnpBzkLQUunoJi0AprbDwicmao20jFJcZ9MO7hCJzhm4bArYRex
         p4DZ9I4uJCtzk0lto0zmMwbl4ljBgXu8lQaVA+E5eACUyTmxbIed5qdEQtYaD1cbRBKX
         7RcQX7dAbQk206Y0SE6mghCP1CTNp1QB9XDPSBvKfRvfQGQvnpVuJ1dEe274PDZlK/ip
         LnjFUglvSbgIByDSozZ2IpCePILG+iq3LdHv2hHKYQsUgSmYAG6Hm204tZ4gVCS2CQOh
         Ory2137Rmencvxlqo/bBJHvS98XISDHvZjpHrGFl74AupFLRqt2/XKq/BKoSb9zcFPp9
         +wCg==
X-Gm-Message-State: AFq9FYKtyDD/E9/WvTmiZnfhdjwkVg/Q8H72gqsbVOLSOOyubKPl88BS
	Xtkrfr5MpRlbPptuuZEMF+JP3Pd7f9w3I3fx3eaiAQ+S72oaFlos05IjBxAh3g==
X-Gm-Gg: AYBFou15LoQZ9Eh2p5ZuBdqWAxk4CZNijCaF5qv+UpSJcc931agJmM0hJbliEFvHceW
	5+EAlXmTFFjuG2ME+0efzpvNIX+o2swvQ/Sogki9Qh98n3OxypD3VXITGmfNG8nIaVUnYtGAMW3
	6+CGo09EvmFcqyUJZyTIGLzniwc/1PSfejFb7j11WPxWAefP9fLo9uNxWDYIG5CTUxIwOXyHrg0
	AHdLYas60oOJ3vdQ2RQfdr3ltZzCYStHFil/wPpes2kMmjhcE152ZBrCQ165Vw849tmbevdPThc
	v3MD+t6lLrzxFLkZS3s2Irod42z7QBSr79mL48gmFomT7orW5gd/kOJ7f9fvDYypxxm5rCktH8a
	IquAKrJrYnug1OY5tg4Y78+97jvtHkYyRnMIHteAH+KJic2oegAher77aGQna+SFD0FNbwiTVMS
	HRM6x+T1dkofxM0cw/ENFs/PhbfjqXdIqjzr3w7vfVzQQC+hs/yGo7jiFzYjSfORTISVTy+ujAZ
	ByvSvXxETRbZnvlzCFBT5EAVtubNfUeq2cktpAXQi/JEOb/EaPV4bqQoHLU1upSdwnaYUB73jr7
	w7R8BywUl5WznaXM8xiwU1mQvscpubU2T9PkKvJa28Q=
X-Received: by 2002:a05:701b:4518:10b0:153:3c50:ab85 with SMTP id a92af1059eb24-18511ad80b2mr13021359c88.12.1792466243660;
        Mon, 19 Oct 2026 20:17:23 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360826875b3sm38473608eec.21.2026.10.19.20.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 20:17:23 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v7 3/6] mptcp: pm: in-kernel: add the subflow-retries limit
Date: Tue, 20 Oct 2026 03:17:08 +0000
Message-Id: <20261020031711.1896660-4-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261020031711.1896660-1-anilkaushikwireless@gmail.com>
References: <20261020031711.1896660-1-anilkaushikwireless@gmail.com>
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

