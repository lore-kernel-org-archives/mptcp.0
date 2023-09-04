Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A47E
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 09:40:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4UmHbvwNT/fc7Xs6EnbAR40nDo6uC4ITyF0Q1sNzl/MwRvriKyciwD2PnPpDpxWdWIddvEHRUIryr24lqECnc0BGT8il9QI07OFaiz/gIsZ/tqzaTYI953BlWjfleP8biQlibyJ4kQPkw9kdBIsOusV+QM+rDZPhtL3pWc9nEDnUk/+tQIbaQj3bD1JICBSpyHb20ZSLJyMfKgyJCGki14fJCuHbJfuhm4bUepuI6vSelXH4ZQ73Fu+YG6mkGaFg1aoEMRbSMTJwRre+eVzmjIKAPrhe8HH3nJFsgHbU9OlZ45g/adIlWl3UwIApOPnS+7cp4YKg6LWl+z4Pg/JJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXCwTe6+YRvW0UnHaqQotfRMpMHy3KjM2V4plXFEg2Y=;
 b=dmlrZHP3smw6Jjy03g2np5xdIDjDQ6Mmpfs37UVXUlW3cPWiM/jChsbYkfAa1wHBBSlpSTBeclMEss/+d3JPhqyC/VN5IkLq9LO8b9EeAj4nEQTh+g/8fa/NusUetmviOrNBuO++K1n4zHjRT7PiWQiPcO1akb3Sy8nFmySj4mjzY5vE1LNUtaeRxWuU+B/15zBmRi0haw8Y1+hW5U1tcrK8xyJ7OyKqPoRSU0pGjjPMN6REkEi+nU+jfm/MAaL/u7kLSJOLxIBv38BBvLvz4XCZdpySXS7FcILqQihyplP0NDM29kbGkOclzX8sW1sOwZKemVTsJ9cA2LJMmp1xlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXCwTe6+YRvW0UnHaqQotfRMpMHy3KjM2V4plXFEg2Y=;
 b=AXZS8CbRHzM9VEPmHBhZhse5n/XZLC+MukLACO5g/LlZ2MG78LZm8Vge1TacnWUoDRc0c1wMB+Z365BG+T0JZjbtZkkZODd0oJvbAQ/8NBXnTEAEw5fmZHMXKCiVjUBx+0aNfMf/ewAXgzDT14M9ljP0G+FxddDxGpikivaro/IRZ8nJfQYVFA77PruTqkvTfANfCNnkdRiU+yFQvUI1BHEYwhDKxeMhwGmb9GHv+9AZXxJmJ6dptMDvvFguHHMT0EE0gXqe8eyGplMVrStwgH/U1VDFJCLOpT32/ZMsXDkQJ2uC3scyWPsZIwxqc9ak0l+duKNKMkFdgv0uLcm4jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM9PR04MB7716.eurprd04.prod.outlook.com (2603:10a6:20b:280::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 09:40:41 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 09:40:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 9/9] Squash to "selftests/bpf: Add bpf_burst scheduler"
