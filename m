Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0FF57D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYxwQN4EoX9wITIw3qveoBNS9CXs5+tZF6hfM1d440g=;
	b=asQQ+Nr3kInJr7LPaJGl9aI2QRAM2LwzXkLo4xoGZ788GSnVfaXHUTW8Akru+VkkUaFiQo
	2yJwvRSfz2nqfS4Gvx4qHqZjVHTu8o3GaHLjjIKG/UvitdVGJOvfDjy9GERijzkP6JUJ5z
	BFOF7iDKcrMmXIpW+P5uZ5qwn9CTBEE=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-UvQeQNYoOuKTVFzTgdqgQw-1; Sun, 20 Feb 2022 00:21:14 +0100
X-MC-Unique: UvQeQNYoOuKTVFzTgdqgQw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBFW4GmpSiJswfLzsL/FtjimRqwHI3R5frg7rgAst0Ro8gRasjR1RT29oFiBu52JjKy/+D4uhiH2phsryJj6kfsa8crVuF6Zhemubs59uruqFdfL/wRcW6UrnpmwvOmEKrjeQumSN7xc2IXXVU2KeZn0BGo2qodHCoSYNnYEbDaQGfVsf0NKrAET2bgOBWF1qSIS30RaPTEEENqZQXlFmSTAxp7oiXLOWP8mBkKRmLdV3vHCycxyCaWr5vHaK4MkMmdDcP6YYvvt3xoTCRSkhjPl8b5UX3qFRxfUS6x9Rzlkog8qhPTe8PYRB6EnssL0Krv9WYfN1Uml8we6wnB4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlJZX0r8ApcJ2nEURZ/6bDNq/guUR//f/33UlQOzWEQ=;
 b=d8ryhUTeeWRY8+HC3aG+qaX5LbVCsqIql+sV8AAccPbSd4knuh8QyCYP49QGeot9dhvsOQUYJ1aUX3mD4eti+uOAopxbgtWeq5Q2VqBF7Ro/xK5SyeJXX6hzYyDj/RL5vzfDtuputfojwnh3xIQsNAEjmtBzdZKGHlDF7d5cshHn0rTGwTLY5K34cw4iACqak2Ctir9dmW8g5GX9g7nek5rJYU1sZj3M1CD1kEfVj7LRN5u498CGVS6osh0Upxwu0SokT/XM5pKiIibsmoxtcRwSlcae5oUW7k6+k58NzeIgTv4BPcbnFh8LGPWeiw3SBP81M3TwgctwE3tPgFA7Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6841.eurprd04.prod.outlook.com (2603:10a6:10:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.25; Sat, 19 Feb
 2022 23:21:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:21:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next 12/19] selftests: mptcp: add the MP_RST mibs check
