Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF67C
	for <mptcp@lists.linux.dev>; Wed,  8 Jun 2022 06:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654670196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qzPKsmwtXxFyyug5uxR6es0GpEoKrX/XbMsUewL9j9o=;
	b=S/A2gRRW7KsxWlRap79pLGFAWK5YPAhBZFi75RpXD0xiHWLERk/s/uNYi5qI6IMMXNJ3vo
	Hlp/a+4JRdPAYL1w/+gJwsot8qHUT52FpcpwLTWPwoTJHvOZRPmrxrp2FXShi600yaKsRy
	342q1VSg41yUDZnQLFrxyIeGhp1/KpI=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-C7rLI63oPp6iR_30UszJMQ-1; Wed, 08 Jun 2022 08:36:35 +0200
X-MC-Unique: C7rLI63oPp6iR_30UszJMQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJW9LCqVTseAHlYF11dqU0L1d+Tg56zoEuHT3/4JFavfS9MO8h8vF8pZ0H1dW7p9nAQscTR59gAQ/OVqhSRYVQcc+TisOoqq70M8cHWC28/FDmmFjuhwPYm3YY+6kYjptxGYnlbnjL9d6kw2tZl+nYs5t3dGfbA8WJIs6DSYMyxdKMI1A2aSvX0tXjOd0R+1CgAIpZSg4fGZyffQJvvn3gQDD6tM73dOJeehrrml4RA4xGYnvRLjmDo72pyWbIl4RwZSGW+TQZinNk9KqGCaUXzaIOVlpF1ipVsBoiPGQ+nvzzO3FEORCaNU7aTQ9iE+nYzhyNQPpL3st/zGOrLJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iH/dE7h+SL63AySFbQCCvxHWlwuILruTI+iwhPZZXW4=;
 b=h+PviklIFM14UZCd8Sf5HrU29wJLPeKl/SoWPRhlG0omXGl6UtReMElle2WqtsoaEFTt2tKAH4Isknj9FxHUwOIWEQdM024j2niWsEcnue5bMuLidEw9jakVpmpC76fTqMeD0w/YF6tGSpVG998EcMuafUzvBzSDjJgQZJ6dOtvobmwa5VPTRcnv3W+pfC8tfcOLuLn8h2izBqMO5wh5CkPshsTXdiVbAHx7CFCNw573zNH7Go6IpGebD6vlidPV0jZqYMuskp6Yzim1Ge3JzaG9duE6Z5Ejmadk5J5q6OqznwVYUwCIqA89y6UkeqhzeQOodySiYuD6US17aUNb8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iH/dE7h+SL63AySFbQCCvxHWlwuILruTI+iwhPZZXW4=;
 b=f9t2tOePyVJXDbRu1mmJSZACBm/osTy2WLjUvwl/emtc9CLwG5yCJJ2t0HqRHMuHLsxZbMtSRUhWuXev34cxJd8yPzXRqlzMAemy9Ku2QQQLX8IlYhJFuU32mqL9bhvR6V7h9zJXph5/swWJyu+MfU5+pPemBl5XatTKMVm10qA1YT4pdEVXXjtEphKCIWJszIqIvEBhKKNauYc7nDMgoDVUBiaBkMH4hE9t+M93pQbW8pIrrqbcin1eJTDuVfMtDXnI5NAPswVRzIG7CWlM6gwHfthnSZ+sCn7lz+9D5WDd8z7Qo4q1GJcuqq/aziPpPaemzvzW15US/7ymHsoSOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM6PR04MB4901.eurprd04.prod.outlook.com (2603:10a6:20b:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 06:36:34 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::5082:d38e:6d50:4f7f]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::5082:d38e:6d50:4f7f%7]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 06:36:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] mptcp: call mp_fail_no_response only when needed
Date: Wed,  8 Jun 2022 14:36:21 +0800
Message-ID: <2e7b890b45f548567894a01465ba6ea86dae55e5.1654670172.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0088.apcprd02.prod.outlook.com
 (2603:1096:4:90::28) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97c5c433-f30a-4bbe-4473-08da49193aeb
