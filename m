Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9D67B
	for <mptcp@lists.linux.dev>; Wed,  8 Mar 2023 08:05:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCGXpSyBxxAW5I8gUmreGb9XLMBP6ifUVryemB+2zueSYNs8ZXumDby7ZD0ElXIFjP/jKSZ82R0NoJFlwm4FjOvo4Aa1fm3ZNmkCnd538OD6p+C6cOzaQf5vYplPNxz5VaSDBtai/9FwnVYQX2Cbiioufi9UiHVxoXQBMUnqsOqMi0vH5H071G4BcEQsQ7toTnYh4NJohA+8ZeS/szPY6OK4o+pa+x2+v5azWB0V7/g4j5erRpqPk9Oe+5pr0xsUSXpvOEu0aiyMrEO97g5I1D1MT4x58vkmajdQUVANvd7d5zmFMeyPabXnhzLzBTxGqUf6IlFbU21TCYa1QxZHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhA8ZlvGgtA9Su6jk8fzqsOSBnKEtsxQ0Kf41K//hJw=;
 b=TWWCOyg8FTskVxYflLM0qA8lPECLk9D/C6+U1gni0sRa6+ethyltBX6du/0KiKe8bj3tZR30RVTLmAYAp4Iv8MLHe1xObyZXuCP6h4uE2vtAz4oGQVzOU78ROWRXtpZyKsUK4e6TDrAgwHLf0RrETkMwesWgaglTYM4qJjCXkAyPG189wgWLf2sWIqy3HwK9NVAv4qmgrQTZ6YWbAYj6uSLJkd1zbBl0th6RHyMoTGIXhTxk7cDscWt5TJqKwjx55bDqTsh7yKb7u4hN/ikLV7nUxQkhqkKTChYqwIrbBi67miebrPGOr7z5G/9WcvO/MDePelkh3u/Y9JKUNGKPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhA8ZlvGgtA9Su6jk8fzqsOSBnKEtsxQ0Kf41K//hJw=;
 b=Kb9EiXT8g7sB9JV04pBLmiGZ/cPb3FdfVGHLTghNUYu4JdjTKcfUvIGZ/M0lTxOkdeMOjAtCO7tuq2v+TJE+xZFzNMELk2LKARWMOvbWiTYKNGkFGp0qpTAF0m+t+qLwsbsldG6bmd1XaboTZ+wyH5ayLqH1e8alc4JPpRaZgct0FZsKwxvaGW0DqGTV8ZVZDQMDOhTZBHfxm/JGaULwU1CSQLiRg5DlZTOKxJsU1vn1smcxF2pLioqQxK5Wc1KD/GNQgV0ALyMkZZS1WtcTL6ofsw8COfssJajR2BXk++3HJyQT7n2a8jTdkJALZXr0jClZLEtriiKTEVx0u4d2HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8566.eurprd04.prod.outlook.com (2603:10a6:10:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 08:05:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.016; Wed, 8 Mar 2023
 08:05:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] selftests: mptcp: add mptcp_info tests
