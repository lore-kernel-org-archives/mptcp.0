Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60058.outbound.protection.outlook.com [40.107.6.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399947F5
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 01:59:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lznlyzTrAskK8JbIJxeVouP+G5V2Q+GQBdGd7Y+rJbSwRrBJNZ/Qz6kD6iAPgx76e9Dz1Zs45lJL51VgyFTb8CNv5YNR1YVX2xLTRGE9vShh7GFZuKUhtUseOEYjqTEy2rx7B5XE4a6kHPfJcZPR+h2MNg2pT5tRSxOLzdcEX64Bl7vwzVmoyKmve+YLVItNEgH0VwWCj/Lup2B3Go4ABMbaA2YqggwfW0SuIJ03NWLRmjldoqAce6O7n8ekBetd7+hpbpNSOjDBPRX9fvcYVhz/8sHRklQ20m04OR7Tywg2IL1biRAV2ZIWLoSY2IzVjqotJB6+E7ei38idViZorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPfCqOEC17AJ+vjZlotadbzv1d5dIPq1z6/PIjEdwQk=;
 b=ctYlez39L6uK6s+tf3IX3mzg/2AZ6Jv+1ovkjgSMSdMnho26lFm5hTDVcF46VGj6z1yIOU499l/8RAqpcGZqf4Rz+z1WhG+daHnqueGPgNSctBJdvR03WqSMPlTgXumXVwO0JAmLUMO6RjzB+B/+fjxTB/h4bGsMHq2zTmVs88bSZI5wZJsrIW/y2uwT2i0fnkTxuLAkiQ+8F5bUNm/CKK5hmdSG/s+vWlEMyQtTrDFW8/lIRFKkmsRy2lrokJBo/RaymCTAZs9ZyIuwxvRy2YP1Whdgo6pTI3WsW/sewE/CV4uHPEk6ka593xGigYb2Sm20pxDPL543oA4MX1HZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPfCqOEC17AJ+vjZlotadbzv1d5dIPq1z6/PIjEdwQk=;
 b=Fn2dW46bWjjyxZuYYIOYqRRP0Rs2d0tm7+3+HbR5eIYhQP8ylb4grNo3lxLFxLY+lSUNy5GVD2KmwW7kAbBTTlNYt3kBm/pRkaMOFMZlbbXgtcHHkYy9cSWMV9n0LqOeA88AO4zEkLKTgQLq4Ve9QF0Afc4PZUG5uNpo8+Ps0wFdZylTE6vxcS0j/O2FgVaY9SwSfJ0bYIBNutHaI1wdmf4dEaMKJoXOWcJ7BZWShlRkd3hPV/anImu/DPZUWFgZXQ9zJDig2ldLupolslB4f3v0kLlJyi7SoFxHJKdAwiBv/YM2CXsCLW/pbffHjCP7XIP1/WBncMDz6SKCotOgcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB6534.eurprd04.prod.outlook.com (2603:10a6:20b:f9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Tue, 21 Jun
 2022 01:59:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 01:59:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: userspace pm address tests"
Date: Tue, 21 Jun 2022 09:59:53 +0800
Message-Id: <6f64d72dac256f2dd6449f8e75c14c98c46ca631.1655776730.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0240.apcprd06.prod.outlook.com
 (2603:1096:4:ac::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65750af9-9056-4f54-abd7-08da5329ba53
X-MS-TrafficTypeDiagnostic: AM6PR04MB6534:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB65341529E85A6594905F8B32F8B39@AM6PR04MB6534.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4JWXX5U+GaUTxGTJtvzGir78re/ZdmHjvdUyUC20VxJSh2/Ko3Hpt52KQ6PzcE8eq8fBiK+oJFQ+eRRCB9fojN8bkpo9HwtpcGykVhT07i4rzKaEiLVU3g8KVT1VQ97FmJyjy1/eJYrBl5taSARQPro2SJUVPG6YligusaK8uB9x4DYJ0xxCi1UKvK1/lIgJhWl/3yRcpjilODdtjlHDyobhSpjkj8mkwt/NAAGm0TQdYLqXSCqiCzICNImPt7CJcurF2DWwOU89nHH4px1jARvHScJVnES/uPUVRmkbhILICOfNrrBZTkjb7wcSwbNy3CFGOxQHXKlx3LgyauUyzTmDXlIPhqOblr5b/Khb7LZ4NX4yAHmZO+f9fyYYQW8CsY/mSeNgsUQDprHn6xFCAKAS1QqDzLghH75++EmaxNDu0US9JwcrZTDp51kLFktfpGkntT7RRWbszs+W+cZEVlBpKpKJmG7xa3owwYJD0XzBD+Lvfc9Cn9lgx9tB6v3iYENbdEZeenoNnJG1VTqnjPAp2OUtazmQ+xfhMj2lSLDOf6YhhMKGam/FMfTwCo9q7aua1NdtL0/2MIwB+3Nwk5rC3VKLgpPRtEYtEsUAiQXX4Tp6b0i3aeJKFzAL4jU8YEeiPMdglAVS3SpfjZNrV8jpt3Weo9Ntdy+SRbDCHfzWp8onIZsci30+D7GNVUrS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(136003)(366004)(376002)(44832011)(4744005)(86362001)(6486002)(478600001)(26005)(6512007)(8936002)(5660300002)(6506007)(2906002)(38100700002)(6916009)(2616005)(41300700001)(107886003)(186003)(83380400001)(8676002)(66946007)(4326008)(66556008)(66476007)(36756003)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qhBEmt2dZQMeQAy3I/JWXnrE0VrV/V1f3oCkTgUStRUljA0JJ4B1zW+kk+M+?=
 =?us-ascii?Q?QWZyDJ7jncNRzU/ANQhuGJdlqDDq244nKCftLpk6DTvmBrG1Kv0x0PFAhhBt?=
 =?us-ascii?Q?a/gm2fW6IhYSbVOy/pzLQhucFR64Sp4tHeOi0xbrTerQiWRk6av0LIgfzttj?=
 =?us-ascii?Q?wAig7dyLEtB6N0HpfV7Jjdl0issjPtVFkQmsLqAXaqBXeuvY+vMMH2dzCjIX?=
 =?us-ascii?Q?4ZTkrFZc/NQ6CJvdwgIirQHOidJyWGKFc/gJvF3obIFUPSVTYSWIex2V4Khi?=
 =?us-ascii?Q?68mGdsUtsECe5ip1Ujyb+99Ds7v2ujZPktGqNLoW/8VZdU+tr26panv83+4B?=
 =?us-ascii?Q?A48CGWl3Ob/wWWT4OQHgcPftZv6PquM2qmxZRuh+BZ8Xb/p+BpPIeMh8MnyP?=
 =?us-ascii?Q?L5iuqDfbAJ/R0azjgE2SML4BzgoxhQWomJ4L0S/9KASG44BBSfI+U5cpwhvo?=
 =?us-ascii?Q?j4QqEoeKQk5ewsk8tWfpJ8+YtDmVOucz07OrdvpWqmKOshmRWEUsvRubVNjW?=
 =?us-ascii?Q?jaiqIItNV9nUtatNhCW5hyOeNKz9SaJ4jjsEkckinFNqVaRCufxibLPfhKfL?=
 =?us-ascii?Q?gTzRsfk7fzOlS1a/7p7iw8Re9F0RLmEXCbx1Z2O5IdAsSEqwBRCZpgc38k3r?=
 =?us-ascii?Q?iD8cHs96FTceq57M2S3qNrMxVhfwsO5uKd+1Rew2mVeQ7cAK/FUPUeTMXj0x?=
 =?us-ascii?Q?5rt2FdghRvbSGsLWsk3LV7tAoMfPwz4S8XIY0Epun+Bss189qx9oN+dCSsAT?=
 =?us-ascii?Q?tWqoLxY4hqxj2ti1XkmMA1fOyEI2M8FDRfyC0hc5XShFV574n8OVfnOTUuMc?=
 =?us-ascii?Q?mVC+9taLCGsjLbcgOOeyWP7iwzsGJlhFFFeTGoIM2CocDnt0Qls+NvAB0yjt?=
 =?us-ascii?Q?hNxqIjvm1Q1R7ZqoNiZUvAPIr1/7jXS5wNl6GlETq5H9FqsDmnCIweY8+Sm9?=
 =?us-ascii?Q?/2/B80Q5zCIqNmm3ra1iwENHzYfiuD1+fpT5fjS/5yh7FOiR81VKcDfXh8za?=
 =?us-ascii?Q?ZAxkGtL6RYgx/iObj2bUPgmhMecnrLzds8rqysCrrBymLAlHPXc8OloNQLQ1?=
 =?us-ascii?Q?lZ4Q5vbpCqFbOFmPi1TIXzMFCbgQT/TgXYTDHMMO04hjBX0+P7RGIE2hJuoU?=
 =?us-ascii?Q?kyHvlc3QaRvipYuFquQESMP5hy+fTVh9JgRtXPhmzzrVRsK0UKY0JgI7FXAy?=
 =?us-ascii?Q?Vw4zw8B+qeoUXPSrZcAxkbvncyFntoQNJ/K2nIKoDfqnJmECDYwPzaDdZ4JJ?=
 =?us-ascii?Q?ENb487pF01r8x9QQrvP6y63QokvpbAhuxMJH7+5d32zmKVkgU6S+tcGrGzZ6?=
 =?us-ascii?Q?PizT7xdUU0vEB7I65FAJNtLuelqM9Q2l5t1ODRrT/66Tln/QB9z0s/bbd3P/?=
 =?us-ascii?Q?fLjYMEPbXGS7eLEAp8XbIdAoR4Voz9Nbm6SGPEmTUJY38vbBSqmPZ0iPLa9Y?=
 =?us-ascii?Q?6x0uSAUzfs1qVmDvyBMaLTDQhD896laxCv/VsmUTyWqWuZ2n/Yx5e+46b/J+?=
 =?us-ascii?Q?kVhXpn4+hBoi5FBMi/Alhxt+zkaxaAABlG9BNbfS/ZWjcSsx17RIP902dBbQ?=
 =?us-ascii?Q?0jRkDMoltfZWxnRmtZ4k9ly9TH4IBVyAhf/jAp8jLecAVeDn0UF6F+Cbcj/F?=
 =?us-ascii?Q?xPA3+nwuGPeER9vtKs206vRXEe17cvzeyvQeK7NYdcYf9j9PFahmKe7YdKbM?=
 =?us-ascii?Q?VDyJFLOMegA+BZ5/zTxBeqPHwWCl4b6jIXToEmCZdbnGLSxsWGCLMN60mlqu?=
 =?us-ascii?Q?6kKhUVQS9oat10/9asBKI13PNu0AHvk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65750af9-9056-4f54-abd7-08da5329ba53
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 01:59:51.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/a106pi3hkUb2U23nEvRTEg9ObGVBB2ufpzkxvJzgbPFSUu5d4UC/isvy9mi5JI0jjtW4usTr+3Yut9CowWZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6534

Use kill_wait() helper as Mat suggested.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 977c59c540b2..d889e7507cd9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -455,6 +455,12 @@ wait_mpj()
 	done
 }
 
+kill_wait()
+{
+	kill $1 > /dev/null 2>&1
+	wait $1 2>/dev/null
+}
+
 pm_nl_set_limits()
 {
 	local ns=$1
@@ -917,8 +923,7 @@ do_transfer()
 	fi
 
 	if [ $userspace_pm -eq 1 ]; then
-		kill $evts_ns1_pid
-		wait $evts_ns1_pid 2>/dev/null
+		kill_wait $evts_ns1_pid
 		rm -rf $evts_ns1
 	fi
 
-- 
2.35.3

