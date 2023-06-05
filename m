Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5195680
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 10:05:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrfcYJ0e4WizY+1g6bR6E1wuzfIAAE/J5QYL5aQBSYDDUurvCUMWUmHEQGt6A4XVIZA9dtc5UJdzBGeDnBEyF8MtvLe5XhCb4qQjE3HMdQ8oRUocDe8nKVMsRpQM282/+1Ok3Gu2U/yBscVxj9KnLMjKhRLSuvAjRrZIgDgKOJx5zDr0nxRwvkNNTpKDIgC4MDj37rUR2lR+MX9Ygc1p3q2HpVb7hT44Umw5x/olePVIt6ms5natTBd1j+0rWBlnV5U7SefacdlGKpmUH2QNXcLBIj2nz34Z2LJUfLm+hXMfP8hB4uevPbN1JgjUn2qDCKbJ3SwRlEOZOUggn8HjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITcHLECExE8zuuOUauK6cbgkk8uWQ8J0FoO4BAZGf8o=;
 b=drS5MIR/euqrbnBI4OD5YB8zUU4Ae61E59tJEIdPXjKr/uXGVdJfnXQJ33gBnHeo6HR5VZmeTPa8DBGJcy762eGc+JdeVTOmblfsIcrhkCBe86H6kjaziCeHpMzLqZ7kQTQyg6zOa0KjQkizkvFqfM/4vSDijLKbtKRPtV2kn3ESYs+9UOBQa/xZL8T9xIfwy1BUCkf7B6TUizdc/INvxpKvI/cr04A+aZyB83vBzyRYCuTGDmkryiqERKHt221P4egZ6h7+afzoD4vcJ9M1HSCtJmapZO5THn0seFGVbEag8ZQwwM3Z6Kp1YBpxQ4i4SKlWCwQvJpDJH11VQ7TIBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITcHLECExE8zuuOUauK6cbgkk8uWQ8J0FoO4BAZGf8o=;
 b=jiE2umzaK9t2G5BP1w5b3XnN0oqG4fjUZhZPuALe4LCrKYJhDWUtumUINrjbVYeImTZZTgUvikVQ4jaBwskoQ4KhtpNTzQyFp9iKFfdwoNgZ4zV0JaPzMxFXZA+Kyeqxspw1yoX4+uYRm+oKd2gbR1kOiWoSXdZQsHqqSEiXoM0OeELE9DeYYB7bCFsfl8GDmk/3qN8nAnl6b1msdeaQemk1ykjXXBi6PTa0TGkrx2+KKj/lrHz9YKOXMPNy4VZ5yUzoLdIUQoWkuhDlZSfAJbgV8nmMRYSFNnAeUWUpRyQ9uh+4qEnG2ntInJJnMafdOw9X75lTIwgBzJOZGekbHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8596.eurprd04.prod.outlook.com (2603:10a6:20b:427::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 10:05:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:05:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 09/14] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Mon,  5 Jun 2023 18:04:04 +0800
