Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BEE7A
	for <mptcp@lists.linux.dev>; Thu, 10 Mar 2022 08:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646899791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRXaXakgZDJHdcH6ARxyeStYz7Yc0VnsUTMauqXsLnY=;
	b=WFW7tpG8qnWck3WVotIu51R/Sre5tbYWZxrAz9ncBEgTNe1rNgqCN5FNAZxpZgSwMXokif
	MTCBG2eQ3+9f/zmT2pEqfkXZgkLMiDd7Exp0UvdAMagEnBxrxXohSHZbTNRN5JYMQoMS/1
	rE6wB8Anfu+u9LXF4e8l6eyiBUlH5Fo=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2050.outbound.protection.outlook.com [104.47.10.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-qtbBUpXlMBWPgDSjlhIE_g-1; Thu, 10 Mar 2022 09:09:50 +0100
X-MC-Unique: qtbBUpXlMBWPgDSjlhIE_g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hD5jWHrqcQ2jr4hkY4eo54mhvq+xeizGHtD+xtqLpEokihNJdsVaStzgwF4kqFAKjE0yx7YOFJeaGWeiD1gk/k8hOaimu6077lpAXxFvuA5Wsrx28ADZ4CiAbc4oZh+hBrjqBbs5fxipt5U/zJ8Y1PHY2aWkk+EjmX+cZQbPZokSMoE8+8sY+wnw/uc/9uirmG2A4NNI7R1oAGFbDsY0nd6mFEdPqyB+IDHcX0SwiICzW7FQaUImwlTH5cOjDAXKfAT3Ch6kU59kieZcWN2vB0q6p9GiEDBTPog0CGgkcB4wORh+mkWtI3Q2AjkaraA1BnPDtvetOb8lNDu8Z6vwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzkEsX3djT5dENRKrhUutBJf4LfxtebVXiwoZUG3a1c=;
 b=J/+FY8Q3vA7A9+OPZelJj1NzxxGzEAMytbby7679yS7midaqCt1nLveTI7clp3lSRyY9lX5gzjT8IbT8Rh7/vo/UR3zh/1eVgzcQpg4Fxapv8dngRtvw+WuKUMIyQjG71m+b9YDaOt8cdlLgs+MafR9J+Zh2+JwkcT72VOXiQOf6q+GpAys/O2i3ILfsk3l0mS03/4z/14inc44gdAWixfTz+q9zV/+be7+UUY3B9pKvEIXsF7LORrjtVUVc5LBOKrElOtR2xLN63nocDbJ78o4/WzbByXBL8zIIEFE3mWQ/bgZFrRCCiJ0K3OvpVEi1MVNmI6VIcYnqPRPfTVRTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM4PR0401MB2259.eurprd04.prod.outlook.com (2603:10a6:200:50::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Thu, 10 Mar
 2022 08:09:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 08:09:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 2/4] mptcp: reset subflow when MP_FAIL doesn't respond
Date: Thu, 10 Mar 2022 16:09:25 +0800
Message-ID: <3ad7b8308cfb43d625b75d059db95ecdebca4caf.1646898548.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646898548.git.geliang.tang@suse.com>
References: <cover.1646898548.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0001.apcprd04.prod.outlook.com
 (2603:1096:202:2::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93e7a67c-4fbc-4582-59fc-08da026d5906
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2259:EE_
X-Microsoft-Antispam-PRVS:
	<AM4PR0401MB22592480D106FBFDA46D4C4FF80B9@AM4PR0401MB2259.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jCRDlliVeEbxgkzs68u89egU9qn0fF69OY8QEw8BESnsaDCvllZZn3oydB9p9DobGnP/zGTPAvpWzm6Fkq0uLLOn423TSIOaCNQcmGLJsio4SDftAt9Zm4cfIsD4vLR7c/hSfQaWu/RgxOgG4PT1pUVCwfz2iYKFH+L0RW2J+ufad83OgQ7m16VCvu0kareGGFR72lIndUYpA0XNHPn6OjILjzZSRgO8b3mrcgwiaiOb3g1GSA/C6/7c2xU4MMfrI3DpjstFDk+VoEPFhvAY1V0RFP+X5Fyv/KbpbNiV33Eh4IDuwybMdW/uDPOECDrIdnUQKJyr4v7aev/R2zO3x0t3Nr58CGMFxcunv4aOzA6eEQe5YAX0ykZ7d+EmWidNKzlX7HdD9WpIaiZJZ3SfmFCtQGcbpCz8RCMb1OMVNpAnGEjGVdXeGMq6pn9UlIcGJ0n/lxqvBk9idAD0HLUm6WiD21zrepCFTCKONij1/2mWWKgzVFQMoTVrhc0YXedMdx5hcMqTw17QkS2N/49bWDbR2bH+KA6RKIURY3WdVXUg/tyVm+PowkhJ+JJl/vHifAVz2J9Xu8AaSoL/myB/Y6/+qlFiSXIJBhhXvvn0cJhbvs5mrZPKtV0yiemwcx3egoTpvjNGfAgG1XuHNdSSGnuUT0nzepqIHEBqHnGefsd34NfQIOWaUy3dZHS+veXo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(2616005)(107886003)(186003)(6916009)(316002)(26005)(6666004)(6512007)(6506007)(38100700002)(508600001)(86362001)(44832011)(83380400001)(5660300002)(36756003)(4326008)(8676002)(8936002)(66946007)(6486002)(66476007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y/falia5treQmBOOTs6DxycwaC7QMaliPJg0YLD7DYJNuzCFaCwLQ/BPAeaT?=
 =?us-ascii?Q?LsbU7FR/384OphsLVfLDMX0U9Aa3dt3WUcbz/WAnZUQFRt/BgQm7KD2GWINE?=
 =?us-ascii?Q?pmovkOPl8p+6s+yAcBvsfCFJnA5D4Ld1TqiL3osq9Jr9QB3FnejOupUgoQq5?=
 =?us-ascii?Q?LAOcPXwFgXxqIATlzU8+Rb9YAHALJoMo+INUgN8x7E/Bq3+AY9VuFoeQfTua?=
 =?us-ascii?Q?L1Hp+CFCaHIZ5nYbM4LwBv20Tp+o2ESCbdn80gXrliEeSy0KylyXmw/+pLOQ?=
 =?us-ascii?Q?SHWZQEqDo1BfKth2l9iW1lN16ANKxacp8r/n25FZp956KNorXKD4uMWx8m9a?=
 =?us-ascii?Q?cWQ2zj8TzSUAWShV0nb8lDECetHR/Q6TjNQLLPtQmHfuUMAtrt/mxbytOnL1?=
 =?us-ascii?Q?u7bBx4opTbTJokeK+iPuIRBzJJhDm7HeJXoic7gW1sJEAbHa1B2X7QfikMWv?=
 =?us-ascii?Q?sx+IfAq5Cpw3QarWYb9vJ/wGUKpRZRtEXM6Xaz63qm6oVU3RoMLaP9DIlZbT?=
 =?us-ascii?Q?oKInQ4cMiXcTc8S7zcDnY3tU7FHl6SyBXuAwfHooNr9ijuoJdvOffLmtW7Yk?=
 =?us-ascii?Q?iCVs17XIYnLX+14baNqCRA3+6HAEimd7nWxKzmL0I01zsR5sve7F8IKJwpIJ?=
 =?us-ascii?Q?PvDUEt7Q277panPjSuMltlpQ3GbKSrWBIF5NV0lGRN48waN1srfpGwbE7xqR?=
 =?us-ascii?Q?wK3LsSYlea+s4TgGziX2VaTTEmWCi+NXBgh8WTfDgwOOAYhqLrMsT+1LqTQx?=
 =?us-ascii?Q?BMCTOw7027ZaY4ECdRs+cNlOdRv+wFLsHbVlV+dm7ezCTjhxKsqI6ZLcPAe1?=
 =?us-ascii?Q?VY9FdwGSqQ/ZJL5tvoMylGfQqo0ykn8gBVoFgPrvzYT/fO0xdtMARha8Hd6T?=
 =?us-ascii?Q?nXcYJl1ThWhnDyExAEGxJWRORqpwoyFrWK6OGbNsBSxyS/EJ9FzsXq6ETq1n?=
 =?us-ascii?Q?pxY8GY3Jqaa1L1Onb8veQ4WE7MspFaE/ED4o+zpLNQxjo9O6eX8dBbwkeGDj?=
 =?us-ascii?Q?8/HLIIc0X1SmgNnCJe2Tc5Biz9iIi6GqOec2N+1RJQ18dQwLr4dFLGcE2BIb?=
 =?us-ascii?Q?9W9Z1VsWJVaLUfXDucfVdAOGi2unBMNyX/cePF/gRCQaxbCIY5GN3krrIm4e?=
 =?us-ascii?Q?3n83+AXijXqpvK0dV85Rm4j9HJsVPklsnf924q1mvZg/UictWurXvtSk+IuG?=
 =?us-ascii?Q?0T/D5golgo5g8IgAqIcw0cTN/jNM4HUZTGX8LCnb9/Ohq8T0iC0nZHp0x2UV?=
 =?us-ascii?Q?keJvgGLfTfvWljMJ2s/LywI6W9bl0zx7S/Bzj2SM9XaQFBCWXrRAbvSblRFN?=
 =?us-ascii?Q?bEJXnRoooPhR4ylHZCTYVNc96+Wd0H1SFTrHJvmIa8NkiVTkHrBMuG92aLi8?=
 =?us-ascii?Q?W450Fqu4vZmWe3eV46ZLAQj1oq/RyjPUZcSeMnzqd5rmEmRJYCCLEU7gzgkN?=
 =?us-ascii?Q?leL9FVW6bjHVxaj2DP5deFnBngYLZ6x6Bpc1B1ZhzbyBNHaLtPlmHC1Ug141?=
 =?us-ascii?Q?t/TktEqMsnAA5r6OL7OcfzBUIEfQkJb7DKlpcB6l5P8f2AT921RQT3W7P15G?=
 =?us-ascii?Q?YUxz6Z4JCSPatohpCTWzg1h8NX6qJcNAz9ZpOadN/Ye8lD8yZWjh378PxO6G?=
 =?us-ascii?Q?xc0EGXHZm868aDkrkTJ2kiI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e7a67c-4fbc-4582-59fc-08da026d5906
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 08:09:49.5719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pz00K6Dai5q1w5Uqx37PLMHzKpF+4qoEc1bk6vM+5dz//wVWj9MvTnuZzWSE6VghyfKMF2NUI3hbHAjl/z+DUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2259

This patch added a new msk->flags bit MPTCP_FAIL_NO_RESPONSE, then reused
sk_timer to trigger a check if we have not received a response from the
peer after sending MP_FAIL. If the peer doesn't respond properly, reset
the subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c       |  7 +++++++
 net/mptcp/protocol.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  9 +++++++++
 4 files changed, 61 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f5f4561f332a..e3a541ffebbd 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -276,6 +276,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fai=
l_seq)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
+	struct sock *s =3D (struct sock *)msk;
=20
 	pr_debug("fail_seq=3D%llu", fail_seq);
=20
@@ -288,6 +289,12 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fa=
il_seq)
 		subflow->send_mp_fail =3D 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 		subflow->send_infinite_map =3D 1;
+	} else if (s && inet_sk_state_load(s) !=3D TCP_CLOSE) {
+		pr_debug("MP_FAIL response received");
+
+		mptcp_data_lock(s);
+		sk_stop_timer(s, &s->sk_timer);
+		mptcp_data_unlock(s);
 	}
 }
