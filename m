Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2F2653
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBy00WMl2fs8jHdKjn5EdBp2RyA97pk/JZZNFomN0HfW3iwa5ytl6gn/kEai5yxb1vkXrydx/b70EZ0lP/ity4Azlr3skaCF4qrNDZ95jomVgCWog7SAIsVnIW/0vNJ4duaQanpK93ZIBTMQLdFkPlG/9YR6YfRs1qKJTFjMvYQsB3TzX0Wo19Za72Gr0bMAf9J1LHT4b0W74vsji+eSAbxuzwOI2O0iloZdnRYj6fTPfKYpDwTafiKRrhM8JEk87a6AFMRsmGebCMFERYaSMfHy2jffRN6aS75Fsfs0SJEah4q+ZHkk1jbBnviO9fcQYWqOpMrD1RyqMn9ZrJK9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfqLHoRnCfAc8h9j9OYWobyPWG3Z626ofMhUd0y/ZHo=;
 b=VZlon32EtSgOEkb4qioYZbp3h5xYM2GhCiqpC0zgpChegAexS0Dc2aA0v0+LbXVBJ6zXT1p0Q0ltqaftCYuBSkXFFMCaatxpriXjMVrftWD2x1GKfe07mLcxxJuQwqNeBs8U/n2fvbSCwDfy1iSUePzZztlDs2fP2HPoW+l4nmmNVZsdgU61tioFPtsx1XbBxVuBKA2cBUAwPa5urotxlRIW8VdpR15gGCKvGHd6MBgLwLRop265JiItfiiFuv9m+nPccS9zPLa2MVwCRFneVbA1qqN04ePQSwaPOiQ2G+HV5lCSlN64Cw/rrHVgB1pnZxsdny0jIiP9/S4TaY7w+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfqLHoRnCfAc8h9j9OYWobyPWG3Z626ofMhUd0y/ZHo=;
 b=lssndo75ai2j8dQey8sPkaPrfhfAISA9A4B4tXzE9FSOOC0otJYmqKyx8zqwwypZ3ZujE6j1Fqkg8IrXkA01xKDGKWfePSENlVMadGFFHVE13AWO/Yi3nKfsPismnexG0ejH6c8qdRyVTdgXnMH+yRjcqWdMgsJxQvhG4UAAl4AK/mEDDTT2Zp9sbTdvrj25hgrNY/EOQAibgwEvWbnTXlW5d5NB2XiB0arXjyO9VaaNOU2uYaZ7DQL8uK9LGjBabe2XbeVc5QRxlbON7k5eCRGenB4ZBOXtD7mkdgfeeLcFgMQf09kT3mJcFAMV+q6OCa1b+9S26owIcoxGFuSgdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9777.eurprd04.prod.outlook.com (2603:10a6:150:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 08:40:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:40:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 11/19] mptcp: rename __mptcp_set_timeout
