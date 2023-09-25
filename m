Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AAF125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:42:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHfIXelnr4BOXOwUNwvrsEXgDRXgFcvG50tQisWwUbVjNLCEMfoXpTwTXa6Q7QU5FBBHp+x+z6WqxoJj7wvA1zvmyiq1z1OvGCKNSD0rzox6ms4CJGaNZfzoxo5I7/xAhfV/oE1w7mFpPke5vFljw3fD56mruklfiArUvvrRT4DN3ci5jMI4mAqNa1qMBfy8uSZu1zSRtX202mSdmYjhoZ2tmKI4r9BkRdxe77gfgvdr538pFL9z/CsI9VBEC+rIgH46IIS7IK8qdpT9DSGhyh8Vb6M69BxwmGawsS4aD+Rz33o/VCs7eg/icByBJS1uY2RY/Vy4VecbUOUHawpn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tC9j9YeIUwHfNmf58gy7+eNMQEQDOXjnM01v5Ytxkzo=;
 b=cUcnmbwT8R5Md6MmbG3hB0grti3MoGl0O+mLOPyQOf5Bt49ulrdZS53ohqQrVGl48ZmQ8AF2ymEE+ZAF642Mu+6D7wPbM5lBkGeA4YAPsGFLvwzJumEIRnPiCpeQ3JaxLNnHeA3K+0bgD9nvFKhwCe2um2jwb+0yeBxLybfPywvjoWN6jFGCWJerAQRgNtDqBHNltdiGensR/WBPHdtzbdG2jEh+m3Emk3XWDWQHD/Wa00FFvzvE1QSafvw+0+A1XoVqDbBvV+ieN+0/wMyXMH3qBiNTQg13HjQ+4D4TUYip23bCdA42PvlTKVHbH22F8/zIoa96i1zBbs4QzDYECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tC9j9YeIUwHfNmf58gy7+eNMQEQDOXjnM01v5Ytxkzo=;
 b=uZktBDZlYOeNBwG77V49ulbR86JrEtXmv2G1kkSZpzBDCz7UBckxNCuQURLy7ylqqYYL49Wxed0UMqBLB/RmrNqly8quAXQHylzM+d+kcmQElxc67TaBxCjYfn8+4jY7uB2LVa/K9L4ZhXqxzvP3TNWbR3LDikZ5NFlHKjD9eoWaUWUhVjtwah6osNQKyWjJmMveLhUp0nC00bMrDpz7wbpZgliX3Ppe3rmygBB9ydgRkQ0ps0lXvoL02T4fsmC96ZaD9bKAZIqfDlKNqyDrKWv+rRjDV0GTTtJmCXNVcXCFGZQa5j3jNqtn19MFXRwnM+F7zKnC8qXrpjkhMxJD5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:42:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:42:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v3 13/29] mptcp: userspace pm allow creating id 0 subflow
