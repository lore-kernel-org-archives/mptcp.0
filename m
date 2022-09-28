Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130049.outbound.protection.outlook.com [40.107.13.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA1EEA2
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 09:47:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLPLoiVsUvP/Lmnx+4qraHhzYkxkDJBYWzfgfSiY5eXiNPdM1GupszwEf9DRH/8psApqlQCNWmYWuRZNfy3kcy88ShVHtmqzdj1RDiHSqufeLzeDSXn2SZEkbAoHSUqFJSpmkoEevavXKIX3ONXxB7MDUe2LbWOmyC2r9uSS6bahlg86P5/vdiYHuD5XypgqJ/IyQqmkdeKp5sKzyBOu1ttenx8tfJWeYfnDhfZiTNzHx5q0C/BPYBt4qGGSuL3Kl06tEYmjfKkoU56kSXGFJDi5roiip8a8h1f+MQt7AGhyEe6Q+H5nstzrPdbXjvKWPtdBtCkmiC9y0aQePNyOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Fg3YRfwPbPrHkyygRHCfJokZihsWmBXcwj4I+gr+/M=;
 b=g13HAPiQ9gr4xP++46mS3ZBLGyInk6Ng9Ifr/cOMJVh+JbK7DbCsrMhnR660uUmEWZIh12IWwXXfvR+j8Uu4JzDynIeZhXSvfWgQxSmuyX8MMIcLv7Bg7+0Zpq2VwxHCZyPDmKu3oot6rDwviZO56f/t1Gm7vB+pCJJ4PwHe7ztbbyheiDQGoFQqr0sUL92z0E4bVBJW/jcFyR+IqeySnEHnaAI9+M576zPwq9KsIuVWxIEsR3rCljGJ3WOHZq74e4VG7785XiAMvPGGyEaATPnBnbJRp9/DN0HNC8ISN07pQRFxBrokCj/TVjNEFQTkDnm5J53q7QSi5XtiTyMzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Fg3YRfwPbPrHkyygRHCfJokZihsWmBXcwj4I+gr+/M=;
 b=SoLVb9ARHbSWyDGvfz99DRAywVJjtgZsMHJDxmK4LQE0l2t7naejOakIZdtzuzmn1RU+jos5MbLTKag8qpABNuvuAUYNbJXWLQLotN+yi+tdhMyYtPlX9wptTS95KVDQ7PyAJgn2O93IonPIbhmsAkxykCMo8ZK3KpWXL7Xc8XydltUBMXkGxMW/YytneWWv4LLVpAH/bHLKsuTdbQBKyXg2riGYOdUQFtD4twDOSo66cifwHHFUcyQ3TfZaU2bMh3fJH4ldOKZ6S0O856cny0fMRoUi50r7CIACp4dU5a5N8kJfSSW8Kqhpx+AafgXphGj4oMBDDOTyCF1zw8xq8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 09:47:50 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::247c:645d:3f4e:d907]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::247c:645d:3f4e:d907%6]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 09:47:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/4] mptcp: update __mptcp_subflow_push_pending
