Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59BB1B75
	for <mptcp@lists.linux.dev>; Tue, 15 Mar 2022 06:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647327540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CqFmZ02hP0661+OMsftMUJMSjklFZgV/vC+bLuwXF+k=;
	b=BsN8tOPnjLew9FWZyFpKyzSF5OccF3giD9qlIuE2XwwKfBN4tE7dR7WLMqK3g3c/vY96aQ
	ThkZdUNbPxjh4rD+8pXUgaCTXJ6VheLdKXUvw01oU2B05dzUeGwez3N6y8AnORqcXDNrnH
	1NByEEIdaDAHFb5qDMVjeNaYLG6iv3k=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-dkDslDIENaehv-suAHYD_Q-1; Tue, 15 Mar 2022 07:59:00 +0100
X-MC-Unique: dkDslDIENaehv-suAHYD_Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmJU91lMFcgSDkvlMRMh0PQuHAtp+PtGwFDLyqC4CAhJF5ahdSXA+8oO+jDt25eQD5PdjlnEMZz2hUF4Xfqa3mb/KoIuiftV6S1r6qeoYQ+MDMLes25Bcjyocg8YweqBbYHc2qSb3GyfsGzaKlxw3A0NCFIrzDZooI4kunvz67IrjimOhSJ4EmCrEmrzi8utTJztJNa3S60RWndSlaVVvVgWNVFCzu7L2veG5nLffYbrBgMHC4FaOa+d/97iPsEcH4u22ecGzqQhChif8vEYIQz5x38lI7ScKXD5iUTmJa7QZUpQm5s2PBg61se7iT11Hedz8NXl8ysoaKs6IR6biw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6H2wHPGQmhN+kkbeEzhwivGrRtEMd5qfjVz+yPcBS1E=;
 b=HcF8LnJg0XD7KP2n0lH4B2N/8qLXKlBmwn88VAv1zc6xDijYsLftQKOrSL8M3Ki+g6Fo99Xj49OV9bnbaRiYhLbaALwPxBUPmKVWuvWy6RP3D1MI1lFN6XtmIkA02yWp7vEOLv4YO0JhB15t8wfC9PsEe4IxrNRZ4eUvvyzPLmscorYn7gQDQT0PbrH3UW+CnQgyQ1QqsjIiPLCtzL9IvGExPXBz08Y+re3G5HXOTEXoIV9/8hDQclrQno7s8ldepE4u/fwc9ZASV3AJlOIduZHaubq4oWxInZtguFRSCf1hcnMHuujqLGAgtr1+lvvi8dMWxieg0SohtN5jhYWV5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB3138.eurprd04.prod.outlook.com (2603:10a6:206:7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Tue, 15 Mar
 2022 06:58:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 06:58:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 4/6] mptcp: reset subflow when MP_FAIL doesn't respond
