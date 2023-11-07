Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3DE101CF
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EvwwXpaJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMPzufsO3Uz4A+j6LLQK7LH+4/XAaKon2nwE+deKnkcOdS2YnHANREi8sKfehxPPJoz2ibE7g3u8srhGPgm8VUzgpZqnXqSqFXuK00le/8ilrMEgCwYBFLvHYbEGjHayvgDbPaxU8vKAogv+t6QW8FYjUKJBedMrvNCX6koqHghpOFqF6/z36ZXbMvvtvNS+hCdggJQ1iTgEpZ3oItDKzjfUAAfF43roLM0UEGgYGbviWzhdvavjo/6b4nz7TZAEQ3beSsEpM2XwnnsYn63tesQEAcZl5gnpreZUVo50tk/EUls4Lf0cGZSkhwtgXJM5Uqx9icITCH6EtsEYoazyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd0XmH1SYWu9fQnD3nT5KuFwrQBJ0oWIgOJZJRjOnhI=;
 b=ScwxiJSfYHbFsD6TCkvFtzjqLUSXZ5NkW+IOtE7WnYG9hllbeHAEvGgpYYN0gCepiNaOpLjfJE6jHM7jI6QJVe4sHJ/w33EelZ8MfDP+ViCbAVrsJ3tIUv7eJr36I3TtYNoA3NbLQ9Wx9EO++GgRLj387c6hWAdW4SICiYSMkguL4L+cZxkaydqWQiRc7JDa1UMgC/XyDKGoHURfBFA0r01D0pH7cfyWprDbHCk1/xEiJZrfKvvp1mO2gyKU7OcaLPPuCC/w31gJYSKjaUpuI3xQXF47GB3LnWZ0LDKSIcwGg2lnFxqPjSiBtIGi4Vyy1GQH9tEhQgfeGPWMdhNSrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd0XmH1SYWu9fQnD3nT5KuFwrQBJ0oWIgOJZJRjOnhI=;
 b=EvwwXpaJwVS9/rN/CYpdHJjFWSmGCO6Ca2lfh1lGK5nfnNebq50rUH9itQiEFdq78PG3PRBtIlyDY2oABNExwQ34cIQG/n8IANyJ5XPpn7zDsz4z0zfy9QRG0Chxr9VTgLC4GziiXzb5Ae2cny2mByJF2WQ51ipURWhHJXJlQCdjFbsIO1W2J+tJvd5Aom4Xlpce8VlB2k832M98pUhHfkOQiaNjrHhYW/Pmz+lkygbvegjBdlr3bOxuhks4T9cvDbL0D5ly1seWfC/D/1RIEtmGeoxsr2YMPblgYzdTwdVukl/dZLoIPEmlxW5UBpyUwBFI7vKKEYbdc8d6/46HxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 08:15:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:15:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 07/20] mptcp: drop lookup_by_id parameter in lookup_addr
