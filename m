Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DA6A21
	for <mptcp@lists.linux.dev>; Sat, 11 Jun 2022 14:55:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1Xv1fwEe50RCT/7saCS3LilhEkGc9vR2FZrUSSkistGK6C11lh/o5AZDJFawC2b/CCFj6pJBoL8aFt9FNjU1rvmDGWw2tmXBF7XYSmCJGRNlXhxayCrj9T5Bg6qfJBif8Fcp6iZkh864gFeuZHmY3hEunh0q2JYkDi4zdMScaMbMBHKHHZBkbG4Gn5Rts6W0hrQOmDM1t4zqu2iHKnRAMSE15tFFV/6UthOo0hOq8H0iA+ZwhIhbz24uR7SSfbD83ZlLor2s0AbIsHoLj9XWfPdife/s0JXgODpch8Bjn3ttLKFnwDsmYXaFYxYIBFjC79SOQM9tU2Zqt2dXasKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZjRFhTo5gEhj19yBmzPdZ6NMbomkAcr2xQHop5jQMk=;
 b=OOCzQfVe4P3YF3dpNDnRTUdQvygGnZqgrLWkD7Sfbn1JWffjVlDSTKZsOn/WAzfCHQ3NQmGifOnsOyxDrU4BDP+zJBXXxxKQGbRYJ/gnNdZ8oK3zJu9wPhscK48+Fpkw/jn82pn2G2Xxc5AvsTyeac4+ll+n19pIURopBJHi4wlw5gMmwA4kUnNnQJ60f17ibRSvT2Ov1lrsgFkyQQMeS7dgZSjyaRI2pMXkFCq6+2mM7VZjEEMhF+z5qcFpLi/haRThQnP8FNegG3ZeHhewdjdp4K3qJ7swLQ+HVRvL3D/rEO1AXDviZuGtHnsCA9Nxi4ujjgA+VRYBS/fmiMKfVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZjRFhTo5gEhj19yBmzPdZ6NMbomkAcr2xQHop5jQMk=;
 b=p1tN1db46hQrUeyQ5I3jnO1Zgu3il9BpaPyp3VerF7+OZeqr6QLOkXd5Y3aethEjCOML9j8hIZIC4Ict8UAg0wWA/OAmQhbQxGmaUnhGxq/eX1JRPNeDs9oibgVf5l+gX0AQHy9rXeWBGD1BOVdgj19Vh8RZhxklaTLvPPSUH2QshCGuq7psnNxC9Racu3p10HJ0DW3zdOUO4cb2WBPo5sx/kdi6Yv+rwEn8K5CJtnn7p3KC75kdJGz+Vtc8Bdw+4QbFPU4J+TxCLQ7N9IY3aF/E2yeRedIBzhb+rMaQlIX3Q5pgCgBxDvlbecdGcO0mosUBGhfwpr9Y7uU4+reA3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4944.eurprd04.prod.outlook.com (2603:10a6:803:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Sat, 11 Jun
 2022 14:55:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Sat, 11 Jun 2022
 14:55:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/5] selftests: mptcp: userspace pm subflow tests
