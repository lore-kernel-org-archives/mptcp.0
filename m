Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B39A28F3
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 12:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652270968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvePz4sP6OgQZXv/Fqrzq+QjuVFjSTwhDtDRdjXpjec=;
	b=LJk4wGoqVz+gfQaM+RwZa40xpcei9K5BVieH6fEKSj7vlNCVHYdvVGnFYKpNHk3FuTcbMG
	cBYzqwh5i+6kSTodJw/wjddxMSHPTNtk0lyQpK6UpvalIhaSUsdiYLopaXpDx2P3trS0zH
	YHBH10DbHVMeFoTJAP0a178JaolkYCY=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-14-_IB9GkG9P5y1Hpp89Tp9zQ-1; Wed, 11 May 2022 14:09:27 +0200
X-MC-Unique: _IB9GkG9P5y1Hpp89Tp9zQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A52+1I+Q9S4lUcfagbrGBKmGZrN7Spazrw697sCp81V6ZsxARWxTydDERbuGpXHgGm6FowhsRTPEpivcR4UNhxIw6LbNHTOaHeBy6JYIFU340tAh/mBVGdhEfmjk35cwvwLOHXcBlqJ4S+oLFSIeyDdk4GSkYHquwlsUmL30XTiwCiMRQIzKY7HhmylZ28R2e4H3sx0DWVefc5zAv4K8X8MHM82/f+ngTevgH+laAHLzWtGXUelwY3rO7YBybn7BVImZ+VG2dTSRgaKaZWiwfykymcserJCSaftsNKLoU2qe0n7Zv1UHrqGM/7Tp99F3nnKJeBPCKKFdjXPtbKB3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaJpMJOawNcbX1Dh/jYRbr7xHUYID+jM6v1JJHF468o=;
 b=hKqm+oV5+6Tofzr+fDDhxlEwKlgbuYpNC0wLUqdU0Tta8wLeyVp6d5iqQd5scJC6RBVWn9n/7dVnXzn9Ty/zHv3LoY5cTZqDY5jidX40FwVvf62E6QS6ApFrt31CHyfr5DC26VSxt7NVv//EeNl1FN5XgmFBJagKGJOSAiDzL+7/JHSUo6s3XE5dOq1AFqE7weznY/D+njB4ivvqiPFX2d+aU3Xu7PWq46UXLeSiD8kLKzSqcft0Bx99m9h+FpaOaTGl5K13vtotFlPwSEjXvRHUd0vEsXQfMRNxHDt9QPpJtvge7MkP5yjZIQH1gMCfahVTiIBBWiBOyGgX7nE5Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5716.eurprd04.prod.outlook.com (2603:10a6:208:128::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 12:09:26 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 12:09:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 1/3] mptcp: add subflows array in sched data
Date: Wed, 11 May 2022 20:09:07 +0800
Message-ID: <bddbe2b652c3be50dc35c34d1d2425f233f4482d.1652270663.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652270663.git.geliang.tang@suse.com>
References: <cover.1652270663.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0228.apcprd06.prod.outlook.com
 (2603:1096:4:68::36) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4af94686-0001-43a9-a0f3-08da33471787
