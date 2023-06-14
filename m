Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2087.outbound.protection.outlook.com [40.107.105.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EDA38E
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1udzlQV06m28NRh7s/Bqv/bOeLw95TN7Q3vi6sU1Huo/R0VTw6sUyf7inxR7nrXyE9+GHAUQv5VpgjMEVQZzgEf9HNXQsSXrQ1IHRfsLvTNREOtoVUZA2ADuqjBOrfHeIp3eSDh4PnnboVEt5i4E+gbTx+8lwm0NiafOwG8KleN+u8u0jQtiRU++La+ODxwdLlWB1ENCqE3HrWaYU7c20HtFcThRIjJBOmWmptdyZOQ2Uh+HD3V9ewtT5K61z/l5fNI0u1flhhuogR8aE+9ldqmf/JMU+e4bbMVLLkkUADoYRSPCReAJLp71pXgZQPi9+2qYgl5k7ZmxjWnEKGc0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ColUWx+jPDzcN0Yy+5AQqn4KnR0IgWRnIS+IXJMrq6M=;
 b=PuZLeXdU64vZvkFgldl+hNkKCcDI7Oi0zfgjZ/ZEyAcvy/+uPq9q6TrjmtZIg+Ey4WYJ2DW+oaAXJLLsCF2B7vt7lUvI3JgNrp0aWh4jjACLkoQ2R1eo4AnYZJ9aTvQTc1/RGhbwPX8eoMZ83AqScetnw/xQOVMlaRoGiMe8xOlYd0XC4Rn9JKHI6zhQCfw/DdjBbMEETyg98dj5W8T97yayPj6XoUJKuW5YFhDU5Gv6zUgrF7DQKbnzfPRiOGxGKLCmyaJI9d0mRABebzRW6yKisdVgsOsscjfql9vAOFiAMY8S1OTNxxkLridBScB/Vc/7oq+nxYV7W9cxLZqZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ColUWx+jPDzcN0Yy+5AQqn4KnR0IgWRnIS+IXJMrq6M=;
 b=uCqoSLmliNU/Hztfu2k47fMyEfpwB4RaLGuMJWZIyXUF8+8TP2QbjyY2t0Qz70+Ftg11IZSF61mJ6ZB32s/t6tjWU9BZ2dfvoIXnw2v5ZwCHoqJKss0v8ckCJShdlf1b+Alm0snp/eVVp9bvxwy+NE2kfijJy+nH8jvEZK5e2L4VkRTiE91EcgOEr1vFHXKPyoKy5gbwiMRYYHazRntWD5EWnkl54Rr6oHqkgBPu1rWUHpZLWPJo9pbf8wVlSYGu9g/oJkfZdbsD7vqb87umXkUwwLXXJblYFKF1aCpqqAkYehhQj/JBMmuN25BPfu1NcJeTCz5FMikOKasb/8yHSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 02:22:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:22:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 09/23] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Wed, 14 Jun 2023 10:20:56 +0800
