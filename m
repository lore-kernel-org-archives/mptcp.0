Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DB544385
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ucu4yACi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1KYxYXY3pRgoAxfvOdlQMbgKbpWj0cjSZiXyfYpSqIRfCYx266PtA6mYJ3Icm6qTpDzBQ5/AYAhH3va4IoleZveuzxCXguSRoCmuyp645D/IMEe+RbqA9d5gSipNPHj+W9Xf648vTIXlLuUC6DH0GpKI2f1NE6JDuj3OGe2hTOiV/MzuA7NRsyr+0eob99JaGCike3dzFg0Yp8BYfP1IojBZVmaP4zkhpp5ThdakUea96hqfclEnIiBVeFgwbPhhciCfbCY50L00+uTk60vvatnT1rucnk7c7cYWtKgevy+dqjoUxlPvXwdIidD3VYvb66Ggd8VQKQbzWOwd7bHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c77BzoCI5dutj8uJeqPUIQddjCTKEEC98Zzl1sjWao4=;
 b=G5D8d7FJ8O/Piw2Mx3/0AYXTGE1wzzRAGAloSp1/A3pzEPLjKqpztXTRlGBcWvy6xIeRl4UzOc8UHXGhNnqyiPKcVhqqXsaThj4yvq6Nx+39ksDe08rxZNZeA2azUFM1L1DsngLRKEwYA0wZQ2Z2PpCXGryy8pZHc/X9Ulez8EmAISsmSQjTEAy1z1S/fQbfWorYHr9kLod3TrnyE56jlaQSrY9TpHjz1jCcyJiPjtUTnUrnEOGtDcn3WHyLDYUqeVIQQbSRpwSxpK3pV+s43ABAzK2ZBcKzRg+XTP1QmA7D0ZpkQXPQIFjT5R86PV1bokfuVDGlctgiewpQDJ/JlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c77BzoCI5dutj8uJeqPUIQddjCTKEEC98Zzl1sjWao4=;
 b=Ucu4yACiG9iJiDSp9zuOV5glPhEYwOzqz7WXMRX9ZHZUEh56YkVJuzCgajNL5yJseugvH63SeC98nq+8zX3WogERgTqdfrGelV80XYTt+S6x1eJ4ntMeVtxtp1emO2X1IJ0yCwI8lPrugzhkrxC/dPS2J8b50RKEfJqzpi1eF/aw2n7SOwvFI2u7dt2GvzxNo3LHSDC+lNb2oAt8+yw+He00yT5EKPz5rT2OLrPxUjQaDNMjDZcBwezVnTmDA5FwkkKU1Z9W+TASuzmxMP2ePzAiIAivMBfb4w07Zkx+bx1RE2jYqwSuWAlRfELymRddQjaC3fZG6+QlsKE4y6iJqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9333.eurprd04.prod.outlook.com (2603:10a6:20b:4df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 11:11:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 11:11:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 5/5] selftests: mptcp: join: check CURRESTAB counters
