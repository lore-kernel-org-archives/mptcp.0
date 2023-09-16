Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CDA134C4
	for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 12:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8t905qGtnUMSjvQh5m8PCtXDR2eDyo2ulrZWgAGrjNEDTlRwIHzNRp9CXGyMHBLMsbZFO+QNiGcIPb145fWxiVbZWwa/k6hKQzXzEBBUFA1g0qWtgcu2HKOQNbWdpSsIuotuxyxtPLdULn7i29BgXOTFkhReiocE8UPc55j2dV3IKATu9DIwIuZqNPUuTd86lPeL7AnPW7i8JOK/nFHWfuTsi+2xXKF7tfbnhWevIuN3lVjsMYyIa09w3UW5bTLfE6cCGsbMy6Z7Kde3CEMrMTLz/bars/fTqRs3B+s7py5Fl2yDZQiQ6V9KzwysEqP2rt5BGTzVCcpwO3c1VEukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEy5cgUwcffIq1vvwR/BVe4Rrxrpz12U7/6FxQyY9gQ=;
 b=QWszXKpL9oBX8vjYF6h/faoT/76rKvKSGWoRXSUjwBS8zHcyn8goaG7Rm96VxvUu+WLNiYpGmssEmKX5LtjyWI0kqdd7ML332QFiKw5xVliXBCF6ty3BdIPr9mme4lRnLBRmAeEbgtD+x9nO2U8sEDlY1QY5t8gVkbIdMwGc6A56YAAE/qmCVsEQNeBJ8OIgbBAHO9o2BJLKAIOX7qhpzlJ0UkkuX7gqSh+/YXf/sf8riPR06kEy4dcOzycLTadtVicsUAvJaOjKFhvfYb+ijWG5q0Z1Antawj7d3tKBWLfSmcUxjg6XyTOqwROuJKj1g6S32fs/eu71LUq4E253yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEy5cgUwcffIq1vvwR/BVe4Rrxrpz12U7/6FxQyY9gQ=;
 b=Wzuc6aywTM2Uw192Bcld9Uu5/9UCEsgCSuJXW6lAFtNSjnx0j5CsIAqBmDlvDSKoGKexr+H8yH+VChD+unajCoUq0e7ojjU/UDpXCFMnxaw3cPmAdIqWX121V4vAxl/KK9EhuUfVIx6TwuL7p9LEz2cBbowyMaAfOVIxYul4pxH+GwPQcF5Tv0dKK3XQnedW7nq3slVM7AEHYza4oZIBgTPvTijQnocgElLl+QX6O7sb2rKio49Y0FHpXXJlurEjpZYrn7EgFinuLiqx3OlHChfDotkKyiNM48IjkA+LawP7NSjQhWa5l/KMkU0azmkbeCC/pTOw4hxZOz3XWI14mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8772.eurprd04.prod.outlook.com (2603:10a6:20b:42f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Sat, 16 Sep
 2023 12:04:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Sat, 16 Sep 2023
 12:04:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/2] userspace pm remove id 0 subflow & address
