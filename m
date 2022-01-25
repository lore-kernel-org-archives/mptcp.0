Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6288B2CA7
	for <mptcp@lists.linux.dev>; Tue, 25 Jan 2022 11:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643111349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yR9LWfG1ta7qIcwpzlhRb0qi90eMLDiPOF2GSxDizxw=;
	b=bIXLob38ORTlUDdVwMv1WCSIwJSVNolcjtzIy5ERaTfiSlMML7DImgj/3ImzIsn5ZxqdIP
	92qTWZuf2QfszprXxBdu5z06LODQg5QWb+CF+EkIjEqom/xwkYo1b+vQ9DHW8s64Q1LrCB
	NhF0Adqizks+0rsvg6xs0uuiZio36/8=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-9BlZ3JebOfCpIVBiqzBDLw-1; Tue, 25 Jan 2022 12:49:08 +0100
X-MC-Unique: 9BlZ3JebOfCpIVBiqzBDLw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgJGOtixzQvIPAn+k02iNTN/jTHbicGI3t6NAtCUFJwgF9PRQOEUE/INoAnCOcYEuIKPHFZJ0PFZLI3Zp8kvZlbksD91uDTPXV1MZ9cakjgjP1CHw9hHqTdGOQvQokngCx5kaWgMZARuKJ57ApjnxA5Xj0JC4QTOShZWSIyhklhuAh6lPK9xHfaQafITln1obgWYrN4nYObvbRUdm8MShLmdRkrO5AkWysQGF0wqSny/WGEqyRjwi9T1Y0wVc97P7Nix3Xfct+EX/AYGGUMTUdexR7O3CuV/JKQ2ydl5LMy9drZY7Z649lkhUz0VMdLhbBQf4dDwEJmb7ghGYAAFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiYF/CIlKRALhCoNY8bR9m29wP6j20lCgtH6TfwAFtE=;
 b=ehPNEJSmC22Szew5LNMumTMmxAwqSB4e3MsiJv7wOyU4H5AeGZc5gYUS7u2yQJA2Sfk4NGI/mnGMWV3TKewqDuOMZ6txC+osM/p8T8HNebBQ+9ykJ1IKMHsGn0s3tqRWTEkTOt4jSX6+dAmTpZOfrEwm6p+dCRvB/eCl+a7yfzVT10HDWaw+Cs8Up0DRD3mWPyv1mv/SPCkq3z12MS33vqfue+PDJSTBSlzTdKx0dc7vADcMgjdQpPKHZxpfX5kgmi4uvlwVRbtUjeMms0g6sSiih9uuaYGUIKlsckAXA8dB9JVy2jOnjOHyr/mO3AbiEeir5SWyzJyc+sn3F5xgFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4775.eurprd04.prod.outlook.com (2603:10a6:20b:3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.19; Tue, 25 Jan
 2022 11:49:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 11:49:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/3] Squash to "mptcp: infinite mapping sending"
