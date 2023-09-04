Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355F97E
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 09:39:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckP2lIzYf74edVPpWi8QBeI+d35cLkrXcgft57RZGYsrq2of6pzIzLd66S4QbLjvthwzJ/P5VeyAE6uJvddyxwrlOpSRy57x/4h/8s/pgYps+MbRgRvfGoLTgdLl/DOdGw+MJYIlec3WqH1dI0Sm8e3BELMlqrykvOv9d4UPcujjkgiTzOeHhrfd0Q5yMA7vC/BdnhyXphAG0S7C1/KYo9DEtwiI0B5QEwHsRu6h499Nw2PgpfhJ+xhAPO2EIVRoKpXDvWJcJGBzm8OgROnaf66oMVIngy64+49Su9q5WxV5gQn3HtdQsAJkYj6HQmziEkdsihDOhT9LnmB7icev5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGEAOZYqr/YZj7QkWssZCGW7YeWMA99bxlXzTQcvMgY=;
 b=NLMb6+Q/aPxn7DL7w08snGCfIv7bB+8/WApLZfy1UrMJRFqAB6RFxri8d9fiM0fvAIWh15181F07K9y/tLMIbOu8brWfowYApWGp8YR+vcPoLYYitHomvnUdRvpMQ3U3IkN4ISGrBECitfbZBfGKk05CmP9WpRQKk4m1YYT/qRfIaJcH9N/mF7Jh2Gxit3u9m2oDyWssWIzcezaUqjhypPx1EoHIRphIuQ/UH2eADUE9Wx/P6iw0vqxbZn1POYSlx82+zw/9/CPYD/5cb3Im62hBqFu9mWUfkjOx9Ni/QYGgXuhez/KZCtMeJHwrwSQwgoypIadI10tiLqAOEMd82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGEAOZYqr/YZj7QkWssZCGW7YeWMA99bxlXzTQcvMgY=;
 b=5LbpAxLLBaVMtBJDqPs3k1BUmCd3sgymwIt93fV5I6f0ZI7bs1Rz69EydhhEFqlAOI2q8l7X3BMTaxCNmPvSS/Pkyi7794aNyAunOUvyUSU5xoykgEgz15aGi3w5jgdRgdjbw+EHGO5LxzjpkNEaYzxoBpLWSUeOUGWbOYOc/X93jN0RMnuszbA/eUn/KlAzfRXg8cik++5c+aEG4IB9QAv5EqQCS9AMtYW/XYKVbCd8GlFAWyZXbyjgWf8VBMZpDl9Csfn/7jiEBJ+9SxikFQovTKqmRVu564Va1gLfEnGj+glEqxWZjcZoDaVzA4Dgq18cqyB0xZ3B6oUTi46WzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM9PR04MB7716.eurprd04.prod.outlook.com (2603:10a6:20b:280::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 09:39:08 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 09:39:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/9] Squash to "bpf: Export more bpf_burst related functions"