Date: Sat, 16 Sep 2023 20:05:42 +0800
Message-Id: <cover.1694865871.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:404:a6::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: f596dfe1-e6f3-48fb-3a8a-08dbb6ad2400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6I3BF6ViwcNkF8peIM3j/57TE+2145GHDCAZ/slezDrC3qkt4IZE86/5OorKUgDDeSvETbRyxw7Grh/GuqnVUu4XmcR2wrxiQmhOEkaC6rytpL16fke6Q/JPsFDVyzAEslIq5Xtzu0S/c4hA1Zd6g5Mi4+iUzZVCg3NyrXsjsmyamKvRI8OPFH4uwrab+48coBjBw9ns4KSau6IxsJ8TOvrxMnpiEH4FNXxaeveHTvVwgK1LSW/4uKHIuVywARQm+c1vUGobxYjs5uA3t70s/J8hiM3zVJBZ9WWDmGAzdNJ38LYPNp9hPo4tP1SVCKQ+IDJ8E3Jr8WDVA1EALUh2UgGhlDvI65Ej+CRI9mCi2sxtcGORYU4G3tpTPGw7UyBVu0kBBFTtKMO00pO0fLj6hKMF2vKOGQ9hqr/lWsPvKoavweSsUgyjrEQDe6NzRKEubHlV071fhWprM1hJjxxa907Q50gYRBNfzH6uwIj2rz94Aljy4uSBpQ7BOkh+mAKSfYzDXLtI28zaWjIB82Kf8nfSeu4aTcplE2M9GZcDbRy9PHaUlyUrr+BpxJNBx8rNRDL+HOIHwPy+hzOkZ8uNdDV2sPFdMvYizoQb1jexMQ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199024)(1800799009)(186009)(6666004)(6506007)(6486002)(86362001)(38100700002)(36756003)(26005)(107886003)(2616005)(4744005)(2906002)(6512007)(83380400001)(478600001)(5660300002)(8676002)(4326008)(316002)(6916009)(8936002)(41300700001)(44832011)(66476007)(66556008)(66946007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SewwFR9SOP6Um3Ati4q9en2U4T21earA7DO7fpBG1vtroF0mZxeDZLAMrWlB?=
 =?us-ascii?Q?EJiQc9azNcMixuuUKwytKSLkjt6D0U5pQYa+5HKh2GXhJMLJEy4snGxZ5QRI?=
 =?us-ascii?Q?putE+rDxWQaCv+Psdo+0CnMLnYUU8KkQlJh5+wTbsYFs9PdIqHfuPyoANoyk?=
 =?us-ascii?Q?YsfxeuSZGGusJTILxn4B+KK3Bk4Obu1lwNhTO/CgNZl+OR+tROHGwMIPCeQ4?=
 =?us-ascii?Q?E7xmrYjI4jb6uyUs32UiSTzZmG+GkuvZ5eXlAnZ+Y2RmgaktvUHmCkyP65be?=
 =?us-ascii?Q?Vv9lX5OTSA03DFP2R27xvlZwHXeRw2Fo0onh07DY5DB2D6qfSrYSMtpiJ1cj?=
 =?us-ascii?Q?M1oIrSGqvWpbMh8YrG7eEhkMgfc8Da4D32gQkoBXAUta6u08EiDBG8TxC1uK?=
 =?us-ascii?Q?6V2/MlLPXJU6JVv76DQqd2GRc6CNkFPhMUXbvaqtMn6Uoi4LaPGO0Ks0n/rS?=
 =?us-ascii?Q?2gaRZznt6G1ibknVpsMjPajX0W/4+cHFfkvnzwItHlMMs1ag87QQkVssGeX8?=
 =?us-ascii?Q?xz0zaME2+twscjGudESAD57ODQ8dOQauth06lQMEU9AeF3TK2/slsiS7hKXt?=
 =?us-ascii?Q?16Gz7EntQbO+tRKG2C5lYM9RefK7xqa1LlZzkfiUbNKme9a3f04XH7N3+UrG?=
 =?us-ascii?Q?fQ+qIDd5ZH8jV0L7C8e7rg0+84Xe0OTOa2aT1d7GMp4KzA9CL6fD5655dpP/?=
 =?us-ascii?Q?bNI3cSisT6XOddsjdoEtTZcENAt028OHkXpjO8NJskNddsnEuitr9hREq4Py?=
 =?us-ascii?Q?/6n9gmbIssUrYhj92NlwIiKdVASOjXomA8Qebw98viHJe+HdGsOwNCqq2/wW?=
 =?us-ascii?Q?gTEX3KPM6Wi8ahrJdHyqfjA0K5SKcBDidqd9OcTVq9AWzOwjqzJh6lLTawBm?=
 =?us-ascii?Q?HC3eNWbrpdBhfXjXHWg3FiC0eK8g6gc6Jo1HhGlGOcAtL7XqxwyZPnEZFny8?=
 =?us-ascii?Q?qn/QZ4WVudmGmIXvDc5rIp4EQPHJ6QCyMNSIZNZhzrQmJAxjKUuzsDxFSbcc?=
 =?us-ascii?Q?kFX4ljHcgnaDjlrChnuy8iup598LEFYBEbo1Li2GHP4oDp8My5+pthS44uas?=
 =?us-ascii?Q?GUfxd7X6uaqGYyi5E+DwkyK1mh9XYesG0z+g6X6z8RXO0dmk4CEoVqKNZUmF?=
 =?us-ascii?Q?v8H7v1b4nJFU/F54pjQJFQ8IZaSqqvusk2hdePuAcRMvkGGMdlSpg1HA5eiG?=
 =?us-ascii?Q?I9PaLobBK1PJfMsP8Ee4INb8gNHseN21YeGl/PgQLA9USwOmgSu7wi4Im1gn?=
 =?us-ascii?Q?VyJJn4p8EMY8SZ+ssxyONYQdA+RN16mzrlUFqjEy5uCBj1rSmsCVnKON+poN?=
 =?us-ascii?Q?AHVsQHYV+FZh1bVBOab+BucKUNFs7a63Y4YAjTmzfTb7RoH6vvHb1xUzMHd1?=
 =?us-ascii?Q?ZENJ7Kuni1xUTdqIf1B92gswDqgUdSBjercgviTcHHg8YX8r1c3tE5nAxsF8?=
 =?us-ascii?Q?5nClFoyQbRLo4n3MzvrKEPpguaJ0pOogOeoX54X6gL2BDXIiET6dzCh21mzY?=
 =?us-ascii?Q?JpgUzrWJDBnYjH4mOFlZ20pIlk7eqpfCD0mAk4+pyrondV96IvH1b9GwCpG7?=
 =?us-ascii?Q?y337XletdnCqFk+3vyVEoJsM47cT6fvgq080uqlR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f596dfe1-e6f3-48fb-3a8a-08dbb6ad2400
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 12:04:55.5978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9jLZrVfTakTMVAu5bmbMi6zhDxCRnHIY+FgVExTtkfnXHW1DAJb6oEoU2d686sIlnfv5KwXyMTps22xiUfLcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8772

Patches for "userspace pm remove id 0 subflow & address" v10.

Geliang Tang (2):
  Squash to "selftests: mptcp: userspace pm remove id 0 subflow"
  selftests: mptcp: add chk_subflows_total helper

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.35.3

