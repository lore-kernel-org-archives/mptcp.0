Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60053.outbound.protection.outlook.com [40.107.6.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0554E800
	for <mptcp@lists.linux.dev>; Tue, 25 Oct 2022 03:26:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iL0SygwwehUYAovVl489qTZYUu2cyZNQ6Ex4rGzszHIXPwJHajCk0k/Yi8iBZFaVAxa/vLI8zl4iOcRBwPP+RW/BPOBk5BilhT3Nw2OUTheSdKLFp7bDHxkfmSjZI057UmYfZzq2lj6oEZRSTjoAfEulSVeLCcnc0qB8u3AbPwKO10iSoGwULpzD7Vi7olHNQ1hsfNMC+K4AyLVlO0R8AICvkugsGKdx2J9KFnLsyK0oLhHmsp8n9RSih68j+yDnO6J5LhYI59zpuIzZQJNm/X9BZEhXh1USfV5ckEeNwFImPMAbPlM7rmuCqht99ZM2QyRqC8WDq1ICINCrKFR47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5f33n7J3pF6OtSwLLztmQ9Dq0nAV6LzTcYS/thvVkas=;
 b=kprnqEWRQuuGsaSzS+CqdteVvCjCX9zqWfROXEHiZEyOLzof+ceusTdQN6hLQOUXmw6w4byM7sNWyto9eHGnQ7g5OzLA+vEnibMzy+PGemCZJWONbzRu/oPnXdS5mgrM0Zh+FMPDD0vGSO+Pl+r3g70g6uJBOicKWSOmGRZbGbJEC68RmdBnfWZd0wZLbPvH2N7hFI/lvf84wBdNs6zaTvzRj2yCo6KBbaCn2x69edxGK5oLt4UapNmcwlOTjcGMhsxfynnDoxN7wsVqa/49WMr6S5aQOEu53u3Pt9uMlr7IkRbK/Jk7roAMw3yxc54TOIvs1H+wZLFaJd0z1XPgmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5f33n7J3pF6OtSwLLztmQ9Dq0nAV6LzTcYS/thvVkas=;
 b=a/9B8iRBUHSGtE76EbtuCU7xT2v8rzwk106hbHIMAWGABF/PxR+EG2cSXysaivuC6SgHtYvPKvqnwBTD5HInPbUKHug8LkF/8LHfHHTKc5f5AmI0k2q0ziFzpluaFpyf2pJvrvWLhS26qiGOkdSzvZlobbF8uDg5Dc34AT7rmjzU2BJobwWN7RvxVQ91FR+C3BMnZPf0IOg/ruHLqM4uj84XxDxoKyxcTFts7IUXTJ5xGJRP+ggcdwsojN355ftKbm9cDOCPeuFRTM5JTGOT22knbBt45jzbdsFAxAId24/hmUiG438XMfoos4sl/TZwRucMLrjMbwkkJ8QIpLmtcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8434.eurprd04.prod.outlook.com (2603:10a6:20b:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 03:26:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 03:26:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3] mptcp: get sk from msk directly
Date: Tue, 25 Oct 2022 11:26:10 +0800
Message-Id: <20221025032610.17496-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:3:18::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: faec873f-d76d-4971-fe3d-08dab638ac23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3me56vHZc2Cq3vvm1rcpZg2Hss3t5YuNKg8agyLwDbp3cyI3p7sY8Pg6xNVThZLhEdoxhF8zbZWGgyHXXiRGbDl6aP7l8BAiezahnaLZKOROjIhVxNFhcu8p0sIISMjx3M+CuxqYzNIX9ygN8gsnFi69Z4BfSx2W75Xaa9CDVgu5b6A0YcqmDzALVS9opMvsFy0UyNBPY+HyX29D2BmlM5tCjlQ+m8xUF0D57L8yFZdmBfkU/v6etDAQWEzBB2G6GFfwiUvj4vtj3zajRZEnz8Nob8w9WX8nrD8MyQFLkj8uPaTT7N+Jl4ExjgKbVVt/vH+MOCmOx100pIfE6hrd9faIf3ttzM9OqdxFcgXZSG0G1N+2QSAQU5WAgC86RdxubSU7FZgbCXO3YlNNM9hR8dLu7UhH32YCCV3iMFmi8EH1X0JMl02POmNYaGLO1PDtEgpkDURN2gnxH/e/icvA1Exj79m/vVfQxwc0c2vsIewM2ii87sQyBq7VWScVnRZjoOF7wVl/EHKOoK6d9IgiOQWzSRDCmULMJ4Zm2gOpg3y3Ry/NNneVqW49R/07yoB2kxkVdljZzEnATFhb5WG60mkGk7HOll/r6hxQonSJtz+1YJFCzvH1wi77MIz1KOrefLHde6U1WjUS1lkezh1Vj5C3M1Ei22vqxckxAx3FTFYjEog4FMVU7ufZ8b3LwR8QWslEsqzWCCf9ySspvMZUYT7u4+7y/u3yQnceWZQxhyZGNiTfcPosE40ZIsXqpkHS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199015)(1076003)(186003)(83380400001)(26005)(6506007)(6512007)(107886003)(6666004)(316002)(41300700001)(5660300002)(8676002)(66476007)(66946007)(66556008)(6916009)(2906002)(478600001)(86362001)(8936002)(2616005)(44832011)(4326008)(38100700002)(36756003)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dp4rGbnVfANTNoKWSL0bvIRMUXnMWxZHXvBMOmYkHkTvVWjdakFEt5GS2y6s?=
 =?us-ascii?Q?PYF6Ef3Tm5mTQSGzFeIUlMgAkWbIBVMkqwMsFxQNklgWeMgpXZtnf48mK/qZ?=
 =?us-ascii?Q?xOPcodCwUgYSItxTfUD3GSIRfRgTA9ieUwA5zCTubTF5K4oZO9vlG1SAs+Ps?=
 =?us-ascii?Q?F8vPsdNrNlDovjpdftWAHdngFYjmTnYQZMHHLCvwNbBDXJGJFF4kJI8iH6z0?=
 =?us-ascii?Q?N7WHk3Kz24OcEZFjJZZKwFDLAQIz8CNws2TotgaIatft9iioDN0FwRu/cll9?=
 =?us-ascii?Q?KL4QSkzNAoULChBp2jdPinJVTW5mdo12GAnnVzlZoWs4LGAljgnaxPLMGC81?=
 =?us-ascii?Q?tZtL7gzqLPgU3c2qsoEnKLzMLFaIDPVjvOkZMgdxsFYzr2LiLoMFpzREN74P?=
 =?us-ascii?Q?DCVDODIVPx0272DFFiWm/Ok8nq+efwcV2oa2vCcQp+hG2gEFW/aNmgvNq76H?=
 =?us-ascii?Q?YVI0y9y3byur+F4rDnO0c1ztq075e5bDKsgu0oOQAfNfooDZOhHZzp5+AfRM?=
 =?us-ascii?Q?b1h4hte9jNadr0Pc6e96thsOwMWk5H3SdIvUpzOPBXNU2/ipiP2h4D7iGtQe?=
 =?us-ascii?Q?Mkt7qJ5fGRIIGnFxt2Qk/rs91kpOEdQ9iOhR27mDTjvwlNikHupw6HQnUWgV?=
 =?us-ascii?Q?e0LqmBzFafAEpUUz4TebrWKyCOCNjACQmYw3l2wrBIjM71TXn6LjA2OUJQs6?=
 =?us-ascii?Q?7LJ25fh8ZuhSp606/kB3Ho+k6I9If0SljkAx5lc/XI/n+YBFMlfE75ANhaSJ?=
 =?us-ascii?Q?WvQSsJZ2xAZft+itk8ghCp/pBOJb+nltIMYDOumm5+hGrYyp18unhEZ41Low?=
 =?us-ascii?Q?LFPPDYvgdMlLZEU9EV9kyymxl8akpE2OXGU/I1+UXSPKh4npnWXuv/uGEsZz?=
 =?us-ascii?Q?vkO6vBV+xS8gVcWMSpLojiWZn4SnVtfegrqwhpqy5IC2QDE1f/BMcCW+3rYZ?=
 =?us-ascii?Q?SjI+MVSU6GON9BDJpKNAVsbvsKUTxwFNg7kA5o0HjyZnRUMdFewzljYti2nE?=
 =?us-ascii?Q?iQuUn3EB7fPJC6eEgWgIWIyuZ72sL9Rt028xGwtKAXu8PEyGmYYv8qcpwVBg?=
 =?us-ascii?Q?35SrHFu52MXiLS5+Y8+HlAUw6MU61VcnbkX2Xtv2xuc0wFiKPvggRKHuSPrJ?=
 =?us-ascii?Q?9juAULBBj5gSMd/7redQdKNDoLns05NLxoQHwjmo+b6juQWS13S7wvOXV0je?=
 =?us-ascii?Q?Qnl0NDAUGjO2mCRLAp7h/02A7NV085VvuPcBKQawtpYOZVo3q13q0QQzBY2C?=
 =?us-ascii?Q?mE/HlHuxSqo1u1ny8DKOwwYFVEfS+4ZzN2mhiRJIXJnActvHmtneunsYBO/T?=
 =?us-ascii?Q?QzN1vDU4r2+IIqVtKDEOOT+YfJ6VFWnUz2uCSjVR9t+pWALlb0sK/I+VEHOL?=
 =?us-ascii?Q?TMTphJoG0znds5Odx0Tl7veXCWhIPC66fwiusRwL0fgExbzyobe/Cd4HED38?=
 =?us-ascii?Q?Jbst98nDQB/cTHuDIt992DGBidxmt49xboyUni8sTtSm1Vvcl0FmRz2Z9v2W?=
 =?us-ascii?Q?0v5pegJG1MeVk+jYRMKhXDRdXoIv/qEJTrA59/w9Utt2C+xKrGxTxkmlDrFi?=
 =?us-ascii?Q?eOeAL2UfMW65FCRyVEzflMZkS9e9oEr6LxzZy/iF?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faec873f-d76d-4971-fe3d-08dab638ac23
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 03:26:15.4434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/S5Cgf7UoBjymWBE28H1vBtG88b+vtZoDd57Enxz0gASDo0n46efqWz1lu3LIfaSZwjOEa3UdfE8v8sUSEj8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8434

