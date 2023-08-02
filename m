Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2064.outbound.protection.outlook.com [40.107.6.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9945D6FD2
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 11:55:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PszrQ2ZOS9UMiE37DcltohO1uj5NuBRDC9nRFSHk+8KZPyqg0wV9HMp2uexdvS2ej6o0l/yGBBMJkIoEyJqF0NofklChM44v1mz7Bla7kSVk9bSGzPanG0SYve8mV0uUJo1B+V85eeCWWbkPYU1LsrxQh9hcPUd8gBN66y1S25nzW2P4homjBkkNqecc3/A6Yq4brqTUiti1Jh7NH8cHFxlpNWpDmPR0G2DyFXsFtF7mRFPTF9krCZxUuCaCAzrWoHIcvL+i6Y8VumVG8h18hEWT+y2CC4C6iLIsbZv1ozYNl+IuRnVMqT0tYTKdrOgCLucxqfTHemobRFO5wiJvng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msWpftxtBYhi4F/vyxfgeHNUPm/VmwmDKYkSATjtVn0=;
 b=fq/deYT3q6mvdcZwv8597TpWDaaZQ4DBU0dXELICdAEVAIrcI1KuX3mvUrsJDuK/NPyNMv4f0jIupEs9KEWlhEYDKCTjDOfi5KjmoE9vw6AIJMe0KeTvoG/tlFCv97H2Y3PmkcsUAzy1Sbe7rakvVdpja9ZMNi5gw0y0qW/04rsFgOKUuJ2Kr0OIuvSOcsZOVbpW5NMG2hM1Lhxd9tw+WF+2apLLWhVpN4V3A0YS60yjm2KOTIfth3WC5ZKY0WrZ0+24SCa2S3+W67dWeUMoY1diSRRyDPy6UzsI5/mOwozBLOd+yx21CzTZyquW+iw59UM61OZ6rZCuudjFeWqFvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msWpftxtBYhi4F/vyxfgeHNUPm/VmwmDKYkSATjtVn0=;
 b=GK9gcMFGFELlfbeh4m0hFIjIvfwKmHmkszHyAr/mgjZI9PIoWmbQfjJxQnSaWT0Gbf83NFuDIqW+SKeSemg5BL+Vaw6GSlBpOJUCT2yvNcZvz7KB2aEKq2VkPVUHTuUlxiXfsRdL+k1yL7EOgjRU248KQeHr4OrafTY92PLtowMTsKRF+iarvCkFLLGAKOp8ZCCFKQBgVkWX49E684c8dL9QlE26OAGkTUVfKQEt9Jt75Ehgx2hzYK5pGflXOB/O5Yq9eBDviDUZC4tgwyJygpXD3txkVVYWot9zCwRk71lgcQlo8AC8kFDzJ1eXXviEi2vaI7BmIxusfHL8mpYxKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8023.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 11:55:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 11:55:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/6] Squash to "selftests/bpf: add two mptcp netns helpers"
