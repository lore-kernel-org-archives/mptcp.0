Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82EC16419
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="mcnOGlSY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anqV+WoZmjMs6Rwsde/nKyiMoiHJhoSFprrZaYGi02KlYPQ70pOS+3j1DW+pX/QW0viZK31WNqLpcI1ptbNkt5hYRSe22EWb1N2XQQgOQx8x6kMAnDpUamLjsJeI5TVpEcIoC/mn/oEvovNCOeN6YfkyuduZCCrKaQRsSoXbjXf/VxUWpoyO9dxNxtuifUfabBlbxMDHIgXE9oPCpzW6MrYTinXQ5j+7yJKRzs3LcPzy4Uei13LpFHGBgn3GTU+H0LEA9nfEzayFnBGaW4StmAjQxXLvoDzbpvHMk9s85mrNPJLCdS7LzKcrWDepIeAKJ1rMT3x3safUFuZQKbl9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipdnI2uBLsjosa7u4VSosK/fSVVG3D9LR74DLfEieIM=;
 b=li25+m+SQDSxHHNrvKGyccinSxMxmJpLZiRhdYfQYdKOctmRBYvxJ8MeGPixepfKuITJ6MMJx+WnsgEm8A9SkLLYJx8XuL3nHAV0+4N6ofUti46QM3coaAe+Np+JXi7ayAWDpei3+A9bzvSiSFv0rRZYJWs+AaOQ1W6IKExjaaNLiHMTnnY/6eYaRlx8AMQ3/LvelAAufvSllf+p9xMBiRsGMK89Y8YPYSMAxCAMZVq2Z//z40fROTQG8IhOzPSuoAwjGp06HWHhYMqFuk/a/Ouwzc0FxAWVyJ0YIkVd0XONNB9iJvp9QJloKeFILa7bm+gBYgHX5y6Z5qc01FFi0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipdnI2uBLsjosa7u4VSosK/fSVVG3D9LR74DLfEieIM=;
 b=mcnOGlSYyAORZknoETkPzB3P5yWSqaMDBN5id/FugyHxhYWiplP9yAYJw6cyiyUJ3nUYDrxKs+9qxkPWULDkfrBXBE4TnR8y2VjpaxVNnoMenOrlRa9iyYAoHFQ4pNHzw5lNbxzp3luMNEDMBsORDNhIGZJMhZWN0Z6srR2wmrYaqRlKprhsqJyiiVxP49Xkc0uvYUI8+80lMxCIZO428uNNtZgp+eRD9RAJ2OPP0VdchusOojewU775U2r1tG+Hz+CcOuykLsmGBvSbGkkFuRHxUxpMnJRqKunvoG+weAYbGtKWzaEQHQtK5uXPMGOk50ysVdvlGoQ3DKUwQMbvKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:30:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:30:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 15/27] selftests: mptcp: dump after creating id 0 subflow
