Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6201E35888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="heigmVA3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPVmAGOFGtxhalptYYCHoJfiEWYQar1eIM7wFUGR7Rece2pfEdZOdYOw8Cd8e39qax6XYE/POBTvv6kwSagZK3bO8TYE92XPGWxq04rtjwEdj/DJRCt/uyEdgy3AvooUR6JotAHuwsODdXtjr7jVJVkIao8Noc1vA3PnXUIPz1g2TgvNF4SAE8nXcK8ovm+oSQowGNPyw5rsqaOGgeHugpFhcvGUi594gW3XAett8SyclbdJGwvgsFP22IommdQVBR+TDXWXS45aJYYrIZy8CPj/kgrjZdSpTYZGjh7EtW8dVdMyWN2jcZF3M4izLNCWjrACfa7ST355y0VF+XrAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eI70D7SROC7m5ZxU9wMumEUgLdE1slM2yKP+UoKBM0Y=;
 b=AZB92mm7Mv0G1zO3xFSYaoi6y7mzRaBu52KJ+bKWswBQwUSad9677hXv2cuVLVUwcMZiumjwLXeV21QR+eZ85lRBMsClrEE1rDMC1I+pr9/8eo/+G6N2cEndZg7ElzncflKPi1Ee3iL44ULps0EI96JLOYVaskEbTHkzsIPzkPCSs/MPLXu8XR+YIWjsJBjKXOeQUnZxb9ux/vmGNr3iORd1M64aiH44gHqy3925ZrsHK1s7wAWQ7iAV8CCO/x9asbhgmHd2EHGxzgRTCSJxKGKrLMrHh+hXq1pYgukMrsLuQ1k82Px2MyPGnvhpokPacIE2Q6YptekfWDbxNOT7dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eI70D7SROC7m5ZxU9wMumEUgLdE1slM2yKP+UoKBM0Y=;
 b=heigmVA3mNZmabCYsESnFYZZX98Ud1BcKt7wb46jp5tx6Z+5WQziG+EMhsuTawPb4LCQ+KQQCjoT3Voa6YcyfCh50hEZgH93HGJWPNMM1WFJPggu2rpndtZG4qyHxu06UumpCXDAbj1Q+lXwUk7f8RQF2sorYAsSuOzbLpCF1HPrmCGV3Mn22ipSiOVbxmsyLvRfkNXFVne3Zrq4trJFj+8FIj/Pkl66SjCJw7k9k3v21xuu+7fMDzcX1hCoS6E1APrN07BrrodvuvZI4mmw9DSSzEIVafrZUzq/3XtJy05WYsUYXHjeoIuiEnctQ3xn+1weDKKfMYZOjdKN7Xtc/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Tue, 28 Nov
 2023 14:24:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:24:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 19/32] mptcp: add a prefix for free_local_addr_list
