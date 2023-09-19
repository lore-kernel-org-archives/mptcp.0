Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2058.outbound.protection.outlook.com [40.107.105.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEC831A74
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzrM/xBFe8cRExuvyHhCrxOyv1AT3HgZobZSxv2Nklx2EhrvJ0910BONzAuqVTOxBzLoCfcXgMmr8RAlGlKBOextaA1bppQ4hsXcoqsedHFOMXe7ZU8UqeHwveOlvI+EOidKoL45stHJhvk3CGBNYTZaJ95O2iN2LZg550f5gulnCuj7WPtth5Y1eZRTmY3Mr2WrtMDKYzwHe4cIqbF6xJECBr8NztON1gUkhAgKz4qZp7zegSB9hqWJstfGLHU3JTJMNB4rkQSKh8MUrM/3VS9x2UgUslAIGwCfQto5Ad1iDv3jRbnWqz/SmZo4NK6O6XMFG5acGyjU4DU022vRcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3/Thb9MfRuKOX6+LCvr/Dd4cn72+PR9JNmDkwAOZbE=;
 b=JdSX0sbX9U2dGl1SwTzJNZkoSfdg/hmyaQMq4GvPXLQS7cg00GU2OQ1V0HTFvzdXFC8S92pf15yDWw8oajUq0dZhLZHvlxv71yX9N8QJZCPeL/Ke+Tm9byptaz90/Tud4G2DreAqc+1+4gl7iG+KiN/fqxRoQCJ0hZVIKUYKYC+lGS0FsOZvqix6WLOvd1nHT7RqeD/R47kITZvUUsdjlJWWyRvh3lSr/w9fuHo85S7qcSsHumsIv3V+2BW4xhI7zgurkzsUNrxjyKbeTm5HtnZ9irIbVuMwkj22Bev6MFbaKTn6GyATL42+p2mmrYDH1wUibvV952N4BuV5dzPzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3/Thb9MfRuKOX6+LCvr/Dd4cn72+PR9JNmDkwAOZbE=;
 b=gX0XJoYJlJrWxJvqsUN5w9N7zGr7WwNPqjZxhN0pgSEgk0jS/Q/8TKb16wnH44iGXvxx8dEBGMfaMDN71AeVcdSpHPbELh1jsdylkKNP1V5ewI8eC/BR5eqQ/iw/XEMuQHYzasIolnv0/hjyslh+s2fJzE7dPPVxrTRJOyjo+oV2TIdiSUEDv2AV2R3jvpto7t6PJ4RbPxPmSze+q1EKHZKUNUh2xK2WhYK1fFzm9H59mUPwei/s8SSMHafwib+eQN86vY96F5t5iLnKEErb4C94f9C2W5u+N+39TrPKGOpL2o9Cq3xqjyPV4tzDQG9L2vmf6F6QmBGO/kKHOtx0yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:04:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:04:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 17/30] selftests: mptcp: userspace pm remove id 0 address
