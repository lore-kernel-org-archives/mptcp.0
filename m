Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA871107
	for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 11:38:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeHqwPx/UwOPuZERdC2vhXncZWiE8zC+GOz+YoCc23ffjVml/7FW+jsQMCR7XY9iMGalIzQAGW9+IkCQ4IYVI+bpXgGrL872qqrvXikVUrv6yze/CGqw3ZBY2sdg4SZL2Fso40WwpTu7qX7E6spTARS3Uqvx34C5UshaBS+a18LRObIf74kCzxnjPnCTQtrK/FS6OZhOZj0K63DzE8J0AcRjiy9SWLmBksiH9N2UHWgnFLma8UT/bAzaOz/jFC2XNEX2QGu4CJ25MTt6Y71vWehhO4THBk9vTTAEYy4BOoOVC9bXxkVPqzk6HJY/IspSNLcweHzBzJ9i0hfntMkJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZWnKfmbeJi30V+/EU50X13bO4wOjIfw0jiMcfX/c4U=;
 b=K3u66OLdf4XBySTKBtT3fRAw1au8c3KDF9HYIxG1rdUKfswo719ctdoGUyRf7pxbceH5O4TwL+ZffeE4cb9UGwIxGdCyFM60ELN7gLArnxNdWfyLHwj+ESoZ9Sxz8RxgNMmoXTc5jtINehvCT+Zykx3G+5806E5DX4kLN8T1yUZv8F2iM0BURQ0S9PdPBTXw5A0lZqOuOgZXz1ruz97kEw0CoKOXL68CiaLpCv5uj3UUbCSIxbGx0CpPu+5G1yRXAHx4HwPIOI+xI22zp4mgVhIMNIWDnwOpgDtSJvIV0p6rYvGVq/AASUHtTdAnbqAv+PvirkGt+PuCxCiI371EzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZWnKfmbeJi30V+/EU50X13bO4wOjIfw0jiMcfX/c4U=;
 b=SOTd1IH3H5QlZ4O5O2EVWFKuhGqYQrGRH2dxcDAPHoRUeywohvczA5O2mikCPHB6e4JnNFErDfzTwEWBWegG8BMIcawSauSwEBcKEpQOInk3kLVA1eKQOWGGzGCSGn/g5Hb+WC73pK7J+hoZ7JJ4BuDoYofq51/tlpeUFep1OyzynY9DcHFtkO3rPs/74EXQTK6LZ/N0dMFQmyNmjtVT/cnnwcZ5WDBvtp3+rWzVJdVcOw+quODv6oE6wvziOkAjNzJllfRBVJ2N4PDs08uTzklj5TVlT8R1zi/c2up0LuRH1k5s5jxvndWa/nqDTdapvVPI4AZHN73Yx7Ws250mhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Sat, 16 Sep
 2023 11:38:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Sat, 16 Sep 2023
 11:38:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 5/7] mptcp: define more local variables sk
