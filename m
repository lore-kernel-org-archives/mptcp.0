Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DDA28E11
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 14:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBaxAu5a3NP/radUH+TmR87dEfPao7ssYu0JUco8EbDtHlhHvaQvA3EocpQnplgqT2MZBnY0VvSPKbjVqH+45GX+cPoTNglyrXqmUMGCoOOEdVaoRCF867ruyXe4cFMhlyPv+KealsaPEP11SFHodKFQYK3j7qlA7XhLLH45eJmhNPVpAFwl705m49cJMGgjy9ydHap/lpCzxx/wzz2T4iSEisRzI8nvNUwSOqTBhLLKbvFCkEyh9Mm0dlaXSeRoVqX3uFMOXniEmb8y1WHg7rexH4bZ9j2Z/3h0I8lc1UFtugs+ScPR/iM9zeF8wwvMIfZLFtnLStFhbid79VP3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEFvBed1NxlxmtnOcLa6gxnZzGjBF4L31D98DBCJhfc=;
 b=S1WhlguMLejxBdv+tt67y+yrzsNtTWi+tQNCafitcS/VaegCddmlQZBUrJLC/EDs64Te8LgCe1h4mHLcBuVpjQKid7oYGLkXaisk3SlyN6Rz+rEpZWB0wVQ5IS/fDfL112KOrCOj16ZIEc5wFtos3xpmvE3sHh+GrXEd8eXvSP64qBqhnnFnjP8NPgThQMT0G+BJHeeVMpqMFrH2IQ5cUwOi5gj4Mqdla0sFFpCjLMdyw6rSSRdvmE1gYKYAJhPei7j2my0aFn+h5Ns7A069Hmbi89QA3UkenGN4rl2lShjykK/o49Z2fiMK1igpWIu2F7jVCazgX26MX1SHV0v2LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEFvBed1NxlxmtnOcLa6gxnZzGjBF4L31D98DBCJhfc=;
 b=XnVKXvYE7+NR0bJrvtDd7H4K+wKnRNOqMpBQTKpX+1N5O7dk1iOKAbOnoAV30P7sfeTGNFQUuixJkrJDkHpNkO5z7ZKMGEqqu35C2HWF/YGSD9ENL9agSF8qZEwhM+eXA52Ycl8kACz2BXaPIjCznhvcsQ70lqA01gerHz6tXOuun2LoNf0+xTbMendBUSbi4Sbxvci/5NcZ74126JTCaNrbexGkfInvpi6sia3tfPoB9K+suDTC4I9U8bWgkDLU2YyS8XO4rRTeMIOY3SJI4WBqTL4h8deM7LfA2FQDV3tKVZK1T5As0jOiXWFMlz6YTntfA3CtuTG0+kCvhNeSZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7757.eurprd04.prod.outlook.com (2603:10a6:102:b8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 14:50:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 14:50:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 8/9] selftests: mptcp: userspace pm remove id 0 address
