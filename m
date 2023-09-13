Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01137A45
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 06:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wez1hwfAMGGB4waoRHtw+YtZ9ivVykb/VNNRR2ch/sm7ePqun8uJz89KnC5pvcrhPw+nVYTYI+kELVyAP5wCnxZlPD9KebppkJjWoXh751zCRuZxy+ySKy/wQnH+wJFYrXaYdJ8jxkwFQmeKPoY7WUHafHNcFXPDDMjBzPCgU6+t1NULSZt2mDPGbEycX9OYxixSfEvixuDjjsc9MOvJ+svVxkraSINvj3IRMz3yAO6xxUwvDs5pEoGc0JWlGNoq3ZqqmPA35fbawlqXdVyaxK5ZR2+Hl5mZxMiC8OeTeno0QF9bPm4R0HEqsCBF7TloHz5uE6d0ll1max7K86aWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8UC8vy8HxN0a3+L4s/V5NIejSZJHmg6HKwyEUt5OR4=;
 b=KD8M8OrV6xClV+bhuAgHC/pH7uiK3hnDAHkwB43Ysz32Bmo4AkMS2k/jJdhk/BB3xHBFysyGlOvOi70lnTpbGgZwlqDbh91c5xdt3Vputp+DpmWP/PueTutmzIcEv8oYFBRIW5uDkIRPTP0o+O+mhS+C2guAKquKjRZWpiFCefnFQCXVGH1K5Bn8i84Ng4Lh7iRS/5UV5Lw/YxK29KCzgTeOwDHuJWfWHwdBE5MIjbZoBQoQOVlnhCKbuDIUhKvQ4IG6l8ztaWumAknwUeePzYJW3dtPVsWKbQbJeKLO5YWzyUxYqey9jRTjS32OOC+Omj3D4NTnRzwHQ6y9p+m16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8UC8vy8HxN0a3+L4s/V5NIejSZJHmg6HKwyEUt5OR4=;
 b=5sp3ybgyFn73KvIzWpB/IMHdWPrA66wUn+lWl0rGjvi8AwiGXgHI9PJHXy0qKXk+kJ9gTTHUz7DLpOYsdKfL8AKZ+wEhKOBQ+GxpY0trvNpB/lb+T7VRMiWS8z+QDCTAyApq6je42WKSPbnyiZMA7ggDW++jukcsE8hQq5x1AeZeDHEu9Ut8i5e1bUgBlb8nx4KUSP5qJ7wXbaxpp8TpM92TZsHVHpCfY/5mGRLmNWxv7q3E5RWfFiZ2dbsXkb49qTnOEoP48rnj9F7m0UxxFeOCPCFDuLS6/sVS9904Z7fso7wqzdL3Ng5mdYQjXCLopDa1fJYyacpod4/i2qez8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8063.eurprd04.prod.outlook.com (2603:10a6:102:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Wed, 13 Sep
 2023 06:04:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 06:04:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 00/13] userspace pm enhancements
