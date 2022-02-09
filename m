Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CC72F25
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 08:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644397044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gDE+pTDfM/vlObtDj9rv2Bw95nH7RsGjQAgpgwg5C8Q=;
	b=Or7YNKkcKWQzMK1dLNpsOGMyQBiU1tO+p+7j3io8ESjPUEdFcxKK987gn1kjdAcZH4jQpb
	5cNLmBlp1CNGhMN0o07D2jAs0wtjX7tNDngjfXKRR3jaAU0ay1Hq2I6n+Rf540H6udrHdN
	SBeHl/WVkA/sAa1WkMwW7rSFDyJVI6Q=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-5NpkQoyOM7CbU8FmSsWAdg-1; Wed, 09 Feb 2022 09:57:23 +0100
X-MC-Unique: 5NpkQoyOM7CbU8FmSsWAdg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dt1htS8vAequArc2i0MizuJcY3wF7uUEl+bSytRCJiLdK0DcklGRTnTQ69SLPZRUBibX07y5llOO0B6wqWXAgw6/L++U8CPMzw9Vl3BQvH68G1O/4XgpclKd8Ac3rL4xGzqipl4HGI34snBZ5FGpEAy927T3m2+XczoaBfZFgCptjXSDzjPp6F3YwP52Vk9kU+uJFevdQ9I9B9J1MWRV44gZ/MjJ49Yksqq/ZdwtqbwRXBwDsx15MM5VNV1R+tZjFpPKpG40ot4TjI8pFY2jPoYqIuQE1LZgKHOHQ+EbM+erUVs6ydOdv7yi2BQjHEEiIVIPX5P72RPWDzUronzGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34X6rgZDek/ez73I+kv6keTjONODKfpjrbNg/E0XcZM=;
 b=fogxJID85pezTViZU9vDYGm3oRytlqQgzHwUqcxdV+YoCshdZ1U9pzI0nnmV67h5toK6oPteeZ4xN3qWDH/vXmi16O42dsXKFqpwM2Lot7tEmCKt57mc2EXXlmEmm0/rmXVcu5ay3Dk9qq6+tsV31ECK3jcUpiuVKBgUACPGclzBUe75giHHc3vuqlIbhjzbNSZdic5+Rq9IUEyaCn40kF1U6yNZYkVKWeFzoRWrY6zBNfiqDHnoFrFJqmOaN7Xy66HZPIpXlCPENTsdNaeiBexLUP6ZkNwx33vJqUH66DhrtllZUn2dc4Jkn3cs1D+7T38lE9z9pq5wz6I/2f9ibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7667.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 08:57:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 08:57:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 0/5] add mp_fail testcases
