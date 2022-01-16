Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F6F2CA0
	for <mptcp@lists.linux.dev>; Sun, 16 Jan 2022 08:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642321119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pW2WbTWE1Z/NUikX1Vul1WEr2B2yqqo7fUEprdKYcFQ=;
	b=HVIRqyxh3xPVr77rq24mgXfyr8WDVWIzEVYAt2zQV+X4SUGvJETzkrUpAk+vM1DBoIoWTG
	MSFEZk1i3yS8rqW3/bzb2tCAyLrZRzlPuIkPeI5f4IzeihWo0SGEBh1JX82q93oEcsZGmM
	HOOxWN4PbJK+Wg91ya2pmOSjuZauQoE=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-oDiTcnCcPXezUbhY68s1Zw-1; Sun, 16 Jan 2022 09:18:38 +0100
X-MC-Unique: oDiTcnCcPXezUbhY68s1Zw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMzATatt+4s9enTF1qiqlBys4PbJezkD91IvufR6rJL8SUtgjGK3nt/FIykyuubJC2EXwZStRxSiMOSIeniVx/Wk7T/QdLwncwUhIrdqLXNokPHB/EHByTBKop2MQ42Ih9ZkV9oD+bIYuLX/5fNZL7GYFYQmwwQUCHcLgOAmj3vbrYQMd4vfOTomEPotVUZmQy/tPwejb/58b9phasVOFVWips9I5gfTaIsuEE6MVS9GJOuOlVjUzRtFdRW2IQrbcQmweeM8wwji2EbYh78ajjjeaoJKFrBitLJCQqGqSum9jieFMJIaucjSJrOtEIbfZpSWcIBtlDrzY+sosw4UJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mg5mkMauIUC15oHSPLzlPAiWflO2Rm62cDWgvgLwCvw=;
 b=hRBYugHj7TvP5A1uft+PhaIRA3SQOT0NoUHQgx1/k5Lj9Rjrf/yLF4QQ2vw4OvqP43qQevskpuksVtY3GtV5yRGZ+EU0BaVrAwI7Gpl0U34z6mdYFhhUkuJ9w9nRwR/zk9JN00+7STkLb1+QHZ+4Bm1hN2atQBJGYfpqxju3NJ04SP6Y+3KtXHMpMJrsKGKHikVaTo3cQwSDV3Zt1WYAGholRk7U/HGoTwIPvMruyEqW5JYU3ZqfyijI20Ivt5+GBxWtFOhBPtdr5vr9fBHV/VjzSIjAU70ZCBMqm+VpxiPmaC2r9Dp0w8TLUwtQ8I7qq4H46l4mLdGPue7YJt3Cdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Sun, 16 Jan
 2022 08:18:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879%3]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 08:18:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 06/10] selftests: mptcp: add backup with port testcase
