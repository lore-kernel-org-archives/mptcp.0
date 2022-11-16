Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130055.outbound.protection.outlook.com [40.107.13.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69377C
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 11:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWjqVrthj+dfDwjMpqQIcfExQCDxrrojyp57SgT5QN7uJTBTF1raM/D8XXJII0/U8tnQ1iK/OqyI/c6gntXDeayZYR0WC4J1ChM9Ct1ZkKT1AV+lMIIiG7iFpM03xl2YG+yGyDZCPMAAimRW055Ia5qKXM3+TNsYvZfUBllp1lxsxdo+S5UqvOskuz/XgGbooU3ggUPNsJUN/FeGwWzG00Ym4PA2rLiBr2hsSDwXNViQ5+DQ3iX2sq8p4NJJrZOkS91Qfxa57yIaLdvar+ta2XGsbkZ7hZqkVKBUeXX2qUOX/4Zj/HN0Jc2wW/HzS7wJTACfd7ulwsalu5Mzm1P63w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3xQautB4P0fmkw1HOwKWhfub5hS7pcWPFi9zow16Aw=;
 b=eaIhs8tTMUPzkilRPPRxPdlKm3SmmJwxMpxWCMSvXJhyQ+7vBO9gkQMErwiKd/Xtju7NbLXmBB/2pNjgLq+LxFM6DnlWQX1YAYBOcoYARCRNhCO9p8tvtNf6wgbUV+AjjdyJSikq6l2SNgOQJNMph4gSgoiJ/+WYvT67DLxMqje62YmbjXiVl6SfqAJZGp0luvSoAXorjlqDH7nrjAvZC8685/f/f6pPWRKo2A/ULPzUnzEZGGRBRHta5q997+emzx+8c2V6lrPxwZtzfwiC5nDI21VWgdXdlb90ZTVR6urHUkga27Awg/hejWA6LSI+MwlVyhtUjZwc87+4JfVADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3xQautB4P0fmkw1HOwKWhfub5hS7pcWPFi9zow16Aw=;
 b=DT5CGOp5Gj6sTUvmF7qLgyauYz2kG0HsIIgikex3M8CpbAc7kfI17Q0ZJQo3cnwEGBLhpiOtyI5NEZCBmz712MrW42ersGIKqdPKJzMpTKMV7RA8zr0Kk1LnW0s8s4bE4Ls7HGaUG57EkwIuGPj80qrFxej+vfRgRm/KDjmtnvnvLbCKiinDICzq/vRw1ODKL4rJ2E4okL6N5srHN1uGHGhppx37UdjNSbd/pKssL3VlfNC6dxbKgQCYWojXHzK4Wy/nlbYhZF2WGdX2pX9h9FPH8p2T1cI4zBvWcXle57JIHS8qJmYhbA6raE/KW/jxIWfw1alYvdwPP/+x1fud6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8657.eurprd04.prod.outlook.com (2603:10a6:20b:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Wed, 16 Nov
 2022 11:46:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 11:46:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 4/4] selftests: mptcp: pm_listener tests for mptcp_join
Date: Wed, 16 Nov 2022 19:46:20 +0800
Message-Id: <9962e346177f1f5b00f418a6b965a025050aa960.1668599064.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668599064.git.geliang.tang@suse.com>
References: <cover.1668599064.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: bb66fe56-0703-4d7f-c5bc-08dac7c837b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HbuiS1eX5RWrwsEeoYiVAyg77AjuWwpfuIrKKZsKbTxJZtDhKnA9gGfBGKZ0cH481rehVK5qMrc9m0J7QhLDCt44E0Ip4As4CM+bBTjARxdXOx2eO5DM0egZOsJI0jZ/+/Jn/QHMrKSp0Qg9gpNzqHsRvnC91telvUL2fwD+EEx1njCC0zbgkNSWouBY72Hg8soTyDGevJK30NF3RR4BdyB1mnroH6ImBLTtdbdAOQyyjywuaKVevw27FBFwxjV+s5JvTQNtl/Tr2HPUAdkFhqPN08kh4f9LV1fwn0+rfOP0jL1ZR0WV/g40tElWuYJW0xivj9i1/U23Jym1A3A0ZdNEf/B8Tv6tQUydohODbnP83uaQd590HXYxrqwWaUOs0O/qat8g4AzwcsoWXA4EX6v/Syu/oGJNOte4uhu8mVmf2yV0hEG+/vQIXlvr86Y260OWlj/Gc10OHY3lYYlYxVlmTH9Q5Xq5lop56tQW6oSkEUDHYRNXL2UzIh5ZIkkwgBO872A3tQN0MSbIR74PBcBvpDgVjfSsi4d/qxBxarI3aec9tdh9bSaZ+w6pDT7dnjPC4QdWOcxlS0rEsdwa3ZpMZpp+dyLN2UsodTPxBJrn7FVwNHS8NvSVQICZSHWzW5bM2ipq89/pmtkYl3PccHoZVwAWJuMKvrdXQ/KuEal9aCsw242JW8f098ZdBdN5QAouPVivrFYXkpWxQKPbXg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199015)(2616005)(186003)(44832011)(8936002)(26005)(6506007)(36756003)(107886003)(316002)(66556008)(6916009)(66476007)(478600001)(86362001)(4326008)(6666004)(8676002)(66946007)(6486002)(5660300002)(41300700001)(6512007)(38100700002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VSxveC2F771aFDb30co3Kjjm1ptQ/uXRqG0RLkvhJaQFjNfWXVVGqSEkzirq?=
 =?us-ascii?Q?V1zCU8LsnZAZL5wPbwNtADrPbIdMf/ehWX5WCZpswGLfFSd8o7JU71aKmAD6?=
 =?us-ascii?Q?5sQ3JZdo8U8wS/0YpI/Zf9I+cw/god0Zp9J+5XVMTDgsKoRh3Fj4gR2K/nWz?=
 =?us-ascii?Q?LlYcAbnD3KgX093RDqwEoqWytiEQPPG+Zkg22KOZg0227ViRKkDPQ/5FVaf+?=
 =?us-ascii?Q?viOHM2jb4Fblwuw9B1OT/UBJqk2gJ72kncTKl7Zz8tHsaJ6KoP3ye3/0Y3pA?=
 =?us-ascii?Q?wMrEAvrNwowRRKk7RRXqWH2/QuegzC3D0kROVWRsHIVXqqfW/MhIo/qElF5y?=
 =?us-ascii?Q?B4mX3XB6A9uyI3NHHNskJtRfygk62MZGM0xbT3/OUNQ/GvyZ8lFNDPjZMz0a?=
 =?us-ascii?Q?g6PTbgrxCaw3L2//mYv1Dxvpp44xaZqBKvNGj6iaRCYXdVjbXPVOj/S6Nak7?=
 =?us-ascii?Q?a47LgH0aQB92ZJdBqj7lU924EpKN8hcARYdNop/qb0luDqPrCCisE272a3FM?=
 =?us-ascii?Q?SreOHNs/4IUTcDYfLXC9rVanK59fbFdJCUQ/mDfIP43cRVhjG/k74MuYYunh?=
 =?us-ascii?Q?5Q4svTH6Ab5MQVsHcJsMj3EwhnR27GH6uPfeWKv0ASmZR+lzaHObFuhC50bs?=
 =?us-ascii?Q?qUrtLayJcPEXVuFmiHOWWXEQqpXD7gW8QM273P5JyER2ZowxjZxFc3u+mTx1?=
 =?us-ascii?Q?02Tsa7yfvTWJqTlHDau3GNO8za1azxEcu6s1qT5NJLU2M/KNVDxJ0xxV2FN/?=
 =?us-ascii?Q?vuqBjxEc9/DE+3mUvZIzgDu9pONWHzuwICrPtqEwrEl/OwtpmKsi5qqSKCa9?=
 =?us-ascii?Q?fMehFgFyfO1CdD3c83oKyR6CXX5SkO/eiE1H6NebuxbPDWG0zLFiPjGG29Up?=
 =?us-ascii?Q?gBBK+7MYhGJrwjraJo5iepOCYBztJU8xNro8Svb9xZMwQgTnjrfxC4IzYITW?=
 =?us-ascii?Q?4FRxlBUh9t0gQp6u9Ke1RCrAexJqAbL4IEmgV2tHk+n4o4NMx1bOFoLqqh/M?=
 =?us-ascii?Q?OWUf8dsWfS1pm4ZxYsMBIi/SbMaBbjt6jmaHn1UMy4mdxPd9HcKD6aIJmfN7?=
 =?us-ascii?Q?PKI7sMA8Onqyx4cllH3tx1R/rSEEUEbB4HlIOxibNZnWKiR4RDcbTfVWCE06?=
 =?us-ascii?Q?3OnHuqQK912oyVXiU09p58Br0Q7D8CQBKBwNBfQY5bIL3VTMbKrihIWEOxJY?=
 =?us-ascii?Q?3MBGuq2oqMehieCOdzK8tRgEtGwN62bHQJtZtlnMgN72TeHbBvN54x42qdNZ?=
 =?us-ascii?Q?7UYwbG66v11B32MrmxH76wIhISlJGFGWeD5OuaU2ZtQZVDOUDwnR6tGDSFK3?=
 =?us-ascii?Q?trQFFFdW6y0h5pHSmLImKCrpEcGsfaAECnn+P6Fi02AmuWhUN2ZH0PASKNj9?=
 =?us-ascii?Q?lUe4sjHpNlN7zWMc+1cS66XIHPcfxBDpYZCXdJDtqjKgHjlQfkO1fdZQdfCm?=
 =?us-ascii?Q?asnmLH/WxHEM5Jc1NUUV+R6CYM9s7u4d0OL8inqjtYrwPLWe7QhpU+/DsxIm?=
 =?us-ascii?Q?MiONc7AOUvrCyqJXh2Y0ZFmUz6mAV4Ea1fx7bZGJpNA3Y2pSNoMX6KxynKUu?=
 =?us-ascii?Q?11bvCiyK4vGsGeRrcv4h18k17uH5R+RxsEygJEzkrhvCOTEmsigI3rxENzkO?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb66fe56-0703-4d7f-c5bc-08dac7c837b9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 11:46:37.2404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: th9PRRAm2wmhohHcpYdax3mOz+SG8l2VNKJIjQezJMVkpXUKIsrzbgPMkaJBLtXlHi1e+iWd00Fk9/+xxY6XPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8657

Add pm_listener selftests for mptcp_join.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f10ef65a7009..0810e9c12fd5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2509,6 +2509,54 @@ backup_tests()
 	fi
 }
 
+LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
+LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
+
+AF_INET=2
+AF_INET6=10
+
+verify_listener_events()
+{
+	local evt=$1
+	local e_type=$2
+	local e_family=$3
+	local e_saddr=$4
+	local e_sport=$5
+	local type
+	local family
+	local saddr
+	local sport
+
+	if [ $e_type = $LISTENER_CREATED ]; then
+		stdbuf -o0 -e0 printf "\t\t\t\t\t CREATE_LISTENER %s:%s"\
+			$e_saddr $e_sport
+	elif [ $e_type = $LISTENER_CLOSED ]; then
+		stdbuf -o0 -e0 printf "\t\t\t\t\t CLOSE_LISTENER %s:%s "\
+			$e_saddr $e_sport
+	fi
+
+	type=$(grep "type:$e_type," $evt |
+	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
+	family=$(grep "type:$e_type," $evt |
+		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
+	sport=$(grep "type:$e_type," $evt |
+		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	if [ $family = $AF_INET6 ]; then
+		saddr=$(grep "type:$e_type," $evt |
+			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+	else
+		saddr=$(grep "type:$e_type," $evt |
+			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
+	fi
+
+	if [ $type = $e_type ] && [ $family = $e_family ] &&
+	   [ $saddr = $e_saddr ] && [ $sport = $e_sport ]; then
+		stdbuf -o0 -e0 printf "[ ok ]\n"
+		return 0
+	fi
+	stdbuf -o0 -e0 printf "[fail]\n"
+}
+
 add_addr_ports_tests()
 {
 	# signal address with port
@@ -2589,6 +2637,30 @@ add_addr_ports_tests()
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2 2
 	fi
+
+	# pm listener events
+	if reset "pm listener events"; then
+		local evts
+		local pid
+
+		evts=$(mktemp)
+		:> $evts
+		ip netns exec $ns1 ./pm_nl_ctl events >> $evts 2>&1 &
+		pid=$!
+
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
+		pm_nl_set_limits $ns2 1 1
+		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1 1
+		chk_rm_nr 1 1 invert
+
+		verify_listener_events $evts 15 $AF_INET 10.0.2.1 10100
+		verify_listener_events $evts 16 $AF_INET 10.0.2.1 10100
+		kill_wait $pid
+		rm -rf $evts
+	fi
 }
 
 syncookies_tests()
-- 
2.35.3

