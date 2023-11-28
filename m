Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A935888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="siYjINv0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mG6KAiGcKn2wAZZ4RnF+UCW847kOBbWiaq61bVRu06DnO3xV8t5N4heAetLBIIPy7n+FLuvVea8xRJ5TIBzZO4BLrkcQw/SjB5RHWNnc08Rk3d8zXnV99lG/fWXC5UrHWd+VMsI8FmrnRXSNxtsIcIeaQQp2nqiFyLnjN384kEShOl8rejNkxsGfVn7YMWbyVj2P5w40U+5WAk11i5ErLJ++Uxovm+eamHoQwFJrvWnvlDu3+d4hCg7+XVUbPcZBC9eQTr9+TxFQMxATz38NUH2v6/gXGrRk9KyLu2nWcPR7yUkcVwGR1E+/PQZOjh9ZUSOj9uOX2eGxwtekOeJ55g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdfeH1bjK+oDhRLa9WbRGWcewYqeZENfXrVzENgNtL8=;
 b=LMwf9qmBSXYXd5gEhME8Fnl8USnybsLs7oidT8pTBpLfLT9NyX0OzuhpZG3/LcyE6+BNe9nPVpW+6/U/ojO5g0Km+NhbryvP/EZLXtCxHVPSTiYED1I+5cC8Q4+S18hokh1sGLBTJOW4lX1fIios7EuQgCvEEWUkNla9SnYpE4SeM1RvStQ7U89k2uvsbo0EKBgmIYHSrd8PP7pmHrkZeAxzgpiZLcAZDmKgBHQtnAntLwlBJOr0n6BRVwzyVYMI2SDSfgtft/6ky39gONN6kheLmaNBDN7qlxhD+0bBSm6j9AwAbuwB1njAyrp14FbzTuDJ83uMoZ0xfft7REX6Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdfeH1bjK+oDhRLa9WbRGWcewYqeZENfXrVzENgNtL8=;
 b=siYjINv0pE81d1YLnAAEjpK7tVDcCzIMxcRkKGmpDh3n1R0UwIPAbJxIFugHHNVDAnsbbGSMJ4/gmfKwoCDy4Ebf8xc9I4aNepWVBBXFs56ba7SCRupqpljxnRjrn2SyiqnP4yt15msSBTimPU9Ntw5fNfN4cc+d+3XZPdg8LhX/eJ3krHToiMS2yQ9AIkBexy8KmAp18hAjwrORDRLgdAP69OvwUd6Ss8oLiDOoXWdzUZ7NgpFPvFYgWfxcSuCFtorKtP/KnWayewhkvCW6Tb4CTtqeK/SiPRQZJ6YgTwpsqQWSVSo3SA2Qlw655ybxxFhP1uSenl+akfRNN356Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7001.eurprd04.prod.outlook.com (2603:10a6:10:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:22:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:22:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 09/32] selftests: mptcp: add mptcp_lib_cleanup helper
