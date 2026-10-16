Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF0B4FDE67
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166982; cv=none; b=X7eNbq40kAnbTdIZzdDj40JfITj/O3nNBWwzTdN6BIgFf2N+3tXiEkKqKYoVMavsymmJsZAWdMnI4uTEU1FKKUjgV6LE6BXC5LzVxqM8/4uSZ85BimQDqDAYn+BuTqjMHka9+ISP8qQqfna+d135LRd2Qjuu/8h6GGYEujyMV0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166982; c=relaxed/simple;
	bh=NPfe7jXh9CovvqNbWQ7sejsHa+PPuu3+XFo9xAp6f8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DqHCxbE97+ejXReAggT1WL7PG859Y44PZOOe0NBuYjNMUnZMlzGUJ6ZvWFAHFLotP434NwCpLRIXvJTTApMaOPkrI686ZXBvacVvvwqczHDC3Pnp3SJDos+OPDg8jssnL65V2pakW2K51XYM2howup2RD7QjBXYIuf9ibOJux18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCA5XD8N; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCA5XD8N"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-354ba08cfd1so34952eec.1
        for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 09:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792166977; x=1792771777; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jfdLECDMs86GKDtBKZ+aP4kswDtr+0PT4r6Uxmz8hnw=;
        b=DCA5XD8Ng/TEs4o6buTgvyWdaNBtv28RIJ5xlmdaknEoRGGHfyqLLM/eSxGpDlK6qa
         Y05UEFFmE8f42SSshQQlZbwrt+yNIB2LPeGoIi4cY/Jktf81xRYLZO/jKHzwViPBWkrS
         B9i5lbB+4Yc1NQnisKeR5qeNS7N43O7zUJln2lz8/dLD5HQkQccoeCNsuS3/daTIkgsq
         xKqhEExyRLq1z+YEircL6WfiaAOnj061J+ej2PMldb6CSyt9XcyO9fGFqrDCkFN78hlf
         1CxhIBeiGzCwX6Y3mTW14Pxye74ZhLogBSAdZquRCOQueXTI7zAWMpE1sHxAeQ6LnCan
         vERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166977; x=1792771777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jfdLECDMs86GKDtBKZ+aP4kswDtr+0PT4r6Uxmz8hnw=;
        b=Hfwwag+KUv3XUGLVN24DxqGDQ810yDQMV2D95DFuL5GianRudAwC583VHvUA7tQGKH
         TlruEynGGNt9WOcC6+l71hRHuZy3Ve8wqcXPlMmmcAYQmLi5pYdZECCtDTd+BydiKtM0
         dVhSkN5IRGhdqs3W390VqwOo1bW+381VbyxHszfEgf/txJgwOL4DmvUQjV7aJlOOOM2C
         TS3g6scNhBnmV4zQ1clL8wIguKnHaAvjReAh/+kSt/zWaSaOlZe7SoGm+qZQhy74E8g3
         UHBfwowFzOLUS+aII/RuFd6cmNk2YkNoTvQ7E/0IX2H9crwh9TyKDohPz2AXJYZ2ieMl
         IRDQ==
X-Gm-Message-State: AFq9FYLdwnuClG/P9X5UIne18OwlJP+8U9+BOp6ojRI+YotOHX9ryd+V
	wbsUMCpi8wdfgNl2fDjU8wBHdDfFXTbrFU7zMffLpAFVneh2cMnLuZydORrB6A==
X-Gm-Gg: AYBFou0T4yMCCutLTiPwzZ932UDWPhnw12sNo87M1yzYvsFsH2R4TVWQJbbFEAtQtS3
	h8p/WLk5DV3OoVDt3LtsNhLdgB/FKyZXbU5ppL1ir3VTIt64gHbGvTfUNheqdNhNUpllXMDUSTi
	izk0szT0qPb45CYeggcy3Pcze3Yhm/Ox84F3EwU+y9rQqizgMSKxcZ/MVG+JYluSC2Bh5swBtuZ
	Q102J2pxhWJAJfPsv6HJMGPagfZS6+18lpW9GLqJ6P0SV7VK8Wx8vId1vPC1IlLCYfIXlypnpDy
	lD0LoUJpzxHlZGUbAFG1/dDKKUt2S3DzKlBbf88GxMCIrx5lcnOi83FiSs/8N/++SiXE+iZKufb
	u1k92gnAZv3ScT+BKkVAikEMinNs1yEOJPLde8T0IhvL/z4mnZoTt0CfhXAF/KfWsvAgxHbOYny
	TDos3Q/+9D1QKlNZHhkm7eUZpY8O6tPc6uKKwmb8P0O+Ps5RS+AW7aEYWAn3Z7nVvaQHN9Nh7FA
	UJXNjL8NKCWJl6GuIicwHZ3JnQsAZbeZc9XL7Kd0FYQB7hoHGiwvG99ZvB/5mHFG5ERLKvqv7+b
	QlVLZxO7qpjiCaxroDHA/fbHlGBWIvDN51xoxyCe576UeTkWeMMP1Q==
X-Received: by 2002:a05:7300:d0ab:b0:35d:2633:ff79 with SMTP id 5a478bee46e88-361a2a3c429mr268046eec.40.1792166976609;
        Fri, 16 Oct 2026 09:09:36 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6791sm9099098eec.6.2026.10.16.09.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:09:36 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v5 3/7] netlink: specs: mptcp: add the subflow-retries attribute
Date: Fri, 16 Oct 2026 16:09:22 +0000
Message-Id: <20261016160926.1155262-4-anilkaushikwireless@gmail.com>
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

It will be used by the in-kernel PM to set the number of SYN
retransmissions of a subflow re-created after an error, with the other
limits: add it to the set-limits and get-limits commands.

The uapi header and the generated files are updated with ynl-regen.

Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v5:
     - new, split from the retry patch (Matthieu)

 Documentation/netlink/specs/mptcp_pm.yaml |  9 +++++++++
 include/uapi/linux/mptcp_pm.h             |  1 +
 net/mptcp/mptcp_pm_gen.c                  | 10 ++++++----
 net/mptcp/mptcp_pm_gen.h                  |  4 ++--
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 39f3facc38e5..1b481908980c 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -196,6 +196,12 @@ attribute-sets:
         name: addr-remote
         type: nest
         nested-attributes: address
+      -
+        name: subflow-retries
+        type: u32
+        doc: |
+          SYN retransmissions of a subflow re-created after an error, 0 to
+          not re-create it.
   -
     name: event-attr
     enum-name: mptcp-event-attr
@@ -327,6 +333,7 @@ operations:
           attributes:
             - rcv-add-addrs
             - subflows
+            - subflow-retries
     -
       name: get-limits
       doc: Get protocol limits
@@ -337,10 +344,12 @@ operations:
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
index c180930a8e0e..127a1fadaac4 100644
--- a/net/mptcp/mptcp_pm_gen.c
+++ b/net/mptcp/mptcp_pm_gen.c
@@ -44,15 +44,17 @@ const struct nla_policy mptcp_pm_flush_addrs_nl_policy[MPTCP_PM_ENDPOINT_ADDR +
 };
 
 /* MPTCP_PM_CMD_SET_LIMITS - do */
-const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
+const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1] = {
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
 	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_SUBFLOW_RETRIES] = { .type = NLA_U32, },
 };
 
 /* MPTCP_PM_CMD_GET_LIMITS - do */
-const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
+const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1] = {
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
 	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_SUBFLOW_RETRIES] = { .type = NLA_U32, },
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

