Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2078.outbound.protection.outlook.com [40.107.6.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A276FD2
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 11:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjbcxOb/q5Fv6JmPgrhMc1uy1Se8MCSoKRV8bXjj5VBvsjnKm3++Ehb+J1MqQ5gc2IikgMIa8w+mE5YcN1gZuOr8CWl7mx5DjdA151enpfxODLY6Jt9bhv0zl7fbcruujAJQxTLZ05ObFAinyU2emUPS1mmTy48iJljLa9e0Iwg1N5/TEnahLzKAlKuNdHsGl7FAj0st3LkFG9mgM8SNB5HZx6WLGL7u2kZhuBByYGDPKEJwbDGsClhQbYcgelPUnnmSsVw5UnFActIyT10yFW7sw+y2RJq5Y2lySUX7AS3Vi5c1rP9JFFhvRM6RAM/0Gpwe9w20ELkA7Gxaor7Ziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NN67srPL4596lQ20Rksjvz05BBG1d7SI/BFvTEAaXmY=;
 b=iGwubUnVLDyE0EXhzCYmoASXvCvZL/oN9aDWPsiWiClMA0IleGtGHzKWO2DfF0JMeIvmtvolL6zqiWeUv4iiF7aBXoIJK9tXeKVoeC5qVDSd8zly/r/0Tz9/Y+V1aM+kF3YruOYS5Rz53pXit45ogQKjDuXO3BsziZg9fAFRgB6N28supAZLBNXy1XiM3ae80AzLnMR6IEXNBOuagizxYMIYxFXUTK7zNxStlZvjR/AGlgatmIN95xwtPIyqUL6Zcg70nGMqRqliWQ0MtF0fDuVlshi8IYU/ROK9nwAvrhhBHCrCP7KTrc7xOc79Tgsqy88hDNINQ0F2guOxbrcbew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NN67srPL4596lQ20Rksjvz05BBG1d7SI/BFvTEAaXmY=;
 b=yACaIYzNxOEgBc/l8Ll7S9IPvgRpJfS94V0TFzWY81TaPitnLibOw2o8Niky6uPxooGSfEXLYpCqPWmdTDY7hrEQ1jTNwzWQLd7A3xxJ5QoC50+SgBwEsbBp80LlU3pMZyGO6D0Upte4vAgTHvOb8tFAQf4mxpeEMHGEBi4AJHTWzqAck+R9uwJ/eRe8wyPfz4Dvswrniru8HxmAHXus5WK28iJL9mPI8MqRV8ChxoAQSc9/v+OiPpb1FVChb+9xw5MzjlbfDNW0/0z3i5BRAqhjZL7auSxUylyQZ9XPQaMtvQY42QUF26bsMxRLvU9CTPjg+0Pf0W51l4ResuS2SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8023.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 11:55:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 11:55:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/6] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Wed,  2 Aug 2023 19:55:28 +0800
