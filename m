Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE2DA2D
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 10:20:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MubmrTJZjF9g1vnz+o4RIW746Ba30xu+EAhYIJP3gCuMUOFpfqtOMN31b0RmuO5gVnXyvlm6ob4ior1/5zOv+OmbicElCW0vEBX8zcStJBBzf+60CUCyJwEVhTya9SwhJasYqxERAUqdEbzx99ux+gu6EXOCyj/Ib6QKoLoYRmVe/L0GV9mUkRVuGQuoYpeAWWCF3zkrgVQNxK7SEk29+iw8oHXU/9qWznx2+uGpYFOhFil7L4vraxWow9EJ+Ajl49Kxi980ZxrGlW0VGCQMdCoqJfXa57dz86uzxB489h/TFtHZxr4I+H4cjxqMitjYacqxfyjAD96rLwLHBKU+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeQuAjyrWta5XccKBx6BNq6hb1zxgfAdSBhpli+HfY4=;
 b=OnyYAv3eDl5mIsFW/YjJdjqKO5bwtKLdnQAcOOLy4xEfANR143/4xW1slP6pNx4/4Wz3xzxafnbhqsvTl1FoovD5nl4VeR5/1uZjg3y0nM+xtKOSErtuPGPK5bSsrxR31zg8oOeIIH5b8WmtzkyL3G2sMi0nq90e1+wh0pfAWDtjf1912fomyfTSmve6mrOlIiWOMnMza092zAamBeybPRrn6Rm0wo3ahziTS8lBkt26jjokQWGKsW4ctQHTGssdjoPxRMGtvg7D2u0swUpLclJFraUKEGoU2+3NHjKW2J0hARrCcZ9okbiZvRY1peWPb39kuCZxPaTjUuu5bD9bOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeQuAjyrWta5XccKBx6BNq6hb1zxgfAdSBhpli+HfY4=;
 b=p4ZhLdbt8/xPE4DD3HoQ47WHlpskIUKJcoYHqDy22MvWu7S0JN1XD7MrrYG8BqPZgWKpLtSeVkXRmCSXMLGF/fYtZTeg95B9VdAlAP5E9a77RwRzuuwCSYzjb9nL6pXzY+h89CxMiPe2DWf9bw3ALlLXB4wu1pk/3p70Pu7Thjy5y0zFpqUCj/4WUlG2W3hL6keJX/wYFr2F3R8Xp7MuFUtWvPuXQVrtOMFP1olbcpvzugXUHbdpGIPWtSZmpnrC0jGyettQk/ijyttQ2t9Wik5zfMs/oWYiyBWzKdzPLW+hMFsPrA49Eu8Ekfc88dh8hL5TeEH7bE5UuMVg0ONwOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8908.eurprd04.prod.outlook.com (2603:10a6:20b:40b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 10:20:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Thu, 4 May 2023
 10:20:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 00/12] update userspace pm mptcp_info fields
