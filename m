Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFD47A
	for <mptcp@lists.linux.dev>; Thu, 10 Mar 2022 08:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646899779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=580mqVVOYQ92HzXzP0nzFrAgvZce5epSFOrBpia7Fls=;
	b=nNlcqzFSdH0Z5w95ntVkJ9l222la4FNOkCrTpCULBnbejoZj1/8HgjjtukebWDAzBZsGwE
	AkLKfCx7WcAytoZ21CtkpmuX4tzWubeq6SQ8OLzV7Z1VBdNhZq+ZgEJKnOmwr/T9tUTomv
	C4bed6RIElLeCSYH8U/0WSD7l3U0UxY=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2056.outbound.protection.outlook.com [104.47.10.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-Xw_0U0-FMiWev-x4dhuimQ-1; Thu, 10 Mar 2022 09:09:38 +0100
X-MC-Unique: Xw_0U0-FMiWev-x4dhuimQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTS23KOswpwWlCmU2T3cgd6QlWu7hU/RfdQNpjNdODtV6QhFaklPzKciUcjHbNQpMA6dDFctO5YHV9NC7lm29HWjtZDZQLGeSk0qKnZpADdT4wnPc/Y0DILLX3/FA0tpUZ9zRfMxUW9zkgua6kMOlpIU2bCmgtzqhX1R8Wr4CMgv4E84w/xURI7jFxFPV6c1tU4d7KPUng0hEHFtSBLjiui3oQajuRySO3XushZxlkawpv7NuLbwerwrXbrkxh5YMjFzn45L1vW71LjAq16gKw2qWsa4iWkAS4gTbXBJ7kDd9fqIwcWWXoaFjDlcCXrD6uX6o8vuaITaeF1uMovFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wD/dMNdoBWqY0Fbp2OtGLK1EWto+zhoYqDVEgxNXMtI=;
 b=jhNFGYtGD7Dq8ORAKGTwPgnY7YWnvebTTmUVA38BAy6/pwye5L/Gv2nfzdMyBjAL5R4dN4Rl3AJqST2mODOiryOnTa7SrxYXBxDrkQhuj2uKkuJhjkTfpRdyCYgSnOZJ36iQCRYm/Wr0DMMAXPhipNCY7tcXaTsdJ3eXPa5+OgDY3bLrpjuZoJmLKJo1h8P0OaGJxvG+bfjEJ7sFCHOtx4niiwXcsreMhNP3FRszbvkOWn6A4zacbYl3537U24y6zeXUg/r3DfLoEboFo3l2yHsyjwwPq3um5MOREImzqzlQUOKTv3kJI+Q3cGsc7YCdvE6GcZzQmgmH1ynpSGqG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM4PR0401MB2259.eurprd04.prod.outlook.com (2603:10a6:200:50::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Thu, 10 Mar
 2022 08:09:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 08:09:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 0/4] MP_FAIL echo and retrans
Date: Thu, 10 Mar 2022 16:09:23 +0800
Message-ID: <cover.1646898548.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4d23092-7440-4627-de33-08da026d5146
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2259:EE_
X-Microsoft-Antispam-PRVS:
	<AM4PR0401MB2259279CCB221B8B14B317E9F80B9@AM4PR0401MB2259.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dG08gqZX+kmfNqETah7j3DAf/e9QbU5yIp2EtxXKvH0FZKPbHpBsPbIJXadcqHJBuQcoIccUS0RvV36jrtAayyNWNmzigSqvsEl7B6N8AFoPmPJ3+17aa+iHuaUQvq2rkd9flPVZ8cZGNQYl933/vUmKjT5kRblZ1ZUcBTnsoDUoASL2+Cl9WUP4HyODAqf1csQxY3f4WP3G2CDmZgfm3H12OmP09Ss8ulRdMXW9e3AQOobbeNhH0SEsfmQBDTAX55LBeGpFoUfnF4nYQex/DYEYW7laLIWbLbtCOgpNfpopCqhOgsm+LUWaBPuju7TMkYOPjp4Fg5jdp3RZACNb1Jd7eCuQf9N6EFSfrrejzhpGAJjNUppMWlj1oBuYWEZPTvTd+JGZXdT424RnPjDT87PLR1vnXjbA7sC2GJ/oPugec0MlIWOiVWZDcBwiW6eNqdoqPpJ47lCZnSqjvc7oNbjOkkzIBWMw/n+6buxt7odWukh7SCV5fMZRU85GWSHSNfv0EaxrDVTO10y36H3kM3cQ6DLENtoCCpKQOq7Wm9lFamO2ZUh1nsMVKubCnm7U2KCstjdyjBT/x+Wz5X6ucdcJJWTvTDgYujKVHcBEaWCexVDvcbbiUIRmW8/kddr/mdWUQxCPoIBDsUa6OIRch8856SBB68awjtZCWsyP7AoX8c9vvJint888m/P+4WD1T0c/yXatFXZC5Fgdrj9IAs1+hOqlYc8MuXqarPIK4/eyfDrx0H/jZIVVXZInMyww7vH4BlNO/ynaMCX5Xl5FlA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(2616005)(107886003)(186003)(6916009)(316002)(26005)(6666004)(6512007)(6506007)(38100700002)(508600001)(86362001)(966005)(44832011)(83380400001)(5660300002)(36756003)(4326008)(8676002)(8936002)(4744005)(66946007)(6486002)(66476007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qYTRynt0XM4CgmMQPLLtYUX0JMsqDmWo5fAZJ1QlEWAjlutmEfIMI2skEzww?=
 =?us-ascii?Q?95VGDiGHnxBaOReoSWP5vVkg4WQ+JsF560s2KKW66dE/w9XjGJsc7TLs9zXC?=
 =?us-ascii?Q?UTNhbFNIo5IkttQ6nwZoCFTjeP/aWymq0b8TNRO2IHhW+nu/rRspE1071fD3?=
 =?us-ascii?Q?481uU3hak6sVr4qLoZsA0vYPnv4tETUEghryDCVNlbgIvnnfJgA2Dyi0Bjif?=
 =?us-ascii?Q?TZkz9zDl5r1bq+3XBNPjpyTu+3RashRbzUw5nbv5wVL81p2qFgnffvs4gaUc?=
 =?us-ascii?Q?jEzFuyR0WHyKKI1xo2NZ2lCdUvguuNE5W5FcYPSY7uQ7BrX3xcfPoL0zXP5+?=
 =?us-ascii?Q?9E5d9WfTKbxQr5E6FWMYtl1T4mDA2HdOirj3/jHZ+5ErQDu+6lcxt/Osw54p?=
 =?us-ascii?Q?MgoDND9x6jfuKMUWC8Fw9prN55SxARhts2vRyrMlY2InQllRZ8hDMi1f9Pmi?=
 =?us-ascii?Q?UK48acW6ZVIG8/SjwyJDNsumXBKbwgF/oF0vCKPLK7lwHHvwe1NbwYEKkQvI?=
 =?us-ascii?Q?IyT0FUddR82udMGISPcQcJb4fxeWM/j81kT3NC0S/LEiAU665YgaCh9TtZeO?=
 =?us-ascii?Q?Azg/CYJ7W5FMVDRqk4YbLnZ3Pfnko/gl5gi8qvKra+Ar+Aad72Gz6e2JZI/V?=
 =?us-ascii?Q?+Qu3Y1k4gj8IQNR2Z5Uv2YVA9cC32XCMyUUYje0LzxuQT0bEjbz2TN0yP+Wi?=
 =?us-ascii?Q?3OjA+Z0ZTmu9KnVDL9BKrDszMzEdjXI2zLPIQ4W6s+pgvwN5LsgMXewMDPXe?=
 =?us-ascii?Q?JX/lIQ8h3dnCJXegnFI0z70X6To2ICu+EoqoBhyIgVVuOTib0JUiEqQvPDkq?=
 =?us-ascii?Q?W+qr0yYJ8C8RZ11KEYL6EkQzr8L3hvUyP6EPLV1yV6WSOhKGbH+IEn15zl4Y?=
 =?us-ascii?Q?9PqPFQrXw2tXTkEw1XCAiY5u0BhtvSQ08Dp68AXlVEzKRpiPd6hwxWwb//q3?=
 =?us-ascii?Q?wDVnnqIuP09Zzhw+SlgfTrSoqAKWqR0WPJCnI5yg6OfQnHRMi0vYbXT/vavl?=
 =?us-ascii?Q?v1DI+qag5ziXUz6qThO5A7JCoNH6Ktfz6Amac3+WNKDauObN6fca/HUmZL7Z?=
 =?us-ascii?Q?dYGSSwvTiwbP2I4HntAE1bB718hvdUBHKOpg7TroLeyByvHxVO/RqvPwu8qi?=
 =?us-ascii?Q?2a1iN8bbDqycEiYpbXQQZ2x6zfq3cnDlIw6Z12Wmr8ddpfwGL+WqQIddCdQ5?=
 =?us-ascii?Q?y4nk5i/VozxaU44lVRr3LTAI5IHD2JXVRFpvSA07GLyfRo+yLj/VTCegAq4k?=
 =?us-ascii?Q?XRaJzDkRzUHpAnAhjoIMMUcPyXjxwQHALNcJUsgIeqMFb7+WtuY7tO+NLn4R?=
 =?us-ascii?Q?9BWzk8iigZ7ROzwKjLS5YI75gwql7wkcgUlaxNoAyNcCx9U0mbByxCzMr4Jh?=
 =?us-ascii?Q?FilQOdDcGdxVfJQG3IYvvj//TZxeU1J0ZrGPbcQiC978pvY8cg6lId8ka5C5?=
 =?us-ascii?Q?2MztcVH5jDbAdcizwY3FCn9TgG7761U4nc/Zyp0pfSgpdUptcnD0jpGsh6SH?=
 =?us-ascii?Q?49REyohmRS4cQhVcsB1aLMhOwpY/+DrFSFdT7GwfZ6IEl2QeJ+vhhTMCXW0B?=
 =?us-ascii?Q?HYG7gwwKPa2/oRftEacNEumpEdhrgvekZmxTiLZlLlVO/B11zlwn/6cEu+0b?=
 =?us-ascii?Q?8g8V6iuStWC7+cK9W48CBDo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d23092-7440-4627-de33-08da026d5146
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 08:09:36.9323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LntA3bIxzKLIDNOMXDyGyUXLSFvhUs1gn1X53MSA+31SO3h0Tl0HzxdQ+P0i2zBFXNkZW7B7buwqZg/AKFBQUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2259

v4:
 - start and stop sk_timer instead of setting and clearing msk->flags.
 - add a new patch.

v3:
 - use msk->sk_timer and a msk->flags bit.
 - use READ_ONCE/WRITE_ONCE for subflow->mp_fail_response_expect.
 - update selftest.

v2:
 - don't clear mp_fail_response_expect flag.
 - add a helper mp_fail_response_expect_subflow to get the subflow,
   instead of using msk->first.
 - add locks as Mat suggested.
 - add a selftest.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/261

Geliang Tang (4):
  mptcp: add MP_FAIL response support
  mptcp: reset subflow when MP_FAIL doesn't respond
  selftests: mptcp: check MP_FAIL response mibs
  selftests: mptcp: print extra msg in chk_csum_nr

 net/mptcp/pm.c                                | 17 ++++++-
 net/mptcp/protocol.c                          | 44 +++++++++++++++++
 net/mptcp/protocol.h                          |  2 +
 net/mptcp/subflow.c                           | 11 +++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 49 +++++++++++++++++--
 5 files changed, 118 insertions(+), 5 deletions(-)

--=20
2.34.1

