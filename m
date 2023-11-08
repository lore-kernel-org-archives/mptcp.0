Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7895E2CA8
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="rKGADioo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxQut30akHZZqU83L5VtTKX0GiIr9vAlyP4HGqytvE7L55eo66+fVfXMvu8OSWbvRZJUp87xuJMdH+LjySuktdiRbScxUTxnKy3s2V+hMdrIRYppy/9YBorHk0SNdhdelCDPHCYzAWoa+l+axrXC0O0ukHJienhTWtkqHbcxisYxWAOcQIeLYzgAa4UmDimz0c2vFVsvavi9YlstL4h4kb8GJor10vZA82iUJwqfpCAmUClNBbtTdXU/Dt5g8g5wf9RyA/SS6eKPvHAh+4r0UEn7bxg7/LdFkRVlTpvM35//OFQ476j+McbxKq1p5ujtygWdvJ00tewBuEqqr2PvDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7yZZCJyImdlhF3yfkr8RmGBMoZfcXqYBgY155dLXVg=;
 b=HP4WCo3/edDVSEfRapED048w95sBepYjUMyzQ2aox7ggxTzIyKqHSTuRiHp3UBBhHwoVq7wTVJrGCzBczQyX/jHdvhY5i1pUauc94mBKbTBeDPDSLnyjaBOyrFSlCcmUZdLFeCn8yknxKwD2T2iqTN/tvYTkv3zs2grVazmoE49y2Wcj3cf6Kb/TJwNVFXZo4ItgqNSFT4q6TJbUTBgQfA2oK9hMcnpmDZOcgzXT4S1P4ceUhqDbuDAFJDwC6/v6aBB5Z1LPnKNKmVSwoyFhb74EzEJZMOOfAANaPWCzhUdyt5LSNyd6+V7XfIOn8j/MumZcjrzNVGPbHWg02wasVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7yZZCJyImdlhF3yfkr8RmGBMoZfcXqYBgY155dLXVg=;
 b=rKGADiooOxSwPOhQocCvjDyM54SrtlOhKPKURV4/jxhahGzGIb0R3hnMqyAsL5rbe7RGbHcLYe2S4f3zOGO48N/6EhPTprtnm09tYGZzDpPVKQX2WfrvyDFkcF4twSzoMg75BCiQNn9ci2kiN8/Uv7qnTN0+VTm9+/O1qzQ1+2Xqm7U0P2oTeI121Yq/Qdpxz72tAIuSQyRF39tpy+DIlpIY4HLDAFbN8k1gb+5AkbNUw1rG5gpZmFCUHu5/8Chi+mc7qUalkH4BVSngsSCFLGNCzw18h1PvEpKZDz9cV9hNu9TxiRN18qtouufDWNGyRLY939NcNr5Q8rSGPRKT7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8803.eurprd04.prod.outlook.com (2603:10a6:20b:42e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 06:50:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:50:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 05/22] mptcp: drop lookup_by_id parameter in lookup_addr
