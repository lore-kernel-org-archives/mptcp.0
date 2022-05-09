Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448141FB4
	for <mptcp@lists.linux.dev>; Mon,  9 May 2022 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652108236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAOcRHBZSD3mIP8jzONRIcRhQktjxIa6D2q6pe75Fu4=;
	b=EeeJTQ87XtGMcw7hqYM5/nn+EpDDgq4zN4x8hjxQI12b8AE1W0tmCm062D1tTo/xkDWubP
	rBgWcmjErLtsdnTgIwcnuFosbOg0NcM95ycvpq6Ly9g+pfI20vQ2p+WBkMK37TinwUO5ah
	pguTy3G9E0BvQCNSKOjJ7p6Xnt2e524=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-sC8I2v8MOwagaM6Xb5v4sA-1; Mon, 09 May 2022 16:57:08 +0200
X-MC-Unique: sC8I2v8MOwagaM6Xb5v4sA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lv+ptVy0LbjdDy7ogYSEx6Ko7qoA+vX/WC1UOra0igqO0Y794Dq7BqIobiiiuIHmKMhbfgoqM8PdSkl40nDpdMyBcv6IFClEySGpHul7VMFcH3EUov9rynbFBf8zkNTTfGaeXjvSRIlxARM3hRqDJ61jcKXX1kB0qx4Z1KKzqSnObID80PMm1DopddoZeNNTIlfnQEsazz6mQfB9haDtAW/ubPIC6D13Fsp1zfIcYa7Dq+uJ8bXVDhxbz7q09vYpQPKITzI2cgqYv8IcwPwaUp1+Qjq1NGu1ukfLNkYoeVCGdzCbuDLfM6v1F72Qe5bqmafM6OjML+aGDS5nafG0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPjGpUakFCHz9R6BAcFh42FQD/PR+k4t3tmFfXHrJG4=;
 b=XixR7ccvw1xMEBE1X61H/nsnjj5zHaib7hlviHC/QUpSGmdZIwor7eE3pZ73Fco8D/hQjE4st2K8Gve0KoRmLtbznPReYRdzdl1r9F8EjGA7JDrjzhEG7vWwrhFz23EP4E3uSax/WV7ILcl5QJKuGfvl8PyBj/HNszBhnFYtb8ylEQGgw52haouERgmLTy75KEXTi2gvKqGDaj4iN7ppPatzj4Jn61239RG62cs1GfyxSAm5lHIwDXcSRRqB2vaH8zemJI9iFwlQqRWq7qZ2A5s8aOaiyJZI3VGpiDN92SQEx/yiZxjNAN3ZmCbtVDyHhfmNwUFOgWDmOmE2oIHP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3924.eurprd04.prod.outlook.com (2603:10a6:208:7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.28; Mon, 9 May
 2022 14:57:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5227.022; Mon, 9 May 2022
 14:57:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 1/3] mptcp: add subflows array in sched data
