Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3039772
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 04:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1635482464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z22GC6YsWKL5PBiHPpk1qGMYaRxP05KOXusY9pdq5lI=;
	b=Vflr9XyOSOFbsAZPCAgwTQXt/tH+52l7uGy51q8OJdPilZ6KZdriPbUtTc7IzZFGjZNAXL
	v3RsNVaovui0JBFZpAy5qtcUX6/pCDGscvlkIKpIPL6B+dNGB+enfT/rPXT4vVNwgc5x4s
	5LyWr/lKhaMcT2y5C6X05z5yoxHBf/s=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-30-uKK0a1zPMZqSOfhV1D--Kg-1; Fri, 29 Oct 2021 06:41:03 +0200
X-MC-Unique: uKK0a1zPMZqSOfhV1D--Kg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVDiUVv5yOEk9/CSRDeFC6kRznYZDNe6aVhrI0ZAexvLPbWkVdvh4uUS8lSOvICd1slEBkVkTuI9OCxGpRCWZkYjClC8nsAqA6N+OTvRObR1OLfJTv3AXQCfmGaRwY9YTCRDPQYyS+cJXYPPqapqrm92nCwD9iDzmw0jP4t1O7HqsyRJuVhzaNPLlURwCh4X/n21Ov8eubKDLDDZt5m0BRPCy/zNhFTDsQs+tTmfs2AQ5AKmiY1mh9JAHxaOPGG5IIjWqV7Xr7NWUgITLD5VnIjLC6s3qApT2tql+R/vcolim4L3OSbaKChMvJ6/dAibnnbIcdAU9vrqjrTvmjPgWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhvWHbb2x4Zlj4/Pl8Tc85LWHK7EoCw1dkvh09Q6kvA=;
 b=AUAjxHehT5C3HK/NohDMl4IqZQbLaoA0WI8Vu6hnszaPyuzk62EK/RpMPQZk0zpMDCUSF3a2MdecL09vIJwuzlmsde6jUqeqUittzVq5GB35zlArOMjLNCRWbVHvq0yHw/hQ7+OsdYYNP2gycMbA9czH9W+7gN343r18lw3jJDl7BxnCo1oSO+pdIdQnRIvmW4bel/AlHl3e8tZVpCsgt/zdKzCNsChVyHEsK7rOoxN+7vCIYIbH4O+1MeHIGCE80pNtI7IwZldYQWmnxjC4LRdJ0rZX3IaAjQ7xVhtXL/MguLVldby3gniEp+m7Iy8IGLoWn+azyDMZYo702fqDng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2652.eurprd04.prod.outlook.com (2603:10a6:3:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Fri, 29 Oct
 2021 04:41:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 04:41:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v8 4/8] mptcp: infinite mapping sending
