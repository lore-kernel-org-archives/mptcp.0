Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130052.outbound.protection.outlook.com [40.107.13.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5301E323C
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 06:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ri5wp8Z+xYUGO8PBmwV0kICLVdAVWFuzZ597QSqtBe1ZrMdlSStvDHaeCkK3tGPEyBTrXm32PB0ACOTLhxab8Y3XZ5m8A3Wt4HN9iTj21n6NxHq8ivWbjd3ATSZWIOy9d/kMc+jni1oMsqLKdHSvABcMLsucw22Qt/LWZxv8tRXyRt/T5m1oIBRYKQoSgYRBAqwu8ltNxUZFyRKwjBzxseNzseaaWP5SfBLwGJ2aGl7l6Rxop5/clMqHPXITaQnNGEhJJ61CsWPGH6NHJCAcqLaDOflJC16l73UH1BjGmFVlx4QjGXLA9bAsDZSVDji7wmNH184/duDB03qXNaMZRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PVfXsdGgJPJNdmc3V3dkJQzFVGqb+WIe+7PEFL3m80=;
 b=DPAGdFWwx6ZeG664/FXQBntA8iEJhobIloQqE/aVVj11V2QuUIr7ZSgARVhWNl4MTRBMhUtFZLnpTBdG3mrNA+j3YLrrb1FICBbhTGuPvljJvaIb2IvhZxnFb63ZeCLiq0Zy9AqumJ4pGAcRlcwZpy24UiWEe6u+mkz+O6+Deamlt79hr8K3Tl6aaTB8bFEHLSQAuseV85GxLpFqArnEy2BVJFaFnhoazPB1ACoDBYr8VfYEmzWgJyuUmIEThnazC3WwwTtQiJt8813F0aRvVz/0Ff1k5L8sEB9iG4Ju0GFNhkAZ5pIgVM35bP9mt5mgfGfrsLdCdmzlC7AWUaJ1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PVfXsdGgJPJNdmc3V3dkJQzFVGqb+WIe+7PEFL3m80=;
 b=yo6ustWGsndZ5CSdr+7I/WSnLbsv0P0JalIpaQ8JyIuF55o1oICM6Mwhp6i5q6jJq7CoHziIZVIb3vKfPnFVpZNWQ6FzhTrgT9a88plu+E5CHpXPFYMcppJhwjprhuUPL5HnxaDlAPusayTbyKC1j55yFGxfYNMxHc4VLend1QwBl6HlJWB03BQtR4TSZTXFH4oUYuOHODHEZOWm1+zP0ldRGN5g8WmA7RREcMsdewfnbo+OxidYej+b3+r8uhtEp5hiZhaEg57DdWKZaOv800mM7mErk+w/lu1wh4hdRftqT6P1KF98hho6QA/D8VXlRw58V3uqjKpnlYmSjMHXLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7948.eurprd04.prod.outlook.com (2603:10a6:10:1e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Tue, 8 Nov
 2022 06:45:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 06:45:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 08/15] Squash to "selftests/bpf: Add bpf_bkup scheduler"
Date: Tue,  8 Nov 2022 14:45:07 +0800
Message-Id: <ec7c140f67c40e15cfaa989a6fc1b85535065266.1667889809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667889809.git.geliang.tang@suse.com>
References: <cover.1667889809.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e84e42b-a1e7-40ff-3cc6-08dac154e218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	12yALgay9RIIMZloNV7TaVQH0NKbC3wPjlnxs1O9GTz/xvy4X2LsahyH/rKIwgX2mp1wEdmWDAGo9YWTM9x5TTIkpg/7XjyXmiBVlV3H0bS6e8LD7Advop9opMPIOHaa9FcW/tIEyB/Ocq7C88+yc837CfHuAcb5e6BsLG17UX1r7Niozvgr2HJp08oItbqQCNJIpKFcn3yh/iI8MzuATIYXLyc/xvdKf/3II8fThqgQSltHjWCHiR0Gy+un5L8y//RNMlYM3MfhKVxDqFY7cXy883W6JSB1OPyo6sdb7PHKizWTmCXc7Qqv7edpU5X4Q8JfOJXLZq6Zos3Fq3ujvi7lWquefDLGgCVQh+a0EqJ7c+t4lExKibPHJmdK8w2owXKbMeAG8s/I8uZpHFVm26trjUr1XwKvkQ1K0cgfdF2Rv0y19SFTvQ43vHzCmNk7j0szqoZbhHU7arVI4/BJbAz0EkP+evLchPPYexU/Pljh/0h0+kxp3Lr+lDT+++XTmw86X3JRFZysi8ruAsO9mo3FMyRHii25wQVHOadU4sy6QF50GHB5vUcUi6Uc1gEMz26nEzdF/bWlbBdtXDn1X+sikOfA1bLrtk2lk/CJJsb/YHIpGq2D+pNxk6RUGOUpy0GCS1vKOFiktGq7Dagz+g/TZGeN7JdR/KbHncQdwZSVajFKq2t5ovVqyWgxjSn0iarMz/P4jCl2lAygXXhHqkmxhUSNqYI322qedFYjNqgMSObTpb8tZrLMSMJynKe3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199015)(186003)(107886003)(6512007)(6506007)(2616005)(6666004)(83380400001)(44832011)(26005)(2906002)(316002)(478600001)(6916009)(8676002)(4326008)(6486002)(8936002)(41300700001)(5660300002)(66556008)(66946007)(38100700002)(66476007)(36756003)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jpKWWLjX9EAoFGqAfPWLQtiiHyqG7IFEMTXEjTJwhnnwjGeP7tuq/YccakCy?=
 =?us-ascii?Q?QaZo7AcOyP2ahbByJTyl4vHawr92i4i8SDxpZxP5ba9ZhTO5VhHohEAKSCkJ?=
 =?us-ascii?Q?cMez7RSz/vAY22AJHmGUaQMhog0pSpFdZunqOCocn+oIQQ+IyJW36ByiR7Ox?=
 =?us-ascii?Q?KZb04lF34ewNAoP1RsOqAteEdVRFKogDrXmwXJkeInPJem6fhQE0+RIUL52D?=
 =?us-ascii?Q?+hzt3vbJ4q007P2fF25aIbahrCuJTyrlML8+Qfkl2Laepk1M9JmgWQlJldiT?=
 =?us-ascii?Q?1aq28ElhGewJCndf6SRtiDQJeQ0pauKdUfELWsOixvDNwPW3/MMWq1G71kWb?=
 =?us-ascii?Q?n0R+NzKmrwOS0bgsC8M01cg1X7X6CmJ9k8CkkSktxhrSNdgRWqGbavarCggI?=
 =?us-ascii?Q?JloKGm0fFHUJrihNrs5h7xc5SwZPIy6qCVsi423Fb18FYXcMU8ZrvXZnhFJZ?=
 =?us-ascii?Q?NMcUmGEZP3VlrZDttv1VD75IQxdfHLRHYK/9WUettbq7krZzcBDI2Y8oAq9c?=
 =?us-ascii?Q?woAJ4oOwhQvehDYkmfXqq3I4hQ8f+pHs+B6b3I1NC5lmNE+vetKEv4CUFtzK?=
 =?us-ascii?Q?OOMJioYEm3dEZq0ek3TcwDL/aJb1v08CmJtGTpNHz3Afk9KqtP39Wys4+lUt?=
 =?us-ascii?Q?PLllRSVgY0udFx/XBe6DR+2IML4vof7tlhqBGutM86C8U3H9bQHUgN/gqa/Q?=
 =?us-ascii?Q?j7bt0L15gPE222Rho/fJw5roLxNguu5b6MLbGapoywQkJOelS4+4WlVpRxow?=
 =?us-ascii?Q?9NSEkz2V6R2VCqnqHFWfSumkbV0fjA/avx9Z+q9Pk0xRI8tN1WgiknscVANu?=
 =?us-ascii?Q?HExjbn3ShyKoaQQl3OyMUcXRydpM13cdUNUdAbAU9PSwMHiRwfy2STI3xIp4?=
 =?us-ascii?Q?pqBp/YgjdGV4YMRBNe3tScIclvf1sZ1L6XpXdX/xuij19TbJJVGdCtMfSKLE?=
 =?us-ascii?Q?GmH47xl/YjMLve0/P/Fgcs4ybbjPrh/WCwu7G1hgOGmD1voqE8JKinWAdz6J?=
 =?us-ascii?Q?yzER/qTiLT0MtBeEI/aY+iqKOeRkR7F48UFUiVoccjcchzgoZfJNuGEEzeV/?=
 =?us-ascii?Q?Zfs92boK6QIK7Ps7uiY9w8EcT8noXiKIR1gwMo0D9FVfS1oSROGg+hCnZJoP?=
 =?us-ascii?Q?L8xlPbOpd68vVJF0D5MrBWjNcTqNXVCgJp54BWNA6LlySnI2o3KAiQzLic9c?=
 =?us-ascii?Q?p2GoN4QVFHBUDzD6t9FHcxNbiwpVvOrngWOPXVDvq2e/MVc0VsvLVfI/c62W?=
 =?us-ascii?Q?JoWl0QGHlGLJq9+tUXV1hRrBYlz6EVKFr+LrIcaGrHTdJkTFcoBiGI1/teZe?=
 =?us-ascii?Q?iBoahIV4hZKCXEAIoArbCFEnWspv4hsCUClrFB4t8LtZDjO9nFry8fa9UzXr?=
 =?us-ascii?Q?JwLayMzFXgVaR8ugBWe4HmaETt+ivSx1bgfPI0WQLWEVADf/w9ABuTJSKrW8?=
 =?us-ascii?Q?qW1Ck/rwY+0waXHe9JoobtSssrlwaY/iViq+gr7YvrqmGzG4B8T/7287bA62?=
 =?us-ascii?Q?/xrVxWYI0XG1chcMIDDkJl58ECl3MfoMgBG8Z89D57YknqwSwAFamYMOd/xv?=
 =?us-ascii?Q?DTt0HhuRYR4Dmd2sBtVCUxJVXcZtmy1mdtnLXcjj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e84e42b-a1e7-40ff-3cc6-08dac154e218
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 06:45:54.2093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBbjpma5r+qZV6GMPEeEhoSgZT53lbBASD5xFj6C7y+y/tOQeGHzrwIdkR8ZaN0egnPGthZUgiaIeX3Poj11Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7948

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