Date: Sun, 16 Jan 2022 16:17:36 +0800
Message-ID: <fe845a602496b2ba280fc53d17b660ba9178e007.1642320655.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642320655.git.geliang.tang@suse.com>
References: <cover.1642320655.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd9d1c9c-63b0-4b44-54b8-08d9d8c8cb7f
X-MS-TrafficTypeDiagnostic: VE1PR04MB7472:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB74728C8DD2FE8AE179943CCBF8569@VE1PR04MB7472.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f9FjwN5rtsDJkZEwU4MiqShAZeUoWhKCEGrml0Lqk1RBipjz+220ABOJbzVotZX0fdY4C4dqwT8tP5bQkUlDC5/XFlLCZxlXy5zB9LXxNQQIgrZ8FczlkMxuxPH6+ZlDt4vO08tsLgjzM6Ip9nW3NcT6WWUcguywc1aEYN+4OzevOWvcJMqBMJHmMeJ5XnRbH7Uqw7gcyghDIejA1klpwKJnHnbLvP9eUyJDpdEO1ZaRmhmlPYKg4vPade+NeGUy3IoEG1ATm60zH7A5C/Mpu4z0CCtvNKiOnJCCVyO0wN8X2/zNQptb+G2t77KHzsUNNGFdQVbFkwyb69A6q2VWZIJnEa9TR8MWh7nXglY2B6bX6I6YMTgKjGv0Wa9ZRh+/hdcbIVkhN9yyzfbgRe+0PerBnsn6I4pW0fWz/UG71yW+iARATVC0ygdGJTsiGlvmkGuULb9K3UJkWJ20/xxwRXX/k8bLKatvSIy/rHlhTmoLf29k7a2LViLLPT7Cb0c9ONFnOD1VOh2cLHnCVsaDyAVlDGr86/zooAq29CCuVDpnrNikUqu9zGS31RRBhB2eU8d3UJGe2CWDgeVVB8s+L4rqwHEv5zmXX3l8rSls9cFAXVWg58DLYKag6B7QB9q3XhC6SqSqFv2dqmqfM3pMFsiroAS5G2qOmqi5vBb/4NL5ZgqKRSnSV2bc1xNgb9Dj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(5660300002)(107886003)(38100700002)(2616005)(44832011)(6512007)(316002)(186003)(508600001)(66946007)(6916009)(66476007)(4326008)(6486002)(36756003)(83380400001)(8936002)(2906002)(86362001)(26005)(6506007)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PXyLhHjVkFYtZEXc5JBZpYCh+N+Q/3iGTLlIgrpbPSEaY4EA8/liuUss+8Fa?=
 =?us-ascii?Q?09V2F4vKg/pSlEXY/X0CgnkgzebFwtVcJ3RdUvRpRJnFasPxp63+R5Au91RM?=
 =?us-ascii?Q?lshBpl4SPgvGQA6BbfT0XZqLmy0NuB8q4V/GJP2KLVAirMZe0L8vi3BtUuny?=
 =?us-ascii?Q?MFv9kmSCTqwoHp8gL7g/D6zsdvrKhcwc2Epdgg9e5Zc61ZTIV2PqbmOF/ArH?=
 =?us-ascii?Q?VeXnqNNvnCDTDLobu69rqxK87iubCsfBlg89+JVdAI6jvHpfWzy0NA6l0nhM?=
 =?us-ascii?Q?dIcL4gdz4TZGNrCRVeQKXyvvitJf+5LFjoHeqhjjHbc+69PPMgmU/MencJF2?=
 =?us-ascii?Q?LxxwpWe+lQgLrU47LC3vk0VdkXtEcOLw74W4F7cd5MKeWFqeOMD5bY/5odrY?=
 =?us-ascii?Q?hgOlHhTfdorhq/gsZFNecv1NFQLcr9IyYYJhwZIO0XG2YmxYJlj7C96iDXVB?=
 =?us-ascii?Q?SN7A2qKwZUT/N56XBf2Hir6F/E8nZdCL/iz644Ton7HsyndsxshyHXuL80lw?=
 =?us-ascii?Q?ZJUTz3DVF61wYeb7zONvJ9OYVRElJQaAyhJF3Jo1c1Zc+HeUtV7pvCt6GFAl?=
 =?us-ascii?Q?ZMmwN2SFfVfMS02JS7MWFOMuxSp3j05KcoDwasyDXlZ7QuMSAq1ttKcjgv2w?=
 =?us-ascii?Q?LBJPjoWebzKJw10N7NF8+7g+gSZdMx5Lr1A9dyC3COl1ZMgMjuxF73RyCDTF?=
 =?us-ascii?Q?b10o1wMfD301qyZYkHhoRlZLh4jlke1ef1gvk1Ova1TKZe26aDdO9VpbNCzp?=
 =?us-ascii?Q?vFctvBuIKeekS2O6zweLS6p1CL960ILBcpzWXvDlQ38nTZ1p1WgMvBCyvbuC?=
 =?us-ascii?Q?N3slU49P1oNa12ddqbvxMYy0iTJo457E2jIybTXiqGf+JMVHi9gRmbRqXAqP?=
 =?us-ascii?Q?mCKP01EifXJ2fb+MQ/Wg+3rvkyx3QUFHeSCS+NbweXTqHT0Hf+hGVgt+pA7V?=
 =?us-ascii?Q?VPjpz9RgJnU0N1mLPeLBgIHmTBLwm1oTn2J7CY8g5YaPOJjl0jhxdBCD8y++?=
 =?us-ascii?Q?rg0TglcBd7Pi1KBICJh+CYcSJTpUsZXne+x+LuShizvKZ/z4orUaf4dPf+yg?=
 =?us-ascii?Q?8YYMymu8PNiarz1jurmFDKHDuI0ZT32jGH3wY0JXz25D+Sx2HmRXxI++z2TM?=
 =?us-ascii?Q?kK0gEQJS+Mvpc21CPH7rU28DFXxBQvOtHwF/PwhmnvUnFddTF301aVaCTgFv?=
 =?us-ascii?Q?iRlwMFQQ/jYwyklk8+CiqBVeLWk0rZ/kL+DGV1dbCy5Hz8ezk7oRhGcnESPK?=
 =?us-ascii?Q?MzD9xazdcfr5USY+HQsjOIGbgSuRiNAhTqowBgbAb5e1SqWBdAPQprv78kIc?=
 =?us-ascii?Q?b9RwFMg9+h3lL0TQGROlB19ufl+JBkeKFLT3VBYgFyxm2CCeENPaDMJwpnTZ?=
 =?us-ascii?Q?RR6BiVu9buF5bul9pIEvwKqdh9WEhkCwPdPyVp2pVsAwumY5ZkK37z28lepV?=
 =?us-ascii?Q?Ts2fN4mdO+MH5pLHfQ0g0NFIktPZXMMfS6LjuI4Uagdah0ikq1X2cv0PZrck?=
 =?us-ascii?Q?ERm2t/aJwZ3epfLfQWZz7iB838AMTQWQ3Pv2yDHfZRjGFfRQgprdC7bq0zs/?=
 =?us-ascii?Q?PjtnbM+5/VFnCgFpd8zi5L4+6jHIl25MvDx2KGlEz6bqFSkidFyEUoSNme62?=
 =?us-ascii?Q?wvy25bHb90D3P8Peq+TOWtM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9d1c9c-63b0-4b44-54b8-08d9d8c8cb7f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 08:18:37.1626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKRsoeKGl6yLQ1hAlZ5A+nf90ltP4jYisf55o9HCYcoBtpipDHoqHF3ZvMv+j+oB6G50LmdggcgCaS8pQ+PcYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

