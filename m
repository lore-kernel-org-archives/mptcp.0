Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F58812
	for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 07:11:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BS2S0uXl+fM6aSKexKe94VNzG2GcOH9zgbTzWeghRWcjz1kAJDq4Ms52wTt7GVC6djrTbrr530LhVDGDqbZxmqNY2RHSFmbBpvJPE+hhl7r2ycIaP6/Ij7lf3y+XuN/MgENaif5IaYWsoCO9fiZXbU/7qfIsW7Ajr2K6kQWrzrlQtE6d4ZPNNVLaztxpzxb7Du/jVxFjZwDsKh9/y9tlc7DNRpPCCRNSFkUQGitx9MaNVIGbC/FZsgBFXSgDwZyrlt/m0HSH62U4e3RB1wKVzGUl+UTLQ6jcJGYp5W8AQGZkegSdaEXpbqdyQcqpb5y4D/smQ9Yab1TT7jrJ5WU5xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3z5JVilyfZYC9JKfAMPc3K7whImbxAPB86WMXS0iMA=;
 b=aQh6u+P/sMERGEVlkciBCFdFSMY1stKir9x3u7H2++LN3QTuRQG9MxPHUougkqcNYEiGtxLOuwSgUtuV00NE0awOZwvXmi/qn+ac8r68tX3HYSq9QvkhSF1ufIAp8frNkXygUg8kj/lk7SFcLreJTwKPouqglfmDt7F6CE3UA6sg1qNdjHBb2YJ9U0jmiflEG9qo+zn0WuQFINnhyPfYKbtSCgIpz7/Ra65LVeeBLOFM3NpUF85ydcyaIXsXv6G09FCKUXTI+6ZTNIl8D8Ryb4RMeu+dD3eMwVWdVg2N/2wqs4aYFhZxE/jNLH9IjwR+HsW6xPLpmFafx04whLYiqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3z5JVilyfZYC9JKfAMPc3K7whImbxAPB86WMXS0iMA=;
 b=h9sYZR6WVNza72hQWi+VUlMdqMz65MIYLW8q+RFzt6/ARQMOtx2QCbAKyUCIPk5VgbIedeSRDU+VcjdDl7Dqsfh8t27CeOpEvMCpMr7YiL/Vk4EkTZez7sY67IW/duuZWam2cqi54TZjNeCUGqXCX1/+GzzZYMJpeRAB5DSskcGYlhU/NHPf8kq3/LsFZ6C7QRkfJ3yQeOX/3+e04vxjZxMbIkdPKOXxSocoTKAprIt/5+MCaLErTx9TBqr8R9F4pI7y8KEFL9SnbVs+yGGAJHqdkhci6BJAaCWKiD9LiyTLHV+JAbOkuJYcgI6BBA5eK6aj7tMhAeIHKL4Q5E2Kbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Fri, 18 Aug
 2023 07:11:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 07:11:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 0/6] userspace pm remove id 0 subflow & address
