Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303EF2564
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 15:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649432304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYhe/nNDsO0I28KCc8Z4C8JAG8Zn5V/ba36DqcYAax0=;
	b=MZFr5dzDirUP+Y1wXvUxSbimN0jd5i+4M6HagN5yFmfZjZL0NQ0xavDAhtD+SApIf23FG0
	rEfyWC76LFPDefa4ZuvbGu8V9EfHLPIlplXR2hrZ6eDTxlCryg9mCjWyEfEm9KG54uk207
	pLVodSBiqyfos0XKnsHxhMkMHBj3GqQ=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-JVAUFDmfNZGjyQkhRR4wIQ-1; Fri, 08 Apr 2022 17:38:23 +0200
X-MC-Unique: JVAUFDmfNZGjyQkhRR4wIQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axqvpD3Sm5GngODR+bApM3LXBI2yo49Cy65Ra5h2WhwzkynXUvzTyWqpJaBK4lJr8zafl5p8VzFePrGZLaNQOAvierGpUN/YXuZa4onyBOytDEgsNLr0XoazV09l40YWMdPHU9FuACtkl53mb1JkVAHKGZRd6+ExNp1aepnkt30DXFcbzHWx23nQL53qtalSpz8DHJkBsjMgLrWOmKcNm8ldST8c39J1pVV8GlzmXwAncE31foHNKjnTiepIQGy809EUHoICZiSzKfO/nCP9WMbVA+/fXrb0aeYgsojRDgxUAN3Ijp2riBMXr2SZStfTJD9uKT34vmwvLkaOQXEtvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CP7ryZNmC5tVJuBOgkfZFQVKfkv9mvRJGXC8SswG1Xk=;
 b=f1F9NqrBW5sBvD3Y7nNw2Zn3RyXA8kESGtLDjRG3aCRV4Xqxy08w76CKf+ChQTFvhWMZA4bvqL4gmNESjUvdp98lJW7QG+u+xJsF8Nv/K2m2+6r+EA7aRBRFr1+PciqiIrFanQJ0N6kwpx4TINgd9sd3kiJsGmZXjAeAvF3qgkRkiHlw1AQEsgzdqHxAajrMb8yuK5A/EbEbyhAXbNhyIVERTmQdSpExS3Yfzy0eVKxueUInhuvReb3yNuaVmPoZgjHNlYUEnWOZhyfzuNivInbN1PtdlljEjIRoGbHPtEHii2UyzLK3jRWBEyfIFC/fwunGybgX8YVyjTbh3iEuvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB2995.eurprd04.prod.outlook.com (2603:10a6:206:9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 8 Apr
 2022 15:38:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 15:38:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 2/8] mptcp: register default scheduler