Date: Wed, 29 Nov 2023 19:10:52 +0800
Message-Id: <ec671764e010ca002224c611aae89d829f205166.1701256112.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701256112.git.geliang.tang@suse.com>
References: <cover.1701256112.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: 23062a89-cd7d-4fa1-e8bf-08dbf0cbe8f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z7gLb++GtS0fKt8DTEAxQdxU2Dx25TWmISOAouASYHfJP2+Q9NUTtBckJ1uL1Yaofs1r0NaWcabHHXEOAjJNOsUc0ZUJOA4ExHmu51+fEsFgQ37Aaygj9hT/sFLUUstk16tHb0YLqHiWPij12ND2mGP79xMqRXlJ87xUihpriN0A9DozK1ax0rCTEsfztCr5UZJgpO1FBES1UaD4CfbbUyFx7eRwOTLyOoTzCduuLLAIGG6FZJZWCvfbGMKT6Isi0dcT7y66Ow28tts2jCV4D7roAoPA1Ls7UkEj9G+dnfhZ97xGehXLpZEjIoEhtBq27irSlEKLGpEawPYejcqRu4Nw7KtWKvbNIVcKdIPmM/GzZ5wCEX8dW9N7ERY76Wf8yPg64xCah7GKq7b+58ig063JjybGzYCYnxfefTZhrTDjUzsfhDDf9LiGWmJArV/VNDVh8z3mNPwwvvT/2SmiBm4QeEZ/mf9eY2ykT9RPyK99Y4O0O3293HHQh8bvSGHc5ycrJDjU6mpvr6VLOOSHc3wGMYkGbqikCgtemVB5080IQ2rXNmCuEEj5JF1n7po+jxvYIgezubltosp/IV/wlS/bIMYAGp/bKdL0GzHLfoo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(107886003)(6512007)(2616005)(26005)(6506007)(6666004)(478600001)(83380400001)(2906002)(5660300002)(41300700001)(6486002)(66946007)(44832011)(8676002)(8936002)(6916009)(66556008)(316002)(66476007)(4326008)(38100700002)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1VWAUQGDQaKo/KS+KTCQ+mUSRQ52J7L8vDm+HidwwXvC899QJjy0d7Ewc2tr?=
 =?us-ascii?Q?8ylsa2ARtBy2cOP9e502EMQYwOG95uYYcw5FM6nGouaHgq/4mhIYfHrctyP2?=
 =?us-ascii?Q?2HEFR7nmgd6Ffg7c+C7Y3MyFZ+f8jqbpjHC0AdSkCWlRu2UUgp4Qe8a3p2++?=
 =?us-ascii?Q?uV9Cp0eWbXifAIrWRvNaTwqwQvxAP0Ry6MKpdoOvQnZ/TQQSo2H+MlmBfDz9?=
 =?us-ascii?Q?2N72SiiTOuwPSNMo3UZkX7jvqdTaoeA4FWfnCIc1FHIu8t0fc7OoVelZ9Apc?=
 =?us-ascii?Q?tfYvkSLfue601dr/tr0jn2a1ZjkmxS0PZxIUqqg13YWVl07lhTKse+WtsbJ6?=
 =?us-ascii?Q?nV7Uies8Rhf6hkYwOtJ+sBhpdtjFHR08fms9f9Rg/MEVnPpuAo6Tttjpt/xC?=
 =?us-ascii?Q?DBOP4yVholqX/OhGeQyxtNDDfmR/dsOQrftNWe/hT+5dvqlQ6OPNgJ3jdBxg?=
 =?us-ascii?Q?0bvOsS+02hlOLGWhVdD3TtNEz69NfgTkUXOqeRZCqx2PFPC03hDsNYj6fbgu?=
 =?us-ascii?Q?j4jvKSbXIgv6gN/UB9q3VMDNhOkqXYGGZM/ubxflGyjfNgQvmDVo9ZIUTFYx?=
 =?us-ascii?Q?CosuK2u15eafGCH3cHds138L5yue/qJt+svhWTzRFHXhEMIa/bNVNg+yXncV?=
 =?us-ascii?Q?ZaYHPeyLAFUM1+y3VRsBd3Kfeb2zmPu/1QBmgS3jJgh6TK0HdzqTLbo8o1gy?=
 =?us-ascii?Q?e1nR5Mif0phKGFhjFgDyp2Ysk8Vk6eRdnR23JyrUaQkmlp6h68i7Xfd0h23H?=
 =?us-ascii?Q?4WslgOiHerLcbqExIMe43cEUhhlVtqQaMflZC2cU+bEHyNmjcTpDIhAa3kuu?=
 =?us-ascii?Q?u+M/L5bZ6+jplaU6Mc3kTLe7gRUhqUL7T1RRuyh/VxK4Wg6JBA6tLsV9LP83?=
 =?us-ascii?Q?9e3bI9Rhj60F2lLzWd4/VPTRMvKE10+b4iS4xbujPvf86xdGUvP5WsSQhOl+?=
 =?us-ascii?Q?Nvq1bo+9prQQSUJFWEEjSmg2BLE459AdH9/z2Cy2mWCEFK5w4BUusZRZCcmw?=
 =?us-ascii?Q?VJkbgR9hxcmFTriMYguOwRaadKxFmBVOTgQ8e0OSDRkUPZwqi5OvuCwgBCt8?=
 =?us-ascii?Q?oNFyVwG4Jw/wpksBtz2rXiBJgxO45iuXnuqS76b4JxpFILqUIQlpF7qyFn0D?=
 =?us-ascii?Q?RmnD1h9ESJbbZQuedjXGRBieWgeWnWQNa9s1GVUfjTQ938APER00xa5tOuSI?=
 =?us-ascii?Q?Ha8Fo1xIOoJbapdlByKx4cg8jt+NeI1i2NJbcVN7c/fYv9JMuBVWBtA/M2+G?=
 =?us-ascii?Q?FnCkiQ6BsUdcL/Myp0k2NuEbWZaMwxHZzhfBz2Q7LjWLqWgEnHWWaoW/D8mT?=
 =?us-ascii?Q?T+IQNWfkNWdd1vnCALy8DZ0veQNgNLX0iOw08VcOJJFUGzWDdAKTklQhkcyw?=
 =?us-ascii?Q?gOcB7HEvqFBahmvdu33Ra61dTEzbGzWP6DJWxeMRNNcPzca2azvFdtj1qG5O?=
 =?us-ascii?Q?alOXyFxQE45b2jT3nrUxOjqKk3nkkr8n7PVEvXbR337t38XGxF5Ul9jaEdok?=
 =?us-ascii?Q?aTXxjMMDylfbL91XjXWny3aocR16F4e77n9Rb5um84uV4oYKq0bUWWUEOdyI?=
 =?us-ascii?Q?hPwfUJY7qNGwYcVLcF8UA4KZHZiwcyLyXBeE/VykAMrVZtttV3V1814SGZwu?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23062a89-cd7d-4fa1-e8bf-08dbf0cbe8f8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 11:11:18.4398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SzGQoGsD7wUc4wB0RWYmpQjZRR85R3dg8971Mz/GkVsFctnyhUZAdKdyTVKQxNkRNZ7TYPdHPbldXIw221WFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9333