Date: Sat, 18 Nov 2023 22:28:30 +0800
Message-Id: <f499849efb64d2dd8978b0af37a19cc5e5f6c717.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0140.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f241859-0ad9-42fb-5310-08dbe842fa7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4wh+goZSQXrBt1g2ia/XbbgLPEhY53hGTsrTEYq4HE4lWTsjXIkYm1ijBDZY0o+Neky+nc0IGJczKqQwRJ44+RNv1HeBSwoq6JLAS55U4uMqbB+GTRQp5+xqjSGtt8ErNyPzYkHvLD+ZoJd8cEYorljxIUEzj0I98Tm97KBNpx08YZz9NZaSvlN7ht1ywdVf+8rvbpYnkVrl2yX7gNK42JiriLsPjiADYyb8d/+cHMofdOhS8wat7ID5BGF92rdNgVlE7XZwqLFRHKLz7cFS5X6gVMe+0zZai+EZwAYDizr88u412zodW5ryUAKD6dmyo5+mFitrWGQZ/HVOCH2i+5ZgCqFECExZt8dJg72pigM54HbDJKcxI5CIN4AhMJskr2yJ9IWDShdmEUpjQf7inxNHpSY7skWIZ5ACTdkWBwEsTOA8OYzFZYBpYGxWSqQqq1HiQ7KM+SVHQScWvvNZahJV2TSTl47x1cTxWYjLaIi1wJ+Y3GhAcjjnynnUsM6mdycXySZukpWCQcTdCi2cObjuU/T0Zh6ryDs7xD1kl7PsNL/ZTsZRFZSCfi2vJqfDfIqdASYbnPgpWZwTAIINAvdTVW6dtNw0dT8KHO6PO0E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(4744005)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1UwNQc3rzbjr5tID+z8I3t48AE/RknaN0PqEZbkz6+gIXxK43UOD9Hc3o47K?=
 =?us-ascii?Q?qKkhM5FGiBEfL58GmECe5BvaJp/SmSXN1upQgfX5pE3yuDvAFHnsEm5Nh34r?=
 =?us-ascii?Q?AC24+C8/Ju9eRiRMyTbOrTkaO4BABGBsLgOQp9ok37S9hvUEX9yRTFnGUm7H?=
 =?us-ascii?Q?Fr30o47e8qLsC5yiNsWpxIeAgn+ZBdPjgfo6WPhi5mTUsX0jXQuHLFZVoIYQ?=
 =?us-ascii?Q?pXDKhZF1vl+Ogh//Z9768hgJ7EVYfr85LedGzZzT2A8Xiz6kzlpkDD00JRGC?=
 =?us-ascii?Q?pCSYO+H/32ym3xEBdAesZCvU50p+/pYh9zG9v/ipiNuS1n0ge3U/YlzLAxxr?=
 =?us-ascii?Q?EL2+bRdCYwcwxD3ZumEgp+JVEoEOpRsuuTT0GVAF56sE8hMnmgPwYF68UGpY?=
 =?us-ascii?Q?j9qzxhq+tnmXND77OHL8Vt1z0+k+Mm9m45FXFxhucMl5Sul5JLiAiTUHnC3M?=
 =?us-ascii?Q?lDRaKvuYkK7KJY7bchFzeFmxHYKVm22dzP24WKoKRwJ4od9coVpT2SGnDYE8?=
 =?us-ascii?Q?OFB49vf6OBZbW9wJ0cdCJaHG1nNeT3xrdi2jaeVFK5cNBFad0SkCJG3mhHrL?=
 =?us-ascii?Q?+n0KDci5sX+EqZox8NonZtFk9/ojMDuXHs8htDSkJnUAPDYCQlTHAQ3N2FpS?=
 =?us-ascii?Q?EG7ndDpIqBmugLAv0dw1JHco6USwnKnhqBiwHObm4LviHdxfQkeqijIxakK5?=
 =?us-ascii?Q?dgmojWphCcqdoFQrxQHQccfDr1Ymdfj+bEl98iU6US0CseA4EW0obWhnBYqa?=
 =?us-ascii?Q?ei9WUU+CLzhVS7dzRzOV+3fXKaDhoj/SFBAEd988cIxOHhAirf5Uh38uqhaK?=
 =?us-ascii?Q?3F3vn51b0u6EfCUdaoUta9J3pbXYKa91ef67KFVz9vqWAZvp3gDOGbVxkbA4?=
 =?us-ascii?Q?5XYj63lHOrka5JEPJdHMgZctdBGbQcoUUBHBiLEo+3fx4mCzK5XBy5hC5JTY?=
 =?us-ascii?Q?gzZO8u9KlbaOf0arrgKAekdGHAkStLkBykkWCK7fvwOA05TpaLX4wwIZUTU6?=
 =?us-ascii?Q?LUVFNOfHn43+xKQOcE3VEVlL9XTusytlDSZ0F/eFHz6HL6bZyk5wCwVGRFhV?=
 =?us-ascii?Q?voLklmHgXQW03qtDl0IdQ/t5VmNPc6HsRd2gAvwsnAQAYy2/lkiLmZSfypOq?=
 =?us-ascii?Q?+HRcvvPfBiNytHopbRAScx4y5MbXvET4YrbEsyDOwmgknOq1888GJVbYvq5k?=
 =?us-ascii?Q?dn9Ju791yxmcUN6JFo7itO46fsRi5DjIS0r1PjjhpbV83dS2FIhEdNI9fMCL?=
 =?us-ascii?Q?qEa3xJAOWtEs7KLhnJ8u9/FDqHr8p0px+WlDoUs81wNzWIgRaTVLX3dAV6mP?=
 =?us-ascii?Q?XxSksWUCOsOOHZWEROpZeTOCgRQA46CpxDqRogKq4SgYy7nZgCtz4HOWRBqJ?=
 =?us-ascii?Q?4TUqadnwqeKX0x2ruOwDYcaXtrGZwJIwM89zBDrH6rsnlZ99E6zAylflwyiL?=
 =?us-ascii?Q?h2rjkGOBnmC48lcXBtsttY4+GRHGxZ+XBkGmYIMIqLJEU/6BTxJJbjUAZ5/O?=
 =?us-ascii?Q?kE0SO4NIonqn93vTNQC2O+MqofdyM++DqE1bSWwWE8/andeus6h8FLxBU3Xc?=
 =?us-ascii?Q?kAEE6WIR7hwo2x/uT4XDAagyeXAg4NF+ERtqcIiWg0kKbhDLXDT9dU40WtNO?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f241859-0ad9-42fb-5310-08dbe842fa7d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:30:57.2303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGIqgcebJNSbGfinrLZ1g4LjwoXeOH4KhJC7cBqraFkpQpTsq286UimBl6MYmEk9ljLiEsSlDfXkpBIXZleizA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

The output of dump command after creating a ID 0 subflow should be
empty. Since ID 0 address doesn't list by dump command. This patch
uses mptcp_lib_check() helper to check whether the output is empty
in "userspace pm create id 0 subflow" test.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 56a795a7f538..3281cd321854 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3455,6 +3455,8 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		userspace_pm_add_sf $ns2 10.0.3.2 0
+		mptcp_lib_check "ip netns exec $ns2 ./pm_nl_ctl dump" \
+				"" "      dump addrs"
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-- 
2.35.3

