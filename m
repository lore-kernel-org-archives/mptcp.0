Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D762A2C80
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 15:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642086542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RhuIGSdI5ppOCQcRA2CFg8bn6lB+t17yeaqcO+YNawY=;
	b=FRDm/jGxWgNt1BKF9769bCH7uQ4dn5U6HWLEHvPmGd+cJeX13rhWOnJFF2Dq1bEc68IMRc
	POYdWejMlSpUvT6DKISTZSYjLVZ4l68P/gFgslXKo+fj+Mr2z1J5FGk6BxdXnYQuIsK5CF
	IDWtmNM9ZYORF2FmOdXL8b1aiF0JBBs=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-eEh4qlx5Mkya3L6SIMvzZA-1; Thu, 13 Jan 2022 16:09:01 +0100
X-MC-Unique: eEh4qlx5Mkya3L6SIMvzZA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ag19rTJysdGNXp6x1IWHu6o+hl7XhJQ+voXKEOEUJiUi0HIV34S2GUZs+fFjSG0NH9P9fgvbfnR0scJ/tEANCipSmhZMmuO9NP1t7DFT2PeXzjjDrEQCdXZr1TAbcg5UoDyoOR2atA85Ce0p4gxP167ZyTHyZCVDQx8MoZfyrlyfLfJZ7UykDBLUbCsYayMB9oMRd7+mc/RKyCut+MuFyM1RzJ690W0FSNh8Fv4oG4cTpe6jG76Unj9L1LkgiRWySUqf3v6JyYkYTLz2mxpT1y0Yy4TcwbRjPrk7ZA0s4fxJYBEewcz6rbkj7yV20KPBqX+ujKa7qb+tfzUnKmaxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqGjnosgvKPxaB219PWAhv9Grkdi3lfmogI4qKJNzF0=;
 b=D4+vxp7LX5AIs6kWjBKwU/nCXGiPKAUqUvJcklx4wufNbsIk8CFe4MZ7g17mqfEWR/5Y0mEnVOh06WUWw2SFY2nP3PQ0a3unSOM11qKJ2ia05Hyevnj8BevXdzPjkYFCj1QYkOdPj6m/kf2uud1ObFpZPQikvUY19Y7DGp2sIMgmRDOhE2Vs351cqhCmTrJWqa7UMU115EKWGUh6y+yxJLR3tUAD4oqUx6x+PFrILcVetuIoOyawqEMJMVsIvr6g/mO2XvUPVXIgSY24qj8Nyt2wL4JTHLr4ni0ZzOQ+wwojUlDT/RhUw7Y+YwC9ZlOunUrnsk+Ff75ljZgr9Wya8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7361.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 15:08:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 15:08:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/3] set_flags port support
