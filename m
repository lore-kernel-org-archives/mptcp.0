Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15867100C9
	for <mptcp@lists.linux.dev>; Tue, 15 Aug 2023 06:30:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bgvh6CK4G/aElPWHGkxAZ3OF4ty9rM3VR2G6nR8uT2nT6EbXAjsWbrsQy1yi6POxwYZZYH3QbP9pXtXrg7fTm3PfY/MdeCSNtdctM6eUO9mx/tdySqz6WXR+lXC26aq6xGSOUUUu6VBYuE2XnOefzCDZGNQsQre2eVekNCjYingOOT6we0+6TA58as4ulCiymRKWThCUPQAU62OoIufwY3ArH/7n3p++fPN2fIJcSdmOk0ub2YTLmUL/ugI4OCy6obB5MujJ1rmMpGcldFQ+2wJdZdtn2EAMVvZUFtyc7U1Oeh8fpLT0XF/T6auNsP4c4usa9ER9ksz/eQOqxQzKxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTF8AqcZHoSkebtOMd/N7qBdCoMquvrozXLfK7kkoH8=;
 b=J4gLhSLHdWrBLr/cX947S0A8fWGzfx+jDXDCEpxR+EhRZ0uv1OWWlOADk+aiy/nPqw1t9OoRqdd9Ag1m0mLla7kkgnVEmeWFjbf8JGX3QV6BWhH1C936PXY/1TyQBW5QjxXTHpFLOKHerk8IrU+DNAy80xWn+9IGHbFMozsbKd0adxU29m6KyuRXhaZ9XvyyewxZT5Zg//fky7YI+0WEOcuvC5YbAqU0f8Iyoz8gxA1dwLrgyY105GipZ6ceLqurdM7rp/8fQmpEHuAAC2vPLqI7ROKC9N/G3i7F6LiqbBwdjsyS31jdIpZenCUN63MxB9j/azjlbZ3QsIJ341vITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTF8AqcZHoSkebtOMd/N7qBdCoMquvrozXLfK7kkoH8=;
 b=3Mn0fymV0PJiP8yioBdxnENLntoLs43rGthCvwoUjQUbLgAcLhI/qe87XKX5Hye5/mALXXXW4QlwLRp/688dBIXCqOA6BoAixUfAVXCf30XrVWW9WVZKq05NB1FHAz7MO7H2P+/QLmyTOMMGTL+JwHGs0cYHRMUXaL8tqNPZVjvuZ4chMmqI0gXgKe+1aod+wqYzWq6xhMmQ/oPiIu2Gpbk/cxIXn220FlnJDTAjNWN0ND211Y8Hd2QCHaGO0nn8mNnbVlMeawevt5jEp2ViLtN9ts/fYxmOuh90qYLKa4DHNMrtKpdv+nl8ZkjrmfykE9bVjfCzhqjdA+KpIo9Seg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7239.eurprd04.prod.outlook.com (2603:10a6:10:1a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 06:30:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 06:30:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 5/9] Squash to "selftests/bpf: Add bpf_first scheduler"
