Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2027E0
	for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 13:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648734827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Kj5XlZbNODptNS6syR8znM4tOtUoRqhmP8IN9bmL/aY=;
	b=DvO7jHQZfcrlj/ZQqA/Hp6MDn19vDs4Cynztx8mSbGtSH3oYUtsq7jVgxVC4YTcCHm5oST
	31tcWD46gxqDiSoSJGzVFsfUaPn7uTJmDR/7ejg8Kvj+H2qrld900caSJGImgcjvcT9FNy
	TeLCUQZKn+Lee0frl4uj+gU6owmRo1w=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2050.outbound.protection.outlook.com [104.47.5.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-LW8DebzXOl-HrxGj3Aznvg-1; Thu, 31 Mar 2022 15:53:45 +0200
X-MC-Unique: LW8DebzXOl-HrxGj3Aznvg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqlAGlSwShVbbqU7KQ2q2BUA9AXpuoDBbuuwSJ8Xe10R8ZMkuj+vu0EtCzOnyOjGJxzTn71NCn4EGp9nd6J7WgNhwIGsvfdEAuhkenFZ1amSpppGVk459GpzljVnTbjkSu05hlas763RIzTlP6iPMbrVSJGt07WYeLomAVzXKcMozmFkEbE4g9otQXXttAjwq+aWgPsBxdjv9H4QB33n3TwjIdpGoEUZ/tXGMtafgRSaNw+gze9qxF7n8yPqsTOxbCmqiVE3Pqa9kGtURexBS7ZHNGOnDOc3Gll3uXa6Gc1k5MR2NmLzBbddtYby7//vsgLm1Ivrry/U+6MFJU7S2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4rvCTwNVur25nbrPc2HYtfAVmDJdS2Dn3tvBjoInCM=;
 b=MrKZKChvj9DH6CMRSL4Xez3sbA1prZAKKLhQHeI8vzCQaAvhTEWZNR8jrAMr2DSs1Z2dn1/AE8psposXO7kE7C+1j91ZlosDC0nbA4O5AOeR7Tk/Fs4A+HCuJUJUI2q/jxZ8w0QfotuP5joiGcgHFDO4o6vx5HFbOF6NdKyl4ltZJAFqk2JrkkNnw+wZXI6pY+Ov6Re+nxBq7M6Lo4zBBWMOErQxsBSyRX2hOnUgifTS+lQOWEL7BcIqC5bPPYLC3/tWkYolkK4X0lrZuCrQT8M2Wircc+R+8Oe7MMAlHG4ZhXw67e4P3GgejVFX+hkYu8i9fS7sO61q52EPabrpkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4112.eurprd04.prod.outlook.com (2603:10a6:803:45::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 13:53:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.023; Thu, 31 Mar 2022
 13:53:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] Squash to "selftests: bpf: add bpf_first scheduler v8"
Date: Thu, 31 Mar 2022 21:53:46 +0800
Message-ID: <763736a3cdc0113a50301e1fac31f7f5b8f05749.1648734802.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0097.jpnprd01.prod.outlook.com
 (2603:1096:405:4::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22d52356-a62d-4dde-440c-08da131ddee7
X-MS-TrafficTypeDiagnostic: VI1PR04MB4112:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4112C3AE88D29F1D6FFE4EC9F8E19@VI1PR04MB4112.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZVoWvz99/OvTzlZvVJVAV6Sw1a1CJ5F+0LzYCY1QceFNwbgp7b6zO1q7hEvg5Ht2geV7wHRR1EZTzvld+6saJcZGiS7fzDU9zMeYARL01nCb/PJZJ4O7lBZe1P8LA+/8CGmgwUNyFtxHjFC8lySFgqgo+wYlCxiL3fVx7vwD0jftQTuKScjGpTTIwBDu1HFaDSt1S30z/+ow+1n4LJdx7ngrRcRMkfZS1BgytOgBSQSCEE2T7fDnJMxXuAJ07bwnw00moJpcRRpT0SGNAmoGd4bNhNimsnQ3xkaMrQIG5a/0CbC0f2JoH/+p6Mz1aYcM1GzNYKrUM117Uls1MuVu0aV4T3C2Yxbb4Q0aAPn5HjwuCx3Eab7AaHjf7A9UgAw5NOvPGTmSbjQVEotiLhVhb+Pf2NFFqeCVtThGGku+XJq6Gb/dwik7je5jVemZ6WofryoVc3ervKus0/macdjmkea8mtC6hpUkklWxRbrFKvhnFYgSARfQhjMfXfPdkhggMm3LXJTY8L+nf+K7o32X52ECZ4g86nSBHsLztELl1Jmgub7Cbls2CNhfds50D2Hn5XrdfKe9nOu2LkWAhGnSfhpkDtdd8ciZV0lgn2COf5tV+2wHib9Jnp3feO6y2y5KmbZqzJx5b+63vfRSTaWgcDTfbmDggSkitu1oXr42VmpCv8llJi31EYdpsgEPVFn9WPxgqw7L6p1XJq/pBO/dYg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6916009)(66946007)(4326008)(8676002)(508600001)(2906002)(66476007)(66556008)(38100700002)(6486002)(86362001)(26005)(5660300002)(107886003)(83380400001)(8936002)(44832011)(186003)(2616005)(6506007)(6512007)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zti+NpcMWsi6iW4VTtPPbvcc91uzmxM51VwD4/8ZvkwskgoWHzor8/kJH8/V?=
 =?us-ascii?Q?LLMNQ0B+BIZYQN+vyA0JTqVMClPquRMhDdjSIluhcQXDQL4VUh4qJRoqSrZt?=
 =?us-ascii?Q?kM8U55M2WD/Nra93XGUd5vPmLQX+XraOdED6q6jhyCsbIFZ5Tv4DA5lYH7nn?=
 =?us-ascii?Q?ivtSNq4BDJLK9RgLNUZbk/U833halv6j0gWqbvHzi1/c9vGyPM15cWKS1ykg?=
 =?us-ascii?Q?8LpAVv8zaYhBc6NllRYO5GsbQo4o+pL2HIxNBf97cLwvRb9ANB/ESzrz5Ftl?=
 =?us-ascii?Q?dtXAD8SSNBO5sE+2LHU9R2NjsX+Eup0/cspc7FtIo/kJc14i/KYjMFrTkxmE?=
 =?us-ascii?Q?byE65viGABoq1a859IKMgoLS0LkQD1nxehfwwsvs3PvflIOolqCcPzm2Jrkv?=
 =?us-ascii?Q?0vokEi7Sg/MjppA6IMGbrkGF/7qhskUd2hagYA7sxVEZbZyGEzyLST+8Ngor?=
 =?us-ascii?Q?AMtxETlqnd8jIgoEzeaDQWW4wdY2cRGEzAqzmlxj6CIiNIZWcRxy9+WarfjK?=
 =?us-ascii?Q?rS81mri2r8cf24APuFYS0EpW+wFaq3fzRnFyG+CTQpf2h6BKjRYQ9you8Yoi?=
 =?us-ascii?Q?fOetJxSdZSJAHGW6QpCycROJN2wIAjRYJQ2kGamzTiZlV0E0axwgo/78NTsa?=
 =?us-ascii?Q?XCbjpi5vQJnCG464GhyibnCQ5QYuVyYOeCGfO8u7j/CRRR732UWD5mArVSMI?=
 =?us-ascii?Q?+TEZ9epGRTbMgDl+eWkOBHxnQaKv6vLenG4ZR8YFAnoyrzbXLWGEyZgdhlP8?=
 =?us-ascii?Q?ZO7u2F8HFMFntfbBEBe602EJ+O1bp9ws/XpEuk2jRqW/UDRMvDUacV5ZOMrK?=
 =?us-ascii?Q?kfaS9HSK3sjYNsfOH5JlIDOqOew6ox+hjQA+LZrvBRpaJ0WoVtEXINsCS0zR?=
 =?us-ascii?Q?LMwzl43eteTBVNZgZky4K61wTW2Z1la30iovMuX8HPcJTj1xSCogoI3k93Hd?=
 =?us-ascii?Q?fIo6wiVPNZVPZr+kS4TgIKNwsLfjr2LOc+966XlX2b0i58Hv+M2fU1e8HxYT?=
 =?us-ascii?Q?cYoBqquL0FDkD0dB9gntc1uybSPDSuti+v3rmtX+8e8Nf0ikS4063aj3oNLL?=
 =?us-ascii?Q?XgA/Z8yWXx2wEsMhBtgL0tonccXhfnTkf9lxBsmsIankolWEdF4vwIY47ogW?=
 =?us-ascii?Q?KXrh9Ec+8HIQWYJa88Uwfzwj5+Ody9aaAET4JlxVbU777r9RsZj5HLT7pwdr?=
 =?us-ascii?Q?g2l7kcS0RPmx44XY2+0Eq95CMnJ/Z+uB3pqYOUXlUtjmK2l2p7MDPwNI1Ybl?=
 =?us-ascii?Q?0oY6e86vFyRAvK5qIkUA/Om2YFvFNiphgvhCEZq37OJgtist3HMQMdbbyLvq?=
 =?us-ascii?Q?+K5Y3pkAJNkbQX2q/t+SpvVg+LjdB+O50SUuIJlb58BGK7jYDzvoBQ/wsjVR?=
 =?us-ascii?Q?avBZDdk4Kz4Lk+LRJWXnBS+DCzhtURt0MFBg53aNBd6nqSYswnz/ljHrgcdk?=
 =?us-ascii?Q?wSfZdtg3lYsn8cc8AlBQugJAoHghYPpC6wgL3iVtjdKZTUR6LzX7TXQIjFP+?=
 =?us-ascii?Q?jcftVagrkDk7StRtO9vffBAkULyTE+NTWU14qE6/u0Xnuaq0XNd/syTqbTHU?=
 =?us-ascii?Q?Tt4p6pFUTL7QJ7InIP3nNoiuepC3libn650akGv+C2HvxADk2QqYnZz8UD3J?=
 =?us-ascii?Q?6WWzony/2dieQhRtGNXNLIML1AI1sTl1MzWJ2587ppX3IDofeV9+1KjzEN1M?=
 =?us-ascii?Q?R2fn5Vvnid+jqfHmsnhBdcHMIuo/+CY7DvfDvqRT11SUTaGN6AlX50tjeCPF?=
 =?us-ascii?Q?n2eeDpTizFo/unLd7W3DKVISrKPfRTg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d52356-a62d-4dde-440c-08da131ddee7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 13:53:44.5242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYPiTMEui9VItlKTtY8xLYrK1JkAc+F8gs6DvnnDj90u53JD2Uc27cBhOFeJKphKL7WgMvtdCf2f+8qcjQTttw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4112

- Move mptcp_sched_ops to bpf_mptcp_helpers.h.

v2:
 - no need to update MAINTAINERS now.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_mptcp_helpers.h     | 12 ++++++++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h       | 12 ------------
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index b5a43b108982..5135eb6710e8 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -14,4 +14,16 @@ struct mptcp_sock {
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
+#define MPTCP_SCHED_NAME_MAX 16
+
+struct mptcp_sched_ops {
+	char name[MPTCP_SCHED_NAME_MAX];
+
+	void (*init)(struct mptcp_sock *msk);
+	void (*release)(struct mptcp_sock *msk);
+
+	struct sock *	(*get_subflow)(struct mptcp_sock *msk);
+	void *owner;
+};
+
 #endif
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index ee66a8bef85d..89750d732cfa 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -189,18 +189,6 @@ struct tcp_congestion_ops {
 	void *owner;
 };
=20
-#define MPTCP_SCHED_NAME_MAX 16
-
-struct mptcp_sched_ops {
-	char name[MPTCP_SCHED_NAME_MAX];
-
-	void (*init)(struct mptcp_sock *msk);
-	void (*release)(struct mptcp_sock *msk);
-
-	struct sock *	(*get_subflow)(struct mptcp_sock *msk);
-	void *owner;
-};
-
 #define min(a, b) ((a) < (b) ? (a) : (b))
 #define max(a, b) ((a) > (b) ? (a) : (b))
 #define min_not_zero(x, y) ({			\
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
index 3ae5c1eab5f5..21890a60f9c2 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2022, SUSE. */
=20
 #include <linux/bpf.h>
-#include "bpf_tcp_helpers.h"
+#include "bpf_mptcp_helpers.h"
=20
 char _license[] SEC("license") =3D "GPL";
=20
--=20
2.34.1