X-MS-TrafficTypeDiagnostic: AM0PR04MB5716:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB571602D1D082F86C11FC1C7FF8C89@AM0PR04MB5716.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	diuHDCYUdj/LSRC/laZet8hq3DF3izY1kW3NWezgh3CF/Dib7cyOqFi9KjLeJEOCUHy0kZ0LSXb5pSRpjmnKI/YR5Lf1AcBLGW2a9KJlH6ftDn9sX9pFuNnGWeD4tnEcB59vWy3p1iCq72aqMeOnODHwV1qwznhLTfP2fM5tbFjBWJlmY6UmgmgzIrXxL/ff74uAO5LZF8yUQJZdSg6R9wxI4fb9BtKfSvJep2padVlt8Nhdl8m4u7oUpdOzSh7tdaqyg7XzguPc/ddhWUAkPij24DV8FqRy1vCJKA5b5pKGOryDUCJXfeQzl5jKYJbCpPLAqkARh4PeXVfKjOZxcLDif+D5P+HVgljxgRKbf4UO0Jsk63NgytNb9CFtrM4JOF/fPuK3t4LvG0hD36G1rBl7GcIOn/9HcUDbDvSPNQ4Mj9bayp5hu6fpQpY3QTZ1wxcQ9xNi5ASUnzxNg8mS4X9OguYHQJYtYg/laUG8+wfqUE9Hf/a3HstGPPygHFjjL+u30DQ+4yghqxggksCe6GyUeurdsuHteX7tVpu3fwd//dfow+uVJ/mgQWyiZp9oNHMY+KxYOQOP3skeD+yWVdqsJ2pwrxomKpwwXNIMv9J7HWGqhUszyIPacZnPHOsyTtO5giRmqYUSZRXkMbXA35AyvxItpdqDC31otXid29kGoPCRtzGtNP2U+H1/Mi7SHLNHm3O8KvEfvwNnv52nrQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(8676002)(6512007)(6916009)(316002)(66476007)(4326008)(38100700002)(66946007)(26005)(83380400001)(5660300002)(6666004)(186003)(6506007)(2906002)(508600001)(107886003)(2616005)(6486002)(44832011)(36756003)(86362001)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g4cBHQT7z3Vr7GOgNatBYdq+uWKJAVL2YHcu+uAWAPP1jMmwe+Wuak/85M5y?=
 =?us-ascii?Q?na6q7LCS/wco72/e4aahiHF7W2oUs7Te6syrViHNV9mtF98T293wvRd7kAce?=
 =?us-ascii?Q?WBjDE2kpCPeHiiZaU0qpdMdaq+h9teIvTJxR6ily4nWNk6ZZ5qHIUYuEND21?=
 =?us-ascii?Q?mlV8R2PUb777C1V26uqns/Tau70YbQZ7lQt71YakO3vzYjlSz38CGHMS1Dz2?=
 =?us-ascii?Q?hWVxOwGp83nhMW+pBjW/50gsEck8vPGkshGRUsFHLUqM61jnWqKvpSPvLoP5?=
 =?us-ascii?Q?Qmjxwx/pphFR5sJ/hIQBc5vaTkl2UwBhMWsetFdHrNQ+AQVg0mPeFRL152ED?=
 =?us-ascii?Q?Ckv5VQIsMR6Ge4spLuBgbblZL8X5kDnpGVOxwEKBeUd4rEL9qFubWc0Ke9Wm?=
 =?us-ascii?Q?S7oI5QgxXw26TVe28J41n1vlJY2I6MazT2H+sxw/0nvAIJz6d6JMp9XzxsbF?=
 =?us-ascii?Q?9K3llnMGrSX+dK4qYR65utVjHKXdl/RahxWjFwO1YrBX+q3iSafkLcS93xDk?=
 =?us-ascii?Q?+YggkvktO9l3aVPnZbN+ppsuQQaitetcnNNMyyM4CK2VknMA1EAgpc9gYIBV?=
 =?us-ascii?Q?qpG+4bIPv7T+qPM0wujVLDmbF3XaLcQMEZ9RrGt8mOfVGFLuQN6M8bY4FvL5?=
 =?us-ascii?Q?2lcT3ouT57rRIT8YPOQ2XxA1vGHYmcBpduv8jkcJYu2cTiiWP76KFAr8kxha?=
 =?us-ascii?Q?YQTP7C2xW33y/qgiNMYa+LWhwpbU8tH/igXui42DhZGon+EXY7vL164qRwMa?=
 =?us-ascii?Q?2NVwKFpmkE2yh2hnZ/6bqeFO24BC1xWh2IIArSnyEqNP1IaM5Axuz+dIfRWH?=
 =?us-ascii?Q?L5NLXuUUH0YYu0nzty3oRYjvrD62WnxDhLqg9hzHi5e2Hy/dpShU+hmvM4e0?=
 =?us-ascii?Q?jU7FSTNhg0w3QrYty5X5WWq4a0Amcs6CoVnXDtG9k7FaoFhzwtuIBwMiKbDg?=
 =?us-ascii?Q?MyhSc9vIOnecHyS8bjGkiX7YApYcPZjzlMmDV2Q8Y8iWrSlUSYpv4SslNRyi?=
 =?us-ascii?Q?ys/Y3AEzEn8XGaYP1YkIgAcKmOIMlc9BczgE05ogVP4iJ2nNDGI8oY1VEr/0?=
 =?us-ascii?Q?RsDmU2UddigTPJF2C4/oICaNgfOTBQ9IWxP7vXRygsHwAQnoeXcNXWcPOD8u?=
 =?us-ascii?Q?JjmCnqWkedmIKeNMJwd/hrVu7Kbv2QyRd/g/HRLQg3vzIybIGnfMc/m2g+xh?=
 =?us-ascii?Q?byR1M7FVYZG2ELiPurzCVMy5SOqWsu7bY+rfGHB/LHS2M6kyYI9u5f4kuGrP?=
 =?us-ascii?Q?vDnVJFbH1dZLtsKCF7dDAMgVl5A7U4leK1IIFPpg4fmV9KF5VX9Gt4lI7Hru?=
 =?us-ascii?Q?d9AxVTgO4SHVK3/sGp/xJzRpDJtUvUM/np34rljh7qStYdhBKy+KaUzQXfIQ?=
 =?us-ascii?Q?wHIaU/gF2Y3MxsZQAxyh3xk9S/K88W1cZDPxi+4M1DQBt6rPXqT6qzAWWdGY?=
 =?us-ascii?Q?aMT0/DElUyLc3xULBVywuZbc8h+8BPs+sBEwMIFu3Q+eB+hhh9ujVVi+AsxW?=
 =?us-ascii?Q?d/1e/iV8XtPx9060xhoOzyqXDJcf3KB6F0Cx1T1i53sx27m2mFHhpibjBs+c?=
 =?us-ascii?Q?8wvcmAupMLTGI6v40KYLFWywHuDEougOe/KWQJcf0jJnipM88GzncHhyQN3E?=
 =?us-ascii?Q?oZ5eSq40m5o87Mlw63pQtCY5fY05cuFvtKa/f7vJQM9xfu5Xt78VOkw5vq4l?=
 =?us-ascii?Q?wnbAMkBvj179AoKFIaYJNJKe/QM94RHKZttqIJVR6QF1FsLHrPuF1ArrRbcK?=
 =?us-ascii?Q?vHo6S/7UhNOBnz0NiuOrKu3jke3CXH8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af94686-0001-43a9-a0f3-08da33471787
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 12:09:26.0086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKxMM+vM2H0HOeJ1AWtZXdldY2hcLD2Fzx2lg7g9hCWiSMCnZtQ5VB9rCCx2Owq4UD5WJu727qq6tSKwhDgY5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5716

