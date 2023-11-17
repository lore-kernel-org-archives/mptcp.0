Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2088.outbound.protection.outlook.com [40.107.14.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25986B663
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ansdy03a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVs9BevKwdTsToBLYyISfQbm/4vCMKLknxQ+M9UPM2enaDFNSZzRMa96i5QlioxT8+trWMCPyLzzEH0PA9Dqpkk+2vWeW6kC+3AdkoSueRc1kyp8YEHhdU56nNxJczeJ58k3XdbqQb12U/vW8lTvjh2K9T3pjCi1WaKT7ljZXpBbu4R7K/6NMn7XDsA3VbBgQFN9+uCIaE8Jel/9yk/utlqyRA6iepJ4Gq+MteEEsHfifyhLr0Ql2Jk+S5msmGa9Te4wWRTQt8aK5BusolSno/r4aUf2yaaZzcf4aI3uM66jwntITcOG12RtCzKfaooNu9DPDeLqsr6OMQctFxTAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ky15XWBtA/4dpY1pWmdvI+JIciuSmIx+xXLtgq6JwBA=;
 b=Luo6a+SEq2L0I8VRJYvwA59e5KNMHtk7hsEOHRKmi3mv4a4ke7EZ/rpk9oK61Ky9MTZI3qmkLLzPaKE1wmVf3uYrh5m8gq8tIHSjlqcPXDtTeRTcZjV1o2e3uU0+1oPGPjBTB8GZePCeCLVZhh6Fv19y/WwImVS55XG2HHY5GA2JspZXdd481jhy/D340aKzZ9baR8gvPck1ZnhUsTYVEi0wyCs87vs9t9k95zTxkybLzXyy0y4gnD/4LG23peV33q2xFGlkwSuI89GwMT63Bv8coWY4CyPv5wGjjNdYHmDfDlB2NwmY0RRWbERHQjDhC8SW8J4xqPN/CqlG5usAOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky15XWBtA/4dpY1pWmdvI+JIciuSmIx+xXLtgq6JwBA=;
 b=Ansdy03asG2+KohtYlnOYr/fbscyqe7TF9sUZWqNyF4/gTLGwkbOnnrxMGQYBek/sBZV19GLkPVtaKoGhte6ZQ+/JjDAWPPprgQK7DpeL9lUlxmKd3DyBiWv2MWUT7aHox+/RvlVCrgVtoOQlISeeWyHOSS4OwtxL3DKDUTMYuNNgxezUwSy8kT3OurIaU8RELrfbFXRgHqdHOtXGO8EPLJsQt6XT7+vM+XWx8WkgTpsBWD3Konn5guZyelKbN8UhhV0l4qnR4qzIqb2WP3/ARagKo8h3Z3wFu/rDs65FhCG3acw+Rhz+shlaJluNgj4QOc4bT4sfx5fOwc1uXEKZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9975.eurprd04.prod.outlook.com (2603:10a6:150:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 08:58:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:58:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 23/26] mptcp: drop addr_match and id_match
Date: Fri, 17 Nov 2023 16:56:16 +0800
Message-Id: <bf83a30c0a8b4560d7c3fb81c1e98fcb6a8635f1.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0048.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9975:EE_
X-MS-Office365-Filtering-Correlation-Id: 89106241-e9d5-47ec-c5bf-08dbe74b6611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UvX/za44SMaZdGYdeL4ZQb1ahUj3YdioYo/6PCuF84Qrc+2piEusLHcS0Ea0kT5eD4mbyqQ9wEZS7gxnK+p1xTJPJgB3C+yFz2b0WspUJbN9JrFdB9kkiHBsxUSwUvqvwX7t7wgwrHlrsKwT/83Ip+vbMPz2WbgfuIzwJBkS+gGG8N5eOrL5/LE7ChFTeyC8ixSYEvqo6o1GJandOokGjo3rtHxqBmXjGWJHTHd4sL+H/8KkAlzICzYJ6AxUc2V7xN+BTa+Dh6kDLT/g8bb+Ue55EfIPBhiyV3BcWikMq0vivGwn5kHeyReBQNn3QENjZSmb9ZZyCJyJBKFm82LpzzxgE9fZylZZS70E9+mWmfrxa860i4NpYA2PdXb+eivD4dD2FtMUPjdspU/KSrtialjm6ry+a40jNxt9lBkLl6o+mVTEuQ1KSZTgD1BWVUABMg8GVKieMoWcCFv120uag8dDl5B2w53aEttL/E8dxZCGx8rr+BAPXnT/u2+DQ5dMDf/hbjtCZnvnaxDiFH21doWmeV3F56CD8fnWMrdZmDPT78sdvdDBwfkxF0y7sd1W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(5660300002)(2906002)(36756003)(86362001)(6666004)(41300700001)(316002)(6486002)(26005)(66556008)(6916009)(107886003)(66946007)(66476007)(4326008)(8676002)(8936002)(83380400001)(6506007)(6512007)(478600001)(2616005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MidqPPLm8emwPi52cIYaDlReVWp0uH1bWTzObVrNwv1Sz3DUWLeFLO43acOO?=
 =?us-ascii?Q?+Q7536Ya2ScoYRVLE7AlopFdOiW/mBV+MD6TLh0kzf5r3mI3KMvdXfEhybxX?=
 =?us-ascii?Q?eArnV7Sj8WV+yKYwuHQ3oBfr9+2WFWLxHkz2hZ60Ln1Ot9o5uQUbeRYTKhz9?=
 =?us-ascii?Q?eJVs+WdfvwnBMloMX2hDSYckMZxrPMD3XB0HYdv+1CGp+SvEl+QBE1AWHMj6?=
 =?us-ascii?Q?lISOclpko++AN4586GpQSY9VAy52+eBEVtWVuX4fNESTmr+IzaplYfclwOJv?=
 =?us-ascii?Q?Ro1ASqYXz5HOwTXtYrrGmG90/+Y1IiIWZ5Edr3SLPs+9C0mllmZ4nSi3I60c?=
 =?us-ascii?Q?pNWYzWKj3brqNBwqqOceAKIhN0IN67H+7Sn266rmCJt8u9dXGNfgEn9x4gmu?=
 =?us-ascii?Q?ksNyY1WrZYdGO0jwm2sydwVeYlGs6ur6EPK2pJRf4CUpgGBiNi5d5yNUsWTZ?=
 =?us-ascii?Q?ZDnDVNCKIrrTlwFL5Hf/w+0rx+Ca5M2SQIpJaJawyFhFcP/t/6phedIGNHRT?=
 =?us-ascii?Q?glRZ6ornfymwRmluwgknuV8Xh5OQ9WcSDMyeu4W09rG+SLpZ69mWX/ZvTcoY?=
 =?us-ascii?Q?oQr+bFa+CuW6l+nDwe5k7OIuonJyppEoEoIgYFFguaa4BtKEJ/Zzqv5I8zww?=
 =?us-ascii?Q?IljEyjAZ8h6wYcZpNDXr6igmYVpe5Czjls/hVNSkSqHP1JLFMlQY5yKjj0io?=
 =?us-ascii?Q?h+ud5bcEwtI4OCpl7BB1iOjB89nAzcMQOhN2AK8sqjaVF3ERYTYCBcq8m8BK?=
 =?us-ascii?Q?b0g6+CT5Y/AghRMjjS4qYaJd+tfg8WtK8K0kt274CbuwuAPHRNlwu34kyXHf?=
 =?us-ascii?Q?SIrXeihdIzP8mk33QqupqH8binnpHVqYbI4se9YBJVlLtc7liVXl2VCTRgID?=
 =?us-ascii?Q?0gqtC4XhGyxs7dUMZ+MpJ1/kXzfwYXWcC23TEM8rKydZOi5spf/6C5H52zig?=
 =?us-ascii?Q?1Qo3E+ryEm6o0FzTM95nUpqHIeFil82m7m3mlO0EaIsPdWYjXKeWkg6H6sUa?=
 =?us-ascii?Q?+hGVL4VpcoDdi7yahROMzOBYkAir0Ccieu8WBjScvG69lr9YuaM88WSuoKyS?=
 =?us-ascii?Q?eATQ9JpJ+iI3soE0uJoFwovyDFfQaXB61n4MLsueGH2+4//xRKwG70VI57t2?=
 =?us-ascii?Q?VeC35FHcYEdcPa6nlh/dSMaS6wjJhnDZXoZpWwdBVIzjwx1guRWeY/FhyoNG?=
 =?us-ascii?Q?7a82yg5lAExyWm0s957nc3F8HpxdmsGQFueFuyEvlN81MuLgo0GZ6OcEv2yY?=
 =?us-ascii?Q?MBKyDQmjTsHMR5hM/g/4zPuxBDi8+hZw6qFBtePH7qI1Q2o4iJw9sARM1pVW?=
 =?us-ascii?Q?El9H0xf6sRBeg2JdyBBVynmNG/LQMJsXervZu7hZH+Mhd2g+huy2tfuCb9Sl?=
 =?us-ascii?Q?LJCNB1olLUjVrOpwksU5GiBdmCKaX5V9iTUCVm8s20k1l6YPu+SHkULRpAsp?=
 =?us-ascii?Q?CKUAzdaicuKUfbH4BCpN+CmPqvd0QRr2Cz65tkFJApMe2pBL4hVp8hL4xcwI?=
 =?us-ascii?Q?1th+KrGWMcnlY4oV4PKryeS2SrTTrbmtpIbJl5gbt8coEOdW7HBHidNCEHeN?=
 =?us-ascii?Q?LmE/QyjI9skRGfCDWrvIFIoQUIJvmE8MXhIMIev0pKeGcYIgKtAyg4xoa8W8?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89106241-e9d5-47ec-c5bf-08dbe74b6611
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:58:42.5622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osgDsUcXs6rG55z0UCo8yMSc38Ml/41RcJvFOPfGvsyiUp7/E18Kvu3JVBvic5LCNtT4YCcK/xFja1RPpcTqKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9975

This patch uses the newly defined helper mptcp_userspace_pm_get_entry()
in mptcp_userspace_pm_append_new_local_addr(), and drop local variables
addr_match and id_match to simplify the code.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 255cb733c59b..af9bd7950fa9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -60,26 +60,13 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *e;
-	bool addr_match = false;
-	bool id_match = false;
 	int ret = -EINVAL;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true, false);
-		if (addr_match && entry->addr.id == 0 && !set_id)
-			entry->addr.id = e->addr.id;
-		id_match = (e->addr.id == entry->addr.id);
-		if (addr_match && id_match) {
-			match = e;
-			break;
-		} else if (addr_match || id_match) {
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_get_entry(msk, &entry->addr, true, entry->addr.id);
+	if (!match) {
+		struct mptcp_pm_addr_entry *e;
 
-	if (!match && !addr_match && !id_match) {
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
@@ -98,10 +85,13 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-	} else if (match) {
-		ret = entry->addr.id;
+		goto append_err;
 	}
 
+	if (entry->addr.id == 0 && !set_id)
+		entry->addr.id = match->addr.id;
+	ret = entry->addr.id;
+
 append_err:
 	spin_unlock_bh(&msk->pm.lock);
 	return ret;
-- 
2.35.3

