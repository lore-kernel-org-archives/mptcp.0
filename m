Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9592C86
	for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 01:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1637630642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fuwNzEblkHYq4u6dE9B0vesqafy65S5eQBURfQIqlB8=;
	b=mHXGQplY4BlH8OJEWjGzNOlfS0pzY+FDMIfifi+CP6P9phKb5RTk2LlAX/dYAL6dSjRDAT
	syrC4OSp0xAfPh/RnVfQK0i3JmIDlsbzDdTVeRTycbevAe87Hp4YHreEARoEZBnm+l7t+l
	iOdoRHQ9qsDgdIdiHozedYyaSB82QTc=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2110.outbound.protection.outlook.com [104.47.17.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-D-Oe7PrDP_OF3kZhR2BK0w-1; Tue, 23 Nov 2021 02:24:00 +0100
X-MC-Unique: D-Oe7PrDP_OF3kZhR2BK0w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8VlVvth2MXsFTcOw6+FzeyNguAj53AkbZQ/UDn8E14nqMRQvUGA0xXEJNSybuPYzxS3Fiy3I2PrE48fZVYugQl/yk2Xi0Bp1bDqAv7edNPLfObxNzb58EG+klLoY5kxr+rKXRGe9i9hXNZlyqDnhOWSRoLTQqP/hSKopHjVtuoExpD3gFrygTRQzg5EqL7h3yVyERamT0TS72xrxpbPKxq5iuo+PXzQXhEOHtjD8DubaUcfxaXv4g1TRFvhCVUMAdO2WY2ucdwKgHQpGp4f4T7hy7wE7l7pq76mJreJteoUDYOoW0nfLUt7JXmsIpEaPAyP3vl4JXgEEPQy7oeq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMlso0P4DkZv1g74HoKEzZ0DsC/Isy8aZ9cahIz/u6w=;
 b=N82fyM4qcMwjfr4PI+mn4074QFSSluj6YCUTUD6FTL2gQrQojmadwpYBImIVit1WOxNv0Qzy5XR6diNIiGGErVoKg8a12NMPQENZGL1Y4c1tSvN4RvHrJxHR4w1JcSjbqjvQLLBa9kofkLjQWLHkd90xZniAa+q7WFpupMC+M2EMMQg9XNJzUbTMRREzd6SJM985VTTg427M8bkhHUKEgic5Tn52/MCqpPKOUjWi/TGNIaJNzJbnYofhklYbuJexJqscwvq4d6K2JlH4aEXiQeVZdWrmX1eBbu4Iw4Hu+ZrnsjLDkwHWL9Wgz7mq1VJkWve9PptaAQQXbh+QAA5YDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2571.eurprd04.prod.outlook.com (2603:10a6:3:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 01:23:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4d5a:e54e:9ad7:e79a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4d5a:e54e:9ad7:e79a%7]) with mapi id 15.20.4713.024; Tue, 23 Nov 2021
 01:23:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/2] mptcp: print out reset_reason of MP_RST