Date: Tue,  7 Nov 2023 16:14:13 +0800
Message-Id: <ab25c88001446e9cf32c7e142548b31ecc021802.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ea0ded-dfff-404a-2e17-08dbdf69a8cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k2zVihSizV81mKo6SumUUGMCDLK8UDeAPZ63HgctQlPK6hLbKV/qAtpoNV2r54fi/5jf0alLRXLtFjFA4RX9mGdVmIvIc5Mq89qvOZqNhMSp2jFT6MtIYgkj/chUzNclP/IUKTyZq1XtvtrQMEFT6Iq7FYK1Z+xPw6jrlXSDA0Bino+o1qJAxjnFQFga+nUD53iQ+AbogrjcYLefTgEMa17wTDutvAz2zY7vKKUwNlzQb80zpoxwpzDKd8Dr1yA+cvgDfv/oTls6GaJeSfQAZ0259IFeu15keMw7CuYsOstsA+wBr0lZcaS0gMxfC6nHDBBUpLqxro03w3mn6MJeSlgCzEMdVqUf+/QZHtOKaPNbSrSzoywImv2/iKr963KI3AzMcoAMF6ImZ7HA8FEUTY68kQL4sltbLUPZDWiJRxpkdyNITTULGA9GIkzEqmyrVdt2q5hsEwUrAam8tnuqLh/UBEiqnlZVTSDFJqbxaCBeZVP5kr/KM6gMG1xkhG1X28XKzQ6O8YSnCDe6p5F2IWKsXZbQl9Gr+iDIoxrT3zrM1l1+DCbZRW57brCZXxGb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(2906002)(83380400001)(41300700001)(38100700002)(8936002)(478600001)(4326008)(6486002)(86362001)(44832011)(8676002)(66556008)(66946007)(6916009)(316002)(66476007)(107886003)(2616005)(5660300002)(6506007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bSoQKDjISR7ZLJZCK54MdqOgASLJlY7Dvd0/9XqwFcR5b1BXpRxCP3tznihk?=
 =?us-ascii?Q?mwXn8z/vnfgmgWQBgsSGqS0I2cLLuyaFzkjEYInJYlLnCUAoWh5MgWAPPFff?=
 =?us-ascii?Q?q3QYd3ciQHfmS1a0CWak+BtKt4hwcaYBdaOxuzIcxPSTt2/bQvo19j09AqGR?=
 =?us-ascii?Q?Ynph0H3rcJodVF95zY5r5u27WvXjgHjZrkdOOO159OG97ws8RS0nvKednCuk?=
 =?us-ascii?Q?TfxL8Q8ajEU81Qna2rTYasFbeTx6sq6poNYjcR7g+ADBcp7YBEynKGd0C2ye?=
 =?us-ascii?Q?CatU86WueGItclk4NpzXD5IMNqUQGnVHPwp2BQTFNri/EhGlTLr71BDcLxT/?=
 =?us-ascii?Q?ckKyZD2aZe7qS4vAFKp4TW8jjV2tsD2r3Ydw3nkSvwWd0Q2J/gi+pjXHmERF?=
 =?us-ascii?Q?XOkyZTlGoH6dtKnQpvJAwc41Z2PwwtL0SkooisKtUmjahNORJFgrFnXpFFr0?=
 =?us-ascii?Q?+2ihADjJzRWa9ryHjf1fqrranA/fp+x9hYdRxTNcaVQ2WYRw0g/JUjz7VQZa?=
 =?us-ascii?Q?Yy0OGeymu4+asLaRERVA6PiZS20I9nFOkzuDuw2UGRW373LWmiS5JnAwstq8?=
 =?us-ascii?Q?0cszhezkKy2bw5R+8BqSO0PAULvoT0nVDxcbCi1BgeNu7NDCGcHrTS4qj9kH?=
 =?us-ascii?Q?eA4V9CaP3N2N8J5p4/H2SUy4/BXpn9mDoybDHU0wDgLUpwKv/jFfRg2JTAai?=
 =?us-ascii?Q?VkDz268/DFG1Tsggh4aVt3s9EgeEcCneLDCcmeh14M6QObN4P7rLUzKys2NC?=
 =?us-ascii?Q?6W1x4Tb/EYYiV4ZY003uvo2zFgPybpht0aiFobnAZXN0+bem/zBG2AaPI5FJ?=
 =?us-ascii?Q?DpiwFtKs1L5PW2hrA5Rdv6z60Ci7emTSOWjTPxdVhH6X7OVzYDJyTstHmCrr?=
 =?us-ascii?Q?Sv4G0OB7kv2NCv+20O2fqPSwSKeKcYEMGs93b8Fd1CuZdFrpWP6aR/1eeXMD?=
 =?us-ascii?Q?Yk/JD5g5a+o2yO7b2qZiMCd1Bi+He9q6PPExN0QilqITNjq8jjHjlmdDTSJ7?=
 =?us-ascii?Q?5eIST0/VtZgkZf+MT1pBNpBSEHd5uoZ4fdDOFJgmabmA2FnikY2+E1+V5N+1?=
 =?us-ascii?Q?Yitk8RGaUNWmz1SCOQ8tzBoOSkx8PT2oM32SYfF3IQPCJLZRN5ZPYdE689im?=
 =?us-ascii?Q?ZJNGnliD+tO4N54C6kntw8f8IdERIbEfNMqouHcxHpo96w5mqk80cDckWPWm?=
 =?us-ascii?Q?PfQMHgrAkdV1cq5OdJqjTWuqPVs1rWgCATPoKb3eX7orwLTAzWZe0qBd8n2k?=
 =?us-ascii?Q?MzCIz/5HuJ+p0mIPRm9tRVu+CDMHSBHFYxatpRcI4wbB1eaIQx0JVEKSiOtG?=
 =?us-ascii?Q?SpD/5hoxMOEvLFHuGgETx55dln52EZX54ELCYR4rRqPdsO9FZU35/fPzZ/iP?=
 =?us-ascii?Q?Iwv3yhf+KQu9WrgYzOjnVWEr+ds0e0AKPLg/p9moj5/Ex+nc2WCGH0wo7vnG?=
 =?us-ascii?Q?H5XsDOkC5lsIUKvddXdaUfJStyq/8V+YlukSoEF3omVIlAmJ3hvQM+wRVTsE?=
 =?us-ascii?Q?4fAprDaegD4ZOW7lKypq6BM8/FkHfNvgLDNSB3zu8PwzoQqp6IMIUiG/0oiu?=
 =?us-ascii?Q?WvaXBGQB3+x23SSRSrYMaDNw1Kd/ldQqR8/pso4L?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ea0ded-dfff-404a-2e17-08dbdf69a8cd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:15:10.8259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+6PDWVH6mrju2TBq3lmkEer2mPMhYdqI5ZB2YlpCBARsxLst30JOdzyf0zk/ObEniuN8e8XsnkBfDHGTZ+uwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663

When lookup_by_id parameter of __lookup_addr() is true, it's the same as
__lookup_addr_by_id(). Drop this parameter.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 95a793c6702a..5d42b62cc3f6 100644
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
@@ -1834,7 +1831,8 @@ int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8
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

