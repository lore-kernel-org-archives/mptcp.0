Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E7C173
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 10:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641982075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fkQEu1KlQCl/NyMrow3DbDPPpstKhf3lwd9OaHH30fM=;
	b=ZISST30A1ayonDv/U368cNx+JeoVYGFEZpLAlpqPqzCOVVUzHJ4gK/F6BRRyacA5x074mC
	WQQjduVd4H6mc+fhY5MS5iIhFgfD/uiWf24b2vaKffPA5ooVlKPJIrqLGiYvuKn2FyNGaa
	N5tCL3gJppoumzXZTkno392f50wZskw=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-H9SDfymrO2GvDhKKfBFFfQ-1; Wed, 12 Jan 2022 11:07:54 +0100
X-MC-Unique: H9SDfymrO2GvDhKKfBFFfQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTAeAG1aUf3yE7nlpffHKAZMPN0OZzQJ6GtgZ+1+TqTs0izMe9VZrwrZweBF9afENKJ7sWmc4cI3UdGLOpbb4mJq8uWlmFOGF+93nK9UPvVYB7Uyg+rgvUCZzTw/9Ck/ZHy5w0YtActE5yXof1Bc/ZF5u1Iyt/UX0h/Wi66BXKXYArjtgb1roU+ecxaLyD5/oYFW4APaBjZiqK3cQ2fDhaODoI0xBNzd2SvxVDUyFZSePxNPLnaXCny70ryGLfM3I6/cc19m/C9/i4zut4i7hINz7YQ/N60hetRkpqWUVs/YNrlEc4T2I83grUWTfKrW2TeugyxGaSC1tiLZISQIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTJpLtkKmFx1Ns9B0lWJ/gMkUWUg4yeCyHSFp0eUIuc=;
 b=WZf5lXbXDiK10p37biz65l/oJU5A35CzOl7kDKTZ2vrktV4WkU0OYpBIWvTD1lV31z3ctbJ78Suxw2lzgvhUBjWvcFopAxmVoC/Se6tHjNVSHkYsd1H9J/i2s6fQUmLwlYXyS4sUoO6jh9zH/IN95D9GFXcfXWPkK+tbjbByYDFwKnfIFSBG1cxaAWnGL42kyM+qQQhP7dBnVLij0JxeM460vYYgPxEeWumlwbsbqf3feIzr1WgEC+7M81Q67A9gxbYqenSNOBGRV6FUA2Xqq+QvPNHWNOssPNzgopZhI1ka2c/W/av1yIRbV6ua5bT2imFPHbZBfA8/bIXgI4Hn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4533.eurprd04.prod.outlook.com (2603:10a6:20b:18::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 10:07:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Wed, 12 Jan 2022
 10:07:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/6] use 'ip mptcp' in selftests
