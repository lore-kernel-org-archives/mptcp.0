Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A952579
	for <mptcp@lists.linux.dev>; Thu, 29 Sep 2022 15:03:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIW7CI5rh43os/N9HrU6JVYVH1a1Uwz+GKW7mPEbQYlEEPpEyMkFkCfGnnBqma4kVtsirQYF7lBzjL2AKj+dUK8yM/AVeyzYRw+9IxqOWHkOAl+7QXBxca7e+FOuSg35miGi9k5KTv57coxQcR0mTe0zEowDkHly/4eI+sVWR7JWKSfGP5Gwh79c2xmMzKVDFn4UGVm55fWRjPEP0I3ifhZR66SanDQsRaNIAzvzA3QSQU18KL7BzWG3HwP7RkRtwwSyMGwAv2lKDtB5bNzxsTbXNKhJLk8EzZS5mSruIL74Avj9KZ3Uo/DXTF2Ei7fqc2K/sqqs3nguaNtO/EaZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaL4xNoAHgJQtdwy27qiVFaGPslMFSrbbubFjIcXw2Y=;
 b=CZvuV5lKbr5P9+EEouBIlJx3F5YYtlqfj9nVy7Hd29jNTsNTL4YBF9oHaX1sbWpIVuzYP/xgMpnyPRGXAWE/X23xn6i7ErOK95wu6KRBnLeluXuyz33OKGZPxvybWc3fwLsSKZALXKTi/R4/KXyLfsjw31a857tV+UOVTB8NuyVRX846JZC7vsxUHxEBT9AAZc8Dc7F64ylJGKO4ZRYvvGSSKJA+r2Am8xleZ7rteO8o4D+k4QjlOJTb+n0UQXMS99XOGCoXR00mksMrnsv6r7eAlsbC+F6GEIJVL1bS1E2o6hhoIfYcpkdAkzOx9X54mUbYfsTB4RxOzHNVsvWzuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaL4xNoAHgJQtdwy27qiVFaGPslMFSrbbubFjIcXw2Y=;
 b=osWeMTINTv5hxoik/PpLs5wiKqEijFrJT7SidAd+h2w8B1lNVnHvDksErMsNQfKb354KGB4+YDCy8MJuflXiK0zfE0RtiXWV/YUe3Fhz6vNbBnM2Kx30KBxvqqSkUgotT+1VTXjIwMErBmognPIP682dEs9ZAFXakmbrlFXanpPLWjqB6KIBUIr8/knPY+86WABg62FZaNm5+yo7xEmGpNopL+FUKR7gBglFJFLJTSz10N/le6BaFxxucLacR2Xkxhabm7HL2hRAC9BtJsNcfGCNCF46JLX942l0+Y2UIEb0K8LNb79YsfMJCtlX0/TP9sX4Xw2PG31+sxeu7iV4qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9362.eurprd04.prod.outlook.com (2603:10a6:20b:4e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Thu, 29 Sep
 2022 15:02:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 15:02:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/4] mptcp: add do_push_pending helper
