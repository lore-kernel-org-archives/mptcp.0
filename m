Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695975;
	b=zrAnC+QtpZd8TE1emfBcrBUTaVcNEzErABasy/nHmlfg2fTuulf2Jjrwn+R6Y2CwaZLx
	 5wsEZMCmeIGl1HdvIQFioCeUiMTXe3Laty+tOuAQmTweRVNL5swbQzgq1xRObnDi6K3QY
	 nj+T0tzksPP10xrF4dsWsPgKLPmLvLKWNZhCqFE+K83T9PdvcZ2/XT3MjEiqcaRkEIMsA
	 f/5cte5L2yIMvZUMab7JuUOrMUFaocB/gZemvPBt9/mKM5VPza65tfYHod0pE7sSubg+Q
	 nllteeSaANQ1q4KkJdosjMuVUjX8TqhHPUBoIsPm+OBKb6Uhzc1zplAvMFgU7Iu/GEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695975;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VbM06yFn2Jh2tq6JZ2lNHsgrv3CcW4NZaAIdbeX3CqM=;
	b=KLbkmmgqzkGTiV/MVtavqGF3WRoclkfu6qfVMrwIu4ng3VNWwZIJ0t8NqSCNf1nVSsJB
	 5zhzmllo1Z4pZXZ/h7O+nLaTZKdHSTj96FpzAQfOic3kL+DxIPT0D+DruUPnpbwXXM+c5
	 13K87jjmmW1ed6BCD7ZISB3r6LnSF8VWHN3Bl3dpw5Q12TBD0QDaRZUApDZwaihKEAZku
	 YLLNxJMDPM8SIrUUaXpMy0IgNooDGgBtc/IJp9hnF6cvzTTPyGj0LO49wk46X8ZXXHRYA
	 X5GM1CaFhLiiniCV8W+CeDR6+qXZfnYqK9eY9w9r7Xv11r1Ldjh4KfTblGxtXo+OUPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nKeBTBLo;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645B606A32D
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 08:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8645B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nKeBTBLo
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36a18fc7a38so7424538eec.1
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 00:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793695975; x=1794300775; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VbM06yFn2Jh2tq6JZ2lNHsgrv3CcW4NZaAIdbeX3CqM=;
        b=nKeBTBLoXoyqqap1SDEtZ2rDWLrjxflfx7/GrFVefAlWeFjk7AC7xKbUvbcTAnCGhZ
         S9us3GheagjK1edSQK6gqIkR8Zg57MkHXFU9iFs+Reb+WHetTlz4C9lQZNPOI322Y3Iq
         kSPXAK49UQJt2Ad9QefCckU/7FwFPvIkISGwXeVoDEModpQiSO9pVrXZ1xsvkS31oCR3
         RsZQLFvWlrO8PIhqiBllhOkYglzS6leV/J15QhBFPt2k4c03frmnhtRKJXXpRQBz/LFR
         3+lbOt3NG8YA92uyKfBWx8mCbt2jg+UIXaE7TOGJ+Pp14J+d6xXDJMnTzdkBoXj3/NjI
         Je2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695975; x=1794300775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VbM06yFn2Jh2tq6JZ2lNHsgrv3CcW4NZaAIdbeX3CqM=;
        b=HP7aTNSLTVLMZanOvtE70YFgBpVdhM44SLaNIJUZy/xqPBxbQc911k7MS8oExdr5DX
         xuSwQtJLuAldR95kvHbxC3VRQ5MGgLIoqPJir0hbrIJc9m2pSrpcX6PuBX17TO9VbCzY
         F68KMhTYt6Gb9ezCRh5Hv4Q+Ngyba/HgE5lbol0DaMkjlZNKkUVvBKeMmYfvNpbDHhsQ
         4VmwQUa999Q940LM1q9ZihH80fvXcDkVICrXcbdbzmxvqmzxG0klZ0NeD3fFy/1TvTQu
         miLEiPs/LBB0hP95UchwmpZJX0T+fBBKecUhZd2puS83Obq8/vXTqEj+UQALk9u7GITt
         HwLA==
X-Gm-Message-State: APuU4Z/SOMeiA1jQAjMWH5djrV2z9d80qt6Wk2NLhLeYyk1ly9QcdTfJ
	tCbS+Ui1juEPYKrP5Ls3k3ZYqDysT0uDRuTT7FeBpWKH+xeg1xLUnM/obhs30g==
