Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9617C
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 11:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645009532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVKAlT4T5mLlp+OG4kYh/GLLYL4uqi5uxCVGOreMTkQ=;
	b=mlHbSeM+JWNPX3ywSqv0alXyHF08EWOYAJwdKE9OmMho8ygLRKOvPD5N4kxyvfHc8pK52A
	Xb+cbZ3Pr9AWonZoWWN0LM84F4fDV/grJ7y2tVwbFUKnM3kEF43Gm/MLPe79MVanlLIAHr
	p2O4EXnGDsyIRCA+4EjCdmqvKzYEeSM=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-hTCKpFgnP6yuxRt_du-EDA-1; Wed, 16 Feb 2022 12:05:31 +0100
X-MC-Unique: hTCKpFgnP6yuxRt_du-EDA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T02LBFLh56T+kwht5/3ulECqDTEiu8/BXcvSkDwfpv70YRd9bn4PeALjqk7+AcWBy1PjcCgeYKmfYBRYPkcgaeBruzEqyaAd8ozR4mkML46TPYPglkicwW880nT6MUHpJ7lw/iN53NCQicMB0jpXGLCxiiTnI6foQAQEBxVHC5mvlI/PyTlMFZiokLnulVMZ3NYkLwSNVBcbmzw34YR799L793BMuKWYMFO5hD50GmzMed5NrzIp81yEksf4F2n36eOJkt5Gx501aOQeq//7A+bD+n9rqgEesIqLoeXJFHoH21TN9uTAdYfVYEDDF/Ev+rjoTx0RRQndgu9ox5HvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjwg1U6vo7ctwx9nr66uAajQaFgkqF40yjeUJlJqQXY=;
 b=e/ddX3EQVGv1v9OzIXaadKe5nPoilGJh6jI2RjyH/3e7b4VY6FwR0S0VUxdH2vwJ4TGI1+3zAQIkV5GRUO26hFHZcf43tg77vj0ImSJI8yr3artzqTduk8A9Ldk5UbC7sswyjyQAGFzz6kIYIjj783+wB83ryIKt6h8T+bQyxOB6WqOHN1nnS5/EiJLND0q0G1VHT0gHxMexq+369iyq3Eko6kGxjuLQZZo1jf7rI55yv3j3YyoD2rmY5GfP7tpBvj87wNZlYgY0PCXL6Seiyc0JiC6oxAaQw8OhUvfuSa84MHH4/kXF9F5c0hjan9GkIs6lJ3tDzFgX8Au5s3Yf3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7422.eurprd04.prod.outlook.com (2603:10a6:800:1af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 11:05:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 16 Feb 2022
 11:05:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next 5/6] mptcp: add MP_FAIL retrans support
