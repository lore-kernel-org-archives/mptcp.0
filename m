Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD96723CD
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 07:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650613406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zUNMRznTaTXJ84QUL7+RFQvrbEJx5PtEXAdD8CpGc+k=;
	b=Hw01jPPi/mLRx1VAuHtAOgm0AWsx7+QenlxfFKAl5GyWJ3/8OJIpPRMq4XUePX/bW8BOND
	qHBiDvh06E/K5y9IfqFXNmAqBG+YRDKykQeRmsblbzQI8wQhjhk1mHFvJ1WvZuneA7Euoq
	NCBOGyXwwG9U1rGwuRUIIVS9Au9lHjE=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2051.outbound.protection.outlook.com [104.47.0.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-8AY5ju4KMlmLFHzMIodHlQ-1; Fri, 22 Apr 2022 09:43:25 +0200
X-MC-Unique: 8AY5ju4KMlmLFHzMIodHlQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2b0Zi6J18/VSzTHaW7WQKib1YTvuGJnfApmhP+hl0F5oCPe14uuGNbGj0uZlYMrwqheNN/KeHh+3uSxp6wozKubOgvz1LeppE4A6Nk7o8GJjYTV4wQWwwmqRkQIW7y1GzlZu6m26UIKnDsSRJte55GAa2LgxV0E1LOr6tyAjr9+6oMjsIUlSJ3f7i2KHnBNAoFc7vmPycVZtZ3oEM+4zALAT0c+ga5iTibLieuN6u7zqH+itYdnSE5Qa8ycZRvznN9U+DundQAcQrPv3reEGBHBqJ80BuyCsYJa6dFE7+jKsa563VP9FG4peoQZiI3Ae2FYF5Uu2EMNS9wHNe/hZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5CjQmJ372j905gN/1yjb29NTA9tXpx2as+KWYqXzao=;
 b=lSLSHKksjdLN6V+6zjhC4dJUxWElyTcwzt7eQLBQ6qPawmBz/zMSxYRaVOoJiPx/CivDFZC7eHjDRKzTZ8db35imaEGOEkWilhkOskLtQYz0v7l7ceVo1By2SiSbFobDYYjItMVy28U2AEmX0HVggdGFQY1c7TdpRdK/4MQZYf3C10X5x+tngY1m/4ufm0J4O4MTSO4XsK4UOCFHYtj0Rs9+TxJi1S94qRiVdiCEdJb1AzDLbT6Cp5hxjHNqslmpRTwTP5W5yGrg2bP5wncwXdDpHqqH1kJtlkYlyXoYH/u7ePg8j6Fjsd7RbMqdENEdQ3ic+ndmWgwTQ/Wd4ZTkQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5876.eurprd04.prod.outlook.com (2603:10a6:208:130::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 07:43:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 07:43:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 5/8] mptcp: add get_subflow wrapper
Date: Fri, 22 Apr 2022 15:42:53 +0800
Message-ID: <a932406a428e0fe1b70285aeadb5347db5267c36.1650613135.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650613134.git.geliang.tang@suse.com>
References: <cover.1650613134.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 461a031c-80dd-4992-89e4-08da2433c780
X-MS-TrafficTypeDiagnostic: AM0PR04MB5876:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB587620FDB1AA12A04904F761F8F79@AM0PR04MB5876.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HqsKZzFj8//NCXt4hmWt1bvZ8JswpLM+/jOQrI4AoBChPegF9hlcv6xPNXdSZl+WuDJ/lhG+k+efYrePrFPHUeG5WNekFSwnzK4XN4Zb+FwNUPB3N2JLMsIufQlX4g6qpRymM9Eie6Y/jhd6j5cCmlauTmJDFJ9b8XanTStjvGn2M0lrfOTIW+d7B3R/c3Bl3gxd70NQrIs3PZf3ZzN/Hp3iAqFwfRtJ1zWi1lB8SDD2a9/xPD2XF7PM80QOf5n0abiufAx3qehiB7bt/41EB/Je5GMXtO9gsvWc6OHPFlTOzxaMlVYTwRJSxjJ5FzQRysBaF6mRomEegU6VIfw219uf8x0smzF+5BT6Kiu0n/UtOBsv9ZLe5XSWGZh1XTUuaoNCcWI4ydmMkFOzRGzWn4KeXifZXRfnS8vcK2H4QyOP/BSMmA5ypnDLHgyQd44ostgX1JsIGTjb2E994mdmuLAQN0gODXhMQv/wvgScg4I5vlbh6qG2uxqzBLwJVBA8YbyEsNhGoot/34DsShOOSACBVYduc52aLR1b62tyntCkIPYN3FPpk15uA+mgo9fQe7ADAphVHfgemKIvp9R3dTM2KMBJzK0oeJ9+OMJRD/WiVWMl1Kf5dcUr1q5cY46fr0QAaZdmmpPq3Mx0AcOwQkyMtG+R5VQCsbFljfpr+wfLzTT7XljxV6mUWbj/P1gM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(316002)(86362001)(5660300002)(6916009)(6666004)(8936002)(6486002)(44832011)(4326008)(38100700002)(186003)(2616005)(2906002)(107886003)(6506007)(6512007)(66476007)(66946007)(66556008)(8676002)(26005)(36756003)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xeqTBlGChbepd4PLogw9/GLmPzmsZEHgOZrkDT3MNnmeF3/tgnpVcwb4xtCG?=
 =?us-ascii?Q?8TtJGY8x/2ZpUXsc0ybrbPgCPMXUEYa8s+NymQakJnUHBBlC+SP9XAgm2mbJ?=
 =?us-ascii?Q?CmAIYwyzbNMTmHIGNYJ4+nKk2N4IYjkazelo8ou3/bdTU+t/7tOqM4QUu8u2?=
 =?us-ascii?Q?/vYhy2TutxCCcPwWD53Sm8Gdw54o5NsS0ZzHTXpJkLXjr23TiRXboiPFRUef?=
 =?us-ascii?Q?0TCRCI5rSvDvwtuGkU8BOqqBjYDPtB8nDH4HWlueN8PQZdF+ykHtP51h85SA?=
 =?us-ascii?Q?8AQbbdqpuhnnpZzl/W67oZDkwiLtgnZ5wd2cqKdZv7wPHyaGWpJmegtMUT5I?=
 =?us-ascii?Q?YCmpDRKjD2Z5gJKrZ98AthAlM+19Kcd3UUnzrUD/wBmrvQmMcMiF7gcg/qus?=
 =?us-ascii?Q?mstDeLrkMl56Ntt0jZeyRpCAzMSZi7GWWvpjmETySNJhb5/ZzLKY4SbyG9ot?=
 =?us-ascii?Q?oKGYzO3WKTGJh07qFc3P8/uudsiXmeL7GTSnPXGpM5DVTHkSbI/xi+WJNgmP?=
 =?us-ascii?Q?aTMvj+2nLJdaZNZCsqzOdD9342a1Dp5T5Zq3mPlxxmbEJ/M7/pWbKgMNY2X8?=
 =?us-ascii?Q?TJ1SeB6OghZP5RrNNV1hqM8dxjrIUfpLwv2bCqmDN0jEPKxjBwV4tyStNeUQ?=
 =?us-ascii?Q?uPVJkqhqBoChBqwdFSOShZDgNm03eMHWp50fO6jN4M45zTUrQAZQXaN//rvh?=
 =?us-ascii?Q?VbZyBdHB6dfu0fL5PRKCVGXY9KeN4oAkcVe5ilfWQsJLA/yVY/h3q6JaI58m?=
 =?us-ascii?Q?egY7BNP6Hkwk8Qodjcx1+Sy9SReim2QVk5zPsQYSXKWbdMPI+zwhak4Nt/AD?=
 =?us-ascii?Q?0iUzzeD0OBJN1tbBspVe5/f53zTTDe3GrYmOuAIRF6XbIN8t74Re1DIPP/Di?=
 =?us-ascii?Q?49WAsYNmUDaYIFxpa9DU7wN+7oefw/CvGAZp1L8yYaejIVbsRGn1+BVoAEKa?=
 =?us-ascii?Q?WibSEwfkrfqlo7q7PGJT4+RTwitWRVqDwHRi+iomzosW47ieryLAWXewNlNK?=
 =?us-ascii?Q?fL6+IGvplBIyJa99C+au9jPRFErLNsUKNIjegmTEQitp7bfGGycXGImCDATW?=
 =?us-ascii?Q?D8lHMIIU1RIfK+IlvkhiMDOEvyBVnC19uQqgSEKY8YYUsXy+Ch8wnZALI6Nj?=
 =?us-ascii?Q?/RGLJDEplJzgdQa63b8kdeDMzUiZgjWg/dq1AVWXfRtGZwO62zDPL/y9WrBM?=
 =?us-ascii?Q?2wIUq0Lx9s/wVdFTh85hPaQXjRyvodMLrTHFSXV1CXNrx4eCUmjmELzu4UiS?=
 =?us-ascii?Q?hyL3jlqIOonnLECNBFE7mZKh0+bFbS1egor48ClLuJ/t9PLpTdmJtCO39QCU?=
 =?us-ascii?Q?Kf5nO3UHDj5nNn3i+nav6P/6VtfMPLIxP8GNRXYdtJjEMXLUl3syk6mFmmBc?=
 =?us-ascii?Q?eMqr7zoU3lzrkFZBHS2fcQM99npvyn7TKxMhOuRjRkSGV4y0BrL4zUIfIoxT?=
 =?us-ascii?Q?sf0M8R5rGAUePIfBA1pGwWapij5MRfQVX53Dqy8lhsbHShnAxrrt1lhCRaj9?=
 =?us-ascii?Q?05H3DqV0bSiL4N4SvmBfKTnkMLHHP0Sg4P+/AEeHcgn4YDf8ZGR284wV2616?=
 =?us-ascii?Q?P/L/ZHPkW6pQvhNP5VWt3jE16AQORqOGboXBiGE1rwdn2z4/iCSGDYLC5p5c?=
 =?us-ascii?Q?svvNYoj6D3ysbEiRNuCRx4U/jNJ1TtuaIyF4odme7sAqhonAt81PvXUWWL7y?=
 =?us-ascii?Q?SbztSeibAy2Q0M+DGIRv80M1obMemCQS3krQ9BPNIOB8dtoHp6oX7MtP2n+3?=
 =?us-ascii?Q?d3ZMjJ7YDd4ARuPzPSf/5USMVdjxIqM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461a031c-80dd-4992-89e4-08da2433c780
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 07:43:23.8336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3pZFqrN3cTcOz+p3rGBr710xQQ4Vp4d3iOlQ5rLux/ouWOet8A2OlLdXHGDbl6fuo3TyzJ1YVYH2YVvfi/tPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5876

This patch defines a new wrapper mptcp_sched_get_subflow(), invoke
get_subflow() of msk->sched in it. Use the wrapper instead of using
mptcp_subflow_get_send() directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  9 ++++-----
 net/mptcp/protocol.h | 16 ++++++++++++++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 70ba43c18e45..dd41d1d8d2e6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1507,7 +1507,6 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk)
 	subflow->avg_pacing_rate =3D div_u64((u64)subflow->avg_pacing_rate * wmem=
 +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->last_snd =3D ssk;
 	msk->snd_burst =3D burst;
 	return ssk;
 }
@@ -1567,7 +1566,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_subflow_get_send(msk);
+			ssk =3D mptcp_sched_get_subflow(msk, false);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1636,7 +1635,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_subflow(mptcp_sk(sk), false)=
;
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -2481,7 +2480,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
=20
 	/* first check ssk: need to kick "stale" logic */
-	ssk =3D mptcp_subflow_get_retrans(msk);
+	ssk =3D mptcp_sched_get_subflow(msk, true);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3146,7 +3145,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
*ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_sched_get_subflow(mptcp_sk(sk), false);
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9ded79c942b0..006914cb78de 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -633,6 +633,22 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
=20
+static inline struct sock *mptcp_sched_get_subflow(struct mptcp_sock *msk,=
 bool reinject)
+{
+	struct mptcp_sched_data data =3D {
+		.sock		=3D msk->first,
+		.call_again	=3D 0,
+	};
+
+	msk->sched ? INDIRECT_CALL_INET_1(msk->sched->get_subflow,
+					  mptcp_get_subflow_default,
+					  msk, reinject, &data) :
+		     mptcp_get_subflow_default(msk, reinject, &data);
+
+	msk->last_snd =3D data.sock;
+	return data.sock;
+}
+
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
 	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
--=20
2.34.1

