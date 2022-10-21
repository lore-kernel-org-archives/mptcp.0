Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795667B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:02:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nARlBStGk7Db8nrtsKbvUa9uhplaTBeI0zHloGUHyLBw19AfnHFh9AGAteimZ7/1gIHB2bCYnDMI/9KJt5Ed2ME3zx6NxWDsN93B+9MsQBqDi/RZvxphTPDwDcG7LN6BEQ9qKPg92hAG0CqLyG5f0+qy2ydV3T1RBR4+LqoDr5P+OCb1K+NkSb7+5UveZScNl5TxdXcto3VGni3IOppkyfeqRM80zRnNOR/+Wzh5M+mDcsw+SAj8JYvKEOKgFHi0YHQiK/t4inM72QWCNJwPS5mSAUqBbPFRpyOtT8AArvof+A2EVrUNxZOCA07lPrC5oJUHK3YmdGqgNUCO6dzuig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvT8Qh0I7ISI4Sl0vNv5NvwJblCbHIfRtq4szSiBCfk=;
 b=QgYlPZG2QtPv8rz89TUaCaY4HOEut8cD7dC/ceI7vKwT0WeTyefmc9YJcxV2+mCI6F4i/4rc/x125pZZnzx7F94/nFEzr4BVXF+csXCvOZkv5gKTfoJdzE73Q3FqjdJa1LVTwymKtpVgbTxlPK4BWl0zN4UgzOZZFPNhfWwjRIGLsUvy3PDCA/hEXCWE/DrEnqUbZI2q/KWBARXZwX0WQqRXpKuQ/Ota6g1EPJhcvQUSb9RkdbS6841pKBOAADKA/3eR1BCRL4jUkM36oHpVE84vGAKacXxwJ+116QNDcxgcICymJkcwwqKeN+nUFq21LnhMRVuQN0/l9nYF/NDBTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvT8Qh0I7ISI4Sl0vNv5NvwJblCbHIfRtq4szSiBCfk=;
 b=XMV8Emp1qYcNojH+x5pwlhTHcSe1nYnELEnpJxTeApTa6o/QIB8OCrg+LsZGZdspIkxPJYF5P/+XjGsP7ijQiOjsu3a/3twYcOMMHYlXaPewaHWPcQkvRchb6eod6C0M6r3Ixwh+RrBqexKti+4prRxJfDd4GUCO2VXgARAC2O2BqGCtnhjcYSiwvNIV4TkqQf1NoPJ7ie/yE0CmNFUIKIrDm5DfcDVRMeU4hExqJvUt8mU+34V0VswCgffsykAlZOCaTJJPU+ZWDeZJyNr9fD3TWy0upj6U103gFhhl9GsQuhiAvw+dRNoLitIOmaYpeivlqyxu5Osf7EeOarsY7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM8PR04MB7281.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 11:02:27 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:02:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 11/19] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Fri, 21 Oct 2022 19:00:03 +0800
