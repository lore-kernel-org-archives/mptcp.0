Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204A23CD
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 07:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650613384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+iyedV8b3iohtihKMOBwN9sqoDXzbUxgUG2rxbr9/I4=;
	b=agGZMy3/a/DCtHp97hRTa3i4ouShyOwMN6tWyZXv/M7BVPLIHnnBETKA3Ngb0wM3OHQWv1
	utg0U5inHlXOafHO1ITl4jIBOK1ZRaFmLl6XF39CpktMsMka/P6bHFSjANniqRC1TLlOx8
	BlI9MILu30orJ0hMwGrZ723IDQ8S0TM=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-hdeywMLdPG-ro39ncM7Mug-1; Fri, 22 Apr 2022 09:43:03 +0200
X-MC-Unique: hdeywMLdPG-ro39ncM7Mug-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqU5M86UuCQ67SVeFszBNvXkRPYspMRj3XnDYzoMPscdmh2BrxBX7MAifRoWo6Iu4Qk4+/Oa0VDTco9gbmSMNGRuihlOLuRYXTWNHL7hhPDFwpp7ehIi+O8J4eIZWYlP9SF6lUU/M/ZZst/IIw2DReFEH22Df/NSRg3YNb+nH7WGBICaTX5zQLLDrQMxvaMf8CnzPEo50bz0OlSphrQuqdK+D3wHkk3IIZxTr6uv41COZhwp1NmGPyMYm0iLN38fXzWISnouZTTu4ga8RCM2oAIAV5wCpYXmh4H0xT8rp7GbXgF5wEH7ELNeb6vPUwqJgtqDhYtiGdcWa3VfOF28CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roxgSlYhLfib1/V8Bbc8Ung4U00p4xdnvPFxXpts5hg=;
 b=KRAML14s2sUw+8lh7UlAxmUqcXbRNBmgDaCOQtxQDT4pqXb1eydDst7t9s0KuJcYTL63m8DNauyN8L8ifMOTz+xj/XwTOKIdEPhgZ0ZRndbOCTObStttfMklcw/kfPA/295lec0x9Ehuhxao+zOZpfcsllIxYQ0cv7tKi/+VlUEYHaEwju0LROEETdfTo2mt9/o132ZAR+yowEqbEapBWQGZgu6a5MqZZ5DK8S0R0mvHi0ZXV4/xlWT1UsAqnT/dnU2kaVxiifAAtYkgoGdMhnP6+CXPX4kwoRs16URNnMWwAYyODU6H/sW6vF/NFMO4sXJ6or11bXlBDEMqmlH9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7251.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 07:43:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 07:43:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 2/8] mptcp: register default scheduler
