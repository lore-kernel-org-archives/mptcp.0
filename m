Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46EF1CAB6
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="lPUyAA/W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7bWWHLl0wOBO1j+ShiuPc+54WF7SThkG1Qy+TrKo0MQlAmvi7urqaMgUVwydyka5XT8TlbgBu4Cqy7e7Zu7yYIRRf5GwBpP3/WQ4DdcJlsoYomX/PdvZsfBwTD3byfC97ynHsJPS/a/WLqAFUrNtb0oJ9lfOKy6ykICOd+nEG/n0eM4cuOxAHz6GSnUzFV3Xk/LMC3LEs/Q9/yV2X/4FHfHgvcvL3Nc1N5DTe0mwJFm6Z9vOd6niFKM/qJxpKqjqUjzZp5Zrhs2RvHKG/vp1D+tQ//1Eh1IOjFfH4nHlKC0qgJA2HIGB995wTKvqbxSvHYGVsX3rAo/AZajPgGkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REVfFsoMxM5W3bfwncBbfAOpHcuaKeU03wO/aUM2aCo=;
 b=jDqNSdMmHZLCvFLRd6tw+KP6Y+VAThrblOseaerfZD0Cn5Zke60jf83/nPUDbfpZjkDp1U5TeE7hXxt6+whe2GfNwrrsa4aPPTCufKj2xqmOQQQIvbWoJrHQO9ZCpMlKpxVK4H6Zi3RCgJQ3WgjDoBBsV9FY1Q4+zJDZ5hVG+cTEocf+3Omv48KUdCN5GcGYnDoHi8WFDZ3Uo3nU+6zOEFiTSafdq21dYebBAHBeo0nyfd3FXWqPeul7QU/Z9+UFtUcFfpCX2hvbzD7VHyqlRvOJfonlWcogMVgUYxkF7u+68JJsLYqNU/GN/O9Zo4GZOFMYnZzKYKRLWQhXGJwJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REVfFsoMxM5W3bfwncBbfAOpHcuaKeU03wO/aUM2aCo=;
 b=lPUyAA/W6O74pT6RaKJPcpZMUE/RJU+R2niBc8xxN4T2qRYKD/YQyqBGa27ESeQIvZ5CHdKQ3lAM0n3pVfQnjDWRfUJ0IZzmP+ESAKK3zEW3Ub6BiQ8ge2IxQsQbRPw1PKi5QZKXkijE8peBCuem+ei03Zyl2xRUv8Ku2dJJqM3UfavBdelwKIabGCveuyzuQJiKFGjLBUTOMZvryE2s4H7zx7KSKCyd7lrWzyJhwfoe+rJ+qOwBo2Fu3DUW/MHq1zHNqS0Wpr3AxTyZN/uUXbTExKp7Duiu9ncLoBVG/toHLSTV07eJwGDXlt8N95s/SufT/EeWjHqSB64o5Alq9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8858.eurprd04.prod.outlook.com (2603:10a6:20b:409::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 11:34:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:34:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 33/33] selftests: mptcp: netlink: fix positions of newline