Date: Wed,  8 Mar 2023 16:06:17 +0800
Message-Id: <ee1415d43a29f55bef6ac7b6cdb2625b655f4b25.1678262695.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0214.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: ce95ec55-fb90-4b74-5698-08db1fabd2e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k8sFhROnwKS4tpXmhRXJfvajoQDVTeYGc6AqhHMpLQXlx3j3rHouQgxmAYcc6EThlCZBrGX0xgLkIZ0y5R788fkWfTubWZIzg/kV98xkk+ycohel3RKAK6tDTnAPQY5DAgz508AYH9bvfQOQiuek6I4tjT7+39pQW2huFnR4FCk2U74e099iBg8yIOLi5Qc02VMw/4gUpn/LnRlDfVoFav28TpgtGnU5Pi76Onp/1k11KuJe1B6enFQFwwq+LJFafiX4RN3QhC6Ze0UspwaanzDHZ9E/uB82JkdjaCOWzS7wZIZjyiLp9JtYFT4arSw4menvlrZ0y8V9uQUIcdFBa5X/lYz45QgbLTpNY5PzjGuw0BG2DfzHGgJNlhDmzaU3MOw0TC9A0xy35PP7uznO6CrhDOLnDzybBfS3qPNLjxghwV3uP++cFbuMxTf0sYPh1/+1Edh/URmMJnjRCpRdQzxdzO9AZKrGET3k7z2XYgUGTRgE2Nxwp3jK6RXGjpd0gKLHUQYvOUK498l4yQr9jDgoS8b3O+n8SG3Bq7ffJai8azULMjvdUfu5ycYmWY5BAujWfOHl3EqQ9pTPxgM994gehlVzS52A5lIc3RbbuemXVEti2pvA+RZwvcUVvfHChXOda5WvEYqtX3+yRXs9sFFFah3pVbFG51+SdMYoeoOj5N/7F2Tq4OtxePm7CrCg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199018)(86362001)(38100700002)(66946007)(36756003)(6506007)(8676002)(6916009)(4326008)(5660300002)(6666004)(2906002)(41300700001)(8936002)(44832011)(66476007)(66556008)(83380400001)(186003)(2616005)(6512007)(316002)(6486002)(966005)(26005)(107886003)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8q2TAlefLt5mbrB7s+NRax1Gaf+XCok1M5dw0kSJ94+jHpmms+sN7N7VPeou?=
 =?us-ascii?Q?mhqJLLJ5CP5KGfmG/miLMQJ2UJ8jXBTf5vkqliTNQOUSyxc4V0jsu3y2+vvn?=
 =?us-ascii?Q?DDkjwMyqAM5isU4TfpuHySj96gPTXZOrmcxaDuPQitMEtKTeYmEzh1uiYE7r?=
 =?us-ascii?Q?o+cDDkORfLxHtPYR6IaEh2yzG+93By52qOxbAUGJ6g0eP/0uDilDv2CS/066?=
 =?us-ascii?Q?5ksRQsI9fbckPPVFrEaCT3ZtRGAxhrXqSH/n6TPcQgKGW56RZX8LqQgTKY0j?=
 =?us-ascii?Q?rHE1438u6dIF7z1Tv+8trmaFBdwMGYQ/o56RYA9eQJ/Y0AH8jWUEFc4uHwxf?=
 =?us-ascii?Q?ODfT6UyUdTiQ7d24NkRtE+JSZeGs20xBWqOLazfIMEUjcNoV32CZOoUrLBc2?=
 =?us-ascii?Q?PuGSSyxYesK8wW+RwEXUug7afGpuwzsfsFbhAJOoZlNb0k20PE417RpbeEDm?=
 =?us-ascii?Q?xEmpRxbtq5jbLBbtZJAqmm/XcBajgBClqm2dhwFp35cIJOdJ7oLTMFQwFSd5?=
 =?us-ascii?Q?iZ7vRGEhkj7QQUVZcgFZUN/GeQ/NFZCy3xo5iS2YfS2Oq8TJL8iPkTpMTvs4?=
 =?us-ascii?Q?KYSZZGX51gqEhMv1dgUzhBAe91j6v8N1nN7i+VDLDO0YpiChzb2fFw65u/Ry?=
 =?us-ascii?Q?zYiJX8RC5NUr2845Owkx/eGoxZPF7Ep6eQLKr0Z+4bJc3RqGzn0cDGDFlH2d?=
 =?us-ascii?Q?ZskrmNrWWbBMekOqETagbTh9wnoKszZw8UjuXwurv0VRE3hD8sr+K4pF7eZS?=
 =?us-ascii?Q?DHr3sZx8owN66gwepU92XzxaVcjr1xyDwANsszzUoxSTcjVLgqa6Oku8DD2t?=
 =?us-ascii?Q?wmDeSqwSh3/0HSR2nbwoPpcK5MMHlYq++LBuu5NFkcOAh/9Dl+Rf9jPO+3Qx?=
 =?us-ascii?Q?kX+ThXOusWJyK2IlIYjdaP7iggR8c0ZXj7O5vjB7EF+TOLD/SmEr+XhgWdYf?=
 =?us-ascii?Q?8UDvm3i5+We1tYR95ydighQ18IFigQIWpIm20M524U9nbgRN5hY3wk3Z8+C7?=
 =?us-ascii?Q?eiaCAdA4flUKphb7PLq2EMO99kr0JYXVTi8Qc9/l2kQZ9OHbbfNNVvxDV3nw?=
 =?us-ascii?Q?HX3fRNWUfmrOzetdoKWxVQaBjX4JqTgnj+RYoSYHrcVWaw327sjfP8OSEUJ2?=
 =?us-ascii?Q?oZrEQJZfyVDP0r+5Qhejn+wj8Hawm6W0DjvV53syi+Y2tah5IqE3iYOq0fpy?=
 =?us-ascii?Q?cd4VQKT2C2VgKlgYfHvb/PVnHvpfpNqw0RTYy5u8dcU5TEOfnseXfICjIpSp?=
 =?us-ascii?Q?UxHhAVTSq3oaxfgbxdsk8nd1c/Tcb/BIavWo2BSCP6NEZ0z+pstrQI2orcWZ?=
 =?us-ascii?Q?U09kVOTX63q+cG5syNWq+6zheSA64byUdO3RvgOhEyMJJdZSx2pqnJGq0QHa?=
 =?us-ascii?Q?XONV+dP7Ob792Hb5lzJTJnE27xqk+yBY8HBFZKiNMvmjf4n+fSlrUxJ+8G9W?=
 =?us-ascii?Q?hLqVeDeHVX0B2CojMsLNBW72ZuuxN2gByXfuPyLT3gvmWk5EHzrKQPNZOvPL?=
 =?us-ascii?Q?vYC6kg7dz34tr+Od4rTDBGaRArCq8kGskXSmVTuFnyxJYogq48zQQIcizLYg?=
 =?us-ascii?Q?/Lc5dZJ7eRBfm3htI3FVwR7fzgs1bZ0CZTp1YeGoz6wrxpmbItlk0TblquYB?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce95ec55-fb90-4b74-5698-08db1fabd2e9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 08:05:04.5807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ct14kpCJ7dqQPvcwJ6Yi3UoMx0kzdkk6G0b6ZOKkjBzF57ND+R706qdM3vIf7ywNcRnotwnmNiqB12UxnjWW+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8566

