Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4915486
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H1dE97E0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+ITkr6EBonFutlvU4Fn3ou9FWq2A+OmnCETpt+nB/tKcq1khrUpsEOloaiG2LU8r0Nl+mkcIsPjuTxeoRPbgkgrNoMDW9oxaCAR/ug9SttMfsvomvfMfcFbl2NNBfa2KdZYXWKjnsmTIalXV64vbMHigWUA2eZ09puxJHRW7QwQlFH7gMpssopTIkOvQ/HlYO6x1IqWwdsvQhezAD2qkXQoYFQ454XbZuC28EPmFVdyTgwM6domcvYchpIbVmqdA2xUJeTFj/phjxLWRVdHuumgggXamT2u95SXgiteozov/BqVKrNVro7iaOuO4YbgzOoHAbpDz/UanHwwWZ6eHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+T9plPdpz6T8d/QQhCljbdjlJktCmvquI/ANwcEAJTQ=;
 b=CMICsJ91oN4YT+i61xVG+srAJvJY0y16bliuQ8mPJoRHeAXUUXbr3G4DU1Dd+PJTASIrOXoCxqCF78H/ZNY79UR7tAUtCinr17iLBZ8mMqblT8dSZgOifxzE72kB5BQvocAHfbsDsesFKz78oBG8oOblcMqxwJPnTqkyyK092hTLZxU5/6UHlFGJwJkh+Pa9nHw/KVhj10yHe/Kz8GcZC7Ph9MGd0sbCmGZcSArmCi1fxLteSr7rxxByW8F98UMldxcvNzKEyxHW/RW8zCPHgEWOK49IojqgkLzJjgM6WSER3gSbwwRfkpb/t+0ohMGLo52y3H+DmJWbeXH7SEGqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+T9plPdpz6T8d/QQhCljbdjlJktCmvquI/ANwcEAJTQ=;
 b=H1dE97E0PL5a0iOorMg/eaBBomyiJ/lRlG1oyK71ZxYEiffaeNMRNNuIjmwk/afRNsqvuj87+jYKXqA+yaPhpO7jHjU4eVrFeDVWNyRuYY085lF3ZzGN3VKnqsso4ejARIYNwR8JlQBN8KpmdeEG3Qx0IiTZz6wZdt7ybhpLbWt+WcMK9APULdAQLJIseopbGu59ClSCCTTM9QuR5tG9yASpdWJ69Dzvr0p8d73tL0AAoevKvdMISkqQUP/elLdkwQoKP0Ink44OrV0jfCoGh8CKw4aNkmkce5ORkjQ49hag5mjmi/H0rjqPHvPW5sh6mrP1dbQ7vJvocOIxxxaMNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6820.eurprd04.prod.outlook.com (2603:10a6:208:188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Sat, 4 Nov
 2023 14:17:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 14:17:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 12/12] mptcp: drop lookup_by_id parameter in lookup_addr
