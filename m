Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988D31107
	for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 11:38:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvBbBZjzal2V1B1KMsRYXD2apVtDk2VqLdvEo6n6Z1+vplRxm9u/KBAiwo0HPTJy63TD6JYlLBcS+KTALu0w1/saJoYLV2C5VH2ZjEXsS8sFrWyGexR8hlQdO0RWBcGT0NOdiF1e6igmR3f51j+Lzharcmwt1Uct5xwwo9EHeZZDpgYsyiJ+zbCrn0o9DHgS0jP3ksfQMP/EULeYiYk7AOBlJ29QF4wtQJMbkndJDXMDKdmrca/CpBJVC4E+IO2MmPFwsFAspYVOLtZIK01cCWdsKJIWfMfVK3lnEwmyQfJC0iyeH5cN5elefJbdSpOZC9ulNTuBte4ASBjetbBVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldM+zhg3ZRaNH60oexri0cN4gapaj9rWMRpDBoFltN0=;
 b=W5KDoLJiABDey99mos4lCmEVcYiTd8vFQce6k0sig/Exky/HbJ1VqV39c0OGanXyaHU4VB880HnmAFVBgLJPvjBNLU3wxfn/NdooyJ6HgvpbJzpB1CWOBpQwhG7vcJ5pT+/Nf1bu10X+u20epfXP6cSxIlYBYYCtTi8JXCzGYY+PN5Fjyvba3vUkstQ9aAA1587RWSgwQ9BuAJPF+mID+QjD0yTi0iQo8AIcKscCW3EUKbxSDqV0wYMIcoV4gppGh9hgGTZS4HTGtWaEaeXAJlXdBFUCR1WPZtJ4GbKm2NobNT3ZFH62GLelv4ZvNAFkTLWoYxmMunn3RXFSuZfpBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldM+zhg3ZRaNH60oexri0cN4gapaj9rWMRpDBoFltN0=;
 b=MX7VkZqyx7nLpcLifj8pn0GhGk3+Lj491rtuTfPCFUoBy12y8xkYNeXeEV2m90u6c9gEqZUFfMQHZ7BIseD6UVgCmTIr5bfsDyRJMQPxSs5hr6NiOWHx7veKdefLBi3N4f+ZWRp9+xBDP+vMkUd08Nl5iOPbFXyj1yvRAgk0sBM2bEC6kt+xS1zmq8hZwOTwXqJAJnAvZkjpW076c+a/EtykSk6h+p0mYm0Mk62B4bQfZdskuBadROwhg35jByyaXgoXDzipKw0xK/S7Ot+GZAXB47UGjV9OEpGDT29TpYh7nDAUnbIzCNysN6LqYoyPyPQaN6YnFRqw5mgKwwOWVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Sat, 16 Sep
 2023 11:38:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Sat, 16 Sep 2023
 11:38:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/7] mptcp: drop useless ssk in pm_subflow_check_next
