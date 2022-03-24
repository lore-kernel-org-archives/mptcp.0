Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835091FC0
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 14:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648130961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+cTrNB+Zx38NOKjh2MXJ3XItIATGW7r875t9SRkEbw=;
	b=dgGBg3A/0ox+VOA6ilKRsD4JKozHYiTdv0RWZdUE9u0ly92nuGisXjQxZqZj/Zsnvsii0h
	Crw+xVBwXEDxZDNEkRZTFNEWY4q5nTAQQlp6Q9zPCaoAXQnOhSMCBRa3w81pVXOi9eWWFY
	+ALZZ8M8tKY3iez9vDEi2BASufmDRRY=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2057.outbound.protection.outlook.com [104.47.6.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-MoiYLgWgOA6DCqNOsyzhsw-1; Thu, 24 Mar 2022 15:09:20 +0100
X-MC-Unique: MoiYLgWgOA6DCqNOsyzhsw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TN+ENQFgucy/7ZVRVfN/GpfTrkmQGJ2YtRKUh1Ba1C/NA98eAJQOiYdSks6RpFyLBuPfHPhkVw+RJL8u486IqUGR3BtlgiWzs+R8sbk2ghVE/VnyT5MIbAntyuPYAeVJRa5qvbiXxJlbR5n0xyf7gk6GLnUz8SXK2/a6cmH8wFilXqc+PRNw4XOuBCB41D2t3p4aiuFyBpVykXa17d/UhwLbpSUrfBb/5hPgbMcCji1zHDzREL/CJUgxZEVgWP8TjpouYnyaYyCci7fTjLcA9Zq2kfgOU1YzLhzRcRrD0mMJLf/edEwJiwWdf8b3vYqY54Du+lmA3PXTSZ9Mk1X48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgeqUbpmagr2qR1wH2wSt7BunbNHdzc6PhQFUsw/1dE=;
 b=aK/sFjNA4V8Fs3o/cWAUI4FieKNmYKMMBwFuAp/vabiiiVWVGXX01HgdSBbn1IXmOjsg7d3ojUwB6Lay0+vmzUCrBo0kDL1rd4eXPCmFwfqv/yPDmk4D8SSy/dDOaypcLU3gpB0+FR/27fK3lJGiDG/UYezDJ7SlXUhSNBdLeGmJRKR6mhEwZOr5InscBifdCB4dNRbaqDylkE0F6ia7nfaPubwcHNZSalaZdTyzAqlEyKK40KqjJ1TcEP/LNn5vnnZ5IcdD+I1+iYM0KfRiFJd9K5vN5hOJ9uEJI6nrX2mbokZAbzm7mgYl0isftHuKiorT9q5oSOni8hAy2XAXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB3616.eurprd04.prod.outlook.com (2603:10a6:803:8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 14:09:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 14:09:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v5 2/8] mptcp: register default scheduler
Date: Thu, 24 Mar 2022 22:09:04 +0800
Message-ID: <70f565e206c415ea7d8a0cbc93fd82e1d2e3dbca.1648130637.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648130637.git.geliang.tang@suse.com>
References: <cover.1648130637.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0212.apcprd02.prod.outlook.com
 (2603:1096:201:20::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ce44a39-1573-4624-a4a2-08da0d9fe332
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3616:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB3616C45FE1CACE2817C51022F8199@VI1PR0402MB3616.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AqjrapSI8WEId0e28zovdOtv+yfRiByFOqaIzj2TKTPmJtbVse+RTzy+Y0uW6Y21eTLHkCV0cIa+8NeDLNLxmhw9fWphf4lbhEuoimubypF5ucdxesWZmQsRR6/T9xFI5qOhD9An7xj2i5SkKSlBu3HjM+9F2mf4xeOBKmqp280PCwZoI2roYXJDZ4gQVZHF8gLepi7NqQHluXgZBP5yw7a4hnIjBVnimtpu0Ze6KQ3paviGVJZOxYfGdalx48N86kOv3E495izKfjoryHaBZVBcO2yAIP1Q2kJKX7NcM3ZoxLUGidW1lj7s3sHt6yDYM2RDWIMCugKgN67WpdKQLNRjlqdcuKdjPyxNnqMot9FtRl6yZO3p0hptOzpYc+zpZcLZM1L2c7R6qCxh0D6FOKCfEo/NUxUj+oT6RHqExZGntMw3FNvRhOkUtt1HK2s9SVVHB2uTijdjAzSImT8s+ZcoomdHFbE/wZ1l5uNKrFVWHhLiEmowggDOd6zET6noy0pb8DOkHVOHTLFxmW9leWgass40xaBdklPLcVW+ifTxBZEZIahm97HcSdTubnPfgE6HuOAiaS1i0egnA7/1S87If29tqZL+Ek3BCVpBuE6uMQoo84FvIpYZfFWPrV1zakzk8ftMjtkjjhYPxwuqlm5kd0/VXKU8tlYZVjoODSQUObeNecE7z5AsswBJSBoRclZd6FGYpBt4KudCvZnHiw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(6512007)(2906002)(8936002)(6666004)(5660300002)(38100700002)(44832011)(186003)(107886003)(2616005)(86362001)(26005)(6916009)(66946007)(83380400001)(66556008)(6486002)(36756003)(8676002)(316002)(4326008)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6VeR4vYJrpTA91QYqwpEIpoYT90pQtV0Xt55AxPsAT7W0//HWyGV86PcwL4t?=
 =?us-ascii?Q?KtNP99JYNZ+z/3anQJtLpyQwIFKJY4Or2MFs797xY2bknEd2cmvKgsAD9B0o?=
 =?us-ascii?Q?+lcQA/hqvxsR3hiTTiDEi5J93YQx0qbtYztw0XUYhDTQ22RCtVbPzWWmdJ8v?=
 =?us-ascii?Q?uFSIDYw+YOqrhufrmo5InXigcaicOTcJtfToLYBr2SBcxCwkRodpWW+qL+P0?=
 =?us-ascii?Q?vq3NYyRhy4aMhQu6VFc/jwl+S3yCqCZIeNLmC2nZGfjh6SNOEA5wz7HHcyaU?=
 =?us-ascii?Q?aaDRrpnQzomUPSx/N1Fk94GaM6+BpmL6XYSgO64Ou4dZpAQNmt0eFcRC1qdi?=
 =?us-ascii?Q?7bCtyqahYReHDRUM1WOQHSAjSZ+ALvOST3XOkqdTm9sjPBqvb3QcVVcuaj8B?=
 =?us-ascii?Q?BnKn8Sds+hr8nRmjiU8xxbuqyNkp4bSUn4KPzEYhdcURl50P2dn+UishPCbe?=
 =?us-ascii?Q?YMF8sJPENEjC/H7HO2y9MLja209Pv1cd+hHY/Cp+8r+Q6HXyCgERS61Ig4/T?=
 =?us-ascii?Q?kbaKYRzgiQtM6ZhXzQ5yxR+2WzTV9Go7OEVAdbCzxYZrL5y59SzomR/rAmPz?=
 =?us-ascii?Q?CIIR8iwQG3h+Q1jfbzYDBvaH15qX1bmfgu3u30qKIYOiIpWlNk+8OAXGkNTY?=
 =?us-ascii?Q?C9fMdvePCes6ZLfDAZG/hPZfLQ0v3E6w+PNW1S0g64zdwYQsHy9u1gL4gE3k?=
 =?us-ascii?Q?KaWmfP3ZXY99YkCdRhWJFFVKjJ98n7xK94cNTU+Ga74+mFa6+upQbr6uGQ2b?=
 =?us-ascii?Q?xM0YJDEMrGh9WQMhNpydDgq+gFpMzuelMOL8N/QkLkSATubW0qn22YLoAXxy?=
 =?us-ascii?Q?Bi2Sjfm4SXrMbJvuzl82sJu7geVcFtpbU5sycCO68Qe0vkgNdx5oBQsTQvtg?=
 =?us-ascii?Q?2krYM33dUkGy58FIZB0Ot7TCpN9sIbjS3OCZvJJXO35b5PkqXsxao6SruA14?=
 =?us-ascii?Q?5CWfsj1njNVMcYH3wIE/bhIiuXc807YTjG8EYG8RCOBCLAIO0hMKM9jWyhtV?=
 =?us-ascii?Q?4Xw8eIPjI2yx/r7xUUVLcHK34P91iTaSyblvyjeoMY2MiW7e7HZXieBZYOJD?=
 =?us-ascii?Q?Lpw+4J9/TD0ERt0lMqZ4WC8FYjvgc7RQTLqtjCa7X1HTHaLLocKlOvAf0/LE?=
 =?us-ascii?Q?XSiFcLvyTJU5Td6t1xJ5UTD64CsCqCRULsHHtmWsAITeWhvruyazLtCSF3pd?=
 =?us-ascii?Q?My9gRdbWvXYFxGKsYs7lOOCCf+Md96Yx5TMH+lhK4PUGVIFbK2z1zWSXRqws?=
 =?us-ascii?Q?9nXEpGCvDBFp1/ZxRkY2Xry4NzvnecLjkKtBL2PhqRVWJvGxWGMBB2NZYBQV?=
 =?us-ascii?Q?FGbk1K3R0GwUeWrdGzueovjen1GJURVA8KXzgMPWQSaIiVPPQSXYbv5Wg7Tr?=
 =?us-ascii?Q?74Esgsyt3cfIOezY+zF9WLWEtAXOypnruZRXRXofgEEIP3yL4SbrxnEwmorx?=
 =?us-ascii?Q?7RDvqIOonFOwaKXPWUvjaV4H13bnqbpeHflv7wJmnuVHbaRFIOEIdQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce44a39-1573-4624-a4a2-08da0d9fe332
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 14:09:18.9992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjOIj00iCd1AUElFKbt4XX9UI7VgHhnvFoyL8GYZ76XOUhnG880HnMVbpqittAdrKXR9XKgLltN29ef6UUHwXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3616

This patch defined the default packet scheduler mptcp_sched_default,
registered it in mptcp_sched_init().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h |  1 +
 net/mptcp/sched.c    | 10 ++++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b1d7c8b0c112..81b77ade9511 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1424,7 +1424,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_contex=
t *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3258b740c8ee..46ac5b4528d5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -614,6 +614,7 @@ int mptcp_register_scheduler(const struct net *net,
 			     struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(const struct net *net,
 				struct mptcp_sched_ops *sched);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 void mptcp_sched_init(void);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 3798a5cefeb6..f6ace8cfe865 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -23,6 +23,12 @@ struct sched_pernet {
 	struct list_head	sched_list;
 };
=20
+static struct mptcp_sched_ops mptcp_sched_default =3D {
+	.get_subflow    =3D mptcp_subflow_get_send,
+	.name           =3D "default",
+	.owner          =3D THIS_MODULE,
+};
+
 static struct sched_pernet *sched_get_pernet(const struct net *net)
 {
 	return net_generic(net, sched_pernet_id);
@@ -70,6 +76,9 @@ void mptcp_unregister_scheduler(const struct net *net,
 {
 	struct sched_pernet *pernet =3D sched_get_pernet(net);
=20
+	if (sched =3D=3D &mptcp_sched_default)
+		return;
+
 	spin_lock(&pernet->lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&pernet->lock);
@@ -111,4 +120,5 @@ void mptcp_sched_init(void)
 {
 	if (register_pernet_subsys(&mptcp_sched_pernet_ops) < 0)
 		panic("Failed to register MPTCP sched pernet subsystem.\n");
+	mptcp_register_scheduler(&init_net, &mptcp_sched_default);
 }
--=20
2.34.1

