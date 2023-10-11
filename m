Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404BB1F928
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="tbncFcOf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzolKEi+bfTb+Y5h/N52dDUIgnnr8kzAjJrVm48tTfpjlll/375812RwgiQXSLLOi92OvMvzQkO4DOLParl3382NLecbsvRdKp7XePBcPTE4lQyClKKT2nMx+RSBCGW4LMoT+mzJNzezcGmPcK1xTHtiqYPsF+xlj5OsM2WGAGWFiiRxmIAZxiAWmttzlwFvD9Pcw6I7C8Yg2NPLZMKExvM67ZzcrXsv2G0KiQBjh5ozTjMTiA1WYAtZnKpSoXVfo92yllx5CCqIOkwnagHCfpESDMyGUXmWVUsoVOs3V2UqkNEW0MuNk8zVadFbTUQJLNvZhkCxHoZrmduHs4aQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0yS3cDi9k1TVhY/Z2tsvNEnfjIbIkPbwwTd7wQBaTQ=;
 b=c/mUpEBN6x08gFpZyY1y/6A89VH0WqwWLYaoM0R3+59W696dikzgQmugrUKGeoNHFqOAbvXZBnLW7utGY9TnBYE8PkeLZF7YnIxQ+wv5BhTVggAvLkVo7rgCh1yys0+olLtfrin2yiVBuYL1I2qwYu1rpvDaJam6ZCzY6Amsx4d/jns/aCvWqDoal5DdB+hmxPxVtm2NlBakVrefylhvBpnqT10hhuTG8wHaUNaFGIXqG9CdTr4CJOiKDIdSw1vzv8tij9SKQUf44QR/HqhzrYQBas0icjt8Lf1XK9K6+H6H/2MWX7S7LQC0lbOkgDdUKyT/PU2tWI2NUd4fxXv4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0yS3cDi9k1TVhY/Z2tsvNEnfjIbIkPbwwTd7wQBaTQ=;
 b=tbncFcOfEMLuQ/qOq0CL/+hjTPGOfBTLpyP3Z3MWahY5FLgXUIL2g9Bbq9KqbAKPey5sTRC/P5W4A1qT1kx2rRYqeG7KomWzGN4yco1EAgfLD7BI7VCOUj/ScPLniWVbmjq5912mnxGShlC8m0uFkNDfK0GBUCh3hMA3MIgawk4AFx40XovzZcdsdgF+00ud7NbxXIEhtKIcIIneJ/atkFgRs6VON5VvF6DCOIHgzN9yCeALs3VtPXSVyVwMPswPLGx8BGimyHR95EpTmrUvZIegwO3Okg9wg/tGQaZkGCkeYu4vao3QM6UXSTCyA8ElFHSqmYs71Le5Gm49I7LK3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9139.eurprd04.prod.outlook.com (2603:10a6:102:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 13:34:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 13:34:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v14 3/7] mptcp: add __mptcp_subflow_disconnect helper
