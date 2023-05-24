Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074A1BE7A
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 08:03:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkNR41rz2Hmsra5QBb77a07AFqj+WLjJjLTdUo7A7PqvDlpr7RvGGNDLGEdOl69ly5PcPPKNjFB6gT+h3t+WBLzvCouvfq8frPBvLsLtYF++uzS5xQhu3eVqgwhSyqOJ87LfcuYwFhs4X7u3TiTQDMcF+31md7JtKSyXCjPfqWwi5XFnZkuo66p5N98J1n1HwGlrvgSklHibcS7R6n9OvJirCty9G2Wda5QUrxTB0rnjEKWvyNcArCyfZCh88cEy0vKb/Ww6KfgrWiorPzad43gFOBgTkK3cSbhO4nlDIiHBMMScl91TAVBdNFw6GScoOs8Iu2glXfvAvR/ins9fZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuuVjmvT0OwFVCrz+yOVkWabcMUgW/VJoBN0urA9XI8=;
 b=K8CRkCtpciEMbwfsgnNzHL4MMpF73Wx9gIxm/uF2+OysAi8qiieBfM2K1O8FZlU5ZbppIWmMOcGLrOXbtgAWAI4uuWH242ya9lfvV2njTa+9M+xWIdHa+ko3ajX4pDzwUYpUfYK8/yoCfhwL9dNvrtDbhYykY9ZIg5bGTILZQ+/sJR7t3I1GcA+4DMQGnU9g4WhxuXCXsVIQCcwxa4Ty8muMjrP2golQjQVKRtVPO0b00q0NlK3wJG4tSRvqe4HZ3/EIYYEXEKG9LcTw/PC2O1r+WBHj3+hjqVZIF7ZG/wT4jtoJDuPZmNiyT/M7Ruk6giKKwuOhfUrN6w1AatZcTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuuVjmvT0OwFVCrz+yOVkWabcMUgW/VJoBN0urA9XI8=;
 b=P/oRFU8eI5LVvD2LyYOKZjzSPlenjA68pfhWTTDKP9ZD3IpZgQHYbCLO5emEPkKWktksWzAjyHwJfGxAakIOd4xuN2FSKk+4I1J8FrXeqcjUDRTbEY/aCRbBj470TEW86GRfqMQnDVr+hOLtqOWobZve93s7l4S3teHsA8fCEhsWFJ7oO5gYJbdWjICHiGVW6yz1Y81zk1owlpNd7io6YPwBq9zI8e0HhLdMc16ihl1rYcQ500fm8Kn7dBXrEHZtFrQiFPmgaJwfMLNi3IuMb5M9Q0BjmDbemwaODw0xYI6bpl4ktLT3u535eo/Z0K9o5UslIoh732XVw3MeDaJ+4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7714.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 08:03:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 08:03:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 2/5] selftests: mptcp: update userspace pm addr tests