This patch adds a subflow pointers array in struct mptcp_sched_data. Set
the array before invoking get_subflow(), then get it in get_subflow() in
the BPF contexts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                           |  3 +++
 net/mptcp/sched.c                             | 15 +++++++++++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  8 ++++++++
 3 files changed, 26 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index b596ba7a8494..d48c66de8466 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -96,10 +96,13 @@ struct mptcp_out_options {
 };
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_sched_data {
 	struct sock	*sock;
 	bool		call_again;
+	u8		subflows;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 3ceb721e6489..f86b97292044 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -91,9 +91,24 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 static int mptcp_sched_data_init(struct mptcp_sock *msk,
 				 struct mptcp_sched_data *data)
 {
+	struct mptcp_subflow_context *subflow;
+	int i =3D 0;
+
 	data->sock =3D NULL;
 	data->call_again =3D 0;
=20
+	mptcp_for_each_subflow(msk, subflow) {
+		if (i =3D=3D MPTCP_SUBFLOWS_MAX) {
+			pr_warn_once("too many subflows");
+			break;
+		}
+		data->contexts[i++] =3D subflow;
+	}
+	data->subflows =3D i;
+
+	for (; i < MPTCP_SUBFLOWS_MAX; i++)
+		data->contexts[i++] =3D NULL;
+
 	return 0;
 }
=20
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index e17ce2b856bd..7fa96e3a8318 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -231,10 +231,18 @@ extern __u32 tcp_slow_start(struct tcp_sock *tp, __u3=
2 acked) __ksym;
 extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) _=
_ksym;
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
+
+struct mptcp_subflow_context {
+	__u32	token;
+	struct	sock *tcp_sock;	    /* tcp sk backpointer */
+} __attribute__((preserve_access_index));
=20
 struct mptcp_sched_data {
 	struct sock	*sock;
 	bool		call_again;
+	__u8		subflows;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
--=20
2.34.1