Date: Wed, 22 Nov 2023 19:31:21 +0800
Message-Id: <bf8c6d2142b5362dd9d6eab1c32ad573d3558657.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0008.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 11937c92-b7af-4f78-5c90-08dbeb4f0c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tb8vIxlUteNVjkBOuQTCqILiigvz2cd7eEl8YLHa6AwnyFG0ApFPG0Astzf/+ZK6CHuYczhlnh5tlAfo/bLUKxKF6o77+p7YVK5Ioqr460IH9CTkDoi5QyEZKWFN4LFvBT6vKaED5k/GwYBMH2ijRqHgwPOz+W7woW9s+OL/EdVZySwrgYTlYz5+cgyJHdZO+G+Krl4x8esc68PSjMVQYGyxASJjwMLJ0ynAbzdATT87mddqvCZC7xsZI5mMb5oWNMbJL9nA6bqWKPX5z6Bu2h+QBEAhNzUzZDaEigtJQTAB+lwI2fFguQCd1V4bWuQmUM4bCJxSIqeTtKZKiG0XxS4v4hA2tDLR5m3gvTpOHhhtB0gqHoC4HbQi5vQnJOjjXjU9s0bSy6Ors3mxaA5dNGTchBL5qgd8/lk5EKnbb3uaqJeJ6I9LPCN7jwCZdKxUpT/6QChMFpiFig6LBblyTx2iqC+BH9/29tz1M6U97eIAWgpOKF2D395NEvXQBiBufVlhgq9UOTm/hg6vEdU1cc9jCrQrb/mneTsYkCSjwKYQoDpspQawrxuAbfSIunwUlpUyHkYKzc0COUgxBChKAb6s4iT/nWy5pKTPTk6F8xQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(36756003)(8936002)(44832011)(8676002)(478600001)(6486002)(86362001)(4326008)(6512007)(316002)(6916009)(66476007)(66946007)(66556008)(41300700001)(38100700002)(2906002)(83380400001)(26005)(2616005)(107886003)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1U8EKC0t9ZcHvr3/nPiuN3tAr/0+yo/10xHTShMsgeSCvZ5EkSH278kK1GvW?=
 =?us-ascii?Q?/KQWMmeffo5dNRnf4Zb4n3NQdkHbAcztNE4tBcy91TjwXzleOLmUe+wztVfI?=
 =?us-ascii?Q?tkf1PcqvKj2CYF5wopYiw8fAS+fm8G9HVZ4VXL0HbN5yC6ijMm6BUrAE4QWf?=
 =?us-ascii?Q?YBhqfR1f0D9blilRfu9Cpjxwz1EOh7XH4CERgNpzE4btuKFp+ZOrJSmTV867?=
 =?us-ascii?Q?360VrmXx+ScEOsjdbdCl5WWQOq0XM2g3NJeoVIHWQxcFz1r3uJd+vHl+05w1?=
 =?us-ascii?Q?JbS2iukawkUMRzfd5H0yUa3gNlQnv2Z7g2zVVmWl4Xsk4YaBsTyq/2mUI3nx?=
 =?us-ascii?Q?7TH12bpt3woa9J0Tp32RGtBnny1G4t5EHXoeYq36TlPiTww1G73Mzcs3VxLE?=
 =?us-ascii?Q?rQIhKAB6HdXq4djgd6nDzfQr7L5Bxk6YQ4r+sXE6qpMz21bq1egUlVRZP2se?=
 =?us-ascii?Q?FFjRJqIqOr4RYDWtEzIHV9B0xXM49kZX2CNiv6QhPt7hyNPKHQnxc03xZNfe?=
 =?us-ascii?Q?IFWkgTUIpE3YnmVZFBilcp9quK+9JKKpkMJICP32PEVLVTU2J8CFwHIgr3FN?=
 =?us-ascii?Q?C/1WF/PsjYdM9W59cT+JuoHEIpMzZO1onA3KN9setDyrHdFxGO0+ZitwlVEv?=
 =?us-ascii?Q?3b1e9RaRcj9pRZHN7Wpf/tkLV8b0J/3vI0Bm4xbzhEH4fdzp9N0F7v/W0Vsg?=
 =?us-ascii?Q?GrcufaJB09jcMlIHELPmYb/s9w/Qj85WoIfwvcef+fzd1PgtoKceuA6bAV3L?=
 =?us-ascii?Q?rWSQzmND1fdb2HHjWU29lEhae5r6d1PXd0mlrJBhFs1imtGKOw2wv5GgXcRA?=
 =?us-ascii?Q?b2k395ncFGeaco3w4ZfbsxLIgvqYJnbdwljx43nnpqwKoTaGfO5td1nWCNfd?=
 =?us-ascii?Q?IbaGtmaGJK2/JYADwzS2CKAIidvB4ZAHxwMDZywakeAtpGXRcAxJEyc+EJIp?=
 =?us-ascii?Q?i6hGzaWp3/SROPC3rx2Co8ZSxH8pVFeoGsqwdY+zEr2X7FfC/YXxSNd+UKNt?=
 =?us-ascii?Q?fBptzudbgejHp8rODylrXORNj2Oa+1TOgkgpaHNyM9otRlVIIAAVXx8K+1TX?=
 =?us-ascii?Q?+Jd4hgQZijzhmqvVIhST0xELe874bbGHXxhHOJBFrLJZtJHemAmjJKpgZP+k?=
 =?us-ascii?Q?0a3CiWqQFvtcij/2O8kk9WhDDk8C4d6MYDey4KbEnncIbqjM5R5/Zx293dy9?=
 =?us-ascii?Q?+sCkmrshn+/0lzGLIYlVyh+FoHwGNBhdsoTVH/H0EHv3fBRZpeM51LkDXWmw?=
 =?us-ascii?Q?o2XANmo9HIvVwdxnctdwvi+JFMUO/58vPyKsfPvFBxtQWF348141wn+LwRBr?=
 =?us-ascii?Q?CnAk0ftWAVmTW+ZgTL/UElyT1g3SJPSehC4hBAvpC4aqEPOW76sAGhPZ8xoy?=
 =?us-ascii?Q?YamSyie32EJhY8qkS0PQVVwIR0zjxsnqi/GqvfolMksadXLvOD1Rvb92HF7q?=
 =?us-ascii?Q?Jnv5w1oLWW2okvL9LfBv+mLtDCyLOntsITuB4Cw1nKNCLrfy+ZSsCjE5vtex?=
 =?us-ascii?Q?i0RTBess9G1GGx8bsBEWq1IeiCC/yVfvJ30y2B1v++UL8DrgJfaaL/nGRwTD?=
 =?us-ascii?Q?HGsncYOug/dKklKWCLo/AzEbN3+Y9Gw9GDlBstcKF0Zdu4qlt8G6z2t0z7mr?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11937c92-b7af-4f78-5c90-08dbeb4f0c7c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:34:55.0031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHnTW2zaSCA2oFcRE5vhPHgnFBVAEbzIXLYS1RFp/BMkuGg/YhutqUuepskKnhAeXQGLgCkkv6ErkLJnI+hgug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8858

