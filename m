Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2083.outbound.protection.outlook.com [40.107.6.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592B111CA9
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhK4gLNSgTIeiDIWiF1BKDp/rkZWxK9tGiXLDR7kMyO7EmCuxQZaRu6K9E1HvNEK/wKRNRQYqk30xHVqb+kAnV9UUKPZkYhq3IBPy3E71of3NCBsOZL+0SlcPnfHEsiD++Wrjs2s09hN5kA/LUcTUqzDDLVvX41tz+raE3u58bggkcvpLiVJ2XSD0qX7VK+1ytvJxSIid7X6hJaoD/dXrquE10tF7/VK8XChHsX22kESHOotUQOtK4f+kNqVRm1A5UT6zctI2ADFKZCVC5igO4f1+eXp20j20NkX2aFtrLawek3GvPdcGUHszEhL1e+Fb3vuzhMLgUfDONb5iBrpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yVEgpMDaNofwmXaTQ1+ECzhm4b15i472fTOw/cwkJQ=;
 b=ZVZ4pXO7SjClBrlrId0M+6IIHtKfg+HkYRs5nwzaauj1yMS0xVJtrZpB6T87OsFVsHOCLPuDOxGActZCDkogG9TqDCPKRU76orNY2RIMq8OgkBYFhm9mEaSUt5lRt0FBSWfdLVA8QKQnBGeFqYRMM+08FXPhcagEX7QF/CAcLGh7lcBPixFRvRC+5KOqBm3dzpo5ejmoydZxG/HNysQkoefw6UP77no00tx5NsHKHTej+kGbo0cQp358xVOeAUzfaW5FoQ02heWQ9HjWiFSpoMDyDZp5GVdciezAiYPzLsClpMn/yS86V21hHjuv/5EEU8LSXsmcpSWKRAoLHRbxcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yVEgpMDaNofwmXaTQ1+ECzhm4b15i472fTOw/cwkJQ=;
 b=scotpBizvGgEYeZzPTzSUET2x2Gv9IaVQBiFRplz8EQnrw9VcbEOF6CIF8N01LF+xD/UiJyIDyFbZldYo1fSBn+CB0UWtZK2dLv5GUCQFvIwR2PkCmhvCrrvM0ZGwgfdaFaC+pRMqXfmWtXgFSjPH7/OR81En/6fYpqFPj5sPGxx2nzCORr+bgnJZAf9bz9NamPpsg0sknEp3FT4mhagFPAbewNkrNBizuYh2jJufAtbU0jxI9RUibF5Pq2yZn/W5qOqzHHZX0KF8VddUYCVmnOWjdNg9jiUnPVrVroSVeTP2Gi/ekOrNzDtOWiAEvHC5eZMFyDywEm1rLvwv91wMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:41:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:41:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 01/29] mptcp: drop useless ssk in pm_subflow_check_next