This patch adds the mptcp_info fields test cases, using '-D' option
to trigger it. Add a new function chk_mptcp_info() to check the
given number of the given mptcp_info field.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/330
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v2:
 - use '-D' option instead of '-i'.
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 42e3bd1a05f5..46742453f883 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1719,6 +1719,40 @@ chk_subflow_nr()
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
+	if [[ "${nr_info}" = "subflows_"* ]]; then
+		info="subflows"
+		nr_info=${nr_info:9}
+	fi
+
+	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
+
+	cnt1=$(ss -N $ns1 -inmHM | grep "$info:" |
+		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt2=$(ss -N $ns2 -inmHM | grep "$info:" |
+		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	if [ "$cnt1" != "$nr_info" -o "$cnt2" != "$nr_info" ]; then
+		echo "[fail] got $cnt1:$cnt2 $info expected $nr_info"
+		fail_test
+		dump_stats=1
+	else
+		echo "[ ok ]"
+	fi
+
+	if [ "${dump_stats}" = 1 ]; then
+		ss -N $ns1 -inmHM
+		ss -N $ns2 -inmHM
+		dump_stats
+	fi
+}
+
 chk_link_usage()
 {
 	local ns=$1
@@ -3129,6 +3163,21 @@ endpoint_tests()
 	fi
 }
 
+mptcp_info_tests()
+{
+	# mptcp_info subflows
+	if reset "mptcp_info subflows"; then
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_set_limits $ns2 0 1
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_20 2>/dev/null &
+		wait_mpj $ns2
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows_1
+		kill_tests_wait
+	fi
+}
+
 # [$1: error message]
 usage()
 {
@@ -3177,6 +3226,7 @@ all_tests_sorted=(
 	F@fail_tests
 	u@userspace_tests
 	I@endpoint_tests
+	D@mptcp_info_tests
 )
 
 all_tests_args=""
-- 
2.35.3

