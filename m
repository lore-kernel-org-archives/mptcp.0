Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827337A
	for <mptcp@lists.linux.dev>; Mon,  7 Mar 2022 13:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646658590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2bXrOq1W7bOTFV+A157v5ygWfVd57+UL+mlsSG9W0wE=;
	b=cFTA593I9k14uYgkzR6KHRz4d1qg25J78nfIAbiHCCelANeaL97+IZlMVHEeyP39xVsf8g
	boyBrZYCCy5TET5Rky87XKys7L8uy9Ebn11poP5JUR/wivq5Xn26gHeMjzTv61fsC0cK/S
	RFJITd7+FYochIeNXJg1Kxt57P+kB4E=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-HFpbeb3XNuuFaj5sHpTKlw-1; Mon, 07 Mar 2022 14:09:50 +0100
X-MC-Unique: HFpbeb3XNuuFaj5sHpTKlw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6LQovdYd4e3RVAdhq+jVPD2eHfWafiIjKLE/5UkLkaoUpBYxG2ME62DkH/RNqpmc31gLJPa4YbOPOqseq2uspVqG0lLpFb7dnKXlHo/qZz76N9GxyKGvaRoELN1Qj/xsGkg+UP6QOXfTn82G1sX7XfDzrV7ZuXl7pOpZWWHZPRtomEWKVtKqJHiegSU1KMwi6ITLv+y3iCjgt4PaFvQtNLriCpjA4jcCoNnrzCYaMiorofw6I7/Xk9YlwSxDdZCkgP2C79nCm6CKhGz/OIKTiOjSwcf6d0QFeQ/AZu+b0yGDbipMP9OjsKFq4IQtSPS0I7FhkZpxLqsZeZyXvQ9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JT3RrPL60f+JcX6km1XAEgb/2ct0D43cKnjpjTuqpMM=;
 b=BcUv+N9I3qY6RgcULoi5BGwTtyNRgDteDf4nsAF7kMMsAvI8nRXB2Z8iPUN6EOS/ym77e73JEMgFeHcQvPvCLMi4ERKJ8zPBqAVqz07zX79ZMfolkEff899fqnJTK+k2Hgr7z753B//G0BEHZk5aTCpqACVzSFF8UXVNaYL9s+uw3DjooIcZLAXWTKJO/aydhNXUdLsngqnnqnuPo2F8wNZdL8D0Q7nhnIcQJzjN9df56a7hyOtzEn5aJVU0QhWNGyJ3FKQf29ZC3J23tzQpSgplkfy0/qNbAK2S6hJsP4Y8ZKGaSWWB8XHgDt5DmIoDHjgNfp2R+oD5ChoRywoL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6968.eurprd04.prod.outlook.com (2603:10a6:20b:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Mon, 7 Mar
 2022 13:09:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 13:09:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/3] mptcp: reset the subflow when MP_FAIL is lost