X-MS-TrafficTypeDiagnostic: AM6PR04MB4901:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB4901A5B06D6BA2C495E6B9E0F8A49@AM6PR04MB4901.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jC9V2ZYxDo1q0MicEuRXczpapL+6xDVzNM0M3lCye3jZHSsLwO0FWbbM454dVBlL7pdjYnRwsjxxU88Ogb9nKgKR2fq65B/DCe4viSUA1SWeo7NXENSh1h84BiebpvpX47LQbekn52ic00k4X7DQfwKGBju6wZ3y/TUPE4CgKmTH+4mjRCi0MU1ecaRT1yEbBPIs598B//V3q9xEJWxpj7oscWJTuPPTW+AV76HLajRtRozvbc/+/+zqCljnozmpc6Fmx+Adk0749bdM/QqwvZ/ozQIwd35nvFZeDErz+M4W4qtPIR2AM8lJd0xOhNBzEdy6aFdx7NiQ56kwPDtV70+wrEPkQ1K04q3wvHGgobebAyLsKxTe0PZ6UDGuUazUAqyHqIJiw5tg++9KBeWalds11Rhb+7m88LhGZ1mmFP4d38kbJAP1iVJ9iQhZcrvlMHYUuhyn8Hk6LbJrapDDnk8LK43ehbEZ7qW3DQbAQz01bwrIr8lrvutKsZoCIFQ6WxL2xsYVqEuEAzdnQc8hHTOwgLKcJ0xxXmlflwmJsjCL74LlpmMb9+tW6WG/OWvzyI85YcyUSk3g5EZaWBM/0qwm03AOC9bXq1Qrcb+/0mtUX9XCH+bIBtzBYJl0FCRCFrmhiVazqNhxuAg+W+Z+4Fa6P5nJrkZmpLCt5gAaKbIp+0BZ2haLmYtj3q32lLfcQbf//HBlcbSCtgxmzfDsuJI85VEXqh7mkilxvJxgobUMPDr+KOyDtXECmrxQPD69UKM9Bc6XB0HEE5EQ6yXx1w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(5660300002)(2906002)(107886003)(6666004)(186003)(38100700002)(2616005)(966005)(8936002)(8676002)(6486002)(508600001)(6916009)(44832011)(316002)(86362001)(66946007)(66556008)(66476007)(26005)(6512007)(36756003)(83380400001)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OyK48/YJbNPBp6eCDGps/IYoFDnGByv789om5vrJ6aZAR67PDvhSHUh4UK+0?=
 =?us-ascii?Q?ccq0GcTiYhsHkVPYI/gNBM4TKXIELnapSjDcPPeGpHQ7gqs+B09ZcCNCfrK6?=
 =?us-ascii?Q?NwovnXl72rT+Mk1/KJOkadAb3C/oUvMVW3CCqp5rU8eud4zGNjWBviVQGbvC?=
 =?us-ascii?Q?yYWfoc38Si9oob3KR8pbM5UuzSLnxCgv686HcUSOpO1q3LGnjMSuRw3QcA7D?=
 =?us-ascii?Q?/C33ZjkRVYgSSQAT/zooZDRO1c9+fnOOQlYGtb6BbvflR18EzcttLxjHioFI?=
 =?us-ascii?Q?wbTcVi+edjIz+o+lVGV33zNGe1pVCbuqah7BOFtN+fTad3CAmtSmzrre7CgV?=
 =?us-ascii?Q?zU3PI66ySnMUjuI+UDFAG2y91XowPydz+cGj30XRjbJXMyleTcSsh9OHHLbp?=
 =?us-ascii?Q?6Xi5fhKvJmIxAXjlXbFc8MHaHcDfkzbQKX3l8Qd0xEzgg+q2Ifea4kBEfHtr?=
 =?us-ascii?Q?ZhvrfnR8kefe7CW7NQjCX+6iYO/9lal1RJkXy2SU+wIqajn7SzJtea4HQA15?=
 =?us-ascii?Q?y9ztm5k7gQW/ng27y0F7jOm0idDRIQrMk4gGQtPNIn/ZvOrVrSpS2euoO2A2?=
 =?us-ascii?Q?WknrbQUm9SQoihEphHqFU7W5yVOI2ezPCzB54zcfl6wVxV2+CXhRRYjMF7Wl?=
 =?us-ascii?Q?g8TKnxs+EqGuepLPVeDCAkYCPZNUND5yU4SEGUHuW32H/uf1BGlVu6nkDfEd?=
 =?us-ascii?Q?Y0rPwKhaSYBFWcWzPcpVHqkvakAWDyVfjVSK/hf9rQRHmVZeOGPimgjEoe9f?=
 =?us-ascii?Q?AmKI76MRgeFPk0faOyu2jq3txmZIiY2DJ5glzxIfRhWMLLZ8GQmUDKWXQ/zl?=
 =?us-ascii?Q?LvWlnb9hZoneoDQHgo1O5Gr2Cb1S35/ORMt9pk7HmqjKWVbfx7AIfa8qbOOX?=
 =?us-ascii?Q?iy6x0TtJeWGC/ezLDs59LdCHCHMsXwRSlocH7dQtBDvk+U79U5elZcgctXMj?=
 =?us-ascii?Q?qrnnpqefkJ4wya1K4ho3LjnhE+2QYLFnUveiCCOS4HmfXCdmDqzvfsLjERdG?=
 =?us-ascii?Q?gN2ey00lOVYVtIUohgJ9S771X+ADB8YA4bB+wBPTNHT19bAWO16VuI/GV2cv?=
 =?us-ascii?Q?OqrzFidsHLtMGCXD/1779jpq1vl9FAdqbq5S/YB7GYWFVkBY67Nr2MkcCcaF?=
 =?us-ascii?Q?+Sg7mcXVNO0NuV3Plg5NyXaEaIe9uMyHC7bTOOlQX1hxAGke3BNEIQsqOLyW?=
 =?us-ascii?Q?OohJEGhVEJJ9AdtK48dfdUZBlTm02vFdZUTlIq8aGyLdCUMaD+A2g6uX2eyo?=
 =?us-ascii?Q?8rmtiZhfAm4Aek3FienOVNVl0FSxX7wO9WcIDxkgfPY+yxy2oMD+lOzsbroB?=
 =?us-ascii?Q?sW+CBTFwb+xF3YpzZadQghRp7OtwU9jly2hsnBxSZ2JepB4VKjuCo23whDe0?=
 =?us-ascii?Q?N3asSn1AbyKHZAjRGkorE0Y8qn4gEibs1cbTWouEbCvjlv2g08nEVs1uqcdk?=
 =?us-ascii?Q?Z1sLHQ2FNHNTFvphu2rkkGpelgY4yd45gIawd5ZsHKm7C2oMb4NyAME360TW?=
 =?us-ascii?Q?D9GY99MfPnoqLgwb356ro9nI3DMBKnwaIAtUr7Lil0mguoj1L74pKuvxbJBZ?=
 =?us-ascii?Q?4cBx996kpdeXboHiTSZ0epCT4vHd1sNml0vYav1zvgxfBQqt7wIfzCpPLZc5?=
 =?us-ascii?Q?5/b8q24lwQ7uJ0/C7spfyAHTJMfa2mnxnKrGMKQGj9M4tDd2DEiyzEzbRfDt?=
 =?us-ascii?Q?y9IrEzpE16eU6bUyZQ58RLzkaGuS8b3aOvMpLWZpo2dH0kLzC8aa2gdJ0mi3?=
 =?us-ascii?Q?39wa9jg17FoBEjhhkVqutBdX5zUSuCA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c5c433-f30a-4bbe-4473-08da49193aeb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 06:36:34.0665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60m3C+SIp+BMZQKyAKquw3mZOQ+D7rStFa85cOI4/BXxYHCpRrI6iSvAu1pFh7ooWlJyc66bkpB+QIXRKV0zXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4901

