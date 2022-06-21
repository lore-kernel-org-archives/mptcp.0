Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50044.outbound.protection.outlook.com [40.107.5.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17756EA4
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 09:54:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7s4o09jkNPH7qvHGDtlRrQR7+nIahK8mzd/Z04FkArOjWJrgi3K8GKj8p+4ZavgzLtAG1znW0UEP8Cb4b3oJnG7uGqnU1h0i39nMSeOQLBztL9etRcpYMfa9h/cQ11UmkkPokb8MAwRss2CxElJyR5g2cH5bw0iXOzdf1k1Of1WusaEp6XYN//eDah3fIlZ+3pemjs+dILAgkNB4z6yP+7CdcvxmgvKag3tvouZVoj1ar/5TP5KTlVjyrhMmy7aT+GNOf6+MhJy/2KjwYie6tbr7DJzwJC2XCTmX8WDa7vr9od25uo7EKkIdMeNXo1l3y1VEDCrxii7im4SIzgWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2RYVfLJgh0YWdxcdVWjJWezSmKBQCijAZjYZPWP86s=;
 b=RuhfSEnREobGa5+azCOMF1EJr944fZjE+dZdQthi9U8mocOWxoM7mJ8dscVyzsrsaUFwBS8OQCijbZmDDvBKxY+xNMtysDBJDx6KdoxrpqApDHzsrG5S0sjGTCfu7wvo6NV68ESVsyB2+h7J9IZVxhBvFJAOz8wmPOr0mjJaKrCq21uzHqI2Wf5r/EyQi+0DPxEAShSaVETEYylZk/EenrSvmIvwrZkOLThrzcAJo30z1b5YNrq5oWk6VmXb2uCVaok9kb9QDxoZ52oswugiwXhzDLvGwNBhNgTWfR/tha2kk5UlEHO67fFUuuUWFG6B3BKI9AkThnz4YEc6xkPsNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2RYVfLJgh0YWdxcdVWjJWezSmKBQCijAZjYZPWP86s=;
 b=hQrXylTHrdySYdHExhSvXKxF0451IViTaRTIw+C/tINQCGAp9tlNatXe98xkYS3rBYj1ca7JmAAhzeLA8uBKi/T48xvnHgl8ubM+hEexqgAKtm1oKahxrI2Mv7e8R+uZ5d/oDf3qrQVS8l5HTBWNG6YZpAoL6/opIFcCsxuhGWiuAOi3lNSZfcR5F8esnOEYkbFpsUFbzRWQQBQSTF5vaviLOceHErI76U9aieZQ7yTku+vnn+vhp1NE0BTmuH/889mNtYDoccLPlqQaEIfXrHC7/UVN6L24i8biWyo3K2s9bGPXH0ZdxnUYy/PSP8t7nDF9AgBxxPgKH5fPn0GUwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9427.eurprd04.prod.outlook.com (2603:10a6:10:369::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Tue, 21 Jun
 2022 09:54:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 09:54:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 3/5] mptcp: redundant subflows retrans support
Date: Tue, 21 Jun 2022 17:54:17 +0800
Message-Id: <edcebdea920572bcf4f5b1164cbc89d7d7a99160.1655804700.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655804700.git.geliang.tang@suse.com>
References: <cover.1655804700.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36ccce10-48ee-43bc-c1c1-08da536c0c14
X-MS-TrafficTypeDiagnostic: DB9PR04MB9427:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB9427DC15CBFAD868DCF14B3FF8B39@DB9PR04MB9427.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jQSRmFPwff8Nrakefp5P1eU3qkgDs4Yctg5DEyJ4GE0sHQdgMfip4bfsCrecJsA0b2IFfq7tCdmjF6QzqmAQtGhYQZbbv9sf2FXxIqPxnwbd9crKtkqSTXnC4hoMLxYxKbZioZc37wnbtD3JblF2SDXOAxOMbQbrME3BHaBreaJyGvlVv9aIxiUb9VgE0P0KrHjF4shh9hXIz8tGC0AOrL6ObRJgX2vxCnO7ukAYUFVzp0k6imIL2/+cJPN8sarF/tTXyzBoPqIymvIUjQ8NetShskg1ldGzVCVDPJv21Js11F7Ej+e+mUawGSHbc90EPi7hb/T6xw8b+pWzWdp9y+4lpoHGGonlY/aCUpn76FAJGpQxCJHZ+DkTD/CgbioBzj2K0vko0dxcLxsDE6+Ecr7l1l6+m4AiYcD+N/6rW6ZkJVDDN3w+xNKnv30vmv0NCGBo+L6ILmWp3Lt4XGXrydDeIEhlQWyE0IZfCajmCYpjmu74lGh1JBiNiOyqCIiIcPC+YVNEGLZhhEexZ+PkKt40G16vG99SXN8oJ/KJqv/r3+HXE2geXUJMSCdhU1lhA+/tp+IP2B14TGd4u0pOFW+oloKvPaT/SDMJhhB+hPCAZtG/yhQUO64nSdoE/lOKkr+71G9oPshbjFV5E80y+6Mjbkt3EWuNm0QPTboJxN+Zs4QksMAa6WzPFkKGhxjhi0DBCDHPT9n3XwWpYcwrjA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(346002)(366004)(396003)(2906002)(6486002)(83380400001)(6506007)(5660300002)(6666004)(44832011)(478600001)(8936002)(36756003)(38100700002)(186003)(86362001)(41300700001)(316002)(107886003)(6916009)(66556008)(66476007)(66946007)(2616005)(8676002)(6512007)(4326008)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0U5ZbnN5fRkoOl9WthxVd5qiQ3UNANDxThhTCEdCu9PD0hZKoILc8MKjpT47?=
 =?us-ascii?Q?5WI8tDEhNpm4dbeaOpkNkiHxqzaCvdysRhL/w+Y+101sqvGE1wrPFeaaAuw3?=
 =?us-ascii?Q?gVyeAp2QA7rZnUvifEf8IYGl8la4ruhYIVCbF81mbsVobMH8iGoxqla9oqn4?=
 =?us-ascii?Q?bK27/NtLEPGaqjK9PnS/pKFTgtL7TBqAoxq60KtFoPaM1DFdaWv3dyzI8+RT?=
 =?us-ascii?Q?Bc7qA9d9FPIrx69Wr4IKvV9OravXwZqZWcbms5oG7aXvXywxDQX3vP0BHJws?=
 =?us-ascii?Q?gFgaa6fy5gPVZspFuWTYbgvN6vY313TgQ+gw/ii3qUqfKrb7ofO8njo4iVHM?=
 =?us-ascii?Q?pX/YJLduczIlkMuZtWl383IgJVFAPcTz3qoaeizmQrVjTBdDAePCfDm1sZ4e?=
 =?us-ascii?Q?OkaqeOZceUJ5NBSD/vMObaEqb0yVwaidql4iS0xEEBbbZwOEKdnuT4Hr0D51?=
 =?us-ascii?Q?rxdoic5BhrNgJcAxqxGXjncBcW778GBnawWpWdZpt+i/JXHxONSJ5QkILget?=
 =?us-ascii?Q?dbGKv7BAQQwDyCHBov77qvWV/hiJHPSYiwWMpc0g83y4j5BNwHxVwXUAz0yq?=
 =?us-ascii?Q?WbV4/H0gE1W0uf6/KAkwWYmBii96iIOQJYBBRvGNIyIgv6KPDBJlJIris6k0?=
 =?us-ascii?Q?4bwyrm9JXv2vYRDstuBLtBwGUQoxdVDjK2oAqWBIG9RJ2ojOdUOeSosciuju?=
 =?us-ascii?Q?u0k41EQyMAivDn3fbM+LCFCCqixsnOlktgfWxt39uuCmD4RfWDp/wPCSxKQx?=
 =?us-ascii?Q?mGYNLftj0FlLBKKHpTgG2reMfiXs6mS0/F0NOXt9FJNrLKW6Hos3KCouYh3x?=
 =?us-ascii?Q?65HaAW7ELnqG4ql27/k3NyAaFauxrimz1K2EAa+wkE7a1fXXjG86Fa9qFVb1?=
 =?us-ascii?Q?2LkW4DO1ahVhOky9D7H6MMjzZwM0D8aNodeYBQXMVcJY3qlKLQMCu68y0Tca?=
 =?us-ascii?Q?fPHPi3nk4/hszgWVdCsZu9XFntrj8XtBR3mSEG4fhDwquzJp05rTUXWmJh6T?=
 =?us-ascii?Q?J2X1DLrpSIyxSNkFD3oCRwgv7MbJ+2hydEq8YLctLM/1Q0bBK2bpNLgz5QsG?=
 =?us-ascii?Q?CQ9C1xRESITaEM69Nq7iT/p0xn7AasWN+le19gGpdPCSQrpAOLZL+oZRPY8C?=
 =?us-ascii?Q?X1oT0wNXLxw5ObsO9VSJ62rzreTAP/QfV0UpdQORR5HALWxbaV2VTi8MGPrx?=
 =?us-ascii?Q?C8oUR7vT5uUsd7GupDXHg8KBjdRf90ysXJE3mPnwiixqmeLsqn57k3hf7KYP?=
 =?us-ascii?Q?TGUP2/h/T7NKpQRpmY1HNuIHXpFFxexQc7zcjkEpYEfOVNsWnQ2pzRZrBJ1z?=
 =?us-ascii?Q?783+kR6YM9Me2LXZnHlNx4IWcLwRhAEJWQmnkVJVc1g07pdD6bMR4GDoBqeI?=
 =?us-ascii?Q?8REj4NUM5wTTYQmYH7sd0zL75jhucjn+V7gYJXaFnl1oKNAHLNI6pDZD+a0c?=
 =?us-ascii?Q?9bnSHdc5SyWpxq8YLBfSG7JGoHmUfhc6EQueoEm9kxdpxMxjTc3IgUUs847t?=
 =?us-ascii?Q?MvWlJxNmVXdgDi3ncO79NzoL5bmD6DviBt+R+GsTamQFfByHQFs+JQRNh+AA?=
 =?us-ascii?Q?3+wYG82dXfHbvkCxNl0pckJzNo6eHZxkpcd59xKPLahWzwuS1t5PFEf+5ZZG?=
 =?us-ascii?Q?9SfbDY4m5KzsGM0pGQqnYzYsrdJ7MRkV1YzkPJAdTLTDpT7tTmpRj7o2JuPB?=
 =?us-ascii?Q?zY6Co50ZXICTVcIv0lEKgC9PVeajOS4zpHn88HrJEdNinWKl1ig5mys/Rk45?=
 =?us-ascii?Q?Unxjx6NfyZeyZ11KAsI6aeMIlp8VH2c=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ccce10-48ee-43bc-c1c1-08da536c0c14
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 09:54:35.3575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xpW4IvlzDmZXaurMZV0/cmPn8LjalNcksCVCtvQHGkzNgGhPqm0IRZdDCEutlDUd9PJGlw99+0cOC06h/isSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9427

This patch adds the redundant subflows support for __mptcp_retrans(). In
it, use sched_get_retrans() wrapper instead of mptcp_subflow_get_retrans().

Iterate each subflow of msk, check the scheduled flag to test if it is
picked by the scheduler. If so, use it to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 57 +++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4f5e7f7fa6aa..ad1eb62a9b66 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2443,16 +2443,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 static void __mptcp_retrans(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
 	size_t copied = 0;
 	struct sock *ssk;
-	int ret;
+	int ret, err;
 
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_subflow_get_retrans(msk);
+	err = mptcp_sched_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2471,32 +2472,44 @@ static void __mptcp_retrans(struct sock *sk)
 		goto reset_timer;
 	}
 
-	if (!ssk)
+	if (err)
 		goto reset_timer;
 
-	lock_sock(ssk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			ssk = mptcp_subflow_tcp_sock(subflow);
+			if (!ssk)
+				goto reset_timer;
+
+			lock_sock(ssk);
+
+			/* limit retransmission to the bytes already sent on some subflows */
+			info.sent = 0;
+			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
+								    dfrag->already_sent;
+			while (info.sent < info.limit) {
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0)
+					break;
+
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
+				copied += ret;
+				info.sent += ret;
+			}
+			if (copied) {
+				dfrag->already_sent = max(dfrag->already_sent, info.sent);
+				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+					 info.size_goal);
+				WRITE_ONCE(msk->allow_infinite_fallback, false);
+			}
 
-	/* limit retransmission to the bytes already sent on some subflows */
-	info.sent = 0;
-	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
-	while (info.sent < info.limit) {
-		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret <= 0)
-			break;
+			release_sock(ssk);
 
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied += ret;
-		info.sent += ret;
-	}
-	if (copied) {
-		dfrag->already_sent = max(dfrag->already_sent, info.sent);
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
-		WRITE_ONCE(msk->allow_infinite_fallback, false);
+			msk->last_snd = ssk;
+			mptcp_subflow_set_scheduled(subflow, false);
+		}
 	}
 
-	release_sock(ssk);
-
 reset_timer:
 	mptcp_check_and_set_pending(sk);
 
-- 
2.35.3

