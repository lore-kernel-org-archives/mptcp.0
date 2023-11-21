Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9178AC8C0
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QrOVVWDM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xg/hCvfAh1mjkxHsD7XtqMaWM1FISsLGRaGUV0TE4STAmtnDVZgRk1y9lU0bL9fwzke4J45SV12yq3degiZ3lqvp7sMG5qG6U5Zyb6pO2cGBBEoD3UsI60InmkZNhFohp7lMdToLX8j0rmufoCTmHTHjgLf0zm9lSPWh7AfXprAI8/8c8YdMeRg1zMR9cshA+jIfYxhLSZzxZiKMdkNxz6nA9wubkY3SQkrMju9f5wKR0UIJ3jUNM6bYr2IA6IRGG67wjtOdm7pEi1PvmN2FGQyUa2p2rZ9zz3iKP6eWREwbp7pm7msaGDVjKmxNxl3pqSepFLnLdesOnL5UnM2H1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty/FXllXKtTuaHGU2kYiI+FuaBwPLjU6GvuTeCv9M3Q=;
 b=PyNF94mTFlMK2QCLu1/dPRUMkfyLN/ALIK99vyr1FykMr9zZ90d5IlyILutpw8iw2EMoJzxCbZXSKat7jccI5ergrF413L88fdjM1tISm9hVWUfAPmQkpsNYu6KlVsNJPM/cXjNIkSGz3iqEBgp1tn6RM4AnGkXSXomDhHrKxgdmhVshUoTBLBWyLqcqnoWQhG1xrG7Ttv78fNQAuy2SbE/WpxvLqj92xRLqBDuPw3zklW3SX2Lyq6d3sK+MG5s+ONycAVE6E58H/NfWBQoUIO34zCjtpauT1hdX4xaqxjIEU9T3dPXybo1hdgLY0JMoMGwEQHjLkGpzy6sjtGdTQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty/FXllXKtTuaHGU2kYiI+FuaBwPLjU6GvuTeCv9M3Q=;
 b=QrOVVWDM8zDY9gxyXKsCj22wScosJL0PD7iUEgspRBV7zD2L7iZBGzA7+heJvIwmJwpUr8t2iqHt8Hp1qUea0gCmoqdf9brD/lBadNcWMm2jjsmjzQm6boj7p/fYn1pFN3OlQ4xGXOVGnxdlTpBiFa32iKX0BL31pESxJV7sQqBzBhzmQDUuC2S+/n9+1QGflnWJts70fRltHHqaLxwSZHaGKWRk73hQ0lZnkbwqexE/y1SKekpfXMKAwy5mYrXTOUyCA53OcikN7x8ojj4ZYbOI63FT+dUNzNH5dnLmqdVKu7yA85CSym9lGcc19cjw4b9TDldGV8NM3LOSgRudNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9667.eurprd04.prod.outlook.com (2603:10a6:102:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Tue, 21 Nov
 2023 09:56:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:56:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 28/28] selftests: mptcp: rm userspace addr with random order