Date: Thu, 13 Jan 2022 23:08:30 +0800
Message-ID: <cover.1642085750.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:202:16::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dfa2e49-e165-4326-a603-08d9d6a6a00f
X-MS-TrafficTypeDiagnostic: AM8PR04MB7361:EE_
X-Microsoft-Antispam-PRVS:
	<AM8PR04MB73611FA8D6A355B5AE033B30F8539@AM8PR04MB7361.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5n5QuxkD4wx0CbLSG10fDjB2pqgBs4xp1VzAbX0082U3ckb3iSQL6P/vWHKiZYCLn2klh6fB5klt+540vkA4YDEZjT72mGRgb/scUWCh6FIGrGilMj2TaG+rVKwEQJNLpnexGxuH9n4u8m6+AuuNOPckgaTIpFN1hBLNN+pm0J7IPFhJNY6GnyR2o3o+89ZY76Kw5QHbMaMdgr7WMAnckQvCZW/kkqrJDh+ARASY12vF2op0fj5snch66DZCqmVf43dByUeg8rI9woBiAgsPRpqGVLBlQqTM/HQoEg4s1CJAj9O0lHgYheXTa57t3TD1o0KNYnciBN08gDeSzO5tIoag0KRnoxwrKTO6fxhjHih7DXo4HP0MEv8xa1/xizq1M2iOODmmrDtVKwg7KSSeIYB+1cdn5RYDIn9WgBERLfGzF7B1+TGGSitjVvIiRugDDsgSdOAW0c7Jq2XSJQzrpCL54OI7D7RgKxwqWraL6ltzTt+TmmRgTHu6WqD8aWbhWs7zgBV1+K5wEKpaDxqBNO/4JeyTYfRyCLJUJWGDun8mipEMWlFM1I5sdhYtzp5UmZrMRrLLM0N+3d8Li373lvf5RndkNahPQAGGP4BhP2OO7pO1v75rutGpRvXCk2qLPPZ0z2xyicBJzWr6Rh9ilQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(8936002)(86362001)(508600001)(44832011)(107886003)(6916009)(6666004)(38100700002)(316002)(4744005)(2906002)(36756003)(186003)(66476007)(83380400001)(5660300002)(6512007)(6506007)(66556008)(8676002)(66946007)(2616005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t7Rn2BumbTVJrY4F4Q7HnXl6vnpCHDFvQt+aNkAElSbCu3NRaKiU8IIcWhQw?=
 =?us-ascii?Q?lDW3JzKK9r1xESLjZPuWIkQBTStAwhEICsLXG39IdqNScvp+K/AQT0MfAewE?=
 =?us-ascii?Q?DBxr90vUp0VTauMP/hbYMqXOQfbOXqSNTdCah4q6twzs58ONJERGmFE5hjf3?=
 =?us-ascii?Q?pfDzUGH4fmptdCi1O2WhPQwk1/saoitEHvyslMj5cbzgewRddAymSsKmeCvg?=
 =?us-ascii?Q?2GxQD1JjcnIbAMT1A1G26Sd/AcNrjmnZ6FyBS3TPEu9OzXqFhqUy1V83Ym8u?=
 =?us-ascii?Q?ZnBg81FVl+2yASwpjkB2ceBQ5DjTqUE1cRHg4oAWz4Mz1Ln3g+A+923Sle6H?=
 =?us-ascii?Q?HZ9Zmk2tmNehcrzcZXjE5KWrFEe/ryedUnstznIf461aSZknUuuaAYiC3M6B?=
 =?us-ascii?Q?CaztVTIdbuSKBTgxbuzlaBbHqV9mWH7n80yGkxjLw11IC0hwxY10Myax9Are?=
 =?us-ascii?Q?PxGtu9Kqqe2hKpxar0qONEKdEKPrjM6cQyEpijjB+Ip8Hed9m+n38qjowz05?=
 =?us-ascii?Q?G/1OKKoSKrkNXfOwxdVLIJLgsuhpkfy7cp+fLGv0TVpRB9Rhzs1c9xSPO/HV?=
 =?us-ascii?Q?i1Dbr8wmUcfSjMSud2UWVmfWH+sdVaNZrPfq1K2Y/gbwYBLFJHPS+OPCUaqT?=
 =?us-ascii?Q?ibyrgafp2foNXo1wW24f7+AFksLyBUYgpR0/M++jALc9HPNawVvHXWWIx2Y+?=
 =?us-ascii?Q?O1w49GeDHUwzH4Fr64k4OC3/0eZDz4ZM1dxNMabiU7uS1S5NrO7CXtfzQaU6?=
 =?us-ascii?Q?beNlEf81lZx1FD0o6XsNmt2HaAlsua8XNkSGAzvMWX9OIc+LhGQa40xP60Xg?=
 =?us-ascii?Q?m7V9pCrvInXqozxyWtum0mAjtr+30z86/VVCtgT/DhUWrltA38TINVwC8hzX?=
 =?us-ascii?Q?gemStjANbIepcDa90TV+iRy3fMv66tAYJmVdpjJ6+e1ifJQHN0h8T/H9HBfT?=
 =?us-ascii?Q?EOUjQltjxA01iG2oK5zkaXFxFekfvLugSVomUv2ONr6iUNknbYaPdagpkdy+?=
 =?us-ascii?Q?qD3FCe0NRseBT36sJUprG4bKaWMPhfYtORVgVawy+wAEZnXkjV5XB1N/JmOY?=
 =?us-ascii?Q?sMsSMRTkJMsKid4S+mbga3fjtewcB0twBBP3ZK3As2s0aHtzrBqifG3sZK2d?=
 =?us-ascii?Q?xMUps+t6DeVE7HgZxhvLL8GinjH4xyfMwfc6U/DHJWp7Mep0rEBOPjrZ29/B?=
 =?us-ascii?Q?JpeqvlMD8P0wmgRLoNhymGJc/bBpzuFNv6w+rmWy9GhHUUXOYyEar0rjWWEy?=
 =?us-ascii?Q?Gfn/7Tqo5gH9JPPzpKgdsLOafBh7P/J4sExy/XOkAKh94liikm0HXxGg3zP+?=
 =?us-ascii?Q?5Ay/ORPCt1T+5gUnZ2Mf0yE6gM1LoW2lUY/2WVhEtjrfpUXgWuIILEQLhgxZ?=
 =?us-ascii?Q?v4COoojrBhll5Nj4P5xkwSiENhGVBbvw4Okcq9/bvxaMhgACwJAG9aE9Wg1T?=
 =?us-ascii?Q?tY5WvogmnxFGUX6HZIOCeyvI2xniU5mgQ5lmmfO68kMFGjr+Suy91WxMc/wi?=
 =?us-ascii?Q?Gyc+bmrqYDsa68wmLTj1bLv45Ka+60t7Lh49HipHu7nWOWv/WL5WGej/ipry?=
 =?us-ascii?Q?RT7Gt8iOFI99En6OPC7WlRFCn3togwb1mS1fE4pItfTZ+RMxHIPmVDUs3H3w?=
 =?us-ascii?Q?TsuKwIGFZHcsTVWFhPHlYIJ7It73VShM93FVwd8isvv91RYx9TD8qpsA3Ak9?=
 =?us-ascii?Q?0u0Na7lHXGCq35xMGnzwufuHuEI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfa2e49-e165-4326-a603-08d9d6a6a00f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 15:08:59.0587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxd1Q79f+wwxX0ZvyJkxXngBaASCvBsd1Nk8esLvITP/4zAlgah77ZWMQYKqANQrjgI+LYogiAkNWRVQpW7UfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361

v2:
 - init _port in patch 3, otherwise it will be a random number in some
   tests.
 - depends on:
  the "fullmesh flag setting support" series.

This series added the port support for set_flags:

  pm_nl_ctl set 10.0.2.1 flags backup port 10100

Geliang Tang (3):
  mptcp: allow to use port and non-signal in set_flags
  selftests: mptcp: add the port argument for set_flags
  selftests: mptcp: add backup with port testcase

 net/mptcp/pm_netlink.c                        | 13 +++---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 46 +++++++++++++++++--
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 14 +++++-
 3 files changed, 60 insertions(+), 13 deletions(-)

--=20
2.31.1

