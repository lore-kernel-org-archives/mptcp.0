Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C263F1FB8
	for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 03:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6zUWuEEADhS7c9Lt3/Cu5Sigy9laeIxlWxMaKcGHnJU4vmnUtlT/SJS4bba+o1mhyL1/nLltAoutddC/NnP/0BjIKcCnUp5evkh8FY8GvE7aFjI3Xp5YZIJOKge3VPDzpzoiH7NPAez41IK75dQW5O9UumDf2Y1kkAPQIFQhC1q9AAOVP4YQhHNpDJIX4MkmMwxleB+2nE83DjetK8UDZoi63B7oKBGmXzLiKxxEAHq2X+TQKvSDYkYPeup8bi118zy9nsc+/eFm95YHZqcq1+Uqn9gs3siXk4STx2Z+Pwnlnur/092bvcNjpoa83G+u+ygewGrGcA8JCktglb3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtbJIdgofgFRa7x+XPjJbBPL6IUvmEL62Hg+8W4g8po=;
 b=bmLtXjWMSKMPXLnOO3F7utGL5ZocnZwL0X4mFvJ8GnyRr727vFHt7iia9nsncJcVZvUZS9xlJSVzheRe5F4UZIHKSuRvgh7E4uFFYhg+Qk2sw+gJh4d+A8lFwJe3/PRqvx3/tp85LH9j5CokNMpby1QTJg6ErDzqJmWsmSUUr4R91c8P5Kl9RKTdZKKg4z38NJXCzkxMZt8+0vgJo48ZdQiBMRnxcSFZJQz1Zo2R14gqT46n+3v539pZPHtuXudeiIUBj7HoZffoszmYCGsgjcJELfx2bHzz2PTN66MGYyCPZ7YeKPTPjaGhcVFzHnVl8m1aSWojN+Hi8eQaWozNzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtbJIdgofgFRa7x+XPjJbBPL6IUvmEL62Hg+8W4g8po=;
 b=0uD6L7CmC2PdR/A6GJWDC8PV8FcZ29GX6rv4LtEw0D9VEF/qHei3PF9/Cu3TxY1i447B6cJ1/72p7pFOVvwJIj8T9MZLKNquaLqyVOBDMnMtgtAYxcwTYIe69VPw6wmXkH5Xv6eTrcK9ZFKEK3pa3o9zCxTB0hbKCBDhp+ESOGqfv+fUcwboO3SBlIsDd87iUJPganbMkcgUQYs/QBV2sKkpu6rhvlmjQg6tojCj436OSwHjVdmWzg855MjkNiw0wIFIVKlHfCQ+W2wA5y490/xT88raq6/U6viUVWG8XrbMFEYKiEcOgcjMpf4lX8jE471T2EW64ogobO3pm/IYLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 03:37:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266%4]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 03:37:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 06/13] Squash to "selftests/bpf: Add bpf_rr test"
