Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70079.outbound.protection.outlook.com [40.107.7.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2802F47
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 13:36:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4o7QdMZ+bvPBEJNmAaVcKDU4PDFR0d9iURpnB3a91ttQZf6AeyG3XQMnuSTAGR6xXqk+bLnr53w7nqjxT9sSjOHRtqo3OygUmXYp4xkFZ877P0uF1Sc69AN6DJwP4xb9po66KgSBcYHMBPBM6WS2J/vtdfKMoDRsIeO93W5u1ea6B1iG+fA8r0Pqt/PjjEXyE7TN6pwj0X8/fMIanfrvly2UEgtNmf6J2LoF/p5Jztyva3fPaqsdkYYmq7Yp6UnrcoEdXrh2zWIXLf+bD4DoWovBBnBE+TE70R+/IOUWhXV7LejsYrHD7Se4e5YRr064AEkGUup8+VfDREzC5Fd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRfrELYvOcYqwmiB7zae4Uw8lIBHVDM9ygpGvnBlsaI=;
 b=XoiuXcp7gIxAgNDKKSdtPsjok/u9T6lF8aYxBoTaPtBlb1W8ASisRUXE8bE5cDAL3R6O+j95kZR4FGiacsUt4QM1r0eN61YQLxFOWYIBQ5lSUf33g2s3Rw+IwgKdlNMbkxLjDEOBts3HHPxkkau3zSa8bc72GYedGpIl+hhzygR12s+3+I5VP2KpY4VMUwZxlH9kQOXDiRtA2WyJnrPLTWD6VSSzcdWcsK8cjo98cSg83eiqkpQXy5VeldMVf48JOEu5xs1E7dzpFmLIiKqrjvBZn9EzXOnfMEJpiYHPmlsD5MrjsAP9cmLTBk+k6EuwL6Yr+48Wju3vvHfyRPbZfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRfrELYvOcYqwmiB7zae4Uw8lIBHVDM9ygpGvnBlsaI=;
 b=wpZJM0RUBh22yCukR1zBIxLb+Ot6moY2ru0EzN5KsnZO1om/Ws8gnORI729n4r/dzt3dbuMozG6LKBgb8qGbmqKo4bIac/AJypZScSgVZ6fcIJDINtwfAxvNXWX0xbeXxL1tXbckpaPnJhOH/4C1zGDagJ4w17TnPHQw1fiKxlHdB4Odqd4STGTFpIIUx8x74DPBBy1L5k7WGBnKGJhVL979OujWS+5XCD0agOeFXMKX19NWfSy4emN5KggB3JPTNJGAwzpynJZQPiPmtiBq1jTjsIhCAgHnTNf2siqEoIYMeBZ/SB6v+VPeurz0VZEBWG2I0aa/kP5cDHk91HXKVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8261.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 13:36:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Wed, 19 Oct 2022
 13:36:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 4/7] mptcp: delay updating first_pending
