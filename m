Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B5041D23C
	for <mptcp@lists.linux.dev>; Sun, 18 Oct 2026 04:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792297086; cv=none; b=bBUwjX47moWfjC/4bD1s/e5Yo4EA0pLR+xKopj8/GN6p/9yfWZcIRk/jhH36E85aA6Wo2GWlHI3LCxaPbGPmgG0QheRuk5DWPppjdvmGTPushbxkdnYSakLI0zmjmjhdNmYPl3tRkyClZXxXJepMVjwgVXzYA2RGgfheivHn4f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792297086; c=relaxed/simple;
	bh=f+/W6iALoairZdFdQaoES4E296+TJ9KytKBHkYK+cfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kZPlbJXr7cg0NmSTljT2YF3g54abY8BpucWndH4w5vgqjG5oAqJ7XRPbAxRNehBW8DmYDDXqABj3wkWNv44m7QYHhWTSYnaS+sVN5bBMQZYpS62hw7/7dn1ylRK60RRQoRRmJLtZ95jusNRByDrANydmPmTns5pfTouJYLkw76o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mG4IirZD; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG4IirZD"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-185fd3a4ca3so10208c88.0
        for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 21:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792297077; x=1792901877; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o/F0qy/pDf3EzE73Yj1TmKqYZz7h1EKlB8HBrGWQXho=;
        b=mG4IirZDFtTDtMfj0Dw13EFRh2PcIxxeX4v1asJZLSJYXK7dcvLHZI54EIxfDOeQ7H
         0x7P0mC9xE9Tg1f5vuqqOeCJY8iJ5fSQssWowiteox+aUZ4A0O+SJPyllFxwO4/VYCEK
         sq+0+F2JDH4ktaxdJNQa71ocWS0ZW2Xm5538+6OJpnDueBznv4H+Y1FhunLVJLxEru/y
         ILO/8ueNekiSSK3KHWkhNzQTP6wlIaM0rn5t6MhNmWGViLzGnx+HIvYNzMjEI0OaP9YH
         5CPGUsb52m7PxNBj4V1CEcQXQBa1gwtBibVJrcoxZh8FWF06h/ILagTQme+1UMJ7pAnO
         N3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792297077; x=1792901877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o/F0qy/pDf3EzE73Yj1TmKqYZz7h1EKlB8HBrGWQXho=;
        b=oRMndH/WJmeoAtrA6RF7oikNBnjRJYejWOhRY83JwygBI6Sp4hcqz98Q2FAsneIkLy
         0Q/ZYnmOWAP7CjPlg7wdjgAktBV1lNiBNfGJI3r5W6ycUK10EIkILuQER4q80+iIL+Ej
         YGJHWln3qGVUagBRtq+aa23OtnGyt3c0gcJI3eEV98BmIM5T9DSnA+XTYynuGfuMxv60
         rh4zf6Ev+1xRfM00ScuVPgzFFfj/bs2cdF2ezfYf1XJg67yyCcWbuWux6oAVFXUGPigY
         d1nh9FmZR3B9VRi4xngeprsR3M6440yU7/G16SovQqNeBk3GGVEeydZiPVog8kMLDkKB
         /lNg==
X-Gm-Message-State: AFq9FYLVvxgN8I0ibqFkQzrlFeRKIgCDI5p78nwMrUs8MKFfVvZBmPPW
	y9EShDsvDzvk0xR0qYjzeyOWRbEP6bF7mCEuaQYkGWZoyT7LwksDcnFQgVk9lw==
X-Gm-Gg: AYBFou2rRK29velZ8ZPj+/jNjOi2P/7NtOcv0E0nY2eYyn7t+Y3ZtwigPgO1tU0vh//
	x8sclU88iDwXrsymVKJ9CSLvcdLFyfYAVhUWCbeTSpTBsojaX1ddQG0RzjKqWKzeOpuMDKSIL7C
	vbhIDEQh3grJx7clgbpx6h39jtTHk2XEZNxhpRbxKEnAT9Sf66m7Fg61HG86Wtj3EY3giBIfeWT
	kw0Pw2jSSFBiu3B26zY+ZnecwlhcTh4LiZK9D4sgDy5mtdorvSEMVitXZXKwhpaDeLlIyw8+aly
	XO2Lt7ubXLwbwb5WVwY7HwQZIykJ57SpZLUhBE3doJ9/J29OD8frcb4nqKwm19bAMiv4hrc07ax
	mArFtbo9NXjfYs55S3rER9yTroyjkwx6pz0XXKncJVsEctJytAcMJlcdMnUcqQfxY8iHvZVsZNZ
	qH1iRCJYrVGW9w2UAOU+4l8UtcYeObOb/syxq3PxizdxDeXybrps+tSKEwUn2rUJxWjEwBOMT/4
	p04pYDNy6nVli2wapWwVcnji/45PjG7YURWuhSiVyPU5kJgeB5C8rb2N+lDDBe/yDruxQScdC9l
	0eWqqqU0kFjgmcFuYchkVjJEjwtrO5Z6uvSHDHoGu6g=
X-Received: by 2002:a05:7022:f4b:b0:143:298e:459e with SMTP id a92af1059eb24-18514256bacmr5895333c88.41.1792297076821;
        Sat, 17 Oct 2026 21:17:56 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831919fdfesm17867932c88.7.2026.10.17.21.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 21:17:56 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v6 2/6] netlink: specs: mptcp: add the subflow-retries attribute