=20
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3cb975227d12..d1a62e2a1d29 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2166,9 +2166,33 @@ static void mptcp_retransmit_timer(struct timer_list=
 *t)
 	sock_put(sk);
 }
=20
+static struct mptcp_subflow_context *
+mp_fail_response_expect_subflow(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow, *ret =3D NULL;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->mp_fail_response_expect)) {
+			ret =3D subflow;
+			break;
+		}
+	}
+
+	return ret;
+}
+
 static void mptcp_timeout_timer(struct timer_list *t)
 {
 	struct sock *sk =3D from_timer(sk, t, sk_timer);
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	subflow =3D mp_fail_response_expect_subflow(msk);
+	if (subflow) {
+		bh_lock_sock(sk);
+		__set_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags);
+		bh_unlock_sock(sk);
+	}
=20
 	mptcp_schedule_work(sk);
 	sock_put(sk);
@@ -2494,6 +2518,23 @@ static void __mptcp_retrans(struct sock *sk)
 		mptcp_reset_timer(sk);
 }
=20
+static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk;
+	bool slow;
+
+	subflow =3D mp_fail_response_expect_subflow(msk);
+	if (subflow) {
+		pr_debug("MP_FAIL doesn't respond, reset the subflow");
+
+		ssk =3D mptcp_subflow_tcp_sock(subflow);
+		slow =3D lock_sock_fast(ssk);
+		mptcp_subflow_reset(ssk);
+		unlock_sock_fast(ssk, slow);
+	}
+}
+
 static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, work);