Date: Wed, 16 Feb 2022 19:05:12 +0800
Message-ID: <58ecb378a4ce3963529e301c296337b173f94305.1645009373.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645009373.git.geliang.tang@suse.com>
References: <cover.1645009373.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0057.apcprd03.prod.outlook.com
 (2603:1096:202:17::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d995235-c481-424b-a01b-08d9f13c3ec4
X-MS-TrafficTypeDiagnostic: VE1PR04MB7422:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB7422D15B807D5EAE515152BEF8359@VE1PR04MB7422.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:165;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0FFo/fOJ/X2d7MFzoso7f3Pac2v6fZUU6R7zfn/YxnXS5VB8DK9iyj2d4t+hjo2YQSvfhxyR53mYmW+yldmkBVc5IuK0aOweClsuL2COVMLfPGk/sLQPynFnpIIPSW+qkLl6KeEI4JRg9GWS90uftOnPShLJW4YVkppusXnNehvuiK/lQCHCaFO+HBY8GpxP+YreuSgPgO7B++T9C4C+X5wpKQTDMiCUJ9k+9ukei1uc4XNt4RJDAshVhDTtB9leNmkdUZUiV8g0OFYaRIWoWxw6YJwchzZ3vU1v0HHvUOTmLVcogiNGuFtmEX1IpuJDTDsZOEun7MDMiMwT4llqfwVHyaTJ5NQlcd8DbTXnxfZGA0ITYQuint29kRn0a/jAzKLXukwj/lBiJVnAL8MTv/wmCXNsgxXxHrBY/1O9MAYMtSQ8Lw4vCH2IRI+UelZN+/EyByrEseDKHJWkub+CPVUalMselzMWpu5m8pty0jADZxurI7XA1S7jQ6bjCow5Q/IqcffniTPK/e2G0NwiKzSbPWvKEY/Cb50wY+yHsVNlcebJrUWVAN4ZlYH1Biud/BL6pmc4E56wWJ26v//BxjWfkG5kdyhEbb65fCQ9O7ulmUhzTTfCSdvkSydQmSm6alZ6ZMyV5xhqlB2wHbvS1w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6916009)(26005)(86362001)(2616005)(44832011)(8936002)(66946007)(66476007)(83380400001)(66556008)(4326008)(8676002)(316002)(508600001)(38100700002)(6486002)(107886003)(55236004)(2906002)(6506007)(36756003)(6666004)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wp3nSZyBVbdxTK4Jjxio3L7oavac5OHuFjRQNGzCrguP1AFxKbhOrs52ocGr?=
 =?us-ascii?Q?d3HBGKYcrGdbUEwjWS68+1zYS+8NJsRaMlFsZNJWyPlsaSgrUNHUQ1KcW9at?=
 =?us-ascii?Q?ZIqFjr/rVMQ0InOlQcFq3aYAoRq16pcoaaBHD+5L1UePbYs0y3927vGO3MYE?=
 =?us-ascii?Q?oZWeDQQv4b5PV/KqhEZwzVz6gBzcJ9gWtX5IP4VdBhlasxBn4UJVnvyRen3A?=
 =?us-ascii?Q?b7kiF7eoDO1Tcchoq7wBbpx3WI+kBFroEcYc2R7fE14dlaVPLOVSitmgCfbh?=
 =?us-ascii?Q?M1biSS1JJ1skxNQj8+OeHT6OcA3SzJ6G2cShRR8e4y0se4khs4pYkp5YfuO8?=
 =?us-ascii?Q?UdvUyOUpbuN6lFkqMJjGpQicOziOv3DSMAwxrPUOjEx4Z+Z1GAZlZ9Mun7Fh?=
 =?us-ascii?Q?2ehRvy5OWbxDE3CovG604pvb6HO5iZrMcrdrpY3wH+nGO2uEAQLlSSou4I7r?=
 =?us-ascii?Q?LONxFUi+1R/BkdM9jU2taC29F9fj3jcEyzUGIBPGUHkHOcX/aCqcpgHjfqWD?=
 =?us-ascii?Q?7r7+eTITGE8WPumiaOjVvThVShhkhD4+nzDE+a93nw8HvjlOT7CfEitDJYAQ?=
 =?us-ascii?Q?QYIEUtbyB/zsOKVol7qFLTsp+RV2iVXV94oUaVQfaezvQ0tKuZDoWEtL50fR?=
 =?us-ascii?Q?BCY10bfoiWxdZYU2sCf1S7RC/9qTNgWKswI6Uw3mSErEvkOkidp6ceuahPnx?=
 =?us-ascii?Q?mdiDyZb+5Y1DpKAaQ/86a+BA0DYLKNQSIY98ystFUTJcc0hhrbiZp2cRoE4o?=
 =?us-ascii?Q?on+LnUZk6scjWNiQuC/AUTrqyYX6w/HLQEnfZZZRA0/p3qw2QkWQ5Y5XlIaB?=
 =?us-ascii?Q?pgMQBiEp7QTWvIzplXVQ1O8sdAGP61TDl9vS8UM53tO7lKZzGLqyTRnjUHhj?=
 =?us-ascii?Q?lAbTEdfc1qHShvJsqq8IjZ2Ymw9pCKLnfXkr8kLSLaD69vYs7Eeptqg6Hwqe?=
 =?us-ascii?Q?wZBca5kOzG+D+LTOo0+7fLB9sNMyRdlZYx7aqY2jtkSBmYOEraBM6wh47MEv?=
 =?us-ascii?Q?Xm26ZrSyzLcuwWRtKCtAxifWJLLnO6dA2AhBJpKM4KlaB65DyzNxU3kv8jgu?=
 =?us-ascii?Q?RkKtlTIiILMIawoUmusUsIpMnX9boATREgQy3ElgptJIwMHBwFV5/r/CWJJr?=
 =?us-ascii?Q?AWMm7sdaiHxUGEiWcQaNt8hIFnjpTX4G3MlitypnKGUVBBNGuRf3M3KCiECz?=
 =?us-ascii?Q?T5rm+YXTiqnBYAopd2z7UsfABjRXiP1Z/ywDFiz06OdPXSrB0BKO5YwrYada?=
 =?us-ascii?Q?yXWr5+DCB1FanS9QVM5lFsIT9t9kdwcmzii9yD0CcimwBS3xDgHLJKoCBaVe?=
 =?us-ascii?Q?GB6ZZwQ/Jn6bwk6RWbcovWXPosuyXk1JzA4nGZBxuHNVFjnGAgg7xqH2oGyx?=
 =?us-ascii?Q?Vw378/xAMw01D+WUDwrpiL2nXVm7gCNvuD6lAz/rJKpvWEEyWoOvWKxAZ07c?=
 =?us-ascii?Q?XbGJlIu94nPda1TNaSFWqKGRaDJD6A7LX6arjJ3Ml3vG2YvG8nBCTq5rF6Wi?=
 =?us-ascii?Q?2ghpnDW7phLHstmZBOZEaSfMiIyQdSJArAPyp9rj8SCBXxLHYs6tIyMHaN6w?=
 =?us-ascii?Q?qLPHUI5HjDuwDzVyb+yGkaALLPBYbUrVg9z9+Dl/JR8xR/5/tJWvpbKYiBsw?=
 =?us-ascii?Q?RAKF/rY8mch3lf5wbUMB6OI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d995235-c481-424b-a01b-08d9f13c3ec4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 11:05:30.6009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNAx81xy2Cr6VqEIwC6TqHtuoN8YyJy4iFHhJUBzzmLHuGg6SLCPiLgqSR8vv1v2CKr8TMl5la4SQ0+b7wBXsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7422

Add MP_FAIL retrans support.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c       |  3 +++
 net/mptcp/protocol.c |  1 +
 net/mptcp/protocol.h |  3 +++
 net/mptcp/subflow.c  | 25 +++++++++++++++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5e133b249492..e85acdf49d95 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -311,11 +311,14 @@ void mptcp_pm_mp_fail_echoed(struct sock *sk, u64 fai=
l_seq)
 			if (tmp !=3D subflow && tmp->fail_seq =3D=3D fail_seq) {
 				struct sock *ssk =3D mptcp_subflow_tcp_sock(tmp);
=20
+				sk_stop_timer_sync(ssk, &tmp->mp_fail_timer);
 				ssk->sk_err =3D EBADMSG;
 				tcp_set_state(ssk, TCP_CLOSE);
 				subflow_sched_work_if_closed(msk, ssk);
 			}
 		}
