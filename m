Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2059.outbound.protection.outlook.com [40.107.13.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E280E808
	for <mptcp@lists.linux.dev>; Wed, 10 May 2023 04:20:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nd3if0PBoxqc/5n+CrKt4XnaLNoEQnI9Q92GU15a/9vgHcCce9fBAIKGjo95tfI3SqU965NRccP8FVl2gk7GNjiYxzGYwVbEOvwZrMjz2PIZf8GGTfqpVElG8Ba9wj16giP4N03MPMkK1xs6FXbLx8wlXB8Ustuto6/wS17MGS85MAfZQTfvW8lH5kRiryIi0cGlfHjYSiY8c7QrXBueVf2J2MwLM82Y/7KWlbCv4wxgpQX0ucS6Bkg6fcvTRR8+zYaHFHQkx10E57tt4CMgfIriwtjJ94xX4Xjz/r5/i7zdAXye17DdDa2fY3bTq4aaC2DH4NH0JDz2dtye119I9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uPcsK1HRQipGVCz1RQZqVahcxyMoS7rDUPjUGbWgGY=;
 b=nowckcgiMDBD2MFTrxChp1lYYneceE+h9KiFbi5v78y47GVJar9DJXpAKWALJ1YUnGSBYQrg/j4fJSHgetRTDGcO8sGIn3ZjGwxqDqMXW48U1P9U+HKwgMSbO0AqDAuH09qoKS4vQ2S7AQ8t6f/phGqgrqn6lMHdwmGCkmoz6YY7aiVwCpet8NzKplpVt8uKq3Khrt6BNzKozqdHMynTpd+vkVmMlNwPxLQ2DKnNwVzXBvwJlSnRuNsr/FcpW+vNltQqcYtSE2+6xlPlhoUVtQzWFCTR9KidiOZhjyZAJekENTL5qC0aHOtRotO0ycTUHFORDJ8Qmqpved4rzBrfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uPcsK1HRQipGVCz1RQZqVahcxyMoS7rDUPjUGbWgGY=;
 b=DjoNiDx32G5AspaMwH9nTtRml1EIwzj4UDNQZkvtpIjXI8ImAkvIZz8Os5CDypWhcjZEpg8YAqcq0F4QuoP9yFP4vbwiCWpDOIlqJ3qFsJ+CKYBz1/kGEzyBN0PQ1yGtsy6NRrO3BKFQOZNiZZ8ZGL3yCdl6S59yoVgKHp9+AqnUv/O1xd+imFL6dFeJ4R5cxqF+aGLZpw7Z1s1IUvgNdugtXBDQrFqPtQ0XBv7cvnHsmApniSEspjJxIILlEyyu3pv6DkA8N9lwe1RsLON+ZvjrvHprbnuFBMEVrkvquq3+U/ouCG04gQhvijVexmQAtGhoDRvyDaKaOYau1VaClw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7146.eurprd04.prod.outlook.com (2603:10a6:10:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 04:20:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Wed, 10 May 2023
 04:20:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 0/5] update userspace pm mptcp_info fields pt 1
Date: Wed, 10 May 2023 12:20:07 +0800
Message-Id: <cover.1683692137.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0145.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec69c1e-2291-4f99-f4d9-08db510dd318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PchZrGPw5YgxeuTSTmIf+6URVQKYb6eHUQfSjikk7dFhvh7or4JMksLD+wNI+a0s3vKbCROIcwO45O8f74LnjlHUI50pFa83dw9P373fL17qomqoSxb4fRKMcjyueJAGRGD4XlZPLXY3G/QMyeUateqjnRUW7kEOy5F1s8JRc26WUFwMIlJocdr7iVXaHfjt7sjrZzMkcofC0dvR3W+DJ2uDf9KAYpFh3XS7WJ5QjMuGWkE0VDrRbk8ReifiQR0DWueZ6aoVuw5WSy1ECDTIBv9GZo1gUwXkeihRSD+6N9v/77hLo/vMOuXDd1pvrVxdCuzpvGk6aaOtNKe6lmzf737/m1/Xo6fJpBkBabSvvC7BptxLpVfEaJP+ulN3zV7Tt/BaCYU1+FP11ItgeMHBB5fjrM4LTyjuj+z5ZV3iv17bWAtPU8vamNeAOObSTQiKD1yyW72oacKjO4GQ5C2rW/uB6GNSXVycTsT9/vMj2kwdnEiqCe/cxD2vr7pIB/3WJA6qSrJVrq9YkcaRy8NRa9MAByirj6REDPRY2VO+ytatxIfPifgt/a5Ys4pfxaO6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(478600001)(66946007)(4326008)(6486002)(66476007)(66556008)(6916009)(316002)(86362001)(36756003)(83380400001)(2616005)(6506007)(107886003)(6512007)(26005)(5660300002)(2906002)(8676002)(44832011)(15650500001)(41300700001)(8936002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NiyzBTk6iQkVYlxrxYLWgiftPqrt/K+ZjfqcBAzftDZaJj3GPGVQwBuH6s5R?=
 =?us-ascii?Q?TUGeUu6ryx3o+j4zCA7LKXW4M2j0nBeKFkfPaUpZL7D1qQWVeHJS82lO/Ggj?=
 =?us-ascii?Q?J7atHfwmAcwC0EQUZW59AWkoLR6R/HciqRbED6fpfEji55NxpzA83ML0wH2B?=
 =?us-ascii?Q?AlG/fyOLpcMrtIHlotXpbdZv0DwGgnNCgB5q/K75O1RVKiTkz/jkCu2/o6+b?=
 =?us-ascii?Q?uQ3pyHYDdi0uFx31RHGqSSpQ1eXs2m43ekkArpfKnKadSHW85Ay3xkJZxPs4?=
 =?us-ascii?Q?1XWoFUHxqYA4Yu/yf707Oj06YLHLYbz7kTzb6mhNypy2hzDzkvDjsj8H/KM5?=
 =?us-ascii?Q?cJgeqCTeUwBKfok8FRe18Fn1wMftGfphxe+DqoqpubNl32uyw+9gY2SflAEP?=
 =?us-ascii?Q?Kv70R2B/FPbFsY8YLYPn5f21x4F+PMT7V1GEXx/aNndvPV3POQrMXgLplHVl?=
 =?us-ascii?Q?FlB5FLdtDHh+SeFf9+/6R0rQsaF1fn3NKtSpznL41bG9FpSS6wnCpa0gXZ7L?=
 =?us-ascii?Q?wuVO3367kUuAiR1onI81+hwIgRRkb+sm7x7aSxz/7/NkacjyOpRWHimXM4C4?=
 =?us-ascii?Q?GaB8oFMj9a39NY9RDvBqB06vF7XyHLPMlI5Pj6zEqSY+uhMxOd09R9qRWzfr?=
 =?us-ascii?Q?V4QJ4yXIwU11vnXzncjdnNdAsT10iu5XAwGT/w34HoRpuIIznpYJ79ZtUqOx?=
 =?us-ascii?Q?liTUamyrXpaQ4GBrf6njuPTggKp76xj5YxqdfAf7DIL+IZxipifr3e15Nn+4?=
 =?us-ascii?Q?UcicO9pT+MrPtTkKZEGEPMY7jNtsKa5WEzmBHscy6lkN3oy7QHVINOaVS6Mh?=
 =?us-ascii?Q?b2HmZnApAdo97Fu+GQ896BzyOCGLEbIMx97YAsKdN/Mywu5idxHvvDzgXw1O?=
 =?us-ascii?Q?oSaxnWlm389np2kuEtWl7VM5tZgePEuAaa5PykHx7wye0UTZGOg6AbA55eRd?=
 =?us-ascii?Q?Wr9Pv4oTiuKTtdG8MmeO1oZ8gehZVNU5r6hgpPIwxdBdO4XTrLA3Q6zPFLYQ?=
 =?us-ascii?Q?LIU41vy6kU32ixMpjSpgMWGhe3O/+Qcmg9huI37+J9Veiz27Ek2H1yjNSZ6g?=
 =?us-ascii?Q?GyB4pr6H/bKJryvCEgWyX5F+9rYynztP1nAX4jqPpKrY23ONw0bOKBx8a4He?=
 =?us-ascii?Q?vyiPiaz+a/i2KF6I6g8tRqSot1onBcEka+CT93WCQGw4wSX7FGVUFQpptsTr?=
 =?us-ascii?Q?RTAirxwcCnb5HRxTCyp5aFyHUvd5Fq6DBqA+lRjfv9qBV8+dQv7kV/cEboNV?=
 =?us-ascii?Q?GcQTzvuUku3SHizxyoQZcLADEZz8qgzKAd5MNa3rqvgyQXwKjSBD8p87NGJi?=
 =?us-ascii?Q?47+5zB2c8Hcs5CJ2uBgokTB2FzD/rEA5Hmnit0Wr6VwCq+mxdhqBsON//SYC?=
 =?us-ascii?Q?1SN7BIKQ0EiPz1BIIdsltVR+9ISHQ/e7tJnQ6y5RHg3i4fMoQN/U5BSvJ0x4?=
 =?us-ascii?Q?84QHPbmz1PXl8xUV9/hDHnJzfAb9WaxliOXECyaL5A9FGBWVlYlOXI2HIMZu?=
 =?us-ascii?Q?aQ77GI6fqULSWWFakLIHb7A2oGPranNYDcKaGht3qrLieZzdO8KLqn0cZQRd?=
 =?us-ascii?Q?/uizL+gmdOF9y2vhzFFglrBSwO+jlPql7v9kB6ZJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec69c1e-2291-4f99-f4d9-08db510dd318
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 04:20:02.5442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Dh4+kkuBdGMToeQXNOYHN3A3SxOyd9tkNlylxj+PqhKHAUvV1wJg9JK9tHTecF7k7xZwFHtlVmSunqkjkX2pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7146

v13:
 - move the RM_ADDR command after the destruction of the subflow in
   patch 2 and patch 5.
 - drop mptcp_pm_remove_anno_list_by_saddr in mptcp_nl_cmd_sf_destroy in
   patch 4.
 - update userspace_pm.sh too in patch 5.

v12:
 - address Matt's commits in v11.

v11:
 - #1-#5 part 1, address Matt's comments in v10.
 - #6-#9 part 2, update pm mptcp_info
 - #10-#12 part 3, some cleanups.

v10:
 - fix userspace_pm.sh errors reported by CI.
 - fix the bug in mptcp_pm_remove_addrs in patch 1.
 - drop msk->pm.subflow == 1 in mptcp_userspace_pm_delete_local_addr in
   patch 3.
 - exchange the order of "pm_nl_ctl rem" and "pm_nl_ctl dsf" in patch 2
   and 6.
 - update the commit logs.

v9:
 - address Matt's commets in v8.

v8:
 - address Matt's comments.
 - split into two series, pt 2 will send later.

v7:
 - fix userspace_pm.sh errors reported by CI.
 - only remove addrs in mptcp_nl_cmd_remove().

v6:
 - send a RM ADDR from userspace.

v5:
 - fix a memleak error reported by CI.
 - add more delay for userspace pm tests.

v4:
 - add more patches
 - add selftests

v3:
 - update local_addr_used and add_addr_signaled

v2:
 - hold pm locks

Geliang Tang (5):
  mptcp: only send RM_ADDR in nl_cmd_remove
  selftests: mptcp: update userspace pm addr tests
  mptcp: export remove_anno_list_by_saddr
  mptcp: add addr into userspace pm list
  selftests: mptcp: update userspace pm subflow tests

 net/mptcp/pm_netlink.c                        | 26 ++++++++--
 net/mptcp/pm_userspace.c                      | 50 ++++++++++++++++++-
 net/mptcp/protocol.h                          |  3 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 11 +++-
 .../selftests/net/mptcp/userspace_pm.sh       |  3 ++
 5 files changed, 87 insertions(+), 6 deletions(-)

-- 
2.35.3

