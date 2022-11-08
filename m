Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130052.outbound.protection.outlook.com [40.107.13.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3C0323C
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 06:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzwD5nOBrq7uSUE7a6LUnE30NIIWomtSQi54Ig3XtfBpVcUrUF2enMPyw+Jn2Q2IyuIAsy041lOrf9za0nE51uZx8fs2SNCKM8SYlTCDcOSAqlGWtavGOczdIiyRf93Neq9CIRcHrgus+z+bdt0ubTFKNuToFVrJ4FaGjEcTr2sWJtHVbjVoIjZV/WndxmIK8B2PC2Zt4DcjMPETrqX0v85bTZBs/ki+QSa5QTXM3VxU83Wq7nSAM9Zj2exXsXYnkJ432QBzPYG5/A4LmzcHXt+jrv1HgefHagfhyR/ofY0L4X6E8ZBRxx1wLAo+jaeM9oRZFzAx5RkZCnNOAuLaRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnDh4myN5PG5rA51tFqnEO/Baj34uQClbwjqgpGiogc=;
 b=htoLajirOrbz8kW4b43W0ck4rIeCbGP33FXwCHXP/LOzqt24izjlIjPUJeEy4zE/gXIpv5PGVoVJph1+12T9uCTl8px8MCyobZes01EZE4rQ8f/1FTUx8ppc1haOMgMdwcC00VPSdrlvMtC0FNCMYeiy0e0e+HCqepzMTWcaN7VgDaHs3ZyIJfGZYLkZBmX4n9MLi0F5qY5FILkaLtT/trKqpnIGlpOPbWiAOjT/w4cHFjyT+x9bh0QbndGQSB3Expqn0vKnjb0PV85jZdzK0ekQaGAq/xtKJJflKvAgQDJsK2iMfiGgy0kMcZJ42+e70upLNDVMQGqdgNkZMBKyCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnDh4myN5PG5rA51tFqnEO/Baj34uQClbwjqgpGiogc=;
 b=ReRs/mVO+T4zZbTKQ5aBrvWbTjQvOhuR2t5tE6Ygo8UQ+vYuwwMX0TXIxkNxhCscGSMxyV15iI5skmkZsEIVqdp4BODNDBvOt/QXVCpLT0kpzw61vphLhL/qirGGC0WqACNSopvVhfluXdymeDa3TvpfPjOydfYNR1WZG2XMy+xUhF9fqE7OJeeWcTHx5CUbJiqK6sqSbl9BhOXo8/fePLhqGCjDnaw7JyAs9PWIc23vY4JzV/lm+C3+V9hhXgnAHgsbehXZzsB78P82tWaBH5vDPw3Hcn+RKs9uISq5WhnEejJCeKBKpeebQYvc3+ykkEprQbpuPOD/u6StpHp7bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7948.eurprd04.prod.outlook.com (2603:10a6:10:1e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Tue, 8 Nov
 2022 06:45:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 06:45:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 07/15] Squash to "selftests/bpf: Add bpf_first scheduler"
Date: Tue,  8 Nov 2022 14:45:06 +0800
Message-Id: <c8701b650a9154e348626c2c51b81a51162f63d5.1667889809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667889809.git.geliang.tang@suse.com>
References: <cover.1667889809.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: b32eafa8-4c80-4cd3-3c4f-08dac154de9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6AyEzc7/RHvuugmMCq1U3OAoNM7qBvgJtswUmAnmzzhXo3Qqk1eleQG5aLUvrNXFrAtdH24FQEoz88L2QK9WUfVmIKWqfmdfCrxTFAKkDHE6iA+wmilY3/GS51wa5P6YcuyQjoc0P341AyF5P9NOXtSqRpjbkWquCm4YINGTh9paxtuVOXtOLTcO2R948R2yRMzv5iKx234Y3eZoRJPrvi3JpKlybTZODhf4E3E8Mav5NIk6OKkgP9zW9kWPApCuVLJGAMpZ0fWL0COPtZ2yzL+sYwapWThD4shIZs3EgU6Dzg+GwG1h+NGzQtx1n4VCIdnAPUC0m3TFUBaCUm/craGO4lIRqYK+kGTUp1NUsrYPWBOEFSofnxvUn/OS1/bJhmbYQmIMUl2RlKC4F+pOWSA2dAV/0zPZc+U8H4FNsEyvmM0RUT0RaHchsSsdhkjPyvn3EqYom4BvdBgadMZnShvnYQ7WQaCCciXJbiMJsixeApkYLc/pS1pQbvFHocmOe4fjnbiKCjQmvV1NfX+aqSGQM8MQq+EC71BhQQLQ4Uwb8QD4JmOL0NjmtJze08Cw+OCiaN8BeeHX9Vug+IR1JaIUcIBKLK6wLHKz+dOMXjdrs3MunEL0/awMiqUW8/Z+32zlAKmHIc6efSKdVShmxuIkYlUsMx/Qqdu6p5/xYFM5yPAQc9jatgjpi1goJi+Sf1KHiZ1pbX6PHInRprSXvCRZPLoMxVQLwbuJ2hh8dPsNRdop3qK38CKOx0ppso4X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199015)(186003)(107886003)(6512007)(6506007)(2616005)(6666004)(83380400001)(44832011)(26005)(2906002)(316002)(478600001)(6916009)(8676002)(4326008)(6486002)(8936002)(41300700001)(5660300002)(66556008)(66946007)(38100700002)(66476007)(36756003)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RV388HwtutpXATWADSHwYqW+NI0hgOlXHPOblYqpvPe6ldzl9yrVTeQw3w0+?=
 =?us-ascii?Q?FD8zGAK11u8gWlTInYZ7RIRUonMbvKlIumTS2fkrXi681HA8rU9e8T2XSW0Y?=
 =?us-ascii?Q?ttjlUwUSw+3mhPWM0yXL9SIWcyYQbmfA+MUuesl+7f0trxUBRYqi2fU5JsfH?=
 =?us-ascii?Q?PGogoOCB4iRJDHXfGUXKvBj/d2PlTCEaeZ1pKBn4DgkmxW1NeWiGPTUZKVuA?=
 =?us-ascii?Q?afr5aOwSvRcrOImjuoENd3zNIg5/aBRpfXOhpwLRoYaYznK12w1jxK0SoJoh?=
 =?us-ascii?Q?JI5ZAPECX0TIhy5k/gYVMaYWP5hdmuMPpOXZPu54xqlyZPHLNEzaGsUfELri?=
 =?us-ascii?Q?hqvvB8mCDSrRFH59p9NArWKrwhszC1fIYPn8FOuGW4/Xogf0HPyL7wg3DF9k?=
 =?us-ascii?Q?CxYJUvebAmnHEcQIGw+XjHRmnXwYLtiNerNVh0riPa/9IDi3T2f2+B70qZa3?=
 =?us-ascii?Q?3OMgWR4na3rp9hN2Ake6tKTrKlPrY3IqYOYbZIvQ703grIC6QoWhVyNRFo+u?=
 =?us-ascii?Q?JOG2vfaXzjBCj9d7bqgnrXU2nHTbYTelt5EV94zlXLVWX20RtabSuZeh4S7x?=
 =?us-ascii?Q?ABIlwMSnz5Ao6f/C1MGp8rfY0bLiyx+K89AO83VFGG1cijDi5KKydosylVqj?=
 =?us-ascii?Q?LxVR/pDfEetzSdpQkAsw3HnhrqrfXFrLu9LSNgrv+2HB4vktS1TL2C5Z6PHa?=
 =?us-ascii?Q?uiZwJx5aHo2nNvgDn3nYfgDaF3c1kmb5z9wOFOSrJv4vbEuI0NnfhelT2zk5?=
 =?us-ascii?Q?DkCAOocPK07Rmk5d7p8Fno8IDag88hAPwUklVHV07z+aAlXa3BL9ls3tUeCR?=
 =?us-ascii?Q?4SrSV6gIDS+QX/OH114dStepfEgjDdXxoQv5x4vY33hoz+IRMHmIenV2rUCt?=
 =?us-ascii?Q?HsaaRWt7DRJXI6Ly4RU4kG/NaOTxdc2HSWKJ6+jbcJZD9IV18wMUPKQAd/8r?=
 =?us-ascii?Q?3+SV01ZGm5qDkPYQOwMHDRoYDwUWyhFQm0N56ULEGX1MMbkqS5cbiCFOFzIq?=
 =?us-ascii?Q?gpfdtRo4gp2ZtF7w+pxRgI7OToYElFqfqGEzvXdDhKsspVyOMDUOL8uVIwxy?=
 =?us-ascii?Q?fpLF/C7y+kxkAQ144rLG4kVS0wfIa3zX5nhMKngmqMQ+OfJ2XCOa/QSMkn+m?=
 =?us-ascii?Q?b1pTcaJ+BVJXxiQbL+D5GKkbhD5JuEcTw0Dxm+RAkVkms6dmCOBfgxoDIpjn?=
 =?us-ascii?Q?cgOmZuZVS3Xd286msPGH5pVUnXhQCPZEkchBCebf5bmEROshSls2OlL0FCpf?=
 =?us-ascii?Q?IX0kZXQ6o1x8v40YDKQctFZIFTZyZybzkR0GgoN+G4X3QMKEVOsf5uKglrRH?=
 =?us-ascii?Q?UbYUP00dS9iI2mJGQ30vUFAjT+oKP0BVbhmAO7ELnNGFzHBhY6RnMHEbV+Bl?=
 =?us-ascii?Q?glMNroe+xyrjWvCkiL9NScBliXHomTUUrpu7bC22y9eyWNrFCr3evgMXfLPA?=
 =?us-ascii?Q?kD8G4rgR1+63HPZFzakd5kTIXEC1dmS3hsan3Up1HL51J6B+vW2ecAUpLU0L?=
 =?us-ascii?Q?Qivs61xag+jmz7PZgMmvZkiGzB4WNAFDkNtTUkEf8Ib+5AIpmHFrkWLis93G?=
 =?us-ascii?Q?lP4bkuCBqqcS4UDLFFrA67wsYpZifEEbmuMrtbVM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32eafa8-4c80-4cd3-3c4f-08dac154de9a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 06:45:48.3503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTWZqRqN+BpYf27rOdUZze7otseEqaWV/ik2m7RVsX28Xb3EGeJnoOMViZWv8aR3WxFqDsvYbxmg5Fz4RyDA5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7948

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index fcd733e88b02..e4caa2dd8c6f 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -16,16 +16,24 @@ void BPF_PROG(mptcp_sched_first_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_first_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	mptcp_subflow_set_scheduled(data->contexts[0], true);
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops first = {
 	.init		= (void *)mptcp_sched_first_init,
 	.release	= (void *)mptcp_sched_first_release,
+	.data_init	= (void *)bpf_first_data_init,
 	.get_subflow	= (void *)bpf_first_get_subflow,
 	.name		= "bpf_first",
 };
-- 
2.35.3

