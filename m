Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280DE4A24
	for <mptcp@lists.linux.dev>; Tue, 18 Oct 2022 11:03:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPV5XluawMDgy4sqRVqGFE+8EU7lw1u63PNRqwcwzktst38+MvGMJeVFpSUPPLeyDdN7TgFyMUgprnIdvg7pQJNU1qlxvNpI6buoTZ67tYy5J28FIOcUqfd/1p3zWwRNkmcBz0MscXeYaqL7Z2a3ACnL2W5AaILjv9oF+SS2vfEEowfHKbPY57wAbL5v6srZt1qW9ttxvYPxtEWBOC0R9CEicAQBpm8FC1yvtEyBGq+dGO5hW/2dl5pVHXQ2wF1pHWfRwyaoF0pX4nndrLOdWBNGJavnomVjqSr+pI+X6lNUBsvC5HQyRJKHRWHRLnPEBckO2YVbrh/uRWNvXL0mzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEGJYsd6Y2NIw0pE94lIsVdVd0mXbtiupplXsWcP9IU=;
 b=AQcagzRRMzAkTQfcqdUYT2SxKBVKAeLSgS8+xWPGe1sojpW5h3QToVSYJyH8/fQknqSFR/ADi+cR58EoM//EmJ42r8UtzS+ilIYmXJRzPw4zlU8UDd/wDn1HxgqBhEK4UNSVqKAATYVpfQufXGjqUuXiYKmoelp6SOJROS46O/w7NlJjDxTsr2gHeidMofVA4PFv/CosEjmCdEWXKZDqMkYkTOpLeNYY/fwi/4LtiFsl79KJuJvypuhrndpbpYuGFdvSgydC6pbAtyv51otlZGhyILgvuZJiHjvpI3jAaAlGLX82VHtF8d77FxbxBRQtHDI157/ElLgku8bWzUiLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEGJYsd6Y2NIw0pE94lIsVdVd0mXbtiupplXsWcP9IU=;
 b=OK3SA3Zl4gG++mVtRU7PVplf7s++TT76SmA8lEQpJ0EcMDam8qEpoBKJdsdOcRZ19q0fc18Ft7heG/O+6eY3Bj133cuokM9SLc31hFxYqyCf9zaHR4uiNm8Wy4bY02P/P11UpyiK4+9lpftAWngZXnJ7L8//MqB1Y0EYfwEP4iLBS26sr88TGw4ZfRR22FmlYCAfAX9sJLV0CQWCmMO091rAws3JTGhzqNgN0EIsfHYZFr6IDgo1AP0m4aV80nL+Cq2nVMUHtFF4+Db9yXjdF0No3pE9maG/UIiiY8OG3pnGxxBLc8BiFBRqhso0sQ8CEAuAqVbqYAh1X2u1cEtqlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7369.eurprd04.prod.outlook.com (2603:10a6:102:89::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 11:03:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Tue, 18 Oct 2022
 11:03:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 1/4] Squash to "mptcp: add get_subflow wrappers"
