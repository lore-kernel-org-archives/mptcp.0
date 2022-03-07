Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE4B7A
	for <mptcp@lists.linux.dev>; Mon,  7 Mar 2022 13:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646658583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6xyuDgS4jHJqao1ATGOWuQieVlZdV/pb0pD4GvqqBbc=;
	b=mEWRCUYC9i/mCdL0an4lW0pbzKFVY4htQJ3LomtxzWQB0+kRZoeWrPGWYiXXCVo6LM2MUH
	01I4UHhs3H/l22HUjHF6E6voiTsbLNSYxHLML3cVvvHoM8cALGfC7u3v324gIowBDIdwTd
	ZuZb8PKHJulgFldRo8rc2eBxo8/SNKQ=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2172.outbound.protection.outlook.com [104.47.17.172]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-FeS_KP0cNwakhYZMjUxteQ-1; Mon, 07 Mar 2022 14:09:42 +0100
X-MC-Unique: FeS_KP0cNwakhYZMjUxteQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPzgvsuExcLWABDDtCOk8QSnkOPlvnallJCDSgygAWH3cO90BnJ8dHJ7lT/yjH6xIVo8mz4jv2d8/X8nTUB0Cg6ygejGjd/rfo7ziS5CvqEp3S+fCgMvh0xFd87wWw+UToSObIdtXYa6gUaGw5gcPKKz+rvuMQiyKkNhZUYc3DLmigqUXkqk8Hpp7cwpxszKXl8rcyMef0616kMaV9piaWNl6sZbM1qdrc1AQxK4kfiqL334Hh7iwANjRTa5oqOrbgt7XZ6qf3kU7MfZ/flqyyvQTR/c62kVVh94gG1SR7x7TCMbnd3I+v7/tAuxHip/etNIEGhKz/v/297XjjH+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=666uCOP0SDUd9+QBE+huczpK2WrB8Jdm8u2HLTIsbnA=;
 b=HmhBLDVvnbNtNYJKAJMcgL0C+GS5/CC9D3uYM3Rtnjl6hs5C9TF/qfQGr1WK0e8vvUwrBcVCRafpz9sxqHOjFf5VFCq4CH8R/5rL9uWz07PQOflxd37F4/DNOI3X27ORNlHrdllAYQW1u1PxJYfbjhjTsR6T6SKxxjg7Oh2QosEFf6WQ7WmmNyfNk1zO5e50aWEgVJW2xqGVOpmSSnrGD8db6KWkVuRBuSlgVIX1WuGUHXSumrQn79qNfS497D4c9IXd0Kzr2AhOoWB8KqbqTagrpfV/W1iaCSh9ZrGlohcXR4KqmCnbvwnemZ4e/1tM8FABQzbIXq3WemEsuHq4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6968.eurprd04.prod.outlook.com (2603:10a6:20b:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Mon, 7 Mar
 2022 13:09:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 13:09:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/3] selftests: mptcp: check MP_FAIL response mibs
