Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2F02F25
	for <mptcp@lists.linux.dev>; Thu, 13 Apr 2023 09:13:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMzXmVE8pzmtUAC0nBLOZD52vRfSu5ioiiKEVLqhTS3LjRE3d0v8zXcW0QDbrIs4H8eV69HkgwRpRvGGH4GbYtgw03BW/HvVJesnpae5Z4O77qqIob2OSqcPgenVMoakGuCuxEO1VW1BwolGbAFAvrN55ZuxFk7yupofWYB7PsyYstGunEnT7VVx3kpPCdDEukFbjwTNLdsby4KFDUp6e8TFUKCJPDSp/Ipl6OSIk6uSeoSWnd2HiHCONRJrmoeASgqlw8Rcn3CFWVYUp/vwKHq9zcWNBNpqBTsEOHHdQ0FHppowzvrvG6hwF51rv7SfiN1S1TkDWss9sGe92tgBDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS4ZyHw5r40SFRe09mK3DxbaB4VjfUR/gphp2MTc9eY=;
 b=R9DT5SR0kO4UEU/e8iYaAR9A0dTibuJ8QjK3RjGBjDF4gT+gWDjtN5mfhWSD1hCm37rPb7/MdEVVtQbpyK/eSE+Y8FzdOvk3RQO/NzFKTjB6VVgyPuzK9ViXzWDQ0zxTiGSmHK5+qnLtRNz1vpogvaED4K0Uant64uxFkrbDwmS6i4V7A1GAN5nPboaudKl+TLTAPJ2jSR3X+u6mO3EnIvEEUGra30vRV62b4W947hT8XQkQ6oB15ZqW0tIdRO3HBbCsfCqAtAkILetzv5amt3B2a41abb0OSrMI8+ft7NM34IYtRzRs/2xu9AsHQ8lmy8llup4ljwcJSFe/GNLrLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MS4ZyHw5r40SFRe09mK3DxbaB4VjfUR/gphp2MTc9eY=;
 b=P3wMZiXjlQBPId62TmdOez/sE5nIpVqejbKWyj7J+cFuZ2OiMWOwSNS88kYOq1RpYtb8WNVVGK4g7wguFJVz4Mg1xFa8qS22zUrRWe4cCvn55zhgp7a56v2xPoLc4wu8+MJMSJ8ftJ2nWN9NnUBVR1hj/xrDti3dQWNDgqWcdPGYOCUyNjgkqsSpX+GvY1rVy5fqmcgPXUjNCA0jgWR7LrJOr89Sp9bKx4SBj7Lo/+7pt5otGKyYo9hAHDt0Ue/fTJyBBJbOc2iS8JL6sauBE5CuZWuux1mSXsp4hgGQK+r84ZVrnrb6VlhSytaMWG5xuudFEThZEvOMlc1cfJXKjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7339.eurprd04.prod.outlook.com (2603:10a6:102:8b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 09:13:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 09:13:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 3/7] mptcp: add addr into userspace pm list
