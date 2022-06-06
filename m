Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B2428E6
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 14:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654526518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pKuy+jGUIVghnYatYVovAm/x3/tZ8YbQItIPy4YeB6g=;
	b=StImm1xtBV9VM2tnGK0M7I1g9T5pU+r3bHIYlJ+hb4u02REn2+RuYjhKR3kXGZkkPX0tOM
	DfjOmhcagAwMrZxV4+33sb2LYzDzXHjkxTKCRqMaVyn3/iXAfO6tM6QGzjIchZalorvd3W
	G90r7QtuqZ2LwDRNywVSpEi6fO/gpcU=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-0WzzQ9kmNzmT7wicpKZ1xQ-1; Mon, 06 Jun 2022 16:41:57 +0200
X-MC-Unique: 0WzzQ9kmNzmT7wicpKZ1xQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnP0C+8RiPwV/If68AGUI9OsE+vtJkI2FQMM3OiBpi09Zv6UCFfd3xnzfOhCQ5UqlSr4trzAv7d+vN04diXC6gFHCAmqz+lL+xN0z8V616q+lyYYrtnCbrT9r9fvYvx9aGKK5wIFrWd+9s8XE+XC2jFCurLMaywD3JfVyfzQ5qR/RJG3cSnjr4xI95MYvHjGXKaXhQq9cBmZbLt13bhejATvUYgUaoo/XJOpldwLOVjKWVH1zYLV/YzwCZYHVHIWJGikHtY12OjNML8FTLMZ4DsTZ3Q318YAE/6DDPZsLuTpTuSyBDUUOIV44gBMgaa8gjE3UhUf/hiY/oJ+vv7egQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83WHn3ZZJYjV8PsMxZHlIzybq3Xsxk/FaQbLslWUMqM=;
 b=TmMWxXZadLHXtXzTlwsBQHD0gMKjITUWg5E3U/StplVczXhrdpaWQI79LZUK59SJ9lxrz3CS6+HVQ3ZX/SNNDJS5aujV3Ex2txKA5HH9bDkX6JgI2WYrsWc0ajDU58SDjsJYHisFFEpC2gMpSFcV+wDQrd3TIRPbp/T86dfXqEzWkehqyuDs3ZPI1NfGAUj2s22ytBL+UcJIlw/ogY9Mo7zP6k9TC/HyRhZmkGPPhOXjrqgSxnSxaYPgCDWO1HZmYbJU/6zT4s9I6T2Qd4jG/yLW3+Vnx6Agm+Xk2gxKsUaI3bxkQShgMeIBrWJyKCSHwmtU2kgQC2VRbASmmNJVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB3536.eurprd04.prod.outlook.com (2603:10a6:803:2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 14:41:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 14:41:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 3/7] mptcp: placeholder for subflow_push_pending