Date: Thu, 14 Sep 2023 22:50:23 +0800
Message-Id: <83a8279370374ba9909123a07c571b624d50d44c.1694702984.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694702984.git.geliang.tang@suse.com>
References: <cover.1694702984.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c837db-075b-44ca-08ce-08dbb531fe70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dx4Rm22pdwhTAcYI06Yq/QRAS2q6QafXlKJOnHJGLUOdckmHdYCIJCnOPIyhnE7pvzokKFSwVD6cU5knaNN6thCusYM3EWxpve3qLW9vY3itmLSV2dEpr9eYoZCbeufHvDz899qeIIgjcZg8o6jSNLp54/XQniqNLAHSQ65DOsP9xnZEpPXPEQMlXP7ZzZGgz+z0Fr38614z8TxyEH0goZGgJ1R+dHZnQ25rXh28lor0VXRi8jwyNLo6b9tKh8YLtRqTF21hqIfQtWQ4kusKI5Pnnvxabvd3yzufJCHzelMn3VQEpEiMnZParagyCky19G2lYoYm74x5UgMZtT2NuOtgiFoXhuIbUzqPnZtOJjHUkg2CftbMPVkcX+GauuNLH0FSFgnGsQQky3CdXFCir6KRUXSTogUUFG9Ef56jHWanFcWUV5tWv9URyMboUBRP8Sr8FSmlqYhZe9SAmHCsgJaRFBkT1pe6O8alu00QeSi0VmBJjQ9PizKxxJxAGIY8WuzVyyEm6h08+3iEPQWnvBjVjKY/mWou56eAF7144uGnyPgKwj52a1FH63mGG7koYe+j31f8UzoMwXYOv+JQIwdIrLXi2HZMT/KJYCjtqg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(1800799009)(451199024)(186009)(83380400001)(26005)(107886003)(2616005)(66946007)(316002)(66556008)(6916009)(66476007)(44832011)(8936002)(4326008)(41300700001)(5660300002)(6666004)(6512007)(6486002)(6506007)(8676002)(478600001)(2906002)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2h6VpxPTiLVi9zaKm+bHyiqVayKoPXwNp/xsabeLYs/bZCkVTyJrWCaBaKCV?=
 =?us-ascii?Q?lFiK/OogdF2gz5wmHcKznBY1k6OfnMcJ5xuhh5UXG3USEXJjRCFx2G8ft8uL?=
 =?us-ascii?Q?mfoyi18zO39hs21LtFyrpWIgjbACS5+mQdTvpnFPG/5sEktdFeUKhnBHmGXX?=
 =?us-ascii?Q?WOb7vgsSQm4xFTn2rLfJEaf9wXS3wd9OfQf+RG1RSPpdgIi8Ez7EMXOgTVmX?=
 =?us-ascii?Q?nqhwUKCfur7qOiuNotFLWJ8Wsz4VEZ8wwWKnB4WBa208ZejU3cC2iu9yngnC?=
 =?us-ascii?Q?3aOi5pQ++ea30Dn3zkcAWYBKiDkTS52FpWs6nlg/M3pFMw3eJp8l/Usmn0kM?=
 =?us-ascii?Q?D40XwA+RJ4c0PyOzUJIsW+0lgu76PCqZJeid3gST1sBOL+0Pvry3XUfZv6az?=
 =?us-ascii?Q?ObC2E+P5p5WJAX9Bg0ZfZ7HBxw6593Fk0z7jaoKVTWzb3NmU7txB1/VM332j?=
 =?us-ascii?Q?EOumExBxuTPhbMQY34rXfuyOzEwqeQIxMcGS2PIsDaBPqE6mnv2+3MRr7mgd?=
 =?us-ascii?Q?n2PIrnWBuLsaC6nJApShKAGIV9FIXHU6gKDQJjQKaChiZjpE5A05dJRr30P3?=
 =?us-ascii?Q?Pw+haq8rYwkPuBCg+vwVwUqSwgG1TEfCcetBqDKwgUUc0MwUQDzV8C6P4gAU?=
 =?us-ascii?Q?Onyyf4nxxwQ23H3UrWJwCzcW074F4ATXdKfi6vugS8RfHZoyQarGfAaVNH8S?=
 =?us-ascii?Q?kPoy16yAlQxfi1AZbMXcKzACgG8z+GnZFr4RG57oXDPePDu4G2OufL03uyOD?=
 =?us-ascii?Q?4G+cVFT2KQkHy1HHeuuwDXuJRQJkQSV1b+9wl8cHE0SUEzAQpurmUSdrRuKY?=
 =?us-ascii?Q?g4MR53j+W3SnkunlkZBgP+Ry/sikTtm2QyLRt1hmQM7xigyasyIQSBXSquCb?=
 =?us-ascii?Q?Y3jKXUexhOEPLGzRZSd/5MFk5RrGtNdVt44DKnAv1/XmQ4VIc3313BWkrolK?=
 =?us-ascii?Q?q6khkJzyIXnIgzsCoZnvmVz5+HBWQN1HAw4Hp8UW9KvSgk2Ly7lWZILIHM1B?=
 =?us-ascii?Q?KiYVDdHdY9ZCdUPW4BJDWKwClau8qhq5s7heKUt6YQaiCwWVmRaPzy7bdABS?=
 =?us-ascii?Q?s/53nV2fR/+BmtNOXmQlDml86AzxLmgKqi4pATmT6vozYeS+2js4Sf7ugqEP?=
 =?us-ascii?Q?X0OU/tS9xAQCJ9gvvYml+g28zAjn54e2Pp85I1IVpA8X+qQHha+IdIo/NU3d?=
 =?us-ascii?Q?uM6D7P8lI1ZwsUXZvC//f8D9ytAjmoLDx0nvanUHRhI6kv/6R8WJGH8iiu5d?=
 =?us-ascii?Q?LMBCS8KBipgnhSGPw437JhzLea6v8bBvAYn9T2mplcfFJ2oKmL/6GpeMgP+j?=
 =?us-ascii?Q?jEQJSKKidBVe51WbhJjM0+fj55egqhW1rD4LQSef0fYnxtoKiTmdMKAwiPAi?=
 =?us-ascii?Q?shN/VoJGcpT3K8RCgMyqR39mPvTkNEH9YRYuB4HGvUdFGnrGzFaSDKLLfzpY?=
 =?us-ascii?Q?HNzaHHhTGBN2C97BQrdZoggkyuUTqBxEVErBB6Jm7eh73opNXGY2LqQ/rjcY?=
 =?us-ascii?Q?oc4NenEOgu4tMdD1uDhNs3G1YAmTw5dK+mkBTT93nkRQPNsVaPx4KlfvwdmX?=
 =?us-ascii?Q?T3467RfiXB3Abm/bjxB+03htuUyeMgP4Obd7k52nqRaj1/OrMcReFZhvwMYD?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c837db-075b-44ca-08ce-08dbb531fe70
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:50:53.3310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s60+R0rY/jmsT5JwCCEclScPLg5tRb1eBVQj9DEaaDbEQ0tNp87WXEmvYM4sGFjdGscJEs1m2Am2ddR9m3bkhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7757

This patch adds a selftest for userpsace PM to remove id 0 address.
Use userspace_pm_add_addr() helper to add a id 10 address, then use
userspace_pm_rm_addr() helper to remove id 0 address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f1a7e04815b1..19a6859bd207 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3496,6 +3496,30 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove id 0 address
+	if reset_with_events "userspace pm remove id 0 address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 1 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		userspace_pm_rm_addr $ns1 0
+		chk_rm_nr 1 0 invert
+		chk_rst_nr 1 1 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

