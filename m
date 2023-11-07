Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5175FDDD7
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Scbg9vjd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyMtKj0T/GQoZKXRJYCEi2enQ+rzlaHKQ9ewPR6a/we5kL2TrYakZvgvRWwfcCu9QM11JJAKXVQwD3uKGQEXhD04RYsCZ5iLi3H/69rkvPtrqmP8nZeIuj7GgLozj/QnpNXQqdXArWZ299D1p8OoyTNm7KKwtj5QvG0hHvFSyLABzn1OHZVOdKe6HOYYNHSS+XAIp1O8Y5VpLMeBcDzIUU8wK64/PV9OKKBEFIyYuzswRguCXLQIWTjOpB1BQdsP1M3nX0E1g1WV5776QtVME55IFrvBnmSraSjVJwCHVdFNaRxaWm/dQFQf2ELj3Ome9iWYpMlxhqcObAnAxh3K7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3u6vMCIzr3CB3JJjxmqLJZR/JIscDvZeEiu/dJ77244=;
 b=At+798CyAmYVbEwP//TqjOY/CTdy/MBrSifkqRt1GS44lbl4k7yGgCshuzGvkvSAnLJs0+jKEf87L9tY1IXDzHHCfUKCKJxBtJedAc2EJYrNFF39DWisy0Eh5UPrsnv2l6YCUqh7+ZIarkVDxXuPt+UM7IWTUrLG7aaz9WqsVwI2swHSnjM3nmSggEwtjAA5FiJWyBdtonA46ctlBg6apXJbm7RXd82ULTK9fGGdgS6cF9wPjxfCRYtz3iAYa0lt4ZO1CHHVKYHFBtJl3uobqUY1Nw8haq3ayt+5KkwHGKf7faK0Ii376aTqHlutIkntzwtPY2T1GH3Pjne6zI7V/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3u6vMCIzr3CB3JJjxmqLJZR/JIscDvZeEiu/dJ77244=;
 b=Scbg9vjdquJ8Kxjc/DyURkXqgODGUPPhVJl2AMmFPrZekB2JeAvTSyjIlUB8t+feDldwGifKs/S1LhdsrYJsOhwa5MX6otiVill4XBpl94TurV3ygFGH/KrXSvqSaVnuuhrm2g5lT4TgZJ+K395DveekRlQBDKYEgLTgcbXFujUghEBwYsNOX9u3xckQXmdJVR9HCyXR4j7zRN8kyrklJAdj5uqWyn9bQsY6sALrNSelM2iIqHuYFTe4AKSA2rcjZlVq0OYFmGyhQp/6MmvbRVjvnj+2rylZsqM9RhJEpw0sSb0Ti+nZJG02IcwFVtY9cpqNVd19WCZ0qc4LR+65Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 08:14:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:14:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 00/20] userspace pm enhancements
