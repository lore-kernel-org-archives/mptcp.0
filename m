Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C8E8475
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GRgUksOB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGcnMaEpVSLFaFmCpUjn+O8fqHp5//lsNWZBurZdDLK3U1fG9a38SyzziSKEIZzyH2WDGKbnkHyYzwW9aLaJ5SCQEjDWSZakxrobmlpRBDivwiyliEZfzcUcxHrULr5x/iS7b/9RoBtbvXvuJJxBjueMxrqbO5Hv6KrYL+a7rdeCiK2Mn2s2ITiPKrjQ26tbzF97UNEZ8BznkcBofmOy4sG+mQ90t99tjhzgMiqFOmLS8fuI9OLnH+6Etx3yNV1cXin4v0dTLTDq8uSGQlsdvMpKIPoTTclHkuqDykJ6w2tFEw4LXDUyRBgfhIgiHTAjYLpgK4VNMxExqvFpi6bf1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIBuATYPnJu85N4OTa2NUQqHL7wVCpPGr6WYqxEHq0E=;
 b=MPCT545bKU5q+KAQDLu66OwVqmsi5VqMM49+aMZjcLpmwfBFVrW3F/0/9O5SiuiKIV9BXA4l/qwiy6U68mAzr7nVZwbLgUOkkLeXS7RqZcpUGuh4LmEAxxOIUrJcfz6/FIhoUymGYifwG8Pd6A0mWXYaJ5Tc5DNazWHJFnuHrj1sJMkqrVIcBW7pqCfdTL++pNHWaPdTz166XVBcSgPQEXJmyJER6xstFdmY46FZTq4ZE56ygOTGyXK1v/zOGPCIjgt7fW80kArLcpdA7ez5jelGCjrlvwVOH5LzobsvANkuNvDQ75tYSI3euHhow0zGVmrLBf0+kXiEJ45IZSfsXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIBuATYPnJu85N4OTa2NUQqHL7wVCpPGr6WYqxEHq0E=;
 b=GRgUksOB+b+KGBdaveq3f6KhzAyXCzD3LU2srlz/7cApjgJUrbwNySbXsKI4pAT9gxPAcECx4YpLmm8zQKgp/6nksvmoowaH297R0Oh84/gn3CRm/fQsArMMS+5YRbwh/1/TWqo57mmXoeLu+JhGk5RGYsnGZCC06gD6Zry5cE72+N+LQIKyHffpmZUrELt1+K0GUCv3n8X8cSS22wj7UAcQ3y2UH2QESONnZgEguHOAr0e/3BZw45W+aHyYIXeb5Y7bnbAAhfl4ietNYa/bSMzZriiRThX3ad6NpxCvcsoz3Rmvs7Ly/cv8irCrPAoScsjzSVH7OeX3WIyV8PCt4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10038.eurprd04.prod.outlook.com (2603:10a6:10:4db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 02:50:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:50:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 12/22] selftests: mptcp: dump userspace addrs list