Use '(struct sock *)msk' to get 'sk' from 'msk' in a more direct way
instead of using '&msk->sk.icsk_inet.sk'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v3:
- change protocol.c and sockopt.c too.

v2:
- fix the "uninitialized use occurs" error reported by kernel test robot
<lkp@intel.com>
---
 net/mptcp/pm_userspace.c | 4 ++--
 net/mptcp/protocol.c     | 4 ++--
 net/mptcp/sockopt.c      | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 9e82250cbb70..5cb65f0928f4 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -291,7 +291,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	sk = &msk->sk.icsk_inet.sk;
+	sk = (struct sock *)msk;
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
@@ -403,7 +403,7 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 		goto destroy_err;
 	}
 
-	sk = &msk->sk.icsk_inet.sk;
+	sk = (struct sock *)msk;
 	lock_sock(sk);
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ddeb8b36a677..dceeaaf3bab4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2440,7 +2440,7 @@ static bool mptcp_check_close_timeout(const struct sock *sk)
 static void mptcp_check_fastclose(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
-	struct sock *sk = &msk->sk.icsk_inet.sk;
+	struct sock *sk = (struct sock *)msk;
 
 	if (likely(!READ_ONCE(msk->rcv_fastclose)))
 		return;
@@ -2602,7 +2602,7 @@ static void mptcp_do_fastclose(struct sock *sk)
 static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk = container_of(work, struct mptcp_sock, work);
-	struct sock *sk = &msk->sk.icsk_inet.sk;
+	struct sock *sk = (struct sock *)msk;
 	unsigned long fail_tout;
 	int state;
 
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index f85e9bbfe86f..f62f6483ef77 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -987,7 +987,7 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_sock *msk, char __user *optval,
 				    int __user *optlen)
 {
 	struct mptcp_subflow_context *subflow;
-	struct sock *sk = &msk->sk.icsk_inet.sk;
+	struct sock *sk = (struct sock *)msk;
 	unsigned int sfcount = 0, copied = 0;
 	struct mptcp_subflow_data sfd;
 	char __user *infoptr;
@@ -1078,8 +1078,8 @@ static void mptcp_get_sub_addrs(const struct sock *sk, struct mptcp_subflow_addr
 static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *optval,
 					  int __user *optlen)
 {
-	struct sock *sk = &msk->sk.icsk_inet.sk;
 	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
 	unsigned int sfcount = 0, copied = 0;
 	struct mptcp_subflow_data sfd;
 	char __user *addrptr;
-- 
2.35.3

