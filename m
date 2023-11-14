Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EDA612D
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="xCZySjr5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ni8uNO9m1xqKizYcR2eU+ekruos+xJeGt88bTKMAWUh9zGIqArPgZpMnlCxtgflUrI2W6b5Z8eGQ6p8K0p5y2xUfVi6DYA1z5rxJldJ3aLfnlDd4p40JTDjbAB5l+AF4RO+FsNtvWY5f5J8AVkgo0MLHLN6sYybDW1UAFGn097hMIf+/SJ9Hr25IiHdTHD7ydI9Q+rV+TxTGgIv7IGY3Sfn3n174e6dXzSa0HbNaoGTlfnWdsvdzclhow7keEChbe5MDuIYIs3L0XBzGMYDm21RPOPndtDVVsN1o+CmNM7vJuLCMrQQ9WxgBstdI88hTDXDYPwIrl0jtg2A9FvNX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdLYbK7vXnu1Q5Sj+OUn839s8mJ1ffI2svEYGzcGgdM=;
 b=nQAqxIVfMtwhFlT0c7eEfeT9s+YbrIo+WmYo8Y/Xs2NoDdEmF0JFowla/FEUA0wOCn4Y+E8zDnaYY1/HW0amd6DC59e/1GoAyru+R4b2i5br2FdDSqCpmvsXGJMbgLbYHDuXqRex8oFBM8vSdLIs3lnaNHrxcb3GlbTsxaCQR+FF83x6pu+6+kQ0RWA5Nznf+Ug1izKI9LxeIFSYtHU0Jw619vFxBU17tqZA42WoQjFMhvPx7P8W9jDxQcMhLxK8MpFrcOl3vl+TZF5STyaQXHhNK6BkT+xh8yXivCRvWb9h+0rCLx1M76Duiw5S86NtsfygdTYmSwnevvZCgsF/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdLYbK7vXnu1Q5Sj+OUn839s8mJ1ffI2svEYGzcGgdM=;
 b=xCZySjr5EuKKy97n1eiqeJmczhApxDsOdhp5uTjh906UHdQxf1wG7W2lxHLPYRRK1ljNKPthGvdYBzsObRetHl7PB8vMKVA2bbKxaCDWN8DMNh2gQH2papMhoHl6pnIl+CJjJX6jn5MHmbf3o7ZUYcDh7LVD3LoJD1i1KAeMGcdDXEnTC6WnUV36XtQKGENeJG5vP6cxGdd5f6RbYCMVY9KWlXOA1A7TUK27sNy/PsZSLVDDYpihSe+UkG3/E/SjVazuKi2IjUjKm43FUM1EnaGCmGmUVipjk0Oq3UYgRMhGcKeS9Nw4GpsHz+IqX2DyTqjr+3i9idWkssVw8Zxs9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10052.eurprd04.prod.outlook.com (2603:10a6:800:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Tue, 14 Nov
 2023 06:36:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:36:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 05/21] mptcp: drop lookup_by_id parameter in lookup_addr
