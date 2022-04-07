Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923E620EA
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 04:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649304244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJUAQANvCHKv4ySEsdBuYEQHlPtRhU6GRfbLN1x5PEc=;
	b=AzjfjMg/fA9kJZA4eduPL+nNRO3R4AakGQhrwuaABAgvrjN7nurmHafQRKoAsfCI3VSZyk
	k3DLAqhZYGXWhz+2HhiOYjN1GjMBHDkw7O+CYDt1ziAEfSvDAA+HPVjFMHFucJ+O+vpZaU
	+EECifwXwY/JkteCFT7pTEUV+52FB4Y=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2052.outbound.protection.outlook.com [104.47.9.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-ZzGAfuceNBmZlWpCJn_xTw-1; Thu, 07 Apr 2022 06:04:03 +0200
X-MC-Unique: ZzGAfuceNBmZlWpCJn_xTw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5gZb57D+jPguF5HQm4upSSH6CyIhMXlj1+S35ZVSM7kJzLsT33H4qUZZqYZyZZ4njShiR+q9phwHndylOtttIgWwpHJMGH25H2nBM+QXJp5P0uMPPuiblt8pEcUjb9OG4EuGDOXz0Waxsqr8f9n9ip+0ZTVp+B6gO7zyD7M7u5SLOMWc/Rjg4jSlbzGwn/+xsqDqI6pZSOYBVyCe4Pt5yUDlpWveqPhJ45ty9qlKLbw6RRFGKq77oxkxEqDVaLBUr7Xc3/FxBE7OXSnLItC5DXOhstBL3rib5xgdonnw4A5eVoxT/+SKz2p2YI1LAAnJiSJVHgup7ARRizWANb5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nG8vck48mPd76laoT/V6HnY98I3IdUIZ/QVucfkqh0M=;
 b=EbfLWW7zxmFj4m3b+5N84A/NhIYheYgSj4zrQx5bNgvhTmwSiVraWkdI+7vFduD9+owCrCCgw52bMSx7Elz2I1CeECr/qbQfnLMiYBIPfC/BQya8J8Jje4ZVj5UoOZL4+Ce6Vg+CwnaEsLp007P6x3UB2E7q7BEOBsNE4Y1ZScdlHmB3Ku6gJ9bQ8IMpceDbKljwzRHwIQbNlkZbrZ9AlBrkfYUL8yosJnQupHKKwGydaLEiQjpM+fes/YECtKpgKRDIvzTlz3NGXqhCHTiNhFVzlrpeI5CLOV0eDPJcf+G9gsyK8/1xa6jVLOfuDNEBzXVLUBGPqXGQUGwLWPzEcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8818.eurprd04.prod.outlook.com (2603:10a6:20b:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 04:04:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 04:04:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 5/8] mptcp: add get_subflow wrapper
Date: Thu,  7 Apr 2022 12:03:17 +0800
Message-ID: <fd09cdda77981be041bd4547ad35176795c6389b.1649303876.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649303876.git.geliang.tang@suse.com>
References: <cover.1649303876.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0022.apcprd03.prod.outlook.com
 (2603:1096:404:14::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01261194-5a9e-4a1c-01dd-08da184ba6fa
X-MS-TrafficTypeDiagnostic: AS8PR04MB8818:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB88188AD2CB2E9925730E9873F8E69@AS8PR04MB8818.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j/j8COF147IfzQikYlEVFoEF0P/3A9ZjWXz/lRAUvmq+19b6EsXTRB2io6J+N0uD0cB2eAW1Lz2vGHA0SCzp5xR2QcL/vau0AF3u3T/HtZxL1aOcRhXgM2eJBtbIEO+4jCY35qYf3vQJLd1p1/TxKV/TvupMGieHsBb7TRqeKHh07IG+UP3XAlc3SRdY5+d3NBy1EuxTzWZlXFw2b8abp4sMk+1sbhx8ZS0QL0koHj8sBHJiNPJYk8QDCtBMGiVbM/7Q+atET7TcHqwjUwkiNSXpA3Xki8oaDkvOEGCKS/f7kZwmodveNn43izKzXccUY+K88gJi0pNmRkBGW/jy7S/C0ilacOcgVnfgRbYBTABMFgw+UJy0IJLGZEewT5TeFECRuJs6MX/cwFGDdCtGlOjBh9FuLA4ZRD/IE3cMXE5hTIcJERU6+376480or7i6Ni5H0sHfF7kLQNQD/Bw+9P+VSV0pZ6c5Au09HLvvKiztb23hdxvgPsnFVrHfyZayflKSnRYq7L33eLPCpxSJHBKhzYqqQuoX+r7a4xAK2tfGppm91RdMnJAHkgWS2gXfyt871MUHU/gQamOvA33nLJUT46dRFIFdvF0m9CjV6jkUrWWoPEnSiBiRo1qOXyklBaqsugde5Qe+Q/ErLKDeZAIKufX13oO9jpMTtWPqepL0+c88eAeAxcEPpsMl5Cjy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6666004)(6506007)(508600001)(8936002)(6512007)(6916009)(2906002)(4326008)(316002)(36756003)(6486002)(8676002)(107886003)(66556008)(66476007)(26005)(66946007)(2616005)(83380400001)(44832011)(38100700002)(186003)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mJDdTHtcv694e4QE2nE4Qzc9iIgF/QAgYozv5D+t2U8JrO4vQE7iFdxgowVj?=
 =?us-ascii?Q?NSVSyo+NcyY3WRDU2KGk5Zc9eohW12JjU7+mEEeNcm1vp/WI1RHEapOJOB0G?=
 =?us-ascii?Q?Tf5OtQhKFl2FjuE7+Md7Dj+deCqzDrzFUJ03p6FPtEav7o756icgh3+ZYdcD?=
 =?us-ascii?Q?spoQDz7Hhtqpc8RBQTtJwnwpAsgnbdIyjDXNtmP5ZPhu6C659ydD9Y6e9BgF?=
 =?us-ascii?Q?K+lzCvoVR+xkDNRJp8ttpPfOIK6zL/LeKF2asergTHyLpp8NQlbw2QpYjW7W?=
 =?us-ascii?Q?J8uxj978OcjhVCe17KKDeIjrgW3tK91R+nAQgu2tCiitOMIRK8De0o0Jvypp?=
 =?us-ascii?Q?Aqz8Ea2rt+3JS1bxmnDDHp9sWxKiiQTCEvTBosGU7pqgBKHwz4zHsmPJl4hx?=
 =?us-ascii?Q?/3Dq+Khh0Z0OeNyz6yoMO87FYDfQfF+K7FOrWMQe4M+If6qziJz4L3AIOrlb?=
 =?us-ascii?Q?PDy1g6QSp1Ode9sILQxZDQK283v7fLUH3SvJB/kyaCRN8t5xXFSgHBD5QMiI?=
 =?us-ascii?Q?wIrTpBqFBjnFz/gvXXKCkWoA14HnCSP2zZfcV7c+j00hgOzt3p0S21i1udEa?=
 =?us-ascii?Q?E778W2vHTOXyfgdFOYYceQYrLWI9C1/hlq/iiE2QQwUrinFZG/X2lX+m9F4f?=
 =?us-ascii?Q?ooJnjrbGQZSpOFVC3gqcLPK7OELasY7FTPKj5XHB9GIEm5V75JSyVmYveFtm?=
 =?us-ascii?Q?Ke36uaKMfIkr9PWb94I4w7ttUcvmV5E+2tFsG7MI2DKJPbyHvtCYKrElIE9O?=
 =?us-ascii?Q?pwa50fRTlh+4ZOQE6KAQJ3dTC22p5URrjX3vVq54UPBXMD1ajj41XmgpnNMi?=
 =?us-ascii?Q?y93dONKf0OZ0HQzzsw2kINcjAme7qhgSheTvSRq6xjF4d/9JHASFg1BcxTYs?=
 =?us-ascii?Q?+l6lAJpU2Vg+43Lq5WAGqQgxN7lUVoADhh6TjLT43CZ4ncy+54CAiym4rR0V?=
 =?us-ascii?Q?j873MBudMldilU315C+c7jFpm3X2kMFv6N4d3MOKdrDgvhlDPPjSIZinw7jk?=
 =?us-ascii?Q?P8Z6930H0KSzmvEtQHEJZhzd59IxsrooGKFxxkA+WGmNcnLWkfK7GokZGiO5?=
 =?us-ascii?Q?cnheNb4gjxR2RC7i/DzKKAK8ZNj7k94QuUHkoS/TZszjcQ+ZRst04wwLeMpf?=
 =?us-ascii?Q?sWA56fON3KIGHcskBTbrY76TR1e960QihfUZE1TFa3oLs8Ac6ZPpLdOzzaMr?=
 =?us-ascii?Q?JAEDMLBnhaIK6+Atn9Gzu5o8Ic/DJEMZey1y3wI+J5gNUa8zcHKOM53C+7d1?=
 =?us-ascii?Q?aOSnn2wKG46SJGitHrdxNlhUpUI+UAl0v7e5hskNJvPGiuh0YL7WRDelKW5X?=
 =?us-ascii?Q?XULfOIzcZJenSuedHMH7vhWDCsQH6EDSQqkxUeSuvrk+OYIxN+Vzd2ShrPVb?=
 =?us-ascii?Q?qPnEbgrZahEIxJhBRjhYIHNBMwWiUXGJ0KQ1MLehB1SHNzW5KDhmMZ9xMJmV?=
 =?us-ascii?Q?iQk7SytzxASSH3+nr+En3liCetrT3qVexkPrVFKPXAeY1DhOuG0San/oqXcI?=
 =?us-ascii?Q?dLigyESL2dWhHpd7IDa3m2WuT+ke4xSjmDHYw7+EdE2K7jLsWQdxvJv248QF?=
 =?us-ascii?Q?4uBzKHoZUTwmRnieVx1RMHutS1FI72oumoq0slO9rvfFjqczYNXcRajUmZgq?=
 =?us-ascii?Q?bpLkx++TwusNvCb706/mn1a4QVqb2a6wPxSyqZWk4SAijkfEcfMHP5UmKTg0?=
 =?us-ascii?Q?G1zqHmJ2vAAUwCNYa5nUW30eLIvMi5SfjyAtsaYdMkIRR3l0kDW6G2CiA/5+?=
 =?us-ascii?Q?USTmYSkiwQJ6i/tboE6eIoGqpYtEqUM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01261194-5a9e-4a1c-01dd-08da184ba6fa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 04:04:02.9987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fo3KvjSaYjm5Mj56A2UcapZBmYpBmjZr+OWqi6t6YMFGNCsvwWakbgv6o4Zly/TI2eG7cae5oRjwLCqqs1WUag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8818

This patch defines a new wrapper mptcp_sched_get_subflow(), invoke
get_subflow() of msk->sched in it. Use the wrapper instead of using
mptcp_subflow_get_send() directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 6 +++---
 net/mptcp/protocol.h | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 37f4f6f3661d..91d8a6f2c38b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1567,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_subflow_get_send(msk);
+			ssk =3D mptcp_sched_get_subflow(msk);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1636,7 +1636,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_subflow(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -3137,7 +3137,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
*ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_sched_get_subflow(mptcp_sk(sk));
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1016dac065c8..60d6ee54a899 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -619,6 +619,12 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
=20
+static inline struct sock *mptcp_sched_get_subflow(struct mptcp_sock *msk)
+{
+	return INDIRECT_CALL_INET_1(msk->sched->get_subflow,
+				    mptcp_subflow_get_send, msk);
+}
+
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
 	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
--=20
2.34.1

