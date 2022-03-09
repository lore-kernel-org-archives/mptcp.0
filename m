Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60F27C
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 12:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646829258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQJ2l1BKpPmS4N5RPrNdOP0V3PdXhVSAmHmVgdnuft4=;
	b=lQM3z/O+SUnrUdv9ShNFY0fGC03hSZVMoHI1cW1M3zMqlX5bPPdSvSiov6SORzikXonnSZ
	fzEipwNi2qVFr+pmoMajMwNX5zjV/nwtaRLrsFOBt/56e8VGSeZ7eMn7k8hBvCKc2NrRRW
	qhISwIE2TuDaS6uaDIS9HRHzNKb1AjA=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-EcJ5Yo6VPT6gAvTftD9ETA-1; Wed, 09 Mar 2022 13:34:17 +0100
X-MC-Unique: EcJ5Yo6VPT6gAvTftD9ETA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaDRMQiaH1LOrlw2MRCOCOsrhimxJijJO5QDcCCTEASAGLg6bH4YNKoiM5gWsLBq+yskcU8KUqydZYekypaAPf05WWDtYKFhcfg5A/QWFM9qQCRL+oq+vYKvmkKqkKeuStEcp6nSjYN2eHbKEqAVmQF1GSjFO9qso+tCpmvhv1x3hM4Ndb4C+fSvbN6pnAQBLhRy+HOFKa4g/w9nzKMw0+8mwBYwg2Sezt0xxfJedMQVwlbPkb1zGqLAbCVIb7Kk5g2FtnPBKaVD4R8xg1QF3nxfkCQBIPGmQwGvzPOTwQTvNBxLhZVq3s5rgm1wGFLZLioNRfN3y2qdoql14sCg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmtozu5b41Hm19T191shKPy11QNLhq7tcsp1tiLlI0c=;
 b=EQb4cBPiV8sVj0U5GqU/CfYx/JDZO9iU0Dvb//0DF0mYaDai7NsaT8lECfSyjx20p5hjUAZ5QJggHzkZnZqc+aIhn9PyZ4os8xSSbVCq4wepUzTuX7bHwqSV/ElSp3KA/iD0E81j5FLdxtztxPmp1d4JHv4ifXP2zEueMPBwa3MZk7ZDJ6F4/1cdrDHicJV/Gb3gkp2lfsf/XAaP1yzy2JJS+455+n9Dy7TCAAsXuuoyHWDtaFFtInRxd97iDBoR74Pek97Bq2373Ji4zU12q1K0UtA2qi1KlIptMiHqCHjpPsE5ZWx5c4nihlFKCDGkmUKGZWPoYrafw6qsJ0L/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5782.eurprd04.prod.outlook.com (2603:10a6:20b:aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29; Wed, 9 Mar
 2022 12:34:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 12:34:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/3] mptcp: add MP_FAIL response support