Date: Mon,  4 Sep 2023 17:39:20 +0800
Message-Id: <f112ad86adbbb18efeeb0ea5f6196ab588e3368c.1693820153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1693820153.git.geliang.tang@suse.com>
References: <cover.1693820153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0163.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::10) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM9PR04MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: fd7d0da3-2d7f-4c5e-088e-08dbad2ac9ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6oKCoQBGz2bF8yMk/sWiId/mqaFxUXqChE02Q2cvGexKMHkxJE7wIYlwtDwSWKxp2vw3opPtZxCYIqLk0iZk2eVagwZGBgAFMjrFG/gASYA0YjBJJ1rDF4xEUVwCAfNihRjMeI9+a3fH9W5pals/+vSikHVXfG2dweDYZKWkiopHfRoAj/Ej4Zwr3Y7aj0C0Cfjb5bTtQgeC0lMaHJ3r5F7xoD/jie1JLZyARlznzb7C+bYVk3VjKCzkMnrAYS+K2knNRsDanlGbWTQRcYNx+EYslGXcD39te2OlGxYgX0pFFkraloeKJPc+SiYprV5gFEAh/x4fTs3gAwtJaGUZBJHXnx6LkP0w5RIS69v4IafyaRRG47wC/h17OeEwFVYnsjYycFmbliiSujYwsXmGXKnrkPkfQTDMUHG/rab1WxDfVa4lX7PxH+3PyzrJOmXuY354TMzQM/iNqTbL0PyAqRcxcxELPWrwa7N4x5lQfUoYnhccREPRXXmhUudPfvNlJm+KA+VTcriHD65FWv3tHIz8TXd0y8sjEWgnEEzOrzI5TEPeO6dZbKU58OvEA2vj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(6666004)(6506007)(6486002)(478600001)(38100700002)(83380400001)(2616005)(107886003)(6512007)(4744005)(36756003)(2906002)(66556008)(316002)(66476007)(6916009)(86362001)(8936002)(66946007)(5660300002)(44832011)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iLjei59FCU3czWaP3dZmDYIi3OOoFE/car6ykP6SYAEPB0hI/XxNZb9rE/g+?=
 =?us-ascii?Q?dttfXcHBYAk9s0KiyLfh6cC7YPPYsQloKuurkRCMILeoiFmSrYLYvIIgLMnM?=
 =?us-ascii?Q?P4U7H1DaG8nUrAiUPbeQndHC69Gp5EFp/+D+oz8wHRdLUinmRcwRosE1Po50?=
 =?us-ascii?Q?B31xCW/bVVuFKsZPEoJWmdmyW790/kUkjou+0KmukevxPTx0mVGtnskZdJg5?=
 =?us-ascii?Q?cxhLJTOBFWcHei2jFC+ysLueusB4sveOpLFcTDm1TeOo8wHwoNF/zTJXB7qM?=
 =?us-ascii?Q?1UvhiwEWt/HdJ2v65YqC76DBQOhMvlbylW1PI55bfH4GRW1CH8ptNXyQIavR?=
 =?us-ascii?Q?bC6jZgso/GbBks+7kq27XuRXRWfNTJpfNwXiNZA8D2pKF+12PQAS1+idGIPp?=
 =?us-ascii?Q?qO3NrZ/+q32/DsqFLvTDSXvRZ3UfNgUMLLCf19W+ZjhFFgBeEGBbCmo+Y0bQ?=
 =?us-ascii?Q?u1pGn8DVXcDHEwMrnIBPo69a0osPKH8h6n5a7xMztEAEoBu6tj2KVj1RtEZn?=
 =?us-ascii?Q?/iBCAYSmD6f9Aij/UcAPi6oUXsoP0yO/2Xd//lTFrqa48tfMIigECTHVRxOA?=
 =?us-ascii?Q?afBHayoZhgNmlNq+rdsmnoK/rOsfLKU12FzYTLK3A/LoqYInbT14F9nyBX1v?=
 =?us-ascii?Q?7gAVL/eA9G+LZpu3UBBwFUtxSOqG3e3BsyFWoe3D/OaMCR7IkiF6UjQc8SGI?=
 =?us-ascii?Q?TqDtbvEmyk69Rl+f1eNhib5uZaFutd/FtpJd/gyxBE6j0wWKKGBpZVuDvuF3?=
 =?us-ascii?Q?+ZwgEK4sZ8+OP4P+GAampp3u5jOonmNZrMHptumn9hnCD7zzonDLQfB95mI2?=
 =?us-ascii?Q?OyZ6j0JYoFO/mCGqC37QoamGuv3yBnA9CNlIdUUnaXzx0w11JfN2jJnjAsZj?=
 =?us-ascii?Q?G5fj/FiSOJu6D8y5wUqLyzmJ1yPe1/LKpNtgQZfXef0axeytoPaICTFlFm0Z?=
 =?us-ascii?Q?oijMTO6xD7AVxb6Jjy043x9fiUZsrYDnCoCDruEgR6aX8MSsyfTARLkCgxUT?=
 =?us-ascii?Q?pJkCiOC5OafYR9ITrrcqdVwOIhR1Q5QgdY7H13K0ctpTKbKUxD+TCC5ogH5G?=
 =?us-ascii?Q?wcnw51mQrfSspWtULWRXIGvbsLoHkYd6lt2xUFPzoTRJEp3hXtHrNGV/D/NV?=
 =?us-ascii?Q?757YuP+OCTsTQ569Fvo/uSrNbJ8qB9V99FnGNzzqvBVnsKTWncfyI8eKfFJL?=
 =?us-ascii?Q?jdJ32Ipu9wA6nz9aXQmmiTsAJ5oRP7gZS4/6uzpIdtEUyHhV7aCbLHwnVTeo?=
 =?us-ascii?Q?zw9WiwSu8POQa2lDqfbgAbQY6wcmJgcx7yPaq1RKXb2tTF0MlAvDyj6214OY?=
 =?us-ascii?Q?oDp2EtQJXLxyo6YanHnIJJQJe/hX0NmoWMVFmHcjP/yNyJf7Bks3mswXJJ1/?=
 =?us-ascii?Q?vSdymHVOLoqhTCiA/2ZN7MJumMr6OosCKtTYtgLcRIk9TfFqH0Dm79UC9/5L?=
 =?us-ascii?Q?+hxdo31+0FRV5vso9b1avD8asaaWH9qGBLaUVFtQF/CEeaZstgmpXHxpfCy7?=
 =?us-ascii?Q?ev5oQflh3H8ph7fo1FFUuMPZ9yBOVJQRaNbquJYjqgHoQOtbkk02HSN9zsoe?=
 =?us-ascii?Q?NKSQiKGQObCfE0h6ylNlp055afs7uEwj+Rkq0S9ZIHg9/KeS+BZXkTPrOtU+?=
 =?us-ascii?Q?F2sy71FMUpokwm+F5GAmlPtsURlfeQSaVHpxXyYNUQg3FyxsbI/tLcZOMepp?=
 =?us-ascii?Q?tHVy2Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7d0da3-2d7f-4c5e-088e-08dbad2ac9ab
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 09:39:08.7456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01oMD7r9/7zAGuozES54utPsOzZ8zxDTa4hl1UlpkmnH+W581RMNmzFDd7XT5Rvle2JVClD8qPHSgEm2ULbP4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7716

Add __bpf_kfunc before bpf_mptcp_subflow_queues_empty(), drop __diag_*,
it will be added in the next patch.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 3c29718156df..8109d9dfaf5e 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -163,17 +163,11 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
 	.set   = &bpf_mptcp_fmodret_ids,
 };
 
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "kfuncs which will be used in BPF programs");
-
-bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
+__bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 {
 	return tcp_rtx_queue_empty(sk);
 }
 
-__diag_pop();
-
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
-- 
2.35.3