Date: Mon,  9 May 2022 22:56:47 +0800
Message-ID: <79d5680d76a226415bc77d0a1bbf31b2569efa0c.1652107942.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652107942.git.geliang.tang@suse.com>
References: <cover.1652107942.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:203:d0::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c948f577-18ef-4ba5-2ec4-08da31cc2ea5
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3924:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB3924ADF3A4629F43F5BAB4E7F8C69@AM0PR0402MB3924.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s6ojZWYqi+2EJnvbbWz3XdV805oQJdXa4ZCHJ3TeLHJdGeF7B2mZ0Q1AnCTI3FoWsfr7655Zb0/F0dMzD7ihzSGTTJrBWrk4JrrPFUbdbUjySz4ed+gOxIKk1otQShVwTwEVYB04nHmguaVDgAHuwQEFc++CaY4/DI2dosdc9/sDUe8V+By4GdqM7u90rltJ7Dqippr331/iD1sRWHHCf/C6qRI3+4jcZyN0ZpXA3ttBpd77iuH9bkhWYzsMXHkpKis1XMauX4zGawe3W6VQtCOUGk5qnhaIkmX9jU8w07ipzSgLuo1NccA0Gx2YvYyqi4E86Od8Ltfo9NtEBO34KMIeil02kIGuuKWfE6BcIXM9xu/p159LDJyxRI9BrnBNljKIrt+F1+cbHB7yy7WQMoI3oBnrsUc/6M0uVrRQdTmD3fME5FggRQhfVxkhNktpF+9+mLjlnqoDGP3jCKpN1LDZwt2f9SuZSHOKiWBHBKP8bXTZBgk9hGrS6K+EfJl34niy2Yy1517ALqW0d6jjrmUcYcQ22HfSzxP+IVTJAooVW2bCq38sb07GA7FZcRz+Han0zg2OIByzWtZTYwBXmcr+k00SrfLLmaCwM/V8Wh2c25JCKiqE4LDkXKHdQlSCGNyU30iwawuvOtEkJlmiBjBh8q+ei++0xDu3+Qqfyf+SvQdRN2JsdBytuXwBLndm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(6916009)(2616005)(86362001)(107886003)(316002)(66946007)(8676002)(4326008)(186003)(44832011)(36756003)(66476007)(8936002)(38100700002)(6666004)(5660300002)(6486002)(508600001)(26005)(6512007)(6506007)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9NqY1xVXWDIxCL48G/7NEfaFb4v7g/fzKhvtFRYDXwZ+6JyQNnme9wwgrTn5?=
 =?us-ascii?Q?ZOZ4JiklRY05OkoFwZMBX2l23d9q5bKPzO9vHuAah4J8UruNy5v4LCVRhU5R?=
 =?us-ascii?Q?PLLDHD0X0gif+2vSOlxZHUKDMCvgXRAQOJxqnAUI2izmv8UCZEOJxNXVzqOv?=
 =?us-ascii?Q?whi09Ss8pydkVQUr9aIecIKaN9ITOzLn8ZiINDjApk+th+JL/ormJT+lfjx5?=
 =?us-ascii?Q?6MGeTLWLYGiMYA82or/c0WmEAyVagi2wEmnvTZnjVLRMiVr+JsIL/wd8fMqk?=
 =?us-ascii?Q?nqBrg7G9QIASaZnUxQfKqu+gwzz6XUZA0k3L/AAGTgkd+ODZBQdviYc31XLV?=
 =?us-ascii?Q?EFUHYDsHz0NR9AXjLM+KjqasdNOBMIBAXZ3G948TboSW0rHEmwKH0KcZodWi?=
 =?us-ascii?Q?VbqTXMFRGxMjseX9PX+2W71rWctUaKqdV+ELAIKy0Y+D5Pg3KM6gwhSkU/z4?=
 =?us-ascii?Q?AIaYjDCWs9P+/ycE6nn0Bm5IILLYkwILIICSly324h+deIcJCj0yEEPbJ8W4?=
 =?us-ascii?Q?6cqsMYtz8vsEo2mHiXBmEm4utP5V4m+4q5lq+mi4/psA/Oj39kP/hVTHEnMv?=
 =?us-ascii?Q?UHhgZ+tOUHUjXUKVhsimm8gp8jZS0Ur65pZF0CYFICuWvLvqwGcVCWy5VaVa?=
 =?us-ascii?Q?P9ZfAL1eByjVQSNDWjmClwvG5qPrsIP3hyAFe7SLrtMjt0HO042lJHItV1Me?=
 =?us-ascii?Q?7lZABRAUMUtRIhf3jnIimEQhjpYyGSuk4fRwct/pWb97dFdmi9bEFFCFb83q?=
 =?us-ascii?Q?sNFkKQrLRwfe0VE6T0mQlm8BOjyNpzvNz9/q3ctOMPG56szo3IrKx3X2esfK?=
 =?us-ascii?Q?Fgpw5isyDzIqVADSOOHdoo1AK4mdk77g7xvnR75tNsBRtMUtt2FxitW4SY8K?=
 =?us-ascii?Q?bjV1C2Vn950cTaPs/tFAvCGcfiWbZUY5QyEdSAFdYi951cx1dMURFJHaUe7l?=
 =?us-ascii?Q?mHW1cbMKdnGhUx84M4wDYx0qNL+pchjvRhsuUW1+vYxc4ZLIS1iUIqAuh1fg?=
 =?us-ascii?Q?CvUOhD/IkTb0pvJM5HU35qQeNvspsqcULWhbBEWRqHZjD6WdxJVOA8ObVLa9?=
 =?us-ascii?Q?cZT7th5ojnnW4wvLY0ODfpB+wb/7OOaLFGsX0GNI4Id6JCkuHy7gvIMENXa9?=
 =?us-ascii?Q?EPCwIaTyrxWtRwxCCetsGgzaRdbrY1pNNSbSKQ0mqOvms1kUzz6S/DLg9Fw2?=
 =?us-ascii?Q?z0FA+Os5Z/UzKteSWHaOosC4nRrzO1gqZQ9G+dnSEg+4Db5jyyEZ1Fs1vgby?=
 =?us-ascii?Q?kaQmdREWI4B/OolmNZrlV8h1gqXmmeES6JPKtP2fafSosXcFIkEbQC9u59xi?=
 =?us-ascii?Q?00VolQIqy1cap8O02v5Fk388zXHyaMVDj2qvvOCOWsCm4gbZhrTRAnNaTYxU?=
 =?us-ascii?Q?HTILdsh9HCcG5hj3w5/xk6mfRRqPP5OQgdnz/xPp2dVrFHBBUSjvKsCbwOb6?=
 =?us-ascii?Q?6m1sbRZ0+FDNJJMp1t2F6RnJsFxQuvivWFeZ82i+KUunYFgUzwS0dE3+T6tT?=
 =?us-ascii?Q?cfPXMNiACD6jFuobb/FrPjluIocgQDBUlV14CIqRXWZEnkXvLaIazS/aXQfG?=
 =?us-ascii?Q?lEeEamPrxhKGbnin22j0WIxxXUQQ0bZVh6i0Ljl1R7iFU7TJGpzKN2zqL0dN?=
 =?us-ascii?Q?rcJmLwpunY9YvTxaKhs4Gimrq8ksWBf0jlwB64xT8NuiYA/dyA/UkmnJQCO5?=
 =?us-ascii?Q?5+845cZP01A96qNwlZAjvjvvxq+6kqIHsyXM7ZMyGXVdboj4LqbNO22Yrluz?=
 =?us-ascii?Q?olqB5G7ie4mzOOoRYLFV7W+GKtm9Y6s=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c948f577-18ef-4ba5-2ec4-08da31cc2ea5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:57:05.5138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nd/bZvFcnuf35bM1CXynnwZdGP1c3aZmW92nNk6SFJzwtg6VVikDn3CBhd8TyNKk9ZH8hXtClX0cRPOjJzxsKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3924