Date: Wed, 19 Oct 2022 21:36:02 +0800
Message-Id: <d7c62b1b5c76fe1dbeda09d4998ec99337c46361.1666185947.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666185947.git.geliang.tang@suse.com>
References: <cover.1666185947.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0078.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: f258dae7-62fe-4126-fa45-08dab1d6f8d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6L8HFKLxVWVP3yFvT+x0qQoxrjtgSxavaF8eh7jQEKekSbs+blymn8GHhSjXOQMdKKqwi9xjJctszM0r4DOXCGcnoQVjLyLR41nA8Y89Rr+5p3PmTGZ08Z6pU8q7gKUpl4cmrv8T1ECSoNzlOr5Zc/Ui05w1LNFNZ4Q2o2u2AeMOLjEcCc+YEjNppVk2GR8wgnRNmy4yCoYyrUJg0XD/zRA7YWz3iCEcfD3UWEJ4fSy1jwEEZuwQXdxTPL2SMxiDQ7K3An3roRt6I+qZzbIjXg1q8RlLQcaK9uw65Lfs6BQI47vjLeFJ7Tyd5X7sdMpOIIdJSpzOJsW+JmKMtnO9XY6iq9DNDJTUE1W9MJcSY4fW4r1fy4CIE7wokWj1mt/9iCXFQMWjJ5wVS52J7Dfxr9l0g6t/6/zFap6CVaxtr0fiKrAch7G1emGzCtEnxSRE7MUFoPB6XC0lbEDr/f/Njv1hoBnFcKd+jIgZWoCtN+gOQ423a6sGpVuN62tL6uVklr7eGcYZJVItAQrJZld+kQh4s1tLCXKSsuDotTyIEOhIRXk2QVXRsccUNZLc7vTu7CZMC9goCywoi8Y7TBVCxB0zEd8tBDElxfuiwH99v+UQNWe35zCq2vCJYTBzrkk+LLHhZN8cx3iGRER1jtPsf88B5fsxmWbBPvuufOGtloepESa60NXkHXi1Xxf0vbngGQolR+hdGEoSz6gAv+UNi+XKJdPW4QowdES5XZwAY4y1b5By5iqFA47+VpYJtQA+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(83380400001)(36756003)(86362001)(38100700002)(6666004)(107886003)(66556008)(316002)(6916009)(5660300002)(44832011)(8936002)(186003)(66476007)(2906002)(6506007)(2616005)(478600001)(66946007)(6512007)(26005)(41300700001)(6486002)(4326008)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/5D9bwZJ077HisnXF18dIlvQN78GWeQOM0AShkeKBvdJuE8Edlxu4VGyAOtT?=
 =?us-ascii?Q?AvL6Vbx9o9AUAu2cylXINfBjfyIXt48eYGX512gT6M+PDcrrWa2z+AjPsX/9?=
 =?us-ascii?Q?9LkrS5feTZi8SsluBq4TujmBpKurqqKBPBX4dh65eVNe5zgFMl389Qrf8+NG?=
 =?us-ascii?Q?/Is6b+23/rn1S44QKzhUPryxeJTQvxi0dnm+N7asKLXr1rtjH9buKmFAdozq?=
 =?us-ascii?Q?CAlsVTbaGf70Gf7fp5etGjJr34j6A1ksEVsHt3KRDqmp/rtmy5FBtM/cn4yL?=
 =?us-ascii?Q?z6aqhlTt2qnwyp0D8Z/iNJX+jOfhSc7jhYX+te7s+oX72DQU5kUFcsuBdAl1?=
 =?us-ascii?Q?4+da2YPuHuN5CVVn+yvVB8nbVpRXfM3geOvmXAGBwjVwSvjwiNPM1fYE6d2K?=
 =?us-ascii?Q?tUh6V2AjjMXZ7dnTttuTKFkKbNZuJo7OJcKczhyKksv3vZH5BsGD324WZeqc?=
 =?us-ascii?Q?9bU3x5/SSpxYRtulXoiBz+iKmnajTjqZ9lfsR7f3s1Rg3vEwDLt5rqhBN8Bb?=
 =?us-ascii?Q?erFgR6SVtjyiUOAVFYa5jkbMQ9ftVEPMVe0nT5dCz+WfpmNVOJOFUUuHNtN9?=
 =?us-ascii?Q?dFUaEXe/uI/mx61HYtBwauHg0Xqqohc1sfqJACxTmo8jWgIbSTmSXRZGvsmC?=
 =?us-ascii?Q?1daipkq3UtaxdLdUJ+F/1n1Z7i1c2ZGVCmAGQh0oZ1zK2nNETn/oXNuaZFnD?=
 =?us-ascii?Q?BPKsyFDX0fE+FUYKFoxCSVREB+QUMYEpmuX7t3dj5pq53+Y5yG+qqztpRjON?=
 =?us-ascii?Q?z35tVlPn68ZACqcVZPMNfny42ump1PtkRzZTKusZjasWt8iw2cyPns2/7MEF?=
 =?us-ascii?Q?RmC8ofiS20Ciz+DHYF6wT89vMmLWgWn1c8x0xu4sAjyLYum6YCMK3RpBYxcw?=
 =?us-ascii?Q?WMKmnsw2B07kUboBwkQZ8VRSWjent4+Z33LEG9CcThMmcU0ZvWqns8R+5b8E?=
 =?us-ascii?Q?HKi/T7sK7XiYCKcXRa6MZ/03WaF2mx1lnstm5c2+XOI/byneg5y0+KVO4Vy7?=
 =?us-ascii?Q?fVfUR0NXe199VdrvtMrAJ11n9L6v6w+MY7eIWXrtg3R48Vg7FIbg9T+cXsKs?=
 =?us-ascii?Q?TCVTrj4jbsBYVVBrAxt+ebPzBy4TyBUUBeJpT6YZQbVjBjGUI5zlrtnUO/fz?=
 =?us-ascii?Q?gGOeF+RhLiNHtV1U8psplYKBT5RvOhMx4RNLGFd2KELk8DaRKwDU4XOAAF3w?=
 =?us-ascii?Q?EFt/59POr/wm9J+cpFxiMHvKCkOhT7NFDQb1BHuMBhyxX4Ao3YqSdzYg/UR3?=
 =?us-ascii?Q?JpD3RwWsqNpydwnTuioBX/dFSp707fIbHVxOHedpiC9Yin5/rYZZOhd9ACdL?=
 =?us-ascii?Q?Emjmckd4oC1Z2ayKLJW5OrszrOEC+PhCIIe5Ajh5WB+727Z4kYFNys2vv0ZP?=
 =?us-ascii?Q?Ok3iu3XMTb0lqA5av379UaXBS+Cv7qDW04rguyAEQeGhbeCAsz59M714Pn9e?=
 =?us-ascii?Q?UT2/Fe57QKIOXj3bUKzpveDqAJ/hlaAwnaNb+asF6KuXfmNXhlQzk90HapK4?=
 =?us-ascii?Q?fgmHSI7wIyFeZF22MtK50OU1Ipb2UsDmwyYIHklng7dIRBccTiiecKRacwoi?=
 =?us-ascii?Q?8V+KbgqdZTM5lyPiT80pfZKWtjS5WHP3+z33b7RbxaOVTdKWZmcNzQq40ysx?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f258dae7-62fe-4126-fa45-08dab1d6f8d7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 13:36:48.7211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQ5FsXiMkJM05z18uHrDabp812kGuNESd6HOvdK2JB/GrzK0FnpUcAxPNR9AHax0zVmMrqe/Jgbm9fGqqCMDdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8261

