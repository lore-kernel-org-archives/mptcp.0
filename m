Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE171FB8
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 08:07:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HB8nBrW3NObPnnzUsj8ka0UY2tEreMD2AmBwqNa5LpAaxbxqSQ/iO6goW05H0tilAMSqNpJJfDDewt7OzKEyhUBp+vd6x/DnvDWDWMDLRLt30d5mCAIXZLjzqVoMLqTGU05KvdCP34/T1UPKyGAaD5xxyGDCVV4I6tsr0FPqykLqfTVAAQ3c4kfpvrAQ/kM2c4AH0DjZouZdDZ25qQYAlPQ9EH6ceWDvRez1D1aBdO/ydyJQpkKlG+/VtElMsf/JRhcz70QWC7K76YhhI++jA9ql5FdUsJZUgzXwQPG92QaSg+y7vot9wKRaEQrsGKc7ztSaNBaUw181sfo2kWdjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KMFf07cIARJTn+RnGAjPTQJx+imKCPL9p+xlGtDCHo=;
 b=chLCLEikc6H5VlP2tJbYwZ0x0WPDSWQUQeOkyHnSbKdELahep1rx6v6ffuRs2+JA+qAqjdHsEEcVRAzt/PMrF3B/4rwsDnLI/9m9utkjNe0U6eCBnvy03YTE3vbeXgYCD05VojkgG3lSdwe/eR1PKuVoyArxNKzcrO33IgeTggF2m0S5oaZPkAmErB4wT/mXaUBFhk/D6MZXo4mgwQUW5x0ivLgw9xM06q1XaejJHpof/Msagows76sX+FtD9hI9gBi62rW1mtnAA1q2ZmMz2y5oZJwSZVFrMV2ROrOhvlKcLs7tmdJy528cF2EtY2nik2Lgmuqr/vcKnrjgZU+Vog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KMFf07cIARJTn+RnGAjPTQJx+imKCPL9p+xlGtDCHo=;
 b=Ce0tT6fjR/Pchcp2BdLvqorQcs3qvDpTDJ7mFmLG+tGDgTewbMpmPyhiOWK9vDKhJRaIUixQj6WjVuCMFy630r2lCi+UwAQQXLt36Jqhu1rYZiI5o/IN6RjLC6qZTk6uKHni/qOzogwiRvSS2wByQyJGPS94Hg/HcRj4C6PBGL0EdtmtPc7ms5vgpobSA0YXIpOcljMrvm7boyhlK5of+BsfyzTh7PXgF9rAeeeNcFk7npH+5S05dfbbp10qQjk5roPm8ZTo/SqJ9BOYmBCYMPAPgzc6LUmpuLw/BUwU9qiPb2xnNUL5LmSl0fSDnGR3KwogFaM2X/k1bWwM2qN34w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8075.eurprd04.prod.outlook.com (2603:10a6:10:25d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 08:07:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 08:07:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/4] mptcp: unify pm get_local_id interfaces