Message-Id: <be0063d17a1458f27ee298a8e840022a1c579315.1685959315.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685959315.git.geliang.tang@suse.com>
References: <cover.1685959315.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 0415e25c-c9d6-4e81-e5ed-08db65ac67c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9dFchAV9kSCe9qKYLYnj5PYG2ABFCJAWpVBy581y25soR+t348Px/HP2XZk8G4zOOLouzy4Eu+vNLYALRyQqJDg+O4CieIZrSFBz7r0+vx09YhMFrcQyXpE9TB5ESdxl/VjHXHLFhSYGTAB/cQLlRUfFNR81jHPY1fIcrNqj+74F1a1Sk54XC1RBLc63g/WQMLv4aIo5LAuZmRZBqCpjh/JHXUL3E/ID39lpP+gXksumr1okOTSYsW5qjSPMaLvWJlII8MU3hk8Fbz8o87uylGnXR3LzGJgpMyFE5Wx2JSwNWOiWDGHGHFhna4YOi+oVJ9TfMVCmWEY/D7jmbj4O327ADj3QLgEGkxNOiqewmKDXZ/cH7SOXXFmRcvRF9WNGieIIh1VN/QDo7lm/d/oQZbDxnxAIBHbTRI/mboasrPYGq0SICz8+2ZWt0lYSfCdda36x4N6WTYRTub3M0Cnch0emZ4Pt5y9zGJ+470H6oGMZtphSjdh9ZYVyQ/zrOez1BYR5d4ZVvZxkTuCGWxo9eJPjMdYV6ZQzX+P7iiYJegr06j21jJFSVIu2omrglzq8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199021)(107886003)(6506007)(186003)(26005)(6512007)(2616005)(83380400001)(6486002)(36756003)(6666004)(2906002)(8676002)(8936002)(44832011)(478600001)(5660300002)(38100700002)(6916009)(86362001)(4326008)(316002)(41300700001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?73HlQMku1dYiWPsuiXX1oujCGck+I+5UrnuXUZtJ2253p+MwzMP/qKPmQ7SH?=
 =?us-ascii?Q?ZPRbf6HKqC4s2wHMs5g8fOilTLoNp5E0dV7AIUJfvjj/gCQXJPzjFXGHg0r+?=
 =?us-ascii?Q?FE1JM+In1LkIV76ERkigX/PxUxmqY+aJfqmPeubUKwHByhGJgEmLh5Jpbyld?=
 =?us-ascii?Q?VWZR35ozpnYiz/giiIOEEiuA/SN8VWjKom7Tn/nLh+GjGvmDsmDah7LS3rN5?=
 =?us-ascii?Q?mL+h/AejtK3T1m2C6wun0PLZP4pU1DQ4g1CHjDaIVgcOQlsekHMoaEQrrFyQ?=
 =?us-ascii?Q?9dYnYkLkSqemxo5nPAYvuc1La6YRQEyQ9XHqKwz/qygZfZQ86RpSNE+RRSY4?=
 =?us-ascii?Q?8y3dp08GaJmoqAz2ZWseMcC1qWsKl/zPqJm24Gq/7OTrWkbMtmsgNmPh/MXW?=
 =?us-ascii?Q?qr+dBzKzNy5lBaJtlabh612XjtglCwU772ZCWVqUjCvSdboJCFbSeBWmP5ZB?=
 =?us-ascii?Q?9JIUvnKPTLP4Zi3E1R2MFPcaBY++k+Ki7O4k3DXuxiH28vq0VCpMw7gHSlVF?=
 =?us-ascii?Q?V67iZUwFzU1kjIlSUCIUWreLwIy4hLvDiqZ7UGWuNMJQlh6+Lwn36QayT++k?=
 =?us-ascii?Q?J+/goLSIt8CHDkZ7+H4XCru6deWHz+5TBbWDWaT4Fr/sDZq9cDEtaA5EbXy8?=
 =?us-ascii?Q?S2j97/HmC7DR1qiYYZXV5R99Go7SVgHSGcxreRY3CfDOqPGKep8Nx88nNDf9?=
 =?us-ascii?Q?udD6R4x23ePZjS2yQX17czttHDUwXAUayFcfnHY2LYYolIR0YKiQrymA2BLk?=
 =?us-ascii?Q?5hXQoXEXHKi75GqE6+WhTRZjkL59VGFvVtiZG2xOe4bvMLek91y0UaUFJcM0?=
 =?us-ascii?Q?6VsQzNqCc652W8/fBxj+88fJ32a0xGirbSVHVS2aD+mOLCjA1gGEBMQQdekh?=
 =?us-ascii?Q?MlEixlbZalUHVHaK6L8hT4KlNukk/eHqo7Kc7YiGT3GCaTLAE3rN0TkfCZKl?=
 =?us-ascii?Q?OvmLSJqUdlxWe3ZcJ1x+E5QCgUFBFmkpR2xhx1gop6esmX2+nmYomuN7x8jl?=
 =?us-ascii?Q?UWb8uCmk03nuAUUclImvwsvvmxW6pRjzjKHhdryYFX5vGGE9BP0l/ar5Igj5?=
 =?us-ascii?Q?PrHmmBC9KhsY5n3IG+omPoYz2H4HC3lHSQzp6QcmxYN0DjPT/VJbgtXwFRiq?=
 =?us-ascii?Q?h+xoARiGMhkAHdGqRBz0BbII6ud4V/DmInkgES8dWG6i8BvC9MOABy0M3hAg?=
 =?us-ascii?Q?vPixh3vfMz9AXQ3NyBCptohpw2QZw+bIvQ91/RTtgmvKXxbL7tmgo+Vtm5Gz?=
 =?us-ascii?Q?scWHjZi5Ja3jrKGFWlyVA1zGNcnXrPFxsQY4CLeJLKiANDQPTT3VbNSFo9xx?=
 =?us-ascii?Q?uFxatevx+nTwOBaQrLy6Vj783I029vylOKmhPzM+KFXOqWOkFIN9moBEeeTn?=
 =?us-ascii?Q?GHsIGdw1wzVUOBwukp3GSdOxWH5PQ8hx7oE7QVyxziDe2mdWI5kkrFLKGCbw?=
 =?us-ascii?Q?F9dDa1R36JNg7vuVE0I/aqeG7DLCCoQyDpNS4hRpNKGkUKqC6jCUIvV1DbNt?=
 =?us-ascii?Q?rmtUkARz+cXEi+NpvrM6zmmAj0kxFfo0AVV+A1yepnkUwjyQxsNuDYA1qRkm?=
 =?us-ascii?Q?qdtt1oj8ezMgIn9i/pPE5RX2Jsm3wTLZfJL23ZPNOFvIwWRL0htN4vXOLNCW?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0415e25c-c9d6-4e81-e5ed-08db65ac67c4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 10:05:35.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAYzDe26uh9a2p4nA0rkXNE2nbpymZzWPv9FCfl+LxLwMXLSWbMeAAJ7o1M39/V7edY22+3IeEipxQqn+OljHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8596

Add more struct accesses.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 3ec90caa8643..de9e28d69c00 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -18,8 +18,9 @@
 #ifdef CONFIG_BPF_JIT
 extern struct bpf_struct_ops bpf_mptcp_sched_ops;
 extern struct btf *btf_vmlinux;
-static const struct btf_type *mptcp_sched_type __read_mostly;
-static u32 mptcp_sched_id;
+static const struct btf_type *mptcp_context_type __read_mostly;
+static const struct btf_type *mptcp_data_type __read_mostly;
+static u32 mptcp_context_id, mptcp_data_id;
 
 static u32 optional_sched_ops[] = {
 	offsetof(struct mptcp_sched_ops, init),
@@ -41,8 +42,8 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	size_t end;
 
 	t = btf_type_by_id(reg->btf, reg->btf_id);
-	if (t != mptcp_sched_type) {
-		bpf_log(log, "only access to mptcp_subflow_context is supported\n");
+	if (t != mptcp_context_type && t != mptcp_data_type) {
+		bpf_log(log, "only access to subflow_context or sched_data is supported\n");
 		return -EACCES;
 	}
 
@@ -50,14 +51,21 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct mptcp_subflow_context, scheduled):
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
+	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
+		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
+		break;
+	case offsetof(struct mptcp_sched_data, snd_burst):
+		end = offsetofend(struct mptcp_sched_data, snd_burst);
+		break;
 	default:
-		bpf_log(log, "no write support to mptcp_subflow_context at off %d\n", off);
+		bpf_log(log, "no write support to %s at off %d\n",
+			t == mptcp_context_type ? "subflow_context" : "sched_data", off);
 		return -EACCES;
 	}
 
 	if (off + size > end) {
-		bpf_log(log, "access beyond mptcp_subflow_context at off %u size %u ended at %zu",
-			off, size, end);
+		bpf_log(log, "access beyond %s at off %u size %u ended at %zu",
+			t == mptcp_context_type ? "subflow_context" : "sched_data", off, size, end);
 		return -EACCES;
 	}
 
@@ -141,8 +149,15 @@ static int bpf_mptcp_sched_init(struct btf *btf)
 					BTF_KIND_STRUCT);
 	if (type_id < 0)
 		return -EINVAL;
-	mptcp_sched_id = type_id;
-	mptcp_sched_type = btf_type_by_id(btf, mptcp_sched_id);
+	mptcp_context_id = type_id;
+	mptcp_context_type = btf_type_by_id(btf, mptcp_context_id);
+
+	type_id = btf_find_by_name_kind(btf, "mptcp_sched_data",
+					BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	mptcp_data_id = type_id;
+	mptcp_data_type = btf_type_by_id(btf, mptcp_data_id);
 
 	return 0;
 }
-- 
2.35.3

