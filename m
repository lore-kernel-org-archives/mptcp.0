Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0497220EB
	for <mptcp@lists.linux.dev>; Sat, 27 May 2023 12:56:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3QGbGG8uKeW5cJGxp53emYBYQ0ftzIZQyrHr0A+MHOXOsfW+zzaFeLOGlLvU7D1bFXNltdDCMU+ueov7W81bXVVwjNjQFuH6LWkUZcphSm39y5W1JWnEDwdfPKIHV5wxiFFBPCpC+qqw3BjthpZlGqFry7c4895yVFte01GQ5X/mYAlh+TI90nHLc+v41GSJ6Fwsv0WusaH2YpCk+84+kmAzTFp1uKbejXqL66pxyO1Pl2ciCf/522PeRaena6jkwZmyK9RZqt9zplMFz7anLITsgm6DefdYFlyhmAifbrSsWnGjooBHw7qfM2J7UON8kS/IoJ3Q/3jrPlpsRw3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQ9H09HbhNbOHAC+Ffjd/nb9kksQBT6yOON7SkFuDLk=;
 b=aZw5eivHVLJLzaZ3OHBLs1vhaSO5pD4BvPUQSowZvfigeRzMxeV91tPkdDqzuGbQrptx6k7ChbzrAoZmDnFicFaiijegquiqLyEIjIOSdoCHkgvmzpwiQLZR02jLHt41HIi/7NfksTFASePxdSP5Ttpv/CEsaXQcvYEmrmKpGXBpVQiB3unbZ/xY7q6lNnWwzvkJ76TO8LSDeo3fqwU8stWj3THBdGT+quMNSiyyLyYPlJ3Vww9a0bBcZegatWahpQxj93x80z4GZfPT+QVALuVzZ1hovpLPE69Vza1cT9YPh/ZGSFEv6BOvRU6Hb8NYKyGrpUkq/S1kQo3aCvtCjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQ9H09HbhNbOHAC+Ffjd/nb9kksQBT6yOON7SkFuDLk=;
 b=200ZI0lUhiLf5/onfWzH+XfQCSAyqagwMpm7dbLaga/8nP8q75YHT85FIIVXvtVhFlHoIVUF49SS4gWZ+FfgmKMZoAgTpcCpXds3/F0iuglbL083pX9Ih+ESHh4K1HnzgQQ5dOgYLO4lcmJrgsfXjmyf3dgEchUlbRRJEsYeMejQs3whUdVKnafbQvuABONkpE5r/SKcWusz/NoC9Ivl+riXry+5j/T0wITxHIfEFLUH3aPP0gfwMWM/TvgSr82y17XKWX6xbiBcEXj9waopJzTPuR+J1DM6CShxfL/nd9n94KU9U1tYxqihstFk++NmRBmU4khLafqf0LuRvHF6vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8371.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Sat, 27 May
 2023 12:56:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Sat, 27 May 2023
 12:56:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/8] Squash to "mptcp: add scheduler wrappers"
