Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372D07E8
	for <mptcp@lists.linux.dev>; Fri,  9 Dec 2022 03:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6k7lBswV0VusSVZjHDMwDMuIBc1YWPvJ+TD9ZCiYSGPZfylklNzKEQAI22ODYtLG9IhhZ8xC5dNN05jATSBQl8Ve+PaAbTswiLFQD8i9D2wy2RFq8Wb/ewFNKZUg8kVendHj7qyL0iuAhlMweO3R5xU4m7gBOXk1jirwR7280qhPjr+LHrgGCM6cpnnchQc2a7V6bGZgf4k+zgn6DRC3/zoU0udrX7Md/cfRPVOp+SKVo+iWOVRr8dJNTgY3qhX7dYItX5miygbQOFww6j1lbpMGUeEm8idmS7sZFRkgbWcQQsHYoso+RoyblqLH0qMIyDwhJe0m2vlXXWl8aPM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1+X+QzKeGB2Itz7EgeJaGMxVtD/7fnByR7/uCeJzOc=;
 b=i1IyCxpJUyVmAJrOgoM2eu7t4nIrtUKYNGUyiAzjiaEx2SDHWYYEbXWKFXPEHeISbaxFO/pFxx+55DPQs1H4KzM6WGFcvyKpLiHInNXr9Z2SQmkw5dI6SZcTQgQbac2fZedT6se7Eq75zWbg5x+akdHDI4ciMyHlr6u90dQouIs1fwY56xMzXpFpbYj7BG1qkyIKMXk5ofw6an9QwGk/bnF9C5Y9mW50GShnoGUospNqL66mTsY9IYJeqt1aPll5WJve9odSPg7zO0/JD0yms+Q+ZWyE2ZKu5yY39dR5Pq8i1kW/bOaK/E68Ifj6SQHM755YkIHDTOMkMo21gzrK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1+X+QzKeGB2Itz7EgeJaGMxVtD/7fnByR7/uCeJzOc=;
 b=WoiVjNADfKeHm9JGc+iT+ezPW2IVgeTW7hyEoir6cLnC/MhEhPjnDlp2yUWspjPgmQHOkCLfYEIHZAMYXY3GY21aXu4DnpASbn8nLD1+G/CTI2Kur1YUc9XlNIpvji4r4a2H6/Dv3gmxkIGmOKQAJwwBHX39c20c9VyyH+VqnMk/zn9bsLfnn//t15CecvZB2kY20UTbBqaPz5jp/vVw8Xyi0fEJeFpT0NlmxEZADqzNgBTjg3K0tSHAE27b4SWsYMx13fDwwU4PF7jFAGH++XaCpln8VabYVTI0YD1EM7L1mv0PKanLuFp/hkA/DAY4+ZyGTaU8ri5NbYlDphPESA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DU0PR04MB9276.eurprd04.prod.outlook.com (2603:10a6:10:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 03:18:50 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700%3]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 03:18:49 +0000