Date: Sun, 20 Feb 2022 07:21:27 +0800
Message-ID: <192468e21efa3142469263504acba66c87d94b05.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645311956.git.geliang.tang@suse.com>
References: <cover.1645311956.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:202:2e::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fad3100c-7370-44fa-ee97-08d9f3fe8548
X-MS-TrafficTypeDiagnostic: DB8PR04MB6841:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB6841FA389BBB2CA75B8BF019F8389@DB8PR04MB6841.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ru9jnIoHM+T7nYEFvkHov2Fzok8dsp7w07YQ0szlDDfduAMpjy7k5PE2hhAHhSlfLvwAZEVe0DUxD8khH/K/9Abu9hirZrRvb8QIGC13KHHuTJuYVU8WzPziH9L67IhpgY+91GvChpm2QG9acAJ8w5EsPRYhl3XLOIvS3aTzlTA4yo2x0LiSNOBcAoWVECcRnCijKbUkCGnPxvAmciRRJ6V0HmUEZlwBVcz2D3JUrgBQJ+Qkk4h1Qs3F0xfqv6DSm3pM9Dr8ufp/QXIZQX0ALu1micRvxENv285ibOiu3KLrnw7qHUKSEp8aHaVw426baY4C82ocIiZN9zeS8lG06jvKPPnVRL3P+e6LCz13x5fKigke2cU78zZL/HJeFgSpfX1341OQ/ap1FZomJNkxJzJtFykcfOQq+TUledtvl5cvUigjghxMcsHbVN0DpOIB5Tes1jryE0jCuUCnbOYsNCu//RU4eCuMx8/x83vKNRS36eesdcIfLbdFjS3bnH+0VYmgFiUPoZcx4CGmMDmlIJCh+QUhyussN+tPMeAHrwYCwPrnAiQ4h0c3F++f0MYfk1yp0Xj+gL5dXmr06O7/ZU+ZxXRDabQGzPB9JfXOhnglif1Xc32uAKoCYnAE30vaFkFLEORD2Jp/wFbAW0TARA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6512007)(54906003)(6916009)(38100700002)(8936002)(86362001)(2616005)(36756003)(6506007)(2906002)(508600001)(83380400001)(5660300002)(6666004)(66946007)(316002)(44832011)(6486002)(4326008)(66556008)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YWxBeV+LSUp7GUHSc/UzUGP1P0achRnx3k/8TM33w/Aw7amNQRWqPEs9tYeR?=
 =?us-ascii?Q?/voLDDkPSCoHXi8F4BCmdBLaGnBEUxMAbnj+Fp6NAMshnZTvKxe74YF2fYHd?=
 =?us-ascii?Q?Z3l+eTtGOnbm56tC//vGLfNsK1E0zP70xKP0iUVWYY/4DThEqYYw3W6g6vJT?=
 =?us-ascii?Q?kfjF9lrAUeGhHMVo+/H3XQgg1dlWVOek2np6lK4iTeIDrKuYR0g3ocL0u06Y?=
 =?us-ascii?Q?2kN4H3Vd9TYY6rvSmziJ9MxINDqyfcuQgUMFT8fJDNB7t056YpyGI8FGq9M+?=
 =?us-ascii?Q?6JSHmWr+aqPx3khTGTSKsibf4x/6M/9L+4lUW8nxJgX+SwzBfFzx3GF09m7b?=
 =?us-ascii?Q?qaqpJUQaKEtue0g7pD1NAkqq9TmUOVxaidpLV6DWpYRfR5LHh/CUTh8szcGN?=
 =?us-ascii?Q?O43cyOPoBT55m3RU2WCUjixWlsxd7NA+1l4YnVdRbVdJDoU9dKNar+ytBhA+?=
 =?us-ascii?Q?19+hW1JEsbt+JJ7oCniR1PjGKTtlm4KWDEEW90USsnLANv8L4ZhNNdVZRmRK?=
 =?us-ascii?Q?G55xoJnQi0AVxIbRSRndbsHNBNTGrVRnb6SlICViCbeFUt9HM0c4vdV+D1mu?=
 =?us-ascii?Q?dII0MYwldummZguQ2ICzytBI7GGXVLZ/JqN8IcLsYrMIwKJfdMazPuFpLu5l?=
 =?us-ascii?Q?PUhrTOj8lLHDyLpf4Z91NrvZldmznK7CWuKNjw1ToQ1/c5tkca/Jt1bs9vL2?=
 =?us-ascii?Q?x1NuUt6C9pxUyzCutEVzsPyfR20dYDDWYVqbC1SoG2JkKcU3ZdqOinqGrTPz?=
 =?us-ascii?Q?TkWxFGrhDcNLg3m9gjsvCCgLUqjXC5JZbV0ol/GTDgJD0jGmSCW1+9OuHkU5?=
 =?us-ascii?Q?OmceuV7xD1xrrmU0gl6K8to8jazQ7tlKYElQ4OIiC6Zw425xOYI7bffRcTXG?=
 =?us-ascii?Q?Wcu4m/bswY/+jyn3thNfii+sbBUN/mEaeuqT6X5vDeVNBWJryVKCGCjiiH+q?=
 =?us-ascii?Q?up1yTwMZE/vwnOjBwmTaz63bXLq63C36uV2wdxJIMgf/UxcrJzpT/AQbDJ7x?=
 =?us-ascii?Q?88r4n87XZs63JGCAEgpKnCVN8XbRX9sU6TFG8yc/0TivltmT0NH21+6m2/28?=
 =?us-ascii?Q?s4/xThwuv6R+oVPfXvHeNVK+AsmHAakFuq6EHO80sTmgAPcj3BUFo3ynPsfV?=
 =?us-ascii?Q?D2cyVwO35yL00IdhN3bO+GoWEGZL2B4r3JLKRAB2CT986lMI7LUhLSsyzN1l?=
 =?us-ascii?Q?Ye7eD7yWMYh9E+qqQ/kRp9+1iUFwKkd5i1Xc1tMtcfATnoGFKsxoN/moeUCy?=
 =?us-ascii?Q?b2NZ9fQ4OutkKvoicdIroQx+kgXyvyMj83J+nsPsc048Kgt0Jqr3sl0hAycK?=
 =?us-ascii?Q?XfdE8Dmep/AOaMDVzN+R6VO6YXNJ7iYVU4e1iVtGakJjgvXuACGTYnW5hsUU?=
 =?us-ascii?Q?yTJdKauc8QBtpdvl9VT2jQ3VIW1ZrzMwTcAC+b9VBa22ikWBnjFto+mJtM98?=
 =?us-ascii?Q?aXsh2FKHI6Ll9dUBXeKUop4QbfXG9n1mTJVlGb04fAcFPAhSqzJ2E55+Bif7?=
 =?us-ascii?Q?6xuk9HkJrPejiSbRFC6drbvNaz9/BLLdbYz9Xnd0G5s0kPORN4htgQ93Jp/2?=
 =?us-ascii?Q?OON0ZkE+cs0JbSbXitlpxEzcZEiwHSe0ccUCRtDbNULyMKDTopn58Jy3/box?=
 =?us-ascii?Q?ACQbtT7caUAtSdsMdKHA8jfyJkqOpJ98YfHTxho2wFkZ8LoCC930MBjxJ+8M?=
 =?us-ascii?Q?SbwlFtE/+QOOixqlgHm/x6FTq20=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad3100c-7370-44fa-ee97-08d9f3fe8548
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:21:13.3965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGboenkVnlYEtUez+FumqvUCMp3CFg1cuZrMsv53ixw2jPBhHrY+oY5s2ZkOE2KBX5ubFRapYPHb6nKPZBWcSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6841