Date: Sat, 11 Jun 2022 22:54:37 +0800
Message-Id: <0f4fbcb36ff483b7fde2529c7512e90f2398b380.1654958401.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654958401.git.geliang.tang@suse.com>
References: <cover.1654958401.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:4:7c::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39c3dfd3-e1a7-481f-fe9d-08da4bba6383
X-MS-TrafficTypeDiagnostic: VI1PR04MB4944:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB49447EFFFDF4C3E6ECAFACCDF8A99@VI1PR04MB4944.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u/yaRfe/+meE2ZMOBxm2uXFmtrGtDlJ9eSTHowX2YTCbpRYpQbddWTWPd+2wQzp9lH7N2PFq0Cav8mn7SZ43TOwWqwExgnTqEafPEGBN8AgvE91BkQ9bqnJ+HXnihTwJxKEAD/CBF1mkekxIe8imChIMdGy7BaBR5YFCnuyttBK3q8IKfl/s3CtoY0JcL151WAw7QY6OVk532xpJTp2631omtOvCgxQre8xYKUrPf8WVhJlrAMm3CfT79FMDKsqVNAxAta9YhGEKXU/PEcyo/qYe7qJzMlTI3HDSOG39NIv9OXWlTcycoA4XJJFK1FDTxNq0rFEr7aQf0xe2Yw7Ft9oqZNIfWTb6DpvEkdD+WoYFAbOnjmtI4JX5Ew0seGGlpdVUzYUZzncNiQ/CvrK/ZV9rRDgoHseWTYk3o0L6f6xgmmhC29CPzvgqFZWbaVc9yH5SNI8IG+6UbgFpCHNM7DbYdWLFiooC0aT28g8kazcstDSzyD1AnTs53yynIyfiIFlFok5vWbQy7UwvC2/nEID5WCl2aLg68uL21WjMPjfwRj05M/BF/y8DsKQq5ZpMldTV5elQGs8wy16BGSdfaLIw5yD7YdtJyCDt/b07YQ5+HVm8aIYKyFmXBTSljv9BDRWJX5VAz3Za9B6cgS/rOw3tSzO+apZSsJVIWF+tDyd9rQYhpJ0UMPhyPnH3UTFwxLLVtVyRaStbswKuaU1sxw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6916009)(107886003)(38100700002)(316002)(36756003)(2616005)(508600001)(6506007)(66476007)(66556008)(66946007)(8676002)(83380400001)(86362001)(186003)(6666004)(44832011)(5660300002)(2906002)(26005)(6512007)(6486002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R10MzKNsciR3COBY0HmxPEwIgjFHTlelqNr8oUb3m0RupXIjyOM/RrH9xCAe?=
 =?us-ascii?Q?CHL1rnaBzNjPwpgWZD8dNZ9S09Ngx5d0QV+RpDJ2yV3/RNdI7ZKxe1Oq458d?=
 =?us-ascii?Q?8hViZDtAAKfxEdboC3RtBKlenxl1/TkHKyKuzeIA6U20qLv8juukSxI8Ulai?=
 =?us-ascii?Q?m/Inv2fktt55kfzpJ5qgvRRyyQM89YgNiWROFBciGZhJag5AoDN1+gbjQRBw?=
 =?us-ascii?Q?wmFNAIZprA+RzpqHQrl75wU2VN+ofFiVsFIUN5fBwHejcDWLAhaklMI9caBb?=
 =?us-ascii?Q?9ljtobAAqihqtoJBeOn9r9fB6ZkvhstuwXaYnJDoK87AvwfjJ1mLg7fP9jki?=
 =?us-ascii?Q?R7a+S6KLl1O2rTq0cd85y0MqmJSPV3D+VH6TqmyDUw3dxLxCvh4Obf7+fYaB?=
 =?us-ascii?Q?MhDFcrgb9QG4S0CqBGCKcssnpUIGQrhY9o9jMeAr3BYlOXzOfjugxu4qqcOH?=
 =?us-ascii?Q?RJDlbgRr7D1RWF90un6/KTsHzjNWXMjd2AUngdn1TbhpmDyG2H4ZrBYD2fTK?=
 =?us-ascii?Q?BndeHNNJOGq+LyJC8NU3FnwNuEEb64L9pgJyGdZPw6F9daz0r6JzgfQlpwiz?=
 =?us-ascii?Q?xmkVbsZkceoJ9SaPZO5GHCdEjNMrUWruimKkbgWcJ2aoNl10vcO1t4UH2hTb?=
 =?us-ascii?Q?lG5Yx8H1OZ1hIQ9b5YNe4OlcNeQjTMOIU7QoEZ1fIzNT47Bxv3855XtvZAiy?=
 =?us-ascii?Q?sTXrnWbm38NS2G5ukRaykykVobvC3L4gVOeC0HRWomwas1/p8Yl2y9fi0WOJ?=
 =?us-ascii?Q?O9yMCwd+vI6EpUqdfYeynyjtGteK8egD4x9iQb6IBASul189kxb9F6aIPfJq?=
 =?us-ascii?Q?SWRd6kK+vuCr+xxo59wWM3aQujOAALI0LAHR2wVYsnvLb7N/Hdz0E5PUD2eG?=
 =?us-ascii?Q?HQR4ZND8JoOm9VpAcUqBxkbyi7bd5IQduMM6ralUGH+wZnQ3UBDasxXvjkKD?=
 =?us-ascii?Q?m3iJTVJxc0M1LTTrZvsiJe/iBsYKM2kHDaAM/LAsf+GLfkcpgGZCv1AU7oxD?=
 =?us-ascii?Q?Ko+C34QIoKWcGT+DwcPvfCrAK9Ab0Kw4kitzmc8agGjwkcxd+nNz2BoydHV7?=
 =?us-ascii?Q?3JWKK4+dnevcnPesHWjaPrAUrFDloyAwgjXttPH0W2Zgwu3DryWQGG3QrKg8?=
 =?us-ascii?Q?MEIsEztPOADpnHUqr9pb4g8lKbCYiS2/fxKa/IATcRMkKuxLftoId+N1Iakt?=
 =?us-ascii?Q?94U3k0thfHwoSFlXmBmkm/a1sZb3QP2Tvh5j13zuiFFzRb6pGmSPCkwhmHwe?=
 =?us-ascii?Q?VsT2iuqu0sf9uZUOXjhzraSREwRWIcCXzVE0L2/g3Qr3+ybwwQ897AVEvGLh?=
 =?us-ascii?Q?RRHRjFUpleDRwUFKc8kieJDFFfZcHYHL+I8pmNNSnMhtWOJZCNBbLgOniq4U?=
 =?us-ascii?Q?vRxXA4PEpxlcfZpO9DDnh95KR+V0Pa6g4OAoBKeVuAn5E1n6CkKgl5TxJubX?=
 =?us-ascii?Q?BSd50CZ+6FJN8LHZBms6sNeWXm2Cqn1cIAFfNIP5IIIlJNZ2jJVCYfxIJTJg?=
 =?us-ascii?Q?OA6a4ZC6dzLzDkoc8O/i0Co3e8S0zNujSAeorA43/RUSEAsbF4OCn13zpVir?=
 =?us-ascii?Q?DHVdhCFRXxQSuH9MEVWqZiKxYiAnClAr7DLnKAA15zAEtbFLGWmqp0uxEj7D?=
 =?us-ascii?Q?3q/dFlIuipWXBUgPmlIYaKWID+8dYeCQdyb+lGEPxL//CXReAGYa7qJPJ0u6?=
 =?us-ascii?Q?Zk76HBMpIaHsyZ50/OnnVgC+pwbrer8Q2iA3pobhfx2ql7JAYT4G7DjLRtbi?=
 =?us-ascii?Q?dj5R4E8fd7KknZrfAuPYQZKg7nc4nLs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c3dfd3-e1a7-481f-fe9d-08da4bba6383
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2022 14:55:13.4910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4QQUX1lJDmR4kH8YVLAS19DyFHWWsAMefXsFqbn+Ef14kju/nquXsakkG4MzDuahADznU6Foyx9ehk1p3+XJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4944

This patch adds userspace pm subflow tests support for mptcp_join.sh
script. Add userpace pm create subflow and destroy test cases in
userspace_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 41 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c3cea1d0d245..6bbe6e8ef51a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -657,6 +657,8 @@ do_transfer()
 	local userspace_pm=0
 	local evts_ns1
 	local evts_ns1_pid
+	local evts_ns2
+	local evts_ns2_pid
 
 	:> "$cout"
 	:> "$sout"
@@ -702,13 +704,20 @@ do_transfer()
 		# disconnect
 		extra_args="$extra_args -I ${addr_nr_ns2:10}"
 		addr_nr_ns2=0
+	elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
+		userspace_pm=1
+		addr_nr_ns2=${addr_nr_ns2:10}
 	fi
 
 	if [ $userspace_pm -eq 1 ]; then
 		evts_ns1=$(mktemp)
+		evts_ns2=$(mktemp)
 		:> "$evts_ns1"
+		:> "$evts_ns2"
 		ip netns exec ${listener_ns} ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
 		evts_ns1_pid=$!
+		ip netns exec ${connector_ns} ./pm_nl_ctl events >> "$evts_ns2" 2>&1 &
+		evts_ns2_pid=$!
 	fi
 
 	local local_addr
@@ -830,6 +839,8 @@ do_transfer()
 	if [ $addr_nr_ns2 -gt 0 ]; then
 		local add_nr_ns2=${addr_nr_ns2}
 		local counter=3
+		local id=20
+		local tk da dp sp
 		while [ $add_nr_ns2 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -837,9 +848,23 @@ do_transfer()
 			else
 				addr="10.0.$counter.2"
 			fi
-			pm_nl_add_endpoint $ns2 $addr flags $flags
+			if [ $userspace_pm -eq 0 ]; then
+				pm_nl_add_endpoint $ns2 $addr flags $flags
+			else
+				tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+				da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
+				dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+				ip netns exec ${connector_ns} ./pm_nl_ctl csf lip $addr lid $id \
+									rip $da rport $dp token $tk
+				sleep 1
+				sp=$(grep "type:10" "$evts_ns2" |
+				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
+									rip $da rport $dp token $tk
+			fi
 			counter=$((counter + 1))
 			add_nr_ns2=$((add_nr_ns2 - 1))
+			id=$((id + 1))
 		done
 	elif [ $addr_nr_ns2 -lt 0 ]; then
 		local rm_nr_ns2=$((-addr_nr_ns2))
@@ -919,7 +944,9 @@ do_transfer()
 	if [ $userspace_pm -eq 1 ]; then
 		kill $evts_ns1_pid
 		wait $evts_ns1_pid 2>/dev/null
-		rm -rf $evts_ns1
+		kill $evts_ns2_pid
+		wait $evts_ns2_pid 2>/dev/null
+		rm -rf $evts_ns1 $evts_ns2
 	fi
 
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
@@ -2853,6 +2880,16 @@ userspace_tests()
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
 	fi
+
+	# userspace pm create destroy subflow
+	if reset "userspace pm create destroy subflow"; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 2 2
+		pm_nl_set_limits $ns2 2 2
+		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
+		chk_join_nr 1 1 1
+		chk_rm_nr 0 1
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