Date: Tue, 19 Sep 2023 12:02:18 +0800
Message-Id: <93a7a0abbe9eff32cadd01f32333b6316d545b86.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0275.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ed64e8-d32e-48b7-96ef-08dbb8c57f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SbhUWRobphx2ZhsH96iaGIRGOH3+ANMB8AWc3G1XqQ5uiIgmhDnQzXQFo74Nm9ue5J4iiPR4bVOgGWpjiVfpzOjWTK3JYvkwzRSsYhsyQVEBEG0UzIgew99mf4eWPI9RjnjiFbTPOWnnBe9OuOkvqX1MHbYn1oZ2I4jtS1b0/ahawtXiM9fNCi7SOhiglEHZBaZQrR0Vt+nSSA/PPELmKzuevuC05tTrVndKUN6rGKk1PB6VpU+BcO6sYxn4Zt1ybGNdblKCWOINoL7DvE+lpnc0xSTbsOXyrhfaUZI8yRvTMASoH5XnUtWCuoIH35Enn86HFi0LN6jvibAPvKGHssORgRCDXIBG1gPNIDni45k2ajnrvCvIGN4hi5O8b3GUs4ifppcIvK/Y+Kt6zGUtTfWetrJQmfSmPE9AkNaCdFgbUmd25XoA2jF8UQ7mmjZxd7vv/5AT8LAu959qv5MpTLR3w1t76hD0g+Y8xBRnjthqYhf6i81uoXnet8OsBb+tnthjyE37BlhCrWvEBdpe3tiOrk45biCzmVKVH34ixugaq63Akfc3jG4HnI5lqGr5X4SgXSKYuxlMF3m/BB+fTJ9Ziw0ddoyi57T0uSaVwvA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(2906002)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(86362001)(26005)(478600001)(44832011)(5660300002)(107886003)(8676002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mdpiBJm4uoUhvvlIKdYhwx+KpWYY0OmSkp76D/J8F3OudcIQPvi9GhOpDWUz?=
 =?us-ascii?Q?oNVmHXQ5oe3d44jVjvLQLcIoYYifS3aoQnAGBWVSqzvfk0TGXU5nRkDGI/7W?=
 =?us-ascii?Q?SqfsMMIE94zepw3TNufRowSDVvCEcvxaLdAzNUz/EsIq37NEW+oQIZxH/i9u?=
 =?us-ascii?Q?o0Fy7n5lXtUSgXo/oc4olQqYEPQByUvKPt625HE+APyqYXPUGN07V2nlF3ue?=
 =?us-ascii?Q?g93FQF3UFwRf3M+Okz+Fav7HOEdvBFXp4w0JGhGln/yfSmsoe5SYToVyRsBJ?=
 =?us-ascii?Q?Mp1sgdPEZYtMM5WEjm6W+FMorTigERFyo3tj6vv7l8qtygqcLg5ZeXtIhG2H?=
 =?us-ascii?Q?y7ie/alPWsdPDMgtu/Uxhr2fOKoJ9djZ1ea/Ef1RRoqNb5I8KlSSx8FBIYpp?=
 =?us-ascii?Q?UuAb56z4LH0O7lYTVpiHsWUKcKWFe7guh8zjY6Agy6TADO0hQ6DZknXmFYme?=
 =?us-ascii?Q?NAhjTHWpqkL3FYSTMp2u9y5M3jS2fF9x3hGg/fHdBm9psHNUFoOuqneSlH6r?=
 =?us-ascii?Q?hi8aXla4B+XRnRpuWoe3EY07OZTA60tKNzCb4Fib03gEf2iXePuqRncYxmvE?=
 =?us-ascii?Q?IObg1H2QSicbJlFlMahUhQokozpKcMv5w7MSlP5NlFar8pQ/c3lfsZPevF+q?=
 =?us-ascii?Q?coTNopgp1z7YDQghSxCSd7qYzUs5e4awBmEcNMqwzjY/5RIwUNsoprWG6zdL?=
 =?us-ascii?Q?oCBIC7RlewbaPNa7ciUdrD8aziSoScdMhPQU3jf7yKzxSVLtePgeZI3jxkdG?=
 =?us-ascii?Q?L+r3m14PYJkiIF2CJshgrLprR0RzKpJcaps+2iu2+U8WKhVIXJCDa6z8LUyd?=
 =?us-ascii?Q?VajPk0LrXRRjK0ExcF3xeg+F3ZHr7hVtboSqFXDnD5xyNrLAfdi+/Q+JMlss?=
 =?us-ascii?Q?G5QtWRlRc54daEMGPdx8OS2x+IqWjYjAVQQIlw64Frbz31Xh1xbz+9Gm4YUK?=
 =?us-ascii?Q?FLOYLpklnT1aFrlBZ2bGUHs66xcV9wrwOpaw6W5zIfJBs59WKSBKmdaE2XyK?=
 =?us-ascii?Q?aV3P3ntUgYsbN5PjDrFm4nEm0fOBffYC0++JYwpgjT6wjnUgOW0AqqheaDcO?=
 =?us-ascii?Q?f7x5PTL0uxwkMwUP73ZiAwcTmLyvoJH5eHLJsiAZ1bJ1nQW7gTss/OWq31yo?=
 =?us-ascii?Q?etnLGt9kpTTOfEYAZWEb9xe8xZLJWChFCtVENFGA1U95ntqOYjNrIO+TKJwW?=
 =?us-ascii?Q?+gztopiT4iqaIWfr/OeK5I3b/c11ziGCeIAn09znmdQkZIJNWCYE22sQzgPa?=
 =?us-ascii?Q?22Xnoy3eyeCv1lPn22dxHnCiAEDotUaaO6WLdX7O+seDvTvguQKnI2x7bKZX?=
 =?us-ascii?Q?qUoFGUqoQjOqUO/slFpb0m/kKFa6u8CdjHuA1vvNUDpwGmfVposbccWajfsy?=
 =?us-ascii?Q?f3sABZApf4g/WZtlY7/6wAlU0F5hcIU5Nf1UoaBu5PKRc5QkDDuxbrLKC6sr?=
 =?us-ascii?Q?ktp2QGpD1a7OQcu4F19uUhP0J4j6AbXSIQiN607Xjl3L13FJ5V/QbSI6ZpqP?=
 =?us-ascii?Q?zfrb8B/Iim0Ynjsm54IPWY96ciZLpfN5lHMz1klRT9aAx1GWf44S+O+xLdyo?=
 =?us-ascii?Q?/K6jK6aLwZ0a6KumeIBUcqGcQFfn68D4CwFNCcHw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ed64e8-d32e-48b7-96ef-08dbb8c57f27
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:04:18.5542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFSbe9Zxj/ebiiWxETbW2T5cxmid5cfYOVU2MGbAAKjZjKlHlUJkIjYrfdwADripw1D0r3+zQKW/8Fs1r1VXkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

This patch adds a selftest for userpsace PM to remove id 0 address.
Use userspace_pm_add_addr() helper to add a id 10 address, then use
userspace_pm_rm_addr() helper to remove id 0 address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 22aa69db87ab..aac50ef86785 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3508,6 +3508,30 @@ userspace_tests()
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
+		chk_subflows_total 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		userspace_pm_rm_addr $ns1 0
+		chk_rm_nr 1 0 invert
+		chk_rst_nr 1 1 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