+	} else {
+		sk_stop_timer_sync(sk, &subflow->mp_fail_timer);
 	}
 }
=20
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4599bde215b2..85f7c76aeb90 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2307,6 +2307,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct=
 sock *ssk,
 		sock_orphan(ssk);
=20
 	subflow->disposable =3D 1;
+	sk_stop_timer_sync(ssk, &subflow->mp_fail_timer);
=20
 	/* if ssk hit tcp_done(), tcp_cleanup_ulp() cleared the related ops
 	 * the ssk has been already destroyed, we just need to release the
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 595222b08fbd..9f6e8774b069 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -467,6 +467,7 @@ struct mptcp_subflow_context {
 	u8	reset_transient:1;
 	u8	reset_reason:4;
 	u8	stale_count;
+	u8	retrans_times;
=20
 	long	delegated_status;
=20
@@ -483,6 +484,8 @@ struct mptcp_subflow_context {
 	void	(*tcp_state_change)(struct sock *sk);
 	void	(*tcp_error_report)(struct sock *sk);
=20
+	struct	timer_list mp_fail_timer;
+
 	struct	rcu_head rcu;
 };
=20
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a8b5b8bf45e5..9bbc157fd713 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -27,6 +27,8 @@
=20
 #include <trace/events/mptcp.h>
=20
+#define MP_FAIL_RETRANS_MAX	3
+
 static void mptcp_subflow_ops_undo_override(struct sock *ssk);
=20
 static void SUBFLOW_REQ_INC_STATS(struct request_sock *req,
@@ -1099,9 +1101,29 @@ void subflow_sched_work_if_closed(struct mptcp_sock =
*msk, struct sock *ssk)
 	}
 }
=20
+static void mptcp_mp_fail_timer(struct timer_list *timer)
+{
+	struct mptcp_subflow_context *subflow =3D from_timer(subflow, timer, mp_f=
ail_timer);
+	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+	struct net *net =3D sock_net(ssk);
+
+	if (inet_sk_state_load(ssk) =3D=3D TCP_CLOSE)
+		return;
+
+	subflow->fail_seq =3D subflow->map_seq;
+	subflow->send_mp_fail =3D 1;
+	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
+	pr_debug("retransmit MP_FAIL %u fail_seq=3D%llu",
+		 subflow->retrans_times++, subflow->fail_seq);
+
+	if (subflow->retrans_times < MP_FAIL_RETRANS_MAX)
+		sk_reset_timer(ssk, timer, jiffies + mptcp_get_mp_fail_timeout(net));
+}
+
 static bool subflow_check_data_avail(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	struct net *net =3D sock_net(ssk);
 	enum mapping_status status;
 	struct mptcp_sock *msk;
 	struct sk_buff *skb;
@@ -1173,6 +1195,9 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 					sk_eat_skb(ssk, skb);
 			}
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
+			timer_setup(&subflow->mp_fail_timer, mptcp_mp_fail_timer, 0);
+			sk_reset_timer(ssk, &subflow->mp_fail_timer,
+				       jiffies + mptcp_get_mp_fail_timeout(net));
 			return true;
 		}
=20
--=20
2.34.1