Date: Fri, 29 Oct 2021 12:40:14 +0800
Message-ID: <355f9918b55bec47de9ed14016b6d520a9854180.1635481641.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1635481641.git.geliang.tang@suse.com>
References: <cover.1635481641.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:202:2e::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR06CA0008.apcprd06.prod.outlook.com (2603:1096:202:2e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Fri, 29 Oct 2021 04:41:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f1adc34-7ca3-410d-fa52-08d99a964fbf
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2652:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2652FC9AABB96313B487B324F8879@HE1PR0401MB2652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	orfwjhhpo99QvtGloDqJTS4eS0SHRjXuBX2t1cF4Fk5FvEiBN52LKds55ADBcOMLkQi/hJ/KhWwmuBQHrxCHYn6vUIxK7iB+UCJR779YhMNA4xmKdPTXg0ejNxwzdMIFbA82FqeH5XG6opE7+YhVm1bUWKMrhBkS+txdiqJPntdQsWInlPi21CKx2fAD/RbrsnNZudyDaMdvyMQippf5us7LWqFPrHU+jJNA0HqsSfPag0Tg/lsZDIeJuOscKBuQQiDHuwerM7TN0SfRi67CqZG21IIRMyYOqu22f3Hp0zpkVSv+bdFSBFfVK0ALie2JP8MkiZyI5iSoid5Pzq9CAz/AfEg2r8UGk59e/ty+th7vi1Yc7AH5ShFGyR2VMxpBjYi7LKNFR70ov8Tf5HylQq5ImGSmi5k6IKW2e7HXb3mpCo00QSSgVymJwk1YP3ekV8wH1mFF785wO7nUBhuq1Zjb+LXdqRdgcJK/DFxSJBBMBHMedaVitXNh4uByDHtdDu25PUEnTkIe4tZ8BD7Ff2CQMfUj/yubbcU0Gz6L8AgIAwJ6P/3hiZFR4FoJc9ZMAJ9kGkufXfqBqiE5Bum1++8kMKeT/Pi55Uw4+cbiueLHrGmeNGhn1Fuott/XU6o9IZfIUhAx1yRLml9oQmpn0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(508600001)(4326008)(66946007)(316002)(6496006)(83380400001)(55236004)(8676002)(66556008)(6916009)(6666004)(2906002)(44832011)(66476007)(86362001)(956004)(6486002)(8936002)(2616005)(26005)(36756003)(5660300002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?67ensAOoWdSjogRjf+GohnwJp/mkW60d7lQ6sfCiaY23bb7a9UVngu5YWMDJ?=
 =?us-ascii?Q?BlbVdwCvYcuD7mXLKpC0x1JHxcP8n8XkbcEyOec5uU+YlbmqrmB3PPqvvLZS?=
 =?us-ascii?Q?jDQwr5mey1FAUs3SJKyKZlMhklVBOHCxlmwSAjYog00eLkTWRReANXlaSVOZ?=
 =?us-ascii?Q?MDGkJt7+CB6o2ur5frF+l4+a1staPKnF1hKyDfyMyEpLNTqySZk4hpNiHA3S?=
 =?us-ascii?Q?BhVTP8RvVOLj0AoDHVmfhwv/NM2HnyprEDdeuLL4dpKOTr6ZO6zhsFUJLlbz?=
 =?us-ascii?Q?9eOgnQaTgMCoBku75WwPMZZNRIMzJNESF1VOZwrZjE6zTzb9R/DENsuKlW+H?=
 =?us-ascii?Q?6yaw3IDf5Xhj9S+3sfzy9lDdyPekdiMp87+nkn18Wd35pOFyO1b3mkyRuCj+?=
 =?us-ascii?Q?Ba/QnM4hZi8dThgBJnK7bBZsitW+VIh46depSFl2FkS7GUokQKBK+FEB+24q?=
 =?us-ascii?Q?ggNoJYZvMjaUtPwIw3W94M6hKJNHZM4PRRvdYHpX/YWxSo4KIleKzfH4vaSC?=
 =?us-ascii?Q?wzZk25YLhrmXScB4Z5Gu+5mY/iR9gEcBsoM3UWcT98k1O1YCW0O2/17g/LuI?=
 =?us-ascii?Q?PVZHpN7In2/sMIpphjCfeKOAY4i7MpLY2qu2lsWAZm7VYapnWXp7m5vFzGRp?=
 =?us-ascii?Q?n4ioRzl/4IVmCwJTPJwahvPCsVhZMZmfJK8aQuTg+l8DhsAYXOzLLEU7iW3f?=
 =?us-ascii?Q?1pbYlo3xiJI1DpnA+BmaYXlw+9xo95mKwV/CKGsIiZ2eY5QIUSxp6ndz16PS?=
 =?us-ascii?Q?6fKQFa2/AelhQ1yPwbXPXB+FAg2zylAbc4Ul8bZd5VdJ5Wxj6+l6W7WbiPDV?=
 =?us-ascii?Q?HUazaZGJ3cOh8W7vUlNlf3UfOktFQCVbB1cx+sKKmhcDcppn6UpDMLOKd3wf?=
 =?us-ascii?Q?CLXRq8CGW0icItK2rEPPat+PS8RUrm6HAeSZLD4x29CNm1AP/rcLruprH+h+?=
 =?us-ascii?Q?qXJ7zSnf0sDUqxqlQjd3Ca3yOO/aOj5NtKBOhbbo+/jA0rp3zOYQuuJJxjYe?=
 =?us-ascii?Q?0eYcbj2P4TR2qo/EWH9ixshnP/pnK4PnBOVkRFK8p9aVRQFqVrEqV3Bywuk7?=
 =?us-ascii?Q?Ay7tcR7lPGQqJBtzHLPblUd9xBv2JI2v37ncNVPCwXD/cpGfXBIsJgdysodk?=
 =?us-ascii?Q?eqm4e9uMvZg3pb4FQgt5JefsmHhi+vfnXti/s6m1DRG8c1tjfSajYfQXkTYJ?=
 =?us-ascii?Q?RaDMpLxBjfxOaoAtJuOQvvXtVY0iYvWNOmKadnNJskK9ojs8j+PmXANRDPzT?=
 =?us-ascii?Q?wKjePQPbAdMptUr+cjMytKe8Do5YVlo2eJ7LkctnPvUFlsf31PLFe7Ry3EsB?=
 =?us-ascii?Q?VepQCHTOFr+ci1ORLwBt4Ncj0MbM7zseV8F3R/P7V20R54Bp01VY7gjH7at+?=
 =?us-ascii?Q?ZSLuTnTkw/M98opMJJo5Ygy1iqwU2nDIhfWAHYU9bZy3ywaCEg1+lIVFC9X/?=
 =?us-ascii?Q?i3jtxFs4+ChvNKjQunMf6YM94yMq1/+5hu1D7DzoT7GTaC+CEXGmSuMmqzTO?=
 =?us-ascii?Q?pTMNvetbXd/RJW0ExYAos/MO43XbAqAuABGFGC5yy0fSjinpKYbj84W569ds?=
 =?us-ascii?Q?Y3yEPt8BdJFZVFImZQJdBiY5f5XSaEnEFmkW5t1G99iTR2admEw5rZfuzx54?=
 =?us-ascii?Q?ItN3J264hqQV+pdeasU9erg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1adc34-7ca3-410d-fa52-08d99a964fbf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 04:41:02.5445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szWsI24ey3zx7rmzyheOx5xzNDiGPDCbKgVVo5xXqkltJpkGr2kw/f5zRaVi+aNIFKUv3I9cDxuF9brPr+CqGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2652

This patch added the infinite mapping sending logic.

Added a new flag send_infinite_map in struct mptcp_subflow_context. Set
it true when a single contiguous subflow is in use and the
allow_infinite_fallback flag is true in mptcp_pm_mp_fail_received().

In mptcp_sendmsg_frag(), if this flag is true, call the new function
mptcp_update_infinite_map() to set the infinite mapping.

Added a new flag infinite_map in struct mptcp_ext, set it true in
mptcp_update_infinite_map(), and check this flag in a new helper
mptcp_check_infinite_map().

In mptcp_update_infinite_map(), set data_len and csum to 0, and clear
the send_infinite_map flag, then do fallback.

In mptcp_established_options(), use the helper mptcp_check_infinite_map()
to let the infinite mapping DSS can be sent out in the fallback mode.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  |  3 ++-
 net/mptcp/options.c  |  2 +-
 net/mptcp/pm.c       |  6 ++++++
 net/mptcp/protocol.c | 18 ++++++++++++++++++
 net/mptcp/protocol.h | 12 ++++++++++++
 5 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index a925349b4b89..04f53352a1c9 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -35,7 +35,8 @@ struct mptcp_ext {
 			frozen:1,
 			reset_transient:1;
 	u8		reset_reason:4,
-			csum_reqd:1;
+			csum_reqd:1,
+			infinite_map:1;
 };
=20
 #define MPTCP_RM_IDS_MAX	8
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 7c3420afb1a0..932e19645910 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -816,7 +816,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
=20
 	opts->suboptions =3D 0;
=20
-	if (unlikely(__mptcp_check_fallback(msk)))
+	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb=
)))
 		return false;
