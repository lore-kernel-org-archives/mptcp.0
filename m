Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340377C
	for <mptcp@lists.linux.dev>; Wed,  8 Jun 2022 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654694813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=50oWB4t66IOGoelumkvbFxXiwJftoWhz4+nijl/+kOI=;
	b=Y9xmxYJX5wPTom4KYTnosiKGyMyTNGb07kdTrY3+knD/UqRFNHnAA3CnoKxskpSgfOLEv3
	Cqv/qgvsM7diKjfQA9VdQ9JvJ3tGOvXG4iLwWWHNZ2whfAmp2khUJuT37snP2SaOcb/6Ju
	UEwpnlZ/qOx+xYIQF7FQdlW73P/M5Ng=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2050.outbound.protection.outlook.com [104.47.6.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-shTMLfUoPhK6XkpkM9SjAw-2; Wed, 08 Jun 2022 15:26:52 +0200
X-MC-Unique: shTMLfUoPhK6XkpkM9SjAw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PROV2vePFOyJ7Rbshl9cp2yeUWKpS1ASW2rQvvJT0zV46ddQgiAHli7Y3LGKLXhfMXT0vByHZz94uAiS8LwWiqcF4nDcrx8j4VuAFlSJda3lnF4u2m8G25qkWGf5T95wRa43Ew2MsBgXc1k/fOoM47qM5UKdP4CGOCRDjMpJACtPOVkbIMmA+lsZ5lbqhMZAI8mr27vyy0kBJ8GMN/QhN3R6Zl6p0aIKMlcA9B7XvZj1tyInT3FRc9c+FdHUyPbzVwI1f9qAT0rA7qJW5BU9oO12mUxjUeU3yh6vzpuxgQCnHqnL1FMU7+wwWMWSsZGHclMJaEdvfv4nkdiWECKPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EFKJU/nakRHVljsIg6GlCOm0eqxxBI0z6SQbkRiuYw=;
 b=LF/Fhv8ulAI1PLdMHBZ+87UXlseuvVwpdCKfBtD8sXJ+yNmf8OnJIr9TEDCbtX5yxh3ObAHuX/tsTYEfSFd0i9bCKBXYBQUo2KPKRWDHNuONEIzhLce5Uuz+77rjwMDOg1m8Jww3ATn3VICUsDaw8rRGhZUYWhFI/GcazOsx6+6fG28wkSnyL2CyLcAkKSsT4u0IH/8qsurgXV8Zbddp0dtiycN06K0P3ITsxDPq+ADHZnU9TxF2AmSmlIQN27hnr1NUGKuG/QaOzshTOf1s+LI0B5PDr1fObwTMiRDoACETl9jgSU+Xj396Dn6qhhJ+7d/6DRvJL5h+lKnyicO5IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EFKJU/nakRHVljsIg6GlCOm0eqxxBI0z6SQbkRiuYw=;
 b=Wblcw8G4m1o6+EvxKqmi2NYBIxYOUuHJis0+GMYbEImWfvSFEY6uSDFrwqgJ3VtC8Pid0728SUXZ+bDaqt3Z90aVnOjkY4+CvWw3s7+CzJyNiy4VjY7rLzkxOJfRdqpenL5VKnIRdEGLX4i0J0MpNosyCBoU3Nyd6A8fguq/CHmvRFpoi/KzFsryDa745vGl9AwhRVImS17AZHphDopvp3/PjwKpUxBvydyxT2TBftWKTz/NGzvk277K9Upp+t/oMyBOXGhHdLvfETVQlJNWc03d6GvNyDv6kogpzi0PDHCw6msnsuJ9AJHTK7KyasR/RULyK+eIrnUa1w8QAqAYmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB5472.eurprd04.prod.outlook.com (2603:10a6:803:d3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 8 Jun
 2022 13:26:50 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::5082:d38e:6d50:4f7f]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::5082:d38e:6d50:4f7f%7]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 13:26:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3] mptcp: refactor MP_FAIL response
