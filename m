Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ADC7B
	for <mptcp@lists.linux.dev>; Thu,  9 Jun 2022 00:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654732882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRs4MO5oxYq959azse8AM4UnL6mw5gPTA4ehcZdC4cQ=;
	b=T6v6G1YlcFKnDE62jpkr3KhX1yh9PjmwduTyDfM4i21cH+AvsIE6+I49Um9T9El9xTSkzj
	q+WhRExfrpk7iCVnZjt0imLt1ZG/7hVuum6r3Z6w9BwOF0Edr8B8ndkPbRg/vCQFZbKSs8
	rd9zLBCqKSZ1L+JS2kuygDSmkYCkz5w=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2052.outbound.protection.outlook.com [104.47.6.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-Sp6tLhm0Pqm4k4h1pYo7xA-2; Thu, 09 Jun 2022 02:01:21 +0200
X-MC-Unique: Sp6tLhm0Pqm4k4h1pYo7xA-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2TUwo6wu0bGrSB69huRjv2QLDbGhjX85xSkumm5SKsx97tH3dUub/x/s8Q09jQnWv0GWZAEqbwGzKTEp60+MfjqDffJkrh6WxzXoVE855ipE//twUOOlJOlmOmDBCjFfOKLVPxECtARCuoyuymLPFYoHRy7l5ONzDCzHnqbGJl76VEkjXSCuxC1zVZeEtLZuBMIP9NzJevEUV8gFkI6E69+wSSE8wQnB1kCqs0eBTbjQlK/aWizCj1D6d7l1Pj0V4lknm/mvBH6EEJHBPkAbosYaSvY4nuvjIpNDrmS8k0B0r8rgGAFcmgIffnnaWD0DhSPFwg5ZZS0GYujET7qIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Sm1W9UgzEcDyjWlZhOZLYf4YvXlpATOT0QdsSlOeQ4=;
 b=fgjiesIpVUIb1SJiOoA8VlVbEnmrtbW0u56Kwt55adb5PBP7DuEeUoTEusKuuiAUoMbZjqYm/odGfVjvmxcYfl6wbk1NuNYSE2npYDh5ScmL/bkFZBsdiBqJ4xGzzknpC59tf8Btg8EfChFI3PiiyN+QkMoXFLsNRCs6BirC8d01SApkl7mbZNkmnfBiw49m01zGuUr/b4S9ziYDZs/oQPWXtVVk/f9NV21x5Y+UaLEhevJXm+CIymQmsNjEV5b/sLkOgW0XdoepUjKUhNlxOVZD65SuyItpP+WmWEdidzqroPdwDv1c2a22zCgCOzVTJKStksxQmP6doo5S/sqV9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Sm1W9UgzEcDyjWlZhOZLYf4YvXlpATOT0QdsSlOeQ4=;
 b=Wx8xR8s2sA436WM49whMDC9wFmqbXiz8hKCA9hkHs/5pttndO2KRpdZl1jqorwjIiecppVU0mZm0xNBXfQhNqBBaFJbSCaGLkCD0Asq9NPYVyamlCslk7H59fXu6i/XEjhklkV1y2wGOg8B6ISYq02ludQd2cXDsRXrBg/m3FL4of0Tsf4re65OkG6Kp9to5DdbW5M5+TjnQl1cdsRTXYOnmgzp/li9HDV+LXVPVZlneTGgEIzxG4y6+XAHYhLyi4+GWNeHEmE1ZDGBRVk7X6Uzh5SLT5BM9oXtqx3n/NlI+sZLinIXfrFwk4YQKD/vRmwBHGQa9XblzdsMDI+QMeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4263.eurprd04.prod.outlook.com (2603:10a6:209:4f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 00:01:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 00:01:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v4 2/2] mptcp: trace MP_FAIL subflow in mptcp_sock
Date: Thu,  9 Jun 2022 08:00:53 +0800
Message-ID: <005b6c1dda2ecb334cc9f6b07053aa59b69b5613.1654732564.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654732564.git.geliang.tang@suse.com>
References: <cover.1654732564.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096::25) To
 HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e766d468-74cb-4db4-cc8c-08da49ab2ec8
