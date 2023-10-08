Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62788BE4D
	for <mptcp@lists.linux.dev>; Sun,  8 Oct 2023 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CnMvstdU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNdUramnHRrwhXkJ+IxzGWXAoKOSpXToqQ59XAuIVcbZJc1Xsdoy3QsiILUNq8EAPWVVqNr4V2ct74Sr/XQi3xbfVqenPz048HYkyS3fgQui3n9FSew5jrwWBUOggXPN3zxS5iS7qdy1Sw94IuVM2P0hr34N0k5NfrdfOxtnuo57Jp7aW9DKGoXbnKH0rDSnlPW7ejmpw05viFppxs85YjEoS4kEIf/eLW8pTSO1E6K7I5m4iLRoh+EG36uJF1uMo7Gm8cO1HZ2WKhbI0XqJzthjnLp+aID+GOpyi95nNuYTDi48UtVZz6sZoOnQfMMwP2/T4SN7H/9Y58mm0CYe8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ue5fMZ6jieTGa+5sWcRUvmv+6w4BOJ/BE1pvC8RLWsU=;
 b=H00Qw4C3ng3IHW69X/27hdyg+5v/Osvj5HrD4mCRGoa9NfVA6w+hfR6UDWlvToHpSSlqfnJQvCjs0JLALFMD5PdgtoAvXUyRg6cVK/oVK0bC4ppYTwBLBiE/x64xWvPBmER45xFOE3vLG/HWWGa6iWIaSYFruTeuyUK6yDPoGwYA5ePjaq2VmpxxXpo8ojy1/snitzlJDvcjkJrLKcw31hTOWyqlFWZdo8rHUbLLCGT7BRj/7qKbjLmwndP2VRqzT+fdvr8royWSvFG5BlLkK4aSQv2Hlqk+zSHdT9KVElJ6EaKSZQmSu0HC54YBkImC7VxTtA7gUwCEGhxISU15NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ue5fMZ6jieTGa+5sWcRUvmv+6w4BOJ/BE1pvC8RLWsU=;
 b=CnMvstdU5O1+yqoIV3YAVFv4dwCeLaOtvv2PewBWBgtlGbGgHqXV2IAfllaQGSUykbgsB8htI00OUeQpu1i+yONXsP9rckQyb8njVydxqtLc/am6cYWE2JJEKV4smDYfwo9YD3kqIdwtCyb6qVcyLWov1GypZYNR99svXbF6D+3nwINmJCEXrZ1qztWkhgulwrQpCR5moy2AYhQV/04d+rftacF32Gq5Nr2TEYUaS/2ymx4jG5Ef9O4ilGUDwtJN4xORx4Uo781lspnQIKnfZjQjCkx1isXBvDq7nOaxfSdahp2ZTyCPvGqSGsN8bAuPyfuRQNkIotyT7AdyNO6CGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7222.eurprd04.prod.outlook.com (2603:10a6:10:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.42; Sun, 8 Oct
 2023 10:26:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6838.030; Sun, 8 Oct 2023
 10:26:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 2/4] selftests: mptcp: userspace pm remove initial subflow