Message-Id: <c5d6e4e8cbcc07fae3dfc1052b2341337f5a4bfb.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666349129.git.geliang.tang@suse.com>
References: <cover.1666349129.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0145.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::13) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM8PR04MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e6374e-72bf-4cc6-3b4a-08dab353bd83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UPJ7THCKatFCEoWzeUxPaQ18htULu/pA8Xv3QaxmbX2cCpYyKZxz7hTUAY4yojrohsrfvXP00nODtjpsSiyPAsdoMlSn4aBuxYPOJM45z5rjlSealPYWCKKJjENMXUYyANo+N5ArQBJOIhYZ6hN8+XHbruplYMcKFcATe3iVAnGhOhEuQ6JmFxizQOU3SGSHnMYdd56KJBxKvo9ezs6e+lcOxX6BhtOE1VlWM8eubsTryG3mmAUq+nTwOkYDyIi9ZonFFodokrudPdlKArzYko7TIaCmYt3fKXTR+Iv17ua2gHCthMfmK9YCbB88dJvTKn6IkMWLWUomOAGsIxktYGHU6ZtnEACNMDhy4ln+zHTR+I0NcMkJ+NIgB9K2GWZNfLhuDWVobPQQ8QfwRDnbu2XY3L1N6YI3NxlBNsSsa/8y7AImXPHg+IhBggoEGpGYWf043NcT5v7LRUjcfQDrnmHg94nsdkOFZzWWNo/cKtp58JMAx6a2o9SS1hhQnJEIugLmEfJPhynhgclKE5Yo8Jm86T+kOXvr41qniIl3K7W5O+IcCrsrUl/FFaRaVb8IB8lENYdQvx8qz/GEraxFaVNlLuGrKnLb3oGhnywvhCtwjPyKk9mPfvxt8fgVVB8qjj2hSkMfi8dfZPvKuIyg5KG2YNNb72ktu2vgWPoNYryfHyR68VVcqCmo8ZF1KUxEydurbl8nUftCY95ycYyGlxzQvlM3ej2VVoirebHJiy7oeMa4jsCtqxg4pAdy6xMI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(2906002)(186003)(2616005)(6486002)(26005)(478600001)(8676002)(66476007)(66556008)(66946007)(4326008)(6666004)(44832011)(83380400001)(6916009)(38100700002)(8936002)(107886003)(86362001)(36756003)(6506007)(6512007)(41300700001)(316002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1u0I8+J2pm8N0VCcKmobunilczg5EkzFg5fNMZQJXYO4UJjZQ2Fbu7zCNn0X?=
 =?us-ascii?Q?d4RdzHME/ldIGUYewDALzXa80YhW97a8Z/96FZtgm/XsxMQLmg5UlVzPieKg?=
 =?us-ascii?Q?iGIJOTgDswfQw4/C9Oyw56dar42Q2wdDhiklvNCHZcx43+d2Ams0ilh9sZIV?=
 =?us-ascii?Q?1l4g4pnuL/+XK6aQBCReQdTCHxsjjNkAiU4FFZt8U/Pw93R+pv25BeziHFzr?=
 =?us-ascii?Q?iYMgrJtqOnh1IOcd/qV4X2QI7BicWo+u41KEMP9h660YQcuNokc7Gy6pGb88?=
 =?us-ascii?Q?bXo2XRbp/hiyrW7wogv9SvVjf9IFaIGocwjvmUBgfMglWB2lGDkST2UiaIqx?=
 =?us-ascii?Q?MVb2mK+ucXCrYouJbCMSIWF95xuW4LXNfgCYhysPws5v/2xMPdXzX8t5nyGS?=
 =?us-ascii?Q?kqZoSdVrwhS93cUviN06d7rnHKOkEXv1oqZoO6VGLsFtOuJ9h5wrBbV2mlVc?=
 =?us-ascii?Q?wDE0aJws8uGApX8ydfu8Fx2oD7SNA8iwObC43efL+odJHKZ5oJHvXt2X3nC7?=
 =?us-ascii?Q?9pgW+XeBM5RBL08F/v3y2ahQK//H37K7LQM7Da/RKbGXxQ8/BdQVrhk2fr9P?=
 =?us-ascii?Q?56/aV8006G49zUhM4IWxbt6Xrk6x5VE/Vkz2hLreIYGvBhyKCEzX7NwWduD6?=
 =?us-ascii?Q?ApMbRpeEHLZZZSfgxdbAlyzMnhmtrOCbsj9kg3P+P8kPY6c4WRzD/xf7OULC?=
 =?us-ascii?Q?id/0lsIjQGeU5MeSwn5HNKs+cb0akTM3Sxri9hQiMi1W6Wy13kJSZqu7BCPw?=
 =?us-ascii?Q?O8JeRu8hgXcQ7sDsp2miZvu4Ya1saiLdsb7ryrUzV7RIsCGEuDnj2BsxikJ6?=
 =?us-ascii?Q?iyestZfQ4BTaQDpRj2AqYVFMqpU7eDuXYYxReNJ7Ti9ZDrk/3Ak9ajuTPMeW?=
 =?us-ascii?Q?8tGzf//XuLtccXvM6l8tYmtRs0Yw3ljAkictcx38nUvdAbbgb3wayy3aXKUh?=
 =?us-ascii?Q?NXsnzz6dVLgGuSk/SW4m4DzuIvWs3kbL52jcHAd0RNvanKkNyWnZ2CD1O2Cx?=
 =?us-ascii?Q?VqJKl3f/kCgT8xE+FhC09c6+HWxiVUnmNh+tUA+bXWf78E8js0y9HrJdiu0m?=
 =?us-ascii?Q?F5cNoRG90vv0tR3+Lvh5qLwE1zP50oODcT1onXRPLvPZrikC7ZAT8oQPGVrX?=
 =?us-ascii?Q?P/ACQNY4HJ5Tnac84ffNEZalUVKMMe/5WEaCYzZ/tVfCi0VXNmFxRL6pzgim?=
 =?us-ascii?Q?gAY3LS7ChJkb3jtmM3UuMeM1odWwUiomH1SQwV7qCr3hGqikWfb5ZDFUxN3i?=
 =?us-ascii?Q?liqBNpcS0MTaI2yfT8dBfzpoLgvexrgF0TTlhX3huwZBP7IcLGTpI8fRajxv?=
 =?us-ascii?Q?cVBWviu+hykVpIooge7dw7lmqeWHZlAYd6How0yztk3rjDHPUjgGyjx3vPMV?=
 =?us-ascii?Q?5pEdeUYOMwMgZbicoz4hCsUBsZhht10gbVm+Sc87ppanJmMrrrARWyAVwTkj?=
 =?us-ascii?Q?zroD6cNaMi4L34GFTKAmxxk8WO9uj1zBIj8D7sOhVWHp+3ipGoyzJ/hdXlpM?=
 =?us-ascii?Q?QUf1JreoQx0m/66NEokSqgEtcKK5CskFQX+GNpwra9pLDEHkoLTq35eoi0PW?=
 =?us-ascii?Q?owfJ67/ZID3gaoUUKDzamIOFROlOKQuTrzZvlZznxwfjxthgX9VxYOvuYx3h?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e6374e-72bf-4cc6-3b4a-08dab353bd83
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:02:27.0435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRGhhjsoVT2yYFL227XX03Bnz4MfirwdFWtvK6Rd6t8ZaDa/Ay5e7fMUfvTuZUl8gXQH6e3dpNHyFuTGig7VLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7281

Use last_snd instead of msk->last_snd, then last_snd of struct
mptcp_sock could be removed.

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h    |  1 -
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 14 +++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 2a7a613f87e8..01cdf5d9101d 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -264,7 +264,6 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
 
-	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	struct mptcp_sched_ops	*sched;
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index ce4e98f83e43..2da4e89ff2bd 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -16,16 +16,22 @@ void BPF_PROG(mptcp_sched_rr_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_rr_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	int nr = 0;
 
 	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!msk->last_snd || !data->contexts[i])
+		if (!msk->sched->last_snd || !data->contexts[i])
 			break;
 
-		if (data->contexts[i]->tcp_sock == msk->last_snd) {
+		if (data->contexts[i]->tcp_sock == msk->sched->last_snd) {
 			if (i + 1 == MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
 				break;
 
@@ -35,12 +41,14 @@ void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops rr = {
 	.init		= (void *)mptcp_sched_rr_init,
 	.release	= (void *)mptcp_sched_rr_release,
+	.data_init	= (void *)bpf_rr_data_init,
 	.get_subflow	= (void *)bpf_rr_get_subflow,
 	.name		= "bpf_rr",
 };
-- 
2.35.3

