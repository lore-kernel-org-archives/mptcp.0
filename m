Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F7915A5
	for <mptcp@lists.linux.dev>; Tue,  5 Apr 2022 07:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649144641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wMGcSIPrw3XWx46/x1YiIJodpLgyEyrinqkEcKLHQNM=;
	b=YmUsXPrH0JjVgLSErW9PMkl1SzlZUvS3oOfZAd3b3GXyT9rNWP92f1oBDrRsNPMg3sFGY6
	SxPKF4Qoz1tM9w+ZfphttIMvIqBQab2PK5IeYZQQC1GJf+wLlPnGzJAYkN9kddtVfQj+Af
	q/JOCfQNABKW+5nnNrJZqQaIYfZBK2Q=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2175.outbound.protection.outlook.com [104.47.17.175]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-14-pN5Mya3IMU6mIpYhbF4HQg-1; Tue, 05 Apr 2022 09:43:59 +0200
X-MC-Unique: pN5Mya3IMU6mIpYhbF4HQg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlMDgQjLv7mkgvM2t1eRldCINq5K7qdNUT+DkZg8ltRDxzwglP6+gMNWFVjnDfVpzfHxNTjrIk/QSBG1wwfR/4YgzF4Y2FvDpUHaoxCciQsv/NkqygcGM1pEI/XpxvOS77lDtsL6hKsq1TuEjzPqZ0mawORSeHtbNQV7Ns4orQI7jP9L/dNRHyIxgGn2vV1dG+qGsowIgh2i0V2C2Hrh8cPbCBgy2SSqcLo8zd+K5EnK9vAW5lgCewizg9D6AmqvK7/eY1b2QE6+uZhTkMg1dV2gV0UxxfkQfiHwVqY4mlbAH3DQPjbJScKtiWcPyNcmSzxGjCaq4mCueQZHOHROFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Z1jntL2hHSRUFpWLaJ99vhFVFQ2zy2VGkaFaw2hQWE=;
 b=m19QQglPZ7ZzF0i6LSHgs+qJj0xutw7rx6pDE8BgNvSDjKnIXQYQxNUjWTmcE9Kx+En0AMHQcnzAti15Zd4xYOpEjp9Iy6PF+oZJ0JQPhq6s1BatUHbvOFPxVFAiPeuHAiCHeGQykH5AuC+9ASrEdlxCSnWsL3LbS5ZaCKoynpen4pnp5FqzBKLIfDM2vlVlWgqrGW7UxQb3Ci050wOpGX/xW6AeFV8DXrXeXJ6k/S9lE0VocsCwxR1Q5fMaVQ68pA0sCSLqJLeHng88oysvsmRRkg2gADu2R1GckV74mP4uYLsJTACe01nSG1Hzb9cHeB56MONbiDc5JO7pUlCquA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7574.eurprd04.prod.outlook.com (2603:10a6:20b:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 07:43:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 07:43:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: add bpf_mptcp_sched_ops v9"
Date: Tue,  5 Apr 2022 15:44:01 +0800
Message-ID: <d6efc749e875739e663cb509dad35c3531bc8620.1649144602.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58ea5a8d-dcb0-4f3b-bc9f-08da16d80ab7
X-MS-TrafficTypeDiagnostic: AS8PR04MB7574:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB75746A16489E2B384CCF342EF8E49@AS8PR04MB7574.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tx2ZztArLzgWGWVNvEsaAxZeqRTmPQ1DsvgUQq//IeJ8l2HODoGkf2pMBuCf/ShWjcgV72puNiyryAQIQn83epQPn5LbBkwLsA/1WJFyBzoDBsOQQfuN72V1kOMeOaRzoeIs0JTkyseE5BJs871m3gyqDXVoBIgpjl2WooMGON/ER6dA/dX9XhNsP9Lc9J3gED7LBiAuTgdRmpU/h46Gvm13owHItEJ4K4gqiOFC5NBpgWtPsRT6t4Yaasp+H6fnGR7yuprfbpREwwbW5Ws3+Pq97rM5eeX7B9cQrC9KFqK7Ehzmt5bimdvfmN9/DkX4iYSFg0JlQ934pp9kRuWDv7xz9nCm2EBU85VMQU4oUxuWbKNzQHaFSIZRAp/BNEV1b8HIWzZ+vEn37EbX69sXIIkmiFyhbQmoNzusQbVU9mN6q17EL1MHjmOisBef2UIhrpkBAyyw98EQeVCjwwMe3kCzBuIh/9DL/R5lVgWkCkagU0nSMYp1Do8pH0EWmvR3fhyFsD5+M4LmUVECE3whyxTYIfOhyyqHwMKTjzoxTh8Gr2jgvz3vjN004QuzWQKZ0nW3uvi/tqxYoBhAvWb7GWzVOmWWq1yv1Lu2IVTOPg8lSMRWqFmvQx+dM3ys2Nb3lX3fRLtnsdyftIBaOe02tVy9RgMFA6DMLzwEb0oc/xtF0ha+nkH47vXSiwcW696U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(508600001)(4744005)(44832011)(6486002)(6666004)(6512007)(6916009)(36756003)(6506007)(5660300002)(316002)(8936002)(2906002)(83380400001)(66556008)(107886003)(66946007)(186003)(4326008)(86362001)(8676002)(26005)(66476007)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bqla21y3HQyyPI5+Npo/cAkjfEUZw3QxAjc7OuvRV6GdLY8OCWTg/FFt1Sov?=
 =?us-ascii?Q?CFzc0/7pyhidPLhpjYDbFweeTnP/mQCa/4IKP8XUjE01zsSbsvOsoGiSKoYR?=
 =?us-ascii?Q?t74Lbv9udbz8QBJle9Vp8A5L6L96NzvFkPdHiH0n7RRekpiSFwfjHeevEvRF?=
 =?us-ascii?Q?J4epshikAbZe8fOD5PQ3SfI9p8SqB1SLpxx9lZrXJvZzVF+p7fWg98IFCL7K?=
 =?us-ascii?Q?x4Rc5P5VCRCmhOfscpO/57JMnYpdYGxmZm35s1QXj3N9mMv9SuNML4UCpG4s?=
 =?us-ascii?Q?6UTo8FjQHE/LQ87jLh8zLUg8qodITF5rMzHSRwaAnwcuRadKRGoKLF0fn+T4?=
 =?us-ascii?Q?KJBhLarZX1pwB3YcHqnjTgKWf5qEb5FrH5T/UOjXEj2IqaJLn8pwUUcQGqIW?=
 =?us-ascii?Q?2dtiz8RJjMy9YICDZsw5Az1gfXS1SNtaC9dNZBf5a6+kmF7jukbkj58whp8n?=
 =?us-ascii?Q?vWurYLl+DhBemHIpHhvWEQ6aBu0CBrWxg2vlXDvFpwD0vLexUd6OEYaGSqBI?=
 =?us-ascii?Q?9eOETRsWurqZNDvRt11D22OmOnZ3u7h1GFeWTWreA33/mDL9eXK2JEIql6pX?=
 =?us-ascii?Q?GWCGB2FJ8BVfhEtsQShjQ7LpOSfHbtI/fIVvNyfhkOcjCgBdUqOi8NOHdzIH?=
 =?us-ascii?Q?RjEsVnAncQoMjoEvB2p/C4LaKxTgpnhgaqfKRNxeU+yBCjEpanaep4R/w8AK?=
 =?us-ascii?Q?PnHs8nu7vtv8pFr7RAQwzf/PKOX7Sf1GW5H8RZPamB4bD5uzhFFd8AvwyRUm?=
 =?us-ascii?Q?fz7b7OcdKWo7l9oCFnr2YIBsgK5YMSVHO31iY16yY2HQ4KlOn8FgOykz+GlT?=
 =?us-ascii?Q?oUPlEmexp4LBRSWrEfSDxu/5QyuabVEqS5vsLz0TgeNeLNvK51I0p+bXLB8H?=
 =?us-ascii?Q?ouScPKnStn2JRfGPmAplkz3bfZxzSI8bQx6885UHFnBeBwW9buT0Alw/+ozr?=
 =?us-ascii?Q?3esYS3inc8tcLnD2tD4/CwEv1vZPRqh1bYII07fT6XCYtdzIKsFNrEP468Qo?=
 =?us-ascii?Q?+oZdLv3B1DLkCK8FpkI8kj6OHP8//l4j7KTDaWURmxWX/jUpPwxrV2YafIdA?=
 =?us-ascii?Q?WXbddbQxlXHfSs0+bIpil6jm6rdPdLbx23AlMR507qX9SY2Sm9mMslELwrY1?=
 =?us-ascii?Q?Jbttt9D5+liNz7vcesSV+sQgEqasDeWCfRsKG4PEI+7i9rGJRGhiW2tYMDZo?=
 =?us-ascii?Q?7pLKmfoMNcZCmkRt2C6NEUBpuwXb6HwET01wKuxcWL84I4T209OfLNAsUXtw?=
 =?us-ascii?Q?mC+xLNxxMwq+CEu8yEoOZDL4B2yKT+jlmmq18CE9hUJjA/9i2WZ/3peCMlbH?=
 =?us-ascii?Q?SR5b++ZCZBHPlhZLw/QVsMosBtiL5Zv9LrBvlL063ZiTYTDDAbbehwkMTsf0?=
 =?us-ascii?Q?pXn40m0EDcY8iIkNgqsUMSstfdahNzhXw+5dnTnh2lzgQTwjd2QtG01RbwqB?=
 =?us-ascii?Q?dkZuzIKWDBKeEgQFVrEMqAzwm7yd/IFcfTAja6EYomASc2bz37JYdh1J+XZo?=
 =?us-ascii?Q?bF7T5+t1hBKbKcutOWObTCTyxKnbZtwBoOFw8LxYx5M8D4iX3GxCamNCHUv7?=
 =?us-ascii?Q?43SUKckGAtddKOfLqpDHDTAppu76F0isUgsOZtWuz8LxFbmzxofl22tden6X?=
 =?us-ascii?Q?Nva9phqbJIpbvHKrVjmWe9ho5+F5yMFCzs5iUYDJYx6FXfsU3HN5x/zPq1Y0?=
 =?us-ascii?Q?kamsiVF2f63gax2LiBInRMqDnqVbhmu9DGPk/ilD5n/v6jP/vpy4tdi7tea5?=
 =?us-ascii?Q?t9oaOOusS/FaNSVI8mMISuNJKh8vw78=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ea5a8d-dcb0-4f3b-bc9f-08da16d80ab7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 07:43:57.6469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/QfAfVIT8ZdpKGV4ReQnz6fnbcsRPYHYNF0sfrkzffth6y/xs3fbxKiLVxGUbxmNCUb5wL2x2IQF7oDhzMW0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7574

Use bpf_tracing_btf_ctx_access instead of btf_ctx_access.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 647cb174d917..a3c41c079fe4 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -33,7 +33,7 @@ bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
=20
 static const struct bpf_verifier_ops bpf_mptcp_sched_verifier_ops =3D {
 	.get_func_proto		=3D bpf_mptcp_sched_get_func_proto,
-	.is_valid_access	=3D btf_ctx_access,
+	.is_valid_access	=3D bpf_tracing_btf_ctx_access,
 	.btf_struct_access	=3D btf_struct_access,
 };
=20
--=20
2.34.1