Date: Fri, 22 Apr 2022 15:42:50 +0800
Message-ID: <5ce27e38b2b13bb5ee1f9be265494912a40a7443.1650613135.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650613134.git.geliang.tang@suse.com>
References: <cover.1650613134.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0186.apcprd02.prod.outlook.com
 (2603:1096:201:21::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dfafec3-f9d3-4c86-8fc8-08da2433ba74
X-MS-TrafficTypeDiagnostic: AM8PR04MB7251:EE_
X-Microsoft-Antispam-PRVS:
	<AM8PR04MB725137D4E2B483C2E503A0C4F8F79@AM8PR04MB7251.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ar0I/O1P0u/3eHXCSWwZWhvuj6WFOKpWdckLYF5jr7/ljxk9wf37vFoPdnm4JpTexGjutkDUaGcDywlJqfCYbY5st+tdl0ju1SXvGZjq4b8NcTDjOVN/4kBQQST0Nzo0m+bjZzrq943XwKofY9AFpdEAdF4yw3zBHfAcINl3qGjr+0p448qhsT6ZHdfszP2d08atecYy+8v4JfNwvY3Wnej9E5Wz9lAYFh8XmPa18PhChGPSp6w5C11hEopQdQkp84aTEqt0I8fLaIDMJn1C+Tf9pUqhY4j1MBgwzH9O5l4BwOQ1XOUrxSEk4xa0VHMyfPBoIq7VmrhB2X8aFgmzRBwdDPuZrjYMiAdPBQkgDdfLAeZ30qSDMetDzztgFRCLstDi9N+FO+/1FD6G14W9fcdnbGT2Mhx80y6PjPnzVHez1ZNo4/a0LPNz9yjt/zLa7rAb70WIw+QTHxgz+fj5aIgFl3+rBxEVOXEENq/s8yCfeNbIqze+zZaOV04wCNDlDLbrH2swKQyrws2si03T/MDJznGkxLzQKh+UgQ8Fs95pYbOIoHWLC/j1Ue5syCN3fZV4HWKRQ7jqGjNdH9eT+qVIGm4uLG4Hd4nK7YGJx9xZ6qCZC91Dsa0zwuAGbZZlgk1VbcTobcXoBOgI+ViCysMmBGM7p+O9NhXnWMEsh7zQ9DZYEn9JHX6FF/mb2F9C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6916009)(86362001)(6512007)(6666004)(2616005)(6486002)(6506007)(508600001)(38100700002)(66946007)(26005)(107886003)(186003)(66556008)(66476007)(83380400001)(2906002)(36756003)(5660300002)(8676002)(4326008)(44832011)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cTuEAKQncKEHoLzHBNIKd3fs2pt3b+cNQDz9I+SkvChkyCxkSxuZVcg6eE/W?=
 =?us-ascii?Q?kicxOJdiglD+msMEUOwiM7B6qIiPZoC2/C0ULJVghnAevoUZcez4mdjT7rKj?=
 =?us-ascii?Q?4eG/ZZGWJLqSWfR3X35Xv9aJWJBg6HdqXGlwc7ONVc55kwnALc2OqREXa7I+?=
 =?us-ascii?Q?lpMWc3rbpfnxeV3quy166XrZnxxagW/jJSPmjuJMgxecHJ+6ojhAdy8Xl6YQ?=
 =?us-ascii?Q?U0VkcqTixKnzgf1o+4XlADmri/BZiFqlPFBww1xkmKzoUKoOafYbIbZmiyUe?=
 =?us-ascii?Q?bQjNygNBoHsabR6+MUmQg8wwX51BbkySSknq6zSIMsCCHlIuY11xfl4QAY7M?=
 =?us-ascii?Q?hC4ub2Or5RdPS6GLCPKXvDQG30AMMnFhQddh3A+1npMDEAzkFQIox/zpE+8H?=
 =?us-ascii?Q?xl5dyAwhnG9wGm42Llt/UdPDtUjCerIt368zyYpLobvuIbjVu0K8eROXgUOV?=
 =?us-ascii?Q?kTvafCggNN1dwdszpgcQmC1yMec23Ift3QrdesqHFBc+JepTRmLYmYEzuqpt?=
 =?us-ascii?Q?j1j+zcCvFE5iDxVGNtplgED5wnyakJF8NFJRyH7WPfccvBk+X/V+p4r5DD9K?=
 =?us-ascii?Q?8tJyQKWKpbtVWAHUE6fO1LnUFDoL/2R27GoSYml1mFjI1Vh0FFoSyu2aGKk/?=
 =?us-ascii?Q?p1YYIW0nfTAOkbaJ+2pIjlDNVSWeLqY6YoTA//dZDcQlAD0MJRDFA//eFrBC?=
 =?us-ascii?Q?pfxWEfxIpXqShqnk9N9VTufCB/ze//SWAZ5An5jdyjR7X9AqrSi/cC9rUXwn?=
 =?us-ascii?Q?w/MdLxuzQ6HtOSLdHTJSx6I84WDDFbIS8VqaB7Hh/Xb1yjCEULfHw/sI6yec?=
 =?us-ascii?Q?jGCplFtmugEpEoFN8I4wfYN/V346k3mRai2+wxEcD4FLgoEnc4k1W53YJMKA?=
 =?us-ascii?Q?fV1sbEsDw7e9f40AvsnAUlDMcJtz+lGcn70sWDLhxBCvRlSX4ar3rLtIBYT9?=
 =?us-ascii?Q?QAK5k71WtwZRyzi6F9je/DwdPHBIt3knyBoDE9oxxi8iAd5tz/honq9kOe52?=
 =?us-ascii?Q?/hXqPQpau/HIVpRWkNOukAQ5XA/uNTjLcY0wbjkILGLRefAMizT5277yU/Hg?=
 =?us-ascii?Q?PnMvQd03Fj868uOU7HzDBEnP4RUO/6KXNwRhaSqXB8YQtqifzj8oqCmiINl6?=
 =?us-ascii?Q?jq9JnUKaC6uLVmg8RPmZ7EBUEM4sDUzbbIUKd3F3OuF0VGSXAWckuoionj4O?=
 =?us-ascii?Q?BXD0DQiIU80wL7H5udAkVN9KbK05tG1C9mIVkbcViBlNxNj3m0OS/KJNMypY?=
 =?us-ascii?Q?XXLzwvNhvvJnOGC4ffrwLQkY8fGeFA0MdMf+kS0ZzAP5aBfV9LkcbxAkYez9?=
 =?us-ascii?Q?IztyKH0ztK6L1ArPnPSRFYpp/+XjyxuU0hPDHk/EzFPvajXTKO0xpNr/k6DU?=
 =?us-ascii?Q?w0+EfbCw0M2yvvH4CZiG1p0KdasoY+PblkTWoVbPKo2ATvHD1gpZJVCuXNpL?=
 =?us-ascii?Q?NNprQHLwmTjgHflNGxlWewJa8kgKArrRlmDneRQCFGBbrPKftayHjqGirO4z?=
 =?us-ascii?Q?OSLMy5V8RtenR769oHQel+q4ZhNCbp4QkVQsaSxGOrf3D2Vg3ZYa/g2OYYwk?=
 =?us-ascii?Q?y2rW03SnNnMulDvCO1OTVPTT/m2Rex/oCmT8IsGThYGP/gOzGMnx0RrWuEbl?=
 =?us-ascii?Q?oFoCsRPNv4u4n9yj37cnwFFVXDzZsySfyKTpJnRAC/Exv35jdCORmBOgLBKF?=
 =?us-ascii?Q?qP0Tn0J1LeW7IqHzpJJWhleCaAmup9MmvxYUBLydJTJh/JDEMT8ZOSmr/b6n?=
 =?us-ascii?Q?/BChbTtsNWtCBLKmgXyrpPI/wjSba2I=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dfafec3-f9d3-4c86-8fc8-08da2433ba74
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 07:43:01.9135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qvheBQUTO3CEoYD6k+ofNxrIDR7qTTjf9FnWYSeLMlVYqOv98iAGMOFkaZrTdlC/3J+Y7bcY+7is2ixm5lYFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7251

This patch defines the default packet scheduler mptcp_sched_default,
register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  9 +++++++++
 net/mptcp/protocol.h |  3 +++
 net/mptcp/sched.c    | 14 ++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6d59bfdd6bbd..3f2e1f18e970 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2251,6 +2251,14 @@ static struct sock *mptcp_subflow_get_retrans(struct=
 mptcp_sock *msk)
 	return min_stale_count > 1 ? backup : NULL;
 }
=20
+void mptcp_get_subflow_default(struct mptcp_sock *msk, bool reinject,
+			       struct mptcp_sched_data *data)
+{
+	data->sock =3D reinject ? mptcp_subflow_get_retrans(msk) :
+				mptcp_subflow_get_send(msk);
+	data->call_again =3D 0;
+}
+
 static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
 {
 	if (msk->subflow) {
@@ -3805,6 +3813,7 @@ void __init mptcp_proto_init(void)
=20
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
=20
 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) !=3D 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 18f8739bbf9c..e9736dfb9e27 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -624,6 +624,9 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *=
info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_get_subflow_default(struct mptcp_sock *msk, bool reinject,
+			       struct mptcp_sched_data *data);
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

