Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA1013AC4
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 13:12:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikUXw/C0VibIA6z90nUXaZKtbaujFSd4Sg3H4g3rTOQ15tt1ACVyBbbkeY/qsozymB5TCSXs2ZfME20NaJiNvJ8ck4xnWc0dKFvot9bHBxWPTEiZvfMO/+s6sfm4F5T+qbehvn2iiU84dL9l7kF7Q/ZnIoEsjqpHwiDWnXdufaPOAQRgC8f0Z7efdf3x5SLr+3DHiChKrDkVQJJPonQI54Zla8wp0mNdKcHN8uffnhBRbwV4negQQ4kLwShQgflEplUda8Tcz0RJR+6fYKDQf8eeBOLr8AmSC+PgoP5H0HVdFw2JJ8jk1jIE2O+pWYzqma8PwUFBf4A1AFw+RRIyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UVv0ZRUREg6hKbv+Nf+cYr5i/Dot9G6uNnjR/r9o4A=;
 b=cvqYzyWs6ELKC1U0b49d7GUXux7yVowC+v0sGFxQ2FY+quFCeHbdQLfriXJZ60oDD2koJb2Y08JuODsSx4XmmW7Qix3ZrhwIJ4JbSOxSMaB1FnU1rfZ6ZCCzFNwJ6g0OKMIanRf1VTa/7D4va1sY5OWGXAKkVm4dYD52C0n1F8O6on2ApSccHt7dTntv2eNJY5hQhNnsqhNCh18cP0AlyL5FJeINdOj/eA4O4hD634N4DiWN8ir1O6pCK533bB8Lraj6a4+o1PTDuRXDwfCIB+K8T2MnXYqVp2xLQf8Pzecr0mX63O30m4K9BcrSc9zTX5gz7ftKPpK9OGtt0uoWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UVv0ZRUREg6hKbv+Nf+cYr5i/Dot9G6uNnjR/r9o4A=;
 b=cCHeWpAu5pQ/qUgkfBwiq+Ygistv0sUymT2rqq8wn15POGYIE+3RLXZtz/2/IsNb+qPj6nMdy6IcWpBUrIgycp5NSs8F6hDH+C1l/YTZi3Fof5xMz21aI/0DOzYS/yXFmNjaeNfR3BUpjNEOPHKscDXlRjPBDfuosK46Bb/SJf3GDlRrabbK5xe04ErB6dSz9BXcZTlWKif5SQQPdPvpwhMYhyLBk35ea/BoePr2M1uMNDJXZ6SeRf7LxQej/4tRlogvQ8rt6ipoSMN96/hmkrmyCWFv4F1qCk59VJiLHU4UGNwrtG0qfsGkb/Ob/GPJhPjMif5F34HnhPURZxVpyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 13:12:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6411.019; Mon, 22 May 2023
 13:12:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 2/5] selftests: mptcp: update userspace pm addr tests