Date: Mon,  7 Mar 2022 21:09:16 +0800
Message-ID: <b25c71079360673dc83687c4a263ad72b412c317.1646657963.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646657963.git.geliang.tang@suse.com>
References: <cover.1646657963.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:203:b0::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c24211f6-c9da-4b76-6d76-08da003bbd7e
X-MS-TrafficTypeDiagnostic: AM7PR04MB6968:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB6968AF1F541AD0D12D8453F8F8089@AM7PR04MB6968.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YEZPEivg8rFyMZu51CiOYvko6Wl54tHOAkwIOLSJkC8/KcRWySnj9H7drPr2qrOe8vFs2rEDLbvMg2iXKi6nRKKRUmH7p5zsNwviNtbiEktP2m+gNP9/odlkEBag1BM+3Ck2NbTUb5JKxO8sn+wCChqxnE2tDJXt87udtWZJ+GsOhYVeicsfV3X6fn7TG5PJPZORwNPfYNh7lnzi8YZ2rSoUg9rm/pAU0aH8hLHhR0ia9OlyxTqJIpB1xZJosmLh4jdPZbtBy/Bra0qwvFydZELP3Grr6lKiDqvGuWxY8NqvVCGpTpjc3hmyNQ6IiHdcYApbqVBX2dH2ArK3a+TP0crnjDBNIuyeA5PlJUMzpx5H5hsPCWsAtK6or8gIrVf7h7FlwKQ+Qg/0QJ63rpk/Bh51Vxu2G4IXsYmM/cWR7iGkaFOiQQOLHkXLsUQ4lmhgLSf7SWM7vOAZVp38U70Xu+rSEq8yMRQzTMDkJ3cOndxu3XYnTwYucB6LrkRAvHidfDfvT9CEQilTh4xz8Naoboe2d2tSENvscbuLR15ugu/G8t8kcaH8I5YEtOgGGYFjeV9qLdINJuoRtuVK2xJf3qCLf8odTbOmOH2C78f0BRHDWba6YTPYuBtbLSWmZsy0Ia/0fiFRL0scwvNGTxgjcBl78ugKw1y/K+9pFNejfWJZa3cbBwzeafmROJK6wpXfEEBZbFeGUhLxzcCoMZXisQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(66946007)(66476007)(36756003)(66556008)(4326008)(316002)(6486002)(6916009)(86362001)(8936002)(44832011)(5660300002)(2906002)(508600001)(2616005)(107886003)(83380400001)(38100700002)(186003)(6512007)(6506007)(26005)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JbvkUbn3twpDzuQV3cjaZKWUHndLfEnqYq14Qpj3JExnwHS1zW1pkUFYyaec?=
 =?us-ascii?Q?6yRGrhVgek3Ja7J9tdn4ti/YsqR+2uKtakxjv1l3FHshVjeIrdXwO9Sweznr?=
 =?us-ascii?Q?qvwbkRgL3FXfyfk8yOcSfnwcyw3UJcUdFBguZQt6QWK2TpZYOF6B1zfb+siI?=
 =?us-ascii?Q?FoZcHrryzCAy8dcnLH0BM6vvxO3UXj5LRDQtX7B4V33/0VRIJfXIEcfCq4Q9?=
 =?us-ascii?Q?aqueAFyRHgCYyXhAAQIvrqoTpzVg8YF6dvpWOSej3c6dPfZFNb5gALXWY9my?=
 =?us-ascii?Q?Sl7Fdka7ntKiRqyK1GMVIeDGjHyBq3eDvAf8ty6CMe6hc5PZp+CttKRoHRFk?=
 =?us-ascii?Q?Vloy7p4iDFi4A374qwwmpfP0EyoV8kioaT5TFYVva8Rk+MfSPg1CPnzs5a+X?=
 =?us-ascii?Q?z5V7lU/9N/AXkXTTkNqvZzKu8umMn8e4nEMd3Ecot7Jy5cbI0qSQX6CKw5e/?=
 =?us-ascii?Q?5sr4XdPvOshl5LBl+cCGrnY6phO12tZRYpwFmJ06hEAg35DoSl4o2aoQim9F?=
 =?us-ascii?Q?u0i6AuOJTkHFeykTGOmM0MlfMQLtpQmBre1GPEnB0G6hHhrUBEdx8qkJ92z+?=
 =?us-ascii?Q?8J2tnt0RF3815IMo8KchocgPWxe+XZU1RWTdhlOJGOsjzeIpz3qRe8V0dARE?=
 =?us-ascii?Q?c6bphHsc30uF/RSMKcVdxTYxLexVlh44ULv5mOls8IgLVte1X1i0bHAkOy+u?=
 =?us-ascii?Q?1LwY2vPwU247WNxqtPmrFMGgxt2UaulQHycoWdzFxW4wt4EmviSTDjYtq/oG?=
 =?us-ascii?Q?nLLlXfzVXKDgt0Uf7hyw2uHa2G71oly8uDVEc8j9BbZM/o+moXKu+x29x7BE?=
 =?us-ascii?Q?/Wsy9tJ2MlcDNZTdSaFCYryQ5JDaj9htRwnXxGXkB91HkaS0v5/+McyJqzbk?=
 =?us-ascii?Q?q6updq5cykLjOwMTyeF7RN4FIOyxNRQtUqw4WdNyj3AGGiILxkKlQ81U3av3?=
 =?us-ascii?Q?eVizh/Eryq0VGQmXoYGlA0ehzcz0lBwnU6TsyTxf9pddKPFUC1XaAI9yI0et?=
 =?us-ascii?Q?8/I9jO4APaxVgW64E1CJso1CwQE13dp/IBbaFdO9KubIFGP8IWwq5YwSL6cz?=
 =?us-ascii?Q?r0x5riuJfAWlIT5knHt04QSnjfr7RcT6ArNXsALbY+YhoMWtsOFLhlDVAY35?=
 =?us-ascii?Q?tjh5iA3iihOuk4hOBRDzAjoyRih6SQ1pxP/rPBl2L/xR3e+kk/oUALOZ2lx3?=
 =?us-ascii?Q?FKhGVBZ+w2AAhgjgs9F6ySIW3mG+mLoNnV26sHjpG1ErkQp+7Um+PfXkUgYk?=
 =?us-ascii?Q?tkqNGvWWV/WF1kaqSsHx9GxPUlFrHJjgcBluNBsv3r1qdI3GGiVWD3H2RNqo?=
 =?us-ascii?Q?JDbtdvPKSTV26SWzZj3zhOOMbS3Bd4IjujYoOZe3V9Jbwl0aLUlkTRqcF1uF?=
 =?us-ascii?Q?uao2GeoXSD6/SRuunm3ERfcSdG8uubui7I0klycEOOkyGFSCsDIsTduiOzI8?=
 =?us-ascii?Q?uiHqaJMdzq2oZpkT8GqXradxAnR/qKoo6wuDRtrGTHOImHfa3ud6v4P1r0CX?=
 =?us-ascii?Q?Kz7WHffP/DW3zEC8SxC4A/fIz06rXmnqPwINyKRs3/k/Qlm3Ame1hnTCa0/t?=
 =?us-ascii?Q?YktzZAYSc/kWdtPaLuPzIfO8Q11LkYfIkVu5BaRecRbXdTykjTn0tRFalBY5?=
 =?us-ascii?Q?y8mhN0tQK8KrIV782RS2NOI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24211f6-c9da-4b76-6d76-08da003bbd7e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 13:09:40.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMKffxZ6zua2QhZeSEwKpiCyVS7pVu7wvZxYDuXB0le1XLnobyvi4AIy+AUyOMTOZjVr11rwn8/CYzXI5NHCUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6968

