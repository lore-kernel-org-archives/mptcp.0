Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008EB8474
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MWGb5De/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGgc+dC+kpgxsk2Bc0Dybf/mM6msxeD61UHLlPq9g1P6A5EztCz6F+J05eeCSXgjsggJII8I67+iUupuVjDL3T7vYfUMJBxKM9M6RzgiyCaP+NFRgc+4shSyG8hFslRMpW18brIZdO7BJtN1l194vcI/q51zKYM/el2L8VOPaRatHp4S9SdMbjnRdrXiqOsm6bwH/3JYKZSXX92QDcKU2J+t6HlxDz9wWYx6dSS0IkEd3SE/WytAKauxUCLEg5lGC351Y58Qi4D1q7XEK7AfKM4aQcT3P6ixt1qtBLq508xNImOIBnQuBblF9Lsr27Rp5S2twJJHMCtar6NETigHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezM3HUTE7M0loqo7YBSNkduJPGLKQU2GXOLirY2b9Yk=;
 b=lKBe/uqkQhp00OuxBRohx23pHEh2Z3sfizHVctIHS6ThGpPICieogGvJK7cw4X3I7mRmKuf3t+1s2l2fKAuK05Ut1x4S6neoDhtxXpYrTM/f8ZAzDBEVhGgOCxlNZhD+sq8dsv+z0bb+eAScOogiRamcXu+C6ft583gb2nCYpjHNWFPWyafSKiAPIJ7SMgRfP8Lvtlg6X253zukrH9XlUrIOSSqLX9C+HR/0C+pGFessj0/oyD2GrtUWujDDdDixaluy1AzbhQukDPziCO18OnfGp3w2MainvgYf0c3Ii5yy9gAyAWtmbOZtq/7tIEYvC2p9cSMFOB64Ap4zz9eogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezM3HUTE7M0loqo7YBSNkduJPGLKQU2GXOLirY2b9Yk=;
 b=MWGb5De/iCwSgcUt6EzCW3VbksV+vAORXYY5DhrDnJjmqokKy9iBMBt6LhMdKggq41p9MhZDuH+wkaSPq2AOpVqbfWjnFs6IZk2CvxNLmlw7qL2X4eLZX7qFHZAugIJyfp/X0aVDnSIQ912Z8hoZGb8Cd+Xx7E6O8hxVttbUOOK67Z0T2R3mRNhWg8sFwrFpHDB27r1MRdSl6LoDzq8hx5IgDstzjKLdeizVq/RaWLhNaeW+a/xc8oJKUl34MoJZmkXVRiNd2vlqnAMnhMbFq/B63M5O/CH5uidhGbSIq9zo0UwuKRBpKS5AfvjWLdUHyknxaejk5Cw3k7Zyi630Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10038.eurprd04.prod.outlook.com (2603:10a6:10:4db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 02:49:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:49:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 10/22] selftests: mptcp: add mptcp_lib_cleanup
