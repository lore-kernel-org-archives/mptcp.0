Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FCC15B9
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 07:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652255799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Atk3G91JSSNUe+UIEuu8GjmY3hMPn56dEBUsv8p19hs=;
	b=SPEVwerWaoR0zcIXFxxb427bjDXKCogE8zAVJ8+FhHZ6JMxdU3XitOzPGFyVsNnGSsT3cy
	j4pnEmlOen8jR/NV0tqS/wdXWpXdDEO2FcZLvXu5wC0hkuXixOtccllrl30dgkLMbQnTL3
	1MeF4OEfLmpQKd9tIEkvz7LISOAg6QQ=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-jegA_8tINEaP7vFvyObcyw-1; Wed, 11 May 2022 09:56:38 +0200
X-MC-Unique: jegA_8tINEaP7vFvyObcyw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyZbPkS/yADVhgp+gh+RvF+80xdUWsoKGvvPm5k346v0R9iDZMr/eXqEZ9z3OS5GeogM6MQNTeHzQusCPguu5AGvPTeBV63UNj+ywcikNUkbcaDC9qK2MokcswMaZQ2bhV+DDEeAvziQxMm7QyJoAsVfKLF26K5R6WAJ/cFeh74/X17fWBYKoB2z6S9UxRrQswiPU0ndA0nVhlknOy2LYp5DWgV730OUtc3OspCS2kMnl+pawIUDlB31pS5DgG/nOaCRVhtcij3TbSsX94Btx55u/LEa+ckcQvwOgmfopS6arZ1/oZejAy/frRJGPflbgO1hh+wh6tAklVeDdWOytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y27vFa5j/lSX4Ma9newk9esbxK4aYDN13I/rD70ttUw=;
 b=KsN/HqEMXjaHsMBUOngVsL75RQ9nZLKZiV2TkoODdjeNNHZGqbbJQN9ID4WGq4V6e6t35kAhbnpyROJfHAi4czS46HQUGm5I1Fhgl7GBkPbASUjuS2pmB/pyiCvJ+pPgDWnVXtxy1EwDTtcmcX6pzAgAxuexDMuaMc5SyZyTQo1aUpo3NA2yKtqws6yjZn545kIX0YdCS9e7NVfsNmJGy5AWi9Zm6+2/TinfQupamvzaSwEK667vC31rp/89YylcSQd6Vg6aqYRjnta1NWsGDlEzG1xgEJqtb+2xZZRngVbpR9ODQqSGFg6/lAWOZXkyP3zrenzsdEv7sTP4Req3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB4461.eurprd04.prod.outlook.com (2603:10a6:803:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 07:56:37 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:56:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH mptcp-next v2 02/14] selftests/bpf: Enable CONFIG_IKCONFIG_PROC in config
