Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2087.outbound.protection.outlook.com [40.107.105.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DCE812
	for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 07:14:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5v1Wnzs7ivcmkZG/ll2HqpqWBQRC3nVJkcMwfvn+LryqRk7VQpGKfti6kOJexAq/MDSoJ+ivgUgP1WXk8jitonG/wOz9bnTizFlu5faiFM8wI39tPx5IO7oxBeD+NFBh6eIrKRizaURUrd+MC6k13jXN1tfbpqw0QDWGGDKdpIhvUfw+HSeH6qEJtjAGUe4WFhiDsnHWAoz4GJNC1L+f/Qbl2sVjGppiqeAL7UoLItSEQZ9ELQkJICmJsYNZ4yJkJFKam+T61QhU+VAP7XRI+Xv/lD8SfkzpfocDVmEaeaRna8BoyQ8AfQmxk96CH4XJkArbivqk88/2gZIGaKOog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Bn95+gaj/DFjDt/IpQr2LC7oscctNgb18/cBDyBAFY=;
 b=GIUoSRmUwp6FlfccDy1Zmnd5s4JuHKBpBT9pqafY1SN3vu/aqr5X0Oq8n6jH7rDvyNT6+wfxmRKmeS4dRIRtoyodAJx9f/FdhXVlvsl3p0p+DU8CakaBn5mu9kMkIyQllrfb0UqUhgD3g3ZkXqM5zXteKsSxJYSZco+AxP2fpi0/zFyGPNVnOr6K9BSS4QzZyNd2KAfgp5t5eBRM6PoHvzakRAkl/Yj/zwFDdgz51Mu92DDlcclll7sRiZWIL8zsO0YVzXmgBxHNUQy/wHsuTZHAy9SNfCgICLlM3xBrrejrDEqINyD+Jwp1wwKgI2cO30RTvTvoUboFF0NdDR1iEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Bn95+gaj/DFjDt/IpQr2LC7oscctNgb18/cBDyBAFY=;
 b=eQnL5WFeGvuc4xSHkedA6w7tHiMxes4wNFD1Um58nw39EEHhEMGBv9XP7GDoy2PV4W9wvSlgghvFYKgYYExqGHgk50ctL+WRo3tuUgLgF6Zcd0rCvHuKKEVL7QxjjSwVAMAWWx4CsSwPsmlk6atoAJdhrIV5T1xMts1up+82VGIY9jyhCFTg8toivqdCJB87oRPCm34t/5dY/N6vXepgmbKN+Ys2r8V4QTzYbsOVTNrvZu8kalZZEiVdkkJqoGLxeMo+LYE4QQ7LA/hhRNDqKhTZAo8BIvb4Lk+HUfip20yBmu1d6kwfzx1yFsymSW+Ed3uQjw+P5pcFpSNVw+CfvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Fri, 18 Aug
 2023 07:14:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 07:14:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 4/6] selftests: mptcp: userspace pm create id 0 subflow
