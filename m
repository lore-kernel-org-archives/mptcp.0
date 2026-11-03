Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695974;
	b=bWFgQQFKgPV2oNOAhleLWzckXwqfNNdiWdMTu/tNFUMNCSUkr2Ifm8k4HZCElS41DJ/9
	 HSyPLx6YLF55x2YMUb22xw2OzmNz5vFeFiCYOU20vxri64mX9kzPSN3u+8ZG9m6ElVe6U
	 uljZzOWWZIQpmNGoG5JTJW9isxg8fNgpW0Dx6VGYVj3mlNfzWZ/RwLTsi0tcuzM+PYoaS
	 LBmEgxBX+AvC2xYHm5TWlI1ErJXiD2YelSWN8m/8kWDfKN9LaI+DbcfEz2zRDjiKJuTq+
	 DlwBV7zAjQNW8d908ppfLbSD1fbWvJ/uqg0F+wyIsDBuouR2hk51VrgNq+jkla9JNGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eRt2kWbGCAz58A6g57CpIHgRsmg4UizgVAJ55qsS1ik=;
	b=M7Q0cN+fqi4O3R+IzlRfb/HXlIWHJZN8IygTI0Y46/PouNlRNVQCv5oI2c5pSLqQO+xc
	 Ga2f+DA/pfI8N3UBUFt4KCVFaDPwlCXBi0VsHRqfwHdBTtFzFVvOy/E+J9gIhRpOgTwcz
	 ArFAY1F8Bozr85w7JJZlFpkAda2wLE1e3r/egNF5ZqAy5TabYpu67SXILWiY6tVRZFd3l
	 i/0+2FUf2qB7y4ZiMIXoZ+7Z/AEics4zCwQFFAxrDK3LCa0oNZMhUrQ3WyEP+J3JizTRk
	 1t+rC3IWRAIaG/sL3pyresqfIF2O16sp6tDtytP91REoV0LdBZKmjMpCSOb8M1SUHFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oi4NCHrw;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8AF606A329
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 08:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F8AF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oi4NCHrw
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a1947498bso3754516eec.1
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 00:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793695973; x=1794300773; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eRt2kWbGCAz58A6g57CpIHgRsmg4UizgVAJ55qsS1ik=;
        b=Oi4NCHrw+aEesg2YY1E0pJqU2ad2BFMHUxFIuzeMQ75z+8QjmIbjG30LYVNwzH6fkQ
         H9UB//Y7ZMlCLHWIiMVKg1I8LIs9JN8v7yjaoF09JEPLbS3X524oF/FsUt6H6ACJLXGM
         wsAFKia+2woXQHuquwr7nDPdJu8am706Qhol3bea5YZU+grkroJRU0OAB/VY1bfkobIX
         +kc5FN45JlDQEL507lFyvAb/5PXzjVlu/m8OanwsC8pKy4jKdqNvW1KjlKgKzdivD41V
         eSrCtyG3DRbsVEKTuPwUIkkq4vWU8q32Y8cc/1yS4ZNp/07Fg9R8aIyKcIsrsLSHcl+s
         t42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695973; x=1794300773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eRt2kWbGCAz58A6g57CpIHgRsmg4UizgVAJ55qsS1ik=;
        b=xXQZ34yWHTa6gNGrAKNjVcrKyh4dm/kyXRKT6kPEi152odzfnQZL4mw+RUf7QwuRvf
         ZUvxOOZfWst57RtDwJYUD/EcmFAMnM27z54TdyS04S1tMd/pOwivGLCKdSVCCcDb0sWm
         vVL1eZcaiinzdVPuRABj7YbqPlaTmhRcGwm7CZWu3zb6j/RRp1Sk4FiUYwlqEgygwvMi
         EaqIi803h7kEvYr3IkNd+wIPvaSD1GK6C4PpQp2SBK6sJCcyaq7J0hdCc/FZ5u2JrPZE
         VGRAgPkeRDNuxPOm6Ra9ufskS4bl2LtrgyhhVvoQCOfj4eXstABh8paTdThPHudzscyy
         TRlg==
X-Gm-Message-State: APuU4Z9kZ8YGpCQIdfghkxZVJbB8M2JvY7R8CdfeK2IsDGt7QRd7PyHa
	jDb+f3EwC0/lzyOMrSnyrTsPyhoJ4mOSY8JWqX7vb40bVmtIxZ8IaZYh0qA4Zg==
X-Gm-Gg: AYBFou2XdMf60oNor3NAF+/2x7LvoRHJE9B84hTFYJ5ZQvJiWXSRLD9fgoZpDpAi0dj
	iZPTtniZO0IVQB0w46UaNKLNpTa9HSW6u2tS64xgJoVRZFrwYqHtMdLDHf/8R55aVgithZaOI5+
	rMWL5z3vd9LMgcUJOemsjZCrkbfMmBE/0R8ZVwuggJiaQ805St6hrwB7uHYOnmMqgrM0GCFwk1w
	cfdmuv9cQ8pAARxbfcEIufQRxUNPRJ5Gq+/+sBCN6T932EvLW1zjNRx1Nl5UyzmTgPZy96iJHx3
	hFJ8yAu157P15ICWk/twha+OJKNVpgpvmXjSndDyehDFEEdv4VsMlVHe+0p20G2GeG8Z68r/rcB
	CDiv1ob+3VGBBy1vXNqLIVfKxP5S8UaIZ4In6y4T6OCSmM4Tw9X3+V3TbuDu0QW4NNWaXOh84bE
	gstIYARWeyX3Orn2MiI9IrMJe9fS126AFKDltWXuL5QOt3dyuQ5qLB81MGyZsv5xL7H/n9tQwpJ
	b74ON2ANSYeCjp13CSWwkChcKTZ6sTk5U+eCWGXWFdC2Wj2jYwSjQAqlCHXjx1NvdB9bYtJudqz
	KaS5/RZd30Wywh4Ud83j/Z/ax2pHKSRqER3ZJ3Gbbp10PjTC++JitFtT7awwFgDK9ezJCKqS+gT
	cMVfIvjWhhMc1agbH66TBKRvqdWCpeqEpxG/lHsvFVTVxTAxID++6R2RKWONLON+fNDKJJq/Txw
	==