Date: Tue, 25 Jan 2022 19:48:59 +0800
Message-ID: <a89164069e575fbb57a426877cc6d55e72a6834e.1643110285.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643110285.git.geliang.tang@suse.com>
References: <cover.1643110285.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0186.apcprd02.prod.outlook.com
 (2603:1096:201:21::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68f2a063-7626-43b4-be03-08d9dff8b140
X-MS-TrafficTypeDiagnostic: AM6PR04MB4775:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB47750B3B125453BBD907B99DF85F9@AM6PR04MB4775.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n2jHiKYD61eWHBEp7R5lA8SlQ2m2t8GszMMLVdNobw2GJt+vYlwm6WPYqxN9f+1zI4s+voFvUqv1omMvLrTNXFDwOxffJFwk7//xCqRMSCvdFK3TYpz7HasSkWEtbhDwbkab90Z7mBywfTa/YT11/sL80JaT//sqoFW4HTthglTOL7VD98YSk/IQgi6yjtN1BF3NLAD3yVL9kb7EdWFHgrJZ/orsGwjgSoUO9uCm+hwbN8LpyO0oXLCQd0QBf86dmVTPtdOYFRfGUxZnv70XMjnGXSoEeuMWMLnYsVVHBdWlTF5zQg6iJ/k4kvsbh0ytlWhBN8wgiUM4omKNYbQTpiV+9TLzQD+QQFC/nf66WeIpqiqNcSzRNDQo9HueTEOs1lr+NUKnV3OcxE7laSVef69bFaahBGKplIuHVDWc1M5ZsQGTdP2Bv38hCSNGyFrcAkGj6jWqKy9dIz5Dk2ghmVegoVOONDmGCrDwWlFztxnglMh+w9FCSuAFh597gySnMeDsTaLO0B+AwNdLtroDiEL+688gTz1r3JiGmQNAqtwRDBd/AjN5Izlo8W0qnJvPyzCGGQYkpaAZeX3IYJFuyw1DnhZPqC5QBqydwfGWpJmmWMPnM3rqVImxZmmDQp/zRH2r78+TDw5PgnUVcrQ2Cg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(44832011)(316002)(186003)(5660300002)(38100700002)(107886003)(6916009)(2616005)(36756003)(66556008)(8676002)(8936002)(508600001)(6486002)(66946007)(2906002)(66476007)(6512007)(4326008)(26005)(6666004)(55236004)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7MnduA5E3xtMgkUDszC18j9uRXTgFFQ4yunC3nwcnJTx2lctA0fGgefMW5rR?=
 =?us-ascii?Q?3XK017TzUlxfmHJPwUmW+ydTnv9OoGOGs9PBtT/0AjBQ3A3l7ugnR4pR0Umi?=
 =?us-ascii?Q?EN7WmlX6J4ZJNI+DCQPZtRdWnjedJXeM/d3LFsbD5OL6XRspY3p94N9KQo1B?=
 =?us-ascii?Q?t0GspBBkbh9dp2yvUuynI9UZIC1U1H4cbjA85B0YAm6dflscg2FGC3C/po/q?=
 =?us-ascii?Q?JhKwdJSY/6M8MwQOr0AbYfaVOnDDnggSYSS2kAfvmYvGHeab3/165qI//Tiv?=
 =?us-ascii?Q?k1FwWMzfSDkoXy+jPRIa1GIrLB+OccD5sSp/k47T86pELoXXeBLy7szYmen3?=
 =?us-ascii?Q?fW9x15hSD52nomey8aNZuw0KdsWyxtCDWXFcH+wlETbdyMli+FGWcpkbuA0j?=
 =?us-ascii?Q?NKOoJAt8zmRU/HkSKsWxrlje/t098r5K6hMyujYTsfyJ53Umf8UBdL+amMzt?=
 =?us-ascii?Q?c5/5hcfHY3sryYR/iifiTRltLCCymbEUGmEVTTnyWQeb93Y0gdyfE6MXirxJ?=
 =?us-ascii?Q?uN04HFX/qZOCwOY+/rTYh8TUAiyJPIE5tcTdFwbYcUFHfPsrnh5309SCIs78?=
 =?us-ascii?Q?ncOHNArFCuqq0vtq/ZH7z4GNqGhbDI0uSsUnalyUu0r4sLmKmzPGX7sFyBWR?=
 =?us-ascii?Q?tQSU+fBRGpa4q/58fhQlKef+0ZFWgi43mb5wEz0YaJGBq+J8UPij+ovP9RhS?=
 =?us-ascii?Q?igwuYSaI2Zvq2sZyNoiqFU7L0mSYfsRyboh/UHksZyzqS96mcoxAKQKvRumf?=
 =?us-ascii?Q?K2xvfu3PoqLvhNa1FRya93s5hQkJciW4t3nv/pkAsXCG4T+7jrKskGfIh/SF?=
 =?us-ascii?Q?u+WXd/rLBnBzmlZPHzWgFtyzKaukf57FInXQVNOcnTZxbJC/BCaesGxo+IaE?=
 =?us-ascii?Q?niDNsa81l2FdcAgoH+pmfm818T5Q4oM7hDVBKxglIWo9JaoqBMlK5sckNpKu?=
 =?us-ascii?Q?N/rxnqXeitZeiBe4Pe3y4+uejTpPQ46F8IyCYpbl3PWTp1KGWIQJ3r12RLAe?=
 =?us-ascii?Q?e/oTTcMmVMsOSNh3t/Te5H08odEEeJVuoUX7otGKSvbzxz3aAzSoZLjQ07Ar?=
 =?us-ascii?Q?TtjxNeGA125536HXfFjw0zT3qK5AJ0IH5q6DGjPP0iw8pP3evN7CAa0f2Ekj?=
 =?us-ascii?Q?U8i3cg+U67OxNR80ghciwjMXjvnZDf8W1GMT/QZoG4hlqCjv03XZGQdZjZ/6?=
 =?us-ascii?Q?hSnd5SPaaER6LNcaM0d4QzozsJte/LsF9OFDF8LLH4c4gWqg+FSY6kko/Jmm?=
 =?us-ascii?Q?k02VzbExxGs9BYZJMABhiM8njkmJfaj4JtFBpl5XqeZzU2Lti0r5ZqjTsl8I?=
 =?us-ascii?Q?8K16BMaq8J/qVOfsZ3HY7roOCZG+t1ax8UU+JeNvmE3kbbCTnLc2/hmjTxXz?=
 =?us-ascii?Q?jYtuRu5IcakR7EAiruSQOxlGjojKNeE3SxCPte48NqN96I6mpyy+azUVgUaC?=
 =?us-ascii?Q?H9FwjnFK6Kl/kMXf64kTq5e78bGIiiG8UxQUru/yBXcc1bv8h2B1pwUuA/Oh?=
 =?us-ascii?Q?WHDzPSYGBBc2IfUR+x4l+ebB/eYjykX89ADfq3VwRsRYz9V9Q5gyxCT1mMXh?=
 =?us-ascii?Q?fCY/LtoxJ1XmKZ1tqWPcSbv6pjoLcax4LDCJN17W68nvhBGLUrHx2BXtjLea?=
 =?us-ascii?Q?k7zVb/2HA4TjKIzxxEBFFXg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f2a063-7626-43b4-be03-08d9dff8b140
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 11:49:06.9423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpzZtrJR2mzGZCD0TffAONhufoE58g6MNvqeE1srxP+eteZPhX+hMmekbiYAgbwIVzVLIR4e8287Of7Pw+UE3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4775

Add a flag infinite_sent in struct mptcp_subflow_context, to make sure
only one infinite map is sent.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/pm.c       | 4 +++-
 net/mptcp/protocol.h | 9 +++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0d0d2eb8c8ca..03c82985dba1 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -826,7 +826,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
=20
 	opts->suboptions =3D 0;
=20
-	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb=
)))
+	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(sub=
flow, skb)))
 		return false;
