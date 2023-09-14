Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EED34CF7
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 10:03:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzReRjXBpiuuUt+eXvYpPGgGfQaXdGrpj0vErSUBT8iEj4MQetBn1Iif40DVWiRckEE9P9U7kRM1a5uEYdpJE1I7VP9U4ni1cwKARXk07JKrP2Nl7IqSBCOukusa463IPhu6yGUDMJgnYLLUoh2zQwtUYfT8uaBKi0icH3hJGBB0BRR7lmFM7MLMHpx1V/Um3+SDXm6ekEu/GXBPg3awmFwB2aeJ1OfTdHbxNcnxkt1ApnEnZMoanJxmoSQ1Zc+sYCDq62q8QmUpv1xd8MZc5wCXkIAKPHr7lZt3aaXVMmUOQd3oJZnLZbN5a+M+naXBWrKfmDl93ceg6W/8nPFtpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vx4bAUMqMhm4bliYp31uJmKtyXO39VX61QaRfl/Xk3k=;
 b=gVZV+Kt0yRRvHlfUk0JddukoGZExRe+fhmSXxiOANT6rtb/wK0XmekZ2LKBiOKiCvUm/yaBOUaZ59SDvQXWC2OdKqzv8lFIQHIStmxx5ViTZyp5/tQ8U8zdeIzW1Dikagj3BLQJ29KPXgmfXmGws+p/FU8TXPSeASGHMNbGpv6w4zawI5tmEnkUtcKjJGlKyBf1kAvFO4M69yJtrnkVi61/et4KYXbZGn/SFJ6u4mHKmjKEM8XQagSsMcsTvq3L2TzfX4uprJpZ32e/LmbDu6e4nJK/ceVD/3dOp2YB3yvte9ZWk5Qo8lMMs2zb45Wjm6VlBkEsr2+PqNo9Kr9QA6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vx4bAUMqMhm4bliYp31uJmKtyXO39VX61QaRfl/Xk3k=;
 b=XCKle5DglQX/ltGGvpxncDIO+t1b60v+73Gk1E7vcDa7eUBT6RYNK3v38IHqFnqVXCuYg+Bb3pxkh2ZNFpoFPeyUA04ZVtV3P55/HAmTNWzK1nUnILzNAisWk+njxOnd2KBYKJ/YWmHXsYg7IX1/GYnP++Bogo/cDfUQwE8e61SS9ACxAIk5L1mBZbcuowui3YIWLaLwBwjcx8rNI12p65FiZvY5jGT49gYBEWoNaM92vovKTQMaP1hlvT+9M3Vk+Z2ZqJ8yR3Xv5GDZEJqNRKtJwkvknkzbEngcQLpQqI/tMWZKm0y7HKmIBLmrMhiz5UA0kKRQs0goHRTRKgdgsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8992.eurprd04.prod.outlook.com (2603:10a6:102:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 10:03:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 10:03:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 6/8] selftests: mptcp: userspace pm create id 0 subflow
