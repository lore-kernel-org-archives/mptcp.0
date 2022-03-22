Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B220A31
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 09:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647942790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iw7s5zvEERrVINVLyzL/lgSDArs/eQmsP63FkC7pec=;
	b=jqAt8B3Md2lI5kJ5yEvpqCdulmwc8xu7eqTa7yZDSEI3TKmsrQpRlKVJE4omHzB67kmTLB
	5pDykT1KxIvrnUUKVvzrj3EAKhOOL8lqeR7cPbDGmNawbSv3TbKMceFfyAxH0VGDHCAeCr
	+o1HjF8A+6wYkYXZc/FnDj8g8ARJVgg=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2058.outbound.protection.outlook.com [104.47.9.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-ke_OE81uO0-SJQNekuiEtg-1; Tue, 22 Mar 2022 10:53:09 +0100
X-MC-Unique: ke_OE81uO0-SJQNekuiEtg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCgMui42R6QPz91002qbSFcKLwnf7JcaDG45mYXqESMb7Bj4+07y9Sdyfqc7gizgpjcaKQOYeeA1Yq3ZgkqqZMcGzMpAZhWTSxttMwNpdEPdLDauKzo8CrkEPgWxTQ73r6srtrIrgMFdYqPmSsghCxRAwbXh50kN8GUcQ7xWnCIqy7VcrKz+S1BAVPU35vcjyA5G1vQ/dtrLnt7X6caCX/mLc8q1calFtNHFt9AwobaQhV/BR1syD132RQEUL0Qahn+jZObWhXBWTv33DMd6Xao/FKE4CMGoWBCemZukRL8QNLObNlG8FJZgwBTBkkQXNvAceTuoEtlBjuidUkiLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePBzszVn2fho5okFj9sFkOOiJcmiqWhaLyfHNvwVum8=;
 b=ed2gf0FDgCKcAV8gGZLI5Y0ZiTaVSE8T3RpqhdKh4vVxZ31rNysF08W/i//IJStrHuMU0rV2EORnjRludT/xnyFnKLknKA1f7dDPKnjE9qH3XQ599MdRdeuwf2KVB2auIhqaVspc47R7V37L2/REXtMpRnmAVIsoUMxcjXBC5hx7zDXqLL8/Kifc5kzeQSaparCQZp5sexdGpg7pxou4sQd2bLkb/A3u+Pvqte5Ql1Hn3bm4Rri82qIzfcIZHG3bett90khwuO/PJK59bmx8c4nZTcQUsOOv75v4aQceITKh4ISlacwMugcdfIvm8qjIzDXoq9tD9t2ukDhJeJWH5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2282.eurprd04.prod.outlook.com (2603:10a6:3:24::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 09:53:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 09:53:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 2/8] mptcp: register default scheduler
Date: Tue, 22 Mar 2022 17:52:37 +0800
Message-ID: <d6e5cce088abd4c956edc8f47d21a723a5a77b70.1647942374.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647942374.git.geliang.tang@suse.com>
References: <cover.1647942374.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0217.apcprd06.prod.outlook.com
 (2603:1096:4:68::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b75bc23f-8e66-4c28-5e7d-08da0be9c4cf
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2282:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB228281728FF8AA84DF89074CF8179@HE1PR0401MB2282.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E0AkizyEw45hUnd3nqI/9LORefPwgH0/NMklX3hwZiwU0U6BVO5KCePAMZNipEzdIk09SNqyMgkRlheMTTWMX4IWgxJp/OWX73Aq5Lqas2PCZ8+xlw7zb4kI+Tz8cfsx0Ea6VwybxiZ7TsfuDSupu2gTo++PmNUC3XwxEv9kzvPELoJ7wNsqln7KP4YIGY5glJf9lVz9vs42QpWLYeENck8T8hyKNmULrGw1CHIESL5CKoi2D1irgdstUDs/o3DhTEyJnv6hXrFydKFYzJU9Upn97osmPGt1PVD5aPDGg+gh1ibJKU11uwPDG6jPmqT8A/NIOt/eze3ZCdkhKf86qeTxEny0r+4cZWDYmUdHSzZDoTJLxA9v2X2GcyivzlJsLhfhT0PfWqpUdJxd5hAOgXPeN3prTnm/sJkTY5oV2VSjwgEReNvlihVa6cU6oeiyN1hDzUh53PNxL+HSWCbnP+WQbBbPm19qfDqG6K8B3nGdp5pknUKUWYzqe+gKoYpWAoMqa8b/PBZCHb2kOMzZ2Ap58NGeqwQiQ9DU4yvm6cynlLXr7pfonu+2KsJfSnJZTc9uyiXTRFULkKUVZhk4caBI0p7JTW9Qb1ieKodACMcDiT0Rsq+8c9A23Z2uoRz9cSc3QOhTvy061cgKzsYAc8ZzoHSRjDTvCdWBm4nd7jiUAuizaZ03fInq+h5zW1dH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(8936002)(316002)(6916009)(4326008)(8676002)(66946007)(66476007)(66556008)(2616005)(38100700002)(86362001)(6506007)(5660300002)(6512007)(186003)(26005)(107886003)(2906002)(36756003)(44832011)(6486002)(508600001)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CYKbBX0anOZXtYvnf7ZczHmMfncY8Er0vunyF6B7UlX5YO6x4kIp+o31getf?=
 =?us-ascii?Q?i6/3SbL7KoN33pmFznDodoluLz9s2KdYHy1AoAmVXGAsKReEfEohaIV2PwCh?=
 =?us-ascii?Q?SGXsMbPmf6NlOl8Uo8/VwqamvHstxXxBKXS7cY3LAjhrVPqynudcW8tj9BEv?=
 =?us-ascii?Q?ikrliEvXXTG03dISTk6xYHC0n5TWFzt7aK1BDRCY/D48eukFJ9IpN0nLYZHC?=
 =?us-ascii?Q?ip0EuKRELAtu1MA6IMEg7LgRxjkNziJa92nQ5gKsBj+uh0SdC3PUAYEMbzGW?=
 =?us-ascii?Q?/hfpjllJcQdL6q6axhcxlkogkYSPSHxCdS7TLgjLSVyHIS5MT5kQcBrlHkJE?=
 =?us-ascii?Q?IPBTz9JGWw08YC1sQwjRCKQ5IYU/lR/1e1shO/AyLTd0Cou6Mr279bKDrLG/?=
 =?us-ascii?Q?sdeOicOP2zOxzNINTM3CHMsWHaCSiellwSj4E6YkFj9KTM9rfUcPTWp1KuwV?=
 =?us-ascii?Q?W7g3H0tzUj9NpVqCTLH8SHJSjizp9eOgURlyUNNGYa8XqQeaMQvvI2vj7AFN?=
 =?us-ascii?Q?mcamljCn8sA3sIydEwPrs3le39XnuWOc1j3CJsOKXIkrRrdLs3gREn7v4f5/?=
 =?us-ascii?Q?9y2gomFsuT2a9CjRAoayj1uCcrCLeJRpSRkB0P1UwziKTyYWLrtkznmk1AzL?=
 =?us-ascii?Q?HDYUkiPW+JP1Kf1aESLumMPNYeotnjLGx6+mpThFWT3agNsM25NB/qT3pdJW?=
 =?us-ascii?Q?AhOEWvRc9j/nAoYUK3WjthmElq8cYkdBUvWPZOQQ6TIKb/hkfZgjEAgwbGYz?=
 =?us-ascii?Q?R4De6XydJxvEdmTT3EsRDggH/iKek9G54nuCLPLfrUCTpn5pTAprO/ZiVxYU?=
 =?us-ascii?Q?U+TEBbhHvw36OjtOeh2mranmMOSIOMtX+ffLec8rpOisOI8xJ5q19w1TFCuT?=
 =?us-ascii?Q?5YLKo0mUedWF+kGxwi8Udxti5N30D6Qy5xhux6ZpD2NIZMrv8Ek8PGGvLxS7?=
 =?us-ascii?Q?X3vSV1LNd1/n9wvx7+AK68xMbiNXE48ApMTvljXWdiGZjIE781rllS7VZvrD?=
 =?us-ascii?Q?lS6F8TMPQDFwNkJpLEPjj+7NascWKg01SOrJaWJdJkL4AnKddZrdZzMAtX9T?=
 =?us-ascii?Q?KGAMXBuRlNVLUGJUWFeLzQHmWSH/aOlRjPjIW5JopxmHHhymQzNdYkN0bJVG?=
 =?us-ascii?Q?cVzbQwbCV/fBUklmHtgXmrUq6pkDFI1gUCnDiVa4AG4L6+zYaHzWGu777cK7?=
 =?us-ascii?Q?EM4i0QdIOou50cysQHyp9EMGxoCDQOirzTZqRkwK3T5fLAOBvQSUZD/+SHMc?=
 =?us-ascii?Q?g6DjgsuYNWuPWN4smzZpKPE/0E4Wj1wlHekRWsfgIUGv+h+LgfVhzl3wOKAS?=
 =?us-ascii?Q?MrmhMoG85UEX5JG2a2oHpC84rnd4YSJLeJ3ZhP6Q8G2M6jf+DrfdB9gDmcIC?=
 =?us-ascii?Q?znArbDo0CkVvt7F5QjquychwlX6Ni2B7qhYSrprSDZjWBvkfSgzJRBlO0Z7U?=
 =?us-ascii?Q?zaMTYgxgkL3J9TGA/70OyVlGb6yNx4mSx1CJMxwbLoN0FVHBqQgAwA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75bc23f-8e66-4c28-5e7d-08da0be9c4cf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 09:53:08.4181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgrrHz+zEBhLVT5QerpPpD8szZEdoaTyDPIKVxvuJc7+hN3qSbt1XV4AT2MTUcwe3+/76HBpPBoCQwHZcncm2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2282

This patch defined the default packet scheduler mptcp_sched_default,
registered it in mptcp_sched_init().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  3 ++-
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 11 +++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fbb14dfe62b3..11e19ac9d5af 100644
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
@@ -3743,6 +3743,7 @@ void __init mptcp_proto_init(void)
=20
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
=20
 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) !=3D 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 500dc7b3fde8..c186d199cf5b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -608,6 +608,8 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *=
info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+void mptcp_sched_init(void);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 53a1bdaae2f1..331e6517622a 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -53,3 +53,14 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops *=
sched)
=20
 	synchronize_rcu();
 }
+
+static struct mptcp_sched_ops mptcp_sched_default =3D {
+	.get_subflow    =3D mptcp_subflow_get_send,
+	.name           =3D "default",
+	.owner          =3D THIS_MODULE,
+};
+
+void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
--=20
2.34.1