Date: Tue, 15 Mar 2022 14:58:24 +0800
Message-ID: <c6513b0f0b34547ef0987e7dafefc2303cf7cbaa.1647327162.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647327162.git.geliang.tang@suse.com>
References: <cover.1647327162.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0234.apcprd06.prod.outlook.com
 (2603:1096:4:ac::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0878f7ba-0c41-4eb7-c308-08da0651477c
X-MS-TrafficTypeDiagnostic: AM5PR04MB3138:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB313860954B5D0C1C79267431F8109@AM5PR04MB3138.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NNmEjj4WzWZp/N8SJidkZshg/Uvz2B7H0PumWrdD2AxlRZRh345P1dptIsf/3LuG1LFOGC6Dv7t8b+jg/u1Jt2/dbvUGFWnvJrVc7q2adfiItBJD4ry8HieX7h/I1/JxQSKnj579P1eE/096Z7A0TlPNADa7GTjwNr0Pf2Q9ctfVnxnF9rRtmz2lu56+n8nRH+NsYncF1qKpq2vnd2EbbmtJj5OtbAroosxQUUSRDDIMENUsysrXXx3LoD3fxyZSTdSvZJ3RqmFyz+tuILCvmR0Cd9N0LhU+mgsgDnq87DWVvBuHuQ4wpR91Rqw+RoF/3G3LszSkcy+wBeM16gEY6+ywCnJNznMUCcVen8Vxkb8Rkwpum64dR2mq/MreG+Pg2F452bN2/EQ9Gu0yAOFtqID0zFSs0DkOAznkaIFMkBHIan4+AD3r0x/+JlazD5RCuM2+IT8EFKj7amPzbaIGMXPXImVKImxzk/hmodHW3rHwvUaIIdLuA3nW4sQ6wbTXtaaZ/Wf4rB2pny9SB2pKLrEMWaCB1LeJpZaykuvtjkFfz+vBgkjufqi0cQA/GCJ+96Yv0bsir0u/FL6KSMFRUqkcovqN8xLQzJDwc1dPKDukEQ9I03VjY3VrzN8t0MMXupHD+U4bhOgDhVDspmATPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66946007)(66556008)(6506007)(6512007)(6666004)(38100700002)(36756003)(6486002)(5660300002)(508600001)(66476007)(107886003)(83380400001)(6916009)(8936002)(2906002)(86362001)(44832011)(2616005)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X8zEQ980zTg2NrwhxB65ktqxG00RTiu1M4JOmTrcSJl84ld5c2r8BAgRGPvI?=
 =?us-ascii?Q?+Ms/+IaParQfyNEqdPsPFVuaGgCyZiXXKAUOtBYp65VF4oQMQ6mtsff9eMvm?=
 =?us-ascii?Q?BDD1d+6Y5bVAM4k0rBeXPD6VRp1U1aSoa8u38ZkLcTej9A9YnTwN/CsxvQap?=
 =?us-ascii?Q?bkqo35Jl2CfTouRjcuqyZuPMQ+ZW2GLq2qDmcDbrFJbB0t1pZudHnI5JF8hn?=
 =?us-ascii?Q?PZUGsU8h/drIl/pEtJ29TiJiq2GCURe3oH4sfnm2StERplCcnlG2RWWYyc1V?=
 =?us-ascii?Q?EY8OqdoTLTDiyjqQABTLOarlQfMU7QGjSfBvv5K9zQasyTXCCoCiRhxZGRjQ?=
 =?us-ascii?Q?uOxCLyccCO3DKoyZKki0G6s7RzIPo4CExnxj0kg7H79UsHydEfgfZq3j0t5d?=
 =?us-ascii?Q?MApDS/PlGgny2X8NZvDo6n1hFMqhvQI+8o2s2oOn8h5nNuCtw2WFr8utaGvM?=
 =?us-ascii?Q?UAq7/zia/2iBE46Us8mxCPt7Pmoq7yeqlUXpyOQcTt7QfKWzAeAIZJ0vwu3M?=
 =?us-ascii?Q?xireB1Kh50A/80mlecLJGj+TFU86j2MdHTaOaql8lW+kZenG5CF5gOqvVYYy?=
 =?us-ascii?Q?ZWHFHaZieQdktuTfhZXOLtNPpJLSCQD1tV6GUZKORnwFPnIurC7DDMNUgCQ2?=
 =?us-ascii?Q?V8/00foRYAkre0YC1Qa2log3M0TODw8xSDDj6HG3BAT17yHPBcr1dNwsG4yc?=
 =?us-ascii?Q?Pm3qGj7fr6cc/hCWRaMd6EqJXDbezx8x5F+0bLjWdyYCfOAOAMt1Rs3UK6x+?=
 =?us-ascii?Q?DvtfysdNsQZnPI0okTH4uPh+t0MIjWeeJzYFpXTT7Z9IdGfwPyzS0YOi18vW?=
 =?us-ascii?Q?tZhJDi0b2hJRxXQyjkdPuIulYACAnul7gDaWwzFWWlgscpB8BDdRdkAYKiyK?=
 =?us-ascii?Q?4M0JzUf2r7I02r529wXm5OTNYL3Go0RsPWIadcgAXkEK+Z7osYmnEd3ZKwa/?=
 =?us-ascii?Q?Q0HGGOhV5eFol3catmyY2lC3TnCdeAdHWrLxAk4kLnGzci1dv3rHxKHlAHWa?=
 =?us-ascii?Q?bW+Zeklcy7D6aqRYiihGDqN6MhFmwoUopXx+siK5n8wRe+FZxJRlvMZ5FX8G?=
 =?us-ascii?Q?Ep1PHUZ+OaC7aaueDAqxDlekY8gRoC9c2CVgy9iBbSEyJtaIuW4/0HfpBebe?=
 =?us-ascii?Q?0/wf1OA2/ftSknCgDP/lhsRyuScZJjFbBRTYv7DCT12lz5Bhi3ZtZU8ejEZj?=
 =?us-ascii?Q?MHVlYONp+B3EuAprHgQMc9xaNpmTP2xQyVbN9bcbd7G9eCBQ3Ev+9cOdgQ1f?=
 =?us-ascii?Q?KIVRTRIgLsbP6Pi4iSgo7W2VU7OED3FKi5EyMhkZk1OWoPjAYBEIrnYbZYXP?=
 =?us-ascii?Q?crwT1Dfc5VVPW0cMKgJr3svX+PGVMN4hWT+BjnI2iqs0Ej8av7VLtbqfCLOu?=
 =?us-ascii?Q?97KUhAuMTsjYzJm/i0dd+RNh+cLkUpBjDgMylFL5HSNGwXb+g0+PM4OC0znk?=
 =?us-ascii?Q?YmeakLAWDJQsAJ7Ub9OuAa37jpM5b2GA7rGT3FmpOtJiWbvcSIOkuOcGu8A+?=
 =?us-ascii?Q?wkLbSf2s2LjG2vbUzr7YCncsakrIYtPQwMmPSUyDvcwvIEd19aiCie4QxQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0878f7ba-0c41-4eb7-c308-08da0651477c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 06:58:59.0791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exEJgaxWSKXQT/V5z0+HQDV8qHnkS29/RF9gVGxxLsRQyUwj1xtMeyLzncDFtMV3qFspFxvyAI5B79nVNTmmNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3138

