Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53F8A2D
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 10:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GW67+aJL/LeYAn0Y05eJI1ZksZl4d+kGfQiaIcndiOyf8hUH/rtwd2Ul8X07T0plw+Han1auEUyDm+eRzLejn7D1QkDyk9/XotA6NxGRcUDnF4K45ps4TxsKZbx5FVoLZ8If+OqJ2FYL4vnvcFYwONaPws922Z8/mAfw51MjcRzlz3xxQ+y9BCe+IXwFuw8lrvYegYlfh07FOiUGSgpm2PZys55JBOLeryOKb5GD1jXJKFsWC2YncHB6KlKgZ9KyAkHeIgPeBatFXf0mxlOJwjMBnpGedr999vhOHT68ZWeeA/1mT7SLqQMFcFGtTbiXK4lphn4oMgY9OMvCxM+0BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kI6ElL2xjN11D5EYTplE7+bIxpKKHH6XehTsvkmzj2k=;
 b=ZEATQK5I/kPUn3Jt6T9LohE/3BoscNgg11bZmn9MOlgzSqsbUZNze8Vej0DwiwKW4hW7eSCYKoRPG9DGzg9h1CBr8MuLnzPNVWW8aKLM6XmxgsS4Ps746XTrv9UkGov9OtgFfh3OOLBj/UpXVnbeaJ08c8mjRtcgu9xcuE84+3J2Vh2ZiTsn4aKmb0bI2ZsnMprXDP9D3Mn7oIMvlVFGI86gJmxiKlIxCvES8vAGs97KrEQFF1w/MBYpN/PKcjGbMo0Rdr+WPyG9sDeiujGW4lU2Q+nsOgS7ydfYhVCjvn+pItNnPq1jZuqSb9irAj13+lY9tjbbsjzNl/KkDuUAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI6ElL2xjN11D5EYTplE7+bIxpKKHH6XehTsvkmzj2k=;
 b=lKJYcsRfttf6taLUSpFNl9g8VJA5SDmJBd+KZps90x5Qq9XZRke/KqrHtRwgqYoR2j4U87HHEL1rTAx/h8gcapSMdCW9geiVaHArQyuw02NYeSIYu+N53HvS1zTs+BNFfzuBw9O19wL1nv2+XTY395YlrF+MY4w8+47u2On5+/nYM2geJ7gPWVuy4p6XATNLeu7sTp2LRUntsc8zh28NRr9zJddaDR+YFdkWR9k82T/Zw8e0eanhroPP4IP9dc83wZbl/HH0Bnh4bHJQl4pdcY5UqmS4DI6ZAqBh3E3XYoUJzKbbmjkwqZXjQKFE258Ljnv90METGRDiCdGEQga3bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8908.eurprd04.prod.outlook.com (2603:10a6:20b:40b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 10:20:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Thu, 4 May 2023
 10:20:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 02/12] selftests: mptcp: update userspace pm addr tests
