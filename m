Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2076.outbound.protection.outlook.com [40.107.249.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BA56ABA
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 09:08:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4U5XcCh+550+KKoY+kTPov5zzJJ5mSrcjd3tL2uWzJtxiTl9e78mOVNEbAPD14wfFBFrAgmwh+ee61nFivUm7/2Un+TUl4Kb2PteXALL5gX+XdolIdubGltSmhNgABJPSgk8N9xOXhHUnz8Nmg/z49vSwNC0hxWH+Y3zbmoIvocQFf7XsriwoUgKF/99xMevdbzqAOq/HPJoNxoaD/YYvLf6K1eNy+vfGWoZat83oxQipPfNH4skrHn43MkkBP7TGRDca3wJjSFf9V5H/L+CgOimiIa/wEQNRowP4+0YdxiQMH4I+Cu4jLQicLnql+OPS8VhF27tW6rA7wNHBE4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/4/JsCXP+/OKQz6jjCp+OtHk954GaICx+c/+SeaJ/8=;
 b=MekIrJmjtMx5geGrXbjG4hG+TdSE/RYZw3ADhei+PHQwk+ZnK2fh/imDNfgM06Z6UC0jMAFuXxWSuQr5aWZYBMNUuaMookugRTdso0qWpB3pSGCqxaIunMAgrBb//9GU8l0QUY+qJ3N+PA+7kiz9OIlVcEtPbwH2aMnmNuZ+gxHrs4jEWZH6LzHCzzBgDgh7hHzATqJG9+g4zQLiEJNuW/tOS8uC+hxwGx6o0Dw/F4ZUITOlOp7pzYovS5rA437Y6tfygij8rOSWzBny1dDjM1+U7z9YAXjokPEaIzl7srFok4CULY5XS0w12F3zaVemQ6TG7isMeVTm3hZb50aOQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/4/JsCXP+/OKQz6jjCp+OtHk954GaICx+c/+SeaJ/8=;
 b=nRkC1UoNv2ArdA7Re3ipK4SFAFAlUXmAl+1dtphozh14AL6zTUaERUyuVjn/NVUxyYMZ6OBQnFRLFWN1RveQ6MZmnnxEcMLnToQh61PNYwuUNWzSOuMlbSd7mxVQqcPSaGEkwGieQa52PnR6HrpuMDY0t6kUv3jQqf0eIkNU1TnhMn3QNHb7WPTMLZ0iq2f4cVNVfYx56ZNuFTouK8thA4huFKvLwTmzVEIdFMetJkkYOmUsAw1JMOydx8pgWcNCN+LZS93gOj7PoiW9qZq/uQqMuIVvebTF+nGb94qUA/7U67iu3m+OEzxfivuu+JB+NIKGt5OaE9VUMan+ymoh9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7914.eurprd04.prod.outlook.com (2603:10a6:10:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 09:08:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 09:08:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 03/15] mptcp: add sched_data_set_contexts helper
Date: Tue,  8 Nov 2022 17:08:25 +0800
Message-Id: <e6a318f2f4a2d91a3938ec3bfdf1ae1cf2098ebf.1667897099.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667897099.git.geliang.tang@suse.com>
References: <cover.1667897099.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::16)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: cb15e492-7390-41be-1230-08dac168dbb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xmHvCNLSIE23cEqROqZOdkWBiiQwENtq1YjgzCicZeJaku8JVXlc5IFaf6GtpWvUnkdX5gci85F+d1DsMztA2mh19i9I9GmEmYTV0vAS1Oh35/fs1OwWyG6wuPkSQjqt4odyNDhIIN973zvrbbhdZejPDoPG1wp1sFemwg1aYCrHeibAPNqL+Cb0OSfzJRLASni83EP85SqwkyQaFu6IqpSImXm89ktob531cm6Dbt/QcXN9FpIfuF4xDoGTB3KnQu7zsLpaeM7Fy74tUZqyCb92Wc+ZxloorU4ZjrRhiayimWCqfHuDqVCKgsEqj5WC6AbWTizG086F9T7Ik3l38mpH6JHwzzsxtPRs14Xou64FsWTN8T88tGfqfY1Q36shW9AdPpZs5o12buZGuu78PkO3uDcR5tcVCqhPKQX/5e/nzFZEmF4wXnETKX2vspAwCJ1bhf50ivSKyDRGifI0Uyv4VxAe1UHBvPGc3736x3bnW8+5hL/6b9Cma8snPcqYs1WWi1ywPYFWaAqy0AnZgNeWcD477QWkO3/RS4n81mZPvxFptEPNxE0GxxvBTnf8E1fkyRAzS6XBYS7D6gqteSbxIl6ifAz6Wk20ediKrf73dQkpDRkFwzhUXkB7xg6OdThBC3gPRaukErgx1AEdi0mIDiEeLpSqC8YXCzlZzTZrAuhC/DBoXSnYF9LQiLi+xoUjs05HB3hvQH3OZ75Fu9JtooUT4ZQoj9VJwItBQ2ubbwBSGIzVRZf9RXX25nMx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199015)(66556008)(66946007)(8676002)(4326008)(66476007)(316002)(6916009)(2616005)(8936002)(186003)(86362001)(38100700002)(6486002)(5660300002)(41300700001)(6666004)(26005)(107886003)(6512007)(6506007)(2906002)(478600001)(44832011)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LOLK7yow+LrwLvBezLpejPFl/LqT/ryGk717l1xPlEHtSP4zYQ8nL2qxWbP3?=
 =?us-ascii?Q?CU3BFipGVDE0jVIGAg4M+5FEEAff26z/sEuBepYWvUUTziBcDD+T9mXM/FIu?=
 =?us-ascii?Q?BcIgPJTw9ZH8RvjBPVa2OqQ8CChbJiXKdFQNEsSPk73E/a3mF+JAudPrLsD2?=
 =?us-ascii?Q?LJnvsSTZJKeLhjsRt7b6Fmx0+2RFcYlGNc4n/4B6VeRteZkoNXiH6lfmtPtd?=
 =?us-ascii?Q?D+cg49B124vybyDfoA7Y6OnTgD8aIKTG/3oKcLjvPd51qe6g+ZWxmNCIY/sV?=
 =?us-ascii?Q?bcH4aKsuzZerB6qn5qNbu+/fit2fJHyx0S/zr1ZrqpBHA4E9dVTGsHC1Ul83?=
 =?us-ascii?Q?PS4ZvWQmXcAhP5ritOGMr3fSy1b0+QlKWQ+xC/JfTsLt2OGWopi2L1PUsm0a?=
 =?us-ascii?Q?tG4WmG5Vd+rRCxUw6kf4Ei9gXHeKLKyH5pXO4Rtq9k/KfHIFfeUmHF5+WJMs?=
 =?us-ascii?Q?362a8pnahORkMf9YBS1uy2QNGciXJGCMktOl/U/igHsJGIjIGV3afY/Q5cLk?=
 =?us-ascii?Q?s+KH6H2ZF52o/roTFd6cp7m3xOUisqsjgz1/YzbuneFNAeJHovYPzrpGEOG+?=
 =?us-ascii?Q?pK6JFXCMWSzTTsOGSvhQgecFJX9u6QDqtmoYJE6OFx0Yc7eTJGUYYryVA43x?=
 =?us-ascii?Q?L/BO8k0atpph1hRMCbEov+VTC38/gsUEpf39fTHpgChwCOVpV+OLcTm3vfg6?=
 =?us-ascii?Q?ljnq4CvzWoUZxxYWeNr8M1rr025KU3R5ZAQ38ViYGiHshTSIf2VlpMfwLabI?=
 =?us-ascii?Q?LW1RDLHDp1OpZzN/+jTlOmw69KHlwWvIEahqUaKG9k9PnlFH2/UO0wGunmxz?=
 =?us-ascii?Q?P40ozZ647ZyQv50zUAcrdyv3xEelDduftzDtSqf41W249CrO2o+cTxtUDwgE?=
 =?us-ascii?Q?YErPBsGSvVinZC+U/i9s0GerMv7iIirUNweG2TTOe9LBPCw/dCg4UPcIkWdJ?=
 =?us-ascii?Q?/e1ZN+NSxPiYCpE2gNacR96JeMPwpDn5l4v4P45OnOrxurzDdsD3SHmJJrZ9?=
 =?us-ascii?Q?0MXxBOQEhfvN60PUxVPVyHxDZl6d+W7hF8Ac9uisgaSII0RKj4odLOE43uey?=
 =?us-ascii?Q?PCKEHDSLsezVHYXgXb3oa8/Gnq7TrUikvLGzmF1GcmcLe0M+PdpBxqoxFziW?=
 =?us-ascii?Q?qufRnbATkZMjYuDXZabGec9hMRZf70JVYtrziGNF5vKUKHTvN9sm3ON6uXdR?=
 =?us-ascii?Q?kjAlMb0tEF+AagXu82peYV2KnvnyHorsWqy7UAbZWfh5gfllY1qoFB/hSsa3?=
 =?us-ascii?Q?GMmuHeuw9WK/FzMJzO+XFQ/pky5IUL6TCQnYfleOZrW34AMroG95QOffOu7u?=
 =?us-ascii?Q?Fp9bJdeqcZfT0vba5BtuvxFPxGRQucxXOq4mf1IVex0ws4Xy3COGghw9tb+7?=
 =?us-ascii?Q?jW/AxOpf9YslBFYfdNshc7eJTBhiWIm8xL1KOfYkL6TqTYD4M7co4PhAH/Mh?=
 =?us-ascii?Q?NDZDOBDndUAvbrX1u7P3ViqLwWzkd3gxmDNVI8C+Q+eZA21Pv6NuixuwheDM?=
 =?us-ascii?Q?3nukvWFDf6Aro//RJU9/24ijr3/qO2vuKJtldr+FoobtFhCChmTlNR+S/iZF?=
 =?us-ascii?Q?321gq7OMyFpAiktO9Z157pYtypaZqquiBwVx2Zww?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb15e492-7390-41be-1230-08dac168dbb1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 09:08:53.4014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5+PH5M6/4vtIAIdj5F1z+dJKucgE9Aq4owrvcdHk6vPBUYLVailRdaVLzx8Ujj5T8Lo9GiyOYqCdSA6F6elVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7914

Add a new helper mptcp_sched_data_set_contexts() to set the subflow
pointers array in struct mptcp_sched_data. It will be invoked by the
BPF schedulers to export the subflow pointers to the BPF contexts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index d295b92a5789..5a910da1452b 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -93,3 +93,22 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 {
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
+
+void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
+				   struct mptcp_sched_data *data)
+{
+	struct mptcp_subflow_context *subflow;
+	int i = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (i == MPTCP_SUBFLOWS_MAX) {
+			pr_warn_once("too many subflows");
+			break;
+		}
+		mptcp_subflow_set_scheduled(subflow, false);
+		data->contexts[i++] = subflow;
+	}
+
+	for (; i < MPTCP_SUBFLOWS_MAX; i++)
+		data->contexts[i] = NULL;
+}
-- 
2.35.3

