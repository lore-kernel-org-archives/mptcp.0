Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A075684
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 10:05:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQ5PfA94iz8TLd9dW/ywiUnF8rerqCzuKdRoQqsFCp+Q3X/yeBiuA29K9L7eY8JR4kkuLLjp4o72VScF7qMlaLDrqTg5Kynw6oKi9zozRpglwA59PW2eIYMZnFRmF3h/mzSiuJqHIzHG6dTdhQPOtbJeWxDkupD5SMAH7LNRgJu9kNyq00YsDSzPCy7Q+u9dA6Xu67GH7Q/wyNBx52U+hfdWqUEJCm15k9NBa918wcuzOhIkqczOGHIi3PHxCQ2OuBn3WwjKmKbJk3IJpniU/x/ZHcV03t7HGzMnFfs03UA9d9EotvoGE9YpMpMnJXDxiAfZpRoM1c9BMuSz5PiXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pQWyiwjjgeKPS87ddyLtx3+Np/qOSmdEelVgtqzPCk=;
 b=jue1AOi357MPOg2TtnAJFp0pZTkW8NhUB8/QlfOJqq5zLjtODf6A/sUD0dnhVZF45QUXktcJgxtsSHRJ+B0xKG6q0T0eUcZMIeMYhoXvBvJaTdd+0STHnziAcrAUqupFJsuPUZ4hiOnCHbVgezrrCjYWeya4tipMRvJSgn5X+85G0t/TuW2kK1FEQcFtb+m6SG/LGrPrt6XXcwagb2SpiqC2HaPTdM2aVAij2ydXH2RReWMVPEA7ENb9tHA4M9HSinJ7DRI+xKNPuqxMXM/nVklZuOksJynBnZlns+fFt7ErayffcQWKkRyQV07nEFtPV2wvmQzijBjED3CTbb4pEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pQWyiwjjgeKPS87ddyLtx3+Np/qOSmdEelVgtqzPCk=;
 b=WcK2asteDtUM6RoysOcl+jX81I06RKp+YjywYsaKlSFUPDD2Fg5EwMU5daQj2y90l3x3kghckXWYHp/agtZQL7UKuUpQv8DpLka573TFbyVifYCM7LCHAmL52+eXrmSZzx7+7sEGt/SLzfs8tA/3gNQzaWyiWCho7mF17XtWgBjLXiR7rGvc8QyqNPHvllhCHBchVcIlZ4ryc10ZobsZWgGx/o7zJMI2IY+F545CgnQmipLokty46UmDk17ACe/wo/HcxKahNfzBr34jQf3TFS2wLcgnLTgEcbbzk6ECPlEKBJ0yYJsO/x+zc7TLNjxucjrZsMb2kVmwB7UngprDrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8596.eurprd04.prod.outlook.com (2603:10a6:20b:427::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 10:05:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:05:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 07/14] mptcp: rename __mptcp_set_timeout for bpf_burst