Date: Thu, 25 May 2023 16:07:08 +0800
Message-Id: <b757cd4da3d5519524b2d83fda4d0d7ded3c6798.1685001897.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685001897.git.geliang.tang@suse.com>
References: <cover.1685001897.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e5d1f9-cd85-4821-5cca-08db5cf716f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G4hwYblT5D7CsbeA9YT+qEaZLC6SVtyb6BeqEyhINgiI/Ht1a+DkEMlkQ1Qd/qew+VY3BoKQ0e4pPTdv9mAVMkuAOMiCm4rgzGepYSaUM5V2PSBOLKt30AiTqp9e/ubCwn17gBPVOFlkmGmbve8eu7p4GqEgDY86yIH9EGpOaGjAwWtuLZ1c4/3JOvSfegvvMIRPn2c10EyejhmkRpi2rTB+G8z4WHf4fA46zn3PaRaZmxQWgAmIO2KjA/pt/+0Hf04/zHOz0yLB2DrP/4RX33mto1TignX2PDsq7TCHooiEOqw8fNjfkzkSP8LZGhrl93PT5Bf2nVZYahUxAla0PMjW89Oe6CnfuX8Z4ccG5IVvcCRtR2pQsJoPnGJ6zD9LApX4BLjKMLfjHT0XxN96XWoluHNalX2FJ6B90qANA6WHnF07IB0k2zyL/EVbAmlSEXZ/Byfz7A//ssX+B7pvOiMCbGM/XOISOa+B0xRYGBYrbq6umgLqRZaj40eZ67LZ2BC/TxAQL8Iu7NFcj1dLFhPAz+YBNa1qjZQNBidBJ0DaTTm72r0upGiuk77uP6N7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(5660300002)(44832011)(36756003)(38100700002)(41300700001)(66476007)(66556008)(66946007)(107886003)(316002)(6916009)(83380400001)(6666004)(4326008)(6512007)(478600001)(186003)(8936002)(86362001)(6486002)(2906002)(8676002)(26005)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ptesvgh3Huemwq6shcDQ1RfJjKZNSf1d8uzAMEY4rIAwCrOS5KUkz+/AB0yT?=
 =?us-ascii?Q?YbZxa9SVtDQRHJXt+Eq2qbOcu7CCAPHocrsQdx2c24/ysXaC5rWyKs2IJybr?=
 =?us-ascii?Q?62DlNwSoHEGhV7dssOZu+RqTF1Mx9QEDKdxsTn6kuH1SNzyi169++2Jq2zRp?=
 =?us-ascii?Q?6w6eT/52zCfYDB2LpW/u1Ik3yQRiA3tinXNsve4lc+bOqdTCxeNYu7B1M6jJ?=
 =?us-ascii?Q?e0Uu0atETnUS+CKqFBC1Yqx1GhvwtfIgumL7to+GAofOpBP/ASgUTgD8RUzN?=
 =?us-ascii?Q?r6gzk7qPff8KxhPVSJRkibL62eo4LITJ5MLq5tALOWenQwKyetVO4/obYR2j?=
 =?us-ascii?Q?Imh3b5j2e6nMnfxqJgjTaoVu13qcd1WtJmXRw+BHtAc69iMMpqbO6VJUzl7h?=
 =?us-ascii?Q?kAuytsEMMWiSlQSQf8MUV4UVzWiqVZhwYn40MkPrgu27IuuNPALIP+8nLier?=
 =?us-ascii?Q?sM0HjvVN2/zdurOdkuKVlbpc9gpAp+UT7edpXlbT2+ImBouP4aQA3hiOTdP2?=
 =?us-ascii?Q?2+dNi7ZYBo+CqZgSWHNb5SqKTgG3WW9AUPaz/IWoOY2hGhf22ggBlv66zGh3?=
 =?us-ascii?Q?ceoMqtPMqTdNyF96MMf3SPbMN03KGedV0ZDhnT7bE/6VH/a8JzOF4+cfiMNA?=
 =?us-ascii?Q?qnRvJgRGeRxcB/1zmduk1eUKgvN2KZ6cSPROS81hmMxlFjz0DFUQzoSyTTGz?=
 =?us-ascii?Q?trMYUIq8VFNLeMFHQabtJiwE1FQ23RevjJUpLSnTteay/qCaa8uaatOnxIv3?=
 =?us-ascii?Q?4QDaXRwpMswa2XOiKQB0UfZhtD/VJ2S8rnBpF9yGKM4kfgh4rFOejnvxQmMF?=
 =?us-ascii?Q?obFytp195gf6ej8rC7o+CniEmp3QnRUtPvM2o9/Dr6iPwIdJy8zBaGDhl3vo?=
 =?us-ascii?Q?IeOyR6DMMjtz7uCEdz7bcrsp322pzRptMsF1DDYLIXsjh1WcETleY8nFN/i7?=
 =?us-ascii?Q?OmFhu5ZCqvev9ik2IbrxelEpBwP7cBnZ8lU5Fq+PTW7eDbZ0ekXXT3t5gH/I?=
 =?us-ascii?Q?4Rzo+HUhkUYyoKCAPIrQ3PRW3IbHUa7CETNZOHFgICIBL5vrq+YRcBtbVvwM?=
 =?us-ascii?Q?e3fcv0ok7nmq5WUVoN6eEh5WU1uzCk5XOB7OC8XUpGGWK3/TXLN+Qt216aNn?=
 =?us-ascii?Q?kMQ02rxPVEsHRTgLARcqbDWCsmC2XN6lIfRkZ1UX+ioGXan4iLHg6Ni1mGq5?=
 =?us-ascii?Q?NJyz2BbmzErXoBwZ7y+pzGn86wneNcq/lka8xChwL2otmVl27HEiauySnIXc?=
 =?us-ascii?Q?dOQDJYZlCjUUM+c3DjFjC19embxMTwVFZbW5f11gXf8TqqLpAOcPT23N6hNf?=
 =?us-ascii?Q?CXgXmu3hcjQL+qGHzb4BFt8ljGUh9YkGpRjm6Tip/A45Vkbp6iiPETHpYcDM?=
 =?us-ascii?Q?hzKA0ONKNZ1Twl3k7sd8fOJN05/LRcaQYYYKUTJuXWGqeMcpGwqYq8pLfqWU?=
 =?us-ascii?Q?XZ18o4P3hRROClt2wQ5uvbhWwIQucZjZzP/rPzJXD6WJYSBwi6kGAOtUxuvo?=
 =?us-ascii?Q?v3ZIWSQIXZAcFKgsnp3t5iYDgrblkSGvgjNhO+79zXiiz+nrZcqaBdQTZAAy?=
 =?us-ascii?Q?BcJCSqel54w/WVSLtIPBKGm1i+UYIVaxnB/1/7Sn?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e5d1f9-cd85-4821-5cca-08db5cf716f4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 08:07:31.7858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KX8mP0nsoP0dck+PPXS0OSzaNsTF26/JgjOQ8IxFhIwxX3ZQYwEUCT8NXFkcQE6PR1yx49OfwMTdrvUVRfoHLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8075

