Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A72C29CA
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 08:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643357583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j42Sj4v0Nc9PhFvC278itFl8iJE/fmCQDIJLXjZ5hKI=;
	b=dW6UlnedbylzlYeLThU7fuhf5ffTEyjrgS0wSqkI+IakKgY0LorBuST6Jewhwq0IqJTW7k
	1BjyuMPafcC1tJvP2H4cvOwlbwU9XNlV/g5128HXyUvd6hBq5nilrEA2NFI8H6Or11Lmmm
	cyfG14/WRpPS3WbdqgsW77EdXq6+1Mc=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-LO8H5m8bOr2jWnM8MGU0GA-1; Fri, 28 Jan 2022 09:13:01 +0100
X-MC-Unique: LO8H5m8bOr2jWnM8MGU0GA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py2A+JTTkc9wMNmxiWwT8GUDaSp+st2jb7IfXNK8TjtgX84yH5prmoO/S8008xNumUpRWr9vY/lfEvs9lRFpdhlTvGimVH9FSXFD7K7qFlWMA9Vgq0xwNyxWufKgXbIq1E47EI1FJ2lbaQ5nAAirT0uPrT/OQlWDpmCtUgf3p5IZTqkFarh8E/zKpXtcpvvYLoMgZreWZq0LF5XcEJMwzEkG166CAXbqjPXhQJS/t90uchgYa2Ac5mEWy3gHBmpOjXnRZ96gLw/J91gbf/EXN29nKFjnHdMs8eVNw15+sj+5GcMfTTidgfgvx7QvzC1FQl95bEX1gnhyZPRdBEAIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04JiimxJSg17uQJkPnr2TW182+WXN0OY3g1GZ5f/fQY=;
 b=fM+0cBQvSbReRRgzagMFGfYwHaXxNVHTIYjmlHw075IkqbOi36hILX60aKdBI7rwxrKLIF+A24ezuQ2yhXeYuM8KdaSyJIReYAkOzuze2Cx4qPMxIGAkfy/c7epdzautF3WWqGFcKSiIU+uLtGzZHukEVNMmKfp/4VKYOjVqb07Me/1R9WxHFU8PadRT0PX1zX7MbVqcgqBwcqrLoWdHJ5WL+Zv2ruXrbVFXJT/t4rK9554vjknHhVm1DLo/6oNA0CuS+a5XogmCOJf6pKP45jO6fr8lAbufIG+xZSHetC5pZj4LOtMnKFZPWo2zQJdaKy8EK7nAu4AUBoSvCUkHew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8704.eurprd04.prod.outlook.com (2603:10a6:102:21f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 08:13:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 08:13:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] mptcp: drop unused sk in mptcp_get_options
