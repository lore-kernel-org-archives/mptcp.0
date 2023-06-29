Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F87011192
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 13:34:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ih3+r7Z75c9UV5IpPUrdMK9TXErnZooVkvN4ZwRgkypAwEmvSYAO+4h5bPo2jTi2nQeZ/UVtB+qRvVNB415ZeuZjknz8FMhdCYJX16kW85UlQeKz4uEm1voyKjv/KhspqIg3T3h+bSU0O+mTEgGXNxziEx/3pr7DDV8kfGsk9IzrTZJ4G1pwptNp/PE7FN2H2eZBaDCndDOrFlFnGYJWFpg8ZfiS2kjSVW2pLa5Ic0DWOlWPqCT0ffk9kVrep5bSWDmJqaTRzk6Stlb/a5QjdsHKWvMkneq0iKmgr4/og1oZxT4z85IG7oxC0yJK2QKwKcdhmCRkGx8KVyrvEMEwNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5M3NbqjVBXRSCtRyXTnIMNl5aIsBJRc44lKvNSqTkSg=;
 b=EeOXQZ2NAF440+KC99JC9bc2+SajqN0gLX5IlAGpObaCmBUBkLV6+EYvByzyvmKHQCjAhF7Y805dPVngg221qyl9yIm2haqWKEs2zcuWhuixnPClKyHAl2QILFhAU1kn17NGcq4QZgiBdDj14x+dZa2QYfsW9L1rJDuxacT9l4Ycxg8BlG4Y9Z2pI/UE/2Ne4EQZNaRxV1KbFsUYKducEImB6rZcVW4xUndSHUQUBEEWxgyFehAi+tZAMH3xhzCSPKIkGdS3BxxIV0UPw3L3UsyOtENinZqGBqL+UhRnmv+8E20TE5TafclVoI0HPKiBV5mkFXLK/8WLnYOhG3Ce6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5M3NbqjVBXRSCtRyXTnIMNl5aIsBJRc44lKvNSqTkSg=;
 b=ASw2+d0ZpEnEHPGB5lyi9b9VxushW5lfibgG+6GbkPwoHqVw9FNDRVTg0tZ1rV6+asZGyNNcw3j/XjlDWdpA6A2bMcA3/MtoSoDYHtL4xZnFiRQRSTzSdtEzDHuA2PsCYsNeMZFj3Kw8Zv309LRYwsgdf85njEWVDn+Bk04A+sEl7NfHBPtJ7/l48ZxPTpUY87gVT45EvvxKgZk24YX1JX77OcuHko7jSYMYjOqYAxMeTYf+x6GKMinVJd3uuh4ewVNmxap0SYS1uXXc2v7hPRFSteXrj1lo28wdbOFF6vvpUK/LwfKWeck/mhXnBUf++Tw1iZqrJphI2c5ZNDzhvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8286.eurprd04.prod.outlook.com (2603:10a6:102:1cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.37; Thu, 29 Jun
 2023 13:34:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 13:34:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/4] update userspace pm mptcp_info fields part 3
