Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2052.outbound.protection.outlook.com [40.107.13.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2888518B00
	for <mptcp@lists.linux.dev>; Mon,  6 Nov 2023 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SV+wQF3l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQRjQJ5bYylI4NCr9ESlUO10HYqi4pQQu+tnu0qQ/vxDl+e8pwJl/Gv7eEs0Jg5F3P5CQsJyNNrQdSl66WhUbUcjwR6JbVuJCIl4vKedRW425BV7F58RlbR9zNCzJ5XDNbGmeJxhrkrKDlc3qNdk58NHaT9IGk5N5MhFPgp3oeC8U0zhBVImRp041sW/GYx5Xf40P3BToAghL7EmWQYsodw/FGP7Q7Myf/pLlx3o9wYHM3iLhU90IvcLpWeqKj8Lqs9/SFHvTj6EZIGh290WETcyfdbVC1DHJHBnH1g1JVR1+1LDvJNk0zjFhTiw03eym5vaRYX3cnp/1CtUa3wkOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K56t4ULDdKB7yWpep21QWRKgDWV6B8nHgjR1TjrD0FU=;
 b=jbttypXgGmiieBoX+DFOYUGyqPZGL95DdAdOaFTRb6F1TqBlOiJuqiPfQdUQ2b4e/vr9PwvZ8gIgHEPZQJdK5ZGxGuWAruoutoqO2x6ks4v1kKqwb7fO6asSlVcCLBe3TnKsbX/HEPxS2Hoz5zh1+ZGznbv5ApNwJSsvNBgYVaRNWyCiRJrIppscZTHbC2v+GI4KKcIQ2yLXoGvBCqBX3sx0rMxe49iaoxpeOOfLbckdaO64YuOXnHK/FPyfdSgueg8W9MCPoYfF9/XIRU/KUsLF8v4q3pHbT8lnR+kRJINmX4gTd8r7UkcGbuPJt1qtkOPsnWBm9xJoQ93VtcaORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K56t4ULDdKB7yWpep21QWRKgDWV6B8nHgjR1TjrD0FU=;
 b=SV+wQF3lQMqCnd19sePE8wRy7dib7vziDb62GcPhfjjaF6w3Qqs2OSTKoZyJz/vIkS6w89Em4yeMcrN4kqSlFuCLu9yiBk5aH7ZgpJKwEqBboE3/mIqZS+K97AlPWylXleVFbhFosi2I2MAwln9/c1iO/2CHgjMeS+53hba26A2emxiUtT4AG8N2ZpTFh5u/5PU3gCPpVts3ushDpvfHm81G8mfeU+2xbmB7PSDIl9jMHlRy0oucL4Pj2K7LzNhEQEJVQPAADfachUzUkw43FrNtwngileun9B59MDItuZCysm+qGYIq/YG+yhyo6BQ8nblr9nq/JXDf3px/2+XWZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB9078.eurprd04.prod.outlook.com (2603:10a6:20b:445::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Mon, 6 Nov
 2023 12:56:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Mon, 6 Nov 2023
 12:56:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add mptcp_lib_get_counter"
Date: Mon,  6 Nov 2023 20:55:49 +0800
Message-Id: <7cb131ce1dae4445c05b2955744c63a2d8a1c058.1699275225.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: 092bb3f4-59b2-4b63-a356-08dbdec7b8a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hbuHTpdKvXLGE/XztD0+uyCL268buKrAVCcW1sYIjLkjUCloEbkMCe0gRClrExzreCPaJtqKy0M9jkSLFlAFkbU1gcyecM2wBN4zf+6Mrp/eUFIUjYiAaWDSamr3mJWiWN/1GmU2tweyBNOhiy2/0ZYVPlqQvvT3o3sAekrDafA8hsqMSJhknTWICCoIjkMxfipBuJhIcyMtl9D0YKC+l6kHgk41Fich0e+Dg8ZWR29bp3Itv7kJjLC0WkJnqnE7LYECIVhQj4urw9iBawJY208mx2nBLb7U61sq3qB8w7VZoKhh6z6QdIlxbCObcTMW498BPuNpL+7uCgQ3bvOHm7KEoxfQXQFvBV1At1yfgmAi/Q2OPhct6oS6O9szHw1CGg0/sIBj5J/eGqPS0terkwTxGeklEJE6NIJNR2ef6KQFwM5RGj5w1dNFoay396RnS+uYMtow498PxndpK4ovZufeX5zR3E8kPkjbdKgfXCxykf6tToZWa4/csPTa7xD9nkEGQ+e7iP5BPGeT+fGKzjQGCiXpF+11pmiU6jbi458LjE+xYuSeX0ev4xG62req
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6486002)(66946007)(66556008)(66476007)(6506007)(6512007)(6666004)(478600001)(36756003)(86362001)(107886003)(26005)(38100700002)(316002)(2616005)(83380400001)(8676002)(2906002)(41300700001)(4326008)(5660300002)(44832011)(6916009)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WOiDBYIhkhvJnoK9REHhgZ3qYBeDyySkRzNO2wTsaB+utfhMjleVKZWj2dV0?=
 =?us-ascii?Q?mWmytD4vgtf5Hc1j77OM0vT2DSctLuTEnXhzOSMDXVKwPIbc6ZWPcyofAS5x?=
 =?us-ascii?Q?iNkBd7pRXOi+H4KlCopB4T8g4wJB3buFPq5G/GEPMTv1UwzCqKH71v2JYkVW?=
 =?us-ascii?Q?yMFUaAiLXEScCyhXUZdwm7dkQUZxLYj9HWlW5qHKJGvzCX2n7EdUy1/Tfxau?=
 =?us-ascii?Q?pgdSzWkctNSGpmd9lxjBjsX1bKOAEDvJ3Ovlv/Ki9zoHtehckIngLpTRBXS6?=
 =?us-ascii?Q?zwFB1dyc9R1X9dmwIJyqou99FVj9pFSsQ8ATZk4WSxnE9J4yfR837c+Ifbcw?=
 =?us-ascii?Q?kq7jpAYnuoJd9K3VD9boKJ92e27wxsWJX4V+4pLR8skEezarn3g7pEIKYcxs?=
 =?us-ascii?Q?HnRLRlSgwUaRTUj+cb0qro5CMefBBmksz6Y8FbZnPaWpmjm5x6RJVE2sjRn9?=
 =?us-ascii?Q?cYJ7wA7C4WpmHHKDZ+dTMiJ9lEVXkY5NlkRNg1I5zW/LCIe38faFOx99VfaA?=
 =?us-ascii?Q?IEQXVX5BUJi0qBci+ri73cqp8wdwVM3ci2uwCu6qduqxewSFF786Onpix9H2?=
 =?us-ascii?Q?TJF+9WM7+Oh2j1tmVEJgGBbweQuGIZ9fc975nmcnS704v2BeqnKXeQdX6iVV?=
 =?us-ascii?Q?1GlU+5A9W7Ocz7BrSKS+J70kofUC8FI6ecoV8qO3epS2yt8bTD628u2bPQzL?=
 =?us-ascii?Q?cJA/+FFB47UPM+CmQtUMXdeHc8r1XGuBfAKAUsMOj5IXbJFDMiYpkEhYRxoG?=
 =?us-ascii?Q?6j5GKMEtTpxbnBBsWYn7EwIzoHCGtBFEI+v9ZG24D19+gbgP6q7/GAMu2Qw8?=
 =?us-ascii?Q?/KqVMWloek49IeAmvioXygP640ulSmp6TNb5s2JimIcvrHigeN1yWpyyKfxz?=
 =?us-ascii?Q?Cnx+6Cq3HdbLIsD+efYXxp0fjYI9n1Nca42HbgbDVkVHvfWWtXnIddiObqqc?=
 =?us-ascii?Q?zTVk+7XvkCxfFVcv3KywctzabWDEzOHB+09GFzpDo4+WnR2qi65bYIlKmC2C?=
 =?us-ascii?Q?m0gJCn2rTdYM1pSIRTJLnuawYZtFwtZWtZZ3gBm3acg5v8gPwbBh6Y7DUKEQ?=
 =?us-ascii?Q?idqDwObJYkEEP64KZuRkMHqVTaovm0dnQUV1lDDcMwq2Sc4osRIFdmd09v8e?=
 =?us-ascii?Q?qJ8Gcrwr0o/Wbu/EzPxkB57DOCYZiDQ8cAGSIhdyaNCudyM+idFu3W+IVwpJ?=
 =?us-ascii?Q?Ql4EM3v/gWSLhq58zWQbJUuajidJ+hQkRJ/kdI7dHTYY/x7C01YW15cAmTZK?=
 =?us-ascii?Q?NsopqNc1v5r21ZM6o+ii6LGbkybBFfh17Z+FOEt7mMtWZdIAYmRg9KjEUnxy?=
 =?us-ascii?Q?U89gpC3kaCJvu+R3Nb7aS0hfnqJ5LduFJZsBklpdj+x0b6PBCZcSolaXaMu8?=
 =?us-ascii?Q?GbOiDBnZsidA74kw5/bf13bmB5g1PsrCfjk9Rw251WO7xq7q+iQDdq0txDIR?=
 =?us-ascii?Q?VhTcorkzKWtbm8ecQQs5+CkHk0ZfB7O+3RrKzIJuSR+uHxETDrRjNHivFAeE?=
 =?us-ascii?Q?vHpInG2q+pyUldGqZSyVI3ecY7y7JJgpnzo9wdPGizias+Kh89n4Gr63FBBq?=
 =?us-ascii?Q?HRd+QSvnHQ1jyNq5hFVT/OmlKfaHOuWx59FWuQdB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092bb3f4-59b2-4b63-a356-08dbdec7b8a8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 12:56:00.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNbbMcHtpFyMvB2SA4esYdUW8Pxi1b856rbk3bePHx+JrU7MMgzuSVHbCYUdE8ViamflNR+hy0AgOGi2v3mqOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9078

Please add this line into the commit log:

'''
Use this helper in test_prio() in userspace_pm.sh too instead of
open-coding.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index f9156f544ebf..8d95ea94c019 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -874,7 +874,7 @@ test_prio()
 
 	# Check TX
 	print_test "MP_PRIO TX"
-	count=$(ip netns exec "$ns2" nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}')
+	count=$(mptcp_lib_get_counter "$ns2" "MPTcpExtMPPrioTx")
 	[ -z "$count" ] && count=0
 	if [ $count != 1 ]; then
 		test_fail "Count != 1: ${count}"
@@ -884,7 +884,7 @@ test_prio()
 
 	# Check RX
 	print_test "MP_PRIO RX"
-	count=$(ip netns exec "$ns1" nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}')
+	count=$(mptcp_lib_get_counter "$ns1" "MPTcpExtMPPrioRx")
 	[ -z "$count" ] && count=0
 	if [ $count != 1 ]; then
 		test_fail "Count != 1: ${count}"
-- 
2.35.3