Date: Tue, 28 Nov 2023 22:22:02 +0800
Message-Id: <04727d3b882eebe828a949c647ea70dabbced9f7.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0188.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a17d89-8484-4766-3d2c-08dbf01d8281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mduMv6mdY+dynmlk4S14MJPN6s7Dgj67G4Pa0n6JFqrCfvzQOHfohBEIkwLUaFvMtcHiJn6R+iTWAdjnZF4WmZjpubEFnfhXDKez9aAbo9UNWfVO83zt1s78TnfiriaJeaPpFyY8Wwf+ZLloZqO4gFPhbw0DYmPIQRmsuC9YtS0GcjxHl3F++ccZNJr//PI1zug2o+pY4XxkK660adS/VPFvUX/mVt8XA4yb85PD9k4WH8gtMQY1WKSkwK/Oy0yYQ0Wv4mMpS7rdVDf0d7sZ25yF7TqiOM4emfkosoIiZXxW1YWDiQqaprI2zX3jeOijSghMDq8ujwYL/RycwIvg2ovHIKMHjytzGuixPXeKdET/ZsP1GsEWAXtCtzwxmEQMJOQ9RoMmmSL/r6IuQyyJDHwYdJc2WSzzAHzvGfhCuetnhI6t34g6dpDQSx50XHSipYpcEcHI6AeztgX3hyYJAQxfoQtaorJRofmE2406n9It+1pRuRKRCSWR4v96eiKW76oNsnhrWv6aXlpnCgwp9Dpjm1M6rUjC83Q64zFyCAHm8YBPlAi2jpDzo8PYSdgM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(36756003)(5660300002)(86362001)(26005)(6666004)(6512007)(107886003)(2616005)(6506007)(38100700002)(478600001)(6486002)(44832011)(66946007)(66476007)(4326008)(8676002)(8936002)(6916009)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vrDZAqcn+nJ9HcaZQMoRD6ZZX2ve28AYi7vuiR1HkfrLrJKB3FD1V0rwUaZz?=
 =?us-ascii?Q?n1fe/xLxHi0oTeW61kUjrhpAmDHWIQruo19R/wbe+EMx+4OLkrFpXsCKmgHo?=
 =?us-ascii?Q?xLXpKYqNRV2IHqZwvVVzI1sIR1Qk9FPWbHOrQsgxNVLwxZErp1001HATvaEB?=
 =?us-ascii?Q?zJrMsL5+3gH/PHcaBaEICecSPZCrQ4QBtj7lRM/pVpluMn2c8Q9DNlULIfGg?=
 =?us-ascii?Q?kO0CUKUYbdf9i0vMlorAgwuiK9PrGeYN7V1Gioj8gXDEvUMttFjWCxm4870f?=
 =?us-ascii?Q?iyn2aV7ckaD8ZWMgdjUbUVKhVcm5YmQqEMquz4Phl5sQ6oIbSWoD/9lmgVEX?=
 =?us-ascii?Q?uUYDCVVPldOjS8ZX3msupdxUgD9zjc5H5RyqDnq8fsnQDa0uJYIe9wVpgD6F?=
 =?us-ascii?Q?tv17YAT/6brLIneIzwjehWeyW53PqS/R1uyUTY+0VTnbe7CstkdsuxHmAR97?=
 =?us-ascii?Q?T4PAIxmUtFxB59q8dQ0uSlqrAohf/bFeSH+ehHMbvIfAPGyBTTvPOooRBKE2?=
 =?us-ascii?Q?fdyDxt+QDNYeYP+tXCzYa/saY+CICu7IL/hw7YmYwJ0YdHsNh396MZLeLlKW?=
 =?us-ascii?Q?IOaHq9A3/0jDat30gncnwzvF1cHKK7wqdT8KJ3wzeLkNMcOT0d78ZZ6Eu1at?=
 =?us-ascii?Q?gCPoOnAU1hoXUVPTQrjARAgW4s1Yp0unecISxl22vIFq0ge/iqCPnYAndtf2?=
 =?us-ascii?Q?nKGdu1Et5guOJSD+PoI3hItDBGp9H3HsUxyRIXIsbcSm79715HxWGpKw9LKO?=
 =?us-ascii?Q?hVgAiAVb1GDqRvI6mFNPeEX0bZSyY9AvBJZgIIBi26sLXPpjtSnZXOmsMjVH?=
 =?us-ascii?Q?9KTEvqLgKKnU+SENevtZHMo0s8T6Qnv796xwZ6RaWypaaAd3qt7rmqkTlGLY?=
 =?us-ascii?Q?9foazWQFOfwWWquXZS4gjSXyBVLFWCMrqA+uh566puxQ2uFENdXGxaNgWsI6?=
 =?us-ascii?Q?A5FMp7pGrLbpzZGvqR0OrNhBoDJkTq864q1SEGFiBFDGeQM2juvjCUUVGb4S?=
 =?us-ascii?Q?7uYsSbDAs02PoOwcxKWtPWY4XQzDHZl4Usi7fnGD1ZuFhQ47s47g0tQ8+VeF?=
 =?us-ascii?Q?xvehhbYfwUFo1kIynVoULQwoprmmVtHwr6cAdFdCQ1ud5iKcaKeWY8Gtnc7A?=
 =?us-ascii?Q?96MfxY8MAX8ZNHwV9JtJjsyGppyQRWQ81m7hPdNfCWEEw8ctMnnTmjQxYzSQ?=
 =?us-ascii?Q?RNL7PqfDV6h3hnmY1NWBHgFwFxyPMll9trd0KMfWDuZtfnHVKmG14xdufc9S?=
 =?us-ascii?Q?sFYJIUroj1csnFmK+pt5VBXAwrlznzgQfFVULuxm23ElC5cZMVOzKvOw3xVA?=
 =?us-ascii?Q?2LI3mnE0iyv696SUpp8Qkxk6NXbtRB3Ow90AJKV70YcF1fafW0rMh21nHvmB?=
 =?us-ascii?Q?BnlGOhHzaCkWPR64gfO7W/q8u34mNkbE+Y14FhwSgonQvhqm4N3u7iENSqmq?=
 =?us-ascii?Q?WTZeDG4+3D3BrFXmW0Fs8ie/+DksiEYHOmARXTx0rPH4UcZt/dHDcKhHfbex?=
 =?us-ascii?Q?WGsl+BQNUYSZv+yGYZxUVAivi3zZcud35PQKBpqNN3Qi/J5PkhzdoCS566JZ?=
 =?us-ascii?Q?UO5HGc6Kw0vt1Yrj0g3jl1wOJKNuSeo4ppKDFsOU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a17d89-8484-4766-3d2c-08dbf01d8281
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:22:54.1483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BCQefdmkErRyk/u3I0FdWedtvp32OVBBdMCsHeFaUMqo88dX72It3u/oE/kBFvuU/Ei5LwisIAKx5uLNMqtnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7001