Date: Tue, 21 Nov 2023 17:52:51 +0800
Message-Id: <52ad9a426bb36948608535adbcd6b1074bf5c94d.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0096.apcprd02.prod.outlook.com
 (2603:1096:4:90::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f22e7b-0be2-4435-60d7-08dbea7822c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6yWh1bflmqmj4GwumbS5aa0HQmzEJZTQ2bqmT7pUaShTlXgdxaBn8uyf0JWbB4CpzTSr97Jjf6BQDshkuEgMfUdPvCPaELz9IJb0AskA7KcR6prQ+zUiDd0sKTCFbMHRhmjoxdCp32H/pmXigI84Ah7SUfomT+HNJ4Hba6sDNH8BZzSwfq/TYbEJs/VGDIPjzka8TrlgamRF2bDYMfBowBPqEo+uYL88YG6VY7pqKybXPknNlRDIAwiO506KVkutMdgz1xZzSb4+3pJNgDg52TXv0DBu2UDNIz8WqpLPghZ4PEAkzW0MZ77la61O/6s1o9Tt1CYfBshLH7ihlkhiiLHYik6Pezd2gmUf3f0NJdLaKoOBVdNmnqfekFkikzjyicVCH91Q4eY2Y1B9DyQiveMrMWqw1ZqWkwBSYZkbQykxyy5Au8cXtGk5ajKA1SrvnMHcjh2yFwdre/JSJPs723NOvDgmGbNXU/jAIT8Q3lRQ2jTwg8D/eHZN6nmYE2JYwH7CqojfEzYmTkAUeo4O3pxUFODjVlMeTTYVW1l0p/d86al5aQ5gbEXwfX0uwEvO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(6666004)(478600001)(2616005)(6506007)(6486002)(26005)(6916009)(316002)(66946007)(66476007)(66556008)(107886003)(6512007)(38100700002)(8936002)(4326008)(8676002)(44832011)(5660300002)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xQ8jO+a/JCEh8oGLd48EY/6n0PrfiloWJUGXyLVZpggyESXjoulK8mwFAV3E?=
 =?us-ascii?Q?5dFrAx8VvyQhhw8qDhmYg4Kz2gxp/iWZvPn6fqlVEzM3fgDMg4yCgsphUPS2?=
 =?us-ascii?Q?P8Qix8/gZ9olxVwsL505Y1VHnK4ubP1o0c3NyWAZaMNuZMMSKAuzBGAtCmM7?=
 =?us-ascii?Q?JZCs4HbMso0qkhhmRuiK3jatYWGCn6T6jU3nj/tI6mqp289gPb3thERgTf+z?=
 =?us-ascii?Q?U4yfBVKgkGhUWQUEqa691m5fvo8EsTdb0lGp3zWchVH6rTUBtDFDKXWycc8b?=
 =?us-ascii?Q?tVobFJjU9S8yMfC9tC6CePDjxa8TxAwR2uIlFf1+3WcBozvY7KVn40XIIpBA?=
 =?us-ascii?Q?1TwjTNiJw2XjeDpafcRxQq2oaefsLpWshg28kE0FVir1xZiwJfYKb3ngTI2X?=
 =?us-ascii?Q?flgTHsXIEKjZq+0PUD3mc1oIutAtzGlLh1cU/e5FCKglDvF3NP06aKoiEH7V?=
 =?us-ascii?Q?n7dzEgQEas+gsU+iLUAofCAaa6nKt5kLVd2+ZIq1Xj9lY2D+pit1VKAiQQVI?=
 =?us-ascii?Q?oXQ/ErmZ/oSIvioYqM3e5K5TgSq+g3TUPB9rhBgjil61W1tvTzxs9efR0J0Z?=
 =?us-ascii?Q?Z3Av9OYYt76Wd+isPiAy2WQ0jm86jt9G00J6gXMpArvJwIUw6NhXFVal525Z?=
 =?us-ascii?Q?BcJFHSeScaWdt3FvZb2Qj7GSbT5LDpgrZkJdw7fiOFuNkSfaz041R5mNdgkl?=
 =?us-ascii?Q?rkQumGkGrmoKc5e5pXF1zo3myuZCTcn1n2jUE3mfCVXedeqMaSt8PjdZxXLD?=
 =?us-ascii?Q?ibaB+tVGQpIEroFULCmpKG5hms7tylXs8gej0QaHwfYr5LOpD9N7UdAc0rHd?=
 =?us-ascii?Q?Ir+s1AHZpKwPm80E5E7ezWJnmNh5Ga5K2xbQlTWQBaq0bhc4NNqpX0Gk5YWA?=
 =?us-ascii?Q?ChZ5xnxNJuNeN0z9JW3XBquOYDm+iQXLRTObfDmxLY96x2uM9EINdAm0WYXV?=
 =?us-ascii?Q?YoZO4FxYQvF0m/y3MS/unauouWF8pCvAY+dtie/xPgHhrSEs4RlGSi2HXhXK?=
 =?us-ascii?Q?77tk3uEvBMp8i0YLEHTPtPp6SNcrJNOXVe+DUx8OQ1sMfyVQaCHIA/wGFOla?=
 =?us-ascii?Q?GLVXkwGaFAlaC1xacvoKmMp++MzQlVPzcoD7zdakdc91JwOTm9NtpaREK0Tx?=
 =?us-ascii?Q?lqtcZfQ0cUeYPexA5+NUeFOd3fSMIMkdo50gXp+5ljTUMijSqurHEUuUgLuz?=
 =?us-ascii?Q?E7O1olYhfyT94aH00H7vy2GyIft/Yo60fQsKIABlLKdTXPEtw5kXIesgg18J?=
 =?us-ascii?Q?UW+tnJZqBjLO8RBQiLgUdaCSwClnygxq/ulgFUmnO82GkuRx9a3nsf37wgk1?=
 =?us-ascii?Q?BpdMalUcjbnCjp4bggYY46PDe4EeQkt3nQ2NQSteQ2b5P2eCiZZkEex2tNrq?=
 =?us-ascii?Q?ZhWi7+3dO2Mu4sSCBM2DI8NgfRmAGz0QR1XqSe64MvPprKGxCBUKWvYOQKMP?=
 =?us-ascii?Q?2yRY0bedImgbnPRDcL5/wjugnMqgtV1K8o7+Q4HSTKP1qumct8cwRE/QCg/k?=
 =?us-ascii?Q?mo0HntMR//Fx2q6diG8mcBUUxXc4RjmNPYTZyjmI8g/1yUGrR0WIrGzV29n6?=
 =?us-ascii?Q?uBL7z4E7tUoWdPWHCk+fjCk/UYcdEOgxzd3br62q80IJEziz7LvoZwl3zACG?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f22e7b-0be2-4435-60d7-08dbea7822c8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:56:30.5585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +degy4NuvaEgrma/qN01XJBxCHvSXrfKisUz2yfzmmqmt8OWXixSJP5rqZd+0dvNuf8/Qqm6BfUtEYFU6yTVDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9667

Previously, when deleting a userspace address and subflow, it was necessary
to follow the current order of deleting the address and then deleting the
subflow. With this series of changes, addresses and subflows can be deleted
in any order. This patch uses random numbers to add this type of tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1145e5f98977..68cf11ad75e4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3412,8 +3412,13 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_addr $ns1 10
-		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		local rm_addr="userspace_pm_rm_addr $ns1 10"
+		local rm_sf="userspace_pm_rm_sf $ns1 ::ffff:10.0.2.1 $SUB_ESTABLISHED"
+		if [ $((RANDOM%2)) -eq 0 ]; then
+			$($rm_addr); $($rm_sf)
+		else
+			$($rm_sf); $($rm_addr)
+		fi
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-- 
2.35.3