Date: Wed, 28 Sep 2022 17:48:05 +0800
Message-Id: <e8778be5f851e4d37158ee8c7444be9a5233f236.1664358100.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664358100.git.geliang.tang@suse.com>
References: <cover.1664358100.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|PA4PR04MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f94768-f4f9-42d5-599a-08daa13681ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dH3VjOwPPJ1z+fYYS6CCBbk8G/B6MxaN6/aG/mxuTnIR+SAl1RgyyX3IeNhwcpjb2J2SiaWzDn9BR7xm7xPlqnDQu2wsmfRKjODH0di2saRk9QZtPMhmbnf6VXeb2vkNmNtQWYh5JwNJryC7cuFocThYel/AIsMDIdaBPaNeHlbndYIHKtIk+NxY/9Bp9cm22XWgiwb8wVSMrd6I8QsRIs51qJ8JVJ9nN/ELhPAtuWQHRrT1dBD53thaEImBNM2QfR1P+4qCZGLyjkb6R2vyM+w+1gRKRy7NuyRxj1JutuUruyqYq4a531kzp5x+QIjSvuNAVsT9cmBakPCNbc7ZluhBdotRqLB4pvBSDSn424Xlx5JLFi1GXNMpITUuclCZ4495lcJRZxBuyD6ST77wjUI7Y8b1bkxV0ltW2X6Csddq9iBUUh9BlLD55XwHbs4cuwrdk2dMzJpfAfA3DjNZ0Qk2ApjnuL1QTogaXrxLThZXNIVyiUhzb91nsikQcUbCn8Mi8yZs1xQxhTNpC0FPSiXlKScKOVJwiVKJcb0wPeUTh16R85FhAEGXbfttX8Xin/1xdjjTcJV87VU5CHM/h06RgKmhhKeDtzBx6owK4ryx/2Vqoh5JuYjq0vxGFsPP2F36lYildsWQcZ1FnijXCIG3NP3vacN34j7PHwuEeEgzO27UNF/iOSAfTaj2EOfrhNIjPvszCHrJBTGqiaH0IA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(26005)(6512007)(6506007)(38100700002)(8676002)(6916009)(66556008)(66946007)(66476007)(86362001)(316002)(36756003)(4326008)(478600001)(6666004)(107886003)(2616005)(186003)(8936002)(6486002)(44832011)(83380400001)(41300700001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LMfBCK7+yfs3uFQhVxDySQUzoWUn6FEbTtDILGoaCl3OkMcyscxYmxJ8m6OK?=
 =?us-ascii?Q?2F0L3Z9Bz/ZGdIwFgeQ8HljuyFqP61LZXoORFzBFkyCjB80/9OnTBnsj5a4O?=
 =?us-ascii?Q?sM1ulCJpk1LGmvRsTA+T8igAFgREjjPpHd9vjjErCahaUmVZ1QvLLBTDgyhR?=
 =?us-ascii?Q?8/XvD4cYOFIFhrrSmqEYuf9HJIDBiFTvfs+L4QLgwZj++8U6gRTP0kwUNnVj?=
 =?us-ascii?Q?wDln6trZKtG7PIzjDIWkTd3hTFTPGQtJCSMJBZU/DNKC3idklSh2Ycr+ZA4F?=
 =?us-ascii?Q?dDXYPAqgONb6IYUoo8tbHqNnBT37HB5zP6zaYx04iTcVfNr0gr2+k9tq678Q?=
 =?us-ascii?Q?0rMctI+1yFdzcWva3+Bil49REMUX4zFOPNW4zQYGP6NkKsN853wRwi3sEtdE?=
 =?us-ascii?Q?UqZl3+RIXrjvxOAnhuv7twK1tkLfY0raGC8oQtDpDqeRWgzZDRwzx1suykHO?=
 =?us-ascii?Q?nHpvOqvq7ctE5XKljnddBNXsxelA7BLL/D0frFrWP/ZWcLuOTeeP83qPHP5i?=
 =?us-ascii?Q?EeNor2Es2fjUf8uEQxrGtw9mxPcK4FO9vw/uZ2tJDQVtUj5XuVbMLACLnk0r?=
 =?us-ascii?Q?wJqpWWO8x23dOGlN+PGDQxG3vKwTatimWVwVwn0ahFybpjI7Lz2dambXJRbO?=
 =?us-ascii?Q?sV/MLx2hodY56PofLrGjylOsNCsEdSAcWQzoOKZ/fPHka0XJ/cObjKaNngEx?=
 =?us-ascii?Q?YO12JEuXnUcR6seegJ1gaHYXGzA2MAlgQoDUaEGBXsk8CCBgXVQEh3H7TTpL?=
 =?us-ascii?Q?7QWdExB0S3FLfG3ZHKGIi99pvA0FEmZ4GZ6oSqmpY9kcOKx+2QpXutOkYYr7?=
 =?us-ascii?Q?z3G7vs8/huxPZi7eRiv+yUCBFVm05Eu1h+4v35u+X4DYb34y6h/yWBV7Omw3?=
 =?us-ascii?Q?QgfeRWpdGWAN2uzMWDfPeyeXmi7I0EukpfhCW12J2iPwQRbdF0jAdJFoYR/z?=
 =?us-ascii?Q?6a55CGLtIL1dFpk85QZlNFEO/vT+KmJeW6DKV0v/N0H3QlNo4N+UU1FWOCFq?=
 =?us-ascii?Q?lCzvvi+juxflrFEHJKb46o1x2eRbc++cdU9VUiYSklEubFh38OvAgvmiNzI+?=
 =?us-ascii?Q?VOzobp6BVZMQk+1B7OyamPUvtVsunzkuF8OxSpEc4gC94dRNV8DYYhf/oib9?=
 =?us-ascii?Q?FxaF6nm3k8okozvZh4rawpBIfbWv4UKgee8sFAI4urpMrYusEWkzYLrSpWgP?=
 =?us-ascii?Q?luDDbiYq2jlgwEmfk1JHNN4TWfIkyr8yaw3K3NsYortDWG4qlWe4wify71Ri?=
 =?us-ascii?Q?8+SeuufbynVWjDPbrH7RNhZTdL/LYeKuulqBD9WzJObm4K5CkebkVoq6B1h1?=
 =?us-ascii?Q?wE42fTRdk/RjUNehehN8lXpNYCg0fIaLcHjYIlF+WXvcrjlRiVn8M5dCl0k5?=
 =?us-ascii?Q?hrrENeZfO4Jkq3raR93DmLPh3As6PJ+Toy0gMfOZ4Q9S8bpsB/BZ1dLS6DVL?=
 =?us-ascii?Q?J8TqrQbcp4A61hZUn6yjKiV+JoRZQH8gT7WAUW39hLTHSFZh0FMerrBBU3FM?=
 =?us-ascii?Q?FTmGvK/gZq8fh+Na38BV1nmI2zJIxUQXEwRhBgcUWmiSjnIvzoL8C1i5mrDQ?=
 =?us-ascii?Q?pn/8KaBxSWSeaQTKUYMjjGR/NV5WCQ7loUs3mQ2h?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f94768-f4f9-42d5-599a-08daa13681ba
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 09:47:50.5157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/g4WZGsnnOFVPfk+a/0dXB9San/Saypn26Aip0QqAboB/VgZCwX2F1I/8AW+kgUNja01HXm7gpdIzqddgLDow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7502

Move the packet scheduler out of the dfrags loop, invoke it only once in
__mptcp_subflow_push_pending().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6a20a000622f..550fc375a7a6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1598,7 +1598,15 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
 	int len, copied = 0;
-	bool first = true;
+
+	xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
+	if (!xmit_ssk)
+		goto out;
+	if (xmit_ssk != ssk) {
+		mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
+				       MPTCP_DELEGATE_SEND);
+		goto out;
+	}
 
 	info.flags = 0;
 	while ((dfrag = mptcp_send_head(sk))) {
@@ -1608,19 +1616,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 		while (len > 0) {
 			int ret = 0;
 
-			/* the caller already invoked the packet scheduler,
-			 * check for a different subflow usage only after
-			 * spooling the first chunk of data
-			 */
-			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
-			if (!xmit_ssk)
-				goto out;
-			if (xmit_ssk != ssk) {
-				mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-						       MPTCP_DELEGATE_SEND);
-				goto out;
-			}
-
 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 			if (ret <= 0)
 				goto out;
@@ -1628,7 +1623,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 			info.sent += ret;
 			copied += ret;
 			len -= ret;
-			first = false;
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
@@ -3191,16 +3185,10 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 	if (!mptcp_send_head(sk))
 		return;
 
-	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
-
-		if (xmit_ssk == ssk)
-			__mptcp_subflow_push_pending(sk, ssk);
-		else if (xmit_ssk)
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk), MPTCP_DELEGATE_SEND);
-	} else {
+	if (!sock_owned_by_user(sk))
+		__mptcp_subflow_push_pending(sk, ssk);
+	else
 		__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
-	}
 }
 
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
-- 
2.35.3

