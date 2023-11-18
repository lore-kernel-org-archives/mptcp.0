Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2054.outbound.protection.outlook.com [40.107.249.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E08E16416
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OuumzcpW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Flv9tx0nmAMqqDIHsfqzrcEIS11D/FB862pScbu1/eK4xx7PbQboUwM/RaCZjfCMsZEgXWK3KzDJb602jiBDhLkdAJQKN9+s28ZwXIbvml63HMOfo8fl+PV4Cch6M+eq9Jd5JzzybWPj6hkzwcBRMJzZ3q1MEmE/x5/A6Dya5f6uYzNgMQYMlYYxZHhG6603UqP+Hstsn2QZhUdfo4QjDCCU4KC1aNMjdCA6Kclh38xyrcfY959fjf26rVV3B26d+KrHcLfpnIsRuhl9/R9KdV5DDFRL/wa8XKElOgbziCuaN3SIPb04pA3t7EPoGE2W4QbF0gr/uQtsjFCYFa1sMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crNiTFpMjs7yAPN8QhN6HNu+J2Et+4KM+5JXUFciygI=;
 b=LUqcl3+jnG5ddWrw7SzLERVpQIJcd/HUd5hdX5RhzhWx8rVs2dt8mxGe6v4wg4IglnaQClmKQDr+9zyjkmtp3Sc2kJ6+Q/tWXUUbUtwf/v7kIDYMwxlzPmr3SSOUpduCPD9nkDzJLxQ9CrcDXtIWtG7cN25/PkuVJrPIiLowKBwjLGCg/1wW28RsG8N9PNljUgrRO/PPj2wrt8iI5lx8j+JsxwL+zQ4cttcoU5bVGjBXcPoktiAps1oHtY/Ua3vV0Z0AANTzK/Z7R6almNgAcPNkTHsxbLLNoQ+f5yoCaZG2OInEAhMDJarE5UD1NJsjDWZMKcSNWrGY38IEA8BOuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crNiTFpMjs7yAPN8QhN6HNu+J2Et+4KM+5JXUFciygI=;
 b=OuumzcpWaGq0YPDd37MAqJi3yu/PhDbiZNx3LmhuC6s6cv8yF7aSbJtrInBwQTR9LsqaW02YXOTmLzYzvwnYpRjKgy9osZ89W0cpIhZybWURuAQn6a2dr9ScYNBi9POsFaXrUJQSC8o/raQrI7CMBKM+8IckA1cmgvxV+OkyRqdbfztx7ITf7r4HAlIvLEHnp/tM7ilmjyn7fnAcUGUYg4etfK9xERDMTy6N2AIpQVkdl9ejA50Bbg1Iv/hSAo91Vd0LjTOH89F+NxxRJ52AmvLrcQ65mqCVfzzXATghe73sYxeeYHU0JxxUmbZrmtIFXqBDl+nUEjfBVZLYTOtzkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:30:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:30:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 09/27] selftests: mptcp: add mptcp_lib_cleanup
