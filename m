Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF2CA31
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 09:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647942813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U53kgecBXnpFdh75gzgmSvapcb7jNOcQRUhCY/lrkYU=;
	b=W31ianYnPYq8PdA7ddMiJh0l+1jzG+9RPxLmwA9XDJPlOe4GJkS1AlQq2oPqha9xxw2RU2
	O/J6mu0fdcAw2jQBvKmF0QPjHQaZJOyVkRFjhEO5vnIHCO7EZSikU/XBFvnSFPXTwpmeyo
	JVOx8YyaAITUMRSdB7fO1rUnqnJBJzo=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2058.outbound.protection.outlook.com [104.47.9.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-JLINrbQIMBu5YBKNm_vT2w-1; Tue, 22 Mar 2022 10:53:31 +0100
X-MC-Unique: JLINrbQIMBu5YBKNm_vT2w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrYfchVBVAzHXffThe4B+ixN+12IA4Vq+OgmXWgWgxCQDPEFRIHONM7IV9W8c8Qe8djTXdrMNOjgNBqJZ8UP1GlV0TczEkBmzu6FOg3sA2OadHxdYqo3U4ovQ0HRZJ0Wr1cZQZf7AnpRp3o9g1GMDNuvzNkNvH83SLHpZp9G1Wrp1vo0VywCmdA5Hd0sX1kM6R0flBExNe5TIwihh3R1ucCPLy7/VCftV4xO9PQf5wnFyoIau0nMCXe93C6/PZj+uehywyG/UMJOIGbfo+0xLA1EuS8f0VlX2nABl8Z3JfsuoODIElqr1j4B/+NQbUlfAnhDSYqHpcPot96xj77Mlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxgTnyWv6ApNaMHU+Xxd638u1IKNmH9t1Du/zUOecoc=;
 b=ISWy4YTSXwhOHFN9R4aH10t1coWu/9fSom7VeH7hjM9FdoSoopPfwN1CASrX2clV+mFaqQmTc2Ri+hj9qaiUNknz8hPcxgpDiJ7iZAz6lCmy5b2DuQsUcTWBopMrf4H/mgJJ4MdTbZBr9en1IRM6zwpZbEHPFPS3odwag1tAALf1R64LDqqHhwaKyvWoKk1/KwO2/CIHhS86t01ABUf/tJI9WO7qGPsAcFfiuDMOydRMLne6O/Jqo0QRu8ai1BoMUCZhtEczsJkr6hXtQPRvN2jwSPWNLTHBXYadB6WsE/op7cOwtFR0tEsKk/rGPn3FMDrx1fE4sCQJKLtKtICdhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2282.eurprd04.prod.outlook.com (2603:10a6:3:24::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 09:53:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 09:53:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 5/8] mptcp: add mptcp_get_subflow wrapper
Date: Tue, 22 Mar 2022 17:52:40 +0800
Message-ID: <bb7c05f8725214e166271a0cbae041aff473e661.1647942374.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647942374.git.geliang.tang@suse.com>
References: <cover.1647942374.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0223.apcprd06.prod.outlook.com
 (2603:1096:4:68::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 227040b2-f7bd-4987-1b09-08da0be9d0d5
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2282:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB228283CA6D688B52A588EE3DF8179@HE1PR0401MB2282.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jt892EcJKBPsRH6bLaTNqBsS3eXCp/Nwx754ruu0B9W32U6qAf8IwQw3FTgFnCLEJjYxWpphDf6jy2vVC5QD7fjci0GCSeN1/Q88WXT5OM2o7ZJHkTnQ8iVGslGkVZDLnSIP/uIkaWRUN2POba5X9EGwgtgzqwms3qGdD+r7efOq/OqN0eWl+Wk9lpOqLCKa8KRziVg/M397miJza4DGkH6fJTHtDqYadHirxX843opPE80HFB4QhA3YzAg6jiTJiKaktK92sD5v8NilRVZY5+m+gyHBqRhNZvM63oUyQ1quDnrL6Wk/OKypqSGpAifpYZG488tcfXC/GBcM2OAF8l7rvbqwkGg/CKpVvHnUlo0o4nvjMKGH02cL9vgbDCozRMnSovQocD+2LJIw+VULPN64dWZLlXTRTVlw6BaBMpvDuG8Ic8C8CNPbm9A+haV1gPl7Ps+5XqK/fVjzNgttNt4/D9DxJ0dpVrj0asNYathSvNFsKAiAEHa7ONrdy23LazXMcNYZ25qI6pFFUqh9udaUs+FT2AJrVfSImew794gjzI7gT4G+BV+bB8OSILU68xg0u/CbViq8hJNQRrEpAjCtsMaUzehtHGWB9OzICXPSF80KFm0j4PwBnWdLWK2H4rtXMRdiRPPNsu0rKvY+PFhrRXVlCVFwaBNsMhbWqopaedALmuqeK/R3FpEpFghV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(8936002)(316002)(6916009)(4326008)(8676002)(66946007)(66476007)(66556008)(2616005)(38100700002)(86362001)(6506007)(5660300002)(6512007)(186003)(26005)(107886003)(2906002)(36756003)(44832011)(6486002)(508600001)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PaqzmKlXWq90ymuUE/0P0FrZmMVpxsT1AuHZ3fZAiTZl4npEwuq9n/k5Zsbo?=
 =?us-ascii?Q?nyLhQqOq47S8P7CuIxeneHTsL8Fa20HTeEJsi66qtggj72V4DrEjlbLbyey/?=
 =?us-ascii?Q?hI0WTdNUqrazfwOArdi9pXt28g4072CvniwatEl33jvPQArcu0BIZDAUMQMN?=
 =?us-ascii?Q?S9w9UAmve0Y5J9UUQ6n5KjbtRw78Bhph8pA5yH6sIjqcppf3YVeBUucEUheL?=
 =?us-ascii?Q?LxOvbB7iMw1sK6mhL6e4agqDrzW9XWFmHEsXzaJNeKCfEEhojh5lYEPdKCLb?=
 =?us-ascii?Q?Y02nvcVzizAGF/q7FDxYMt2ioT0W5AvxeHlFwwb7JM0d3biT2a+mHNXd7fS2?=
 =?us-ascii?Q?WOUyR25DRh6XlSJjnJr86e5ZpeoMqt5N7b83BIhUMN8JfiuhFM1bFQVows9V?=
 =?us-ascii?Q?P+RrA1uQPgoPImVNLkOKns247PSrobsn56/+0UXbOyy0z3yjmNnBPjf2Esey?=
 =?us-ascii?Q?zU4yTi528hwUUBqmmXg6QCihyniZoDBstkbFg7nhaz3kPR3UR54PvlGnokyW?=
 =?us-ascii?Q?rC8TJY37UREv9xpS2660zUHKBhepoMVrrNhI8WLY8BemWOXZjhqy4OG9p6z4?=
 =?us-ascii?Q?230LFhq4eKPV6ZCRpRbYqzH3UWBrv3qu/N2uVri78PwjLoT4aSORH4Xz2lNa?=
 =?us-ascii?Q?1ebQ8Rc96qpg16RfjRUBVv2ixIEQEumpJECLwBPg5jJiM8pyWJi3/8eY7+iX?=
 =?us-ascii?Q?rjFYTKPbmnt1dX7WOrD5zJKwfadGRpPNbkejbPnkDRV4CVf3ZRy1x4dZ/3TQ?=
 =?us-ascii?Q?t0qcdS2WmVHTZztu1xfhALDg2BpvkIUQjt1WqzsRd1B/T7OYyfOPgI/nrt4u?=
 =?us-ascii?Q?SMB/6GL4LCG5U/0yAyV0q6WATNY9tX6Yk0bMB1omoLPCUwqCieURTgBOTC8T?=
 =?us-ascii?Q?0FFh1RdpQkJqZeNX71Xx/E7RUYVq2VQeUbqTQvHVvmatZV5/OuVfMIhIhCNl?=
 =?us-ascii?Q?Q+zqW0kcGoxWm0iQS3ssOYUVd4yOGdeYz2IdUTBTfgA5uzK9M3gtyN78fVgS?=
 =?us-ascii?Q?EIhMM3/WizytyXeM3jJXxHPlY+DhlsMMB38V+oYE9UqHW/vvBWL8fDSCXZbJ?=
 =?us-ascii?Q?QnG6gtZWvqP1oknBodac+FWdTrOm0L5EbtQKdm2biLUdh3VrIhnrlXV66UM1?=
 =?us-ascii?Q?avx7lR+y0OiHiQ+XgvCAzN2RYsBrHjXxfaE/M5Tg0iTL0xy4MFdXFQ6jtXlK?=
 =?us-ascii?Q?9I1fo+riVvDRyDINNoD6d5hLT04mEeUw6URxLujl4rpQjsIcCO1Gwxw0KBeM?=
 =?us-ascii?Q?BhBw5m5ySfio7i1ESUko2HPyOw/ZZwnscXvteqDcZZusFK5/WSg4ee8A+Tfe?=
 =?us-ascii?Q?ln3KDq9BN5QLhje/1V8qtliWyyLaAQG3T/3vHGTUEO0P4u/BSvHOu3CCC8AI?=
 =?us-ascii?Q?aSa4mgfE0Akw3BdHwBahnG7QEPl+hPPQfU6bXoEt94sUa3JoeJeclcwkDX8y?=
 =?us-ascii?Q?48FeT/g5GcT7QZ38Wh7DNEp9lK3pxVTOHCNB8DOaqiHkgCJUi7IoPw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227040b2-f7bd-4987-1b09-08da0be9d0d5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 09:53:28.6196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDsFoN3iwPHmp5NsUgLmx5mJ30XdfPi2TnzY+O+AUdM1snFF+3QWEzDewDANQDeBzPAa4JgjNZnG3YyfwQ5wEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2282

This patch defined a new wrapper mptcp_get_subflow(), invoke get_subflow
of msk->sched in it. Use the wrapper instead of mptcp_subflow_get_send().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 6 +++---
 net/mptcp/protocol.h | 1 +
 net/mptcp/sched.c    | 7 +++++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c892e3b6b65c..22be279c8391 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1567,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_subflow_get_send(msk);
+			ssk =3D mptcp_get_subflow(msk);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1634,7 +1634,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_get_subflow(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -3074,7 +3074,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
*ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_get_subflow(mptcp_sk(sk));
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f7acec409607..16e7b9114b56 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -615,6 +615,7 @@ void mptcp_sched_init(void);
 void mptcp_init_sched(struct mptcp_sock *msk,
 		      struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
+struct sock *mptcp_get_subflow(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index ca8d204e476f..ba3e5497f183 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/rculist.h>
 #include <linux/spinlock.h>
+#include <linux/indirect_call_wrapper.h>
 #include "protocol.h"
=20
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
@@ -85,3 +86,9 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 		msk->sched->release(msk);
 	msk->sched =3D NULL;
 }
+
+struct sock *mptcp_get_subflow(struct mptcp_sock *msk)
+{
+	return INDIRECT_CALL_INET_1(msk->sched->get_subflow,
+				    mptcp_subflow_get_send, msk);
+}
--=20
2.34.1

