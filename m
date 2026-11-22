Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795308486;
	b=ZP6McLn5+iEDWUbeB82WXhKFPVoN55O26p3T7zr/pbvgvzyZ9id0woP3Rfew+daTz9pd
	 S8oa8c+HgMd4nkGjEoxuaUeLXTT/gNtooP9KjsYQiDvnYSIC14Z1L5Kqn4UtvdmhZMGKl
	 zqXwLnyaJvehZMVe14gMXLxBtZm8UcS5T7V4QN3QGih5IHQ7R9cyJUPGZcZmIw4MVACJ9
	 4FRRmsYp2jUberjU4+PVlgZcrADr7Y0oKQvjsXcR60DDLnmix9cOI99hByDJiEF1T+5Sn
	 MDqS83o5BsKrGiLG1Wgzs0gYXnGssqJdHW8nRfgvd5D65FBi8BHEdWLpCE/kMjvg+hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795308486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qNd7xgBLLtWkq6QplReL3TyWS/XP8hmLN8sh8tJEH7Y=;
	b=IonbViVUEleOgFL8QKS4s6/VN5dr3msprC+icJc+nMgcZm227yA2QIR+0kKR3JVBTX8v
	 o1JbJqq0ifzAkPRFCIJiCTCfzgETg6xFQ6RWQCDGS5JxRTS2d8Q9jg7xTPZ19BGX8JCnU
	 kVCy7aMGZ8HiQc+NKXKebCBYs+cDGkM6gyot3HIgQFc0qGk7DHdIloS2wDCXgkjkTXTPa
	 TZPZK7P2rUwThFY/K6Tl0j3Gr5tEhNrbrUVJ2PmCwYk/HdyHhZ4QPqiR5bsIZe5dimUPd
	 Bf5Vq00wyvKavwGN5n/UuwDvRMVkagXfgjmkx145ZGOVChniefUavHf8om6Ikoh+1bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hXym2dyI;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABEF606A320
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 00:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ABEF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hXym2dyI
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-38190551625so4335565eec.1
        for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 16:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795308485; x=1795913285; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qNd7xgBLLtWkq6QplReL3TyWS/XP8hmLN8sh8tJEH7Y=;
        b=hXym2dyIcPKyzia9WYCZhdz0CfOCfXQ91RtVl03MqC2khG4AZFbOx/YMG6S9/RxI9C
         0zxpnSUseDWBpIubp5Z3L8P6/QKOV91uS7Jmfi0jdhZ4+Sp154uloEEWcUmGLxgxY6ph
         isQEWfGmpWJa/weUK7V5KuT894QuXsVuROMWUcJibPWJA0IMaiXODW+rwlkysCU5rof3
         YBkUUq8zAtgHdOcBA6KjcrnsdBbhau5nouUWqRxSFnKkGqC2/mRRbKM/UKHVt58FZ2H4
         pFUGcDWGjDyLa6fIPQwNUsmk9Yob9fHN1nM4HgN0zo4crqzeBVuSeQvqbCEpHKcQIguM
         uVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795308485; x=1795913285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qNd7xgBLLtWkq6QplReL3TyWS/XP8hmLN8sh8tJEH7Y=;
        b=SDwJN2f4kT9ig1K555sTKsZzrhVjQT7bR57mH0JJ1gV0ned+IDMBqkaUt4ZHT3E1o4
         Mjjch/FIOzATyNjoCwK3+b09i+pka6PNybFxfTzAXPUMUCctyDHYZFO2I+ZdZkgkgFKj
         2O7qOxF2PYqSqBdflWIN4mtKi+L5CWi5IF6ObgFSiSFyDrNIwKDXetnSjS2jZKAYbMFg
         wpQHYe5/jPo8bOg5Kh4hXtiw8MObXxj+XKBG/4S9WUCa0IkyuYYIQfoPYQXrpvM06Zl3
         pIAMTRe9oftqybtRetSOoPdcj021NgH39INwZk3ZV/CwjSRqQXnwIUx5pGUvf/DIKNZm
         VAfQ==
X-Gm-Message-State: APuU4Z/YE4GkXlAaGQ4BKP8YZaDequYMe1vEokagmjMbgoRetImCSbuY
	Sz3ziXgmHEQY4g0nf/nvOJwynjhaA7wDz/f+mnaI1KlibHuwYbyRX9J+ZBvUKQ==
X-Gm-Gg: AZFdTZfqBDd0tbwwM5S6HNlgOcPEoEqy6j5FDfjjGWmtrm39v3GgSWYR8gK/8CSu6AJ
	VgUY9UUVMRcqXtSM2/AsK9s2Nw12I9ep+60iMneDmIkBIPPx3J5YCIOTtE3cYkakIOX4UAS7nKR
	E47TPAj40ZP9oPX7ND3jiKwbjyb+goCsgGP/2KMwTnZwSaedq5HuTUewL5W4kwMBde8pYltP91R
	JlMy51XewWS4nT8SOINbjbb+MxEVsG+oWkGTUembskIW8q6kqNgd93p9fwG06w6vu+ckyOH2utf
	RjP+ynw7bhM0GZNmN1FZRiBDqHgEMHSArxNi1WHOQq3E7ptAG5+3HMatBCZSBHmKuCAf7HpVLcV
	eC7j3nShaXsTeHL3YESFHTpm+agk8AJrC5LV3fh5HB7aUlZdErd4eUquwA56DiXWXI69FzpSEOt
	YNSbIMbyoqYSAk2TZzKXswD68cNKHVJYz4EA/l+4KUQXUyd8RWf9/9BP1WD2+3uhxeYw8Fnpbgg
	tQ+Wuo/6Hi7HbFA+TKDxEOypHkXWl7Dv2Pf1s25NLE7HwZzVYcvLrijcey6atpHV3wmBL4Nytso
	+2BqRJQTJ7H34E714BFmI9uZLRvZ029wU4jMs+czczkRMN9taYQCNqhNK0Y13xHIhRHxsCZrgmo
	slMIV1p0fYGRlto8P5igzSFco9/Q85yeNezh95dXnS+p10Fc8CHc6YYyLRQBSSP259cEkiwvAJQ
	==
X-Received: by 2002:a05:7301:fc10:b0:37b:dbd0:ba63 with SMTP id 5a478bee46e88-3856c0c8092mr8226604eec.3.1795308485008;
        Sat, 21 Nov 2026 16:48:05 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm20219599eec.16.2026.11.21.16.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 16:48:04 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: anilkaushikwireless@gmail.com
Subject: [PATCH mptcp-next v16 3/7] netlink: specs: mptcp: add the subflow-retries attribute
Date: Sun, 22 Nov 2026 00:47:50 +0000
Message-Id: <20261122004754.2276802-4-anilkaushikwireless@gmail.com>
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

It will be used by the in-kernel PM to set the number of SYN
retransmissions of a subflow re-created after a timeout, with the other
limits: add it to the set-limits and get-limits commands.

The uapi header and the generated files are updated with ynl-regen.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
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