Date: Tue, 18 Oct 2022 19:03:09 +0800
Message-Id: <20221018110312.22510-2-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221018110312.22510-1-geliang.tang@suse.com>
References: <20221018110312.22510-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: acfa5dc6-8b71-4aa7-1180-08dab0f86645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ziCzyzhnQHyZlJ+ssq9Y0RG3K/4lmMgPg0UVi9Q7+sCkDCO67kxumi9IEm/1PbgZ/izJD3zRwUs2fQiI+YFGgAXuVsf/Oa+fnbcva2ulfImXP2tA+1tOBQMpej4JEAjL0CFJrV5nxSUn+XeYoQiy/BA/wZrzUG8jFSbpKLDUeuo5Mzhi0vaGJEOAPBb74LcZJrJcz8KQsP07EBIcse2xWuqhhp9iWJZoNlaEBhoVJT91bzoYqTOPauSdOIpprBxdiSVDUWmeoxyd2A5kcmGtPS2jS+BUI/kWReXT1GgIgPc4OBcQUsA8KrGPZxFtsll84ERniwE323VMyS5dVG1FvwmJZJ8mvyIVEOosT0Wj99l7blYyOsnGXgsVlrauNKbAxJmeQ64rtIpQd4ZRo5NV/IG+smwcpxJYJ7RJ3PyZITo3pFIAXqbl1rKjmcICzyJDPG/0Abj9+z6fbvK6WXV8dyBbW96B12wYdOlpN85HuYO2EdWlja9BYfKVe9h+3gBdj5h/RVqaShMQYgbojl8DPRpaujujgiyLeiHStyuQ2UMuyTduRMJ464mPDvh3kMC4RX/y1E3Awu6ImLQ5i+1i96QgnBO+3bY1nE0pK0+ELgcl/SqnaaaKr+c3u/r//T9j+HMWCCpMXgI10V5FAlGbrTZJmN9LXrPVIrJXk2ByIvHKieRJLPTawuEwXWr8Q2bwpH4KjJyeQu98OpqejMQqGVBkaDCy3DdGzDuDRWJIs3KHHB6WdapsDeBWSBrPO9yc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199015)(36756003)(86362001)(107886003)(6666004)(83380400001)(38100700002)(66946007)(66556008)(8676002)(5660300002)(316002)(8936002)(6916009)(44832011)(4326008)(6486002)(2906002)(186003)(1076003)(66476007)(2616005)(6506007)(478600001)(26005)(6512007)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GKBproH3ykUSgIONL2zmw8L3Hswg6zob6EAHadlCWg66wbQ9LHkmIXORhfhV?=
 =?us-ascii?Q?7CNi6P8a+nXQSFKBUBvcr2JysEgYmdLULp714o09CzfXrkDxijK5E0BveqNI?=
 =?us-ascii?Q?D1p0Yj7a6+Oivx+J8FECprzOAIKld96Ylr9gFq08lLXAw8e55afAh0tlE9aQ?=
 =?us-ascii?Q?HE2LelCeiCTuu1X4nDwtDONzRfhLelhdL2CiMmmUsSAUg18GDbWOYGKvihzh?=
 =?us-ascii?Q?9A64zlenccwRKDzrlBaRsL6dFaECVf8dJdnf3GY+pxkmQCvlJ7+hRQQpfCGY?=
 =?us-ascii?Q?KqdKVHz2chUzDqqYoh3mOWMe9K2kMAWCnRzMxq1Gth6SvQcl7SyYt24n06BJ?=
 =?us-ascii?Q?5aN43ohLvZdGb1Wh+Twe476nyagq+av+w0htV/bWpffMQBnPuhoquetg5Sng?=
 =?us-ascii?Q?saG4SyIYYATNyzUd/dQO0DttqN3aQ7zeymqiKL9Wtae8GN5dTY9xaDyR/TDC?=
 =?us-ascii?Q?gDma5qQCCNiva/EOnXz5/gXWrUabxZq0hNQSsXjEU73XuIBZgw+uxeYeG4Vu?=
 =?us-ascii?Q?I7qcd/8BQxPX9hPj9mxyyF7cFk8hHI+8WXWg1ofckeFFPHGe6y6yFomE+QHV?=
 =?us-ascii?Q?lsYI8/eQbkzvF6eKHFlzmTKXO43zry46VeDTw15lu8IzaHCG4mZRHKT/54fp?=
 =?us-ascii?Q?ia7PYNsytWScsyGR8eOeRuGdQubnHDOk6aAzhXJ3PPNgXjgD8hlqbRaO89rs?=
 =?us-ascii?Q?YFtOlEUrpfYCVs4xNGNL+iqAl5TmJ8gA4ImmcgkdV4I1uizRkRG2GrT8YunQ?=
 =?us-ascii?Q?zoO3A1qmMaD8X/YDdu8AuW+k2MM6UmC4LZFfZATQ6tLffAfGeWxT5lApRvd1?=
 =?us-ascii?Q?J22UIcCU/ubopeveIuR+ML3wNPXz7t+auCX78Oom9BIFAfM/dPaDgmzLdiGn?=
 =?us-ascii?Q?F17aj97r5YibjPT+YxSzb0yipKKsktu3X5vZwcnUwVJTXc51u0MRs75oLRQh?=
 =?us-ascii?Q?L7Em/5Ll2RYpiyaSIdxo9cWmV1TEvR97SM5KmzF2pey0TZTrNMU/rDPpXTG7?=
 =?us-ascii?Q?3Pi+r9+km7bMnhsQ+TnBmWAP1g9HvrwkItdTW94EGEGR4wf/yqU7nfXAzEq5?=
 =?us-ascii?Q?dlmiCjvfvSc9B4w6QwdV4HTKzT1+ZPUiMebHxrjlSMOwTi5AAs+y+4vgRJEm?=
 =?us-ascii?Q?vdqhXwxq3l49CZIp2xpSeu0KvYzNh4Ag9t27l7P9rR9CBnhCAI0hzqVkI2Sp?=
 =?us-ascii?Q?4VS6hNjuly7ixmld3+ByGDTPn0kBYv0AJxj42NSGwKu5NrjKS4cQo0Si4CK7?=
 =?us-ascii?Q?hBUHyIvDMGJlySkM5ONkSaPAYt2SM1vJSPZO/RkCE2TmLGyl8UY0maHcWyZv?=
 =?us-ascii?Q?XrK1vWJE5rziagZXGH2ldyWnoVgMh+Pxy/6+mKedGPbqtzuCzKXETxmZGpRR?=
 =?us-ascii?Q?BiqXKdepnNnH8e5uWWnOzOHmqm7C/EqRss5Tj2e95quwSWekAXNINYX8fvec?=
 =?us-ascii?Q?dP4wswDkrWo3SEpCMJnUirmNwbHrd0j7MoCTRyoEle+uPVavpYM0acKDXQqA?=
 =?us-ascii?Q?y1IkXAc0zHC+HasJKt3bsUy7Ap+yCdfrBMLKDhy6qSiRJdNBiQCqqUHzfnvG?=
 =?us-ascii?Q?WxUw93Kpak77P9C6k1ktVeYJqgRU9N70/Tp8FWYneGzHMsakWIx4AGd58qSF?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acfa5dc6-8b71-4aa7-1180-08dab0f86645
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:03:34.4120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+9WcujqZy6du+2yM6H9hBkg9gdDCxMNCL8jr1lgKmiEwqZW3bjASl10FYUpTUtHgu6g3Vz5txsKRj40I6uolg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7369

