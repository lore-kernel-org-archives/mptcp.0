Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F09E7B
	for <mptcp@lists.linux.dev>; Wed,  8 Jun 2022 09:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654680846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2eq+82/Sp3EF6TYyr0fhZhEDL8KkLBA7F0XqFxQdMGA=;
	b=eLoH3pTF17EOJRByJ2/IFkHIqrWh8EduJKut8gWxhDrwmV5vrQxaJ8fWbRYHGi6iFSnZoG
	mwsbKB1nBjrwbnxsdEltL1dLhPG1j4ImZiq4ox+FVaFBMeN3S6wkusMt4/pw5LBhYClBNM
	95diHblFopXEWN2npNm0ol9pmdZnhyc=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2050.outbound.protection.outlook.com [104.47.8.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-be9zdb7aN0Ccugpz0fuzSA-2; Wed, 08 Jun 2022 11:34:05 +0200
X-MC-Unique: be9zdb7aN0Ccugpz0fuzSA-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCQH8bh2UbkWVU+75l6UL/nLQQHiYHdTM99bLQEIgL4qf516Af//7lUWegD9/DeNkNQALS++dEpgZ7YFh1eMK2T+JYM2wTeYqNplw6cI+lsW23+fF9+siPHcjRUee901MbZHeNva9L40mAAJcE41VcMfIfV09rim7F9xiwqfpx8pqty/gaiwNHD6zbYAc261r52JKjXFGv/rax8iM96gGcprIwMw8PWRaNeqqfjo29lQzXZi2jzlWEP4Jsj5uHFssUUbgBmQaLOwC6uelerQLx+UairuUAi0GbdsYuuqbwJ/vDNb+7K0bxRY3J+yH3nQSDZykweRBpxxjYFuT0kw6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZkeTykrW+pOH7U9YMg7cP9dGLvohzofWrz69UORaTs=;
 b=mJ+h9uqoM/n9hguTE8o7KfA8mQBzkJKA10ZUu5ldSSjrD7J6HQ5PwbLkZ8IghR+zYaEUM34BoMzy3MefdMnf8w3m4YbOepjcAWMbg7yJDfUpn3lD48rvYZl0uV23Fp23Cz/6rX4QYa0ggK9RTp55M5wiM2f5M91jX3dPt+GR4tDh9v1g48wWpiTvKG7pFKPJqNKvgX6LNL3d4BLL5TxpG+Ar/Y9Ay7CqaQW2HGLWHJz4HxNkwZwHaKMBF/PXzg46TVrPfoPmqpmWhSyLTZ3zuGLjacX2CSTycKW3OCwa4DOQgEEsmUVJtH4bn0cR8g1OWFroI/F19k0I3IqOia6WzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZkeTykrW+pOH7U9YMg7cP9dGLvohzofWrz69UORaTs=;
 b=GlRviJhKLjbMrvlHzLokSvrvaHl6N8aaOp8nq3ergkX2XW+hqZFocjZzaBhsymt+fk2MNk6CnnnxxjQQrzWqe+8fCbV/YPCZdLF8Myxwbx2d2IoTvg6ZBzIiwwK+x5Z0I4PkShLcMHX/P7bHnTm2cQ0HQTIrrgP52SQQPIdWtOcoX707bDGMblmwl9VaFFd7ZFE310j7vPs4Wc5IygjSfrxDFpQKWazPK6Ee5RyCJg3nNAMJ3xzVN5cx3Us5JC0HNwuTCs2vMS4ClxhLUM8d1on4BIvlJm/TeWbMm/+ywZpuf3TxMZKJL+iF96N02+MJcX76Gkief3tEaEcviKvvHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR0402MB2909.eurprd04.prod.outlook.com (2603:10a6:800:b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 8 Jun
 2022 09:34:04 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::5082:d38e:6d50:4f7f]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::5082:d38e:6d50:4f7f%7]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 09:34:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] mptcp: call mp_fail_no_response only when needed
