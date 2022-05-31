Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D86210B
	for <mptcp@lists.linux.dev>; Tue, 31 May 2022 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653988212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6qeaeLhCS49ag5oPQUlPBw/DfNU+X0en57Oj78sWy2U=;
	b=LmL9sVKKjtODf9ev1ERObaIJs/GeKPkiyR2fZ35lYSg3RMClvEyVI3KaaREejkGQ3Ht0ev
	VZ0HTnlQzVoLvb4XDA22l+5jMsqxEGZRx2rVEb7Bkv6wfkwvbtlcil5ehHhgF3woOgg8+K
	jXbh1SHkIO3XdztkhQJkEDyGhUevhU4=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-DB7Cw6m-McyeNiZQd9DDvQ-1; Tue, 31 May 2022 11:10:06 +0200
X-MC-Unique: DB7Cw6m-McyeNiZQd9DDvQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n23vZ4tlZKUVx8mN+NnqEC/Z/KT6QcuSVuaEgg8XQoZqKhfb+Nv6O0Cs6FZ13KclgCd+uk0HqX7wWx2A0rsJcxJeOmz9+zZviksz+R9jZyD2MPD4ZFcKn+mzSrJmdDmpbqmCtQRxeADYVvLu9Vu9j1azE1aTfZhIWlILc8cSpGAwk6X0nhM7ernqJwcqLuyWfvB7ccAg5cbLx2bLY1CqdeeWaec0Wv+gI1UZOxx3VqT00S08c16Ixhp7nXzAof5ZVn02TPRCjyJEalDk0QkhFKIKigf7sdGaG3f1yuCNk08BhNVMJRZtououS5WqOtZz19neirlpnVNJr3myD6hOVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yO1a+YtcJ54XPUQMZ+djN76nbPAj4ZonspXA11NptY=;
 b=a8zpmd9qocS0e5rANap4PKG/RpStCHeiZErxwLSDrQvNLb4sIz29WgV2gdLp7jk4MHDgaYnIciFqjqDgtCC4At8XRAC8ppFIg+tHchb9bKr6FuPuC8WwF6HCMuSEUkcyHSg+PEpdVwJ+ao+M7Hc+cADq3PLpL5MuR5gGYVsSUnfKtMXcjtqC5nmfk1ToEY2DPVcG3E6F4SW5ip5LkbSBpj/L2ubOtvgc+FveJiMYO6/4U8FaR+dWP58/8OW/JS9Jw3kyIiYOWhSw2YpIFEubz+82ZSKO7kA4LiZatSuE8c9Y68d5eOOUAqJ4RrsXXG85O9iJaiYMWnjOPWawEHl0sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4356.eurprd04.prod.outlook.com (2603:10a6:208:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 09:10:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 09:10:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 03/10] Squash to "mptcp: add get_subflow wrappers"
