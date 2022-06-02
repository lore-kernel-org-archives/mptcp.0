Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB57622
	for <mptcp@lists.linux.dev>; Thu,  2 Jun 2022 04:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654145679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1TNz5XrAYer2wVWiFk4p9JFI2aNd2gsCqBz1hkDNgtk=;
	b=V6+4LxipA2qbc8iOTDqtd/XrAbm+ZfOz/HL65ngAbMQiF1B89XBn92XEAmgn/RgniI5u0B
	U3iMx+2P/ZkXWJs7LqZ2Jg35pBBgROZ4Ar5uIg3nhNpBPnTcMM1Hq3TqlWJP6FO4LsFC83
	eVsMYaARu9Z0FjupvZtephqCS0JZK4Y=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2052.outbound.protection.outlook.com [104.47.5.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-afGkq274OSm7RES9daB_5A-1; Thu, 02 Jun 2022 06:54:38 +0200
X-MC-Unique: afGkq274OSm7RES9daB_5A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anfhJcdGqZy4P99QrPdCjShmK3rw0rhlphVllvV9lZnPthHNQwODRU86byFbfn/mdVf43cy9qsDx7limggVHBbTUQZiSKL1cDJrNjCkRFDjMJeUdxaeIUA3k8guoQRodn1AVbQ3iaB+yBCyODyoUJy7h8sh515qhBQpPU9jKbkpShKwgaaX6CexSEwmxDUAuIAzd5ho6Aow8hsIa2hvT8RFCzUnJO0hUsjq2vuuNUjoPa1u7DJAeVUURwh7eSe8xADVTswyMxuPgsDJIvQBGIC4z4ye+BpFeXM0sGtHSgPMr7a0yBJYVU93ykmlvfuz3JZYjfQPNAVMputJodWzvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TOnliMdXhZqbAfXt/L3KfXwisRsg3qqsSe4texwxIQ=;
 b=CwJMgjj8k6IzdfFHJw5XY4nwZnL5teaW/yDV1dVsB/9qWHXwZzJneNtyBf5a/DEmMvwOhFXQ+ogXsbNzmK0JbHP3hjUT7+rK7gmOuXK50Lhx9yJ0FFyaSu/Xy6dCI1FXCepCArzB7wpUURf2xKd1B/bIwgnw3n0iMZ7hAEFc5sDNBISa+o66ABdSePSj7PF0A8X0gIHN7nI5R+mTtI+cVYS4iRGB53XLg9P36EGTGVwRLHJsCZTvd90QfAw3qjra3XuSE/uphmzn+WbqJegGZ88TghLtaz9H+LCwTDN7RxqOivHC8dLYTHRpQxZmc/1cNWJsAm0yNR93ns6Ebf5U+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3384.eurprd04.prod.outlook.com (2603:10a6:209:6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 04:54:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 04:54:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 06/13] bpf: Add bpf_mptcp_sched_kfunc_set
Date: Thu,  2 Jun 2022 12:53:43 +0800
Message-ID: <d246b0ca7372421c3bf31cffdf4151b2b6cc5dcc.1654143895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654143895.git.geliang.tang@suse.com>
References: <cover.1654143895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:202:2e::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52d90954-460c-43a1-4539-08da4453fec6
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3384:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB3384829F72567B4494BB8280F8DE9@AM6PR0402MB3384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ycCI4sTp8iMA9Ysc4VwS9WaUeer9XgljhnAYLrnuqIt2pLVmFSiiHLuB7d9y/zubElhu9qstltXhbCP7vkuPY8FQ3VSPkdxZuSY8iwjSd52bkiJTNxcyNPq31pvEjonFXdqcVyKXySIcR4FD5O/nCNP1ayyN/cPRcuo0EOgzBKad6lixWzp5QkqxY5zEWz1w/NWHsXbLx7r1D0F9ta1cTHZeubvKwbhPnmNoFH34u8ePw88GCTHGOfcbSpaRXzWpDLejAqKoYLIztY6JJGuszJiRKhG8o9Ii9Ymm4qW3wI4cvlMIJr3qZkO3qA3h5ts1DU0ptu/LK895iFHLRGFZbknHwadIbf17sORtIhP2Cdjh6uJhWo7MMIsRNt9w89Dy1z39uIkedSVbwnSwzSgQrX/3qRiASy29KHOuYbHWikyCnlh4q3ZoSXjgUyxQW0JmR1LSZXiJoAt0bDmNNTSnskdRBJAG96M/g7LKvrkZv58xU5oUsKDtKqTJ7heoM8YYxbjKQbxCKePXnAThfBQG29GUpLrnXzixG8a72kbFrLoJfRpRs5FCdKNH5R2dA78qSNMeVC2Dl5mUs3u9ECtvbBwB2LyrtCmZY2N0JHnVov1azG5K9ZwhcLLpGjcjTy3r0ZGPFHoeFWF/QFrFL9xjk2B6XTs+RtxflO9bG0pqGLU/P2bfETL4PGiOZDy2kMsOCo/8++/oSRuMzkwI7ZbNRw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(86362001)(83380400001)(6666004)(8936002)(36756003)(186003)(4326008)(2616005)(5660300002)(2906002)(107886003)(38100700002)(26005)(316002)(66556008)(66476007)(508600001)(66946007)(8676002)(6512007)(6486002)(6916009)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AoYWxn4RZ3/NccnRtzLFH5mBV7cT76ttqD65WqzvcgnKWFJ7m9/AEv8nfApW?=
 =?us-ascii?Q?V5F8R3wq+Tja9U6B8Yk74Xrnq2xh3qh1HVHp8F5UtlyzRc6+90pg0k0Wt/Jq?=
 =?us-ascii?Q?96rj6rhWNzEIjJf42cNYKHFq1X8qbAWOkYlC1r9xZbFzGKxW7zTiHFvbml6R?=
 =?us-ascii?Q?QfgAKEHupDCpEiwOluSY0WOQcFkIEZzv7oWTp+RkrzUM43CVOsa0/MQvqWNs?=
 =?us-ascii?Q?nWLc+G3echoxPMvzvSddk9D1wwoYTns+0iMO0zWJmkGhJSWUY7S1wCAtIR29?=
 =?us-ascii?Q?sQFHXY52GNRVZ+fHjn+ogxk3uZu525FDa1+KgLHvT+J3mlGe+lGASbyWsWNQ?=
 =?us-ascii?Q?XLV+yI1umtldlJPytsNhN4xjGEOtH6m7EL/IPbi8jUiZL7+IwvxG4bqQiENw?=
 =?us-ascii?Q?Z2ZxP0J3vtbenwFCCNs7P7DU6dMhDoSUTWUVPWQpzHviwZXI4plCTB836v7D?=
 =?us-ascii?Q?SCRG8TZEqL95G+ei5qp5a0K/Jx817kbWQ5GhmtwVQZI6brO+BhjoXylSm2Co?=
 =?us-ascii?Q?iMXqxbp/Ly0FPSUXfybv6jb7TsVXa+mxm0NQKk+XI5+CmHZiHNDyRHMkQj9L?=
 =?us-ascii?Q?6Q4LxG9Nwkvgsu+yudfR35lh+aTB8KSWpuKSj2NnzXggNlFWnGW8j40ra5Ar?=
 =?us-ascii?Q?CtD8bI9GKLv//wcSLjynbBFY5MtG+J+M/nriaYJl5K1Oy8Lngrim8cU6woSY?=
 =?us-ascii?Q?lI6dvCNPGfJD/6wKBPhi8fmjUA9gcuL1+pb51zh09/57mzFW+OnBt3T/lqF4?=
 =?us-ascii?Q?onX5YmiJHHdkeZEksFn5h/C9rOOli0YHxB/BUOGCdFT4LRvfwJf3ZXpESJl1?=
 =?us-ascii?Q?6wXLptIHKpUD8+phoqx6UzwWvVEbCVwxCIrgEfEZpX0m/tQJpp+F6Sw8HBlx?=
 =?us-ascii?Q?ZTrBGmGpQTJ6jGM9pYe7ucd+Gp9lOi0w48zd89Ba1M5Wu2oSgf2ju5LSYJH6?=
 =?us-ascii?Q?T+wJrMULgeQlVmmrhvrCw6sFSSk16WElTadmL8op6JiBTHJJvPUvEJIaVADx?=
 =?us-ascii?Q?Ii05cgTHY9NEWQgKMtLFzFn4/yuotRXkF18dASwDUzYXiX1SRXyQyt6hSs9L?=
 =?us-ascii?Q?xsfYaINklfJuiwEDWyHnmv2fuvrKANOV31MbQgZz1UxA01YVyrwwPZFz31wg?=
 =?us-ascii?Q?Jz2zNvzMymrN5s700kqTftqn0rbYQCdEiK6ahAexRGBf73lqRJEA+O3s5o6I?=
 =?us-ascii?Q?XMJloSFTtoWk7uBF+s8uiEthtBci1d39NFweKXZnvcalLuB/jtDYG84qeO5V?=
 =?us-ascii?Q?Ti+rmFZ2lIxGVnqVtBPyt91BenSMdJcgqQTaJeU/VyZPiHyTdf7EQhy6FYTC?=
 =?us-ascii?Q?W663pcoWMe8jr4o4YFzD/hhB/zvfb8OSlyruvUIeNh59UCXIT/CcnmEt1Cwa?=
 =?us-ascii?Q?L0IvX1lj8jCZy8sFooDSRb740NQG3ZmCSMs+SwVGatFFHNrK+i2OQtFP1t4c?=
 =?us-ascii?Q?SdvP1j+Lcf/VXBaS8QEmwJpIfKanZ2GgzfinBLM2hUuhmSFxouMUgo1sr2g7?=
 =?us-ascii?Q?pqB7YR9GqV3Sjiag1hPsgc6RQ7Yw0py+GcNnOuU9eGe0pbBiNThIaw2G7N+S?=
 =?us-ascii?Q?FQDXGxIKO5Ntl5afn9HNMRkpqw1kxlqDgUJ1lal88oIfXjawIsO4n2ZHzlpw?=
 =?us-ascii?Q?r4R51EarTZ27vwEbS/8SKoYxSxtsJQyU4nJAFbMWbi4omcLCL7IEcXDudQvR?=
 =?us-ascii?Q?sgtdIqJ9C2BN2aVrTs9uJS27WimqzP+7NN3OaJFplJQkUs6Nf0yygLX2LRMN?=
 =?us-ascii?Q?1wlQnQnmpk/8DwcqQ2QuNwhemVObx0Y=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d90954-460c-43a1-4539-08da4453fec6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 04:54:37.6539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+uIUSiMTloVrwVlZesMR9x/QKgldKtXYTYg9+ugXVqsF7JKi/XImOPTvx1+IsV+zr6tqkx2qcMrJ7MQWOTa+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3384

This patch adds a new struct btf_kfunc_id_set for MPTCP scheduler. Add
mptcp_subflow_set_scheduled() helper into this id_set, and register it
in bpf_mptcp_sched_kfunc_init() to make sure this helper can be accessed
from the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 0529e70d53b1..e86dff4272d5 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -161,6 +161,22 @@ struct bpf_struct_ops bpf_mptcp_sched_ops =3D {
 	.init		=3D bpf_mptcp_sched_init,
 	.name		=3D "mptcp_sched_ops",
 };
+
+BTF_SET_START(bpf_mptcp_sched_kfunc_ids)
+BTF_ID(func, mptcp_subflow_set_scheduled)
+BTF_SET_END(bpf_mptcp_sched_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set =3D {
+	.owner		=3D THIS_MODULE,
+	.check_set	=3D &bpf_mptcp_sched_kfunc_ids,
+};
+
+static int __init bpf_mptcp_sched_kfunc_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					 &bpf_mptcp_sched_kfunc_set);
+}
+late_initcall(bpf_mptcp_sched_kfunc_init);
 #endif /* CONFIG_BPF_JIT */
=20
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
--=20
2.34.1

