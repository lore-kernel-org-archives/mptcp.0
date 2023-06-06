Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2065.outbound.protection.outlook.com [40.107.105.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BF5813
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 06:45:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G67VacQi1Ldt5wSyX4uMPcBW1SRBY48+zincD8hImNLZflcDY7pJILWiItwAgc6U3LDrJhCqeQo38w9uwC2AVVKtvBqziNrRWDwn445rrUVSi3WKiACK+dtFXlARGPp+GrGofUgLOoqWsNtoehxbRCYnelMPikTWku4jRkJecbSKfZe9h2OGm5g0VnTBJ0rhfRmo4ne3i4occJhiuItI6/l0FsugtJuEF0IVvK2GNoPYwi9KPiNvIMtQb7YYmgDiMgcp6NYVEw5cIX8ocGXfsZBUr2Hvo/L1f5+2/QrjRMFnTvn6eEXGgHxAl65enn7Y/k8Bu5T8MRBFNvnG2ymKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUPII91VbbbH5WnNXqpLx5RZRasL80tk7pFYPDg0jNk=;
 b=ZLAzEW6UOMuISSno6TJhI68m1APkvdiIh47+HpmXe7IblE4yGPq78OYdnf/o+wBdEY2ZgK/gkJn6kREUaFbkp3y+vL/l7AOn3YgP8B1wph8+qkYT3ajg6o4DWnXxan5C8fmEnZTKD+gnP2ugbU8yadS/H05gjCQAJz8WGuoHxu8B2g8iOiZeV/DmLb49DgZX5AyQaof3+PdPheAIRtoIqKrPH0glCipvQufXt6VxV8M/+BMKo+ClRSdxJd57sqxcvMIQgKC80A/AVEif0DrUs734kQyFdrv937Ph+XNdGH36t8XsucVxw+btBztCBg5KKwpnxUfDRE3t2BtSPWq2dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUPII91VbbbH5WnNXqpLx5RZRasL80tk7pFYPDg0jNk=;
 b=EqksqS+txXxpxf2uVBUIOqhGWLwnW/JDfa7Fl4Sopt6x4V1hexyYqo8KIgjUAsGZnR6eYpK79S6ukz34c5Y+zR/pXSIV/+jYu23Cej+lMe18oZhT265UbvkFZk1xhdQghYBDf0w3KvwaRF27xJUphugAMYSbRzU3B/uyc1MVsM7BuLu01J+APtu81QREP8B7urjShV7uTeRLNWCE2GH3eS9xjPqoiNUMdNluCpL+tTVACnG9Ic8okk65NWFoFsz6kEP2BjNGz1jBvrOguh/7ranCiONyuVtZJf5hjPO+bho0B+ynpjHbHevJKl0wKoeZJiIM+wL3F/sdi4yC4qjQsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7029.eurprd04.prod.outlook.com (2603:10a6:20b:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:45:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:45:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 04/18] mptcp: add last_snd in sched_data
Date: Tue,  6 Jun 2023 14:45:03 +0800
Message-Id: <6083739fd4916a0e8480e896beeff0fa02d2665a.1686033694.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686033694.git.geliang.tang@suse.com>
References: <cover.1686033694.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: bc877644-9089-4e60-ab77-08db6659a481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PVF+Xxi3+Ka4gXOnIf9xp+Uc9qUWaoRQOl7hFxUeNLu0X/NFZJ1D04/aaK13BASMlKPC64A4RERtMlWJwPH88s5FGR1Q8pypmlAyERiVsK3t0a3UXqARxmyVPL19k51yZP8MpQqRz8NpdLu+FkuM17KrA2Dp8daujOjJYMV5sHoJVCQo9cetjWnYNURgLPCc77DHU/XEFKvwiAkN+pX2rdwiDsBRM1sVwYjGCCbHER9OFe9X7QBh6ARGwopB+upBmnfm6TV3CJD/UXIMJV15UzjytWjJ9kqXpYWywoeedfgRqKB6onkUvHwjvgEIqjYpGwmcmX2mAZ01yB9C4KMIzYg5Sh5jiCg+gWkjljc7nU/ddnHlEAWGY5i34GEDEraqAaFr5A0mFT/YM+DvD1hdbInnuXQFTRh9Nq9NRRhjd7SkU3nq/uvScAuXCpR+pTq3/EtExpgcVd+BwLOsrYqjT6EdQmoz2z/+C1jxLwPirVOh4pxQrp8LXOtSpTHvu6BhloovodzHAln1Zbx107yWCCL0uV+cM7FxhRCcO7yocQd/dwnmwBT2dlwv4JVWeMuR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39850400004)(366004)(136003)(451199021)(2906002)(478600001)(8936002)(5660300002)(8676002)(4326008)(44832011)(36756003)(86362001)(66556008)(6916009)(66476007)(66946007)(316002)(38100700002)(83380400001)(41300700001)(6506007)(6512007)(2616005)(26005)(186003)(107886003)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RrolOtMnRMmCt7PKQqSwxGz7cc3iEsvH4Bqm7at40aVxYCBGTMoXQ5ACvf34?=
 =?us-ascii?Q?F4DUIg2KY4fo+oNaM3j9pIEX0S2uzZ9CKQfHtyhpVYtV1EXcNrsC1oTpq7D5?=
 =?us-ascii?Q?ORNGeXIPDyXESGBmm9/6mENoXVM1MjDDNQ6AcXuAce3LJI8rX6Y1QIDxkNVp?=
 =?us-ascii?Q?BDht8hFVfcoRtX9SVMvVw1+0MLpMk+Y7HJEgtNQLivC4wp8ZJcZW8tNttHuI?=
 =?us-ascii?Q?fBeNoZRdcrKvyMHquTJxx6K9R2P2NOyE985tT7jaKqtJq+rpQPVTBo5jGY90?=
 =?us-ascii?Q?m8ckE6vggomK7noWEz0Zr4G6ifd4tZ6FGp90zKjTt/CD6rqVKk6We6Zw8pNB?=
 =?us-ascii?Q?PdDhOZhQXcTN5Ef78tURU9xhaAArTMuI+Iyb5ubOBigMraCeJ4Ep1VL2JVoX?=
 =?us-ascii?Q?Bg3LiF9NW1FZZbXt0T0kUk5RKYAG9gtL5Z43fq8E/KcNR8uwFX+2ABv96tiy?=
 =?us-ascii?Q?FAliQa8xtTeaxgQIkSAaBgssvCQqd488Al0dAH9KO/k8mct6xPE/freElbzW?=
 =?us-ascii?Q?Uc1JnU//iEEHY8vG4LZDqwIWheLGOUGZ3c/4E7/PouGMJ+NbLU37vOlkfLqX?=
 =?us-ascii?Q?fP2n6VDF7sULqSYOaIDFeh+Y6qYSJXFeyEEk8JC8ym5446WwUpBea56gMHOY?=
 =?us-ascii?Q?U3aWFNxCIzFQ+yFb7Gu8NQRkGdKXsLQevfmtdqBWDdw+5+/PMatVwzXsSwjb?=
 =?us-ascii?Q?LyStBTvpX+tv6O9xD0D8o5UzzeSabYppq2TQOFMqTdT9VfFv0ZBddpSEjR1u?=
 =?us-ascii?Q?c2TNrFhrV4sQ3MWgUmKA8A0WLMyQ1xQzCXBsZIPKC0EDqXHUWxA4cbGHeg8P?=
 =?us-ascii?Q?7cyzh03wcNSnx5RclNg79U/YC7jtFR0S8SsievOEm0bO/4PNERAYmCAN30WY?=
 =?us-ascii?Q?7fMlzGA+2O/v/fuagBKFk5YIASeM+/MyHbQyugWW6YXAZziOo4P4nIRyNY2G?=
 =?us-ascii?Q?USCAvcvmfhSAg6wMUbvrPKKZCnzn7qZZk74QjtkIRdBUOfS3Xw4N6nE01D4O?=
 =?us-ascii?Q?hMLpj8EB1+wnhbbs64JFniwxWPUdStw2cenILwANEXIXavtgWphtYzdSM3oN?=
 =?us-ascii?Q?IGnKlw0pUujn9438anVXqjzzx0amAZDDp/1t96dNisZ/EwMZTZtcoigWAtTC?=
 =?us-ascii?Q?xOc7TALoNUlI476dmv20GRr6c1NAwAGFQgwh73stlHhzVXqbUSMiShC7dbFO?=
 =?us-ascii?Q?YDbhZ5ONxYxEK82vYDWNSYcqKUlZ+FgvAiQPmnXSezPYJ0TILCTCF8V4kb2Z?=
 =?us-ascii?Q?Ky8gVlSH5rF4BSeFY0jA9o9uEwuZXErGB/sJpWrxQl5uWCqkmN9nUKqIeBG2?=
 =?us-ascii?Q?uAE0tJr/BqILn0PBEBqx4e8V4koR8AdjU4eElmZfLjTTMYOcqKLuh00ujE1b?=
 =?us-ascii?Q?DJdQUGsNvp4mIz/vvLEPXE0JjfQ5KNGYuBTvJgjzq6vnCusQyDDlKvuQD/Oo?=
 =?us-ascii?Q?vkey8RfmttOazIMDDyrkf1DJnRIDYimbVQE34Dre1v/AGspW/AD97b6epGha?=
 =?us-ascii?Q?2r9xasrjAgROBEBi9VoiafEIbvgFyTa9KUwDxVZEoAaTrrRhOaW0C4ikG19a?=
 =?us-ascii?Q?QuamX2nInPrG/5DFapy4KrdZJpbXExUAjmnb0j+K?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc877644-9089-4e60-ab77-08db6659a481
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:45:40.4233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdPCtL+6u8PmRac6aSp9LO3X2TBE2nHdTbc9E3C15oyHfnSGzFD/j5CfDRSyvALTpCmbFxQaNoAs06ENtTJpVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029