=20
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6ab386ff3294..86b38a830b4c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -251,7 +251,13 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bku=
p)
=20
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 {
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
+
 	pr_debug("fail_seq=3D%llu", fail_seq);
+
+	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallb=
ack))
+		subflow->send_infinite_map =3D 1;
 }
=20
 /* path manager helpers */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f3163647c501..70f2e0e212fa 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1226,6 +1226,22 @@ static void mptcp_update_data_checksum(struct sk_buf=
f *skb, int added)
 	mpext->csum =3D csum_fold(csum_block_add(csum, skb_checksum(skb, offset, =
added, 0), offset));
 }
=20
+static void mptcp_update_infinite_map(struct mptcp_sock *msk,
+				      struct sock *ssk,
+				      struct mptcp_ext *mpext)
+{
+	if (!mpext)
+		return;
+
+	mpext->infinite_map =3D 1;
+	mpext->data_len =3D 0;
+	mpext->csum =3D 0;
+
+	mptcp_subflow_ctx(ssk)->send_infinite_map =3D 0;
+	pr_fallback(msk);
+	__mptcp_do_fallback(msk);
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1358,6 +1374,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 out:
 	if (READ_ONCE(msk->csum_enabled))
 		mptcp_update_data_checksum(skb, copy);
+	if (mptcp_subflow_ctx(ssk)->send_infinite_map)
+		mptcp_update_infinite_map(msk, ssk, mpext);
 	mptcp_subflow_ctx(ssk)->rel_write_seq +=3D copy;
 	return copy;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4b9fe56bd572..906c65fca04f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -419,6 +419,7 @@ struct mptcp_subflow_context {
 		backup : 1,
 		send_mp_prio : 1,
 		send_mp_fail : 1,
+		send_infinite_map : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
@@ -852,6 +853,17 @@ static inline void mptcp_do_fallback(struct sock *sk)
=20
 #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=3D%p)", __func__,=
 a)
=20
+static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
+{
+	struct mptcp_ext *mpext;
+
+	mpext =3D skb ? mptcp_get_ext(skb) : NULL;
+	if (mpext && mpext->infinite_map)
+		return true;
+
+	return false;
+}
+
 static inline bool subflow_simultaneous_connect(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
--=20
2.26.2