Date: Tue, 28 Nov 2023 22:22:12 +0800
Message-Id: <90d783cc38377c80863d19c6cc4b7e14440b0dcb.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0101.apcprd03.prod.outlook.com
 (2603:1096:4:7c::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e0108c-d3d9-45ac-ce58-08dbf01dac27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6kVTqOTN7zxlbihQL6DdW5nFnzQwHqTElfTSK0L8h9aR67GSrbUwP6NooXDch83EWWWsHRkOWwYvJsEc9cIdCNbnr6UmPJvZ2M9t5ajj19uGbvoaKzTTOHmlLBMzpmC/hltp6ye4WfLzF0rqgG6L7tyB9FsqKia0yI9MpSBx1yJujLJfy+x8fradDERNugnUx6AXTbr7tvwAIQROJe2wIIMHQDO4PeufCgt1FQazaALaxPOafehOkhICHfyPhu2UQLraigmEw+MPX5LWVhlf1cGY3+ivfEbVrMVk343qRoFeEhqWKI1h0v9U5+NAPvylE81SqAqzH5+N9TecyD1+n38kA5sbpAsNbXIZFtpNtQZZk7Fo9JnKkoemWhyqjPGvHAP/8cpTi4DMJOK0M4YWuRL2aD4H0sL7XGmns8gxQVktVwdKfeNl2v3xVfhZHe8cNOBM7vxq6HIm0RyX44FmikiMI4x508rdFwo3AOQVTytPe4yxWvmumI60cwr6ZgpF6WwtIIrTJWFMB1aMh+Ip0Gp34wBwi7JV5M/3EuPHnRH9pv1fjLVjsFbFCBVdZPhr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8676002)(5660300002)(4326008)(41300700001)(26005)(8936002)(2906002)(478600001)(6666004)(6506007)(6512007)(107886003)(2616005)(36756003)(83380400001)(86362001)(316002)(66946007)(6916009)(66556008)(6486002)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qqH3fu9o3PH+xcQVbTjVg9CDp7H8vK6O67AFNvaw9AcpYyFUkiO1Ujj3CQY1?=
 =?us-ascii?Q?6bIuNypoQ5yR6Zk8fWWBDcLubgtNTiM21eo6j2QWy05+Wlh0bUGxhLEjRRQx?=
 =?us-ascii?Q?lAhNeQQZvepz9S5cnzcazkcPT2r555SUWw2pFN+ahNTxxo7EIOUpDaqxJdi4?=
 =?us-ascii?Q?1vE04Prjr4cKZfnwUuwvDKFNqgYXgYlO1NimAdWXfJAaYu76T3jDnED/AuS4?=
 =?us-ascii?Q?0hORHw0CV8V5cU6jhogK5+HdfgD4wWxYCdiUgN6CfmLnqB9tOtWCnjWL+bCx?=
 =?us-ascii?Q?fXwmZ4Nl6yP9owcpPokRd7AYEXusHzvhy+gKTsEYSYYvBMDOqaDBXUFcKH/o?=
 =?us-ascii?Q?fVOhaTzJ0YuMPsvXgYPEgJ9YyvRBr/hJuH4qHl7oO+a4ZLp4UBQzlccnzdrA?=
 =?us-ascii?Q?EXlku8dHfGrGv5ikMXOLZIZvpHOYa3O3tcZMuE3/SOR78XsSFuXbsTsCyY+6?=
 =?us-ascii?Q?+/mrCzgmabQo2bK92jE58Y/3WOSTgSNDz84xyXFnydtbfIHa1EwgKwbD/mwH?=
 =?us-ascii?Q?oTpBIOIikttNZrnMC1ybVBgX/osiEK6DZbvouOkv0SRwroFY1zBbxOHJ6LSR?=
 =?us-ascii?Q?JODKTJwDtM5vy6Uvbvbn6ZwIS07wmkWzR1cC6PdXasQ6VmodSH9E8y05QjFH?=
 =?us-ascii?Q?Pu1qrkIPInJm6Dp4dsXXZRDzChZNvsnZy1GUhwIOgJ1bD16DRnHcl2uwpNLr?=
 =?us-ascii?Q?4ts8bIKWBFCGd/IX4lzzaBBa3fO5cLZfNGlg9ONtUTfgg5oBTBRIZcKKYXti?=
 =?us-ascii?Q?nshmvsZkpAo1QIzJD035ktDViM17bqlYTF/DZh9sjaeI9gzjJ9tYWlhOqJk+?=
 =?us-ascii?Q?TE7H62r8npbwT6NfQTGC2+eClG0+8s2ssW5kBp5YtQORZbijUqV8iqWeJ00U?=
 =?us-ascii?Q?DY08WJ53MvBOneDwlyVXU4UvMtymIiEbXp1n2/9omrdOdbNJUAIPXvxoQ7rr?=
 =?us-ascii?Q?JT1fpw8qnraqit2BZpabDHc1j8IA+NgESHK+4KGlU9cuDnsuQ0HwV7e42MHY?=
 =?us-ascii?Q?j2prdmqJHmmzOjaJIWXyuZbkmjMngTSkGy25EYDPH+qdwDbKL+hFfW36GMck?=
 =?us-ascii?Q?97fRo2uOrLhIfybguAH9rk8t8VCFXGZGdsJ29CMePhZDB4XTmulepFPzVrWb?=
 =?us-ascii?Q?i0SwA8DLUvHygE18kWelrDInyZ5G3lqnll61AzJa9j4ZinE9OOfzoAL93q0E?=
 =?us-ascii?Q?3o2p6eKfpy8KPOQXJl9k3jJ250pMF7SsVXKYGvSYMr7Wxemw/Bs/9m49u36W?=
 =?us-ascii?Q?7AIBgjqx966Flpdfoxbj7WUIM/2jaL7JW9IQIAEk2SGLlAOlqGT1TFiBvf9f?=
 =?us-ascii?Q?s8jngJ9w5sjIWchwEjOZcnLSSvnR3BmscGj4qU76CpnRdX9ycZRv2J71aMVI?=
 =?us-ascii?Q?w8Wz6eHtp4T/koQ/tEB9xbpdVU0bGg/qnkf1HSnmOcdNG0bSbbCYYNRkRsw0?=
 =?us-ascii?Q?tIsyQUAPfi6V1hOqnzDwH8SYgrZk/HUOE0njh76Ihbb/3zP07aqAYOXQ//pl?=
 =?us-ascii?Q?9XqtPWsx7KOuA6Vk/62q7k+vohV5FyEVJhZiwetpOQThRgqZi09qTk4wIH1k?=
 =?us-ascii?Q?BHojAN6joL0tdy15VUpI2vv1zFWkMZlvJsQeJrSu?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e0108c-d3d9-45ac-ce58-08dbf01dac27
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:24:03.8109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2FSj24Ga0Ey92WbzHZHbnVVS7GrgvAci28tv/LEsoPX9eEsaC1sEZ3/fExNAJhtnnNwcGWsjy361sXm85QcfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

Same as other functions in pm_userspace.c, this patch renames
mptcp_free_local_addr_list() with the userspace pm prefix as
mptcp_userspace_pm_free_local_addr_list().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.c     | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 489bb0e61118..87cf27dc1d0a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -7,7 +7,7 @@
 #include "protocol.h"
 #include "mib.h"
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk)
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6956fde61c68..f2f0ce608219 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3321,7 +3321,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
-	mptcp_free_local_addr_list(msk);
+	mptcp_userspace_pm_free_local_addr_list(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ec5557697c11..94126212da8c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -942,7 +942,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3