Date: Tue, 15 Aug 2023 14:29:25 +0800
Message-Id: <c694527595e8110658f90867b72681c28425b134.1692080803.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692080803.git.geliang.tang@suse.com>
References: <cover.1692080803.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0184.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a353ecc-2ecf-4927-6ee1-08db9d591559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l6Huc9cZOFYqmW6SXNBP64BqNBEKx4h79RdCKhSki+Uq2cYxy0eN6Vn/6z/o++p86REuC5aHBFcVeNpYqd3bF5qlk1zTtj+j+WskG5kxJwC7OYukd7jK0uZi9x2cVHbXALjwM6GNuI9SsBDbmbx5DItvdKY9tYcMH68iBZ7Gt7zo52Aec45Evop3KnGPsgZ9qE9MhReqRyqFBS0adz7daoOt+QNSvnWwz97/Z9VcQb2nAgERhrpDtD1tg8qwgwxd6hlyHeGW/oftI+YubjqtLrPOQDf0+II+oIJsdiJxQdOCLyo2pr4/p0oQQHPJd+t2nLIREU8SYnP2ZEah4qp5CWk4qgXlmGpSCjTPmtahv6T9+wBFeIfR6DL3fTst1HAZfBRk3PiXI+6DkjjHsiOUkkclBuriupgR2i0RjNezcAIcwTuUP7kjid1uhRbDOS/LycjQIBj2MW+uioYkhavflUxARn3QkOXc+IjNpntAxG8m9RFHBzrWI5lYkw6FBrgaiilWewat5Xn7UIVjzCuGx1iWQjRHLgwmZZcVl4EOO82+IUL49cAgTHKPXpzVTLoc/gZVbHnelU+AHEVZQUg33f5GlwLmxsXu686NNvdlOV4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(1800799006)(186006)(6486002)(6666004)(6512007)(478600001)(2616005)(107886003)(6506007)(26005)(2906002)(44832011)(4326008)(316002)(6916009)(66556008)(5660300002)(8936002)(66946007)(66476007)(8676002)(41300700001)(36756003)(38100700002)(86362001)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lApjE67svhlr9Htptc323UakAPjNSk1YmjF9qIW3IHw+2I+iK1YO+Qlqi8co?=
 =?us-ascii?Q?EAgrXs4eqfINcnIxifk/7IdFQ4v5ICwRKJ1RU4Dkic27J7QkvuRBq8qiheH7?=
 =?us-ascii?Q?z0lUIn3pJg+mb+5/cPBA1VtFeBpi/YlvyKiFywkRWvvA6P2IZdha0Kuxf7zW?=
 =?us-ascii?Q?aN9kccAF5YZHIbeUssFvS1dX3CwOfNzt9yFNivrJ0m92N9V9dGsUVqJ2do0s?=
 =?us-ascii?Q?Zlzdo37PELv3oUz72DtO+c9YN2inRCdEVJudAH5x7leTm9nLvq0+fE8xpMir?=
 =?us-ascii?Q?6F3rhaeYvpUQL+7CeZgwxq3JRvnpWqxUCGIS65+4R8xwO6ndATgicrhwdzHb?=
 =?us-ascii?Q?pcJkz2SJamzo7ZVCy9c9Q46ARNSJJxShl8ZSvcKqDZ173fr7DZ5LZADGRdfF?=
 =?us-ascii?Q?at8ZrhGVlJgY3FaLJlNBSR8aK9nbw/meKCsxGtNBlDZUiVgyGkg+917WtA/I?=
 =?us-ascii?Q?2I13kkqJjojjZE7Dax81KDGiQjA7l1bBYvjoOUTviEspVvCy/Ei+Nn1CxUxS?=
 =?us-ascii?Q?Gd1K4UBmOdNis4RlAEaJoxaH167VWtqp+Z2GG1XU/GpfcDTgdhBVb0GiYY8u?=
 =?us-ascii?Q?bwMXtWNyNLacnYFW7HcB/ft48UqW9lXMI9Ovyj/pbVhWOVs4HjymQf5nvnsb?=
 =?us-ascii?Q?DE56NhO+DyB0AW1NIZ5T5gFmmF7cGuu7AOhOeJ9aqpHhLuxoq7rXQ9nhggao?=
 =?us-ascii?Q?4jTucqT4M4MjuH23KbFozX/txQGHdtIBnNwKjkFvo9MZVXAAuCQ0BCg8++ZL?=
 =?us-ascii?Q?3JeYxzOvSRPQo6UmlKjMAteoL+J4TQCZXYgB9FA4wHjXzJydisodEVCzPSQw?=
 =?us-ascii?Q?vdK6UIHuak+1KBd3C4lnU6LqBO8rJ2g7xiN0KnZNRjcu1+dpy8xboWvnBajC?=
 =?us-ascii?Q?4fXWadAc5f7xYLJzscQylaREfovoGnuWZ0ajbZlkNEmPjAE2vVaFKwkaBwYI?=
 =?us-ascii?Q?IMSAR8FrIsT9f3ACXU5k9/iF8oqAv/yddC74ZGgwHSzQfyQQelb7mAPg7qvl?=
 =?us-ascii?Q?BToMpgQp5fFxfdLGY59cDNVEuF2l5Jv9j5YOc5TkWFOl5wHZg3y6Nmzdl+mr?=
 =?us-ascii?Q?awgv7tJPaQNyA91LOV9M00/VL10tg0/bauq4gwOuSUjCfU1VPr353bck/xx7?=
 =?us-ascii?Q?uMFSUsckK3giCCq3LtY2PNW+INyZdiwMdInBQuz7i69ojW0g+6KfHdP6E+fE?=
 =?us-ascii?Q?LLWtriygqfGCEhZ35jEXiZCVLBZmKJJ/XFNEItAYz8Pd+VwoJ/FlTG51UOze?=
 =?us-ascii?Q?XTjksM8HAmPWugOxOxlk4K+l6nfSVUodBvjYKED2vd/5W7WUacuv8tveQ1Hu?=
 =?us-ascii?Q?u8vGgY1zPcTOiyKuEpY/gfYllSx/tywNQKIoznBHOYfR8UvFuLJ0l6zVWikm?=
 =?us-ascii?Q?zsZrvd8nRvwGHTcHnjfRTiBeVs0ZRgyH/o81CotHxa+uGTiV0bCT7nBx2lre?=
 =?us-ascii?Q?APLY3q6Rbr0smUS2dUPO0x4uTS7m/ewUIluTAPXEpPrL5IxzEl/9K8P21cjC?=
 =?us-ascii?Q?CbBusJqTlvB4bHOwPVhgAisBrijPRigXj8qZODphTU7nUWNcJzGg7jvYxeEV?=
 =?us-ascii?Q?aI78Ulst3/lfkIcSxykrYyfYIocWNlvzoKuC2YgW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a353ecc-2ecf-4927-6ee1-08db9d591559
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:30:13.9838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSXWPYrUUS+llklQFFrRUKptZUuRoMXW8VwAznqNhNOPHdyxdvmKXg4v2TZfbUAeiROpvaDwKTdus/+shhjKFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7239

Drop data_init interface.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index 3b6669d536df..ae0eced5b91f 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -16,15 +16,10 @@ void BPF_PROG(mptcp_sched_first_release, struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_first_data_init, struct mptcp_sock *msk,
-		    struct mptcp_sched_data *data)
-{
-	mptcp_sched_data_set_contexts(msk, data);
-}
-
 int BPF_STRUCT_OPS(bpf_first_get_subflow, struct mptcp_sock *msk,
-		   const struct mptcp_sched_data *data)
+		   struct mptcp_sched_data *data)
 {
+	mptcp_sched_data_set_contexts(msk, data);
 	mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, 0), true);
 	return 0;
 }
@@ -33,7 +28,6 @@ SEC(".struct_ops")
 struct mptcp_sched_ops first = {
 	.init		= (void *)mptcp_sched_first_init,
 	.release	= (void *)mptcp_sched_first_release,
-	.data_init	= (void *)bpf_first_data_init,
 	.get_subflow	= (void *)bpf_first_get_subflow,
 	.name		= "bpf_first",
 };
-- 
2.35.3