Date: Wed,  9 Mar 2022 20:33:57 +0800
Message-ID: <4877b2ffe0b6128f51b7819c7ea4ba35531743fc.1646829006.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646829006.git.geliang.tang@suse.com>
References: <cover.1646829006.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9669fa21-6f03-4b2a-0add-08da01c91fba
X-MS-TrafficTypeDiagnostic: AM6PR04MB5782:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB5782186103337FED89F642F0F80A9@AM6PR04MB5782.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ueki2K0f7o8tXiHzCQEJJ4IeZuIImHmyrsXJJAA8EmFWBNJoGtIN1lCOUqWGXq2P4YgOyXZDaff6fuMrp+heeXT4srPgmssHiccS2bOONBq7Z5CP6M2gIZf/xyrJlXwS0dbFj1GNA9jevMHK/oWct9esp4+dnDeTLobqz6o+jNJavRldZiFgOIrhIbBMbvlwilOlj2n8HDhwaS49dzeQ48Xrdr6un4Q4gkahkPcS2ATOwF/gMMKVVIkmVqvlLPd/+mQ/PwM6aaJkH3NLM65NoA7cqBOrAGMot1w4ch6azuBeLQLYQuxzjcmwhn3nsSCtwSJJmN5Rzu62Gt7jtVGc6XIgJt4VN8uAjfosKcKCuVgwnjasfYiYttkN+2SHlh+CO0E40APvtJLH42roBUzVLBS9FQhv2HOsWOt2T7+cpM1BiuIVffiEKhqtHV4eXs2Js+bLiYEPm6y0zQod/UqdDQCYe9jTG3fDKJyhnIqlyBAm9+C86L0erQGvVj8y0BLiP9yrROHZ9SrOUD+ZcvcS7fmx65tEoTlpdk+/aDiO+fa9WHKlKptLgVrjTcbFGTfUWTZPZTl07B+I9gSGNbFP7T8kYnHoV/9vV6PL/RuhTvetI4istL7U3IyqiCUrdAXJHSy5JA2cPTH2yRX3qqyFvJ7g6iQOHOv4j0V0nmhiBNXNciUl6ER4WmK4JMSUgJZ6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(83380400001)(36756003)(44832011)(6512007)(6666004)(8676002)(5660300002)(6506007)(186003)(26005)(2616005)(2906002)(86362001)(107886003)(38100700002)(316002)(508600001)(6486002)(6916009)(4326008)(66556008)(66946007)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ItFip+j6DVr4ai8+O+64r9DRvsQvbF5l9jUOfys4GpQM+Kj26AAOsLvHqm2/?=
 =?us-ascii?Q?QWv+SkBUpioVXbDfLGu3eVjEZ/qmq86WZ/5GEb0RpHLHF7v1MloylwcDxJCp?=
 =?us-ascii?Q?zVDaILarlqY4UtzU8EXvxQFvoKneGYvCFl4lq8curLspGoLytsZ2x05tDCe0?=
 =?us-ascii?Q?yU6ieHlXGTWyBPX+AQQWJ8ik0YEiWA5ED6KUrqGSGd8QGIw0k7jGHz5vFy86?=
 =?us-ascii?Q?DgDehBiG+KlQflEMdDHxm6rXRo2fGE84e29qG/hS5N6qRhDzM6aHcai3XwkB?=
 =?us-ascii?Q?FSH+SUOl3vKjbJMXoS22owqmpoB1aY9jxFzcE10Jk0tgkPkLNoJpePzcdaIF?=
 =?us-ascii?Q?TP6XGZ2yWxR7wgwDP9PmBxuxq+80cFJGWbPUOGXkEeO2O1HOekKN30iRufLU?=
 =?us-ascii?Q?YANgpxLmSgRqpR/zLdW7l59TgaxHgZCcOQFfCZJNvniCLhykGcWSQNMwC52K?=
 =?us-ascii?Q?zzACZlTA6YT9cSy1AV6+g4AI2vSFsr+zx2F66zY7Zs/bZOwLbYFKe9JB7Jqx?=
 =?us-ascii?Q?jIkfYMwV9cwCBuAJLm6u8Vb/WVLPDarUwPHDFAcKaSYemTClsV38n5J13D6x?=
 =?us-ascii?Q?nWbPjoQQJzKud7UK0TBjAnNVpDNfPCk7p45wI2c0GLs7AlqpYO3id5A10e43?=
 =?us-ascii?Q?Z7pW9CuOq+uePG+5Y8BVuy28bqv8xG4BvJQ6vDhOQXrRR7IytiHxqD4LDxIr?=
 =?us-ascii?Q?cq72STXey68lNBUNp9aioBfhd9+QsisMGTB8LISEXKJKIxm9Gx2NOGM1UPQY?=
 =?us-ascii?Q?N8a+H3z6MLbSv3tCHV0K8RJnaS04S34OeSkxaV+lv4OP65eKN5cZOq1ze0Ng?=
 =?us-ascii?Q?CyX3D1gCm7CdZ9MwOmeK1Y40quLExyh7T8ez5GWjLbqtn4TsoFqIDQynzYKE?=
 =?us-ascii?Q?1x/fkpZIX+dBQoMpa8/ofqntBb6iKDw0Te42ULIcV7/o6y4S6NBTv3jRXk86?=
 =?us-ascii?Q?6Z8v5S2DjPsCSxiU7/XM4b6vYHEKT3IINGwpeDxtoFda4ivLQN335WUCGELO?=
 =?us-ascii?Q?o8mae2uaqvwlCs00wTFX3mvRSdDvU6hLsmB8ifui+wKapD/0b/nx8HtwhIeO?=
 =?us-ascii?Q?HKdqGrwLo4QeYlkJgwv05fr1XgT0bZXPdqZhzVq6tvNXCMgTaifuZCBwlEcQ?=
 =?us-ascii?Q?AAeBwIxgqPzI39JyLZpmLmYKOPIBRhepnR2UtOZFIL/0eJ0bkq5jCfdjg1Nn?=
 =?us-ascii?Q?MnkFS7c2GMS14mAnc9jVc1NVKhCF5+6NPfaIZ7ks/BmvfR1kwnaVogDHC0H5?=
 =?us-ascii?Q?Kepi5u6AqCIKpfREwDilu6alpg0WB4TV2zo7xRKkJwY/80qL2m7Rt8Uy9IyY?=
 =?us-ascii?Q?Yb2f4gfInj3xaThWAl0WM3eJ8hid1U93E507pp1ADo/TPqJkSTiTp2trLUIe?=
 =?us-ascii?Q?Ujql0lUBuvYIp7Zl4dHY4keTHD9pP1t3djBafgYR5VIHI9qm5mHZzvPWCfsq?=
 =?us-ascii?Q?uzNlJcKyqEXBXS3jAGtDStvlT/PbxT8azD8ugk1xrHJPgZ3EY4hh0Gn6Zp5B?=
 =?us-ascii?Q?a4OVINK/H9Nhi/5aSeXSgxGSzXPRasOc3xEY7cjxloUVPMQDZ29OUW9XPSwG?=
 =?us-ascii?Q?SGvW3jGluX0GvK3uaIDNj2gn3DRkOXYyVWQ0E/MuZpDGSeQ9fQF9eVj4hwLu?=
 =?us-ascii?Q?+N6MtII5RjZFfaybpg+YcyQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9669fa21-6f03-4b2a-0add-08da01c91fba
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 12:34:16.1811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHAHCETt46KqNGH/BaDp4+k7GqMw02Nn+3Rt1P/CuBPjei3NWso8UQu2WBg8RYmMZquR75qKy888pNBpWHR7fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5782