Date: Thu, 29 Jun 2023 21:34:28 +0800
Message-Id: <cover.1688045383.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a0d86c-c4a8-47eb-3749-08db78a593a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JNwVeag4cT1IjrmL3HbrgG0f1Q/xFzPweQyVrQHZ7iJUnGN9I/aAMhSmHF4hdBZpqMSPEGGmN/1Lq0ICMAgNN1bOiIVVPEQscMKdvlolBcCVOVSRIXVQg81bJGlq5/SxldylX0p/eRXz/yTpBJB7tTvT9kl+K8EfW2rUJTCndDBz6gazyaA3fvomRH3p45p/OdT1os2Sm9wFgD4ngZe5oiQO2BbdAx1ZjIm+J1RAAz9eMMAtXynvd63MkfqNv/jHoiVrAchiX0LPoxlkgce8c+18oQQ3cue9TR2GjZd5Pm+7EnWaHqoN2Gff5Y6qD0u0yv/gAmS0w1TcxNFwk4/sBavaIbmMNacYBLZDAW3dNRxChaUYNlE6SorEKwdEm6jTEgMCcuUIYhycA+5jxXWD+QJnAdOd4ORylKy8aVyTXI8EGH3erh1HRPzyzVuKhYmk0a5srVYrsdvzf9Gbg+Fo29rVf9ZYT1FITYyYVwQsbrQXEKMuEgYObECQ45U2FeDJaoM5WrzS2WEc8a1gikLMMRZFBIXfYXPkbxaE7RN9mx28aV4NBDWpXfpipwriwUYv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(478600001)(6486002)(6666004)(6506007)(26005)(186003)(6512007)(107886003)(4744005)(2906002)(66946007)(41300700001)(316002)(4326008)(66476007)(6916009)(66556008)(5660300002)(44832011)(8936002)(8676002)(38100700002)(36756003)(86362001)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SpvwUCsfkB/3EgWlA2UYmXGZw9yY6tM2U4CUKcWbMqajfecQhPuS3owKPzPk?=
 =?us-ascii?Q?0wvT34gFSehMW0Q4Le2WoQD0u5Sq9C2lBN+YW1N8g1yfUHi75EXSwXU6f87n?=
 =?us-ascii?Q?yWCc9v/BSvLBxEUKOC7FbY5/YlbID2P++yYIe5JwfCcvvAUU4vx+exXE6XF9?=
 =?us-ascii?Q?FJMoFpfIeKpiYo8pi+ThKgoGk648td4e+gaQAMtM7RE7wJNiOO7TmaSx66fI?=
 =?us-ascii?Q?xqWCsZveNAoIBypA0Bf/yypxFjXL0tQ9T7O4MgmPq1Y77DNnpq3UCUPKkY9t?=
 =?us-ascii?Q?F7SrrYBwaWDrlODrGbuYlYPYCDkuVuCTg+Lq1Ikr93tFHOT+Z9POADCwLfGQ?=
 =?us-ascii?Q?rpit/pPQuSlozCb1mduttWMDV7fvoBXUUYyYhkvOWXrfLdp7phqyGT+uduNC?=
 =?us-ascii?Q?cPuoQPeNjrc6TC7rE2c9GRd0EvP0m1fZSB43RoIIoRrTf/Ihj9rxs5Q1zJuC?=
 =?us-ascii?Q?uJfkBgg5AoPkqlPLuilfZg4uJ5at7cPfWpKUXVNBCIlIhjo+4vchnQCwzMx1?=
 =?us-ascii?Q?8GajL7XCVaOp2Iw85WdPpESaUMjZk062Qi/bfqzxUATKtg4iXvAu9N2gOEpy?=
 =?us-ascii?Q?SPq7yakJh5U8Y2SOFIDR4Hj3GkgNAv6PzHpFl7lOqUj2djqB+X5/OZxHKVB4?=
 =?us-ascii?Q?HwTQXtfYnrhd2u0fSGbH4upxEZrdlx5b0qROAkj/yaaffQ+6JqkOaFuc8hwS?=
 =?us-ascii?Q?a8ZRRjB/WxdhryJEM0AORjcGlShuLfajqGS5DzqFUQ4fJvvuFw3KkIKRpNQX?=
 =?us-ascii?Q?h1mVCEA72lywImE/KmwIN9aDoGpNdvUx0gKddvpAWcaG0iAhRwiHCH/rJJxC?=
 =?us-ascii?Q?pYZGwCtQDmPK6UpY5aOmhJZEVbWQeUeIaSgy+1o5NDWSD3v4lebxaEBAFhUs?=
 =?us-ascii?Q?/C8cxMjL75V7lyTevwAYRsWJOiLMcCOcaIpyzKwoH5fo799MMNx/KKIQIy0h?=
 =?us-ascii?Q?ncwaQDAbeLeo+P1LkZtaTzMRkdbpNbg8Gb85cE9qhSMzAy3Nrx5gU8VvsjfX?=
 =?us-ascii?Q?aHgN52wWktCncPb93VOQ/G3o/UYrvZGs83fYB2b1DJbKd9tIuZAzqQxZz0Q/?=
 =?us-ascii?Q?JmFlnguzxoH0PzGBjXcE0yzuCVCBtgy4zqgA2aQhzj4zVFpgyM/Y3f5pmwcC?=
 =?us-ascii?Q?OJLeZAus4HYY5Eqq/JTDFAbTewoHA3gclI5u9Ib87zCC793J+Ora9WjKWMvd?=
 =?us-ascii?Q?xQ3QBFSkKRuZG6jmjP6EorwtbSR2+PQO0KNtIa5l0jjW39KcbvjnJy/yxsfW?=
 =?us-ascii?Q?hfwlOhQXc7S29IjRy3QSxGeobHUrFoNOkTu3jYOmyWRECPwGc6r1h4cUqvue?=
 =?us-ascii?Q?qx13Ug2WGaEZPmgijzPKgOebkQpMcAFgsjciUgwoZnzQtEZtlIZYN0X3npjU?=
 =?us-ascii?Q?dKbYdBnRRWnaxgcJzfQKl36PGl7ImOrm+IRb5mdMphEAc2L7UeeIh8noZlWl?=
 =?us-ascii?Q?05DfBkLHeesuZngKvOV4hU25iTG5oULmjfeVzmOlQlGVnWSoWXq4o23C70a7?=
 =?us-ascii?Q?ENKAafJnBJfK3ZPQU71r8780uhbSqCEKkQYxNxj8HzVewx71MKTM0Ba9l0t5?=
 =?us-ascii?Q?8m4JtqRhZXLMYNbYmZNTFCxoIZ4aoA9GBnA/VSdK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a0d86c-c4a8-47eb-3749-08db78a593a1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 13:34:34.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDZgVPvzjk++tTSALZ1CznSwjswIrIHVBniRi27cpvt2zzL2e1GnDoaU+C/4C3XPj861Zpow5aiXfr/OZvsY+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8286

- add three new env vars
- Patch 10 "selftests: mptcp: set endpoint out of transfer" of part 2
 v20 is dropped.

Geliang Tang (4):
  selftests: mptcp: reset all the env vars
  selftests: mptcp: add fastclose env var
  selftests: mptcp: add fullmesh env var
  selftests: mptcp: add speed env var

 .../testing/selftests/net/mptcp/mptcp_join.sh | 257 ++++++++++--------
 1 file changed, 143 insertions(+), 114 deletions(-)

-- 
2.35.3

