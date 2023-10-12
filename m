Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9020E208AC
	for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cVz4UrPX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KP2u2h9mGK3pxhAXE1W67Cym4V/daKgX4a4CoU1NXcrQt2qjYKQaJQHbi0dGr5NIQPnshndi0Goi/WtRbEMaeJMZYY60scds+hZT2+DlPFPsgpcdDvhw8ZucKZsG8imA2a3WvORUK+3oytmgT2NHQILTio6J2vGDEw+tK9GKjpH9j4sDkSqrtf2YDry5ozRsFwsExaJZ9+wm/Jrm35PJM8+94Crs9cdGeawAyi9BtJCswAUAbcWgKFA4REwZLergmMarUQ0JYwHggRVevL4BKds+QJS5PFuxJQBUoknAbNzoA3DAjB05Y0iFMWKvl21lk3ZWg7fJTJUSf5EsuIKiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5AKZv4OnHbcMT/oojECoEUwRwGo+EgYpLEXXaBrEMc=;
 b=cslKhWPdxtl3TjDRkCWaHjLfV9ys89vRbQkPOS1xx4yAUvCE9lPWLDg5QmfV5Yciw3aSX/LBTLjPmaFJbxsKjLlb8Sh2MulEBWxIowHTIW6OgA4XOsdLYEu7KcrHvKaPn2lXu3q3+hrzvAda0gEPsbu48jImFEGpjMzfTs0LhC0r6eims5ANlI5EdLw36bErKxbt+lbywd4060GREDel625tHiSIgBhLjTa5F7Hnq5Nd5gx/EWgkfcOoPVhp+KwM79/uQpl41K7DGtHXweNwiLlxua5HHUExYlOVLbEvtOwa8z/wpIK/gtlChC6WuWxEj1Wy6zJ6T/sLsw0bN8Uldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5AKZv4OnHbcMT/oojECoEUwRwGo+EgYpLEXXaBrEMc=;
 b=cVz4UrPXBxtcaHx6UJ6Va09copK951GAdQHuUEdhZSc8ks8+5Dq4NJ19bis385M/Qpide8SdTrfhdFm2jiXk3mp3+McOsw0/ZGuEIPPCNUuu2vAiSJhTvY+YpWq7XuyrCs/xFeCh3GQrAEC2V0CSjcrx6Fa8bgjV7hrXjHUp6YazDGM1a/tdkXwtxK63LAUkZG+YOIvMX7Lj5c1e//DTNnUAbEw8mYjxMCn91X2DhbbF+zzv5C56M54CbPLhScviESCtGJfxGgqCxFcpRuD9R1D0UaDZpsjJ0qbd1ds+B6GB9Kw7EUhTahL8Ky+i99tevkKA5Oq7Xg4hrU5EgVs/1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7212.eurprd04.prod.outlook.com (2603:10a6:102:8c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 08:50:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 08:50:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 0/7] userspace pm remove id 0 subflow & address