Date: Thu, 14 Sep 2023 18:03:23 +0800
Message-Id: <058d5ccd4e9563f54e9bada2d25a7dda9d55fcd9.1694685050.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694685050.git.geliang.tang@suse.com>
References: <cover.1694685050.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 146b451e-5f6b-4d0a-b4ec-08dbb509e2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QPmwszP/oM8r+hQq9PzNhHn8RbyOXxRLZKY8+2Mzb6Y7txQ79QphKJcLRC9gGq+KeD+1/z4BEksUjVRRGK7vYZj9BXBrmWGFWAQirdfQjx+C4lOGLSWVbtXWuChe1FEVKpsXfPTZ+5upW/RSXbc2FjFMAZM3CgHIdDYTdc4VWLw/wkK95Vxj0Dn1xmz2JHiLX3ylZWbcJsGhMS/2CzW8gnI+rV98u+Ssd4LGEIgoe48IZ5fKTkheNGbzeDQZrEvY9AQmvrcfbzpGOWsk6Y5wK+wWHxAKN7Ls/i2icnHsy9xq5PO0oe6iQz/kGmU2l0Dxr2aGag4ONQrfZdbP3cfupVbJyWtViW4BhT9WQw9zy+v87KO9s1VGgzEYOjzTq06+x6oLKAioRWkuPDNubDMzDJTkFKaGuPAX4t0NS2DDtOzx+Y71grk6uRFbv1ZG9bXiPWW+Lwe0OnyWWaaeH1cy52nWI3OjGHVUjNMgavZsebq4+LeM8ZgsfYCBucRtZF9wr3ZeblKA6xMxq5hQSP0UCMTZej8GpgP2Mb0moXZ3b0HW69ACFGC+2nnGVjbjnKur
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(376002)(346002)(186009)(1800799009)(451199024)(2906002)(86362001)(6512007)(26005)(36756003)(2616005)(107886003)(478600001)(6486002)(6666004)(6506007)(83380400001)(38100700002)(41300700001)(8676002)(4326008)(8936002)(5660300002)(6916009)(316002)(66946007)(66556008)(66476007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QCfjdYtrwcxGShVJ7nyU1RwQidzCSS7NPNCji4cBcx6wZDtricXeSn0AaRjW?=
 =?us-ascii?Q?+CwMEgQbPtYo3lL9Yxc21hP/VLDlBXZUUrBjcGG99+2Sg2O/8uHT+eCRYL0Y?=
 =?us-ascii?Q?wDYRM8wnGIRjq4wH4a8msFOWptz2WhlFB6h8wR2Q5eZuqzZvHv7ghQG9b/aZ?=
 =?us-ascii?Q?pFXNfnUDDoa9HZ4m9Z1h+EuUW5yxwql7zdhLP+0dOzIJMO2dYmQi7Ve6kAal?=
 =?us-ascii?Q?njwn9iQv+anRF6esM/EUqZL0LQkGQHsHZyvIP8/1u1lrxcMPqqA1Olie4W6c?=
 =?us-ascii?Q?fdQlvXJX/KMIIYJhQfTUFVvU7AZlayGdFu1Av1NJIjoRN4zsLnd5dS09EgSl?=
 =?us-ascii?Q?mhHb3nOP640SLy4fAXyMqrKS86K3QmkEqAspe0flCA04ZJeFfl7R7Iqtycw0?=
 =?us-ascii?Q?AVaTTWeZyTOgQaOiSt8NP68f63QZlB7S07qOWEOX/9e4uGC3k8QHx/+IRYq0?=
 =?us-ascii?Q?EpvqUm7Be4Xh8rK31t/c9IJkZA7MpxEK+5zd+KzZZjUgvfm4tFzEo/dNVyx4?=
 =?us-ascii?Q?atJU0zEpfpKExjOyykGIJ/JaqDoiznowqOYIn5x+5NgjdjljbwfH3tQ4cXqI?=
 =?us-ascii?Q?IpxneSeAcSWDEDS91lPJlsL2z+smNuvY5qmoMjSTTmIRCMHTZRVhXv3N8M8G?=
 =?us-ascii?Q?k1Q9oII8WH/9Ls2MVuokay64bLYqUB5FB5/HillN4WDMwJ5ylc1a1AXs5gdD?=
 =?us-ascii?Q?Bfeo9nlIK4LiVOMDW89orZ9kzK5myS4hPBD/dcIm44UM32eAuGe8IhVFlaae?=
 =?us-ascii?Q?fudDoLvjpFQhiXzOH58evkOJaLJMuu2w8NgU6HO8c7BWT3NBGKBl2D0dR10Y?=
 =?us-ascii?Q?AN5TyPhsORQ8Jn2Nm2Mav1kgn0GT0w991pv80nvQCeu6oCjLeDCxpM1T7UW8?=
 =?us-ascii?Q?kCm1/OBqBcO4QA+reNLhRtX/OiT6vXyGbTgsHxdMPSOV26PvhrNJAp2NSsQM?=
 =?us-ascii?Q?ru9RfM1GGpPGx9Yt9KBx5ierQ+r6h2XHO+iToqpvCKR/C+eIOlhREru3e0+e?=
 =?us-ascii?Q?S95UW2yKvZZnEffyzXsGdRkS9eqqhuIcYUdB8r68wgf9X0+vaZakPPWidei1?=
 =?us-ascii?Q?QD/jYELybYuh+/CebXMTYatPnV0O6oCoX5N3eJXLBJHjykERryqo2aSG18b3?=
 =?us-ascii?Q?2ncWDalC10wY2PDyenkPhtrgea8RuffeROtDmfTotcLTYoeZ7JtrmEhWvw/a?=
 =?us-ascii?Q?5Zl6793cvVxwLjNKAucQl3Wi5A7ryrY1kxhNLuDWanEE139fyTB3Ed7rsxIO?=
 =?us-ascii?Q?MQ1BC71c29QoxyHPqx1CW+WGe5vwfn2qOXKzYsI+WBmGNvsveWMKre8UFSLf?=
 =?us-ascii?Q?TVPr8U6tqYjA0nWZ0nnsbLb0jQT5zsOcr206QIQJOAq6pmg/IroDcaLT7pfP?=
 =?us-ascii?Q?E1kSmtYRpI4wvTZnhY1TKKo7L10K2Q4S7UHx7KS0dZ2lZdP5oaHLAPUk5aoZ?=
 =?us-ascii?Q?woIVc1TZknMTDqPv01ZqmIk/C9KNendO4yB8QURdXnXd55jWtxZxaE8nV4kw?=
 =?us-ascii?Q?XGBpetx3BjdHQWbrz0Fpq8Mh/lFA3rHXMF4YjnnGOV00FnigWChxppZQM1Td?=
 =?us-ascii?Q?5yIhWcVYk1Kv6WUaJxFtoDlPvq5tP6cm2ozQkJXT?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146b451e-5f6b-4d0a-b4ec-08dbb509e2df
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:03:47.0197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+N87R2iCenOi0O0dVzqQbW5wRhlzilQU5Mca4/+Jr9EF8QTEtLk52+S2gQPQCIG8NoBu3QKlq464mVn/nlf9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8992

This patch adds a selftest to create id 0 subflow. Pass id 0 to the
helper userspace_pm_add_sf() to create id 0 subflow. chk_mptcp_info
shows one subflow but chk_all_subflows shows two subflows in each
namespace.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9c3ce3a14804..d2c458676068 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3477,6 +3477,25 @@ userspace_tests()
 		wait $tests_pid
 	fi
 
+	# userspace pm create id 0 subflow
+	if reset_with_events "userspace pm create id 0 subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		chk_mptcp_info subflows 0 subflows 0
+		chk_all_subflows 1 1
+		userspace_pm_add_sf $ns2 10.0.3.2 0
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 2 2
+		kill_events_pids
+		wait $tests_pid
+	fi
+
 	# userspace pm remove id 0 subflow
 	if reset_with_events "userspace pm remove id 0 subflow" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
-- 
2.35.3