Date: Mon, 25 Sep 2023 16:41:40 +0800
Message-Id: <e5e4fafcd4bade044275dad26c02423181bffc2a.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::18)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 9185c1c7-43cc-458d-f8dd-08dbbda3342d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AaVrhIVwumxPo0kOOTlx1A+8OYErfIzf2DO90Cj3Ufn/1cNzWbjasx3EBLyYTSwaB8kRBcqUXfOZEsmrWV0jCPRs6G3K+GxiTxN07UkuEwtQiRNML4LdCr9HRpKmaS6cj3Xe0Y6HNNjs+DAz9547Tf6IENX8S6HrdteqokyoZomsI/h7Ms3oDSzMIOajtWKfaOyLSExyWfiAG8HcOILAs3yJtXKmjTiiC0cQzZZrnSPXr9ELpWHFD0cx/3fLuV7rd2RKqhMxr/2smmYgtmboPuok+qw4MPEDUq9HV5sRNA4ftth0yo6fv2HeMGEaV2NinmUrY5Di4FSZEGl1BzSd0ZgMYNx88OoCaHO1J6ddmJLx44Erh8KwQ1OOyaSkvCzU+lJ5V2SpZlbJmyEE/e0jhH/1JSOkQbl3Yuf91av4UQyChsAPWNIsnzNlM5FmqFjCb2XMqWbPMM9EGjONfc3bl/GPS06u1osAc6qbFFT+iQ+PgksqcDIUfyogVX3ntsvE4We6BUgrm7M/iwWwBftOdDtxD8DQ+36lmEN1r/trgV72rm3JTgW+7EtYfLQEIPiN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39850400004)(396003)(366004)(230922051799003)(186009)(1800799009)(451199024)(6506007)(6486002)(6666004)(6512007)(107886003)(26005)(2616005)(66946007)(66556008)(66476007)(86362001)(478600001)(38100700002)(83380400001)(2906002)(8936002)(8676002)(4326008)(36756003)(5660300002)(6916009)(316002)(44832011)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SyqbsvkdeDLwBpsgAN5ZLUWC2enT6B4UGxBu/8tMz6QdjeRZ082AcfaaWppI?=
 =?us-ascii?Q?kVdvoJynS0rjvEqbkSdrr4YHlUGvPCLKKojaFMsASLdiJxIZsFn5xN9ciXD3?=
 =?us-ascii?Q?BaVYX3vaMxsFLRzGzz5Vqxoxl2E3+0cHJWEhD42tiZDmXG0nxpemqk399JDe?=
 =?us-ascii?Q?FYRn1DrGl56YEsSks4ftPmVlBLbf3Afvc9b20yyhn3ZRTeKIG/y+sSlG4hKL?=
 =?us-ascii?Q?ol8dx2x1N7UET7myY5o20QES9jp9fP2ul57MiQ61aAPP4Zc1OHHbqUiYeTIm?=
 =?us-ascii?Q?6x6JVOfEp+POcVzgumr2pywfYKN4zq0PbPGEDuItLB1OEbH7teLzIpmwA9Bh?=
 =?us-ascii?Q?Zl2juXMP8JXWiruvooqgVCcnHhwKMTj60Y092VnUOgjwHn2+wd9ZP+lqKrPJ?=
 =?us-ascii?Q?DagUMekHHUR3PZ4k6GVlN1k4fYhlOEBx9zoVHNPFxfs94jpatg75nnTreknC?=
 =?us-ascii?Q?jQEvMcZ4ilnkBDj7s7kSN7+UXxhlR0NdGeiKBMX8UURKyoXOy7mFf9zqU22I?=
 =?us-ascii?Q?29MRCYOcTdJ8DEgr8eY8AO3P94faOyv4I24nAknGRKKFFdXJo6Q3+ncRM3WW?=
 =?us-ascii?Q?PxX93JFe4M0fgqsrEO8qyuUd07AoJyoFHZvkDzt33BNaHQcCN+YGGmtNVNS/?=
 =?us-ascii?Q?JN8o0o3fIl9ItcfObVKcFSdOjO2PIgRbnuN9eZTHq2p6SeCAm3IzG3c68Q0E?=
 =?us-ascii?Q?UNutn9JH8XcGCvO1Iy0A/Sbk9cnR+po4SG2r5GeeE9PxFmo7O5BifZPloDxJ?=
 =?us-ascii?Q?Z7TTeprFcPxKj4a7m1ZJFss875AX8mE4w+5cH9SjYvzHfxUa2cAZ6LxVQzuL?=
 =?us-ascii?Q?vnT8A3tSlffTH4DTFRFjdX+M1ikFWNHxkURG8sSg1JgHCmZZkrMwf2jVe3LH?=
 =?us-ascii?Q?+nDK7tPtLJh7/GltaF5bugF0Wkr8iwc5mT4LmB+Ya924DgdY1dY7tX6cGwp0?=
 =?us-ascii?Q?JWDTUyi3uUkcBlczvf5ZYOvv+HtLBbYAlS0KBsKdgJjVnAA2hdByZgFWXDtj?=
 =?us-ascii?Q?pf1PLD8H9pcb2VHbC4eYw3gZ59f/i53LGfgidIYj6MX6z2Pydc250uhLUdcA?=
 =?us-ascii?Q?6U8UBYmuiZCliH9B8y7BofiKHdWxfJdrQtNaLpCoDfZsUIXinwl5IFPT7nM5?=
 =?us-ascii?Q?5sulYAMf2F9KWewWECfCP4rL2+BtaoiCljVHm7oWVzYMKGj1lHjVZIuTNKdX?=
 =?us-ascii?Q?INz7gHzhYXJt7eQmzurVnHbny4Cu5lr39MtM6SHAfFQI2qzpw3WoLKibkIzw?=
 =?us-ascii?Q?2zdbGxKnpQ4904rPfLKJBCORqK9m4m7g5LQ9XJA6yzsGdO4oKJbLRYAGp7k6?=
 =?us-ascii?Q?TXin1tiIxFweC4hp3cC8kdpZTmLXCpC63t/JHJ/TkWVhY6ktJOe3vOPrDs6I?=
 =?us-ascii?Q?0pR1CbMKCEftmt3wbVcp3Ttpx4Abkrklfbyo+uClDEpg8g/tyXzvnEimAJMA?=
 =?us-ascii?Q?J4KQIIoatSdIlPrmIdgkAYH3hwP0tOXU0AmvIQe1o+oMBN8AqpkD0zFq9lLP?=
 =?us-ascii?Q?/yVgitVqk9qjWhKcN9RjsWmfnzSqYIi+paAxJFoRQWLAx6FpFPUzUVq3fyNM?=
 =?us-ascii?Q?wXD5BZ75APWS4gH6qHqNbacO3sp8s5YO1WRkmWx2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9185c1c7-43cc-458d-f8dd-08dbbda3342d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:41:25.7058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSmiEoBukzSZlX1Gr22UWdjX2J3LfO3tgGTz6N605ZFDUYm21xDLbPcMvFeVXly/Sv+kMgk1tP+waFda7na9wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957

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
index 6f9e116598ed..6dd1ceaee257 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2480,7 +2480,7 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	/* subflow aborted before reaching the fully_established status
 	 * attempt the creation of the next subflow
 	 */
-	mptcp_pm_subflow_check_next(mptcp_sk(sk), ssk, subflow);
+	mptcp_pm_subflow_check_next(mptcp_sk(sk), subflow);
 
 	__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_PUSH);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ce4f5fad1202..37e38fe23dc0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -893,7 +893,7 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
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