Date: Wed, 24 May 2023 16:02:45 +0800
Message-Id: <48489d67d3de857c2fa4d3522a5466f103601f8f.1684915182.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684915182.git.geliang.tang@suse.com>
References: <cover.1684915182.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0021.jpnprd01.prod.outlook.com (2603:1096:405::33)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 494a3245-3042-4aab-0a3d-08db5c2d5615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8m18tYlz9zefl7uR4DBd/V0RU6jPeoHGWOEedaoiLGug8qnJVhGr7eT5IOOxPMQtnpbDkilDaUbFjXJ1jZG6KJGRXTfW5QMn25pv99lmQkeDTLLyyu+u2w8CQb1oLjueRhpIGfjS0AzzKJgpfRL4frEeWadRlU+HgdCz5wHLVBXuvK2nkboHtPGZIPFzgaKnEix9M705EPYTwx5rrAzOaUOA4JxtzLWJJpaKpFU//UBvTVQsxTG2sGnPYFcR3Z7qgbxCk0o13iv/Kp6tYmt0nVSPMwj9lumPaIJqL+fx3RsaPpvXRJiZRc3mbEegJ5AX4sMyKfcat+EZhbnTFdrgHqGfHIDofYCyTK662wdyIz83touML562T1gMwOduU2FIIMny38KcLwGRy4EcVtXBzQdPNrFyKSZyh0HvrySrV/4eNykxSxgG0aRdwmDCybakOSg4pId82O92zF6kv8ea/1O4VjWAJxb+9TZouOGCEpeqIsGUd+5t4OgggeRd/YdMqm+jE5MNkpkagpCqNzzOJQPFQBVUVxRLW7bN3SElzYbNmuDf4VnYhVUGrHp3IRHY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(2906002)(15650500001)(44832011)(5660300002)(8676002)(8936002)(83380400001)(66556008)(66476007)(66946007)(41300700001)(4326008)(6916009)(36756003)(316002)(478600001)(6486002)(6666004)(26005)(2616005)(86362001)(107886003)(186003)(6512007)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DAZMrIAu8/27Oi9EahOfVG5GwqtXMh8QWaFuJ5D2qS0Nc2qFLWTQ39ORYIJ0?=
 =?us-ascii?Q?WI+brTWAA6OkgGRDq0ssKGnr4b0lJntAXgqwGOsyYfTem4sOtMWosBV5TLMy?=
 =?us-ascii?Q?7GA6A4vYdyH3gYQu/E1srARwsyIKwZYGBfiKk7kwAQjW7ZrW2yb0f1Rd2/XV?=
 =?us-ascii?Q?m3GnD2MTSYuc9IpnVbLbccGOI3VSPr50pBDHWWLqa9JCUqZ/3ad9nFVmHiIZ?=
 =?us-ascii?Q?XfWqCSIWvH6c4TDApYCzLxDRchrrM7dvjcVHyOXBK1DtzkThABFGl9DtoExe?=
 =?us-ascii?Q?WwCmMI+pfSw1MntFWE7HBaTvryGbQw5Pldi1b3RlofLp3BF44kokwbIo2ina?=
 =?us-ascii?Q?Fd3tOBUI33zBIpcvBSZdbwV6pgYIqai4ERdar+pyxW3Z9mo1dWEb9quBBxWb?=
 =?us-ascii?Q?D/ARbeF9wJkQqs2OKwLQe/VfEz/kYY/IqJ2XYXtYUGY7RzFX4D6pkpt+ilHm?=
 =?us-ascii?Q?+J4lUddIGRoTqDcm2BHOrLJwk7GO7i5CVluDhLZxbk3Y6I/dpsvQknMOF43l?=
 =?us-ascii?Q?E+cmMKL+ZynnD8RILTj/MT6b90vvT8FlrFQcJPHSCw02A5K6UVgGLcLCXYci?=
 =?us-ascii?Q?F80b2v33YMSsXl6aUecCYZXf1YYiP60NKxD9sM/V6a78DoTONx/QPwN9ZTcT?=
 =?us-ascii?Q?2q5QPrlzOJlmfB97VpeH7JT9pQs3fsMFPdLgXdC4dS8pLyb/FjvDCJB9Tjj3?=
 =?us-ascii?Q?26VAuy5cRFkcM4rJAZ2D7kf4QRxvSaobO9sSQMrzYjG+bpDcnLvdHK8NRLBg?=
 =?us-ascii?Q?tckEXhyA5cs4+GAZBAO5obSICZ0AlZXNnp+zBFSbg6+ZUXJbEtN+eVgRvSIy?=
 =?us-ascii?Q?WxCNrzEBIGx7oR6gyLQ5j/sfsbTDyDCfwSD7HqeLYwAZkhvPXz/3tBvsszJc?=
 =?us-ascii?Q?7+2wQU31xHB4mPy15RIQBHBQLNalqhzOdIJmPKHKXaJzP+k7eZALY1fpmrv9?=
 =?us-ascii?Q?LTY6EySXvTrU/uI58iggRnNVhp9P4slhvnhngX1rxyzptim7UQ2cu7ncUuaV?=
 =?us-ascii?Q?yhkKk0hRXr7fsGjnIeFp4WxX5h2lCguywlYbMEB5to3mvTerVP+n2o1j1Oxm?=
 =?us-ascii?Q?XL88DIHxUKsRqcXb/K+ZPiItYzBVDrmiY1C1V5tLE5k6himwdJNcTdF66C6i?=
 =?us-ascii?Q?V+ouuBxzYa+NrvqkHH/rrWrPHQRxlHUzyf0E6vLNkbJCOZWa+SwZSVkSUEZr?=
 =?us-ascii?Q?DjW51kBwabI2i9+jR00igwGDKzGCtGLGOOvk9ET8dpDm8mDRdGFsTbY/BWau?=
 =?us-ascii?Q?tyyVOj56SaHKrk0Wfy4ivy2PvX3RGS79uCkviSkrgsp8/AvsZB439hEBn0Qm?=
 =?us-ascii?Q?0tPwEWehOhVVzDnPNb81kXm0Yb0ERm0m1UrUmgZYepl7W00JECPFZPnAkDjT?=
 =?us-ascii?Q?ymSnMHPjaO87FsEELoPWAmoB3QNTp0o1PWf3MES3VAvbIfTWPRG+/UcxDpfR?=
 =?us-ascii?Q?+oxAyV5vLh+LpHyA66gceByET+N5a7SUl64kOpCLBoJgxNlnZGhnm0PrGHmI?=
 =?us-ascii?Q?QogwJ8Zp32Cbq4LA3ZjMOTXWm2zj0yMtJ3b+kNJXpyOqzkcL3sQ0oCYX11bT?=
 =?us-ascii?Q?26elxyWSE8aiwdGUYptflz8asXun+l1x1LGKPVbR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494a3245-3042-4aab-0a3d-08db5c2d5615
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 08:03:19.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldMywh/oZrru2dzj7wmrZkcTsvpxXeimzycTdzizTbtjzvh7eCAtzcE+dd9xCjSsuVOkFx6cXVXFCSizSG3rjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7714

This patch is linked to the previous commit ("mptcp: only send RM_ADDR in
nl_cmd_remove").

To align with what is done by the in-kernel PM, update userspace pm addr
selftests, by sending a remove_subflows command together after the
remove_addrs command.

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Fixes: 97040cf9806e ("selftests: mptcp: userspace pm address tests")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0044d87556dd..a42745e60976 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -863,7 +863,15 @@ do_transfer()
 				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
 				sleep 1
+				sp=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+				da=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+				dp=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
+				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" \
+							lport $sp rip $da rport $dp token $tk
 			fi
 
 			counter=$((counter + 1))
-- 
2.35.3

