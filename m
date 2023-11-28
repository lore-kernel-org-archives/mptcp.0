Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A082035888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="suJutbJc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXMGYN67sgy6dlls1GT0eJmhsZ/vPPy/+XQ26PGb32WHfbFRW+4I7ynTrLiZjy2H8yiGyN7g5bQbM++o7SsUB6pWebrfYJczUa7qWSYAExqA/stRRnZVwA27B3Xlyzm+Bh05CNaB67zkX45LyZAWf73mP+1HmAvkv2c6XsBGr/sk31GoU+kjJXapu9/1WoYTLBWOMcFXUiQ20i69zd85ITtKfcNUwNvZZR96kYQKnnehbgE4rEh9A01YR5ZBWg1UY50qfYFnoQeUQf4gkoP+Oj0xG5Evj0OnKSKORt2Gqm6nqQJCOkDv+4+9iELgLzZTevcee/C82QCKiN5IYuMJ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyRzY/fIEaVwU86yq9iU6ZmsgRtYc8k1JF0Q1WlVzNs=;
 b=ZpLFyay3enzS5EnyxWzFLdmsVVHDpQIToKbX9oVpP38KmBH1E5J+dUtyOLxqxwGyp+LQbnVxx5djaNHvZtVFnDpKbdo1YMITuumR8ZdmexK6xPcNwTNMMQ9LRzyt2rK3kO5MCxvsmk8xLZIsjftS80Jkd1IKIChRNAtKuDPso4Qu5IwK62Ms75pFd77G0ind5u+bVWCpTLZMJHTOASg9r5NrhAbYU9kzuaj887qeSKSdZT+tLU4QNX5rh8lZd0syPa2iH4qP/fx5Nh9w4hJYt8zspzXFhINb5zDzysCspuTvXyhOXUSrZEPa2PgvicKaUJpARC2ffu9TqxAdH82fDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyRzY/fIEaVwU86yq9iU6ZmsgRtYc8k1JF0Q1WlVzNs=;
 b=suJutbJcZIcKG3Deg7DUVGpwMkQSDBw72X5MULJCYyF1PqLxUKOGDLkSb9Nc9Pd3Mwe27+8WBmDX3HeWp3B2cGi3+yYV/CXZSmTnKe+dSOZBaDDncSTDWixN5zutyk3K1/PPalLyMSsJnRZucT+29VEW4HgGlSMZGcls3JeYdyI2h8Feu5ZVm4OonMib+9MN5izFD+I6glJ0TywD+GaTcnlh+pFn+QonmQqTL5in8OfSoZuj7yhvKbXt9Q6fEvFsmQU7bOoa/+mAH7v2MTAWYsEgYRC1gjBaNFgWzrq+cfOqv5mi3e6n/lpWAajRaIbfLA20NZf9Abcb4krWEYaaug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7045.eurprd04.prod.outlook.com (2603:10a6:20b:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:23:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:23:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 13/32] selftests: mptcp: dump userspace addrs list
