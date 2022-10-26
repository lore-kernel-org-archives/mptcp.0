Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140050.outbound.protection.outlook.com [40.107.14.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D997B
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 08:06:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKXNLtHMUIfI7ymSHpY9zUY5T47GcvYk3I2ZI0XuMfPdK/c3TaMuDtZlGarSy2u261oUfOVKKRIH9h9y00Miq9HryxZqfwKjSAWtyElctAS/nJAnH0Z5h+aoRwKCm4BTJ1anccQop0x9vvl8R3HSlFUn5rcFHs3KteJEEXyD25MejulPvDCg+HQedg2Y9mSrrNkJsUqojlYW4UU3JRPX9BIZd++tbQoDMHnu0pJ44d1ogJYDmre8AqShoeIQG57DM/FmYyUvyeyijlY9SVblAtF6Ypj9MgG0kQwpqx5axCALDSMICpRRW/jZz5qtZypi84Lv7BPF8smQUOgTob1Pww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBhGXR+et8gqZaaepl+2bXlszbgBlfOQ2naeK9xmvLc=;
 b=eHW8kVsfnMNcNmlIwgHdyTfLu7edZXMrd6skixgJcBNPvc3sL3FX3jcRGOdmOq9EwR27tgnfHsbXu5+Cihk+6EhX0aemTtPFtyyaITWd7RRcg4N6vgY9pbJMGFwyEibSoTNUTR800XEjbweRBVvLb2Bq8Qwrnu7/5ljEsDG2fIeZtvzS1nGwZaSuAHfsx4nT/M6jCAdlXsdPlFQ1nm1kU78ocHz4wNP1PT1eH3csoBJaDoAa2arnOmsNa1TnqW6Cr9et/0Pcxf1rlm6rrEwiqfEcgXZGGjO4s4Cit016rdkT8hE8aXXfeMzoXd5QlDMXZ2RPy8J6GyaX0FQKCF5O2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBhGXR+et8gqZaaepl+2bXlszbgBlfOQ2naeK9xmvLc=;
 b=JBwPuaf2nDwHZcRQMORh0wiGdeGNYZC6OEcJtqJTcH0es3iRgWjTm6RefMVpTKc+Sbeh1PYbx49GsLDml5eK0wCYl7YxJRfkRhDV7RX2sF+Rp5YsxosRULDR14YL3IsYLOklKR867g13t4OVufBH3gAMEI53iMqewjwYkTheztppfI96oTbYm6JsJbO9GeXLL5vN+p6vWirdHpnczZ4rbINjIrq2kObbtqa2xxOEfUdSOBXaMUJ5rmoMv9MmksUsRS2QS0Mpg0/8Eb+lh9YAZ5N17Bbha8fj+Hd6HoNiP+sYO94aveLJz2pK4V5dLHxGgp84TiIPWzgV5usEgoEocA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7777.eurprd04.prod.outlook.com (2603:10a6:20b:236::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 08:06:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:06:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 10/15] mptcp: use get_send wrapper
Date: Wed, 26 Oct 2022 16:04:19 +0800
Message-Id: <e9983543fbdefba28a426a4015966be804ba0477.1666771065.git.geliang.tang@suse.com>
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
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1d1f1c-fe73-4df2-38c4-08dab728f4de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H7U0u96V20Nv/fF6QTk5KeCqzBHtSz+4fU78XtHJFI0jP5ocXFhl8+MsZTjFykPk9bRw7usGbblkFhW9VaNOsL1mTWSb6pOWnowL8l7SDPP1zO4klQ9wMFaPs5RLYm9+S2JvDgomSSqW+hs40dOYfZPScFTJIvC24BzZ2cLYxyqSSRt6N7iDR+m8/5CmIZ9AReDzKMcq2bFJhmukNjUq4VZeRW5I/4Dmyj4EL2sXLsFjIg60Y4Ba1250tLc5xT55nM3WKrrhzS9Omj9syHWrNVVp4IlcMI3dhoZJ2Z8lU/SBF+jDvYTAOe+GqnuWPOiou+y41mvstZtyO0NVnLdaGJzrjUQXNOtp3AptSkqUlTg34jDaCUT1r0iIExyQ3Hi4oB34I5R+lCtGYNSL/z/fSrgT+a4ri911Um6rVMhCUAiTHM5QgVAarD2pTyG5peYxh+DvAhfkBuTlVSptxg9mDkIT1iAqzhc+9EVvJ6MGoXwq0+YqM+LtK+IHinEDBprM8/DCpAJe5jXodTTU6oR29wCc+WNLKuCzYfntHYb9FPuBACMsadIXUeBIYVMidlnE8BZMAXl2wmb6pN2Cw6Om7aZ8yf3si3pj8Jd5of8rQPFkYyAcOSqiJ6rRY9lF6p7Wwtg+R6qi1aAOT7Q0w8WK7B1oq74MtSHazVnA8fqr6isNTfd8IKeJSetGHmYRNVF3lPGUSi/cwWjNGh7iker1QPzoU93rXCsL5b2PDxha0w+nzzyaolZpw0+AOK1uiP1R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(8936002)(41300700001)(2906002)(66476007)(66946007)(66556008)(44832011)(4326008)(5660300002)(8676002)(86362001)(6916009)(107886003)(6486002)(478600001)(6512007)(26005)(316002)(6506007)(36756003)(2616005)(186003)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DzOmeZwUcL8TQswJnM+u00k6uptoJHRhFUZAb31tRux0ytglyBTP3wBd5aVL?=
 =?us-ascii?Q?8jYVGA+6MQD4QmkLlL2vkaKjTO/54PzoLtrMy2lHtUtrfK1f2GKEpoQ8Xf1P?=
 =?us-ascii?Q?bomK/xzBT9OsZANZVgkCbiZXzmp5iM1yAMiW7eNJmY6E9mgFHj9kyFjCfIpL?=
 =?us-ascii?Q?/b4TBJ5WXAlrytbKGbMvySDUVQYZ4tVQ93xRsHk6nJZoYRyt2TqvIHm6POIg?=
 =?us-ascii?Q?SBlAiFb1WNetI8PWGWXZN5vlz7y4TghNsAJTQHt09sr2+oxNrgmJDZEgXIm4?=
 =?us-ascii?Q?Jn5h7jWKW70NtwQVbDfOfK0iCN7F67GPHJ+Ek1ZafjydkQQe69a/Dq7g88Mp?=
 =?us-ascii?Q?WKq9M52FxBvucvEbv2me+LH3CS4/YgktjRTsFA+kuBj5viqfKAGrnPLLCGkR?=
 =?us-ascii?Q?mNdVyKvBy6YNb0F+bGlhhHRLG0Pic1DOj+wQG2fKUhm3RWzQe9MZEM43HRoW?=
 =?us-ascii?Q?R23j+c7PzzuTp5rzEOoBT/v9qvBq1CCXA5vA0ko+VlZzCHDnmr2LzAuzQznC?=
 =?us-ascii?Q?ZZd8FqDyyMEtpl766Rwmk4pSHcdpUEzhu9Kqg/baBfihosYaB1P5XpzSpzcP?=
 =?us-ascii?Q?RJcWnlwtIMn0XdK1CC34iNDMIHeG3UtM91a/RGzZ6w+M0vSRspnyV4m9ndjJ?=
 =?us-ascii?Q?6n9lN4W8uammzrcf7KVl9X8EAqn87sunH5yTYzumcLWR50tTEhGg3fNhB0iF?=
 =?us-ascii?Q?8he5p9bJQkzChlr9dUNg/VF24zEi+VDh8p3bmjiqC5uwCqizJgnXRGbBxBC7?=
 =?us-ascii?Q?LcmfAPPuG+AsKSJY4XgwL8OVRlDpMkPh4iXsU84/6/dKIwKZf8SAzgYryrgq?=
 =?us-ascii?Q?otrolRvXLI5AHsEK+Tll4gHb20bXyiHUkZWtJNcdexc88Ki5fEJHssgzkTIf?=
 =?us-ascii?Q?dPP4ELWz/OgMSkvDVhwUMz6I/xkgpNozqoHlETzvVR90H3jPH3wr4an+Qhgu?=
 =?us-ascii?Q?+LKwd3fffhAwkWChXK0mf2fqNFy2GHxWysq8r6/E4ePf5oenKD1jRpFmeEmi?=
 =?us-ascii?Q?x6R+wk1ZFOZ7P9palbQWNVEMLAeHtMRhJGUgXvCZWKxUtDjU1Qsjramnwcwr?=
 =?us-ascii?Q?ktdrvLXI4kzqeyDzJaaET4SwKW+LRSPmnO7eZBrBg+7oMeDUchnbA9WJD+cA?=
 =?us-ascii?Q?qlw1O4mjihfV6FXsmaDPFoyRkSJcQ+uSRW6+7+73CObhLDa3X9jV/vGcnrv5?=
 =?us-ascii?Q?ojm9KYawfk1czjW6VjkuF6xJjq0OoJlqP5ir3g2mNP+4Yg+l9UWL9i2tZRzO?=
 =?us-ascii?Q?0hs7aloBqFjOVRiPnJRHxa/mGFACOOADznFTQD/X7z6FdwYCDYK1prnG4PS/?=
 =?us-ascii?Q?ujG58L8pb9B5dUQLL+D6DeXgaEhNiqtnlxVErx6/v3gtCRV4+Tnxmfa0ftwL?=
 =?us-ascii?Q?5cBjz3aDzHJTCNrhuJUXkpk0Qxx1KQtLMaUm4t//krPjSuv+99Ih7SATdM0w?=
 =?us-ascii?Q?jxgUj3XNOGVmYIld+89ltcq83/KHtYtNWsOhW9hIGeQ7ablvUDt5pvMCqSLO?=
 =?us-ascii?Q?h3g35a/7vTsJJZwEKNL4b42tnYmjGS6u0KTI+wQUVenyp7tcy5JGK/iTUmwI?=
 =?us-ascii?Q?d97FqV1YWqdhuDTBBElPbdBOQw8WOfaOTau2OWLCm0RRXU9M2NBdwK2CQjZM?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1d1f1c-fe73-4df2-38c4-08dab728f4de
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:06:16.3469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSRQYPo13ZUXyzNZ5o+/IHLRgNcsIaUY5rQnp9d5duSe1B+4vAIDtcasKUzemMXJltPCn9D7LoD1ME1QgsjvfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7777

This patch defines the packet scheduler wrapper mptcp_sched_get_send(),
invoke data_init() and get_subflow() of msk->sched in it.

Set data->reinject to false in mptcp_sched_get_send(). If msk->sched is
NULL, use default functions mptcp_subflow_get_send() to send data.

Move sock_owned_by_me() check and fallback check into the wrapper from
mptcp_subflow_get_send().

Add the multiple subflows support for __mptcp_push_pending() and
__mptcp_subflow_push_pending(). Use get_send() wrapper instead of
mptcp_subflow_get_send() in them.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 113 +++++++++++++++++++++++++------------------
 net/mptcp/protocol.h |   2 +
 net/mptcp/sched.c    |  31 ++++++++++++
 3 files changed, 99 insertions(+), 47 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1f64abb94cc8..277f1de31e65 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1406,7 +1406,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1417,15 +1417,6 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	u64 linger_time;
 	long tout = 0;
 
-	sock_owned_by_me(sk);
-
-	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return __tcp_can_send(msk->first) &&
-		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
-	}
-
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
 		send_info[i].ssk = NULL;