Date: Sun, 18 Oct 2026 04:17:44 +0000
Message-Id: <20261018041748.1655711-3-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261018041748.1655711-1-anilkaushikwireless@gmail.com>
References: <20261018041748.1655711-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It will be used by the in-kernel PM to set the number of SYN
retransmissions of a subflow re-created after an error, with the other
limits: add it to the set-limits and get-limits commands.

The uapi header and the generated files are updated with ynl-regen.

Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v6 (netdev Sashiko):
     - the policy checks the maximum value, 127 (MAX_TCP_SYNCNT)
     - the doc says the value works like TCP_SYNCNT
    v5:
     - new, split from the retry patch (Matthieu)

 Documentation/netlink/specs/mptcp_pm.yaml | 12 ++++++++++++
 include/uapi/linux/mptcp_pm.h             |  1 +
 net/mptcp/mptcp_pm_gen.c                  | 10 ++++++----
 net/mptcp/mptcp_pm_gen.h                  |  4 ++--
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 39f3facc38e5..93abd7db0fd5 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -196,6 +196,15 @@ attribute-sets:
         name: addr-remote
         type: nest
         nested-attributes: address
+      -
+        name: subflow-retries
+        type: u32
+        checks:
+          max: 127
+        doc: |
+          SYN retries of a subflow re-created after an error, like the
+          TCP_SYNCNT socket option, so with tcp_syn_linear_timeouts on top.
+          0 to not re-create it. The maximum is MAX_TCP_SYNCNT.
   -
     name: event-attr
     enum-name: mptcp-event-attr
@@ -327,6 +336,7 @@ operations:
           attributes:
             - rcv-add-addrs
             - subflows
+            - subflow-retries
     -
       name: get-limits
       doc: Get protocol limits
@@ -337,10 +347,12 @@ operations:
           attributes:
             - rcv-add-addrs
             - subflows
+            - subflow-retries
         reply:
           attributes:
             - rcv-add-addrs
             - subflows
+            - subflow-retries
     -
       name: set-flags
       doc: Change endpoint flags
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index fe9863d75350..43e9643deda9 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -102,6 +102,7 @@ enum {
 	MPTCP_PM_ATTR_TOKEN,
 	MPTCP_PM_ATTR_LOC_ID,
 	MPTCP_PM_ATTR_ADDR_REMOTE,
+	MPTCP_PM_ATTR_SUBFLOW_RETRIES,
 
 	__MPTCP_ATTR_AFTER_LAST
 };
diff --git a/net/mptcp/mptcp_pm_gen.c b/net/mptcp/mptcp_pm_gen.c
index c180930a8e0e..e2d4af1bc1d5 100644
--- a/net/mptcp/mptcp_pm_gen.c
+++ b/net/mptcp/mptcp_pm_gen.c
@@ -44,15 +44,17 @@ const struct nla_policy mptcp_pm_flush_addrs_nl_policy[MPTCP_PM_ENDPOINT_ADDR +
 };
 
 /* MPTCP_PM_CMD_SET_LIMITS - do */
-const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
+const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1] = {
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
 	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_SUBFLOW_RETRIES] = NLA_POLICY_MAX(NLA_U32, 127),
 };
 
 /* MPTCP_PM_CMD_GET_LIMITS - do */
-const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
+const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1] = {
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
 	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_SUBFLOW_RETRIES] = NLA_POLICY_MAX(NLA_U32, 127),
 };
 
 /* MPTCP_PM_CMD_SET_FLAGS - do */
@@ -127,7 +129,7 @@ const struct genl_ops mptcp_pm_nl_ops[11] = {
 		.validate	= GENL_DONT_VALIDATE_STRICT,
 		.doit		= mptcp_pm_nl_set_limits_doit,
 		.policy		= mptcp_pm_set_limits_nl_policy,
-		.maxattr	= MPTCP_PM_ATTR_SUBFLOWS,
+		.maxattr	= MPTCP_PM_ATTR_SUBFLOW_RETRIES,
 		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
@@ -135,7 +137,7 @@ const struct genl_ops mptcp_pm_nl_ops[11] = {
 		.validate	= GENL_DONT_VALIDATE_STRICT,
 		.doit		= mptcp_pm_nl_get_limits_doit,
 		.policy		= mptcp_pm_get_limits_nl_policy,
-		.maxattr	= MPTCP_PM_ATTR_SUBFLOWS,
+		.maxattr	= MPTCP_PM_ATTR_SUBFLOW_RETRIES,
 	},
 	{
 		.cmd		= MPTCP_PM_CMD_SET_FLAGS,
diff --git a/net/mptcp/mptcp_pm_gen.h b/net/mptcp/mptcp_pm_gen.h
index b9280bcb43f5..5b4dee8a0a34 100644
--- a/net/mptcp/mptcp_pm_gen.h
+++ b/net/mptcp/mptcp_pm_gen.h
@@ -23,9 +23,9 @@ extern const struct nla_policy mptcp_pm_get_addr_nl_policy[MPTCP_PM_ATTR_TOKEN +
 
 extern const struct nla_policy mptcp_pm_flush_addrs_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1];
 
-extern const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1];
+extern const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1];
 
-extern const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1];
+extern const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1];
 
 extern const struct nla_policy mptcp_pm_set_flags_nl_policy[MPTCP_PM_ATTR_ADDR_REMOTE + 1];
 
-- 
2.25.1