Date: Thu,  4 May 2023 18:20:05 +0800
Message-Id: <cover.1683195386.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:4:91::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c73b271-e42e-4e07-c9e4-08db4c892941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PBJdf4BUJa6MsSeIPNMNodZa3B753cOsxNw7ZX0stvPAhqtn/Phn/kmir3m81IBdHgdCFkxAwMJii+EXckFErFW3eFeCwxSBGerCGy5dxZksRaA3LDbNrJrSVEogizM+6OgxXsd1jihukEGgXftIdr0HaZXnzHg6wLsIQJ4d5xwCHUO0m2dihqWGVObu1xzPfIZMUkiX+zFeDnuMZEX+w8ZgoNVyng0oU+WnHwDauOX9r2NhsZWg2oPlm+hFyyaXejXIpzvQOmwnNvnjSagwjcA+eYjUIh1503foYRZY/DmwiQuYz3oheGrXHVCPoAYcBQNwajhQEY/+2mEcaIw/EjNeBFKf9yc3duChVvRUSmrKNLnBVhBbDLd49+ov+d4Cg+rHWO40tu/nV0oZeQncEu19uoa2t4daKAB+x8VKSFsYhLl1vxmBnIIFtlsGHcnmlkwIujBs6sWX//n0GlEhzv7htliXcXIsuWRcSFGhP0h8xDLIo8wfWRbVEO+Z50J3ntvev3gaz7B4FyABVgfGDbfJVrYKmHL9OODaGezihz9WB6Omtwa6Xdf+tiK974BI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(44832011)(5660300002)(8676002)(478600001)(38100700002)(8936002)(2616005)(6916009)(86362001)(15650500001)(6512007)(6506007)(26005)(6666004)(66476007)(66556008)(66946007)(107886003)(83380400001)(6486002)(4326008)(36756003)(316002)(186003)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S4pD/pE2jgfaQaSyHoet+6IBZO4/lj0JLMEdqDqJ2pwseA9yMU7MheltSl/1?=
 =?us-ascii?Q?IvHuVv3P0bS/Qj/waZg6EztWJZro7HUDisHiSL+cVRE5TSzdkKEN7+2KddEb?=
 =?us-ascii?Q?Q9rqgVaLt63x5Krn8jXsdvOISu6oXZDIAsiGXpYH64G3Dj26aisYzlsJNrAU?=
 =?us-ascii?Q?V3GEYsbnyVSpvwDv1VDRuqTQhe8QTkbaiJLth88oIiqHvhom/D3aF/RJJRYz?=
 =?us-ascii?Q?Y2UCMUY/4oPTn3l8iHDycgFk4q3H3BTp6Gcr0sm3ZTI4HS5cs20X1dad0fX5?=
 =?us-ascii?Q?0/c4JHDM4swhCktjpx7Hir0gJiU6nFItIlsnWHldQLSRePtuKNonATU5SgAs?=
 =?us-ascii?Q?Pn6zQ/OJcaiK/JZsEcFuJblt5sOvKK7BlVWRU3cl0RQUAlHWrwNJQroyEDQW?=
 =?us-ascii?Q?O2pLwyBOv2Y3Dv44LAY2oeOI0RNzqWdkZeVHFCBI6TSm3AK3oqQw7kGbPOkW?=
 =?us-ascii?Q?aNhLGsytVG5eT2CObuv7yaAx3lKsC5fY3ep/7sdmvBCR+ZvTJgWYaoGT7nbx?=
 =?us-ascii?Q?ldJjVfU0wxDNr5nOtQethRt0dyO4gERsXqISNDQ+1dpwBlrR9q7Jial4GK6E?=
 =?us-ascii?Q?gmFogRD4uS8d+g+x/r7C8oaD/ZlnjBeTAP59J2WRUoxPLpkab7Epy4pH6/u1?=
 =?us-ascii?Q?cd4f3TJ6cyNwF98PNSFPYtQmAUDI8BKBiXtPRvCeUUyUIlXQXlrOVue4tZy8?=
 =?us-ascii?Q?Ogd4BUrFb7v9waxFZfih51N8046ckWmid/4aoZo1hAlGG5Qya4O8ePOQdDTP?=
 =?us-ascii?Q?bGKywxTjWmxyuI12cefzwZxAopffFPQttPM4ghFMB1B8hnOV6JwrqU6SXIPl?=
 =?us-ascii?Q?lasyh4RKV+rbRgGvES6uQX2etgkzzFo0kphkeL6cti+ZyR4P2uusaYX/tSFm?=
 =?us-ascii?Q?+zQyowpAVAUFHA9OoVIigNYRzdtOwhHI8o3iX36u+ry1N9KS4PgOEQOcvPKr?=
 =?us-ascii?Q?VaxYPuYoPeS9mw6RMJO8BKL8vXfQfv7jxCaI5X1Aw5SIM3b+WHTjlsaSl272?=
 =?us-ascii?Q?/hq+kEgKkhTkF/2fKLsmx9XZ3hRUgLaxZI2GdXCwS8bQcIXkdgr1X5PJcB5g?=
 =?us-ascii?Q?nVA+wI0CoJuuU2ZyvvnanK0Q+vLYI6bEIgW8bcHqxNjsmIZA12fazU980E6L?=
 =?us-ascii?Q?ydRJ6i7QNvb4t5jZ+8wuceqltFCNwuunpJbYRkahDOHuu0yrLqkEb8OydYMT?=
 =?us-ascii?Q?E+I3u+TPzuyXpoGWCrpNH4Ow8yRxRd3U357Iu6nU0x6nnY3GjnFjjMbzPe2L?=
 =?us-ascii?Q?qY/qpKqB1PouR4D5NxHugIbExnYZTJVkrA5vq05P6r+k2IBuDCDlmqoTBxID?=
 =?us-ascii?Q?kCX5+zPgzgO8Szn0G4peU7+z8tmEJsyePdAlhXmb26TxziGEAZAw6bgew919?=
 =?us-ascii?Q?cVmXZItWwV0seo0UqUjIsJSAHnTb7SHFgNg6ZREU6GxVCv6RK4eY2ZYTrdB0?=
 =?us-ascii?Q?RXfVD9LPXNCitwyy9m67TcfWnKOFwAvFDPXh1Y5039LXQPTLyvFjHvCMKPh8?=
 =?us-ascii?Q?tIamjErhT4ZUnmWyuVsOQVwtGWXuav30K76OcJ0gn6HF749k2i1UtdngowPK?=
 =?us-ascii?Q?0yQrCS+zkijq/N4Lr/QYbRig0xAF20y6jL34a1Zf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c73b271-e42e-4e07-c9e4-08db4c892941
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 10:20:19.3395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZ6IJfSxXzfp4I5TWqbMDudLjOQa1kHN5z9p/CMlZxi8pysvKUS0po4XDCAUPFLIY0RN/URq4o5N7D4e+cKVrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8908