This patch added a new msk->flags bit MPTCP_FAIL_NO_RESPONSE, then reused
sk_timer to trigger a check if we have not received a response from the
peer after sending MP_FAIL. If the peer doesn't respond properly, reset
the subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c       |  8 ++++++++
 net/mptcp/protocol.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 11 ++++++++++
 4 files changed, 68 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f5f4561f332a..cbd6f90ffbac 100644
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
@@ -288,6 +289,13 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fa=
il_seq)
 		subflow->send_mp_fail =3D 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 		subflow->send_infinite_map =3D 1;
+	} else if (s && inet_sk_state_load(s) !=3D TCP_CLOSE) {
+		pr_debug("MP_FAIL response received");
+
+		mptcp_data_lock(s);
+		if (inet_sk_state_load(s) !=3D TCP_CLOSE)
+			sk_stop_timer(s, &s->sk_timer);
+		mptcp_data_unlock(s);
 	}
 }
=20
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 483f4d4e8e87..0e10bce5f7f1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2168,10 +2168,38 @@ static void mptcp_retransmit_timer(struct timer_lis=
t *t)
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
+static void mptcp_check_mp_fail_response(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
+
+	bh_lock_sock(sk);
+	subflow =3D mp_fail_response_expect_subflow(msk);
+	if (subflow)
+		__set_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags);
+	bh_unlock_sock(sk);
+}
+
 static void mptcp_timeout_timer(struct timer_list *t)
 {
 	struct sock *sk =3D from_timer(sk, t, sk_timer);
=20
+	mptcp_check_mp_fail_response(mptcp_sk(sk));
 	mptcp_schedule_work(sk);
 	sock_put(sk);
 }
@@ -2498,6 +2526,23 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_data_unlock(sk);
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
@@ -2538,6 +2583,9 @@ static void mptcp_worker(struct work_struct *work)
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
index ca2352ad20d4..75c824b67ca9 100644
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
@@ -1009,6 +1010,12 @@ static enum mapping_status get_mapping_status(struct=
 sock *ssk,
 		pr_debug("infinite mapping received");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		subflow->map_data_len =3D 0;
+		if (sk && inet_sk_state_load(sk) !=3D TCP_CLOSE) {
+			mptcp_data_lock(sk);
+			if (inet_sk_state_load(sk) !=3D TCP_CLOSE)
+				sk_stop_timer(sk, &sk->sk_timer);
+			mptcp_data_unlock(sk);
+		}
 		return MAPPING_INVALID;
 	}
=20
@@ -1219,6 +1226,10 @@ static bool subflow_check_data_avail(struct sock *ss=
k)
 					sk_eat_skb(ssk, skb);
 			} else {
 				WRITE_ONCE(subflow->mp_fail_response_expect, true);
+				/* The data lock is acquired in __mptcp_move_skbs() */
+				sk_reset_timer((struct sock *)msk,
+					       &((struct sock *)msk)->sk_timer,
+					       jiffies + TCP_RTO_MAX);
 			}
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return true;
--=20
2.34.1

