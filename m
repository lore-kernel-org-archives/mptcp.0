Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20081.outbound.protection.outlook.com [40.107.2.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CD36ABA
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 09:10:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVahJE9OVJE7ybreAvDdJ51/zAX8YYal+4WCThYxAL2lfu/xJ9WtdxQ17Wbs9XTLIlLNn/cjrnEiM9KXYI6LhAcYX3rg5mSK8pJ9a8JllrcNiJ6mnz9gFvuhw3azabuSz6x4exsBt192OvSgSOy5dH56AuVob9JXL2LTWXY1hSMcSV1RZQYL8Oh5GbZQ8mMgG1Y34PMOukjGpB6e7LTIlLKOa8Pt+ZKk4VOekS4yK/JFm5oM1a6LAca5usKZimkmDcJb+jHcYqm8gZGD3ATEAobjb6PGlNsFH3wzaKBV20po4lYsFmeietJ8MAm7msIeREp0oRUfCKiOg6U6iyz1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Y7KOS/aPgM38D7r6jjug0bODXEY2hZcu/Pm9pK1mLg=;
 b=DDNj+ITL0FQ1bP1vMkg7YKZnm/9noin36My46qZlffckSAVbUg6EZgNE4iBUrCZCJ1AYbJuIXjc1LxeVUvw2Jm9W+SpRDAu4Fd7qJZdBUKdIRErcR0KEk0m6Sl92qx3UCYVjkUGD7OcgX0zCeGVwJd70bWZ0T5oRehG6WaSGmZAi5MqmCd30gkBJtnRUWfSakngdmADhr3TW+I96golNC8C5B9o5iOOBEIDgn3Pw7BocB1/esrk/TdMogRg8qUas0hjL9hpPGXjkszn20GPJpwMKcHZnBjW1QCe/KERxDmBDtRxG92Lw3AtUQERlgRU0SRl9Fm1nbWdTZG8os/mO2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Y7KOS/aPgM38D7r6jjug0bODXEY2hZcu/Pm9pK1mLg=;
 b=X1GRjUBGpqwzm9Rd4aGziZXXzceIOp3FlnzoFFZ5pqEtxYMlVdGEO4Qt1mEoREOi+lJP6VXVlzwCkdA/nXaeBTKgXhO+uBYdZ+9YUnDbJtL8jah9Mp1L8HdtesEk+Swx6PeSjc1hyqPAdfrkdSnNBsAmZPwWtJQMLkSOXDhof1gN9z3ZDF0CpNWC0yGDaQV9fqHQVMKa13hdD3lKe51gPqNq0RGOuoUUZSJqiv55Y+vnn4j6R2ZVsxxnSIWr4syhMubEI982CKvPZZ5dqj0Ct5LOZpYvrSOLWd/f2N6+a/hfMY2X5Op2wd/3q3u0QnAOyEDeqc4Fq9zhjr2msI2XdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7896.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 09:09:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 09:09:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 12/15] mptcp: delay updating first_pending