Date: Thu, 29 Sep 2022 23:03:16 +0800
Message-Id: <3c7f5eb863b0b3b065fe28dfa116e7e1955b40d1.1664463491.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664463491.git.geliang.tang@suse.com>
References: <cover.1664463491.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9362:EE_
X-MS-Office365-Filtering-Correlation-Id: 427e0f39-c429-440d-e5dd-08daa22bb2b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WL5qSXdbS/NaUk45f8y5O/6AXYnRx8Y/9fJ1cOpja/QYnBI0SekFD8jdbCjObvuqAw8mZbUYxZgzaP4lXX/vE2IXlrDoBTLvdYvMHDwJ3HhWWWHwDl3zo75/Wefknqx4WGrax7qEifGoG2UVptBu5JtJrHmVnPXLOo/43uc9OqnDpORfdmQki1GHyWQzs/myAIlTNm7iUGhdLWwAy7ND3UBSMZjk9Xs2/JrCAUOCzkkNvncPW4v9i1JQO7SQhBDAEeW3gnEXasf99FcBCyyVeqefM6dMGkzUNI7gtraA/TSrqQLapSKheZh3UuikyLiEASHiPYIdscHTO4r43O5qaIwQ4TskvpzDi9uKka8SwoxdkECa17MrX6bqiHLeE+iB8Mhgq99bBeYMzbCqB6x2phCn1F8r3Nxobm3Uv2VPFoE5MyBXQJkeI/CuGA89MKYl7iVkamGGyFIgtUf/Bk7XPr9oaziK+FJa0/p3ismFknVekgbzBAgLM61e3ElhwaiOEzpd+gVvrMUGL5mZIGlHuYSTgHbxC6/HpwE0YMesEitokDzWLxsSxIiM/KQbR14y1W+sqUe+NToJM0q7/hHblYaE3TQfrrQE8sbqLbAtQ84AoFqYGxLXVSwZfUTuXoDco5krZRN6Mpy4ZI9nvm/3GUPWh2lf8O2X65tOhMAb1x3yUv7XMHKK46gIoz/c3WR4QubIZ5CvZopPVXegN/eZbP7narK3fh660l9FK5+EwQGm38NC4oI/IvYfphDiTGAP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199015)(4326008)(36756003)(6512007)(86362001)(8676002)(66476007)(26005)(38100700002)(66946007)(6506007)(66556008)(41300700001)(8936002)(478600001)(6486002)(316002)(6666004)(107886003)(6916009)(2616005)(186003)(44832011)(5660300002)(83380400001)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wfwjQ8WcUCEMAD1XI9PNEDTnlHlTEyjtW5IFmHw/bA3nsh30NaTdDm+zhEij?=
 =?us-ascii?Q?pc/vXa+NiSe08U1CV6H4QXY2gOqAZ3Tr173ATjqfBrnYqcE6byVaKaYPUL8g?=
 =?us-ascii?Q?IOcNb+hxF/Ls6LLdmsRY+ZaCnKyjGunntFrb+hcMT5is6nH//19imKyWVeYd?=
 =?us-ascii?Q?rc8VcKJOd7uW9BE0a6PJ/BsYf3ha65S+tXIssYEJX1kyGTVUks5zPHC6S4nt?=
 =?us-ascii?Q?ln25tjBPjXNbGX+3MWRBma5/vW2QWbYBvTsFnQY6R0sxMUv2RBECDsRd7DT8?=
 =?us-ascii?Q?am0X87NWyLipWfugknOpLBonW14n6A8RNLgOf/1EHe8iasU83rXu+aJ9z0z7?=
 =?us-ascii?Q?q7+cl5Pvkh2K+cncVB1GHg5BpwJ9kB3VAS7sxyy332yWRpfYkbGPdQtjC7Wv?=
 =?us-ascii?Q?aLSUYYO3yd6bUZsVJUCaC3Xg97Fi05Fc5ESmqbgyBYpmnwX14bzHVzfhlQMH?=
 =?us-ascii?Q?FoxkNyG3Da7xEky77MfnbO7NmLLxc5N/ZDG1LTPPtc5/r8bz//2ODqGXGWsu?=
 =?us-ascii?Q?aLNnEbkdIs79Hxl6ORoEcMN2aVqYQ+lk7K/PgIQ/BcsieQT0EG8nLZBPa/Py?=
 =?us-ascii?Q?0lovfmP4sDzo4psjYXdMUHwPGGZAMDx9nyTqeipDNX/sDUmfsHGuLSFXOKCK?=
 =?us-ascii?Q?xpTe27o5Nzb/U4+vQrMYjtKtVbQJTnAmpVr4KWM75+UsUYK/B5TAFMGRhGp1?=
 =?us-ascii?Q?QxoaIUIS4Ycem2a3l3Fne3EW7Jp9FfqDGETbet4bs9Z+xGjlEg3GDAUmUT9N?=
 =?us-ascii?Q?JB1eDHsSMh26I/ZAiJgrlwxHGH5+yjO/kev30AWS/Mg/6ENuaTzFQwRqvuzw?=
 =?us-ascii?Q?S8fxxaVWDetYPhCScYvRbp/k+rc+4AyKu7it9ln++rqExgj/LG3z+YuCVQFn?=
 =?us-ascii?Q?tA+T+6WYybBdvY93GHx483Vn4OKYJ7RF+ydUodg2wgRunaehq+gR+qQtCSma?=
 =?us-ascii?Q?vLRevg2IspyGmvp94e9lIWJHN0y+PqjpfjNr9iMkNvmFgukZddVVg5YNgR16?=
 =?us-ascii?Q?P68PRf43o4KonVXONzGRDNOM1vbloRJ+PCzaaYjWkGgAVrz8dMporw6roSgu?=
 =?us-ascii?Q?K76JDtY2STQK4i0vwTKJ6m4PIYHWUDwpWToSa0c7XB9BWpoMnCjDzCCzNA8W?=
 =?us-ascii?Q?5pssvsCVLJSzA/pQmEc+cfWW0GP8BgHXiGeRVLvBlA5Hvqi24775wxVKwagg?=
 =?us-ascii?Q?tPyErqS2F0pF4qyKroO86oPOMhIuUjjBMvn8Cli+SQpiU78UCUaVySh4Buyx?=
 =?us-ascii?Q?KZlH9Dgj6+yYX9dukSCItKNudoAu0H2nO49SMjHdfPOjIgxlskFBPKK2gwpU?=
 =?us-ascii?Q?V1EtCvUhhfNog0k4E5STrM3PNdgXNlt/FQFj4aT5pSJAywgq4zk+JmptJ83Z?=
 =?us-ascii?Q?ippIi2q8N2VZd7mC3BrhBVyPbzmjJ/d64H7KEUspa8P0H9KMolraQsQlKgfN?=
 =?us-ascii?Q?1XM69wqD4TVbq7I73LeqOpfRQWr5kmlMzwEbFVNkheQZRga/ENHGvnmqQsf1?=
 =?us-ascii?Q?QFX1JeBwt6Rsx4w7/A+925CxwExrJYcrSvQDhlWNJnI2WrslqjoF0O0IkoXn?=
 =?us-ascii?Q?GiYgxX++gKPqwDeK+LSUkmXnfQgfPj61RZ02T4XK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427e0f39-c429-440d-e5dd-08daa22bb2b9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 15:02:59.4979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Z0JjXdJ+wJ98yQowdU6zzkWL64rjL9Qi1W4PHWc9/6/eOLZnzqrHc3Kygl0kXFPzHk1Sa+r3b7Vk0bEaXlKBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9362