Date: Wed,  7 Jun 2023 16:38:26 +0800
Message-Id: <77d5821d9815607ba1ca392e9bfa100675bdf404.1686127032.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc25fc5-a512-4f83-d00b-08db6732e2f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2OoKJOOCSwuYdb97FgJCgDPelRwmi0Nkqyn11F2xYj1m3YC65Spp3CRK6LCDzgzJydACvcXrGwsS5siyLRRYL2+4WI86+VwREl7VRashuZMTKGttORdd6VuIXaWukZFzIBsvd8ea5fFsum+CUvIHmmRmqtz+4qRWsFAta0bhcjvzbufjHV9XBuKCApV8XK9Y+nj1O1FVIgdCbLYz4NAJ/A0KYgnSnfqNZ9TUbamJPMItRJ55h56yvQA0U+iIvb7LX46H7+ePDqBTsp11c/iBaFTV9IdpoCdXpGOMkV2Nh1Ka+ifam11Gko9E+V9KmPQcxBaujxgxEAQ+4yCKnPT7hGtFVms+iVzJNP0auM3Fkx+v+aqhH39m+cT/WbhMvCX0QX8Kd81ZO/ef9y+SgwVHRY9Ios/8gIjnXWN1+KlpmX4/MKai9C7Ec+WiZxIfsgYpMxcKqJZspJ6pw+Vcig+rmNTK4HT+FyVXhn5FpztMdOF7pXu6jwaDEy9hrqoik5HtaS6s5l34xRFj+zu4VaUbtyqSevgbL7iQxNXnF9AYOFcfT7HJd8+GxvLfMeHVlr3w
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(44832011)(86362001)(6916009)(4326008)(2906002)(5660300002)(41300700001)(316002)(66556008)(66476007)(66946007)(38100700002)(8676002)(8936002)(478600001)(6486002)(6666004)(186003)(6512007)(26005)(6506007)(2616005)(36756003)(107886003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O7RqX7hRXnlqH5UC/CmvEw6PEtD4PdFTMW9eq4RVQmZcob7pYz19dTi6FoQz?=
 =?us-ascii?Q?RSULusn4790jUlhqCbpjIpsXC7tdy7vaUubtQ1ZznOi1zeISlm8nI7DPiHKB?=
 =?us-ascii?Q?axEpzVPhg37zZlEbbA4wLLWUHoVSn5viQTe7F+3qnyXubHltN9o3KGu5TKVt?=
 =?us-ascii?Q?hRrbxOZ0xWd/WLkX+y3T2SK85VXdCLbZqbPA3Cx3+16vY4pDhMRhotqhkpqM?=
 =?us-ascii?Q?W7M5/1A91AyjxsOKPCH6Po3a5SzN6wPvBY41jXQuWo75arNR0Ig6i/WmSpuh?=
 =?us-ascii?Q?C6VT8maElifujCv4NTY/C1X7Q5b3oFe4EvhFUNQ/fOqyAKVMWzJvF2hsrTvi?=
 =?us-ascii?Q?+8YDAfSQhtLEE5BAD/XPQtjmSUtWn1IKvgxdwtJ/4LVlutnD6Ubp5Zd+qYfe?=
 =?us-ascii?Q?MiArHZoEFnADCGxByf0438vZmIMlrYdHeMf80XjVivAklfPSsq00uMyu6P8E?=
 =?us-ascii?Q?sWiWicaUeG4FSmQTtswUUCmAngeStc2HwemwYi+4V2brwMVrqaSBRmswTnb7?=
 =?us-ascii?Q?4xFJw60UZukNkeehnzBhwycra+16OBg52MASR9CXG1YwanVAOcXG9jjdcw3w?=
 =?us-ascii?Q?8jPxHnAX9dhPIDLc2SRtTZQwiVin0c9355kayqXxVpWxexLD1R0OUJG34BzK?=
 =?us-ascii?Q?vvBm0p9iL/Iw1Qd1aJJ8qfOPIryj3CF4jz+v1s9diHmAg5//+SNlYp99/d7n?=
 =?us-ascii?Q?n9qEgpI2LHfJwalHWYMxYTrfnF7z2Dx7RpPngvkKZFss3lz9v9FSqDUuJGT7?=
 =?us-ascii?Q?7nl1g8r8Lungl4put5ViaL7tcRXBxb2yPD88kc6OvVYKFQUpofXL8//2lxna?=
 =?us-ascii?Q?Ntm5brZrqQwYiFzlM0Mn/sznNUyZqkLoa1ba6xJg/K+inNKsLgYMinFX8v6m?=
 =?us-ascii?Q?I2XIGKxWmutl4RZxx43vxfxRcDHeJzQUu/c7FmYUPkANljV8kLYHBw/MBwHf?=
 =?us-ascii?Q?NJwLDxNk9X4eMhXJPHRpuxtvthN6em9mO0XK4yiuYxCchoBRUYAQqZQ/v83G?=
 =?us-ascii?Q?c65Y6pFmsNWvAaySBgUooNCx0Q3D+o3+rkw7UJzWrbjI+GNe1V3SPKlavKpJ?=
 =?us-ascii?Q?bIwAnl99/L4GZAPKgEGsWlKIM6JJ6+ov2oQKg1NC1YTYNmfPsaFFDfuuCK+M?=
 =?us-ascii?Q?qrbu0WtlSFwEMFITnpuQgt5qZmsex0aDJOOXdyezFCXldqrfWxRhCh8R0PvR?=
 =?us-ascii?Q?wS6P1GcF/0I9Dn/P9QhmpJzbo60K6Kn5DCUwXy/WUZmT0Yt1jqWXZbFt/LIe?=
 =?us-ascii?Q?DwbiWfdnYLJEDCctK+p75V7u1jtgkFoNXR2J3xMcgBXpodtOU4jovY9Ew5Cl?=
 =?us-ascii?Q?qDNBicoYObFELSfx4gbFLgoySCQWIAosvF+ENfiZd2vio+si22ejBuKu/FiP?=
 =?us-ascii?Q?OAkHeSCq5bphgKsZbriVpFeeG/nVkSGz4/qbpZcSS/CXtD2pXDHiE+ADCi+o?=
 =?us-ascii?Q?cw/w7OkOI64gr7IfR+bkao6hXeFagk7uYJFntkm0WgkIbWKm12UF5FAIOnDF?=
 =?us-ascii?Q?Mys6PG0sRWyG9eCKOjX7X1sjKJ/XmDdw/s2RZ7F/jnFNaqTGovizqBYcTL6T?=
 =?us-ascii?Q?pj6GowfT7kI3QUMeYgBY59034/utBkO52sWWla1I?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc25fc5-a512-4f83-d00b-08db6732e2f2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:40:45.7795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IE+UFx6nfVMGT4zYaDX9FVkUrJbD/iDCyMifY6lvVErsTUZ+53WtpZHrwQsakRhPvzBFcAmSWnRDG6BVv0vP6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9777

__mptcp_set_timeout() is needed to export in BPF context for bpf_burst
scheduler, but the "__" prefix cannot be used. So this patch renames it
to mptcp_set_timer().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4a17cffafb58..887997fae41a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -485,7 +485,7 @@ static void mptcp_set_datafin_timeout(struct sock *sk)
 	mptcp_sk(sk)->timer_ival = TCP_RTO_MIN << retransmits;
 }
 
-static void __mptcp_set_timeout(struct sock *sk, long tout)
+void mptcp_set_timer(struct sock *sk, long tout)
 {
 	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
 }
@@ -505,7 +505,7 @@ static void mptcp_set_timeout(struct sock *sk)
 
 	mptcp_for_each_subflow(mptcp_sk(sk), subflow)
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
-	__mptcp_set_timeout(sk, tout);
+	mptcp_set_timer(sk, tout);
 }
 
 static inline bool tcp_can_send_ack(const struct sock *ssk)
@@ -1455,7 +1455,7 @@ struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 			send_info[subflow->backup].linger_time = linger_time;
 		}
 	}
-	__mptcp_set_timeout(sk, tout);
+	mptcp_set_timer(sk, tout);
 
 	/* pick the best backup if no other subflow is active */
 	if (!nr_active)
-- 
2.35.3

