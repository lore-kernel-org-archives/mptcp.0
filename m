Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2068.outbound.protection.outlook.com [40.107.104.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4389A628
	for <mptcp@lists.linux.dev>; Thu,  9 Mar 2023 02:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mC0jPQJ3m3z8EiOkZsAZWrCKHq3Osq15qS4uaVabeiZyv0V/SiBirp7d4/AgPfCynGZHtCg1CEARYR01GpkXFwz3JhoU6estl7oFefXP51JEo97zlCKfGAdAODCtUxu8u5lnpRVEXb7ng1lkF1lXXDAN/0dm8ULZX5CFaQmz+uDeHTQLOog+KAj6Z+TQixbAHM3BnMziag6FmouvrAJrilDqnNnFG/+Ouu3g+wxC/8Y1vbvBk3FOtCMPjb6VJn+PpfNNUtgj6C2ebp8cqxfGfrNcY5+qCb0kqFkJUheCqSOf1BO82YWUEXsXPmbyKjwRT+50+1hAWXlhynQXhytlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3YfkUjs+HqbrBnbeJj4ViF2Y8cSf3TmKZlz6y887g8=;
 b=cfd0egTEb/muFRdO8umkCq1PJEaIDUDaq+SY0ng/Lw6gGl/xOxphKdSyuu6HMk07sFzo/Vozd77/QN/Ea52/3pQ2mwrUD6De4DoG69NzHp7ZVRElDRe7BSlngxPiIlcUDhTLCDKvI4aQ8Y2rBMOREWfWPGVgMN8FhQTP6lzZrtbMyMl7Z1wruPBnJ6JGrLvaKSb5sDj6Tz1ALs9lEb72Fv6Noel/XtBeLmUmz2VCijipGBP1kp44zmq8r7Atxj4bieusTXVtEb5RT08QNuEDV+/4gO3bRvPTi3TNZP9NIG53ZBi70KIDXs+Q2IF//+pYwkAtSsYcH0eNlvizuSxr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3YfkUjs+HqbrBnbeJj4ViF2Y8cSf3TmKZlz6y887g8=;
 b=r4AaoG5xoDnumM/LjIpmgdxPv2TdtC/7mLc0G+7oONhM80oHg9aV//7uvQlzvAa3TwrOa7C+Mf2MWBrQX/y36X4seSHXtVY4uOL0ewIW+NsEpC6NCs1jtUIY3Laoka5SUt5IiShXl6mCskxnnesLZ2hAjBYO+0eFSBRZHMvGWZ5Ij2apKDHvhw56YIK73qSpbAcoASVyfhRG9b8PyOU6Qtfzqof2frD5It/sGjdPPRslxky86DLwtzJiqsHuQxZc28zVy7T3+7t9+DwdovbeLmhXGed2EYo/v07NdN3ZN0KltQmFdQoYG70yqcICu+wbVg7n+Hb0uM/X5iIFlIsM3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7981.eurprd04.prod.outlook.com (2603:10a6:102:c0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Thu, 9 Mar
 2023 02:03:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.016; Thu, 9 Mar 2023
 02:03:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3] selftests: mptcp: add mptcp_info tests
