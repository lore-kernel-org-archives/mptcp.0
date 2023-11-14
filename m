Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DF118C1E
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QsQgs/PS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GR3nH2DRsrP58c7H34ns97cPi0wh0NH50K6hxS2yM9YotJKeFfW8H+zX7oJ0AOjIpm0aJKYaHqU8czyMfd+LMr2J6a10SBjAM6vHDUywY03H6D4VkghrX62Ka6nDVYq/YnuPP7+lSrzDXRZPf3wamHhbh0EKsbpzkYhgXyGs+Cq91EcO8FrRalagdg9hsTdyqEvXcAEQpmeK9loA0QYq/QXrcwj/vI/M8NfpmYKiZwam3HSn9GN8WOVHIiTXGbitigGEH765QG/m8SxDxYXFRw5BwxYNNZ7HCt6WkTBsfVjyQ8tQ8adqLmvil3REt7ZM4/nsDJWYEqAQ7SOJRbloyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REVfFsoMxM5W3bfwncBbfAOpHcuaKeU03wO/aUM2aCo=;
 b=Fq7wBFr0+2wupLdz+rxRO8K7AzoRlj3Iw/zElygQOObg00t9ALfCtiNA3P/lEur3b+Hbt1gkvyCfYX15hrkSGrd6/IviE29G/sZ3Nk+2MePJYbW8MxpBIeXyyre665ezpeeV6KrE9Bt/kJgcJ11/PJYrV6SCVzcq+kGal/wE4yT7CIClYEHMVbLNamE9sP5+/uSNmwO99ng5vJcgKr9uU/gfTdFyEtVYQ7IwuWq/wtw1p/JWQ/uSg/J8l/8GOwpnHa6QZ3aVOQ1sHw2AmGMOTYHMQerdoeerDJmY0638JbgnZJrfuoOVc7IdCPmq/SSMQJKRgJPTwtgQgttXD+gPCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REVfFsoMxM5W3bfwncBbfAOpHcuaKeU03wO/aUM2aCo=;
 b=QsQgs/PSZw8XnB1vMWZWuRz+PLR0Czb173scnho4d/bLddyNc/KCGKIc8h7U6CZgwSsq8wsWudkGiPRfo9YClvy2OMmnE4k100SCzxIUitrHZH2NRFRLsUaZ8D80zn2l3gVxGeBNxJqRqCAYwEcoPaiGrm40c1HHuXlxItWsi0WhIOn4YGVWcVYeXi1lrwjDSwULa2cTF197U96zTAG2YA7euO6Nc+9BErho6h/e1LJyQU/z2/8rNa8mEWgsWpClflXSV+iw8XrutG4n/VbAz2gD6jd/6jKr4FLccoNlwlkbpxIi3y8/xTxp20b3vScb1Z7uYqifrTGti02/Pjtw9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:25:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:25:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 33/33] selftests: mptcp: netlink: fix positions of newline
