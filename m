Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54657F6
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 12:18:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVUJF6M9LjDRXYBiitu6XJbCHBzMNiadpn/ZL9tg4kalEe3fgMfjGYo2u3MeWbUSF1kDX05pTPlrodmq1P7kP60pqgW2Pvf42LZHmOPp1TLlYiD2clNnhIIuU4dX3Q0y4UldXWfEd6sUy8ZRF6P7Y8ffZwMyDLjfZhmfDZPjvaunPLS/s0KaWZgBGFWj4E2SykJYh8AznjGwMbdFqlENgtfGKRo/l8CmG2uNGLgOz89fh6vzSBUDcWoDX8hdTa2x3az/Dh+iR4Y5fzu60RtOf5Jm5P6nnbx0pVf69MUebamYrwLzsbimeH/nQYlJrxCm1sbn8SojOrpYg9dsTbNOhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDdJgqtozW7Ni3JLagB8yYebc3hxLy2oag8/ZnY/lmU=;
 b=aLrO+kMAX5BrZdOhfGmVDcSjbY0pudGmDW47IUfTy7wbphK9cQJvAP+WrYUCOKW90lNgVhn4VXEgIo9vyBW6hMvsNaxVTfOeAZPHJ2zcn5eLH4JHgfegIQZB1SNVwShlHV0BMJdIe307dfixPh43cSDWNZf9bMuGW10kq4XH+q2Ne1ybWfpIw0QUuK2OQoI7i7DX49Ab5mhLF4pYQIieJ0o3s/PyQu7aPJsXAWxZMdzrpbJ4YNV78UGDamCUpNOavOCUC3djvWvR2oxmMNVNOzwx/yfGGOi5D35KQYh2ITpwX6nwSIeZM3acN89dmYKUmji/E62XH6dwYpmbUvR2Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDdJgqtozW7Ni3JLagB8yYebc3hxLy2oag8/ZnY/lmU=;
 b=N9hUG9fEhVw5+ZUz4u0iRZyHDs3bFBy4b07b0IWCbB+mljHa8L2OseDyk2lvTw2x0gBylfGO2mqNKmUYcPknD9ZjTi48Gbjv5YL6PQYvq0UK9bRksyjGL/SoeG/96w4mU3h6p6gpYcrXHae6uY95bLyiRjJ+tRv/JhgeFSUjVywDF4IK2Ut+jImRodTpq9Kkn1ySlg0xNiM13cY4uja0Z9PqDBc5iajvB7trXCi81UHhQ8ZJM8+/QU7YWpq8PinyOmzE2sBJ37082gTpsqj8SsxKC5zr8FfLwkilziqAarFp9y5agpeCGTFwGosmdL9moh5+Dz3sfGy77g8CIqI90Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8450.eurprd04.prod.outlook.com (2603:10a6:20b:346::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 12:18:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 12:18:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 05/11] mptcp: simplify push_pending