v11:
 - #1-#5 part 1, address Matt's comments in v10.
 - #6-#9 part 2, update pm mptcp_info
 - #10-#12 part 3, some cleanups.

v10:
 - fix userspace_pm.sh errors reported by CI.
 - fix the bug in mptcp_pm_remove_addrs in patch 1.
 - drop msk->pm.subflow == 1 in mptcp_userspace_pm_delete_local_addr in
   patch 3.
 - exchange the order of "pm_nl_ctl rem" and "pm_nl_ctl dsf" in patch 2
   and 6.
 - update the commit logs.

v9:
 - address Matt's commets in v8.

v8:
 - address Matt's comments.
 - split into two series, pt 2 will send later.

v7:
 - fix userspace_pm.sh errors reported by CI.
 - only remove addrs in mptcp_nl_cmd_remove().

v6:
 - send a RM ADDR from userspace.

v5:
 - fix a memleak error reported by CI.
 - add more delay for userspace pm tests.

v4:
 - add more patches
 - add selftests

v3:
 - update local_addr_used and add_addr_signaled

v2:
 - hold pm locks

Geliang Tang (12):
  mptcp: only send RM_ADDR in nl_cmd_remove
  selftests: mptcp: update userspace pm addr tests
  mptcp: export remove_anno_list_by_saddr
  mptcp: add addr into userspace pm list
  selftests: mptcp: update userspace pm subflow tests
  mptcp: update userspace pm infos
  selftests: mptcp: do userspace tests out of transfer
  selftests: mptcp: check subflows infos
  selftests: mptcp: check add_addr infos
  mptcp: pass addr to mptcp_pm_alloc_anno_list
  selftests: mptcp: pass fastclose to sflags
  selftests: mptcp: do endpoint manipulation out of transfer

 net/mptcp/pm.c                                |  21 +-
 net/mptcp/pm_netlink.c                        |  34 +-
 net/mptcp/pm_userspace.c                      |  60 +-
 net/mptcp/protocol.h                          |   5 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 629 ++++++++++--------
 5 files changed, 473 insertions(+), 276 deletions(-)

-- 
2.35.3

