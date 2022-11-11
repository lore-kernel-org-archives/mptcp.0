Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408B6652
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 07:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ax6wsqmOoMkdDsjA4NXxEHSqWvLuAJiJ9LUZD+ExObIiJqHd0rCQUo0ov9eV/WGfVSiXVJxTUYlVQc7Zz0PsWwVe1g1Is1m8do5EKsdAufU6A/2gHh4xsQdGNDA7NLg55SrZMN0u7CQ6lEsGFMDbUfCAWSH0reyQNRR0UdqW6K9BH8KySYTd2ar79Rm86gcTSgFD9zn7C09efHO2nY5XFArB8NB1/s/0fGxU6m984AD/vP6GEJOc2BNc9tCKVC/VI/0eMxmP5KARrg949O2cjeIugw8MJf30W/gDNcSDJK0tDVdjkai4pT/nO2k5zhcw0BCLWQzgmMB2Vh2+7qiXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PVfXsdGgJPJNdmc3V3dkJQzFVGqb+WIe+7PEFL3m80=;
 b=bJOZsiMxiAGu6SyDaxe0ZiF84EfKm1lc2FybJQWuAq4jUeiowlmxr7MPAtv9rjGNunJ9MmgiR6D6/au6IgY+hh4Sw5Xs/jK4K21THTPOZunC6SHkVeYYSQSAcyrvSlXUuGImcIpGEdGB2eTm8vhsa4m5CQPOVFjtlWdiKc0DR+6gT/otwdSuurcEYgr2JaRrm49qhbKzxQRH5goShTFEE+TQSEjwctDsOqZ8Gh8uVH8/fSJ9u7ShH0Ix7FHx4QxTUZQNah9WQzNtgXBkg3sqojYk1pU4aQQOYRfNfIT16KdxXjp3ZmzQqSqjdM3cM9/fuVxCfwSR3nkNCDAvKiS3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PVfXsdGgJPJNdmc3V3dkJQzFVGqb+WIe+7PEFL3m80=;
 b=I+8PVLpF/VIcgMc1bgURISPCqlcpw1BAv3XaBXEFcOncvcTjrEevQWUleE9BhbBUCd0XuxSAyEOySd8gPLW1bHh47hP7t66Qx3Exq57IAo3bWqfsOAvBkCieV3xfPbmFLfcHZC2n/DOr7scNarqCOuLX7Z9hghPEVZlBUUNxEEpI/jD9DhlVCgc9StK+/M/9LBaHPXS0/Y6OoRQO6HjU+1yWjqicCmJGCqC2IQEPmdNs6TMO6p4e2MDLWqZO3bhhhuNzwNUih2q55LMAlwWO3Sq6J4ctAT7V22R0rEbXTplzQTbG925RHDwd5Iz3YF+KpvSzl+ApvbwcoKmREIa16Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7521.eurprd04.prod.outlook.com (2603:10a6:20b:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Fri, 11 Nov
 2022 07:48:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 07:48:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 8/9] Squash to "selftests/bpf: Add bpf_bkup scheduler"
