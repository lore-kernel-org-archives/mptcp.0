Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1639F51D
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GiOzd5Y5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqK0NzJzBJvsKPAP+F9vuo7BMIUbS+owqB8z6eN4lXsRx64bbry3/7ggr0gWssGWMpI0KD2hk/Le7uofZQM2sqjc+NZnwPl+xNVlFy7BL9WkGdHTKGx+1XMpEqewRkP8g20o6vARgYGyuknOun26InuoBjC3pgKhmzwT7jrWrtev/qT92H0QOYnizzYRrmQ+XzJIbuCuGjIZGV2JPEZJNorsDbHpdbZS74+qZ5NY6fQcg94IscKurIFbuf/13bT2+Q/UjyWRv6i0JB559BiD4AsnjUh9xd5fGrh01uSnE1ZTF9EiaZaoUHqoi/al7hz8QcKOq5U3Brx7SlJJUt12WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdLYbK7vXnu1Q5Sj+OUn839s8mJ1ffI2svEYGzcGgdM=;
 b=OOL59bAqflleT/xCI+IWmTUu7bat6j54WSk/YR0sb/9DKJbo/FP1k2fwmZjMUEeN7eJdBKlNi1Q20ZEkTq7O7S7VMFsvMOD38rRbZN1ijd4cKoEvhOv0KBWN/SWRVqt4s89PqcO6YEXZHx+WIeU2k4bpSZykt4hvs4MJkswFFB9boIpKF0o+Tfo99Euz8EPFguSICONIFdmBDmWYv4pXeFawNuiXaByMdVCPObqNAi9kHrK0bbHjrj7IshkHLteoQO81UeeVyUwRqYtu27OaTlFgy4H57O0bNDKknJOKUgYzia9ve+eI2mGiifkml80U+BMxcxenmLA3Oj7Z9szkxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdLYbK7vXnu1Q5Sj+OUn839s8mJ1ffI2svEYGzcGgdM=;
 b=GiOzd5Y56I59FmIw2B5P6J5JplIYo1aYLSo/8V5nerymOjWnEl1izU/jjxFQ+NiGnUDtMbsP5vX8pMw3p6LBi8Ub2NJPcbhJif6NZxO0ElMVcW/4E1B/JpeIyEwFh7Cf+xxmE8B0AM0S7JOHvYVrVhz+Zog/JwpN+pU1o3cWByseSKWUivW1DWywEF/NGqBdSyp4EppJU1/QMR1iHcBS95f2YFr5olUds3Yaj/k1XoOrN8eKZQi73z3DIcSnMvuqIYEOfisIqeBKLSM8Vfc7hDBTYTHKJ3YV/utxn6xDOrtJEbs7sX6bu6658l8e3Ojo0Gtb/d8HtCODRIzNG3fAMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:29:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:29:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 05/27] mptcp: drop lookup_by_id parameter in lookup_addr
