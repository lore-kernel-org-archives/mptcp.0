Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7954AF66
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="p3xdzFw6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h13eQ/r47uz2PV88MJD6sRtLrhNZE3tI18VtUppSon12jf2LeEKMJqXxtdP8T+cTZqYoFFAsRUT3GFZ1XnFRV1tv+D44racmMk1kCzul2g9SZ3Mu3otxa6mOFPf0gPSFGhqbCafdk3kqwwc4hFaWk+laMEBZIIxjul3rzzo0JynrmR8mpPXDKhqlkII0er485E9D4F1MlmovVb3ruBb5+Aq+JI1d0mB+1rjMpv+d52LnE68VnN/TPbVZspYrHGUt635moBNPbkBT2A+WiEs0HZeZUDEREnyinoCpvK9MIRNThGw5kYDldxNJHGSDRTYIfhhtT9MbbTNv/bxAit0bWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T38sL+r3/wWcw1Yc3opwLZGblto/rvJgRPxzV6SkvKU=;
 b=g0StEwivG13jog8OUdpKbm039DQUpQUW44dopZq4u3ItVNwUjPQPsomsNatbalXESph6tw8yR9gUUjSMpLdxjeB0N0+babv4ntY3YwwOKg+ghP2sTOQSYGPzxnV9EWpFx4jHYfE0ZcPoLlUl3iZtIzecH2KtN0Prz++6MasEIsCZKdvmxKCZMJsMWXxjoAgxIIHORJSYfrdGPTE/7X1RTq1mUbJJSOoOtWElv+0eoum386RGVMB9rdnRK9xx3ZYmn57Z54/31O0r5U0x05JueFKEcgUi7U+txtRZcfuzx673f5apStgVRZyVECbY2kVlCl7kT+y1ePLaA4yypR/d2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T38sL+r3/wWcw1Yc3opwLZGblto/rvJgRPxzV6SkvKU=;
 b=p3xdzFw6YaoecwFcuh7RO5pylIBrWEASsFH7t5+igGtRaE6/De1mcao8NZOFDyirKizzihi2ae/RyxjMZG9HXcsXyUm6Z4ttXoN+kdGypJJ0bdhAzO4czqwwWbmIUarYFp5N+m4pzupeVyMCw1/LuKR4M4iy8b0YOuSWl9y06kwLFSA6EC/nhnZ7t/INRY5v+fYdmiUvFyIuyDeJnLJ+B1w/vQ4R7IYOYKqTLe5q6TdofjfDf1Ws/fQrcem8FXfCG/iBtucPbc0W14l+ZcZy7BrQsJbQHGk0iIGGZ8na2kSkztHdYamFAGWOi4kX0p2BwBg+f7OPOBbLI/eC4J9Oeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:32:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:32:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 12/33] selftests: mptcp: diag: print colored output
