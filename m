Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E353352758E
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166984; cv=none; b=uu9d66J0yTw3T2v+kZ/X6g+kdnLV2J0zo4nZUQuWnPOgJUhZqJVbEDMEoTq+aOd5V9pIGSuVmSVkjMgxgc2TaSkh93q3zAbYQnBCkRKtXNc+3bxhiiRIOb6kCYo7AL1OaTbmMyf9U/CjF0EvXXxuLtSJjQt6jPzNMg8uggon44U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166984; c=relaxed/simple;
	bh=46y2zJJklQ61xnqFeDwrYU8Qtuz3y5KNJ+GIymTb46w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=corUNqJC+1SJMFO8d6dhM03UOVjgTYINuhLY7FHyIxxP0dJFfh9+z3n20LTJsi88q0SGdv5ts8YlBI2l52A1OZohtAE1ZIMcPd4cKISWtEW80raeIwnakjiUClGJc8T2z6U1nTryYcap/KOh45TXqcKrdpzIFVUScedqaK87s78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aebXBZer; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aebXBZer"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35f036b17easo38541eec.1
        for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 09:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792166979; x=1792771779; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BNTC6E/smb1ieJKaejYYJ+Weegn9SdY3tSYLEi7aw28=;
        b=aebXBZerRYjui1kf3LscHU3rUYXdyeTOIfZK9DyTF/lTKn2kRLwA2IOzc92XxZ9F9S
         0KvHA3LhIqUVwoplmTpD5Mtx+xC9iVRAPszNLW5f/ApWyIkGLJ4nonlFW7SNiHlruFHb
         HiOKaRXEk9+oBG2/D8UNMyHjb0tWcyJOb5D0V6qGv4dBLiirmurhYFM2vM/PJCa0FptD
         qJ6lXB6UdV17eGgvYIbrWufBQ/7Yv7yXbyKLDtVbzHp+Ww7Co8dQb1SJWFdlQDfH3jtX
         I9JdHEH3AXU/IF+I/ZzjresVKc2RsxQ11y3aHi6MD/IosFrBnqIlWs3kLlhnTq7ewJb+
         RQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166979; x=1792771779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BNTC6E/smb1ieJKaejYYJ+Weegn9SdY3tSYLEi7aw28=;
        b=HgA/1crWvUDviIEzpLUQ1oAWmXJCDmRukX+wq+cLdKvdeD5TsbUC7bub/6qzEXA1gM
         aXirXa20Yabz7TaBqpmGY9lzJxIZEzvcUbEhulOs89G/6tJDxtWlOMmIKHXptwVwSPbi
         4OWwqB8bZLDKPGPv8f0sKPnz56YJnInLRsOeDFVJeimmbi6rWOH5IwmKwmmKJNockYAr
         0gIhDU1FPtxOqgCMMAJG9mATagmpUBSfz7UlTKPVxbLOUxQSpZwDZ3a3M3qEDbZ92hcX
         f1Bq7RZrCao7qB/Y3l1Z3aW7fsbpxZ+VEMu6zlI+VTKJtjQhToIM1V27YM2UVJEroN+6
         nitQ==
X-Gm-Message-State: AFq9FYJ8Znr9cIr35oxLRlOLDTbovIdK3zjeV+ZhqeF+DKttLFvZxdv6
	HNYF44qkkVtgNd9u4FWlMJM3V0bh3zyAoVENRAxTAzA678YyATJWANyKA9fgNQ==
