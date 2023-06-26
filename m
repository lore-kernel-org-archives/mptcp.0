Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E537FA
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 02:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDD9btN+79PRMO5m9wA7zqJ62wD/UygcsZwxRPrpyEVhXs51egWvILSoC5ZuW6R7eVQq3zgOGw0IoPabD0Rb/QoL430jmgTkkfxVq9DYUBEpSWp5ORdoYVzbd6x5NMbRAOnqpLxPqLZNXxyq+nIo8upZH2WJC8x8wiKC6owZShTXdCsBQNK1TMe+O+wDEnsC3ViDoA0xNvzzql34LLBTjYzMBVWKozDtgVqwbUOD3XFC9fX38t57imE+lDPTHEFRvhzx4YTTc2OfmriKIGhGvG+HOD5kqf2SEAMFvQ/9J4UVftGd5uzyIVvLZVYZ/VWy0nUs6zC2FxMJsMlVyMX7WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeApqQnToOXcd/HPMxQTIZreDZRn6iB/x5WGYHzeERg=;
 b=jV6W7dPyl+P+vmntcEyPVcOOou3Owa1lvpIyzH8BWebE4EjZdltEs6gAjHlZswpscS/72aVWT+WA18XCSIOWViXU2CBRGd4S2p7gtlQMnF0Y7QtVVDkqpNuZKv9tNi6jVGkEo/BS/sRUCp89tQNBHOnWx39nrwtKonhtJoIliEr0bsvwa3oasU7QzLzXWxY9cZEbdkYOwL2CYT0tbU17yJElkYEjZvU/RzW5NB4u5BP0mFH83VvfKr7NoRYsgFfM5b/YcuhzGRNKjGBnVUAGj8Vb9JJL2VjNo4T2G0W+dbFalcg2tkpGHyaxuw3xIZswlifaLENAFUEUB4Loi850nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeApqQnToOXcd/HPMxQTIZreDZRn6iB/x5WGYHzeERg=;
 b=IQp+QhLzXe7VZs2r9BOcfdVeomPX2We1LJJR71IzzfAAE3I6dQJJKmBxQWvjoRxquraeuPp0pqxhu1GeRzjeLqXErPVq4BHk+7ruA9pxzMMEyImbJgvTRyGq8dsh5pb7dpjCP53JUObtwUyayVu7m5AkEWZPp/oYNJCjufXDzYVuN3mf+cfvUJc4b7gMOoNYAm7JNlBbN6nDp+3WF49H1LI0XuLlSK/c1nM5pXERDBXOqSK+7EtKO1FtTicAdSDItt883COkjnv8TCp1MALX2NnlaoFrTvVA8euqFKJzv4pC4XhcirvIeo8PLNv7KDzUC/QBPkXxwHhTjMR3HQYmRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7088.eurprd04.prod.outlook.com (2603:10a6:800:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 02:23:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 02:23:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 01/13] Squash to "mptcp: drop last_snd and MPTCP_RESET_SCHEDULER"