Date: Tue, 23 Nov 2021 09:23:53 +0800
Message-ID: <f7d8547fa832c5d20c13ca950966d6a5222f0e72.1637630218.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1637630218.git.geliang.tang@suse.com>
References: <cover.1637630218.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (2408:8207:254f:fa90:ffd7:b378:8b95:8f44) by HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 01:23:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f504f30-3b9d-4180-42de-08d9ae1fecaf
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2571:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB25711571A7100F1D4EA4384BF8609@HE1PR0401MB2571.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MTHARDa7bO0/CVCxlm3ILr5Ljmzc5/RegjO3K29gAcZxt9cfrO+RyD2D/KMutl+obm6q8O6zk1JSAVNB6E1Cp8Xi+jygSNJ7pfmZWUOWKyaw6iMBvLX3VePK8vRmgCmT0HqYle6KgJBxDfyGiHcJM5EkMSNqroZFtt6Thh9LsVIV2qhcjH0OhzTSEt9Dp0ZdPWaiEcOZ+6pvLUFMmZUPIhsWYdg807wO3F39wyDOWkRWC5yPMat+hSK2uGsN7sYReaasGBGbWPTjgm0O79Guy79V7ZSf9dg6GVNtSzKnAWeAMm3H2sQwvYNNniQ0oZ5/mXsHf17c28+kk/2bainEK7xuTzdVlgjTawZJeNA/qwIKxmZ4K/vsJ4i10O6OsEgYN3VazgLOYNW3wlj/r3MlLHhyDJpzvrMcO7P7BR0r7EL8g21BjqgJ8n6cHy5kpuFYP/Y6qTZRwMYaIvuRr4vXrj0UmLRijTZDAC/LuAJh2BKUtzH6JL2YIGCJE2jHmMpm+Nb3hd0oOT5C+sdeR0IYYOLNozE4aX9fbs2B5A0SpE+7arPivXqYygeaECxqN9Ji/OrfjOFulJsNkrXAZSqV78WRCi98EZApvfsJ4kf6d//a4AuYOdHqJUWJyJf81SWHOloO7KzfnOc67GICT+dR+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(6666004)(316002)(186003)(4744005)(66476007)(66556008)(5660300002)(6486002)(66946007)(8936002)(4326008)(44832011)(107886003)(2616005)(6496006)(2906002)(86362001)(8676002)(38100700002)(6916009)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Tn/lqsSjmgGGItIfUULxVyLJxm47dqQQfXpXDzGfAF8oBF4Vzy16tCntKoZ?=
 =?us-ascii?Q?BM5kxjIsfeUFY0uEJzhEZTMMVDORWBxuHI6Vf5ehmYm8CV0n8b1dB7WG6XBY?=
 =?us-ascii?Q?MeMl73Uwn1TLKQ6RBZXKkt3Z3vfJH13DNOKYIom+iuiUEaDwD8t9AclEYux2?=
 =?us-ascii?Q?7Vo6Y+px4Uo89rSTO1ELSEzQGXskNT2u4D/zAAAT04Te5s//JZaEtMInSqYt?=
 =?us-ascii?Q?vX6NoIqKvyWnd8IT9dFatFUrxrcGbJPyWF/z7AUa+G9H1SAEVjXQDnfDvT/3?=
 =?us-ascii?Q?nLAu54HYfLVAUgKVw0uRf8JgpUUn/kIv5waiqNh/v6OXSc0Rj0mIL1r6dqP1?=
 =?us-ascii?Q?if3brRPSF1iPGRhxYqKkh9UWJBfgwS5Hx1n2zHK/bbNkk2EmDcxlpBoTwW6W?=
 =?us-ascii?Q?H/Ib61hAWHe4qUltDebJsGqlG2eJNuejCogwOjn3kDqYEAjgIPBii16eoNNG?=
 =?us-ascii?Q?JR7np1DITRcDN+3oo5k4x34nBY6ZomyKINE+q5pFFw6kTiHOUccOXYge68dZ?=
 =?us-ascii?Q?9dbsHs2KgSaX6OBIgrNjCujvy8zTP/XZkiKouNalWHvNTHxg0dXHvxNqfXn8?=
 =?us-ascii?Q?ZYDky3iyy5gCUvgtuFiFRcO6zNAzNfoJ1rfG/MuXpqIvu4FJPgmjb/fIUrkZ?=
 =?us-ascii?Q?5i2ZqIc9Z4ebqRT4MapaXKkAnVGf0Z34lVHIXaBnkPB0rOPLOVnMzVT0aX9B?=
 =?us-ascii?Q?QjcxBKx/KKC1FelMKBrbJTq+ATeS2iINg+cS5C7h3iMdQUFuOcg9zdP0qixz?=
 =?us-ascii?Q?nviZ1lDScpUCRLcFFk7V2WLTJ7EdEtavNjQZW1S5kLLBJmNOzoKa7xaztQHC?=
 =?us-ascii?Q?5+sy2TP6XLPVH4pF71mHLROKXOxC7rBm+HgV46Q/6YGaT51xLzTiqNoMhekk?=
 =?us-ascii?Q?9EJi1ZuoyutZNMxnG2NSvHYIFVeESPEjU3WnJfndVDm/ljrwOt6ZexsWotyE?=
 =?us-ascii?Q?kGz6XJKW3/G4fdr0pZbrz0MfQiS+ZH4VyQZDBmbKk2tIwQjIGr0SswFIs2KG?=
 =?us-ascii?Q?7YBCG52fUIOwZAOJ/5CKgs2loOeDJ68+XtkzQn9lJ1wuxiuLMom68IyWxKwe?=
 =?us-ascii?Q?37lhcspBJMMduWzJ7BgINFdBLUtcxLXtzpusvitElpbi49ypMoawtY59yI8T?=
 =?us-ascii?Q?r7aJHWVLuaTveMSuaOqmX+iatpC8aotrYqN+vWv5vusSQQkIkdmR4Kzm9oiu?=
 =?us-ascii?Q?XJeHOxW+pbiUgt2Xc+S2H4R1CdZAM1nsKI2SJTVd9OXVH24HQIHXAVnhjqyi?=
 =?us-ascii?Q?px0SYoMLhIB8Z4yvJKS4D/N1z/6hI2peQR8bluvb9QdDboFA/narTuPqmcSz?=
 =?us-ascii?Q?dKp/AuirtN3mgnbi9UOkWMlSJlJgtfUWNLwcPMprm+mKUW9hs9KxwYgxkIuF?=
 =?us-ascii?Q?+B6d2nIac1SHwjHZbMjrU4w6WcsFa9ywxQhx991nulaiJDcb/rCjsrDO+Y3J?=
 =?us-ascii?Q?O8LU7L774NBYW4krWsvTRPKE+b28fIM2Xd+wtDKk8pbNJlL4Y1pj3kV7F+1P?=
 =?us-ascii?Q?fuNfLkPpeO/oz43F920K0v4cTvj+wbknioeNjaTa2Ow1lZpcs39ebz/DejFC?=
 =?us-ascii?Q?/PgGXrIu84wUZoPEv1vKR27t8X5zHw6xorlEB6CD+UD1qFQf2u70y02LGOHM?=
 =?us-ascii?Q?R2Jo8GzMSABV+iX5zJqkmKnjmKdpyBww7wuQfudWYpSocj+0gK63Nnlw3UKQ?=
 =?us-ascii?Q?vejIGpoIdubN/uPhUsKsoVqxAk0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f504f30-3b9d-4180-42de-08d9ae1fecaf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 01:23:58.8923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5Wmawoai00lnecnFZvH+UhLa+SUDLSCZf5/d17skAm/9yx77pIkuRB01MXWUFvjIM0t+ohd7lTad6dzon5TwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2571

This patch printed out the reset_reason of MP_RST in mptcp_parse_option()
to show that MP_RST is received.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index dc998a14f4cb..085d11666fd6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -336,6 +336,7 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 		flags =3D *ptr++;
 		mp_opt->reset_transient =3D flags & MPTCP_RST_TRANSIENT;
 		mp_opt->reset_reason =3D *ptr;
+		pr_debug("MP_RST: reset_reason=3D%u", mp_opt->reset_reason);
 		break;
=20
 	case MPTCPOPT_MP_FAIL:
--=20
2.26.2

