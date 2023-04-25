Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2074.outbound.protection.outlook.com [40.107.14.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFB97B
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 07:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSI/4WGFsRZZTfLHbCc0IzCR49dh8RVCtIuORyAjG1TwORSI50+J80p7quEWsv1WQLPkRILeoajGD4nTKaMS8M9DR1yk24/rC1SToMARVdBWsIlDwupu1CSC9EkL+BYouw9o/rpY/ydJ1geozdIIy8bmNApqgeqoiv7BIezlEge6Qu405Ni2gjwH3Ac5BriNO+02R/x/O8+11cWmRCHf1Sxgg28jCzK7YTdM7bDDbwhZZ/yy46lrdlJvG92m31UQtYceREvt7flgnS1xJMIkDKlJ256rEE8g+tZRy7EaEg+FekzbxqkH7f2G4Gr0xWKJQMzAJRNoQAuzyBlxiFtsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt7RCWELTXEz8+21MuqBPSLvhGOZYhWPw+is+N54xjY=;
 b=JUZ9hiw5Ie6Hald/AmhP4ven725yblbPYjhlbqT2NpfyJ7uUE4wzLnFZmOyN9AcCwtESJKtDKJlaU53fslQgRQZnO267ovzhISq50Dv8zWW2CTT9MmVKtZAk+GtN/g38NQZZ23Cr79i1tUwxSMtWja6nY3h6AvOPgZshJNWZDEYk4SO/28XbSgGn4glzD1rbK2vhkSop8CahCwjfezkDIAcBHuqflDrEeJUAxmtsJlyKkB0dc0CwDHTG5TKIc7W7hCscLUfDUYPT1EVeDi3DLNqPtt+0mTwG43cjcOZu8fIrhjXjC1WkK8vF9OlbGLouoIRgXi+C7fKZJeIYt8GqsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt7RCWELTXEz8+21MuqBPSLvhGOZYhWPw+is+N54xjY=;
 b=Uu2Wx09jAjM/J25fuwgLbkSwgI2xX7Az1tI7jpSSSqgkShjHWYL2SK/tdJNQEMpo7zNj1bJiXovQ1YuHPV8uRAUVruK/1C3qOJsac5CNka9NMq0li37lmvKgZFDS6/MLjR2zJoxAnOv+RactwYhXnN64xChiv/vUIJQfImXspS/1FdQJSo9DFKfTFXmIhJh8frf6iF+9RTwEtVyVXTPRh3t5wLzOXA7c00jawn+XQd5saSg6xWa/Th8atpnj4aU8HxwERxaidDqCUWNNcFqrgKcBxto1UcD8QyE3rY65lajcViL8CgATKM+GT2c+Enc17Vc5OO2jPlRCi3FZvasCYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Tue, 25 Apr
 2023 07:56:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 07:56:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 6/6] selftests: mptcp: update userspace pm subflow tests