Date: Wed,  2 Aug 2023 19:55:29 +0800
Message-Id: <2b88521c3134ec4e7a0d911cab75ce3d45462995.1690976940.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1690976940.git.geliang.tang@suse.com>
References: <cover.1690976940.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:4:7c::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: a584d673-19e7-455e-f39b-08db934f6cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dtJIbL5UftVaCC52KehXrvxCwXNEgaI5bh4glvS/8W4rEdn4FWwHHPYlGvRAH4s/BLlX2lSC5Yzw1gOY75dC46a8TaayATwyujS8bqNVC0VrS2klSgM6/MlnQ1PnvlhPMiwc81qu5hOuQZJc88v4Xne20GcaRYD3kPWrvJNqvTk8+tDGJ2xyUraWJ+h5afy3VmQCIhB+Alp5271lryndAOBFdET2g6zBMz7KXEwNOsvNj0z66ID7a2fDQD3GYQQfcYUYKyDpuXdyoNx/4RajpM1lcACtuzSwGr6MWndNwkduHX2Hq8T+1bvj1qJ55Hn+TbSgbZdPUrTCvorEzvUvmqz42u2iFJAY2rqPyo9h82FvYraGvtLLDlG0WVZMcq7sV0fZ/sF3QOfJ+4d4K6cKb0R0JhI2jypCwzE+cMJ5oiM7rAYkFMMN8ZpoWhwMZvV1M1AU+aO5HAfOufnBSx3rDHio/cTKsOE9W5+3Yp7bml8ZkE3rqqZLCi6gdzhHc012mBXTg/nedlxagRvlXTZshYrBULfsVJnw1v1fZXsl3fWQcy5NG65XksFmW7ZamLjdWsOnHpzq3y9PAclO0FDN8lPXI7hXbrrx8TiO2v4vd68=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(5660300002)(26005)(41300700001)(107886003)(2906002)(83380400001)(44832011)(4744005)(36756003)(2616005)(478600001)(38100700002)(316002)(86362001)(6506007)(6486002)(66946007)(66556008)(66476007)(6666004)(4326008)(6916009)(186003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MDRHTEanYPq4mNxpZyXW25ZXbKlBbML62YIZW3coGzrJjfP/8HJRMK0dXy/w?=
 =?us-ascii?Q?TEBAgKT4NQpCMwxfwjmmRbHrG6ZTcaR2UI9LvW2TaoA/KDKpHufEEw+rh+Ia?=
 =?us-ascii?Q?STTrPCCPMCc/qEd0Qg1ZHUxqewLZHmdONrA99UlO0CM21yaat5Ph+rsKjMpH?=
 =?us-ascii?Q?pef0zppNL8njHeA+SBFZeXGBJLvWO3lg9Xe0RyI14JG9K7epyvn8K8gVTH68?=
 =?us-ascii?Q?5QHZQC1vnWYSLs8LQVft1u0/TXyB500R0BRWS/v+puoZycED/Sb+H7e299uB?=
 =?us-ascii?Q?ObOWs2weO8X31i6Be0H2L0XIysh0Wlp7r9JeX1a+jCiCzsmr0bFdojU93ZgQ?=
 =?us-ascii?Q?4Wkqpa4BOviS2WIjUYaZaID7MkR3M67eXtQSs9UK4Uo21dwgIYfp1jhpzzNp?=
 =?us-ascii?Q?4vprggFidF+x3K0pCvU8CJXxgHZieq20sfEdQXpmbnCCy6qhSr1HhYrQvves?=
 =?us-ascii?Q?ETseB1/2DL4xYwjGUT0Q2YjYeTLEbbU/eA5a+X6yvDAErLYqVQ2rX41Sp7sK?=
 =?us-ascii?Q?jGzhnEt0kt5lqqanDfgFhJd7dKSA9Es87sXJokW1AVC2z5KUawaJ5CIw9TjB?=
 =?us-ascii?Q?mgAsW+QyEY9Q2A1wETin4BruV3sqDaI3kHlbiHKc/XcTvtBqydNyk7k9TpI8?=
 =?us-ascii?Q?/qEokRahXV35UXsOoGEFibNl2cRozatWnaDyP1RGFd8UaixRlIUWzEaGa+sW?=
 =?us-ascii?Q?emydeKmx+9DaGDS3ao2B34l8gLT3tDHG9RGY5UyJ4gzXpYmG6IgW9Yo0Cs0v?=
 =?us-ascii?Q?cqTVWpzJW4K1rfGuIE9nrBj4W0LIcgHphx8caqi64TqFi+zg8jQCpl9T4Cll?=
 =?us-ascii?Q?KYwakrwvT+YUww2gB7s2FSfxK1utMbgh1lyJbXEeJED8Dre5LbB3sq64Zz2B?=
 =?us-ascii?Q?U79UbsdTeB9Xu1ZrsqzB+tzWEKEonoHk0pJf9dOoYxoZa67LKqstn6+S4KF9?=
 =?us-ascii?Q?QYCCg/es72KpB0qR9RPNjq6uD5xnyoBadZudm+KY6NnN2w8lxZ2Fhq3xtcZd?=
 =?us-ascii?Q?xQyl6PTJ18ZldLzKjAsmWyL1bw4vA8VksABGwJ6RWaVdVH60Brpj4ui814Rk?=
 =?us-ascii?Q?e+0cOEqFFwr0/q8StzrnGf9DvGbLfgJFMjpBYOPpYTWQ6N/vx/pAfgTWyh6x?=
 =?us-ascii?Q?dNJ7aAK5LRdiNLOWETi19f1eE7v2/DXJmf9VDTn/kUDFeu0RIhq5sR1MmKHx?=
 =?us-ascii?Q?g3X5opZmePv5IyaY2QJeBBVKxy5ClMdolHd/yQS6DDwYGmhs7nIqEaTgWiiy?=
 =?us-ascii?Q?S2hR1wG6tJIXUHkdYg9/Ica/P6jPsWe970RoHES9FlzzObgZ+8eCdS7meIcb?=
 =?us-ascii?Q?TUlXkNHhtHfFNFlSI/IoAreaEuDQ6rk6dXiY9ZIBEZGDdQ1dgmwVIjOAKsoZ?=
 =?us-ascii?Q?sEtAlFl+L1edObkn4V45OiJqn/nLPJXjk13ezFAsrigrDjYVmdLI9QZc4Wta?=
 =?us-ascii?Q?mECencytxHLevTmKKaAbqsH4Dlgd3KiAH0y7DEZhAgUUbD81i5CSfi1HujXS?=
 =?us-ascii?Q?r20PmyM5iiM2poYHhhKcOXhrUI4VCCzeO60OVVhSD4CUJ4cGlLrsQrx4Lme7?=
 =?us-ascii?Q?V09MZDKaK8peyTp3OXqBs6Vqsr76Q7qH957tN3eW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a584d673-19e7-455e-f39b-08db934f6cbf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 11:55:54.4918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qD3x2t1VlJwMh3McGoeY86ewTLx1ihVhXEe4xUwK0Xraw8IGv5utoPXUGNQO2e2vPBznAFRrysnBB26iCMnQjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8023

Just drop a black line.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index ad6b5e889d9d..09770aa31f4a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -198,7 +198,6 @@ static void test_base(void)
 
 fail:
 	cleanup_netns(nstoken);
-
 	close(cgroup_fd);
 }
 
-- 
2.35.3

