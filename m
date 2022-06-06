Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A598528E6
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 14:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654526527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WpjUNxakoDYsJrD+L6cn9Mgn3TQ8B/71ZLk405R4/pE=;
	b=Y3QWE4R+oqSxxJivDNYGaI1qhciglTTO/ehK0sa2SbqkVOZRZDpGcQ6av1CdjLxMLS6hln
	fraV+GuvShtsx5Dwlr+qNuJOzbrOkeFCIqhSIgP0pqjsYwDuZh+y5J7UeQCmBLXXyvtjVH
	WXczZVsKb/vdHEwtOsYtDOzeX9WZOjM=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2056.outbound.protection.outlook.com [104.47.1.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-KJy8ApwPOeeWWXxBo2j_qw-1; Mon, 06 Jun 2022 16:42:05 +0200
X-MC-Unique: KJy8ApwPOeeWWXxBo2j_qw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnWHo6q5Phxz+pSWo90ame023k/vo6Fx0gCg+DNzD0+Ibh6frmhH8FckLjTBqRqtVyR756ssxRfm4UihkD3SU4y+MDb13h+Gc6+Q6FvTtzQc1542J7w0AuGJQrIaWUr8nj9xIJAyhlhRHPZvRXC1LgAHNnmHLJy6xKBWrfLDWOPZKr/Rj5yLTDap9k6KNqQX7wApWO3buyM3jAIJ0Z2OS8sL+boySuY+5VeqOnBHatA2KjjqFQwCnA6gsIuBGdl1tkUpaSRSf2J2WRsPYK/IB0wn+6VOrxItl25WT/uJGbRvvqdAgOrbnCYlWkhsdMgGaYwlZ2TcecSr4r/+jIkTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41A+AfoNiIQMProk4LPWgAFwqELIrOxhERIvdoH7a1k=;
 b=QcRmaSQxzmWzTDUXGZbiYI7wGMy/6WuDMVlVuAeb2ZvVYOADk0YzuqSwAow0qhaE3IovM18Ij8cIBIxC6N/HzdrEhlX5GWY2dzqP3327MaaED1Q+NIyFwjaXmheIbookV7BkMUL2sr0FJbKDJYM6iKgEwFhwCf8e5n3MxaXuZYC1/DfeuAGcdZtdXZaTNUoZkwaISKHcazVlvL278XYV4tEi/5EFj937tpq8LLO2W6H9nQ/SSGyOHlGoiG2IuRQT3x/KdwJYWXizBh18Lgup3eoCyJcHy23F2+5Zch2vNjIcDw6lDr3KbyVKILC0Fqw1J4q9grsbT5FoIWMwoMdGxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3364.eurprd04.prod.outlook.com (2603:10a6:208:17::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 14:42:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 14:42:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 4/7] mptcp: add sched_get_retrans wrapper
Date: Mon,  6 Jun 2022 22:41:19 +0800
Message-ID: <b43e4b095ec5372cc8915e1784960989323920ca.1654526068.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654526068.git.geliang.tang@suse.com>
References: <cover.1654526068.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0081.apcprd02.prod.outlook.com
 (2603:1096:4:90::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 204a3fd7-29be-4d0f-791b-08da47cab896
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3364:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB3364716087D70AB37181419DF8A29@AM0PR0402MB3364.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QdVtWyB3xQQ5g03Nf0yOfItpMLm6kgdccnUYeyPgKq2e072k5xkPuqcm5o2bJEm17e44a8X9lIUFkoBlj5nFBdF+0p0NETmwwc5HIgKPVDs6I3VHAbUJw9HOH++wtnIuLuj593YieZQi5ZRd/IsgcHK8BHbxuNN7pcAoempd+Z/T4da9JrMvCD5y1tsLqnbQ8/mKz/DOYUYv6kywS5Q5e3NFM+S8hNmJaqpAWvUztv1s2j6a69iqnUtEreTJfIIoyrOYhh6HuY3S7SrvhXT+u0O3iKHMQ/FS5P+DsH/fldS6iMDu1fRfeT2S01hLVGSvjdIzfLAdYZNVXAVmHHT2YYH1GqBTGMDpRZLsw+CzbWmJt2UMImnLsz2bZVuan59DHPXvMGSbENgcdEmjirSKBC1FgQKCcHM8eA7gv8CegwuLlhzqmXdOS12uZjpzRBgKRmdDcR6pfOeWpZ2/7101UJ/6f727XQidn021PwhGKNKJOXDl3RDl/r0FEQOr6UZJWxvpnKEOTIEh0lWgEA8xUOQYSgmpYSj7XJZ6u61BaWY0717KN4nxO69xkylN6iqpeo1EEZqAlewhG6L2o3ZckBX8VUsqt8L/AmmcBVbpQpZq6tF+BPfp4TlDmsBppAx6EnNSL0SKwVBMgvZxPtnlLzYmxrZuOINjl8dF9QZnzYiR8xjCwC1eIMoC4DwUao2O
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(36756003)(8936002)(66476007)(38100700002)(107886003)(26005)(316002)(66946007)(5660300002)(6512007)(4326008)(66556008)(8676002)(83380400001)(44832011)(6506007)(6666004)(2616005)(508600001)(6486002)(186003)(86362001)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3EB71473mG9v1BNSvIY6/e28HorxVWOiEQI6Xa50W5/EAXHJ8UFXsIyZ4+YC?=
 =?us-ascii?Q?uagryJgmzcq8AxoWGoaGNHt62XIgb5w/3Ic8vqkC0oqXPUuaF6Hs8wz/xVfL?=
 =?us-ascii?Q?M/oWJC9NqIzyafkpodD8Pl9AQ8L4DMeRrH0Aul8DLPuwGo6C4iJG4I/dEG4r?=
 =?us-ascii?Q?YRUGCb8BJl3ZJcaroKSCqBhSZribZJHeDFQjNIeg6YWaynRxwikjwjU5QQ97?=
 =?us-ascii?Q?XhG8THekiv3FLmE1dUzmW5/xPO9WSAayVdLEaGJWeV/ivnbCLKjId+JwluPr?=
 =?us-ascii?Q?J9i1pkakEM92v8jPPjnlG73VfuOPEI0Z26iSLRuEFNr0DPm5dr9SXpwpKgMT?=
 =?us-ascii?Q?pVr9ty9qayI0DxV4pUFfwOzVcfT9n8Vvqw2xHoG3th7KZDTm5R/VYQHs9ZJA?=
 =?us-ascii?Q?kapiuGg2tG7AVHzq5W7bcwFgo/QtJ+FLelF0Xw50hYXkcW79jPFQVi2BuTDi?=
 =?us-ascii?Q?v6KQUg7O5h9THXH145Hqx4G8wHuyaetGYtGxQDzdVe8HsB4PPgQR7qc2TVCi?=
 =?us-ascii?Q?TuhzyUJvqoa32wQlWnPsh1XYiLs3OuUW70Wk60CrzT7B/QUgSE8EO/t9o/qK?=
 =?us-ascii?Q?RbykBG5FxOWwMSJ12qCKUPc5Phz2nFSA3qgkF4W+Cyft7LFeqG6tGs47BQ5U?=
 =?us-ascii?Q?tJ414YEnxuJ5z+QfCglF1ZoVbIQ8nHoZF9AD0abj/VsRvFrmfMKQA5/wG9Il?=
 =?us-ascii?Q?LKMxXXuDKm4G67Cv95dQFT2e4pXSXElha1zR423m+YjSh7rDrTT50uWnd3OZ?=
 =?us-ascii?Q?ZDCsyPIPb4u0ouEBhUu9tNyZvSuZOQRa3wgB8xOF9r6vCh2IsYyRpxF+tezX?=
 =?us-ascii?Q?su77JiDLXq0wRPFqNDpymsPv5MA3VlRf+2ls6kdFCJhUzHZyt88+5guBb+Kw?=
 =?us-ascii?Q?pYyv8AEEvzB5ZeSWSXO4h8Qt1J/r1ivc/9Cd9bfGmrY8utc/ITJkTlMxX/rN?=
 =?us-ascii?Q?+Wztf13ARz8chR89Qg8F5HccSKh9t8mfShi69ClKVcn3NiR2IKyRrdCaZqbO?=
 =?us-ascii?Q?GqHU6jki/qDrdKWgepaktSfmGMli/9/HuN4CaRgFC0XJZYt1hnkY2JmQZlah?=
 =?us-ascii?Q?+wMgjLJlu55UaMdWtqKbUk0KL+O3QP9a3kA4jHTbHMLsC/sOCq/uEOjqDaDl?=
 =?us-ascii?Q?zaaYD9Gs+gKesXlLQ1z/OU9xGvrBw8GciVgiQAU2OmO2bo7jMy1X1PSr8DVh?=
 =?us-ascii?Q?We0xIu8Bubts5jwl8QQAWNrqb5ZGCPG+Q+Vg0o/Vk9VEUP2oOV/zELp6i5FE?=
 =?us-ascii?Q?NC4bg/x+X3x6c/gAtqiXODZQwQQ+1i1Bhuyj2UR47Ew91QJSU6om+oTvtq0M?=
 =?us-ascii?Q?0oYxyANZzTfslqN4jJj1ZMgQrOOPfiQT/fTBcNPkXjrYchIq139TtVukOyIU?=
 =?us-ascii?Q?yNC++ka05cIKG6Co5z0orSXs28erYG+9yLmXZkPwQJm7RLb0KUr9JVN818MH?=
 =?us-ascii?Q?frSF/ydgZIiJrgLEDJyP23SN+wtpIHPX78vAtkmAlO5ZamGB8fwnUCuQOpEb?=
 =?us-ascii?Q?YrW9uFQ1ykcdWugViEvtYKTrOYDSatPSjssPPeASIO4cMXuVHoknaR6zX8Dl?=
 =?us-ascii?Q?bMd40wO9lABtz0dL3RfUUdIzMBmJfQ+exeME44sB0H3mA1gaMdLr4VTtMh+i?=
 =?us-ascii?Q?U33T07qDfO0UdklM0qVcJP6BlpunIjUOViwKHJRfqfmeU1OeaZ/UjfwqHwyW?=
 =?us-ascii?Q?dtO1QxNFAcGhso1jz+GoUfUATMgYZU2m5PqldJh/Xsh/Q2URJHf5LXqrPQeS?=
 =?us-ascii?Q?U9mZhXdx2779jiShO5uEsSxeO/HR0zY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204a3fd7-29be-4d0f-791b-08da47cab896
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:42:03.4525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ep4kYaUdK0XK3CHbTWdrgqpG5PGnIbJE4Dj9ioEiAn6lTkMXKn09JfxtER3Xpj4MhElYuyQlX4Dmam1yaphQBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3364

This patch defines a wrapper named mptcp_sched_get_retrans(), invoke
mptcp_subflow_get_retrans() or get_subflow() of msk->sched in it.

Move sock_owned_by_me() and the fallback check code from
mptcp_subflow_get_retans() into this wrapper.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  7 +------
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 25 +++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bcaf91562e2b..b583454cfc91 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2196,17 +2196,12 @@ static void mptcp_timeout_timer(struct timer_list *=
t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup =3D NULL, *pick =3D NULL;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count =3D INT_MAX;
=20
-	sock_owned_by_me((const struct sock *)msk);
-
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
=20
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0fb2970a7a2d..3b6b9e43e261 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -632,7 +632,9 @@ void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, int *err);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 527ea07982c5..0ac80eb9a428 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -164,3 +164,28 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *m=
sk, int *err)
=20
 	return ssk;
 }
+
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_data data;
+	struct sock *ssk =3D NULL;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_retrans */
+	if (__mptcp_check_fallback(msk))
+		return -EINVAL;
+
+	if (!msk->sched) {
+		ssk =3D mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	mptcp_sched_data_init(msk, true, &data);
+	msk->sched->get_subflow(msk, &data);
+
+	return 0;
+}
--=20
2.34.1

