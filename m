Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F5E7A
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 08:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652948735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Atk3G91JSSNUe+UIEuu8GjmY3hMPn56dEBUsv8p19hs=;
	b=SN2unJRcf20pUIV091w6zbKkw24bDf1EpUizfNix1uo9a8Q8kRVAJjtTRW/w4Upq9W54hT
	lL5NBBrnlO3zygFJfg93Dm4sLj46q3MMWQXLsk2hkm5UTXc4S7XIYsthSPZLJbWzVRr5Oe
	KieipStr3z3d909DTPTIuUwIZUznv6Y=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-4nIgI97YMaeH-a76oMEJcg-1; Thu, 19 May 2022 10:25:34 +0200
X-MC-Unique: 4nIgI97YMaeH-a76oMEJcg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRLN7lKS6puy0FLWpMvMgfAmlqiUD+3WajOrzlAJW2aOHMXJIqfj67q3Pq3aKHUpzgN07bVuYmj2Sj7apFEo+hAiyn+k7Zu+e8tJNM0dHNbDMcFIZcLM79jPhH5/u+SSDcsGhMrNDFImiQ1BFupfHAldTV8TxJrs3dhnFZovKKInDsATo6/maqbWgE44g0A9i1zqt505+5zzkSzRwwmXX+TmpmIK3oEOx0OKV5g05H9WInLP5Ik5aAk5hg853kcTW+5yBhT/htpD9l+KC3OZKheD/Y2l94yES0KlEQKPcPUtfL1fjsXRRAiHvbNTiWt/AGX7xv/HnZh1KDzxW82yqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y27vFa5j/lSX4Ma9newk9esbxK4aYDN13I/rD70ttUw=;
 b=YnMirjrZSWIJog1QC5tcIeZjknLa4ah72ApDLt4J00PuQDCOLHHpp3EafW1ApT+TaxTmjTLBhXk/J36ZjAREyjL/jPGmDklF1mGJrSsyWqFNpHuC7dhdfwRO8h/RZAj7fKwnPZzLUgfwE+3i8R2JoYPnvk9quPEINGHiTIdrpcdXHhSt5pSNPciqi/dGpmIak3P4X4VTOxP84kYHyO6IP9PD9Yq9GU70C6bgdvY2jIH0uP/ukL0mL1uFR3mjrYlWgW0Tdkb9qAEnZ796RInA1JGMXrtA/tIEB18VQMPQUdQ1Tbsl/k0TjOqFGluIHowCJSNomKxNjoYhh/sd4YbywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6652.eurprd04.prod.outlook.com (2603:10a6:10:109::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 08:25:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Thu, 19 May 2022
 08:25:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH mptcp-next v2 2/7] selftests/bpf: Enable CONFIG_IKCONFIG_PROC in config