Date: Mon, 25 Sep 2023 16:41:52 +0800
Message-Id: <433cb075c69a4f34bab402aa3dfd9ff13e54dc56.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PU1PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:803:16::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: e043ade0-b94f-4aec-4daa-08dbbda3690e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PER6fqZK/BaxtgHLc3P8BOjX4bfCMNchNsnTdN4yNP65fZT62ZA28k/o/oI050qrZdbrQE1TLhZGd8AB7mJh1sNNtwZteHm/RmmHnKiXGun8igb06PWOMCQhk5wTpCseuLH4x7PdjBuJTkaNdtwoQDl9MXK86kKyO8XUBMdr4agKr5nhPFirGss9uxqiZ1rGE2kSzKU7FxIpHdAwmR9uS6pO+aaZVFKoUONJdWixIDasyUpK9w6dXY6B/YuDolaeHqLfepna0NO3rVXFOtOd0freoJ0wrx0q7JqBZm3pWexSHMSEOZL35Me0b2pAZtD81aJ9urYp7HqKAm7LO/0eqIsMyNq09FkLsIsDiXyFv+AOIZl5Dodx49AzGO7Sr755gEcPpbRztAyPL80nrSe+RS+KRCkUnqggRmysIMNOCu1RRai9jFZrRMYty2Dqoq1bqdTkIC5AP6JAj+sKdtNe6Kq9HIommDaMLebMrZEsOnK0Po84HF3OxNaODAzImPzfejsmLO93/ATyDKW4fWJa5sQZMeNFPnBfZUrA8eXt4uY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6486002)(6506007)(83380400001)(86362001)(38100700002)(36756003)(2616005)(26005)(44832011)(2906002)(8936002)(8676002)(4326008)(41300700001)(66556008)(54906003)(66946007)(6916009)(316002)(66476007)(5660300002)(478600001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wyUvdpD2hF6KiZyiNDl+lAmNdD3axNC0tx2mImE5HROCrnAFukKhwQupIFgD?=
 =?us-ascii?Q?tHpYfgxWtdII/goe7VubjQXh4kUdIwpmlXXE1Tv2fQ93EQeI9uv8wvM7WpxP?=
 =?us-ascii?Q?LqCYvZRIKYPhpnqcITlZCD+7lhdN998xjBfSOiCoN1zbsqu0+2OtsqSKZ0ec?=
 =?us-ascii?Q?d9ZjGGDmK28u+pgp5IqRbHqwBTekO6qWSCr025qCtXqyHqPYh1tfLOyThqJH?=
 =?us-ascii?Q?iUaO5gaBFEr91g/XGHAn1xRVS0Qz6tKflm0BXxD9PmmHf4iwrxmi2JUCZS3y?=
 =?us-ascii?Q?rZlyLCXRxw4xmPXgoNER2Ew1greT0RV+KPoOp5Lp6h91dcqb3pNYi3AYHIdY?=
 =?us-ascii?Q?GHf/dqlj5om30vyPtQP/e4Jt0jKZjSXUx+zEK2Ca4/sV0Dr3l+FExYTyrQ6s?=
 =?us-ascii?Q?jH5+otsujXe+wlflFnDovCE+ZH88A5aZA9D94I2KtxoneWZpIHyKwKQrmgGH?=
 =?us-ascii?Q?OrmxZKIzYFjLoey5AOGT5lbIUeuFmk27yRWj9Sj4wywLXN3avvkeC5vrhFkR?=
 =?us-ascii?Q?OHK0gtfZNxembdjJNWR7xUxAx99XH8A5VeVeLQBlxnyw8jm/Y4bMFWfob/CQ?=
 =?us-ascii?Q?c8IUbUBCqXV3EhucRNQbHUyPP5qLigdYTcUa+4+HP2vbCKInvBEp51Z0EV5Z?=
 =?us-ascii?Q?QRHpV97Wu/OSuKZvhhP4QW8Pg1i5IF0FgoK5nqv7Ri1TI6j7Yn+Sow2dkYl7?=
 =?us-ascii?Q?j40E0vT1szNXfcsur+1jMm/Pt3yJS6OyY3mo9NtuQH0O2a+8FNYRy9dIqLpJ?=
 =?us-ascii?Q?IuSqCxSIjo+ebjq95epWIgsN+POjwFcDLLmtD0KY8tVB7fw/RPcty7j2qONY?=
 =?us-ascii?Q?8/MVEBQY/AjFFtLY7UWTdqWLa7ehpCXA6KPAqgGRWpkUyfDRFcwFlXlLUAHl?=
 =?us-ascii?Q?nHV4xJRVougJXoGro9//Vl6clbhelXqyy86j3iiCVrsVsdstldhQZvxJmLTo?=
 =?us-ascii?Q?py0qVu2DZLqQvq49YKtssU1N7a2WgY/ewLwTeG8i0nNLObXP+Lsi9BAIzUqD?=
 =?us-ascii?Q?kk6NBCr3IQqEHD1KbpblAnTjx6t+9gkFS1g0HDoEG5cL3SVZ5Kgou16w7vHL?=
 =?us-ascii?Q?FahwqWdHCqmYxaQRjbsNrtAfTK0I+7mGN7mN2ZNiGhjA/ITd1U7y1lbfHmuf?=
 =?us-ascii?Q?W8a0ECPESFyamXwDBYKGT8OPElPJH5MuMkDZySwftLN/+QWI80+JayIXiASB?=
 =?us-ascii?Q?dP0dTStJuNwVncNfAauT2aPSGQRF8Oedr1GGGjApi646L+XObGi/gcKdvhcZ?=
 =?us-ascii?Q?ewMbX+FS0/bEurdHRpFEEz+t3z90qTQuRko/XFjsxIBcNvMdOTTvU3JWqK+r?=
 =?us-ascii?Q?wFC2UBxXbGWh7nuFzrEuHk5K7FrOXHvpzVm71aUEEkY49nyhcwYqs6eQc0o3?=
 =?us-ascii?Q?azK/b7//N+XHIVTzRp9hgaqnovsFyvk1D3X2p+P9XoE7e05ZqyGX46nr7Z+A?=
 =?us-ascii?Q?GiVbkDMzbe2F5GaGAfde6hmeGDbhjrFc/VSKiQEk5W8D/hKvBK1CJxacNZMC?=
 =?us-ascii?Q?vnHJSrxItC7n1gzVI64ptrgxJZulwbcpL1NwFxJygqPUdUpi2Asmx+OvvI9c?=
 =?us-ascii?Q?6mf2QLHIW/nYjMJChDwGZSTVA7CikGeuTFwRGGv0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e043ade0-b94f-4aec-4daa-08dbbda3690e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:42:54.5087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDcqcyn16Pg/dsmGnqQulKyZmJDrbJjuoo5th4ex/xaH/86TnHD6YAOIZCb/G9B9gOUm+UVoMQYu63cglMHy2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8510

This patch drops id 0 limitation in mptcp_nl_cmd_sf_create() to allow
creating additional subflows with the local addr ID 0.

There is no reason not to allow additional subflows from this local
address: we should be able to create new subflows from the initial
endpoint. This limitation was breaking fullmesh support from userspace.

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/391
Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 04e26eb01ba8..6b8083650bc1 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -315,12 +315,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	if (addr_l.id == 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "missing local addr id");
-		err = -EINVAL;
-		goto create_err;
-	}
-
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
-- 
2.35.3

