Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2079.outbound.protection.outlook.com [40.107.15.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8487A405ED
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Se/6Ect9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbQNUb7BOtcgrCh2nwZ6sj+7K8/n2oADUhmukMPkc2KM6a+fkePKg0pgp3aBHj7zJDfed/1zM9vhbRTVUWu5WV9Z2zrPQanCiJYD7fx8J/NgNwPjlciALh/PA843TFt8iZRiM9F0s8BUVLR5C92Cqj4WA5iM10aS92l23RKN8UJI4fwdkDGjbXEg1a9GuMwloq2WjEXfwHWLte02QT7neFKdhT/4LcukFCwYK/82VcMjcEglD9soW+leLuuI9roc+vgZjrrNLmfkR3BXtsqvpHTZvT8+9nJuTDLjn26lb/JSltSc84kcSmub1Ai52LYSnqMh2R+mlAzHddCha15ywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Oz4uWQpY8tWOYclP247E2z0aafyujG0vIIFGZDS8b0=;
 b=JuMqzE754xvTaI4cJBqeuHkif/jyUCTGPHu5Bt8+PGKDFnx25DTau1L1VhQVCUFwtSYTxajABOdPb4FTlAHh+UWh3LLnULfeZuRRLTRxmPEBZ10U2+Khb7PbxzT2XLcWOT1Trqc9xPjr6OgIXn7ESQ7s8U9CZZ/FvY7Yp6DB8P4sMZt3enfkxPvZs1KXdLPtRpstWZ5X55tta0aWt09qbYUerjDtbQV9+uqCQ3qXLIj2ffN1Z+7LPVkWULmR/pl/NmnH7pe/KX76+MNC36Y8KPZaH+h4/HVOSy30P8Cdb55vQrEiqNC7HZZY6pww0yovEWWffydfHucwbrsT1wIhMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Oz4uWQpY8tWOYclP247E2z0aafyujG0vIIFGZDS8b0=;
 b=Se/6Ect9AMCRv0MK1VZp2t2jLLLL05+TvLSE2xuG4+a7GMgFSjF7EL+s5qJ2avwFl00Hu2qqYgRjhlRsDH8jLOUq+e1V85ajkN9b3D0kMFr37483oOyH4h6q3zguQAtgLJJfsREGs9EhpomGZs0ok1mM257WIN2WydGhYL2zaUd0OlsX7mO6CGQSGGy0uyCnGuY5yplmaIc87ktupFdIAKhiwSJGWptaPjSg520oeK5sLZ0jPAo6yOgW+vWQSkeOFDbQcHT+LRROjHPuR22I97OnXDXCQnA0ADBlhucyUniEV4Q9rWol1vxFmPHXme25LP8d14ZbrQkVCUQp+15/Xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8704.eurprd04.prod.outlook.com (2603:10a6:102:21f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 14:56:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 14:56:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-net v2] selftests: mptcp: join: fix subflow_send_ack lookup
Date: Tue, 14 Nov 2023 22:57:08 +0800
Message-Id: <f343a6ca7d627b4092a284dbc6724f34e6f8c491.1699973683.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0079.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: c57ada64-0688-45fa-580f-08dbe521f1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bge8DT73f7cnd313Y3+1G9R4G8kk8ttTmTmxWCY7QVgVpMTk7Zt1hm/ghNOJMHPdl1sGpIyMNBXhZCMaAQlFhDM9Grw8peOKCjIpcrj95QA2NV2t7h30TRm4ehEXseEOgSg81FSFtoV30MEFGK9W1q4mN3zT7KK4AHkw1tsn7qAfykbNZLsZz8GlJhSC6UoPhLlEJJy/cbrKiKolSDAjaslhXr/QjdU7AvhztPw6aE+BI8J8tzs56qYsgw/tOLTKPc5kNzp8fuwu4qVpaQ5EUwk4xK8NzonK2LYYmlMRXNuq2YA9cBGQTGbHFP1K64F0lID6mjBlfezJESk/wMeU+1OXTsUZuSJlH9Ac65E3WYVWFDtmxCea5BlwwpA9ZfclIefwlcDspU8+oxz9U2AZmi6zLtyQPDB2kbA9067MlmXohxHb69V0OdF2X74eMeZ7bJPimyyQOcDZ3nBaLB0XGYHkjN21AaflVfq3X7Xzftq6hiL9bVqzWpS7DyxWDz5skte2rVmX+v1NjmcxrVacdabVro7XSdnFyQYzkunmLUDSUa5MUZ68YKTW/rncU5x/26ywKLxy3ZLIfvjbYcW2FX9LIhPREreSuqTk8Sp6HyU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(41300700001)(8676002)(4326008)(66476007)(316002)(8936002)(6916009)(66556008)(86362001)(5660300002)(44832011)(36756003)(83380400001)(478600001)(66946007)(6486002)(6512007)(6666004)(6506007)(26005)(2616005)(107886003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HlXMhZtGd1SiODycTKUN0KAMHmmVA2fE5jGpRlEFFp7dmOCo87xUP6qSTv/s?=
 =?us-ascii?Q?lh6sPJ+AY9Z9lmxdqjvlp+stbhUjfgn7B4wrG7Tu1ZX8L+DOF4rfOzHhTJ8w?=
 =?us-ascii?Q?USw/NpX6Lf45kSXMlni1+KsjRBZXCcAzSh83btKLyDBHoEf7OsUm47Rydaor?=
 =?us-ascii?Q?ZmUsxM3Uga/4PiTFgzV0GGvkjg+bz6qZp8eSBd5xHlhGsVOnD51/FVm0cLg7?=
 =?us-ascii?Q?2ar1HD8Fx9bR0W2L2bw7s4WY24ZBrLNjkQ0ym4VhaLHwvu7Ypb8Kr6psAiUa?=
 =?us-ascii?Q?26kavFGOCwdzYjlWj5C1sR4hvyF5l+zBGz78p+m60pLPQR3DVdzdxpwM+gsO?=
 =?us-ascii?Q?fYpwp3A3w8M2zqq0hDF7x8QbImOZ7tK0Blr231Xhn3grvKLF7X6Mixv+kT+j?=
 =?us-ascii?Q?BEWcnWahE1hqYhp289eSaj0uK8CW7PnxtNLx/XwYWXEqtkKjIsHEmJlE6ZQX?=
 =?us-ascii?Q?q1Mq+Ulk0mAwt3QPIQHv3tty+aMh9jObVaqv0z6yG/+lMj+FgSQZ1dTGS7UD?=
 =?us-ascii?Q?Zu7ApXbNMJjSDX4tobDI2XR+xGeV6VBsZBlKpcMJVWiJjrnmlm7lht4lEP79?=
 =?us-ascii?Q?+MvoeELqAHh4J7T5C1FjKBqOmjOgL3t+cTIRdSbJ5VK3z/iFxAHcAqCBKr1H?=
 =?us-ascii?Q?xDqpOQ9MMWwHzvO7SnXNCJzhdFzsZww+FNKuBV87SVPG5tMapO/xP9BQbt3J?=
 =?us-ascii?Q?LIwC1V7DZlI75CxkuLSNFRGAbZHIuG/38F+BcB2v8H9BXAP/G7MdN8Ansrk1?=
 =?us-ascii?Q?PCslgZ0NgG8XdGZ2U+yaRUoKu6ZaVXkAle2x4lA8MyaipT+ETWaU8quW4k4j?=
 =?us-ascii?Q?BRYuySdXadHGumewVSQgDbPIzkQJ78orKUFC/0eZDts7Q45LbViUs//ux043?=
 =?us-ascii?Q?YQBa7ezvbISou3y69RzT/8NzCK5MDtT9k0RfNOfRDymPIt4ndIW38+OkSqSs?=
 =?us-ascii?Q?9siZpMTO/5j+1g4Q9G+9eueELxt3GnHZ200ssl6M4xQ1kXfiiPPZVYDczVep?=
 =?us-ascii?Q?uMZCe0p8PZV0eEam611pTaJD0AEjMBgf3SP37NuhYCLiPxLrmR/CP4p4OjtW?=
 =?us-ascii?Q?TthEUGtQSUKeeK4qUryOIIEe88r7mH5r1969e+oM1ADrcocRyPZiy1YaEd6M?=
 =?us-ascii?Q?f6GHaiSRygRPwsgyEUO9X4mJ2dxa+cCUW5SU+H/6R5S/YYQzyZzod2QrTtMn?=
 =?us-ascii?Q?JiOd0i/9txb+QqnV2/F+K9OFLfObwNwz6ENPQdJD3QQHT0lo9I+4tXaqpsQl?=
 =?us-ascii?Q?tTVurVgEllWnfvcQsTsO4gHACLfbdAqe935a+ZLd8aZ6VAn34j8qWDK3W9DA?=
 =?us-ascii?Q?OKqQS9fUEDFR1TIt3Tno6jgGVk6JyLMFAJ8oql2nckxA+NHDAvo5c5NHAFty?=
 =?us-ascii?Q?4WaxZ2stTMNqVrW39KhsDUnWjA7DDjjgzwQYZRl6HwrfkDOFVvhxP5+IPU6T?=
 =?us-ascii?Q?zCuHxwHosSFaJjwDUjZbGt+YKe/nmYGXVFDdIbK4YlaWZuMrmUNeO/lq4R3Z?=
 =?us-ascii?Q?7PYLqPGhweh8JTcUcPLVe7jHCQjTCSEY26zkt8KPSZ9JGHB0yvlpnuJNP0BI?=
 =?us-ascii?Q?KMDOpXSwPtJELwMzaQkQU/ZgmsVSZ/2Y2C0xY48u8+ZVjZkl2OgwiaZx6NmI?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57ada64-0688-45fa-580f-08dbe521f1bb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 14:56:55.7232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78ktjOPMy9Cvugerjq8EG/4Q+NQ4iFBqliQ8fys8m6la7M+HxvIiXPdlHV4a8Gikim/+RUgeZ9MKXAEnPGwGcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8704

MPC backups tests will skip unexpected sometimes, since static functions
like mptcp_subflow_send_ack may also be listed in /proc/kallsyms, with a
't' in front of it, not 'T' ('T' is for a global function):

 > grep "mptcp_subflow_send_ack" /proc/kallsyms

 0000000000000000 T __pfx___mptcp_subflow_send_ack
 0000000000000000 T __mptcp_subflow_send_ack
 0000000000000000 t __pfx_mptcp_subflow_send_ack
 0000000000000000 t mptcp_subflow_send_ack

In this case, mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"
will be false, MPC backups tests will skip. This is not what we expected.

The correct logic here should be: if mptcp_subflow_send_ack is not a
global function in /proc/kallsyms, do these MPC backups tests. So a 'T'
must be added in front of mptcp_subflow_send_ack.

Fixes: 632978f0a961 ("selftests: mptcp: join: skip MPC backups tests if not supported")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v2:
 - Update commit log, fix typos in it.
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1606474232f6..6fbc70332caa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2755,7 +2755,7 @@ backup_tests()
 	fi
 
 	if reset "mpc backup" &&
-	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
+	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
@@ -2764,7 +2764,7 @@ backup_tests()
 	fi
 
 	if reset "mpc backup both sides" &&
-	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
+	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		speed=slow \
@@ -2774,7 +2774,7 @@ backup_tests()
 	fi
 
 	if reset "mpc switch to backup" &&
-	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
+	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		sflags=backup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
@@ -2783,7 +2783,7 @@ backup_tests()
 	fi
 
 	if reset "mpc switch to backup both sides" &&
-	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
+	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		sflags=backup speed=slow \
-- 
2.35.3