This patch unifies the three PM get_local_id() interfaces:

mptcp_pm_nl_get_local_id() in mptcp/pm_netlink.c for the in-kernel PM and
mptcp_userspace_pm_get_local_id() in mptcp/pm_userspace.c for the
userspace PM.

They'll be switched in the common PM infterface mptcp_pm_get_local_id()
in mptcp/pm.c.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         | 13 +++++++++++++
 net/mptcp/pm_netlink.c | 10 ----------
 net/mptcp/protocol.h   |  2 +-
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e7f944d09fcd..e37df2f45c70 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -408,6 +408,19 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
+	struct mptcp_addr_info skc_local;
+	struct mptcp_addr_info msk_local;
+
+	/* The 0 ID mapping is defined by the first subflow, copied into the msk
+	 * addr
+	 */
+	mptcp_local_address((struct sock_common *)msk, &msk_local);
+	mptcp_local_address((struct sock_common *)skc, &skc_local);
+	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
+		return 0;
+
+	if (mptcp_pm_is_userspace(msk))
+		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
 	return mptcp_pm_nl_get_local_id(msk, skc);
 }
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2f58ab49512a..deb097f16abc 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1056,23 +1056,13 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_addr_info skc_local;
-	struct mptcp_addr_info msk_local;
 	struct pm_nl_pernet *pernet;
 	int ret = -1;
 
 	if (WARN_ON_ONCE(!msk))
 		return -1;
 
-	/* The 0 ID mapping is defined by the first subflow, copied into the msk
-	 * addr
-	 */
-	mptcp_local_address((struct sock_common *)msk, &msk_local);
 	mptcp_local_address((struct sock_common *)skc, &skc_local);
-	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
-		return 0;
-
-	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
 
 	pernet = pm_nl_get_pernet_from_msk(msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d8c9035c44fb..58989303470f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -933,13 +933,13 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
+int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 				     const struct mptcp_rm_list *rm_list);
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
-- 
2.35.3

