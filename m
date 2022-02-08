Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1A62F2C
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 06:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644300249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UgyJGOtlQ6XO7LkCU+PVDT4xobsyZxAkUaqtWWp9Emc=;
	b=hazcDP0ptEZlY6dtdHaWQ4wwwUlKGoI3ZHjWuQ6ksFv+HTHw9r0ol4y1btHV1caMNUJ/8e
	24cbNRW5/dYCoMcsmi/b/7jtxJtDHe12BAVCoyitdHryXRa1VukvPArxiMC1y2gQYw5QfG
	tp2i+WvQjT6HdxtSBi6UBNELlG/7Hy4=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2054.outbound.protection.outlook.com [104.47.8.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-Xh7XTMt6MyWY2iSaWKvcjg-1; Tue, 08 Feb 2022 07:04:08 +0100
X-MC-Unique: Xh7XTMt6MyWY2iSaWKvcjg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NggZG+02J/SgpVSStckieJv5ftzUwluB4uKTTgWS5akjWdr2ZVvWFFSeoXQ8NRquvM40v95PuYVfSOBUJdH1IQw4Wv7Yw1GP8Hx1ss6bIOjZinaspKkHTZVtovxqQgdbrcEwIiVN8lg2fIWHeH7oIfg9XDKiX+lpk6K2ttsrbeHKGX4zKDsU0BGz3wd3zKxZ4qCQsm+Y5CaBShfZhrxmFEIPGHsYmTNJlCW4ZqveSZJpIx/M0OBxk3FrjZWVvxgcnEGDtbgQAuh6RsHD3YzzoDPi4hEVCCBQWDKdc2HtZ8BXzTO8/KGrn7LPGUXQf90hCV6zm9+LhXBrRunO7d1gmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RV89vTU9YvjPo6Iq+o9Y/wzKjt2dm5+ixxCXL1gFxJw=;
 b=P1R6IBPnTxDiTgd9H5NCqd2JW3ALPzCJ3tb1p+eqJDTqowEpmruwz3mixObpjda5HwrT55ZQjcHCe18Q7J0lUA5zWBctCdR0g/QK7lIiN3wecIs6RaEm/6thf6wt+LKgXbnFjCQ4LXqfG7nvumSlnij9GL5f5JXWFHNmKCDl4HeVr1NOyH2KWrwEIO+NPlTqqODVQTNDD5rSRvurPahMhOYgr9SxUNo+j5c6LppwaMCbcQUfJ1ifFznQcaiuz9afkF4zGwVsJEKH4uibyRmlBWhwaQJ9NId+0gKyIwMKLrs0U+DBiuz5EWO2+xR2lE8x7rdKVcyFm03+NTYkV+EE0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5569.eurprd04.prod.outlook.com (2603:10a6:208:115::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 06:04:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 06:04:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/2] fix mptcp bpf selftest error
Date: Tue,  8 Feb 2022 14:04:22 +0800
Message-ID: <cover.1644300192.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0069.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa42d750-92da-4364-5f22-08d9eac8d0b4
X-MS-TrafficTypeDiagnostic: AM0PR04MB5569:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5569474863B3A9973DFFCC27F82D9@AM0PR04MB5569.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dIOPJ90Oxxts5T1IcFK2tHYBWJenK3PSU1zI6rzbv5oJOS649fSw6ubAZX/WKLKhC0Eze8REUz/FCG3N8U7e8NIx86iVMIyZZHFu3M/7tMqlr+TTq8YY2RR6SwXlBkFxHiQz3MldjERs/Vbmdk5D06+6W9cjJaLHWTtY52T+wFDRUehrG6aYy/nrhBaBVduU/6z+XkdT4kH8VhO8wXuVF+i2vUvXjIZu5DGuR18hRFRxGTT9B/ozEk5t7h+GGPoISXBD6D4/OSOh/A3qPFH0E1gGc1H+SqX2I6a5Jpo8vfxxFLjOrAp5dul/IXYMI3GQLzDfSE4Cuqc4n5dYl2m/Z+rAsyIo3oIbzPyWyO9xrZghv50N+hobhedRyKWutrnJOtSKVB6UXbB+FjU5bKjUprzuRtCKlEus8IjbnywIVFPmdwgtR8UD27gbapFcibLtWGxzCg5D0KLff2H1UHU4VKThduZpi59uVu3O5wZpyKecyvZzVW9kmHxQl+ek+gSO4kRYBW3pE4BUbEfMm9SrmvHDwmdLsW7V+z8wUuErkPvnIAcxTp2+G4YTqvRYV1JqLkaTU3sVHkloF+O5Xjpw1z4Pr5u2bCQ/57LuC32Y0GRSKShf8gpggwTLb58rfB37f2KFBrTzSs6nmlPyXnJB6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(83380400001)(5660300002)(6486002)(44832011)(55236004)(2616005)(186003)(26005)(36756003)(558084003)(6512007)(6506007)(6666004)(508600001)(2906002)(86362001)(66556008)(6916009)(316002)(66476007)(66946007)(38100700002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?thrxDSgrD/s2ysW5glAqq833yREAW0Mr1yGJ7ewlz+PC870heWI41Z4nkX8k?=
 =?us-ascii?Q?a0cws/q6ja5pU6hHQTTujLs246/oJSHtLg5SV/1xWb5Q0VUybaekWAzbfjvq?=
 =?us-ascii?Q?N62S4w8jCW60SeiJ15IPQshz5nhr+YmSLiCiO2f3jV6O034GVEoGz/bM35ae?=
 =?us-ascii?Q?TFZjD0qC0XD+QCiHzfXdZtd9r8kAmpeyauBcEz3W+CEDifpXRnIYDMmscnni?=
 =?us-ascii?Q?H6iaP0uYiB2JvVTD/1rxWQexkoWQ8XQeQvSpAJ/gYtXJzeBEzWmAeXtw03sV?=
 =?us-ascii?Q?r6n5vorqssVVnMu2mMtEU92wpg9YhVNCwaZcRvI+jRUfY6PlkRCn8aMrXrhn?=
 =?us-ascii?Q?iBq4CG2O3D1q3Xpd5NMknn1IfzyXtzE4AdJqQf6tCrkosVFIskcaRL3F5sc6?=
 =?us-ascii?Q?JCTBdfjtDmmd69S8XQ5hat4VNnteN4A00AIr/peRaGjEXUt077qkbBT5LLqK?=
 =?us-ascii?Q?u1leKiopepJPKWtirER/h4FG8B0+F0BViI0tjAyBlQmBPWAm0SCxk0cA8WCm?=
 =?us-ascii?Q?CfVG7mjb+9uaIl4d8S+ivqPdaMUDrTcgRugPwgEFdWe2Tfj4XYFzoq9XK4TJ?=
 =?us-ascii?Q?3F1neKTMJ5NMEEbqNMkPxILs+jJWBU8ayMInXmPtIdqxUGYAZDBZ8lyFeqfd?=
 =?us-ascii?Q?65PQ/bo/b32k3ilzcBAZEGy2HKNpj0wIhX/QWXUZ1CT206/Xr050Ge9QIOgL?=
 =?us-ascii?Q?+G271bpMDhBlNCuIK4PztQAb/T54LhTtGNgnzt4M/01+VHXrYppTt4gu3CF+?=
 =?us-ascii?Q?ZFGs+wPgkzHbLEnvV0V31mSzDleFSmn1a8WdIuAZICV63s3HhVZlc7bgGJ7W?=
 =?us-ascii?Q?xmvrA62YYwsBj2edIEGFrcwM3Vd3U6hiGQq3o5ERTagYnqgahKnXB5cVDR9Q?=
 =?us-ascii?Q?0NDg/Fb9dvfmQNPOfm1NxHdWSMvebSrA1oXXqBrebUsmo1LO150OI1HLYHSt?=
 =?us-ascii?Q?/EzQjKesmXAQzIJRbrD1of6rPagSGak8RwV2CI6+nhkrJoKxo8rlspSrlMZM?=
 =?us-ascii?Q?jmzf2oate+jo6HblRWsmdplDCfhERS9WU/Fh1hT83E+kwYQBqs3rwCJpjRhD?=
 =?us-ascii?Q?BmSKbFcqLZkO8d5SoK0Y6KR3V+97M8QQt7rSZan96qgoI9ig796j7Qr5MJYi?=
 =?us-ascii?Q?NWIZtFnD8vUVKkg1XonILIUnwvxcxhoUoxz6C7P1dsoLAXlFNatWjiwDzy1I?=
 =?us-ascii?Q?80OJqT/a7oHQDHf5fR4meaPRzC21Qo2qnzlN0lialiPiJYzoE2dBTXJNx8vn?=
 =?us-ascii?Q?h+DeEttWE8pIjVfJ5rGr6AQ1fCMv+eFmQUy9df1s7KZtQevTxr3p135t/Ert?=
 =?us-ascii?Q?f7mk07rc5+yInG7CerM/K2m3XSgRWhR/QDwNvwhpJ2TToTJur/kZ5c80faaO?=
 =?us-ascii?Q?Va91OiRQNY8hs4AwdFDevbzoLzp9RhhgMg5oB2vYpDp9FxAqFZZEltVKLA6c?=
 =?us-ascii?Q?BRqOcG8dZtWd4yC48GD++C4DNqsOdQUTEJaCDcYZkgRaNcqhXhERNOEVsKLD?=
 =?us-ascii?Q?0qnca/46LHpI8qmqY8ALt88+zi04eY83Dl9PF1ojaRFKrUAGbNvJYELYXeFo?=
 =?us-ascii?Q?HM7D9UWkLzq5/H5Vj3bAx+76PE0D0YIWaTTAFTfm1LEK/LFNNHM+i7PTsq7V?=
 =?us-ascii?Q?CEY4o58kKfAWZtzeWVStveI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa42d750-92da-4364-5f22-08d9eac8d0b4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 06:04:06.7038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VO25Z1bASSMfojvTYpJ4tsq2s85cF0Opbfq7C7K38FYNhFnMfR+sT++2Aq7fdWnUwKpHNWvCmxMwV/kHf2Ju/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5569

Fix the mptcp bpf selftest build break.

Geliang Tang (2):
  Squash to "bpf:selftests: add MPTCP test base"
  mptcp: add SNDTIMEO setsockopt support

 net/mptcp/sockopt.c                            | 2 ++
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

--=20
2.34.1