Date: Wed,  8 Jun 2022 21:26:38 +0800
Message-ID: <527414fccf0c041908900aadb2f043134a0ec09c.1654694739.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:4:7c::18) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbce26b9-5137-4d4f-8aeb-08da49528b11
X-MS-TrafficTypeDiagnostic: VI1PR04MB5472:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB54720C726ECB4930FF0A9A7EF8A49@VI1PR04MB5472.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YRF7bJHBiC7WNh39wSBuMHdrGbXYrFawe9qbVepaEV1dPWuCCnQZQAXz7rLVeACwylsZu3tMMS+Ak8GZ3vrtAqa2lhSWkookKzd+7O+WjtjRJeMC8rzSmse69jUfhy0RlfnRvb/EfXqwbSfXSZF7+9cUDfc/Xv14OvC4Jx537ZWiYfHe8BrnpYoi8eLdgjgPwLOfDHgetl0HcKLJaq1JN//Uy8Y3vk1wS5ITwi3qG1Q4eC3wBZqjz9XUWKUXQx5D4uhfWP8Z07MpK/e6oi1UIKw/bTuNkEBTG8ckch4NL3oJJ3Y0wD/t098L1RpeYMjXAQQFZkLgAvuTS5Bzxqv2SsnwG9GSu5PDvMjLqwFPiG5PbGGoVFbSm5UCVv9MD58kfsmQtiV79DZJD8SLSFpzNPgknR73ENfBsjDliCKVDs2yZbcXn7Xm+qn7JTWfjhTIGJz/4+PVdLTlDumNGNWJzRzZ/jvkKBfQMxloFgBnT9sQCASqYWENtXKl85y22vGBYo9kQS5W8+/Vt6xhvVlVy2QyaQCPzOE8GjIsaC0Jau4InfYL0twC4Zbny0E9cZV+9wJaJzrxoOqFJ+8q5HpKC0I3A3SCf3+B7nOEdLVGu2UR1CZAqJihBLr3pf/7CTA0FQb4YaZtLmPA+650ozVV46tIHGoKkcNKFuN+4A1k8KYiMq4gltcx3uMFrfzUpkxrYIwSWmCULAZAP8E+xhTAoGrUY+p1j+4PM+k0pSdF9xY1S5btqWjrb4aAT5yONkRcOG0UHj6mjpDsRR4JZrtcEQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(86362001)(38100700002)(186003)(966005)(36756003)(316002)(6506007)(6916009)(2616005)(6512007)(26005)(4326008)(508600001)(8676002)(5660300002)(66556008)(66946007)(6666004)(66476007)(44832011)(83380400001)(6486002)(8936002)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E5YLHHBixqDN1fp5nN62UDXZRHj0MwQsun7jftIgcyagIoPQsoDNFOH9kX/v?=
 =?us-ascii?Q?wC8SWJ2o9D+W/MhpVTnPOqVqAN1d6qnTP3YlELCdbRbou0zrfUUH+fB+hPEJ?=
 =?us-ascii?Q?wtvkFYtdmszBslzcrg/yYEZcjpccG9oP+Dm4eJEehFoqbBsZbXk/0GPStXnQ?=
 =?us-ascii?Q?VGEPuBjy7EOcgIsurR9ZpkqRQIhm37k7PP4uvjnPfDe3500NFtEFGWb3xQWa?=
 =?us-ascii?Q?fFpalYSaD7GO4Fe1+xujFqzs0krjWKZxWqVxkGmAjUpuNf5ZWCXQVNqWMmNj?=
 =?us-ascii?Q?lFKzYwfRreZeZX//lNR3EvYm3O/GHK6Sjjf7jqmbJrNo+YXgrH0VJ1liEwlh?=
 =?us-ascii?Q?NURHlO5VQKM6xijCEUKf6rLg02dbGKpdXGyWc30M8dOipN8eo8rKcAqV/QUV?=
 =?us-ascii?Q?NNi6bIFCMXdTDzDVhQFx0fr+Ny+nRJcOWrQVG95JWtJFBE6gFjKdXQNn+A83?=
 =?us-ascii?Q?OarkDM4BgIr2cNcmoyJzGE7OkzeZImsr94f0y0DL2dxQu2Ap8LqalFxkVzIu?=
 =?us-ascii?Q?yM+dlyYuczvY/svf/2JoNefDUsGjqGIB4wCHy3eZQadmXO2WXILR94bCIpcg?=
 =?us-ascii?Q?IkEg3AqYF4O0E2Co7KFDYsuewFhbdWU++Z6a8jqcPSZjRLJR+BnRT3DSczi7?=
 =?us-ascii?Q?5/tM6FscgWvoKAm+iSRO57vwKANQVL0C5odRkyDHG/Gi9rTH4O7aI4fOfbqk?=
 =?us-ascii?Q?c0CncYlVJCTkOiIDHFkbJuBfDxL0tjatJPe9DWZmb3spelq+DnBNi7xbVB4V?=
 =?us-ascii?Q?/wuczoUa9kW+JVwOJJtKS8GnRLgpP5J43PcZHMzqr/bJgc988+31/6FRmFql?=
 =?us-ascii?Q?4aZf4WowWLfEH5fZQ6noSe8Udy75SaZJIhCvLROrqKQ6UDCRaMGob4CT/4lx?=
 =?us-ascii?Q?5N/94njIc9LPgiYW9aY4hDfUA5xKXDophPZNCgv5ooLRcFhk9Vye2nrOwdzB?=
 =?us-ascii?Q?1kShlmJhTFispNrx43z4TZfNYbtp1U8HF9TE6qbjZ7TAX1hqUi4FCxnrCL7i?=
 =?us-ascii?Q?+LdSQWlcALBUH3IBkKvcv7QJY7PJdLWurXeFa/IS3Uk2jEQYLrHwe23ilD50?=
 =?us-ascii?Q?Reqk+SvnRjdPA0l7+WcH0BgVEn3w/5I8H+xYONlhBAD3ltPKRtER1/JIcaLJ?=
 =?us-ascii?Q?rmp1ZqtXbMmE0EkzDymXV7aTUtTxeB+CFDRfckmFhUHWq0xJM0Bih14WoTIz?=
 =?us-ascii?Q?IqkMPYU9BenghWFkXbz783bsP/RPK0H2d/f24SctmvwOCXMXz4glxcOe9flY?=
 =?us-ascii?Q?/GddLZ37bCoqznwFdarm0ykRES9gl6wjOROqPk4F++b+zFqAnNsM+xQZe8wF?=
 =?us-ascii?Q?c257+Ye4trvm7Hu3YEdoPpsoGihzKx12lpTHf61XUhmrsf1RW7jC5Rl533rg?=
 =?us-ascii?Q?1MPaJ09YJVDRBPyKw1m46vNnkrthmRv5/Qaf7nSfC6niR1udFLY2WgxG/P+2?=
 =?us-ascii?Q?ymEwlHhA5WMZUr6fxC1IosXPYuuG81irFKBohqZHhpF9dTNZsLIH26zIl4Lj?=
 =?us-ascii?Q?L/cx5PQ7JK8YHfRgwJGlcUAX292j1zzdlgZoER+gAo6cQzaLMbirdCRdJPAR?=
 =?us-ascii?Q?E7IqkbUH1NlzlFbd+uyMI8/KSng6g/BrBRnzLTgnmfPgigr0zMEkOOaGuApi?=
 =?us-ascii?Q?tTNybUGfMlJqMlmC/y43W2EVKqprzjs/Sx6yIk2hZlImQlJeid4UD9YOBfiM?=
 =?us-ascii?Q?tg2Obh3/xomAyrIHUfn7gqJb0bzRTuyWZ1kSoezWKHU4zvla+8qPFtbPETWZ?=
 =?us-ascii?Q?Udg/9aWW14cK1v+SfqyOO9Ilh5uHr0A=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbce26b9-5137-4d4f-8aeb-08da49528b11
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 13:26:49.8956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAzEcv/19dwIdyy80EeIEoW3wNTHl137Gb1egyXY6ToQR8pgjdXEMt9e/PKajszMG/mmte5DClVb03fImfBmdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5472