This patch adds a subflow pointers array in struct mptcp_sched_data. Set
the array before invoking get_subflow(), then get it in get_subflow() in
the BPF contexts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                             |  2 ++
 net/mptcp/sched.c                               | 14 ++++++++++++++
 tools/testing/selftests/bpf/bpf_mptcp_helpers.h |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index b596ba7a8494..345f27a68eaa 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -96,10 +96,12 @@ struct mptcp_out_options {
 };
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_sched_data {
 	struct sock	*sock;
 	bool		call_again;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 3ceb721e6489..9ee2d30a6f19 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -91,9 +91,23 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 static int mptcp_sched_data_init(struct mptcp_sock *msk,
 				 struct mptcp_sched_data *data)
 {
+	struct mptcp_subflow_context *subflow;
+	int i =3D 0;
+
 	data->sock =3D NULL;
 	data->call_again =3D 0;
=20
+	mptcp_for_each_subflow(msk, subflow) {
+		if (i =3D=3D MPTCP_SUBFLOWS_MAX) {
+			pr_warn_once("too many subflows");
+			break;
+		}
+		data->contexts[i++] =3D subflow;
+	}
+
+	for (; i < MPTCP_SUBFLOWS_MAX; i++)
+		data->contexts[i++] =3D NULL;
+
 	return 0;
 }
=20
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index 4b7812c335fc..7ecd0b14666a 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -7,10 +7,12 @@
 #include "bpf_tcp_helpers.h"
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_sched_data {
 	struct sock	*sock;
 	bool		call_again;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
--=20
2.34.1