Message-Id: <b83a007a5af8092d9b617a5171f7ef2ef899f279.1690976940.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1690976940.git.geliang.tang@suse.com>
References: <cover.1690976940.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:4:7c::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 3699f10e-38a7-466b-6cf3-08db934f66c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lKo/oXtVKgopHB+UNcPmK6mn7fzMsa/GEi+4n9cef8Bvy55RPVD6XaYARUWfsUVPaauP9DOaFYDsNkuVk1XOjgRtkXDLhw6gappVgWB3eiNxcE4oXhmjHpRR6Qn02yd8DfN+ySBNFunqQJ1SI3NFj/1EThj/ju28aQQmISWF8uHlSCwpM+xGkWiOkfp8iDFY+ve0IC5jE3mDg9dXe6OMoh4RUW18krwgj4IKMXQkw1zkDldMBHrMg2NV2zs3XEHjAP47ggaZeO41qsHcRlTtFUx70A5iROBEBJzx9KiYni4CVYo2ojL1pEaZJaPwDro62lp2WAbBhsY7BD2hJY09IlPgl/QPC0SnaaDDS7dHVASshvJDSKhjbj5InAebu4/86vqEs0Cvg1u7erP+hOsYBBYuSzEoAbcUGWPADNon3uBZseyr+vEN5R3/MGI3Q+vuMUusU4qm8AszDwBDuOnuLNEgX8dsXl0mNzOraGnGx9vwaQWxCv1WcgZbkKzF52NyeXR5pfq0yIRfP+nx6yYWtBNCODZ5thDxg0uLH2uhhAFelEb/mrVqquFH8Jihf+g9Q9vmfAxaJ5WdV6xUrLHqO0bBt3LnD4urp1GiBMq3e20=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(5660300002)(26005)(41300700001)(107886003)(2906002)(83380400001)(44832011)(4744005)(36756003)(2616005)(478600001)(38100700002)(316002)(86362001)(6506007)(6486002)(66946007)(66556008)(66476007)(6666004)(4326008)(6916009)(186003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?weiPGl8Zac79t5zkfJTQxYePz9/b1EOdV9zqPHhxJPSG9afq1uT/5clPl0FL?=
 =?us-ascii?Q?hj4putBk1YIHJsoUe4A5Y0YyN3CJEbgaFEwu/VzfJx4I5rZ9iMCGpkbX8Hx+?=
 =?us-ascii?Q?UaS0oekdI+jbqQNlXc+bjx/sGYDDmgpi5El/oHsNargW2zrh1i2BnYKfpWmu?=
 =?us-ascii?Q?ETVwYDmoicGmsU8a0262bHQcQIUPwxukAWi8T+WlGkjlW42qHzTL+1Pz/Bsq?=
 =?us-ascii?Q?mjqiujJDPAGLs0ZOocEseVudxgGzX3HXN+QASbuNR9upqZNlhUrsDml92KhU?=
 =?us-ascii?Q?m/AJDvcr6/U6B1LDbGp+7uJgZhGkZbRjnnnpRjT8WoRB8HAhQ0uo0g+TtSNF?=
 =?us-ascii?Q?GqfXey+JP2pd/IBID946TkzNoo+/um/5zOrlyNqjSDVwfWhh9cjXZADXRq1u?=
 =?us-ascii?Q?zvFRG27POg+byjY4nLCFtL8yIPxDjnoW+8n95iiKEtxnn+28c11X10fsSvPR?=
 =?us-ascii?Q?JNt6TDqLirGMycFJLxdjHnLWigkiBshmMU664gR8H76jNo68au5+1QTgrYuw?=
 =?us-ascii?Q?/1tjTdF63XvDP1Ux/xgTGoVzqWEOKnzOg+vhdbvSwGuwnykRPeo/1f7M+Hqm?=
 =?us-ascii?Q?C6/F4M9XamwUbrx1U+bb/V3lF4+LZfHCWQHhsCP4HUFr2gZx/Fj/Ij01WX6x?=
 =?us-ascii?Q?SJcsgfEYq41L2a94e8rA6cNCBUrj49UD7Fx2NsOVCkt39n0Oex1/lPJIysi8?=
 =?us-ascii?Q?+RbPKczloeXZMbrc/R+SsyEnOn3UuV7ddfX62rL+om+515BPj7VSl1Bd26Bz?=
 =?us-ascii?Q?VLWhJcN3BvAFm6TCxjlnWyFzlyMCo7/DbpDV5PvrTGMpBGbqOpUAyBfskQ1o?=
 =?us-ascii?Q?vdk5be3apU+6zftSLe9fBm50Io5dne6WY5F+88xmgDoRigdLA//piSLQ5adT?=
 =?us-ascii?Q?kp4+BTvu3qg7Wgq1+HEy3Faq2wDUrZCdtlfafhTul/blPFndaqt+sXc4/ONK?=
 =?us-ascii?Q?Gpg17R2dr0P9lYvb3+5z8v1V3QAxGgdCpb9Vq41zOiMFJBhWMdCMvR8BNzT1?=
 =?us-ascii?Q?BGG+DEgUpIq1AdRCEzH9REcRpRnJvpqHwdJDH0GU1NIytRUw6qDaElf/KOvD?=
 =?us-ascii?Q?rZhGTOl9UwOZLj+9FIn04zZOyzS+8e+D8H0L0+kIPd7tZ8ioTN49GZszmVkq?=
 =?us-ascii?Q?+fmKn1yOjYeOZUndWaIjApKFcG5t+QtjRxEWa3sMWwGvLBMlbXF7gfgSWVuE?=
 =?us-ascii?Q?+7f+Otxw/53HD6v9pu6A51VqQj0EFjhYUZos/+XKF/lGP81k0b6YsK0Sa+nb?=
 =?us-ascii?Q?8zdM43YYWnk2pL76jpHmP4ccw3GxCJHy7q49Bh9ulnjS8i+/JyjP+Gcj+PoN?=
 =?us-ascii?Q?4kj+a8ckwDQKSxpHvEsE+ypvHyACvaCKCygWquahbuYFSHSEx38oJ61zMT0Z?=
 =?us-ascii?Q?9Z7Pds8R24ESujkJ3K/tp6RMcRDFzbtuePyc5admatnV5RQDECt4nKCKUhiB?=
 =?us-ascii?Q?mX83Al1Nh6wCLL7VfyNI+4SRXxJLo0EU+u2RZIwKJEHUTmEbzk+axt48BTpG?=
 =?us-ascii?Q?rGO9o0rTdQJXmW051msyoIb5JZfFZcS4e8ESgbmfQOiqX6ixutfFZ/SG2iEk?=
 =?us-ascii?Q?wfxLz15E09icJOvujPeqPlMfqChESyC+0G105BrH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3699f10e-38a7-466b-6cf3-08db934f66c5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 11:55:44.0278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+f/omQbGA/3uOB/knyejXjYkJFT0kX06dZIqk5TYP//gD5Ejb7VezTOEOfpNx3+mdr3in6fflMCGfL1prbisg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8023

Rename bpf_mptcp_sched_kfunc_init to bpf_mptcp_kfunc_init. Since
some kfuncs related "mptcpify" will init in this function too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 0cb25ae3ee30..c33b5c7b1649 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -171,12 +171,12 @@ static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
 	.set	= &bpf_mptcp_sched_kfunc_ids,
 };
 
-static int __init bpf_mptcp_sched_kfunc_init(void)
+static int __init bpf_mptcp_kfunc_init(void)
 {
 	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					 &bpf_mptcp_sched_kfunc_set);
 }
-late_initcall(bpf_mptcp_sched_kfunc_init);
+late_initcall(bpf_mptcp_kfunc_init);
 #endif /* CONFIG_BPF_JIT */
 
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
-- 
2.35.3