Date: Tue, 18 Jul 2023 11:36:43 +0800
Message-Id: <ef2f67fe0bb64357a2c2feb35b6767b50e9c1039.1689650435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1689650435.git.geliang.tang@suse.com>
References: <cover.1689650435.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0245.apcprd06.prod.outlook.com
 (2603:1096:4:ac::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 894296d0-18b3-42b2-7a09-08db87405d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NT0ukI5GKGp1GYu7i9oufYGYzPdRCI1LfPgaCvj5Q4O6VTebVANTQSQqZEUw8DA/ttysVenxs+0Zuz6xMOPPh4inFjAqzwYwcGoTMq69EnfnLnwxUVDeLQ2tQfeCCgxisvbCELDMareoQfcoI7UmofrjjbrwSnFqsevmEAF6T6Fa9k4vLvhgaUT/d/Xou9qvBl1ZZqX+VUzxv2DXneyVUsrMFaJwRpEul6cyX6Thnbtl+BaNc35SmI4EPafWQvo1GWb4hnkh/SP1EQiNpET0pujTUq1ROUnJaZCWwtON5Q7xzsa1xN4Tsgx0yIexZ6NedzV3RlinsrSwfO387FiJTucquFh/cYW5FWkw4CEvKS825aUJp786FDlktVxyQ11DuNQunsyx+HYEtkCQN3Wwa7xj2OcM6pOteCwNbJzgPHHbDY7cimCb/go1Eh8aHGXiFkfnRPGrK2zRSTHbVgLMw1dAHi4KFxC1wmmvgxiUZ1T3t9WV5CfO7OhdN6hK/TK6dRdPFnp9z4YCTuArDB+XLls+mi0UnUbQ4drbxtk8Hi/5wlNLm19ScFFhJsPXmG40iej0Bu/ojt/Ka77wvlL3RGlP59pCFArQaahW7dPgFQk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(107886003)(38100700002)(8936002)(8676002)(4744005)(83380400001)(36756003)(2616005)(2906002)(6506007)(26005)(5660300002)(186003)(86362001)(44832011)(316002)(6486002)(6666004)(4326008)(6916009)(66946007)(66556008)(66476007)(478600001)(6512007)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L7O4UXr+5sAqAzvNrEd+52qLGYlEifycvSPOCd8hmUAqGluvGJnvXCeORCna?=
 =?us-ascii?Q?65bQk3E4Fn4FQCOP8C+ZevwXlnpyhrlhs2/wrndMi/mHVfAjUylKCYS2hl3p?=
 =?us-ascii?Q?UaK7ashn16/rpvGIm5nnCXRBR8KYvU93O9p+pNANlk8V+rzEHxiLKWTdep4P?=
 =?us-ascii?Q?TNDEMosHINUptc6m8Sk/adiClWYJ48t4+FeJe3nPByLP3ggP7Jna6C6sgHih?=
 =?us-ascii?Q?l8SQVotzP0s4iQ13zAYQXUedW/q8ahxbJAD5rIdZnD7m54uuH8RhZDjIMxzs?=
 =?us-ascii?Q?+ywqiYgV0cvi55rSW9EKmnKhb1iTJteWbP0L/RxfXQlNZHQsWARcssbdLX/r?=
 =?us-ascii?Q?iPQg4MreICgYxBOhkIJIxHBCSHGINa4Y2ilkRyREADRDlSw5iBSnJE1C0EaQ?=
 =?us-ascii?Q?uJFOTpLHOXmRm/NUV1jWR28paX16WpnkkYkfvCS4L+hDpneGuIdsbRk1wQBj?=
 =?us-ascii?Q?aNbuX+OarVoV+qrffvyDn/H84H9ePPBJYhHzYnoHsb5PDI/Ze5Zo9Kp0qdoR?=
 =?us-ascii?Q?K1d2w1H8soKaMdGl/ghNZbD6DFgWUIAkZFv30jmy3YrArH1TT2kugsNyECRu?=
 =?us-ascii?Q?Z1NZDpZCXsrBoIGsGXn58Ag1CeayfbSsNwgOoG2nMvyYghjCLwlb9FDyMv6X?=
 =?us-ascii?Q?wSwcNHSrGLc5j79CdvTx18a8fjHrGMQRVAdnHawsU96awfz1VnkHNI16973g?=
 =?us-ascii?Q?AHJSMuz5d4bsdEQMdpOO98cOQiKibrfC4fyuYEL2ygmkSDh+loBN5Kx7pJbO?=
 =?us-ascii?Q?R+OyZmfScFItL5fUm9jJRjzkPvww0tWEg71acYX9VEzp9AzcdfTfbb1bZ78x?=
 =?us-ascii?Q?pOryTdO/nNdfTsGbUAciCSWrhjIV9qmFHIsHMI3ZRyF/fnSORfVwu+N2+M9p?=
 =?us-ascii?Q?FhNuHGpLfz0cL4rFXodL2LM4rI1AFooipDa5oAlukFpH9LoZ4/7OFalLH9C6?=
 =?us-ascii?Q?gS1xBasK8stiI9Vz9G4WiPJddc1U2uZpWZX31LFKj/KlF6Qy/k72kc8FOYTF?=
 =?us-ascii?Q?c4YDrXaq50X0DVMclCAnCYF8iavcYZZ4gJVE1yU/mlmcY4Rmbtd1UYTFlqdE?=
 =?us-ascii?Q?r7W9ErcyzzXJJI3aqSIIt2Oqypfqvubhtju27VxmnjF96Z+FiTt7ODrNB4nQ?=
 =?us-ascii?Q?WpfpPMv8IZny6UHjF/+VI16YwSIm96rGA66CVk6hdX3oezXL/9v6+I4/dZcN?=
 =?us-ascii?Q?QEPFo5qJahZ3mBYV6+oXXKgp2HT9Z2FoJyzASYiAmUP3903DsaOhr9DaQVmH?=
 =?us-ascii?Q?nSSwz+pQsB8OgGnE4d7+ar82zsnXUFeUUD/2aXoEvInnsuftzPj2o3O9SJw9?=
 =?us-ascii?Q?j02Ngbq8jZIL6Woo2ipvGyngRZ6dsGz4K+ZHTPmNxBDybArf702P48fkOYR/?=
 =?us-ascii?Q?8Ek0a5JEpZ9Qw6rs0dHKwfRhrX4Q8xeY4Gjh3c3gm6hdRskIoYVfx7dwQK0h?=
 =?us-ascii?Q?ButTnwz2nl9upUODA6TwkaGQ5kgfHG9zQNgEUVQKkEGACJNpjhDZThm6oS7H?=
 =?us-ascii?Q?IYzvQczZKzyBCKr0sWSOJx+LDof2ZItGfDX1s4oGY0df9g3xKk99sieJTeTc?=
 =?us-ascii?Q?P5nJadnwurKI4aQAQILi+7N7+CSzTvA0erdN4Llx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894296d0-18b3-42b2-7a09-08db87405d5b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:37:51.8322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyuF+ECaqNl9oS3Mtf0TUQQMYQAnZ/bIYmVTlw17fzvbZiYfzvVvB780amzac/OTcQT2GCtBgegnPxttapHPLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9105

Start server with PORT_1.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index f5443c3d2d97..5e2f6504cc68 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -439,7 +439,7 @@ static void test_rr(void)
 	nstoken = sched_init("subflow", "bpf_rr");
 	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_rr"))
 		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
 	send_data(server_fd, client_fd, "bpf_rr");
-- 
2.35.3