Date: Mon,  4 Sep 2023 17:39:28 +0800
Message-Id: <589720832d0408f7d3ff10a33e30b83217cf990a.1693820153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1693820153.git.geliang.tang@suse.com>
References: <cover.1693820153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0286.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::18) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM9PR04MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b884a6-fab2-467b-cf10-08dbad2b00bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iT77OhRQq/vKtjrh75ttXzGHPtE4wGajMSZldPV2wapmLOfLzLeeXYtpiZF/ZUjlC2485P/aluIoh+YKIqKKtErstY2m2HTHZFIRXwu4QzES1snDjyJNPxWRE8NY0N9uaUUp8H0Hx6HNNhjPB9IpQmQ2QZp6Id/J2nwSATS0A+f6DRlsRTSWkJXLa0EsJNsaOzWQvmw5D3WyFKv5q1iDMUoNGXcvuriTH5ZeIvAJKa6CS80NuJiFW23IARuwGjYl6h0t15yt+L8mieJ4GXlW3CBPT3B0aEH/ofC3wHNfJOgLikTB6tN2ArXU7c273W6SeyrqK3OCxBy2Ut417XGFmPhz6C2YKhJVgjzDnPMpc0ApNy0xowL/yri8ufw9ANH+ZjhkXqFimkDIJCJ4slPJkI9T0UkESNWBVmrkxSnWFX3ML46RFGDb5lDVeY7p7Fs0ikiiDOmIdNfEX1KRqZL/ADDR3Sx3PbWkcN12uNyaiuzKGr9t0st6GEoABbp80MXJdTQObmYI0DhwgunCooG4OU+9BT4LaPPdVJcuZpCgtAscNOpxeQ5z0+n7y8oErsZN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(6666004)(6506007)(6486002)(478600001)(38100700002)(83380400001)(2616005)(107886003)(6512007)(36756003)(2906002)(66556008)(316002)(66476007)(6916009)(86362001)(8936002)(66946007)(5660300002)(44832011)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i7MuRU/iJkZ0vGmuHfpkY6qdwkCt3QiuFq6tBuRQYtFv0IYOt0ej8AI06nLk?=
 =?us-ascii?Q?zVA/UrJYTYRd764r6sVKnhQnRDDgmrjgKRwMVgFOE2Z4tT7xULyYEqwuaCll?=
 =?us-ascii?Q?OLqBDQBTkkROJxmnouA1lpCLbmCi61i09Ww98fE4vQX27vJ7J1Hmfhlzgt2M?=
 =?us-ascii?Q?+HFwTyEUPk5FJjz3Lacfi5mtN+Tl4rURfwc2DgPp7gpZRI6VO61vfMLx5FPJ?=
 =?us-ascii?Q?e5Sg6WaSrrTtjkg4DG/tP7wTBGRbFx3CGwil577gjQB54tPBzooA13fAM7ds?=
 =?us-ascii?Q?D2lBbm508s2jdDJ698ThW2v3VZD4ZVIe9Q2m7kp7sZ2vJsrGydjiTaAYGKUz?=
 =?us-ascii?Q?6fuYNdw/5Xkeo1NwDpGHDSZT9UI7pFEiC/S3tlW3ybzjqeZCYuyClhibYzDf?=
 =?us-ascii?Q?GyOlsz+VndOZWxwcPUIh6P/lmudhvUKdR9QUPeGCNiVlVLu42w++YYT5Vd0x?=
 =?us-ascii?Q?6om+roMqhllM3DmlNXjFs0dVYbHC2Pg3WTY+FotE+vzlctbYuiNAPtlGoqnO?=
 =?us-ascii?Q?5+U6NqSXAsW15Fdw8Fjnk6J4ICFNNbnt8J6eMHDxKYh68DshepqGWXUbRMKb?=
 =?us-ascii?Q?C1pOaiYVH1RdyZp7mUTTxnrnVdUP0Gjd9cLz9WzFLnhr+duL8D3LDIa2QMSs?=
 =?us-ascii?Q?FlNY9k/4S8MOGlLIBQcirI6qiiTAKAtOkdmz26aZkDGfclUzRqW6cJljXfXE?=
 =?us-ascii?Q?gVwU0GyH/hgvgzeA/XPwFLGaY271yIJs10CbBsdBsWfOS5snpM5u/yHU/6++?=
 =?us-ascii?Q?+TD5fHduOgcf1HIWIDLAjpDVoYveKUcm5rO1dMoY+a6ZfJGQ2Nq8NuUfZRS3?=
 =?us-ascii?Q?+SvuYpvN2XGtVejy3boiMcCdE6ZEvUfhyacs2VYVl2v3DvcxCzhwgYccHhIU?=
 =?us-ascii?Q?2+gTNkLPznQK2am0O1LtvHwGJDWZAM8wE6JDVZBhVN4/rDwJpdd83at1IWma?=
 =?us-ascii?Q?5P2F2oytBZCY0UagOEXkfRBjQZZY0L0Abu5zu7U7bihjqcb9Z9M7XZHDeWyN?=
 =?us-ascii?Q?YsiLavhR01lLz9UZvYciB9zgWn+ayU+WMoxfJe5fO9C15t2zBXddAp80C4W0?=
 =?us-ascii?Q?eS/q+1bry6nkEKwPkyIyHpwDcjn5Iccn0Pbd41KYunnzFbpCSb2CjQj3vC+C?=
 =?us-ascii?Q?zvKBN2NhiakrcTTjdDdgQNKuf+1qOlOMFStdQdZ/OU1YhVhpnd/HZu5OgzwK?=
 =?us-ascii?Q?Pr3BlTGC7vWQ/wNzMT0qEwf0cZ7s4Sj4829ifSqypSoT+UiJ/if0200P3Rkc?=
 =?us-ascii?Q?W49oCnCa+c73+gDrq7wFCY7cwsYh/0e69GqqjUu88ROQUvTVncwpIpca9fuJ?=
 =?us-ascii?Q?sGTsGwtl0pc5dbc6wvwCx6OfuMwxTPEf+2aqN0J387or1uGuc0QQJTyX7vwt?=
 =?us-ascii?Q?iSWd1PG0X6Pl8mPu1jq5WP0KK0bhgCpma0Oozuw0DBWc2ww1+bd9Q8CmXGQb?=
 =?us-ascii?Q?FS3kfA16ODhr/s8h0eVcJTB4rTC6vjWPkkp8ZCoQ5Ljl7XUwveai9vjXvSFz?=
 =?us-ascii?Q?QXsTQlPZBGJXQkLFlVn9Ws6zVVpNYOpllbWiFpWd+n8K4ICg4h4K3s8VvyhY?=
 =?us-ascii?Q?2NJX+4W8V4W4qsy7fC1a5v1VwfPjU+UrV9pIwXSd9nNVsgKlep1UyxbQ2rm7?=
 =?us-ascii?Q?HPTnOlZ36dx7PYeWMIe3dmHHIAKnWTM4jb5Gql9TWZzwrVuD/xD5JJB3sw91?=
 =?us-ascii?Q?VY1JXQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b884a6-fab2-467b-cf10-08dbad2b00bb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 09:40:41.3592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTEMRy5cg2FRHWLjRu6Maq1XfKbDAnFAJ/etRpXhulfISIGXGReTubeEAadfErWtVopnEAEHkn0JcB0Z60XzWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7716