Date: Mon, 26 Jun 2023 10:23:02 +0800
Message-Id: <3b024e4191dfbe2508090eb15dc7966a0827d890.1687746021.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687746021.git.geliang.tang@suse.com>
References: <cover.1687746021.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f9ca53-7fcd-42ce-efca-08db75ec4ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+kJdSwuivTTtQXYMqFQ7QRrfzIVId+Lko0Y1U4Lujj7moh/CZvTlNnopUZtNPt7586erQ/DJUmHDXQoVJlBA4k7j9GJI7Wvn9N7WRTjOwWwp6moVNtfb0tWWg4atUzRo/KFQJ8OV2XywNIwg/FRWbAbLU1cPFB3yFS+7E/dpxgfpMwJrZdNCmpXFTs7XFL9fZHefmS78lP8iNpoFfvj/Uu4i1/V868DghjK2aymQLUkLvuV0ZDC1iPpAdr3vOebwxAelorxSuuRjWBKd2SQk9mt5j0xE/TgtKp3uzdCcBfo1rX+DrnMmZOobtj3HDk1dwDxdZS3OGo2Gkv1/T4yr34gvBZX403YP00IE5lawOdHacinST9gb6DI9u7wUrUk9F4ZFWN660O/9yemRiezjiby6G2R+BYpHkBNdLg9t6wd81sF5sjebAbV0iLBCzmt1naNoNEUn7qO2g5BCrz0flmuGxxQajdI+KNQvWuhffaiPUS6RgQiiP2mzyBTuXmB42+ZLS97EEkMHi76HLzRsSbo1254dMbKsS6F3HTDvLJewJH6/xYKx1ybvGFkG0/uk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(6666004)(6486002)(478600001)(83380400001)(2616005)(86362001)(66476007)(107886003)(186003)(26005)(6506007)(2906002)(6512007)(6916009)(36756003)(4326008)(316002)(66556008)(66946007)(5660300002)(38100700002)(8936002)(44832011)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YYbiQP+5BTmQTiW0jPqF6Thq6O6bafA2oCzMRwDxwiaD5nd6OYOtkrNkLcFQ?=
 =?us-ascii?Q?9YYoyh1kjQM/3fU51EOFisEb3gC9D/A5enVMrmpUlbIQKDi+P8j+W14Ju9hq?=
 =?us-ascii?Q?bdMcDKJhPm3xGJPHJGdn0e5lAn0Kj3f3s3IJo9OBXlFKOt/yx5tbvzsvbAks?=
 =?us-ascii?Q?y5BpPbl+UsMLOR+MTNJouesCkd4Bo2JEM1vPEfB1iJR0M/5qv8NRZ1M2Mwwp?=
 =?us-ascii?Q?7k8xRcCj/K0NleSVsjaHejHixfqsV3f0UHKBcL3xoEzpI83/5QNqqryImD4B?=
 =?us-ascii?Q?rqOMIGjzWpwcQENOqTFdODAJmtO+SvXN7mcc4+nEZh7fwJxIyNSYlLeE2mJT?=
 =?us-ascii?Q?oxQJtiGpnaX4whCHtSIHSEXk2rx2Fq36vPD7C/DfAyRl3HVSheKoTtLTOj+U?=
 =?us-ascii?Q?+bXh3rC8lWUP5YCbV73yM/jBfb0Ck/NTgtHX6Yhmtxrp7aq7wtb6vHhUQBDg?=
 =?us-ascii?Q?KxrrPlxyeyDMNDmVbVnw/DQc5YK80PfkLYXn1NVqjK84BsdW6M4lCrfYt8mR?=
 =?us-ascii?Q?Z0mE3UO0jCY8LKRy5M/0SL7pPe5L1QD9NNyUWiH+LIbMHNABEoDUqmrnqTeT?=
 =?us-ascii?Q?d6JLJLGjLzj+20xQLa+NzzBBD0KtHZbz+xU1fwibP9xdvPnPfYqm1E5Rr1D6?=
 =?us-ascii?Q?P0INIyeDLwpVlLN4aIg5eg8Kb9Mi4Y2E3fbokxhk2Ps1tEl2xb0ylp9kLQg1?=
 =?us-ascii?Q?hjyKN8tJQu2kPubGw8O4dFG7W0dzTP8CVk/ZNVKSvHb4xy6YLzqosK8Zhd+p?=
 =?us-ascii?Q?tfs/tOaq6iUFeQwCooKoiRkfWoYc3u6euwvYuxcBujZqxe2G69SAFmkaJrS2?=
 =?us-ascii?Q?gX6gEiFsHKUk0O+G7HonRXLTw+yS8QGCUV0uvsrGM4yORn6lpIm7cl8Abvqu?=
 =?us-ascii?Q?q9zz/Odv+kqrU079IjF0pIY03CNCe2mey5LyCpDqvf+dorUabUXzAw0wFINc?=
 =?us-ascii?Q?rzs7i34diW1v+h5eIIwYwNcSlLO1f3+vqEl8tv2Ohs/LNgVo9rREQKoJhFur?=
 =?us-ascii?Q?R0cl/ZkPsy/JR6qf/SGmJzBT4p3IdrZIJTU4F+A+EoErKDWz0UjWSFZxMpJo?=
 =?us-ascii?Q?U2LT4uRTXmDXMHlq/7hsKJGtD9BKXglyq4PZ5+V6fCZ7Wbkl8dib6qZnEFdW?=
 =?us-ascii?Q?wLpRehCTDFvJo38LH3PqN5ceNRdSdiTEGYUu68mEsx72q1dcfgzrjbuxOJol?=
 =?us-ascii?Q?Q1VZufOwh5gBYta+Vgip2dh/RyRnohRostgSbKu3IioO8MqKKYOiZLqoN013?=
 =?us-ascii?Q?3eV0LN46E/D1EPhpgMBF5pg6kSOZqHR2hLr/U4YYRxcbKKYGOa5tP7gOvXmu?=
 =?us-ascii?Q?WDl6PaZT1lTTW8ixQF5mbIshPnOZcsBZhkpU4+4Fc4CA15bGPAvii4kUiucF?=
 =?us-ascii?Q?CpASO7S0WanIdchcFdRqz2K6MUUTKpksdBhfG4HuuAqncKBYw3ukEV80WnYG?=
 =?us-ascii?Q?KDb4NLSnIW8MZz8WRcYvmJcRUX97gXc+++5i2yXM2YHY7D9PHKufIdnLAvX9?=
 =?us-ascii?Q?NxyLmmyY26+ZO6MoSSBlvOPjaPz+jLQ32kRgwDMXaka7YSidu2z0TTR0WFM5?=
 =?us-ascii?Q?X8RaMzTMdlNztYNwmpwixUwr5DBy0FH3v8fxrd1+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f9ca53-7fcd-42ce-efca-08db75ec4ffe
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 02:23:21.8960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXqnT29M+CalSNOAcVzI8DfjBAVK3tnMpRGZoFs1Je95HpARztZGriJPwxORsfckBZkkuIR8h/FKSrCd8KNg9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7088

Drop all last_snd.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 9 ---------
 net/mptcp/protocol.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index aad21e0bf536..3ae0b94d25c0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1573,7 +1573,6 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 					continue;
 				}
 				do_check_data_fin = true;
-				msk->last_snd = ssk;
 			}
 		}
 	}
@@ -1614,7 +1613,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			if (ret <= 0)
 				break;
 			copied += ret;
-			msk->last_snd = ssk;
 			continue;
 		}
 
@@ -1627,7 +1625,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			if (ret <= 0)
 				keep_pushing = false;
 			copied += ret;
-			msk->last_snd = ssk;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {
@@ -2410,9 +2407,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		WRITE_ONCE(msk->first, NULL);
 
 out:
-	if (ssk == msk->last_snd)
-		msk->last_snd = NULL;
-
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
 }
@@ -2592,8 +2586,6 @@ static void __mptcp_retrans(struct sock *sk)
 			}
 
 			release_sock(ssk);
-
-			msk->last_snd = ssk;
 		}
 	}
 
@@ -3104,7 +3096,6 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
-	msk->last_snd = NULL;
 	WRITE_ONCE(msk->flags, 0);
 	msk->cb_flags = 0;
 	msk->push_pending = 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e9ca30189731..8c9b2a03dc94 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -268,7 +268,6 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
 	int		rmem_fwd_alloc;
-	struct sock	*last_snd;
 	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
-- 
2.35.3