=20
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1f8878cc29e3..88f0fec1bee5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -275,8 +275,10 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fa=
il_seq)
=20
 	pr_debug("fail_seq=3D%llu", fail_seq);
=20
-	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallb=
ack))
+	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallb=
ack)) {
 		subflow->send_infinite_map =3D 1;
+		subflow->infinite_sent =3D 0;
+	}
 }
=20
 /* path manager helpers */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c47d69a42fcb..6bcf6cbded45 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -450,6 +450,7 @@ struct mptcp_subflow_context {
 		send_mp_fail : 1,
 		send_fastclose : 1,
 		send_infinite_map : 1,
+		infinite_sent : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
@@ -893,13 +894,17 @@ static inline void mptcp_do_fallback(struct sock *sk)
=20
 #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=3D%p)", __func__,=
 a)
=20
-static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
+static inline bool mptcp_check_infinite_map(struct mptcp_subflow_context *=
subflow,
+					    struct sk_buff *skb)
 {
 	struct mptcp_ext *mpext;
=20
 	mpext =3D skb ? mptcp_get_ext(skb) : NULL;
-	if (mpext && mpext->infinite_map)
+	if (mpext && mpext->infinite_map &&
+	    !subflow->infinite_sent) {
+		subflow->infinite_sent =3D 1;
 		return true;
+	}
=20
 	return false;
 }
--=20
2.31.1