Update mptcp_sched_data_set_contexts and mptcp_subflow_ctx_by_pos.

Store burst in msk->snd_burst instead of in sk_storage.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  1 +
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 30 ++++---------------
 2 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 36a53381a4c0..6b43845f1234 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -262,6 +262,7 @@ struct mptcp_sock {
 	struct inet_connection_sock	sk;
 
 	__u64		snd_nxt;
+	int		snd_burst;
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index b6a8a051741d..b3c811564866 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -7,17 +7,6 @@
 
 char _license[] SEC("license") = "GPL";
 
-struct mptcp_burst_storage {
-	int snd_burst;
-};
-
-struct {
-	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
-	__uint(map_flags, BPF_F_NO_PREALLOC);
-	__type(key, int);
-	__type(value, struct mptcp_burst_storage);
-} mptcp_burst_map SEC(".maps");
-
 #define MPTCP_SEND_BURST_SIZE	65428
 
 struct subflow_send_info {
@@ -69,14 +58,11 @@ static __always_inline bool sk_stream_memory_free(const struct sock *sk)
 SEC("struct_ops/mptcp_sched_burst_init")
 void BPF_PROG(mptcp_sched_burst_init, struct mptcp_sock *msk)
 {
-	bpf_sk_storage_get(&mptcp_burst_map, msk, 0,
-			   BPF_LOCAL_STORAGE_GET_F_CREATE);
 }
 
 SEC("struct_ops/mptcp_sched_burst_release")
 void BPF_PROG(mptcp_sched_burst_release, struct mptcp_sock *msk)
 {
-	bpf_sk_storage_delete(&mptcp_burst_map, msk);
 }
 
 static int bpf_burst_get_send(struct mptcp_sock *msk,
@@ -85,7 +71,6 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_burst_storage *ptr;
 	__u32 pace, burst, wmem;
 	__u64 linger_time;
 	struct sock *ssk;
@@ -98,7 +83,7 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 	}
 
 	for (i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		subflow = mptcp_subflow_ctx_by_pos(data, i);
+		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
 		if (!subflow)
 			break;
 
@@ -127,7 +112,7 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 	if (send_info[SSK_MODE_ACTIVE].subflow_id == MPTCP_SUBFLOWS_MAX)
 		send_info[SSK_MODE_ACTIVE].subflow_id = send_info[SSK_MODE_BACKUP].subflow_id;
 
-	subflow = mptcp_subflow_ctx_by_pos(data, send_info[SSK_MODE_ACTIVE].subflow_id);
+	subflow = bpf_mptcp_subflow_ctx_by_pos(data, send_info[SSK_MODE_ACTIVE].subflow_id);
 	if (!subflow)
 		return -1;
 	ssk = mptcp_subflow_tcp_sock(subflow);
@@ -142,10 +127,7 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 	subflow->avg_pacing_rate = div_u64((__u64)subflow->avg_pacing_rate * wmem +
 					   ssk->sk_pacing_rate * burst,
 					   burst + wmem);
-	ptr = bpf_sk_storage_get(&mptcp_burst_map, msk, 0,
-				 BPF_LOCAL_STORAGE_GET_F_CREATE);
-	if (ptr)
-		ptr->snd_burst = burst;
+	msk->snd_burst = burst;
 
 out:
 	mptcp_subflow_set_scheduled(subflow, true);
@@ -161,7 +143,7 @@ static int bpf_burst_get_retrans(struct mptcp_sock *msk,
 	struct sock *ssk;
 
 	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		subflow = mptcp_subflow_ctx_by_pos(data, i);
+		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
 		if (!subflow)
 			break;
 
@@ -193,7 +175,7 @@ static int bpf_burst_get_retrans(struct mptcp_sock *msk,
 	subflow_id = min_stale_count > 1 ? backup : MPTCP_SUBFLOWS_MAX;
 
 out:
-	subflow = mptcp_subflow_ctx_by_pos(data, subflow_id);
+	subflow = bpf_mptcp_subflow_ctx_by_pos(data, subflow_id);
 	if (!subflow)
 		return -1;
 	mptcp_subflow_set_scheduled(subflow, true);
@@ -203,8 +185,6 @@ static int bpf_burst_get_retrans(struct mptcp_sock *msk,
 int BPF_STRUCT_OPS(bpf_burst_get_subflow, struct mptcp_sock *msk,
 		   struct mptcp_sched_data *data)
 {
-	mptcp_sched_data_set_contexts(msk, data);
-
 	if (data->reinject)
 		return bpf_burst_get_retrans(msk, data);
 	return bpf_burst_get_send(msk, data);
-- 
2.35.3