Date: Sat, 16 Sep 2023 19:38:39 +0800
Message-Id: <e0ae79a44aed280f4439b4fced672e2295205a09.1694864093.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694864093.git.geliang.tang@suse.com>
References: <cover.1694864093.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: 96326b63-6cd7-4cd8-cad9-08dbb6a97791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PmWyWghPfGdy1HEwwAtWpXJWrsHC2RdvcElcvoNgdrqdnOOizGLSrl16/XMlhMaVoxTRnaAFsE7zC1r6imc9gr2kyKrYMKiReu9Eyz9h95OVV/T8ef5WUsYHM3RTaQu6MAv3fTfCJT6/K502VlDgVH0rJA2rglu1K4Bk+iaSBewQ1usc2zXtQ0P8X/Q1bboVwtEn2m+lRAWL5wWX1PTy2bYeRUVmQK9xeXDllAcNU7PGaHERA/Wg4nHGWBz1UCBDZEhohi0J1a66gknKlGoTHCvbgvfKy3HJXbs5z+XqqL0FI6sU7KSnoFD8xNC8xkRI8NfSpC+/wrwqvqqSVUVvnKnTBfCfl04Hym3dJjuL9NfhHxjukh++swpvG0q3llY/G22PMLZQwvaqWrV2St4hilFDzUYi4A4+P1eV4HrjcmTbxgMoE+fSvwnh0cqBsqEQfXCXBQ4vEh5YRnI7GcK83MwM/Iv9gZogP9xkcvRfTyGkVxNOFWzIzlB1umAX7dqK4YZr+gYivSUj4jW3ibkU+r6SG1M9GQAhsmINWC80S+XlIClXC5Rhk8GmwLBRyLhgbJsBxcOj6CrXbfW8jtpH/QGVHqdqXgxGuGXfBlqHzVU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(1800799009)(451199024)(186009)(36756003)(41300700001)(38100700002)(6486002)(86362001)(2906002)(2616005)(478600001)(83380400001)(107886003)(6506007)(6512007)(26005)(66476007)(66556008)(6916009)(316002)(66946007)(4326008)(8676002)(8936002)(5660300002)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QQysCjo0X/p/nlCsHj2k7zOdaKdNVD9XJxIYmFqQw5op6MPEGN9waUDNM3LJ?=
 =?us-ascii?Q?j8X2DoD81nx33gC69uDu2AY2PrQiFOGzbin5TLOk/a1EbAP0h3eRh3Aejtjb?=
 =?us-ascii?Q?hAeaQtMugyy0vEpynBkZhFU0IT8rNu81j1uWpHwKfz+L/E4aJsqhB75R6LRx?=
 =?us-ascii?Q?wl54AnLoxIcDV8RsXhSYYzCBwA5PoDghfr6aHpinekpcev8xNFAcHpNyPWky?=
 =?us-ascii?Q?cWBOEMtHMEpxSSac2cw61UY3WSwQGAJs6ohiP1QgCxPhvLE9UDtqDxcIEwmk?=
 =?us-ascii?Q?NSq2SnGamdBk2R7lRDxt61F1pCXM3eTk9TSupH8zPaEaHK5vXP5yH2O8XXRF?=
 =?us-ascii?Q?cBXJy+z9AS96oywd507bQOGc67uTJm/g8koULgRFXDrYj1CZOKXqjp0H7+Sq?=
 =?us-ascii?Q?aWrnJ/nv8gAjRI0cGZCcFJjSdDC1Gz60EIjDxGuFT5vRmwiGrwWtb6ANbSwO?=
 =?us-ascii?Q?jRNX6xQwfPfS2P55ahsA8oBa//ctt/pXUPaRyOlQrs9fvPK9g+1trwKWUiZJ?=
 =?us-ascii?Q?2FxYuJWEsZ6NfFlfAHuWUaIoK1HcO4Wepg026GX6Rg5NF6vLzcK7xnO3123N?=
 =?us-ascii?Q?rlYulHinvva2bEGz497Nf7ATyp8gNwxzxg5fuqzH8ykx4sMhFC5A14GRUD3T?=
 =?us-ascii?Q?DFvijY+WZzhSeR6XhnekmWBO/fg2CgvLKZr1RhYEygknWdjFg8Rml75izDsL?=
 =?us-ascii?Q?sxA/piv3N1vC5K3DDhM4+ePIIdclltopmO8D27b3y2MGXP7quWU5jRWFMa5c?=
 =?us-ascii?Q?AoyehLHE+/L+QKTLD4Tq6Yl6xG1hkt46Pif50+c15hx+5frqrtSjEux5hRDj?=
 =?us-ascii?Q?r3jEz5dHPknyTzc1sNABgvX+j/Wyebe4RoEtzq6D8mQNMoSI3K6bF3ZESIaq?=
 =?us-ascii?Q?wqVW/VWRFSzRQSkxqgHT/DeW8SFunurVlhF/SgUm3gfH4rSIydbn272r3JhE?=
 =?us-ascii?Q?CuXB3zIVwQpNZqhoFHtV9EqE+qCcRkWav96Ax6e+0b3MKVOpVTPhbHAwwIgk?=
 =?us-ascii?Q?+68y2Rr2Vm//Rn641jyQURfYvgjUgwWI2qqRNJiw1BL+EwyVNl8EouokqEsA?=
 =?us-ascii?Q?lPgz/QndkOyhItsPh7etY69xCv2vEcZOm1RG2IlQecl+1OjzBzvjZukTvcd5?=
 =?us-ascii?Q?QdTSQx9zHQhPUlDm4alpTo+2ePeWjN7CPbnLzyqrfy2nLWVyKQQy4br9P5iR?=
 =?us-ascii?Q?jeO4b3gonpho/oIen52HnhG9+sdgXLxz+qfStTlHnHc6g7AgTAnAMZjPnZ4m?=
 =?us-ascii?Q?0BSomtfL9VuHzt3zYsmBN6hSA3AuqY1XPsPi2lrMesroaMW2UWh6cjAAl7VO?=
 =?us-ascii?Q?ai8vzMQ0LjmDMip6C6edA3uTeIOkNZZliyH3vpc2pRR9vIWzovYkF3j4ryvG?=
 =?us-ascii?Q?tbumBq9Fvg/iRnZMSV26xxbl0mHnXshiqr/xm7PCjWY8t+lg16L3RlOjb8M6?=
 =?us-ascii?Q?f6r4wARaZc1wQVDk+1frL0BJ8Z6OrNWXa/XwJ9N8l9YpUFfKNSLU03iUATnt?=
 =?us-ascii?Q?FJs1hY6Htr9DtbleypRAC2bneI6mR4MRAIBeUlR1yAztf/dMlO/qvPKaeVzM?=
 =?us-ascii?Q?zKv1So42VJRlVCJhsbwmwgRVhxmV3X2bXn70H1W4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96326b63-6cd7-4cd8-cad9-08dbb6a97791
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 11:38:37.8016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nV08R3D6kH0jPbaUoSEXk8eeb/7YBCFQ0kXWAj6SMeYQ39CCADrI5l6ljac58FU/Xy91VRKopmG43+3krrchCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371