To support redundant package schedulers more easily, this patch refactors
the data sending loop in __subflow_push_pending(), to delay updating
first_pending until all data are sent.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 28 +++++++++++++++++++++++++---
 net/mptcp/protocol.h | 15 ++++++++++-----
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7c0d81c6dfe8..b1fef2b0c968 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1121,6 +1121,7 @@ struct mptcp_sendmsg_info {
 	u16 sent;
 	unsigned int flags;
 	bool data_lock_held;
+	struct mptcp_data_frag *last_frag;
 };
 
 static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
@@ -1514,6 +1515,14 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 		msk->snd_nxt = snd_nxt_new;
 }
 
+static void mptcp_update_first_pending(struct sock *sk, struct mptcp_sendmsg_info *info)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	if (info->last_frag)
+		WRITE_ONCE(msk->first_pending, mptcp_next_frag(sk, info->last_frag));
+}
+
 void mptcp_check_and_set_pending(struct sock *sk)
 {
 	if (mptcp_send_head(sk))
@@ -1527,7 +1536,13 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 	struct mptcp_data_frag *dfrag;
 	int len, copied = 0, err = 0;
 
-	while ((dfrag = mptcp_send_head(sk))) {
+	info->last_frag = NULL;
+
+	dfrag = mptcp_send_head(sk);
+	if (!dfrag)
+		goto out;
+
+	do {
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
@@ -1546,7 +1561,8 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+		info->last_frag = dfrag;
+		dfrag = mptcp_next_frag(sk, dfrag);
 
 		if (msk->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
@@ -1555,7 +1571,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 			goto out;
 		}
 		mptcp_set_timeout(sk);
-	}
+	} while (dfrag);
 	err = copied;
 
 out:
@@ -1594,6 +1610,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 				ret = __subflow_push_pending(sk, ssk, &info);
 				if (ret <= 0) {
+					mptcp_update_first_pending(sk, &info);
 					if (ret == -EAGAIN)
 						goto again;
 					mptcp_push_release(ssk, &info);
@@ -1602,6 +1619,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
+		mptcp_update_first_pending(sk, &info);
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
@@ -1635,10 +1653,12 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			ret = __subflow_push_pending(sk, ssk, &info);
 			first = false;
 			if (ret <= 0) {
+				mptcp_update_first_pending(sk, &info);
 				if (ret == -EAGAIN)
 					goto again;
 				break;
 			}
+			mptcp_update_first_pending(sk, &info);
 			continue;
 		}
 
@@ -1658,6 +1678,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 
 				ret = __subflow_push_pending(sk, ssk, &info);
 				if (ret <= 0) {
+					mptcp_update_first_pending(sk, &info);
 					if (ret == -EAGAIN)
 						goto again;
 					goto out;
@@ -1665,6 +1686,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
+		mptcp_update_first_pending(sk, &info);
 	}
 
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8f48f881adf8..118fe5a2745c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -350,16 +350,21 @@ static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
 	return READ_ONCE(msk->first_pending);
 }
 
-static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
+static inline struct mptcp_data_frag *mptcp_next_frag(const struct sock *sk,
+						      struct mptcp_data_frag *cur)
 {
-	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_data_frag *cur;
+	if (!cur)
+		return NULL;
 
-	cur = msk->first_pending;
-	return list_is_last(&cur->list, &msk->rtx_queue) ? NULL :
+	return list_is_last(&cur->list, &mptcp_sk(sk)->rtx_queue) ? NULL :
 						     list_next_entry(cur, list);
 }
 
+static inline struct mptcp_data_frag *mptcp_send_next(const struct sock *sk)
+{
+	return mptcp_next_frag(sk, mptcp_send_head(sk));
+}
+
 static inline struct mptcp_data_frag *mptcp_pending_tail(const struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-- 
2.35.3