X-Gm-Gg: AYBFou3U2OZp4BSsxXrMiWUorvfNprDrmIs5BOsyK3IPfW8w76DUV8u+iUDG26dZyGR
	iyMPbRsG4UxkhwTHKgu1h4jIsNJjnaxQeLuhAdoi1iiFYlz/LIGCfGAcpZwgLtnSRSXWmSE0mJt
	Ni7g8HpRD4rCelNj90WdwuduVluKNOu5T3wp4Q/uuajYF/ZXf1CxB7Bk180/W9JHNK85kSrdsmH
	0ShnDcgYTZCF0/xrRCRqd4k5BbdDGnQeJY7nqNBJxn1qqBF4RadH4VnAK6lGBTSvsvr5J4eMY48
	JQ6+4uIkfa3XoRQ6n2yq0ySRUoWYlyuk4zrV7nQd+5CgRolDsQFD/NFqh9mDAvdyBZNSLt/+XXO
	lVBGxuwonNfyBpLUECn1iAwNDMR8uJHCHJEJo0PrFZED4MBzHcsWnWZ7KPQTr3IaOGpmHzfun4s
	TeS1wYzGgQTLJ1Pgbi40nsnMV2NzPVdnN+3gMKQTB5tceEJU80j64RA8DNY+2uzdieccS2e1ozm
	BK++Z9M6Cckm+LYBG7WDC5UeHfaixFMtLXbZ+AdSh3TeGSSXmefgpakAEXh6pkwpK/45UqDOmon
	+Ev8/H01huWxOcJSZXnOGSrUgm7wyLOvp1mjHxTX5QiLbJRPS5OsyltC8qpYuSUAWpbtFs5z/lh
	p8WXXkyMISwvCnbkouFhuuwNiBgn5wn3AdbfMEgjJ1waO+fTqvHJj3q2EksgwAxj/CItBPbk+Ov
	g4ztqKJBP9Owgb02jUHbU=
X-Received: by 2002:a05:693c:895c:10b0:369:f05d:6c5c with SMTP id 5a478bee46e88-36a4240f66emr20228928eec.28.1793695974343;
        Tue, 03 Nov 2026 00:52:54 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm53065635eec.25.2026.11.03.00.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:52:53 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v15 3/7] netlink: specs: mptcp: add the subflow-retries attribute
Date: Tue,  3 Nov 2026 08:52:40 +0000
Message-Id: <20261103085244.23064-4-anilkaushikwireless@gmail.com>
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

It will be used by the in-kernel PM to set the number of SYN
retransmissions of a subflow re-created after a timeout, with the other
limits: add it to the set-limits and get-limits commands.

The uapi header and the generated files are updated with ynl-regen.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v9:
     - after a timeout, not any error, and about 4 hours with the default
       RTO settings
    v8:
     - the default is the maximum, MAX_TCP_SYNCNT (127) (Matthieu)
    v7:
     - the doc gives the default value (netdev Sashiko)
    v6 (netdev Sashiko):
     - the policy checks the maximum value, 127 (MAX_TCP_SYNCNT)
     - the doc says the value works like TCP_SYNCNT
    v5:
     - new, split from the retry patch (Matthieu)

 Documentation/netlink/specs/mptcp_pm.yaml | 13 +++++++++++++
 include/uapi/linux/mptcp_pm.h             |  1 +
 net/mptcp/mptcp_pm_gen.c                  | 10 ++++++----
 net/mptcp/mptcp_pm_gen.h                  |  4 ++--
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index f25f00759ffa..68734a23c4e2 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -200,6 +200,16 @@ attribute-sets:
         name: addr-remote
         type: nest
         nested-attributes: address
+      -
+        name: subflow-retries
+        type: u32
+        checks:
+          max: 127
+        doc: |
+          SYN retries of a subflow re-created after a timeout, like the
+          TCP_SYNCNT socket option, so with tcp_syn_linear_timeouts on top.
+          The default is the maximum, MAX_TCP_SYNCNT (127), about 4 hours
+          with the default RTO settings. 0 to not re-create it.
   -
     name: event-attr
     enum-name: mptcp-event-attr
@@ -331,6 +341,7 @@ operations:
           attributes:
             - rcv-add-addrs
             - subflows
+            - subflow-retries
     -
       name: get-limits
       doc: Get protocol limits
@@ -341,10 +352,12 @@ operations:
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
index 59d57aebf968..8ff103f5be37 100644
--- a/net/mptcp/mptcp_pm_gen.c
+++ b/net/mptcp/mptcp_pm_gen.c
@@ -44,15 +44,17 @@ const struct nla_policy mptcp_pm_flush_addrs_nl_policy[MPTCP_PM_ENDPOINT_ADDR +
 };
 
 /* MPTCP_PM_CMD_SET_LIMITS - do */
-const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
+const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1] = {
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = NLA_POLICY_MAX(NLA_U32, 64),
 	[MPTCP_PM_ATTR_SUBFLOWS] = NLA_POLICY_MAX(NLA_U32, 64),
+	[MPTCP_PM_ATTR_SUBFLOW_RETRIES] = NLA_POLICY_MAX(NLA_U32, 127),
 };
 
 /* MPTCP_PM_CMD_GET_LIMITS - do */
-const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
+const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1] = {
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = NLA_POLICY_MAX(NLA_U32, 64),
 	[MPTCP_PM_ATTR_SUBFLOWS] = NLA_POLICY_MAX(NLA_U32, 64),
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

