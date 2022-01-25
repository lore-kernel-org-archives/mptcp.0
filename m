Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7CF168
	for <mptcp@lists.linux.dev>; Tue, 25 Jan 2022 11:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643111344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g9kENoS9FSe2i2o1bRIVgpvB2Hs0rqyc5gpWim3Hosc=;
	b=cEgATWN/j2S1QX6/tqyzT7iK3DvdVHITP0DQ87OxrtALf8xA/Xyl0ltgGvLcnRARWgju0e
	troKj5xLepvis1dd4ImvE6vEf3SZVwNRdbwyGZRmkiXeH5Rw9O0PkiY3YFrEBEZOrPWcJb
	2DgCs5x8YKWWsIT4rur6Jj7CNo3RvRo=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-D6SNAnbtMQ-5KvWwTWWe9w-1; Tue, 25 Jan 2022 12:49:03 +0100
X-MC-Unique: D6SNAnbtMQ-5KvWwTWWe9w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FR6ifckO6a2xZsvfCP6tZOGIEVSFp1BoqmpLojP2Rp91t/8Gb9dzLMxqnNOhPTn1Dz1BV/MsUEFGqv+7tycVvBVtNO9Tt/KlHgZnM/SVpLdY86VaszneAowccx9eox09l7VwRaBzxTigxaRhaPs59W75+SyKq84zkoImLadx1ow0F93Y2xi7rmraqdFya89ArEkBctWKc4H6syVRoSqoj2/RsJ4/afmL1N12OoQhCkpNcMT1dX31ShaSXK/ZCnuPYt8+V7PLls6V3gcqWbt4WuMyuTM4LcbKqyQEoWkZCyJ4MWOjqfCCcSePuF4E5yHXm59IVTrA0/hJf4PkTwO92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVXc4LdaiGZop75QXMKtxelJSowM0UBTOFdpqglI6G8=;
 b=GpEYkOjNK3BapzQX9tEolcVvY6OZ8udXH8OJmr2CtGBFxh5650bDjDXp/X4NlmBrnS+uXZfyH+zy85EvTqN5XmKtM2fixmaPvjcSCQ71PsQo5O0ziJMN2V1Rtkm4H5cdQ1bPx0TwKF3uPKmRBA0Zj3ObTir1mE6af52l8a+0c1LLNHelR9GojZAGX1NmosUKYojs3GpnLT9jY8m46ryakU3uJexnPP1psd4jHeRulJHAONUCpus3i2I1CQNCYe7KnkO3cQLQhcwW07CP0TB6CXUdc+ZOwg86+aK86PKhTYPeiXKp1BXhWwrfO/I1EEl9dXBoUPkgzoX00qpvH8AAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4775.eurprd04.prod.outlook.com (2603:10a6:20b:3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.19; Tue, 25 Jan
 2022 11:49:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 11:49:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/3] add mp_fail testcases