Date: Wed, 11 May 2022 15:56:08 +0800
Message-ID: <e6f3d3dd68ba03969062c2d643c6bc98ffd5262a.1652255616.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652255615.git.geliang.tang@suse.com>
References: <cover.1652255615.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9623c4b9-5759-44eb-70c5-08da3323c669
X-MS-TrafficTypeDiagnostic: VI1PR04MB4461:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB44617B5FCCF027C0094D3855F8C89@VI1PR04MB4461.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/dx3Or0VNMwXWZ/m40iFgCJRr7ggopfvZUzCWfvT5iDtyG4RMqQxEfZPn/vj2XR8+wJqksUkDmJ8Phv3GuPEJjajjAcAj68ZC2oE6ytPT0fvP0iqSmlMCZ2J18Tk3i3Oipz4DOwo5EU5Wd6cebMP3zXm+TgVXKkPaONQv61B/TMaZhQbkz4QEkFrqn/qVM+fwF326DSjgixEM4+jGRtPujFvDNGjeKHRaGEK86uCMf8OMxBVdtB99zCTQYrL7f2kfTD1WDj7cTWbr2tanir/4RO8VltrNtb3FQRnVb1a93lsNHeTEQlFA0wpy1jVhL6pOaa6n/iMx8BBSBkd64c0uvy44VHVJDbYx1RYpBXbzBbOd/V02xQxfEL5ie8+pnGuupLIstUGcZKuE+bOnOhCzFKkT7GmzsICkoGeb9qWd3f6GFdIftFCj1W/9mbFPT0Bh6gujgibCcDnRhW7jNxDzC/YszlQSl+QcKN9vrRFbZC3CzH8EhcZDriXDeQ7wIEaEx9F2UumYPKafkvQjlLwUdkl2fE7G/tHuJ2ZvfKzmR7spsbz5qe324YKEmXFIY6+oR2Wz0eHZ+irqC0fH/sm+fONesG4nsobzH4mPI5BpLf2Y1WmedYfp95FT/7daGIKfc1ui12x7NYUfbv9S7Au+IhP/2/58xp90xnFIJ6Sf/16sktQ7YQ03KzFlE/TwM3psPT6U9KuoWdl61uauyvmjw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(508600001)(5660300002)(8936002)(316002)(66476007)(54906003)(66556008)(36756003)(186003)(66946007)(6916009)(6512007)(86362001)(2616005)(4326008)(8676002)(26005)(6666004)(6486002)(6506007)(44832011)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pm1rpGBZ1oAH5eHj80rI58RU5PzaK28/NGLrXgy9PN6J3lhbeSXtKyD+RFn4?=
 =?us-ascii?Q?DG1ayjWejr2xu/mIn/i22X8h9F6RfR+xitEGQ32QdUxwQ/af2n1PHcuIInvk?=
 =?us-ascii?Q?l12V8+tennF6oSwoWIAc4pM/YHEXc+1zGt6pozqnJTG0kxoulE7cmXELhScI?=
 =?us-ascii?Q?1EmCzv5nQi3ygvlOTd+kgN/zgYHwfN90hiIMuqyy/wZR90Dd3dcfMfg5ZLt7?=
 =?us-ascii?Q?q/NQ/reoArexYrEanyesSgzIjC6wrqibOdpOzPTdeZNttEL0+Tkr0/tzLT/M?=
 =?us-ascii?Q?IHDJgP3ml0T0MpHZjAJvCy/lXhWClE1q767MrzlUq4TpphUo6YUF8p4uPhwN?=
 =?us-ascii?Q?Lo/DlGW/lC3NUVhPkV2G1RPJf8nf0QA5SX2vllrdw659l5xi4GoPxmtPGwft?=
 =?us-ascii?Q?on0h1p0QpoNvGUxHZWI+Ek9SKng/2G+mnI8pGbS/rgc6iU3uPkNRU/7GIybg?=
 =?us-ascii?Q?A8DaTmPTSjl7yr5TXBflgnrv6tTUX94q/z3c/Qj07xf31rDErQc2Zug/Ch1U?=
 =?us-ascii?Q?BIFMlWIwEIRyakZd3AyEC6ml+OnTaU7cDHxZ6lFsvQ6AQUrgJAL2XTcENqha?=
 =?us-ascii?Q?pPIo8zqVaxY2vZbiXYhk2pCgBPod6jkIKaIsWVeuoetSwpIOad8f2ZNwBmg9?=
 =?us-ascii?Q?5QO4QWbMPb4QoNanm8pGJGgqf75A7nKdp7tE9enbbBfcP/f99OKptFULtD8U?=
 =?us-ascii?Q?5/UXijBMmu48Yp+Z4SzfQKDyim7jLxQ+haXqOhTQ+iwb9NePIaxagUYyNCGh?=
 =?us-ascii?Q?ZlyF5x/7sIUW8MOZ9HJV1vUcipYcf+3wFG/jbg1WR5jLvmNbt8d1WpE18es/?=
 =?us-ascii?Q?P4OZTBkFCgp2k8iih+G3fnxervoGa8sQ1bWKqwePF8jCVdH6ZzdaX4JQgVko?=
 =?us-ascii?Q?k9JTVIFcW3JUYGSPJSuRM0+hHIp7pDAjsnGPPYBv0fiAo17qNI/JrvcYoBR6?=
 =?us-ascii?Q?kTLdXwvueLCWGkyfnsxCglTI8Wmqkb9xgr4p8EUz7th1sW65dHSno30N0s72?=
 =?us-ascii?Q?o3Zf0ka2bhh1gHzKN4GG782VIYgtCyMtT5cn4F4/lbMCPAdEz1E6MDERccK1?=
 =?us-ascii?Q?pFA4yoZh5su74A+nT2TThzCdgL0gISixHe7flTPCnXhXtBtR0FJyL2IshRye?=
 =?us-ascii?Q?8W/+L2QSFLwsZCVD6xbb2NANC8wWj3o+R5y+SNTmzLn9D6e+yt+iLZgK23KZ?=
 =?us-ascii?Q?lXlyfU2ZSAu9NJhYL1i68P7qF9XwQGAiQTqfHZw6UeJdbqwfVQ7zwo25xQfR?=
 =?us-ascii?Q?pvpE7O8B+uaB31HVExrDfF2pCIrCHSp8/r0Hdxii3yZTVVRbKnzGx1SL2Sz1?=
 =?us-ascii?Q?Hb7w1xoL912JgV/HTn72QRvIE6HNkyWuwB0jow/AVgj7jc4t93Z9isITVRAI?=
 =?us-ascii?Q?aFbvWIcojvzEMaU2ajf+V4o/7liY2+llrmg5alqPLshFouzN7AKe754EMxZ4?=
 =?us-ascii?Q?yl7ybSlZH2M/ce6xTo0SewdzTnIRPpgmpCmpIvcCJ4MHBpJJrPJUNYGy7s5U?=
 =?us-ascii?Q?dwMDnLdnN31HkXaYhC+nFxM9nzbvVeL8HeIWlVpBCSGvgdIIMqXSsTPGdJTO?=
 =?us-ascii?Q?nxHUqOzmDYFWVOIyp9jGvX/ZdPftu4HZcnBz6o/EcIrJW00YuyNOn633y682?=
 =?us-ascii?Q?htWlRyoRVrWazCogPPlIzh9BH+HXWIj4jeLRSSzxu7d9vozTbumoQ5YY+Hpl?=
 =?us-ascii?Q?ya3RjlDQHFC/5VBNMeb15bWbDBomm9T7+gjCKNzT4F3HzTi40Au2ddceVTL2?=
 =?us-ascii?Q?jyZeGDabbQUeJN/OCInP++hLtALcwIw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9623c4b9-5759-44eb-70c5-08da3323c669
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:56:37.2954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQhDrQlz4zCxKf4ZYE1+pF3Z7E3CvexsA8n/3jimAjUuCY3ondGhO5SuFNVpc7/R7Gw1soxAz9X11O6a04WtSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4461

CONFIG_IKCONFIG_PROC is required by BPF selftests, otherwise we get
errors like this:

 libbpf: failed to open system Kconfig
 libbpf: failed to load object 'kprobe_multi'
 libbpf: failed to load BPF skeleton 'kprobe_multi': -22

It's because /proc/config.gz is opened in bpf_object__read_kconfig_file()
in tools/lib/bpf/libbpf.c:

        file =3D gzopen("/proc/config.gz", "r");

So this patch enables CONFIG_IKCONFIG and CONFIG_IKCONFIG_PROC in
tools/testing/selftests/bpf/config.

Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/b=
pf/config
index 763db63a3890..8d7faff33c54 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -53,3 +53,5 @@ CONFIG_NF_DEFRAG_IPV4=3Dy
 CONFIG_NF_DEFRAG_IPV6=3Dy
 CONFIG_NF_CONNTRACK=3Dy
 CONFIG_USERFAULTFD=3Dy
+CONFIG_IKCONFIG=3Dy
+CONFIG_IKCONFIG_PROC=3Dy
--=20
2.34.1