Date: Fri, 9 Dec 2022 11:18:52 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v19 0/9] BPF redundant scheduler, part 1
Message-ID: <20221209031852.GA26930@localhost.localdomain>
References: <cover.1668151131.git.geliang.tang@suse.com>
 <ae42a5ff-8d1b-e4ce-6702-eb3b3045cfec@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae42a5ff-8d1b-e4ce-6702-eb3b3045cfec@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DU0PR04MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: 896d0d9d-a5b3-46be-0e8d-08dad99416b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r2Qa369hzp+zbe2xfgnaq0fuBBQzJa1sWa72ur2kF1ur6BHsmlYLT6/HlR5k+RJzUOAwvvUTRvmsi+5/nFSMHBHs5FTth2dZTFPTV6lCQX603zL15tLAJAIsINQxc34l/HSKMyHh8iM25r4R/79bJT16oCjutShDLrjn5NSu4f3H2wOUiErlvXXrfpHtV+xXCMeDirD3Yt7qopYhhwGA67DwghxlnkRrHoihoRREfvGaMITYRLunYUP/TtA41v4JUXUUfB7/3GZtkf7WQss+4g7FC8zO3iAUO+li7fzupm0ih4E+mopwlVNmxpUjFWTZaAy6zHJPhZ9n4UgUpgRB2NcAyX5/g2/3RbvQlmpXs0VwxmAI+krEhUtaQn8hSvhQNd5E8tZjUevhrie2gc8TlC58r9DxtwdgGav5hqLB2QwoPc5CU9bRZmq+ATV338Gm3r91JTVivrvZJvalmRLy6bWXppKf7LC8/ovxGn5PYOoCOsEAhWkd1o85yXr/rGjQIHhgTPQzfi31mG2gmFDlLMkPZdaKy6MVDXbMj68d6MX8qTDinXDLvckAWeo1DMwZ7dds0ToH7CsvgdW1/IWKZ1u36kyCfJN2sE/Tgs3x6zh2GFLKb6z6cNJZLTPdU2tIZG5EUvCQnxE7nkhv2G+aR1uCu9iamg6TGjlWrctv6+GEg1Bv/MA0tAuWtVTQbSqb+EL77zLv6adyRE7jo2aw7Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(1076003)(83380400001)(86362001)(38100700002)(8936002)(2906002)(44832011)(5660300002)(4326008)(966005)(6512007)(186003)(6506007)(53546011)(66946007)(8676002)(6666004)(66476007)(66556008)(26005)(478600001)(41300700001)(9686003)(316002)(6916009)(6486002)(15974865002)(33656002)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YrOHdg2OA5sZPwbzTMDegClKmr3sMe7CMbekC1RZt7O5JQMen2My9wXzHpti?=
 =?us-ascii?Q?k7+ZVqCQ4s5gE+8lfjcHyZFa+Em5LWPhMcS6rAfZbfKv2xS22izAp/eFBLi+?=
 =?us-ascii?Q?DsbomM0j0wwNpzP8OivJWp5cEuBVLwwMjCMccF54f46KYrmb1MeJQQfFVWjW?=
 =?us-ascii?Q?ifFs/M8Bq2MF5LlOvEc+OXWdVHI/8+ALG/xLdvR1FxokjXVpQJAS4BvFWsSd?=
 =?us-ascii?Q?2pgEySLhhe2YiHvt2Tx8Qw/7nImgwwdGud2B20dESRqjG5k2mYzbX88m3WrD?=
 =?us-ascii?Q?jCLnZOFvlbDPzo+DncT6+UgzoLJdNGKlSXsxN9xqv5TuybCIGWSUqmg7kqLM?=
 =?us-ascii?Q?EXB2loIAdE57NTZm2UD9N1mnug17f5jIEF4H2vBBXIwQIUpW1o9VJvxxyLl0?=
 =?us-ascii?Q?kQ1hPdMdJ89xWL3S2aP5A3sUFGlZN65iz20dI2IP5JY3rIJeAQWXs/PRiyjT?=
 =?us-ascii?Q?Es89U946/Dvy314XQ8o/eOKNSROrS3bziERguRSDbNXaR3cqgHGvj6Ric0yN?=
 =?us-ascii?Q?Xoi9h75GbpFkjsxnO01XHNoQ9xpVlrYAKS0yfvE0NoK9E7bukACQ5DzUijkI?=
 =?us-ascii?Q?dRYfQtF+1kQVLUZEtP+gS1jVVF9T9fOyjzypimNg+Gf0hhLD1XcJeexDZEKq?=
 =?us-ascii?Q?9NfRNmAXba3N25Q95EGX7544xmiJz58mEfdE6FdUuM6iIe047fXohcUgxL1c?=
 =?us-ascii?Q?Kyz8MJrLCqVyOa7oCg1J9554QVdY9pzN7fPL7mt+5qMwfN3vOgNb//+gjCAn?=
 =?us-ascii?Q?owLNQM/9qEfLKjNxk/UyyGlYrvSb2TASnrINsRzgrG7/zsYffpRP6TBMYsD0?=
 =?us-ascii?Q?O38VlTe3tzS8upvj6EP/vY4io4qp9usVGkTPtLmHBVY4RWy0fj/3C5xGzOLh?=
 =?us-ascii?Q?KqmudLAm2GD0aIxHoAI354UCqbb6r7+khe/vu29JgmIqqTXoSYdk7H+QILJc?=
 =?us-ascii?Q?g7Dgl/tN1o+pGksGBVbFtP7EhmNiHHF7qeFe/5I47w8rbg1sijm3Jem3mJhh?=
 =?us-ascii?Q?GjBcPqEktNfI5fncJClIRLbMp8vnbOigss59fcYtiQV+f4sGETPcoiuxfXej?=
 =?us-ascii?Q?lL3CxqY2mc2S8t21+53jWFwNfJrM2QtpOHlxBelLIHLGeIf7PbjukfnqWqEe?=
 =?us-ascii?Q?ITC/Me+DlULkVQqd2glMCBrhsDYAYGZFJtpd1imp15JX1h0xK6xwDGdCaBVF?=
 =?us-ascii?Q?xz9x70lJ41nLo3bu4K8t3vuf0RL9NhzzycYOECghanBmBHl0uX99C8ikAtXu?=
 =?us-ascii?Q?I0oFscK+H+n+N06/0qKu9lsaEaqOylcI7ruTrKXDBhLadLIvPn5pAki3hIOF?=
 =?us-ascii?Q?VxQgi1NgwBySptlp9/gvm+iCvzqGqsONPSo5xW/c5MWZ3B5yb6xMyK2DGdMN?=
 =?us-ascii?Q?HsmaNkWzOzW5XncUpe7vtDU105rVdm3fgTPApJwb2+pF4nUG0a1VlCnuiLC1?=
 =?us-ascii?Q?z+hLM7lkgsvfYXHPAG0RRWmukuG/XP0/rDUUjScxjUakgQXr27E//+BU6eSC?=
 =?us-ascii?Q?kWraSHRngGtyverT1IWLI+KaJbYErlxyzJYUdp7SFO09HOX7KYWl6iEoWqy0?=
 =?us-ascii?Q?eZnEGiI6WZBbKuoUhQ5El4CLhI0Fxg5kMSSIrIgoPTAHExq8lNaGqdHrYuhr?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896d0d9d-a5b3-46be-0e8d-08dad99416b1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 03:18:49.2466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKnsXtD/tCH+Ddw0RrMA5/ojaF5/I8DZbPz6BdJsxS2zKF4772Xj1Kz9iZV5UbiXe2uTrGE4Rq3rAMB+CL9xPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9276