This patch added the backup testcase using an address with a port number.

The original backup tests only work for the output of 'pm_nl_ctl dump'
without the port number. It chooses the last item in the dump to parse
the address in it, and in this case, the address is showed at the end
of the item.

But it dosen't work for the dump with the port number, in this case, the
port number is showed at the end of the item, not the address.

So implemented a more flexible approach to get the address and the port
number from the dump to fit for the port number case.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 44 ++++++++++++++++---
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index dde5ccc8ef75..bb5fa814c05a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -247,6 +247,16 @@ is_v6()
 	[ -z "${1##*:*}" ]
 }
=20
+is_addr()
+{
+	[ -z "${1##*[.:]*}" ]
+}
+
+is_number()
+{
+	[[ $1 =3D=3D ?(-)+([0-9]) ]]
+}
+
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -472,11 +482,25 @@ do_transfer()
 	if [ ! -z $sflags ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
-			dump=3D(`ip netns exec $netns ./pm_nl_ctl dump`)
-			if [ ${#dump[@]} -gt 0 ]; then
-				addr=3D${dump[${#dump[@]} - 1]}
-				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags
-			fi
+			ip netns exec $netns ./pm_nl_ctl dump | while read line; do
+				local arr=3D($line)
+				local addr
+				local port=3D0
+				local _port=3D""
+
+				for i in ${arr[@]}; do
+					if is_addr $i; then
+						addr=3D$i
+					elif is_number $i; then
+						# The minimum expected port number is 10000
+						if [ $i -gt 10000 ]; then
+							port=3D$i
+						fi
+					fi
+				done
+				[ ! -z $port ]; _port=3D"port $port"
+				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags $_port
+			done
 		done
 	fi
=20
@@ -1657,6 +1681,16 @@ backup_tests()
 	chk_join_nr "single address, backup" 1 1 1
 	chk_add_nr 1 1
 	chk_prio_nr 1 0
+
+	# single address with port, backup
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+	chk_join_nr "single address with port, backup" 1 1 1
+	chk_add_nr 1 1
+	chk_prio_nr 1 0
 }
=20
 add_addr_ports_tests()
--=20
2.31.1