Date: Thu,  6 Oct 2022 20:17:53 +0800
Message-Id: <dbaa39bd15a7ba87251e9e5d068abe76042474f9.1665058388.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665058388.git.geliang.tang@suse.com>
References: <cover.1665058388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b2670d-de6c-4064-bdf4-08daa794d7cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RpyTvWv5fi7KOsNJmK2mml/SeDkU3uSt/VXKB/5TuquAPBpuIjLSoXgNW+MbWgH+uQvZgsNTHuny4SZg9bDMw5mUCiqefKm6hF9CAsP4K3rSlMgOBiJ22fa21iaOSBX6sqWa5w0WidzBUweko8B0KbuhDhMKrtgf2tjaDNaRUi3aXnb/uICd1x22hRpobi4TTv2tbzvU5ppTzN8KySxHcSE2HGAs7o3vVYN1OFBD6YYuH1XjHRvKYNC9dih5VATFJLcs8adiafxyb+X/wMRsHGJLxPaDvoRDDWf12JdKZi5NZvF4zf4YcU16i4h7FAb4V9oZR/F0/hxQ7cMwQ6bzglRbn7stnY4GFT0wwMjQiL++x2354WxzJUaVB9BbIqTBWuBCsuZVxdJ/l7smwrFjBc6I9j+DDAfo6mqDtB+kn+6phXnYbUrXYG96plrVubEfTTLVDcQZMTmJoeY8YjDfyvQ6LO7HQ2PtZLGRPySZDotedbDwZm6aRBMIa1/AbEyNdC5w4ImMPwmJzTs5r2TPBA4t5AfEa9E2DqtUESJFfv3wZRhdF/avt9m6ZC4GrHNH1+6ApEZXy4H+I+mo3kvmc5XSsADdnmWgmEnuJYWlsnj4fbMKxjVgo0bakZmC31mRe57DvAuyVnTPvdp8FNqoHbtUmJdIQ96c3Pcux78XPZfzci0v3eqUATHr2PU7v3pjioWCSltK2B/1x63UWOw6L+fSnT5OiIIULcbVVZ3JvgQjf+seA52fA76UecGLtR58
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(6916009)(41300700001)(316002)(478600001)(6486002)(38100700002)(36756003)(2906002)(8936002)(5660300002)(66946007)(8676002)(66556008)(4326008)(66476007)(44832011)(6512007)(83380400001)(6506007)(26005)(6666004)(2616005)(107886003)(86362001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MswD8anBenUaEXI1ONebF9GBz8wOvVssFbNYTmlIkCCapBdsFWkZ5iqAMelB?=
 =?us-ascii?Q?nlaS7N511nL0uANXIfziJXXJYD0f4zPRPxJmoJ2AvVxnH8Yyqyb/co8/h5Jp?=
 =?us-ascii?Q?2RDNTw5ZmNnEwLSnUVGg8zbMqMtW7WJGaQ9Vsdsx8paMhw8t5d/9I2FMx5fm?=
 =?us-ascii?Q?hBCrK+F22q55Cu/mddADzrlnm1Ued821mN24dq+vGLVFj7c7jamCO1EJV64d?=
 =?us-ascii?Q?F0YFmfZ6IZBJi8lDfHGt62lUS1KvDORs/E4cz3/XH7ehldU0wjMiV0xKr7JQ?=
 =?us-ascii?Q?R5hOmRIl0irG56NQgLGvUNd8EDHi8LuKiIZmqBdTO25VDOba9p8JAie2x9Ii?=
 =?us-ascii?Q?aeHM0PHbPmeyLdeERdCrpbNfmWUtPZoI7Js6bme+rlmrhargN3GtD+7A5vlf?=
 =?us-ascii?Q?chMMjOJEtqMjP7hVMuXwt9+fCQtE1RKIVy4HMR69posRx6imb4utDmI1AjJZ?=
 =?us-ascii?Q?5xQUpKo3awNBo/eHQgAOjMgXSvbMBWMfRej68678MaGKdxYKk33vQEKTNy2o?=
 =?us-ascii?Q?njafr7ogZsLOxdTI02wYit+6Hc7vegxfhHsnQgm0vMz0bnWFFFZ1v62JVGrI?=
 =?us-ascii?Q?jlSxu5VC6bC4+k4s15a577o0mNclYZjcK6YoH/hQo1jbyHE5bw0046InvZ3C?=
 =?us-ascii?Q?l3vAqes6TYMkS2wpK3tMdvaAmgfpEcQuFE9wsVrf/tDsfQHNyS/bfBMM6QXx?=
 =?us-ascii?Q?m980kayugYvKr/khBcey/DB/l9MMAnpnXvCYWkD5VqfKVOM8NFEWs8M+SpuQ?=
 =?us-ascii?Q?aNw05DGDwvLnT69089qFAUglrZTYssIp7a3ffvhtceWTPwtWg5H9Uu4sqWeT?=
 =?us-ascii?Q?Zv+YJI3DT/l9imD3XE+ifx7guBjPcQ5iFVZ70IZDfDEPH2Drcb+nB66UiG6U?=
 =?us-ascii?Q?+U3X9zcZ5orP51yuLlfJsv0aDryG0+Bb8IPeKtm336ktlko3w3O7UsMJA7yj?=
 =?us-ascii?Q?ABzr9AJvC5dopN4RgMRYpz/rxm8YmTOJW4Gj5t1Jz/o1oBXg1jC5nr2jX4w8?=
 =?us-ascii?Q?kQOnkcfy1KslFHMU922e1t+ByefylN4/rawoxER/KTkEAEkuqQfgj4Lb/4QE?=
 =?us-ascii?Q?g9YZL1NRSJA0zCt4oFMZNXCYzDtn3B5e1Fz6HqqUqqyFB2NhIH/Fl0ET10wj?=
 =?us-ascii?Q?Va3cW1Bv1AVAI4Ai/3LBjzspWg0BOG55mFKg83V1yBon3mleV2TRuHh9EcsT?=
 =?us-ascii?Q?eOLyd2CslBIqPMT2+QdhW2WIu959CzbDOBfHexM0xiKxIZTaC9KETvofUKMv?=
 =?us-ascii?Q?rUoHV8AFM+sNYLV9UjLsdq4ZHdHFZavU5/I96fSfPjjY09bN+dIhxxddobqs?=
 =?us-ascii?Q?rVCzdZTPy2UEA5R0+8D0ZX9PlwMUWl4tLg9NhEyC5uEncYuqNWXB+xkVDznU?=
 =?us-ascii?Q?l37NtnJk2BstqoT2ScNubaUnio2bXGPFxELq7taX9Nc7SUckGKgRJx+uQ5eP?=
 =?us-ascii?Q?PIEQUzG4PILRcoMrBQP/3DmgX4o6fY3Bem/HhSRGz3pzUWmO/Lnbr3co3ocS?=
 =?us-ascii?Q?uLbdMT0amwh1sYHhRY4FAs16fh4sINVa4M2nxMzKcMSxEMCvMpXZmahiw6ih?=
 =?us-ascii?Q?4j2ujFKodCVy7rqhzgHxFDdjkhJKRvTpx1wSZ6uBtXUzkZkf9c/u6N7tWd3L?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b2670d-de6c-4064-bdf4-08daa794d7cc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:18:14.6051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+UR+1lm4Xje6NlAuB6IKFiI270hCxvEB/5zTMHWBnFV3f58Offt+DJCmM9kVjT1yfDB2z4eRbltGT0BYajbyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8450

This patch moves the duplicate code from __mptcp_push_pending() and
__mptcp_subflow_push_pending() into a new helper function, named
__subflow_push_pending(). And simplify __mptcp_push_pending() by
invoking this helper.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 95 +++++++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 41 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8708e1e4ba16..29905214103e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1480,12 +1480,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	return ssk;
 }
 