Date: Wed,  8 Jun 2022 17:33:52 +0800
Message-ID: <8c8d4ab88bfb43cda2ffa0b5e43595cad8c83512.1654680717.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0113.apcprd02.prod.outlook.com
 (2603:1096:4:92::29) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e5c1f6f-75e5-4ca6-0cbb-08da493206f1
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2909:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB2909EFCA3A228EEA8E1D9E11F8A49@VI1PR0402MB2909.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZoXO8DoD9fKJy0S67PSWKrEM9uOPWH0feipDx+9M/7ywVNF4PNGxoZ4y75tpi5FI8Q/W82hPv/szIrcsQZXARQbqjd2RI6OhzJQJhPC2ibNWIbSljFsrH+niIG2abQWGrPPwBBFGj/rNiSU8dXvD6B331XXT/oq4G+c1nT+8Jy9qmlf1DnjFSOjvZkmhKZqDlu8IGlBOMJMqQDkH7SQCerpZGd2Hl9+ZEmuorj0GuB8efahraX6iHVspw/N8YsN73pmszGb5cwa2BunbLTRIV0COlMHfoUHX/LvZdsM4k6U0yCjTckPAV6s2fMJp+MmDGY58M8jXDVl99BIf+qhMjkIQtADsvWc091yfEFBSmYs6D4bibbkyForcI+lC4kIMms9ivrFgHvzVPrjl8Mxouedrj19BaPXlk3RMcsRuKaJ+NS1Y/YjHN0BZqSShMVu81nK1VzCAPwlDIJBCc/S5dRhekEyTszQ6JliF6o6POk/rfZMa/jz/3rbMDHoRbNg3jQjQ1Dkv8C8yqE0l2S4S7/d2dtoUIQxXiZo3X2oNio2F3O1OrVDgIvu0laHEj6wNQ03rKAwXxqF7w5pbjR199Y7ssGZapCS1wddYJW2bMEgoDd/ekB9cGwTNYTQlAq7jMN7IHbKe+NzeCqeDlmb4CHs29A1gWnwB5ZvwNsg7jp3dUI/O5H9j9WwxFhTQC4FJo+Zo35CRe90ybS9onj3qLeOHh7BKFOOZgUGa+KGRNsRb1RE0SJw5krbGxBFUmuwl1+wyvKvLOs5mCxrz/LpnRg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(107886003)(83380400001)(186003)(2616005)(6486002)(6506007)(38100700002)(508600001)(66946007)(316002)(66556008)(6916009)(966005)(66476007)(8676002)(44832011)(26005)(6512007)(36756003)(4326008)(2906002)(8936002)(6666004)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8edicipyUKacO8ofB6QLEgydvrvVQpLbrT+nc0FEfQs3j+TIlt7ulvDb8kA2?=
 =?us-ascii?Q?nMB+vA0UiIxhyylgGQ80qskGLEIcfuJeLwyjn0nn0tBnJ0zgJGLgTfPT5r94?=
 =?us-ascii?Q?XVWoZAhS0bIk/OsHqMuxa+/81Iq6NFjqDqc39AVNd00SrPKpk5cxGKmXHv66?=
 =?us-ascii?Q?mRNyflWzap7tVDnsNXA1mPyQJUoaZB7xKIPxv0WzU7TGwPjLZzNgu/fMyvay?=
 =?us-ascii?Q?IxthNoStjbK6S42SQGl4VYPRoOR7NY6Rz3/lr6rEZFXj1L+b6RM3zWkVuvzN?=
 =?us-ascii?Q?EP8FOlVuBhNZ4xScR3fXEe/QoTBXIRjipr8xC7ZjA0RdwJk1JqFf5CI3ZoUi?=
 =?us-ascii?Q?/ZNm+q2mJXnXHMi+p5IaFSBW3KYg4gbpn1XyFogo3UcYZGOj3vUNNH2pvL4B?=
 =?us-ascii?Q?UMa3Qn8BqLCRYC/Wc7XfIjBdc9jLyVUzUvW7QlLY0YGV/6WTp1mdcdumyFCT?=
 =?us-ascii?Q?xgb0dK0kI2peAQT4WkQ14joICLhluIT+Qs5deIz5puWwpYJB1kLeV1lJ9FBq?=
 =?us-ascii?Q?AbDezGutbisIuTWSk+939Hy/+DqBYjk8bCabQ6C+c0NojzGGt7Q+FSBnQLUU?=
 =?us-ascii?Q?nvL7vf9UTGmQb05NZ8Ff3esimXijnvfwgMcN6vUQGPksOfZp4ygQwjcFNyYq?=
 =?us-ascii?Q?UohP+5S3+mV9H2u2g5FysEcOgpS0TjbAwLtkh8IsxqGwUTur8b6ApnPGkPo9?=
 =?us-ascii?Q?2KWSZ2EobKJNqNrgPjHDY8uDuwbYZglBjgLX9Pgzk1yOrokyoBWznfWrkDR/?=
 =?us-ascii?Q?3Ax9mj2aSp4yJR58+/ZR95loJGfGsGsrpR24qlDeJ+ScbcqtS3iHb4iWcl+4?=
 =?us-ascii?Q?Qlk2EXwtR6jJSMSQYkd5JR4y1XX4bo8E1nrgmT6RzHCVuUbG3gXLByPalGBC?=
 =?us-ascii?Q?SehjoGLYIYuA3YDv8gUo8yp8MO4k05tb3CJRBsaAzLj2svH0thW3WIAfJUzO?=
 =?us-ascii?Q?CpDdtap5Rbr1wkfmac0wl7EsTpbA2Ko+2Wb7cZz7s1Fxc76i5qSgtea63NRH?=
 =?us-ascii?Q?UNXIXv14VOrH0PRyJ3oyq7HXYiAzjMt4+avJchYjGLsMeuRFut+XCvbcd5Cx?=
 =?us-ascii?Q?EnTPAKei13z/kmPsktL2Q7OCM7hrdh9v7CZ28se0ZNM3dU9SjoDke+W58QCi?=
 =?us-ascii?Q?YxDlsXqoXqA+JqXJVxoU6DZ/NQhTb+MZb0nuYldMZ6HvPiVg55vthisrfX7H?=
 =?us-ascii?Q?2SGObvTXwQiXc3ohz/z4iG5zADETN03wpId+LIVqOukn9z/ul7kcQrhmrym3?=
 =?us-ascii?Q?FwV+3kATC5x1AHrc3siCbl8otzDGb7uMd5Oqc9VMFRaEQk4yl2SpEEt066xg?=
 =?us-ascii?Q?sKKYFCRIqDNIP6plpgrln0DNjDZgxQ1UdJvIUbNuJ858VRhE8WmcfLvq0iUl?=
 =?us-ascii?Q?Fiomu97QCcNU8byVJvdhTSDgTVZIOL55rT7/FapS4ek0CptW6muVD+Qc73Op?=
 =?us-ascii?Q?151BR26ZwLmWyLtwMqhtp4EPhYUNEYaD4fpxy6e02XLBFFl04GOPk1Y3dQdk?=
 =?us-ascii?Q?E5KHvtcWBE6poBQRPA8A5pQCarVrkU0LMunoyT/Uqx6dVc31DKqywF1LWFqc?=
 =?us-ascii?Q?so6zV8Ksg5j/n60WtAUIY3QOQb9QbBkkXUN0ZaS/Cue3Ln4QnMoqSGzflLVA?=
 =?us-ascii?Q?6xDo+1wJ5h/7gNEYR6TLrGkh64rcY4JeBfQKIsNeoddEvBOz4yHo2NkKGpKs?=
 =?us-ascii?Q?J/dXZ4tSLAkj/ID2Eb9XCxk4JuCt6mOvitKqutEdWqW+E7Y9wVZwxZJVTZSK?=
 =?us-ascii?Q?x0QHSOhyA0eGu5ke3j/F2OSXPWZ3Y2Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5c1f6f-75e5-4ca6-0cbb-08da493206f1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 09:34:04.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPZsFX2AJW5ZjUp5Aii20hrYjxfD53j5WG0MdDfjdksbd338lYlXtbhtLX3YcXtJCAZPKwZ8Bp27UPDg/2lL5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2909