This patch refactors the MP_FAIL response logic.

Add fail_sock in struct mptcp_sock to record the MP_FAIL subflow. Add
fail_timeout in mptcp_sock to record the MP_FAIL timestamp. Check them
in mptcp_mp_fail_no_response() to reset the subflow when MP_FAIL response
timeout occurs.

Drop mp_fail_response_expect flag in struct mptcp_subflow_context and
the code to reuse sk_timer.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/281
Fixes: d9fb797046c5 ("mptcp: Do not traverse the subflow connection list wi=
thout lock")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 v3:
 - update as Paolo suggested.
---
 net/mptcp/pm.c       |  7 ++-----
 net/mptcp/protocol.c | 26 ++++++--------------------
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 12 +++---------
 4 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 59a85220edc9..c780e5d11b89 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -299,23 +299,20 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 f=
ail_seq)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
-	struct sock *s =3D (struct sock *)msk;
=20
 	pr_debug("fail_seq=3D%llu", fail_seq);
=20
 	if (!READ_ONCE(msk->allow_infinite_fallback))
 		return;
=20
-	if (!READ_ONCE(subflow->mp_fail_response_expect)) {
+	if (!msk->fail_sock) {
 		pr_debug("send MP_FAIL response and infinite map");
=20
 		subflow->send_mp_fail =3D 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 		subflow->send_infinite_map =3D 1;
-	} else if (!sock_flag(sk, SOCK_DEAD)) {
+	} else {
 		pr_debug("MP_FAIL response received");
-
-		sk_stop_timer(s, &s->sk_timer);
 	}
 }
