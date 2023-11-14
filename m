Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EA26133
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eZCIZufm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtuQfeYUx8xvk1imwRpTabRoQNHiReLpmhG2QThwsafkiwWYB0tKWIbmbcC0emNbD94JLyyQ0Hwx6HB6KyqtmlK7Y/eKheVjLflby8gq/xBhGSrew1tyZPjaLxLyZx7Rb1sft9e3azxP8pWOdxApQap3LBJI2qzqoOMcuGbwDZB9I7sWN3sP1H/mvghfaYBLiGoAuMDx6OVPy2MuDOTz+Ux6HUWWEcauOSi8nETmsVgTYEHcZo4ywimgvHfAUcHZ+uykjKp4aCrGwl4jE5ZCwLm2RQi+it8lY1pzdGr/ubpHGJXWMJMqenP5W1SesUS+RWPnTyPkD76Ejl/X5lWQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dph7slE2gv8EAzbuXoW1AIj1s2dm2ND+F4+zezBtKwE=;
 b=E5w4HttAFPYlIzsh9wTZXaSyEgdVIi0mIEjhK5/M1XB48yuFm5n8Ap5H7aE+bLJ6kFHo2w599RhcBa8PNlGuVOGuBh5g9h/9B0DE3iRHDprlosYK0eZMPGM45byNxum2pTwEk3jjsBn4+yn9bYTgusD+L1VnRI1/E816UPU0IB0pPWacnZiRqnBT4juJ0KOnntpCSkUyJeqGy8/F1XRoydTs0iuQxRlZJZg8jZtKJq+Hv7UDscSFetQnkIYCv4aqL0EcIBTqXtfpiKI4MMaUVukP95yPvKWAR7Q+oeyQHTUVp8KE7O5ln9oOD0HKuBr/gxgXWpuZLC5RMx+EI02fYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dph7slE2gv8EAzbuXoW1AIj1s2dm2ND+F4+zezBtKwE=;
 b=eZCIZufm60FkObevkMt5XU973SSCDEXFM3ELbeMVI7y/xEIUuZdJqRr5FX5I2RWQMhxUUcaZ5K1q9W22IP2kXjiV0+782OKcn73a8hdQk5/K3NQtiOAfeXJ5kTiOk4nc4VMFRRWEpDM6c8LWOBDXiVMTfA8knhY6mkoW9W97dKmlC7Ho51bjl7ooITl2298qqc3M6GJNw/3C0SF3C/N+p9+IwhYdFVu7NiDhJud0iOKAXRFY6osoVd6R9gaqMgsPk2vKaXie2yBhZwNrGufPdN8TsZyIb8Kf6MjLt7KXutPy7Gd2wbKgys7QBx5I5vcvQckbQ/75cpaYp/f1DPLaMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10052.eurprd04.prod.outlook.com (2603:10a6:800:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Tue, 14 Nov
 2023 06:36:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:36:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 07/21] mptcp: check userspace pm subflow flag