Date: Sun,  8 Oct 2023 18:27:08 +0800
Message-Id: <1c1cbfa1233832ae989bad6a4f541420f3c43fd4.1696760702.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1696760702.git.geliang.tang@suse.com>
References: <cover.1696760702.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 0512f4a8-0382-4cce-3456-08dbc7e8fdcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OQ0/XBLjA4uhZY9hJYUI4kRP3iOcboKf01aTHF8djPDBn7FMo4kddG+hzPOZ/hj7GZ9Wt0MG0tuRf1dzuVieTDOhJEZWDk0xZ/q18JG/dU+uitRAI3NI2xvgWsXVPzBx+kn+Ia8YJmGkVlIZoF5cqAR6HJRnczbYlPDXURcsfSfmfPqL4O3T6QN3QL+lq+jyeOBpSBq7JkllTxexA7NcHODW6/u7FwrFejNIFVyywlqjtRGN9Kh+vPUb5BV2LApUgQTn6Rdb8gu2Gdg3IRMW6kkEbbeMXdbmPAEDRT6q6Ha+Wln6SpJ8Os4BGNMoZRKGnyX+v9qWVCSLqiSY7LqA+RP389JSBUJIECcK86FM/pU6UiciTu50ho/awAXphfalgcqJzXcCKR+MoBpi15PnkItMnLzluuLgP+psqKBx2Ws16tbnjHEo7F7dShd8uOp1OLZ42v4g3KukelxAboHYUZKMeXaiNZ9D77pToedkhErqNx5TCGEYuBs5t0R+UB6sUVDIxl+92L3XiLYblvxQ299TSovzwPq3qMmLwrpMDJhAvdEo+QrWU2MvWqA69Bnd0TX8EKXQmDtY4DJFnPCvEuLVrQdAXIsjwPbS5BwRiFU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39850400004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(86362001)(36756003)(38100700002)(2616005)(26005)(5660300002)(8676002)(8936002)(4326008)(6512007)(6486002)(6506007)(44832011)(83380400001)(107886003)(2906002)(41300700001)(66476007)(66556008)(66946007)(6916009)(316002)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E8WaZi1YD255yobH8/oDZ5GgbtAnCulLXPIc02RKt/Ec+ocS4Vwqa3hT9vEK?=
 =?us-ascii?Q?GIiEawrWBCOLEsBcuEdFcKVmOzD6/PkJGuKQSJ+bTvHPyDGgB2Cm0EM9ytbu?=
 =?us-ascii?Q?UR1GbQ8Vta4puOkFqnvxWd5ialOHuRppO2HEZGFn/LDjE4ztG81SKuhfmfg/?=
 =?us-ascii?Q?K9OWlzCR/E3YYJlQylX2+XMABwuE9SZz2eNkpETqlP0Tk1IF1HI7y4g9zm/w?=
 =?us-ascii?Q?vHn26jRGxxX5gHWqrOsVqwYehWgAXkf7Hv+yR2DTj3hhMMz4u4Mq7ygCSbNT?=
 =?us-ascii?Q?HEbmT4hmkg5r0tWVr2M1dds/Mib//+ax5RrT7MsRdl0AifD1MFfUh13jYb5W?=
 =?us-ascii?Q?YrrmmqeZ5huvnoxnLlvp8FL4iFqqSt9XCHUmtm/szYsXA0Zqh0NzN3ONzidH?=
 =?us-ascii?Q?3xqpxZs9qUHyo3nwrqFV6vS7n6ia5ElnXqIg+8bvJ9flgNohjRxv01SblJR/?=
 =?us-ascii?Q?5uGTr2BtdSKCqwBf8OY4x83mli70RLJmKXWuD8zx9cdvB/hr7/LTvzwxtMtq?=
 =?us-ascii?Q?1tuer/jhVqWtQzYPS1R+tXML3I7rUosd1DpGpTrcH509MzVyjdrRUnDT3a8z?=
 =?us-ascii?Q?nxXJq0RPc2VXmqF/98jXOOzNM6XJU5qpI5Z7pRrRieae9EVWyi3dalYA4tZF?=
 =?us-ascii?Q?VxzwEykw/0ihdgc4IHvi7l8PJL9pNBHxJrod/G0W1WJYYtjEN5ZNWlYT48Io?=
 =?us-ascii?Q?IgShkrkQEkC3kstKYtPGDgp+4v2c6KFUeh0ULzQ4qcWObZ8m1QtooW5NcbcN?=
 =?us-ascii?Q?AK2yVzcBTJvmZihL1BaD+ByB+cBNGZEqo8xQswtCkObv+ty7wpMqUVnijFT0?=
 =?us-ascii?Q?gSQtFi90zuOPjMnBwFTZdqp9RBMmhHGR4c17eUBByc/mh0ZLtiuzuSkiMJBG?=
 =?us-ascii?Q?/dHfMRBJIkQzX2r9kPlK8t9JwBB6H5zjbK8tQTczqyiOSKA4zyYvl+fV797a?=
 =?us-ascii?Q?q1uU2u5ohoN7OFxY3EHWP6OdneO/H13wdMzZFbbjeHPU9z3GL/M6BtscQdJE?=
 =?us-ascii?Q?23VlE2RdSfquawwLG9yq8qZFQvRee5hfxbucXZaOZrXxVSnHDWY7uJquLbEw?=
 =?us-ascii?Q?A6VeuAPAdlaNvxww6d2LiGsTWKApJKTx3VDY3wkaDV8gyPJbHZVEiYACqSRg?=
 =?us-ascii?Q?Nq4LKmiQsmhFQ14z45tVyEmApRkGZkltyRx/dh0KP2zUdosjWlA7AlcFs+Sz?=
 =?us-ascii?Q?uW/8dzb1+F+HeZljAu6HtKttPnBfiDanWe5HE10r3SA/G+QCoqFGj2Sx5yD5?=
 =?us-ascii?Q?QX2hcy+3fARoWWBmIfHCf99GQ1dZXrbkaBa50eBmBQY4M63yeNVJhTOWw1n5?=
 =?us-ascii?Q?bEAx1NBStB9KjZJsBFy6M+VyiVK8w6lm3zUDYr0rSH5e2xA+dJaQqvHXvG5H?=
 =?us-ascii?Q?bUFXhgkJCgB3Yt1+jUpNjoE2PEMF0jZcpQObezmGiTEcKoM+3Hx0j/ca3imF?=
 =?us-ascii?Q?6ryp/T80deWwpy7IQhqmM9Mej3k1unNMXIxG0oz1PG0Ubr0NnynlA/vFellx?=
 =?us-ascii?Q?+2+3775KCMF6awGS6YG9nWSsnvyd0ufZ6sPBU0AESx3QJL5/q7F8Z78cy0NJ?=
 =?us-ascii?Q?aN6UQpOh51t0q8zLQXaoQm+k11zxcqbEU2GwY0um?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0512f4a8-0382-4cce-3456-08dbc7e8fdcf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 10:26:10.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJeVWBhXZhfR4VZnFYsVdbOXL1u74E8qrsrss8Zi0AL39qMNB6bRyHM+vNBKOwgdEtxsN6Zj6V3ms04R7EXcBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7222

This patch adds a selftest for userpsace PM to remove the initial
subflow. Use userspace_pm_add_sf() to add a subflow, and pass initial
ip address to userspace_pm_rm_sf() to remove the initial subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ae38b428e42e..ce691aeca99e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3490,6 +3490,27 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove initial subflow
+	if reset_with_events "userspace pm remove initial subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		userspace_pm_rm_sf $ns2 10.0.1.2
+		chk_rm_nr 0 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