This patch moves the duplicate code from __mptcp_push_pending() and
__mptcp_subflow_push_pending() into a new helper function, named
__do_push_pending(). And simplify __mptcp_push_pending() by invoking
this helper.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 62 ++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 37a252a3f05b..fe92a301b8f7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1483,12 +1483,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	return ssk;
 }
 
-static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
-{
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
-	release_sock(ssk);
-}
-
 static void mptcp_update_post_push(struct mptcp_sock *msk,
 				   struct mptcp_data_frag *dfrag,
 				   u32 sent)
@@ -1520,40 +1514,29 @@ void mptcp_check_and_set_pending(struct sock *sk)
 		mptcp_sk(sk)->push_pending |= BIT(MPTCP_PUSH_PENDING);
 }
 
-void __mptcp_push_pending(struct sock *sk, unsigned int flags)
+static int __do_push_pending(struct sock *sk, struct sock *ssk,
+			     struct mptcp_sendmsg_info *info)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_sendmsg_info info = {
-				.flags = flags,
-	};
-	bool do_check_data_fin = false;
 	struct mptcp_data_frag *dfrag;
-	struct sock *ssk;
-	int len;
-
-	ssk = mptcp_sched_get_send(msk);
-	if (!ssk)
-		goto out;
-
-	lock_sock(ssk);
+	int len, copied = 0;
 
 	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
+		info->sent = dfrag->already_sent;
+		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
 		while (len > 0) {
 			int ret = 0;
 
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
 			if (ret <= 0) {
 				if (ret == -EAGAIN)
 					continue;
-				mptcp_push_release(ssk, &info);
 				goto out;
 			}
 
-			do_check_data_fin = true;
-			info.sent += ret;
+			info->sent += ret;
+			copied += ret;
 			len -= ret;
 
 			mptcp_update_post_push(msk, dfrag, ret);
@@ -1569,10 +1552,33 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 		}
 	}
 
-	if (do_check_data_fin) {
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
+out:
+	if (copied) {
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
+			 info->size_goal);
 	}
+
+	return copied;
+}
+
+void __mptcp_push_pending(struct sock *sk, unsigned int flags)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_sendmsg_info info = {
+				.flags = flags,
+	};
+	bool do_check_data_fin = false;
+	struct sock *ssk;
+
+	ssk = mptcp_sched_get_send(msk);
+	if (!ssk)
+		goto out;
+
+	if (!mptcp_send_head(sk))
+		goto out;
+
+	lock_sock(ssk);
+	do_check_data_fin = __do_push_pending(sk, ssk, &info);
 	release_sock(ssk);
 
 out:
-- 
2.35.3

