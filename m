Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2079.outbound.protection.outlook.com [40.107.14.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A410B7B
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 07:55:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEOATBj+qq/g2pL1bfvU3uPFZAF2SoOvdoPYLA+9IMANmyxovOa93VxPhaRzAasWwm0cXbqnZybicKDT4Mzr1GNTjMwlzJNDfYP1Or9BCsyAz+QWmiGEyTl/fGlZ5IuYGMLmnwEOuAxEFIFFhsYz8Cbl8fMQTW6EogrbVfEQ3We76gUGGrrqt0o/slqyCFhNRvvxsq7BJ5E7Kjz8+WbNcznPIlOCemuRB2he0pAiDI4HoJPh/mWbLh1lp+5b9liyUf7iq/Z59ir6dUtfIqcb00Yrk7dsoWR2wpb0HnDSquegxF+1yyLDKfAr+l7MUwrO5kmsMxxEIy0rb0+x6XqAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rJvvM8/vIqLvXBMOpyCYWvDy/y7zQUtgkKMG2PZXi4=;
 b=gZ4s8SxuQc+YyP2zM8bl0Xop7iDGkQTaZlhiMD8fSTwC/3thjUd2GXQ01i7PBtNvGYwlbn6bA7b/95aLKQ1y3RYl2CVoMoA0FQO+k9uDi38s9NTfhd8DpHabfUORORrgph2ms1QQ5aH1r6bKanTchv/nJnag0dfIybPp88Yi2JL846Td2NANf0xGKszObP5QHYQ6JWOiFMVMfbpOXZzBvfXmuUO03rHxXKCkVjQfv038Se5ByM5/5ACJ1+XRmPjz8NkrMarsRzRoPE9pDyWCtIqTwnnw2yFFJQ40aVhbA01oGT/OR7PnrgIP5cYNAwytE/cwEgIs3R5m7u7Ok+EZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rJvvM8/vIqLvXBMOpyCYWvDy/y7zQUtgkKMG2PZXi4=;
 b=LCkI9q9NpaQlDD90MONPXroeRysocaMkkjiDVaxamRl6oupC4PYZybS+AsPA6xOc8JgFZdnt0omtr9oXchOmD79KQ5C6RbuX6lFIUQsIPyERKmdkUOwgvGgFJMEeOB919iM6qmIOjawsGk4nLGp1nrtPEH3T2BYBVxOLbdUSGNvDtldQP1QSS6zFKZdogbcP4BLr91yOg1Q1G0NgjJr+GH87l7UWmD9hXmEV0YRjEaHqADcQ9OhShykHvQy6qAhMthIsDR6g/fON97zn83NRd4iIPQT2WZRx0G2IGfIOSKQie0NUKF6AzootXb0eHFLbAYYZl9asFecQV68WbMwMrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Tue, 25 Apr
 2023 07:55:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 07:55:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 2/6] selftests: mptcp: update userspace pm addr tests