Date: Mon, 13 Nov 2023 10:48:56 +0800
Message-Id: <c9973a7a1335c66ee1706ee8f2829813168b2665.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10038:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ebdf80-e87e-4072-c450-08dbe3f33e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xOIpVAN18oXojU9x6FuwPdYzLycRQmQZjsiA6cjbzm2/WuOG7+oEVlC4yaia4A2bysV4/R6OmjDzB0RWfi6XjeeneRga/np0KHOv4ivLnWnhjXE5qDU6fCIoRVvx0Zn2GY78EYDMeEcG4kXkMU7ErNQ3nrS6Gk2SfOfVVz6ja9PV9toaR/ii0lig/TUDsj51d1vvOzl2JeTS5YRMDCSyBbvIda+WJpJ5nsXpu/ikCihpNzfhReSD9U1teKxl8rA7UaILCwXc85+fb0seNlEX48FcvwRlRyNCttNpIBvh09pNv2QBO9WgsCWXOEopxrpmNz+NrO/nJ323v4nctQRg2FHcaTH9ehklxUwK3aFE9ellN4qnrQ9DTYqCqv6DsCz3holko2Pr+SoXCb6fxX4ufodRFk86MkyInk4j36ryazqZjts5n+xe9GT4H89pUqq2+SrkyQZV17ibQKdquT9hpd6FRU7WWy9ygEFtRCkKeLIV3Wt2lMZ6ztwzPbkAYnf3HOfBShsBv2vJSuXP2FJAhgmpwhjw6Ddb9seSY8Rue+Zqy0QHiKUTk2dlQTGC9UTW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(41300700001)(38100700002)(36756003)(6666004)(86362001)(2616005)(107886003)(478600001)(26005)(6506007)(6512007)(6486002)(4326008)(8676002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2/NpDwmpKGwTM9m2VIwIPSzxv1B8Yf7aHn+sENIBtz6LUtU0p95k1dO69pv1?=
 =?us-ascii?Q?bVZs3Ypm+u3RsXuGXJnGqegFAqWLI/KQvEWE+py/PPi/L37RZRl170CqI+u7?=
 =?us-ascii?Q?1lbUwE3xwNdSugM2F27Z8U39x8lp0THdiZdeQsiFoId+7vnUU2FMJ8fisTpm?=
 =?us-ascii?Q?Wok4Xy/qr4sLK8muJwiFV6n+Nyx9PSrUBr0AckoHbdANm7zCiy0UlqEyxhQR?=
 =?us-ascii?Q?9P7m1MzzWKX4nVc8Fr8BIHYkXhkIlSAZaWFz7B5YKqb+s0UuM2VxiC2pxOyj?=
 =?us-ascii?Q?L3CFB9Qe1p4hNKuBj6JkYyTkf94JnoJnaoeYVviguSRGLnA7MzstjFfgGsr2?=
 =?us-ascii?Q?VBACp1mea9o6Ru73nrhsFu3DDj/HxwVrMiNxKegj2CTEQTW4eGGhAEuinptK?=
 =?us-ascii?Q?aCKBk9mdHBntrtDGZeCjL6Fk7T21DhwRGGeKN31W+eDyp9Mie2zlqsAxRN7u?=
 =?us-ascii?Q?vAXcyym5m5PYV2R1suOQxe/iPCAPFc9qHZxvP/Yf9Un1VivQIVkbA9huS/y/?=
 =?us-ascii?Q?r5AAe0NM7gMCoygP+kBmiWmyRsF+Y2XLNLd+BEfv+aGHbS1R50FjSiwfe2CG?=
 =?us-ascii?Q?cqdsVMiWE47dt9k2Se08hMAE9JW4pr7NPn3qJwGpVdbpUiVESVYYSLt1NMEe?=
 =?us-ascii?Q?hmf3UT3T7IXr5lGNNeSP53AT/N7aL3WiFSZl2Th8Tuk8wSWBXaz2K8YL5mxM?=
 =?us-ascii?Q?LE2x+/r2xgeZ/7OxsnLqI4s2YNCVsX5AZfy9iuCIYGqKbtttjr24nhi01I9g?=
 =?us-ascii?Q?46RC+62sib2cMaFS3qgppSKovFdiFC0uaNKKb9beBR6IQsAp/hYvRfUoBlee?=
 =?us-ascii?Q?EybXipifXD6N5rIvjHvO8htQrClHFal917tOnGtuONjyM+vhyYI7ImlwgoHy?=
 =?us-ascii?Q?gurCuo3KBzDHQOfHMNs7NlYkT8bxeGQZK8w/RbWTii2wxu59Ce52jZnpDJTD?=
 =?us-ascii?Q?pb321hczoeLuwu7snq+BGCIyhU+M/hNDe5eeaCW9k3ztyTKble2jopZi5Vrz?=
 =?us-ascii?Q?IgGAEiim7XZtN3IwpNTP9hlqTvLo14Kuj0mL0AG/25Hl/IZxo57/hwsdzm9e?=
 =?us-ascii?Q?UICFhU8LMzNYZiLTrdMzK6YbZ/gWwQuVKv15T2DfbST/v4Dc7BvL3WW0fkiA?=
 =?us-ascii?Q?hZVvNKRM8YABPikmk0oI+raCqvnfpGZXpHLA23v2//JQAln8vUd9QWufF9Ll?=
 =?us-ascii?Q?v49TrVKUgA6sd98V6l10PtE53yupSyDET8MFDYr06lSXZ0wjCLgMPDXLvGDq?=
 =?us-ascii?Q?25x8Imtrn9G76vEIUVk46q6//jem0bQhMRUXifFwG5OeBYfVacscpPZWT0C1?=
 =?us-ascii?Q?R+EXhEZ1kIwLeXzBBKnMBjbqG/8BvzcS2ML5ESU91YcRDQmCStDak4J7qCiu?=
 =?us-ascii?Q?AVAddinQEgnEBEndkLr1aFEpuBZxqarWBolHrf28nXpx6rVAt7pEvMmaa7qt?=
 =?us-ascii?Q?BMRPNuiWalDcA12+H8LGdn2hu8h2c6Cvxk+RYP3MUXPuqUqgiHdirGKl2aOX?=
 =?us-ascii?Q?2CRJKv6bCK81yTAL1D9NItSNqc/TsyrIWlfk3Tfpq08u3k9prripTYgknxKx?=
 =?us-ascii?Q?07PynjPQWyYEUFboS3cOnhbQvX+MFHqsY+E/G/Xc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ebdf80-e87e-4072-c450-08dbe3f33e5e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:50:06.7113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPQTvm8xPVNbZmZ/tylVwCIFvrWO3Yem5Uscu1QghozuHgfO5hD8wosCh4LxjK+V9HqYi5hHj4nWTIOjfV3kkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10038

This patch tests newly added dump command for the userspace PM. Add these
commands into userspace pm tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3b49a1893772..9e29251eee15 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3406,6 +3406,8 @@ userspace_tests()
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
+		mptcp_lib_check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+				"id 10 flags signal 10.0.2.1" "      dump addrs"
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
@@ -3430,6 +3432,8 @@ userspace_tests()
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf $ns2 10.0.3.2 20
+		mptcp_lib_check "ip netns exec $ns2 ./pm_nl_ctl dump" \
+				"id 20 flags subflow 10.0.3.2" "      dump addrs"
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-- 
2.35.3