mptcp_mp_fail_no_response shouldn't be invoked on each worker run, it
should be invoked only when MP_FAIL response timeout occurs.

This patch adds a new msk flag MPTCP_WORK_TIMEOUT, set it in
mptcp_timeout_timer(). And test it in mptcp_worker() before invoking
mptcp_mp_fail_no_response().

Check the SOCK_DEAD flag on the subflow in mptcp_mp_fail_no_response()
to make sure it's a MP_FAIL timeout, not a MPTCP socket close timeout.

Now mp_fail_response_expect_subflow() helper is only used by
mptcp_mp_fail_no_response(), move the definition of the helper right
before mptcp_mp_fail_no_response().

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/281
Fixes: d9fb797046c5 ("mptcp: Do not traverse the subflow connection list wi=
thout lock")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 41 ++++++++++++++++++++++++-----------------
 net/mptcp/protocol.h |  1 +
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d6aef4b13b8a..123fa2b3f200 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2167,25 +2167,13 @@ static void mptcp_retransmit_timer(struct timer_lis=
t *t)
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
=20
+	bh_lock_sock(sk);
+	__set_bit(MPTCP_WORK_TIMEOUT, &mptcp_sk(sk)->flags);
+	bh_unlock_sock(sk);
 	mptcp_schedule_work(sk);
 	sock_put(sk);
 }
@@ -2505,6 +2493,21 @@ static void __mptcp_retrans(struct sock *sk)
 		mptcp_reset_timer(sk);
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
 static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -2513,9 +2516,12 @@ static void mptcp_mp_fail_no_response(struct mptcp_s=
ock *msk)
=20
 	subflow =3D mp_fail_response_expect_subflow(msk);
 	if (subflow) {
+		ssk =3D mptcp_subflow_tcp_sock(subflow);
+		if (sock_flag(ssk, SOCK_DEAD))
+			return;
+
 		pr_debug("MP_FAIL doesn't respond, reset the subflow");
=20
-		ssk =3D mptcp_subflow_tcp_sock(subflow);
 		slow =3D lock_sock_fast(ssk);
 		mptcp_subflow_reset(ssk);
 		unlock_sock_fast(ssk, slow);
@@ -2562,7 +2568,8 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
=20
-	mptcp_mp_fail_no_response(msk);
+	if (test_and_clear_bit(MPTCP_WORK_TIMEOUT, &msk->flags))
+		mptcp_mp_fail_no_response(msk);
=20
 unlock:
 	release_sock(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d406b5afbee4..f78caaaaa360 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -116,6 +116,7 @@
 #define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
+#define MPTCP_WORK_TIMEOUT	6
=20
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
--=20
2.35.3