Date: Mon,  7 Mar 2022 21:09:17 +0800
Message-ID: <43b328bce5479e34e1dbf78b29b8d5d7d8ed2e02.1646657963.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646657963.git.geliang.tang@suse.com>
References: <cover.1646657963.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f8eeb8a-fb9b-4b65-cf61-08da003bc228
X-MS-TrafficTypeDiagnostic: AM7PR04MB6968:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB69687EE40C97219DCD76C523F8089@AM7PR04MB6968.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EwMoc+Kw71pjIWzZOsH9p6beS4Tt0TGK/+A/ScGI791Jxb6MIXjETiq1Dt9obd2va3wbqQNFAkknBhslG+1NI1d8DSUkJNvZvsvW8Qb96ePQ1rn2V78kARlNwwMEuh2kRzpQtKpg+1MUvSJ9dlpVW46m197aRWaU8J38P1G6MVfVirubkz5bAfGnWLiWzBbF1thwbrJoxewqjtgRJR42qDPS6Zk5z5grKuG8uQqTEn94BHTrIywtIS30KgNs1lWPiD/iGDg6ZVgPcWBXUv3+sjBSU1bfZn2u38ouCGH/2yjI/Wg3J2MVdi4vRHQTLItgFlXr2ZfSdq29BqYLNlLNkSoIhib3qA2pQt+IMTlBETTF7zvZ9ok3sVDw35tIqnOSEhH0mUhyxXxf+4aX4tyJAs2FmTcdztb+DfAOPAjVW5D5I87IfJnu8E7O+WuBvoJnWeuFRtxICmI3pQXSElSmN/7b/6aomJ1Jr6bYSdrW9/JpuTkDtQTsLfKSFt1oVmgwpTNJ97qZAKA58qCd2CDCDTX2IK/SclBGfCLqVDdY3ZI02VFVaG+Cvk7DzgA0fKBFOtbwfIf8WZ51/O8QcY1w+ZPNM6ctOczeusPtzz/JcIReu4i7YEy7Dtv1+1eYROjiIM9IPcVVLl+7C6E52RTQkRN5Gwgnr5UgXpaKE2lKQ4WQ4I+njmf1ROd3JgVfI2ZM8LhnLspSuIqtyHveWE6tgA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(66946007)(66476007)(36756003)(66556008)(4326008)(316002)(6486002)(6916009)(86362001)(8936002)(44832011)(5660300002)(2906002)(508600001)(2616005)(107886003)(83380400001)(38100700002)(186003)(6512007)(6506007)(26005)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bFaHlzd/z1P6IRBvCm0e1NipbIoCz1Kgtg4tinkttIPjT7p0GZsHF849AGgS?=
 =?us-ascii?Q?zvcwy1TDNuUTsw3NrmPVJbw9+AclOEwXdYtdpfmJ/DOe4PrrEwkBONZkqPZ2?=
 =?us-ascii?Q?ZR5tlUrP+H20RdtSR96+P57KwBNav7OD6lXGVq0lg8IoVrceaiKUQH21Y9Gt?=
 =?us-ascii?Q?5epBD4Wv4SMM58g1Ro2lbMh3dv7+lbx7NHFrlqXbvLoTp6rpTQJeagcDk0sQ?=
 =?us-ascii?Q?lyvyDLSziYsRvfsXMunyqdrhfzvI+wG54JwCbOZ9lrfHzjTdHfm1hl5tU3ae?=
 =?us-ascii?Q?3bg0yWxyScy/ZeQeaAzqbOMyyVPVMnv1xxutE1K+f3liagkiQBaGGiUUNOo3?=
 =?us-ascii?Q?l0aBVqDU4MHyYa5KkCS726URoe+Lv+EBmXw+u71RtYeDaXnqOaR70kl3BvR3?=
 =?us-ascii?Q?vAw83++5wjw6K8ha6vmVo8Qs2hjnf/p8vihJ7BhENrk0xum6OVap9Bg68q4B?=
 =?us-ascii?Q?2MA1Og+voslqF1EHXp21aRUtcVoTljZ2z7iUK5AP2J5eB4MbiJ8xaCJf1Rg1?=
 =?us-ascii?Q?oBZfu++obk4EnCUHvZ7v/omZTJRKxVyC7Lv+OQWSlpBFGBLbrPi2PxBfdVLJ?=
 =?us-ascii?Q?uBY29CEfqaWd/MWDyJmprPDM8p7N5hmPEZqL2A8MpmUVKwirlioUHeQOWg2y?=
 =?us-ascii?Q?tsMVnQ/zn6bhV+BDYcjnDeYGRAniULVv4ZEN7iUkOndBCEkWg7SAK/jimlTT?=
 =?us-ascii?Q?qavVAWo7VJOoANXc2zyoudG/7aCtyeezWSmWIaZu8ytxxmBVXPvPCwj8m56q?=
 =?us-ascii?Q?20FoMffvpDhBPONM6KM2jYQziD0st5ucaGKQIu7VS22d7VuiiTj0BwP8UOLc?=
 =?us-ascii?Q?34j4JANPKywQxyxl0iB9THSdgOAth2SjTBbFeLPdRScSW6MKmiFwPQsoLa1r?=
 =?us-ascii?Q?TDEYdFhhGi+xFEdKRWg0d0RZ1mBApxCflXux4CX3xyTJ3eeZ3bbsdUdtvw0f?=
 =?us-ascii?Q?XthuWM1Gy3GCDpJ/VnCbRf5i2BqNHi20XMuuSL6roiPl7MrdsCnQh/G+vNSF?=
 =?us-ascii?Q?KgsycaGRTtJsX+OcwIq0d4ZNvq/bfrAreJbQuIH6xmHdIBSBby6ERmD0qmyg?=
 =?us-ascii?Q?O6LcT8JQntY5y43g4bJp7gTOJ6KXgY1a8EiY/tlOBD9qzinNVDlIoGL6RSsJ?=
 =?us-ascii?Q?TC41xgOJFoUoNxxCFKSFBHDAw2fvoNyEcEkusCccPbkR06nwFhwrfJZAh0+Q?=
 =?us-ascii?Q?rlVEoDSGlGcIPqhaB0f914uZIYw5iftyEpMtzA7tVLD3QWZtz9Y+NM7PBxWz?=
 =?us-ascii?Q?xlosp5JswLYLRVfGeCjtJmxJYRhRENrnrl6EaUbGNdSKEkCWUQtJE8qKgXzP?=
 =?us-ascii?Q?G/qJBxzCyxBqS3kOQT9y30S8f1R8s6Svht901lLSEd+nT/zkpTYsX1UXjoI0?=
 =?us-ascii?Q?lBNle+VExoS+wCrmfxGsJ4E+MvpQU/qhEIDHYAg9DVsLqialKBeJUjozgSDl?=
 =?us-ascii?Q?A8tFwcM29Z2rSK0u+2ttRlUL9m0v+yI+WgG/dr1VC9SeS5spQKJSAo7USwGG?=
 =?us-ascii?Q?3RplVcnQW2T2kzT1XM1C5kZ9jUM25n648mGPdJ8DE2Tqk92m4hPdyIj5pz7S?=
 =?us-ascii?Q?1dj4gpoE63WG3LiyW1RN1I+95MbYRD9u+JT13vzplgSfw8Ry+G6+ER4vKI51?=
 =?us-ascii?Q?BmB7IMl204LbC2McAyw2aAs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8eeb8a-fb9b-4b65-cf61-08da003bc228
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 13:09:48.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLVneWYmnidp8Tk0+D3fQY0LBeMIadgUVxdZ23P/2aixuHTby7KCLpPq36DruDRMzpO2ieGfiGwMqyjvWJdhGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6968