Date: Thu, 19 May 2022 16:25:13 +0800
Message-ID: <575177c9d8157173537bb495bb0902c78b358ca7.1652948238.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652948238.git.geliang.tang@suse.com>
References: <cover.1652948238.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0090.apcprd02.prod.outlook.com
 (2603:1096:4:90::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e533a8df-c5b5-44f7-b07f-08da397123fe
X-MS-TrafficTypeDiagnostic: DB8PR04MB6652:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB6652DE0A961CE05077FB88A5F8D09@DB8PR04MB6652.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wgy4JaV2u0aZyZonkRZ8iCmAiSNclwX5lcvm1x6L3pSqWIvavt+k7kskLCUIkOXYnEl6BmbrXnIS4zc6H0QB8HmbDk9DU/AY8PhBHedHIVk7INqIXiDHwSsdUDAUS7yGbLCh675muQmM++YgOOrti7V3f85G4R8gzxQWrshj5nIli082hZ7Nh+8fnBz0RnL4g0I32fZqUohKmJ/KJ9AK3/x5sY6DiDOA8wN4NOHlDG6WHazcQero9I/mCEsfNXycNbOZkET+Y26FNQ+f6ra47hjR4cufaBk/WR5OXR3am7MpGQEUZtoq6On0qDe/KSskus47+8FFGA6BlVLGjrXP4dIcEnYsDm88IKQ0d8eZmj6YtbEhafcm9/luoIrNhq+OQd0q7aaKdFrckBV3K+FcsISAZ4pqTB8F7yVzjvqwVwkL53zRTUMGspDwHAmaDiGPX07+FJSDsmy+cU/SHdBjZ9KI8Sl2cmgDIlMxIqXQbTf/IrWhMFsur7fIbwX2fH3bO8WaIqkKrNLX4Fv4AmzIoF2hlN5EUx4WDpruMBEZzgTEWpz6OmdoLK815DFndWTWLZD+4ma0SsAZnvtSB0ehMEh5k/UTZ/WQlMcZkxG5Pb497g7p1Nmo8eN6A+Uae4/hwcrj77bO85RPD4UkuSKc/oz2wmhIT/MTBaM55YUwrkvQhynFwe0rZ8/nLlu26w1tr6k/kFvw+8bLgpnwFyLuww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6666004)(38100700002)(186003)(6512007)(86362001)(316002)(6916009)(54906003)(8676002)(6486002)(2616005)(44832011)(66476007)(66556008)(36756003)(5660300002)(508600001)(6506007)(26005)(8936002)(66946007)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4i6ubGjZVaNtu4BNXaW+3SMpBRcHFfK+Scsf+JfXwGW+8ZnYeo1X2uBV1t+N?=
 =?us-ascii?Q?iTv5WHfLx/FBMOhTmEsfnwSxcjcG8EAfMG08ZbSOhozQBbUGWhYTlAwxen2J?=
 =?us-ascii?Q?I42uT+Z0X1xMMZeGy83OL8v7MqKweYjIvuUUACxWvhn5pGxdLLB0ytORFN2g?=
 =?us-ascii?Q?zi7c2ctLVbeOZn4+Rs5bzJjfhQvwpKPGLUjDPRnMMfu02vqoz/4c9fdbtXlv?=
 =?us-ascii?Q?ZkmUBJFmSB1tk0qVCddy8j8oupQ7s9fe9FyG93BssRwd9UTkgY8ylU9S463v?=
 =?us-ascii?Q?R9+ev3bCeYXDlJ/+w6iL09UgsK9Ztd7Od50xt1u8ahU9j77uktXsxlPPqo17?=
 =?us-ascii?Q?D2Xzgge2nKw9WwNCbT+5NGpVzdKl3zmOSxwebb2KXTuco0bOlZJNr/w+gfE4?=
 =?us-ascii?Q?E2RbE1zBTkRptspUAQ/ixh76PBizeF4X4XV0KJn1saa8X3e8kbPZrIqha95L?=
 =?us-ascii?Q?7bKKDfHQ2YR/y8TEqVNkLJ2luX2/+4cWQ0aqK6fB3I9XI7uxC97YBGfuq/o6?=
 =?us-ascii?Q?C6lQSYRv7xN3h1HcgTbsQF77renM9AXT/dU1YIkStXUjW/hVPduaZTINddXH?=
 =?us-ascii?Q?CgL3o1oZSuveE/5Yb+fLW5FVeHA6ywlgTO6pulkeHxnVuGyxJ0ZpQEkHpGU3?=
 =?us-ascii?Q?bcukWCOWdK8h9ABb3aerAeyAsdUbnR8vprYHGmGnkJkoszMMk7u3bDVF9nZB?=
 =?us-ascii?Q?l01H+UAd4TwJfYtfhc1BZimpSLj4o8dU6vrY3l/JlybuU2sqAM+j8T8bvZgf?=
 =?us-ascii?Q?R0Q5/r3cQXihhoVlTHYjYbiurIcJjIQ4j82yrMQzR/x5bz+B+8Y9faXiEij7?=
 =?us-ascii?Q?Vk16l+9MV/wjA638gC8wBhKZ1g+RS5xdrG1WxQpIRmDjqhEEcw+qjJ428RId?=
 =?us-ascii?Q?4tZRRXcRC6r6srRt7nYhi+t9wf1TK9yXfFUP0rLrbCAT/Cgs10oRQJHh5J++?=
 =?us-ascii?Q?Kv9UL9uNosgwni/OYWYMRmmDYZgbZGRf8Z0OuqDc/mFwZJ+/rf7qqcFtpluO?=
 =?us-ascii?Q?ItnkaGvDpI5mdCs1csNv6itsWghY0+3WkFGlhtsSfutNBDbk2KqeQSLyZ8Ji?=
 =?us-ascii?Q?c2FrOIBDGURm/blr5E11iyObkABgwG3CvmAs4LGHgwgnnVKJMZwBzP1NkKFa?=
 =?us-ascii?Q?Tm52KoWcGEkBe7yfNPMdWyMfbWXO1b5RImnxfxk2Kpyj+HPqT/RLP39LQFlk?=
 =?us-ascii?Q?lyd8LkUCu5Xv6F6BguTnz5ocgwPHWGdym0+AYSDm3G8zPIHVtBaUh6Jv67Iw?=
 =?us-ascii?Q?SZPCal+dQzoEossZiDSTPQQn01cTpJjB9MR7Zd/ZRzEadyTQ2/jOQ6XKKtCN?=
 =?us-ascii?Q?z/OH1PIyak0KAO2bXOk5vn5UwPWsZhcVU3u8IgSitP9gw94LldpUEXDhX3rY?=
 =?us-ascii?Q?C4aZWp0hCIxphDuPsqretTH0gDlxMSSY2LuQVJQdb0WaSoK7hHfNu4LMS2gS?=
 =?us-ascii?Q?fZfl4eA6HF0lqgEMRd7M+FfkQ8fQtvPPVXrwkkqF2BGEREMnU6Q03rHvcZ6S?=
 =?us-ascii?Q?60dK8HLbib7YB0beWF6o32LxMty7ZvEHfV6KM/2JbUiimHaLQvbI5P6Y9rWU?=
 =?us-ascii?Q?IlOFBOMpJ1J6VAssXg9MWC/+kq8HCYrqsd2PDBPp/tZFhe+GCrZH3BTH81r9?=
 =?us-ascii?Q?+VG8vMX645Bd6znMRDNnggzMR7E/K7NDfJvVXavbWf1pn44vTfvq0rud4Pe8?=
 =?us-ascii?Q?/0Va9anLT7TjCZjCzLmcqa88OrzJ7CUyRsdeE4JufyyVcd0/06K5SgoBDHyv?=
 =?us-ascii?Q?6/oa3vpJuEJzmlueZD09LfyjzveOP3I=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e533a8df-c5b5-44f7-b07f-08da397123fe
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 08:25:32.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NR9T9P0yKZb1ALaEK/icOtY0HdT0pniqz8uO//f5KeSrBOWAOhYGHjXGbkDZc3Fm9AlclNUOjyjHKehMbTMb8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6652

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