Date: Sat, 16 Sep 2023 19:38:35 +0800
Message-Id: <4482c81cd226e1670b399ca24a2262024665a402.1694864093.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694864093.git.geliang.tang@suse.com>
References: <cover.1694864093.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: d09c8b08-f6a1-4f06-e06c-08dbb6a963bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qm7uUtiCOaLdiKFGkhJnTvEq12YJfZBJavCecfohjwoJwRLCWbbar5OVrHlI7JRqsvRRDwkC3+JKvfyMxtSuAhZ92sy7ndlz+9B3SM7QYzaGypZQOnXeu8B8rKFlVTsIg2Ijrj/hbaejbTX1A7gsW0MNaJhZNFZhp3o0ilD7C4VAEEty506JvU5wM7TxSU3X8CxJMl+IF6fJTXLQZmY5VfUsZoK54ns5STvmuhMLlvSdLDdwPElQ5ur1nmh9IdSfQU4gz7hnqLwgE7k6Wf2Y0879V8hiT8dOqHCX9SagUNyt5qWYQ9QUN/DkDIjt35rJX7ZDNwnvtyvUoCrV9kw3050+4Ema8hZtP1kvw2msZCaJlAnJxvBaSW1HNs2UzHmoo7nCKow19aqC6MIszG7suzns8aHuTp/1BcsEIdN4Yxq3UJtlZSsR9jJsWxlmcPgMGOT9HuoM7sKYTtQ5Tc2uYfP5ad9TLPpJQDvI/7e6E4EIebRzUyQTRQrADTNhDvKsOHBLGJ80wzB50zwPS7F/eVlgAGgM6da29ZXvLAAkicfs5hCEw4C7B2JRIMH0an/opqCapYtIXWz9f6LgrhlE4EmBwW6kKBz81fvY6bEZoxI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(1800799009)(451199024)(186009)(36756003)(41300700001)(38100700002)(6486002)(6666004)(86362001)(2906002)(2616005)(478600001)(83380400001)(107886003)(6506007)(6512007)(26005)(66476007)(66556008)(6916009)(316002)(66946007)(4326008)(8676002)(8936002)(5660300002)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DUPSERYNU7bUrAcBXhUfdggT7iA5LV8IA1/pKtFwoAWeFALOmx37oNFL03ss?=
 =?us-ascii?Q?FCLhPdUlHky7xYI6oPQpMBxgEIvKMIYBngW+sANyUFMXEfoHxp1rMOZ1CbdX?=
 =?us-ascii?Q?CfyaSd3HKuMTvGOoqHRgFreAuw8+uyjiNS3WKT1a7+LRz5UWm5eCC2n9HB1O?=
 =?us-ascii?Q?zKKQjwqvDy/u5GYSWLpQFGw+0CynwRp/Qa/kcpGeA/YPAL7RxT9hieEvC5Qj?=
 =?us-ascii?Q?VFSwetxJG7gU5tc+gnKd+WROL5FkiNJNWLecJ08QISvxs+frAEwwRNbMjKfJ?=
 =?us-ascii?Q?ZRKYMazSUoE/GiI+QaAkRA62Da5JpIo+7nmiZspYO6BaMzG/AT9ux7C5Lcfr?=
 =?us-ascii?Q?+foYDdazf7s66FgtVlthJKFvtOYjt0ln9pr2GPhJTPRkUwgFyYksAnqwYbrr?=
 =?us-ascii?Q?MprJmTVA7guuZpj9z54NcSZQlbGk9ePz56PY/5BT3Se5Rk/G4t/OF+K9z1nn?=
 =?us-ascii?Q?dwAXPICupeIINXfsp5DldgbjOAh19U2VPMdixIfeSUD5elgwv101aWyhpCUw?=
 =?us-ascii?Q?8XvA2Un1sXKLh54PXm9aQwUkVhBhd22u9P80GrEa8P3MJX8YdojgcoZdWhLp?=
 =?us-ascii?Q?GvNXsZKnqkM6LETRb8gXRh7Tj8uQQcwjSqiCQaWk+6ihvlstWyxjlYfUup7X?=
 =?us-ascii?Q?tqMmlepkwwamH7tVzaDqGzhdQHfoVOshAAXh1q80ypMTRHb4wdE/r0QNGJqQ?=
 =?us-ascii?Q?B0qsndMSuPPcJyb/SltKBznGZs/WKnvSFi/rUgU/+wqZOj3v8GzREbN4p2ia?=
 =?us-ascii?Q?FZ2l0hIfivQJSWNzUOpkI0b5t+dc9wfd+NF9GfxWF9PrlkUaFoPQAoA54f1k?=
 =?us-ascii?Q?TaywEeYffISpf6rNLrs4dS0YOnPkQ0Azkz0ocXo2CeCmCaquLJG8Fkl/NH76?=
 =?us-ascii?Q?IPC4YKMNvjm3tdAKhDGEbCK2tjP0nWSWkS7HLPN+qrqyramcLkGY+7lLEwRS?=
 =?us-ascii?Q?rKmeVsGsxjv1CSUN7GoaSVDp5Odn3h2Ph+N7CHKwbyt3zVYQSXIho5iQhRfP?=
 =?us-ascii?Q?jSK3G0aq+B9XJrXTQOTeZQ+DXFb3h0Ighxi/SyVYrNYM571+t75iwpcZBwA7?=
 =?us-ascii?Q?Q4ZBIueDntAO+kYH9tpEb+NrEqlcMUI0LaNX3k16UqljOd+TiBUXceHfMmrT?=
 =?us-ascii?Q?dMk+qjomgysJKY1HOyjnCimZSuN9/U9bxaRfUIWMi9sQ5sMc9k7/LluCq5vp?=
 =?us-ascii?Q?WJE+IcTO1HVpomUo6f5EpXkj7dZE6TzzuLZ1SkeI6KFMeDETCBstkNGX9Vrt?=
 =?us-ascii?Q?5LoXkfN14NIZSUMvbZk7t63Apl0598rWr7Qi3QZNersRG8PriiAYV39Xdafk?=
 =?us-ascii?Q?Rl2t7rh0eTk7hMgLK3AgSipqhaP508H86rT85jeE4U67QhKJQmVAQfQezcmt?=
 =?us-ascii?Q?FUgaeo9ET6B04hSTHkjqN6O4OSw29etV/Ve8V7rebD9Z5qwGHeLHVb+YDDfi?=
 =?us-ascii?Q?RXtszaUvbkIDR9aDHlzWLpsY2pH2uDSNqtHBzKPcvhQoybjLienm0pEkbYp+?=
 =?us-ascii?Q?0gcY60J/pXPdrcSQzdRkUWJSXCO4qPy3hDunhscGv33sr594Gc6JV951HkEG?=
 =?us-ascii?Q?J1MX/MCI+keJ1DZ8+kEYolL5wt7NYYyO1Ju7CF3h?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09c8b08-f6a1-4f06-e06c-08dbb6a963bb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 11:38:04.4959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQ+14iptvEJa1e6eIw+VL1haoG4EdAyXEtSy0RvEdXlGQ7N8ujebAE0birK/1YvpMrVecykM/PxyO6jPpSh0Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371

The code using 'ssk' parameter of mptcp_pm_subflow_check_next() has been
dropped in commit "95d686517884 (mptcp: fix subflow accounting on close)".
So drop this useless parameter ssk.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c       | 2 +-
 net/mptcp/protocol.c | 2 +-
 net/mptcp/protocol.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d8da5374d9e1..4ae19113b8eb 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -184,7 +184,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 	spin_unlock_bh(&pm->lock);
 }
 
-void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
+void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1a0b463f8c97..15cdcc0f03bd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2467,7 +2467,7 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	/* subflow aborted before reaching the fully_established status
 	 * attempt the creation of the next subflow
 	 */
-	mptcp_pm_subflow_check_next(mptcp_sk(sk), ssk, subflow);
+	mptcp_pm_subflow_check_next(mptcp_sk(sk), subflow);
 
 	__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_PUSH);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3c938e3560e4..f67cb5596e41 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -843,7 +843,7 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
 void mptcp_pm_connection_closed(struct mptcp_sock *msk);
 void mptcp_pm_subflow_established(struct mptcp_sock *msk);
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
-void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
+void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow);
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr);
-- 
2.35.3

