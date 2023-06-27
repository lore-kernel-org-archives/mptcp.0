Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262967FA
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:07:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCZ5FwE0USzfshGLWLhDVT71fb7NpTbtK7vh/mU5V0j+Q4c0zq973X6+REipmQfV3e6tAFzIz3o5VivLQRH7H9GHzTNCu5EjQlQECCSypV8p+6ucEf0XzM8SD3098LpGmfCupDOQBaH8OGW7vqVFHREed3LM2TFzM2dEFEDqQbV6r8cSSspaKFjN2TGMLieGF2oadPBTlJHfu28bas4Duk3tngQwo1s6ACMdKUHcpZm3cvk2cHBt5WfAFzzQNVvxSvi51ULMK3CRTj71ZxV763RG7ZwCIPtsJN+dUzUFvtvSva3aU54x15Pbm8bP9J8dTgluIA2a0jCJdFBQGJy8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMuiez9ufG/+XvLADX8WSR/KEeQqiLIA21v17pE6eyQ=;
 b=BcfOp0wh9PM0K7k1YTTWBXV8kiBxLjfYM2WwTa4IfiOYolb+1QuTXSI2VbwsS6schN3MbKdMCQXEyeO3WrAO+gPj4+vlff2k1j6qghynDywf2+Fa2aEWGcDsZMB6SI4vNpiiS26+GfJbQmNADj5SuieY3iZjEUgCeBGHaiz8ih8xKgqUAbnWLCxaOWEVzHdHGXh1gCdjg7ZD2Rmyp6qn8Q2z/CQZfYpsH6RYJ/gPOP/laQjNmq5S7uWK1eM5ccesk7zWivrFzCE4fbcyzuZ8eY+FHQwA0VlGUaYczjOET7EJTkt7gc6pGg3M/hwtJZpuKw6CvrJoSpCgRCIIDzfqdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMuiez9ufG/+XvLADX8WSR/KEeQqiLIA21v17pE6eyQ=;
 b=iKfCI3w8G84NFjWPNCspgHol+7F8baNNXcjlWNzoWfCaxDKhOLXouUsgZ6POEHIeGIbBZLsT2Pc7uX5RmzR0cxlu2IwXc2AAE9kgw/MCDhYOCiF8cah7RJeLPMOnPR11BJOAxjgnw/dfpAlf+y8FwvMlY+iPVx8oQLemK9CQxcHsQusn5enusnqoYqvykrRRfeEz1vCrOHyeVS06vnQ56QGEiL7JRL2ZpC3ldx/CHrH6VQ5GVc+orLpW3z+HiLgWn+V2CQADP3iA6wOv9PUdAvINKE8xd3G45LUIy2K7TaoA5EPPyhA98MWTCEv4+RG3UV1SiYOOdj4F9CPhxtBPIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB9922.eurprd04.prod.outlook.com (2603:10a6:20b:67c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:07:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:07:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 03/11] Squash to "mptcp: add sched_data_set_contexts helper"