This patch added a new argument invert for chk_fail_nr to allow it can
check the MP_FAIL Tx and Rx mibs from the opposite direction. Used it
to check the MP_FAIL response mibs.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 959e46122a84..02da0f7bd1b0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1055,11 +1055,21 @@ chk_fail_nr()
 {
 	local fail_tx=3D$1
 	local fail_rx=3D$2
+	local ns_invert=3D${3:-""}
 	local count
 	local dump_stats
+	local ns_tx=3D$ns1
+	local ns_rx=3D$ns2
+	local extra_msg=3D""
+
+	if [[ $ns_invert =3D "invert" ]]; then
+		ns_tx=3D$ns2
+		ns_rx=3D$ns1
+		extra_msg=3D"   invert"
+	fi
=20
 	printf "%-${nr_blank}s %s" " " "ftx"
-	count=3D$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{pr=
int $2}')
+	count=3D$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPFailTx | awk '{=
print $2}')
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$fail_tx" ]; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
@@ -1070,17 +1080,19 @@ chk_fail_nr()
 	fi
=20
 	echo -n " - failrx"
-	count=3D$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{pr=
int $2}')
+	count=3D$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPFailRx | awk '{=
print $2}')
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$fail_rx" ]; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
 		fail_test
 		dump_stats=3D1
 	else
-		echo "[ ok ]"
+		echo -n "[ ok ]"
 	fi
=20
 	[ "${dump_stats}" =3D 1 ] && dump_stats
+
+	echo "$extra_msg"
 }
=20
 chk_fclose_nr()
@@ -2672,6 +2684,7 @@ fail_tests()
 	if reset_with_fail "Infinite map" 1; then
 		run_tests $ns1 $ns2 10.0.1.1 128
 		chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
+		chk_fail_nr 1 1 invert
 	fi
 }
=20
--=20
2.34.1

