Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70045.outbound.protection.outlook.com [40.107.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993767E3
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 09:11:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfBQ9JmWZD7n4mQtDYqdOk17CuTT/lEFuYGuvpsdq2ztatXLEe8Icssli+S1fNuN5KZPkRPbHr8Ti7tmKfR9lCvVruUWOeV4Yi/eIFSLSbMCGzkwid7/obsuaZKfTUfjMtWx6ow69pwqnF11gLjpf0eNHsGVbHXL+cBv7PGbCGpgqDBJDNuS56pbHTViUg4ZJCV5AvUldtCAFyi53Vv0EZjqaA60WpjHWD2kaF9konUeL43EfOrBWXlv0gevLBQe2cw4eZm8K5wGAUHRkjej6gNH1WPb8O8nqFdp+YRx9rvDL+laXhPd1yixt6vzXA1/iFNYqClit2fRvwb+1aPjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwOBqXH5lOiIU6xNkURvwOwmjxKSKk7ykLdqqT8xVKM=;
 b=Dicsha/lT0JQnViSVrjSNPeMT4gwPhg3EOmb5yuZSBMNnpS5e1FroJyLDdAc11ZWSMVcLO7Q7oNA5bAvKPgh8fjCYWxud43J/SjDYe04+4qQFcGP3JpbEWTtt83GRX+s6Vw2eTpL/yjycTX4o+5jyqvlwoI/88LlKYqz0Kfg1yCygaV2s8+6OzFI5At77tZ/iI7d18wYKJTNQ7V/OTZl/CS2GARMeuzuQ2jWI1O02KK/k69j3V3reMB0Lr00lQun8LFPR584Blb8Y8czki9pRgF05tDPVsskS/FvMsVile5C8o4f0eEwraISXM3XvV3u5Tk5ps7OPxyWD6LUHTkVrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwOBqXH5lOiIU6xNkURvwOwmjxKSKk7ykLdqqT8xVKM=;
 b=YuuOd/KEaxKzOOEJnvC4AkjIkozJ1aapuE8mEYtpt22C0NFWdzbq0kghH+sAGaYt3D8xPdjeEdoAwR/Qy1Ook3Opw35VunMPfm/OPbpmaevBQf5tdUai099wzFskoCK61IuWbOnBmz0R1m20M5z6WDkCma1U+cpPa5I28mOGaL+ow2l+m9iuLQEEA82syido7rOealZ2T+L2PMb5Oj/AdItBagrfngOfoIBPDMd9dcoLuMAXBtfb89YzX3OcElhY1FdNIMrFc+vMdg+lTE54fZsXXa9PWAImjz7tTSj+BqDBfjyueWeDaU9LGs5o5VXgF0RdzelWanDLu4ie0duQDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB5739.eurprd04.prod.outlook.com (2603:10a6:10:a5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 09:11:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5588.017; Fri, 9 Sep 2022
 09:11:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 0/5] BPF redundant scheduler
Date: Fri,  9 Sep 2022 17:11:31 +0800
Message-Id: <cover.1662714028.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6eda46e-207d-4ab4-e934-08da92433fed
X-MS-TrafficTypeDiagnostic: DB8PR04MB5739:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ggfaF7eYRnxOO7bMOWkNeYBHo6YMwxvHkAPFJO+P74OVW7lSo45y5uetRu/SjM3xNFD7rMYEIztE84RHQxT34Hqq1w/QHfiRVrgz+OsXljDmhY7LlFfIaiIxxhB8Jgs8IYvkhJttskzE1O8467mzsbWD/AD520YARQeVIjBIVTOdyfah6AfaRhbwn/hcpPdtyAXhFPs0E6Spf1+0BE/F/0lHx6epeuLDCBUcBQYrs3yardtzN7xkFtTpay1DFcw9VqnqQwZpsNlVusKmdDaXBg4rEZdDSmLW+SA2/kocTaj9wpr5rDG3O42EVi0RdB8aZ4qkTvyvVvkcTQtzT8Ioc8fREc7VRpecNTfQDFL5czxY5nn+UTc41WTPR3uiq6bYc4AhTY82rYvzqRkNk62NLNBfbItm5/yjr6TZRv/hkAhRdbls1Q6fXCd+tIMqAIfllnxvqBCmM5iMFGVicbs8GMVA3aYcExlPCoJz0USzW7LlP9dfJkiZuXcUPpkHvNJFO6w4IKY3IWIrQWNtezFFzNRyVUH68p+pEMuL/ZiZkKbrXEZ3Z4fxHFACg/4YH8uBtyvdzeqLh2WMiC5TDaPl2uG2z8TyebmIyEBpKzjYQ+t8DTuX7RabrOHH2lS4OzfB+o64NEndwDcWwHhIfOR2c3meqrzfEuEXp/1LQ6mdsgP984O6gJWqem6oBV0fVqhbsgYj6qAn0Ek+w5hQzkLPdl7FpnE90M5AgzHzz4b6ofaPe/ZJtBfgKb2h4rHRpn3TFbzOaqqjEmIAz4F5Uqzd2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(39860400002)(136003)(366004)(2906002)(8676002)(186003)(107886003)(5660300002)(38100700002)(41300700001)(6666004)(8936002)(2616005)(86362001)(4326008)(83380400001)(44832011)(66476007)(66946007)(66556008)(36756003)(478600001)(6486002)(6916009)(6506007)(6512007)(26005)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6QRBIAqJ/BqqbGHXlCTlJlkIqgE/api598KDk1WBi+OQNBoa0Vo2yYq0y3f5?=
 =?us-ascii?Q?qrIf4ImiWCkas03Pg/hFMrTraw0Mcp/rLCCkGtZbODVAb7qfdjhYwyYFPgrh?=
 =?us-ascii?Q?hjck3VTvUcYSpCikHCOoUX3TRq2fpJI/eR7qayQRdTYuzdor/ZiHw5HFWzt1?=
 =?us-ascii?Q?WhX0ZO38LD+Man6a5b4n28dX4ew5gj/fH2IjgWvo11gYyPD0+CJ2BfHLhi3K?=
 =?us-ascii?Q?9HH66wQnnEfRw9pO2RtyZsUWiEq9VBja+9uy4D/ACrAzyWdIkGF83onQ1txZ?=
 =?us-ascii?Q?6M2RhKODzeyewvsEhrk15oGTg6hJTYo5zd43DHZKK6+h/bwHDgT4/MA+B3K/?=
 =?us-ascii?Q?cEzhPA4c5FBfgB2qpKVkZpOA+Hn/n0RcgmONNKUCSI0XFRSQ3Lv7ganh99vC?=
 =?us-ascii?Q?K845nXGNDghsw8mYqP2qkfuo9Ol1u8HVQzKYPLj9IO33OA/wgjnMZmN8uiWt?=
 =?us-ascii?Q?cLg+4JLzx0weab7IfSFW09Mww99jQv7FFVbYmGIgQEmKG22tVkJamHmwjCY+?=
 =?us-ascii?Q?uSeRhTSjphuX8LidTva65jaKr4nNwRrQYWEZfAIavhBXRKlRn1u/TFcVoj/Q?=
 =?us-ascii?Q?B8MTQwAeihWmW7kGDOzEHpEahPCi5h0/IjLSv37hh/z8kUMSCisIk6r8K68V?=
 =?us-ascii?Q?M/cY7W7Q6Oi1XCZs9GM4QEe8DRx4jPeQn2eaxfYR8VvNlAj9TyWR614fXdvq?=
 =?us-ascii?Q?54/gOvLw2IbU2L31NYamFN+WDqj4U4qyq5+09TodTLP4Iq9esxvDzonWKTLC?=
 =?us-ascii?Q?SbLqVlcb5AR0dKy0niYg2AHOypx3RYOBFqOljeUmTbAl9sCwxaICRjc5uXCF?=
 =?us-ascii?Q?ghcEX1tb72ewU/dODkjh4tQl6y+J89Vu3tfXDbXA8I2Ul/Egc5t9mSBFINvF?=
 =?us-ascii?Q?Pi6bZ9WLQdc1TKDhGh7bHrbd+R3wmX12shawEAtPUdEgHZjUkDagVdRbDru9?=
 =?us-ascii?Q?B4QgLvRquhGLr2uqXFuwCLPjvVY5ggQq6UXgBF4Bw/o0Y7Zud+I3xC0yKP+d?=
 =?us-ascii?Q?REVsnmM4vV1Iztta1IEG7Xpinld2Q8tQ8JsWLxxY4fV/TvaFSgcZvhOET6G7?=
 =?us-ascii?Q?OWsQ/AsVaxZiuWqToNppASps2WGmCO4LJVdj2CX8vmifTksCeEjeLkGk8bz5?=
 =?us-ascii?Q?vjXBtg5XvlWEUmlSPccsHP8nhx71e8T4r4G3NTf2vjlpFKRIx1DfF3u/nGp7?=
 =?us-ascii?Q?cjUQcVUzIqTTV1va+X1lZLOjEe+h0PTeD+K96hkEXU9I4BAB5mVvrlPXAQpF?=
 =?us-ascii?Q?S09xUctRflBp5zy1AWXoHrJK6KzwWMbYLaoVnT98tIOFOgrRUDhi8Ve+JC4N?=
 =?us-ascii?Q?0LhMOOyq6vuOMfuy50wi3MMKo2RjN6GOlZvDyPKQfj0nwx8JC25lPDLIOB9i?=
 =?us-ascii?Q?+6pV3TRuy54pnJ7urHYbN98NZfEMm3fk7gsq3GNb1mfaB5J6mV98aUUUm+Gl?=
 =?us-ascii?Q?yOVs4tE7HqkW3iap5y7fclcwxSEwGaLgj0VN3WRijwoRCNIgG/RwlW/F0F/T?=
 =?us-ascii?Q?F72WPgmHnwNIZ5a8G+4eUbRipkv5wCCydnSrARJ1F+S8N7nlZmWcEOPiK9iX?=
 =?us-ascii?Q?B3ZqOwEmz9wzMkM7hI0gyBaPLl+DZDMVaWA775Ny?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6eda46e-207d-4ab4-e934-08da92433fed
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 09:11:16.3272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hvk2GwOMaF3Tt2owjYvHGKPuMnIUTS3GDeS3IjtWRkJQkhcjf/1obEgDjUfodkFlrh91nOiIN/Sdqsu7U2AA8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5739

v11:
 - address to Mat's comments in v10.
 - rebase to export/20220908T063452

v10:
 - send multiple dfrags in __mptcp_push_pending().

v9:
 - drop the extra *err paramenter of mptcp_sched_get_send() as Florian
   suggested.

v8:
 - update __mptcp_push_pending(), send the same data on each subflow.
 - update __mptcp_retrans, track the max sent data.
 = add a new patch.

v7:
 - drop redundant flag in v6
 - drop __mptcp_subflows_push_pending in v6
 - update redundant subflows support in __mptcp_push_pending
 - update redundant subflows support in __mptcp_retrans

v6:
 - Add redundant flag for struct mptcp_sched_ops.
 - add a dedicated function __mptcp_subflows_push_pending() to deal with
   redundat subflows push pending.

v5:
 - address to Paolo's comment, keep the optimization to
mptcp_subflow_get_send() for the non eBPF case.
 - merge mptcp_sched_get_send() and __mptcp_sched_get_send() in v4 into one.
 - depends on "cleanups for bpf sched selftests".

v4:
 - small cleanups in patch 1, 2.
 - add TODO in patch 3.
 - rebase patch 5 on 'cleanups for bpf sched selftests'.

v3:
 - use new API.
 - fix the link failure tests issue mentioned in ("https://patchwork.kernel.org/project/mptcp/cover/cover.1653033459.git.geliang.tang@suse.com/").

v2:
 - add MPTCP_SUBFLOWS_MAX limit to avoid infinite loops when the
   scheduler always sets call_again to true.
 - track the largest copied amount.
 - deal with __mptcp_subflow_push_pending() and the retransmit loop.
 - depends on "BPF round-robin scheduler" v14.

v1:

Implements the redundant BPF MPTCP scheduler, which sends all packets
redundantly on all available subflows.

Geliang Tang (5):
  Squash to "mptcp: add get_subflow wrappers"
  mptcp: redundant subflows push pending
  mptcp: redundant subflows retrans support
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 net/mptcp/protocol.c                          | 158 +++++++++++-------
 net/mptcp/protocol.h                          |  12 +-
 net/mptcp/sched.c                             |  59 ++++---
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 ++++
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  36 ++++
 5 files changed, 209 insertions(+), 90 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3