Date: Tue, 25 Apr 2023 15:55:11 +0800
Message-Id: <ca308feda45a2451d0297e2c5f21dd9b1aff6981.1682409247.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1682409247.git.geliang.tang@suse.com>
References: <cover.1682409247.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::29)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB9366:EE_
X-MS-Office365-Filtering-Correlation-Id: 443d6361-0025-43d4-4550-08db45628832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kcshAw2XbYKyET+UMTSWp5jg5xLAhd4eGBr0lzCZTroVXDoqy6/9py85Fd+HdUHLHd8HwmkcLmrgSIWD/5xzh2Rn/U0oZM3U0eeLrXBp8jvEjoA3kNbTSoypM/75MJ8JzDjTI570s/6+Cj5qiR9PmrEllF52hpdSh6oQ6VcN15dazsSearWOtjpNRxUZl+1eLrqVVS7C/6P2gTeyOqRpiGan6rDqrP7g1eqVVQI34HUMB67yigTB8QJsLiD93nttOXWiYxQwyjgHIsFt/dBeSrhBntqTR0lnFIm5RNBJpfnE2R8NmieikbcU20A+rPRkMAgi30KNwP6q3yL8rB6o4puqdNj7HvmKE5qAF4c0tv+mjZcv68EfePEgEOaakG/3Cwoj//2ypRLyGUbCyQgoP45aHS79RCk0PuRryj5R5Ym1ZgBjHLum/CrePY/TdeI8USDNsG71OZ7UTnLh+dFvhkkOqaMZ2Sp4icEKA39p06zN1wOhUcO+ZKi3Q+DJLK4IGLfapnWcmxQ1fx9DqvCMCNlZKsMk9jTxkRZZj6VqG/c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(478600001)(6666004)(38100700002)(966005)(6486002)(107886003)(6512007)(26005)(186003)(83380400001)(6506007)(2616005)(5660300002)(8936002)(8676002)(41300700001)(15650500001)(2906002)(316002)(44832011)(4326008)(66556008)(66946007)(66476007)(6916009)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tpa6xW3m4L49oa0VTUjJnIpm92ScY30K0xZU1oeZc/5RBtqvoQSc+GqwJUOR?=
 =?us-ascii?Q?sTe0fUAJn4cnpWnuGMlFzicbjvkwSOdIh8h5SaoNFLmr8V7RHe1jvL9c1n2e?=
 =?us-ascii?Q?7dmg/be40tT9EJyM8b20Sr3SQeLUvyOc1gZpg6BNPxog/5laX9+JRdvsfclv?=
 =?us-ascii?Q?4In28ZslJ4nDCopQrM1Y7cYLbJeofKDmwV9g/SWGEFNGzvNakAvQM5DbU54l?=
 =?us-ascii?Q?EU6p8YxARZLylKsPceuSBRVWGLoIdFKUoQgXj1pmOCjyOCFspTSKeCbDBLxF?=
 =?us-ascii?Q?uCm+68JlNxEMNXm2xK0cT5HZ+8r6ZqPIvnPz51YRTax79pqjehkSMKz9f99I?=
 =?us-ascii?Q?43Ki7jFQi21PUiohaJhVlCXNhSk+cOHkl0fOJk5qK8XSlkHjQ1INX5A2JUNO?=
 =?us-ascii?Q?11SiFDSKfygHAac9b0O9vtUo3a4qWjJW/HCpxv7qctMAGjQkhc9CVV9jGoEN?=
 =?us-ascii?Q?Hy8+XmmriA8xIEcl0Oe5POJw2S8vBHyFKOgWCnu4cGnWCt3tF3OhPwi2Bp3z?=
 =?us-ascii?Q?OXEvVkXoHLBI/MZjoTTpqx10SKsGGpplHBiC/2rAKZV3y+13bxGKVyUZK0r9?=
 =?us-ascii?Q?U+zFLQrTcSuMjxMFVUMNNp4kPoPT0ZGZx9AdTFNjFY5KiVr5rRBQq5O92CU7?=
 =?us-ascii?Q?UKYZMrPNbDhtJE2lMyupRwn0K4yT/xWD2y0pZ3ortbUKahNKBQ5KpBi1WSdW?=
 =?us-ascii?Q?1m9jPkEXh+OSZ+tF6wdyuD3SgWfuPnxyeQXAiZcVvrR6O/2LItXZm4UnGeLZ?=
 =?us-ascii?Q?mZljWpjYiYGaGtIF00NkPF36Gn+4nsZdOdzT1R1xLQ9tFb9O90uyZdTrNzbu?=
 =?us-ascii?Q?wSatvxp7Psw1Mru+89tlnqh7pWZGeN4OK+H8NOuIJm3OHMOMj3apuhXs8AHx?=
 =?us-ascii?Q?WjNN6YjKcLUn9koBXj5fPsqW+zubeOePsRKa2BVeimGZJi54wYZMcn5D8CNI?=
 =?us-ascii?Q?OdR+ONbNeaEX9Pcxq+OF59rxHZYG6fJZ/8ES37+Rmr0h3SIe5Wc8+6ZYvdmG?=
 =?us-ascii?Q?Ue1YFM8+j80SW2HVGsSAir0BY0cW/NJILViVpzssGMs1Pya2jIkbbjdtfxDH?=
 =?us-ascii?Q?l4qOoFnv2tW9EluV83tJmMZze1oeUZh87GhU324CSOZ0P+6O6i7sJq9zRZnK?=
 =?us-ascii?Q?UUJjbsMtH1rxqbehdYoUD/m/O6DyS36H3UUmHtq3y7Lwm2dwHldBc5Si/Ger?=
 =?us-ascii?Q?vQWqlm7jcCPih/X1Pe2W9Laiq10VDtwcSPAtsdc+K8i/5oV+MP61uPphMtm3?=
 =?us-ascii?Q?GL02/uC66p4tO7XQCwngx+COGDgOEp8OCghDPbzSyRUFd5XxZ/Kd1cCXBAuN?=
 =?us-ascii?Q?src0s2iJuLArYqEdvZ64inp63zYGgWwN8+QJ7+FTqpqCcqcH7LnJn3PWvKs1?=
 =?us-ascii?Q?iL7Xxb755/1SGZUyAUuVoYjb13VMfIzHhaCsa5yBRZt2Szo/JiPjEjw2KoZ9?=
 =?us-ascii?Q?WOFV86KwKfiZdoyTM+lAHHL/AlpPTdxtDfE/COGxjRpu6Sz7BbnFR5lPADn4?=
 =?us-ascii?Q?YuiogVUhR+kMvD3zdKUqMnzH0p1tshORdI2zmJ360yVsmOLAEDXsJMo9QeHt?=
 =?us-ascii?Q?vi+CfyztWjQPhBMUwg0oO7XfCY4h48t2tGme7sQq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443d6361-0025-43d4-4550-08db45628832
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 07:56:09.8868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kesQhwxwJssqMdzb+z6Hdwdv7YaDYt5aYGZ0VnbVY4GVzhqXS3B10lbOfPC+wI11ouyR14WtpOwn9QScpk2BcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9366

To align with what is done by the in-kernel PM, update userspace pm
subflow selftests, by sending the a remove_addrs command together after
the remove_subflows command. This will get a RM_ADDR in chk_rm_nr().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Fixes: 5e986ec46874 ("selftests: mptcp: userspace pm subflow tests")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b3cbcf27fec1..878acfcdba58 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -925,6 +925,7 @@ do_transfer()
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
 									rip $da rport $dp token $tk
+				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
 			fi
 			counter=$((counter + 1))
 			add_nr_ns2=$((add_nr_ns2 - 1))
@@ -3137,7 +3138,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
 		chk_join_nr 1 1 1
-		chk_rm_nr 0 1
+		chk_rm_nr 1 1
 		kill_events_pids
 	fi
 }
-- 
2.35.3

