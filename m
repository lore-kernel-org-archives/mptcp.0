Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2080.outbound.protection.outlook.com [40.107.14.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC962565
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 07:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goOMeDH5JVUvx7/mGtCaQffFB0rdqBMCAEa/XS8XAA6usNtBisK2bNfNOH3t0GHmjOjDgURPWZ+2JeJer4EcBgkCi4Wtzm1EZUhYCWp7PDwL89/RJGL4Lip/Zl0/b1UnPu8/ajK1y9EZBOhImZ+X6JzLwxNZoZuDn34K4tjGbEDE8Yeji0J6sXxzWWDM//gZeAagHwokp+cyIEgzQRHhCiIOfxiXulqCjYpduZNGs47I753dEGNyRMKeIc7ebclzOhxy69Yp8mRIlLd1gnw6T0S+m5xAFgSaLq+62WGJ62YHgnIWOZ9i00sGCEMcZakW6WIbOw5oqgisOCRyRc0itw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ap3GzzO3yAIhll6ZLPGy8SSdQ/TxCnhpuWTO6TKXXug=;
 b=cZwbQpNoDzVVjtgrCRAc3v0+xEnRYFkgcMyhVp76NVedE2Y4AmXw3JgjRMVmzr4Owk3cxsutGAf6UYerz47wUQjgHIr4prXWCTgpCjQ//97P+P1OAsOaQxiaAmdzSqxjLbepP7nMHo6NOBzU9mcO1sBcQbBWyW2vLZrk8oXn6zB/sgT4rQmu0laHk56DcQdLxaqdWfAdhn4kEMrjHqSH2p5stLMeNAEUTuk5epgEEAH7xJ4s1J1TI4T9cXplRXAG0wOhrQ+96ebnn55xxEOcarQPeUgh+QBFg67vL+o6y45T162/Q8X1B5W0ewGtfqUdznnEzkKYuiBTYyRLfuP/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap3GzzO3yAIhll6ZLPGy8SSdQ/TxCnhpuWTO6TKXXug=;
 b=gqnLhrSz80PbdRQBc40t5NKy12bDQwUP6F/yIUEPnSXlEwJPKIsiuJ6J3EQ+sOdLq6IdElRDJrZSFtu27cmccrceV66skiKIw6C+YD+ke4uimCJwmKOVj8TXdklWdbX/fSF9KH7k2HTpJQwUCbiONDulWpcAkwloOCY7+a0dZaof7LGw8tbbndcgy++AGAXLKFuI/kBwHbCqdRDXirQERdF3eu8oIC6IBquUaF90EZs3waC2qJNkF4FnvuvLtX8s53+GDbgL7KN3Kv3vThIjXVgjbr2FeLdmyxAtbI7Ee8AX/1bXE0rcp8d39siaceiFEOGeklmFIgbXg/CIuOi4CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8759.eurprd04.prod.outlook.com (2603:10a6:10:2e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 07:31:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 07:31:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 5/7] mptcp: update userspace pm subflows
Date: Tue, 14 Mar 2023 15:31:42 +0800
Message-Id: <07483b4044333a3d2d6de1e5c06a32672c54a24f.1678778977.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1678778977.git.geliang.tang@suse.com>
References: <cover.1678778977.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0029.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 75418b3d-c3b0-4427-6de4-08db245e19b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cM3SUCY0UXm1e3vRq92MrrOHVfuyFZbrUApG+PMWfEYK8bxKWMEEbKt/emIBUsDNFMOxxSaFhm72cctgUQAgyxiQULGMVn798HQioZ1VrykwU1umO7L3RiOmr0AiUkLtxP+Pb9EXMHd+k82lC+bDV7veQ0df+0+SRIovsejbXBptB+z++1RKRI6UWf6AilonrSOnbjCYw7TQnRRtFHtyVfMLzcUhsY+nWalwtc1dyxgCZGEBxWvBCLgW6W9NegB5DJRx88bjWpdSyWe/F1guO9nbv+LZLV02UN5oxoIt2xcW3Mw37Pgp8XM4+b3zXTYbfdIfx4kVn1mlzwh9cCT3ZrVVI6FhYazbg1yJusg3md/ZnY1SynqHa2xcBqgkQh/hcGPZ6tNYaOpDhNzgwMUJsovVvrXNFojqcZq6r78EB8KVRg7Gqkc+oPZPHX5jPpOb41XasyTg5yT3Zouz9P5oolnDYhC4wprcT4W66jNInlvxHViRpZukBW2R+NG205XpUJkD6bYFoaR1GEKxKdyTVQrnGAshoXjdhfRF1+y4jrm17rzJqQQz91Bcq3SXmNX4lfAoX1uOHMfSa/u4kVJm32xA9gl+Vjza9bfs+ANJdzDpXV6IzoYUBL2kMBy73ybUdZ8lw7zVuvReD7VfYDtMMfAg0gaQ2hK6IWtIT2urB9HTiq3P4OieW+YRWV2y44J4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199018)(36756003)(186003)(8936002)(2616005)(41300700001)(478600001)(26005)(5660300002)(38100700002)(15650500001)(6506007)(6512007)(86362001)(6666004)(107886003)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(83380400001)(44832011)(2906002)(6486002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZXZlA8iLbVAA1xwp6OD0quMIvHyYHC1O5rys+A+Csgj0G92GUSdtGkzfZMpC?=
 =?us-ascii?Q?tfCXZgfwPTi2jAV5uoryeoiOBgsOxvIqcdh4ftgl4bXkn2DEqTgXusRuMv4A?=
 =?us-ascii?Q?a6qCGvbqO7XiPI2yQXiOkc33tu2PyYVtV/MbVE0Cc2jdLkiMGqIPjJp6ceDc?=
 =?us-ascii?Q?Qw9xrDWk0s3JkZLOcUW4V/288V3qfnGhCdLLs0apCguDDWRB75T5OmPuLbxM?=
 =?us-ascii?Q?7xVrZTQAvcgOVSc+rptaV4PwwEdEidWaFa2hzGj4XiggwLSU+u9hyCVRO4xB?=
 =?us-ascii?Q?33h0dTASx4GSWFr528FFo9/scNgXMvXogyfuDvn2ZPQSqjl+41vJkSgn8OhQ?=
 =?us-ascii?Q?BLd3cne6dJ3uaBv8gSNcx1w28mWs2MVVfq3sBWqev5mew+0O8R2tkVME73Ru?=
 =?us-ascii?Q?J7jFm5jMeaP20yMubNEp1JZjVMpJ8Hlrqpd6Qlzm/bf6J2OvJfp5GYHBKR8O?=
 =?us-ascii?Q?Vcyp4tBcIiF1C7/rsVWfGbrR0jMe0u9SXkD+fJ935CXl6vFz2UazrE7GeDO3?=
 =?us-ascii?Q?lmWfPAgbgVwqKm5lYCi9KvngLn90j+wmmbvhwnBZ8+z7qffoprIQgZyFud79?=
 =?us-ascii?Q?L4cUnl/PTkS5yxW1E3oo+VBqsMXxKyRYyuXTh1JBcbYFOYv14t2JqaOyyojY?=
 =?us-ascii?Q?XDW3RKxEHbj9HAKl5bVaFJ8m0gyDgltDB/ipv2Jy8fnvieZujCaq0CsfCTV5?=
 =?us-ascii?Q?Mk6h5zi3g8hJI6qw+kGfdn9WrzYSbvTWxKPDTJDeemDo7VQBh2oKXiXR0rXr?=
 =?us-ascii?Q?PpdWnzfMTpVPkrLBvPH6QxM1Tzo95y2YJcgcuJCXzfa4dhWslqYpxbMl4dmJ?=
 =?us-ascii?Q?qrDkVWZ3B8IwVd7MO3uCrEM4qj0ISUUwYieya3jclC3BEOJGHHCZZKfrTcDs?=
 =?us-ascii?Q?3qPtlPKKTX/0O/nY+wKC7mT2AFAi4xdR55F5A5YH3HGyHshPaNrCc9LGrCrR?=
 =?us-ascii?Q?lAM05YZpzMyq5ZEN50EJRNCpy3b6rxyEVhHLe/zlMERiuXmyONEaQ8AG3UcK?=
 =?us-ascii?Q?JFzmzdofziv/oMzmQCL9CgpR8GVbBRJTY+YnqLLU43rudVyIptb6iUbS8S3K?=
 =?us-ascii?Q?SdhYZBOxjyCHOenGHVzzrdR3hmqRrUVcXzgjfeLRODFTDTGWlsBb+vwhf9IO?=
 =?us-ascii?Q?ycPBXoS7QAsx+IR0TnuMmoV3IGVMYTHXX9JxpKmXuhQXuCzQSBt2FbsKrC2C?=
 =?us-ascii?Q?PBRBb/nGpHczimi5/VcC32rVhTvSBwlLZ9q90iWqfAeU+9SL8tXap1RkdmHe?=
 =?us-ascii?Q?KVlbitb9QjYX2WODvB4yzPDCdaVwW4QnpRa3RVbLJruXdID4YovPrjkq8Joy?=
 =?us-ascii?Q?GeGCzVQZZoKpTseAeIuouKHS5iPu13Zx16BlZvVTnxJ5xv3zCJSWYgpS5fgb?=
 =?us-ascii?Q?1OnIevOmBvihAgtlbmemyjhByuEMWjlLAoDEmYlt1YdI5kny+QkrdBSkyhkz?=
 =?us-ascii?Q?RwOuO2FDatZ6y3nZYY0sUF6sovK0qSctjgAC4d3PsYTS33trx1rpDxa10qxN?=
 =?us-ascii?Q?itzbpglV559asl8/cyVGmSWOUux3wycUzPAt6tl+ZlVEoM7aFtT8MgWoVJWa?=
 =?us-ascii?Q?+zyBcJ5+ELk0IuR75KZJIGYgpU52QGicMlxvzJNmWrvEJpWMBOOGBK4op5xY?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75418b3d-c3b0-4427-6de4-08db245e19b4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 07:31:18.2025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PR0UMd43AOggRMMRrf6us8JbExI/0MHBPzxxClDnSQOpfBbf0Xk967uA+zMokMUFVhCw9jK1wcL88gflVnOHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8759

Increase pm subflows counter on both server side and client side when
userspace pm creates a new subflow, and decrease the counter when it
closes a subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c           | 21 +++++++++++++++++----
 net/mptcp/pm_userspace.c |  1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4ed4d29d9c11..bb01f15d8e0a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -87,8 +87,15 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 	unsigned int subflows_max;
 	int ret = 0;
 
-	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_active(msk);
+	if (mptcp_pm_is_userspace(msk)) {
+		if (mptcp_userspace_pm_active(msk)) {
+			spin_lock_bh(&pm->lock);
+			pm->subflows++;
+			spin_unlock_bh(&pm->lock);
+			return true;
+		}
+		return false;
+	}
 
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
@@ -181,8 +188,14 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 	struct mptcp_pm_data *pm = &msk->pm;
 	bool update_subflows;
 
-	update_subflows = (subflow->request_join || subflow->mp_join) &&
-			  mptcp_pm_is_kernel(msk);
+	if (mptcp_pm_is_userspace(msk)) {
+		spin_lock_bh(&pm->lock);
+		pm->subflows--;
+		spin_unlock_bh(&pm->lock);
+		return;
+	}
+
+	update_subflows = (subflow->request_join || subflow->mp_join);
 	if (!READ_ONCE(pm->work_pending) && !update_subflows)
 		return;
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 09b4b359d960..465928c59917 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -310,6 +310,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 
 	spin_lock_bh(&msk->pm.lock);
 	msk->pm.local_addr_used++;
+	msk->pm.subflows++;
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-- 
2.35.3