Date: Fri, 18 Aug 2023 15:11:59 +0800
Message-Id: <cover.1692342519.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e39f8b8-d840-4b4c-40b8-08db9fba66bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zKoureXeQQhYIv7RTI3xLDyvXwE+9SSVkWwN8z8XmHIuyFzNk99bSuqM0UbCuIDyckc/ZZqhBuHqT2XBpEuai5DHqWSNutq3P/LT4OO6aFV71wyfXNDqK8nj3bxq3eQSVD08kQV+h25dqAPR9DGseivSXI0oTflV3RXmABkxbuEc7uo9eBJc6BtTZxXXbHQ3ip43Ua5BrZd4NNnvt42oMaZixucvBLHLgO816VDq13TTbBeZumZWa7x6wB7ov/0gNZb7h7yjoGvFCzCNbaQw6561aqEu1iTPJY6tZbLzXSqTwjcFJQ7HShaMLDVqYpjCFe7qn4WMnRqsciUqvbUBGzfqBxjglfLk2I/8WQ4kVFIsu/xI3I5GcdWNiqfgkE5DIXYVSxc/e+iPWZ1zH5AnaCTQgljRoJnVoID5Gv/QzzIo7t2RkC0qo8xffZpjqMZ0TtO2yRLO5Hd0tIyzoH1V7Pr0UsN8AyvcPw1lX/2xMolF5N3Z6RpEaxV6stR4aPTsDzkwD2dFCqejglGGbCePzkeG9N8M4ZxSYDkfsB8Tt+6eGu4fwqeyeSFtQe46MRKcVnzJ1ALBhYL5kYqV8Aj0s6OBxdxbqJJArAvnNzIve8U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39850400004)(346002)(396003)(186009)(451199024)(1800799009)(2906002)(4744005)(83380400001)(26005)(86362001)(478600001)(6506007)(107886003)(6486002)(2616005)(6512007)(36756003)(966005)(44832011)(5660300002)(41300700001)(66476007)(66946007)(66556008)(316002)(6916009)(4326008)(8936002)(8676002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LS4Y0TF21cvAm2gSxHv2N4a8vE9UVyRE8BjMR3h6qCuJticfrCVvcQ3w1G9v?=
 =?us-ascii?Q?bKKYZW3I8hfUk8AQFZE3gTA86Y6hcz7T+jt4ZGQ1tG7a804yjMeSJwcJlPUS?=
 =?us-ascii?Q?oPdrWllu1TYja5zB9DQRBUXzqeSmxudNg3fBf8gPxjvIuErlhFLfjTaVvAmi?=
 =?us-ascii?Q?v6BndCO2PCNjq6eSY4uiErYwn7KhKtXvh6q4ySASOyUPz0W+ILNZEQElc+Qx?=
 =?us-ascii?Q?bwYfSRi/0XYeUuVSIJtbKXArKI1aroU3AKzpeBRn0ePAQRopjSAqEwPuDKcM?=
 =?us-ascii?Q?yVVJp0hKg1q00su33ucqFB3db9Hpl8//NmGLqb/sJSc2jWjhBss4CZ3TPg+h?=
 =?us-ascii?Q?0rZiNSur3WV7vwZmApObX1nH7yU6hwaUwXV0Vi1OL3tKFZ+v7fu994ClVGOB?=
 =?us-ascii?Q?hamNwnnDnrt7qpuR9pDSWi8M2fQkRciuXpNywkt7cy1c/IxcP0UumHuATFsT?=
 =?us-ascii?Q?sydDH4nh9FM51/odGVJIO598/6kGc3vGe3gYRvHMaxpBCwv8/EFBuiWRUC3l?=
 =?us-ascii?Q?1DEBqFrPPlFzFjqB7R3huKT7BJbntoCFA+uIOF8L2rqcI6I8V1oMTYK/aFBI?=
 =?us-ascii?Q?HxWHenMNWf1tt8fQ2RIe87t4b6lHxr0hwxwPFLNWK7Rqf2TPsxXQfXrIU1Tp?=
 =?us-ascii?Q?arJ1KCLHdqblcx8/+Sb3RSstv9+3j20UjlWyHlE4KF4SKRjTCPYdCZVTfrv4?=
 =?us-ascii?Q?jOdi/XfovYB0z2T8dlzRaJXhqxujnLmgx7XlG73yYHVPbwu35vWpFBp0EIkz?=
 =?us-ascii?Q?YXPey8vtMIAKsh7dBbT3nnEUZT3xP71RXPVDZkUdAAZ9wea4JwRHXl8E+yOm?=
 =?us-ascii?Q?TGfwukuVzHgTpTG0hfz/tbbjkrHNEribaoqm/lSt8wch8u8iGG3a+0ZKmusD?=
 =?us-ascii?Q?A739D0HN4H4lVjsNlykZ7GPhGdOu1sBsd9kuab+SbOeLKzSHiIDcCOwvEZ10?=
 =?us-ascii?Q?O69Mohj0FRH/NPTamcpZtco+MjdFpfpUmOSCA/20B2qlDruOvNeFogEBlXlU?=
 =?us-ascii?Q?Cb1OD165qfL98gUS5LS7/XWIku3N7sDNtyocnjCnLua+6yQt3oF2fMA676q5?=
 =?us-ascii?Q?+9SN9dEUem+EsmaEL7HKvy1geT/5v57mJX7S7B7bZ/Ow5BkeadAeGlI8679E?=
 =?us-ascii?Q?Tnybfx409haSspK92wfXBPX2S1/OVuyEENrQCHAhvTMmeRJw85Ahkl2YmJrU?=
 =?us-ascii?Q?qtj3Jn0JtFDKIhLpnwKAJa6vaa1WqNrot2VG09pZJ2oPCct7Ll1QLxnsXhg8?=
 =?us-ascii?Q?JDIEY+z8c8vKH1uwThpOltnbciQxzcnygfv8DbrY8wAPi0r2dr5L3H+ylyiL?=
 =?us-ascii?Q?BNxy3C7aCceMpyXV9VZzk6I0kdSjokVSvcHDnNbskMNLqa3vA55i+LVbKN+c?=
 =?us-ascii?Q?LQiFIwJsJ02rBbCe7ouvCcJ1OvKGnz/SnJdcDQ0l0DoPmmXm+x5+T3TgpLoa?=
 =?us-ascii?Q?inlU6/l+Sa9PSWo3Oahg2oIpbuMD7Td42mtOKlxse6G0muvTqw9qqXLQrFUy?=
 =?us-ascii?Q?GYrBs6Zfrk3LahSc0UmWVqCy3JJitGGvuVfKfICYhW+f64iZiMEiIGXPVpiI?=
 =?us-ascii?Q?+rZu4rnjxv5PAW5wHEzTZSpBPC92FrIoIddmeHI7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e39f8b8-d840-4b4c-40b8-08db9fba66bc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 07:11:54.3041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXKwlt2Cgm+p7S9sJHrl6B3XsbWNCMjzbYCKuHJbcprTrIVjU2rm51CqBj5cDtMuwtPA8JWb//NcpfjlzL3TcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975

v4:
 - add evts_get_info and chk_subflows helpers.
 - split the selftests patch into three.

v3:
 - address Matt's comments in v2.

v2:
 - fix CI errors.

This patchset addresses #379 and #391, add the abilities to remove id 0
subflow and address for userspace PM. And a selftest.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/391

Geliang Tang (6):
  selftests: mptcp: add evts_get_info helper
  selftests: mptcp: userspace pm remove id 0 subflow
  mptcp: userspace pm allow creating id 0 subflow
  selftests: mptcp: userspace pm create id 0 subflow
  mptcp: userspace pm remove id 0 address
  selftests: mptcp: userspace pm remove id 0 address

 net/mptcp/pm_userspace.c                      |  48 ++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 145 +++++++++++++++---
 2 files changed, 166 insertions(+), 27 deletions(-)

-- 
2.35.3

