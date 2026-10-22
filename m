Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792681901;
	b=TnCqx4NGTcAzoIwKKgTe51srD9SpgZFh2/pdPgnS14WPz47gG3MWa7hcYDWhn7CVoKJc
	 iAmUTCUNSOTM3q9Detrv4tRxRLjTQ3KhbeR28oZrfi3fhTeivekQu2fym+qLcvDKTpOFc
	 ++Owp/i78WaKgfRI9pnI50pYuyLUmbm3naw8z3jctNNaUcqTPqN4e90cROEyEvDEEhVu+
	 gtbqMfGldSrpmtYHtygEk7gNtqDZcC9EAbsA9VPk2LCtscZQJV7L+/NQEyH9J6KNwPq6k
	 DSXVzdYw2PWcQShqxzJskHYt1ZExmetlzB11maYKAr9Di1I6VYisR516Bsf2Ac2ketA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792681901;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ump06wsghp8b2HbD4sv+HMJtzXS8AH4DrSGwHLv3CFQ=;
	b=N0aeAFhr3yLMUd9GibvJVzUOeaFAlbt1h01XfacuB1B2rWH3L+T3hLne2rMx1v9frJJO
	 7ZVOgq+2iyGEzjArBVQWui527Lf7MzPt+gfR+3iLluSdheWC3Cg4NBRbZkVo3PoD/2g49
	 nkcekDJf6QNYdVQX9XrXlthzLQ6iuXQaCwN5sDPSa91Pg+8ENtI/POIRGPR+1sZ2jFj17
	 5HGo5YVqR3niwonQtXtz3BK20jAhhvUTRdj2E0/NFg8teepixaEEEPst9+96MEI6JwEhN
	 8pi6FxPhpnc+tHrVa75wqybmVK8Uwke/GYL5JFyeFicqSUvTLMyJQCOh0tSjUqk16tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="bNhTr/1P";
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D64E60A3819
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 15:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D64E60A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bNhTr/1P
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3282db206d3so4466479eec.0
        for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 08:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792681900; x=1793286700; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ump06wsghp8b2HbD4sv+HMJtzXS8AH4DrSGwHLv3CFQ=;
        b=bNhTr/1Pf77jOgm85lb3lHOVIhfpWkRCLaEEOexbx5NKqFszrMs3N9G3pDt4+dFn7v
         j/8mBN/Dw5FrWnVqj2yyG9X7EjtTQaL4aP/ToUlIfFA9ssyyVkyjJULs3KSYPnJW/tp6
         qxO50jy0vUGhXVnpsZ3VhUxz0ssIyxlJDGJt6w59bOcsZcTJFVqvYObM+JFoYfvu2GxB
         GUmQt6LZkJsjc1RmO1mUvFvBkTEMByR1ZZEo+B1VK2k9c56JAsp9RV6BzF6gyPyhU8dG
         WwRUo30QAKtgoYz7WLYW+8nWw73hv3ob1XMY8wCMGkuPuk0AO5Cwo33DKiLWKRfw5QSO
         LwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792681900; x=1793286700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ump06wsghp8b2HbD4sv+HMJtzXS8AH4DrSGwHLv3CFQ=;
        b=jp2lwx7ilVUgssjDZBBB+xNTrq2LiUq6Lw/m+YlQWppIr1nRbpljxurgWLLYcur3WP
         4P08+WI0AR+U89xrm9bRKZjHE53rKkkWk3dxB/yaalOIC/zWPpFRMslRUYfC3Gf37/TV
         oKBRlQY3P0KjpmGdmfr3vE6vr8kRkNM2R+G3jsQujcrwduJ7ZCqRG6OpEl1BLIsCpRZu
         hDwB8k/JhncGloPK9mZx/jk9NWKxSgEgFjq7ODPJaUnZBLiKs7gUW968zhcENl+L4gJE
         XtnahtRysgpl3n1s8mdrVoyvkYIxYHDP9Zx1B0G8IVLCPf7xVt34myER29mIbGFUiT2Z
         fFiw==
X-Gm-Message-State: AFq9FYIY56HelP9kgU8/Nv4nyMDrDIZtRG7lHJk4sRddUGLJ85PQ8UAB
	Ja/73DIYjvYiyQFiGhcP0BJ3eUXvueCt9HrL4vliUC8DdUOMPxYlB2KQ+MrSyw==
X-Gm-Gg: AYBFou0EGgt32xVvCfdbRadyYEhdSlwQfd7qqKZwgmAek/YTSfRNJ3PCBGUL65wzfot
	MY4jsksWExmjL+7VdfA80XFZXzp3kvZ2L9SMKLADRl1zWWsvGB4LUIaVPekXst+BYJ/BkJJQmGf
	IS428S1I5FcDUYQMeS+hX55X0cQGlFQzX5qiyPjoSYofuD2UsSjj2Fqbqo3cGRXijPw8MXaxaUc
	lZO1KS8r/eIg1hoNOJWjGVDBDGvtzPN+qgaqk6hi9kNnD8S32BVxBwtpiKQ31w0DpWLqWF0lTkm
	9FbJnhLJi3i0fqVpjHW0hsfoGqoLEOmYLVTYV4A9uVHSB9catP3qbPta3ejfZhyl4189vwx8zsJ
	syzS0Ry8Zt4XEcoDnlq1LcPwSV9LKxtlVgY2LoaQuW+AT0HwkyLoqC4MCe3TJkg9KPJrkYWNb4i
	cF2SOYC1o0qLlb0CSiC+UDC3GiIdTL1BxCuLOqwFyH6AjOnHdvSAy7LGF5M6fkNELWQhITpxKd/
	t1vhhgzKVgFCUjUdHpX6QyMenEMrQ7S7mupgY4MgeBe42pCaCWWMtZ2jboL2N1Q5wO0DBJDhzO0
	6uvA8McH8+o3VRdV/Y23Dm3kC8Cy2AOnPp15Q/X6tClB7+XyCf8ZLKwpRs24mdpp4nunSYOuUUT
	NNLXOzmPdDPOPvApOdXtdC54A
X-Received: by 2002:a05:693c:2808:b0:369:9062:c392 with SMTP id 5a478bee46e88-3699062d8c8mr1170114eec.37.1792681899953;
        Thu, 22 Oct 2026 08:11:39 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741e71eaesm36327560eec.26.2026.10.22.08.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:11:39 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v8 2/6] netlink: specs: mptcp: add the subflow-retries attribute
Date: Thu, 22 Oct 2026 15:11:26 +0000
Message-Id: <20261022151130.2285198-3-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261022151130.2285198-1-anilkaushikwireless@gmail.com>
References: <20261022151130.2285198-1-anilkaushikwireless@gmail.com>
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
retransmissions of a subflow re-created after an error, with the other
limits: add it to the set-limits and get-limits commands.

The uapi header and the generated files are updated with ynl-regen.

Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
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
index 39f3facc38e5..5374f06b04dc 100644
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
+          SYN retries of a subflow re-created after an error, like the
+          TCP_SYNCNT socket option, so with tcp_syn_linear_timeouts on top.
+          The default is the maximum, MAX_TCP_SYNCNT (127), about 4 hours.
+          0 to not re-create it.
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