Date: Tue, 28 Nov 2023 22:22:06 +0800
Message-Id: <6f7bae86eeef8d7920d9b82425959b876af0c105.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4bcf4c-4fef-4faf-915f-08dbf01d955f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z03Va+TarCBgbPn9xb8mFAN/zBYQRuj+iv8EumSFyg8c/ZbTx4TyLGLM1hTRS6V/1h+x1AsoaEdV0TXh1jaFzL4JpYdY8tq+2HemsDqz0nAQGFtLeeVQ4yUi4+arqbHaZu9p8vXC0RWzRIoE5GnAa5qx0SttssTO/Xk6qj42Cp3oY3BvYF3HNHaIgK87n6Y8THDGGPeXsWXsfvkzrxKyGsraLfoF16a37uhB9ZNDcDHTJfXS3Ax2f6AmEQo5G2e3n8LkKFE0r7vae//0ELmLiXixm0owVZSKcvlmCf0CVY8YiJ2nQ/GUtfAWx8Ux6MdI5784aSIjIujTYZJW/DyYDLZrMcupS9MJevB4yMXqNAmZQBgYoMk1dZzGOy8kuMveYasgrgykD30WtbUb9nzl4ZbWHm3B7KC2kIY40gXIdIyBS45h1xoYxxoYRpR9PRP74rRaHFPORJ8sdY/Xqh8L3ueIdXSlfhy7I+ZdZVnZ2qREJ1kIQ8Aqn3lLYEgyrTXqK0kOHPm6jhQNnoXxFXQDFnLdQpuxNqll05r/NdQPT4an00lMLfV9zflS1+0wt1Sn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6916009)(66476007)(316002)(66946007)(4326008)(66556008)(8936002)(8676002)(478600001)(6486002)(36756003)(44832011)(86362001)(5660300002)(2906002)(38100700002)(26005)(107886003)(2616005)(6506007)(41300700001)(6666004)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XZaXOXw7p6sJheDMb/KMQep/RwNH2rgJA7gRnEhL3j+gg8q1/zNzh5kcxyEZ?=
 =?us-ascii?Q?XJD6Afm7HjHAyMeSSI1l2UWz5oiFWWBRjWP/eAdIa999XPZgaTcqqM/MhETv?=
 =?us-ascii?Q?dzVsUeqLjoiR4mbvmvWkieeppbXncwEzGs3F+/5hiKa2vjKyu3n6FxIQm5cy?=
 =?us-ascii?Q?wZHEG2EQrLX0HDGubVYoNK4Ew9OZnOcHUnZKrLeSHpcqgzZ19Y/+PyTqgvBr?=
 =?us-ascii?Q?7byM5H/MYvisGzvn+2/uXpdYYklqcKNrd4d8wHRYp5+T/gldJm2mHV/uairC?=
 =?us-ascii?Q?rmL5mCBiNeXq5qy7CuUNo6G/0pS+dbfDfC1zeQnT8nzPSxV/ntQIOXnOH5hE?=
 =?us-ascii?Q?Rx6esufmr/NejpzGQBchAk2Hd/XZ+pTlxBxFPtaOwQdIVWbvp4bdY2C7gewY?=
 =?us-ascii?Q?rGYjgigEr2CZhrjRrOtIhXfYQWElAd5vAkW6rdcwMA2i5wTWWgZQBElmi9Pp?=
 =?us-ascii?Q?Pukl/36WgtZO9GkRUReCi25Epub5WvXXx3jRgImno1WGgWuAGMsIQpw+zsX2?=
 =?us-ascii?Q?NUhyWL1FDwBeJhwqtOK4VUibrluzSU33ZR0CBJlCZtdjKxjleHn5fw76q57R?=
 =?us-ascii?Q?oZcp/JgHUF2b3/EMt+3nJqTepvyJK4rQdkRmd5QPyasod0IilEFTmm2tu3ld?=
 =?us-ascii?Q?noQqXM1ITCpXEkka1UOlIcl+KZdksqAwFmCBIKdqrGGnqn0FYJizKl+qj+nV?=
 =?us-ascii?Q?TsJlMgLiGtSSgWV1SWfsW7t4On50tHt/ZwKPIGPQ5HKeDIH+NNhApZmAmB8P?=
 =?us-ascii?Q?WJDAmACx5FNKhTrZIpml9pqV6lYxT92DzGJrk2k6AkqVXqPyPD2UYO1aIdmA?=
 =?us-ascii?Q?PrshXKsYqaXLnEiEC4h+8dOaxtWdee4uoCcI3cTvLH2ssZn6+VE5IcMu7l2L?=
 =?us-ascii?Q?BF3BquTzafvVVEl0i76+Cga2OrWc/h/+O/ocpR2/bOeUn7wCPsB0+AtXLAm6?=
 =?us-ascii?Q?scnW08mvUDzsyFyaRpH64Inu4JctV17Xz2lKFQRcHqdJ9FSzdTsfroQe8pYJ?=
 =?us-ascii?Q?ANoJJIGLlaAqJmJpvNsHFhPpJdlXrNyVLHREnB8szMwxrzZQ3p1L9nb2BS00?=
 =?us-ascii?Q?RFnIUTR37HPNW8iTuIqozt9UH2Q0EVtJ1Z0gyuQHjc+OO3YApo1fnGoyZssc?=
 =?us-ascii?Q?uqR2+mY9+t1XLw53VwOxTEU5P5e5SBaqaVbG6vIaTnjl8iBKkFIGqgzTqpSI?=
 =?us-ascii?Q?Px/mirltpz30+VRTSTBNFXxlCgw3ag8xPKKw7d1tI5PWcKIAgPe9CEYfDqv9?=
 =?us-ascii?Q?iNleJPIS/o3uUyf/OoVguvvMzHka7NZXn8oiiuk6Ph7RVSGyq24rMkMblpW4?=
 =?us-ascii?Q?qBibnTBAK+GfDDpKkqbz+XFZ5vsIG0yLRNlTgO/DUlKzSvcptf0kSlTz1mYD?=
 =?us-ascii?Q?KjkuySJcwWJwyKMzdxP+wLPp0vlE9X+JdFSB+tDY6g3yHbZfet2z1y+xqAoX?=
 =?us-ascii?Q?Gfb1JzasSR3psscwQL7EFbxrHquu+mpAzg+YbrekW7Lx9O7nCH2MZE+6Px/L?=
 =?us-ascii?Q?KsTxWLbwTPO9rw27PTWFeJU30TifoApwtz+CvBBsybGBZbN75bvd86k7p1Tq?=
 =?us-ascii?Q?nVqz3/dJyXPloY5aEFiMGY9S5P5/gSr5F4UXjwsH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4bcf4c-4fef-4faf-915f-08dbf01d955f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:23:25.6189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egaz40bK9Id8KCqRFGKEnaOPv6O8wqpEYz2hcQDDRpe+AqVIOWntgE6svHGp+d7Ddde9X10fRVGtXcXetugTuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7045

This patch tests newly added dump command for the userspace PM. Add two
new tests for userspace pm dump address and subflow. Use the helpers
userspace_pm_add_addr() and userspace_pm_add_sf() to add an address and
a suflow, and use mptcp_lib_check_output() helper to check the outputs
of dump commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fa67c833f91f..574aaf5372c0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3510,6 +3510,52 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm dump address
+	if reset_with_events "userspace pm dump address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 1 1
+		speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		local dump="id 10 flags signal 10.0.2.1"
+		[ $ip_mptcp -eq 1 ] && dump="10.0.2.1 id 10 signal "
+		mptcp_lib_check_output "pm_nl_show_endpoints $ns1" \
+				       "$dump" "      dump addrs signal"
+		kill_events_pids
+		wait $tests_pid
+	fi
+
+	# userspace pm dump subflow
+	if reset_with_events "userspace pm dump subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		local dump="id 20 flags subflow 10.0.3.2"
+		[ $ip_mptcp -eq 1 ] && dump="10.0.3.2 id 20 subflow "
+		mptcp_lib_check_output "pm_nl_show_endpoints $ns2" \
+				       "$dump" "      dump addrs subflow"
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

