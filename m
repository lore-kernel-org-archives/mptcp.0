Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70045.outbound.protection.outlook.com [40.107.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36327B
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 08:06:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFOXKLsiMJLccJX2MeIeDIS3y23tO/xQ0iUC8WcGFCw5OA0mWNvbxlwTJWe1OmXtARFWjCtrQz3jpky58D0ZV2sPVintXisF+41iBxzfPBSqU7S0ou72xceRof3GQfYYQyhsRMFlzyn5oQjfrNpu4+1HiNgYZ1j9r0I+W8eL70A9DfFMYL1Vvqd/KSCM+AkR9y6h1uOaSoqqtz8xKL4B82DFv+oU6ujz9QTSHExuHys/Mj5MQQ8s2YDlLOEpBTvnisTX1wixXOgGD5tG3vp2E2R4cl1KEsF6W/LPAHZe4/RaSjMzBWnBzYq0F1tcbEMYBR27Ccg1elPP4gGB076nFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UGIR4G82xig19E5DbRTff8ElhU6iAO+Hn8aTQ44Gm4=;
 b=MpJQEI5ffFYlRowbPaFJjF8dWi9L6FgKtS/bguzDipN4xgLG730HfK+I20mpJYZ49rQo5heoTbnB14yZWI24LfWLbX5JmntuV4GxZCQq5OTtaZkewEWNbLqKPMCg31XS64G1qjGuJd1l++mKZmKArD0Bbh1Zd5zOm2ksduxbFExglKD0MvOlWMSfUn/c3q1KjpfzF6la/8yDJsdc4Ub4AT9eduresRasYlQFH8rx0WHUgc+K1CFcFyHet4ORvu4/5QKZIw3dizjdS2fomuIaLaERxwbHoC5mJj17OpNaJgZe+Ee8inFJPVPladsZGS4cyGbWu6/+sBdmBEwGFa+L2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UGIR4G82xig19E5DbRTff8ElhU6iAO+Hn8aTQ44Gm4=;
 b=rUh4fwBiawCVYkt5ZesMD04srhGquAa4/UDPyh39ccWkprUeb7FVnHt11GpTYlYrggDpc2ePw8N7YvuNtsJS9l/A+ramr/N6gYtI2OtDp4GtuMS+5iMhwgWhrnDqAkZTV9LlYFSyaoUMGo3Op+jqHQO7Ig4P7wA2zXRS1Qr/qf0GkYepzSJ6S9mklaENygt8zRHfCmPC9h3VTRXeObSylbDIQtXOd3fcok4R3bJ0qoKAhntC78Lsgl1iH02tEX9zkryzRqEoA9MFvnbBBqxGbpvKZoMapDhSmFDylxP7m+96ycnTivpjZH8h4Eqe3BohclhDgaNTHHNgzZEtlgTM9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7617.eurprd04.prod.outlook.com (2603:10a6:20b:286::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 08:06:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:06:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 12/15] mptcp: delay updating first_pending
Date: Wed, 26 Oct 2022 16:04:21 +0800
Message-Id: <e240884f233edbfe6995c28ae426583e7d60aef7.1666771065.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666771065.git.geliang.tang@suse.com>
References: <cover.1666771065.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b595c49-b429-4c5c-6de9-08dab728fc32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	86Of1GHmbt/7Omw0tgye22jyTXBnzneQhFwaA0myf0M3mfx74ZLGbs0Bq++94zmOO1D1A1Pru4qFBlDOaDsuhhPBkt4BwqKqXv0Rmlheia2b6UxYO+lbdgqHnE+D3KpXO7f7Pem+dtmxcFn1V1FLk3z2quy1Tguq9nuBSRTGIlxlBw2GhR7K1swVy3UhTXb2Vo3ZFwBiYJrRym6PQRT6y6slkSrZWpOQzCZsACmaK2ftPOLtGzvGF97d9kqx9A8QByfUc1J7bifjfmNRDTZ0eCl/bDJLYBX1W7JFR/Jaetf1XHrxu1Kaq00pCh8e89jm6dsjeG8nnJq348wkr1volO0FJMdKCKfFpnO2d9oicpLic2N9UG3EBj9HNfKMypWHReR6Fmr4jRu3vBruzT52Mx43dY4IoPLH8Jrp2l7p0+yuC+88NoRFHa+ABab10/DTgrhmnn0uwGpnG/X7LOSquOY8uvDXf+9Eg+kBSppZLhSKlKXm/BFVRRhLe9J/K0hZ6RlczpsaaQAoTN9mOVWNzd7AG1LyAR3Dn0xqO3C5QPi0nYszeLZF896WcyiToxdRIW8f4PpSRdLGC82YdY4u1qOc/I/iUZ5Cb5YFeH9KLmCem0h17q1X9dsBRoQW/485OoiCw4oYlGzne9UbVxdWH9ZcPlwyXPMT30SD5eOSJCNRtGYWImbOcyLdAHY+t0m79P6XpjzKYH+YGCfH0P5/DK6U2m/lEen3ueh0uRHqTcaUZ4MbS57gdZwisuC//Cm1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199015)(36756003)(186003)(83380400001)(2616005)(86362001)(38100700002)(5660300002)(41300700001)(2906002)(66946007)(66556008)(8936002)(66476007)(44832011)(4326008)(107886003)(8676002)(478600001)(6666004)(316002)(26005)(6512007)(6916009)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eL0OrO+yvHhdCbZa1V+TpwqGoN5sapTR/zWTfillYJ8OeJo/PdsZHSSGrh9a?=
 =?us-ascii?Q?yYMsywKOq8bxOrOsKVPWc96lwE8uEcWw5hf5N5W30G4ReHWZPvkVzwzTP3DI?=
 =?us-ascii?Q?Pg/0Sv6/7z7qsf6mg3tvbg8Vzh83VPoXYWDy81p1/zzP/D8tn7k7EA7MR6M7?=
 =?us-ascii?Q?7ssuldQacFchmu0clLrEmrfhITVo/xbirjXueBrlksDumIfMXdBBYE+ZBRGg?=
 =?us-ascii?Q?jtn4wxcoi2HY7X6BFkg2lm5NG9X8aGMTDt8SNZl2mfLT1ANI8TbF2QTLCmJr?=
 =?us-ascii?Q?aLoFnBwGtX0yUPA6PHtluqvRVJKn9j2dpLC03XGC3eC8DMow0ut9t4nBWNJ6?=
 =?us-ascii?Q?aM+7HBvDILahWPG7huk6/FxzXboYIbWCDhFWEHYSceXwIdg9OlMXJ533ev5x?=
 =?us-ascii?Q?aL5TWbrJNfb7Sl/0vhUkrwq1zoEx296z0pAHJqpgg6CTvxHuz9bbx+okEM/R?=
 =?us-ascii?Q?6wipS5m+VJHp3yTVfgfTqVmJiaW7hpgC+Vu3yuRzM/6nR93nf8qIFqlfnVbe?=
 =?us-ascii?Q?akojjCfcft9upTjUUefZKEuMHXEmPVx+4gk3P2rUGPqpILPsJRTrml7tRxoJ?=
 =?us-ascii?Q?uwR9JO2hSXO4XC8FpXjJ4kHMcGe9ELKUWlXEvioeODHUR9wPoLNmQHV/N5Ew?=
 =?us-ascii?Q?0mviFloQE/+Ay9xZy96ye4eNDSe2Nt4vscRCCiSnsHlQfK/ZFcTHvYp2tfRW?=
 =?us-ascii?Q?51MSVuFya6LpNuLVrhUCK8M3iK8WZkLPe3OS93M79RWuJ7iWY1x8RHo/SYgi?=
 =?us-ascii?Q?vWnD9IRrVhqnoXGi+qWpN+pIC5pHOkRrZt9THSYApGD/vnc3hC7Qhx908j6+?=
 =?us-ascii?Q?OKYN3XnO/ujgJ/Pyev+xPcd9zI5Qh8ExD548POsfOLHSmxZTSu7zlOl68+fl?=
 =?us-ascii?Q?z8oUQQI7I7oQXHhlm5N3NZatYYquhHTVdXtT4DnJF8IPIPNjDvd8f/cTLS4F?=
 =?us-ascii?Q?makwiBDf992z7Z0JbzqoewQQUb2ISVY0bXCURPbr8via/YRYrEUq04hWlj5J?=
 =?us-ascii?Q?3i1eTWzP5ac74xF+jthlRuTwBSvcKAMtdzHrb85nTtEkxtuwaDvI3PRM3M6I?=
 =?us-ascii?Q?TexG8ll6ZW4oT6ASxhko7H+9qLb2uVC9fSTonOtyb+d7Gk5y6bVtoA3azEKT?=
 =?us-ascii?Q?LVNl3BN6gv00HEGSA0pI4/x7Q7u+egrTi3IUqLWYQTHTktTG238S1i0HY682?=
 =?us-ascii?Q?B4UITTggE12BtJTqqqfjZg76jZpFTr/bXKK9kBFY28TD1JeG7+pfZz23BQUZ?=
 =?us-ascii?Q?gzP/KCic5GSW+L1Jx+GjbWV232XKWyY+TIXdIVEqozzxXnMuLVmZx41Gsv2e?=
 =?us-ascii?Q?BD5w5JgeGDt063xwq2XVyetQc+Ckh1WR65RYEZl7Unn/PGf+8JnhxbiGJFJ4?=
 =?us-ascii?Q?hCVNV/ObREM84e40oEPQqOub6aKOiaoNVBKF6BQu+aP7iVtoV+i+5NFL+kkW?=
 =?us-ascii?Q?iL6MB4puvjwp4uwuocEOUbnHc7NjfYNQfw4wwDpIleUcui+WxtdzZs5Q7Q2s?=
 =?us-ascii?Q?rI4cxdsghQ6vGCt3X3qxzxO8ENaWFCOBg4beFPSvdAzzu1c+a4XROZN2deE9?=
 =?us-ascii?Q?emm5YsjnOXppgRNd7wNlxJvaNt6EpZDCmAfZ62fgK38zsryPkgxs+5pt+iP7?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b595c49-b429-4c5c-6de9-08dab728fc32
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:06:28.6740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJ6/spwOz1AZA28NQnvX9Zx7dKAZ7/tg02EScZtxgZLADhyuVgF8TBfyqMKjXcjYH5uzKUZCgASDvWQZMNqTFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7617

To support redundant package schedulers more easily, this patch refactors
the data sending loop in __subflow_push_pending(), to delay updating
first_pending until all data are sent.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 28 +++++++++++++++++++++++++---
 net/mptcp/protocol.h | 13 ++++++++++---
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f2e592d53073..262853d51e40 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1121,6 +1121,7 @@ struct mptcp_sendmsg_info {
 	u16 sent;
 	unsigned int flags;
 	bool data_lock_held;
+	struct mptcp_data_frag *last_frag;
 };
 
 static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
@@ -1511,6 +1512,14 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
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
@@ -1524,7 +1533,13 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
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
@@ -1543,7 +1558,8 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+		info->last_frag = dfrag;
+		dfrag = mptcp_next_frag(sk, dfrag);
 
 		if (msk->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
@@ -1552,7 +1568,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 			goto out;
 		}
 		mptcp_set_timeout(sk);
-	}
+	} while (dfrag);
 	err = copied;
 
 out:
@@ -1591,6 +1607,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 				ret = __subflow_push_pending(sk, ssk, &info);
 				if (ret <= 0) {
+					mptcp_update_first_pending(sk, &info);
 					if (ret == -EAGAIN)
 						goto again;
 					mptcp_push_release(ssk, &info);
@@ -1600,6 +1617,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
+		mptcp_update_first_pending(sk, &info);
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
@@ -1633,11 +1651,13 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			ret = __subflow_push_pending(sk, ssk, &info);
 			first = false;
 			if (ret <= 0) {
+				mptcp_update_first_pending(sk, &info);
 				if (ret == -EAGAIN)
 					goto again;
 				break;
 			}
 			msk->last_snd = ssk;
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
@@ -1666,6 +1687,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
+		mptcp_update_first_pending(sk, &info);
 	}
 
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8b1054fc2c3a..b2b5110a2aba 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -349,16 +349,23 @@ static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
 	return READ_ONCE(msk->first_pending);
 }
 
-static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
+static inline struct mptcp_data_frag *mptcp_next_frag(const struct sock *sk,
+						      struct mptcp_data_frag *cur)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_data_frag *cur;
 
-	cur = msk->first_pending;
+	if (!cur)
+		return NULL;
+
 	return list_is_last(&cur->list, &msk->rtx_queue) ? NULL :
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