Date: Mon, 22 May 2023 21:11:59 +0800
Message-Id: <f7ed4c47c46991f3ef2ae156c53d8abb4fcbfce1.1684760588.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684760588.git.geliang.tang@suse.com>
References: <cover.1684760588.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0043.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 1386a7f9-9854-4b59-4a28-08db5ac6369a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G48713zag+w4H11BAjmgpaqRhCPkDNiSIxVAZLvTfrctxERlbbfzNY7pNQA3Ati//ZlXU29RlX3IbsUkjbnu2n0Mfm5wo5XA2KeqoWt//fo6JQaNNSl9aodD8tMlOCqWyzp52J40ENIVKhp6kl2b1jAQH/a9uMDkLJlTxjdoCtQkHFUGSPDq9fGX8Kn1rnBpiREMk6BuDuALiU1CpxNULkuZ0v0QZxD9LurCuk2O+8ZgTHWgSGIl/jDLwEQElgPkXLdJ9tTF1YdDeODq8aTP2NxJqX2+SiUZ+X5Jgvx0lTVYcumGsF7s8tkWgxC062Vj0u9uKL272hV+7f71N70R1yKFphqu3UfZYTFFKxP61BYaIY+PDF058SUYm8CwrWrnefWc7TU7qwkQ/wM86Qu+1OUfRBnXjMBZmLiReKJsZE0N3AwES/ssb3QxzEwF1FVCnae7HQ14czMqrA3zCTQ98rLhY83V07Mu57MakQdYaV7AvY9FhtDmmbuWcmkJ9Oh3edysmPGGLSbYQKrJMatbtabZNT/idUvzd6Ru4iS2pbxQvpOrFYL4bCN1cAbyosea
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(2906002)(15650500001)(5660300002)(83380400001)(44832011)(8676002)(8936002)(41300700001)(66946007)(66476007)(4326008)(66556008)(6916009)(316002)(36756003)(6666004)(6486002)(478600001)(2616005)(6512007)(6506007)(26005)(86362001)(186003)(107886003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xssk9hXHN2VsBC+QON/iwBw80uPTRzQF3pvnsZ9N8ms5bNFWpoHpoYYbuQwY?=
 =?us-ascii?Q?bat2WZHSnAqZPpcjONFQ2ZwtBoLcaNv7pDC0qGe/nlsc9CNAS8XxQbO9UeW2?=
 =?us-ascii?Q?5YfdjQ/TPtOLxv/hxcRxHzrk5xufLLB/5gSbnp6G5uPDRz7yj9ve6K1e/jrQ?=
 =?us-ascii?Q?yw6uDvbFJ8/IP2svG7RPbZ8e9eIK/eBEJhPF2dtov4pXVlboglqSPtYS+ltZ?=
 =?us-ascii?Q?5KtFPIqbm9KinG5h336zTlDpaXpXTokzeizzKds3WX+ZIklHUFaEWwpsy2yo?=
 =?us-ascii?Q?QloKgjELI706/ADsijOJxCBmX7Hgp/ktYy0Lpz/p23LjxjQkS+3G9wpKG/Zr?=
 =?us-ascii?Q?1YadmPMGLPmvfC3VK4d4U21z1qrSo7fbuywBTyUu4MXInSnArULWMOQPALle?=
 =?us-ascii?Q?O9fB1vTHVJJ0ROPc8DDaitJk5f/2NNk4DNc5lj5dR7mHFyJ+rECnxwARZG8B?=
 =?us-ascii?Q?qg/3CKCLbW76HFlUrb9jauKcnQkaBLp3vvB82x178Rws9jMZKBqawGi5MR6K?=
 =?us-ascii?Q?NcDUz8pZg+1yalc0WBGekkXoZlThICsJZDMiKnp9BLR5KURCi7SGEAJ/9Zme?=
 =?us-ascii?Q?ZDaPmgPTGYNOBgIP1RA8DtqDIX9y5PAIA5ugLEX9id2Ov7WCAxpfPRk81y40?=
 =?us-ascii?Q?PK0ygFQId5RJvyGQ3Nrdb8Q+6iKaLQ6jjqs2yHDD4sOpVO2Pkuv8N5X7EBCW?=
 =?us-ascii?Q?RIDTtcTpghllYenU6nQHphDCEhigXQwlIgpLlfoxg+c7SymjY/qXun/3xFNM?=
 =?us-ascii?Q?6jtK08/mDPbP3+NYhvzwQn88Zi9b6HhaAa4dvZhHMfsz37A88jiRqdbvgLJ0?=
 =?us-ascii?Q?aoEPeFpAsS1utxVGiTxieAALnUVOkSj7bwomqBhgkVyZVFMAeafp6oE05GCp?=
 =?us-ascii?Q?VU7RqAdrNV7Y8i7FqtbNJ3tRYwwK7LKziyzcJ3LmuY7JHcrhdGScPO2Y8gZT?=
 =?us-ascii?Q?G1kaamUnhy9HZBbjhwyLImnSSjjbKFq0Y+xiO+Y7646a9sQMBI8eh3F0HAyr?=
 =?us-ascii?Q?eASluop3RkrMJ3X93h6iTeK+Jvr9M6Gm3b2WDg+wfJUi7h4U0v1dGtCXPPPv?=
 =?us-ascii?Q?RjnRcpJRW29UWVP+yQ4iQtWi1I3bXmuWu02xG5oinCNRh71tTTEVOWKNcgJy?=
 =?us-ascii?Q?yTrfj7947zP43ZLMK0vwpkIxLZVw8DO/q+JsWfgeHEjvHd5RzfpyXUTWzkqb?=
 =?us-ascii?Q?qAvp443XFNZJilJdeNQrt8eGdT77ERDVlTYrUfEkCSsBKOgcUuGk7J7kIi9w?=
 =?us-ascii?Q?bbBeDv8Nm3Z8mRhWutjoz6x5sznYGCxrVAmKYy0EMqLE/2pW1ROpa038ReZz?=
 =?us-ascii?Q?5bumvivgnElC7fdvyj90at+1cv9fmaQ5fDrZJTdPBtQIo7XEnT6xsUrvrKQa?=
 =?us-ascii?Q?g5Xsf7mC/PszGrCPXvTSynimBQ80LjEYhxOgC5m+LmQisLYamV9IBOiTVbG2?=
 =?us-ascii?Q?D78RdsKxWdLJ6Z0Sc022dM9PMVwXRdy7GnhX+NkGajrn8GdKtz0pt+7yQFLr?=
 =?us-ascii?Q?ZMlzGREYR3SmOC3k3k9mKa43xpwwq8USnvBEfcvcdgaE8vKdm4i1LmE2s/mo?=
 =?us-ascii?Q?Gkm3irBXLIs9cAdJfkqJ7HzvOU3rRgONcEFa2uux?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1386a7f9-9854-4b59-4a28-08db5ac6369a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 13:12:37.0143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 720g8oql++faUlJKtfI0g/ggJds3az20U4sRhsWX8/ohMpb5uQlR3gFCSWkpl9VpB131WY8oyOFGwq4UHHBkdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7845

This patch is linked to the previous commit ("mptcp: only send RM_ADDR in
nl_cmd_remove").

To align with what is done by the in-kernel PM, update userspace pm addr
selftests, by sending a remove_subflows command together after the
remove_addrs command. It's independent of the order of the remove_subflows
command and the remove_addrs command.

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