Date: Mon, 13 Nov 2023 10:48:54 +0800
Message-Id: <118c5320e4425462889fd9a8661ea4d62cdcd85c.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10038:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd34a51-a985-46a9-887a-08dbe3f33828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a3NSSOaYouiz3d6JhVg3syf5PihiHPtEw9K0qxrYK4UnEJqoFPlkUn39aTAEiurm04bjJIAguwjEcUZOi9dIcnnmvPg90GS46/mjIiDsp9kAd2/n0zU4SURTAXiCWQKH2yVCuATaIl+IAagnDq+wj+BBJhEJvfoLbTvHUJn+8jcuE9It/PTo0WTxb3bxygnXlBYpM9jDZvI/4li7nVQGVXyIEgqmEl7d6GeTVUEoiuWnAKh5VmgQzHYLolouIn/0KC0mLl0EnriRufJnMTYdoNMh3Qa8f1kH6plI8IncV9flcSVBMUk5G/KN0r5QU09I3Ny8kXSGwJ4fnXnFAYEsZktEXGByz+3GIeUhF/io96ntWIUPN4ftU58UEixNJQDJm6XLrOr6koAr85GJNyykAsu1eF3PRDKTxTTmz9Hjti46OZo0fMVjdM46SLPo2mChDhSwDb1cMRJMoK3nmUp9V3jWnzS3cQ0Zgznsnf5GtdnipboewrG3UKqxBUjYrv3FIjZtrKFmcDcd3Q4KRl3tUJ/PNR0XGXCotArYcXdAKazcjKJvtdBwy0VAZc3gKRyn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(41300700001)(38100700002)(36756003)(86362001)(2616005)(107886003)(478600001)(26005)(6506007)(6512007)(6486002)(4326008)(8676002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sjdrV4hP7viIMavM4Xr7YtTkwsZkyKKg44xsPrbUOoS8kiVSozQajtnI4wJk?=
 =?us-ascii?Q?kGkYDs64cMo99P0GdsaYodYBxQ0v1SgD9Zh7NiHWqGA8gw7KynpvGFXkdcOu?=
 =?us-ascii?Q?l9WN52pmidSfAUOiP+DwtqSBDuEGEhPAsJGv9MNY2zh0H+kQ7SZswXug3YDE?=
 =?us-ascii?Q?87viy1APLHPosuiby+3gBtuX1C6axOvZtAo9Rt1eqVyLAJyiPDjIMdNZChBG?=
 =?us-ascii?Q?kg/jeoGatQ7BUNL0VibA2TPjBBatSh6w+KPup86BIG82f0VOfuzX9rBmRyZ6?=
 =?us-ascii?Q?lJVIHyqHet2VJhlGgStXYWu0Lf3HbWpuHbKAP5lX84keMD9+D1vGkXCxpq5/?=
 =?us-ascii?Q?niWgOw72suGgaw4KPYl2b2CuQd+ooiONNA94pnLkL8uAOFBQvl0Cguw2BAXr?=
 =?us-ascii?Q?6Z2r62PKluCpO0vrIfw3jOaRF5t8j2VDsgNFKYWVEfYFj1I50pfUZTGK46Cm?=
 =?us-ascii?Q?dzPUNI0eLNvOmVjzXzkT2qk6LO6gWylNLt3SxgsLR8lEXbfa4ToBaV3gqA6z?=
 =?us-ascii?Q?dXSkJRGcgVNrQdVfQidMkoKHL4o5NTPctsYLDfw+ySIXE5jhOVlqUPrsFPMj?=
 =?us-ascii?Q?17R2z7kp700oj+j/nJa0jRDyWO2DUgTJqU2Sinm7K8sUw0X8TwozrE85oKJB?=
 =?us-ascii?Q?kNs24jJDJhvMmzue0C/aRbL/q0HF2h90SNVzu6ORYA5fg2PrG1vpxtF1Dcgv?=
 =?us-ascii?Q?fYLHzpK/TV1zfl8EEfMf6iC1g6RReaiaNGYxhLJGtxqzMib0o4mzLpYkelTo?=
 =?us-ascii?Q?UW1LTYLrQtleoRH/+R0GMYoOwyB7+L/d6oo563WCrMAhEOp8K8b46MvF6bff?=
 =?us-ascii?Q?YOt9HKwIxgt5sAYVgpjAPxK0SuVPAK0n2UbETuzsIyJO9Q6e/Yvy/DYd6YMK?=
 =?us-ascii?Q?aBDC7z4uAkrUktBemmWYwfqCSJ+bjK9RS6Ol56Ad/YqPKU+jOV19vqE5bPL+?=
 =?us-ascii?Q?yujW+7vhp2vjivY3Orka0NucY9hYy8Mj+dpg9WcvSNLzL/62lsfQ/UClF19Y?=
 =?us-ascii?Q?yQGbzwJQEJuZN/usKHbE8AR96HDDPdBSXRr42IVJ/NXv576gOZBSgvRQOOib?=
 =?us-ascii?Q?iTIvoEsJZNXAvqpgKhiDTsezkAckFSFRfleul18iHZbZF/jnuH4IO2N7Q1cu?=
 =?us-ascii?Q?HuGWHbtd6mxtovi/2VlM4W5jdkasgRZkxmBXe/X3rq8xKAHtYwr/fn7jsCry?=
 =?us-ascii?Q?SnYs5TbC+/qxs8HSLh8KcscUkdo5opcKZ1geAH8YjGfqAId57rKtLekqJBze?=
 =?us-ascii?Q?8MhAGHLewBGkaN+f/lERgNltzU6c3dEA8MCX+/WIBKAGcD5DqxgPPAab1gMm?=
 =?us-ascii?Q?j/8VZHML92pwi63mB5b7L3dSrOmZgLgpInuB1hzhElav7MandXcSE1a6Zf1j?=
 =?us-ascii?Q?03BMJahDCw0adtFPJBDLczWIfFbXFZa9HjYsaRRpffC3aHr3Yxxk5PIAz8xd?=
 =?us-ascii?Q?D8MWI0g0VyAwDC64ZIcl25tubEb00w+BNyAKOQSa9v5LQm8x3wFXlfaaFEaT?=
 =?us-ascii?Q?sf73iAnPDlNe/oFerHLDrefw+tnezF2X6qhQ+dajevPDxOnnlw4v1d0LhffN?=
 =?us-ascii?Q?QqphDPFutyc1ATkA7ODxUQVsGdVUBM4mDYNUxhix?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd34a51-a985-46a9-887a-08dbe3f33828
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:49:56.4964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sAfhvnHR+ukkJ9O2rfl+AAnW0+4sF42bAwBuFtLipeduLAo9G8oBI9mX/6lUINHOsc7PbALlE6Yre4luIqXKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10038

This patch adds a new helper mptcp_lib_cleanup() in mptcp_lib.sh, it's
a public cleanup interface, being invoked in every cleanup() in all
scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 1 +
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 5 +++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 1 +
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 1 +
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 1 +
 8 files changed, 12 insertions(+)

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
index 995280882428..3b49a1893772 100755
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
index 1f8be9dd0e20..cbaa55ab89b1 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -299,3 +299,8 @@ mptcp_lib_wait_local_port_listen() {
 		sleep 0.1
 	done
 }
+
+mptcp_lib_cleanup()
+{
+	echo "cleanup"
+}
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
index b1155f4a8504..85b2c9145601 100755
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