Date: Wed, 13 Sep 2023 14:04:48 +0800
Message-Id: <cover.1694584681.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0099.apcprd02.prod.outlook.com
 (2603:1096:4:92::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e07e352-af9e-4d36-5654-08dbb41f4263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	purbvyMxiSHovXvmaHRGQyWHec9Qfo+6HDhDv4Xt9oLMA1aoUnrzTOrtWWpupTTInlRW4Q9JDzxtpOO5Si+rQOkK//XAcpyajM+Ak4w7eeAJUBW/x3CKHADDtw4Xo1t9cTGHAVQ7Q4DXn76sKfMHsmgjMiOjoInxVrVhkifOEummGAL7D0LQEXNapSJl/J07fE/k3T3l3HLSQeeBaqePAg7zxHiA2VuFnos7HAX/uPV/x+gGiiy3ATai+Hnf6FZu40geJlqS+8VTrzHpfAWChDnkZ6SBE0IWz+RiAPebbdhhrt802jym4O+k7gxrJmxY46pA9mruer9yVa1JqTwNihT5RSaAD7gq3q0npCEtaYnqUTQgxSQcZ6iMn2gLq2Zwn6BosSdkuzwx2meUdu2aitm0K+owfNMZVDNOhoO+j1zAd2ZUo4DBQDBC1i6oguklL04KVU1Ns9SsfjDZfVmWzZv91kioDg8X8BEx9IPNVQWcIPOmEX5N8bXtp/ju6KmGWg0++8XfRs9gj6EG52pckOsfZGwwmnVN3XSFDEw7g9qV+U/+dw1BMx5Z2qHGLWk7er0FE/DWIpkUsB6WwTnBHqQLuyseU7LfwhLw19aWCY0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(1800799009)(186009)(451199024)(316002)(6486002)(6506007)(6666004)(966005)(38100700002)(86362001)(36756003)(2906002)(26005)(6512007)(107886003)(478600001)(2616005)(41300700001)(5660300002)(83380400001)(4326008)(8936002)(8676002)(6916009)(66946007)(44832011)(66476007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5vgcZyMYFqPfaUD+KuehU7qC6JdupnVa3OvdDrA1GlLyZyXR3uQhp3kyIAbI?=
 =?us-ascii?Q?JFIqIrVbCTcWVXfe7Aq0ohEbxYuqtcXdmU7WcNa/IEN+Du24qkGxleD3kVS3?=
 =?us-ascii?Q?HzLwfmEI9WjG80TqyQBmNSdjKoK+SAV416vr0ousYTM5ng7oCBm31ZuSW2eh?=
 =?us-ascii?Q?uagfgWu6gatfuoxA2z76OkPkd8gUobP9S6fEt4MfKaAUfZIZKCIwJnFUjJLl?=
 =?us-ascii?Q?lEYTAoe3J6DQqFLY2ogrLpKh8pgk6E7WbZ6f7NYtqdGvVytyTv4l0EHtCjlE?=
 =?us-ascii?Q?0GC/apiynpOxvnejuLTGNqppILPNpPkGYwV2l1gIglwVq54TsS5TccK4I3bL?=
 =?us-ascii?Q?DIf6J2+Jz+ahbBPsp2Xh3M8AyrPZ8A+V2JICLWOtewzgKnbR2DnHQc1SJ7Wx?=
 =?us-ascii?Q?yKUyC3vufMy9anWMV50YkIhlJSi9V6afOikmu4rygQT42y230mp+ifsSpND4?=
 =?us-ascii?Q?dPj2wvJtCAYgWrUV2OK+D1Q8ZYynPPN+TcrUKfxHJ5uSkxZT/8eHQr8Idg7G?=
 =?us-ascii?Q?sFsHVSJsdSIANOdMtsvZXbUUWNTjVBqcz2zX4ohhk8yp7F6g07LFS1kVfrv1?=
 =?us-ascii?Q?UxJ8bBo5wZqFkczgQopwrFjc8HA4R5E3u0sxalO5IPsMNXOnM9Mk24gXtA9l?=
 =?us-ascii?Q?EFJYtwQn+BK/CyfG6kWXGYLtKvbxC0UpzznzeTegr+6oCIgbecKE/jRRojCX?=
 =?us-ascii?Q?sums9H4+bPu8yihW0+4u1jLEBv+CVRpJpwQ2H7HnCpSDq/1FJiA1dIDhjaFD?=
 =?us-ascii?Q?2B6QqfeGYYkbYyUXwFiN0+JXUNcYT6nt4V+90g3HxZAd7LkcAm5So5wLlPvb?=
 =?us-ascii?Q?M9xTNnSewzsf7LwbL2sJyvPa/7SjR0zhAwHMF9WgQSvNhmsy5a+SAJOvgf0N?=
 =?us-ascii?Q?0nGIDY/cblKaX5D6n4bKgIWGqv3cXE5IwET9d3WU2oh1dh74ZNMCXBnVmE1Z?=
 =?us-ascii?Q?WlzcFu1U6m3fY+/7AaxNxcJBOqqISTkbLtVpINKGSvh2PHrWi0KrLS6uiVDq?=
 =?us-ascii?Q?jb3I7y/ME25tOLxt1vgOb/gqd6vKcBpAI0zum8p9ZVT2Oe+ILsV58xRHW+lL?=
 =?us-ascii?Q?y2eFWv3F9hg7IIme+HcOiN3FU8OMOK9G1f3cDciap2BFKkxbpdQceF7s3p+h?=
 =?us-ascii?Q?Il4TcATEqVuixD+8OeNk2ToGq+QzTYiMaGDqBnJjeyYGBIzgtYXvdHM502oB?=
 =?us-ascii?Q?/sJc7ktfEY28oM0UALcfmCVSKo0yRnaxbbPwK5LtFcXxr4x3OIMyyMAUlbfS?=
 =?us-ascii?Q?QvJvoyGCsh7XXf3gSp1D0N59qjGSRQIZpqIp3Y/PQeMpNVkxOw7bj4LzxxLs?=
 =?us-ascii?Q?jRyHIx8a5Jdz/gDY2msW6L5i+efSHFuG1Pgd7JV8Q58m0mxSUSHNT82RBy9d?=
 =?us-ascii?Q?XxKDzPo1e+ujWSF/PkbvYrFseamOPcISHhQrSfz3zkCuN2Fy6GM1LbsD81CI?=
 =?us-ascii?Q?9nsnHxLNydDVxq8FSnoJe0FnSZ+wJl7HRQvWmhU0Te8MzMSiUhlLVxlNHOHq?=
 =?us-ascii?Q?zNBBlCQxv1gQhxqp2SLfD036dTmNi0EsgD+KLjFaEsugzPM9VUIxXNvi3gB6?=
 =?us-ascii?Q?7/xIvYFVVUp7OTxMYMigHuPB9f1iNGw1zAKgPol0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e07e352-af9e-4d36-5654-08dbb41f4263
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:04:15.8980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IW5efxjTRyS3UxKm/jIBLfbeQjS8MjoNW0PUpnZXtb8CsuIBFEqQHcV0JXpxW9ZTbjhhaNBf2+Uum0suJS7/8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8063

 1-3: address #403, add refcont for address entry.
   4: add userspace fullmesh tests.
5-13: seltests cleanups.

Depends on "userspace pm remove id 0 subflow & address" v7

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403

Geliang Tang (13):
  mptcp: add userspace_pm_get_entry helper
  mptcp: add userspace pm addr entry refcont
  mptcp: add netlink pm addr entry refcont
  selftests: mptcp: add userspace pm fullmesh tests
  selftests: mptcp: add mptcp_lib_kill_wait
  selftests: mptcp: add mptcp_lib_evts_*
  selftests: mptcp: userspace: print colored results
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: add mptcp_lib_is_v6
  selftests: mptcp: add mptcp_lib_get_counter
  selftests: mptcp: add mptcp_lib_make_file
  selftests: mptcp: add mptcp_lib_check_transfer
  selftests: mptcp: add mptcp_lib_wait_local_port_listen

 net/mptcp/pm_netlink.c                        |  25 +-
 net/mptcp/pm_userspace.c                      |  60 +++-
 net/mptcp/protocol.h                          |   3 +
 tools/testing/selftests/net/mptcp/diag.sh     |  23 +-
 .../selftests/net/mptcp/mptcp_connect.sh      | 108 ++-----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 280 +++++++-----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 176 +++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  54 +---
 .../selftests/net/mptcp/simult_flows.sh       |  19 +-
 .../selftests/net/mptcp/userspace_pm.sh       | 122 ++------
 10 files changed, 403 insertions(+), 467 deletions(-)

-- 
2.35.3

