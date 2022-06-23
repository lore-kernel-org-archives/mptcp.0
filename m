Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BE81876
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 10:50:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIrllSwR3MZHYbmgdUYHF+qZBqki4DrD+XF1NdoR0/soxoPIQSsw0wLXa1+aOjW15sJHJMYbVBtdJDic3bC/U/qCFYRnpU8Lx7rHmuVClx6vJL0j0V9cdW81S4JXFaNoVnARLVV9mp/rGXESCsqAz/hY3x5AjKck5SymLGoAFl5wwD73WWRsSUGRp11vQanoIcIwr9J1pavYX78KWUSBzGR4Dj3hRE7I+EISq7gaPOeh54hf6Q4mOm4eL/+bnM3HkKxV502RlCgRsQ1ZpiwOa9BCgICR7EooOC2h8gbsW+PQTJpvqxRmM2tERIMbQp2b/pD3MCbfXvgaqdnKCbWLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyqihYF231941JfVUkBtUfiOs4a1mIgvx8Ejeh4PGGU=;
 b=eTDlTmWqQ1TyZ5/sano4mr9DfNdXp6nkaYhhSC1/a9H+9dxCdy0r8DoNcU0vm0ndLHbui841EMnsVeBp6nyBvcnNb6cdqWQQt6KoR0I1cBj/cEWk0nMpnyKdinG0V87xJXwCYuqMKxD4Gd/nKmloGADO5/Eh0FF9lZzIO76s9qVXLDLcSScFWI5JXiKrJBKvbwbp7XUQNJaKIgg2YNa3dnkrohkLJUoCg5e6yoM0irUKA0WWcNhCgAYYz1RoG7H3h3+XDgTai4JibudT2XGaihLibjiqaYlq62UWDDlF6VdnHxS3W/g96DqyDbRPchk3ClP30FP8fnHiVFcQPpMTOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyqihYF231941JfVUkBtUfiOs4a1mIgvx8Ejeh4PGGU=;
 b=rWfXSHZPGWsuwdbjLLQXKUkmZv7YRDy4voJUwcBfIUO4n9igH9I49KyojK+SMO7AQwUthN5lvdUJeg5i1e4jU1463M875qtUZOtm1ze4fCynTgKJKS8lFUhwYcWK+iSC2D+o4HokDaLLEcYCwKkhGQFGwyFmXo1ZZPU3CLrdHUUZwrlFpuzNM53CMJOXU9+hkHETVIMqOP15ElkLUHoVOoH5jf2dmtxfpvN2AK6kQ+0EA+ERLiWKyUG09+tdyzvqbDJoq+qvI8KGyVdCsaTxSjamisYLYe1OCbfyhzjZYrFCx4TGSYNwxgpi18EiMxrcgm27clD5faF+ZTXsnPkcOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7659.eurprd04.prod.outlook.com (2603:10a6:10:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 23 Jun
 2022 10:50:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 10:50:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 3/6] mptcp: redundant subflows push pending