Some positions of the new line are arranged a bit strangely in script
pm_netlink.sh. For example, the output of 'pm_nl_ctl limits':

                                                     "accept 0
subflows 2" "defaults limits"

This one can be refactored using $'...\n...':

        $'accept 0\nsubflows 2' "defaults limits"

For longer output results, such as the output of 'pm_nl_ctl dump':

                                        "id 1 flags  10.0.1.1
id 3 flags signal,backup 10.0.1.3
id 4 flags signal 10.0.1.4
id 5 flags signal 10.0.1.5
id 6 flags signal 10.0.1.6
id 7 flags signal 10.0.1.7
id 8 flags signal 10.0.1.8" "id limit"

This one can be refactored using "$(printf '%s\n' "..." "...")":

        "$(printf '%s\n' "id 1 flags  10.0.1.1" \
        "id 3 flags signal,backup 10.0.1.3" \
        "id 4 flags signal 10.0.1.4" "id 5 flags signal 10.0.1.5" \
        "id 6 flags signal 10.0.1.6" \
        "id 7 flags signal 10.0.1.7" "id 8 flags signal 10.0.1.8")" \
        "id limit"

This patch uses such methods to rearrange the outputs into different lines.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/pm_netlink.sh | 80 +++++++++----------
 1 file changed, 38 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index d68353c18996..06446cec7f55 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -61,8 +61,8 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
 
 default_limits="$(ip netns exec $ns1 ./pm_nl_ctl limits)"
 if mptcp_lib_expect_all_features; then
-	check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 2" "defaults limits"
+	check "ip netns exec $ns1 ./pm_nl_ctl limits" \
+		$'accept 0\nsubflows 2' "defaults limits"
 fi
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
@@ -71,15 +71,15 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 flags signal,backup
 check "ip netns exec $ns1 ./pm_nl_ctl get 1" "id 1 flags  10.0.1.1" "simple add/get addr"
 
 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
-"id 1 flags  10.0.1.1
-id 2 flags subflow dev lo 10.0.1.2
-id 3 flags signal,backup 10.0.1.3" "dump addrs"
+	"$(printf '%s\n' "id 1 flags  10.0.1.1" \
+	"id 2 flags subflow dev lo 10.0.1.2" "id 3 flags signal,backup 10.0.1.3")" \
+	"dump addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl del 2
 check "ip netns exec $ns1 ./pm_nl_ctl get 2" "" "simple del addr"
 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