Date: Wed, 22 Nov 2023 19:31:00 +0800
Message-Id: <7ef9aa16320a8221786f2ea9490f6cf1c36bf998.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0023.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9c8035-afb1-4ae0-c467-08dbeb4ebc0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RqJhwfk8qYPjYCN2fTeKpPkJbRgM2IW9EVdh3zCNm/SNJjGvrczZ3r2Jxm8W6vG/Bygg4U+Flyte8X70vmzHO/pxAbD+DW3HJwGrwJjS+hkOqehKFiDNTntxQT0ufQhuzYA+iVmR9Pqq0XDDsPA+xgC9FC0JJI/iW7Pzjq6znv2TH209w1EtLISAh4xpvLsVEc4JL10eHrAroCzZyOAKXsdROoATFY35RDcY93iJBrn8YCybqoqV0vJ/oyBmNhA3eMbx4woptAc8Sl5ouup75YF9hkHaBGRhqLu/WoNM2icyznS9QxdrG5HiJ/DV0n7ZxEouwFYicdfRK7N6IkLlRnL2nuNZqI0RUiWCuA8YkX2TxxX32hGnPI9vcqTlsRFYCdOPHd4Ayorf4mvLqdOTphkA4pYIn90MEbJQbt5CYRkEPXy4Ved5n/P9VU8q/USjVtKpVOG9AxeXOcwmfo+9djANeLFe8Sd/5oDnJesyWlckb9ABB7l9+dOVjTN+46Gc+YegSURB8W51trqx1VHtRIdW8BDzBYaiShmoFjWbOL9Ju8DvG7LgbYuoSAGOIqnOBXCRQNiE2nPvVztw6gplpdkk3DTGFKZHQTrXSn8Q2rY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(44832011)(2906002)(4326008)(8936002)(41300700001)(8676002)(66946007)(66476007)(316002)(6916009)(66556008)(86362001)(6486002)(107886003)(478600001)(26005)(6512007)(6666004)(36756003)(6506007)(2616005)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LQ2EuY9h/Bd1M58XtyttzJ55xdc3F7b9FRjm40bzsAs3Vm+fnSzU6Jgmig00?=
 =?us-ascii?Q?nRGlKH+en0YwwaWTPoe5STxJ8JGTb4C6fn78iFH8l8jWJdOV14QOhexgxxsk?=
 =?us-ascii?Q?MiSUOW11X2kwJbKE4ug2HjwYYPHOlYgEz/Rc17GKJFHh2QRda+77MCZHh1bs?=
 =?us-ascii?Q?RQJtFHx+dxDIb9azaBN/WWZNhUAvQHpbhqgACn7r9KAOgF9y8DDPOl4Ps/Cb?=
 =?us-ascii?Q?Z57nyMZ+6Nu5XEEviPi5Sb6udsdx5VfcTM9gl7XlqfpGduocH+EVtmgE5bV3?=
 =?us-ascii?Q?hh7GuUCbZj7rYOLkS8fZ0dWbagzFSE6YTtzdoycsEs5lDEHPeaKjs8ig4VDe?=
 =?us-ascii?Q?4CDDL2zjL5IA6d6nAUzdU/7RtzuldaQidMXhNUVGdzPzVnHC6yMxQlENyQ2K?=
 =?us-ascii?Q?lhF2Y7faTOAic2fAc4qD5x3a6NB7qPWqkd6hiM3msFgRBhUK5erXdImpLoKz?=
 =?us-ascii?Q?MxDD1S+9kxwnEf05IYi1Oltsa9uQGrcE6AycEnPL6/Z+s6qRXeDbJcn2EcJC?=
 =?us-ascii?Q?Kt3CyQSD2scMw5ZN1sFnNd+XEbc5scaQ21pj5lqPXoaaD+y3HsxGah9h6V23?=
 =?us-ascii?Q?awoG+MSNsZb2KhhjJzrU5hX0aX/QGQe4eeQJ5Eg41vBzMIpaUzUSp3qLpvA4?=
 =?us-ascii?Q?fQ5g0/Rarevi1Dbh7aXQi1EOtDjmOpVPESdKqvonG8XK/K7JSJzL/TeHeiGe?=
 =?us-ascii?Q?NLeg7nw6ApHrYnoILAIRwcYQUUyZJQKK260E4jnvbpihzr2Dan823kztv3Sg?=
 =?us-ascii?Q?1JXlQbYlV301qmpA1mAnMB4ewMvbk2YC6AMfTkec/kpqopeWOIskYMORVkY/?=
 =?us-ascii?Q?elbACX7rxGmtsGSTXNc3SHMlYCCiHiXNW8/g6HqnRdiACM8R71PLrDxOlRBc?=
 =?us-ascii?Q?RA1aStpvKN7GyR0KkTQTALZBB4w5s84NWSj5mIC4rKSmgprGshk3Hs9dXLXr?=
 =?us-ascii?Q?YILAsLr5pIF1TS4V34nWr3XbGTDIqSLE4n2LPCP8bFwdg/ce0k9zu7nlRA+O?=
 =?us-ascii?Q?Tr5xyIl4QJHiW2GPVqw9oklj1OOoPTedVoBErOcdkGhMadIVToMAy8bK2uzx?=
 =?us-ascii?Q?Meh7+Lnd/8MeNlBtu/ptz6e4DMMQdaW0wiNp9oogg1Wu0f1wtoTkJukfKw3I?=
 =?us-ascii?Q?tj7X90ifdWqr5mrRn2n37HAjg4y2936EdSrMb3SFhNLMV6j0LnU9SYy87vUc?=
 =?us-ascii?Q?OGr0eAQ6A2s2jpSc+dp10nhGkZShPGTfjvsUSXab185tNQjcxB8SaCJvaWvk?=
 =?us-ascii?Q?KgoJ62o/QJyE9aMt9ur1xEzlpzcBtDfYCcPXE78Ax9O7f+CFTsipfd6de9o6?=
 =?us-ascii?Q?HbHWSxVLiHai65BUb5ncmL5HGf2LWslfM8tJ4rFGG3H/rNlUmzLt3Dz0gn39?=
 =?us-ascii?Q?jAIxPCxiJGM5mdAMutZixywfTr8uCFFk0xX4f6Q6VSr5LsY3CVHq5vXDj8Am?=
 =?us-ascii?Q?xMTTxCr9x3FMvGmz/y4AifTqRaI8J+P5r8CR6/mcxsyC7wpbzUsRrEmwx6oU?=
 =?us-ascii?Q?WrTzAmWGYES7LuhVEYLlVh5MAlipSq8hZ18FUzC3zkRl3hgyS/KTDB0sqwx3?=
 =?us-ascii?Q?/ffgy12S46sWdMe/Lul1rPbE5Lx+xZLhKaIWG1SE5joHeHctaRcJIHBC+3C3?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9c8035-afb1-4ae0-c467-08dbeb4ebc0e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:32:39.9642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlMlpOJc241BbcXgpkrMqGi7OPaE/+ffO32D/VPOHrTb7bRT/GzWcXfo3VVcRK45Lu3qmg2508f5vb1xobqAoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