Date: Fri, 11 Nov 2022 15:48:03 +0800
Message-Id: <47738a71d94c64b7c2da82aed472521b9dabc700.1668151131.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668151131.git.geliang.tang@suse.com>
References: <cover.1668151131.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: a572b3c9-f9e6-4233-42c7-08dac3b930aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lembgTut8C2nuBC6cmF9c7SEWX5rm71Ov+HFrPM4cgGRnShyg8dTvkXHVCQlIFYYJyxiGWQZPYY+HOShLfXyGm87CWIL/Cl8FwPVgzKC51o/FBaiDXrGWv/NlV0OfqDIYgg53hgUK6pnbAzcnNoRzpstjq3cBrYkeKO/C5WlDg2/+jvs3mHnQUpfar1b4yZKUY0lpIDTp7o2b9VI7T+WjReZIRo0UP7Md1PLCIqpzbo9OMyeml1V0m3eLQmql1GfttmpDpLWSsOSNxGvHs6u4QzKB85rfbgzHKG4A+FzsZ6MI2EgP9aH5IpIu+z07iAvbupYntUcGsayYSElx0m2G+b6umaD24awM6agM8IqNd1pTAJNoB88TVmuQ7JcTLbZ+y+xv+IXxeBisOJf8e8ksEPizrJEVHQfsE8z5mz7+bxjC66KI1Zbx2IfKv7iDx25+lUgwRGvmwmCGJlf0UtCggx9RhVRCduKs4TjPHsfv7jjgwUpF0Aqx4f38O2HL/gIbf2OytLor24b1imEwywKc2/gjuE8tS3bs3A7uO7AzB1z0X9I2hpTexXWh6+hVWfSudmAnXIMhidqVPlCZiY0dJSFBB2uDMLJJ9yy+KD4/b905VYMdhW7dMir5CZPPIhE4XLGJVvvSVEu+8xCVdYEu5mF5Y/6vRryXAbIluJ+feNEyw3LoWeX4tgNocP+TjKRdLlS2V4IeYVH5XjCHEnZ0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(2906002)(86362001)(83380400001)(38100700002)(186003)(44832011)(4326008)(8936002)(6666004)(5660300002)(107886003)(478600001)(6512007)(66946007)(41300700001)(26005)(2616005)(66476007)(8676002)(6486002)(6506007)(316002)(6916009)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tU9D2Lx18bUzhKLlxON7UBRZjeyJbciQ0hcugRcclNQoNuorCK6TvZirX322?=
 =?us-ascii?Q?VgiKb9ln0ml5bCOr8Ka5GZfa+9wLOAJqUXhQOWflM7JwmZ1xNOb3bfIFvpYt?=
 =?us-ascii?Q?MmI3dY9GdFFev8zfy13qda80TaeDGZof3hlhk9L97+v6/ty+WiRrHX2hfUIC?=
 =?us-ascii?Q?ygcuB9j9b7ecSComiTVhVxROG2AcVgBdY+pxjdei8eb+M28ag0gjQ0PaeUK6?=
 =?us-ascii?Q?5Fwe9xdTZLdtkmMSgYheiOWVOo/PDSS9y9fq4Co5Fa9foeIB+tgjVNZM7VgF?=
 =?us-ascii?Q?vkxnrS+IS+5L5zIpd90EhzfUSEg2MWg2N0Pt3D29d0ps9FTUel6QtiKMEdc4?=
 =?us-ascii?Q?xN0D9flK+g4k8bdeeEMEjxFE/c9IAgqkvt0lfVX12x4htRDNECAL2VEDAUFK?=
 =?us-ascii?Q?NXM8YPKsiHoMycWJQVNgafAolJHU2C7XAYpfuHecaj8nqDhhyKhp0nYAFCTB?=
 =?us-ascii?Q?jZsnkQAr9bFg9OZupgBSpQ6N78n+QkFRNNe0fYmRDwhSnso0+h/80ydKJexN?=
 =?us-ascii?Q?bhujtofrYXl9P5kbgw/4vcw8+BJ2WbttI36DAi9+FvBZXOUPJMXP4S5IDoGj?=
 =?us-ascii?Q?Q5SfcjxhbsEPOpEiGBwiEZeUqDLFZKRlAnGYhx2v1CWE5oRk4rMCAJZqboWh?=
 =?us-ascii?Q?2i7y7tCXnpVatMWl4sODtDHBYlPR9cWKRThdNVJWraVCUWawoVTxXMVBG7pE?=
 =?us-ascii?Q?xDtCHzj55JJSu5NQEd6zH9edmQmhmmhNIWj9+U9GeMaYcnjLcErzzpXolsq0?=
 =?us-ascii?Q?E1pDulBHzMoqflvFe9gO0U9xju6tL1v1hHpSwhLg2nsw6jJJ0c57CI1mp+e+?=
 =?us-ascii?Q?Bp11WDpBmgdFKjtQDLUABi3UbzAyer5cpFuHIwjOxPcRhhvdBYwHOyTqtjUS?=
 =?us-ascii?Q?2LN+pW3EKCP8nJbA5dT7AR465LGaHyqW35cBqNaQNvarGr/sg48vC/IF/1d7?=
 =?us-ascii?Q?13troYUgcdUFjGWVWjRy9z5sTcorIXoJlFd0+h1MHW5Ine+0dnaPG6Gm+CT9?=
 =?us-ascii?Q?wxfvYs+zogW4lcM/IOfYNQVRHirmyHoRolSCezx/5hNbQfZS5qlMBYTavECQ?=
 =?us-ascii?Q?WKFpgsZYkwcsj1VsUznqp8ODFo5eWaalgpAreAOkgUBD/5uYAtWcjkFFYvEF?=
 =?us-ascii?Q?zgtXgy4sGTNlyq86vQ7XgNvFk592yi9HnsoxglRbViKPFSBtNJFbTjdOlFaj?=
 =?us-ascii?Q?ekrWKXvcn3RmC7a7paaZlnNxt030QwYoKgT58/r5E6rH1ZS7ajf0Lthv8Isl?=
 =?us-ascii?Q?CNlzN7T3ssEYk/Nv2XuAcoFfvZ0FQLkZbKod9MvFDx/ndVTTKx2ix7pU7/pT?=
 =?us-ascii?Q?W97AITndU0BEzFhFDXDf89wqG1FqXSMiTn3G3d+La/AR12TYgYhCq59r9gTz?=
 =?us-ascii?Q?2QqPRCMpEqi38awMNf7V+tjG+rtauat1J3IqsUjGrHyNmE1Hgg7qH9a0wFtN?=
 =?us-ascii?Q?M87YRNF+0tbVQ9eFzrqYEreuPzs3jXS2REvfh1ISNdUmXjgvIkc5euVTEKbB?=
 =?us-ascii?Q?6mc0TKQ5At03Z0KmgAoHar8naBA30a9sp+0iRjVyPdZhhkkI6WzNGD7KtZRj?=
 =?us-ascii?Q?kBoxuWx375E1F3BQbROb+9xCl9FLqV9RC2+u7pSseUOf7BOTfHHDOnWhQQ2X?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a572b3c9-f9e6-4233-42c7-08dac3b930aa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 07:48:58.0114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ul2leXViyZiH87fHJ+fp+AX4R5y93YCbrLF5QXR4raITG22TsyhetOInuN8OkQQrfoBM0bUji4ddNLyonQL2Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7521

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 949e053e980c..b2724426676e 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -16,8 +16,14 @@ void BPF_PROG(mptcp_sched_bkup_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_bkup_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	int nr = 0;
 
@@ -32,12 +38,14 @@ void BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops bkup = {
 	.init		= (void *)mptcp_sched_bkup_init,
 	.release	= (void *)mptcp_sched_bkup_release,
+	.data_init	= (void *)bpf_bkup_data_init,
 	.get_subflow	= (void *)bpf_bkup_get_subflow,
 	.name		= "bpf_bkup",
 };
-- 
2.35.3

