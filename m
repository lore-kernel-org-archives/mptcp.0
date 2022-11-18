Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6D17C2
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 02:21:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+0tvRUk3KgRFBehm396RN6RrMPnzVJykI2v32JJZmr4NykCboF6UnJzabE+cpxRZd9Zsk6vIpim0y32aNXnqOr40aWc+TqiXfYpcMmt9jJrVSXXtdSFk2W9pP/6LTrDTS5Z9tpGdJPCW7dbi8Rls3YKMV3JF+q3o7o1YKkJ8l8XX9fOJu7NFFfPLegUPHWb3ECj8TOYgGe89PCiCc89rhjmqlbZIEkNmzgcHREJ6N34RimfAn4D9m7aZMrR3hI2CG1bcZM11SZs1kqlNuXkEVGvOlFfSqXItqXezl6+yJYIywSldeXx9Lkmam9K+QF4LM3+Lj647WE0ElLrITIeQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ONX7RL0JA6szMz7PDJ/UHYzbaBGTjWWuEG3aUZlMII=;
 b=JPVryabUFBlzh2eXrGNsIE5l+/gjY7jltzPAZ0OVpBLVqhqxFi8UY9gYJCYTRajqL9hNKohEwyKAHSIHc8yo+3yY+jJQVtCgTqay7J+U8PCA0oVxqXtZk/S5HWAjOHfxHWZE3zOzC20LeUVBjEAZsswTK18KaGwwIabQOVJcVUIoImZRrKXo5A0ZQwOIAzHkfqPi/q2fO8Q2QdnLmI7a2/y6Hh/ftQLaCqJabT3VXFeJ13fAAMzYIsskb9PQWsYNCR//SMasI3olMg1pyo1rbbI5Shr1cKdnPUaqGeIJkc1A6AMHRm121nVEftH77DG0OlrWf2L6LJkQLKYSIMpLGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ONX7RL0JA6szMz7PDJ/UHYzbaBGTjWWuEG3aUZlMII=;
 b=CLlHKcuIugnCJUdLEYAKz9vJwnQRwHWhN0lsCHSmzW6LSC2zKb+IE9J7hd3cPM/WOsFCg+uG+NB7pZ6EP6n1XNILkcsbC5hTAVGJotmZZsHKZ2SH/CnXQ27IHKu8VVmJ0CM7ddGJfBWGNrVI7v5CW4eVJgzsmamjhz2pii0MDAduSXzyALAJqkcV/0OqjYMRZixVXTsAPzMRiiJMLFzJAca5NT8CdWMxfnRfurlwacznH+ISWIGP2/7UQbU6mocq0W4eCgZC44aVeTb1rL4Ty6rCtYVUcNTXadXDdqtGSXIwa+1M7Q+I0DKCXVNY0L91wLfBwi2wjEwnInBAqCLMKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 18 Nov
 2022 02:21:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 02:21:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: delay updating first_pending" v20