Date: Wed, 11 Oct 2023 21:34:58 +0800
Message-Id: <e75487344cde69c5b754ee1fb3bd8c730d54e5de.1697031190.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697031190.git.geliang.tang@suse.com>
References: <cover.1697031190.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 357f7a20-591a-4d3e-1d41-08dbca5ecb06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HOSeY7SQVTS7q6Xff47uvzjH9D+sZNdrrjcxd3s9nclnDFIGTl0Pl1zsGycvIwv2mDZEijdNtrVNAc5UdBBJVa+uB6n/L2I8EhO96tIYkjZHBGol1ol0M0e+p/pX47wab/5IJKItzQpHkl2oousaS91BasYWUt7fAw80esyK3ydv0GY20q73UHhIqWsc90tbe9bzSJ10MmCNRrASmfIGgq34iiJlAzmTz5d3BUdXafkCsE/UVSc+zCpqs4zfRmPsFx+sliEpJJGSGZ0k17xvv/1LUPAuh467KG4a8qdQ4o3jvardY2kOzHW0LvH3//xflYZpmn+zRu1Cq8vEYhJA2NdCXkOc/UYA0HycmQ5kcAdIywandWWpGH/ElXGq46f5z+56J2y/3FgJ99vN9UJVVAEno4+1yFC9GnPY7buCtMGozA3tOYUUrQgm0R3uODeDRg9eXUxAm4JVdjN6+A/cSlcEJ6TBX2Oe2Ej4+w3KBM1lFO0rR5s579kYZrojPxjgiHucnf27YGkuMbw+MwuPKmX7DtDMjelq661d3+s+rMiAYtjBZOI9dSJh/kscrqRT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2616005)(478600001)(26005)(6486002)(38100700002)(6512007)(66476007)(316002)(66556008)(6916009)(66946007)(54906003)(6506007)(5660300002)(44832011)(83380400001)(4326008)(8936002)(41300700001)(8676002)(36756003)(6666004)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oMPysvNuiMdSWVl+1ZMf1dXCR5qPPwh0sWR3GMhhhduARcrOXP0Zu720ci5X?=
 =?us-ascii?Q?Y4F1Yh0JVH59gG8uid7DVfWiYRn4vNxMK/CqpjqPOSl8cnVxsCLzZslkC77a?=
 =?us-ascii?Q?8KutRmxLKWSgyghopZeVBHeBBoZwint6Sh4BLKZMFqYcTqDBsboemGcVTlIR?=
 =?us-ascii?Q?mZCBBzHOolZbZlLmI9362y/09feaKdl03erWre8fPDgqgoVraLhEuhRqtosG?=
 =?us-ascii?Q?ubwoe1qM1nZEe3brx45D8ZYnmiEpowoycU34pL8TIQyqrRZaRKyrnrUfhaCs?=
 =?us-ascii?Q?oinVyl63jWyF+3a6fFksHLcPbjcbgiy1U1gvtZ18Ie+Eb8wnhaJ010wG5Deg?=
 =?us-ascii?Q?HlxsjualOjm/MdP6GJ/a+gLeFD0mLuuO13VL6mRkrCsbmuWqka8Xu3EKiIoD?=
 =?us-ascii?Q?163H+Y1ccdK2NqC1UE+SmTFW5+BOUH0a7n8QRM4hZOZBsXrjE5ATXP/9Of2y?=
 =?us-ascii?Q?Wo6dJ0FA/1mNbzXoVSNuZ4WllW1ZurycbErcL698qYJFlk8NNlS5sX98ZcPZ?=
 =?us-ascii?Q?ElZDZk1WedOni4gFIU45/xHOv2xjOJoeyD2iG+PGvljJWv1SlfLK+UNC3ECz?=
 =?us-ascii?Q?fep0zp/beqsRA9Gj/aJWtqUvlLpHIdIF1+ah3Q6AgE7k5Pb5ITJIZVR66kNB?=
 =?us-ascii?Q?yGQVJAeV8ZDvwJUBpHqslQ1TkARxH5qb8O8DjZbKQEwiz5RP2ZQjclBnLkJf?=
 =?us-ascii?Q?S2+BHzC3iNAwA63GmZffYzW00XnjVlCBT1WkpsHoVZ7625A3IssTSNUiEFvO?=
 =?us-ascii?Q?HYCsvAKJn3HldCKQ0xUOpiDEfZI++0oQlU3H19PsaGt3QmIi8vOoNIgH7EDM?=
 =?us-ascii?Q?PzPP+pKrxKOyj/nATgq3YOg46MI9hipElesy9Nr5tJc98Ftcq+C9PUVUHITL?=
 =?us-ascii?Q?Orjm2itc658FxJjTVrtkPdSU/UOFReaqfanFJ1S4Wv2MIuqV8oKfr56XLc2j?=
 =?us-ascii?Q?RgUpZ1S1ASLTFB+K9tqgtZ1nQGrGtkSggJQym/xRHxhbNUb+VH2o5xyMadeV?=
 =?us-ascii?Q?hs0Aiabw6dusPUt5XT2ANwYSxhlHsJNkRlq0QLmOmrW8YXZQL+UBRdYJ8U3g?=
 =?us-ascii?Q?swosgETEQ2R+bBKxc4iGAxwWn5tLO3inAYQarKPTzFi4wSWhMUCotSGVsqsO?=
 =?us-ascii?Q?e/c4cegNbCSoKcevTpxD9ZckrU6eiEw/R6K4Ma+4yT7DEEHNndY+nzBpZ1Iq?=
 =?us-ascii?Q?NIXdEclwHd3jwGftfBYwCtz+Wi2Eg3kLJbsxpx1nJyG7FTDVKarNqWXy74SI?=
 =?us-ascii?Q?7f4ng4Jvl8xR1t4BF2oVhF22BORPhGVGd2VkyBRzuEsE8RDBR2sufqSUOwpk?=
 =?us-ascii?Q?oQ+CcxqXLeF9spaUyW+S2mcycEXZbqC4VONamNdXMjqUgSpMlYkHBaoCMMPS?=
 =?us-ascii?Q?1DvFcvkeCl2TOSfciMxOhFm16wXyXPvipP3iPTZlbRzmwD3qZAx5tsrz3kiq?=
 =?us-ascii?Q?1AT3ZrMpSOZ7CUtW7Sqf+KzDSu4HY9hmFszskpPTYvbM5CTqPNuy5r79L5rj?=
 =?us-ascii?Q?yB8t/wYU4ymaFWbsZxmmigAzN21I0jVcNdwwbOL+mVmrfec9w5JvxAmwInBz?=
 =?us-ascii?Q?EgJHw8YiwvMrp29OQUUWMfqIJkM+TzuBRV8Llzkn?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357f7a20-591a-4d3e-1d41-08dbca5ecb06
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 13:34:28.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVCVYb+fyJOBFj/ngVVLZRyz5y93qw9whOY/ZCAM+8riyd6pVIDzd5NbqjAycbVFP3gULGKXgaL/uZyvk6Z0IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9139