Use mptcp_lib_print_ok(), _warn(), and _err() helpers in script diag.sh
to print test results with colors.

Having colors helps to quickly identify issues when looking at a long
list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 3119811018fc..7cf1f602bf48 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -62,15 +62,15 @@ __chk_nr()
 	printf "%-50s" "$msg"
 	if [ $nr != $expected ]; then
 		if [ $nr = "$skip" ] && ! mptcp_lib_expect_all_features; then
-			echo "[ SKIP ] Feature probably not supported"
+			mptcp_lib_print_warn "[ SKIP ] Feature probably not supported"
 			mptcp_lib_result_skip "${msg}"
 		else
-			echo "[ FAIL ] expected $expected found $nr"
+			mptcp_lib_print_err "[ FAIL ] expected $expected found $nr"
 			mptcp_lib_result_fail "${msg}"
 			ret=$test_cnt
 		fi
 	else
-		echo "[  OK  ]"
+		mptcp_lib_print_ok "[  OK  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
 	test_cnt=$((test_cnt+1))
@@ -111,15 +111,15 @@ wait_msk_nr()
 
 	printf "%-50s" "$msg"
 	if [ $i -ge $timeout ]; then
-		echo "[ FAIL ] timeout while expecting $expected max $max last $nr"
+		mptcp_lib_print_err "[ FAIL ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
 		ret=$test_cnt
 	elif [ $nr != $expected ]; then
-		echo "[ FAIL ] expected $expected found $nr"
+		mptcp_lib_print_err "[ FAIL ] expected $expected found $nr"
 		mptcp_lib_result_fail "${msg} # unexpected result"
 		ret=$test_cnt
 	else
-		echo "[  OK  ]"
+		mptcp_lib_print_ok "[  OK  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
 	test_cnt=$((test_cnt+1))
-- 
2.35.3