@@ -2534,6 +2575,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
=20
+	if (test_and_clear_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags))
+		mptcp_mp_fail_no_response(msk);
+
 unlock:
 	release_sock(sk);
 	sock_put(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 83f0205f0d95..bf58d3c886f5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -116,6 +116,7 @@
 #define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
+#define MPTCP_FAIL_NO_RESPONSE	6
=20
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ca2352ad20d4..d38b8089988e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -968,6 +968,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
 	bool csum_reqd =3D READ_ONCE(msk->csum_enabled);
+	struct sock *sk =3D (struct sock *)msk;
 	struct mptcp_ext *mpext;
 	struct sk_buff *skb;
 	u16 data_len;
@@ -1009,6 +1010,11 @@ static enum mapping_status get_mapping_status(struct=
 sock *ssk,
 		pr_debug("infinite mapping received");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		subflow->map_data_len =3D 0;
+		if (sk && inet_sk_state_load(sk) !=3D TCP_CLOSE) {
+			mptcp_data_lock(sk);
+			sk_stop_timer(sk, &sk->sk_timer);
+			mptcp_data_unlock(sk);
+		}
 		return MAPPING_INVALID;
 	}
=20
@@ -1219,6 +1225,9 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 					sk_eat_skb(ssk, skb);
 			} else {
 				WRITE_ONCE(subflow->mp_fail_response_expect, true);
+				sk_reset_timer((struct sock *)msk,
+					       &((struct sock *)msk)->sk_timer,
+					       jiffies + TCP_RTO_MAX);
 			}
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return true;
--=20
2.34.1

