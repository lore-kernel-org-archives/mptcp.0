Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793166113;
	b=WIc1xLrMAyaLT5YPI0fnrlCMYPDNB9cf1YI+pmfmbATbQCbO4ZEyH+xGmuGJp/sOatmy
	 +Zbur8tGTLzK20jcZNic8K2bSIWFx/RuCzi44yK3BWmTBoQvCL5aYlpYvN6FEm2u5H7sF
	 8g7tQp4E8QJRt7edDcskMwGvk9vXFcpljektIyNac25caLv1JfP2sK4YdHgvvpQMlTVLI
	 ZFCOsTY5kl4T5a77/MZkHj24JXvRvfhXOnb6PVwbM94tnmGucouPpNM7C7+U+ZFlb5pDv
	 lGovyMd11pyff6rI9/wVvQaWd6r6SeErPWiG1tNdGhJ2fHL2ZsHEt3I9YwufCEMRxCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RhdWlyO5Sam//srEVeWFrjzifW9W6rttgI3RE0aHgEU=;
	b=0f0qQcImbPXk45mBsYvTTebA6Od6E1pr4gA+ciWBgejgUeUs8swqb6YNJ1qFDmpawAHi
	 fdMN3UrGksEuFqR8KPf+XRwJ+EWfjd0iPU0PTSBKNZ6ixWHpWSQiFywTMI/NiKkDt/Z6K
	 6QBv9DkksX6lGCh2d3gBPDbOr32uY+GPZnp3p9iuwa45CnKn4Fm67sj7MJi4gEinsymTC
	 rFDoRXBuNFkwKnNxkib9UNJbmLeLj4NLJ6BGxPvPmxzJ25rN54dlniC/NLiI7nXdVSojj
	 BPRh+ifFwGy18m/0l4yC9X82/f23CPwpYRZpC5pNVk9XWr7PWzlkySaCRhXGXb/aEag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gxp8WN3F;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF0606A31A
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 05:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BFF0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gxp8WN3F
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso1059933eec.0
        for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 22:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793166112; x=1793770912; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RhdWlyO5Sam//srEVeWFrjzifW9W6rttgI3RE0aHgEU=;
        b=Gxp8WN3FJSiKo4NKeQPC25Xr1vZZfBGwnBwyWHXlmq4aXzLCXodUynXZ2M8a3Mkdzr
         ggXgPywY6s+XetqlHONgDEAMLVboqdA/+sNqXzxs1WN+Xs/oldUufgKC94cym/2QSy0a
         41U3XFox1AirWtNN/TSqbXYenf8X0/4+ocPoi9ppBT9jS7PBUkcjhGGwOf/6st9FdjgT
         w2eppFRrLDShQRDkecXrc1XDdvNnU+9MkikXRG7EY4crfCEAbtJ/0/f1NgVyrbVv3Hw2
         JwSI6bFuf5IH2+THgNGokzR2VU/az+xWQr6Rp7Dfnb86Acyalp3gFLI8xUV+HhVK/o9q
         sFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793166112; x=1793770912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RhdWlyO5Sam//srEVeWFrjzifW9W6rttgI3RE0aHgEU=;
        b=vzHZegspfRsaIWd0yPLGyFszDVI/Ho8FKH9rxG7dgOqmNBR5XYaxzXVjXeTCIUYZ6b
         exE8dqNbwibn92vMfPwOjZvSDf0C1+541FJskqu3ox6AD1pZkAZ2LNN5fPgGgHMqQbkf
         b+15v09EsjwKfQ/1z52uaAeltMd7sw70rhjNoXDCTqO/aqABEavMQOi40Lvs/7n/6trh
         0QrL3AQnzlfwJxNzYGC76V4CaYMBdjcpHJi3uaOYbVBG3HTY5eIv9PStWXHjsnfk1+EV
         rt4Ri5XyusRGJMP+U/aVj6UHD1FH5RfTGAtn+OEJWUkEut5dKr18+1vwOFcZolyv1ksL
         iMJQ==
X-Gm-Message-State: AFq9FYJanViu4+utXeFOz/qcB3ZJaPJs3AVmma5qkDdOuct7xYuABakP
	p1sn9zX2HE354H1g7Uoj9nzSPjTSyIuDHbIzN6F8OilQ82xqNSD4HXwbUKQAgA==
X-Gm-Gg: AYBFou2esvoZEJzODcrxQzLqT78WzGu7rK00SqC0QhZA/BgCBUvzkenG4t0k12uH/0i
	fizIrbCQ66bAUUyZ1Pl3TeUcBcD7n4RtKrdVWyE2kMkfLkF6MwXGE+N+PTTIavITd0RL4ZwyDzz
	A9T8yhnrJPQIVfdDOvcJWSBvt0W29Aqviu97s4SMZMg6bAjZqo8X7tvenaE1PuAcSer/5bKsV3R
	m7aun3rVdBlP409O8ETzf2FSxsmy/LQ/8Wa/PJ/AAos+8pRRNlROEbuPUM0SKNiSO8/z/7yP1+K
	CP3z/J54rYOdv4Py9PtxuYhjcsbY3jhhKx2VE0TRQqc3JxXcpWR5bGyFfvshUawgkKegEP13QVe
	aFq8nse7aRd2yf/orWoRIOCMLEcgVtf0QNiV2xWmSpt0UzOGAI0JigyFCCp+ueRIO3yr4M2/I9F
	7pJBh/EVbWKFE7hqYMk0csKpMBcE+XXb0H9sZtsUjemOgrLGsQjm2duu+wI7xUC83Da6vMy6bjJ
	1m+NkfTilSau4WO2+TqkWFq6xSOSuFWVZT957hNWheRD4+9EAl8ktGJ9NWxJAGVfYi+ru0XL1Qt
	ZdnMqc2zF0cjiLR9v7k6RAz7zrWKdCtA8Kt0e5KBT1oaBEW0wSeE7xC0E5PHMFApXBaMq27RVMB
	cizlCnPJxAjlIqpk0Aktobjqfa0zmGO2V0MrKN7/WCQ1CQ2uo/TRV6CcX/4vPLEax3Id29/SevA
	8=
X-Received: by 2002:a05:7301:2411:b0:369:fdae:c9fd with SMTP id 5a478bee46e88-36a201132b1mr2144488eec.13.1793166111791;
        Tue, 27 Oct 2026 22:41:51 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a237be80csm5860973eec.2.2026.10.27.22.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 22:41:51 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v12 2/6] netlink: specs: mptcp: add the subflow-retries attribute
Date: Wed, 28 Oct 2026 05:41:39 +0000
Message-Id: <20261028054143.3222998-3-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261028054143.3222998-1-anilkaushikwireless@gmail.com>
References: <20261028054143.3222998-1-anilkaushikwireless@gmail.com>
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

