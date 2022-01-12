Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00122C9D
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 10:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641985013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sbL7hwFC3cAewzZRzXMjkBYneAod93Si9HqcUdHwwng=;
	b=LLwpYMNRwfADczaPunKBDN8i8mbiKpY+CIqTe2zEhopFJUl8zYjRRephJhE2vofCwAQ+/f
	BkgoSq7ZDeb83L1fdJjDSAs2M333eRAGVtTBcBt4oyozNElZV6tY/v7tp2HJUTaASCU547
	52HVBYG4LTV19T11dNST6BOyqH5H6ao=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2050.outbound.protection.outlook.com [104.47.4.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-lgPRvBtZMm20x6mVPlRFqw-1; Wed, 12 Jan 2022 11:56:52 +0100
X-MC-Unique: lgPRvBtZMm20x6mVPlRFqw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWGGNbHnW6IxVuB9qIDazil74tioKRdL8Fm7HBZ8HdFYKjC7/yenDULbt+IzzHePl88QTTFnIzecoRRBfo1vIS1fsy5V0GzUh0ZLLpT2TQ7RaaFE8TPZxTJ7nWqajMc0+YtBObJMn/t/g8d51oqkrOwlAo74ZB3CSExMygDpPIlDMIwWr7GKsikq+MRUtsrMsvOwrr7uqIDxBzm60AeQ8Kk0o66ZEs6mOk0QnE8NJsBJ/D4xnWY23Txt0DiUMA2Hn5F2y9KKA/eYIo9tPnW+i6SUbdZM1/xYD/1W80IepCfrPsTn06GWuyF+ToYkLCf95lfIr8TSWY/nsb93yRtlWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUaJ2Iw1rMZ26CzKXnqD5K7rzzw6FBl/5tX2tZFX2AY=;
 b=mAZdrn2Ah6zIUnLhvFBSzWcQRc2qlbKBU1V3rax/fuu1t12Zef97UVKzTqrdIGFRsUxyUIi5F9E+7/acJHrWgwPuesjqzmEJt1uWIVxQrbHqYlXYjNArkqnqY0mHbZO11Vkme7+OxgSNYIpX0E5yxwYds5kgdDFv/RcBAQMej4m9x/bN1HGRDGaPhXmO3cGOE4AxuI8rYy98zPtrcgn6O4nOY6SihRKZWJBZTXKzVOR2bgi2F7e+ywsv9mVcJeaXpITjp2XnBPInWiPY56rUtlKJcAD0Kdz72vkzJFP2gS2O9KxZEfrtDxS7lz+HtuML1KNAMEBYhSgmJ7i9SAfMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2252.eurprd04.prod.outlook.com (2603:10a6:3:24::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 10:56:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Wed, 12 Jan 2022
 10:56:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v3 0/6] use 'ip mptcp' in selftests
Date: Wed, 12 Jan 2022 18:56:40 +0800
Message-ID: <cover.1641984855.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 360a8d3a-5e13-4e81-50de-08d9d5ba3c9d
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2252:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2252ECF5EF0F79BD2130F48FF8529@HE1PR0401MB2252.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KMBMyqPBJrGAy1uDJYe98af8Tj3Y9NAPCkO0HyjeIna3/Q4oJTek2x7/lgWvgvRVF/reozkrPX05JgYKhtL6u8e/3Z0xGU+C4KVEJyVRdF/Cy1/zAQWojvAuSYcjkzuzQ9t74FuvPMgYDyPFfKagSPNfdW6tJ0PhC7FfDEqFOQlpSh3BFuzdYMp7iRc98oUyQGSSjHXgpj0OXG+Z6MCJjMe1/EfAwCTQDBfzNpYgZH9bmQj2SlMpHJGub0SdG6nsaCVpeCSapJ8dhE15WYAiZHNlySVSJ/Ez0uOEPYYMXGlK/9DikqVbZfC1uGOkLFWarPf5Nu1/yu6lkyxPu2cA+dqWhim5sMr+sDtqbQ2tWbGGsk2rPQs8r+NRuGYvrATj2wsmMqeCi7IBstoeMXQ2Sx2bzwtCGswd46prEE6beUhduqZ2m3ShXqmS7PriBmS7qXti1AgWHK/67pqWBJS3VwpIevSjNy9PINezJ+BMTiaVDG909tpT8Fx5KxVnrmk7pKt4bJIih8ZiKTCNe2/yO2fXYHVNr/YmMlETAD4MRu9rNFTxZhAy9P4csUiUhjtlGi4cO1JoXxd1hUVwt/qixsBE0zHitpbuUuLO6BhX0GEf97g3SCGhRKWuIugCoZ0P2Kfxz5JMeh5QZvCYKuemnQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(83380400001)(6512007)(186003)(316002)(508600001)(2616005)(44832011)(8676002)(8936002)(2906002)(26005)(6666004)(107886003)(55236004)(66556008)(66946007)(66476007)(4326008)(5660300002)(6916009)(6486002)(38100700002)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wIbomks+FFP9eDni5f0wfKxWd/mm2nm8qW/55Y31oMSlouzsOWt/yojiVDOf?=
 =?us-ascii?Q?kML9mLbV2ILfM0ZZuKeZ/AlqNm7C8qn0WnzA0K/NIn/mcwU2B//7dTKq92sp?=
 =?us-ascii?Q?Kb6zJcIsQlbs99FRNKnFpViZy6Ik6IP8HbfHr3ifnhM6DYCsdULEXRntT3iq?=
 =?us-ascii?Q?/+eh2V1fviUIUpdAMLXbGIizOkYIG4RmyaYtA8a+ZCW8fpBp5SK/2ORgGeNg?=
 =?us-ascii?Q?NwDYn7HEmjmYmWXjThA/LTIEff1xU7ZoH1DRVgSlsLSNpr2QJzeoo5UTYyBT?=
 =?us-ascii?Q?HzxzvClEzoPdyLZEiw3rEBO3BLDcVehXht+Eb5y1m+Ku+1qD5Gz1aO+A799r?=
 =?us-ascii?Q?uw0Xy1H1AYpamdKv1lLcXsU+Q/+5kWqNCKIXy0HrfCkMh9i3GKUcTzB8eyUK?=
 =?us-ascii?Q?wb0VdXen3KpIsxokRUCHFLJmjVetdOwi4Vsr741lO5o8kAD77PBY8IotMU7j?=
 =?us-ascii?Q?vAkozozlLq1LO3IDZbZKmFocAvbW7SkPVTzf7hl8OLEKy8ivQyd2GsEx2L/q?=
 =?us-ascii?Q?0sRJVIBKsYn3sBpDYc68x0xju9n2P8dJFgCpUN84Fj/wRHOA5aRn7dK4L5O3?=
 =?us-ascii?Q?jIVkH26c2kpzUszDBS163j5g21RZKs5MH1Glk7Cu2oPLiJGTReRJJRILZTtj?=
 =?us-ascii?Q?FKhUvoyrcXCD9Bka/yr7abnES6UmRUpCPLOju07W0P/IiDIzyYv55IUYHlyT?=
 =?us-ascii?Q?1YjhFMD++AP1oLQqD8fydWTLlM9ce/cmxN1bBK2dd1RrgRzK/Qz9K3y3YfId?=
 =?us-ascii?Q?oyPIDrsmzO9ZG+qLUY5up0M0RHPT+7cQpGaSE6fuK4SvdYC+ZRoHVbteSyJf?=
 =?us-ascii?Q?cIMGOdj1pzN0xS/UbLhL8w7vkhqnbYQ5BJSKjjEkyfmtxKCpsJ8ArpRf4zpD?=
 =?us-ascii?Q?si50Pv4h+b4IiBmmdqiOGlH4nQc75D7YOmK5cen2+p/GjMNKciAt+TqbNwXz?=
 =?us-ascii?Q?e2wUFTzDEuejaWlNLzkDIakLQhOviGIoYPSucHbicWca0YvBDioZFEbDvO7l?=
 =?us-ascii?Q?aFHaFeChk6IPd56UHwHM13UACbMUJHFgDr+1g3VacucXevA37utn92sCJZaW?=
 =?us-ascii?Q?Cbj7hThfB/t8SvRlI0yGlFTbP+6iTHWkN+5qSkzGHa7LMJfk8pQnbQC72Wbl?=
 =?us-ascii?Q?nXvqcTl/Vx7rkMWm90TEiY2ep75riqoXl6KX7nhp47zKhLkY19s1JjhQ37l4?=
 =?us-ascii?Q?l9ud3uD9G0f8SxRgW1TZtCtHqlydOnCgfTHXiddj0lPc79L+aKF/2ABNLJ5j?=
 =?us-ascii?Q?Jj2S6UYurfXUFvPpN1afaQiMupqBTeTl80/ylZEh8nWOS9IQJQvHtPuGaDgS?=
 =?us-ascii?Q?a32iAYyDeY5e8jasxHpBDl9Ac+1r1a+WcjT9BJlHvgMkLegZRY3vp2pvOOXK?=
 =?us-ascii?Q?gqPtW+MI+FMFBtJ14a5TIk98BSDM8i2LpKDrCy4sDqaUf5qJyhpSWlo2R5Z/?=
 =?us-ascii?Q?6hhYNO7yEfqo5bBzm1a/CFAd/A6vsZN8M2sje7KkdbOtqShD/5WdZNWSk9w/?=
 =?us-ascii?Q?WHEGMjGXgz/FbEvVhhz7NS3+cTacFgIwLZ92WtSMvWQEPTSmtEr+lLGh8ppA?=
 =?us-ascii?Q?ziIeDb45NLe3GRFmX5SZLDWqAK9ltWjfbgfeJpEvRMjQAg+o4wF9Jt/p4lWo?=
 =?us-ascii?Q?Zih3KhjX7SBJ4oFzmicGKz8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360a8d3a-5e13-4e81-50de-08d9d5ba3c9d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 10:56:50.9868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CrnRaQFlOpT6kFDzR4hl6P9Nv9DeNTbbLRKTm9ZCsyG7k4LuFjruR3FLWQtjiMM72tFGdshAmnldZcGrdVg6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2252

RESEND:
 - update subjects and commit messages.
 - rename pm_nl_show_endpoint to pm_nl_show_endpoints.
v3:
 - use new approach of getting addr.
 - squash four patches, pm_nl_set_limits, pm_nl_add_endpoint,
 pm_nl_del_endpoint and pm_nl_flush_endpoint, into one.
 - rebased, fix conflicts.
 - depends on:
 the "fullmesh flag setting support" series.

RESEND:
 - fix typos and checkpatch.pl warnings.
v2:
 - use both ip_mptcp and pm_nl_ctl in mptcp_join.sh, instead of
   replaceing pm_nl_ctl in v1.
 - drop last three patches in v1, keep using pm_nl_ctl in
   mptcp_sockopt.sh, pm_netlink.sh and simult_flows.sh

This patchset replaced all the pm_nl_ctl commands in selftests with the
'ip mptcp' commands.

Geliang Tang (6):
  selftests: mptcp: add ip mptcp wrappers
  selftests: mptcp: new approach of getting ID
  selftests: mptcp: new approach of getting addr
  selftests: mptcp: add wrapper for showing addrs
  selftests: mptcp: add wrapper for setting flags
  selftests: mptcp: set ip_mptcp in command line

 .../testing/selftests/net/mptcp/mptcp_join.sh | 883 ++++++++++--------
 1 file changed, 511 insertions(+), 372 deletions(-)

--=20
2.31.1