Date: Tue, 31 May 2022 17:09:48 +0800
Message-ID: <38eee17dadb62fe1e21a19c875cf63e1cadb0f1f.1653987929.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653987929.git.geliang.tang@suse.com>
References: <cover.1653987929.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0245.apcprd06.prod.outlook.com
 (2603:1096:4:ac::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36170318-7a7d-49a7-174b-08da42e5596c
X-MS-TrafficTypeDiagnostic: AM0PR04MB4356:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB43564413649433582AE436F5F8DC9@AM0PR04MB4356.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0X6uHCy6qzSBVb5CGL6GVBKwH+xF5EojDfEKN1ucSW2p5rgCT9BF3fszJT2f8KwO+i2KUByl1aL2lzTjactMOK6Y3IZs7+64wpvYD9Juz0bLWPBmtPmhiq+Qze+QCjtY5hudPmBOJlyR7IHd5vv4yi5giRmsEEim+fU1TQsVMLUANLQN8QwA45Nks5K7itvF1nEFf8Kv3i87ME3UnI6pzyM2X+z1lP90ak3RH5BR83SnMZVhGVHps4EoI5OfDLRFzJlH2lg/TtMGVxu+bKPqjeAsQNLnuN+K3Pc5xR4KLzxwV2hs6KVllkhBmeYuCFnK+T3uiGVNTBZN2Vg1F9mQnzR8wKyR43Wr654QM7vraXcjY1/8+nfVd3IEqh2lzUq3q29sYu1LuEf2PUzSmqo7dTGPteofZtT0I1yvjutEh7A29RzePoMVH4BzCm8XF4/MNcP2VlrWzhf58b+v5bS1TFxNjd5diz5qXawpBcadrG0QNYOnsKYW+mNkiIfNBmWa1NUlnEwx6Y8VGhTQUsI+ijh6afby0DLiUbT6C0qZdMbZA7hvkh4fddqrUCN97m5RkPhGccoY63CFjviQvWrM+uhfavxMqLq21hBwAevHYl8hNTFtgCj63kmcdgK3iNAEF4isa4xj/xb7DYHG7FzqezfL4rtRAMmPOIP78HMV5zW/i1lXX+jZhe5Vajlpf8Ncb63mFoG8u9D8IRqjC3Ubsw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66946007)(8936002)(6666004)(36756003)(66556008)(4326008)(316002)(6916009)(66476007)(8676002)(6506007)(26005)(6486002)(2906002)(6512007)(508600001)(44832011)(186003)(5660300002)(107886003)(2616005)(86362001)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oZlSJ6zMnsoJTRTeLrBUgM14F2x/qOQ6oGHHxjLOt0KmZWl5b3ScS16WRnOc?=
 =?us-ascii?Q?2cUCjh9PBpFnU9UNTO8Zc0OtvsXqWwhMqJ/m+VJU4Ur9paMo9JaXm6sAorEP?=
 =?us-ascii?Q?cYr9H9RjrprUj2CrQj/mI3wjMF59wZQagcC5uunMaE+TYDkqmmOoM5MWTNAZ?=
 =?us-ascii?Q?whWwt9GWjmUgPa16K4uB5DvUxpaZbYTOFWQKrRURkCBizNOKliiES9Eb70Ew?=
 =?us-ascii?Q?L31aY5qp3jeYyv1MTHBBVA/zQmFtRYH7I9nA+1kaSejvOkmjje0fG8k1fVKv?=
 =?us-ascii?Q?S3iofY9Ndt9NNLTL3YSp9X1UzwhH5HVYTGxV8LBTMZAmrOOXva0aOfdK64VN?=
 =?us-ascii?Q?V2XMlgtLovOcsBzMkLRsuSXXWeMDwWOeUkZlA4OnanK278b93APaBnPtnH0S?=
 =?us-ascii?Q?aSLdv/Oc/lTjzyMOmqN4VkcSwCe/g1SWGV6gB2kyG19s/WKcvl57ccL/cIjZ?=
 =?us-ascii?Q?xdZeRLAuIALGKfjBmOMq53SbGg76KHwFq/2PjRCrefo+2o9B0mN3LVIfhgA/?=
 =?us-ascii?Q?AgvqO7B73L89Mfz0/G3wUgHVZYGm1jvvJF9LzQn23hypp8WcfgvNqDL8M5CD?=
 =?us-ascii?Q?6ukiLC92z/rd+WDo70PuP1qIYGRWsSgGn+R4JvXsLZN0t9yebBRfXht4SlvY?=
 =?us-ascii?Q?ZJ1ic///ZFuVnKsasx4bXn2kWf+MaL/ZFUI3hZLTHPsC1k9LE/rHxVAHkNWI?=
 =?us-ascii?Q?F9c4UlBKkfvUlaBffllpANhSa5O8ca1lQSyk3p+AAuzuVjH9MrWamJKfQLdS?=
 =?us-ascii?Q?bw7404vfThzIbvciWN4SnvpoH3Gj6aY181Ks6E4YdN5N9kcWTjg4KsYbAmpn?=
 =?us-ascii?Q?CQFIxYeQVLPATkZ+304EHKbyCMZTAD0F5BLTOJ+8xRo2BuphPPsfWpaoz2lh?=
 =?us-ascii?Q?8priKWj9kOrWo5H08/5hUZd7QKCb96kZYZotNZSI6PgsyQBpX2SPnYxCTR4a?=
 =?us-ascii?Q?QKXVN3Lt1b5F3fsa3s27pkP3LtNMdIt4aDcC9YC5kbehSoBsWXEyTLoGgviE?=
 =?us-ascii?Q?BdvHzVzQbU5QXEj68vYO7UAydkqn5kPbRqV4i3Zob27M5q7Av9C6gpp6l/Vx?=
 =?us-ascii?Q?IaZerjccNkmYoqqKtfLQmdsvMBzmod1Eea8G+2xQl+dNzrqFKtsH2W0vNA53?=
 =?us-ascii?Q?9Y2Xe7l6ytJS+m8WcwB3Meju345WsbX05EVzZz5vHecVNoJ04mybeOWiJjWn?=
 =?us-ascii?Q?Y/H+m42pmmKlB8sKpvQxD/5rQbWvbxKAHhkMrfA+mfrq36+nHjxwZ+8Vu0Hf?=
 =?us-ascii?Q?NsD/XrONRfh7f5e9pGql/zd8b0ZuDuyRmjgAWCJGOUYQuz9MPiXeIsxcbQXc?=
 =?us-ascii?Q?PW5Dzx91B+95mQ56zgw90oMcQzO+aWUfpXreT30dBInnD43lri7c80mPuycI?=
 =?us-ascii?Q?ndb428J+krRS+qsbqXBtJSU8DIU0B7PmlyAQs30M8E0ylCnwLXKbtRJlIJUe?=
 =?us-ascii?Q?uFnWvxo89Fk2pgontkaag0IqyG+mYMc6xe//vhbrXNXVEvojV5+hyR4/17My?=
 =?us-ascii?Q?2bBfhDU1a6bPjck/KEu7d/qrfse46lP9TgyuL50iQoaQMiuewAs3tbuwy5gg?=
 =?us-ascii?Q?IywlGy9i18tvbGSAhI7MnX9Er4jWKlY5e7eK84DNbFrd7zlfv3dMqF1u26+F?=
 =?us-ascii?Q?z0BhSDR6HaW6zKJSkRLxgowzm/oFAbe4iJonnGlPEx1YXw5m6xhTgp2syk3N?=
 =?us-ascii?Q?OXwvsNLRP+fXjxmwHLgpQ7vr4hpXEpQcvcrMWImlFFuXP1GG8qCpTBN4x55p?=
 =?us-ascii?Q?n2DAeMpW8c2XD6MJNVIg7XC+hU07Dhg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36170318-7a7d-49a7-174b-08da42e5596c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 09:10:04.4358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 631Sxa+hOZMHUTMYfbHMhAKkWpDrcQfdGnxwp2Kmtk7TZTl3o44r37c3pUyHFeYI4kBItXqtsNaH+F3demvHRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4356