Date: Wed, 12 Jan 2022 18:07:29 +0800
Message-ID: <cover.1641981669.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0155.apcprd02.prod.outlook.com
 (2603:1096:201:1f::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6347ec41-96ad-4980-dde2-08d9d5b365d9
X-MS-TrafficTypeDiagnostic: AM6PR04MB4533:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB4533049EA3838525CBC9729EF8529@AM6PR04MB4533.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CTcjLHVPDm8ZcYKQDQvDQdnbzNMOd6iaY82sU8NhZLNP0mRoeor5C5B+hP5Jh+Gepkf8RwvYxQQPupRdbwrF92isZi85vXgf435CrpZeWPmnwC4cFiH0J2rznBqe0JRFkuik5MwXs84zf8pw0+xWPMmBEut9TmWhFDI/fgr+5GktGj6uw70lYYRL1giX8UPhvvrOucsi118bHmoZ76MKrfVTVnBDNOd9/LE/vWwuvXdhF4NW60eDeSgqJMIOFkUzaZAID2OxlY2xFe7G2gB22VLigz/1ktcuvXLNX2B/eWp92gChCTlfe3SGypUXsXTv6IAi34YJUVXc6lHETIwNiXaA3sTatGpG7lUDvHlRIS/YJKPLWo3AHlMuYP9Lt+tZWg0tlVmbMNHPhxcwtB5z9H1OSbvBm92RFVjMAPQy7XaZTdesmkQ1NNkikrDupQX6/HsiDU/RLG32B+4/rD6UCP3fjS5NyIeDa9MLZRpQ5qspsFFn7lIC0L/xjEHpMwPdo+AeDBBXu4+f1atNE1UkQvywgl9IQJLFnRKRK6SMhNCwnpisahcHalsMdecVKJvWO305gksyTXmbI1Tvc9ne2c5pj9lFd6coPVr9GUKQZ4/jRLsRUlY8eFalI1C/1+6XLKbxmjZu4v99eVu1zQsLDQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(508600001)(316002)(6512007)(5660300002)(2906002)(8936002)(6506007)(44832011)(55236004)(6666004)(2616005)(66946007)(66476007)(66556008)(8676002)(6486002)(4326008)(36756003)(6916009)(86362001)(83380400001)(38100700002)(186003)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jl4PIvPMrG/pPm2iW56Pih+M3Twbm0HiBBoujlhjcM3kHXrnSt9BXaSOaXev?=
 =?us-ascii?Q?9KIgj/wXFNP3Xdn1AIXC3jcBelMaavXFRQXKF0hNq3tQzo4cQGfGl/1lZqsw?=
 =?us-ascii?Q?LTHwDv72AJswTw5XeAxAVhCVa+MhmdmRgOVLXleiBIOk7PoHY3w7Zr0J979D?=
 =?us-ascii?Q?ADTGKbxNvIJVnWE055eIMKYJlc5k9x5Z9CO0KUbG0aufCeRwiYXtCv6y33FM?=
 =?us-ascii?Q?9ggsQK+0fRmSc/YTY+kqknHW699/oCIQHjDyhlUhqJ4AAZi0sqdrkhznP1d8?=
 =?us-ascii?Q?WDiazI21MUNmswLjXbUvcU+jY45d7fcISg7yoMOlXuhBDjCmDq7B6aoptjtV?=
 =?us-ascii?Q?OKVNhxTQNdhlRzIyan8YP4pvN+iy9ChihvjZMg4NHtpwIKc/U+k6NxQY6RVS?=
 =?us-ascii?Q?P23xWSGgd7Vm+fmNzzzkPnj7bv3L5CTOEIbMq8DesKjbtiAXCPgQGc0lCQvq?=
 =?us-ascii?Q?O1WEvAYt4PFjtMDI6AqjO9OmRyTcPqUrKAB+QWRZd8zIvqbvo8e4R82OoFc3?=
 =?us-ascii?Q?IrwZTZJ+wFK5aU7SGA/MBiq3mmNsSN07/VrlBj1p20iOf4Q+RTevpjIcotlf?=
 =?us-ascii?Q?J4a5u6KVtAvYBPaHgQvWDUEI6NT9VkxA0ip5BRKceJpGe5e3f2FvGEaMyw7e?=
 =?us-ascii?Q?tJmuQIrZoP+8myWKCjf76+/WR40dmk+LAdJotkPKoApsZeWLE4zCfdH+oqIE?=
 =?us-ascii?Q?JN2KFZpHrf4gBmwAjiaDtV9oeyEsB4e9/Ceix5NcUqWwV0nk2XG5rcI9Ax97?=
 =?us-ascii?Q?KA3XzbZeqqCsGxrOAJP3XW35DQCJHd4YjzaK3kJDUCLwQ5GKOBPwRzvyYyGs?=
 =?us-ascii?Q?tvNU5FXoEmxzg/Lk+KVJXHMjnpE2/Q7J+OdalruthX6NqjddK2/Wrzm89lfk?=
 =?us-ascii?Q?gs86t/amn5pWAIHG6Sm4DYR5yFjivRzw1WCatodgZBZYvTBUw2fybhCBodyw?=
 =?us-ascii?Q?R5WytryU3YZOjD9kWT7M6uTl6yesS5yW4Wsu3kjIm0bbeKikTPkNeYZqeoOP?=
 =?us-ascii?Q?BnashsvMT4rqpuSCuvZ8MJ0lQeTRTu6MzeZRCqTs/3G52xrPojYwnJt768s9?=
 =?us-ascii?Q?DklTPoVtMxPTiel5ToOVd0/YLPcRPX2HcSxbl1lwDnHka3dhTHWcY73WyFtn?=
 =?us-ascii?Q?/YyfYjYnM1vW9zUZNKAqdlx3sFN+ebFoz+qZOv2sZF8urYJnSJawRValRiHS?=
 =?us-ascii?Q?m3BWXsHsKHp7OELVjf9E4ozvNvpajoPELVHT+mkEhukP8wTzZ718AicPllHN?=
 =?us-ascii?Q?d6XOrGxGY6DaRml4B8ACiiByZBqqo1KPR9pRc8iCUEiO4J6Y8H8wmlvhsWCr?=
 =?us-ascii?Q?RAjcHUufon9kGKT+TVartciCTyU+Lzh1RHgNFJgIWLtJvfgyI0C3J+Fu1Y2V?=
 =?us-ascii?Q?G+QlQ+IkBYT7GUgFal6bd8taTjDtzpFXk9p3HIBoguep9+UWVtqiY4O11Ty8?=
 =?us-ascii?Q?oGvbXy3zBFJ4t/NVy6asublcqTApBJW/6GVz3i7Xo2xRv1kUj8tlBPpwaKSY?=
 =?us-ascii?Q?90JXPpN6ff+NJehyrJtFb+A1+7i7n/eDmU5o50ta2PcrROTeMDE7CcaVR4pn?=
 =?us-ascii?Q?Fhq5myWLqdahHMPFf1L684N4HSWYNcSelp9RoeYUsVnRElkG5SCtqe9/MuMd?=
 =?us-ascii?Q?yGjRoPuPEiVmqgyU3GslECQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6347ec41-96ad-4980-dde2-08d9d5b365d9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 10:07:53.5368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziEiK42VO3OvoJrfMY6T4u7KbkFoOAgEvRZ/yZVwN9kKY7zwT4ffIb9w6OWFIdaBmQlHwrFjU8fmuSGWW0XuoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4533

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
  selftests: mptcp: add ip_mptcp wrappers
  selftests: mptcp: new approach of getting ID
  selftests: mptcp: new approach of getting addr
  selftests: mptcp: wrapper for showing endpoints
  selftests: mptcp: implement set_flags wrapper
  selftests: mptcp: set ip_mptcp in command line

 .../testing/selftests/net/mptcp/mptcp_join.sh | 883 ++++++++++--------
 1 file changed, 511 insertions(+), 372 deletions(-)

--=20
2.31.1