@@ -1572,36 +1563,42 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {
 		.flags = flags,
 	};
 	int ret = 0;
 
-	while (mptcp_send_head(sk)) {
-		prev_ssk = ssk;
-		ssk = mptcp_subflow_get_send(msk);
-
-		/* First check. If the ssk has changed since
-		 * the last round, release prev_ssk
-		 */
-		if (ssk != prev_ssk && prev_ssk)
-			mptcp_push_release(prev_ssk, &info);
-		if (!ssk)
-			goto out;
+again:
+	while (mptcp_send_head(sk) && !mptcp_sched_get_send(msk)) {
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				prev_ssk = ssk;
+				ssk = mptcp_subflow_tcp_sock(subflow);
 
-		/* Need to lock the new subflow only if different
-		 * from the previous one, otherwise we are still
-		 * helding the relevant lock
-		 */
-		if (ssk != prev_ssk)
-			lock_sock(ssk);
+				/* First check. If the ssk has changed since
+				 * the last round, release prev_ssk
+				 */
+				if (ssk != prev_ssk && prev_ssk)
+					mptcp_push_release(prev_ssk, &info);
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				continue;
-			mptcp_push_release(ssk, &info);
-			goto out;
+				/* Need to lock the new subflow only if different
+				 * from the previous one, otherwise we are still
+				 * helding the relevant lock
+				 */
+				if (ssk != prev_ssk)
+					lock_sock(ssk);
+
+				ret = __subflow_push_pending(sk, ssk, &info);
+				if (ret <= 0) {
+					if (ret == -EAGAIN)
+						goto again;
+					mptcp_push_release(ssk, &info);
+					goto out;
+				}
+				msk->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
 		}
 	}
 