Please update the commit log:

'''
This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.
Use them instead of using mptcp_subflow_get_send() or
mptcp_subflow_get_retrans() directly.

Set the subflow pointers array in struct mptcp_sched_data before invoking
get_subflow(), then it can be used in get_subflow() in the BPF contexts.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 54 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 3ceb721e6489..613b7005938c 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -88,11 +88,25 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 	bpf_module_put(sched, sched->owner);
 }
=20
-static int mptcp_sched_data_init(struct mptcp_sock *msk,
+static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
 				 struct mptcp_sched_data *data)
 {
-	data->sock =3D NULL;
-	data->call_again =3D 0;
+	struct mptcp_subflow_context *subflow;
+	int i =3D 0;
+
+	data->reinject =3D reinject;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (i =3D=3D MPTCP_SUBFLOWS_MAX) {
+			pr_warn_once("too many subflows");
+			break;
+		}
+		WRITE_ONCE(subflow->scheduled, false);
+		data->contexts[i++] =3D subflow;
+	}
+
+	for (; i < MPTCP_SUBFLOWS_MAX; i++)
+		data->contexts[i] =3D NULL;
=20
 	return 0;
 }
@@ -100,6 +114,8 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk=
,
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
+	struct sock *ssk =3D NULL;
+	int i;
=20
 	sock_owned_by_me((struct sock *)msk);
=20
@@ -113,16 +129,25 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *=
msk)
 	if (!msk->sched)
 		return mptcp_subflow_get_send(msk);
=20
-	mptcp_sched_data_init(msk, &data);
-	msk->sched->get_subflow(msk, false, &data);
+	mptcp_sched_data_init(msk, false, &data);
+	msk->sched->get_subflow(msk, &data);
+
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
+			ssk =3D data.contexts[i]->tcp_sock;
+			msk->last_snd =3D ssk;
+			break;
+		}
+	}
=20
-	msk->last_snd =3D data.sock;
-	return data.sock;
+	return ssk;
 }
=20
 struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
+	struct sock *ssk =3D NULL;
+	int i;
=20
 	sock_owned_by_me((const struct sock *)msk);
=20
@@ -133,9 +158,16 @@ struct sock *mptcp_sched_get_retrans(struct mptcp_sock=
 *msk)
 	if (!msk->sched)
 		return mptcp_subflow_get_retrans(msk);
=20
-	mptcp_sched_data_init(msk, &data);
-	msk->sched->get_subflow(msk, true, &data);
+	mptcp_sched_data_init(msk, true, &data);
+	msk->sched->get_subflow(msk, &data);
+
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
+			ssk =3D data.contexts[i]->tcp_sock;
+			msk->last_snd =3D ssk;
+			break;
+		}
+	}
=20
-	msk->last_snd =3D data.sock;
-	return data.sock;
+	return ssk;
 }
--=20
2.34.1

