Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6152C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 06:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641536230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=33ilhGqvO4q0VDuJvddLl18zHGBFY0jNgsdehEjufS0=;
	b=LrRkECO9vHiHEMU2R11oP4h+neI0VGMJMt7fd3uPN6AHwmEfQYTWucYyCJL9PWBcp5Z6KP
	+SYGitV3/48ZljUJyQ6h0UbonM6O26SQKJ/l9nkaOWaiULPSvY2Z7ARGcMmxP8ZSXbFmJn
	o5ZrrsVEG83+CFLQT/Ohk/6HXK7kaOc=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-TSGu2bQePVyHE7vMWPg59g-1; Fri, 07 Jan 2022 07:17:09 +0100
X-MC-Unique: TSGu2bQePVyHE7vMWPg59g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcBKO61e8q1wbs3TayuGtUwkCRK0Z9TYY07kCV2pQ0sna8DgAX+ggIXa7FGMX061wec/fiYbHT+1aeFsrp9gSM14ouiAV37vwoTSZyHMKRFr39Ks4x6ygtQ3V1caZQCmY548H3UPcJdmkbTj5ULAzfTrEld+un0DIb7pS5dByW7sddmyx0toPxlYct7QdIgLl6BkjQcWVEBgS2MUyPf15CV25hYWlhmPD5WBGP8cN/oSy6J3yuuiskTw1N1t27hR5y5GTIvALhleDNaqKzzCZS/SIilVI/6AfsAalKgUhVbCae08pGwrP+LpmLodz9rYQCjqgujujl80M+VwjZq+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0ZSlWO3UcVyhWAyh9QI900sYG14jXJLsOBSnQsJZWY=;
 b=NdvXb5ykLx8b34jhqQdy0Gagmznd3FcffDIXlQPKWoLYF7ijtBmagUlrl2QCV/BYijw46T02mNySmO/DC8si9j5JYCZSMNGRT+WpXdmXwkpCKvSdDOgzYOF8r/SaVflAmcbtnZKwWRy5zgO1nmEKKaAgyZcV+J6tHGrF1tTWpkRF7SiYyWjVkqt7hQvCXv/dkM7zFq+ais1QJxn9hkwP/XVJ0InNUlO7QO3SZ08EYPn6nJwHjnAbkHrtzUTzuhxbTcxoQkMKpAZ0RBrgA2tb4yZm8F+mWFF035bNKVZmPur3I8B0Ldm4p0RPskXA4phZliTGaV6FDwsl8jWem0krEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3369.eurprd04.prod.outlook.com (2603:10a6:7:81::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 06:17:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 06:17:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v2 0/9] use 'ip mptcp' in selftests
