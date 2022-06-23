Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150082.outbound.protection.outlook.com [40.107.15.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1D41FB1
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 14:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPhojWMOTjQnf6ndBP6/q8GfOOejl9NwvQczRDl6/HEhgIsJiKAHimwuj9vwHJJvEwsAg7Xz9ZRjzzqhzcHnuqsy2IGL5SBaGUxOlQCZauWFWJ1Hyqmpz4uGG5hW+1tBrBNpvKcFSvKUFqTV0wGIM9RCfn/PVw1oTSD8n0OVwQstS0+a9NufRfGxSJeTdVKubq6cXOzjG7Ld4uaSBWm5V6H/HbFWRRMkOXoYNjb3gF6KjklPs30sHS8XYKhZvXhfvvmtO7iA6At3uKorsygjCHwVnPOAR1Hh11R0H08BsZl9C+dGh/A9ev0FOCcqiQQ3TGS3PRqBqEFLLlX2XDJGsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXAPynTVxZu89adkwojsAU7JghYEy10fp7QxGK9ooj0=;
 b=hv0KY5HV4/AvqJX6BZh1CY4NPfihh7P2P+QORG6Lopbqhd48hJPH4wySQhmIXWNYd+DlGgxDyjZgsGsZCw0rnAuZkd0URYJH8cbb/JuCBnFPJsDlAwDxGTIQCq5A/LjsjWTvqGtr8YRD9XFh4jA1OoJiSLzZoeF3OAJj9oIU7ePO52ZSoSiNtf7NAqCdftuYsKHmx7wTzPs87jx1gW1qi/ME7N9ECFxS1Q91n10+LK2R1XzEKhk76/1io5hOFy7f1Zd0lJaXBXSBPZWYBfc4iZYQ8ObN27haW+fStfaJQqfPqIiq6mP6pzCyCmAyIsDwRzWsLxbU3J/foiJqtQSUuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXAPynTVxZu89adkwojsAU7JghYEy10fp7QxGK9ooj0=;
 b=Nn1T8NuLb2TyD1AHPyd4hglgaAJSnxt6cOTT6D0Tsw5NxMzicO3rnGK0XQAq9z71kwHfQhxhVpmstmH5oegMlYigUwQpgwHZ3NXRdhr1iZWKichzq7WB7zlr0gNMbPuyNJWPLOAaYYulq8RVInCBEpOEMvYchH0wDxw4VgNbB7iBizfuotNqyT2TDqklGXpidjk+uC9LNlrnT6pF0mP5wTYDZh93jZN8dLif275rJiyrrpGA8W7pgjP38X07sT05Kw+ozY8c0UAqgeHyFz6q8dvi7ns7x2ejlmQwO28Ma5NhvqQrShFczc36GhAy8JiccAfsfq0ejmD36Mr3BSKZPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8299.eurprd04.prod.outlook.com (2603:10a6:10:241::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 14:54:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 14:54:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 4/6] mptcp: redundant subflows retrans support
Date: Thu, 23 Jun 2022 22:54:20 +0800
Message-Id: <4e48d578633ac9363ae80e1c8709394fe46b6f4d.1655995770.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655995770.git.geliang.tang@suse.com>
References: <cover.1655995770.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d071b25-3f8c-41ad-9bb4-08da552851b9
X-MS-TrafficTypeDiagnostic: DB9PR04MB8299:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB829952AA2CCB08518E549D03F8B59@DB9PR04MB8299.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9GqihoYmA23YopmuFRy1m/qdQycDC5u03J5g02HXXCd8bogMNWxDIyl3B9ZX5QS+wz3SUcjNG2JhAgaPHrLmNDMZxOtLc0suzjDpwP+gfYqfWYdqz59FdlwogXQdYN7g6aDYOxgTZI/etE968MoyKuhnRn5bCoWYYNCnYkwQbJLO3ISAmmV3CKWTpFR7suVAiyzgKNos5VSaO2deV7OgcZt5gFzXLCv+PYqeTp7zJxcM8X9pcdsdDPEWWaJ+5g3Fswpd7B3W68fYXZhixt2rnUX+ZDmgGvhU94SHLGnIrcIrvReGUP1vc8OMtaFYwZGS7qiFBXXFR75/50K0+PfNT4xUUG47EutLmUYpwAjhvOtDOPp3AvSF/VJ6a884qW+A8wEO7L1ZAwVO54juPcpqHmdsOduTqS80UaV7CJFWv1rwk6b5ohbyXwK7aMGgAsntwfc/0TGCHwAgD0bEwrLQp0q6wLL7oLee9Tsm8weNIIGuJrgo/9axZBxOegrskwAyPXdDDLngB9XuOMz2HfEImLiUigE60DpYYPmA1Qgg4vXP0jtJwaxmKhdkilCAEVkJMZXc7QSn9F9mzPNiztB6DvuCIfPpvaUZ+/OfiKreTLUaEqUQcQyKWe5+Ha6s6MELiQ7slwtxchXO+/kQ4vLqGEiJsVHIEraOHG1uvm+BM6e3aKnZPQvGV+Ykb8KfknqXbYwd70ad+iBCsH7vHGaH9uEFaAqeSh14/94agMZSm3FL3dgetHIUpTUI0cj8jT0J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(136003)(396003)(376002)(66946007)(66476007)(83380400001)(4326008)(8936002)(8676002)(5660300002)(316002)(66556008)(2906002)(6916009)(6486002)(478600001)(36756003)(44832011)(41300700001)(6666004)(86362001)(6512007)(26005)(186003)(2616005)(38100700002)(6506007)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KPE2uQuGcSBUY+1l3TUApVuBgd/zQzuWgtxsihMVy/CONbEqMOUI9F6TuJ4X?=
 =?us-ascii?Q?3js+hIHuHpYKcEte4GpbgG9ydqR0j39dGm1QIOjcU/xA8+s0mSrQR1Pj09NT?=
 =?us-ascii?Q?ED0vmt+CtaMJyWlTQL9B4d3ydtfO9JuI0CGNm/TAYR48h0DiSr8y++Zwl1Io?=
 =?us-ascii?Q?fiDWkek3hFZ4drq2KKmwR9FswBRzYZYtNyo4f9Q1ccJQkQCtrqMbDdCERzAC?=
 =?us-ascii?Q?O3RiKnNDIrjdpEXb/DA+XI2hrLyjRFj9eJGetUTXkueQtUwNmgeIa3NMtbTL?=
 =?us-ascii?Q?7xhJzjqur/7Mmplqe+dIjYaG98P5802Pd6IPPULBQqyAtboY+/M45D9eL2cA?=
 =?us-ascii?Q?vFLWVDE3qHPUGJvaUgsqXeAk8iKuudW+e//F2mEQJuGd/VrAtM9/NGGUMrvo?=
 =?us-ascii?Q?8kzA5dhvknSduCoz+o6yabAAd2hkiZJslvMzfC9F++w+OQ0vGGy+u6kqlhav?=
 =?us-ascii?Q?dQv0zy4umg6gFU8Rw8dnSKPv9Bl4YzNadZFNn00cZOQPvlE6R3+hfOmGdU4S?=
 =?us-ascii?Q?Q+Ba99msO4+2a2/aZqV1E2DwL6mosBSGhmRgqgIFd5d1yNwkmvYA3aIkLuS4?=
 =?us-ascii?Q?Nl/e/olRPTEgQt5b7Wv0cHTdmU+TWOkOP2BURHtXaPMv5UoW/zI7M9F65Vrs?=
 =?us-ascii?Q?vHmfw7aNsJD55IMuXI4hBIVZV0DZqp7qLmW+BOmvImPm0VM7VmUNkVx2I37s?=
 =?us-ascii?Q?z65i91ZXITBLfYxTZeKg94fJSkw3RzzFVEoiA2+bgzTrB7hUr+cv5UMpcFsL?=
 =?us-ascii?Q?/UJrZ8VIA47zwhw2wFsz0njsiw+6hgtY00AciDYFV6r8wql/cdxaVsooqK+h?=
 =?us-ascii?Q?gXOtdZwlSF8lmmvEXCRLr/B+wiUR/lA8FvSYjI+tXBVxFYGZd5JMbBWZ7pj8?=
 =?us-ascii?Q?GXoYq6bao5MZVWVXH3RVpX5aUEUCCVqjxHPhgrpMfstpaEnvVzYAknyI3ftp?=
 =?us-ascii?Q?4qO5WhsvbAMksbDRWvK2lD6uUY9qpEpNiwUzPr53e7d95gW6oumRyijIJ+Wo?=
 =?us-ascii?Q?y8csIOxeR/O0Kt0O2mfFtNieGZ2RIt+F46aPOZgqArFVhBiLC97TZI96IJPB?=
 =?us-ascii?Q?vIeFdlLivaefvQL16rZfYNVG9zEKf2Clj6UBi4BVx4/M7ZmJcye5S4AZuXwC?=
 =?us-ascii?Q?OVOJ2uFRC9DVTXPni3KCwwc7IEBSqSJsHPxsAMhfDsT2w54dz3mw8ThDtl/n?=
 =?us-ascii?Q?Q49NDn8zRqRTdrZtz+Wlth0ty7zRs9+vzs3kSyAc0oMnGhWqom7E80q0xSs0?=
 =?us-ascii?Q?McDRVIAZ+jWvcJdtw3pfVuLwcShsvXLXsLyJ0Mh+ApblBZfCIqtj3hXUzM2J?=
 =?us-ascii?Q?jD2bCOEgjuJZLpbCq3ErPR2kUxdDqahE2NPRsC0c4b44P3E7DYNWumO7Du32?=
 =?us-ascii?Q?HVWuaJaiCpqSZdQ1ngpcyYfyfNA7aUcxrltxpMb8lCusehgZOyFy+VB7mdta?=
 =?us-ascii?Q?jq+3yMAuGaRtDeeXFsq8akM4UN4+i+VK/5WpfHEl3fLVkFXAsM2GjhoYY2rF?=
 =?us-ascii?Q?OvhbFQmmZxpkzrKi+3e4Su6tKevsqZ57w7utfFdd2hy6nyYOseyDlork4BFH?=
 =?us-ascii?Q?sULtPM9lAi7ni7bX/3Lwn0mgVcs+Zm11BpI82SVsdpR6uPRm/2VdT0Aw5dDX?=
 =?us-ascii?Q?L0SnbISL5kqvBRsQ9tzoouo0+7ZP02vu3Vwu1kt3wCw/R2LV2pIMWAAJ9UMH?=
 =?us-ascii?Q?udojA9IpoaTrjjblkAlUHzNXIN7kjebBnPCGGYDO/vgeOWfzwgv3N4OVRJlg?=
 =?us-ascii?Q?PDNBuP705cwyvVwsVzb0RFQmB2sgblQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d071b25-3f8c-41ad-9bb4-08da552851b9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 14:54:48.6548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8SklWeywGNg3SgcNiQLDlSBaN2IBu+YGDXYnNY+WeSC+j9U0W5ZLaF2Ljk/6vFDAQkyovifNf+9pAjBthbQtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8299

This patch adds the redundant subflows support for __mptcp_retrans(). In
it, use sched_get_retrans() wrapper instead of mptcp_subflow_get_retrans().

Iterate each subflow of msk, check the scheduled flag to test if it is
picked by the scheduler. If so, use it to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 62 ++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d09b01f1dc29..0390f3d951ca 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2415,16 +2415,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 static void __mptcp_retrans(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
-	size_t copied = 0;
 	struct sock *ssk;
-	int ret;
+	int ret, err;
+	u16 max = 0;
 
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_subflow_get_retrans(msk);
+	err = mptcp_sched_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2443,31 +2444,46 @@ static void __mptcp_retrans(struct sock *sk)
 		goto reset_timer;
 	}
 
-	if (!ssk)
+	if (err)
 		goto reset_timer;
 
-	lock_sock(ssk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			u16 copied = 0;
 
-	/* limit retransmission to the bytes already sent on some subflows */
-	info.sent = 0;
-	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
-	while (info.sent < info.limit) {
-		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret <= 0)
-			break;
+			ssk = mptcp_subflow_tcp_sock(subflow);
+			if (!ssk)
+				goto reset_timer;
 
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied += ret;
-		info.sent += ret;
-	}
-	if (copied) {
-		dfrag->already_sent = max(dfrag->already_sent, info.sent);
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
-		WRITE_ONCE(msk->allow_infinite_fallback, false);
-	}
+			lock_sock(ssk);
 
-	release_sock(ssk);
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
+				max = max(copied, max);
+				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+					 info.size_goal);
+				WRITE_ONCE(msk->allow_infinite_fallback, false);
+			}
+
+			release_sock(ssk);
+
+			msk->last_snd = ssk;
+			mptcp_subflow_set_scheduled(subflow, false);
+		}
+	}
+	dfrag->already_sent = max(dfrag->already_sent, max);
 
 reset_timer:
 	mptcp_check_and_set_pending(sk);
-- 
2.35.3