Date: Wed,  8 Nov 2023 14:49:35 +0800
Message-Id: <c87db0f18009e4e092c25ba34212fcc8657a19c3.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5b1d43-9b9c-47a3-2bee-08dbe026fde6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7yIRqDNWbOtj6swOyxBWtkoy0y4gdqVAS8X5/2bIzSHDMAFbwvb9ySQrsV6uE5BJZqsOvMSIvGoVkVP3oL5qnMeVl7lcng8w7/e+tLoRus0v0odCMChmGioW9S62aVwy7xNRbUlrZsRqWztCPXZR5fhNqwURDRmPSyZtyWJ6pTVPqSG53E90gxCw+sQztYVBbP0rEH32RjS22wvcoMyRT2o6OYtlBE9R6odyEyvisyNryxX6igIcORBT/cdr7Y+LLOYRdiiXTrJpQ2qPhyrwyOTXu+t4+r21BHNS3tEhMPIK4ZcRaz23tNAHaGT0q6BQIQ7Fm7LlyGF/XHxC/duyVRDrNChMQHfgZKpTRPl+J94DChGPMAD/+D3QkO0U6L1hDwlCV9JJKT8OZXR8FA8bQA+UP01KYdccT9mpjbjRQwsHbmuZOCSSTl42Py9WARuCXA5rS34ZFrL9fnTA34bNTX+vQSDFzcHX69WMnWKRtPHWPBql/TX/KHo/RbWEgUXnSCnNxMpCAzmK9jTJQ3rThYOxQro6eZoPm+iE9G8big2k7NHuytWvFecW/Bv8XGpYe1UaMRWheDU5qv0rlcr9BlRRCYiSRbXo4s5a4CktoA0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(6666004)(6512007)(6506007)(478600001)(6486002)(83380400001)(107886003)(2616005)(26005)(86362001)(36756003)(8936002)(44832011)(4326008)(8676002)(2906002)(41300700001)(5660300002)(316002)(6916009)(66476007)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oeh7VfHsZ1UUPPEqMl72e8pqhCg0OPe2NN1cZPzGvw8iw137yvf2FAB1B0br?=
 =?us-ascii?Q?cI1Igu8yeG0qXiEMnEDSh/tPTEbCL7Y9ZkNbMtViVfo5RY1kZwi6lvTB9h64?=
 =?us-ascii?Q?7Yh+UcoobY6ezN/tjnebC0I/h9xdM3JL1cEvknaUr7s2fRzXkP60doUcTfVk?=
 =?us-ascii?Q?0e82WcsbB0j0XVzofEB4nZHffu3GIpilvMimvOBfWLnPKIp9zULpcB0Zuynk?=
 =?us-ascii?Q?t7xBO392ADgyiL+CGVDDF1+wgrx1HcfGOcgmZpNwV4GE2ymkXCZR8/JbMejz?=
 =?us-ascii?Q?8pYrkbxRAjV3dEPzXU3B+OWrxNHKrewOLwem/P2Gsj0I4Gw4TV9VNkNTIKEM?=
 =?us-ascii?Q?zVReFPdKTYqz0STnwUPEL1RL7bP1Budlk/7EmWVvaaDUtM/axdQuzkKQPDpL?=
 =?us-ascii?Q?HIgw+T3jNEDT9EF7L2FFYp7c8r9pD35byf3jp2YLU87hpu3QuB3TDnEbF/Q6?=
 =?us-ascii?Q?8kjVEE89KG5nTCgoL4AucSfiou7F1E6o7yVpWOOhd+6GtbLtB7idD4eTGvT3?=
 =?us-ascii?Q?RGD7HdeT9RK62DAMNCGVmJlSaQhOiLfCUo51I0rw72QaFQJ/LnxE2PEqQ23j?=
 =?us-ascii?Q?71is2lR6PAcpkBKEFdVcDD39vE1zZr+sM13taEquB8DpWgS5Qw8TRWOSC72Z?=
 =?us-ascii?Q?sOn+9x++WtjA64GKt7Fu7iPSmZetZogcPlV6I9OdsGMKBLKQZ2jPutGwMLWW?=
 =?us-ascii?Q?plUzix0mn943DfOYMnH3r2FCxx/QSaBv0ZhLyUXvc2j3xkvBVOUBomwK98/I?=
 =?us-ascii?Q?m9FmZmjOhXhWEOnh4HxT9d2Lm1JaIdWOVeUeLpsZ6uebgIL/HTFmV9tWs2Pr?=
 =?us-ascii?Q?1lEwW6qYzwMf8C7NII761fOJKRONDpdSRifWeGOzFJiKU0YYMuway3KMqJHc?=
 =?us-ascii?Q?gfuoxrk0KS3louU/ePj4pc6IPmlHfdV4D5UCiLzhLmnRosAyIM7bX4viYEJu?=
 =?us-ascii?Q?FbM8s/O2KKBH4Nbg/Tg81x2pnvyu+xqHv9TWr6TaxfUDXLOTBHNleD6nhvje?=
 =?us-ascii?Q?v/CBazGLhKFzTVUzc1w5Os/oYqY9Y1IF1RXwEgzjeUACNLbz6akfVt/WPAe7?=
 =?us-ascii?Q?vMrgIMzrZrm3uu04ROFtDFxlhvrp8KZ3B/m50Bxb0ANRZ6wlmv+C1u6peuUX?=
 =?us-ascii?Q?ob9lerKa6+sCfEwKLJmfpm9xWpD7SOF/fxuVzEQeypphcyLXNf5O1HZLY6Jn?=
 =?us-ascii?Q?28k4PkKtLWMSqgjln9Ja8T04GRirEn37j7oTx4ZrJ8hTVKazmBfDL8LJClIx?=
 =?us-ascii?Q?x8J6SD9GHjZ47S+isnAfhUi93RWiwgBqbPY0tpd4k0Wxg0PaS9QuQOpGBZz7?=
 =?us-ascii?Q?9N3RId6eXpGIeTFYkhvLQTcHGXf6bwVqSoP/FAuDwymtCFtv6JzTBuOq4PHU?=
 =?us-ascii?Q?iM8NnCNm033X25cpLcL5AE+D3X5R16cwrwV8e5QhsUBTytzJu5amuGuO+u8J?=
 =?us-ascii?Q?Xn8GSMPXDOkavVHIlcJVjGiViMV/8s4Ecw2qIJGqwfHej8HUTJpj59e4lk5P?=
 =?us-ascii?Q?uhGf6M6GneB7YEXihoIY2Ezz2NbPf+UlNHtNiL5craecxR0wWz+kZvTqf+uZ?=
 =?us-ascii?Q?d8dJm50Va7ry61xXX28/JqC8LnW7/x3boxQIC8slbB/ape0vwG5XsmFrcc6e?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5b1d43-9b9c-47a3-2bee-08dbe026fde6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:50:27.8388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UG7kMZQ1zcfortO1u/Rh9TbD50BoJyPIsRvQAf3T2VIGVRksS2N7UovLDfRuEPghD+IZQikzdrhV3OVglN0gzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8803

When lookup_by_id parameter of __lookup_addr() is true, it's the same as
__lookup_addr_by_id(). Drop this parameter.

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