This patch moves the member last_snd from struct mptcp_sock to
struct mptcp_sched_data to make it accessible to bpf schedulers.

With this change, msk->last_snd should be replaced by
msk->sched_data->last_snd.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/protocol.c | 14 +++++++-------
 net/mptcp/protocol.h |  1 -
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4bba29c99172..d52aeb8b4485 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -100,6 +100,7 @@ struct mptcp_out_options {
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_sched_data {
+	struct sock	*last_snd;
 	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 380b7335618c..42adc14a073e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1619,7 +1619,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 					continue;
 				}
 				do_check_data_fin = true;
-				msk->last_snd = ssk;
+				msk->sched_data->last_snd = ssk;
 			}
 		}
 	}
@@ -1660,7 +1660,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			if (ret <= 0)
 				break;
 			copied += ret;
-			msk->last_snd = ssk;
+			msk->sched_data->last_snd = ssk;
 			continue;
 		}
 
@@ -1673,7 +1673,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			if (ret <= 0)
 				keep_pushing = false;
 			copied += ret;
-			msk->last_snd = ssk;
+			msk->sched_data->last_snd = ssk;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {
@@ -2466,8 +2466,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		WRITE_ONCE(msk->first, NULL);
 
 out:
-	if (ssk == msk->last_snd)
-		msk->last_snd = NULL;
+	if (msk->sched_data && ssk == msk->sched_data->last_snd)
+		msk->sched_data->last_snd = NULL;
 
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
@@ -2649,7 +2649,7 @@ static void __mptcp_retrans(struct sock *sk)
 
 			release_sock(ssk);
 
-			msk->last_snd = ssk;
+			msk->sched_data->last_snd = ssk;
 		}
 	}
 
@@ -3160,7 +3160,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
-	msk->last_snd = NULL;
+	msk->sched_data->last_snd = NULL;
 	WRITE_ONCE(msk->flags, 0);
 	msk->cb_flags = 0;
 	msk->push_pending = 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ac05fc317689..949f46d4c710 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -269,7 +269,6 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
 	int		rmem_fwd_alloc;
-	struct sock	*last_snd;
 	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
-- 
2.35.3