-static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
-{
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
-	release_sock(ssk);
-}
-
 static void mptcp_update_post_push(struct mptcp_sock *msk,
 				   struct mptcp_data_frag *dfrag,
 				   u32 sent)
@@ -1517,61 +1511,80 @@ void mptcp_check_and_set_pending(struct sock *sk)
 		mptcp_sk(sk)->push_pending |= BIT(MPTCP_PUSH_PENDING);
 }
 
+static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
+				  struct mptcp_sendmsg_info *info)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_data_frag *dfrag;
+	int len, copied = 0, err = 0;
+
+	while ((dfrag = mptcp_send_head(sk))) {
+		info->sent = dfrag->already_sent;
+		info->limit = dfrag->data_len;
+		len = dfrag->data_len - dfrag->already_sent;
+		while (len > 0) {
+			int ret = 0;
+
+			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
+			if (ret <= 0) {
+				err = ret;
+				goto out;
+			}
+
+			info->sent += ret;
+			copied += ret;
+			len -= ret;
+
+			mptcp_update_post_push(msk, dfrag, ret);
+		}
+		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+
+		if (msk->snd_burst <= 0 ||
+		    !sk_stream_memory_free(ssk) ||
+		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
+			err = -EAGAIN;
+			goto out;
+		}
+		mptcp_set_timeout(sk);
+	}
+
+out:
+	if (copied) {
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
+			 info->size_goal);
+		err = copied;
+	}
+
+	return err;
+}
+
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
-	bool do_check_data_fin = false;
-	struct mptcp_data_frag *dfrag;
 	struct sock *ssk;
-	int len;
+	int ret = 0;
 
 again:
 	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk))) {
 		lock_sock(ssk);
+		ret = __subflow_push_pending(sk, ssk, &info);
+		release_sock(ssk);
 
-		while ((dfrag = mptcp_send_head(sk))) {
-			info.sent = dfrag->already_sent;
-			info.limit = dfrag->data_len;
-			len = dfrag->data_len - dfrag->already_sent;
-			while (len > 0) {
-				int ret = 0;
-
-				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-				if (ret <= 0) {
-					if (ret == -EAGAIN)
-						goto again;
-					mptcp_push_release(ssk, &info);
-					goto out;
-				}
-
-				do_check_data_fin = true;
-				info.sent += ret;
-				len -= ret;
-
-				mptcp_update_post_push(msk, dfrag, ret);
-			}
-			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
-
-			if (msk->snd_burst <= 0 ||
-			    !sk_stream_memory_free(ssk) ||
-			    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
-				mptcp_push_release(ssk, &info);
+		if (ret <= 0) {
+			if (ret == -EAGAIN)
 				goto again;
-			}
-			mptcp_set_timeout(sk);
+			goto out;
 		}
-
-		mptcp_push_release(ssk, &info);
 	}
 
 out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
-	if (do_check_data_fin)
+	if (ret > 0)
 		__mptcp_check_send_data_fin(sk);
 }
 
-- 
2.35.3

