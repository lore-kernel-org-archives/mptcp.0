Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496E7E
	for <mptcp@lists.linux.dev>; Sun,  5 Jun 2022 13:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654435804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/zdKWG2EBqMzuN9rcmWq+IpOR4s0ra7aCa3OsLQBzw=;
	b=SdCUash9RiEf0F+G5GcXhRDXOQ49iGAVTy3v9aIEohCPViSXPmXLGQC4wixO5ssApP6K+x
	gy8KGhnsb7DfApg4oUGL7uznmyVftHzzJrsy+D2DoumaE22avRMMy7IfGkuF9nO6L4YRvz
	zVqnaIe/Ph/UAMJwjCoaN4Kie0nRRGU=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-VT6uvFqqM4iGCA4uV7mItQ-2; Sun, 05 Jun 2022 15:30:03 +0200
X-MC-Unique: VT6uvFqqM4iGCA4uV7mItQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbecyBAAJDnTrPqUcPCtdHYE9YU50PIhlE0PbcUtPRwmMjfN/N9YyeOPfddDXE0MgA6g2BKNvVbj3STiQPNzojjiS7l9YqcMEi8my+uyRHKDZX5C1nAGwVlshUE++5dIS9qjJNxqHYmxfd/1mI0wtjC5FJPwQ4Y6i8C3K291TE0IGm/cmtdBEfcDshv7tVq+dH0NMvh5dkryGQJQO6meAr890NxGu9O1K9izD18EEbFMtN82nXCelE4ah0PVVGjvkrv6CzfsUKd6ereO0ZbxJQG8DTY4NpCQIgPtFQZE8cW0RMXH0Or8ls1NkaEcQWC8zBVuDaIKoUCb2cYBENTfTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWyPHO86ltvZ7vxj64NyInBIg1DKQysrlAB2kZTCdQA=;
 b=GJK6ns5djOxNozig1h2I0+DyD90CI+obJ0LkjAw2IIgGrUu6VXd57ZxNOuYRPU5GQ8wi+5Rf7S0ywLwm0C1PCVse/fgXaqW746zPXqEmR8ooEgvNG4ILopmdAYTIorKx0hZ7R8fvZ06e0/tE0n+ypNr21lHcwBchECE45cjYSNK51sHJSPeyU4TZ8k3FjRktQj9Bti/XxrBwB9Sp8ofMHvc+WVPeXpILnfI2PBT97Y9AN4qX+WjrHZs3UUB2ZrjrUugdbWhFI5+9hG3zD+L5JZ4T5s2dm6mGAeXhcPFLGPNonbkVrkqLGeI2N3b80d6gDiumCUtuZ+ScI4z75NXAPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5028.eurprd04.prod.outlook.com (2603:10a6:208:cc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Sun, 5 Jun
 2022 13:30:02 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::5082:d38e:6d50:4f7f]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::5082:d38e:6d50:4f7f%7]) with mapi id 15.20.5314.018; Sun, 5 Jun 2022
 13:30:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/5] Squash to "mptcp: add get_subflow wrappers"