Date: Mon,  5 Jun 2023 18:04:02 +0800
Message-Id: <0df77b21de1fc44cba9109fc46891b329bd5d412.1685959315.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685959315.git.geliang.tang@suse.com>
References: <cover.1685959315.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb7a9ad-7e65-479f-ffc5-08db65ac5acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qC9RFzaN+1OmBd0aFWnKLvVZJAWDxFOpg1HhBmzdnbAAAu7c7VM7zCq37HFzmqa1rnalsxc0Ju4qIm5hwIMcvh+CtxZr7SOk9WcnwiGgkih7uWIWxn2/IYsxfgkZ3/C2DENyYDB6sCK1kaoJgs5bOmK+Y4sDsGS6fjrrA3S0CCbu1WeF1gJld/bzTgr9Bty5o9Z3eq0Cb6un7VGG+l7z/Ji/p+4OinPm5WPe/yPpR463wOYsjQYB1dQXHcMmZ3PMghR9FeJqfAKbGKGHA5qa2Ah+V2AANEkqCryd4XLIklsy9Po9cFocqve3eq/6sT96xzaAb83f2QgoPo/ioMkmkJL4rxgYQ1vhu1pDFTWy5gwdIuX5Cn7Rz55QWbluHpkvVT5Pm/SfEsw82K15GnxVhcD5qcJHl8T4mHspULabnrEf7V/B03dkcqXIrBHGg+YGksExUvmX9hf0BMl5Ikje1uHA/pMlIcZCLV3d+iDXdjSr8HlnjdFcQkJIFfGHDfFGQg4hw+LS7RlpC1NKBO9a74XL6ZaAJndrod4PeBggSnmL2Uix1s7jkQzwfBCOrH8e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199021)(107886003)(6506007)(186003)(26005)(6512007)(2616005)(83380400001)(6486002)(36756003)(6666004)(2906002)(8676002)(8936002)(44832011)(478600001)(5660300002)(38100700002)(6916009)(86362001)(4326008)(316002)(41300700001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yzZrKEsL+p54fxfdhL8/g52ON8IkOnGHibnFOhNn4cLqr6brjOLrnDqNWRA6?=
 =?us-ascii?Q?Cb0xCxqRiCgGLxgLKbnOqgI5vu9c5Lo1fkVEhb4z43jPdIJ+sQO8QhwwAZY8?=
 =?us-ascii?Q?ExaPQ1XZWd5/9jrWUryGZBhilnlolbmkYDb/9BqffOMJZzfz4EYnXJLZ1iDV?=
 =?us-ascii?Q?xXouyvm84mN5NpGesUAlx4HjF34cy6T0IbS45RYtmNKBwyluyza4OD2iXmOH?=
 =?us-ascii?Q?mnABCWh9c81nMrgc14bbJbz8LHtLJTGrSHv1YClSMtv9BBa7XZwJbFTw+lHq?=
 =?us-ascii?Q?qIS+shoRZBUBCkHxEseQtc3blGLv+SzftRRcy8rljexkwFZYhWF+S+tuMDde?=
 =?us-ascii?Q?yyE7dZ8sgtTN4cbe2mXKOfTVzxA5c3CRlGI7K/zBEG1yXZKyPRWGQ/mvcZJC?=
 =?us-ascii?Q?FOst6v3urUL+02wU1WkhvnyMK44NJXvmmZjKdyvuM6zdnvgfSzlHc/wOX1vj?=
 =?us-ascii?Q?K2hEK9OuG5mkvKN+Sdv/80avZELh1hGuxqW/x4JUSxBcWy2W2sQJ0p0ep2Qc?=
 =?us-ascii?Q?OJlNKkMemSU28n9EIYEJKDA7ScAOs68DeexMtoW/JeeMmoMSHKeMgyXO89O9?=
 =?us-ascii?Q?k5UdSv9ob+lxYf7EF1TZGD/8jStjrsrJNIc/V5OXR3BGrvIbbr6noKdN0jWD?=
 =?us-ascii?Q?1gbYBXFHezrf4VvyQv0dmpRMvHcJIqcimtkuMzRxHe8OU/MoWTN+KkgMoCye?=
 =?us-ascii?Q?8R4P+jeGbtmTFF0cDu6Sr0mhq/RqtHSOysTPTl0kcaH+cP8xjl+4ElStTqGs?=
 =?us-ascii?Q?gu6YT/fmKRa6ixfCn442ncqeDbY3uQrGlqIpbwu+KM2o7+wopU0uTcoskSy2?=
 =?us-ascii?Q?4BLOz/U4gHn6Hrn/hxYzAYOfvP4ri7V/pErxeiHpxY7M8t4TH3WMAeh79VYd?=
 =?us-ascii?Q?RsvYywoEF54CJRPEebkmrvWlyYhZpiXmcicut3q5YRtlScTrX/kUMGBg3Gqx?=
 =?us-ascii?Q?yBFGMUBq4VXb4oy1kVqObl72h4Nv/ca8W7nh+1V/QJjPCGx8jHIKXcO/edWd?=
 =?us-ascii?Q?zZDdJAt4cC9MCMEKYQ4MjARoShZjKqYRmbzk7FXU6lMGZlgT2CF7ISiIN2/A?=
 =?us-ascii?Q?sSEpQfrqAdVroDAxoFxnF+ZrxiPbFnWRsafly2rK1CxRRPLq3qNs/AgSCZx6?=
 =?us-ascii?Q?eMWXoA3cNuhiDx4F0WmAboXXPzRxEQz7BwA2I3oqGamwY/2qZIitdndudXHH?=
 =?us-ascii?Q?EMO7XvU2i4SD0T94UrtJWkED8+exGrh4WK0or9481HMSPSYDtCD305PXcYN9?=
 =?us-ascii?Q?TdtlGXDjFRorbU06PhRU9+O4AHZ0Gh0+704snCmBI8ccWw71Ss9MvhHuHxId?=
 =?us-ascii?Q?2ZQeAZ5Aa0yfnEZ6AGr+tGGgS11mBu4IZ82IfENGN5hlcruOsFX44w6G/y0q?=
 =?us-ascii?Q?5Qsu3nysfzPKzu+PBY9v9LpDyg1KUB1kRVDJeiqg1ZaceCZtYVjk5sA3OVRz?=
 =?us-ascii?Q?/zNY4g1PHX3wupmzIR6Th7+0IYth3brGOUx7HjHp1BwFiZlGWnQkMZHn0YoH?=
 =?us-ascii?Q?CAwbX77TbUddwHWmhzr/ECLIlwrTD8CmlBScmtTx9V/kgFMzKEMPxzWBuQs3?=
 =?us-ascii?Q?76SShpR61HUj8er1bhhW1wJjGXrHkWgo8+E9uZWlObCS+JFE+4+B5mwJ4f+C?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb7a9ad-7e65-479f-ffc5-08db65ac5acb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 10:05:13.6945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETX+LLCYQbbkyGveNhbIHlpbukF69YTO6lxYGRtSvU+s5UOG5ngf3HFFB7G5WQT8gHgg13Q3onKXPqRLULsk6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8596

__mptcp_set_timeout() is needed to export in BPF context for bpf_burst
scheduler, but the "__" prefix cannot be used. So this patch renames it
to mptcp_set_timer().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 27407b48f3ff..55c2be2b14f2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -485,7 +485,7 @@ static void mptcp_set_datafin_timeout(struct sock *sk)
 	mptcp_sk(sk)->timer_ival = TCP_RTO_MIN << retransmits;
 }
 
-static void __mptcp_set_timeout(struct sock *sk, long tout)
+void mptcp_set_timer(struct sock *sk, long tout)
 {
 	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
 }
@@ -505,7 +505,7 @@ static void mptcp_set_timeout(struct sock *sk)
 
 	mptcp_for_each_subflow(mptcp_sk(sk), subflow)
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
-	__mptcp_set_timeout(sk, tout);
+	mptcp_set_timer(sk, tout);
 }
 
 static inline bool tcp_can_send_ack(const struct sock *ssk)
@@ -1455,7 +1455,7 @@ struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 			send_info[subflow->backup].linger_time = linger_time;
 		}
 	}
-	__mptcp_set_timeout(sk, tout);
+	mptcp_set_timer(sk, tout);
 
 	/* pick the best backup if no other subflow is active */
 	if (!nr_active)
-- 
2.35.3

