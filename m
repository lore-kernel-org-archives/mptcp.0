Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304C6653
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNvOLp+t2Fvi0D8KbTuinVJBlykdzmSYoGv5tOESIrCQG8buuQqjP56gkA4svCOpLxNibLrayspSinRxCVsHUvJk5P6SnzpJAS5mPJOFjVOgcSaDA60AEsir0nyGssRPYwBNhFnFl9/wLwWie2Bk6ysoMY0BDxokIrnjm2wFer/qF+0z2/0C2mQ26gZzIkm2F7oSWl6ygiIVyRPqK6+xnWjDdvKUZlj4EANT3v/O9GsDjuhUCdtxBW+0CbGh+ETQrVu2ioIayZiyescpO3ghnFGbau6oGbYMSU6Ruckgz0fKjBGRKPFHWJJPD8g6NUR5YD0UvaQnFK9DNbxitk6WbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkkPa4YxT9TOJMRtM4o9UnLgGN9TOfaFNMrwAmAoLIE=;
 b=C31p8aEMs6C5gHuxsK8yKwJ3DXB8cET4EfyP+QBJbBds82zrjFtPS645kY1SWiflpZCm4TOC5ERipiv5b7FWEvscVFKAO5U2Z/G2bWjUpAWIbGG6/Cm/1YaJ89LNAgJbCTk3bNAxYQeTgChKMlT1VvYxEXIQRftytKBRft58wKtWTgu5V6KhWoq3OgYuYvx7wv1M2ppbyGFUMtIuzpnFfsTa/6Ooiw/aYxL+CH3bNa4Ut/hk4//RQcZLVHXZJ/orHbkMV9VTXazYDF7tBBra9HQwz9mh35/xNWlm2/MwHkNflLFSP5TkCRWlm8Glo+8bJUgp1r0ByETS4rovcEB9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkkPa4YxT9TOJMRtM4o9UnLgGN9TOfaFNMrwAmAoLIE=;
 b=iEZC1ZyGnrIpamSF7KI8TDWlVqfXRdWB/ozdq/6gwBMf5PPI+xQaC/skWQzjXwl72Y1IHAjz8X5+7WszI+qX/HEBcdUuSEX2YHxR3CS8vg2JcOfozmB+yWgOsWQ+PsZQwvWcVcglZzbOfzdRe7fWIJzFQTf2syjMrmjbw3/FHCCn1gWyYWYPrCDkg02B7dcrQx8+45B2HnpFiVQHJevL30imw7BAuF6VyF2ZDrpcjKRrVyXYs6wP9g8O9ZEaJ90ZFQoSUa6BfGH+8o2AceNGku5d/v2dYFzUsnYq1q7/ozVoXh2LjITDVwBQNkBWNXtBHo6lA6INa8ORBa9mqTMRjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9777.eurprd04.prod.outlook.com (2603:10a6:150:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 08:41:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:41:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 13/19] bpf: Add bpf_burst write accesses