mptcp_mp_fail_no_response shouldn't be invoked on each worker run, it
should be invoked only when MP_FAIL response timeout occurs.

This patch adds a new msk flag MPTCP_FAIL_RESPONSE_EXPECT, set it when
sending MP_FAIL and test it in mptcp_timeout_timer().

Add back MPTCP_FAIL_NO_RESPONSE flag, set it in mptcp_timeout_timer()
when MP_FAIL response timeout occurs. Test it in mptcp_worker() before
invoking mptcp_mp_fail_no_response().

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/281
Fixes: d9fb797046c5 ("mptcp: Do not traverse the subflow connection list wi=
thout lock")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 8 +++++++-
 net/mptcp/protocol.h | 2 ++
 net/mptcp/subflow.c  | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d6aef4b13b8a..cede25e7f2a3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2185,7 +2185,12 @@ mp_fail_response_expect_subflow(struct mptcp_sock *m=
sk)
 static void mptcp_timeout_timer(struct timer_list *t)
 {
 	struct sock *sk =3D from_timer(sk, t, sk_timer);
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
=20
+	bh_lock_sock(sk);
+	if (test_and_clear_bit(MPTCP_FAIL_RESPONSE_EXPECT, &msk->flags))
+		__set_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags);
+	bh_unlock_sock(sk);
 	mptcp_schedule_work(sk);
 	sock_put(sk);
 }
@@ -2562,7 +2567,8 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
=20
-	mptcp_mp_fail_no_response(msk);
+	if (test_and_clear_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags))
+		mptcp_mp_fail_no_response(msk);
=20
 unlock:
 	release_sock(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d406b5afbee4..99023a59639b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -116,6 +116,8 @@
 #define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
+#define MPTCP_FAIL_RESPONSE_EXPECT	6
+#define MPTCP_FAIL_NO_RESPONSE		7
=20
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8841e8cd9ad8..849dd001bc61 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1240,6 +1240,7 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 					sk_eat_skb(ssk, skb);
 			} else if (!sock_flag(ssk, SOCK_DEAD)) {
 				WRITE_ONCE(subflow->mp_fail_response_expect, true);
+				__set_bit(MPTCP_FAIL_RESPONSE_EXPECT, &msk->flags);
 				sk_reset_timer((struct sock *)msk,
 					       &((struct sock *)msk)->sk_timer,
 					       jiffies + TCP_RTO_MAX);
--=20
2.35.3

