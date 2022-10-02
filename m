Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10048.outbound.protection.outlook.com [40.107.1.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F033D9
	for <mptcp@lists.linux.dev>; Sun,  2 Oct 2022 14:25:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ow6/l0TKOvwZOzn8GGnlqg08FadhfSD8WLERVn+hO8d/FluMIHNbVwA63uleYhljUvMxvm8365odpafYxe296wWHvglRP5Wy6aWdXQV2vnChrqXiH8msy1m8S5ba8k+39KUB4Izxnn8toH3B9AL1Y1HWEKktORxtvVbp8Ndp7kogAEwLg3amunoXq9nELT4isO4MpHM6yNYMun+uxYxBaoB7y3FjLvtTRcu0RcthOHRu5P12JfuK9+aQjPl199YDmaQE9TTthR4OOWxoJjYaXRJkTPP3IJhAHjhbyXmfvZOjH2NS7+VDSTY3jWc2+WvXz+5oBZ6ruxNm6eSrDvuTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ic3vhbiuGADqE/Jl/P8oLe/c1ICHq1UyU1Bm/nbJ9sQ=;
 b=OJy7e9wPwzCEScgA060MXaZD+cdw5MopadDHQTcBL5mwplksuGonb0VprSZO3uSCjqkEw3QaJEOyXR9fpTSHPwCdbsUi82uK/lbHj6gcMZZ+ng1jzf844op+LCkQo4ibd+rm3fkTCiq2nH4r9MEZgOuvprFlE6/1OeGBmlcxllYB28nK3cc+PVoFC5JoNkNxhiiUNwIYrf6MOMfCO0DwdOZXiaZbBfi3Ty3QO6aQo3u/DDMpntf88IvCtCRP4Zez070JiBbWLADgsqaQPZPLiVbiRSoUI9Zw+/R4rQAyBhv5TTzlOO7VigSXXmiLbN2T2WM4jkiJdfJO3ipZwVuY/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ic3vhbiuGADqE/Jl/P8oLe/c1ICHq1UyU1Bm/nbJ9sQ=;
 b=dM7kocLdRSgrfSK8/F5slKIyv0HH63kTYD4Xk/J0Pbm5v2Uw9O/ETG0CP5CGPWk5pp6gGtB8ukOAVAgZqfFqzJe7xmo3gBamkty5sva5FsLGcvR1PtcMJirBp0t3cs6RNbJVSTVVIAl7ZxxQFD8PFfqvVlTxvSCQbXLg/RhDaELMknCKLw9MN7i2jsi3zE9ZnqCgsWOAB1dEfwHRbVsAQ3y35fxfQGA7YOOXRwo9JTckp2jszJSVib95RD/CEGra9DSLo4mqf/geyXIzH1gwgWcqDBzL/9qZzumdkcBEPrymC7MEO2OcMu4W00U8hSl4y26S7/NfHtqHR535pr0bmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8738.eurprd04.prod.outlook.com (2603:10a6:20b:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sun, 2 Oct
 2022 14:25:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.024; Sun, 2 Oct 2022
 14:25:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 04/11] mptcp: refactor push_pending logic
Date: Sun,  2 Oct 2022 22:25:12 +0800
Message-Id: <c37e1bfc52a855cfe861a5e97cafbd02b3395601.1664720538.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664720538.git.geliang.tang@suse.com>
References: <cover.1664720538.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0029.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5d8b65-fb35-4b7d-7f40-08daa481e84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fwoC74mpLdJkqUHBitv+8L5p8iMXyKl5uNXYXs3vQSAkcCIsWSTHBxcFVs2W/JNV1SkMiIkgUTFSrxZQH7/fDhWz43GkbWJKIDlQIYPwCd5OjjBD22CSmW2nP9ATejxix3jB5neKs6eZHVKXIBIUTGlMxKOS3V5zT2k1QbrpZ8Ybdc+5gzyc2Js1/UejeBoUB/KG2iGFkQUpEIT/E+Y1i3DJMg76Pab78WQCKn35H7Vt6/fARQV24Xei6wdZuvva92diZ47HJ57/7Mq9eh5tfPkuUzoFrdRalS1BUXoMZSOCjllp7vH0mE14WNFq0T73tSEDUtmN5zR3xnsVR01X7o8BwCh6Dgy6HX6Wf3ZujzR/4yYGKdV0vzyGiUM79CUEKuEjpsi51uFEtjPq270CB5x47/qoLf1Bt26tJG+6jrqO5vFVsCAczkGlrhNuoYyw3vunT+C/a5/iuttT//mVduIBhjiv606L/ci1C1l+Hmd/XxNAbYhb54CMpeHOguzDEHWnBga5hc+joIw+vzTcbe6L7h7PFhfotGieL5NaUDRfwqq1W2dDdJUJhxZXbfeNvfw+0uC1IT7R8PPZUhguejkdEFnHhi0bW1moWNSblavcF11kBwNiPWJCT5uU/vLpKdPcrYZTRVBKQK9LokhOK1lebSWGV4Ajp/1vcooo644lEeXbE+JpzF7YvhmwxTdfYLkBRQI2EH2aJBg9lKb2OQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(39850400004)(346002)(451199015)(186003)(86362001)(2616005)(83380400001)(66476007)(38100700002)(66556008)(66946007)(478600001)(5660300002)(8676002)(4326008)(44832011)(2906002)(8936002)(316002)(6486002)(107886003)(26005)(6666004)(6512007)(6506007)(36756003)(41300700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3yyqZasU33FlL7E8fFkz4rOOyHFxly4GY++5fqoO/n2mlIHSTS2gITef4jQk?=
 =?us-ascii?Q?UhUwBPTdMbw/buF3AWAJnI1vhhmGSkAn22i8JcwoxhVDiNwPVhMuHctWqcv9?=
 =?us-ascii?Q?cXgXgO2sHFjcp1v06cCt+oiLqNZDscab8UeojftWNb8jlk2jicsmbfyHsd8s?=
 =?us-ascii?Q?fItr+H7JeF/BF69jgd79ziVDI33vLciNOI/7PGQKzLzIktk3Mj6wyEqGQUCM?=
 =?us-ascii?Q?XQiD6jTRUZWRBKfHt14niNHzRX6nEEshJLP2LQ0oPYtWsTkID5hx+SKNu0Y5?=
 =?us-ascii?Q?ITykvkjyg0yTWcZhRSOZr9VwFzOhtB/rGDuHKMA9yri48UUORK4sh/Q54sih?=
 =?us-ascii?Q?oI+jTsp6yqDKk+qJJGGsXxonzWfEUC7n6zUq66UiR+0IzcopUnQiiGCOcfW6?=
 =?us-ascii?Q?ZOdA95WFlkETvBrHtI7q5MQSWZKVnP+G+sc+WPduz2P4DRXNaKoEXLVXLCDN?=
 =?us-ascii?Q?EFpY1G78eYM8+FTYBd2r5olQAoVsTKhEJx1RdsP2BMUXB9San8lMZoCdvy5M?=
 =?us-ascii?Q?CJLhOIX2iIZZMg3gZJWWfBOExT5jdh5Xp2aC/qfpSz9WVgNYOpFtq69jvG0N?=
 =?us-ascii?Q?gmko5HYK924Gvon/dnpEjKZoyD2H/62aHF72gr+PZkwxMtq7Yof1Hh1aNzvP?=
 =?us-ascii?Q?2OajDEhJC8RxHO0otwu9Goiwk03ezGBHPoYRzpy9OfdgqtGH1x5LuDUf8Llc?=
 =?us-ascii?Q?xVwoO/pgpdANfKqQ8dSriS7gxoDSieOdvIKqEoJQb0pBXdhHSELiCVM1qCiB?=
 =?us-ascii?Q?5UuegB5z+lPaQzRlhyCpCLjmHZ8TdXzkv2wuDchw/v7mYAJlVmsBB7O4J2vJ?=
 =?us-ascii?Q?iGHR3jWwjCCCo+zt+JNc+ZUhPHtt9gyyiI8cOLWp1k333I3vyZB+DsRa5XnW?=
 =?us-ascii?Q?GgwOJqgZoo7VZSbqm9xK0pHGkd52IN+lnqDHKOCQML3gZiXFulIwuqlA2Xbc?=
 =?us-ascii?Q?HF27QMRAIGC/I37o3VGk23lndi0aiLjAKBpJ4vMriAuNeJYv1tZ20IJLPuIV?=
 =?us-ascii?Q?2ZIkGJcFqQf9iyfEmMgXy/mepKNd6cbjoAGYHOP7b1g9I5wQcUJBrUc7/IsF?=
 =?us-ascii?Q?FM6QnQgvYvMJDjA7EDIyWuBJ+YtbEh3vZIsqmmXKpOuL3XuD7QbAseRvNw2/?=
 =?us-ascii?Q?EOpg6fjt3sPPWtrI/7XM1N8ZR6JOGCrOBQlG/8ZSlu+g+m5P3ggm7n5msze8?=
 =?us-ascii?Q?Gw7K73Hzlrr29uzyiCPz2pLiGFB2xrdgj6fm6MWmKLo72zm1N2CCccTmaDns?=
 =?us-ascii?Q?gNHkmzT5XZkDjGYRamZ+lzWBEh/BEz14oyAq2vC+gJb2MDTwKGoRvingBLzB?=
 =?us-ascii?Q?ify9SSa68EEbL+abzDyl0kdwIiiQwA5ipY7gTDu9dmBvnveSG8ukdN4SPdRt?=
 =?us-ascii?Q?KXn9crnZthWa39Zzv0jUVl85uuCC7uQXgsLNBLbkegY0m4iwHPEh2YRc132s?=
 =?us-ascii?Q?sqnjh5tgI0s7FwoQovuLEBVjuk+w4xK8htW73TIY+zPWPL142Ope2PayqKzq?=
 =?us-ascii?Q?vkY/IzIAZQyEU0AU5Hpz3iH1DbAUeLjuCY7CSq2lTtBc1fSsWve0KovvilBU?=
 =?us-ascii?Q?2oteglPbdvGchn4Yq9P7QjzNQD3YiRXE6x+Pd/k4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5d8b65-fb35-4b7d-7f40-08daa481e84e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2022 14:25:08.4822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHCu9JTXMDPYevmG1e+M1LxAH2S59Zf/4zMrqARnIT+ilDYQH/CjhaU4vlR33/XZUi1PXh9O81MgkfQ4UMKQjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8738

To support redundant package schedulers more easily, this patch refactors
__mptcp_push_pending() logic from:

For each dfrag:
	While sends succeed:
		Call the scheduler (selects subflow and msk->snd_burst)
		Update subflow locks (push/release/acquire as needed)
		Send the dfrag data with mptcp_sendmsg_frag()
		Update already_sent, snd_nxt, snd_burst
	Update msk->first_pending
Push/release on final subflow

to:

While the scheduler selects one subflow:
	Lock the subflow
	For each pending dfrag:
		While sends succeed:
			Send the dfrag data with mptcp_sendmsg_frag()
			Update already_sent, snd_nxt, snd_burst
		Update msk->first_pending
		Break if required by msk->snd_burst / etc
	Push and release the subflow

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 76 +++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 46 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 785c52b738cf..296b7135e9cf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1519,67 +1519,51 @@ void mptcp_check_and_set_pending(struct sock *sk)
 
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
-	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
 	bool do_check_data_fin = false;
 	struct mptcp_data_frag *dfrag;
+	struct sock *ssk;
 	int len;
 
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
-
-			prev_ssk = ssk;
-			ssk = mptcp_subflow_get_send(msk);
-
-			/* First check. If the ssk has changed since
-			 * the last round, release prev_ssk
-			 */
-			if (ssk != prev_ssk && prev_ssk)
-				mptcp_push_release(prev_ssk, &info);
-			if (!ssk)
-				goto out;
+	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk))) {
+		lock_sock(ssk);
 
-			/* Need to lock the new subflow only if different
-			 * from the previous one, otherwise we are still
-			 * helding the relevant lock
-			 */
-			if (ssk != prev_ssk)
-				lock_sock(ssk);
+		while ((dfrag = mptcp_send_head(sk))) {
+			info.sent = dfrag->already_sent;
+			info.limit = dfrag->data_len;
+			len = dfrag->data_len - dfrag->already_sent;
+			while (len > 0) {
+				int ret = 0;
+
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0) {
+					if (ret == -EAGAIN)
+						continue;
+					mptcp_push_release(ssk, &info);
+					goto out;
+				}
+
+				do_check_data_fin = true;
+				info.sent += ret;
+				len -= ret;
+
+				mptcp_update_post_push(msk, dfrag, ret);
+			}
+			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0) {
-				if (ret == -EAGAIN)
-					continue;
-				mptcp_push_release(ssk, &info);
+			if (msk->snd_burst <= 0 ||
+			    !sk_stream_memory_free(ssk) ||
+			    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
 				goto out;
 			}
-
-			do_check_data_fin = true;
-			info.sent += ret;
-			len -= ret;
-
-			mptcp_update_post_push(msk, dfrag, ret);
-		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
-
-		if (msk->snd_burst <= 0 ||
-		    !sk_stream_memory_free(ssk) ||
-		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
-			goto out;
+			mptcp_set_timeout(sk);
 		}
-		mptcp_set_timeout(sk);
-	}
 
-	/* at this point we held the socket lock for the last subflow we used */
-	if (ssk)
 		mptcp_push_release(ssk, &info);
+	}
 
 out:
 	/* ensure the rtx timer is running */
-- 
2.35.3