Date: Thu,  4 May 2023 18:20:07 +0800
Message-Id: <7b89e8795f705e2dccdc4d17fde7c114d92a903f.1683195386.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683195386.git.geliang.tang@suse.com>
References: <cover.1683195386.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:4:91::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: a9720532-3ceb-4779-4d01-08db4c8931af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FVIoEUnBO4v7gKek194QT6he+Mwavuvkat5F8O3vKrCvSow4bMu+mLR6i/dHhm7EwktNAUFy6MHMnvttoJxjMN2ysQRUhiR0UJrCxbOMuDEqzBWhwYDhgK0YDxvzX8BFdrvIvkrMY0Dprl3Tw/tjwOBy0ttdSlVHwieYn8Rkj5u4Qacl+LBj3zx7wZa0WRvcyPRtB6epYmTFN+iNyAM/FceS/7Y9Llf7nzfPgctlKx0TPR5TsvHK7SJjE/dzLZ+Kq6ZpkaI1MLjwb7BQhYg+szViLTXBX29OwnNzI8sxFO7ILTEuAIODZUklqno9BrFzxk9a1orsJssUyN4V/QmKegpqI1mX7lsd2TEdlmKYLpVv2KN7JjY2Mky6ToENp5EfZSUnk33Kt33xix5/fFIXQoYbY71EqLYC2Ln0xi+fVCv5wSBYSLRjGjGfHACLtAbIUedr7gqdKxllByQXYTwA/CbBDEmsxhrIletl23yanWk9CEresxcp/WHQ7QklDm+D0BfqH7Pm9ljcxU3XM5mj4aSlsN+pyCkSjvTTkoCF+DurPdt160TH9kA12/cDLHvs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(44832011)(5660300002)(8676002)(478600001)(38100700002)(8936002)(2616005)(6916009)(86362001)(15650500001)(6512007)(6506007)(26005)(6666004)(66476007)(66556008)(66946007)(107886003)(83380400001)(6486002)(4326008)(36756003)(316002)(186003)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ebQzO3w4W0qWXGlz8StOiChwIknUl1ucNKpELmaYpXbO4cVAQ43xqdqmWA6f?=
 =?us-ascii?Q?W7s/inMiynVzxLFF1W2RSJEHB8B3b/i4BKkISp0ojf+tQdE+wMZj0mvt8FFF?=
 =?us-ascii?Q?7qXzQ0tZJ2+qwdWney6v/Zoqc2+aXNpf6dSpV0BZewe+Gqy37SC3VnNj9ix6?=
 =?us-ascii?Q?d1VoWKqE5LeR+Hkly7CnX9/B8NZojxixdDHp82YcK9XPupD+tQDk2V4CEyS/?=
 =?us-ascii?Q?r1RGv1tB/biMyrLuAgox0GjN1e2vDfG0hKtWxEFaVPXSics4hpFP35cgSgKH?=
 =?us-ascii?Q?FUi50tVx5vzyZG+LQs5S+Qt+Wa/tK/r9Y7FV2TvPi9wriqrqGa7dukiyYa93?=
 =?us-ascii?Q?otbu4FEXPfNcQgTBzJOjYiofZOC3tua1Lqm4iQM/sih1TSWawk5vP81e8aBF?=
 =?us-ascii?Q?8Cn2VxIdJY7NhS5Y2Y52u6JS/oajoi6qWMlCA6Yb6M6pcLodEXvR8kU7EJE+?=
 =?us-ascii?Q?e1mbWoBOC4ly9whB6G56hDxpgKayRLD4etUeeiIkwbO/wMxAuuvfmwZ1zLQm?=
 =?us-ascii?Q?sp9B562eQf8Oqklu6G7UWCBmVjBS4ZrbMSVT1RyEgXEzmz+1nHchi7ASf0E3?=
 =?us-ascii?Q?3Fbt62X27//2x/0K9oZf4nK5vfvWOJrgWx3xCXANGF0pkDXkbzOKfqEnYjBS?=
 =?us-ascii?Q?sWMCA8M9jG88hJuqviVDX0AFBKd9VFApbuu/dikhiZddvYHg9QuY6imjsE/j?=
 =?us-ascii?Q?+8zqmKlMi9jg0NNO4E8LxXnl1qDoujkx9Goue26FfDfMwPQF62PKqqyNIRuL?=
 =?us-ascii?Q?qiB1hTIbXSMFa9/+aHgyzRcgCP5CIA6tiCUGUFl60YnsRMLa7jLmKECY5w6p?=
 =?us-ascii?Q?YDQ3UEBKJz+juxzT9/+bpsKr3gTikD+0ErIsYNZVnaeeixV7loPxLeMcDSxg?=
 =?us-ascii?Q?C0mX+Q8SCpoTpjHXr0izcA5RVvzwdXCfKk5HTsTUe5LwHL4gahHSy1hkzTcJ?=
 =?us-ascii?Q?b7WZkef7M3fNsb/avM5nNDCOW/NAJIBeml2RDhIJs3+HQEJN0tTt65NKrEn7?=
 =?us-ascii?Q?NXknxq4mINaXiZ/KzQzyBm8Lh5qznhZ7L5tSOzq44SH16thmWKgE8KND5mLv?=
 =?us-ascii?Q?qemSNvJNeBI5N95V7FJouAqONm/VcjuXO2qVV7JFA8tqGx0NYZb6E0UZAjWc?=
 =?us-ascii?Q?/LqFrnevrkcmVwOE16b/VuwqJdCSeq/tm9aGYuz69PjXuHPBUCWm7r4enpj2?=
 =?us-ascii?Q?mLDp+k/b0T+VKV+XOhuWQfoLySFUQ5XHtu6Gqey2NMtWRxFXTMkGpYXEqi04?=
 =?us-ascii?Q?8qj8TfkaOvFsEaBE01XtzBBpxrOhlkG5bzzJ+VYnty8DdTdOzRTepxDskMSA?=
 =?us-ascii?Q?eTAI+50MRO+lzOPieEe/qVXmjHDV7zTL/knQocPU4a0fBpO0pYoedJl1xz/9?=
 =?us-ascii?Q?CsY4EQztq0QHMZrjYd6s0nACY+6XQUNY2iZ3md4T1PKNxgqJ54MBkpc1Jum8?=
 =?us-ascii?Q?DYSOaV4QB4zUPRvXVKSwCEhNIlCQrFLrjRUqaXDLwP8NS2iwwQ3eM6o8Km6Y?=
 =?us-ascii?Q?YuDyY9KBjGp6Kl/N1DlWyMglQuXr+pQNBP6Jrz/Fdf0QucJF7nhs3NqiSRs1?=
 =?us-ascii?Q?yPEY90cGsh3j65DIPHDSWCPn3WSMwaRYPgQIIGUP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9720532-3ceb-4779-4d01-08db4c8931af
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 10:20:33.2269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnX1Tdb4xtf/vlkv/E1GumjvWtjT9Xi3IlwWbdahe9qdcSkon1MAGrOXLRVRxFdU+tM1bB6jJfoiSWc71nQaAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8908

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
index 627daeb513a0..cb0ae133f5ed 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -864,6 +864,14 @@ do_transfer()
 				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
 				sleep 1
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
+				sp=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+				da=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+				dp=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
+				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" \
+							lport $sp rip $da rport $dp token $tk
 			fi
 
 			counter=$((counter + 1))
-- 
2.35.3