Date: Fri, 28 Jan 2022 16:13:05 +0800
Message-ID: <37eb45cba9d5702e2d8ea804216efd433c2d15fa.1643357544.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0019.apcprd03.prod.outlook.com
 (2603:1096:202::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f628afd7-8398-412a-9b4e-08d9e235ff6c
X-MS-TrafficTypeDiagnostic: PAXPR04MB8704:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB8704B12287513B5E8B722C79F8229@PAXPR04MB8704.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3TmCXoLYModJ6Y1tyrd8gKNy+lniAi3MutvJZV7J/yyW4sl9v/hzp4m6XlE372e0a+LCd6hnbwn96DNBaSnotYDLYwiL6NyCwaHWJFdYeHoS51c9/OTGbluwqdgaS6kzEen2f41m0rTb2CzrhmhcegaCot2A1zmxwT3KQVSIoTkn/Rib7MTZgGm9tzz3LX+XpEjDINdU/MDmMpzGr9xz2DrTxis2u2Ebnbqf+IQn/sS/9aHKhDZQNis/rToj/FZvdSR1M9ZJ7c5I72OGzrHmg+HPmGbVe6OOOs/rpAp0kmJNz6Iej6MkTMoq1WoVk9u/Lju9k5lOetkXbIiOY2VMyeNaaw0mC89NvwB05480z7MVUXFwSyXwuV1gO1G9ybr1CmIK1oiAiMCmRiDv4eb/Vvzg4iejgSVmoQTV1lSWA73AY0gSsgQuPthLtnK0DxF7n23BayaI6Bl/hAdeI4jEOCHDV7zdTo2WnDQLcBbypi/VxoHdBDFnf9tbGUWRUZfyOcsYpfCj+fJ6uzRmody7Gt6Kv0nzeGdh0ymn3A4jR+XT+LnSlMkaanzUMvZ6VnL1JGfa5wnj3AZZqU6cZIN8N1P+U4I6fq51kZsEe3uSfS9Wt72NIanDyukusCXGAHKApLpY8H/kPUK2lKgktO/81Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(5660300002)(44832011)(8676002)(36756003)(86362001)(6486002)(508600001)(6916009)(316002)(38100700002)(6512007)(83380400001)(55236004)(6506007)(26005)(66476007)(66556008)(186003)(66946007)(107886003)(2616005)(4326008)(2906002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0NjeW6U3BQcy6tQqg7Zx7AMGcLdox14kSgMHTzlUY7ht2eI3mDJYQjJf9nfP?=
 =?us-ascii?Q?p5GZogvrf7HCPSn/q9rNxZ2fb/f2kVPMKWVR6apuKIHKVyVu2YqP3hiWBn7+?=
 =?us-ascii?Q?/n+DkHi3uYgZqwb96UWmZN9NhD79H5FfaQyeGg1nGyZxdh0X74dX3UOyjPAW?=
 =?us-ascii?Q?0UgkKq88wXwZ451hrNUdZ4M348QcueUm69/F0Y+QsyWhvc4M7PFBPzWAoLEf?=
 =?us-ascii?Q?ld4VkPpR6PEuxTJDZn6A89hIWU2ieB01mGlVODXVMjZbjQBswq+6J6lj4lDd?=
 =?us-ascii?Q?zgwFlMnMH9m4mNORO5yUtSZbmbOlLlGbqW4yOHyWLEDta/EkieAvUGJIzSio?=
 =?us-ascii?Q?2m8ueyV9qwttN/R7nGua+KSV8Ws2w448hToR2ETabWPGthc9/xE1JLCPDkcV?=
 =?us-ascii?Q?bn+04mUkUqaGb4G5Xrp5rrwL8GjJoNCA0cZB1CdVZg9jIKELL/dpFvXbekG2?=
 =?us-ascii?Q?6DnQsN4xQX2MIxqj8zJRSN2rjyKFboJGYmQeCeONvIna0W1GPWNEm7SZoYT8?=
 =?us-ascii?Q?5Dn2ksgtVSl0q0BcaskNtNlLXZ39ywCoxKePjKr5xRu2J7Phk5rTWtnU5dUx?=
 =?us-ascii?Q?iuRJUt/SWP0sm7t76t8CafJx8ro5WsgKdHkXHYfmvupdkZFsP4W2a68wOnFE?=
 =?us-ascii?Q?ddMs9IYV8Y25iBuUpvKEAOPlc1e1WGmY8ktUENtmvf+cZKYVv0hWYYCfhmY/?=
 =?us-ascii?Q?EJDCAS8B1JY/g/LtR150Zr0YVB+y4O4LDOc/jbHiCTDKjO0BwQMiSFjnhPAJ?=
 =?us-ascii?Q?j9mrvGvYClsdvT5n6OnhJELtU6YJNwxsfxlOupyYRChs68LWden0oypcaHfM?=
 =?us-ascii?Q?r1bflh3gIF5D57vPC9JfJ3UJFuC2rlwR+rhq3JEz15/3ba9C0PFTua8n+7ms?=
 =?us-ascii?Q?QNGJa5FyJxtsnZCo61m/pFORCIjTnkwMnxxQpJE+LKzVZ3d+0iWjoxBo70lN?=
 =?us-ascii?Q?M76PtSNbuOBPYDCoJyVBwTt4p+QZg/QZCIKjqmUjaUClyVFRIXqK1OjRMkqR?=
 =?us-ascii?Q?vpIMzKGORYk72nIlJzY6VW4A+qspTPVIsK00epeOt2OAJ1YUlt+oeHVpnGra?=
 =?us-ascii?Q?+RJm8lKGYQr+OOTRW7X9j8CBinJoE3nQAGLF6DtMm8FIsKB5Uf7tjQOO/dCg?=
 =?us-ascii?Q?9vXkCrQyxhsPc+ExtQMzHue4XAWluZoEavCrNhdH0r67q2JzC1eIOHxSpafl?=
 =?us-ascii?Q?FMUmdx2Y8iEKkVSj4o1i4llkRlq7MsbkZwfRHGo53tdLXP2bLRSaNKRLUcte?=
 =?us-ascii?Q?0AAwxKIL7YzttydEaj/pT+vGgpTg1QrEp7M3q2ewk0wyq1ZIWDtS4BztmKlN?=
 =?us-ascii?Q?a5uRnIQaAREHCE949bCcFSRLalGOZZC605Ylnk9jSaMik322hP5S+WE4X48h?=
 =?us-ascii?Q?MQgz+vaHREYfwQAbBu2bAA17qhZ78lLXr5qGrRD89Wain/y4mvOfGtKClZ6Z?=
 =?us-ascii?Q?wSggt43fVZDolmcvo+7RjnGmN2TDyRJ5aYDdv1BU1RSpnFx1R7DH8Sxwlef3?=
 =?us-ascii?Q?mF9MkhZDni5FG81tvgg3ueVllOjFB3TF7JkLJH7YE8BvqHD75E43AoNgUuln?=
 =?us-ascii?Q?jRyJWBBlqQHa+TYUTdLrj3hgR03sFrhghGvxc1mQop1j+6CS0t6HWy3ysacl?=
 =?us-ascii?Q?mzWEpl0BFgKlwSZDVv6ec2U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f628afd7-8398-412a-9b4e-08d9e235ff6c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 08:12:59.9524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEBrkhLf3qq47o1e+pSoOCGKOf3E5SvjgeEU/o34zRDto+N4urkEShES6D3iwqSHudfdtpFClT75FQVjde5hmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8704

The parameter 'sk' became useless since the code using it was dropped
from mptcp_get_options() in the commit 8d548ea1dd15 ("mptcp: do not set
unconditionally csum_reqd on incoming opt"). Let's drop it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c  |  5 ++---
 net/mptcp/protocol.h |  3 +--
 net/mptcp/subflow.c  | 10 +++++-----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0d0d2eb8c8ca..dc0c7648a988 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -355,8 +355,7 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 	}
 }
=20
-void mptcp_get_options(const struct sock *sk,
-		       const struct sk_buff *skb,
+void mptcp_get_options(const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt)
 {
 	const struct tcphdr *th =3D tcp_hdr(skb);
@@ -1114,7 +1113,7 @@ bool mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 		return true;
 	}
=20
-	mptcp_get_options(sk, skb, &mp_opt);
+	mptcp_get_options(skb, &mp_opt);
=20
 	/* The subflow can be in close state only if check_fully_established()
 	 * just sent a reset. If so, tell the caller to ignore the current packet=
.
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c47d69a42fcb..f37f087caab3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -655,8 +655,7 @@ int __init mptcp_proto_v6_init(void);
 struct sock *mptcp_sk_clone(const struct sock *sk,
 			    const struct mptcp_options_received *mp_opt,
 			    struct request_sock *req);
-void mptcp_get_options(const struct sock *sk,
-		       const struct sk_buff *skb,
+void mptcp_get_options(const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt);
=20
 void mptcp_finish_connect(struct sock *sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c8126986793e..097292b7d2f9 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -153,7 +153,7 @@ static int subflow_check_req(struct request_sock *req,
 		return -EINVAL;
 #endif
=20
-	mptcp_get_options(sk_listener, skb, &mp_opt);
+	mptcp_get_options(skb, &mp_opt);
=20
 	opt_mp_capable =3D !!(mp_opt.suboptions & OPTIONS_MPTCP_MPC);
 	opt_mp_join =3D !!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ);
@@ -250,7 +250,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *=
req,
 	int err;
=20
 	subflow_init_req(req, sk_listener);
-	mptcp_get_options(sk_listener, skb, &mp_opt);
+	mptcp_get_options(skb, &mp_opt);
=20
 	opt_mp_capable =3D !!(mp_opt.suboptions & OPTIONS_MPTCP_MPC);
 	opt_mp_join =3D !!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ);
@@ -410,7 +410,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 	subflow->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 	pr_debug("subflow=3D%p synack seq=3D%x", subflow, subflow->ssn_offset);
=20
-	mptcp_get_options(sk, skb, &mp_opt);
+	mptcp_get_options(skb, &mp_opt);
 	if (subflow->request_mptcp) {
 		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPC)) {
 			MPTCP_INC_STATS(sock_net(sk),
@@ -663,7 +663,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 		 * reordered MPC will cause fallback, but we don't have other
 		 * options.
 		 */
-		mptcp_get_options(sk, skb, &mp_opt);
+		mptcp_get_options(skb, &mp_opt);
 		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPC)) {
 			fallback =3D true;
 			goto create_child;
@@ -673,7 +673,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 		if (!new_msk)
 			fallback =3D true;
 	} else if (subflow_req->mp_join) {
-		mptcp_get_options(sk, skb, &mp_opt);
+		mptcp_get_options(skb, &mp_opt);
 		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ) ||
 		    !subflow_hmac_valid(req, &mp_opt) ||
 		    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
--=20
2.31.1