Date: Tue, 14 Nov 2023 14:35:02 +0800
Message-Id: <b11ade60a6f1dc40a9e485d428d3715a2d8f0e9d.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0210.apcprd06.prod.outlook.com
 (2603:1096:4:68::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: 5526a9d0-048d-4874-c770-08dbe4dbfe2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9KhO5O9nVdF1ehyM/Kan2YCVwm6Jzs5IblNCO/08LHZoO7fllv+Zb/dju5mKA1TcxYc6B276nlrScZ/njJ63fQGNwmNF9gt0b2hxwgcHB9DNvxO2ohPDuPpQMnL5vX2BolaL4BQPW/zI3GxZWeBMPUHyBKej/jrHNBp9vfd9AZd7six6wRTMd7RldEm9f2UzpguwJ7PAaF3uVexnQfs4lYfzxHMdBLxJhcLAHWl58OeWrUVFbvFZGMu4+n7/Mia8ClRGVjZEecNspFR+GAX9+I8NzxblRpg+SpbvHBOuZEn+Zaj7TTedBxWiZruK4Ot5GNQqPGdwYgGjRcl0OiCmhwOfiXhZhLkHHNEL7ik5vdMnfqXq2ttSqXCaHLhobpnTCfS1xSmDyewaIycT4v2+RISYGTrQilK9/nJWu9nLSWPHXx43/zdM0KJVvoT04xG+QfSMrcqB68Hetc7dh3Z2Sr7stemRkq/feeyHI8I+ezxO0yf65c7omgaDiH4boEwkllNe8PzdcdJ8TJ8D7Z7NHywaXCraehXxaYwRM8vGwYmDbOZrKhIs2siM0Uo0fRIq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(107886003)(38100700002)(66476007)(66946007)(6916009)(66556008)(86362001)(36756003)(6512007)(83380400001)(6506007)(6666004)(2616005)(2906002)(41300700001)(316002)(478600001)(6486002)(5660300002)(8936002)(4326008)(44832011)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6tZQkfAfjC2ZPqVuY7L5zCsStWE1xVzsCCmIWr43yd/I5YHRcukggPCftatr?=
 =?us-ascii?Q?hvE1irkEqlZk4aW9gH6nU6w+39imW78LGTfuBNcQXRqu8NNWId7QoDwHvq0a?=
 =?us-ascii?Q?N756P5iq7o9d+is+hPiIdIAY29rGsPNCv2bsOBeAVvtHI6tIJknb03Tsihmi?=
 =?us-ascii?Q?e3gtM+KR971sBcufNtcAKdHgX0Wx2oXXzXxjIaa+jtHTk8l+cLBz403IvluX?=
 =?us-ascii?Q?rOugShFP4rJJZogglHOktqZZUAa8AnHbhEXhMKmhpgFJFHk/U1hVw5mqq/Gr?=
 =?us-ascii?Q?AA+VJNBOFLoBS3YHXXwnioKEGml4TZdXDLGA9gfckgF50aJiKWFNZyJvuXBW?=
 =?us-ascii?Q?6LFrmpCZXH1Y0nSXQILRJae79waIYqq0GJn0hiU2uEUdmZlQwA0Ukq9bTFnk?=
 =?us-ascii?Q?/jjxUxNMNvK2NMbPnHO95gQc3iS+OrW3MBwQ9HCSEKJ5LcQrxGd/petFxxP2?=
 =?us-ascii?Q?s+HWUiBTeAtDUBqcEh+GAIZieFs6ukLLsIquT71YPMKIq3kKLpBQwXcSDOpa?=
 =?us-ascii?Q?h1HqQawkXrDXObLjSWBvFvZeNoUJ7qPQtCO1To6T1jBamOqZDqLcUvwH/3cC?=
 =?us-ascii?Q?G7CyN8YSaPmqlmlE3aSR0c2hFdpVdKKLkxA8qH+ubZsI7jMsUrfKpZ63S34T?=
 =?us-ascii?Q?DLxo/aFbTuFAyVjzVt6lbfeoUuoieHyHLUMRpow3YTZa01g36VNCzHseTJhr?=
 =?us-ascii?Q?Gp5At0cSUzzbnz65RG8GDKl6TFj513mRJUwZTUqlr03KAYXHBnITvP2TMP+F?=
 =?us-ascii?Q?rAyidXoq+wMcJ1beKkaFRSmsIZDVD2YNCZ6s663d+USI86IN+0s3pmakGfS6?=
 =?us-ascii?Q?v9fYSyzSUo842HrlqTaQFggb7tBBCTMNAvYahzfmY4BxBCMIzZEwgmeWWRkW?=
 =?us-ascii?Q?GHQYjsRL8fknNor+mEErcNuuvq0YE0q0M8nm0Gqwu1rbh++wSZD/zfuymeSe?=
 =?us-ascii?Q?3aPS3fw1KPckd6H85eUyIr2g8cHzzjR7F1C+4MhYUHySS/IKlvYttZrnTFNG?=
 =?us-ascii?Q?bKD6mXLb2ah/n6LtK1zxFZKg2L6k4WBeGGQWqwJxwpArtQ8fDLzS3I6pHk+J?=
 =?us-ascii?Q?jFgl0azN/u6n27uM0ml4AtTGpGXYqeEQf/2XTesLHjFohPAv+GPZvdNC7ZRz?=
 =?us-ascii?Q?+nYACVRrLyaGWj3R0hP7gehcXrtZ530BRZ163omZMJppCqVrR97yqAPGeKQA?=
 =?us-ascii?Q?lrIiCW3ZfEvtJBhOVNa9JdB6WcWBzOMHCeUYtkpRLwvrORt8Rp+cGM5uzMnz?=
 =?us-ascii?Q?sM5yrDpyLMELZwh6cP5ZSUla2QxbjjrqNLNNRbEOZGsmvPKhx9H5/QaZin/n?=
 =?us-ascii?Q?m0d8oRat4k45hFdQGc8QzdNWbWspdDTZiUhSDiZ/BJk6Zz8R2uX4lL9DRQtd?=
 =?us-ascii?Q?Jylf3S56CaYsHyDHaGmACeTmfaiBGo/ePjFAgzR8893Kr/vRG2DjI/nS9MYr?=
 =?us-ascii?Q?DTnEyxIZj9Ru6z30EazDHF1DatQHx60Hf6Nw9pr6+LqKmIRAa3M4WtvABYEl?=
 =?us-ascii?Q?vL6nfF8g2p0UszRiEZMk0D+gHX5RHgEWqwsCQSXp4YwaODStEWL5vrQdaS8G?=
 =?us-ascii?Q?XDi15x9nuhaNXTDG0XHV6QWdwzUooNU74tRvraBz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5526a9d0-048d-4874-c770-08dbe4dbfe2f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:36:11.7570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBS2mq37IirU6HRZjR+FjVcKak4N+IA7Ow57hb0MBgj+VILrpF/m6lj23k0dQMAb2ZZNA2/9ZAhmKBSsFaKdPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10052

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