This patch added a new struct member mp_fail_response_expect in struct
mptcp_subflow_context to support MP_FAIL response. In the single subflow
with checksum error and contiguous data special case, a MP_FAIL sent in
response to another MP_FAIL.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c       | 9 +++++++--
 net/mptcp/protocol.h | 1 +
 net/mptcp/subflow.c  | 2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d0d31d5c198a..c4622b07b7f5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -279,8 +279,13 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fa=
il_seq)
=20
 	pr_debug("fail_seq=3D%llu", fail_seq);
=20
-	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallb=
ack))
-		subflow->send_infinite_map =3D 1;
+	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallb=
ack)) {
+		if (!READ_ONCE(subflow->mp_fail_response_expect)) {
+			subflow->send_mp_fail =3D 1;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
+			subflow->send_infinite_map =3D 1;
+		}
+	}
 }
=20
 /* path manager helpers */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c8bada4537e2..83f0205f0d95 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -456,6 +456,7 @@ struct mptcp_subflow_context {
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		local_id_valid : 1; /* local_id is correctly initialized */
 	enum mptcp_data_avail data_avail;
+	bool	mp_fail_response_expect;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 30ffb00661bb..ca2352ad20d4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1217,6 +1217,8 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 				tcp_send_active_reset(ssk, GFP_ATOMIC);
 				while ((skb =3D skb_peek(&ssk->sk_receive_queue)))
 					sk_eat_skb(ssk, skb);
+			} else {
+				WRITE_ONCE(subflow->mp_fail_response_expect, true);
 			}
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return true;
--=20
2.34.1