Date: Fri,  7 Jan 2022 14:16:52 +0800
Message-ID: <cover.1641535880.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:202:2e::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16d6ba2a-ffcb-479d-ead5-08d9d1a554a9
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3369:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3369446B1204F6990EA5F7B5F84D9@HE1PR0402MB3369.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h94VtfzVkbBu6dCY4nA0OTugTVXMJ1ENGe2cblbiDTvQDMyXdwS2TkdH+4U82Axx6HjLXM6k2k/BlPREMXzhomaD1XH6YFPUUrv9i0y/S5kz4Uu84qdV/ZzI/E7bDTfaocLndhoJ2gId+440btCysRpQoSNZKp0jseyR3TApBI67+jDiZFWimg1HXdcj7bd4jXvfBvNt6wQ8Zw5wsZsoaoC9oqkybgk6bDT0rjIt3B97dERNwYNnUxnuezMW7Pre9XHtVrkmNhVr3rC3xqrs9XUTVsIf9h5cjihaHylDnWwI0t/7h4jdxBEepu0fe1+qV14VtRfayuDb1DO/m/hI8tp9wJO4kWXLJbcr49cv6QiAoAxShYvCLtosGrzG73eV+SsiVTuawknuKQnG9/yw6QLX4jVjghEfXjlyslq4qgRcQo9gpz3jF43CShOAuaLkOLHS0JZib/DuaHdhVL5uOuPXEyWzliOWW0iW5YZjgAFglT89WxQhTgf4qcFE8Fs8QzSqd2wYNS2vEUl6MUglDr8gQ4FH4paFi92reK2BH6y2m1aUeShZlIa9rIXJjf9jam2oCoYTrgI2JUeNEw0HHVvN4y17d28PxSS4lzEyBraDZSCpPM6Uk5RbGI60TtRFCovKMNAt3ysIeHfySB+ikg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(4744005)(6506007)(36756003)(86362001)(55236004)(6666004)(6512007)(8676002)(6916009)(26005)(107886003)(316002)(5660300002)(186003)(2906002)(6486002)(66476007)(83380400001)(8936002)(44832011)(2616005)(66946007)(38100700002)(508600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hv8GxbqzMa6D3pKxBcryrRoDTX7id+I5TlvmEreKqU1++oyOnWZ36itQgCui?=
 =?us-ascii?Q?T4Op0gaVu+BAsp3WKCC+asKRRl7b0377GOhY8K7XHD8RhZcuEvC4gfjPnhEZ?=
 =?us-ascii?Q?pG9fpHLUklFPGqvg4QHsT5rDYFoLP1fSR2aWiIY58a6epfM7Q54TuSJEdzx0?=
 =?us-ascii?Q?nlfCZ/NzY0p+b9Ab614FBZa7fD1JrJV9Xqvig1lclF75qfwnKQohhj/bGFlI?=
 =?us-ascii?Q?dIBWOnVuO/9QE4mw4IsGhIAedp24mQu6odlyEnFJalHur8K4OEfGZVDl/au+?=
 =?us-ascii?Q?tZN6FZ/kZP9nSZp6EFr1kWVo9ugAHORP5tKLgMVZB/DUgKmCne0NumAhvMUy?=
 =?us-ascii?Q?hl+bBOuUrLNzpPjStrAy5Q7HR1F/tcGu5wawyZflS0LtAPHE0lOFESvsfgn/?=
 =?us-ascii?Q?fm6ZKkA0TGrUNzjfJxTa1ECecIqDzTPx2ZfKJQY7cl55vqeTwgkILir8VwBh?=
 =?us-ascii?Q?6FtTrWQZaJ2U7x6DktxRUMXGbbtAy2MYGnIFMH66vuxFJXCYqBWAwm1Qab4y?=
 =?us-ascii?Q?bBbfj9q9hY4NxSE+kTNXekzXpvcRp3kZbwG1MTYiHFqJqWF5cE9g32lH8MiS?=
 =?us-ascii?Q?i79wapc8gZ+rTN5FCDrSwP038G99sMj0u+xvpgojV0tXizasbHt3keeGGAxd?=
 =?us-ascii?Q?5utOC3a4jtlwX+l9JUYZQWvrMwYROMpvCW3sMLdAvs4ryMLj76ehb8EMHWXu?=
 =?us-ascii?Q?oN0WpXXnJeiX701gVG0njA6syhu1jTdeiTjGL3Oqm+EuDWRDC4gs0rCDCgQ/?=
 =?us-ascii?Q?1v8v5QyAqPIaYO1BHOTseTTnZCQbP+BCV4FU0uDBUor9a8pbfeD80EVkVMt3?=
 =?us-ascii?Q?aWu7lZb3r3BhwrQBWV/4qHlF9dHbTDeNGFPoDb7bMRj0IxnLuO8KmAMRqsgp?=
 =?us-ascii?Q?gTxoMgpO5riBz/kE4yWodVwppOi8WvCkXtKEDry7bo9wUd5ACQjWBSsFTDNf?=
 =?us-ascii?Q?yek/XtXO/pmr/XN++5qiADQ4AbcvBidQIQ5Mv7wSyAT2d1fIBce9ZMkTG//t?=
 =?us-ascii?Q?873SVWwjeaks5jhOhnGBAXVMm+r3rFofIBQTyBwBXl3OQPeqyR7kk8/tiplr?=
 =?us-ascii?Q?APaNfYoXmOYuVHCf27taALPjYyzMsSi4Kp7TazwrsTF5t5oVLft1/Svcxrqz?=
 =?us-ascii?Q?CxRvwSDFz1uWQDuSEZxMU37KwYCXOMiHnOIbdupaAAzXDpoU8RYYborMD05h?=
 =?us-ascii?Q?WBK8taQWjw9YjhjkDJp/Z+TtRRIhCK7o/9w2sfmmXRoHS/RAVNmu394U1cU5?=
 =?us-ascii?Q?cHyGYnLCUAbtC24OuETW6YgIyObkwaPoOFCplizXithn310Vd056piJX/9QI?=
 =?us-ascii?Q?kktv/DpULN8hhjNTADxOa+/mjTOIVCGhmPfH2cwsxVPmci+u4XZAGeLz0FzC?=
 =?us-ascii?Q?vcWk6A+R1BadC/uwXRUHtug/qtSb5qCnrYwiS3gC0QHQkXjN99xnK3XyQ+PS?=
 =?us-ascii?Q?GpO9qouOT3v0YG4S/j+hIoOcpmY3a7odl0lWVFc4f2dZHUz21D3WQF4bY4wG?=
 =?us-ascii?Q?gD/KEAL4U9dkBS2Ow+3vUpWNyD7ZHYsWmD0TGlF54QC2LfxLu6sMA/RLcZJm?=
 =?us-ascii?Q?tNnqhmzxRB1qDrRSQnpVPmTXtou03Yom61JIA2UrLrHZJhvT0gCTEFO/uf02?=
 =?us-ascii?Q?v7N1Qu0XDxlsc2BSVpg3f6w=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d6ba2a-ffcb-479d-ead5-08d9d1a554a9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 06:17:07.0960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLhre+V546FxQQivfhC8U40SUdbyP0jwweOD2lG+RyD9xbdyT8W9qwG3pIxiZnlIjbRayaqwr6UonhkKqllLbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3369

RESEND:
 - fix typos and checkpatch.pl warnings.
v2:
 - use both ip_mptcp and pm_nl_ctl in mptcp_join.sh, instead of
   replaceing pm_nl_ctl in v1.
 - drop last three patches in v1, keep using pm_nl_ctl in
   mptcp_sockopt.sh, pm_netlink.sh and simult_flows.sh

This patchset replaced all the pm_nl_ctl commands in selftests with the
'ip mptcp' commands.

Geliang Tang (9):
  selftests: mptcp: rewrite removing tests
  selftests: mptcp: rewrite backup tests
  selftests: mptcp: implement pm_nl_set_limits
  selftests: mptcp: implement pm_nl_add_endpoint
  selftests: mptcp: implement pm_nl_del_endpoint
  selftests: mptcp: implement pm_nl_flush_endpoint
  selftests: mptcp: implement pm_nl_show_endpoint
  selftests: mptcp: implement pm_nl_set_endpoint
  selftests: mptcp: set ip_mptcp in command line

 .../testing/selftests/net/mptcp/mptcp_join.sh | 866 ++++++++++--------
 1 file changed, 499 insertions(+), 367 deletions(-)

--=20
2.31.1