X-MS-TrafficTypeDiagnostic: AM6PR04MB4263:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB4263D896451D78E2C99E40DEF8A79@AM6PR04MB4263.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X3Yc0TfncJi7BzLhpEyhWR83QKnIKwPYIaJbUPODhp+FuIxsBxM0uNaRvoclWmgDSU02v8hyL0V9xzkRXAIWC63Pw1QmfJq8Farf0diZ1GmBke4H9r1MbyeGaHnsWhPHbvz9oO7YpbuapxB43mpEvoYsRFAHa5xz/GLH2ATi89Ps9RIDyGf4+XceLhjvPmqGqkL5X+LTW7/KKSYliMNbhx9bqTpSntpVwhIvsitlFsv1uUp6WzI6F9W99XqZ0MJ0hjr05tn6TvWMVKtvNJFnevdz+m2WpsFruAWzRAnbTOTaldJkhz4pXTVVM1Ts2EqmkNZ5XczZ3NQcCuGsi4/7ztheUWZlt1m26PPuOTPur/EOzWSBDnXoiEZUH2uQ2c+lhMH4yCpG1NkDzm0m/1EcN6ZHTwtsoTzUzshIlkB0FlEtkirCcOHld6Qr3yGrTZFswuQ4SuTP3ylV94/L5b9NK0W0XiU5KxycVi+9ADjtEsMM/S9RcASFpUBRDU0+LigaUPSg/jfEaeM+l7OMDd9WEVzKwsqormuX8tYy2HB8RMhcBGOqG2PmBz92ES0SoXE4RMp1/e1ccHyQxBIzabjqCoaggT2irJiurkSQsk4uioRuKgT8GQoFWuuFv5VLphZKXUNOLScGFm6JAnsCI/ZmbtscRgAySBYSpdpmyCUMXIJpa/Q8YSHWMBWuMinNiFk5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(316002)(186003)(8676002)(6512007)(4326008)(6506007)(8936002)(54906003)(86362001)(66946007)(6486002)(6916009)(66476007)(66556008)(83380400001)(508600001)(6666004)(38100700002)(2616005)(5660300002)(2906002)(44832011)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ysp8QbIra042s1AGOjPEAavNl6frbjyFftHqcW9Ic+noQuecsbZAw+rPDY2f?=
 =?us-ascii?Q?kKNMOrx9HkRTXbQj2lGlCj6VY/yIaYaU6KZ07tC2fJn/QlMi9R4UdjtKaWpW?=
 =?us-ascii?Q?Jne2XHePAosTxjlAAj9XpDeUBy3xGeZJq9EdaLJx8r+OdeEYRkObdkwEFhtu?=
 =?us-ascii?Q?3YN8gN6S8djhsAGpvV9InP+QDcbnikguPsWaxelHCl8XSwYHhWD9gNYV4KOC?=
 =?us-ascii?Q?wSI5+sY1+xtkJo2LeDSo3bJ98nZmpj37wZkuDQsZA1XR3H3iGe2pWfQltemS?=
 =?us-ascii?Q?6GlGhxXZsGn4aqUxV1BwpzaAaHlZ+UJadJEUayQClpvwEf2yYYPRltFr8weq?=
 =?us-ascii?Q?isPBoHuG4ckV9dDedAJ3OvJPCU3kKrwuDeJ/7xE26dgPp5IgCUXmp2SyIAMd?=
 =?us-ascii?Q?cALQmF5A89qLRqGLkh8u5kB1nQhlJbepEdUIz2FLkA45NVoMLFFOb8itmH+0?=
 =?us-ascii?Q?TrU+1zqBwJ/iSWQqNTbxjAbHzKJI7rgPL8WHVFP43gIh7xXXuSCkhf9WCyEr?=
 =?us-ascii?Q?BPNteL6HFLSxdItiHa98KATEJeNU+hywPWFpc656rit1LVkk5tsylACN66kw?=
 =?us-ascii?Q?WeeFmTYV4XL0ciIf+gXyHqyDJWCwYMXz3spXncbIYY0hrDYBCsoqaxlyGnm3?=
 =?us-ascii?Q?ZgaNxJvxB7hjmu0bf/RiRgizYjWQ8KXxVVj5m41oybJCtAM1oyIo4VnvleQL?=
 =?us-ascii?Q?rUrz5ftk/yPUDTt/bJmYGWA+74IgUmBglHXaYGoE4UpTcKIfcF3ACx1pKPg/?=
 =?us-ascii?Q?IsoTgDTIG+I5wUkMghIYPYjq73hpZdhmJNGYf6JwqJCLyddUXqzsKTB2aP1d?=
 =?us-ascii?Q?6brmB3Wj1xL0MmwkIf8Pcd6DMF5V6ir/JGD7UzvHbwtjK35bhZxcWaTqFdK8?=
 =?us-ascii?Q?IfNlY3woNFbYh46C99kgWagWNGgd07fcWwWwDDATdOHbUgC+eZ7VdbNlcWXA?=
 =?us-ascii?Q?B1yJpZuezknN1tMtrWREXnN+DCSNjeHk7jrSrP5d4/r4JWMt0YgsfpOgT6tn?=
 =?us-ascii?Q?PtRdRuQR++eJYYNyM5QI8ESYLjZznrshWaL+XDxKr4bfzmiIZdMXTFDSxhCv?=
 =?us-ascii?Q?AysGKVbvvgBhhzBdeVXoDC4CwKFbRDyfSf2tLlTpJrDtq6VfqOEg9V1szIAw?=
 =?us-ascii?Q?xLHJ63Z5AoQvRBy487ZnbqEyJcE6q/P/TL3W+cXMXlvuem0z5b1MLPGonMIu?=
 =?us-ascii?Q?nwHvXRgfMFcR+dm6OXcVprMw4zI7ohIRuON9oQ+oLzu3Wnwf6vbU3GfkpTbt?=
 =?us-ascii?Q?sPbf2E62GqE38c2/g8/ZLZgp4G6mb7S8K2/wog4tqEyE5eOlQiuE3CTGa/5k?=
 =?us-ascii?Q?RKjE8XlikxeTgmw+G2WC/HO9LNmPba9UAuRALFxF/Zc708CrjkfYvuUSMs2S?=
 =?us-ascii?Q?dEASv+uyRJdWaqwLfFRNMHpt5RrkFJ90/nYR8t0nUjGYg0AIsvUrqRdawWNc?=
 =?us-ascii?Q?UFM6xvWxDeGepYuzVCS2MzYL05q+hgaCMCgmY9rsBnhV8Dr5OO+bI99BOa+N?=
 =?us-ascii?Q?IoZJKHBEVdtVrPZ5AZxYxWSmHfCvOIJuqVBKfGPm6m2sLlOe2Vykxqc79vHD?=
 =?us-ascii?Q?9A8fa08fPJTIb1l/BDdPa0RriRxMaGZUVOzAd6isjsbfCYxytLkFMiJkYCxm?=
 =?us-ascii?Q?kPTbwneLtMj+MEFmgV1IGlRz2I4VPjxTTRgdZ2cA3WogxDOzhAgjZcLANhM4?=
 =?us-ascii?Q?V+ONUKWMT0mL4eYM07LkttdRrMtXWZjB5NMPLZsC9gLGYFPUFw/R7mU9thUJ?=
 =?us-ascii?Q?74R0ChV9ZQi9glEq7Y9lbYk335u6i6U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e766d468-74cb-4db4-cc8c-08da49ab2ec8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 00:01:20.1368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kN0UxmleoWClBTaeEr8ay7fqhC/NufcDIfooc2m8b1VDKL2oWnYKgLKYEmw0vowhdCJSrLQ2fJSrKiEWOpbIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4263