Date: Thu,  9 Mar 2023 10:04:21 +0800
Message-Id: <9b5a84ef14899800a8a0036cceae0406e016596f.1678327360.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 541f0d31-1585-45b6-0ee0-08db20426c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FOqqiGbjTDEPswQYe5ASJTDKp2ISCe6RzJXg2MbRFpfIxKuRf8wgM4a2vbBtX4PnUhFboeiTecunHF6w53+TnhupSeo9CAqy5gmrkZOPYWdwWOx4Rlj6au2HSjf+ZdJlyP6rVl362VyZMM0BS9xwF6npYStgA/PmAeD1nbE9XGwVpBRqYSZFft7UYmnnTeIZrycXVzZE5cEvmWIhE5c6GfxvGYkHAIHqm9tOUcwObep8DZCyiDUvTsvorkDEyApIJr0fDTrR0ouQkYHgcmDjZUDg/Z1rRLgbXCnNj+NI9P00M4GMV2+3jXYFum05MCl/7F9lLksvhBtI3pbnhQnzjxy38Mz31vQmNZnu38Vh0c8aLjsosvD6tbRAOTGVCR3WBo7CSlDvV4v3p9nh8PXec+yX33ZTKNi1wKIP66fFJ1dNlX2r/sTmUfEcIJyx8pmO51OPZPCkw2lCvzJFtdLQl0W/z7LvlQuL1nQmoKt8A+P3D2vVs4Lo2UOHTaUCxkEq6ipYcR6kfdnS8RqsXIGRbzQvx+SrR7lK/M5QqA2tFo6lz2lmGT9U6HldmIY9xIvlyt6lO8L+2NfQOohvTR5xuHjvtXRWy6UXytAwJsQlmf+1p7S+UZh0VHAegzs0uM2U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199018)(316002)(86362001)(36756003)(38100700002)(6666004)(107886003)(26005)(6506007)(6512007)(83380400001)(186003)(2616005)(8936002)(5660300002)(966005)(478600001)(6486002)(41300700001)(44832011)(2906002)(66946007)(66476007)(66556008)(8676002)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ya2sPMkPAQyjqIp0Go4gXxuGfcxIs98G7ZVCOrAiSdsNwQsUJIxtVG5xiSfn?=
 =?us-ascii?Q?b9eR9lxA2xKxOF8zAO/o9/wKK7ix98Yc+T/nnPeqXPnNO4xCx6q92PFtAgdm?=
 =?us-ascii?Q?W3ifRYYr/TbxTGRzYCEMIGl7zG1U7MgCsbDDCzdtDvDYvh8L9lLUTzxaEWvr?=
 =?us-ascii?Q?W8e2J2KrMV0ikxzRrm3QdbKBtDjyIWIU4mZFS39ldAlYNDpxthzHcnI3iIFU?=
 =?us-ascii?Q?vqlDBiyXCUh6+SSHjY0mG4+16ePJVStItKPNLMiBSPUOk8YuW0L5wPUEfBfV?=
 =?us-ascii?Q?3zWk28SVhI9YRuC8uWI8PdrUzl0hjNoIVkUhz6vl9C50jl6lOFc75o9LOTjf?=
 =?us-ascii?Q?5dqMM6h14jYHEC71QC1JYAYfFxW3Zclj93hcI+OW+QtUUGqiK51HyRBf+um3?=
 =?us-ascii?Q?lHLc2o7iqdQexd+5tt3AuRdX8/UBsf5SOzKZWautj0gZvdAbgkTQOphX2YI3?=
 =?us-ascii?Q?BBDvxERzaXRQgCmCbSrxLanPVb/IOHORpMzIXuoaV7A4lZodOkoUMulb/lj2?=
 =?us-ascii?Q?vIbbVcNEaBhG3R7JBNPInnsz4tEgvPKkBAg4xsjghTX10aSkzVE2pgDrZo+L?=
 =?us-ascii?Q?719+Dud/cCeaxJmJTd6JwGEFjiuoW9u97b0wQXfg4JnbU1iG6vCvXreFE/5J?=
 =?us-ascii?Q?4pfpUHB+EnstHfrnR9gdyFh5sJlBoeR/l+47jQMVK0bzxSWDxrNfAORMdTwM?=
 =?us-ascii?Q?Qw7L/JQmAOWlsa2rUIXp5GF7SoulwEdCf1OaJYt0yieQ6zUAmZHMMEzvLQK8?=
 =?us-ascii?Q?OM7DpHz8xPjpWuNxollzHP8Flp0d+UniWeVJotfBxuqLMXiA0ORnC1OyUM9V?=
 =?us-ascii?Q?4FIhSx7a48xA2HB8hIFjEsK7BgHRXwqpnjlT+9EcYVHTWbQH/PBNgKGlgEYD?=
 =?us-ascii?Q?NXPX7PM38Cs7r5zviriRD1WJ8H75aPkSP/+Yj46c7yedzgf5Lx0xqUcu2Ub/?=
 =?us-ascii?Q?Xo8oMgcJH1QVNXESfsSTt3iBMqvHEMvfKIMJkVKXzKJmnJMRPHVydcIa+btk?=
 =?us-ascii?Q?HgzxDO6800d5SXDXIoSb00Fiz0wDzxbP/KhAOjy87+vJgRJSbA8x3mOPQ8XD?=
 =?us-ascii?Q?3lSwHAu7ot60Qs9/5LXhWmhRS08aez2ZFunGNPgape6wvkeoH6Y8nr10+tha?=
 =?us-ascii?Q?NEkkPANbguYM8+Oke7Cc9fDTZcid46OlS/DQKZsf3sXF6cZWdhf0f50gKTYA?=
 =?us-ascii?Q?l5E209bx7awbVaGHi/JubBv4rl+4qPK3mShGB5Bb9BhReEIYmUjc4jAZT0+J?=
 =?us-ascii?Q?hjhKw+irTGakV9QQ6JO+hpgEoZ0b0/d1nj1/uEe+8d14hY+kfCeNDle6uxIb?=
 =?us-ascii?Q?c8nWLd3nF1FkQh1VKBm5bJfQ2sRLsYALjzMACQniqzfnOFRkrx0lC7s+iUFs?=
 =?us-ascii?Q?t7H9W46qL07IqbCklgAV6CLrJJU8zK0xXzS1Wx8yu49naYFl5ES/+njx1Tne?=
 =?us-ascii?Q?959RDwkIVb/CR7ZMPuNpyflYR/6PuuiKMWR7cFqUoQjR/bxgaVCM5LkWC2HE?=
 =?us-ascii?Q?Vp89VNFJouL1UV/C4X59vDXR0Gp6wk2mTkit8FlOAfr9tOW5P9P8UMlaMaHL?=
 =?us-ascii?Q?WbVALzr3FtRXwqcAO/9q6pbOvwCcuZATxDgceJxyaJ1KUDJEkerT2Q4jGO9h?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 541f0d31-1585-45b6-0ee0-08db20426c71
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 02:03:06.5304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUmhn/P5XaUGz9QXcvDasDQnlxcTYblDXxAGDAO3aug/EEtVupdTuJ6pzB3mU3xeEH6UT+rLdZ4xHFhDLYoY7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7981