Date: Mon,  6 Jun 2022 22:41:18 +0800
Message-ID: <9073029677e1ad5e96a2d08fe60fd9ee68511c57.1654526068.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654526068.git.geliang.tang@suse.com>
References: <cover.1654526068.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c010fdc2-b8ce-485b-31ea-08da47cab4ad
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3536:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB3536954E9787FC676FE37E4AF8A29@VI1PR0402MB3536.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TDSS4666KEMQisf1HPCenksz+KCDRCqVIRUG3cNa/gBr3bM221IMhKpD8ENTqbB39MgVDckxO5UT2vp05Khtj0p37CRt9kpHDu9kqo0mI0fqkdEl/Lscv275PV/oR37oyUF5H/RKyg1g9NhgYNUnXqk2T0wvfLgrGBwZVUCcMDb9sVyW9MbFNYsPhjkPq2E2fozH2OJvYr9ltKvaV0taWfQSDoK/+tPCXvPxsAz5XQudYEF9SN9YkCxGwsIdfrdQwpRGAPwz9F6Tti1ex/9VVjKlQSu18bkpXb/vUooNl9rpUlcjALvqdyvykBfmCqgb+5w51vsBYGrj6Wjzq79lZYrEsHBMBZ18E0F4REn6DeqXsPARHNjHFoaNzAvoob1TrcOyfd7cKeBRD3wSYUcClLjpFPuzmv+bevbJCr4Q7TPRq+sbZrHPnOUFxrz8mlGpAMi8BLOKmm6MOAtflK09xPs5H0VIv7rNbTU0/o5HQlIxNx+NJpnQ26WDFI2P5/wzu/KhNj+sr20gzd1bad63u0YDPJgNfezyV7DY6RIxTN+3PlHB3ntHlYBv2DEkUwUtG7bJM+2f1cBglrn6Bp8blMFpF1YeAWSHLgYPlk/hy5nWWoxoYRTMeVB2NwySPG1Rr+WfhyDVG5vBAx6T3h9JBoQ2RePS36JR2JSTBQPYL6pG2139CeoDFrYAq3Yx/LPZafiKm7qfpbKkWRkls4RD/Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(107886003)(36756003)(66946007)(186003)(2616005)(6486002)(6512007)(26005)(6666004)(6506007)(38100700002)(66556008)(66476007)(8936002)(44832011)(316002)(86362001)(4326008)(508600001)(8676002)(5660300002)(6916009)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MoM2Lu1cXcRaUSshMZPRQ2r6RNAOWFbBXVyomdVPLal8hhvPSosYc8s1xxqZ?=
 =?us-ascii?Q?6Kx7MOs7Xbjxx8twkqTn4U25Y/Z7a0MhBUWOxQOFOS62DQZ2v/iEWmqNN5RH?=
 =?us-ascii?Q?zCtA8Q02jYeQcmtwupJeWs6Cgl7yvVOHmUUylX3F3VF8a1fx8JOZ9DBtKk2W?=
 =?us-ascii?Q?xoy32Ooiv96IAD8R0RZwIfe8XexhSZS+VVhSsMFKToFLjE+KR9rJ1MnoNmLF?=
 =?us-ascii?Q?O5kbTq0YGcToK/7THd/yQBDj32cRx+NHOZROFd7Y+oaP9uq93EY/zbszpY6L?=
 =?us-ascii?Q?M96ZZ06jmkZLzb4/FvdwUOSG+DmU8F3SADPlvFmvbm4iiIKmBNwmzYCVxA2u?=
 =?us-ascii?Q?koFIui40gTmgB0Rhs5luPrlIuNSKX6nHjDeiasdmEQkWn0LWt9ySV9tCtr5y?=
 =?us-ascii?Q?/6NwfN0m2MRIqBFFbP9yVSPdw4sXb1+hwc7yAa8Zv9DdHp8zi+Y0I70oeiz/?=
 =?us-ascii?Q?DII0FWRP4RJomehU0RjWlfd5V9KklruTXu2Sjw2sXg5mOczFd6EeuF0w6Ai7?=
 =?us-ascii?Q?RBSe0NbwhAQL0SGWFy0diwTeTjtpfFa+MA1X+rxp5BEiqrmR4TTwPT886QqS?=
 =?us-ascii?Q?vTrt9qqfsbKlltgRgPFHY6KefgX2mJCJdJqkEVKBcW+ZVWWVaZRsUIUHgj4K?=
 =?us-ascii?Q?2Dt5NDdgSi9dfWciKhAgcBnNTktudLnFqhxuRkM5pFbKn92Y9IHDW10LZHin?=
 =?us-ascii?Q?A3zdjSdattNAlZZ2QM4q2S6bUJXytLIpG+fxlSfsrmMxv0nyc8URZrVxbjCR?=
 =?us-ascii?Q?Z/XBHklHigt8H8hd8YQvgP+9WsKGFsaem/ZvPm2R3fjwcYJbvmIyDeXU+xVc?=
 =?us-ascii?Q?gLwVpHko/45usXOGOwFhKL7d4Y5D4XjFT/RlApR+g/atKh5tm1c5eApVDP+o?=
 =?us-ascii?Q?zHSNkKEXf3zTNYReK6YxeJQB8XpOxs5c03gqHqC3nQ4pzpQj1FGmuwG7ZU35?=
 =?us-ascii?Q?1XjSd1zIR1PpCI9s+eVj27diANj5giUkwYOKhvsjI2kDMr8RRC9S3EiPjimh?=
 =?us-ascii?Q?dsMNvPbjCz8B+svhiaTe582jP5gY7zO3CdQfaY10QmGiXfTR4m2OQCoa9vLw?=
 =?us-ascii?Q?M8d8AYDTzL5pF76YQpcchhJSJgRbdjG/RJVfTlvfz5nERueLaUImi/X+DPxA?=
 =?us-ascii?Q?gADDzajdy7JcYYcPF3fi+gBANXRNWOryb52CU4aV7OqBVSAtv8X1u3qZTVuq?=
 =?us-ascii?Q?hW9WN1eg7nek2tPHJMg3RLU3AFzuw7iH4iF3q3HtYZcO3PIQRashwtIMMCE7?=
 =?us-ascii?Q?mOP+Wn4BG+69yAjY9yfmorfxTGX6N5bZ/eCFwYiffYCh/RTVojspUyo0C/jI?=
 =?us-ascii?Q?oWCe9FRxjrya2IWEFrv2rJXs4+jKdoVbMGpKgOFMpwC08RdfD+N2HTaSp9wF?=
 =?us-ascii?Q?+fAMc4svm3JZawDpgO8kQyxF142in1KMh1L2uR+PrL81bLzVH8oV6cdhYGlZ?=
 =?us-ascii?Q?7kcuwjSgCjuNbnC8KL/gcFbOK6psbVOx7rDAvZzpG1Vy2m8oYU1T72FgjOgm?=
 =?us-ascii?Q?tkUKAdulVHTzIH7ZTaHap4koV70aAcl39NR3C2X8l1qE9H8pVN4rH9qs1ekc?=
 =?us-ascii?Q?j4D75t/0Qfex88gULV6JIb0zCHjnXFRAPpmkQcHRHN04eeF3+Ju36im1CZyw?=
 =?us-ascii?Q?iSejn1LCTVUugp6OwoMGOXPCmLtSD05QwiP29+DUQ6INNnSbJCTQ07copFPY?=
 =?us-ascii?Q?rIqD4sAZ88RhU221yitFrJCWAs8Tv5BifxjoQhUdFQxiwCr6A2Xhs3572p1A?=
 =?us-ascii?Q?W+Nws5fopk/VR7afXzpnlng2JbYdeYM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c010fdc2-b8ce-485b-31ea-08da47cab4ad
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:41:56.8280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVUQOlq83Ye7xxIsIm6/1/CVeEsGY1aXnP+FB7NnIIBTVYfFXF9Wt2GX6kl/y5AWW7w1cH1JzNUZEyqmTsOLKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3536