Date: Fri, 18 Aug 2023 15:12:03 +0800
Message-Id: <64dde8c8b88e8a584533fbd9d3584ba53f4f051f.1692342519.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692342519.git.geliang.tang@suse.com>
References: <cover.1692342519.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cdf3de1-5316-4cd3-31d1-08db9fbab33f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hGsgrwKxd6PgHJ23kSus2lybn5ZXS8SE17OZQH5bfu3tix6ugzzamL1+aPzPc/Redeb7lr8wwRhdDOflYxhKXB7aDK5/bQPN2qCv4yMi2ld71LiSDFB6zEK+pG0ttmIJCHXMhdJV0hTreED+kaJxTvVyR2drayiUhAspsgLz6iZS8i1hwQkB3t5SrvdZPHgKDwvNM+JeFk1V7oU5tkLt8K458kUy0qCB/j/DOLo2PE1BTCvpbEyg4J5mEmXE/9uCCNL51qCGB8Gj8V7bJm/41xXMT+iwI9JfWao3BndVZ7Qx8Tt40SDJA3vy4WglUFGaTYtaC9m2u4gB3VOQUopHYjzrzgqZ+fMLs4wiEAQON/TS0dYB9jWmzhhXeCZlGFGv6xCrCzUjIZhpEZf8A5mjEw2wFWJUtZ6EZDhPMq4wZMCxg0JPenTW8ZwSzrFNZT7/Saxxe240dYccm7WJuZ74n31bvVdFBBx/ayh0PyVvgnkQfrr7Y/ItYn0swMndy5KyZGy/yjubrLevNm/rIuvchdl5Vo0PkqJSsKq+CrlHDGnE/3sx7IuNzuWQfVCrfR9J8au/QtnT60baNGTPSwS1LLL7etsQmjPnOsAjsB3PFlw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39850400004)(346002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(107886003)(6486002)(2616005)(6512007)(36756003)(44832011)(5660300002)(41300700001)(66476007)(66946007)(66556008)(316002)(6916009)(4326008)(8936002)(8676002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mGRDs5Szj669sJpLInW0jCwm94yJ3mQAWeJUC241sjaYmlBBWba0qUPZFD/s?=
 =?us-ascii?Q?ktp1sP133EhvNmrMTZsDycI8XwJKQAcX6EOBTAjljc48n/6/7rYr3P1fwHRW?=
 =?us-ascii?Q?lY8CbjwYX/vKs+FyiFENy1CXlEDo43EXF2LRFdf0Fz0HPl1IneLXrEBvFW02?=
 =?us-ascii?Q?/D8u3odsP2c5ostChpfqox/mdBcMTtr5AWps19GX3unPbn9zTLvX/9M8u6i8?=
 =?us-ascii?Q?oSoK8DGDZpo3Jgqfbyjq7nufa3JKKHWkxYffXd12iyy2byBrGqhML79Pp5Sp?=
 =?us-ascii?Q?yzN+UxSAjj6jyQZIoHrO1VKYtFTc89uVqYD1rugqJxa0lJ+AyeYts5t5dwSP?=
 =?us-ascii?Q?JKrJrmecKfs1mny6WxGDMu+eEQODtxYXFu3x4E8FKyaknnyGSXuVrFMDwaj4?=
 =?us-ascii?Q?/aq9U9OdaoHvrptTChGmWuTHapkiIg+xkbjquEraOTXrXME+K1RqbPXooue6?=
 =?us-ascii?Q?pdPhpbVE48Dqnjbt3XNUptiRevdhB/XiDdlrLMQvVISL6mf+pGemiJBgMkDg?=
 =?us-ascii?Q?nbwBfRVKj5nCyr0UiM/qRcl3Mkd2gXrpV+j4N4nLw9tCIgsGUMKLHMnvs09T?=
 =?us-ascii?Q?OFfu/QYsppo/D2NIXZ+xDDuQ3g4iyP2a6JjFK9gU4xIH3htTydmGwwOAK0ra?=
 =?us-ascii?Q?4rt8n+J4TFGR/UhWGvclbUVhOV4fCKBZVb7avTf9eWrmxNh57U9D1pW93SFP?=
 =?us-ascii?Q?RSpP8DnjmhVjLfJmtQhWI082y4MmeSFaIl7K/nhluHb44Po50lt4JCT1XhCJ?=
 =?us-ascii?Q?hkMCbE4AumF0e5VGAFudz/xe6hUNcZun8WQvvy76q4UwpFAXwMN9+xUQLdzh?=
 =?us-ascii?Q?meoxwMFI2eQuuMu2KHxx5esNX4sm/ktWEo7vwFrLb1kVqZcfB4BcAX6SY7gm?=
 =?us-ascii?Q?bJao3ljlQ8xIkHn2Y4/wOMozFyaHCnxU362zIJARun5qaGvsmOLtgvGS1M9Q?=
 =?us-ascii?Q?NJrZw0ngeCBoPLYS8TqlrvKr83FRlPA+DQePTW9jT/244cmv0WqqeWWoWDl7?=
 =?us-ascii?Q?Li2sB71s1DakIh/ktGCuywnAxNCkA+GLMOpliSgBqCf1qftO1/bvSpeZaVAT?=
 =?us-ascii?Q?RajEdpoch1zQNdMf/FtX6DX7+ZayPQbDTrnl+OFqcQM5dTPWzV4MreJR2DFm?=
 =?us-ascii?Q?/HMN8F4xI0C7GzsmUKrEmyjdce9Y1yHD2HavcGHRDkS8ZDygFfKVsntajB1H?=
 =?us-ascii?Q?5gkadMuVeSqMGAfcPNrr29iU4t4F8Ae5GZIJlfg1jx3fPv6U4Vkq72nq6pCi?=
 =?us-ascii?Q?Dcuv/D3hw4HJpcNYeOzL6tOsyTFA122o9iAIozpQaYiSjlm0pV0jISqzuiKH?=
 =?us-ascii?Q?cqF9vQ8Txc4mobPkhc/oQKWVHZm2qdRYcymD8CrGflZbTiutpUAdWRjcFSA/?=
 =?us-ascii?Q?FmIbNCWe9GBLeroXapg37/hinUdlXhBOATNa1U6/Do/6xNeBGdNhidVw60hZ?=
 =?us-ascii?Q?OvZ9pH4+teSW8WLZlnNE1nRlps9JHggvtfnwDKxaWlg2JmNedBigYCR1WCkv?=
 =?us-ascii?Q?wFis5CZfp400m/Kldm8RqxurzZArE9KviElOwO24hlESNx4wuU+2YRk1e1JJ?=
 =?us-ascii?Q?2QklI646Ex8OR5BW+bhQV/ixA/fvGZNPTHtHAQOL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdf3de1-5316-4cd3-31d1-08db9fbab33f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 07:14:02.3829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkXsF58C2ML+2Svx6oRsYLRawrD72zFeheNUwsUGNHFUpeMY5wBfYQa1AhaEyqiQq7U0KUvfD6AYPn13iuBrXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975

This patch adds a selftest to create id 0 subflow. Using

        ./pm_nl_ctl csf lip 10.0.3.2 lid 0 \
                        rip $da rport $dp token $tk

command to create id 0 subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 52d696f49e58..322adac0cb1b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3475,6 +3475,25 @@ userspace_tests()
 		wait $tests_pid
 	fi
 
+	# userspace pm create id 0 subflow
+	if reset_with_events "userspace pm create id 0 subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows 1 1
+		userspace_pm_add_sf 10.0.3.2 0
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows 2 2
+		kill_events_pids
+		wait $tests_pid
+	fi
+
 	# userspace pm remove id 0 subflow
 	if reset_with_events "userspace pm remove id 0 subflow" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
-- 
2.35.3