Date: Sat,  4 Nov 2023 22:16:26 +0800
Message-Id: <fdfc8e7f6db275ccdf6f9fd615baf636f01baf93.1699107275.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699107275.git.geliang.tang@suse.com>
References: <cover.1699107275.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5a055b-7008-47db-d799-08dbdd40d036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eEOsFoI+ILdSitI5zsMRx+CiwU7th1rsXI5/BYzKQHgRwWZfF39T4BnqxNFsIfgGrHAZWRRLtskk2y4RpTICh5krsN5ZiMmnbpm0je5Jtm15ryfRZ2xh9FatdbHQeacT3rPE343zLvKhnn2MgyM8zwrm5GzhOCHKcka9k4CKN5S7NoYt7m7ZeMbnWjeRjLLSEynPA+6L08FLzRd46mfkKJRELn6rVN+traT332fnm6frf2FT9PFlB6ODoV5Iqtcx5WsP3LNVwvdwRc/yFftSJ3/7xy2VfZTKzvuyWUyaz70T7NZAWq1TQJ/wlDjWMHkqqM+xjsvV7W/wTY3Ooa0KEbi1sB3sYrBL6nRIUuX4Rcwu+GSlquUMgRAguBnapw7qUrRGa16tPBP7zp//DmYvIFOlyJujcqnSEd3JPmsQ5Y9/bFl8RuK7JEV5j/+j7+hXqfnDcyAHZ6nBoDc8b9GPgni5z/21aO7th3kLCrQLzgUBg+B/dNdGv4oaKF5OfweBLp5p/d3quL4q0h9OrQonOC/7I0vUVJrp5bBY+buHSFDZ6OrSNmlupepGRA2viI0hvlUpCT3lyqhTG2wIggkLtbUlQWq5gnVpYkVGBj420VQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(83380400001)(5660300002)(2906002)(6512007)(26005)(38100700002)(2616005)(36756003)(86362001)(41300700001)(6506007)(8936002)(107886003)(6666004)(66476007)(478600001)(4326008)(66556008)(8676002)(6486002)(316002)(6916009)(66946007)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FDH8GwNwlPonOLxkI+JvfhEFvYr1mNjdcCqoLbLFMiR4pvfgagLVY4F+lX/t?=
 =?us-ascii?Q?kVSV6RJ0RTIkryfEAXcZ+mPrK1h17nBzCLWpyq4zQRjzFNP5sdjNv9KNOCL8?=
 =?us-ascii?Q?BGK/9YsdxTrUJAdcV8/6P5rXPAdB7W1xjStFA0MqBzmoZxZAyb3b3DBNX1Q3?=
 =?us-ascii?Q?u4S2bHAtn7OnQNeqvyrZDZadepj/4jW8K8OAmMp7ApskDMHV5C7dnrKXH01T?=
 =?us-ascii?Q?VHdlXaoR7c4yQCeD8saI0cj7S1BT/zmCvqRkJM2r5gZj9Fj+DukN29DDhqVM?=
 =?us-ascii?Q?Mx5IeudGVgN5scBoRhhFm7twVMj8byS+sn65vMFVCYkc/K8uRdGJkoiyTWSW?=
 =?us-ascii?Q?6UmeW1VXZ2pMmKTD+EBG716THlyStAim82HJesnBwnTvOK0Y15NYU826xDuD?=
 =?us-ascii?Q?EW3aA5GApUx7SEXxcbmcTl2R4j9HWwh1bqCy+vfCkA0RrxpYKGoa5Y8ZgoDB?=
 =?us-ascii?Q?SGHrJaRFzJP8HYawuqsUf3fuDbVsT08cv274qXyuBT96pLgTguM1HGMo91a0?=
 =?us-ascii?Q?dXwS+BQVZdp4KJj5xI46q62DTAomwejv7xcWGNuugo/ygjq5jsf7kbfUnhlR?=
 =?us-ascii?Q?aaz+OLNKXYm+eJYz+0r9xyGqKfVxjf77alevSzEmYouIMQFqKswahcxMKtao?=
 =?us-ascii?Q?GnGsRTi+4+F+qQFRgHL4PWdmJPHM72WvJl+DnohVmutTHkLUjKRUoWAhYg2J?=
 =?us-ascii?Q?zj0aBb1wpyZQDBMItoxrwNNK8BSX+q1wT+pJuHuuqjDQd5lIm3eeXWV95xXe?=
 =?us-ascii?Q?+3UsaIFJCozWge+RJvwjr7eLfEYhOr2/JTx6QcOCGxSUBGg6t9D+7o5ccgSr?=
 =?us-ascii?Q?9Lb2uG31z973fR+P0K78Z8kkr/eZGHuKxDZaoXDGmDMF7DxHFhonRodhZywK?=
 =?us-ascii?Q?+qteWX3SGd9df6aYhucnkXbkwkY/TzsxJNFSA6TmG3C7P/y4XACvaJtcqVlm?=
 =?us-ascii?Q?/5m4ZzYt1tsRBIaN53LC03s5ipoqfBRgC17HFC7mQPOjIkUe537Qy1kbTCrs?=
 =?us-ascii?Q?Y1W9D1H8NpUMcY32pWi7Y4xzMyFJs3BCv3v/P0Di1lmkc6XdFd9eCBCqEKSy?=
 =?us-ascii?Q?CfLcv+ev8EeQrltgMkNUA26bNN8nfQONtHduOts8pja2YjE9tGJoWSmZ3lTj?=
 =?us-ascii?Q?OU83AfOVyY2lrWTmKb45QVfK01Rvl2Xp3PppquvINBp2Ykw5CjcBXv0XCMSb?=
 =?us-ascii?Q?cLBIr9GAb+MvAgvDva6fbU+q7KywaIRNeujxLexy6YLM5H6olnK7xo2+TDRt?=
 =?us-ascii?Q?h4bvRgavcIjp4PMHJOOjFBE5iZIK1JlQSzHdF8735Rj1x45iu8xPxGmJuWO4?=
 =?us-ascii?Q?PNPkHLmoN9PEDRO6PC5NXQ9+ZxLy86vE2Ao7gZuMhwvYYMSqGNWLOdddrUAU?=
 =?us-ascii?Q?8o26bwYe0Z+tzV5HVkdPYNKMnYxbxaFsILNulp+LjVlSkPPczk28DNuj15u9?=
 =?us-ascii?Q?eW51klb0HumDcJ/wNJzkv7sHcfdsrT+J2SXSNvef8d9iq/IKnPCuuZIKplwl?=
 =?us-ascii?Q?hTt0OPfGCLEqeppVoVgQUBn6GiZiv6OC585EBHn6+iBYvIEdEoqPb8mwZyvP?=
 =?us-ascii?Q?CYvxbK1UmZXJWNOZLYsTtSCKjXwtRTBv22gOOCfW83Qcp9JzE3r04HlcxJQK?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5a055b-7008-47db-d799-08dbdd40d036
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 14:17:44.6764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtWzJ+RDJOY4SP1xUQdyZi0Hl5DkNWc4MW5t7x9V3FW/92mEU4cHWqS1gNMPFQCYMavymGK9esL2IgoQciNwmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6820

When lookup_by_id parameter of __lookup_addr() is true, it's the same as
__lookup_addr_by_id(). Drop this parameter.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a4fe051d74a9..3d69e6e70119 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -471,15 +471,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 }
 
 static struct mptcp_pm_addr_entry *
-__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
-	      bool lookup_by_id)
+__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if ((!lookup_by_id &&
-		     mptcp_addresses_equal(&entry->addr, info, entry->addr.port)) ||
-		    (lookup_by_id && entry->addr.id == info->id))
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}
 	return NULL;
@@ -509,7 +506,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr, false);
+		entry = __lookup_addr(pernet, &mpc_addr);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;
@@ -1852,7 +1849,8 @@ int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8
 	}
 
 	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr(pernet, &addr->addr, lookup_by_id);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr->addr.id) :
+			       __lookup_addr(pernet, &addr->addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
-- 
2.35.3