This patch adds the mptcp_info fields tests in endpoint_tests(). Add a
new function chk_mptcp_info() to check the given number of the given
mptcp_info field.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/330
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v2:
 - use '-D' option instead of '-i'.
v3:
 - add tests in endpoint_tests() instead.
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 42e3bd1a05f5..625d24d94576 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1719,6 +1719,46 @@ chk_subflow_nr()
 	fi
 }
 
+chk_mptcp_info()
+{
+	local nr_info=$1
+	local info
+	local cnt1
+	local cnt2
+	local dump_stats
+
+	if [[ $nr_info = "subflows_"* ]]; then
+		info="subflows"
+		nr_info=${nr_info:9}
+	else
+		echo "[fail] $nr_info"
+		fail_test
+		dump_stats=1
+	fi
+
+	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
+
+	cnt1=$(ss -N $ns1 -inmHM | grep "$info:" |
+		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	[ -z $cnt1 ] && cnt1=0
+	cnt2=$(ss -N $ns2 -inmHM | grep "$info:" |
+		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	[ -z $cnt2 ] && cnt2=0
+	if [ $cnt1 != $nr_info -o $cnt2 != $nr_info ]; then
+		echo "[fail] got $cnt1:$cnt2 $info expected $nr_info"
+		fail_test
+		dump_stats=1
+	else
+		echo "[ ok ]"
+	fi
+
+	if [ "$dump_stats" = 1 ]; then
+		ss -N $ns1 -inmHM
+		ss -N $ns2 -inmHM
+		dump_stats
+	fi
+}
+
 chk_link_usage()
 {
 	local ns=$1
@@ -3118,13 +3158,16 @@ endpoint_tests()
 		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
 
 		wait_mpj $ns2
+		chk_mptcp_info subflows_1
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
 		sleep 0.5
 		chk_subflow_nr needtitle "after delete" 1
+		chk_mptcp_info subflows_0
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
 		chk_subflow_nr "" "after re-add" 2
+		chk_mptcp_info subflows_1
 		kill_tests_wait
 	fi
 }
-- 
2.35.3