Date: Sat, 27 May 2023 20:55:32 +0800
Message-Id: <bc967c5293fd6c9972d4ba6bc3cecdce84587363.1685191581.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685191581.git.geliang.tang@suse.com>
References: <cover.1685191581.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 5381ead5-5374-4cf7-7273-08db5eb1b9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LBM9xGBUINKPzkb+rViQF9xMUzVtwE/b7oik7qO4zPWdpgc2MLeBZ/0nFjnkvV8sbnqSVh0kUEn3BA8byaInhn1hlovsqEDMxGH8CwScWq8hpIQHM05BotZDVDNkuKBpYJ0YHEpQh+8ipi72/xmmsKHWeJRBRup6gnd+WbeEOxXlAZp9ZTk3DDZgWlditZg93U1a9q7MiH0b+DHF/APB0O+WSkRPHc0SB7s3yhaeCEpuSKHOIYpOfXJo3qPDj1pgPnpFJ1X5286+L7gj0JOrc61a/rY9SsoSBkQTejmLzjLuiCAFLa5Jpg7ohkt/LFZmQAHp8YvkAXZ2BPHuepaKGG2Fvj+bxYas06+KFB2905m/4m4ZK+Bn+LGgUvJgDVJV427qQmuJEs1QNprlpL11lca8EDwE2pQvMVYkC3hOS8yr+zr8ujngOOeIr9Hu70JoAC+SFhM2evJRHRpg1+Jh912UVFizS4t1xLfyFLQO+I0vZU9OwOFAJXPF9QtSkz3ffUL+FKEX6dOJMAVaYbMHyCQLf3HPeQr6KZHF9cMqZoaGlYq1FEl8DFhyv1X79eIq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(6666004)(316002)(6506007)(26005)(6512007)(36756003)(66556008)(107886003)(44832011)(66476007)(66946007)(6916009)(4326008)(38100700002)(5660300002)(6486002)(41300700001)(8936002)(8676002)(83380400001)(478600001)(86362001)(186003)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oH2nSKEFeMJyW56gQGgSMclzm77Dw5heO7W1gqlWa88LsmEmsKxQtelqZQYk?=
 =?us-ascii?Q?Irh547f9V5fj+zfbh7CepFBSLOwrrx0fpagyuEHDrAi40rWsfxkFMRH11XxR?=
 =?us-ascii?Q?P8HZrWqhJkJc8vAFFoS3Iz797zyTcuZm807uA2uSKWi+Y4gjBaLRQWf+hh6a?=
 =?us-ascii?Q?tSR9J52a1NKA+Skf3QDp8C5PUVZGezAY6OS8T4YdNbBZLrdeC6EPC+dLAPZl?=
 =?us-ascii?Q?Azh2AqtLvYg1Dzw2ZAGhEUeEPtlvPDI3Eu/8NEVE7giNnhPWORMZaMUrrevE?=
 =?us-ascii?Q?8EXsZN9324xWZE7hcsosw5Quti/4piCVga93yjHqrbZLsAExFF/14sDtN+aI?=
 =?us-ascii?Q?7xiq8E5K/jlhm2iBAt3JDildscGNzgMkF5J9RTfEwIeTr6woQ03UZGAamn7h?=
 =?us-ascii?Q?dIN2XjSp/QBE4rklHsVBXwHXHsSTG2SKJwSaAcNewzSzMKfRLgmV6TALknJP?=
 =?us-ascii?Q?Y95RGMQwGhfHwWNe7mUgtqHc6hOUBVfk24qBGU8j84e2Xko9/177W+RMJb2O?=
 =?us-ascii?Q?xIhM3uxs1gbVKTigY8hsHGr5+lpOve8gQ+GDZLl5o4h6sVpGUvOnLCRSUk3t?=
 =?us-ascii?Q?E4jz/AjgKYjGdpGPRpAQa9OCtqncCOkdukmgQe0or+q0L0DwjIAUklLZ9c37?=
 =?us-ascii?Q?/jqNlIQldNiNnBIsrP6jviziRzg03FlBBjSWK4/bSQbbn1WxgfefQnjQQf/A?=
 =?us-ascii?Q?yGVybupnt7DYXDcpYVJKlH2vidKB18CkdoG4m3NPEFGAgXq5clFbw9+4QqUm?=
 =?us-ascii?Q?7jhMkdJ87EDkAuvUEqzSx5awk8LeLTe6NDUyZq/kxArNmG5wZoG9SjLpNTM/?=
 =?us-ascii?Q?wImVoytV+x/OMbh4WC50n4OMUtz87TUgJV/btvi28nBDu4LSvH56+Abcbtzk?=
 =?us-ascii?Q?w9H/sxy3XH9gNxClRLesDpR9y3UlG0FTLCREHWt0pZax0fjL2AF8PdCOLdB4?=
 =?us-ascii?Q?kFz6W1aYGAx3K/Mk6Ox7vtO/gQjB9ozXm+xVdb2fxRZT2JtVuqrwzbhov18U?=
 =?us-ascii?Q?qa4qM5QjFky0HftetQOC0r4V5XDuiOdPvYVsCO4LQXnw8PG3FOg/1mjXnutv?=
 =?us-ascii?Q?GF0nf67+5MFpmGx4EoWfP/riSeWaEpC6jzsSFrr6jrcrEWeC6xdiIH7Ro+yf?=
 =?us-ascii?Q?D55VKjUZN/AV9XwTj0H5Hj5xJln+XKz0w9nZxeWQoj83CvhFeU3cW25BYR7E?=
 =?us-ascii?Q?uI2JhvCe0RIcIkAFR/vHA3gxkntMRqE5C3lReGq6wjgJN/ygLaNqmeEe7qgY?=
 =?us-ascii?Q?JjltlUe3d0Tq4iYwUNWBLWmQJDsFYGUIB3tDJPb53q6MtllG7cEMLhH2vcbC?=
 =?us-ascii?Q?1r7r1xF7fgHAwzg8958aDMb/2moZ85nS0uYUyi14vOWWfd+gjtcAXQCdtihA?=
 =?us-ascii?Q?1mOEzIybHdgvsvfQxmsGKOMqapXg79zdmjMLT5hLax5M1dwzO35FNQnqCNZ9?=
 =?us-ascii?Q?euwbxU1U7ssXBfL/oFu2JVlJyqLQNBZJwa/mjT2mDc+GF/tvfhYT5XmEscxu?=
 =?us-ascii?Q?x8PI3L5C3jEuWSKDAH1v1KgoLilJonyY4Wb4tfEOqVKOw8mBD4nkmyDkSF6s?=
 =?us-ascii?Q?FJBJq/VtGU/4zxudRhGNpyV7eK9O6yuxbuElKtXe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5381ead5-5374-4cf7-7273-08db5eb1b9e1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 12:56:02.5258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcF0Wt7zj/ZDzDdlrxWVGVJIKUYbs+o+YZxZEiNjxe3KbKAOG3hgRAohabTz4oGPEw+7AP5DcY1PFXdv6EJn5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8371

Use msk->data instead of the local variable data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index fb0a5004980f..414b646dc9b1 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -122,7 +122,6 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -152,15 +151,14 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = false;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	msk->data->reinject = false;
+	msk->sched->data_init(msk, msk->data);
+	return msk->sched->get_subflow(msk, msk->data);
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -183,7 +181,7 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = true;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	msk->data->reinject = true;
+	msk->sched->data_init(msk, msk->data);
+	return msk->sched->get_subflow(msk, msk->data);
 }
-- 
2.35.3

