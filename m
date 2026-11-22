Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795308484;
	b=DkhjSOBisjyZpev8eGhkBATf+LJeu5fIrUxBPMpijhlVG12Ytb1IfSk6XgbRFgJ+CxCx
	 RaEfkdmKnTydh+y2efoy8z0ZUsms4JSbipSxSt0P5DWAg2pUShMpxgBchLtwmNGTgk8F7
	 Y0avMVAICgzsy3/xdgOZli+ZbfiaP6Dbdvet+EkPk1Lyg2sfbzsOdOTRVTEap2fJyzMit
	 oMK/3E0ElZHJnRYYa/5QBI3IV0+s3pmGm1YXmXs38xqhUJcWYrNAzL9KcWeQto3zSt3Y/
	 AQpZAsN73EafuhZImfEEdo0dTjkwsaiV4f3bxZ5bwjlNSEcPl7orzIY/6j9d1X2H2Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795308484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M+s9brDDnZyb6J/MFw928VMsWvingI0Duby8WJMUHF0=;
	b=CKZIkhDjpy2xya7dica7KFJeWbFEujA53bEQKLwm38s3C3hnkwOh3cxm6GwQUgFu0FeJ
	 4YJLGOA1nzT2mwXlU5tbbmDbeRTnFYtXn5T0MnoP9idReTffyQCnOAFkWOLhj0hXPSVvr
	 zr6jts+69fR60w6/3/xprGlGsxRIUYzY8bkxbMpLtm6PkP00FCgcUrpTpkpSsO0/k0Lg/
	 oRcjQWimXJlavudlUKArRUvcYx+ZcnUxO1qzyehtIOd9E52pu733SuNwpkUf9YbToOERK
	 sHZcgs5qPvre9k1Ix5QqgI2a5ziW1vUqAWBcc4PNjjSocjNIfx48+SRkHRz09oVMk5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SbzJW2UR;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059F0606A320
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 00:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 059F0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SbzJW2UR
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-38699cf08dfso1436451eec.1
        for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 16:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795308483; x=1795913283; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M+s9brDDnZyb6J/MFw928VMsWvingI0Duby8WJMUHF0=;
        b=SbzJW2URPqFA0CsZznQW/xGiaInuAREa849kMfC7cA0stHNQgxuYL/IbcGQ7Cv0Zgv
         X8FEwtixvcWHU+/A3lyjR+hqRv7WkTiI7ZQXZh8GF4nxRtO2Lglov866wtVhcGBHuuQW
         G+FTofTIAXKcelfMjLsJ3XBmPEtHmJlslcKSOUbTpMfUel8DQxHnUg0DWvtc0urMnbdl
         ss3SJyWnp72onY3qs2nNKbB/7viGAyMw+za0U4eFXLzNnRFzbdmPSkRwYZYq2TANLElh
         ns8YY6LFghoklKuCb5Ni6hiboo9Zdh4lpiqCHnaGRkJafzVvybDCUu2BoRtYSj8E8D3D
         /I6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795308483; x=1795913283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M+s9brDDnZyb6J/MFw928VMsWvingI0Duby8WJMUHF0=;
        b=xQrqg12riquvt0dMTaRHJS8GujODazBUsY/RpKwI7+LkHHRygs2uQNulfMoKIux/9+
         ejvye7Eu/og5gpe2ik9toLGJCkk8wJLRc84/nKS/cny0GarnXbuqg4Ml+SIyP5yrIu5q
         Nvaxiex9AQjO9J6E2Cu/48AymueBxEA2Y3OWG+1tNbFgqnF8oj9kABdQI54IZ9tjutOS
         pUeAgTKQbc0oOvJpFGWMqoWdzUejVzWZeuSIbv9HUSh52Efk8XxIbioOVPu3oWCCpdFc
         GF807/KjmKLgcBoyjrLbn/t06aATF2UBmQPMnyPv7mjweOrJk13bm08SRNVnICI3nJSr
         TyAw==
X-Gm-Message-State: APuU4Z9F+3VQlVw9wzBAiBo0gF5tdBtSXOcRS4lPVY0pGqzqBMmy1zQl
	/kggHlz1Rb8NLxboZZ71ZNhZkJloUQqy0Siz+yExe6RFj8HviJKrZianWg/bEg==
X-Gm-Gg: AZFdTZcCsEfxRqjv1K+l/yhduNttbY+sC7La5KFvuUcxSpY2yqx61ZczNrxLgTSqqxL
	7HDRE50LbETr5EgaYiQLU+f/E/EeFhHNJ2pZLnTDbMPhqM86vhSJuph0RENSqZC/zwM28zhRdKO
	O8bf7xh4e8yJ5KbhfWGQqK8UzOyBhsFfFZza/JmO4blGHDvmiweYrfyOF9uieGmalZEDErEDhnH
	EUxXHwhfVMrRcEZIBpz//ApxkOFi38JUNAEd2C/tawBT9mewSkkoHf13aHRUFsjTWyRV3id5NM0
	mYqXK4cn7NQT87CrDsL5AFnrPGVmEu9GoAVuKmkZ788xGeyN7ZHd8NjG1Nvd5G+ym/Pei457u1X
	vNZhtGOyvBpJlu/AuFPPMPNPfxAgxRB95xalMScGrwrwDCP94cQHRv4lS+PmS3eZEI39ZHKf7Uc
	fL39FxVncfaFx9Uf5nWN8QVrs340vO/yuR1/nFlBkqD6ScZehLU5SeWg0pXxuN4+81iI7LXDlsH
	tWQMUUpW0DyeAXsLsO7/K23NZwctkbY7jt2PRlxJaUrgTwuU8vO96obyto/O+dpSWZLRfPYtSS9
	XWGWXfy7tO/7IfuVAmSGqEth/B5I3SCrrt3YXDmZAwHeWB6AEAl9hDp25yKPkPeDgxwR7qEU3Co
	ZaU1MVu5zjLTRY//YqfMu8m7QGzPpL6sLjcd/DIeU2A/vSZPjY0QEYMyl9QIY7mx4PAhwrpyewQ
	==
X-Received: by 2002:a05:7300:1909:b0:383:f646:9feb with SMTP id 5a478bee46e88-3856c4b8304mr11732955eec.2.1795308482957;
        Sat, 21 Nov 2026 16:48:02 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm20219599eec.16.2026.11.21.16.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 16:48:02 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: anilkaushikwireless@gmail.com
Subject: [PATCH mptcp-next v16 2/7] mptcp: pm: in-kernel: check the limits with the netlink policy
Date: Sun, 22 Nov 2026 00:47:49 +0000
Message-Id: <20261122004754.2276802-3-anilkaushikwireless@gmail.com>
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

The maximum of the rcv-add-addrs and subflows limits is checked by
parse_limit(). The netlink policy can do that: add the maximum to the
spec, and drop this helper. The next limit will do the same.

The maximum is unchanged, but a value above it now gets ERANGE from the
policy, instead of EINVAL.

The uapi header is not changed. The generated files are updated with
ynl-regen.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
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
index 2680d4672d58..eb66e0c1c797 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -30,7 +30,6 @@ struct pm_nl_pernet {
 };
 
 #define MPTCP_PM_ADDR_MAX	8
-#define MPTCP_PM_SUBFLOWS_MAX	64
 
 static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
 {
@@ -1402,46 +1401,24 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
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