Message-Id: <e0e50438f701bfbbc8711371f742536d28293629.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0091.jpnprd01.prod.outlook.com
 (2603:1096:405:3::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e83cec-adf1-4fe7-6499-08db6c7e43d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BORdNb8m4krWbTjz4n1h/oaF/WPe3Z5uL1RG1OO56POnfXLvDIpOoUNyF2zM9vHaljcoVrZnNAcCqE8L/UCrpSMsv0SaQ2gW+jecsCIHlVKFUMuP8sHU/PW6ZJg//rJBhWIEkctaMK/PJO79oaSCos0Q9KnXZJEPInPSo32U7Qh0Yci6S8FUWRs1g0jCG7MXvVCIkHew1Lb5ugcPYh5hWh4avDMDb8eS3doWY/a5y2HTzxes90ihC78LmpvqetOl7ziyMUBf3dCcHHe4kYr4tnRbUL7j0Mi01YCZ/IMAOegHKL1sEjoMj3I9bZd/ovp4/7cHMfcuakh1DGMZ5iBHpZixn7f1DDTEsdE4cGb1VFi31Kq6NAZAwhYKvPtMgjeruhCPhw6WkpeLZQ+GvRWasLBVZDhg7gZ+saNHmNRmxmSTDqWgql6ZSSS9KYjZ0XeflUTomvYzcXyJJHqFH1bFhutx/Ol/OuwciYvQ1cZXWMGahXNWUMj59tklRnoZNH0FOy3zzxhdoKi+YmiGf/NpwhzED3shfwC+4RBcnmOi12y2IQwawaAAnEiq76fqS1fJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(6916009)(66946007)(4326008)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(66476007)(8676002)(316002)(41300700001)(107886003)(86362001)(6486002)(6506007)(8936002)(44832011)(83380400001)(26005)(5660300002)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Od7+5apn44A3u7yBT28yh6fHzy7thbzKCrRZkpKUfkYzNhuG79VD7C8X6c0X?=
 =?us-ascii?Q?sYullmolCza3PSlKbskrw/HDogQLI/3ymBZmlDrQd5wlZx+Uy4uTpIh3eOJD?=
 =?us-ascii?Q?onqoLp2no8pjQ50uDVuAMB7/5duYMvajzdrPAKRYw030mMgsRbm4O4FOe5++?=
 =?us-ascii?Q?ufZWGs/OCPw3cXHn7AFH7TXUc378xv/Z/84fYrXwKxXZI+Isx+AyLpw/hBkk?=
 =?us-ascii?Q?w4VyNlvUcgMvAMu1Y18QmHj6FBuUsfvKWlLsHFLnHccU8ZCOC4OeCxp0G8OP?=
 =?us-ascii?Q?ObrriNDj0edN5A+kmWM3xq7clNj21+5Ip2ZuYAedmMr1h4slohYfyrB2W65w?=
 =?us-ascii?Q?J0OSnBXc8Ks4hMFUC5fb+1nWvzc3Yi9EctrFntmmTMyY4YtuDJiSDAQEm7ke?=
 =?us-ascii?Q?md3OvvVWWSmvYMFoKn+2t7J9o8sY5s46RKBxERuz7UxVci+dtOqZvmXyzeoE?=
 =?us-ascii?Q?WC14pPxfp9edJ1IutbsX/oyfL4G42aUOMtraC7ysyT8vdfT0EUN8b9hVe9ep?=
 =?us-ascii?Q?Wu6ckY4kRzil2CA8HBuRMtr4+le+kPrtc5VVgrsb50ifRVblG/L7HEZitn82?=
 =?us-ascii?Q?CnmJLKpRSgSdlLZGvWkWZy/r0ZPSZ9tP08hnY8nkWrUQgOrAuF+cW/i1ysrE?=
 =?us-ascii?Q?c0yMNrE6QRgl7P0qKybsqjMPfuEqGYAXYA+KmdS4I7WnTAVSrNE0C3WoI3qk?=
 =?us-ascii?Q?r0pbJZCHzJo3wkq3N54psUBbBdRu7DuRkoysUkNbBJcu8VIDXfsiTn9TMWX5?=
 =?us-ascii?Q?ZM58VZdM3E2zfNIgau41NSICM5ETA3qWLDSLEIJpHk9bxhTynt5TlhV4rZtD?=
 =?us-ascii?Q?rnmHMpYZP7CGPZhNCof1qjJVpwGKu8W1SrKK6kUEv+rvmiFb4KIrt0btXiaF?=
 =?us-ascii?Q?rlPOiARyEdpKFHe5kgur3jedDUBlfFE8CZOhCVHJlrXewM6wdzypCv292Zfi?=
 =?us-ascii?Q?GWzYuIYoDntr83mCmYqmQtWNnx27dusWWQH8WSIUFvYX6FH6XSBJMtiByLiN?=
 =?us-ascii?Q?k/amMgE6DVBi02V7x+lNJxk4RfXsQ+lBICGCWnGChn8323FMUyaTH7y1EGx7?=
 =?us-ascii?Q?WA1bo45CXV/yL2SNTDVXy7rs5pOJ7RgnsyM5s3T0I95CTeLIdMWg+NAzZbbF?=
 =?us-ascii?Q?YJ5UI9FISwDDTS8+88G6d3H/ZMZBbDo8ZIB6mYdQyZTqYGA/tVreq1ITt+4J?=
 =?us-ascii?Q?D3kMo8gJNA8/KurORCppOHtuYRglBz7tQ0co3XU+gfCrsIIdObD8pYVupPGT?=
 =?us-ascii?Q?arcVYBZ4CN7Ixet+yoB4SmT3DLZMfuy6+X01CNwC5q+Ac0OINhQUlWV7WWO8?=
 =?us-ascii?Q?9xdLjcJ6pLkk/r2+nJ7L7XMSqBvMTjloXXVpWzQTukhTMv9IeTsycLy3tMiV?=
 =?us-ascii?Q?WlkxXZGAIWN2LThJ1N9yV+Nr3aEPbDsVQXKiwoHtktSrzvPudybYXarJYHE+?=
 =?us-ascii?Q?i4QTo2XifOXfRsmfgCTRFE0Xpfzx1YaBs/F1HMyMR63IaHOBbd0NfbdgnxAU?=
 =?us-ascii?Q?5hklGA5Feg0ZA9DJP5Z4ax8meTPEPmOOtg07FZTqGynaPzuinmdCdzHsA+yP?=
 =?us-ascii?Q?I0Ds8rzd9tpd5AJ+0tPS1C4VGNz5Lk4EWKUy0D6r?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e83cec-adf1-4fe7-6499-08db6c7e43d5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:22:56.4994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lmP/8hOCAtLIrNL2Zm/WV83v51fUM5OPvTxTiay5Ubr8sn983LUOswZX0gaBi7uBxUTc6IQoQYKaYVjF/O5wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956

Add struct mptcp_sched_data write access.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index dd1208670c54..e2ed4223617a 100644
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
 
@@ -50,14 +51,18 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct mptcp_subflow_context, scheduled):
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
+	case offsetof(struct mptcp_sched_data, last_snd):
+		end = offsetofend(struct mptcp_sched_data, last_snd);
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
 
@@ -141,8 +146,15 @@ static int bpf_mptcp_sched_init(struct btf *btf)
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