Date: Thu, 23 Jun 2022 18:50:25 +0800
Message-Id: <c42a3f387637eee08607d77e5d089353cda44ad4.1655979747.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655979747.git.geliang.tang@suse.com>
References: <cover.1655979747.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0148.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e053e7a1-1f34-47c6-9363-08da55063790
X-MS-TrafficTypeDiagnostic: DBBPR04MB7659:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB7659F5977433A7C95D84D74CF8B59@DBBPR04MB7659.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j2HeWkaiV7C0gapSbOZAn6lfrdy33kRQOHguzzuUAd5ZIyOvSb7uyarDEEJAkGfg9B9fwvIk9JhhJ96L3Zy5gkxKT04IjcLlTAkPpjMWoHQMXN1AY0tplL6Bn+V2l5A/UgoUX+qDzVB/fmMwoa/4bnnmwCAC7sepCpHn5QFrFYffgBOua1dAeQ8/595X9sR5YRpVkYv55HOpWZSPRMkXSumZg/rXYiIKSD92+yiLa3XBASM6x4V6eR2N0htg3h/cgnMleM5ahDguR8KwI20ZFNPa3lbDIouF+1K3UXD6jsvGNBYl1S/HQZ0skW7H1XAsvVNxThG0C/CGWDc3yflKTUd31n8i8c3zLj3/pD3uqD0wf2X/ZCGWkdEZ4yDCAMcUlrpJHzTjueAa3//zsoXxxX/kIeT7d9OgWginM3kR+hi59AxwbL/XKfI93K3jMFk6ZaKEg2KtHWBJdov1xAMyjXikXUheByFSaQ2Jh97AJiR9dNaQzdgAOqsriJn3yED759ICsfM2qRAmMGjupq3DyTTWjLqW8mhtFkvGtQOntz2EyBPanw1ArL7bA2zJ7RcPcZBQHmMBrAn8MPe+ag3XJpspGPB2dpCVASl7qLwSqvVq5gy5jP6acTyKKKT2PB//c3hLhsd3LeVS+0oRIP6ikflbqlIQKLZVCqdyb3E7xgB4Z0aRfTfgbcTcCBnWbfQa+Aui0K2gQeMWuOxJHhgA14R9k2a/V+iyB25k4FxV41iKQW7+5TQwgkMOMoUyEJWt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(376002)(366004)(136003)(8936002)(186003)(6486002)(6666004)(66946007)(478600001)(36756003)(66476007)(4326008)(8676002)(41300700001)(6916009)(66556008)(6512007)(2906002)(316002)(26005)(2616005)(38100700002)(5660300002)(44832011)(86362001)(107886003)(6506007)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jp8jP9xoTDD1mA7eGawINT969nJhJqOoyM4kAoucpkJiLesgsclARrK1lMi+?=
 =?us-ascii?Q?dZTI8C5dZlKpcigodjkPLfme30xwdJVvvocvB5sCh9F86CfYCqka8ZEA7sYb?=
 =?us-ascii?Q?7FuWzL+wggYv5diAzczMnZHLKfu5fsWQE/4xV2Lw5p1azoWeCOOgRM32aR+Z?=
 =?us-ascii?Q?ozK0fJB8dfRgovEktGcX23LcwhW2UWV7raTqSoz2wmr81cz65P8zTFKdimz8?=
 =?us-ascii?Q?CqosmcTHXdKl/SX7e6I2XQMuCAI/FI1nTJ8IVMHs3yP3qYi0xvIRaonorSMt?=
 =?us-ascii?Q?6jOwnZ4TqGleqjjn3dWznA7UJCKpoHJ5TDz2rFfE+7KZek9f6D0T5Nbd+E+q?=
 =?us-ascii?Q?SgBhlh9WpSx9O1bWacLpoOaKlUsQJg+lDkiIaW2fb6i5jn+q1uSd1k+90YoE?=
 =?us-ascii?Q?sNv8iqeNe3B96ihjUMudVD4QEoelhsXqUa97kCg7hFqZRSch82HUJzsKry3J?=
 =?us-ascii?Q?wsCoQItr+efWzeU6L5hLTjhd1yoaRIfxQG9biqxx5UjWv7gbrxixk0u4ZtLW?=
 =?us-ascii?Q?HHkQQS1UlYZSWdkCqx8TLpTE1mh/yBn4OC7V6THinr1P4L6tsGwu15FcvPcx?=
 =?us-ascii?Q?fVUAlPlIvBP94t1F08qy264Rxa0GHEr2w0pZsZgLdFU5Xu5UjtBmeQNIlXnf?=
 =?us-ascii?Q?pCe4NwOeU9hu2OyvrHSvbj5W4frNzwiCTB9Q82ymvu6OPF4CRxp3SQCDRAfb?=
 =?us-ascii?Q?mcJsLznUZ6vC30EgugQHiLxNlGLz4yYRLt0VSn+1bIGh+O3FecMDgQgwE/pp?=
 =?us-ascii?Q?9dGLMQYO9wRrqomKmFwJKJLZ3E2wZaJedjHwJSJwjE7VCrwpDngZbSNAAKug?=
 =?us-ascii?Q?3ZKUFg8r0/bGG1ZG14R37Px03peld3RTBOecSfvQ/scJ5U2OEDi0ScwqfgVY?=
 =?us-ascii?Q?JjFQ22cjCyf/ISDeqp3jYmBDZmJ0WoTX7Cg1qZ6h8ZKs3ihIm8x6OT4hB5Lp?=
 =?us-ascii?Q?itcmtrsyKSZE6Q7yTyvlQ79souAg9tMDQ+DojSnnfAnFKWUd+jX2kmGQOC7q?=
 =?us-ascii?Q?rdwaGidXpfZB0oUQYc+spJnDI7oJwVfxFx9XrOBhZerdQ6R72GpocoALFubU?=
 =?us-ascii?Q?3393ecM7XbqjwF/u1EcKitAkkrjCKnHAs5eCPT12J07fEKRq1uVMx4ifPXhE?=
 =?us-ascii?Q?l6VT08GAuHLuwJU6mzv4o6E6u7oATQqyzhhtDWgdtxWXEdU0h7ekstB5UYre?=
 =?us-ascii?Q?U3DLw6CzvZ58vc1aW2iztBUT8mHs69iSGvL38d0AaD0d886tlHG3fC2m8ShL?=
 =?us-ascii?Q?Ri0GIlhPGs4+C3orscWMJbQc0fSQlijxtXcGBoFB8Ty0tHRDdIUU5BhvtwW7?=
 =?us-ascii?Q?9UzMvLz7SZCqXelf0NhuarUFs+3K5sb2zoC4tYeqbu1ibfW8rE8my32IVeTS?=
 =?us-ascii?Q?Jt7geBxUfoEiKH09R0q3fn8fCPFGRfwhkA9rn/0E99wiWMmYASWunXur6LPq?=
 =?us-ascii?Q?eJ5a4aIru/VErJseA9dxxY3vjzoKS6PjoWPPxtQ5HUJGR/JP/tKNJA0NmFVk?=
 =?us-ascii?Q?PJ2qCLm9BviGhX4XQUL3EGWynG0Ox2gWChtqPiIqwDYaPROYUjtd128iu+YO?=
 =?us-ascii?Q?kNo+f29uMuZ6gqQmkq1X6Ggk0GmE4E6qrU7GdMIwqhkVGEbnCeZxp9smcB6e?=
 =?us-ascii?Q?0tl8UHADuO5Wvvl/YFnjOmvR8MUslE5Fhyl/IOeLm6+gkUeGQF94QkJy26b0?=
 =?us-ascii?Q?meRYkN490p8NbYMrWQTPRUlBsGqJE8D5I2SIm/5C1qpKgVG/RlBF2rOa0zhq?=
 =?us-ascii?Q?/IsUuVd4bQt1HjpHM5JosZDr1FYKtos=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e053e7a1-1f34-47c6-9363-08da55063790
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 10:50:41.8451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HnfIEJMUCY1UUaHn5WuzNRJKeg9NBPwNsRZMNBZGERF1z3sjPjZQhVoQsoZNDl+VTyZOEbT0JdNifgfAqFc9TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7659