Date: Sat, 18 Nov 2023 22:28:24 +0800
Message-Id: <552b0c47e23435377522bd013dfa03eebace1ff1.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0193.jpnprd01.prod.outlook.com (2603:1096:403::23)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: e889b0ed-ab0f-451c-c40c-08dbe842d9e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jzIbomIooydvt+CyU5xO3aIWS3Ut2IHFB22D0sRSjLlugT4EyCIQsB4/e3zCrfXcdjAe+aeETsaZQSnlmB780N3zYQA6Zmjf8FhWbNu7ycOOzTJ0cBaocl5IgZp/5RXV/PCoJM40ykTWd89LG3LjUNfPpMrhrjlR/z/3h04Yqbx+8W09xM6aOXbx/r8ulHU37ZXhY0qIjAAoNxc+kzbmv7iXQ0UsMUUCGor+UnFICAXlm4fBXCMp5CWOeNwNqMeVvvX+bLcs3SRt5Chrd9ERTZYQSMAO7j2BfCqPHE2ICPfrJR3R7WOygkCFZ+WfFzGsgMbWmXWuYQNFswin0hM3inChTZU2WP9JQpNKaycwRv4Bvh3wLzkmLFGOMDnwlRE73M3K5seHzGsvSewSOcfU4axWL1HUu6sy5VqflEvxLCYgI2r706D/nxmgB4IiJF2+IVDnOidR8DQMo+XvpuXbqsu27Ue062cKoZQ2psfiB+Cgvq/Z7ZieXa1o7qEEKAKEtX/WwIWOs+V9qMFVc3fKU9/Ej/6ROORH5uQshUlZR0wp+3y+l30/h0Hd//nH36uCTmqOiqOdV1ksFmB4UY2kj8L3BkCIp1765tukiY0Tsq4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+UdcuIlk3Ge08mIL8PAYYgm3L+uxqDlKFX9PhfCY6d+n6JJHD5DC54tOSgcK?=
 =?us-ascii?Q?kydAi31zgRpHg4IGfQsrAXE0zqN6lHaHyjOOg7ol8PF/kd6jaD4pD889cNs5?=
 =?us-ascii?Q?UZmqC/DAzFB3zvDindS/svlLLPweeJS74zNmR7ZGL97oPagakkERA0+wUH1C?=
 =?us-ascii?Q?dc3YRiTTb8/hS4NvkEc+xG6kSQ8dtRV22Td3A30YfBaL8TJpgKirnBKC4VvT?=
 =?us-ascii?Q?bRjGzw2Nt2XX141B/D/pn3BGJFUGrLLcbosJj+wh5A/MBd3WkkFG9fW/EQbY?=
 =?us-ascii?Q?d6U8h/fRuCakWEzQr+ua9tbUUbDOdcjMMOiGJHCRY6u4KKx7TVrL0b57rcSH?=
 =?us-ascii?Q?bYyur6uUb9M5ipruAMG8VcmjAcJT32XEKZlviAdBiqc5OrnpanJRkMd/Jjnv?=
 =?us-ascii?Q?AR108UKHGUbzlD/WQ8f7XYpaskdqUDbk7brpNqLlHdjMh3e0D69+2IR8O04U?=
 =?us-ascii?Q?mnFWkoh19ZCiQY95XHOtfalGThc/awzBEBkFZmOe7DS+O9EZlzTcr9/+NFB5?=
 =?us-ascii?Q?pwALA0KZlpSktZgIN+LHq+T3JJu5XxUeTnn6K2/qGIfNFtKGrecTWiSwEDAp?=
 =?us-ascii?Q?ptHvBbV7AI5JhOtM1Ea7qrYiVMP8nkVmBKSrRpzE5EEz202Nrnsbcqm5V2il?=
 =?us-ascii?Q?yP9p25nr5x23mSWHnBA6YNv7sjFf6rLecHPxSo/d8IiHe2Ey8xswC7Q12LeV?=
 =?us-ascii?Q?TptCb5ZMItzzzrEiKKcb7sJWN7qmeQKMpL2h0M39/Abi4TdOy5cJ+tX3J+g9?=
 =?us-ascii?Q?oDGFoCWnGHVOzgw2rYcGKErHli2wKBkWQG92XdgiyCc6GtbQPvd43Ob29GHk?=
 =?us-ascii?Q?jG3nWjskXKEyzDz3rZdLXt0liBlh4qWFgUFq37KrLbBcrdzfnKj56pUsXVGJ?=
 =?us-ascii?Q?288jAhNnI4XcHcmI+wkC84xd//1NR3anDUVsxZqSQWGsKUTQF5r4Ju2OmeBP?=
 =?us-ascii?Q?emVxgtmzKVneA1SFpntwcpw4UAEYB64ExTlzy9Tt4Zn39DvBYMBaYs82f6Is?=
 =?us-ascii?Q?aH7ild4Z3wi8yUBs202fir37ozFm34pmjrsnOvAkcNP9CEgmEXIla21xpjHv?=
 =?us-ascii?Q?4igSSwfcMnkjPv72JeJlBSveTnoqA/HzLW3ljZtj2qErKvZv0r6V3WG5/JHQ?=
 =?us-ascii?Q?5aUYz7WiJ9kkc5kJfWgT2DNpyOqUWOY9lfHJEAnuCkCDekrEK17HHxoLRUBJ?=
 =?us-ascii?Q?ZoUERYRUKSxqKOHiOV01HCnDNWeqi6MGhR+4PKn1fkxTSquNyeWGSnt5o6wW?=
 =?us-ascii?Q?2VwD29uoKOky+JgUT0AbnIa7jkRpBxBxF8zd8J9zCIEIC0zjkUDPOXMJGvk8?=
 =?us-ascii?Q?lhKumZdYFSC4CVKbN6kt+54MREon/fZrJu0cu+dSe6EMOtWI21UJfmBrtixf?=
 =?us-ascii?Q?jZdUBe6MYYb4/HDrPfyyI6e+MYI1R5/N5nxn9GXcRZtxaiTIbaI3CZn5aGnj?=
 =?us-ascii?Q?IbrW/mxRaIjLB/X5YhL/luInespKaeuL7uJ8tdIpMpLJdWKMRsXuRRCfulVE?=
 =?us-ascii?Q?+Rh1dKu4zCrRxejxMVWJgIzs5rd7/tel9A/TL9W6M1vHCdJFmC6EPwt6dDom?=
 =?us-ascii?Q?oO4dWLbklp20EVTEEhjkxmjUwK1b2jAmUr6rIHG0YG9rnbcbT5+M9gj3LlBb?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e889b0ed-ab0f-451c-c40c-08dbe842d9e4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:30:02.7510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpUXl+/IA1etLsxU/PRkY510Ia2KtyfJRP6Mrcq+cxGGqZ5lgzRtSqM5ezUldPGWQcHYxR78wuAa80tBkE1BtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

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

