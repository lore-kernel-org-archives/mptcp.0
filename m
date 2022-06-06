Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F223BD
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 09:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654508850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2GXbNYTzDYxhfNKMRPmH40wmPbVTeqdqTT7C3ZoW0c=;
	b=dDnWURxNNFaW5WGc4ldD6MuRhffbo3U+eH3tGJ3xOM6OFNewehK+NDDoa91AwJngHkBA+S
	geWJ+PTqkcxfqWBZGN8pOP8vDk3aLF9JiMGXIybflwcFsxArXyvlQ4D9HnbcCtISNAo+Ea
	J0FHnS6xmSjKICIoe47hnMnMDAZZazo=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2054.outbound.protection.outlook.com [104.47.0.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-45-Rizd01EgMZuEc7S9Yn8MbA-1; Mon, 06 Jun 2022 11:47:29 +0200
X-MC-Unique: Rizd01EgMZuEc7S9Yn8MbA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXInuzh4i3gZcSHATDjzXlxZhyEwtxJkS41Z8k5bHxJzNYR7jLTE+eiHZP3YGbr1HEfL/sNbT3wuHG4WFrjAM0p02da2D9nl0TiXoRwo8yr4ssXSt3pQHPAsBLHDLdmQzK4V05p2nq4tVp5ZZFCEnW8CRYuGOS1spJeE1VH4kl7GStgglgwTvRETtMeGCVvKsPNAEqpJEPZlJvOsEqOyXL7xNA+cuGzBl8U7uWXK2JaYeZeNQSf1cBd9sj1wpHnCrCaKVJhUdF1IkEgH+zBrehiout/TapbtdU54EltjrAaCgyWotTUSRzclGrItTlZX3kEkiL5C8fk965ail++/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lob2rto+af6hEU5mPGx5/WYvVNnRMfM4/NK2pqNdOmg=;
 b=X3nJoqy2QZpY3FwKYGnbtqikH7ZG+6BEV+J1vEV9bGi+oJ+UN3UNKxnw3icf58BA+2gXhUwLL7JV1Fq14KVPaAcAXWzXAHpSOXMqDcrsXcjWqTiUa0IBlgR5PXU7azmn3rYK0yUEIdVmu1lKJN3sUoz4/uq3z5drjPyjcR7wJ/2RkKUaguxgMGpqJs3I+w/D5fr2BBIiAfe0ZOvK+1xQNnLuTs+PK6OoA92T3gR3s1WG5khyXprQB/++5G48eGEHSkPAZh1I+hMgHm7R08d4JWc6E8A/ewhm0eVU3BsVmgB1UJZiHXWlhT0xSC7BJ7uaaheMb5BP62TggbIzuhfXfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4802.eurprd04.prod.outlook.com (2603:10a6:208:c2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 09:47:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 09:47:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 1/5] Squash to "mptcp: add get_subflow wrappers"
Date: Mon,  6 Jun 2022 17:47:11 +0800
Message-ID: <663067f1da8c6418d60f8587d9dc96af33cce167.1654508532.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654508532.git.geliang.tang@suse.com>
References: <cover.1654508532.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e8b09e1-3ef2-4e23-84bf-08da47a190fb
X-MS-TrafficTypeDiagnostic: AM0PR04MB4802:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB480236B98D28EE2C3E404A1CF8A29@AM0PR04MB4802.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hyx0aWi7Mv9B8jFKysJUup4aLJozhx9K/UkMBNy+rzOOSB8IkGzdo4951/29XDyOstvn51wiNJQZeAxsmBY3FVI5+SCsiOheV6NC3A18ew5mFD5COPFS94MBim/P6vZVu3qhnJlgZ1VqO86tj9y9eRoljmfLLhGPaf9u3HiJTnufQg6qrQGUO1W/pRrF5ga/U4qkAQe+ZZnD7DRZUxIzbwkuC5Gk0Fv+3oUv/bZFzgO5dRRJNiqJ8LqUSHJRpykfvWxpCqncp44SV0jWMMxFJfDSPdrHnVY7q88GEgvmMsNeffYoKOZbc9uLT7v9Qp1ZbjQy/Kk/VZSUeJn8nRlVmokZpp5Wv2l6rNJAoxKmeLvQ+yTVX+XbeWN6UyTO3riZL/bHCi36U8OLRRCzz+wkaipfDkvk1N9sVieMiQaAfUwBnLo4PZoc2br0+p/xZj4G22LBlszAhIbAo6HAwyZp295ozEW6Vi6FhzZ7h40Jo5NwA72EssCutwTjRc9hZXHu00H/EuA6BMUVrO/ZbgPMkqaf7CBgpci1WeAYeTaz0lnbJ0+t26K8mx/+pSUU4dq+5eXOFrIlSxwEnIfJ1xg/87xjeB5Gie8AnWfZap2DZ1JCYQjsD5zjj3/4plSLYk3OD9Tt/IQ4fPOlWizp42zLL6Y5kEntgYE6trUewpAfJQXYOc7KfwkfOgwzmg1l/G27ZDWj6CekTA794MgZ3q/TVg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(36756003)(6916009)(38100700002)(66556008)(66476007)(107886003)(316002)(5660300002)(26005)(6512007)(2906002)(4326008)(44832011)(8676002)(6506007)(83380400001)(2616005)(6666004)(508600001)(6486002)(186003)(86362001)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lc/nYGVgJJUtWwfojtEqZVZ/sq8Xlda1YTTcmq4QKDBybEt27sZDsjFnB6y+?=
 =?us-ascii?Q?r1OkMqYXFt3+ZVCz6TCNRH2jT8wb8kz5uZFd8FozMs8XDfp6e3n2dR3jDohl?=
 =?us-ascii?Q?SOBGQjlzbcPbW5eASpY2l4C0FWX1xKejahLGhl2RQbGuKO1dTy/x0p/uPzzk?=
 =?us-ascii?Q?8mvwUgxnxhkcAK6lbavd+KEIC52PgvWJRx4OiMS8//l9+XL8hJHfMvTVneE6?=
 =?us-ascii?Q?fNJwC4rDY4/vCDkpM4WExb5t7Vt26V7GyFHDFXnNiwaQ26BFDbZ3PM+vq6/K?=
 =?us-ascii?Q?31fuSRpwKVpVczG5/4ESY4qgNrAN6BtgZZSodLSjK6ruOIJvBZ2E+vhptGAP?=
 =?us-ascii?Q?rnxOhO9vhHqMUv578/Fta2Xx2/hLdd2ePGbl0lQZPUxhreFw0MAwWqanenaj?=
 =?us-ascii?Q?mtEnkSHJJl+s1XAFmz3lkkANRNS5T7kya8iHxrXjR4IDZpFvhoLcGSOHS3BW?=
 =?us-ascii?Q?nI7BopFzxjsvzALzNdlIay7Rv6OUbWeQ1QbLjdIIZ1g3OiOmxqHdx1UR58kQ?=
 =?us-ascii?Q?q5DRPKyOtJyBEPbSgA+VIykqBf8pyA02yuf/gjPNh0eMesG7e9FDYs3pMFuf?=
 =?us-ascii?Q?qrBGUY2e7HhBCmvucfk4QeYWs3qqKUB2oQCZo3zCJJf8IZQK6U56mMjfyEtj?=
 =?us-ascii?Q?brrbzgvv8HNR+WFsTUI6aR3AnvxDflGLiSjgL4U8jcLasqLqwM+Q0zqF7rxj?=
 =?us-ascii?Q?FSIFIaiWwZpzlWb+2bi0OloCmdOTc4vBXayNsun4OLGyOF3GMvACDIfnBjk9?=
 =?us-ascii?Q?T6MKD127DKjU+uFNd5OdrPjXmnd2+aFVSCHCo1bAYBWOvuOf7BrH+rku+9io?=
 =?us-ascii?Q?VGudp65XF+1Tueu9POhMMuiecnmMvQmquLLaS50SPvrp3TMNgO4i7FecVZL2?=
 =?us-ascii?Q?jIoLuOZN6YPv/ctCeaEr7sRuTB848CK3s8cVZ/Z5z1yn8sXNUrfae8RXmao7?=
 =?us-ascii?Q?jYAw0hwdKJ1dlstzs/tfE7KupYM5/2rUfRpPyDXCGO4TelJHLvRosoiomJX8?=
 =?us-ascii?Q?brsuGIyAkunWu8YE2EcG/J0YxSR35KrmFs9faUbIs0vrWOFonTgTUsu+4RHN?=
 =?us-ascii?Q?2D+KZMg8gjPHym/rIP7Sfw67ikkaSReLViJQFc+sedwj9VSe4SisZAI6Ux8v?=
 =?us-ascii?Q?kgCxoFeWeTAqu+nLmiDJVy9y1dlTr2t3OJZTcaBADeaFOfrDOQvvsyF2ADZG?=
 =?us-ascii?Q?gmy1y5yi48rpdieuiBoctDyNjZQjjCrD1deFn229RkoXInJa/R/vs1OfYe0d?=
 =?us-ascii?Q?ZsTpYQUybfUhKzit3qOVnhauNPKLftt5u3yc/vYHqIZ8NDn5ifzzwp/1aGkz?=
 =?us-ascii?Q?hkNAix22wxnwYXRS6d6Lv6v1gO8tFrxwodH7zJ3jgieGJ6tqEEry7s73y5tN?=
 =?us-ascii?Q?knq5HWxmKEq45LdJH4FFwvBr1kzqZpKw84n/wP3WtXqZ/PgM90F+3nfC76T1?=
 =?us-ascii?Q?ogaTIXEmeJTNTSp5Sgo1NXlYa2/jOkteB4oMtBodHY5X5DZDg4EgnMZSAJVf?=
 =?us-ascii?Q?omQ2IOldrdcf7swQ20U6eDg1omFzF4h8aX2t8RuX1dFhIG7xH0RIt5ocLBKl?=
 =?us-ascii?Q?pIPSK7v7X4Ukx2HEotYVRK21i/4130U7OInRlLNkpQJL1o6eLH8SftrxqRwW?=
 =?us-ascii?Q?xUl/OeKCMX5fq6oXCvnpV5DNDzpTYRvlUpFOhWZnreoXuqPZJhU6xJTVmONW?=
 =?us-ascii?Q?Zy+JKXvN1WjczPTdThlEC0ZRTecnfrAhRbIo0tpOalUXA4zD20RNXGY70I42?=
 =?us-ascii?Q?GyKWthwT3kaejQmNjezgG7TSp0xDD/g=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8b09e1-3ef2-4e23-84bf-08da47a190fb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 09:47:27.7024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6WTixblNnvlI2PgUM22i1zoWrnKkqkXDg9TD/XlO5AbjtWD/KOOX7C348r1LOUOdwxBMmmWYXiUd1Q7tLhcTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4802

'''
mptcp: add __mptcp_sched_get_send wrapper

This patch defines the wrapper __mptcp_sched_get_send(), invoke
get_subflow() of msk->sched in it. Use this wrapper instead of using
mptcp_subflow_get_send() directly in __mptcp_push_pending().

Set the subflow pointers array in struct mptcp_sched_data before invoking
get_subflow(), then it can be used in get_subflow() in the BPF contexts.

Check the subflow scheduled flags in __mptcp_push_pending() to test which
subflow or subflows are picked by the scheduler, use them to send data.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 76 ++++++++++++++++++++++++--------------------
 net/mptcp/protocol.h |  4 +--
 net/mptcp/sched.c    | 59 ++++++++--------------------------
 net/mptcp/subflow.c  |  1 -
 4 files changed, 56 insertions(+), 84 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d6aef4b13b8a..c7a1e15a66fe 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1551,58 +1551,59 @@ void mptcp_check_and_set_pending(struct sock *sk)
=20
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
-	struct sock *prev_ssk =3D NULL, *ssk =3D NULL;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info =3D {
-				.flags =3D flags,
+		.flags =3D flags,
 	};
 	struct mptcp_data_frag *dfrag;
-	int len, copied =3D 0;
+	int len, copied =3D 0, err;
+	struct sock *ssk =3D NULL;
=20
 	while ((dfrag =3D mptcp_send_head(sk))) {
 		info.sent =3D dfrag->already_sent;
 		info.limit =3D dfrag->data_len;
 		len =3D dfrag->data_len - dfrag->already_sent;
 		while (len > 0) {
-			int ret =3D 0;
+			int ret =3D 0, max =3D 0;
=20
-			prev_ssk =3D ssk;
-			ssk =3D mptcp_sched_get_send(msk);
-
-			/* First check. If the ssk has changed since
-			 * the last round, release prev_ssk
-			 */
-			if (ssk !=3D prev_ssk && prev_ssk)
-				mptcp_push_release(prev_ssk, &info);
-			if (!ssk)
+			err =3D __mptcp_sched_get_send(msk);
+			if (err)
 				goto out;
=20
-			/* Need to lock the new subflow only if different
-			 * from the previous one, otherwise we are still
-			 * helding the relevant lock
-			 */
-			if (ssk !=3D prev_ssk)
-				lock_sock(ssk);
+			mptcp_for_each_subflow(msk, subflow) {
+				if (READ_ONCE(subflow->scheduled)) {
+					ssk =3D mptcp_subflow_tcp_sock(subflow);
+					if (!ssk)
+						goto out;
=20
-			ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <=3D 0) {
-				mptcp_push_release(ssk, &info);
-				goto out;
+					lock_sock(ssk);
+
+					ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+					if (ret <=3D 0) {
+						mptcp_push_release(ssk, &info);
+						goto out;
+					}
+
+					if (ret > max)
+						max =3D ret;
+
+					mptcp_push_release(ssk, &info);
+
+					msk->last_snd =3D ssk;
+					mptcp_subflow_set_scheduled(subflow, false);
+				}
 			}
=20
-			info.sent +=3D ret;
-			copied +=3D ret;
-			len -=3D ret;
+			info.sent +=3D max;
+			copied +=3D max;
+			len -=3D max;
=20
-			mptcp_update_post_push(msk, dfrag, ret);
+			mptcp_update_post_push(msk, dfrag, max);
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
=20
-	/* at this point we held the socket lock for the last subflow we used */
-	if (ssk)
-		mptcp_push_release(ssk, &info);
-
 out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
@@ -1634,7 +1635,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -2195,12 +2196,17 @@ static void mptcp_timeout_timer(struct timer_list *=
t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup =3D NULL, *pick =3D NULL;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count =3D INT_MAX;
=20
+	sock_owned_by_me((const struct sock *)msk);
+
+	if (__mptcp_check_fallback(msk))
+		return NULL;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
=20
@@ -2453,7 +2459,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
=20
 	/* first check ssk: need to kick "stale" logic */
-	ssk =3D mptcp_sched_get_retrans(msk);
+	ssk =3D mptcp_subflow_get_retrans(msk);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3107,7 +3113,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
*ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_sched_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d406b5afbee4..a12507dcf1d5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -632,9 +632,7 @@ void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
+int __mptcp_sched_get_send(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 8858e1fc8b74..9427d15b4c69 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -117,63 +117,32 @@ static int mptcp_sched_data_init(struct mptcp_sock *m=
sk, bool reinject,
 	return 0;
 }
=20
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
+int __mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
 	struct sock *ssk =3D NULL;
-	int i;
=20
 	sock_owned_by_me((struct sock *)msk);
=20
 	/* the following check is moved out of mptcp_subflow_get_send */
 	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
-	}
-
-	if (!msk->sched)
-		return mptcp_subflow_get_send(msk);
-
-	mptcp_sched_data_init(msk, false, &data);
-	msk->sched->get_subflow(msk, &data);
-
-	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk =3D data.contexts[i]->tcp_sock;
-			msk->last_snd =3D ssk;
-			break;
+		if (msk->first && sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			return 0;
 		}
+		return -EINVAL;
 	}
=20
-	return ssk;
-}
-
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
-{
-	struct mptcp_sched_data data;
-	struct sock *ssk =3D NULL;
-	int i;
-
-	sock_owned_by_me((const struct sock *)msk);
-
-	/* the following check is moved out of mptcp_subflow_get_retrans */
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
-	if (!msk->sched)
-		return mptcp_subflow_get_retrans(msk);
+	if (!msk->sched) {
+		ssk =3D mptcp_subflow_get_send(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
=20
-	mptcp_sched_data_init(msk, true, &data);
+	mptcp_sched_data_init(msk, false, &data);
 	msk->sched->get_subflow(msk, &data);
=20
-	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk =3D data.contexts[i]->tcp_sock;
-			msk->last_snd =3D ssk;
-			break;
-		}
-	}
-
-	return ssk;
+	return 0;
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8841e8cd9ad8..e7864a413192 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -881,7 +881,6 @@ static bool validate_mapping(struct sock *ssk, struct s=
k_buff *skb)
 				  subflow->map_data_len))) {
 		/* Mapping does covers past subflow data, invalid */
 		dbg_bad_map(subflow, ssn);
-		return false;
 	}
 	return true;
 }
--=20
2.34.1