Date: Tue,  7 Nov 2023 16:14:06 +0800
Message-Id: <cover.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a31648-3331-4d68-82d0-08dbdf698c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lqDXWMiGyrDBGAJlzWGsRi25FL9kfwBSzZKbeA0FItwTNcHBxTUuWqSkbw/SXl7TNijSQ6OJDEegFba2wzsDcUrmIT40qXRXrRV41pw0kQ1HQnk/LieoyaUAvh2TXq9cef7lwJF9kB/LXCsaZWD2gAtHYyOzWhd/Xxj1ciRVeXhB2EYacIkqPYEoFb4tWl6clW065xlDu4Txrdqn3Kz+N6WNtAfE+u5g3K5ZCMoX5y4WaoVLFviz2jZmkkATjBK5y1PQz8xA1ctyZ+KF4YOIPP4lTVwDJhRIoJl9uJeDN0eJKsEtFlBPyV8p2I9d0sKiB48C8haoC1c6/cjcm8rq39JoEpd5XYsfwaHb4xD/XuTEdY57PB071Khxl5cjuSsF1PLcnev6iOmlHR/GkhSASM6IazigD+Czi+EzqvvYKnWIOPgGVkbK8dR4nD4HDY34gVa+Q7RKVbJ4dI5Zwc+RabkP895eTk5nlf7d7wRH4GDiNyuDn6y+4qQGdyldO/BkQ54piI/Jlk0Ryryd6AmxWer2UEwfj0e+EIuUyCBA+lKx/gPQ95luHyPJ0elWtEuc+Tg/MwW1b46xG89OoS2rJOv6wb9/vgW0cZnmf3lnsL5uodYw/zAE+iTl+2wK6XKI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799009)(186009)(64100799003)(26005)(2906002)(83380400001)(41300700001)(38100700002)(8936002)(478600001)(4326008)(6666004)(6486002)(86362001)(44832011)(8676002)(66556008)(66946007)(6916009)(316002)(66476007)(107886003)(2616005)(5660300002)(6506007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7DZtOYYgb0RI+3M28aFmIGMp4YxRfhwl4QuyloZ6w5JI8o7XGqgpuqKG0Rrs?=
 =?us-ascii?Q?WMOcfOpXTY9Eqml1fnCs125Jo/E1kpgWrC5Xj/qzwCPVWvAk0WpttBtmxLnw?=
 =?us-ascii?Q?jXauhHoiRYFCHqAt0imwt76nYUs7BFIr4WnNJFxPIsBE3B+K1K7JZdRjnf9R?=
 =?us-ascii?Q?LpOGzwYmAXUfFZgDSoZE98K8Fbt8TA/4Jyqdv5NqrLIB/q5Kf2XpEu9tKj+d?=
 =?us-ascii?Q?HafUuLFvs6vxZkUuhzQyRJHGarFbhfHIfJUCRNbWLcKW4b+dhuMEjW3/ql/A?=
 =?us-ascii?Q?qSXcFIhHtossCmYX7kIFN5HS2tG1wfBIe43nT3YIF3ChisESZNe1xydGHNEe?=
 =?us-ascii?Q?vobVOOQFCe+ld9/zOGdISDDAtPtgN2J9aRIo/oybZwm4SafHfX9FGRmqJCvJ?=
 =?us-ascii?Q?fr4rRJB2aVCkID7qEYrmqS/PiyRCLA9JJlJy3Qc1ilR0RgSs8Fl/SXfYjsS8?=
 =?us-ascii?Q?q33EE3zuNsRwl4rQUHQGngpgq137jsre/gJS1SgbBryg+zsU9RuIOV0qCC62?=
 =?us-ascii?Q?b1KFaUV5LR7lyxPRj4fiJfHbMoIsMHcPmMc818+ImUDvVPx//K8sNbFtV0LP?=
 =?us-ascii?Q?Yck0LOe/f0uKzVZ7Ow1fjsD4P72Z1/Ouwvrk7Ix2XpCirJN38d3tM5ZdGm20?=
 =?us-ascii?Q?pOkGMV50OIG7UFAPX4tUC7KZXVjVORLgiCtiRFuTfbPVI+6PBXRtTPGhA4Qf?=
 =?us-ascii?Q?ITH+EkdUcoeeriKMLd8V4mUeg+E7iBuvyimN7yFIVaj3GQq5h5mgnX/u2Ejt?=
 =?us-ascii?Q?Nf2lWmBZkcvsmGdQMFwP2ltp331GzIw9mjK2M3NbKAyw22/lboqmpeUDGPig?=
 =?us-ascii?Q?0sacJik3HKUGfZIOk9lSsaxvfGOcoO6dylRrJ5CTwPmrGrHrCNNC/PkG6/Ay?=
 =?us-ascii?Q?0Xf5OBxkGJRTLwfEtynqd0CpQHRfhkRk++7j/SUlGjF/Q34LRN1ZMdZkasq8?=
 =?us-ascii?Q?aHX8EuIZTrvS3EtBs8Aos/FovXZ0KyEKtzJYSB1NmC9rPlxbkonv0KXM0FEV?=
 =?us-ascii?Q?7zPZuwmsj6yp2JavFsF6M3fxMQe33OGb8l439t0sYLGHx8dm7RO9/ycfKac2?=
 =?us-ascii?Q?C5advbpg5Niv2MYE4qciWDUURqONRZriS7QKiDodjhuXvHvIkXW1yP7qeCXq?=
 =?us-ascii?Q?09+7Bdo4aIRXpmXnpkD5eB4vhbhXxeGSGLz0dYJiNVRNPD2LXm0lU3N9AWLK?=
 =?us-ascii?Q?U/QmOwQEOTff/UjlnBC2yFsEUJqW/uhHKycHdtFd7hAKnwQLJRz4LLPHuaSA?=
 =?us-ascii?Q?51lKXN0uV+eQqgKoauVzUugPUTqALt88ukKnqa+5v9FgZKyEyBX0sWR3Jiu8?=
 =?us-ascii?Q?Sv6pALaZiz4fDAvs373Hjwahb3FEVZCQcaUPVGmS908rgYBofjsPnHY/hgUa?=
 =?us-ascii?Q?IvTOYzhHBi/lUAAjBAYOi06OdWgHTm3FvTYn9+6PuatHKU5HSK3nsWwPaAWw?=
 =?us-ascii?Q?/DkpKJ7JhzGZPxrHIMHlNLULieYEq4NoSeQf4jsH3Wda1vY+pZF6t4Jq9FKh?=
 =?us-ascii?Q?3SYYY1K/2YXWr57qrh4sEJQrz/1FfNxz051Bh5PMPg6+4TqQS82K2n4oxvrJ?=
 =?us-ascii?Q?nyJ1UsPglaUbCUsY69J0oP1dpNuV5OHnKs+MNDvW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a31648-3331-4d68-82d0-08dbdf698c08
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:14:21.9593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aONQ5tB3pxi9zMDgi02k7NrPrXCEBROMfe63Jtk+XPvsX01T/Fs0DGua2QwsmB0M+B4OJihlm9Y3QFxJ88UTcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663

v6:
 - fix kmemleak errors reported by CI.
 - drop a patch "mptcp: add netlink pm addr entry refcount".

v5:
- Put the two series "add flush and dump for userspace" and
 "add refcount for address entry" together for better CI testing.

Patches 1-12: add flush and dump for userspace

v4:
 - fix the deadlock issue in v3 reported by CI.

v3:
 - fix warnings reported by CI.
 - get id_bitmap using pm_nl_get_pernet_from_msk.

v2:
 - add two patches: "mptcp: check userspace pm subflow flag"
                    "selftests: mptcp: add userspace pm subflow flag"

This series adds flush and dump commands support for userspace pm.

Patches 13-21: add refcount for address entry

v4:
 - move two patches here from "add flush and dump for userspace pm":
  mptcp: add userspace_pm_get_entry helper
  mptcp: drop addr_match and id_match

v3:
 - add four selftests patches:
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: add mptcp_lib_init_ns

v2:
 - rebased with "add flush and dump for userspace pm" series.

Add refcount for address entry.

Geliang Tang (20):
  mptcp: export pm_nl_get_pernet_from_msk
  mptcp: drop mptcp_pm_get_* helpers
  mptcp: use pernet id_bitmap in userspace pm
  mptcp: add a prefix for free_local_addr_list
  mptcp: flush userspace pm addrs list
  mptcp: add userspace_pm_lookup_addr_by_id helper
  mptcp: drop lookup_by_id parameter in lookup_addr
  mptcp: dump userspace pm addrs
  mptcp: check userspace pm subflow flag
  selftests: mptcp: add userspace pm subflow flag
  selftests: mptcp: add mptcp_lib_evts_* helpers
  selftests: mptcp: flush and dump userspace addrs list
  mptcp: add use_id parameter for addresses_equal
  mptcp: add check_id for lookup_anno_list_by_saddr
  mptcp: add userspace_pm_get_entry helper
  mptcp: drop addr_match and id_match
  mptcp: dup an entry when removing it
  mptcp: add userspace pm addr entry refcount
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: rm userspace addr with random order

 net/mptcp/pm.c                                |  16 +-
 net/mptcp/pm_netlink.c                        | 129 +++++--------
 net/mptcp/pm_userspace.c                      | 181 +++++++++++++-----
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |  38 +++-
 net/mptcp/sockopt.c                           |   9 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  83 ++++----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  70 +++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |   8 +
 .../selftests/net/mptcp/userspace_pm.sh       |  91 ++++-----
 10 files changed, 372 insertions(+), 255 deletions(-)

-- 
2.35.3

