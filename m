Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00060.outbound.protection.outlook.com [40.107.0.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4617B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lu2/vBErJ5I6tkv3txvugZZ5rqTTtXpHZTDU62gBLsDYjelR0pE6lZ4u8nvnq/W5/vHJ8iUnZ6MAxJHX1XdXBUvF2tSoYERqLwDsA8DeYymcMkLhU2LTgXpD8yVKJU+kqXrn2xV0k1PxsjTzj3OJKt5gO6T4rNZkk8jvJpRey/mrA72kavE7f5VjV1Hn0BJSMmmU+VwYo2Kh5pZPPevCozw4NgFbDdXhNi9W3o0z0znn+XSXjT2LUyd9NW6gXxORb7r0ZJEMN53NHmRqj+mTltSElmda1ZZcFxwu3ztDpHhk3ErMU+22bpCrsW482jYLDrGjRsKTHpMF87fovJfK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJjowJ4690G2NdLtiQ+Je2I0ckCnZXEC/DGaQQoUNmE=;
 b=ibqpPPElzzuaxSI0iCkWFrX1ZqV6V0rxsCmv+Ge4cwjkaB6/57YWcwlXmdA0Ym/7lyKOvmV7AL+2364xJSCEmhsMtxUcC/3IC1O0lXHOKPE/BB5caVPxQULZP3TBMow86FvYMeoLBplAo8iY0ITsCNk3kPfPG+ET4AQEeBzjKsd6Xjx4qnm4hZTT9V4S88VHzx5QefTsbipkmY6rIIYWRUxJuhjTgAfuAY1BJRLGYUjdIqMF+6Vjaf5gQ8ecHoXIbFksMzobq2X/68d2ragmIapDd/RfAPXEsawYTU2R2sCfyNvebwxG4aEhA2l/hZozotnr5vn868WS8EbyByZfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJjowJ4690G2NdLtiQ+Je2I0ckCnZXEC/DGaQQoUNmE=;
 b=Ukxpmix4eUmnuKBR9WHo9j3/yzuREQvxb5l6CR7b7IaL1o9JP5MNMzBICIf1WqatOFKkSavnJeGEdbUmQmLm/z5lFH4IMZL1hAymWxGmcABJRyLL2rjP8G0BmR9uK120eFU4SkIJlsNR6lN3xMvWIuXCej5g5kGfKzDMddsjaaGWHLmcGC8HE82jWs7/BrNs0qim5rnzqRrLLzJ26ke4+Kd33xMVgNIbHwwsfwg4pw5mlPCJN23Jn8w86+JHKIwn+q3UVDjv0YuOe+9FawLrRqwqaBuxSkTd217NV1IL4AIDSumDmgB+NJ1WKgbVpGYJ39MpMgaCbSqTKBO1M1bo3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBBPR04MB7835.eurprd04.prod.outlook.com (2603:10a6:10:1ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 11:01:57 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:01:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 08/19] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Fri, 21 Oct 2022 19:00:00 +0800
Message-Id: <23cc44284f711f1c47369c390cb3da831ee27fa9.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666349129.git.geliang.tang@suse.com>
References: <cover.1666349129.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0119.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::35) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DBBPR04MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3fb0bd-1a0a-4445-05ec-08dab353abe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8Z51NI/A8n5OAbIQcbcJ6uljYDJ7Yq1KS2F2w3pGHLeRHQSn5IDPahGnQwhUbTrHhjKOKJpi6OhF9wuB+JtYkFnOhw5kMugvhfo2KvvNsmCXCzoTC84hUt+vFNv9VhDkuG/kK9bC79V0lEe2R8gUzrCBhPzJ9NH1ULZoaIUzRlw6gXG3IZPoEiQEI+8qkMS82w2ImKZPs4i8v8XVi7dX07Gwtra59mDaTc4Zr8Fx3zuaahk3kINPQ3RJWRj9281kuUFL6hXRSHR/6FXuOcDNmvVBQshi+DAT8JIQsesqeqWOxeRGmXrHYwhqsnJtn/DDIJZuacV/zqmcvYdZ2kIqBg3Hrt0Fsw6tYs90Rb0i40s5OARf4VQJgFP/acnvJktGOA/8NpcRY1AQk0rEBgC1Z1J7BrhgbwaSZgDG7xcOVmp+imJlrZ+yGdOqvUf02afZ9cMhEwxDzfp+AVqIet5VweD80EbFGDCYCbolqFV9tvqm0GaiUub57qXYURotmNrxRu5fhipjxIhiRJMzBIbFCl9WshzRktLoSD4LxiOIChs7ZT1Q4BKT88db4InavgumBYmYHnhraY6oBL4PoRMT9gHY0fvvyjGuMEkXTJEh2TomBANZzV1/px6L5L3Zjt4gdFDvBMkuQVpAAs8V+NTq9VZdl0mAsuBttbBpT8JvXF9a3CWCCnxQtxkkHGx9fQDRuV4JkEXVRY+LJNUcHRVXeT/aoOmfQ39K11FA/G6lI5VFuE0zdFOutI+VECau6DpI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(4744005)(44832011)(66476007)(86362001)(8676002)(66556008)(36756003)(66946007)(26005)(6506007)(5660300002)(41300700001)(6916009)(4326008)(316002)(8936002)(107886003)(6666004)(38100700002)(6512007)(6486002)(2616005)(2906002)(186003)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k7dsgdQ8FVq6fVcGXoMm1RvyS74D1BzmrP2PvxXo6AKQKjsh9+wRA1UATWz6?=
 =?us-ascii?Q?1lrOI+7RIAtOdYalkf+51wjg7sf4kXfLecdg2qPciZaZluncRcVD9zFaLzEj?=
 =?us-ascii?Q?6Deeu6c2SvCUF9H+oUcA/mhSkeI4FYP1KwaTfJHv4xCgdzvuKHQgF84E442X?=
 =?us-ascii?Q?jMqlceOuv67wgpa93Akkkocgs9jcCZhtRglZSdiA65B81QAAXn8w8eBWU1M+?=
 =?us-ascii?Q?ZfqPUhR6Ipa9pY0Vcmy0qhIKvs8X9WzKnJodnxVPsPfYpRxJK/HC7nZYFE0/?=
 =?us-ascii?Q?99yfZV9tsrjop4jS+qzGQkJPb31SOo8Q2E0T6fSI4/bpcPr9MYHV41tNiD1x?=
 =?us-ascii?Q?mbse7nA2TMu99Un1XxgQikw1XmXdTj3dbpSFOxJShkrTvPSFacLhmNc+vWoH?=
 =?us-ascii?Q?+CCVkBnZww2O8/ITndNpZ51nSpC/T6irzkUWkTaIINJ+j1HG0y7GOJOFia7x?=
 =?us-ascii?Q?w9bG13aRTF92tDy5czTScFNCfJe1L4ExKJd1uGIFCAHQr/OTU7SvbnVQhifa?=
 =?us-ascii?Q?a7cFbyHOAXfshOEmeTLoKaQf9t2+bVQw2HOeBlysyJDrj1VD1fqklWjfa5tw?=
 =?us-ascii?Q?Sx9OE6/monW/zZMg6GzY00mVuBu0WdqeQsc+Fni2VG8Oun4GHGQA59J4NVwk?=
 =?us-ascii?Q?UVWenKiK46mEAYOxnxPbYZrwJ/GDF7AUjGHpS3Ef4rE0hsRxjncmMssnu/sN?=
 =?us-ascii?Q?OVDCpyWoeVyx27XplMKtyU0geTIQhpdrzjjeKDgwJsxCrSIE9H4W1+Cvf5hl?=
 =?us-ascii?Q?xj+jRrFo+GJ7iwWQ2Wjm81S2NpxhicuzOiIkxuuTtr0rIY2fI/gKALp0EpOd?=
 =?us-ascii?Q?6hDMnqLsvDCyNRw/aRzdL4vUmtU8snmQDBGT4UyQ9d8X+Ba53svZHv3+zmU6?=
 =?us-ascii?Q?NYvRtAXPyzDmKwga6lXV/Byf9n6koIgEwfHKkRmrgSPqQPw507hC1d1+3DY/?=
 =?us-ascii?Q?MhIEd6j/fOhmF/e3FWObomosBpndcKHeOh8lCWjl/BLJxlwC0Jrhfz6JW+1/?=
 =?us-ascii?Q?ozPAH00HGG2kgopPTZJ6E1a72oSX4hrLCOXIF+uIZM41DGHAi+4NLxsVlU6o?=
 =?us-ascii?Q?2eXRi5T4lH8w8PQkydXEKQdJV5LtQYX5ayyIWgTCNxkgkABe/rYCDWYRK5se?=
 =?us-ascii?Q?iO1pQ7fqV3nBqj2qBFMYr+HDQYRQkNidkRoQxgN3Bbbe/rvDDnFpF94kj2P2?=
 =?us-ascii?Q?rRXnwVf47U0ok61vgg4/s4+9ytwbi+MhlgnpEGR6Dgh4lFtFleF4cBRUHWsS?=
 =?us-ascii?Q?+m5hRXeC9S2DHaYlW4/GElQHZqeYB0BhoPtOQZW5KKxYjWnMKIlYP/3N1AWt?=
 =?us-ascii?Q?2/zk0AFZzzHMW5CMPMYV22hU6J5AMD493LYEbl3KttMG0a81bA/LEUhcYtwL?=
 =?us-ascii?Q?RzzpaAQRZzqtrG87VEJUXszUlshBZhoBKIeUbBFgjBYNaFJFXXJaYtPh+85c?=
 =?us-ascii?Q?GBQJW4rm2i6nKre3cBHdnETW8z2UQzdFFmbjUnpLpxmylNBEA74q3KxFiioG?=
 =?us-ascii?Q?atraU0MruYfSBVG5S+k/OD8T4YcIYNS1ho/R9s3GttMMbKt0AuGrQ2EaxhOs?=
 =?us-ascii?Q?x/iqRR7Jz2gS6bBpS+jZjPfzSPy40ClFOLYL4WQ9Smun29sf1dPMpqFgcteZ?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3fb0bd-1a0a-4445-05ec-08dab353abe7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:01:57.5141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BsF5F4TQYWo2m+xg/Btnoqqh9bNOaiA9Iths2XqY8mIpU4drT/pksskQf7du7JZI3Y/echeDrjXzs8pMWkikQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7835

Add mptcp_sched_data_set_contexts in kfunc_set.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 0a768898990f..03decb05755f 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -164,6 +164,7 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
+BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
-- 
2.35.3