Redundant subflows are not supported in __mptcp_subflow_push_pending()
yet. This patch adds a placeholder in mptcp_sched_get_send() to pick the
first subflow for the redundant subflows case.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  8 +++++---
 net/mptcp/sched.c    | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8bf48387f9d8..bcaf91562e2b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1629,13 +1629,13 @@ static void __mptcp_subflow_push_pending(struct soc=
k *sk, struct sock *ssk)
 		info.limit =3D dfrag->data_len;
 		len =3D dfrag->data_len - dfrag->already_sent;
 		while (len > 0) {
-			int ret =3D 0;
+			int ret =3D 0, err =3D 0;
=20
 			/* the caller already invoked the packet scheduler,
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_send(mptcp_sk(sk), &err);
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -3109,11 +3109,13 @@ void __mptcp_data_acked(struct sock *sk)
=20
 void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 {
+	int err =3D 0;
+
 	if (!mptcp_send_head(sk))
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_sched_get_send(mptcp_sk(sk), &err);
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index a0585182a2b1..527ea07982c5 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -119,6 +119,7 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk=
, bool reinject,
=20
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, int *err)
 {
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 	struct sock *ssk =3D NULL;
=20
@@ -147,5 +148,19 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *m=
sk, int *err)
 	mptcp_sched_data_init(msk, false, &data);
 	msk->sched->get_subflow(msk, &data);
=20
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			/*
+			 * TODO: Redundant subflows are not supported in
+			 * __mptcp_subflow_push_pending() yet. Here's a
+			 * placeholder to pick the first subflow for the
+			 * redundant subflows case.
+			 */
+			ssk =3D subflow->tcp_sock;
+			*err =3D 0;
+			break;
+		}
+	}
+
 	return ssk;
 }
--=20
2.34.1