This patch adds a new helper chk_cestab_nr() to check the current
established connections counter MIB_CURRESTAB.

In do_transfer(), invoke chk_cestab_nr() to check during the connection
and when the connectin closed.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 87590a43b50d..36d855a37933 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -976,6 +976,23 @@ pm_nl_set_endpoint()
 	fi
 }
 
+chk_cestab_nr()
+{
+	local ns=$1
+	local cestab=$2
+	local count
+
+	print_check "cestab"
+	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCurrEstab")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$cestab" ]; then
+		fail_test "got $count current establish[s] expected $cestab"
+	else
+		print_ok
+	fi
+}
+
 do_transfer()
 {
 	local listener_ns="$1"
@@ -990,6 +1007,9 @@ do_transfer()
 	local fastclose=${fastclose:-""}
 	local speed=${speed:-"fast"}
 
+	local addr_nr_ns1=${addr_nr_ns1:-0}
+	local addr_nr_ns2=${addr_nr_ns2:-0}
+
 	:> "$cout"
 	:> "$sout"
 	:> "$capout"
@@ -1090,6 +1110,13 @@ do_transfer()
 
 	pm_nl_set_endpoint $listener_ns $connector_ns $connect_addr
 
+	if [ $addr_nr_ns1 != "0" ]; then
+		chk_cestab_nr $ns1 1
+	fi
+	if [ $addr_nr_ns2 != "0" ]; then
+		chk_cestab_nr $ns2 1
+	fi
+
 	wait $cpid
 	local retc=$?
 	wait $spid
@@ -1100,6 +1127,13 @@ do_transfer()
 	    kill $cappid
 	fi
 
+	if [ $addr_nr_ns1 != "0" ]; then
+		chk_cestab_nr $ns1 0
+	fi
+	if [ $addr_nr_ns2 != "0" ]; then
+		chk_cestab_nr $ns2 0
+	fi
+
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
 		nstat | grep Tcp > /tmp/${listener_ns}.out
 	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
-- 
2.35.3