X-Gm-Gg: AYBFou36se3qjUeENQrudPP17Ewy4otr3naDFGTPbgjzK9lKwVusq/rgWZa7msGbjQS
	lU/75i4l8q66syQ2tQgd1Y1xDyVjo5KBfU11+I6rmT21uLa36B9rHsFcdQ9ivebQRblMMhWZz42
	9sxQbJj6E2AfrM/6Hj+6+/MRO7Z9fu8wxZPFMVz4KvLwA0w8RjjTglcrrgHYmghglay4sQ33v6j
	5u5N4wsKfIuLuPc6eY1t/r+vO3ONvDN96Jo9iXB7kmNIDDqVF9KpZDl2iDwWrvkEo0jclsX800P
	sVIoCWRHNtzVcnyoPDE+sWbojHIn5dd2AZ0Jhvh8jX7q4dxNsVvrTP7YRwS137/DjCscVMlupxT
	5KYDp67d28KyZJBy1eDw4ovqKVXrNjZvJxWIz4lIlyci5pdlRXR1Qyz9t7fJm7+Q/hjXSmgtFbB
	7nh7haZ5u2MIckZimDxeBa2wqEz3YaYhJvQUHf0r+KZ6086+AMWcqQFCQfyf62bMnhgSlJpy1o+
	4u6w0oRZaW+donQ/mFw9pOyCXyTVvRJ7e4fCEQob7eOXBv9e1mlKlLNtebVqEYO3exS4fCI2zv7
	jj46SSc+7X2m07vUzZXBpLg2jBBKQhKjRrCCw68qo5c=
X-Received: by 2002:a05:7300:d94e:b0:35d:d9a9:e455 with SMTP id 5a478bee46e88-361a1b52654mr325680eec.21.1792166978543;
        Fri, 16 Oct 2026 09:09:38 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6791sm9099098eec.6.2026.10.16.09.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:09:38 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v5 4/7] mptcp: pm: in-kernel: add the subflow-retries limit
Date: Fri, 16 Oct 2026 16:09:23 +0000
Message-Id: <20261016160926.1155262-5-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261016160926.1155262-1-anilkaushikwireless@gmail.com>
References: <20261016160926.1155262-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new limit for the in-kernel PM, set and read with the other limits:
the number of SYN retransmissions of a subflow re-created after an
error, 15 by default, about 20 minutes, and 0 to not re-create it.
MAX_TCP_SYNCNT is the maximum value.

It is also exposed in struct mptcp_info, in place of the reserved field.

The next patch uses it.

Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v5:
     - new, split from the retry patch (Matthieu)
     - the limit is also in struct mptcp_info (Matthieu)

 include/uapi/linux/mptcp.h |  2 +-
 net/mptcp/pm_kernel.c      | 24 +++++++++++++++++++++++-
 net/mptcp/protocol.h       |  1 +
 net/mptcp/sockopt.c        |  2 ++
 4 files changed, 27 insertions(+), 2 deletions(-)

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
index b662eb914958..f4e23deda140 100644
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
@@ -1419,7 +1428,7 @@ static int parse_limit(struct genl_info *info, int id, unsigned int *limit,
 int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	unsigned int rcv_addrs, subflows;
+	unsigned int rcv_addrs, subflows, retries;
 	int ret;
 
 	spin_lock_bh(&pernet->lock);
@@ -1435,8 +1444,15 @@ int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret)
 		goto unlock;
 
+	retries = pernet->limit_subflow_retries;
+	ret = parse_limit(info, MPTCP_PM_ATTR_SUBFLOW_RETRIES, &retries,
+			  MAX_TCP_SYNCNT);
+	if (ret)
+		goto unlock;
+
 	WRITE_ONCE(pernet->limit_add_addr_accepted, rcv_addrs);
 	WRITE_ONCE(pernet->limit_extra_subflows, subflows);
+	WRITE_ONCE(pernet->limit_subflow_retries, retries);
 
 unlock:
 	spin_unlock_bh(&pernet->lock);
@@ -1466,6 +1482,10 @@ int mptcp_pm_nl_get_limits_doit(struct sk_buff *skb, struct genl_info *info)
 			READ_ONCE(pernet->limit_extra_subflows)))
 		goto fail;
 
+	if (nla_put_u32(msg, MPTCP_PM_ATTR_SUBFLOW_RETRIES,
+			READ_ONCE(pernet->limit_subflow_retries)))
+		goto fail;
+
 	genlmsg_end(msg, reply);
 	return genlmsg_reply(msg, info);
 
@@ -1620,6 +1640,8 @@ static int __net_init pm_nl_init_net(struct net *net)
 
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

