Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2087.outbound.protection.outlook.com [40.107.249.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A965684
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 10:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVrOLflcqPMsNa1k78b81i3sL8+IURjwqd6KtvUvvhdK+z9oHltMICXylvWg28sWAVOBMSlVKwhtsJvipNRE8ldwstlpEPGYybauNr5oliWLGFZIv7nJPwiwf0D/sSxQhU1qilqpE4IiTtY2jlsXwNBdsEJxFvxykTd3EJjkOa7yiZRzPT9T86KNx5jnrOk2JDN1Wn6HwbiG+R96+AgStJx5CMcgKp9h8Wcttug53/uEnz2k54Erq8qnr75kjOwpqxhg6n15wEvM+2exd4cAqK7kqtODvk0MAfiHRit+nEAzOfKXRoRuG9E0YOKvI3XYVnTDUJuXHKkBjUaIk+Spag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUPII91VbbbH5WnNXqpLx5RZRasL80tk7pFYPDg0jNk=;
 b=Xt/DJLnNayi2p8UbItlVRgOGZtd1TmST1WF6Cjt87EzGfH5ad5koDyj7RiSCRkMxwTcetobEkjrUB4vxiikAopPigZb4REIB+hV3WvUWUXNnQZ/ThtKJkj6wiQ7wp+Y54kRbcrJElq0Wy3jvQejERyQ7lZa3Fhxtg1kq8C52aQCxvA5B1bWMZH3uX5NcmL0m5MRCVSXQURflqLdO4As2H1GjetkJ1wskLrrhghaEi7FKTHnaHcIch9bR2vEhQbGkWKEitVzYfjaUBNsCkQmvUmAGHzD4JHukA7NGeMvETm8qPRaqOVJugWRZiE+5909fjanu7PKoaFsC49ODp0oTDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUPII91VbbbH5WnNXqpLx5RZRasL80tk7pFYPDg0jNk=;
 b=1Qkd1nN44gHtxn6A/6D22fL0IOsIPHW5sZElb+LwotwyfWQ9B3+pX3UqN5tcw86Yds2hXXmpownI0f9PzfliY62jMlUWvvngBBGUXTBJ2vkMsmi+LjDnc76KWmQkb/WBpJZHW9t8FS+zBgTe92n7iTMmFaVmm/+Ti0JpzU0wNARtf5fhoy68V5IaBAJy1aHr+3HzEV+0W3hQ/MLXkutLA1wQRFxvPjKGum/hVzAbvJNgGW1nfCTyZ7AxyLgclpAVi+TGHJWbFlGL6zEWMw4YBVuJpktGO7KZYy6VzUaqoWCa/bYADyMxb/ZzDLyxdw94CiKgqNpqtFBO6Q9Z3L2vog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8596.eurprd04.prod.outlook.com (2603:10a6:20b:427::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 10:04:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:04:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 04/14] mptcp: add last_snd in sched_data
Date: Mon,  5 Jun 2023 18:03:59 +0800
Message-Id: <6083739fd4916a0e8480e896beeff0fa02d2665a.1685959315.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685959315.git.geliang.tang@suse.com>
References: <cover.1685959315.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::18)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de121b2-65b1-47fc-9a95-08db65ac4c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WwYYiqeWedbf5sM8CuQ5OWTtuHQt/Q0euygRX7JSXiMDPojvxfJviEJmsO0vDCuu9qvnShBfj5HBw8/oSy1B7LG+E1bAoA53jeEhzI6uzeLkqHIWMqozLJyeDnwzvAYOl6O2Gh4eN9+IfZr1SPYcXsZJaXxyWVsNHNDSsxOePwWTr5wsmlhUPP8jmrJd8wpxqWi7+Gzw8WUBsxZHqJFxP1i2GU1wQ7+4o3vfjWMxnFJ0qp5Pr3m3gY1EjWkQ7SePIv/XtMcwzq3o2IM0k/5L6I5RdafzmstI6sjqxM9kMB0pqnWRtxBvEef0pY6cSM3g/TiGaPpbEBK4k2bMDAC36GVQ+D55etFkH5PL1zkWBQjYexK9kF1bB9w/dRyAU498oMya7ZN849m2zkJgibnCt20iYVdV/jtOnwYRNLzVPUzAwinVCSZP9MexVjpJtjaDcHI6pUNgwDbMVrd2GTPZ7RTKpC3AeuU0lXRC7QM8OB2xaWJSzMnKsFokw+EM6KIPSWGxroR54N3dav/+ymMlNlBSk5aCkVN0tSkR6mOVVSeSNVM/EE5xs+fOefUP1X7A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199021)(107886003)(6506007)(186003)(26005)(6512007)(2616005)(83380400001)(6486002)(36756003)(6666004)(2906002)(8676002)(8936002)(44832011)(478600001)(5660300002)(38100700002)(6916009)(86362001)(4326008)(316002)(41300700001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9NKu7A5c6D9qTQit31NF4MVKW3J3XeXTYP9Q8TkAUy50DGa6X8ESn+rAhzKl?=
 =?us-ascii?Q?LZQ60WekhEZLXX9yIA+SjjqH0377KKJIibzZfe0wb2dLPtMclKJNpb1De+1R?=
 =?us-ascii?Q?lWXmZvIjCj61wjPNbdhp0SNn2kgNKM6uChSf2zaeAgYTccj3XHiRy+UOWW5x?=
 =?us-ascii?Q?wZrp2CP4CWLWm4wWMFrr2JR6XEeuRXwXpdgQ5QLXr4t3B8BdfJMlDOCeeXho?=
 =?us-ascii?Q?idPYnWlEoEfwSzdzBWfQ7w0upeAMqd2UntQJBw8ot1t9f/EqtGJGuM1meRwI?=
 =?us-ascii?Q?i4iSqkq+SNe9FO+9WFdLolXEVBSgPCGLG54ckCYusQ6s/H43IDODgaTcrse/?=
 =?us-ascii?Q?+R+fhTprv1Xy0a4Rk4K0KfttegPGo6ZKBfNje3RDYvur70y7G1EheN6CM/AL?=
 =?us-ascii?Q?tKX6Ardt8xO2fyb0JmXFdXFRblRTgw4gTDJuY7JuIgKsL3wT6k9B739C5k0f?=
 =?us-ascii?Q?q0FKmUbXxRkUFUrA61G1CLIP211QlZ7BUS/4qQz3L24R96ljLLArrOL0sIW/?=
 =?us-ascii?Q?CiJQNWnD1eAlM3gKdzcqISFKw9eg7xEhfdOPSYeOClFu3nQ95K+SOBmELXp6?=
 =?us-ascii?Q?Y5BPVs77xYxTzZqAYqOAf9ySN5TaGd/HAHWVuIs+Uj0bV9tT+Qopp204yJZ8?=
 =?us-ascii?Q?tw+IVaHFKX/q8Q9HYS1eVXotKB/whqc4hCb+jhEOzKJDSp1nvnk819037Wkl?=
 =?us-ascii?Q?S/Qh8lto5YAMIcrMItIttr+mOn00jdQ86JmqL2QZ1e+3FBbxgyFcvmWl5K2Z?=
 =?us-ascii?Q?O6HW6xye+DLrlnaDD0/3yPlrbW03/t7lqh07W4PVhyqpXLCTFY1ExB+IcJS5?=
 =?us-ascii?Q?l25eyIDWNvgbALGKs/LAfPZcjIsk1oby1GdJmvSWWCW5M1WZDp9fWDBsXkSG?=
 =?us-ascii?Q?+Fa1RXK3tqOJxUKVqWIg+JCi2O4skxDA5+8OzVKqruWb/ZZMAOiDi5HgxxFV?=
 =?us-ascii?Q?Xpdu4V2Wz/tntEBhyDee3VD/N09omdGu5vW4p6wW/Sect/urnBwaqNW94MGG?=
 =?us-ascii?Q?6loGlFqUfDSTOVdaX9Ni9OtAX+UTzVNJiGkUZtJnbj1Po8AfQIzsG2XVXCfi?=
 =?us-ascii?Q?cIUgHVHCQgENj2Y6BKxr6WvNBRO3/WPW5VrE6x5adwM5q11xMlkK5vbt0NDG?=
 =?us-ascii?Q?SEPbkwwgwNUO6z+z0b1LqOx80CImmu9TVd30q51xJekVAiqk2sHednPoomUw?=
 =?us-ascii?Q?EUchSJk3mb9Ug3M/+oXq35bg+RIf9Cket67hn/cLpWMIgotpI7BwZF7q2tOm?=
 =?us-ascii?Q?cHO8CtXT6V8i1Fh+h6r51YO4BaE3gX2ADuvPcna72Ag+LeO65E/mrlz+25Wm?=
 =?us-ascii?Q?Z9s83PjqDL2CW2hpMMd/ZfZhjEkwxg6m3ue7QR/nRzkv/PAT9q87pKbsMO5o?=
 =?us-ascii?Q?6I6KhY6ka9mIIP6aeOjnEuVT1XTycJiZJ+CpRCTinFYaKuVAaFKmS/sgdRM5?=
 =?us-ascii?Q?GGKlTdB5PrAaUrJwPtmHUm8tcwxnn3Ol+RfGiunEsRS1DWW2Rh9kQcX2JsJx?=
 =?us-ascii?Q?krZXt4l/sQDljXYdcWAgG++Bn6H+jRBkvJFvS1XFaVl4YNSQwF7xDJiKbsoF?=
 =?us-ascii?Q?WlaePdwHWPLxoA0BViUonG9oWnNy8V1kt7878pDE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de121b2-65b1-47fc-9a95-08db65ac4c04
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 10:04:49.0738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZ5XomJuo0IsXckFJfAw6vN5sTBhgw+SCnFjWs8oHJVJ/i2tyhuSd5fBEIZrW+U1gb4e6Ebmo1Ey1aHEjXiNrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8596

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