@@ -1620,32 +1617,54 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct sock *xmit_ssk;
 	int ret = 0;
 
 	info.flags = 0;
+again:
 	while (mptcp_send_head(sk)) {
 		/* check for a different subflow usage only after
 		 * spooling the first chunk of data
 		 */
-		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
-		if (!xmit_ssk)
-			goto out;
-		if (xmit_ssk != ssk) {
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-					       MPTCP_DELEGATE_SEND);
-			goto out;
+		if (first) {
+			ret = __subflow_push_pending(sk, ssk, &info);
+			first = false;
+			if (ret <= 0) {
+				if (ret == -EAGAIN)
+					goto again;
+				break;
+			}
+			msk->last_snd = ssk;
+			continue;
 		}
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		first = false;
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				continue;
-			break;
+		if (mptcp_sched_get_send(msk))
+			goto out;
+
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				struct sock *xmit_ssk = mptcp_subflow_tcp_sock(subflow);
+
+				if (xmit_ssk != ssk) {
+					mptcp_subflow_delegate(subflow,
+							       MPTCP_DELEGATE_SEND);
+					msk->last_snd = ssk;
+					mptcp_subflow_set_scheduled(subflow, false);
+					goto out;
+				}
+
+				ret = __subflow_push_pending(sk, ssk, &info);
+				if (ret <= 0) {
+					if (ret == -EAGAIN)
+						goto again;
+					goto out;
+				}
+				msk->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
 		}
 	}
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 285abbad833f..cb8ea1eadbae 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -640,6 +640,8 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+int mptcp_sched_get_send(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 0d7c73e9562e..063f5005b2db 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -112,3 +112,34 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 }
+
+int mptcp_sched_get_send(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_data data;
+	struct sock *ssk = NULL;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_send */
+	if (__mptcp_check_fallback(msk)) {
+		if (msk->first &&
+		    __tcp_can_send(msk->first) &&
+		    sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			return 0;
+		}
+		return -EINVAL;
+	}
+
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_send(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	data.reinject = false;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
-- 
2.35.3