Date: Thu, 12 Oct 2023 16:51:58 +0800
Message-Id: <cover.1697100600.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0021.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: d2398272-0bd3-4088-765f-08dbcb0058b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	90EsqgMXRgNIspp5tGdwsPugclaomPhunnzobHXbRIFeRymIW2Il73Pd2HfewLjHk7SCimFBFKCWDGz8a9elOu5t29h0HlrN57HvnhxEilBNM5pqOEEImYXuMkfv8kqY3gXlvzpA4iXE5LVVtX3JqGaegtQB26nMtsLgW90Ow8xFCu3BOrUZ/sO7VO8yY3c1R1PvHXt1xmZZqBwzAC76kU3QmZuozG92U902wIdxM07K/N0c9UjkxJTKIt8GjBh+mUWFGZOo6xkuMKiMybg6cugAY5WadUaNhOpwsRk4w0PO5xxh8LtKETPyiqx+U91fnCCCggdWnHjlAxjRaySqhHGr6KXFMuHGhm3r96SIdytjHAatOZY7BOXgchKGLZY8IuAYciWF4c4TFiLmNAjZ5lncBuFNDQEd0hi9GM4MWg79vdR2k+Yr+MtmfqO1v49tsp0GDmCzziTRx8BZ5iypDzb5HuGsbyvJs2ZKVGUjMiC50bXvfaxN7YwnWxodICX4tCbGY7k2Rc06FwjVatDTNrpaJAFB6/5AxFOpd6AnqYCyX4Kbj3CnXgw8hJhQTsmy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(83380400001)(2906002)(4744005)(36756003)(86362001)(38100700002)(44832011)(5660300002)(8936002)(8676002)(4326008)(66556008)(66946007)(66476007)(316002)(6916009)(6506007)(6512007)(41300700001)(6486002)(107886003)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2v6FkBqpI4qseWYtjNYdxlxfyLIAS7n+2LP1n9OL6sFLVJaqM0Ux1LyOF/wm?=
 =?us-ascii?Q?skNNYaqXZsVWDU5T1Ll65iR9RwJbXhDYRXgVWvwUPkK/SmT+oXFE3kwO2D0Y?=
 =?us-ascii?Q?EsYosuIx+tFIC+6kzyiROa4Nldm/TDXnKYHNXPOHDqUdsfnYHPFjV+8DnzSL?=
 =?us-ascii?Q?qaphDlC8CGUHhXOEPN6vusxulMb84EObMQQH86YJqxBsKzb75txi+3qtYOZ8?=
 =?us-ascii?Q?2rkY6kI5/UKr2KnQxTCBm7zZPh9gonkZ+F0oG8hTJK8kQXxlGV52UcELJrJ/?=
 =?us-ascii?Q?q3Clo7eMksyVG1dnvSC0jMKw9eDi8HnjZ8fP8ufPL8aQO93ZDgEnjKkExq1j?=
 =?us-ascii?Q?bvb8jyS7tC7fY2CaEJPv2ZGG75y8BxJG1UYm3uyDHZhYIeSDCaGD0U2yt3PC?=
 =?us-ascii?Q?SzI/XNCga4BpN7Th4OrBepcdRAHFbQt0+404h55GnMvj0yw/bwWYy4q/XjqH?=
 =?us-ascii?Q?cYtaSQngTVXImgCqrxGAz/vgJWQfyYRJ8rijgHLyNl6tYOoOA8P62GXdG5QT?=
 =?us-ascii?Q?TdttY6X77xAv7x+Y57JT7A1z36EszQ3IYZkOyHaJfnEvOVNvPJ1eWQtZrCae?=
 =?us-ascii?Q?arxmGmYGzZs2GmHwkKEZzYyrqVthBparVnY+lYS+cViXQQOO74zKOpWv90jn?=
 =?us-ascii?Q?NS6E0zr2RgT/S+20rj+uO0UXX0W4V8wx9qdxMTuJIjk8qfjFR4JsMc7rHp6M?=
 =?us-ascii?Q?hec4ALSRH466VUHXGQapWviqDMWATwF1aVwlcuNzr4PROTBXgMreSJDvYxm1?=
 =?us-ascii?Q?+/SFvSQJTDBjnELb9UCje7gmP0THqwgEG8xNDfnNICIm74D5TFknBk6RR9sz?=
 =?us-ascii?Q?IiWAJQ+0lluMwD25uo+ImaU6Kp7Jz/oncYuJNb1TPzXTpFSKtTs7sco5fK0K?=
 =?us-ascii?Q?BBrJk4R666bwZ9nssL7JcpFoZYzhszGTVLPl0xcRzr9oObkxKOCm9Cn0poYi?=
 =?us-ascii?Q?0ExS2v5MpQh/tW2OdS7WJ2696ARsdpJDmOh1hzDgXa9EdD88Lk6N46WBv1xa?=
 =?us-ascii?Q?0JOEwGTuDe5UX2lnLW4aK/0jYn97GQZkDjuQdf4ENJ1/B75m4gYYZpbPu+Bx?=
 =?us-ascii?Q?EkQBrnZbbnUZqVlPT9WAu8UhHhGaspYVJVhBoPOwdl64Ilr6gxfn7/ihWGfX?=
 =?us-ascii?Q?E+pYFo3faUwm1eJOQz3wOj1Y9jC8XQO+abAdPMJeSjMMUjKsqAfrv8FjOSN+?=
 =?us-ascii?Q?y67EUgvITpXu+fIhj3dBE/2wAPq0fZCk4icNGMf9H6aZyyrFp4+Jsij4KAuQ?=
 =?us-ascii?Q?PyYAnqjGXu/pnB7o1Tgb5AFBsoCwUIUHqd4wcnYn2FMB7Q9VduLRxA1v4njn?=
 =?us-ascii?Q?+D1z42fNa+mttNV2YKoP/JbC4T6oxI339SFir4FPBRHu9G6Z7L+HJn8yGgT2?=
 =?us-ascii?Q?iaL9MUIfGb+paL3Xf56xe5KO+YiQpCgG0Lg7Zk3EktR8pBgEcXUYqF5CirPr?=
 =?us-ascii?Q?l+m+EZyTkIQd1oavKiSZ0CwlA8chroN7KeZtwx/II/qUzvmHIurCubEh+ioC?=
 =?us-ascii?Q?fYnTPY7CAM2HHwAn5YjxtPm7zVf0070RBwv7hdvbV1tdOgrRjiWoVxhJ3XaO?=
 =?us-ascii?Q?fEOENevsFyMjW6mWWEOlhrcdjxj4Hjb1k1mfIRLtrN6x+uBjfdB9DJHsyIg7?=
 =?us-ascii?Q?+bTgZB7/NQ6E8lwM0wqhh+rrlEIlKYCbd1RzcphAwO6I?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2398272-0bd3-4088-765f-08dbcb0058b2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 08:50:55.4236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aw1927rwDB7H+cyBTdS9dd7NveXOfSgaXRTbMcvFd3eleLOI79+5M+q4UqXjURmJpxnyrZn7psyVskSPMPuFIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7212

v15:
 - update __mptcp_has_initial_subflow
 - address Matt's comments in v14.

v14:
 - reuse MPTCP_CF_FASTCLOSE flag.
 - use tcp_shutdown instead of mptcp_subflow_shutdown.

v13:
 - invoke mptcp_subflow_shutdown() in patch 1 as Paolo suggested.

v12:
 - address Matt's comments in v11.

v11:
 - avoid sending RSTs.
 - rename 'id 0 subflow' to 'inital subflow'.

Geliang Tang (6):
  mptcp: add __mptcp_subflow_disconnect helper
  Squash to "mptcp: add mptcpi_subflows_total counter"
  selftests: mptcp: userspace pm remove initial subflow
  mptcp: userspace pm send RM_ADDR for ID 0
  mptcp: userspace pm rename remove_err to out
  selftests: mptcp: userspace pm send RM_ADDR for ID 0

Matthieu Baerts (1):
  selftests: mptcp: join: no RST when rm subflow/addr

 net/mptcp/pm_userspace.c                      | 45 +++++++++++-
 net/mptcp/protocol.c                          | 28 ++++++--
 net/mptcp/protocol.h                          |  3 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 68 +++++++++++++++++++
 4 files changed, 134 insertions(+), 10 deletions(-)

-- 
2.35.3

