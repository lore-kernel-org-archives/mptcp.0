Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2043.outbound.protection.outlook.com [40.107.14.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D207E443F
	for <mptcp@lists.linux.dev>; Wed,  9 Aug 2023 07:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n32x6bFio6y7GUohMJG/HnqJCfcAR+OHvmcyThrDasu67JLUhBWTW2HRekcOSXUdWuBkkqCxV7Bvk9qwazeDhxuE3n3BxUpgJ/Moy+3P+FO4UPj4AefSNvDHh5w0uQKwNTzYBY0+bpaxI/QPLy6eYPay0WU4/0cc34WkGY0AqBNPrZRGF8jdjQMYF56PGiEqwOk65So5eNd2uLWJVsiqVayy7/ShGezcI466ceD8we6x8pTw7njGn9OBW+yYvNjdH7qNPy/UZJx0r+S5N1agBwjTuCE+ajL9xhXxKwEswaAybzGbt/qsQ3cutiKyhcplv1oTIKdHHzO+Rt6NBy75gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RN7zgSwTL+e7Nt7J0zo0y3Wvy55qGv71xebsI7tbxkI=;
 b=PvW9jpPeRtWfp1UewwdLfCJxx/Nprw/ZbJM8MC1WbWiJzTM/rMNboMPb8TRGwhm4zYLtWZrogLhR+hWTv7tPgUVXpD5OwGhKvPMhd9MJlkkZmJa4GV1HFkV/D5a+I08p9TdK9jFI3bVfJjl75zvxNS8hQNjpooVwZ32k3PpI/i1DV/192mVvXX4mBtyu2RO4YmktqULCs2TPa8Lz75HxfLQrXwO8/4fHcufHxgf3kDYKQIZqxLxwoL5YiznhaVyA3MPCCdZMorEjw35GPUnt/v490RgKYqVadVyLPLM4X9mLyWpW9g9BPAC4lvsWtRCvsxPK7b2bsiSjCOpoaM/ZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RN7zgSwTL+e7Nt7J0zo0y3Wvy55qGv71xebsI7tbxkI=;
 b=QzYbQb81RfNHpR+b2tTSwQ2DigxalitDJsVmIhd4l5i6RR4E2ipOPTSXSxYBQttNg/JtqPbCXJJ8GjquYvCB5YMhV4ktzKvTQG1OtcrXxZwtZ6ANAN/DbUY+VXP7RuI/PtEUHj3Xvj6zb1/wDupWLBWKsbqQcPP4wcgRWlT7Ge5hJuchSbOwaHo3A/Ly6j2/Pd+LkklFzZFlpnOxyfoiolq7khY4ow2vfR7Q41qYqk9vAXGbpVNvm9A7cayaZ7JXX5x4agFWBwIgfRj0d46YXmEDeNoPjERuzUWou1IoiY0Xm8nZ5jCHo5c/WuRrad4XK2XJ9wtX3i4G/I/AV+RS5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7984.eurprd04.prod.outlook.com (2603:10a6:102:ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 07:07:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 07:07:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 4/4] selftests: mptcp: remove id 0 subflow & address
Date: Wed,  9 Aug 2023 15:06:39 +0800
Message-Id: <e03195dc58397af6258c193c6a5a8fe457d20c33.1691564649.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691564649.git.geliang.tang@suse.com>
References: <cover.1691564649.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbbf88b-76b6-48ee-72fa-08db98a7422b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OzJOa1QcKmf27hgdEHWfwptsnCUXmCwiboqwPxL+MbyUoiLj2aTxFI9C5hgXw4HBomlOJQZAhIB7BVqGNuJUt3WpEhB1pw0j/bT/oy4a8Gw0yLzxscLSYMyDq9dzkpJmq3X45nxmjvjhmmdJMgm8CZ5rR32SrP6uhwLSvJHtmXztQNhGc8oQ1rOnmhc5Lwp/ls9NewNMaAhcWmbPYMK/dQmr485LJVCXkckZw8rfSFuEci6RL0aQxxlxYMjRop18BCYX5H5sXeUpKzliqvg4SmsRR+3KDm5jyxbeQP/RqiLcfctmnV1Lo0FIuUeXweoV/+mjx+YJAKS3LyhSDXEbvvicSEmlqAjf3Ck4MTO/B7y7wPjBzM0797LW2DmJJvpzgciPyLphepSiwaTIMiSJcfAuQkjQnKORXt+Qnr2nVx9yzvpuSfGfRctjdG7QVVIla/mMmnAZqaKYKur4/i7HxPQ5ImlH/bWtrXc4BxysSotzz05hSCJFkCrosoKGg1vIh7Oy8R8lC4Pac+o3nlDlVU92Yzzi4Hjnyv725mDpiClUegLMbALEjjFO81VzYIibOKcN7MjMQXMesvozLVhRJvLo67M816nQRzBCey4QfCw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(39860400002)(136003)(376002)(1800799006)(451199021)(186006)(6506007)(86362001)(44832011)(2906002)(5660300002)(4326008)(66946007)(316002)(66556008)(66476007)(6916009)(478600001)(8936002)(6486002)(6666004)(8676002)(41300700001)(83380400001)(2616005)(6512007)(38100700002)(26005)(107886003)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZkCPfXqo9w6L8zyBNn1IeY8BWQ4poPLadiW25gsp12jA/Yc6qvFhemQ2jsKy?=
 =?us-ascii?Q?R3susl9zlDAwN9VNPcBWn4VSRKYuxPkhkV2bUnS2ogouyjLRZdu01xSNZgKA?=
 =?us-ascii?Q?rgp0kNaft0IWGprT1US8UtzVoJTqeCv6lnYbUM2XBAhYqoVeiEqt+xAATQ94?=
 =?us-ascii?Q?tjEzqX+59bMOFTKgbg+bmEu908b0CZq5YMcvKaQXSEzWW/G+vVOLqfPK7OWu?=
 =?us-ascii?Q?GiWcenG+OlLI9jeA56MExnP6Uw3Q0MFAYBSIs4z1ekOnKZpyBd5DjejXZwUS?=
 =?us-ascii?Q?D9NXjuMr0JDuFIwVzd2cCwPikoj2td9tSJDerZfU/cPmJgkyx3EMdTeGltLj?=
 =?us-ascii?Q?/Qv7Fg8d5ESL4Kx8/6pJl3gmcEsan8QgA/wHncj1cwITQ0zOpmZUjWZpfc15?=
 =?us-ascii?Q?yWOGvHJCfNMl4JAlzssWSanTsqPpEY6PF2Mp4k9/PuilLFp4hMCT1DgMFXc6?=
 =?us-ascii?Q?Hz4OYIRoBzw9iFgw/KvYMECNeKO+wYtrKBSPbMp2lJXB4aCwyrRMOaLURVu2?=
 =?us-ascii?Q?dS8UhgEi/S751JJsgNWNWiVczlYD1GeMoq2IEbwQ6OJFogHMGKV/owsO5Pms?=
 =?us-ascii?Q?oui2Xo0oxwcYHH2Mf9qCDuLCwnCtNxBwacU9jBhV4vpK7ZqcB/eWcN30KDdw?=
 =?us-ascii?Q?ui9P38Uqz9CeAcWWZL3PFl5gTUSVz7ecJ6ZobKbb9AbKSqTqMZWvxT2HnXaK?=
 =?us-ascii?Q?87oqxX/ztASemvuPpL+GAN1EBJpNK7euqPGopnCrDHsjkdBAKzyQix4uUAGK?=
 =?us-ascii?Q?nluHuaVCluMDJ2QQp89+cuYSzg+kdobdAlYwB0SnqWeowfBw+mog+SqZdWTx?=
 =?us-ascii?Q?AUenM0M6soxoo6Zb9ZBpZfJw1/mUj6Zwz0xAw92lcxVf5L7gCUUNFMBFxX8j?=
 =?us-ascii?Q?vIXI0Q6fbP/cVXYQ0GF+xbDJ/76HDgG3sdjhjHT8+AXv4QW3EbAtvCxXgAZX?=
 =?us-ascii?Q?bmMfEFUGjODzKn359Iv7UifzrRJy98kxp/iUHzqeAjt2CCm164nDQHq+VVsS?=
 =?us-ascii?Q?ulDERTtgUm2681pgBe/praDCC8yb+OysY3OAM296+oKE+gNtzX1IElcDYha0?=
 =?us-ascii?Q?gEkKKsnRySkG5bID+uC+nMGFPw5eoFqNt80zecdTb788e09MAMiwZgvGIgWV?=
 =?us-ascii?Q?CT30ayJM4mLsHPXaaHzZ9RZgyz3R3a/tzMkYwZarXaAF6NTBiaHK+JrnjWXm?=
 =?us-ascii?Q?oiGT7v0OeasFFkbDHbxe6cnX3642f6+7JMxKZoqsNNstNMlQWpH0CbxBoWI6?=
 =?us-ascii?Q?bzgmrI9Q3XhLt/KSp0Vzmz63I50dbqtKkgcovgpvQqTeMPETfNmJC8GIAA9o?=
 =?us-ascii?Q?SAy9zQk7iow0GiU3+QjvGR3T+opbZrIC2bgxy4ZhBoj8jjgmA0OJvETZpxSH?=
 =?us-ascii?Q?xJqa1Livu+eL5TqXn4T3UksndHYS6T5/eTYH+Bmfp9eCSVeeRjoeaXTNtNe2?=
 =?us-ascii?Q?Sxt0VKUc9c7soCtFG+aOEtIeypZxM8s6fTdO0Scy+YtlKq8xUYbsPOtn2Sfb?=
 =?us-ascii?Q?Ep7nkhdvgJ6RTxb9irvg1VN+r48IMwtXRpy7MihkkRolT/A9gEwvmwNewviV?=
 =?us-ascii?Q?A+KUAR8MdUnfvLhU4MeaxI717v5reNnWHLJkYLH9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbbf88b-76b6-48ee-72fa-08db98a7422b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 07:07:14.3613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YluGNp+I5/D5hG+zvRB6zSlHZuSy1EAZ2z/pP8qSRkAYGdGyjGuWeAJNOzA3HbXef3hdnkJwPEZhQsThW6l6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7984

This patch adds selftests for userpsace PM to remove id 0 subflow and
id 0 address.

A new helper userspace_pm_rm_id_0_subflow_or_address_ns2() is added,
in it use

        ./pm_nl_ctl dsf token $tk id 0

to remove id 0 subflow, and use

        ./pm_nl_ctl rem token $tk id 0

to remove id 0 address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ee1f89a872b3..52f081738c36 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3320,6 +3320,15 @@ userspace_pm_rm_sf_addr_ns2()
 	wait_rm_sf $ns2 1
 }
 
+userspace_pm_rm_id_0_subflow_or_address_ns2()
+{
+	local tk
+
+	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	ip netns exec $ns2 ./pm_nl_ctl "$1" token $tk id 0
+	sleep 0.5
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3434,6 +3443,46 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove id 0 subflow
+	if reset_with_events "userspace pm remove id 0 subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 2
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf 10.0.1.2 0
+		userspace_pm_add_sf 10.0.3.2 20
+		chk_join_nr 2 2 2
+		chk_mptcp_info subflows 2 subflows 2
+		userspace_pm_rm_id_0_subflow_or_address_ns2 dsf
+		chk_mptcp_info subflows 1 subflows 1
+		chk_rm_nr 0 2
+		kill_events_pids
+		wait $tests_pid
+	fi
+
+	# userspace pm remove id 0 address
+	if reset_with_events "userspace pm remove id 0 address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 2
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf 10.0.1.2 0
+		userspace_pm_add_sf 10.0.3.2 20
+		chk_join_nr 2 2 2
+		chk_mptcp_info subflows 2 subflows 2
+		userspace_pm_rm_id_0_subflow_or_address_ns2 rem
+		chk_mptcp_info subflows 1 subflows 1
+		chk_rm_nr 2 0
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

