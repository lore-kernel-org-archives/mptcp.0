Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389BE7C
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 11:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645009498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rO1M85RSTBYKcPTZfUcrsnulrunYFaSbL59mPuJtrI8=;
	b=TCWRZz8VUmVmRj3gG3n1PEjprfgNeg59Yns3CRTxk/Ggs26zvKHJrM0jtkIHtRF2JilNGF
	U+eGMs5U1qmSMJOjeaqj3F6lfmzWvAnLIYFZVinB50sitAplSxvRosYtuVvxSUp2XqZOiF
	eApdq5/B+7THqDyb7+BVB4EEepqG4JE=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-iQgnss0yOIOvjSbqh1-5Rg-1; Wed, 16 Feb 2022 12:04:57 +0100
X-MC-Unique: iQgnss0yOIOvjSbqh1-5Rg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxSzmG3rvJSmJZGmaP0GhQ7AQi/UM/JqY5C/YDGpJf8VrqE8uHDN5MdwNB9qdvIkA+HE4fbzyybrsTccLvuERjhf3nhXMP/knb5El3VQRl26uD6WZ+d39vEfnCXt6wdp2iZct7ITkBUkgwvpQNAMzoOie1uXiQsudZ/MhPfz8gdSX+33WDwfwzmJCEWBj5Irb45OOXmXbSd31YkaUaQYKbZiouY1jCWCoZ7iK/AFMcOlnJqDO2XrzuyDp04aDd66JR3vKpGBikxwqoa9CrqzwjD+etSqmvdNb2hu6fiZBVMRzS57c+QooOiYkYo0b/rOrsHRp4vAPXebcv5H93AOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8r3Ki1wh7SXHNR87cL3shZxKHvA19CO2O6BpBNL70w=;
 b=g9vlDWJMbK2E0/2NhQUitpDGcfXQIATwyfF0i37h3v575QtXiFdh9S9ZhG9411c0908iox8jQiQtdC2RQj1emXZyKyIWZzKg5t/ceqq+VFuP5dt8w/pMDiqptZXGyQEPZeGdiNxJa63FiIVun11JC6ZjURg3tn4JPqSOzecyxBP3cZMSXn3BFqlbzc0aPIQ7kmOYOGpkDThmUgWPPOU2ruDiom/1odfj8fNB4N61PV7bFLW18XGP2MADePmEfZL3pvUdITYq6krDe0w+R0fnNrZoGxLk42OoKns7zmO3A3rflXbYFXcTRgQmu03xzPoNZ4W4qjbg6dIWQw6+aReydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7422.eurprd04.prod.outlook.com (2603:10a6:800:1af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 11:04:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 16 Feb 2022
 11:04:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next 0/6] MP_FAIL echo and retrans