Date: Tue, 14 Nov 2023 18:22:03 +0800
Message-Id: <655640887b348c214b4bbb734991c695b23964e6.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0058.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: b812a292-5d26-4a19-bf1e-08dbe4fc07c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sD9lZJaiuLOHP7Kwedkl/YW0/W1veEN4IjoAjLd311++ipbpHD/LqV+yle+NhodwwmU4C9OQ1hTtoL0OwHMnsTWHzoweG0ZiMCBqIiIRyA5Hs23Lh/A8Jfel7/RuvWkMG4TO7vSb/r6WjQ8I82GvMFnKJQGe10Nlta95XhYxSY0L/4lO6LHxKXugbGdLhCLU8ArMIWh7mnwuht6ZcN8Zmv+LlRN+yPO6WJxjcDV02j0c0HWckt77C9DHUrocEvLrv0qG0KSMSgiJ6y5Q/JeKosYbbfKMWo0YxvyB23EBV0OT2rcQBtMaACg3rD++VgUAoo+uXOc35gjRcBikmJeWuZFRIXlKmqIoeIDQRYCItsOGVgkk8rLfn6YCQ7F6s5dh1GlWynNPtMIUlhVu3qwSlD2SIBXEwBBbF+8+wD93YMSbjIRrEDUOAnGTAduIzUes1M3IhhpdB4hvlfQl3cbvu2qf5z6ffwXaRN1s7jLa+tKiZPdOafyoqG/kDuyJlcDNI/u8fivfavUmfo+uUuy8RSL7BGa6kaYHHPqy5YyhHSdIWDn/XgjqEtN6ir7RdoZC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(44832011)(5660300002)(38100700002)(86362001)(41300700001)(2616005)(107886003)(6506007)(6666004)(6512007)(6486002)(478600001)(26005)(8676002)(8936002)(4326008)(83380400001)(66556008)(66476007)(6916009)(316002)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bq9C23VLlkNPTRVNd5z33bFFoSDy3OXGUN+rwqWLvhH0Ve0T6IEwIvZWtw18?=
 =?us-ascii?Q?WHWqImdyBSb0tZW4WK92/bJDBRFDApJy1aIFdRoXlZWwfLTNNgU1A3C7gWqX?=
 =?us-ascii?Q?I/zNbEyREAhk/DMgjfavXNWcKO8PVRIC5xlMSO0wBBGpx5eU2xpbPA4NHqlV?=
 =?us-ascii?Q?7rEdWFZT9StVymwUaavl1ZX35Tt+gzcaRqC4eFujFNxebJGtlpcRnbgCAhGu?=
 =?us-ascii?Q?IiQAtYvDgiRblLpX/htfXsWJsQ5SSjHMu/fFBfy1UhFbSC/emJjNJmAmasz7?=
 =?us-ascii?Q?gawFGZV3VhW6a/ElJLEu35vlDHvH1XqYhsxDJAMjEPpx9b9/Umgi0viou/2e?=
 =?us-ascii?Q?8x6CKLcbUAss8BBHe/iHVQ7P94L5F4j5UFTMyWRI5owttg/W4dD+MzDwuIEa?=
 =?us-ascii?Q?ZazxlzZIp1g0pVPiaC22UZou2JR/BxO3z61x8nJIWWrQqPObmg5ICmtuBJt4?=
 =?us-ascii?Q?EMD9sO0DePD81eZ4Y0ddsrjJ88KTM18rOlkxkLhd1r2fvqzlvJ+GynRbkxPQ?=
 =?us-ascii?Q?VpMt0Zwl4fSp+Qgn71bm+zi9rbeiKdQ2zLmSJYCK2XkDZFMGZGSmc+/+obu8?=
 =?us-ascii?Q?EhdgKiFLUYBTMRtc150AB6xFt+k5VsYAUfA8tUN+LLZ9Av+Y8kmS/Y+sXRk0?=
 =?us-ascii?Q?zeQO+D7WgiLah04VkXFMHNtcY/VbSilUp/ckYlyfNOFq2nZPQipQeh2qhZon?=
 =?us-ascii?Q?AueTlZrudNQ5BpIjERXvN0sFAPub/GhLdcMUAp/Iq3mppCmSzxkAlacmhstq?=
 =?us-ascii?Q?K92jM6asVI77FV6Y6xNJSx4EQf3FWRhNsGP62xV03iWHBPvIUeHndGOUPL2+?=
 =?us-ascii?Q?ACp+wwGgCqYEkW2XiOXoxi8zRfR/xhPA2uu7pdrMRJvd5FQHPsY4Exs9SrdO?=
 =?us-ascii?Q?tzrJSPPw0A/5IlclNTOvhVvW27GeCM/+jZAlSP3bAiqszRh/pDT1vXU8TSjN?=
 =?us-ascii?Q?u5E4jDRxIplpkJ8ZKsAZnLP0UDhRDnw4+Sh6uRwmbllOipFc4BSGxUBpF7wh?=
 =?us-ascii?Q?7RbdK5fZfL9nHxDOAcRIMTt+ZKF8Z/5DH5ScNklReKFmRfjuKFvT9Is2v+IU?=
 =?us-ascii?Q?V9Xqoz1xpdpBKVuxJbQZj4vDQsNKx0os8rhlw2+v71OI450Degyx0wDLDEjB?=
 =?us-ascii?Q?muIBTfQYibD/NoHTLcW5pzETyjD+eBOWU7HR9HBHLaifUGiP/LoK/eIF7nPK?=
 =?us-ascii?Q?DqIGA66bWHz24Pn5owVdZ2y45x4hZyraxJe4uld6dFJA5Ia2Sga+OQgKzGot?=
 =?us-ascii?Q?4cA4SgCXJYKFDp5b1oBi4bfqk5flLR/gMRpdzEOHSwBS43O02VP16gmClsSw?=
 =?us-ascii?Q?Ir6p8IZBdxvUTAIkckJb9jpM0ClbZ8eNdVYwdl3bnQ/oplriWAKL0xed/JZg?=
 =?us-ascii?Q?QpeBLz6YQlolFdIUsME5GOB2UJGJ9EkcHz9oGRhvpRmb0BtDWyDUfaYNKslO?=
 =?us-ascii?Q?PG15LK1wWGISaxzb/5+YfJFefkdVqZymji1gWPFaIPQVFWTct3lklRuVOfsy?=
 =?us-ascii?Q?od6fTR0hm1i45aspSQfm3l7e/TzbubyNoJFT33Y7LoovUC6qjkxya3ujZhhz?=
 =?us-ascii?Q?HXPPSMI0vJzvZyVt4nwIcIl2Mw8YRu+xK8y7JlRb?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b812a292-5d26-4a19-bf1e-08dbe4fc07c0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:25:31.9711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9MIN52xlpsFLUIwClAkxqN9m4svTdJNcjAY0d3sipY/WtSpe2FZHeqGkvjmaPE8LlWO6XpMbaG6WJkGwyrKLBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

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