This patch adds a new helper mptcp_lib_cleanup() in mptcp_lib.sh, it's
a public cleanup interface, being invoked in every cleanup() in all
scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 1 +
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 6 ++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 1 +
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 1 +
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 1 +
 8 files changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 95b498efacd1..a678ee21973b 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -31,6 +31,7 @@ cleanup()
 	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
 
 	ip netns del $ns
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 7898d62fce0b..98f4e82789ba 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -143,6 +143,7 @@ cleanup()
 		ip netns del $netns
 		rm -f /tmp/$netns.{nstat,out}
 	done
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 87590a43b50d..98b6814af0e5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -198,6 +198,7 @@ cleanup()
 	rm -f "$tmpfile"
 	rm -rf $evts_ns1 $evts_ns2
 	cleanup_partial
+	mptcp_lib_cleanup
 }
 
 print_title()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 022262a2cfe0..5b136c8f0827 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -298,3 +298,9 @@ mptcp_lib_wait_local_port_listen() {
 		sleep 0.1
 	done
 }
+
+mptcp_lib_cleanup() {
+	echo "cleanup"
+}
+
+echo -e "\n${KSFT_TEST}\n"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index c643872ddf47..75d8c648f9de 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -85,6 +85,7 @@ cleanup()
 	done
 	rm -f "$cin" "$cout"
 	rm -f "$sin" "$sout"
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 8f4ff123a7eb..fd413b4c8123 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -34,6 +34,7 @@ cleanup()
 {
 	rm -f $err
 	ip netns del $ns1
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index ae8ad5d6fb9d..436500c55e12 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -34,6 +34,7 @@ cleanup()
 	for netns in "$ns1" "$ns2" "$ns3";do
 		ip netns del $netns
 	done
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 6167837f48e1..005251b61d7a 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -129,6 +129,7 @@ cleanup()
 
 	rm -rf $file $client_evts $server_evts
 
+	mptcp_lib_cleanup
 	_printf "Done\n"
 }
 
-- 
2.35.3