Date: Sun,  5 Jun 2022 21:29:36 +0800
Message-ID: <de45f33b2c22e5d56f94156db2bf1820ac68ed43.1654435294.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654435294.git.geliang.tang@suse.com>
References: <cover.1654435294.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62969358-4648-403f-a0ea-08da46f77e70
X-MS-TrafficTypeDiagnostic: AM0PR04MB5028:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB50286E4350C571F0C1E39343F8A39@AM0PR04MB5028.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3BkQvyvWE9nM/d5Gps6F2YNK9s96g631tvxeH+GhlJQcaBXjFR/z0k3VYmAeYgaad+8T1F6lYz3WZ6uwvtRMDsbu6YtRpPBz/wq80zyTUX9yAYIMYZHE5h4URinp4erNC7GttFb/S4Xmto9A29GDI6D6M2oN+tOdBbBkIpSsKJ3QDtNZX1KDWz3uyHIfV87V6PeG7x5hLO+wACd7ovV/XNCG6P14SZLnTuRSk+UNg73w7+CwDDL8jr2EmnffAFk+/EVgZRZruL9R3JbbWJ/98DRm31f8j/zUJnepKgQDAzMwCSxPov39o5Bo5lH9tWQMFd3DGdkPxcxhl+eKdQzdvEh8ASQDe5owRFW1ZAgcNdXHucAm13PAnKy+6uq/YETZ71dywGdYuhChXsspbT+KuPFlEAbBslKdSBWzLgFIGad8XYsHipkXkzJb8wEKbEBgGj3j9HEuO1+HYZ3aT/gIvD8D4FH3CH7CyTj9Z8kxVnac9TdWVix1Y9FuhZcTsQZBxLf3TKNyJ/n9zeC2zBjm7haxP45uP92rxrh1UjEQYhlL6y5VMp+mJjiZSMvefpitmuIsmkekDxWfnxhKwovTxRMC90PgYPERvVSyyGWZoGhxqcuR5Ey4F8HAN6LBhAWtO4RNkBNQlK6BY9RwpoQxVUBXkQqF5ce6WRBSWitXdVk3XGzf0KSiqm2gJWWmIZo1hvHYFPRdQQj4BrjrPY3KvA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(66476007)(66556008)(66946007)(38100700002)(107886003)(8676002)(186003)(6486002)(86362001)(6916009)(26005)(6512007)(508600001)(5660300002)(44832011)(36756003)(316002)(6506007)(2616005)(4326008)(2906002)(8936002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HKKAor/2dLn24o1vSSy+CMNdzOcwqqAsuXQ8IkN/oc43da7j09qjfc3gQ74O?=
 =?us-ascii?Q?sytJhXRYwrLflwlLoZq/mlSbkXdgj1fqz0MD4coIrBsN9gLrBBDiw1VLStlX?=
 =?us-ascii?Q?Mty7Deuq01URfL+bwdcYPIKvmQDNO3u7h1zfEHA0G5l1iF2H5IVq2EA5Hd8U?=
 =?us-ascii?Q?Xjdvin8G4PUj91TfZmAQYBmkmG6ML65kat+vF+HCOI2aKVa+ACZ/WM62UjwS?=
 =?us-ascii?Q?/e7LExfIKfSbM6R/JcXK2gjVp4zx7ThMpn53Xvyz+fW3r6hemGI72FpU+FC6?=
 =?us-ascii?Q?asok9XZ3ASpAGm+lMTdok1KNT/wSxX291GPvV5/JbSOUf9+KF+0xsqYaxr0I?=
 =?us-ascii?Q?5j4I7PZKK9Y498YIJdw4Ac2kKABh9niLE/UA2W4bjUNGIh9rfZimpl70oPfp?=
 =?us-ascii?Q?Eb1YVmlpc66YNUX7eVnODrRZmPaqWC78hRjG/d44tc3Eb6p5csW2lPBA3aP2?=
 =?us-ascii?Q?EtBaT5/hOcCG+tNY+SU8d3/NVDFU7RfMYwNkO1RZDRDIXknukUJaNDwWUuuT?=
 =?us-ascii?Q?Q46Or608pArJUy2Qd19zPZhoSPRt4/C+1mQq2B+4RR+n44uHuXlgEZ6iyrM8?=
 =?us-ascii?Q?hQZw6T72e8oMd4nu9O3IQA7vZltK9QBpvVcCWQe4Cfe1bDtTxjvb81N/AhTi?=
 =?us-ascii?Q?WwbUsrF0lClxzrIUEV+xFQvubfR/SoTfS/qiXLv8V9ybTpMgTmhmeM6VqsDK?=
 =?us-ascii?Q?v8fRbd0r5+EZI9s0w7pEsL2p5mucc4oFEdoNuW11wqN3bPm6VdqRsZkmgpAX?=
 =?us-ascii?Q?TXzM/Jbf7YO/xabS7xMwoonMG+Wiu/2QvHDusa2u0XsOoaAMN+efT62UAJ0D?=
 =?us-ascii?Q?+ZoQB9M8NacN6NBEryinVpvT/vQGN2wDJ9mltXIkYIvmKpcbSvv4f93u96xm?=
 =?us-ascii?Q?fw5Zb9IijplDUR5bZNt19J3AF5qxFgfRCm3ZYYFFvCeK9CjC9VLu/gTqfuSu?=
 =?us-ascii?Q?5R67vZQu5NOlno1hV1KZvui0zReWMR/HbQ3fTk2/Fkyb818/nWOGbHoAZSdU?=
 =?us-ascii?Q?5bZCCJM99bUmfzRMohQZtwR2QAEdnnxMNViBX6IkXw0Q18Q9KP60+NMWKOII?=
 =?us-ascii?Q?2dJEQNJa2WQqJcfQTEhrmTJit0+siVUESDxDI9ttrxFVbkK1Mr55ujAvpejZ?=
 =?us-ascii?Q?jv+5tKINkVekJ+Jc57jYba1CRIgWuXlGEqAhHXqdOD5BCYfeBusnfPPMDYW5?=
 =?us-ascii?Q?J6N4CLkTgYsRg0Qaf+M1cCkge8qQrk0N1oaEs2wpmgWZ8KYONdPQJ0zOjG7L?=
 =?us-ascii?Q?qizsNPsjNClgVZ7EtO19WTmYNdE4veCOJNFzmGRTV6TyC/Bitap7gmMUmLmy?=
 =?us-ascii?Q?8nG11hhMNO9OujLEqXKrg1uNurMD4Y5OevJAT/uMJEs4HIQi/uQFFYGYVP1c?=
 =?us-ascii?Q?jNNxBbGdw32nL9u7FcU4la7HzgXTEbDRnIWf8Z/eSn74ErejGwP+GInP2g4O?=
 =?us-ascii?Q?oEOJznpJZHA0r/bA9aa8FZxSXrr/pZHHZR4xwg/7Ag/SHJNraYdgSTBIU8eE?=
 =?us-ascii?Q?IRDVnQBRLx+jgO3iMDkXThkkJ2HRRuAoSl+6karguEP8L59vbyNrFs0rpEHD?=
 =?us-ascii?Q?ow00mfluRLmRQAd6wVYnt14oslpwO5cGJIQh7VMM8EwZqoBFPC1exw6ecGSn?=
 =?us-ascii?Q?wDbIsNHOi3miW04+BHsLsJUxe30bQnD4RqF11DvLFz+8+BiY2F+9yJ/pBl5D?=
 =?us-ascii?Q?kgub7TjZCg6yBBbzYPmV3ZlcFP6ltj39IrGdDO2sQ4qtXMtQ5+s43AAY4T18?=
 =?us-ascii?Q?2Q66N2nxXOp80v0rKBcx88/9KZtOg6g=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62969358-4648-403f-a0ea-08da46f77e70
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2022 13:30:02.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+iGdKEuBo4H589XvthPNQZ9duddYlzQASwRYk+pzZwHLYQt/ZDwGCazdfxbO6QWeQcCH8BRO3itsylQsQmMHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5028

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
 net/mptcp/protocol.c | 72 ++++++++++++++++++++++++--------------------
 net/mptcp/protocol.h |  4 +--
 net/mptcp/sched.c    | 59 +++++++++---------------------------
 net/mptcp/subflow.c  |  1 -
 4 files changed, 55 insertions(+), 81 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d6aef4b13b8a..06192eebbd57 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1551,7 +1551,6 @@ void mptcp_check_and_set_pending(struct sock *sk)
=20
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
-	struct sock *prev_ssk =3D NULL, *ssk =3D NULL;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_sendmsg_info info =3D {
 				.flags =3D flags,
@@ -1564,45 +1563,49 @@ void __mptcp_push_pending(struct sock *sk, unsigned=
 int flags)
 		info.limit =3D dfrag->data_len;
 		len =3D dfrag->data_len - dfrag->already_sent;
 		while (len > 0) {
+			struct mptcp_subflow_context *subflow;
+			struct sock *ssk =3D NULL;
 			int ret =3D 0;
+			int max =3D 0;
+			int err;
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
@@ -1634,7 +1637,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -2195,12 +2198,17 @@ static void mptcp_timeout_timer(struct timer_list *=
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
@@ -2453,7 +2461,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
=20
 	/* first check ssk: need to kick "stale" logic */
-	ssk =3D mptcp_sched_get_retrans(msk);
+	ssk =3D mptcp_subflow_get_retrans(msk);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3107,7 +3115,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
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