Date: Wed, 16 Feb 2022 19:05:07 +0800
Message-ID: <cover.1645009373.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0010.apcprd03.prod.outlook.com
 (2603:1096:202::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dcb6b96-08ba-4485-f061-08d9f13c29fd
X-MS-TrafficTypeDiagnostic: VE1PR04MB7422:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB7422C26828B9A0A31875544BF8359@VE1PR04MB7422.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S5Bd7s7oss+SbVc8rKWbDg7vwF+Ux2ml7t4lyelg3rNjplBs6enS3+1wyxoLTWHzYEYOkdD4dcf6/xHDCOzYo2CtIiDkwWY2L4eLDpS1NVINjb16i8LYWsQw01tgS/1NbBjhyZ/b6zMSUIfaiSgh1CwJ3Zf3hFwtNshKPOv7OTlOhIYPL31YgQdVDnS4yhVsPSj8SisxB++aB6kfwd3AWo5QBcbt1mZsIhvzRNpFrO+T2LnC0NAMrUr03YDwuKoiT8nwER7N5IJ4JDjsSH9I8dQDp0YNeWolXSrEWWXRVgfudCzBIrb44QxeUGbgGLDzzzhNmEE5sEobBXERwKY2UArT3xg+ZhV2o/tSSd9YbxII5QLdZjOkQ7iALPDgRMoQkdUAC92rh188MMz7lEZd7wl0xbl+Sh++NHJRPcu5Pn+VJ4TxyEdnNLKWd55+1VT2fW834dCdUu2NE4EB2iGXaMCvu4xtRfCaauWW0J+G6DTfLV6h1ZXRAgctuR9iHM9ts3ugkxFI5ftaTGNxl87kMKDfzO/Z4YQbf3siz/IxPMTA7T2w5H2g+WFSaxO4kVm+EbMqupbvrx3fWkklOePRmYS8ajf76auj9SZJkc/9YzooODYde1gOqJS0LtjgGEyyaBlKCKqIDPAwGGtw00s/EY8jDZVxBTEj0D6mNp1b2X+JXnShjLvGYPFVPnE3QoeN0sIiQcu3h8pVCFn8RG586lG39029gkI5RYQxHW3ZSlc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6916009)(26005)(86362001)(2616005)(44832011)(8936002)(66946007)(66476007)(83380400001)(66556008)(4326008)(8676002)(316002)(966005)(508600001)(38100700002)(6486002)(107886003)(55236004)(2906002)(6506007)(36756003)(6666004)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rEbdIpC4YKs7V2TUpxnn6SgtR3Lr4qCPYbSu3Caq0Q/j6Pup+eOcftCptV2d?=
 =?us-ascii?Q?RPubQZm+8rMh6QnJYT8+s2rBgd2+wBy95jexvdZkCCfSBl5IljqAtkA1tlVR?=
 =?us-ascii?Q?TxQvD7tcfGVEypD1oj7gb89W9hYNQC0en0S8dZjpZWXC2woDyKKybcbESK1n?=
 =?us-ascii?Q?iB6XcUDUTvoajKzpj+ETXLXk7eT5aifONxnDq6GGDy6B2K1Gs2wyw9FmedYH?=
 =?us-ascii?Q?lahxrbXIuFf+1cJxEIVCSEGMfFoqQXa/GSmvegG85e+9oniQZdIx0ueohj7Y?=
 =?us-ascii?Q?nPlY+JaAVJZm2VsMcLutemMMrn4PVJN7g/iSXG1H0gbu4kbRQ7NamQ3P7EVG?=
 =?us-ascii?Q?EDoPbKBd3bU53otk0isH5rwgunhLUyhm3zO8GGjiBf2g+AcY4gU9HRchWitT?=
 =?us-ascii?Q?7yRCSuaUrmsdLKK1pRaTZuPCG+NoUj+A+d9SEaEhrOnnb9cmLWzabZdZ00Gv?=
 =?us-ascii?Q?8HqU+yFZjrMTqBzDamoLw62GUOOK241RfwwXTDSjO+nCzrH9KuVnUMaeFsiw?=
 =?us-ascii?Q?B0fPVPSY+RKJhhTAzZWI/MY09xM7HNrffkZTZt7omSwJFp4wpu87rtsOm1AU?=
 =?us-ascii?Q?xilSGua6crvkaut4vrcCcQwm5nKgA7rDMUJoWljm8ZZ69YXo0WatNsfI8xQb?=
 =?us-ascii?Q?Xd5VOLXfO8k9MH4s46jjSpAIJVuQMmk6XndHwnimW6gXsRrvPRx602UV7hsu?=
 =?us-ascii?Q?bCMZn6Mt7GnO1KhqRoNVtt6YtnchwXwfJ77JYQqECTVHVZnzUDCiuaFTDT7j?=
 =?us-ascii?Q?atA1+OhD/kJIb+fkxdYzPRqoJOW0RttoOYrm0vQ1PLK/MPlWXuUER7PX0cVw?=
 =?us-ascii?Q?f8M6fPXxeUTN3AWsPR7uZ06/npiLHTwLAFCjQOjwEDccBmneZoW0SW0vNhLR?=
 =?us-ascii?Q?G2ME+owD+zCbz23HWqg6FETl9ESk/tnoz40A4z2/KiMRbrq8u4dtK0xOU1Mz?=
 =?us-ascii?Q?1WiomdQK4xoPSdvwiXizXHMXMWtzg7kcpKIZCAlbh5/LMtjH6G9YWGafnw8H?=
 =?us-ascii?Q?EV8yj/mtKqd1x5JvqNgEaDUD5mzlksOWB0+KU7CoDoaUqNtoWKn7QwuOEcHK?=
 =?us-ascii?Q?wSct9JgQPwVckOejxM6moxScH9jbSCuMFvL7EHESeSDsHnu50IGgm2WqPHMh?=
 =?us-ascii?Q?dNoAXc2rGY5fEc0poVLVPR7OI5pYDXEm7qDorBO7HmRSuDRtp5clp3VoGANY?=
 =?us-ascii?Q?DlDpagDOFlQFWYebDWgfLLqJEu4UvonPUJ0ymSrARffLd0Aqk9ozoCjOayTu?=
 =?us-ascii?Q?nDYxqef8dfIjj6TwU/nLMDKd5O49uSYVvy5RmTlhh6xlTwmzUVvrWLsKIPHG?=
 =?us-ascii?Q?nzikIwIcRbo2bUZoJI8uX+1rZ0mP9qNHX0VWKjZRHbLPPEUVQ9hcvhlZ9ESa?=
 =?us-ascii?Q?EyTFYH0QZ/hkg8tiVxE800t0ErVrl7dbaR8pGSvw9zRnQgkkGTG+7KjROPtO?=
 =?us-ascii?Q?Bc9ixJ6QD8hv4MW6cWhJDkNZZs7Cnn/UlajFWtlu5tq0uLmjGeI0KwLclZGk?=
 =?us-ascii?Q?i6hfz2B38rpvIoPBzQc3PMG22hxlLt4RIO8ofWCJ4lEO7555psAysKULuvM1?=
 =?us-ascii?Q?3whWtCOQzwZU4jSX8tKHyfwg1e+3x+ji98+oy2ydAPHKAUfH0cV/XPggXP4c?=
 =?us-ascii?Q?kicdwtvb1SE+ZYMV7GuxREg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcb6b96-08ba-4485-f061-08d9f13c29fd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 11:04:55.7444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Qbuk4h0o9W0kWxP6cyG5CoTPdFU8nK+rkuS8ApKoDdjFuKo1UyazibFRQ61VFh/YhNL8ULYIBDAe9f3mZqXrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7422

