Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2041.outbound.protection.outlook.com [40.107.7.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919EF1D53E
	for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="sVrkfBFl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLVwRGCUe2ZrX5w+hi6pzLlugYMP+FuFDO/8ZXjRv9f73RWRJm2uZPdK+XQrTmhkQQS0Z3PQU8V6eg17prGBgSZH+KMXjswkZW1JgWTp/4DVkfx7WV6OZnke9+guWX3gAZGjbRfyH5byfhSF7d5cYxvQfMeuX+qLqbcArzMV3XO+nmUYFee/O9uXzz1H7xZO0IO+tHdqpJFdu8xcHKvlz4sAFnBQTmwXkjthXdNKsaf9bbQxeftR9EgVVMWQw8DK4bP54foxnozXXH36FuPbqtCSvLiPps9cS708+gr5QWYnQAixl5C/5ab1cDOH7St0QicyjHuv1qjJu0VRhUjyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IQEvFh6gdXeD+mG1BZ0f58gh99w7hdhkeuxHo1D1Lg=;
 b=LHND1/rVIOm3vNjHROvlMzQevx5hT9YAjssS6pfVqjrkYyXj7hdnpqO/lOMkYAzpeDuA9yrDCvaKmSdyx/ECRzbobeTbTc5/WSiREn4tx9wi8M3tOsXJj6HWvyksqax9eGqgekbaveoJLpvucvs/XU0mxqe0dbKCUk1Ag1nYisyHNUlv2mpuYOIIxxEqK96ht7mGYhwPogob/5WFlv4LDg0bZc0AaL57ZGm792mAMHZ/MC8qpbrjrTsj0Feefvw90zIJpOWLiuBVDCuvN7SL0DCx9YLNhU8AUawMN3ouZKJrxw0EplYSL80R5Aw02vJiP5bUYwEFLMxkxNB7TE+3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IQEvFh6gdXeD+mG1BZ0f58gh99w7hdhkeuxHo1D1Lg=;
 b=sVrkfBFlibycDcTSKGtk5HaZhQ8LMcO3jAWSEzaqazzLAX8/hqOBcp27oETbQCNsF1Nj73eZkbF3qojIYBIHMrYbqAen7mIWFwc84odgnFgz2F2LkgLr3jniqrAFZcXwpophqawnYGqJym8gVZOdNQLEN7Dx1xUL34KoLQubnP6ECHT1FKRoJDzGvOMb00CnCv9bQsEigT6UBSYcztbXdX7agxxeIeqDVIa8US24poBJs/WbkUOz8kAvapPVXzS6RojDy4gPlE4n7fXI62D6hpjOR2saxMKC6GNimw+1YBqBou2go7V55b5MCNh5MXKMCGNYTAVrGyKq/Qi+Nyx/4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7923.eurprd04.prod.outlook.com (2603:10a6:20b:24b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 08:51:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 08:51:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 3/7] Squash to "mptcp: add mptcpi_subflows_total counter"
Date: Thu, 12 Oct 2023 16:52:01 +0800
Message-Id: <6e9e20ed1350ac793b682042ae32be6808c1a1e4.1697100600.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697100600.git.geliang.tang@suse.com>
References: <cover.1697100600.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fddeebd-a33c-422a-11f8-08dbcb006da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1ZbTpGFo5MertYYV8v5WuPmn/A4406pK1fHu4fT3MZhfe2ONiEHnl3eYdFpNIAEyrjEjUnw6VRF4rQLGcLDkAe0dZgwJXT69nPASNjIPOvfe1OEqPLrx8aCVm11SAqzq25vhjnHibbl7nryS3TiUt4/9DwaR2if17HFWr2PWXKiU2zQ0a/+neBr2tfZxSHiKPB4g9g0RHuk+4Xr+qg2VftxMquphIe4cNW7wuGiSrGLcUf+EEjNG1hh+wfTNGyPWE9REn9fc7WtLLU6pvyrVVDiA4evrTzLY6TUmtrwyyD08BNkp8re299SNhtREEI0eyOmNp91epam4i3F6u2sC6KF6+phDjOHAkOslldm7oZCs01+XbJYY1mu+mv76aIYIRH4m4SCPkHvgdc1G7dvocySoxK0QpJhvzVJYUgFJPViICqjue15rQ7kC+HUH3sPhuY/ypqffP8NhGVonTJVfJH755SdKNt5PjIR8FqbO5fXMIJEgi2V+UXoorHNox7PEjGaLJBnnUZAS0uE/k62f9B5YXmVY10xcVxw63pz001lIouLeMvZ4zxJzSgvxIiNa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(6512007)(107886003)(2616005)(478600001)(6486002)(44832011)(5660300002)(8936002)(8676002)(4326008)(86362001)(4744005)(2906002)(6916009)(316002)(66476007)(36756003)(41300700001)(66556008)(66946007)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fV4ubpLntKTu+Z/w6V6syEmuWfMpHEuDYnRWs7lNpa97IuJJYSY2cnh1Z+gG?=
 =?us-ascii?Q?PBPie5kHWS39rPreHYn42ZOsOR9cuHNrrdRsxQW7VHBFouAusc9ns2uJMAeE?=
 =?us-ascii?Q?Tq2wDmU0DjFfenWNXAZMrqbAj3IWKyxHttkjkKl/uP8AulTy637IgBz6YQl9?=
 =?us-ascii?Q?9rnBO2Ur8Jn79xrl2jlJvaot1LmqX7DKDHMk8e5rAfLrhpyu78lzhfAHyvD2?=
 =?us-ascii?Q?BJUWxBioGjyKY+fMXd8wDd4uu16r7ov2p1kwjlSn/SY+fXdfVYne6Im5GVix?=
 =?us-ascii?Q?eJBNVqTFobOyKfSBVv4Nmrw/XxO26rAy4j59JwuhCXdtwdOmV6XEoRXgX39f?=
 =?us-ascii?Q?THKJjZs4U5NDUG6k7GMQz1A+GRM7/7w9a/XsLrwpEhTUKvVqld2v2riG+HD9?=
 =?us-ascii?Q?EAFnSMoWVrKzc9z8nj9I1xUnCY6ACoArNze6tLPb/Oam61Sw3/DMfBVb1Ef5?=
 =?us-ascii?Q?5mJAr/RsuxbTJ4eiP1AIMv897oy5Mel5hLsiPvDFY167t2E35UA6Hy3oQERq?=
 =?us-ascii?Q?jJXLa8g99Btkz5CyvCpWh192XgCIlpq8A1t8PJgI+iBa9kpAsESfVIb9OSe0?=
 =?us-ascii?Q?91PQu+Lygk0FEohhSHqF27sYSW3NhfihgbQgxSWHusqRw6bvIttdVinEaYHh?=
 =?us-ascii?Q?vlKmDjsUsqNBWXx/LoSvirCfLgw4Q7LKluA0ig6K3oFqxnRvwLr6fdPHxPX2?=
 =?us-ascii?Q?njUWnKq3CrkNorP3Z2t7z7SrGfX7gPL+vkgs9u0/5jT5PhxNhMvZpwtxdtfW?=
 =?us-ascii?Q?+41slRCABeHIvw/8kNokGMwTGLmPS5AvM0F2LJGW++Viy+iw7T9u/9zF2/BY?=
 =?us-ascii?Q?gwhjDvvVUZVEfefGZSmEv5ehSUuA7W35SsFoOGsZ5yVE8TrTTtOHFEMB6qDQ?=
 =?us-ascii?Q?kC0aomvgkyyah9Yre+qjU2LSi0XNT3VhRrITsCDf684vo5rtXEvTGOMkjZkh?=
 =?us-ascii?Q?CrKQKZqYoCZhtqjLz3aa/7BEzmOG6HSBwmTbSs23QmJmPEpN/aXuRhwtAPgi?=
 =?us-ascii?Q?ksyGGckRLAMRxB+w54X0pb/N+xQpzmwvl6pC2mnJojXuJjijk2izjCBOfOE5?=
 =?us-ascii?Q?au76H8ji/IyKVdRMePc25Ku5HNupZanY5RYWM5ycNYVN/Hzhit3BSWCv0YzT?=
 =?us-ascii?Q?N2aA7VqWJCv9Kx8qlcvUVqEiiXKTjnD68Fw/e2pEcILCui+ioup2frAoTX3y?=
 =?us-ascii?Q?RWDJ2bzPkPDY3KqULDvQaVzfHZsklOUp6AG87M6oHPRlJ9zJDzqib6J2nRGh?=
 =?us-ascii?Q?7+VAkENlslaWz0xJyvYVEHNVuGi0EuzZCibl+G3lf4rHhdmKXW+VdAT0zgph?=
 =?us-ascii?Q?lplLSB2n6PR2qUTSEFKp6CAnUlA0plyfB5NV3XVZQfdMTF+45iZK3BWwMrJi?=
 =?us-ascii?Q?A399cNcGPEG4gxJYkAK921a+mqXz9wwv/cf+O+5xArD1AP9k7tL6kdGjMo/0?=
 =?us-ascii?Q?9wLmEhgozBfLC/pYdTXtiuGTZVr/er3OCjcom2Kz7C41Kk+yKFl+0qwcZI33?=
 =?us-ascii?Q?R869ZjCowFS1f86psRHAZsQA7TnXlOr95u/A8Qb2Y/0Id5E5TWaSaOHq+sz4?=
 =?us-ascii?Q?uQvA3rmBF7ChI0g9QTm029DTc3AqP6Ly/18h7hsgz9fdtUcdu2jymzCRQUKd?=
 =?us-ascii?Q?+oP249ELRMxBGrjhMlW0sOsUwOXVlCVDAjVb/payXjl9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fddeebd-a33c-422a-11f8-08dbcb006da4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 08:51:30.4101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+hAceFylI5kH+1SNnwI6B/EEIlfWefD9DTa4cJZGAP5K8D/iHKMChWQlgALM411X5CCU/WKDSwk+Euu4T8Smg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7923

When the socket shuts down, it's state is TCPF_FIN_WAIT2. Add this into
__mptcp_has_initial_subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6508179e94a6..ccb97b747527 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1081,7 +1081,8 @@ static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
 {
 	struct sock *ssk = READ_ONCE(msk->first);
 
-	return ssk && inet_sk_state_load(ssk) != TCP_CLOSE;
+	return ssk &&
+	       !((1 << inet_sk_state_load(ssk)) & (TCPF_FIN_WAIT2 | TCPF_CLOSE));
 }
 
 static inline void mptcp_do_fallback(struct sock *ssk)
-- 
2.35.3