Date: Tue, 25 Apr 2023 15:55:07 +0800
Message-Id: <9538f1e674ae213267d8edbff236bc07cc5a2c59.1682409247.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1682409247.git.geliang.tang@suse.com>
References: <cover.1682409247.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB9366:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a5fea2-27f8-4aa7-7f67-08db456276f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zu5jzKQXTMdKxN9V8Hz8o10lj314ilyK8nWs7dujORbwpPyR322/OHQarZVQ0WXc/hIuvJvxktIDO8hrQfVyuzsJ0nrIZggO0IgIuR7KfU+A90qmvxyMuG7U2qWgyqdu5kA4GOe/JK2hooIoBcMiY74m5URudt1l4H9vTsx7nsMypMS2C8Wh8a/97w3uOZf2f8lyutd/ofZJHEVRY3pAFn/+IGu8J/kjF9r0KRD8aCIoMJ05kDWE9Inpn8qkT5WICUQex8+OtOAZmA797CEGu89fcOXtXD6WdNXdbMc5m2hHPZmLjBUufT0jcRY+Vqv82zr6vf0PJQ481Jjr2gMoZ9MZvKHqDrvXIVlV+HsRuseLeaTQTrSuk2HJ7n0kkqrpXZsHF7n802nKRt6RO1ckn7HaGdKY/S2epa9M1u2MdPW+1EXAUm+arlesqfeHw5//EWV7wf4c4t9lv6GiNPyW0XEVKnXpPT2ghWiimtTpddjxj8dZWZk1GdusMF56+9ZOWbC5E/49Rs9iTZmVYDfpVG1KwdAnRSxQFVZ+9Fw82gKKcy3RTUTlDCiGjBBHSK1X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(478600001)(6666004)(38100700002)(6486002)(107886003)(6512007)(26005)(186003)(83380400001)(6506007)(2616005)(5660300002)(8936002)(8676002)(41300700001)(15650500001)(2906002)(316002)(44832011)(4326008)(66556008)(66946007)(66476007)(6916009)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iAqo/G1vRNeSPHvyp4Ac4sapiveDRnYOZ0U3EaPhsNSnbp2WCO5plhmIVJan?=
 =?us-ascii?Q?UtN6F4/QTaFstg7BP2AXYHnB5oWwnFIDqcIXYVlj5KJ5ebDlFCCVik56pV3H?=
 =?us-ascii?Q?L9A7CFrN0e15RZknBqYc3v7dSQBUCTwGpCGVlzzbh0iQZjU/DHzhlwuoYHcL?=
 =?us-ascii?Q?j3TGodeve7GfMk/e88GnguAqTtHE19180ntI07zb+AmFy8GKkgjous1fe97+?=
 =?us-ascii?Q?FEyyJlqyLs1BCDW1RTU0BI25dZiCmvQfclvpeio/rq26F2sgT8D1zRFXmRVv?=
 =?us-ascii?Q?/+owd4WCGgltDOqi8sMoqZDtHSsYEEJE8exWtbwMzBW3jdm/MBPQzH4nlHi4?=
 =?us-ascii?Q?n1OsACS0ySf0qesMhArS6QxODIprifQYqFACcwPxw8gLjO5VIGAb4pOjeHM6?=
 =?us-ascii?Q?m6N0XpL+HFFycwuDabJ2Tu3P2/madDvQkrBWZjqdDNdXkvRvRRqcIY04vkOa?=
 =?us-ascii?Q?GiD8GSczlfG+E70/dVq5eTIPXSgKNxcJB44SPBJl8ruw91Kd/G/Npvzszw0Z?=
 =?us-ascii?Q?A199+TQ+w/O9b9y9X9KYGFFxNpK5SRiSyRFNWPsDTBGSV72AOpb6L4eiUltD?=
 =?us-ascii?Q?bpHtmCFoCly9JN/gwE4J0vTVfxomsTa2HR6Uxzk/zJAEQPvqvjOKTqJqzgjZ?=
 =?us-ascii?Q?SgINuSYE1IHxH7japH6HeVbvsYOVWz/LGPcE2QBumrxcckQth9re7KJZedwm?=
 =?us-ascii?Q?ZIFEu9LXoRXLOBt4LjaphH4vFwDch59vYblMMG2oUWPriMjgHp0caj6Ogrwn?=
 =?us-ascii?Q?/0UhFPnPi9QKgYuj5nkKrazW+ib368dltFFuPZc3Jzs8/hVsE4pirld1j33f?=
 =?us-ascii?Q?LZMApX2UXh+WI78rhBUmS6ZcUIT2NZJNw5Pok29tAhrtVSDhZ/i1PVgugI4I?=
 =?us-ascii?Q?5EbBoKALmX3MDG6CnUQ3QAHJLZ/nbPKRtOTqNnKe+oQ7QBmzJFKODY6qcOst?=
 =?us-ascii?Q?pUWSo+cLNXv67lnWU9+eymxTHnZqm7/EUbKBZqnJY1HNh3Vp0K6T+443LiYo?=
 =?us-ascii?Q?ntHkF1x1l4iUH7R+DEJ15xWsoZvy36HvmYbHo0RDOUu7Y8wEbwzDG6n3hxas?=
 =?us-ascii?Q?OFiY+tbbQqJGwxztugeY+NRuOiCmB048hks7+5zK8UDiwHfC2N1ygHnXzmR2?=
 =?us-ascii?Q?fpGgSMR/ixKY44p8vrlpCIywWNbU9Ju4hnAjVTYkFo2Obaj5l65BlBLRPmtg?=
 =?us-ascii?Q?rulJqNKeY82kQhG9eCXbsXYwZ1lJEHQBf8dokUs7PdzeIlVaw9CvvbVVmkkd?=
 =?us-ascii?Q?13Jj6B3plq42eLbYLxgcF/uRE71tu+ng4X4gvlf/jXKR14e8Ca7NQtjUiZPW?=
 =?us-ascii?Q?DpRyJXhdcMcAwdc07tXBGizpZN3Kx2aB0jGfXo/tRKXprqsoxz6xFZzyhhcr?=
 =?us-ascii?Q?Wrt2N9LmOZ6JepZs7nPbi6nemrZFxalL8Vphkpb9YHrUFkzZEwfJLdcDjIN7?=
 =?us-ascii?Q?8koAVfSdJT7TdiokmwJEoqpiGqb1HsPjPMlLfsgW2pA+i+ARUJYdofarnHip?=
 =?us-ascii?Q?5Q3XKcUOBfkRInFMZplUqpwoxDxzyr9viWrr1SNXsrzg+qMDWwE1FSIhoTzw?=
 =?us-ascii?Q?Jk+nu2unk4qGj4bgISVKfLPD7ta8sCKD2is3pRBK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a5fea2-27f8-4aa7-7f67-08db456276f5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 07:55:40.9138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnTxTXsrLPRpL12raxBXFgTjJBGBOKf6Xxe6PXRJKC1SMgHT98pRy2U2xzs2LuEMcJrt3xfEBJZqqdYv5Plk7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9366

This patch is linked to the previous commit ("mptcp: only send RM_ADDR in
nl_cmd_remove").

To align with what is done by the in-kernel PM, update userspace pm addr
selftests, by sending a remove_subflows command together before the
remove_addrs command.

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Fixes: 97040cf9806e ("selftests: mptcp: userspace pm address tests")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 26310c17b4c6..b3cbcf27fec1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -849,6 +849,14 @@ do_transfer()
 				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
 				sleep 1
+				sp=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+				da=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+				dp=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
+				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" \
+							lport $sp rip $da rport $dp token $tk
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
 			fi
 
-- 
2.35.3