Date: Tue, 27 Jun 2023 09:06:46 +0800
Message-Id: <5694986e33e230afaa68c83c9e9fd64f7a551da1.1687827857.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687827857.git.geliang.tang@suse.com>
References: <cover.1687827857.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB9922:EE_
X-MS-Office365-Filtering-Correlation-Id: 221c44df-7a5a-4087-10ef-08db76aadb1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8hFkfubYBaz4AZOir7YTXHL8jhyiW58tMNVdlRxQqnIk5bW5TRKIOzNb32AhOVejfVRQRqAb7uHw6TbAPAKODjjui7zLkr409RL53b2ZoeOp/JZWXAjt4a+LHiKqwNfbGOOEx+F2uPiK9VL+weM77P56ppV6jjjEyGjcE81RdsYu23RlNnTyAM3m9qWltC/NjPnPeQjSPmc+Y+IwoxqxjuiXMllBPSAuxTBQFyPaYO6d8t7NKp+HCAfA1sIhvyVygeDVS+1eTDFqrqGQ7B4eIDoiT8LXjA8eF+Gf7kT/OxKppl+heQdYPNTK6/9kt4eIevWruVC3ORUQfzx9WC9FW9tJIefrb38ZgmX31dbtxT0SmPXLof6aibBJRrEPodScF4rbyIBaHZZJ2LvxrsVk97vg4ZcDW3IwEY4NU0LJMuBNxeMJUrHX6/te5gbmQz62COfv3p8NXOi9CT0xPEnPQu6ytQ/UGpm+Lw1Y76q8kS6SNWrlHU+2vcBPqEw879Lk3FiTKsbM6CWnQ0y+WUZcvIgM7BLaYhNbf+5yq3VpCGTgh2jaXqNrHp4GyF2viF9S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(186003)(6486002)(107886003)(38100700002)(2616005)(6666004)(26005)(6512007)(6506007)(41300700001)(86362001)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(6916009)(66476007)(44832011)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zcB6ZOHs842ZVlPnE+yeU7mhNSuXAVL04D3MEg5l2z1mjHwxJ2rNfY/K7B1b?=
 =?us-ascii?Q?G3okfnAiBnUEJ/oNo1LG7pXtAH7/Z3BLUF1zCvJQ688UFdJQVEFQCHXFzwRs?=
 =?us-ascii?Q?P2BU0M5WHK+xWRXX/+bsFcBR3DFI/l8en005LHw5VrSOFF2hcZ3uCvzKt94S?=
 =?us-ascii?Q?5Kz0ckB3gB6AygzHhvGKOOjKQLB0Q/yMcakix26jMQzKwth0b+JZnSV5jBch?=
 =?us-ascii?Q?FmAHGX9mjlH+EB28wPuYIaGflFUlb9Hjkbcu4LNOZ2MMIdTl2kEAKksLETQ+?=
 =?us-ascii?Q?6DubDahBlhVfA5DCDnKpSU2VGbnc815vJCCPFdpMYTQbmR3jHxiN3eoWQ6hM?=
 =?us-ascii?Q?qEkDXEubkPr21qWhA+j5LzkX1hYXnk/1GbNfMWkzM9dPSvEhdBWttik1bU0k?=
 =?us-ascii?Q?ZPsRW4xXFplLUIOVQsJP6YmfVucTCFVDgWzOIVRIQ+NHkeVaDY/R+RggwvCI?=
 =?us-ascii?Q?Ot2y/oEAnnIR27eSZgmAq+56YsxjBJrV9uCX88FHtjXHvrMr29an3/b5NHDs?=
 =?us-ascii?Q?Tsquutwi0PAgPSEDsnAsJrXCrlXd1v3Kqk12nGGWXgoEUdiGlVi82Osp/3YZ?=
 =?us-ascii?Q?p8Z0C7eys6QyRludstlmF+auCqQyX9sm5ziVlUbfQqq2tnxbpFLklDTckZc8?=
 =?us-ascii?Q?7mISLGPF1Nb+4a1DiTPB/bYJOk30ephVK741tgcODiIyFrBIGMwvvDzfyi6y?=
 =?us-ascii?Q?VHLMpu6qoA30KcDVK0C7BF9qX2UHxE/z23F8eAlFumPR+1WDqq4Ep4IZKxa0?=
 =?us-ascii?Q?RGlPacJLc5RI/SyhCaynW1H/ipiI5LwrHCpz5F99G/+Ot9i1ZQUUh1fDHtIc?=
 =?us-ascii?Q?fkB4LCbTmqIQ4cRIqaDCxEaTWkGJ+G8FkJIYVqc5v8ne9DZ6JNs8tdVx71lN?=
 =?us-ascii?Q?Zq/Hd8OMKStt2nPKaJ7avt4T+ItuSeEi8zKJCricZMwYEgBq3UzHoJAtgYf+?=
 =?us-ascii?Q?9DxxaWoiB/FPnVRvjVf+rrEDWTSnVqFeSlQ9pVzN4HBYWS9ECjjvuS18XIi+?=
 =?us-ascii?Q?Yx+V1jfsLJKYMLcVHIPrpRCfEuuXG/HpiHkOg2fWvL7JyUq09baMjnC0w5Q4?=
 =?us-ascii?Q?Z9XXNlnL3mj9SuvDJ96isweNBlZQYvew+DsvqPr/00ARJPCn0ZDJY1ctvZAO?=
 =?us-ascii?Q?OKSWNljCQrXcALaWORwLeEamAUlYgb7J5/t1qh3aPUABX4LZd6ITc39GOCSR?=
 =?us-ascii?Q?UGWUS4vJUrlHbaxgavnz7UWmVxPyXzXc38zNirFYTzlk/P3IZqFoYeGxKGGI?=
 =?us-ascii?Q?v5hUn1Lrd/KWPepQnSouCZf9PEW0e9u+UYGazI9mBnzlw9fC32S+NZKxX4M8?=
 =?us-ascii?Q?GXDFH3dUTQ3VVwcVWHuUa7fjcuHEihd5KVUWt8VnLFzmxHYfb3XiHTFTJWiQ?=
 =?us-ascii?Q?ehm3hjB8uMXGoo+SZoQPQpOfZHkCnC+XZ/LZKDVfYQz0omU0PiwGiryJB6Ud?=
 =?us-ascii?Q?V/6YAVukYP7H/KBILyu5XHlT/SCX1YTLSsdf2PX7nLrP7nYD34/F1f1y+Itg?=
 =?us-ascii?Q?kBNE25QHWXkN2WZJkL70VjA4ePrZEUTlApwEuuPhCpIV6Ia2XIeDxPiLzCz+?=
 =?us-ascii?Q?eLC4VYTMtacXuSHKzj+Dsz84gPQ3raxB5Wr1tpPR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221c44df-7a5a-4087-10ef-08db76aadb1d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:07:19.6995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sOGA1NtRsofJfQ1qJZCWJJjEioaXEAB9RjVU6E3/vNl/iD1iiXmCsyqaNa947ymiBFQGWTYycaLxZLHs+zCyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9922

mptcp: add sched_data helpers

Add a new helper mptcp_sched_data_set_contexts() to set the subflow
pointers array in struct mptcp_sched_data. Add a new helper
mptcp_subflow_ctx_by_pos() to get the given pos subflow from the
contexts array in struct mptcp_sched_data. They will be invoked by
the BPF schedulers to export the subflow pointers to the BPF contexts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h | 2 ++
 net/mptcp/sched.c    | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8c9b2a03dc94..cb2f34c8ed09 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -664,6 +664,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
+struct mptcp_subflow_context *
+mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c7c167e48d72..82665263bb94 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -108,11 +108,20 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 		mptcp_subflow_set_scheduled(subflow, false);
 		data->contexts[i++] = subflow;
 	}
+	data->subflows = i;
 
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 }
 
+struct mptcp_subflow_context *
+mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
+{
+	if (pos >= MPTCP_SUBFLOWS_MAX)
+		return NULL;
+	return data->contexts[pos];
+}
+
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-- 
2.35.3