Date: Thu, 13 Apr 2023 17:12:38 +0800
Message-Id: <fff7af74f27904f43e75bd2d23f697680d7b5126.1681376983.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1681376983.git.geliang.tang@suse.com>
References: <cover.1681376983.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0438b2-3e09-49fb-1221-08db3bff4c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wmAI3wJ9XVC3nSNibgivavPcm+qdH1rDeHyLi8DSZOsfYpjGk5w9D3W31AAV3Tlex2pk72u+keylShM65ZWqg49APeNmcYIaQyazzytV7z+gUWnlnO8FUG2PX52RWYXei20wRczixl6cSYlGjpMjVecuSf8TmSUlZ1at4I19h52H6s2aVihrSp54I2VBH9MamMiqvWmbuEvOz9xjBiiAHWPbbtg9h42UkrgrXYjJtEReRpOF1+RP5Oy3T2bq9i5KvMpy3NaU7B42t7FTwRoLZCJGFQz0GiLGV18YU+aypgL0BbAGDusrMHY2yqSumn08UmYv2IMTb1IyrlDZRqO+jGd0KBo+n9pY/ookze+qqd4ncWwvT3eSxhbfKCPvg7XfPUUarpWpukXG0mlLBGa+9bsbgrNl4k+Ygw0c3OLJkp8J5MqERc+md65mZW/R0SlCwe27XqivBwgmdOO1ZaK+BWzLSLQrWNHgVRshpgh9HDxwzuhNGpgPFXqDWdSokeQa/zRpdU4e37xARxiWZJ3s9/ixBIeHCmIrixlwEjOxz+zK4CvaUKH1afFWXqINMTRo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(86362001)(478600001)(6486002)(36756003)(2616005)(83380400001)(26005)(107886003)(186003)(6512007)(6506007)(38100700002)(6666004)(316002)(6916009)(4326008)(66476007)(66556008)(66946007)(2906002)(4744005)(8676002)(8936002)(44832011)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tJhhjiHwfy3qYaPHhAtmNirEabRTqEWcnjsiDrWAtNfU6PLYNhfciL+UoP/t?=
 =?us-ascii?Q?I7kxdtWXfFCCW6p+m5t3TFuhEfNFRzg87b1n+t4I9e+1f8ZXEwM5ye3Q7Jri?=
 =?us-ascii?Q?9M3jYkkhSpfGhIYVnv8IUD/izjM8mdgzRoVIH9yeIlguCAtcG8+B0E3MryNL?=
 =?us-ascii?Q?C7v6NrNqcreHoGRsq6+L9iTrRsuoeyAIzElnV8NY7xTIqmHnHI0u3HfRbe89?=
 =?us-ascii?Q?S/333DX4cmlVGVEKxAs0H9hbw/7Hri2CiuRnnQ5TKxgdCcbtybKelMblWgcr?=
 =?us-ascii?Q?k47aE39+RAT4MAnS8wLfNAldFF6fmentpo7s3JR8tk+m7z2XWln9od4+gCn4?=
 =?us-ascii?Q?v6Z5wkmSRUSrcaSk2z5kxlG7GKlpyyJYX9Jg/faIjHQ7g1CYbd7EkyI0cgtn?=
 =?us-ascii?Q?uiVZpBxiGu3T7ZJ3LQwLs/0H6Le5wd+HchCx2ZxkbZ+OC6i74/H7oU5M3ag/?=
 =?us-ascii?Q?Y/Mzu01KK0PBrgTrj2B/ZN8EcLY0hYDVIB9MSROnqG9Vp9xnMCsIDldLAE1r?=
 =?us-ascii?Q?MbLG3LZBCuoeJPwWzQdm36lYg/tRuduNk4XDiMxV0BVkAXj2nFeBTlilIN++?=
 =?us-ascii?Q?Uc7DWAmkyUPFtr4Mn2bBs7QEPJuzEeTaax4vcFhrkOfbkmG9GUDI3mBoqjKy?=
 =?us-ascii?Q?xScUinwkOef7kRoEx20ugbHZtr69AXh2VtlrhpJnE6LIIhIPdElrLapy3pRJ?=
 =?us-ascii?Q?MHjKI5QF8uLg1RasPl2dzqj1BzFxXgpg759lWLtZHt4dD5t2XK7dtKOE5abW?=
 =?us-ascii?Q?CC9KndCHeMX4oOxnrHBv9uHm8IrD3qWpwrHaNpb0is18dBaQ5FzyUN/6ZiAe?=
 =?us-ascii?Q?ezHwZsHTxPKix5+ye2C0o40xuFWanLrBu/D98c+x6WXV/laQo9bhemhpGunT?=
 =?us-ascii?Q?cZAAfrLejpDrDIgLKm+0afUDrysN8qQh5u6qi2kHDbn+TCb/ONtWmoWhRfPw?=
 =?us-ascii?Q?q367L4+uq9GsMwdBMs4EH1RAYBjFmka8l9JwM+OWGwPXNXOqp/aWUfFeZnnP?=
 =?us-ascii?Q?HAztUpIMYcoGxfMNMDrzoh1gkMdceVPPVOlZUjjEQWtMjnsZtLYB+fghK01C?=
 =?us-ascii?Q?014eupBcQrpdD/z3RtOHLxFybzx1Yg3USlcYtaBTA+JLdaBRXFAL2dAUDEAW?=
 =?us-ascii?Q?0ln5KVbqzOGOIqow7HKI3o46jL17c9MA+jhbzuhIxiMCZLk2s6xebXketurt?=
 =?us-ascii?Q?UAJCN93C1zXS4zf7zo7U5CxydUOOOV8Py/SFIADRCGt2CUgpej4vPGK+F4xQ?=
 =?us-ascii?Q?kYvncMFOJttZJAFWrxnY7e7YnKd3mlrZDF/bh4J0eDOJl/oJK7+VsulUKBXE?=
 =?us-ascii?Q?iXCIqizbS8fw8bRrot7FMNqHI1oWQDx74ET8AN5ZmAhA+ZEiTd7FU3aqMvSR?=
 =?us-ascii?Q?Amsmq4NON1ldrlyTzfOimZcfD4coTSpkVR3z7MqtwiszGAnx8VwBmhEnC90U?=
 =?us-ascii?Q?PY6Dxle5QwErOViQ7PB0MpC1Apdx8RenzVf94TTGqKzTj3snz+cionv+2z7s?=
 =?us-ascii?Q?SLTiJsMurxaiNm8zXzjZRIqPwJWZ/ywvPk/IDV74H+oWeXf+apwWOLDT1PXu?=
 =?us-ascii?Q?72ziH+wX4ee51R5/NhH9FaapmkL5qOJ8UQ4qYr8f?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0438b2-3e09-49fb-1221-08db3bff4c8f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 09:13:09.1761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFTTlu0Kt1J8/S9oPtKr5RrztmdyJ4DkvM3yN0f3yoW4tIbyPe1Xg90O2qd141PFAAayNFO/Hx01qSWKYs2BkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7339

Add the address into userspace_pm_local_addr_list when the subflow is
created.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4a8ebf87ef02..176c77a2a79d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -301,6 +301,16 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
+	err = mptcp_userspace_pm_get_local_id(msk, &addr_l);
+	if (err < 0) {
+		GENL_SET_ERR_MSG(info, "did not match address and id");
+		goto create_err;
+	}
+
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.local_addr_used++;
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
-- 
2.35.3