Date: Wed,  9 Feb 2022 16:57:36 +0800
Message-ID: <cover.1644396927.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:202:2::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec7cc22d-c233-4362-61d5-08d9ebaa2f70
X-MS-TrafficTypeDiagnostic: AM9PR04MB7667:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB76677B58F3AE9B97E6856C5DF82E9@AM9PR04MB7667.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UHGUMyevPLWxM7HKLWo68eSQxXNwenVXSFG39gadJN0RgDd7eikVwAyxROROiG4yBXLSFdLPE8+iE5ot+JLQwIPCuJlA3oNC+rYiWHkSDD7t8uf777uwkfm55hXS4bFHNdKlcmobOt58Vpd/MEddncYc2U8c7d97lfxVBRUz+S9/fzfOG3VnB/oRIoSlvcIU7uaFRb/d1rFb8DO+x9+0zhJUCQTb0XQXzqbH7frikBC5OfjjsQZU+0+/nl81cqxZsTfX/pivvDN4hbBEn3+g2PkxTzJGM32TJE1pNl3E3OPq5BZnpT7Q5rAKHd4/PdCWkZwsCvjILNLbaD7YYp4H2iFbI1ancQx6znt1++gJhy4K6XBsOmgE+sOHLTLrnzyqgQGvJohHQCx4q0AtKrAndtoOiFScPzZDZNxspXGYxCQjfapeCJPALzWW7wd+Wyu5ZUsYVd2Mgjh7g7lmWo+GlmStyaKb1pozuDJn/G78lxD3IBewjtl5/wv5WjBcFRnKv4uR7xKdpnYfjeYX+pY4Co+3TpLVBUNvbjjO8RYemP8WmnWW16YOXOzYvSkhZP6H2OYTMrZFqUDU0LyQ4UTs7OD55MwkNGStzndrDCOOK/dhA4QKi4POasNFPjfPnV65h11F/61Ea1M+Va3/ZskU3Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(107886003)(5660300002)(6506007)(186003)(26005)(55236004)(44832011)(4744005)(6486002)(2906002)(6916009)(6666004)(316002)(6512007)(8936002)(66556008)(66476007)(66946007)(38100700002)(36756003)(8676002)(4326008)(83380400001)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3xRTGwuEuWkBmD9hUSC//kcIPq7UmU2V+sOfLcllY1MSsqZQDF7wFHxsw4dy?=
 =?us-ascii?Q?ssN2l6pDs0GvUpLSFLa6Y4ngM7IXrSPI8IvYHRe056mX8fO5HOb5LuNnJ4UC?=
 =?us-ascii?Q?Qo7CvUoRN8lOrOYOEeJArHvwr6vDzspySgbtRVfVFVZDQdMrDGQb67jiXtFn?=
 =?us-ascii?Q?69Q+4yVb/x42QKoAk7TRKoRxB5t1EIs3+bdJPwIW6OYPIVxCDuDkHjdr1nS4?=
 =?us-ascii?Q?lAG2hi5Zg6FFY7kdsm9MnZoL8OQpptZQWr0B+ornwe8OJKm1wFRgMnjjsvY2?=
 =?us-ascii?Q?ByOlQEbq8a4khK1oak5iV7rGrT/yyoeiItsEEanvbEjPTzCsepkf79DhbCBu?=
 =?us-ascii?Q?OcncbQCvfSS8jcBbACJ7ZbuaJd++1n/zYXZY2hHoYJV0STNVN35oY3ZM0eAK?=
 =?us-ascii?Q?kABOpJjErBfhF7ZtnZ7imIl1IQyDydIY3LQ8RMzXo1HvEvla4OLDGgiKj68H?=
 =?us-ascii?Q?qgYZJN52BkjhYhwlzP0XCGJFGMf3KbOCfgkce1tQxKDCmceBTMzvgAZikUZo?=
 =?us-ascii?Q?1EvKp+AHbzzvzuE6O7N7ouZ2FRt5OrXIUcsgOuReYEbxFpP/ksmI+sWRT8lq?=
 =?us-ascii?Q?5rnA1ZMIaDVtYQZ9EYLWEBib9JroDZY2xvJZJsh6gIq4H4OLU5eFZL2LW+GT?=
 =?us-ascii?Q?1JWA8NldddmLgWIo5EL5Umie+Umdju3rCMPXll0XXdvBlVOyP6bvtXv/mKfb?=
 =?us-ascii?Q?bZgWacQ5BjdqfMRxc75XbcY4umBRVG7s6eUKjVdZ30h/CB1YQXi3+Q+4apza?=
 =?us-ascii?Q?zrDvwNqfePRcbNuSx46IunzLeXsLteIqPrlvYhiMGdHrqXqZIaIl6/EtbQGT?=
 =?us-ascii?Q?a5GVlQjh1RLtXL6yhsko3wajHaK1jR4oTsxz6L7dgWciQt22zGwdlMPlOtm0?=
 =?us-ascii?Q?IaAy1/VzkGjWwcGOTewQeGcGr0me/pc+2Wo/4aIEUf6BeN9SmI7RD9BzTu7e?=
 =?us-ascii?Q?Fw9AWJSn12mWF1NUo6oDeDkfPjPCcaBAt1eOyc2qtwLXQ8Sq5XjtsBySO26j?=
 =?us-ascii?Q?dw9zG/T8mDNophVR1IP+oCZ+vudf2xgrF8py/83bBH2uW4L1unAnUh8uJ4wM?=
 =?us-ascii?Q?jbqqo0Qu88NNMzp4y5YlNiHv77eWrxtVQ+SMcLDDGd1VmZryMfU8hPC8yhg9?=
 =?us-ascii?Q?FAo3qIJdrl/Oss4IYu+3xswLdvm0jr/aUpzchtPrXShvXRfKhEhxFRqCBkr/?=
 =?us-ascii?Q?2Ogmq6EwvuRpNVbGpdfkwYz0yXKyFQ0gTVZIXeT/Pj2dwTXK/AMIq6iccsrV?=
 =?us-ascii?Q?7Mb+VBx5ZPA1b96Qtge2eVeaTju8hOyautb3mUiU1X3tAERM3eVG2T4Z6zPQ?=
 =?us-ascii?Q?JOdMrFdya0+MAop00+I4MB743JAMzqC8Fwkr33she2eQkihEkByt1egFWASI?=
 =?us-ascii?Q?MqpchXvHNIg2/xYKVLWJDdTdOcrjxDdcb1g1CO3WWeDgAr5ehraSxnWdy6c+?=
 =?us-ascii?Q?OYT5KK8d13f1JmUxWKK11TOkHmLKGdDshpfSp4hRPlmRvVQwUDfVP7h9I90R?=
 =?us-ascii?Q?AhxBeTdS9ftyWN19VijcbmU2+T3lyyJGB6r+hVLmYMbfRJ9l+Px7y5MjIcwD?=
 =?us-ascii?Q?zJ/ovnbw/2AinUPux1UsNNdHtkEEqEkQWukXfbtk6jR8BSB47ZWUfgZ/rx04?=
 =?us-ascii?Q?xsKTo1tOvaG378C6n4bOC8g=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7cc22d-c233-4362-61d5-08d9ebaa2f70
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:57:22.3591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGY19kdy9RaUZCwhUovxPmg/JSnk4AMShe5rLsTPqA9TK6VshWjYzXP/e/AZULoQ+8CsbrG/857RBFCr+IqKPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7667

v4:
 - add the mibs for MP_RST
 - patch 4 "selftests: mptcp: add MP_RST mibs check" uses the variable
$nr_blank, so it depends on the commit "selftests: mptcp: adjust output
alignment for more tests".

v3:
 - check the exit code of iptables.
 - add ip6tables support for reset_with_fail too.
 - add the null check for $packets
 - rename nr_mp_fail to pedit_action and get_nr_mp_fail to
pedit_action_happened

This is v12 of the mp_fail testcases with Matt's changes. It works well
and it's very stable.

Geliang Tang (5):
  Squash to "mptcp: infinite mapping receiving"
  Squash to "selftests: mptcp: add infinite map mibs check"
  mptcp: add mibs for MP_RST
  selftests: mptcp: add MP_RST mibs check
  selftests: mptcp: add mp_fail testcases

 net/mptcp/mib.c                               |   2 +
 net/mptcp/mib.h                               |   2 +
 net/mptcp/options.c                           |   2 +
 net/mptcp/subflow.c                           |   1 +
 tools/testing/selftests/net/mptcp/config      |   8 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 217 +++++++++++++++---
 6 files changed, 204 insertions(+), 28 deletions(-)

--=20
2.34.1