Date: Fri, 18 Nov 2022 10:21:50 +0800
Message-Id: <20221118022150.30520-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0004e0-f3f0-4d91-45fb-08dac90b9c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KBi43eIshoc8NNBpXCsf9t3fn907+2kNQMSMDb+Jzeb45qGsfmX8fy+0drnP3Jb119XkGk56PFQK7DGXlp2n1G+vkwH8zs36Y+x4JUQvgyC3QVKe7+Zx2XPj/rI/7Ig97VXvDkR57i0YWZa0snTiivM4XqDl+FfMn9O/woeW197vcVAqznrhc+55sHiSdtt9UyagSr5Q0YBDn4haoyQ4NksQwq9dmQOzT9RS7iyTzv6QhglmIbPtMiZPEC/HGggPFG4vT0xmApKFMjUbWsz6mCyYbN5VJFkbOyVLciN8WraF85QnHoVTeuUkWdV7y3y+nhEh91SG1yHm1B0DO1sx76YKfx591sjxcujsuGi+YMTJT5pt0wbjaUe1yJHT04AzBtUTJkOKBXviT3rejyN0DHg82fsTHyq382fRcMzuPdSXis9e3Yyt5hop930Pa9k3h8wyMKgT9BS2RNOQ5aTVveAbTMoTw7Q46mL4cX+r0lBy2G8YU/7uVGJPPyGyxFt6xecYzc92Ezb49ljTIAh5pKpAsfmhH+Kaz0R0q9wadl8kMwIUX8SlHxK1+BbmBzabp2TJ7mZiIlNOcEkGZu+AMmTDCYRescBDpzqaeY6z2WZEGj4p0itqwmHLKJSnU5HN9aPwNpiiU503RmA9ANpuVQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199015)(2906002)(83380400001)(36756003)(41300700001)(66946007)(2616005)(86362001)(8936002)(38100700002)(6506007)(6512007)(66476007)(6916009)(5660300002)(66556008)(8676002)(44832011)(1076003)(4326008)(186003)(316002)(6486002)(478600001)(6666004)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZbYRmsC1Mr6kBWgiytIO2iaarftOhBWJNw2BNaslYI3/Mgigy60x66KlO4rs?=
 =?us-ascii?Q?hgg0plfUsK9v2iAB2+FBVjooXA4CnYbuiJBnKuUO2FbfYdN6Gnmg6NnE+GVw?=
 =?us-ascii?Q?i77eQ5OtN7Ax5AH9O5MzsdiPI+pMIp8Gfc5HSL9FHrA8JQnGFriKcJX/0MjN?=
 =?us-ascii?Q?yaN6+4d96GtFEQ7tPS0r0mN2IPKT475U4J3Az67K5UOdYOEV+8MN+GYBK9Li?=
 =?us-ascii?Q?NBxdi7OwgP4KYSI1URE6AyjbKZDGUFUrPPhsQc1l0aDc/wlqNAPab/27kOZa?=
 =?us-ascii?Q?IB5xkOsXT2js4ZvFTd0+rRAAboT0YuPyAttz9xNzGhHSDOFBg0DFgL62DKyR?=
 =?us-ascii?Q?W2Bsqra74VjNVdAvcbLD12DKBjCPWBITKofJe9XMLMT+aerQueYztl20AKlP?=
 =?us-ascii?Q?lwlVPitbE0+VEVfvyTMGlEg41rR1DmmK/jc1LtowyZ/dQrtG9e0laSOu2hMQ?=
 =?us-ascii?Q?tKfk1sC6Rmsa/cLS+3KUHI75PrOdXdCIBcgOvFqP4xUGpUNY9aUyqS1vo235?=
 =?us-ascii?Q?rGzvWPob1MWWGVam4f7zipcxVHORbYsn4BmozAgliy8sH4eCc+qYbzBOVh/3?=
 =?us-ascii?Q?9hozRj+7zFJ7nn9Eaf9dq0dAlHXk5vfx5al0W8TF0jD75K8INinPgQEuzW3F?=
 =?us-ascii?Q?XsDtUq/vEj8TVXExFH+XwE+lHWU3NwWcnBZs/9Qm92v8f3k6dxdAj+1vNSUy?=
 =?us-ascii?Q?Cpg7K5LzxKrKeJRCni5MFROEXO7nmgVVFoX7p6mNHrdMuY+WPS9GDS2dd3WB?=
 =?us-ascii?Q?+yNWP6ZjY3ix9mgXrFpojGQgsLYG9LBYNeBbZL5YAMPpMrw7xXC2ksFfO9aW?=
 =?us-ascii?Q?0F7rTMXpM3rR0JrZihvIAR5leoChi1duRuGrfOsSV4hMADb4L9z7nSFyKc62?=
 =?us-ascii?Q?kLIGTREH8o7fJNBkBiHvgjDQ0oCCQAPnjwSNQ471ZImQpt6smx8jZwMYAErv?=
 =?us-ascii?Q?1r5Qtn4fmz+3RU1yX0ybEVt89XvtizxII7uUdlX7gEhCh3DMMYFTDwLc/ReC?=
 =?us-ascii?Q?XIGSTvZAahbGQxLvAlDci8V9udlZMFxbl2F3WdKTmt7KiUYWfrZ12dFtyWnb?=
 =?us-ascii?Q?bkRzQvM/FJIa5C68zyBdLXafOAdM3CWDd2a3VwJxBkv6Izr/mIENTVM8vVtG?=
 =?us-ascii?Q?BpYbOCn+DI+1mXA7Rgjys3rf7HBRgmWtUHnhBYiLSEeYci6nKiPhk9KDrEGj?=
 =?us-ascii?Q?9AhyoSGZ0SAi8dqsdI1CpkD+e80gcufJnzeG96TT1B68CSisLKOVxaaerunz?=
 =?us-ascii?Q?Emg4zPyIcqAVsJ+QLvNrz7H/CxP0aVOCJyKqQrs864AFaYbNhQIzDqnHhOLZ?=
 =?us-ascii?Q?5Gw0/qL2+t/EpMqHGZ1pAgD9pcpEfu+9HHkKt1L4TLuckyVrRvW175ZOr+zP?=
 =?us-ascii?Q?bMRpdd/dZlspGebYJKPM5aRM4vs/ooePACRksQf+0YlyRos9rXSLEfnaGJkX?=
 =?us-ascii?Q?mrCV1TErLNB7QpfDqT8ybQOZmqtYnznBIZX42MApxYXFlVAEkjHzVRYSVbHE?=
 =?us-ascii?Q?J+IjJ4Mhbu1OxpvDEQ3Cc+bkWKLeFYu3nyhLITkMCVYsawGFHAgCezXU5M1m?=
 =?us-ascii?Q?HhQAycmkkVT7xj+Wb7DlnKqeHI7pEaJOgnWjCooIHy+mS3rcJYVlgFHAMObz?=
 =?us-ascii?Q?fJ9yEqIGaio5S8ApRGf0U52YcOpt+JwGwcA5huJnYp83?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0004e0-f3f0-4d91-45fb-08dac90b9c9d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 02:21:34.0253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1Dpxb/WHKOHAAITlHup6gBs/gWCTKlGoTYTr+wjfv5Cgco9bafpW3xFD3DiSy10Tm2RGHaJbxLoZLKHWjZy1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