Date: Tue, 14 Nov 2023 14:35:04 +0800
Message-Id: <a50eebaa72c7141728e91cb6b8c51fe3aedc86b3.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: 6294e6be-7d53-4127-c1a2-08dbe4dc04e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FHKtKGVIrN5mdi2Kc1SjwQPATkxoLmr40hP6Ry4dbiGYUjlilic1TfUA6WA0ECM+gdQ4fsQUZiH6I+Bys7P7BSjw3+WDfPQTIkj6J5DhdLFaiED5MDNWt4ru3KIUV7mNz6mluci/p74Gi8EkF36gSayVOKOrEA4QVUzgxcaO36UPcAoy3syHs/cgieH0QP+CWoVHgFmBTKhraVU8wCvEgNVLVLsYQ/ZFTSMf+nx8tT09wjf5MhmtpBFFUElchmzrVqW3c3CkodS+sotSPOeLxNqY94Kd+mJD0q0qzFpTvgBJPlwHa0UPX4YoEFaDuqpVWofidnpqvWtzkjPcQJ+4aDjhHS5HFJB52+YHMDVqRq0ZcCRwt85IFMLqEgSWlk1LkK0zlM6dDIPPGtXa8BVRhuu8Fyc5JD08J20R0DY7LQoC6/xvZWaQ4oxn1F76IgS46Aek2m+YuewbvpYV3AejNJuDH2MXNO+rF7XmcIuIx76MnSYpWL99vnRX67xfhoLC9vqhdNCdLh9aCZdy7y0+WPVI001q+S1qa2+kHtWvOVrtz/evp0faiQ51NYrSs/PO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(107886003)(38100700002)(66476007)(66946007)(6916009)(66556008)(86362001)(36756003)(6512007)(83380400001)(6506007)(6666004)(2616005)(2906002)(41300700001)(316002)(478600001)(6486002)(5660300002)(8936002)(4326008)(44832011)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lTYeKl7sHqaQMHB+mBYEXX2Uz5keoi9Iy7jZzFMnJ9eWxTKkXZ0sirVMM+Fi?=
 =?us-ascii?Q?CeTs57HBXhmdjpforD2aTcdI7UKLNx2oBhhCnLEF/EH0s9nN597DeaB6P4vk?=
 =?us-ascii?Q?IKVStw1tzgxjyOEz2hsRV1q6kRfVjv8PVOw3slEPgqz9XfMGfnsCaOuQZnXz?=
 =?us-ascii?Q?7zMmDjYhI5pyGndH8yoAqqdNrmmwUT4ydQnJVf3UQX+v4OmoDf9KwLe/1OWZ?=
 =?us-ascii?Q?fmUe1VkAoImB0TstxG1nioHfkhxTMJmJicnCf4u30Hcgf4DxCHIgFol7i8AR?=
 =?us-ascii?Q?kIY0dVb0Ib5xvfd9YPwwgnq7N8k/K7wQspct0DuucFndoanWvaFRLCjflv8A?=
 =?us-ascii?Q?BaQZRCgD3w6+3llgnTDpNTDrYaIRzV0Uw79FUDDf2/fVgL1DyhO8Qul9vvVC?=
 =?us-ascii?Q?/RqVOLf1yNTR8j2YCG21LhzswKA0vcFAvQJk5C5KhfBX79ZcwOcz8KzF2ZZP?=
 =?us-ascii?Q?emLhkB4g6jxTc3/mCgjQn8bcHmY9nA0nbrxt6vWuYOIklyujt86oSWE5XJHj?=
 =?us-ascii?Q?zKkBHFvvKJ5ozySqhFwemf4FSsXzN5wiSg3A3Zgi8l2P7LSXXvmg9UdLAl0a?=
 =?us-ascii?Q?d78myoi9att1lt7Yzrt+UpLgS8+Cg9/0C5yMpd6hX4dtBDOwQFZMXyQydAKR?=
 =?us-ascii?Q?pmhYJgKrBBLZ2O4gIZMxQQRcFrSkSV3JEQ3e1vzfv6DYemI4bZwxTe0YzYNj?=
 =?us-ascii?Q?oAkMm5ySPnbHEaJOSiNrG9adRbOf3RcqAzUS5VH4K3V0aVgPiKLZLSz8QK9U?=
 =?us-ascii?Q?4oZ0KXQwAwamoevwnS3Z+mEQRIfx1kJiFlIRaWwfgJPVMTpe9r48O3GsyM+3?=
 =?us-ascii?Q?n5LNMXqXHBGyEXnMda0+MXGWdCPuUb3drTXSQB2E3h6wBpLDTs4g/EeDcsC8?=
 =?us-ascii?Q?cMymhGHUw+1q90u50SuBH47BxY3v5YWsSNEjOG8FZK+aW/XpuzGsKURLcxi6?=
 =?us-ascii?Q?sxNMtgJTbmac36s4XYbazbxaxtP9NVrv7fMmRpw2M9wiPfl8ObJGKxgzdfZ6?=
 =?us-ascii?Q?EpQqpNMyCKa2oiqGTb8ekzOTdKUNowO9FKH35C1OQMSJ+KUz9EmTZ2syH3kw?=
 =?us-ascii?Q?V6GrIwjDHw2T41WQ2ndMYEs5TtD/qHCka/ulU0vQuRgHbeu0u6opIntCM07U?=
 =?us-ascii?Q?tnkYOZ1XDX12bebOEHqoKcSnTGl+1KB4J1mO8FwxGUMQxmx1tH7papXq7YQF?=
 =?us-ascii?Q?nkgWbMEzSQQsmlnMhG2G1cGlhybkcfR/xq7CXzzxlw++RLRVaBFIS3Ti/OAI?=
 =?us-ascii?Q?tQxueGfiQxdlZeCTJ+dEj6yFAaeEgIoOZbCPN+FxP6MUcevkuCFrEMjvPDKz?=
 =?us-ascii?Q?U2Q2AEiG85hLhqkhraaK0C4E0lVR5vqWbtVssgGJLTdkn9vHJP4dyHtb92ws?=
 =?us-ascii?Q?wzKqyTPTalz+lsgsu06VhVo/BvfpGe5ijE1LW9XsgaXrh/S52Zyx3Ypru+b5?=
 =?us-ascii?Q?dbaWLm+l+Gkn52LUxo/PQpMY1+1Y6ahAUf29vFNhaZ0kckur9xZ3Ive2X0E7?=
 =?us-ascii?Q?S0zpmpu2iogY53tQ0QLKLoAv1Xf+PXtGl5QiWUX0DvaEXCekgYcFToGvU7Aw?=
 =?us-ascii?Q?I9vu+CgwjevGQNz2Dx6qFw0fps/zqSWNNMSqgUHf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6294e6be-7d53-4127-c1a2-08dbe4dc04e6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:36:23.0645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMSD5AFnNyuLJh3gLKEbh3oNGzGVsIMd9anL0sR9kw7LFsDe8NaboSKtUlG7YSavz/nEfMruliQkk9+y10yZhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10052

This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
to get the flags of the entry. Add MPTCP_PM_ADDR_FLAG_SUBFLOW flag check
in mptcp_pm_nl_subflow_create_doit().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5e45e36ce1d3..de10be21bf26 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -347,12 +347,19 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	err = mptcp_pm_parse_entry(laddr, info, true, &local);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto create_err;
 	}
 
+	if (!(local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		err = -EINVAL;
+		goto create_err;
+	}
+	addr_l = local.addr;
+
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
@@ -365,7 +372,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	local.addr = addr_l;
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
-- 
2.35.3

