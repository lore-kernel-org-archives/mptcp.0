Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A8E7C
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 10:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646736490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7BGizHph/YhE1zNm7kEajUC7f1Y7h8Wgg45i61M3+mM=;
	b=N7xFcCBPCZbnduZaJcEMC1BP1OkPU346xPi948Q7rnmfwL1shLmG0VEnthqMOlsBfQUvYF
	HmOpabwFCgfVxOCBklorpFyf65CqqddSrroofwRcBgVnf8W30VciSIoJMzIbGSifF7CLk5
	ogkakdkl1bLWss6vyu+bpYuiOkFRh98=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2057.outbound.protection.outlook.com [104.47.12.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-iNjNmazsOBaAXH18NJbugg-1; Tue, 08 Mar 2022 11:48:09 +0100
X-MC-Unique: iNjNmazsOBaAXH18NJbugg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ih+Ix7V2m6zDkHNiKRrodmBblAT2xCnDhL8aeFAB4d4zRe5nZy+9/3OQwuv5WTcx08oSxUP9VCGA2mZgvGPguB7V19dM4BfC6Z4ZHdhSwx3YtHc3+DmKiN8JczCW+08r8cwLBMe0uAnjbvFHg7LHKqT5oZFXWwcmBtMZROHT3ubZOCK4fvuPUVev2j6vrEdzgTLlwGCrvzEGPLYbQ0dlT8XCD6F9Os+CZVUcGgGlN3cpbp8QtaugNCtZ3dDHPRQxincq1sefOQVHgexBz5Nf73pZyQLb6rCQXZCWkVVZZf5wDwDd+fOXux5o9+oxeJ52KQdBa6VAR57psO69xitZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjnDMohe2FOflGtxTte4BkLYIa7pLRnYn/vQK9dPLuI=;
 b=CvDJyep06cS4kmoC4y0LWLOTGQybxkPl0CNZBZ5cagKRUYvGpzbHYLrFxMqwRQO0Xbd20zcgVOZRzdYRfy8Zz3tHLdQ1lvk/2qUPAAR5TbwuKWXCcU+tl6HfP+GriZ7mXt/baORt1TyaNph6qVIq1KN95VqlmFgzNDqRK3nvqBcxZw+kICbs81oY5/XwFXZ43F1n3kc2dUXto7k9yThZyP9nYwwOxzKW1LbUJMEG48EfMTccPaVYMsZN0kpxhhZwAeSuGtsnBJwrJp2nJH6U5yg2tANdptc3j5uOy27bbzcTaJ5LxVLa6UsZXGaJ42CcZIIkgThsTyoC9W4vyEltSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7929.eurprd04.prod.outlook.com (2603:10a6:10:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 10:48:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 10:48:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 4/5] Squash to "selftests: bpf: add MPTCP test base"
Date: Tue,  8 Mar 2022 18:47:31 +0800
Message-ID: <4c1507d948172d1ba3c26f453313db7385a41eb8.1646736285.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646736285.git.geliang.tang@suse.com>
References: <cover.1646736285.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0064.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9aff0f7-1282-4a75-e8d9-08da00f121ec
X-MS-TrafficTypeDiagnostic: DBBPR04MB7929:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB792943975543C8916FA31620F8099@DBBPR04MB7929.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fczim1VyUUIYIMv1cVw+PAegyrBvk8RK+rOVKmXDRluM6kqys+chfIYMbImcHJ35NpBEITb5UVP+dZfItOEiq72lT4eE5raUs9uuo/jcPXcfThvMuEH4oiiK4qeJiCKwAj/g0sZAI5nDxJo7uEOFO19Gth0sBifciI5BvW0uhqGNfpEvea5PlTCFxO1pz3M0f54aidGfGo8KOPqknn9o4v/TQ4iWOlwAI05RHvQOGpA8/Rx8Qg3IMkylWR55LirTP6jTeWfvhciObqi7lkVrQ1+4lk20hdtlHep5GWN+xyhC1cBeH7zhryjt42ShOmjB6SCtH62p30QiWMoKs5n7QVoEzx12eQZwzJbdn2DPxtqZGGymwXL3M977cBWhsnwqfWGQwp54pj9WCgHJ5onKh3lFluuYVmVp9JfMxlTNWE57OAY2I/RZtnvuaumcgXxeVY7waLtD6B7fnwGFwEhgnhOfNTweE+fnm35e/EPUaibpXrmOJh0KEixVY07hpYuJWtoH4lwi2vCehbzT0HDla5I0TXxqySWXgRSAtKQ0t00Z7j4XSQBcEyVL5Sp8WzKWxkRT+UPon6OpWem0imTC58Rg3DjuEqLdv0PWEHZ15L9Fz6TcuYVexRVVpC4OMk/ZWgcq8h5gzE7fiz/MaMyQriC5q/Ibzs08e2xO82prtRsG0pW4vFgtZEu1s4UWjW9O8TmSM8Ms7aPCg+4M9zC/1A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(107886003)(186003)(6666004)(6506007)(2616005)(38100700002)(83380400001)(4326008)(66946007)(44832011)(66476007)(8936002)(8676002)(5660300002)(6512007)(66556008)(36756003)(2906002)(508600001)(6916009)(6486002)(316002)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vB5LlqJ7VYEmQOoGzypNTNOx+GY6LL9cu+0gKuqpcAaieGxLBPCp/YwIwV4w?=
 =?us-ascii?Q?rVT2YFzE4fQwn8ik1OqnRaSfuFnU/QVVQV6RtNQJT9xXg4O6+F+hjSU51uL/?=
 =?us-ascii?Q?Cej7bHuyTZuKp01zy7RZYTI6e2ZaIaN2a1rcBuRcbs6IEfa9+jG9Nmo0j8s2?=
 =?us-ascii?Q?jKpJ/YS8xWqmazLL91yj5HxYDHXFeGlHdwvebMkUgll2hRWHnmEQh2Lw8+ml?=
 =?us-ascii?Q?bterDFDu8AOnWWqg7Z9MXbsDH+C0f+/gTiebX+dPLU6hz9SGGyaZIDCjQzwI?=
 =?us-ascii?Q?HEqGmw3Kwk48Lbff0R56rMs4LRjzpkihk9s1QVqJCUXNCS2jxkWFVRQP3apX?=
 =?us-ascii?Q?7N/3y6oxt4YgApV8wo2rmIQdq9w6X0DqRcG2DlCumPkhYuSmBQxhcLj6vonY?=
 =?us-ascii?Q?PU/41oYnJlvGl7r5VSa3+zSLrTST1ts99XcjBgwPCmBCLalqkSw7RtY+O9/m?=
 =?us-ascii?Q?GnB2CnfClKIlbw6qch/ZeoZaEpVOg6QP+T+8n5xdNouY2+phn3hsvB3u3AnF?=
 =?us-ascii?Q?ku+F31PiIa+UMf4BxJiv4AhnZLCXbzIINjyEggisWNtanoyst5ifMhujrw4C?=
 =?us-ascii?Q?9GAlMVjiU70ulVu0Z0wukNWG20E36yxKCz/VvTaD+WTv57rSJGwKW6SKkh1U?=
 =?us-ascii?Q?SnuypI9foeXapG+GCZBn1jqCzRcmRAect6BFd7g2aE8SLkpmH2WgWHajwcNB?=
 =?us-ascii?Q?ZAiuNBg8WbvOCMEK8/FGcwXAjVGLk/yZ8sQudpDdXwvQA+qQhLqeSStMi7i3?=
 =?us-ascii?Q?zGVTb/ySSBRRRfl9vaifGIm69CEZ2drMzCyPMbSSoOQb9tB1uZafmmML73A8?=
 =?us-ascii?Q?KZeoKb1kGEWKt63bk5WPckDRSu+2VUy9JkSSCbWsdhn5HT8QD7IVoFg3lOoR?=
 =?us-ascii?Q?SRV0GXKIauCbOMbHLC4IX3WeSI57vVOSZXpuh7zee9L7kXZJEyvDcNEA0xOM?=
 =?us-ascii?Q?ic8F1tNkElouUBelh+NrL0fkSpr633R2uBhFYEeq/zxHA+W2snyBOjb1oEn9?=
 =?us-ascii?Q?nrCx80I92b0YpuWapAYAKj1hjoA4Z9LqdvDXKFrUV2kztaTdY7WiHC+5lZsx?=
 =?us-ascii?Q?svYQ1lgNKazQvU7KvY9y69qqZwKlsEbWQrphtdskuDPRVDwuqFOqsIeDP93v?=
 =?us-ascii?Q?zBv9p8N5sXutpQPq14E0Qs8wkd6dChQIxceCGaOMI9lCIKBj1A94mqtFz3nc?=
 =?us-ascii?Q?8V7WJh5s/YGhWdRxYfX4uOH73+f8hH2F95Mh5k7qNLkBW1WpGQxvRgGygIU5?=
 =?us-ascii?Q?X0BIeO/7HW/j2fVYmhx5f95u8T1v3UP6Opc6NMphX9YlP0BUK7Tmj/y2d+nw?=
 =?us-ascii?Q?6w9JW9QacSqQs77fC5pwF+/W8Y0qqApLi0IBrvtz51tlWugeH0EBRMf3MU9e?=
 =?us-ascii?Q?IwrnuTSPF4kc5X7vrWA9I8nGO+/J+Q2O0qRrKnjw9hCBqNzKtOu0zhYd+mXD?=
 =?us-ascii?Q?1N34qPnM1DF5FA/L2U9EA0hKq65y9m3NSSR0TJdcNUh8f0NIUZPCBvWgVG27?=
 =?us-ascii?Q?d/8cwU5iCPlBOT6Q8ztRiDzFIJaOefsKbIDgUbl7L3h36dWECQmnIrMkuyoL?=
 =?us-ascii?Q?UqbBZUixh1rEYSiKnRL/+s/pJvZAqoaROfz6zJiXH97Y0eGMzE8GWr6zXJMF?=
 =?us-ascii?Q?oAduJd8AGWHiRPafG5xMImo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9aff0f7-1282-4a75-e8d9-08da00f121ec
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 10:48:08.3576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDuMxjDwL9KEpVU9vYOrmRxI2wEWrF45Gxh4kq0eBRCD131fNOYFbzl49ffv/BLsatbxJFFaP6zkC8R39axT9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7929

Some cleanups.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 04aef0f147dc..87ee7bd8a689 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -13,12 +13,6 @@ static int verify_sk(int map_fd, int client_fd, const ch=
ar *msg, __u32 is_mptcp)
 	int err =3D 0, cfd =3D client_fd;
 	struct mptcp_storage val;
=20
-	/* Currently there is no easy way to get back the subflow sk from the MPT=
CP
-	 * sk, thus we cannot access here the sk_storage associated to the subflo=
w
-	 * sk. Also, there is no sk_storage associated with the MPTCP sk since it
-	 * does not trigger sockops events.
-	 * We silently pass this situation at the moment.
-	 */
 	if (is_mptcp =3D=3D 1)
 		return 0;
=20
@@ -28,14 +22,14 @@ static int verify_sk(int map_fd, int client_fd, const c=
har *msg, __u32 is_mptcp)
 	}
=20
 	if (val.invoked !=3D 1) {
-		log_err("%s: unexpected invoked count %d !=3D %d",
-			msg, val.invoked, 1);
+		log_err("%s: unexpected invoked count %d !=3D 1",
+			msg, val.invoked);
 		err++;
 	}
=20
-	if (val.is_mptcp !=3D is_mptcp) {
-		log_err("%s: unexpected bpf_tcp_sock.is_mptcp %d !=3D %d",
-			msg, val.is_mptcp, is_mptcp);
+	if (val.is_mptcp !=3D 0) {
+		log_err("%s: unexpected bpf_tcp_sock.is_mptcp %d !=3D 0",
+			msg, val.is_mptcp);
 		err++;
 	}
=20
--=20
2.34.1