-"id 1 flags  10.0.1.1
-id 3 flags signal,backup 10.0.1.3" "dump addrs after del"
+	$'id 1 flags  10.0.1.1\nid 3 flags signal,backup 10.0.1.3' \
+	"dump addrs after del"
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 2>/dev/null
 check "ip netns exec $ns1 ./pm_nl_ctl get 4" "" "duplicate addr"
@@ -98,13 +98,11 @@ for i in `seq 10 255`; do
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $i
 	ip netns exec $ns1 ./pm_nl_ctl del $i
 done
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1
-id 3 flags signal,backup 10.0.1.3
-id 4 flags signal 10.0.1.4
-id 5 flags signal 10.0.1.5
-id 6 flags signal 10.0.1.6
-id 7 flags signal 10.0.1.7
-id 8 flags signal 10.0.1.8" "id limit"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	"$(printf '%s\n' "id 1 flags  10.0.1.1" "id 3 flags signal,backup 10.0.1.3" \
+	"id 4 flags signal 10.0.1.4" "id 5 flags signal 10.0.1.5" "id 6 flags signal 10.0.1.6" \
+	"id 7 flags signal 10.0.1.7" "id 8 flags signal 10.0.1.8")" \
+	"id limit"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
@@ -116,8 +114,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 1 9 2>/dev/null
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
-subflows 8" "set limits"
+check "ip netns exec $ns1 ./pm_nl_ctl limits" $'accept 8\nsubflows 8' "set limits"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
@@ -128,14 +125,11 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.5 id 254
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.6
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.7
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.8
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1
-id 2 flags  10.0.1.2
-id 3 flags  10.0.1.7
-id 4 flags  10.0.1.8
-id 100 flags  10.0.1.3
-id 101 flags  10.0.1.4
-id 254 flags  10.0.1.5
-id 255 flags  10.0.1.6" "set ids"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	"$(printf '%s\n' "id 1 flags  10.0.1.1" "id 2 flags  10.0.1.2" "id 3 flags  10.0.1.7" \
+	"id 4 flags  10.0.1.8" "id 100 flags  10.0.1.3" "id 101 flags  10.0.1.4" \
+	"id 254 flags  10.0.1.5" "id 255 flags  10.0.1.6")" \
+	"set ids"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.1
@@ -146,36 +140,38 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.5 id 253
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.6
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.7
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.8
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.0.1
-id 2 flags  10.0.0.4
-id 3 flags  10.0.0.6
-id 4 flags  10.0.0.7
-id 5 flags  10.0.0.8
-id 253 flags  10.0.0.5
-id 254 flags  10.0.0.2
-id 255 flags  10.0.0.3" "wrap-around ids"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	"$(printf '%s\n' "id 1 flags  10.0.0.1" "id 2 flags  10.0.0.4" "id 3 flags  10.0.0.6" \
+	"id 4 flags  10.0.0.7" "id 5 flags  10.0.0.8" "id 253 flags  10.0.0.5" \
+	"id 254 flags  10.0.0.2" "id 255 flags  10.0.0.3")" \
+	"wrap-around ids"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
 ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags backup
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow,backup 10.0.1.1" "set flags (backup)"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	"id 1 flags subflow,backup 10.0.1.1" \
+	"set flags (backup)"
 ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow 10.0.1.1" "          (nobackup)"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	"id 1 flags subflow 10.0.1.1" \
+	"          (nobackup)"
 
 # fullmesh support has been added later
 ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh
 if ip netns exec $ns1 ./pm_nl_ctl dump | grep -q "fullmesh" ||
    mptcp_lib_expect_all_features; then
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow,fullmesh 10.0.1.1" "          (fullmesh)"
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+		"id 1 flags subflow,fullmesh 10.0.1.1" \
+		"          (fullmesh)"
 	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow 10.0.1.1" "          (nofullmesh)"
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+		"id 1 flags subflow 10.0.1.1" \
+		"          (nofullmesh)"
 	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+		"id 1 flags subflow,backup,fullmesh 10.0.1.1" \
+		"          (backup,fullmesh)"
 fi
 
 mptcp_lib_result_print_all_tap
-- 
2.35.3