Date: Tue,  8 Nov 2022 17:08:34 +0800
Message-Id: <5c1a07cf6f4f0dedb9bfcb7cb9f91df158f44e14.1667897099.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667897099.git.geliang.tang@suse.com>
References: <cover.1667897099.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: b168a662-5813-4baf-f23b-08dac16902c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3Ivi5ZX1Em2dTE8iDAg6M2eeIF08pIZXq+JRY8aXek7fpcUaquRp5nzS7kgp7EV9vDREeYrwzslObY+zVvLV67Rc2SkzPUNfP9IY4BG5nzTJACzVNjdtwiwhYecwnXhxip8Iyw0QmeMMbPePBSt3lxiJ20D7+Pxx4cKW0CBVynvU1/LYLYACvk0FuYegWjDL/Nv2rVkmsiN/Q6Yaz+X8QuB6aHEfejFndS3ZxTXo+Z56fxM86nEh+hVjnoyhJPkyWBDR6ikhNVpYA5cOndnfm3kqruMiqUlyDw05KH8GnlhhPOiWbgcXeJVtMwLduxOiwWDO0eqyEufApZKo3UwuKkJ9UEkzerYKG3/QQxRU+h2w4ZZyt2p9fWN2uioda2QXRKneGwL9lLKURR7HoT0L70sDbO4KG8BuqjgqCqh2aorj+K7SU+QJNXv2D46HEuQL/eRLQWJSA3ug2kX+tJKlddijdEIYtcs49FQjgP916OPFzI9zod6c9kkKEjOWhjloU3TDGIc6/oovuAsDvzmqPnPIrdwui+37RFmsns7Ia8BbTM4gw7Zk1BQUjpExcZhBJ9rXpafR3CXv+d9JJfn77zlQqw3Ks2pL4MkXA0a6Fc4FoUoeoXy0fk/k8zysnk9hQMdHyeEfUBEzDIJcsDNuM+0r4oMHVIG2eJhfP2WK97MMKwsBezM+vlqpSvZ/DYgSCX4Sx+rCMgaiL/6MwnkLXjSMAn6kAMBFpE9i6azVKglwpRa0zhiL/OZt1W1XCRP1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199015)(6506007)(316002)(6512007)(36756003)(83380400001)(8936002)(2616005)(186003)(5660300002)(2906002)(26005)(41300700001)(44832011)(66556008)(66476007)(4326008)(66946007)(8676002)(107886003)(478600001)(6666004)(6916009)(86362001)(38100700002)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mu8k9eQ0CifjXlQP+QhTtUJGQc0Y08DtSqBcxe5iOjpqanwQbzmhW3FsrBy8?=
 =?us-ascii?Q?kTRSz/2if5K9H+WpI7QiNRE+uvz5Lur7l55mVDW4wX6C/3rnqcNc3q0/9AIU?=
 =?us-ascii?Q?fUEULSyjl2mxwVii9Gqy8rX1RrpcJl9ssyzhj7pPILV0XxwfFfJGFm/AgNdR?=
 =?us-ascii?Q?6MyTul+Dm+RjlgO4vY0lVSDK2RzZWSTKtnxU8VJSnICQn7xqh8/ubH9LHkp5?=
 =?us-ascii?Q?ZnB87wg0Av5F4vcRDqEp7IrnH7P+TtYB2w/5llU2MT1C/Sbq0eAAABcqBWoI?=
 =?us-ascii?Q?YtmbcdS5eFrioLwcV+3BDyOVWSzF27EVNt+JrFcD7kZ11jacKKmt0w5rIy02?=
 =?us-ascii?Q?0xIQfYTQ6Xttz1SaAFe1I8m3HZ0DyIBm2yDP+680hDjmqlSka5DXCTbswxdq?=
 =?us-ascii?Q?gi4yjLvz2V4V4YgtaY91r6SuKemfSvplEUOHQYgOmJEp3ls3w+TWYqUmSIrI?=
 =?us-ascii?Q?xK4+njkaa5aEw7rjnXsW0eZBPqCqoYOtMm/CfaEPbRFZxZF3eN9XVtQ5PDpr?=
 =?us-ascii?Q?RDDia+g0PE7rVUypClh96ovSMARfUtPUoU17EBs/puzwN9mf95m/LWm3ciIu?=
 =?us-ascii?Q?OydnHcC2SdgCcqx8NHuRyAs/okoF9215S2FVAR51juxOAhkqXTudDUFHsLC0?=
 =?us-ascii?Q?HEmdZ3U7FDj5VqX2KTEepSTqMLnyFHlfWb6AQFApXSfWTK/YjeLXb008In+b?=
 =?us-ascii?Q?RXa3wL5ynavfUFkrI3//RBwY0m/LDOGitL/m75ZBXMecp7lBWyxv30yfeIXl?=
 =?us-ascii?Q?K3TN7I6Rnm1XdfAkWdD1QXH/WN784A03OCG7bAkJgT9LlxWudSp9ulHHe7ZT?=
 =?us-ascii?Q?i0myen+R716X5ULrHuuhunpRIAwgSiOJ1IIGauC3LKTB0sj6qhOX3SogSg4P?=
 =?us-ascii?Q?L5AQCqqoTO30lCADEDE+QZHczqWo6cKSIcy46ZkSewQlZGhM0mQdcfIS7nhN?=
 =?us-ascii?Q?Ur7WiNLO7/wf4TSnBllppSgGhiaahsFyeqHCrjUeWLNDUjh8Rae+e90I9nb1?=
 =?us-ascii?Q?B9ksToDG8WT6XYqwHw/4SDXb8ENvbVCrMBcSo0KboEdfzqb9tZu5UIU3MoUg?=
 =?us-ascii?Q?8Wo/xCLP5DftwU5s+qTyzeJexbWnHubGQx95FAnFQFsdbDESekEAMMuGpcRO?=
 =?us-ascii?Q?SVGUeg11gbCt7TdDEAQTQYGxPzoUupI4gvNJlpPNppD2JcSNcfULDvO8XLEt?=
 =?us-ascii?Q?YDzI82d4hP4u9ZK0SoPQTFkRy7N5Lec+tbkCJwQXwow1fw7Vkpik4NM7dui+?=
 =?us-ascii?Q?icYv9Cn1+L8UTlSuDaoDZseyQ3oBnd8qM/ZAWbTEvAEbnM84JrA8nKCvNOog?=
 =?us-ascii?Q?x4DNSkqvsJ304daqELJa4NVg8N2UtvpaytobUSj3hdVA709hqVp/5CuwdaMR?=
 =?us-ascii?Q?uEJsK+BpoGBXRQE51r55sSTNVirZlb3YPXn+Wwc2/DG9+grZ8fl6Wd8OxC0O?=
 =?us-ascii?Q?z5BksxMfeNwKlq7mxKdZA7jM7e7Puec39q7vLDM65FSLysipt9nmVN2tCVR/?=
 =?us-ascii?Q?tyy/qEr01JSMOLufYZ30L92T8TYEZppDv1SD7IHM/Fg6fetTdnLmGu0zSoup?=
 =?us-ascii?Q?IV6v+C/LaSijP4gHGyeLPEzzPCYCkVs9St4KdOaj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b168a662-5813-4baf-f23b-08dac16902c1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 09:09:59.0994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLCNMOSFPBhjK0JeKMOpeY2kEXO0ooks6DutaIoLzTS+3gGQVapcn6FlH2rC6d97D2g97mxvL8Ar4HW7ODyaTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7896