=20
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d6aef4b13b8a..9ffc96ddce01 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2167,21 +2167,6 @@ static void mptcp_retransmit_timer(struct timer_list=
 *t)
 	sock_put(sk);
 }
=20
-static struct mptcp_subflow_context *
-mp_fail_response_expect_subflow(struct mptcp_sock *msk)
-{
-	struct mptcp_subflow_context *subflow, *ret =3D NULL;
-
-	mptcp_for_each_subflow(msk, subflow) {
-		if (READ_ONCE(subflow->mp_fail_response_expect)) {
-			ret =3D subflow;
-			break;
-		}
-	}
-
-	return ret;
-}
-
 static void mptcp_timeout_timer(struct timer_list *t)
 {
 	struct sock *sk =3D from_timer(sk, t, sk_timer);
@@ -2507,18 +2492,17 @@ static void __mptcp_retrans(struct sock *sk)
=20
 static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
 {
-	struct mptcp_subflow_context *subflow;
-	struct sock *ssk;
+	struct sock *ssk =3D msk->fail_sock;
 	bool slow;
=20
-	subflow =3D mp_fail_response_expect_subflow(msk);
-	if (subflow) {
+	if (ssk && time_after(jiffies, msk->fail_timeout)) {
 		pr_debug("MP_FAIL doesn't respond, reset the subflow");
=20
-		ssk =3D mptcp_subflow_tcp_sock(subflow);
 		slow =3D lock_sock_fast(ssk);
 		mptcp_subflow_reset(ssk);
 		unlock_sock_fast(ssk, slow);
+
+		msk->fail_sock =3D NULL;
 	}
 }
=20
@@ -2589,6 +2573,8 @@ static int __mptcp_init_sock(struct sock *sk)
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	WRITE_ONCE(msk->allow_infinite_fallback, true);
 	msk->recovery =3D false;
+	msk->fail_sock =3D NULL;
+	msk->fail_timeout =3D 0;
=20
 	mptcp_pm_data_init(msk);
=20
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d406b5afbee4..f0748870ce3e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -306,6 +306,8 @@ struct mptcp_sock {
=20
 	u32 setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
+	struct sock	*fail_sock;
+	unsigned long	fail_timeout;
 };
=20
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
@@ -468,7 +470,6 @@ struct mptcp_subflow_context {
 		local_id_valid : 1, /* local_id is correctly initialized */
 		valid_csum_seen : 1;        /* at least one csum validated */
 	enum mptcp_data_avail data_avail;
-	bool	mp_fail_response_expect;
 	bool	scheduled;
 	u32	remote_nonce;
 	u64	thmac;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8841e8cd9ad8..8209301dc8de 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -974,7 +974,6 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
 	bool csum_reqd =3D READ_ONCE(msk->csum_enabled);
-	struct sock *sk =3D (struct sock *)msk;
 	struct mptcp_ext *mpext;
 	struct sk_buff *skb;
 	u16 data_len;
@@ -1016,9 +1015,6 @@ static enum mapping_status get_mapping_status(struct =
sock *ssk,
 		pr_debug("infinite mapping received");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		subflow->map_data_len =3D 0;
-		if (!sock_flag(ssk, SOCK_DEAD))
-			sk_stop_timer(sk, &sk->sk_timer);
-
 		return MAPPING_INVALID;
 	}
=20
@@ -1238,11 +1234,9 @@ static bool subflow_check_data_avail(struct sock *ss=
k)
 				tcp_send_active_reset(ssk, GFP_ATOMIC);
 				while ((skb =3D skb_peek(&ssk->sk_receive_queue)))
 					sk_eat_skb(ssk, skb);
-			} else if (!sock_flag(ssk, SOCK_DEAD)) {
-				WRITE_ONCE(subflow->mp_fail_response_expect, true);
-				sk_reset_timer((struct sock *)msk,
-					       &((struct sock *)msk)->sk_timer,
-					       jiffies + TCP_RTO_MAX);
+			} else {
+				msk->fail_sock =3D ssk;
+				msk->fail_timeout =3D jiffies + TCP_RTO_MAX;
 			}
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return true;
--=20
2.35.3

