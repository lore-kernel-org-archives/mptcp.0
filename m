Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8718923BD
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 09:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654508862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZf7IBWY8ZgqjoM884e7d2fwbgUfXwPyqPbeKY0nsu4=;
	b=dzdEq1g4VM2r1gAKIoDVdIPjJOb/bwUCbbHPksRPEAWSUixlD/qtfwC6UT0jH32Kd0xZXN
	FK4d2W0OT/MAzNGmhh7BmzJtsIrdFScvhcHMLibKiRY3Kwev2vuHRZeggLPBhdw3mJrWed
	Kxi8a/C8Z4dHknyUpRPLkVt+ENNHrLc=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2058.outbound.protection.outlook.com [104.47.0.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-a8f5klh4NnKw5RM321jeHA-1; Mon, 06 Jun 2022 11:47:41 +0200
X-MC-Unique: a8f5klh4NnKw5RM321jeHA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTU9e4rX0W3LO2SFjgyMCKZUI9PLrUkBw3y6yPa14198QXljv8Yg9lgTA/H/7TcYUc+gOHvmMNAgxzyIzb+XHpB1CnpwPyd/Gol9JCZH4XQYAHqbC8FxslFkCX2YxuJaeFNNa3k6K+UR4OvMGu2xUHOGI8wX0Y3BtUlKet0uTKTmuB+wsbGT21bSTUv13/GPu8cOq1AQozq9VysLHwSQtKTduTfLQkh0tPZPZJ9vaicxz7o2wok5kTjSwQ/Wh9sR50YFEiILV7K96tT3UNgPdL7k7Gh0lEWm6/KnG4Ivz2DHsvD7sDX7ePCgYlAPUJNv3OcFXsz1KU+vN23e2KSCSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMApmYzdyz2EWIHY4EidKwjDfbvUtaDuDbGcTannMyI=;
 b=ZD12bHT7QNSDZzasFl6vb5opbW6nCVFLvosq7oeSKisZq9Y6rJb3Rue7NtyDcogRLPYyAuxSJreT1HvA1yQFmM6VM69rpMY9A6u7npbHNuiwgm/szTMPdjCczsnNzecW20yNUuceSWrBwLOu1wobU9PBGmNNcxi6fXZ5dMx0dhC68rCvDXzGYCYak4Cn+M5K8yn6dZEVKtFEIJ7DPzawrHbjJjS4WnkVK+SnNyGyP+lsHA1SDNOF9VaByXqXNjBKLdktMpz2cPcvJYUpuiXQtmDLXLQHQyhWNNOJrWR90lIApskHhv30vWBKR+UJQCyNQaIUoTx0astD1OZiSK3a6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4802.eurprd04.prod.outlook.com (2603:10a6:208:c2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 09:47:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 09:47:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 3/5] mptcp: add mptcp_sched_get_send wrapper
Date: Mon,  6 Jun 2022 17:47:13 +0800
Message-ID: <0d87803df540cb9e103b3696a366b5355c0104f7.1654508532.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654508532.git.geliang.tang@suse.com>
References: <cover.1654508532.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f52f7e58-5c97-4362-653a-08da47a1989e
X-MS-TrafficTypeDiagnostic: AM0PR04MB4802:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB48021626BEA7B5FF7AA7857EF8A29@AM0PR04MB4802.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gRPDUYmCPpM1LGPFPbVNsC9NubqHSpK5mdFuHzidugAxdUu1AuTzITjo0HvKSPbu3Jt7ZIef2vl3XgJj7Sog7NiSMnDpGjB4d54NtNnd4JgaUiGqdiUDNWmDdnTBIrwlUPV4DvNp9VrWxL0fC/cqyORHdkhPJON7HMvY9ELExo7Gau1LbEI3fcPuf04SXF+DEfM6QLpAWw4uZk2vOcgmIGEg+5knUJVaMjvPVzWN7XseaCYpzPjuOmosl6GOX/Vbnkbh4unG0QE9AHE61chp8iGw1f65DdELlnm9Bukhg6KYIRfQxhDGItqeS8TwUFZ/VCqogGG40l3DoGN/uOeLaG7sVrNlaTELwvCbcwEaBaexnf/Dgs7PJMxQ44clWRzCvMmRoxZQi0RH1Xv7Vf+LGXNMHELQl2nGn9br8MdxSpKhDgQSWAWWg5i6jKM/tm+Lv8s53PTGgG7feOgEnVzKZWlf2vNGwarnniQeA4uhqSkLLqDayzPzDefMgO4MZOWCtqe4e8z9Bn9eCsZgpUOL73kTlMgRjU5+Mw7bHUWkFB5cY+Wm44sZUv/K6+AiPdaj9bkUpF+goiwj8I6beyqf/w8EyHCsk/IOYDuseLU034XHVtiDw6ABccvCxiClRhXMTug/c33FsnQsFdLPLlsHhKo86pwFtgiRGC1ikJcEpS3z/x/hR/q14Mgc/+Bi1USi0//+4cU+kLe+EM8XTofItg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(36756003)(6916009)(38100700002)(66556008)(66476007)(107886003)(316002)(5660300002)(26005)(6512007)(2906002)(4326008)(44832011)(8676002)(6506007)(83380400001)(2616005)(6666004)(508600001)(6486002)(186003)(86362001)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B66QzYAFT3VI4B4ZEs/asRj+24xTfG2SHGXs3ZW4ZF9Y58RyIOH1gsO82x8Z?=
 =?us-ascii?Q?3Vhcs847iPCt1LdpPE4D+ZGRRtiendU8ELUn6v77YXhGoO3U4YbFeVzsEJXy?=
 =?us-ascii?Q?mc8/u8/TqWOvFS6//gt2Q+vRugSBak/16taLvRJvxiAf43iOpc4x5ciHVOkt?=
 =?us-ascii?Q?zN0gLxxV8yeInKNfxFEdCQGMw/OjM3c1340KTWJGZMg9CKekn8IhhlimBSu3?=
 =?us-ascii?Q?6l6HHjmFeKSjO2s8HVAu+4IMFEou+uYRWq9EpqzqOrc5zZYYTNmpgMwXMZ3Q?=
 =?us-ascii?Q?71F/tyDaf4M2RW3ZixKdYaAbhHs6QuQMp6HnNvaLiG7JmsKVb/CU1sUPdiK9?=
 =?us-ascii?Q?EaQJZlyP2oodw/OwkT8XdBYMSZS/e2uYbRY6ha+aN+4sa7RVPbKtOgjfAoab?=
 =?us-ascii?Q?O59cm9e6QNckbV8V5oBeNa84yyAK6JP7CNjpV/uQ5CTZLjnhpGHsJ4LRJ0QS?=
 =?us-ascii?Q?hb1T1y/XIQe7NHiZlmS78clM5E4Q5HoB84SBqa5ElifOmttHZDwrO1GipUeC?=
 =?us-ascii?Q?muwJWpMCvcu1yAUSV5ER+UHLYq9L4r2jTCgrluL6Z1RTucbAJdc010jFCU4l?=
 =?us-ascii?Q?PiW6bnU5wTqZMwObFumzVzHNXb1Sl7XKdjWrC+wbbQ4zu3FRsFWtndhOg61/?=
 =?us-ascii?Q?4zkys/yE14D1iMdFqZx07t8Z6ap//EsyTqNnSTfzxJPQfD6EU2SrSqBoCkm2?=
 =?us-ascii?Q?W2hKum0Fq8hY/lBD38tivVL7HrXVjI3N12JOeuN5a9LH7PrN9QG7zJAZAWkr?=
 =?us-ascii?Q?nVHTzIA3rYEmMZWVapg/uDVNFiPGuOs/PNAWv3GUHK8enPeoXxgyq6EUsYVz?=
 =?us-ascii?Q?7ix59V2IhTVcBRX9Yklx+QVEcx1jc25innkSngEbiyUNHWEXuQ5BFWawlULY?=
 =?us-ascii?Q?R7TyPt+d6OQdqkPqxUQmquqc0whmrpYzedUG2RhYW1rvo/BD52WZ8YjbFiy/?=
 =?us-ascii?Q?RpBWuAOkn9wH1UGLWDNYxSIEn9otSB/NyzuZHyz3lWMYQAnU7OfdM3IUT0ae?=
 =?us-ascii?Q?s6BXNiDksc7TfyQ+GoXqLV+15cavYFhCNz61T7LYOsU8X+1NRfGE0IQU2iXP?=
 =?us-ascii?Q?MbgQ+03KlcRfLgKmYIRL6c1OSSQVVqz6mU0iEnVY+U6UXcrAS8KsFL+v/Ghk?=
 =?us-ascii?Q?I7CLgQzRMgzFLIbaNXlUyELSGrmNJy2OIL4KDUTmUs3v5KdcVW/hTsBhhmb7?=
 =?us-ascii?Q?mbEq06aupCtAEcF+xUVLelbH4i55e16K2V7ZqNECkjp1pkCNyYDXYMJ1opTF?=
 =?us-ascii?Q?NfxRb3BTjGlc1IRoDvgki0AkDnJZuPLiVvVBVuKPXsSmqQ8ZtW9vngWVdSBk?=
 =?us-ascii?Q?OxnGA3m8DhH9R6q5Iek3GS/RDPGpuvRXSrDZBffcGYREtYc5OD9ETJNTz+OO?=
 =?us-ascii?Q?uN7EkOuVER1evhVs5koSADMKGzqAPC5ONGD3rGobzRl/4h+THSdKhz6w/xiB?=
 =?us-ascii?Q?gRXpAqs5lAfkYebxcjy7J7OZSIwKk3JnIHFiItmzFfKeQoAqJwN14C9m8ApI?=
 =?us-ascii?Q?WiEvEyUgupVlsCPKXS8EQ/6eOl6zZDX8bmPwS9JGexSNZ+CPW5tpUgYzIPjh?=
 =?us-ascii?Q?ew9H6DntT7bhDXyMwBr8VC0EErQt8InSqZwFCCtT2ash1TTn9fafIg1beEC+?=
 =?us-ascii?Q?ggr482w2vUAXLCqsVGgDXRKpvFbuxi6+OCJBCA4+cy6vVGLjxrOaZ3XRyEQR?=
 =?us-ascii?Q?4tcZKzKOcXg+nnTI3hT6XOpks4l+XJ0WNeU0HNWAaePf+IYeAI3esIYirCRf?=
 =?us-ascii?Q?oCAYlCXS309JV1bVKY/GzfCFkz8N2Zo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52f7e58-5c97-4362-653a-08da47a1989e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 09:47:40.4982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j81r0AffnJe9asYmIbVOUPcjJ4sWrsJOaWC5VFP1bjejN66DN5ranUrb2oGmVFHvLT62zkrRoiMou/Wy2Y0ycQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4802

This patch defines the wrapper mptcp_sched_get_send(), invoke
__mptcp_sched_get_send() in it. Use this wrapper instead of using
mptcp_subflow_get_retrans() directly in __mptcp_subflow_push_pending().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  1 +
 net/mptcp/sched.c    | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 999e83eae821..16612bed5890 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1635,7 +1635,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -3125,7 +3125,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
*ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_sched_get_send(mptcp_sk(sk));
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4669d34f4d7c..6d9e8ec5c96f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -634,6 +634,7 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_c=
ontext *subflow,
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int __mptcp_sched_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
 int __mptcp_sched_get_retrans(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 70ab43c59989..70c6b7b86f23 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -147,6 +147,32 @@ int __mptcp_sched_get_send(struct mptcp_sock *msk)
 	return 0;
 }
=20
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk =3D NULL;
+	int err;
+
+	err =3D __mptcp_sched_get_send(msk);
+	if (err)
+		return NULL;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			/*
+			 * TODO: Redundant subflows are not supported in
+			 * __mptcp_subflow_push_pending() yet. Here's a
+			 * placeholder to pick the first subflow for the
+			 * redundant subflows case.
+			 */
+			ssk =3D subflow->tcp_sock;
+			break;
+		}
+	}
+
+	return ssk;
+}
+
 int __mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
--=20
2.34.1