Date: Sat, 18 Nov 2023 22:28:20 +0800
Message-Id: <8c13ef7d113ae1b870ad2ef47d70a795afb12812.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0012.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 7642d518-c045-44f0-2b63-08dbe842c1e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	08RTai+DxtYxdTNy4vTHJaoBCnbdPUpl3qMt9Qz6WTE/qiT4F4vSn3yA71xLI3/X18FqpFzOCpzdz1/Kn/KYSRif8QbsMgJhXwsIKxBgufdc6Op9WABH95jx+1rAyp2Tx5Nn2NWRk7uoFH2AlswalghsEIopiaCB3mpo+TBTmrNT7MGppubgBQx7o/9wh7S0iaKIHAvndXk06ITt1NgnHfLrgWPBbdFvoH0qTLkqA/XOk6GMbC+SdECIULtmltN1Uf9SKPiHRaUAQjhuuKgAlTgC5NfG0oe9LGS3qPCwk9Z+vLyQ0xgZFLfKEu2IDD5s3pu4ALSsfb9Sw5Ws8nar321p7ZpV+gTnGMXJY5rfqF5WXGTZtF1tly2U3Lwb6APSVFrJ2rNF7IcwEgCzK2bJhZU2YT+r+ft8Z3/WSNj5aLRzAmYgzdALRgRiRaFdDGwzRJSeW0tgHMfdbBjftihnv9lEA2KaH0b6Aq6SylyFaUMS5yI49T9Kqj/g3DOSQUJje0yJA+l+zl7s6QludE/P+tGAVpvzdaAB3muvGP9I6w+rZflaJPmml7Xcbk/5pkYQK7uDO9y8pcakDfMg/xLUMXvygTneISYa4NAcE0OzJA0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(83380400001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A5s8evr1cwYuEdys1uhlbJRVY7nmGNIddkkX6JFETdnF/jcxAJ1A7ROM0vR8?=
 =?us-ascii?Q?m8adifsXXdbJRPEPMpcNepyozMbFhyUC6sdaYzV0GEXmD0ybzLIBup+0oa8Z?=
 =?us-ascii?Q?gxN+JewRU8SUFzrnuntJN83OhmdZAhmdT8kPGHdJ9S1MZWWJFr1Zwtp735gR?=
 =?us-ascii?Q?4x4sxp0ZMHOP0GKnk/IVclY4PJSSgw3nwNdF0LqIDuQppmTY7pcqUMFdtmkY?=
 =?us-ascii?Q?bOZu/Y2oPg73jYLiFK9bie0zmvhcN9R1BMu4ZlPsRYbTY/b5VZL2wcLKszpg?=
 =?us-ascii?Q?c06hcEjZTrHmY8WzVza64+RatUWxXjcgNhNzN9DWm9lnuouM234cfcB2l7Dv?=
 =?us-ascii?Q?phK2Arb0Nrg7wcmcweWIb0Y1eywRqbRZzoQwmu1pIpCI9g4Gc4I9kt8dSftb?=
 =?us-ascii?Q?ewLOMxx1hJXkuhoVw6QK1Dqag6KdcmMyifALw4IWcg/wqKJl5vc0QLkj2Wss?=
 =?us-ascii?Q?3ikp2GRg2/3OZhVv8L5XOV8f2A/I53y1+JNICKOrAx4JQntq18MhfC1Isf3I?=
 =?us-ascii?Q?IbdqtfsdAwnfakHegduLogYiuUl8fFJVPNdIGttp+XFFjHGc8xWK1PpC2Ylz?=
 =?us-ascii?Q?2ILj4Gi0iDrtJ42dLcuYoPuBG5ckG8lsR9VCbqKkpGZwME3uB9m8AAeloXSq?=
 =?us-ascii?Q?J39lMBOMDw8HSUDF+E84I/ww/d0khfU1y/XBPNJHe4JWUhKpFzR8kmrsgJJs?=
 =?us-ascii?Q?poU2D9uga6Lv/uDawoHTfdFQU8hO8FvAjwngmBuTRlvxzHLKgRqStSD7GuoL?=
 =?us-ascii?Q?tfQsqt5G3C1aVBg7P57RvCgsVQoq7JzTwGjpB54660qm/XJb+jgInAwe13cD?=
 =?us-ascii?Q?VMHpyL8XRpA60iSNUYeeXu9IFj3BiReZdA3svKcCT85kQfvGbOka5yWmHGSX?=
 =?us-ascii?Q?GzsdB5UNpCGAfaC+NnrEq+5rCG+RsRVmaSYKLJw9Q3Gn5z1eG9SpHLm6L3j1?=
 =?us-ascii?Q?+08FNg9UTjosmNja5X4uRTtH9u2gn+EO651d+gRyYeYLkZr/ROM3kt6ugPyz?=
 =?us-ascii?Q?lh9ADFl3wggQ7xKerTa5D4sKoDaXhSEr3cP+COwlM2FQF/striXxuGntYtyI?=
 =?us-ascii?Q?Es1obgACrsxoQ/acuQPCsrwZDjOQKxUFfxG5Ag65F1R5WBf+gY7M06RZH/8d?=
 =?us-ascii?Q?yvH23rat1USBB1n1i/tUc5xFKTTN376+Xazsc/kGoCxrVTWtCQ1ui2s87HHe?=
 =?us-ascii?Q?rZr3/77/QhoMSDLd1cq8Etid0dBI7a/AOiwo/kUbKuGy/DtgCPpOd6B8Sdcq?=
 =?us-ascii?Q?1FPHJI7gzsJKy367ESdrvzqQ/Bikad2+2tyQlkbLh2V+j4CwgnbnoQU1yD5Q?=
 =?us-ascii?Q?TvsMdK8P6n9+1vr9Ea96ubnFYSgcF3e36AFYBg9YI/sfXBwARH9Ua/ZuZE0V?=
 =?us-ascii?Q?PaFem+H5vMSwvLxYdAfKcB2AIMKhYuWLydAXmycKDi62XcWT8Bf3MUeXW1g4?=
 =?us-ascii?Q?4jdiWhf4PR1GkgGPePiL9jSOW0W6kqn7OvvDIJWOZ6etH1duHnAcjk6A7Yz4?=
 =?us-ascii?Q?8dQ1pbgXpmdvMn+ibGsf0EUvDd+pqEp8woZc8p0u4PK62ZrW/yzZqMjeRRF5?=
 =?us-ascii?Q?7ICZ3jnkISlbIZjM3bIpCRYAEaMTojYnJCMCW6N1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7642d518-c045-44f0-2b63-08dbe842c1e7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:29:22.3013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfEo4gTcvsYpKqbq7sNukmESJL+9swmS8tp4pW0f3vUIMZhbWFyml40BLIqOk0TCWgQ0q/+yXQNV+6xbUo1eIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

When the lookup_by_id parameter of __lookup_addr() is true, it's the same
as __lookup_addr_by_id(), it can be replaced by __lookup_addr_by_id()
directly. So drop this parameter, let __lookup_addr() only looks up address
on the local address list by comparing addresses in it, not address ids.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index dbf040e39af4..4cb52df57ba5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -458,15 +458,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
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
@@ -496,7 +493,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr, false);
+		entry = __lookup_addr(pernet, &mpc_addr);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;
@@ -1832,7 +1829,8 @@ int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8
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

