Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792936158;
	b=balwgSjCHlG2E9Pwm3biaxqlEVJ+V0VFVaZnG2rBt7Vd324Cx2i2eELkRgrinN5injdP
	 gWD+YQJ6OlPmFRtTNF7YEGAPSejrdaYpNlGUdjoEZvDNCZ8CmsYQ50887jZFHuq+mb6d1
	 ItlmVChwJKC4kKuDYLV/BzG1UFRVfwPO/nIBPHhhT6NpM5rZQBai5nbU/thkTq6/FOUIz
	 bGXB8/rERtrGLCfUGJp/pNiB6+LcoHGUJBVGpqYZvUqNgxDsCazmhGvF+0iZcVdMn7wwb
	 W8KAe7yRjJXFUTxxp3A1TlILyxLoK93i1TxN2mbFWhlcbpU8mzJQo4cBtM/RLyUejKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792936158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FoHLCgKqo6W+cZA4LHdCievgvvTPpTAKrPT7nHC+Dpk=;
	b=0MJk6bQiS3xRM3KcK83noB2heql+1YQDOFXK5LP+BZikgO76swlDx2dhJwLHKnrPwo6V
	 5WxnObuxE/uKH1AmccnUMgtoaaF4+H1Ccg8xB2q0kTMZWp6k8daULKmezSFvzvV1M+BE6
	 U2z7S6c2aguqn3USGbBuHRg0iteo/U0vIfXyBHAa/NCl8sM9dVZ7Iy+auvSgTEK5FQO20
	 nHl2hKM/5QhMFttwGCI2QUWY75OosFvjaw1eUP5599d3+yK7Em2mLDbJsT6l1gbJHB6kH
	 9rjhhPXnQl6eyjRI7q1iaHKwSH4A2b11m2A1uTrEk+1FGgxzOXHURZG/ZHZnWL7sE3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MVLxTF9g;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F874606A31B
	for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 13:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F874606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MVLxTF9g
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35943f55c06so3018215eec.0
        for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 06:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792936158; x=1793540958; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FoHLCgKqo6W+cZA4LHdCievgvvTPpTAKrPT7nHC+Dpk=;
        b=MVLxTF9gXJnLwZUCi0llIRSCTUJvpEvknR/PCfAAnHYb+OeeBYoe5bnKDbP8wpCsmz
         NNjEUINdX8CzclsREoDp94eR54cyWmH/N/lYub5liC2Gy0g2O3ohkyaHyMW9RtSqdBOu
         J8Op0RU9b3BpAaJW8slKDBEsDyNDsNahdxzXv9/E39F//NQBFztl9++mQqyrQuAZPvSq
         323ezL0xrc4+kjc0iVpr0x59YVzDAaKI+SSjefuq9uhTkz/v9ASpMgWgQSlOZKtUM4vd
         v+K7cCBpfc+sQ6ilQlGA37s/iqF0vzLeU7grifgMJo0epXkxGC8LRDy9TlNOvk5sY+9J
         OKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792936158; x=1793540958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FoHLCgKqo6W+cZA4LHdCievgvvTPpTAKrPT7nHC+Dpk=;
        b=GSSRHzmFIGm2DKH8OS/rb+2GucTs8RQov1FpH/sz39rwDUbSLcJUV9J5/Id7URcxRM
         QxY35+icdY6lJBuiBw0tW/P7yNzCj2nLCjHgCzSA0AA0jOOQxqJcrnCyUoUIdfw7Kv0P
         EUfXSYr+wvMkw1/ENEve+bkSXH56ef5vmLT6C8Rck1ULo1i0An10hMMF8NHZzVnqq7o2
         lhmd1uQD2h1T36WwkPCKjfOkDXS2MfU08WywSUx1DMfB3PTWXKqQmTHFVXRx7PvMqZ1L
         jojdYvONcEvhkZDDEzPFNhfCf6TOjp0bw9u8Vp8CGY3U38k2/DbPwlIm2SnKqevfhtq3
         FTuQ==
X-Gm-Message-State: AFq9FYJcD4ZaiM/hG5B51SocDQNQJfZPYMrUMK07uAN93ymWv9NddIN7
	TbXV9KDZpqrReiqt2qux50KoHNGxAZwylhJlOhxOV9oKRNvSNwewo7feOA+6Vg==
X-Gm-Gg: AYBFou2u3lrKBgnelPl4Owl0x92t/3QFzz5GkXu6R/Z2jfa5zKU/c2w/NI0xOlwZ7wY
	Qt3aWsJzZHxOtqvKMtXjcJxq6yvnE1ps61X5FLMQ5Rj+K2eh4d4hhwLy/i1LhpCdNhy6UthUhn0
	I6t+e+y55jsRL0YpMBuFMVaxTQnFn53TXBMoj1OEojP225gn+CwoTT/SJKSVmR7B5L/xyqekwFU
	7Zp68hxwnPFQDqyTtwzrylp/UPGiD8ACUPUzvQYCtZO2eF4cqiVWW+VPEn/5lkBFbcIf+W0lz1K
	9CIHItD2OV2JmImQeJNixMMzHZ8PVUIoWAE70oZ4AoU+h0mzya2G5oQ1ogzzV83m/RcsNPfMxxE
	OxvMC5fMb6yRscd6NrPT7qNqdmgayW0wfMsYn2EfhCR0CbOMxIXzbNsnKzBv55QLqXdD6i8Q77y
	ZZWwEPay3vjQ4CQnb3goXjAdu1TnBLbQ/THsHS1hNhE/z2/68NNoU7hYnxtoggpR55C6W8nKKnx
	G9WhbPJitErMHfwzh581fyo5xJIQuD2n7kbIv4g8QPrmM09y/TmM3m4Fl597bdVaUvi12u9TR4z
	JT2z9cPfYd4LCWa/qOcMrMAHHgAQ+fsL1+OVOY667uA8Dz8SZa611LziiXVbZOVrXRlvXkuR9D5
	7exHOJW22maZs0XQnC5Zy9Vn6
X-Received: by 2002:a05:7300:559f:b0:341:c383:9afb with SMTP id 5a478bee46e88-369e84fa1e9mr6554230eec.20.1792936157271;
        Sun, 25 Oct 2026 06:49:17 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a002a486csm1188159eec.22.2026.10.25.06.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 06:49:16 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v9 2/6] netlink: specs: mptcp: add the subflow-retries attribute
Date: Sun, 25 Oct 2026 13:49:05 +0000
Message-Id: <20261025134909.2794368-3-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261025134909.2794368-1-anilkaushikwireless@gmail.com>
References: <20261025134909.2794368-1-anilkaushikwireless@gmail.com>
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

Assisted-by: LLM
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

