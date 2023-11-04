Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D79846B
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W6iSXy3/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+nw6Q05YlC7C4u3tm9Ty7dmbNb7AVTxvG12/yMZCvMKznlQ3ayDjnC9wwh/gB/pHM65dtWpW+472AT3NZ6WdvPlFKvnHC64r1tkrOFXLuPlrjBFLyJ+JgyNb05VTQpjVGZsD65p+GwUBy3A/gw+OV+mCrfCAM9U5fwp2CzrKSp2z+PziazFQnvcYWIGTbhmQDfMsuPzGj5qrYu1xpnDe62Nx1SWwrXCgh8Uae5VFi5JX0ehqGhkuVBNzln25EusOtpVT85mxxZgJUgiFolllOtFYJazpf4et4m4A3PhTZrc6BDhmZ59HLvSEVciAg4amSbhr/JUwJZ15ltAu4yvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujWlHlkKuqvJ0vm0co4NtzUywzjfyNV1J2pKF5cTkwg=;
 b=W6jYf/mStilUjQawjywuXFf+L1G1H4Pq/DWlCI1XX6paZ4G4tL40KwrSZg/E0K0HepB64IoPBFp0L35aA/N54gezcE5DRDzPAs1DHXnPvhWihhFG+d3BqgkPWTF/cXET+NEHPejhUIPYnmWmhG1CFLinmY3A8dv+6MEHEwhB3KjVt0NC/ZA27jGoR6b4xzigg7meDXB9U9AB4LhqeOIdKU+lMsgxacDwOKls2ohDh/+H9Nwvgx0FGSlulwyJc04P4/nQUFpClxFHOTYn+Th78g4wFz0qJmYovtA8PGCambVEkMkRN/N3dBPh8KnMTSFwKMxiB0/n62wout483KABNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujWlHlkKuqvJ0vm0co4NtzUywzjfyNV1J2pKF5cTkwg=;
 b=W6iSXy3/6+wxCk2NR5FRr4uBHUIP7K1VrKpDwbq+dxvarVb85vIs5vBXjduF90LyDNp838w+zi9QGQAQEkm31XdTUGSJqZDBCHQdJUzzezGKqwlu6wRoO+zL8QZXSKV0QRnVaWoasWGTWqvZ69RqDRp4G83dc5E21pVSFUNS1sGr94FirxK59HlXfGxtnOAN/Z8WD3ZN4mirxdWh8ZgeyCvwivckr1VIt60ZUZR74gzly2OWsuoBPMl1TLfz6tmJS392a6fi9d6FxL+kq4m+F0Zu+cnZsNa2KlFsGlgzF9asok5sv2QE+hzf6NPwGRwBIU6Uw0t0OYSaCbNpSj5mgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8874.eurprd04.prod.outlook.com (2603:10a6:20b:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 08:36:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:36:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 05/12] mptcp: lookup_addr_by_id helper in userspace pm