This patchset added MP_FAIL echo and retrans support. Except the last
patch, others work well.

Here I have some questions about it.

1. How to distinguish an MP_FAIL packet and an MP_FAIL echo packet?

Unlike ADD_ADDR, there's no echo bit in a MP_FAIL packet. Patch 1 used
simple method to distinguish them.

MP_FAIL carries the data sequence number of the checksum failure.
MP_FAIL echo carries the received data sequence number of a MP_FAIL.

2. For the multiple subflow case, MP_FAIL echo is sent on another subflow,
not the subflow receiving this MP_FAIL. Since the receiving subflow will
be closed by MP_RST after a while.

3. Patch 5 added mp_fail_timer as a struct member of struct
mptcp_subflow_context. Is there a better place to add this timer?

4. Just like the way of dropping the ADD_ADDR packets in the ADD_ADDR
timeout testcases, patch 6 tried to use iptables bpf to drop the MP_FAIL
packets too. But it doesn't work.

Drop ADD_ADDR packets using this bpf rule:

 "nfbpf_compile '(ip && (ip[54] & 0xf0) =3D=3D 0x30) ||
                 (ip6 && (ip6[74] & 0xf0) =3D=3D 0x30)'"

I used a similar rule to drop MP_FAIL packets:

 "nfbpf_compile '(ip && (ip[54] & 0xf0) =3D=3D 0x60) ||
                 (ip6 && (ip6[74] & 0xf0) =3D=3D 0x60)'"

I thinks the offset shouldn't be 54 or 74 here. Matt, could you please
give me some help about how to get the right offset values?

Thanks.
-Geliang

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/261
Depends on: the "add mp_fail testcases" series.

Geliang Tang (6):
  mptcp: add MP_FAIL echo support
  mptcp: add mibs for MP_FAIL echo
  selftests: mptcp: add MP_FAIL echo mibs check
  mptcp: add a new sysctl mp_fail_timeout
  mptcp: add MP_FAIL retrans support
  selftests: mptcp: MP_FAIL timeout testcases TODO

 Documentation/networking/mptcp-sysctl.rst     | 10 +++
 net/mptcp/ctrl.c                              | 14 ++++
 net/mptcp/mib.c                               |  2 +
 net/mptcp/mib.h                               |  2 +
 net/mptcp/options.c                           | 23 ++++-
 net/mptcp/pm.c                                | 41 ++++++++-
 net/mptcp/protocol.c                          |  1 +
 net/mptcp/protocol.h                          |  7 ++
 net/mptcp/subflow.c                           | 30 ++++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 84 +++++++++++++++++++
 10 files changed, 207 insertions(+), 7 deletions(-)

--=20
2.34.1