To support redundant package schedulers more easily, this patch refactors
the data sending loop in __subflow_push_pending(), to delay updating
first_pending until all data are sent.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 33 ++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h | 13 ++++++++++---
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bf49eaf203dc..fc3498f84964 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1121,6 +1121,7 @@ struct mptcp_sendmsg_info {
 	u16 sent;
 	unsigned int flags;
 	bool data_lock_held;
+	struct mptcp_data_frag *last_frag;
 };
 
 static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
@@ -1511,6 +1512,19 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
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
+static void mptcp_update_dfrags(struct sock *sk, struct mptcp_sendmsg_info *info)
+{
+	mptcp_update_first_pending(sk, info);
+}
+
 void mptcp_check_and_set_pending(struct sock *sk)
 {
 	if (mptcp_send_head(sk))
@@ -1524,7 +1538,13 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
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
@@ -1543,7 +1563,8 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+		info->last_frag = dfrag;
+		dfrag = mptcp_next_frag(sk, dfrag);
 
 		if (msk->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
@@ -1552,7 +1573,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 			goto out;
 		}
 		mptcp_set_timeout(sk);
-	}
+	} while (dfrag);
 	err = copied;
 
 out:
@@ -1601,6 +1622,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 				ret = __subflow_push_pending(sk, ssk, &info);
 				if (ret <= 0) {
+					mptcp_update_first_pending(sk, &info);
 					if (ret == -EAGAIN &&
 					    inet_sk_state_load(ssk) != TCP_CLOSE)
 						goto again;
@@ -1613,6 +1635,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
+		mptcp_update_dfrags(sk, &info);
 	}
 
 out:
@@ -1647,12 +1670,14 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			ret = __subflow_push_pending(sk, ssk, &info);
 			first = false;
 			if (ret <= 0) {
+				mptcp_update_first_pending(sk, &info);
 				if (ret == -EAGAIN &&
 				    inet_sk_state_load(ssk) != TCP_CLOSE)
 					goto again;
 				break;
 			}
 			msk->last_snd = ssk;
+			mptcp_update_dfrags(sk, &info);
 			continue;
 		}
 
@@ -1678,6 +1703,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 
 				ret = __subflow_push_pending(sk, ssk, &info);
 				if (ret <= 0) {
+					mptcp_update_first_pending(sk, &info);
 					if (ret == -EAGAIN &&
 					    inet_sk_state_load(ssk) != TCP_CLOSE)
 						goto again;
@@ -1689,6 +1715,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
+		mptcp_update_dfrags(sk, &info);
 	}
 
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f8cc14064573..4b13ba9df34f 100644
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