Date: Wed,  7 Jun 2023 16:38:28 +0800
Message-Id: <0a6af2775f6044734eb736ccbce1640c1acb5056.1686127032.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d9de8e-03cd-4a4f-062e-08db6732ec7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mBuzgAYJpfCV+NRnyxtLA1zLW3aGhk+JuAx2Pa6UNBSaBNdh29DKNVOEv5G7kFVehy7gM66sd6p50nU19WafR8EqJwP7zL8foSZaChZfL/D3rvlwurCeNdBQx7MYn79KKDfcc6UjQgvxT0hxxT+1H51/FYXoJGFxu4aCI1BA2yJVLBmJWuy1shTpWTsMdflA1zPLK/AENhcq5ci8wUCkNwibI+8LmU6cM7mYI3W0XnhXk+TNOYLdhxc5NEi6z8rmnmzalu0y7EGmZWta2ZLEkwJkwW8tACfel1+RF/y63GWjAOoEO8g4euJLiB1UXy3cOLQ6Xo8zf9HzO9td12/EEY+grQo8AELu6gnyNmyQgsVk0GSyO6CRwwbXsuHMfrl6BPDaf7PgDY6JIhj1UBtOZXmXINyZLASUXEtzoBQRWSCpRUYQGXTw9M4LRm37Axrt81dH7Y/oDPWDrEeczAXwgnOIZPMKsZ1p30e88Bmbr7XbsrYv1ZXRTYykXu/pxBSjbMyUwaSciIvxHmdjxNsfp+kSUE5ncKvN+1sXNTWBT8E94AeQCFCCrMX3SSAbqksS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(44832011)(86362001)(6916009)(4326008)(2906002)(5660300002)(41300700001)(316002)(66556008)(66476007)(66946007)(38100700002)(8676002)(8936002)(478600001)(6486002)(6666004)(186003)(6512007)(26005)(6506007)(2616005)(36756003)(107886003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yvzER6VU6pBflLkUddtOXcGP18HfNouq+RKd2cHcJhRZc24a3cRBy/D4ztA+?=
 =?us-ascii?Q?WS5abGbaCYnOozT1/l/fS8oscJ8HEJPgttiqYAZU22PhTrsIGF/VGZRib5GO?=
 =?us-ascii?Q?R37/R3OeA/U6HN8fTE8iu11NAYAfDSYyUoPpnhHJJcvZkjKmp4BeCbxvrfKb?=
 =?us-ascii?Q?fuYeUbE3ddU2SjRzD4N1er+n2cKvfPyKdo6msPBXGrY2Qd7SDi+tIMUC0CIG?=
 =?us-ascii?Q?XbfPhHM8LJINyQ0heFuXl8loBAd3nnkTbVZEoG/WzTYgW0nxa1Ff7f1lmQYT?=
 =?us-ascii?Q?AgFCDH5lGddCi3mlPbdQiVzuHgAnhSn0xsnk3e7Z9m5lE+EYni3AJ1s+1tFz?=
 =?us-ascii?Q?bQZPArITnpZSzb5G2zJiC3rW2IpVVKsipUQxClLaZCaEywqCEEr98NDSXdTg?=
 =?us-ascii?Q?/h1dy6t9GyN01udNTHneCDrzS55xLeHIY2c6rwln2k9A1qi+6IBAhi+kVxLB?=
 =?us-ascii?Q?mm7+WBP0vwLtXhnHfAqaP29X6cTJL/w4QIVbZUelZwXggNxe3V/ks6Ic6oq/?=
 =?us-ascii?Q?TQyI34qIRnIsp6G/ttjf+X6Jg5OIPx4hfP/oIdvhiTullopYunZlbTwBy4K1?=
 =?us-ascii?Q?8tyQH6fRcmfJ2m31dXpbpk8IzvcOHfqXW7vKU4O5RoIGfi5OdlEgxRxpqVO3?=
 =?us-ascii?Q?4TRYf3UOBEIWe424D4oSZgjVJpJ053BSogvQtSMpPRyEV4oDPiUW0Op8/euu?=
 =?us-ascii?Q?HvS8DmQiVRIdBc4mXtAB8tBpVYHZJh0ip0WfwZi7ExPB+IfGYxUtmltI6oyg?=
 =?us-ascii?Q?ARRFTe5hDjDwOJLM3p7TMlzuRz/eGD+gKzZPycNFJVQDbadk5gtwgeQA5Ll4?=
 =?us-ascii?Q?XzXXumVXFHPqTwtLmHTVSk9Zr9makkUK4w/AXG/mpB/MPanDdmEMrdeLRPiC?=
 =?us-ascii?Q?nFllq0Vv+csD+Hi0I3AyIBRcZbxtD0V/i8ZezTv95sqsEC4+e6K5urqS+hyY?=
 =?us-ascii?Q?RVv8oGnI7DAyG9uR1g8VUszyBTIq1VeBJSWBqxPpcQcuw2fDbJEHU8edPwde?=
 =?us-ascii?Q?UjmYiPUXEJ4jgMseZ5JiUDLiEjEaUUT6ZeWwuOCby68N8RCpSurAqGGDlBbL?=
 =?us-ascii?Q?PvqCDg1hLKARdQuGpHcPJSefN3ANyHxHhWNphnAlyJ4WdxsJeHOu1UxHXbWq?=
 =?us-ascii?Q?GTbOOoieHdaXvDetOzz57XW7Q7Qw53VBoHolByJHOsdsFQU3Uuy0vxu8qDK3?=
 =?us-ascii?Q?gfvjqNXeSKGw/Q7DCS7tD3xaUaUhZjOjZg6WP0NPQE021yzewIWOqls3lofW?=
 =?us-ascii?Q?MKzpuCrhrfaqHeuEdqKZ7evPmMZFkeI7IxgGAIDeFDTLkRYHwc1NSUnJR1Ps?=
 =?us-ascii?Q?SVHllRvxbefqx5GFvYnN6iGLnKJcDBFzUhQTTqV2xhuIv64XdIqmiMKcDIKn?=
 =?us-ascii?Q?QDWfEsEV3WunpCK+bL65FDFwziyysE+tiQrnoFZQjmNfqyCZgi6YH/Q5DTjC?=
 =?us-ascii?Q?j2NnAr3V0kBj63JagB5FOpPox7zTyUcQImOsLWC6hxPZHNraul2ee2271SZq?=
 =?us-ascii?Q?5WbrKJfCTdXnYPA/9QRUhsBePQKzPAQwnYDSns+LTPya5SDbO6SLN0id4y85?=
 =?us-ascii?Q?lyNAfs4qEBZXdnaECTiUXFYI+LHxdwX0nHeJQiSU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d9de8e-03cd-4a4f-062e-08db6732ec7c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:41:01.7715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //Vv7KsuEK6LB2413sXCjbvsBxauGTs1DeYpVykqVK0oZ62BDblUMoRH1KxYHpiLv7VhbbLN8WWnvUs9Jae47w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9777

Add write accesses for avg_pacing_rate of struct mptcp_subflow_context and
snd_burst of struct mptcp_sched_data in .btf_struct_access. They will be
used in the bpf_burst selftests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index b9fba77a30bf..ceaf4fbfc430 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -51,9 +51,15 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct mptcp_subflow_context, scheduled):
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
+	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
+		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
+		break;
 	case offsetof(struct mptcp_sched_data, last_snd):
 		end = offsetofend(struct mptcp_sched_data, last_snd);
 		break;
+	case offsetof(struct mptcp_sched_data, snd_burst):
+		end = offsetofend(struct mptcp_sched_data, snd_burst);
+		break;
 	default:
 		bpf_log(log, "no write support to %s at off %d\n",
 			t == mptcp_context_type ? "subflow_context" : "sched_data", off);
-- 
2.35.3