When closing the msk->first socket in __mptcp_close_ssk(), if there's
another subflow available, it's better to avoid resetting it, just shut
down it.

This patch adds a new helper __mptcp_subflow_disconnect(), and reuse
flag MPTCP_CF_FASTCLOSE in this case. When MPTCP_CF_FASTCLOSE isn't set,
we invoke tcp_shutdown() instead of tcp_disconnect().

Co-developed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 30e0c29ae0a4..1a54d55f8bb2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2366,6 +2366,26 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 #define MPTCP_CF_PUSH		BIT(1)
 #define MPTCP_CF_FASTCLOSE	BIT(2)
 
+/* be sure to send a reset only if the caller asked for it, also
+ * clean completely the subflow status when the subflow reaches
+ * TCP_CLOSE state
+ */
+static void __mptcp_subflow_disconnect(struct sock *ssk,
+				       struct mptcp_subflow_context *subflow,
+				       unsigned int flags)
+{
+	if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
+	    (flags & MPTCP_CF_FASTCLOSE)) {
+		/* The MPTCP code never wait on the subflow sockets, TCP-level
+		 * disconnect should never fail
+		 */
+		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
+		mptcp_subflow_ctx_reset(subflow);
+	} else {
+		tcp_shutdown(ssk, SEND_SHUTDOWN);
+	}
+}
+
 /* subflow sockets can be either outgoing (connect) or incoming
  * (accept).
  *
@@ -2403,7 +2423,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 
 	if ((flags & MPTCP_CF_FASTCLOSE) && !__mptcp_check_fallback(msk)) {
-		/* be sure to force the tcp_disconnect() path,
+		/* be sure to force the tcp_close path
 		 * to generate the egress reset
 		 */
 		ssk->sk_lingertime = 0;
@@ -2413,11 +2433,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
-		/* The MPTCP code never wait on the subflow sockets, TCP-level
-		 * disconnect should never fail
-		 */
-		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
-		mptcp_subflow_ctx_reset(subflow);
+		__mptcp_subflow_disconnect(ssk, subflow, flags);
 		release_sock(ssk);
 
 		goto out;
-- 
2.35.3