Drop mptcp_update_first_pending() helper.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4c249d1b9ec6..6f90c28f7612 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1503,7 +1503,7 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 		msk->snd_nxt = snd_nxt_new;
 }
 
-static void mptcp_update_first_pending(struct sock *sk, struct mptcp_sendmsg_info *info)
+static void mptcp_update_dfrags(struct sock *sk, struct mptcp_sendmsg_info *info)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
@@ -1511,11 +1511,6 @@ static void mptcp_update_first_pending(struct sock *sk, struct mptcp_sendmsg_inf
 		WRITE_ONCE(msk->first_pending, mptcp_next_frag(sk, info->last_frag));
 }
 
-static void mptcp_update_dfrags(struct sock *sk, struct mptcp_sendmsg_info *info)
-{
-	mptcp_update_first_pending(sk, info);
-}
-
 void mptcp_check_and_set_pending(struct sock *sk)
 {
 	if (mptcp_send_head(sk))
@@ -1608,7 +1603,6 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 				ret = __subflow_push_pending(sk, ssk, &info);
 				if (ret <= 0) {
-					mptcp_update_first_pending(sk, &info);
 					if (ret != -EAGAIN ||
 					    inet_sk_state_load(ssk) == TCP_FIN_WAIT1 ||
 					    inet_sk_state_load(ssk) == TCP_FIN_WAIT2 ||
@@ -1655,13 +1649,11 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 		if (first) {
 			ret = __subflow_push_pending(sk, ssk, &info);
 			first = false;
-			if (ret <= 0) {
-				mptcp_update_first_pending(sk, &info);
+			mptcp_update_dfrags(sk, &info);
+			if (ret <= 0)
 				break;
-			}
 			copied += ret;
 			msk->last_snd = ssk;
-			mptcp_update_dfrags(sk, &info);
 			continue;
 		}
 
@@ -1682,7 +1674,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 
 				ret = __subflow_push_pending(sk, ssk, &info);
 				if (ret <= 0) {
-					mptcp_update_first_pending(sk, &info);
 					err = 1;
 					continue;
 				}
-- 
2.35.3