This patch added a new function chk_rst_nr() to check the numbers
of the MP_RST sending and receiving mibs.

Showed in the output whether the inverted namespaces check order is used.
Since if we pass -Cz to mptcp_join.sh, the MP_RST information is showed
twice.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 76040c725e12..bef029de5876 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -863,6 +863,50 @@ chk_fail_nr()
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 }
=20
+chk_rst_nr()
+{
+	local rst_tx=3D$1
+	local rst_rx=3D$2
+	local ns_invert=3D${3:-""}
+	local count
+	local dump_stats
+	local ns_tx=3D$ns1
+	local ns_rx=3D$ns2
+	local extra_msg=3D""
+
+	if [[ $ns_invert =3D "invert" ]]; then
+		ns_tx=3D$ns2
+		ns_rx=3D$ns1
+		extra_msg=3D"   invert"
+	fi
+
+	printf "%-${nr_blank}s %s" " " "rtx"
+	count=3D`ip netns exec $ns_tx nstat -as | grep MPTcpExtMPRstTx | awk '{pr=
int $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$rst_tx" ]; then
+		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - rstrx "
+	count=3D`ip netns exec $ns_rx nstat -as | grep MPTcpExtMPRstRx | awk '{pr=
int $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$rst_rx" ]; then
+		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	[ "${dump_stats}" =3D 1 ] && dump_stats
+
+	echo "$extra_msg"
+}
+
 chk_infi_nr()
 {
 	local infi_tx=3D$1
@@ -981,6 +1025,7 @@ chk_join_nr()
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
 		chk_fail_nr 0 0
+		chk_rst_nr 0 0
 		chk_infi_nr 0 0
 	fi
 }
--=20
2.34.1