Date: Tue, 25 Jan 2022 19:48:58 +0800
Message-ID: <cover.1643110285.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0177.apcprd02.prod.outlook.com
 (2603:1096:201:21::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5886664a-823b-44e2-c878-08d9dff8ad27
X-MS-TrafficTypeDiagnostic: AM6PR04MB4775:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB47750247954FAFE292EF1FE2F85F9@AM6PR04MB4775.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xBKvdzVsM2cn8T/hw9yUtK7dvsyiCTbn1jm6W/xBZ070UrsM6U5qOfkZ3XzkvdKGxsaSRxlRRVcU0PekOeXn08xtmJZRgtJVxTlB2k3x46Pgi1mjkTsL5btRL+CmEa8tlUxgyfciaW8dB4rd/3Lh4SbJVcXoL5vhky91Zmdp3E6aNYqttzvWwkm8F72uIIYMsQ/i9wIROk9cxBov/NKMSfnAf5/ctjDxjC47tp6oTPZ8z7D5HoWL+Iu39Sn2MhaQhAxlrDCsN0/AjOmZlmsbeq30U/MUKmTbGbwuSr71DGI+b6u1ilOYuFHi68P9g9+y+GLgNPx3Lk/qOK+Qs90CKyjo1h2WeKHIkoUug/WU6zE7qQgLAq8gqihoq/9UOUzZEoa0zp/mhhE2Oeb0ip0EO33xuPHzpV3q9aYQEQo1s04b+RG52AWGxL92iehdBVVXtXc55wNmk2LyvcOMk/zcfsZR3OtGHNRnbjH44Be2E6Ww+2x5yi4l7Hcx0EmJKpcHcgsZKayA/JdZIhETtMs0i9+SzdgF/csbF5cekBcWnogBJTi73/0sszjseCHjOBv+ZkgCYgFtjnst9uzgzbKHerHcsX8WeIvvEjfHQpuzmTes0I5dTikLYFVEXIaRz6mkgYuCZQ1bLN3ufWYbJXVa5w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(44832011)(316002)(186003)(5660300002)(38100700002)(107886003)(6916009)(2616005)(36756003)(66556008)(8676002)(8936002)(4744005)(508600001)(6486002)(66946007)(2906002)(66476007)(6512007)(4326008)(26005)(55236004)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sKaFToQnQ81SPPre8qmmlIQvi99tt6MOKd9MssUoBzx4xnorvLwLi1v+pCne?=
 =?us-ascii?Q?SjmLtCvFMPDnfeK0ElpFpNKlkxPInoo1yOuXrYvnr6v31l9tRa3oY7OViRco?=
 =?us-ascii?Q?aJl4bdn6bvjmUsr2HpWzsay/TL7WlK+6cP4HEUccU+JDH5bWL8cHgyGbZScx?=
 =?us-ascii?Q?F/3UlzvOPPcj/egDBhVJlm65s9QdtH+/Wmhwtstpjkxh7V2Rd31DrshjoUt4?=
 =?us-ascii?Q?iGr3eUN4pxQM8HMbdzXeVeutF925PahSPYVGyKS+5mNo4Ji52bj/5FwsYFDV?=
 =?us-ascii?Q?P+xQs1BsE03LGK1+SUeucmcqVk5td/lKvnKk+HSw+oM67sM8+ToG0dR+aM+N?=
 =?us-ascii?Q?N3yKxvMze2BYU/EORamCWSUqdJLFhJBrJCGtKwEk7MKKdG3pEgCqfMeSwRPq?=
 =?us-ascii?Q?8m+EuzgpXI/OQgMZUXIj2DBE53NWF9FOdOdSZDeDMgbiVE+PyLO0AAkQDcIW?=
 =?us-ascii?Q?r9eQ7hr0JczMasj4loiD2jKvqmaINjTQpy4oOIgjqTNwDivcxVXyEiz2nmRx?=
 =?us-ascii?Q?8wnYAa0s1aIe+TYGTlr5nEvZ1nTHFr2Qb9mEC1IfFqZmtFwf0FDP9/jCV0uk?=
 =?us-ascii?Q?ZlvzE0lnz6tcwZYyX2vpg8RRYgFpC3m0FckSH4nyhbiM3FwrmmsszSL/MX6y?=
 =?us-ascii?Q?W+0xcteeG+4C0OINLsShclDeTkTvWA/mWU6aSKbzr6t3TYtSFAd6igbfB+RF?=
 =?us-ascii?Q?uNv25CUxygRCU2vhKQa5pELWR/zFKcOjDQ7KVP3i7StpUF85FLDvSZ6FnfQm?=
 =?us-ascii?Q?pJQiTzrgqdm4mn5izMN1ZOEZMNQVvYELQBzPbNZgn3XorIG6oW6GLVrlUO0O?=
 =?us-ascii?Q?pPhqDCP6tgwgIC2rPR60IUkFC0OvEjO5U44J7KG/lEu0gmjXMOLdiuEWk51R?=
 =?us-ascii?Q?2y4y2aCasqeNRzxPMa/kJPAhFIDugCZ03KxQ7qsbwFJRDagjf5kXJ92tGg8K?=
 =?us-ascii?Q?NH+ILwUfQha8A33YaEtsegd9ZYhrUl5Y9/2df7y/N9y2RS+Fszd2GbRyeZM9?=
 =?us-ascii?Q?fPWDdQvifyaVK0E62pUzcr1CUlywpFD+jSOQdiVngPBYbJZz8S0zOghHo8ll?=
 =?us-ascii?Q?aqdgCJEDbYbRLJnizrWeQjPSoeVzy/cvrOY94V+kObuqR3TqeUZ8P5uQMK5G?=
 =?us-ascii?Q?hyQeoulCbwWiR36X6zRQ26x5llKTr6IgnwoQFOHIUNL3ZDPAhEFyGPQG4H7Q?=
 =?us-ascii?Q?JL4SKhG9Gm7jkITJhiXpqlX3UsQsr78BXD+V9Wkdv3WVLfxwk7euMIQmLTci?=
 =?us-ascii?Q?THFgoIaMsgj331e4dKbUh6arT4m4Q4sSUUxbxyGNlegB5Ce/ik5mLU5JBJGD?=
 =?us-ascii?Q?wxQ9oFv9qqp0XR7Q4eVS/rpHn1ktfEBwrsCd+DDGmJ4tQrwE+EDtaJpEkgq4?=
 =?us-ascii?Q?rXqPKZuBygNAGDfYoi3wet20ttbFrfXWrS9KrnB0jXDUm01YJYuXlCd+Zfdk?=
 =?us-ascii?Q?chAJcXMuDYP+iG1pYUgRaQmA7RUZRaS4RRbJzF6ZMNs01uMScX0YjJMmmfRU?=
 =?us-ascii?Q?rdu79tQwBLRxqCTt2fciTZW2999ZP5Y9HswWNqev1wG6/TdnWIrjBSEo8cHB?=
 =?us-ascii?Q?Y7hbvQhfHPz2ApRHXf9MI1cguyjque02kSaUIUW564d26+bhM7XM/llWT+P6?=
 =?us-ascii?Q?KKpb8c6dRWUfmpy5i0ITSwM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5886664a-823b-44e2-c878-08d9dff8ad27
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 11:49:00.2397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XhCjUrAPaJBEdTNI7cZFiYMeMFk2QW/7Q4k9zRJzh6mzL9X+bbWWr3hPAchmMvdEPv1ixuK0UBCiNUrEhNTLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4775

The testcases v10 is unstable, it has two issues:

 - send too many infinite maps, the data translation was cease.
 - the infinite map may be lost, it wasn't received.

Add two squash-to patch to fix these issues, and make the testcases more
stable.

Geliang Tang (3):
  Squash to "mptcp: infinite mapping sending"
  Squash to "mptcp: infinite mapping receiving"
  selftests: mptcp: add mp_fail testcases

 net/mptcp/options.c                           |   2 +-
 net/mptcp/pm.c                                |   4 +-
 net/mptcp/protocol.h                          |  10 +-
 net/mptcp/subflow.c                           |   7 +-
 tools/testing/selftests/net/mptcp/config      |   5 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 148 +++++++++++++++---
 6 files changed, 153 insertions(+), 23 deletions(-)

--=20
2.31.1