Date: Fri,  8 Apr 2022 23:37:59 +0800
Message-ID: <ac028d11ef931482d5d5f224830d9875aef50825.1649432004.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649432004.git.geliang.tang@suse.com>
References: <cover.1649432004.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0135.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 396ba470-c3f2-4c65-89df-08da1975d010
X-MS-TrafficTypeDiagnostic: AM5PR04MB2995:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB29952AAC7145FEDCEEEB3F7CF8E99@AM5PR04MB2995.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XnvYPHOUnRfjUh8jOezQMlzcRjRJMIxwLCfTdLE4LdiEgaDaxZZ88ZcOC3dFZ1oMGV6o98dIigb2LX14mUvOuNdFKcvduGvbcbkeSh5bcXyFO+yM5mQj69lQbGwYE0URVzHKvCg5faoumjaEZsIx7rajleo8r76YD4a/1BwRSEiFiF34zGA4OU1O6NKf2KCth+wMQyrgjvIL8Nc8CGXVA70Mgc22aGb26J2yjT2BeICepvkGgraTIASjD+GymOTd934uAEp2BrNTM+onCELSbXgUax244D/von9XX+EXmbiQ/Z1vSInP587njwzp8oTLfYe/MvHMUMLxodMKoK7uDPFVGCZgwNNJhrPGRUHSvIXH6K45ozrDwJPi04iDXs1wMfbT+YIUk23UKX6bGSUghFjnsS3KbqME72JYst3bXgxfDtXQ8RfRrarBzAWKsbKuOMuuHcG8tbGtBn4Fku857k6EU0MZFNXQFUAVWbkXCa/6yjQ6T3M+gyRfd9rHJrkXVXTCVP5gt4WphL2HgLYX8Ngyy52217vroPRHTgHA2NRWVDL5A3qFR4eb024+hlVptDJIXxheNGn/z5BWHvdVA9Bhwnzy1nU6zw5uO6l42E3GH3xfDA9gAV80NEJ6d15JOJxGSe4fzmhgq6sAjVKnNUGJvAMMhrr5KGQBY1PxWLRNJuCFc5AgswcuC63/bLs2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(38100700002)(2906002)(4326008)(5660300002)(44832011)(316002)(186003)(86362001)(26005)(508600001)(8676002)(107886003)(6506007)(2616005)(66946007)(83380400001)(66476007)(6486002)(36756003)(6512007)(6666004)(6916009)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xS0SvXXlIo/q91LDWzJjfezG7Ah0+ZxMOmRdvOaOx1ayO7uP2YDFcXj7dVCl?=
 =?us-ascii?Q?LWwMBhcRbE7b7LDtCLuQX+Ccl5HHvTs721QDddcY41CaNQ0p7vh9HDzADoxk?=
 =?us-ascii?Q?jsRgg5F4UMoTnUP5ByQvDUzqh/cosPsSq6w4xw29S/FKh1ZFwgAwaZ3q13tL?=
 =?us-ascii?Q?afoLqvTD/bXDi5Y4r7psvACluMNBUQbbqmafZFbNA8RLvaYCY/P0gU0EGpCc?=
 =?us-ascii?Q?EceOmB3v4Errpdlawz0uvh5vlIyC5GVre2l95KyT7X0xRxpzaBtGn66mb4R7?=
 =?us-ascii?Q?iMh3ybD53YBcn1McLu9TgkULlIFypLi6sRYuF8GXYrtbjv96OnTqfZAF0xvl?=
 =?us-ascii?Q?DJ4+BPVGm2KCeqayKbYgRuHlHQCzJGYClVPG211j0uC0khYBiHw4ONjGp9ul?=
 =?us-ascii?Q?9k6asV2liTlrPeNNHDfWaGn7XFbsu10b8ZVnpnxTEoBOvLJG6g0325N1ybNf?=
 =?us-ascii?Q?k636fmm7eK0YNqEZfm8i7lkn/EVN7a7XFYDqatctbq5r/2nWuky+e4wiAbyV?=
 =?us-ascii?Q?9iliDUHx4y3u/YXxm6GcrlvjAYR5TfIeX34gg3a6YqHYZ4JVyn6b+F9HrG4S?=
 =?us-ascii?Q?MxyyVlIAH1ngJq1JMJooNa/c0b7y5ss0vMMVu/9vGTsG3SLnSHWf+ayQS43A?=
 =?us-ascii?Q?kPJ08oBNYttp3j2Zu55eNabsPY5KsVOiFFsOVC6OXYqAMPwojM6u3MBruYe7?=
 =?us-ascii?Q?J1z/IXsa3qe76Jk9FUDP3b817RK7nBCVF7RmOMkrMvoWEL2ZwmE9xBOFJ9u2?=
 =?us-ascii?Q?IMIZYaPNIUQT7aaoE4MlUS7dvcetrMpeWaIgYQO3Ti6U8mBr/6PSuRUs2DdW?=
 =?us-ascii?Q?rHZ4HGKossSUtIG8OrAkBoD27qRvpsSy+qAKysYJL/jfh+h6/nS3jX3u5UVB?=
 =?us-ascii?Q?PNv/gJUBzasCBCmGsRAQoP/tMF96QTd0Wu8cWPECWEdjcMkFGQ5sipcc1CEP?=
 =?us-ascii?Q?Uz3z2k8XcPr59NVAG1mgbLtRBnWHNu+uzFmGQbPM+EXaYfAA+pz0Do+3MO47?=
 =?us-ascii?Q?LfVI80l577NxBdhKfGXvoNYIpjWB8TE5w2IST6ZR5EAIzs5R/Axmm4bQxvB/?=
 =?us-ascii?Q?6Xb6yR8U1xfrlJa2JUdqSWHqc0aSOIMxVCBptiUATcUzRWZdY0nbebBoNm8Z?=
 =?us-ascii?Q?RO0MwgaJQCJP14q5jjpXDJb9fYM/YwL6SonUb2204SpA5zChEjMA4iEY5IMj?=
 =?us-ascii?Q?URrFODY8OE+SZ2edbv7Qeo+EZNIRJt0xlA3vDtxMsysPoMWyVaAPn3v6ydkh?=
 =?us-ascii?Q?rM2wRCoHTOLzGX5ZiSNiG+m0DRVx1xBfUiIeVy9Mmkio+BsWK0n6a196fE1X?=
 =?us-ascii?Q?RT6WadUcF82zQHEf/Kp6Bvd34fznTTaFpUZ0S1i5brIc9yrwen3LdUmjHO8c?=
 =?us-ascii?Q?D5sjbjkMoYsRK6x78haqh1l7zij3t9FK4gVeXue3GpPRY5gSgGq02F4upb16?=
 =?us-ascii?Q?JUr1WsyHa+ZD/zx1iJNXASgrnehnZ0K4oqTPxhQOokp46yrppVE5WaH8doje?=
 =?us-ascii?Q?m/1950mHfRLjbNLgjG8SHhDn4BHXHupjheexFI+ne7wFOnUOmfa4XzENZRA9?=
 =?us-ascii?Q?+dg2sncXD4iM2zbWm5AqFUkgKxK9Uggcd55YXluIgprOBaRNvwwJhQEsiT58?=
 =?us-ascii?Q?Vyk8MEFalzsJGNjYNKxWMWObA9ilAZRk7zrWoEmGak+qXtQpmbND8THuqIOU?=
 =?us-ascii?Q?GBU30kc4UajfrokexasVJj4Mk1J1fF5sh6LyuZIvz8p8OSIQZbcudPdNtcCD?=
 =?us-ascii?Q?wwXYWc+9q6/HZaCNurHeTqyEgUIMMl8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396ba470-c3f2-4c65-89df-08da1975d010
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 15:38:22.2552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSV5IB4vZwK6YTalrMSrT9/5tU3eEFxI1fp0wQ0BRSmb20vAeYOgZ4XKvH1ai0vsHFl6iLwbfJAgps+PMs+3UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2995