Please update the commit log:

'''
This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.

Set the subflow pointers array in struct mptcp_sched_data before invoking
get_subflow(), then it can be used in get_subflow() in the BPF contexts.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler.

Move sock_owned_by_me() and the fallback check code from
mptcp_subflow_get_send/retrans() into the wrappers.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  8 +++---
 net/mptcp/protocol.h |  4 +--
 net/mptcp/sched.c    | 61 +++++++++++++++++++++-----------------------
 3 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3196d2a350f9..1cf8b1c68e09 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1547,7 +1547,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			int ret = 0;
 
 			prev_ssk = ssk;
-			ssk = mptcp_sched_get_send(msk);
+			ssk = mptcp_subflow_get_send(msk);
 
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1616,7 +1616,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
+			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
@@ -2500,7 +2500,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_sched_get_retrans(msk);
+	ssk = mptcp_subflow_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3218,7 +3218,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 		return;
 
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
 
 		if (xmit_ssk == ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2358a4083eb3..8f48f881adf8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -643,8 +643,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
+int mptcp_sched_get_send(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 044c5ec8bbfb..9b128714055a 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -114,67 +114,64 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 
+	msk->snd_burst = 0;
+
 	return 0;
 }
 
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
+int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
-	int i;
 
-	sock_owned_by_me((struct sock *)msk);
+	sock_owned_by_me((const struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_send */
 	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return __tcp_can_send(msk->first) &&
-		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
+		if (msk->first &&
+		    __tcp_can_send(msk->first) &&
+		    sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			return 0;
+		}
+		return -EINVAL;
 	}
 
-	if (!msk->sched)
-		return mptcp_subflow_get_send(msk);
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_send(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
 
 	mptcp_sched_data_init(msk, false, &data);
 	msk->sched->get_subflow(msk, &data);
 
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
-			break;
-		}
-	}
-
-	return ssk;
+	return 0;
 }
 
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
-	int i;
 
 	sock_owned_by_me((const struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_retrans */
 	if (__mptcp_check_fallback(msk))
-		return NULL;
+		return -EINVAL;
 
-	if (!msk->sched)
-		return mptcp_subflow_get_retrans(msk);
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
 
 	mptcp_sched_data_init(msk, true, &data);
 	msk->sched->get_subflow(msk, &data);
 
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
-			break;
-		}
-	}
-
-	return ssk;
+	return 0;
 }
-- 
2.35.3