On Fri, Nov 18, 2022 at 03:52:38PM +0100, Matthieu Baerts wrote:
> Hi Geliang, Mat,
> 
> On 11/11/2022 08:47, Geliang Tang wrote:
> > v19:
> >  - update patch 1.
> >  - split "BPF redundant scheduler" into two parts.
> >  - rebased on "export/20221111T055536".
> > 
> > Geliang Tang (9):
> >   mptcp: refactor push_pending logic
> >   mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
> >   mptcp: add sched_data_set_contexts helper
> >   Squash to "mptcp: add struct mptcp_sched_ops"
> >   Squash to "bpf: Add bpf_mptcp_sched_ops"
> >   Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"

Hi Matt,

The commit logs in these three patches become mismatched since the squashed
code, please update them for me:

'''
mptcp: add struct mptcp_sched_ops

This patch defines struct mptcp_sched_ops, which has three struct members,
name, owner and list, and four function pointers: init(), release(),
data_init() and get_subflow().

The scheduler functions data_init() and get_subflow() have a struct
mptcp_sched_data parameter, which contains a reinject flag and a
mptcp_subflow_context array.

Add the scheduler registering, unregistering and finding functions to add,
delete and find a packet scheduler on the global list mptcp_sched_list.


bpf: Add bpf_mptcp_sched_kfunc_set

This patch adds a new struct btf_kfunc_id_set for MPTCP scheduler. Add
mptcp_subflow_set_scheduled() and mptcp_sched_data_set_contexts() helpers
into this id_set, and register it in bpf_mptcp_sched_kfunc_init() to make
sure these helpers can be accessed from the BPF context.


selftests/bpf: Add mptcp sched structs

This patch adds three MPTCP scheduler structures: struct mptcp_sched_ops,
struct mptcp_sched_data and struct mptcp_subflow_context; and exports
mptcp_subflow_set_scheduled() and mptcp_sched_data_set_contexts() helpers
for bpf selftests.
'''

Thanks,
-Geliang

> >   Squash to "selftests/bpf: Add bpf_first scheduler"
> >   Squash to "selftests/bpf: Add bpf_bkup scheduler"
> >   Squash to "selftests/bpf: Add bpf_rr scheduler"
> 
> Thank you for the patches and the reviews!
> 
> I just applied them (+ an additional squash-to patch) in our tree (feat.
> for other trees (bpf)) with Mat's RvB tag.
> 
> Patches 1/9 and 2/9 have been added at the beginning. Patch 3/9 depends
> on "mptcp: add struct mptcp_sched_ops" and it has been applied just
> before "bpf: Add bpf_mptcp_sched_ops" as mentioned by Geliang.
> 
> Please also note that patch 5/9 has been squashed in "selftests/bpf: Add
> mptcp sched structs" instead of "bpf: Add bpf_mptcp_sched_ops. Do not
> hesitate to tell me if something is not OK!
> 
> New patches for t/upstream:
> - 602fba0955d1: mptcp: refactor push_pending logic
> - 343f8eed9abb: mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
> - Results: 69720c6cd168..ac857086fdb8 (export)
> 
> - 65e9504361f6: mptcp: add sched_data_set_contexts helper
> - Results: ac857086fdb8..ae9c4d4cf58f (export)
> 
> - 82721c73112e: "squashed" patch 4/9 in "mptcp: add struct mptcp_sched_ops"
> - a7c2367dd1d2: "squashed" patch 5/9 in "selftests/bpf: Add mptcp sched
> structs"
> - ee74ff707e4b: "squashed" patch 6/9 in "bpf: Add bpf_mptcp_sched_kfunc_set"
> - 813537758eb5: "squashed" patch 7/9 in "selftests/bpf: Add bpf_first
> scheduler"
> - 762c5b194975: "squashed" patch 8/9 in "selftests/bpf: Add bpf_bkup
> scheduler"
> - 5db53c2d3ef6: "squashed" patch 9/9 in "selftests/bpf: Add bpf_rr
> scheduler"
> - Results: ae9c4d4cf58f..0814e9ff0a94 (export)
> 
> - 7b3058027867: "squashed" in "mptcp: refactor push_pending logic"
> - Results: 0814e9ff0a94..d98411bcedd1 (export)
> 
> Tests are now in progress:
> 
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221118T145003
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