X-Received: by 2002:a05:7300:c00e:20b0:36a:12bb:7f8e with SMTP id 5a478bee46e88-36a4232ede1mr21045852eec.13.1793695972485;
        Tue, 03 Nov 2026 00:52:52 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm53065635eec.25.2026.11.03.00.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:52:52 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v15 2/7] mptcp: pm: in-kernel: check the limits with the netlink policy
Date: Tue,  3 Nov 2026 08:52:39 +0000
Message-Id: <20261103085244.23064-3-anilkaushikwireless@gmail.com>
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

The maximum of the rcv-add-addrs and subflows limits is checked by
parse_limit(). The netlink policy can do that: add the maximum to the
spec, and drop this helper. The next limit will do the same.

The maximum is unchanged, but a value above it now gets ERANGE from the
policy, instead of EINVAL.

The uapi header is not changed. The generated files are updated with
ynl-regen.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v15: new patch, all the limits checked the same way (Matthieu on v7)

 Documentation/netlink/specs/mptcp_pm.yaml |  4 +++
 net/mptcp/mptcp_pm_gen.c                  |  8 ++---
 net/mptcp/pm_kernel.c                     | 39 +++++------------------
 3 files changed, 16 insertions(+), 35 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 39f3facc38e5..f25f00759ffa 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -183,9 +183,13 @@ attribute-sets:
       -
         name: rcv-add-addrs
         type: u32
+        checks:
+          max: 64
       -
         name: subflows
         type: u32
+        checks:
+          max: 64
       -
         name: token
         type: u32
diff --git a/net/mptcp/mptcp_pm_gen.c b/net/mptcp/mptcp_pm_gen.c
index c180930a8e0e..59d57aebf968 100644
--- a/net/mptcp/mptcp_pm_gen.c
+++ b/net/mptcp/mptcp_pm_gen.c
@@ -45,14 +45,14 @@ const struct nla_policy mptcp_pm_flush_addrs_nl_policy[MPTCP_PM_ENDPOINT_ADDR +
 
 /* MPTCP_PM_CMD_SET_LIMITS - do */
 const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
-	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
-	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = NLA_POLICY_MAX(NLA_U32, 64),
+	[MPTCP_PM_ATTR_SUBFLOWS] = NLA_POLICY_MAX(NLA_U32, 64),
 };
 
 /* MPTCP_PM_CMD_GET_LIMITS - do */
 const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
-	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
-	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = NLA_POLICY_MAX(NLA_U32, 64),
+	[MPTCP_PM_ATTR_SUBFLOWS] = NLA_POLICY_MAX(NLA_U32, 64),
 };
 
 /* MPTCP_PM_CMD_SET_FLAGS - do */
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d3014bf57bf3..08a36191b5c0 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -30,7 +30,6 @@ struct pm_nl_pernet {
 };
 
 #define MPTCP_PM_ADDR_MAX	8
-#define MPTCP_PM_SUBFLOWS_MAX	64
 
 static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
 {
@@ -1399,46 +1398,24 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 	return msg->len;
 }
 
-static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
-{
-	struct nlattr *attr = info->attrs[id];
-
-	if (!attr)
-		return 0;
-
-	*limit = nla_get_u32(attr);
-	if (*limit > MPTCP_PM_SUBFLOWS_MAX) {
-		NL_SET_ERR_MSG_ATTR_FMT(info->extack, attr,
-					"limit greater than maximum (%u)",
-					MPTCP_PM_SUBFLOWS_MAX);
-		return -EINVAL;
-	}
-	return 0;
-}
-
 int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
+	struct nlattr **attrs = info->attrs;
 	unsigned int rcv_addrs, subflows;
-	int ret;
 
+	/* the maximums are checked by the policy */
 	spin_lock_bh(&pernet->lock);
-	rcv_addrs = pernet->limit_add_addr_accepted;
-	ret = parse_limit(info, MPTCP_PM_ATTR_RCV_ADD_ADDRS, &rcv_addrs);
-	if (ret)
-		goto unlock;
-
-	subflows = pernet->limit_extra_subflows;
-	ret = parse_limit(info, MPTCP_PM_ATTR_SUBFLOWS, &subflows);
-	if (ret)
-		goto unlock;
+	rcv_addrs = nla_get_u32_default(attrs[MPTCP_PM_ATTR_RCV_ADD_ADDRS],
+					pernet->limit_add_addr_accepted);
+	subflows = nla_get_u32_default(attrs[MPTCP_PM_ATTR_SUBFLOWS],
+				       pernet->limit_extra_subflows);
 
 	WRITE_ONCE(pernet->limit_add_addr_accepted, rcv_addrs);
 	WRITE_ONCE(pernet->limit_extra_subflows, subflows);
-
-unlock:
 	spin_unlock_bh(&pernet->lock);
-	return ret;
+
+	return 0;
 }
 
 int mptcp_pm_nl_get_limits_doit(struct sk_buff *skb, struct genl_info *info)
-- 
2.25.1