This patch adds fail_ssk struct member in struct mptcp_sock to record
the MP_FAIL subsocket. It can replace the mp_fail_response_expect flag
in struct mptcp_subflow_context.

Drop mp_fail_response_expect_subflow() helper too, just use this fail_ssk
in mptcp_mp_fail_no_response() to reset the subflow.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c       |  2 +-
 net/mptcp/protocol.c | 35 +++++++++--------------------------
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  2 +-
 4 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 45a9e02abf24..2a57d95d5492 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -305,7 +305,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fai=
l_seq)
 	if (!READ_ONCE(msk->allow_infinite_fallback))
 		return;
=20
-	if (!READ_ONCE(subflow->mp_fail_response_expect)) {
+	if (!msk->fail_ssk) {
 		pr_debug("send MP_FAIL response and infinite map");
=20
 		subflow->send_mp_fail =3D 1;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 917df5fb9708..58427fabb061 100644
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
@@ -2507,19 +2492,16 @@ static void __mptcp_retrans(struct sock *sk)
=20
 static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
 {
-	struct mptcp_subflow_context *subflow;
-	struct sock *ssk;
+	struct sock *ssk =3D msk->fail_ssk;
 	bool slow;
=20
-	subflow =3D mp_fail_response_expect_subflow(msk);
-	if (subflow) {
-		pr_debug("MP_FAIL doesn't respond, reset the subflow");
+	pr_debug("MP_FAIL doesn't respond, reset the subflow");
=20
-		ssk =3D mptcp_subflow_tcp_sock(subflow);
-		slow =3D lock_sock_fast(ssk);
-		mptcp_subflow_reset(ssk);
-		unlock_sock_fast(ssk, slow);
-	}
+	slow =3D lock_sock_fast(ssk);
+	mptcp_subflow_reset(ssk);
+	unlock_sock_fast(ssk, slow);
+
+	msk->fail_ssk =3D NULL;
 }
=20
 static void mptcp_worker(struct work_struct *work)
@@ -2562,7 +2544,7 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
=20
-	if (time_after(jiffies, msk->fail_tout))
+	if (msk->fail_ssk && time_after(jiffies, msk->fail_tout))
 		mptcp_mp_fail_no_response(msk);
=20
 unlock:
@@ -2590,6 +2572,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	WRITE_ONCE(msk->allow_infinite_fallback, true);
 	msk->recovery =3D false;
+	msk->fail_ssk =3D NULL;
 	msk->fail_tout =3D 0;
=20
 	mptcp_pm_data_init(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f7b01275af94..bef7dea9f358 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -306,6 +306,7 @@ struct mptcp_sock {
=20
 	u32 setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
+	struct sock	*fail_ssk;
 	unsigned long	fail_tout;
 };
=20
@@ -469,7 +470,6 @@ struct mptcp_subflow_context {
 		local_id_valid : 1, /* local_id is correctly initialized */
 		valid_csum_seen : 1;        /* at least one csum validated */
 	enum mptcp_data_avail data_avail;
-	bool	mp_fail_response_expect;
 	bool	scheduled;
 	u32	remote_nonce;
 	u64	thmac;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 866d54a0e83c..5351d54e514a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1235,7 +1235,7 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 				while ((skb =3D skb_peek(&ssk->sk_receive_queue)))
 					sk_eat_skb(ssk, skb);
 			} else {
-				WRITE_ONCE(subflow->mp_fail_response_expect, true);
+				msk->fail_ssk =3D ssk;
 				msk->fail_tout =3D jiffies + TCP_RTO_MAX;
 			}
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
--=20
2.35.3

