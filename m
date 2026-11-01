Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793517661;
	b=SUyGzUQr24Mi1d7VySDAYW/RxopYlj+KTRrP8s+3e5R4MIgnkVUGDPWxQTKQ0AmHEiqK
	 aizxLqLXavT9UAIShprQwSWYs6F6/cs4csl/14cFU5JvyUXLNjJV01eeV6Rv6iYGDaEcl
	 ztIc1BDUjC+g1Zco+dfL4i9gy8y/cBHgZAOKY1jlLpX03MkePLxvF83A8g7AuYw/RENqw
	 jIimc2yCnLGYA0XQRjlQxOdd4FovVCMWKZ25D7Di3tg2YhnmZR8vuIxLOmJ1TEUrA+1g5
	 +VkyB9V1XAzHCVbWTZF5YqY99iLQ7xGZhhEcuO9pV/SDMWfeX6nP4HgN30td82hys7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793517661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RhdWlyO5Sam//srEVeWFrjzifW9W6rttgI3RE0aHgEU=;
	b=IagCUlJLwm8jDT8pA24YNNWITQvFjmfat0GD/9xIF6+8Oj8aj3zoASp1Hixns3rYEIRY
	 2DOu1ZQSlYa6VJ64WMktEyap3onMC6zL14xfFwYyDKiGjBeyetsEG7hTvuDp1L6/d9VM1
	 sX6d5xSXeklRDRQjJ6rLTjnILtNvzOemSUgfOaD1THK/tNYfQBx2deBHvBIYMGEtTI6Mf
	 DIf1Xo5A0v/DKgNILqvEgOLrU4Ba+7XD2JcY3PGUEplbgm4dxqhhiXxr16Z6b0sDOMFzq
	 Qqs8UhJS8fNJb1cNeKQ4pIClRut8D8BJm2hU371fhYH6eY3lDrEztwxVZD5TPpk9qNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rc9xZCr+;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54A2606A325
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 07:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B54A2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rc9xZCr+
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a2761c69fbso2432837c88.0
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 00:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793517660; x=1794122460; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RhdWlyO5Sam//srEVeWFrjzifW9W6rttgI3RE0aHgEU=;
        b=Rc9xZCr+VAY8qiIntVp6ZJ+U0WI4uDGs1nv5fjwJVNCAMgJ2chHf8YACrBdlFGyHmp
         uY4iVYD6z9OuzsnbiBIiTSPdpBLzWq3EEmHrVUSW9D5lLBRa2gJ+Ip4jow2zJ887k/yV
         ETX2JNrvCSxru99+U0AiCLGc3loXrX7ngFZ/XD2J7H8gLxTHDqvOPzn7Sxt05MKKakaq
         UxKmkae8RnylJNm3v75V6775ElrrMaVZwKipC55pBgOs1YE/j5Lz3qs+zlehzWCJCN6/
         E9XyhW6l2rCeFWW+tKMkQuMrmjVlNUw7GXN6q8IPT4iHaHPF9Vfu5fOnpQA/QnVn6ST+
         atqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793517660; x=1794122460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RhdWlyO5Sam//srEVeWFrjzifW9W6rttgI3RE0aHgEU=;
        b=osKsn2MsMMFVFtM1UQGvLeBHbWp2QZIOhgJhEGc1YOPPPtXahb65eiqEg7N1/Py1En
         TbS6TB5p3Ue8FyUHkmHGmpM0tpc6LUqonPx9BJKOX/xjT+r6cNoluXiktKyl9yrZlH/r
         7XKNzBh1ADeMmbkltnjz5vv/hAyg5OEWDvCVyEZeo4L+kldE6WY3g+x6d+U9vqL7icjA
         LJcLjAyZuMB5hv81mlEdcjkTwT+s9JPw2qaRXWWJ427qb9j5L6okwNQ2tir0n3ppiisi
         E9YcsX/z9z5sduR2Z5vOEerOs6/IBfMedFrB4g9iNoSgsH6gVay39kehyowfP9VqPKSp
         yQhA==
X-Gm-Message-State: AFq9FYIYCREssx7dotGl9C1DcYjdhOyorbYOihUDa11cfcuqzZa/Zvns
	B2PESlf9XzCLopjKqoIkWGuszCzkWlvvX7PWHGAWIsK5FISJFP8NdYE6Ovwtdw==
X-Gm-Gg: AYBFou0BysKkrIDVzWjIlA3juwviruC02+VjbdVHCPgVkPlRmPCjuzSwaIUPHe0Xj6r
	nLrzHETrZWxTKaZDYvTtQ5wiTyjEtZzk9Q1VPt7XP/gBNW3FZuB8AZruhvlGBFUbfBUcb0K6Xde
	TKgfKEUiMNqCKDHvAG7V2YM6y7wJVr9cdHdR13DS66ecJKumdf/mLYO094OHJEhFZNBZfs/qIlG
	NQ5bhN5dcI361oX2D4uzL7sEOETEjSP87AlMAdUv+xq9YLHj26y+PMxSiop+0qlTlLYacpqUZqm
	v9swssVmbFl3/Yplyuse6KvR4x8PBpnbo1FfmNTdCAedw1xYyGL0uau/XKX+YFbjDoFmpkDbq/u
	v6xh/wcuC7ZBjdTaNbwQV+V9kQFy6HKY/+mVRP3cl6F3VRF41cmcMO3GRUjCAtObDG6d41zRbdI
	Un0UcmWCCkWEIoFk68xly/E7Z5xuVlEc3LWyrzfSNGcS41R6/LPodSNPLAQHoHLzwWSlF9lASB/
	27s82VRA8iHT5NkRMRm120DIKKadF7+U+5J35SHd3Pfk7Hix7w9nrC/Iyb4HigEiJBqsDowEIQf
	Jq1V1zRdJ/+87TVX9e6lDHcc6yIhQEwlh5m009BivHuzhxhVB5bzZPl3YmiHA37wRva/Yi2jyxD
	G1zoW0ziGY36jK6oE/j/t7SiAJBkOmIFYbE+COlfCKhyE94Vr8lvbS11WGTblVhAPr+bxulHk/A
	==
X-Received: by 2002:a05:701b:4550:10b0:193:8116:f5bf with SMTP id a92af1059eb24-1ac59dd358fmr9627306c88.16.1793517659650;
        Sun, 01 Nov 2026 00:20:59 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm29851495c88.6.2026.11.01.00.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 00:20:59 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v14 2/6] netlink: specs: mptcp: add the subflow-retries attribute
Date: Sun,  1 Nov 2026 07:20:47 +0000
Message-Id: <20261101072051.3853492-3-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261101072051.3853492-1-anilkaushikwireless@gmail.com>
References: <20261101072051.3853492-1-anilkaushikwireless@gmail.com>
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
index 39f3facc38e5..690d3c5dfdd2 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -196,6 +196,16 @@ attribute-sets:
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
@@ -327,6 +337,7 @@ operations:
           attributes:
             - rcv-add-addrs
             - subflows
+            - subflow-retries
     -
       name: get-limits
       doc: Get protocol limits
@@ -337,10 +348,12 @@ operations:
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

