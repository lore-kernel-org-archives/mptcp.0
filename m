Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150083.outbound.protection.outlook.com [40.107.15.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399AD7A
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 05:02:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQPNyLHlLBikWwcFY9hM6SDGHahKidEIK+zmjKiwsC2wXZUVGutsh3jFqW2QNeJHQ47xWcDgkrdvrGpswpDBZg7niTZ+pIEMSSYkMU1bmAde5n5Yj6/Tvzs/Irrg52905RxryLcTc4hkkpeuFjBdk9TVLpB7kYqD9bs6SVmyXbqL0YJPFfgzdPOSCncxS6Zwsdfs6LLtZhhmdwbPe19UHrm6TbwluhoGePEPUHUjBivPl6JNC9QOSRt6cO65RA6B7eckqEZlpnqlDCk+qlUyuBAJhZxIT3jU2T3ZXF1ARYwNPAQYYNDXXgpyrVPQ6Xm2xqA0kQTdDkJ3fFGlueTabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCPk8Hc5W8xmackIsis3ojLe6sFPfb8X93AIiJr/vH8=;
 b=CZwNq6OIfkSyF/i5d7+6CYW8ct7JwGmjfkMWnqpRvm0LKcdhlKUFiFxVGAcK0nqUb/Ouq39SfgE1J6sWaTfz3ZO8WjFm5dCzty54vOJMh7KOaMd7aUGPU5vOuR+mVh62YizOGW0hNN5dmmABdChSjKc4HAK0UJObClHdN5+U878prCZPqfKvHBNnJP9/MCczQRM/TAjwaCVjIk1Zsa5pmu1Zfxuuz8UVaBveC41VKF/8Oizng6katY+i4TAeXci0R/4rkx1Jzqwe6omf49JR5Nwqdh6HQSviR5++9ud4I+0OjV08yCr3vGH7xVWf+Kq42UNQst2khmOmdLHVLIj0eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCPk8Hc5W8xmackIsis3ojLe6sFPfb8X93AIiJr/vH8=;
 b=mZGMDsIRts+SGo2ABpEk3jx7ZhuYQR0ArDAfsh8VgHBlzxAWgU1h5ykD2qdsqW3IuFS+nM5XlYbJi3kuesQlv+oT7A2djCji4osldMIi8JH64vY5AARUY1HtkV7rvreoqpTajJQEWwose8qaH+L5s8v6chFeQXu4ZSTCjg0HQCDLst8/ffLPNOnBvP7TwmCyfP3yg4n7tHUr8u4S1q3nIthYxmthJarvEjI2wVfqP9r6JcUt4pBbOymMB7ojU9wENLDXlC449YvE962XO54TPMKmUo6sBw+AUOZKxAPmrZ3B/b+r1xHBjuYEhwP/E7w7eFkXj7jqDvwhXhLpGs3gOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4720.eurprd04.prod.outlook.com (2603:10a6:803:52::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 05:02:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Thu, 16 Jun 2022
 05:02:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 3/5] selftests: mptcp: userspace pm subflow tests
Date: Thu, 16 Jun 2022 13:02:24 +0800
Message-Id: <3fe28e031020b282b23e906b1095f1cce16af111.1655355422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655355422.git.geliang.tang@suse.com>
References: <cover.1655355422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c9df6df-e613-4747-17f9-08da4f557866
X-MS-TrafficTypeDiagnostic: VI1PR04MB4720:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4720584D3310685B7C1664C0F8AC9@VI1PR04MB4720.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rMzU9nbwYjgIytA5ZrqSxhLYgyp8aM3wBwDTa7dDaoAQ40DnRW37IgrSbX+UWMS0FkXtZiyMsNETGCDMuYtr2kUBPc0B+JufZHSB9wZd8lOEcaTqtBZaTBDNBNvoE+aB7NLPd2cG5tLSFZRv5QLY5Qd0WJjk3tqjG9u+Mp/jB+Qj9sH9L1omO3ZVzAgY+nGct+0jxITTrEPsDgcJx2jrRaD23hdKZgsiD2QkCScJRftbImYu8/b4568vsWlR6FOo7b1T4ZAmBwmalTV3RQD1Bd/BwZKI1mZosLLZHN0do0Cj0RQpLdDTp0sFsjh5nhe68L4JFS1CnWX2WWrFhoRFYaMarsPNv5DRrskTv3mmVAfU2pDFWpFo9nElqq9TQSzaWwLEQRcNwxZWWOIJYHRinrP0RduDqRX7Gknhq18p6G2ksLWQ5ZjeXROaD5qqtsY5NEoKbX1rpMiajEzh3nLqT29w78nTiufP4hkhsZ+AvOFtzDX1prqijae+EDC80NnReqHt4vawaoLNIZ4aoI47D/b5tXiar3490pm/rM1wiJZm/EFTJ9r8kq35YnT/YTYMFWKuiUiJZyQnkPmP8v0sWszB5np7zvBs7y/bX4I0+bVAVOwbHgTiDqqovZhCuznsuDp8SFk2LTcNyUGHjK/lBauNGvG+rCCFCYcVZSAG82zMuqhK6F5pzm39cSst+CrljBiiunb2NlFVoKc59gh3dw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(26005)(6506007)(4326008)(66946007)(66556008)(66476007)(2616005)(6512007)(86362001)(2906002)(6666004)(38100700002)(316002)(8676002)(36756003)(6916009)(8936002)(44832011)(83380400001)(508600001)(186003)(107886003)(5660300002)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RxLqGseR1j0jXKTAntw5yAU6AX1vYEsgsjuY1UZw8Ft4etsIFtNG08PxB4eV?=
 =?us-ascii?Q?acTkk/sxw+LDPMYwXkrq+/Q0BKKESXdgiOdpWBa3EOxZUXG/147Pxggy+aMf?=
 =?us-ascii?Q?wc+GJwGIhw24czgF+rDx7nlVVzDjPTFFF9f/zR84KNptKKNA7uPi8BjUL5BA?=
 =?us-ascii?Q?KLQLSquwZAagxy2bYzcyVoByjA5AjrwjiWIqXaMq90EkL+hUJvC+AdEQr2hV?=
 =?us-ascii?Q?HgpPJyV+PKfcB2odiMsEpwWYJ2FW3apn/vBRdGLI+Ihzrl2DbB5UOUcL8RJf?=
 =?us-ascii?Q?d9z6lNCIBg0aoFd2deLfXSerYRSw4gZWr08bEo0cIGZ/l6EFsNmOhELEP1Yg?=
 =?us-ascii?Q?Xt967blLXXMpQy6x26qIJ0csZdNGCrIYLMjTdHGXg7L4xX3A9j2Uu9Clll/T?=
 =?us-ascii?Q?p8QIEJKc6g67KHaDCjPHJKuD5AWTpBRqvkniSynTM5vUcht2rH0xyIjGtGfD?=
 =?us-ascii?Q?MqoKmxBxw+xml2AAfLoXtDbT90v1ym00Rze7hl0h01hMv0mgCBuXPV5qjgvX?=
 =?us-ascii?Q?Q1rDQ2ULdNRyawwbrPkvvp7ADM3yQawv6aP77HdEJ1LRE2AoFLtB14p2DV+D?=
 =?us-ascii?Q?WGa+7qwxbL82BGM8Vzt51UUR3RJxVzO70PKC3fxFu4BV8A29SBzqKC9zidN3?=
 =?us-ascii?Q?y6K1aiGNZk3lwZQ/bSPjR6jYWtusBihK7wGn2Gi+Bh/kZJMGDLMtw+Y4/Hqy?=
 =?us-ascii?Q?KO/pzU7cEPiOIaWQ/n8wHacL10M2G18qZU6rB3qnVe45FT8CN2YwiXK4i2f9?=
 =?us-ascii?Q?+5+88fdeAzuz+IbEahNp9crRtCTt6KoXD/IQGiNW9nF5MQJjnPKxrZxT9icq?=
 =?us-ascii?Q?SpOwRY1g+bmx917vzDQj4g9iYS1NPHBEMOnRtXHhZ658GiDKAm+Cm5ZmGErr?=
 =?us-ascii?Q?EgKnB5jXdOo9OSpTRtRsPmLVshEl0vBxBQrUqU571ks1xSGy2te6OXk/8SFy?=
 =?us-ascii?Q?zo6CrQrvvCAyFv1EUglBLx/UIbQspqSduqO5vCsEXtE0lvcUJGgokr/ER5ya?=
 =?us-ascii?Q?dXK2+6aIiwz5VLuTfC30rq2Oqeyfurcpq+Yza3aVJDqfdHkUsEII7nAXJMY+?=
 =?us-ascii?Q?u3HOSIoijv9PkHdMrRu6vMJInas8xIXhAP2LuHghaSquiqfJIvoPuvVtdUgR?=
 =?us-ascii?Q?J3R8G9UVv6XPFBd4Tx3k5WuNOkYWHkCh57jkywfJq7PLhLzNzqZ3OihUYEz/?=
 =?us-ascii?Q?wjgjHQ0VXTI0PfZ1tFh7vjDIwvEpgbrNWX52cGRuoAWmWS26Uj8ZyIajcpiG?=
 =?us-ascii?Q?Hh7KdpBPQTI7jNeJVXgNzGqZ6Ahse1vBFJ0SXmG5KzbFG08eK/dM62MGKAWI?=
 =?us-ascii?Q?UQ3U4WtaauLXQg4XymIqqRbEtwRoFUgQ6/gfyMt8mtVK2lr4/2GZty9VHos7?=
 =?us-ascii?Q?s4Q6b7yXnpmAxHAelFASglpZzkEzrOtCu2rMRGrUBSIViw1DcchiFGQ5b3iU?=
 =?us-ascii?Q?Qjs3iP2oEJeHP1bRmjHEpj7cmWwk9xYDT7WTWHTwQ0fl4LImj4eS/vk9lbhV?=
 =?us-ascii?Q?k3FECzNmvP/peD0/8WVB+gKTb2kJDrpGih2c1xogUaQML+GelYhp1HwCVdJx?=
 =?us-ascii?Q?29oIRT/6QH1YgDBA/z+i8yzsQywC53QOzY9Y7nijYt9G15LQ+3JU78sBfkmD?=
 =?us-ascii?Q?TyxpT+Ocm6njGxLLfqr4buTEO2D04NFi2Sl4rxTtt3FNUpkCUd5fDgEw2lt4?=
 =?us-ascii?Q?hlEOqFVJrQ0+MwtQ7PHu1CLo8LAbLOz0No5k2OuoINwAOSu6HCbxGKadq/Cx?=
 =?us-ascii?Q?K9EqN33TtyaEEy96YzDgcfeI+YORFF0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9df6df-e613-4747-17f9-08da4f557866
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 05:02:54.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvMEEgAq8iGaggvN1g/Pruo6sw/afiXMqAeCn9LFlz5mDepGbtfeWqwt657fDqJT4WgejNQJLCF6Do4LzcUbpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4720

This patch adds userspace pm subflow tests support for mptcp_join.sh
script. Add userpace pm create subflow and destroy test cases in
userspace_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 977c59c540b2..bec22fa38415 100755
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
@@ -2852,6 +2879,15 @@ userspace_tests()
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
 	fi
+
+	# userspace pm create destroy subflow
+	if reset "userspace pm create destroy subflow"; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
+		chk_join_nr 1 1 1
+		chk_rm_nr 0 1
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