This patch defines the default packet scheduler mptcp_sched_default,
register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  9 +++++++++
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 14 ++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b2c654992de0..0187059307d0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2251,6 +2251,14 @@ static struct sock *mptcp_subflow_get_retrans(struct=
 mptcp_sock *msk)
 	return min_stale_count > 1 ? backup : NULL;
 }
=20
+struct sock *mptcp_get_subflow_default(struct mptcp_sock *msk, bool retran=
s)
+{
+	if (retrans)
+		return mptcp_subflow_get_retrans(msk);
+
+	return mptcp_subflow_get_send(msk);
+}
+
 static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
 {
 	if (msk->subflow) {
@@ -3804,6 +3812,7 @@ void __init mptcp_proto_init(void)
=20
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
=20
 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) !=3D 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7cd2c1c3d25c..9ba37d0b9fcc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -611,6 +611,8 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *=
info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+struct sock *mptcp_get_subflow_default(struct mptcp_sock *msk, bool retran=
s);
+void mptcp_sched_init(void);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c5d3bbafba71..bd0beff8cac8 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -13,6 +13,12 @@
 #include <linux/spinlock.h>
 #include "protocol.h"
=20
+static struct mptcp_sched_ops mptcp_sched_default =3D {
+	.get_subflow    =3D mptcp_get_subflow_default,
+	.name           =3D "default",
+	.owner          =3D THIS_MODULE,
+};
+
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
=20
@@ -50,7 +56,15 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sch=
ed)
=20
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 {
+	if (sched =3D=3D &mptcp_sched_default)
+		return;
+
 	spin_lock(&mptcp_sched_list_lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&mptcp_sched_list_lock);
 }
+
+void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
--=20
2.34.1