'(struct sock *)msk' is used several times in mptcp_nl_cmd_announce(),
mptcp_nl_cmd_remove() or mptcp_userspace_pm_set_flags() in pm_userspace.c,
it's worth adding a local variable sk to point it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 78b935ab7d3b..9429cf91a9e9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -152,6 +152,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_pm_addr_entry addr_val;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
+	struct sock *sk;
 	u32 token_val;
 
 	if (!addr || !token) {
@@ -167,6 +168,8 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto announce_err;
@@ -190,7 +193,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	lock_sock((struct sock *)msk);
+	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
@@ -200,11 +203,11 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	spin_unlock_bh(&msk->pm.lock);
-	release_sock((struct sock *)msk);
+	release_sock(sk);
 
 	err = 0;
  announce_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 
@@ -217,6 +220,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
 	int err = -EINVAL;
+	struct sock *sk;
 	u32 token_val;
 	u8 id_val;
 
@@ -234,12 +238,14 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto remove_err;
 	}
 
-	lock_sock((struct sock *)msk);
+	lock_sock(sk);
 
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
 		if (entry->addr.id == id_val) {
@@ -250,7 +256,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
-		release_sock((struct sock *)msk);
+		release_sock(sk);
 		goto remove_err;
 	}
 
@@ -258,15 +264,15 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-	release_sock((struct sock *)msk);
+	release_sock(sk);
 
 	list_for_each_entry_safe(match, entry, &free_list, list) {
-		sock_kfree_s((struct sock *)msk, match, sizeof(*match));
+		sock_kfree_s(sk, match, sizeof(*match));
 	}
 
 	err = 0;
  remove_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 
@@ -485,6 +491,7 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 {
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
+	struct sock *sk;
 	u32 token_val;
 
 	token_val = nla_get_u32(token);
@@ -493,6 +500,8 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	if (!msk)
 		return ret;
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk))
 		goto set_flags_err;
 
@@ -500,11 +509,11 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	    rem->addr.family == AF_UNSPEC)
 		goto set_flags_err;
 
-	lock_sock((struct sock *)msk);
+	lock_sock(sk);
 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc->addr, &rem->addr, bkup);
-	release_sock((struct sock *)msk);
+	release_sock(sk);
 
 set_flags_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return ret;
 }
-- 
2.35.3