This patch reuses icsk_retransmit_timer to trigger a check if we have
not received a response from the peer after sending MP_FAIL. If the
peer doesn't respond properly, reset the subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c       |  5 ++++
 net/mptcp/protocol.c | 63 ++++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  1 +
 4 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7aae8c2e845b..2630018786c6 100644
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
@@ -284,6 +285,10 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fa=
il_seq)
 			subflow->send_mp_fail =3D 1;
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 			subflow->send_infinite_map =3D 1;
+		} else {
+			mptcp_data_lock(s);
+			sk_stop_timer(s, &msk->sk.icsk_retransmit_timer);
+			mptcp_data_unlock(s);
 		}
 	}
 }
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3cb975227d12..8702f7123143 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -866,6 +866,59 @@ static void mptcp_reset_timer(struct sock *sk)
 	sk_reset_timer(sk, &icsk->icsk_retransmit_timer, jiffies + tout);
 }
=20
+static struct mptcp_subflow_context *
+mp_fail_response_expect_subflow(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow, *ret =3D NULL;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (subflow->mp_fail_response_expect) {
+			ret =3D subflow;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static void mptcp_mp_fail_timer(struct timer_list *t)
+{
+	struct inet_connection_sock *icsk =3D from_timer(icsk, t,
+						       icsk_retransmit_timer);
+	struct sock *sk =3D &icsk->icsk_inet.sk;
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	if (!sk || inet_sk_state_load(sk) =3D=3D TCP_CLOSE)
+		return;
+
+	spin_lock_bh(&msk->pm.lock);
+	subflow =3D mp_fail_response_expect_subflow(msk);
+	spin_unlock_bh(&msk->pm.lock);
+	if (subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+		pr_debug("MP_FAIL is lost, reset the subflow");
+		bh_lock_sock(ssk);
+		mptcp_subflow_reset(ssk);
+		bh_unlock_sock(ssk);
+	}
+	sock_put(sk);
+}
+
+void mptcp_setup_mp_fail_timer(struct mptcp_sock *msk)
+{
+	struct sock *sk =3D (struct sock *)msk;
+
+	mptcp_data_lock(sk);
+	/* re-use the csk retrans timer for MP_FAIL retrans */
+	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
+	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_mp_fail_timer, 0);
+	__mptcp_set_timeout(sk, TCP_RTO_MAX);
+	mptcp_reset_timer(sk);
+	mptcp_data_unlock(sk);
+}
+
 bool mptcp_schedule_work(struct sock *sk)
 {
 	if (inet_sk_state_load(sk) !=3D TCP_CLOSE &&
@@ -1428,6 +1481,7 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk)
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk =3D (struct sock *)msk;
+	u8 mp_fail_response_expect =3D 0;
 	u32 pace, burst, wmem;
 	int i, nr_active =3D 0;
 	struct sock *ssk;
@@ -1442,11 +1496,15 @@ static struct sock *mptcp_subflow_get_send(struct m=
ptcp_sock *msk)
 		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
 	}
=20
+	if (mp_fail_response_expect_subflow(msk))
+		mp_fail_response_expect =3D 1;
+
 	/* re-use last subflow, if the burst allow that */
 	if (msk->last_snd && msk->snd_burst > 0 &&
 	    sk_stream_memory_free(msk->last_snd) &&
 	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
-		mptcp_set_timeout(sk);
+		if (!mp_fail_response_expect)
+			mptcp_set_timeout(sk);
 		return msk->last_snd;
 	}
=20
@@ -1479,7 +1537,8 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk)
 			send_info[subflow->backup].linger_time =3D linger_time;
 		}
 	}
-	__mptcp_set_timeout(sk, tout);
+	if (!mp_fail_response_expect)
+		__mptcp_set_timeout(sk, tout);
=20
 	/* pick the best backup if no other subflow is active */
 	if (!nr_active)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 39aa22595add..313c1a6c616f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -669,6 +669,7 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const=
 struct sock *ssk);
 void mptcp_data_ready(struct sock *sk, struct sock *ssk);
 bool mptcp_finish_join(struct sock *sk);
 bool mptcp_schedule_work(struct sock *sk);
+void mptcp_setup_mp_fail_timer(struct mptcp_sock *msk);
 int mptcp_setsockopt(struct sock *sk, int level, int optname,
 		     sockptr_t optval, unsigned int optlen);
 int mptcp_getsockopt(struct sock *sk, int level, int optname,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 63a256a94b65..960b161b1cb2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1219,6 +1219,7 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 					sk_eat_skb(ssk, skb);
 			} else {
 				subflow->mp_fail_response_expect =3D 1;
+				mptcp_setup_mp_fail_timer(msk);
 			}
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return true;
--=20
2.34.1