This patch adds the redundant subflows support for __mptcp_push_pending().
Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send()
in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 99 ++++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 41 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 15472d0af508..0be43107170c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1516,63 +1516,80 @@ void mptcp_check_and_set_pending(struct sock *sk)
 
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
-	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_sendmsg_info info = {
-				.flags = flags,
-	};
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_data_frag *dfrag;
-	int len, copied = 0;
+	int len, max = 0, err = 0;
 
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
+	mptcp_sched_get_send(msk, &err);
+	if (err)
+		goto out;
 
-			prev_ssk = ssk;
-			ssk = mptcp_subflow_get_send(msk);
+	dfrag = mptcp_send_head(sk);
+	if (!dfrag)
+		goto out;
 
-			/* First check. If the ssk has changed since
-			 * the last round, release prev_ssk
-			 */
-			if (ssk != prev_ssk && prev_ssk)
-				mptcp_push_release(prev_ssk, &info);
-			if (!ssk)
-				goto out;
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			struct sock *prev_ssk = NULL, *ssk = NULL;
+			struct mptcp_sendmsg_info info = {
+				.flags = flags,
+			};
+			int copied = 0;
 
-			/* Need to lock the new subflow only if different
-			 * from the previous one, otherwise we are still
-			 * helding the relevant lock
-			 */
-			if (ssk != prev_ssk)
-				lock_sock(ssk);
+			info.sent = dfrag->already_sent;
+			info.limit = dfrag->data_len;
+			len = dfrag->data_len - dfrag->already_sent;
+			while (len > 0) {
+				int ret = 0;
 
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0) {
-				mptcp_push_release(ssk, &info);
-				goto out;
-			}
+				prev_ssk = ssk;
+				ssk = mptcp_subflow_tcp_sock(subflow);
 
-			info.sent += ret;
-			copied += ret;
-			len -= ret;
+				/* First check. If the ssk has changed since
+				 * the last round, release prev_ssk
+				 */
+				if (ssk != prev_ssk && prev_ssk)
+					mptcp_push_release(prev_ssk, &info);
+				if (!ssk)
+					goto out;
+
+				/* Need to lock the new subflow only if different
+				 * from the previous one, otherwise we are still
+				 * helding the relevant lock
+				 */
+				if (ssk != prev_ssk)
+					lock_sock(ssk);
+
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0) {
+					mptcp_push_release(ssk, &info);
+					goto out;
+				}
+
+				info.sent += ret;
+				copied += ret;
+				len -= ret;
+			}
+			max = max(copied, max);
 
-			mptcp_update_post_push(msk, dfrag, ret);
+			/* at this point we held the socket lock for the last subflow we used */
+			if (ssk) {
+				mptcp_push_release(ssk, &info);
+				msk->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
-
-	/* at this point we held the socket lock for the last subflow we used */
-	if (ssk)
-		mptcp_push_release(ssk, &info);
+	if (max)
+		mptcp_update_post_push(msk, dfrag, max);
+	WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
 out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
-	if (copied)
+	if (max)
 		__mptcp_check_send_data_fin(sk);
 }
 
-- 
2.35.3

