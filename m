Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130085.outbound.protection.outlook.com [40.107.13.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E13EA2
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 09:47:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dwav3IW833T0Q+miYIq+kyNGkJw+IhN07nV9F6IGzI+Q72+ZVU6qtKOBo2P2bra8Hy5bM4JvuFvbLZ0lM1RWN2MnSgOL+R1D3WLpRLJ+ii7hTp/S9+Ue2KphSh2eMioeMJShFfU5ahAtlEQwFvAyL5Z9bf3J4ay0wjKDhQCxoIiTujf9KBQ7IgQCOXaSl2e+mALwGMN0sW/jTVqg+ZVAN4Yf77LGQMFZCsvwcoPguoH4LhEGPFecVvLLsgNxPul85BLQi6rZkQNwsDnfnnOx6aZZtXGfL4EMXNjoFsVpo5CHWEUu97WUlayrpwxv2dgMU222/+IrNxsn+SU1PWD+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SMmhEwME6WeULjt7BkPB3jfR482LNdwK66n/ddcdFM=;
 b=GED/WaoyZ8VFngUFwYLHwVxD4HHJOZNfx2hg5wLg+qVRpEnHL3SrnhQkdI7+sONhA5AJzfxLfJUvaJMhIC5vUz49c85O+0g4E1iM/AhWtuiaqvWzp4Tjp3LZNVsr+XY3HAUx97q6gmgq7Sxi0NzYtAVjSHkDj/cFY2JNedu1lFeyYc9CbX9CWAkRP3EgxI1GECIA0LQrvycqNCLyqcycW3z/0ylldZiyYSjTvRumJScHejPPo7Hor75kqj7sRLZSzxbkjCYtKdlZ26WjU5m7if4kGSNDV/bZvdAeYgNUutsADiF5sy7RAAtgl6thJwk+ttidfLOjuetbtyCAzqpRog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SMmhEwME6WeULjt7BkPB3jfR482LNdwK66n/ddcdFM=;
 b=4V+EkswN7mhusc+xjSmNWTBRyKi7Bm2QZtCvapMyNQdo2iBSl8jK4hiRurJezRQTJOcSekcyDoSwiVP5L6KTBJEs3zSSiOV/O1jHD3LHUW4k0pUdFMw0q90fRDHxw//b9k8F9Vu0/a2gIzW/JHadGyN3CJYpj+ornt+Swhew+XfGAGz/3OnI//8SZG4Sj9BOt6qdRmgF50iF74SHIJlvIjHbqrSQ7oO6L7WbltsIR5BiJbU0BoGuVAsgdnNv6ELri30n6GU4hkQZhrPTn59vyPAKrnVlmLhNin/eoGRkthlY5NVrGnq0QrBAy06aiUtnjPh9Fz9TeQYNQvdHAxozng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 09:47:37 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::247c:645d:3f4e:d907]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::247c:645d:3f4e:d907%6]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 09:47:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/4] mptcp: update __mptcp_push_pending
Date: Wed, 28 Sep 2022 17:48:03 +0800
Message-Id: <0b90e9ec304d919c833863e056f8e6c7b62d0dc2.1664358100.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664358100.git.geliang.tang@suse.com>
References: <cover.1664358100.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::15)
 To VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|PA4PR04MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: cb594a39-890c-477f-27d0-08daa13679cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9YfBeFuQulNXxYj3M7eiAji1aJwwQExhhw+MhcjUAtFl1D4WcEK4i+58o2r0tfR8672zPWUJFiNBMzSrz1fRLDBPFBX0fmHz9wVHQjJKyI7Z9fYaya+b7BC1wILpWVCIxK2ibjQogUZ85pEmvfov0o9uxeTpqQLw49jMyyYRO1SA40UPVgbh1OC7uKffsBm1NZjj+8yLEYRclc69K/CAe+GwkSSK5JSITXLM5Xo8jd9Vrg5OgJ8bOwukb0uXGUYFd8LUzVRKdoAXVmqcjtVG1jBHgULyGzDIJKlmCVyfx65q4/g8Rw3xmDBn4X0FWjY+szzuYwsWsk00+7t4YOze96YA/qjsz25/AQvUSZT1uS1uctI4T4l9Dbq2OgDfZZUm/vGZOgdlE2lnnAS8O00p4fv1ZjTwlVtPbC8bCOquZ6QFhXRfvCMCRP/tk2gOTJvYjiascY6pNXKdJeObgUtVkwKBzvP48qfRDRqHy56CjdZNEr5/96XJRBKBxPsnJ2HTs5LGVUwaDkHKH2/Edl71pr7wmDJSXCJEkqnHsuqhMp96Vn7Pu1y1prTgEh00iHJZ/pj+kgh0YJUyIODB9h8joAxpbuHSMA1nWjMCAQEpKFjK0dClke4rZwDtyMtBuvqLQxokw3gqX+1g+vaBupIRkHFcESYiShUgWaIiAF/8mNj7pP0gH5r5vX25vanGhHCqT/7cUnG0F7F7nQ2S+B7Klg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(26005)(6512007)(6506007)(38100700002)(8676002)(6916009)(66556008)(66946007)(66476007)(86362001)(316002)(36756003)(4326008)(478600001)(6666004)(107886003)(2616005)(186003)(15650500001)(8936002)(6486002)(44832011)(83380400001)(41300700001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RztDDrmLy+Z5VCRiUSImdmYdo9mWxkYWtBlwi4Zg0kX0aAYAy8p0cM4Evg5g?=
 =?us-ascii?Q?PjNQBH71byClSe3bctoRHPqm4swwdrEh1sTfXM6q0mUHz7Tu/UnVvarY6bjE?=
 =?us-ascii?Q?Jk08FyiGzgZnn2a01G4/4ChhWoO2q5Vc8KcJTPGd7J1cqNhH68sZgWuAiH7g?=
 =?us-ascii?Q?VwJHXijqxwAM+mdZl8soj4nugUhjIneoyLMoHMjtNjB7ZRpodAOxrlCUMrrE?=
 =?us-ascii?Q?V8cdDLQ7F/iXjwPHhNjHsW7mwMePzpL4hbmrQ08adLzOEskxZy6anjE8Up4h?=
 =?us-ascii?Q?spxbB1MlKiYPe+FzANSig3zvz4cq/E2XvPrdObAQgK3iyRDh9h9AZSom9vlL?=
 =?us-ascii?Q?I02KPwy53EpUI/mMswfRFVMGButZDvnMk1Hl2w4IfVpJjJK6/ePwq3ZAY/Yg?=
 =?us-ascii?Q?cX0zjJ+Z1xdS1Otdce/rbNVwqlF7jpP5jRe12Fkkoq3mOm2AF+VUNdx5ysmP?=
 =?us-ascii?Q?AP3xRCgFVQnMP775GgnbekbpHXw8XyG83tRom13zrrBMlPa+6IL4m8jG3vMU?=
 =?us-ascii?Q?8uYy+Zy4WWFNJzMTBA3ufhziMms54HWxdw3AwZEzaPnh0duogY1CON/hMQyg?=
 =?us-ascii?Q?nbbHLUelfYG3fnnv1DsiU94EqtSEBwW57NL349O7NX1S7VyQd4+xAvGiTRdh?=
 =?us-ascii?Q?tEDyKsFs1rnsfbsC3Iwa0vTm9vFqAKBZkGZXPaxLJJAiCj2kPU6yvbPsKaRK?=
 =?us-ascii?Q?d6couxJDOWaUN4P4adYS/bbRPK4OVkcqGUZOsSMgxVrFTZEySXt03QuTWXRY?=
 =?us-ascii?Q?2b+ollFcvvnHDfB9o7uXFMYL17GfyWtfMIMFzF4nBHzhup+3IEySMK0URMhm?=
 =?us-ascii?Q?VfpbHLAk51N56ssKFeHItb2EleKYeixb/NB496s2FnvN50skGqmtE/ZT7XrP?=
 =?us-ascii?Q?bxl6eRItvCxrYL03IzYYqCNdtt1/DwS90uOTcIrgWBs7IZ2NxUF0rV9cRNNa?=
 =?us-ascii?Q?XMOriWnMF0uKuVbZy9HN+guqplgzJhdeiBfxpygrZK58kBI1OjPunuoFHHVb?=
 =?us-ascii?Q?QPaOtC256Yaj84cktqr62plUoPLeEGfyQ5ijjNdo27SkkAcyHblZl9ZrTL5O?=
 =?us-ascii?Q?3c4gL4gQEBQiw4ZqMcwd0t1jlJ3ZtB9Wx+WJqioPqmyj183s99xD0Q/Fw6kp?=
 =?us-ascii?Q?Yd+B1g9ETwMCGZDltNreHX5OsERkyrNHl+xg3NNAptt2yrhFvXNZRkcsWft1?=
 =?us-ascii?Q?72hXHNmJ7Ars+b2+9qfOOFJvRDP9/HxtsY2KEjcmen5/NmskyzJ6dFdxIUab?=
 =?us-ascii?Q?+X3zbdzqyrj4xsG6OeZnRV0IahGN+2fqtKyvUwtbz1DmboZxT3WVKkKtC19A?=
 =?us-ascii?Q?8mTcIz1NYST0aYyHwOnnSsmd9h1HHbJU4bhhTFebRbluVguJdMDyla3YME54?=
 =?us-ascii?Q?ymUFP46jO4EOGqKYJlPBtgXo7rMQW+eeMVY9BvWyc/7gu5rBuTpt/Yf7VNK+?=
 =?us-ascii?Q?ywNJPhHzlLGQvbKICZWLDaUPyqhfXIuM+HImhgDxxElaydoEUWjGdyoPjFvq?=
 =?us-ascii?Q?YEmbA8B/RNZ0Usam0UGHOVpYMdxbQh1zkDcqTiUfKet1SW8E0sgtIPycgsRH?=
 =?us-ascii?Q?VYl9Vme7iULeDX2PzVlbsI6gbH6kHfNJKQ1rU2n6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb594a39-890c-477f-27d0-08daa13679cb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 09:47:37.1571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyYYW9ZT7MtxPjnBmZbjN7N/4Bq6dSVHv1UE83ocgmbLQb4j3iN7oQVrKZfBiTmkv5YqDTPTeMXHvNQTq2KE7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7502

To support redundant package schedulers more easily, this patch moves the
packet scheduler out of the dfrags loop in __mptcp_push_pending(), invoke
mptcp_sched_get_send() only once. And update the socket locks
correspondingly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7ca21915b3d1..fc972d56926e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1530,15 +1530,24 @@ void mptcp_check_and_set_pending(struct sock *sk)
 
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
-	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
 	bool do_check_data_fin = false;
 	struct mptcp_data_frag *dfrag;
+	struct sock *ssk;
 	int len;
 
+	ssk = mptcp_sched_get_send(msk);
+	if (!ssk)
+		goto out;
+
+	if (!mptcp_send_head(sk))
+		goto out;
+
+	lock_sock(ssk);
+
 	while ((dfrag = mptcp_send_head(sk))) {
 		info.sent = dfrag->already_sent;
 		info.limit = dfrag->data_len;
@@ -1546,24 +1555,6 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 		while (len > 0) {
 			int ret = 0;
 
-			prev_ssk = ssk;
-			ssk = mptcp_sched_get_send(msk);
-
-			/* First check. If the ssk has changed since
-			 * the last round, release prev_ssk
-			 */
-			if (ssk != prev_ssk && prev_ssk)
-				mptcp_push_release(prev_ssk, &info);
-			if (!ssk)
-				goto out;
-
-			/* Need to lock the new subflow only if different
-			 * from the previous one, otherwise we are still
-			 * helding the relevant lock
-			 */
-			if (ssk != prev_ssk)
-				lock_sock(ssk);
-
 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 			if (ret <= 0) {
 				if (ret == -EAGAIN)
@@ -1581,9 +1572,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
 
-	/* at this point we held the socket lock for the last subflow we used */
-	if (ssk)
-		mptcp_push_release(ssk, &info);
+	mptcp_push_release(ssk, &info);
 
 out:
 	/* ensure the rtx timer is running */
-- 
2.35.3