Date: Sat,  4 Nov 2023 16:35:40 +0800
Message-Id: <ddab6fec4ecb36f11d6bc42d2f8b5a52ecc9c6ea.1699086244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086244.git.geliang.tang@suse.com>
References: <cover.1699086244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: e27bdb18-a722-4974-2c62-08dbdd111f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/IrBISxsgbu0C7PTTfiUPpJDnsHHD73rIL3VTVZeWxkFw4GYNczf4eljoF5l01cXDxfaNkYNKmc1/7bARz3GtGCHu++ldRmMv5eFyRSDxc/EdP7o++f2q/ojOMReawnn/HY5dOQopRuVsyv0Xbf2qvKFweWHgyrF7pliZSEQYsD//NZdlfW/cUAwAZOT6xaDMBEADI1GgoJTqhFRwiEh6eQCmgzNlkUxKLLzBlEymcCTVwhLc9dpnTU8VJa9apLLtO9u10EPA/T1qBH9cpWUYMTDE3nbt6kC9HG1YvbBziRWjixmN3iErmQ94CgsMsLbI5v8zUuU4c4tWktI9mrLejihm+9gydYJtno+LGBK3qYw7Njutm6n9B4E19xHFW3joc1wba8+ZTPWVILAMkpjRq46wXiRcEzWrf392bX+sCMFj8mK/HwZntUr7k4GFqwzQHjfAsC2bA2s3uvd0g6OzAQXi4zCbCP5bBDkzDVOezA1q4TfM5alOhJ2Fl59d+z2RXGskewTph6cPJIRgx2GNolI8yVJMgFTjqLBA8U7zXE1uXybl32CV6999GGwo3QxnqjRPbEoR/VbRV7m0QuVIZwJXnyBMUikpp0FLUyJ1Y4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(316002)(86362001)(83380400001)(107886003)(6486002)(8936002)(44832011)(4326008)(478600001)(66476007)(66556008)(41300700001)(66946007)(6916009)(8676002)(36756003)(26005)(5660300002)(2616005)(2906002)(6506007)(6512007)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q8zy3hy36ztq20MZzXX7LCRd9x6AnzlF1N2g7NLpxcuLMlRWer0usH+qLj/K?=
 =?us-ascii?Q?JQf8buJPvwCOyVp0UYuh19KLKuiXTdV9+19vqx6FMTMrvLwsXgpbcoMjTT8Z?=
 =?us-ascii?Q?87SP/+B+2a7EoLOgyXerXutur0kPnHox8x6o4nu507RXIVTf/jKkN56hMs7g?=
 =?us-ascii?Q?7d56cWtlS6dcHjJxRqbnzBYTP7Z+Y+KWsDs8tBKiFzQ339IFPqsWsGI495eA?=
 =?us-ascii?Q?r+8R7VwfDZSSKkPYs2UHpUg3bq1uwM/N/evVqzbMqzR0SoduudDlR1ZqR+Aw?=
 =?us-ascii?Q?S+XwpVk+nB1aRvU3wJSCMnpm/8kXxjQd43/kpErxdtdZZyRRfaMt5N6x6GVm?=
 =?us-ascii?Q?wUfo7+1bVmdswoE4aUxJopaY9zDltCr2FjZUEdrBOuN/rHm92KlSKmqO8W+M?=
 =?us-ascii?Q?BYv1Et5/W3ee5x+44B5B3D+jnKIOm66BbxNlSfb1Se/Wx6RMxcGErwgXQX24?=
 =?us-ascii?Q?ZiJETyoO6FJyNG0j1nFN1MZJqG6oiT0na20s+yaF3nHkI/nzyBC/+5myz99H?=
 =?us-ascii?Q?lBdBafnfnnThwxYFVvz6mLvErVXlncTpHpVm1uUNJ1wWAVzmWFotyica71QN?=
 =?us-ascii?Q?FTKSQQl7SL5bg7n3hDS4FEyWsZGeZV+uBa/VulYmfU6csBp8PLtItWGwvMFt?=
 =?us-ascii?Q?Ge8z/eEIxfewUBr9HBh8Gb2gYrMXLR6UGE/2vSOW8EY10edA3d1Hsp/Rizju?=
 =?us-ascii?Q?wknYLJC7wlyWTknM2EfQFeFTfF3Bm0P/ntw+/EFljGItpCj2c3u0yjBr/WUr?=
 =?us-ascii?Q?6IkB2QJz18iTHlHC+wxGulPddjuS5lEidv9UYJH6TyuW39bvoWB2B3Kfq/fF?=
 =?us-ascii?Q?jbwLkQ9K+CQqx3Esbg9/bdf413PbntMQ2Im81bEVGGGz1882ywcuHGRQK39x?=
 =?us-ascii?Q?OSDHv2IGeRtrLuJU8lQAR56XASekEHcketCj1t2htMX+Vjkkc3A5UtHflUqf?=
 =?us-ascii?Q?CCKraWbFW22P+JHC/ZWHFjCYh15FA/sPZ5jkIk+vErFrLZ7lcS7RGjML9eKN?=
 =?us-ascii?Q?uYmwEHudGgxdF1kT4h3Zd+F0/FkGmNNsIrrjUdg252UHbET3Vsb17dujaSWg?=
 =?us-ascii?Q?h/paAaNr/pnCZMH0PPSA33F0HUJ+21sVrtgak01bzKUs1b9n9y51G4X3cAfE?=
 =?us-ascii?Q?P0usrCKFoGhRzVyDcdHW3/J7NAFHIiaO8qb3Gr1bSxHf6UnJbQJV3GLsGzvD?=
 =?us-ascii?Q?IZorcj0Cqm8uBiK4u6/OI82/VUgSDvYk1wR4GOilrqD5JwG4jev6PTr/Uk76?=
 =?us-ascii?Q?z+wwPu4fpSaDXIWeGsUPoBMbBsHWj8GH9/Ri0nqY9MenafvKQXZUJIeLcBOC?=
 =?us-ascii?Q?A+bT4Y9xnHFX3bPq31adHLHpagzTgQu15P3qF60DSaufOfw9HP9IVwTOgokB?=
 =?us-ascii?Q?b+0pOhe9TRtmftwXM1XTC49e/5PxxRx2tUa4F+ZeOLbJ6v/Bc6iZjDw1oSvV?=
 =?us-ascii?Q?h2rGmIk7gUm/TA8q8InLXtIUT4HOAOWE4Ac6KiZ+FOs/B/GGsLxHkeEUz+oe?=
 =?us-ascii?Q?aDxGtAYUcMlxv4w+AbvlIuVk3IekYkHQRKrHfGPjL/zqbZKEXULUO6a8Lc5H?=
 =?us-ascii?Q?rE1/nsgjcNeBalxlb7qc4tfoCzhUMd7Uxcm+ABLP+fmg9U6tvEmQbLaXLiZi?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27bdb18-a722-4974-2c62-08dbdd111f58
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:36:21.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iI6LPKCZG7R/baci+KvKU++SKZfd2iqKQhzeVAc8k4CzmY5KFeceuYdLpZ/AJNgMpeJJ1Vw4NgPfmCcXRJ9aSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8874

Corresponding __lookup_addr_by_id() function in the in-kernel netlink PM,
this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
lookup the address entry with the given id on the userspace pm local
address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6602abcb00f4..8c369cd77e2c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -27,6 +27,18 @@ void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 	}
 }
 
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (entry->addr.id == id)
+			return entry;
+	}
+	return NULL;
+}
+
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
@@ -112,15 +124,10 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex)
 {
-	struct mptcp_pm_addr_entry *entry, *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (id == entry->addr.id) {
-			match = entry;
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
 	spin_unlock_bh(&msk->pm.lock);
 	if (match) {
 		*flags = match->flags;
@@ -252,7 +259,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -289,13 +296,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (entry->addr.id == id_val) {
-			match = entry;
-			break;
-		}
-	}
-
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);
-- 
2.35.3

