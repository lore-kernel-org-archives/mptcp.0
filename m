Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D1557D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjwpqZ5RXh6zNR3XYw7vuW1jigB7kHmxegraNOdGYjY=;
	b=Wmy04VZW5cCz5nLMlAUfUBztMOmCtMocWkyjg3S0MtXmveKBNjfem747dbTmynThGQeDp7
	HPnCnftEGxIEoTxoNb1f7W67eEAg/+qbCac2ilJjeHOzB/iMYZlkFviNjF4jbZD7T3I31B
	JSU64bItNZBLbSar7V3rU1wAlNxQgJs=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2057.outbound.protection.outlook.com [104.47.10.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-ogLlos_ZP0uvYjDMGDtRNA-1; Sun, 20 Feb 2022 00:17:56 +0100
X-MC-Unique: ogLlos_ZP0uvYjDMGDtRNA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjzfUfH+JDGssXRmuXPnq75H7aUP/H+HBY3aFvvj4vqTqRQ9zU6EfCRSB5hKKyu+UHCBvrjjX6fPE5byR9xa0/FXgbfq/73+sJPuD+Ntv7kM7FPCawIZM4Vrpe3y2wMnLxd0xDQMpzJiePWkjp+QF9K67h6auDM69I3CtCFi68s5x59JwsOUiBlp49Lrs4UhN899YB1T3sl77S9Q2TL2buxKwDfn84IYJDpiVlJtGpRQYftYPh1bxgbLiVf3b94znS3ONskt7M/PX6kMZMw4YlJ6Cb+bJkBiJzjeo35NkqdNO818ZICvlcSZ3F25DFwmIhq+ppD+gGKOT1qcmKnsnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgQmiqoI+yInR/+SgCsdJBDqKc4fg19Tebq+FnF/288=;
 b=Vb2rAiIwDP16zGCJUS+2Z+NF/qqF0y8FU9+QVBy6mITF9vt3fSA+V+f7oc/Lo9f8TMqVNNiftRYtqNCL+GvgHS/gFOcA7DYrn9yRThqSLcINZsowJtCwPOfIIVEVzJdmyAvwOn3RFzLvJ1BuaBDyDkrehTHD0yAF/077Wvz5EG/decJ+lJlvIzvgpbNCxGXnTi8h0IeczgfYJBUwcu9OawO9jHupPMVHHFEqABGtzf+KQXDtQCoBHYvkp9UMEWsI9wwQ1WrxHP/7az8BOJXdiO7kw7uvuQQIFmPE5DEUpOsDSY3mdox3fMUtsbC6Ler8h7AGxKqPgcVhPH7abHM22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8812.eurprd04.prod.outlook.com (2603:10a6:20b:40b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Sat, 19 Feb
 2022 23:17:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:17:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next 04/19] Revert "mptcp: add mib for infinite map sending"
Date: Sun, 20 Feb 2022 07:17:48 +0800
Message-ID: <680412277944199d838f1f49ac56abeaa14440c5.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645311956.git.geliang.tang@suse.com>
References: <cover.1645311956.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:202:2e::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65979707-5d14-4ab8-d1da-08d9f3fe0eee
X-MS-TrafficTypeDiagnostic: AM9PR04MB8812:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8812D9EB778F63C224076F2EF8389@AM9PR04MB8812.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qn2WbIcN5Gw6+ccb+ibuRitq7MjA+9C9UHLQUFKlA5a8PBV52iijAy/jbNOxRHYuex4qY59iyHzVnYmeb1Lua7pYgRsoesIuXFx4NwDPCb+qHKirzQ22KaWwZU7WQ3Qljm8qMFYlBkUsFzXlm5YGu4O2O+PotSHjXNF8mX772GU46mmgGgQ8mTFYEFhbMSsdv9ikWWD8ph7fpINbzx7KWWFpgoE/69C8A/y/jDFyiE3/HdUGZynjQ8HxSz3gOIr3G2ie53wArzWUxRZ2VioRTsgrvFWx5qjqLAZtxwoUAe2UsE5ikRjdCP/9m8D46XRnaKAtfJ7Kdi2/7QQbVcw9T/IFAdCQ4SQGZfX1aOOOGCAGJw6er+E3and6OcRzb4ulfDj6ZRlGRQIe1YFyT4MXhog873eWqFXRHDcN3dsoTBt43hMKQfoEcGAxYxE+nojUA3SOy2rMJtqSiEz7ZIOdh/CP3tw9JCB9CR0wgGIEGIHugHQCQjimiF549XvvpprnofOsl3dw7IaeSFVLZorKWYAsjsYHgKgVBiQtEocJDPaxC+cvzV13erKYCh/xD0O7unRbZ8BUeyRAwByO+7QGX7sdmImCTtYjxjvM3GzribXsT5Kj5s8BUpm/We03XugrXxnt4i2ORPcD73Dfn/HbiQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(66476007)(6486002)(66946007)(66556008)(4326008)(86362001)(8676002)(5660300002)(186003)(8936002)(508600001)(6666004)(107886003)(2616005)(38100700002)(6916009)(36756003)(6506007)(2906002)(316002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K9UACgYClqqZee9bxF16qSx88DCg4UQdpyCh+Hr1rbyJjz4OTSV3kawFlGrE?=
 =?us-ascii?Q?bLLqU4zGZLIUAq51Ktozk+7DXv/RJCU0nlYBgbUg0AUbwUf8rUUo55ki/hdH?=
 =?us-ascii?Q?VmUJ36qJVy/nAZXeBgno9f8VeRbVpeJ27nVqDAWGbbeB4lO77psW8Qn7SxT8?=
 =?us-ascii?Q?SlxGgP2nz98PxGQrm0Kg63lD6XNW7GWXbDG2ybqCM8pgpKUqwllcCuv2cmtl?=
 =?us-ascii?Q?8SbUDjLslbnF80vZ9INfIJKk/lM1mSPa4gMxPENPQdcH6Ct8AYTM5cT99YcE?=
 =?us-ascii?Q?j9WUlW437r85L66hoTO6hFQO/JkEwytN4hksgNC2y34f9QELhNzaRuT5asKd?=
 =?us-ascii?Q?LM/sCIDKL6BZjzQki0NIB1Ri56mHKA9429tC3/2QeklVORF5tjzIHJxq+ww8?=
 =?us-ascii?Q?umbiw7U72CiUq4ovKLlfN0Trl91hGWSXumzWAV7jj7/oRpIhTEIt2ED7P1r4?=
 =?us-ascii?Q?ZMmfRMi/PBv/IOHwMBwUjFPw7W3hdBYuOfmFHdQB3PDP67dxb0r/2FAAPzJo?=
 =?us-ascii?Q?f4jYGgjpRjzA3fyr3AteWoXpzNJhyHAkoIupKLmtT6m6gpBI2h9eworATAUF?=
 =?us-ascii?Q?DEfK7ghygxvNmbAIQenAfwHDC0AHX9aljMGPbOlSFevH8eNTPvaq2lpgExx4?=
 =?us-ascii?Q?bDp9qhHQMUZbG2r1Y50vVBJvRdinOZ5kKjI9HOzsd+TQLZcAm+lDMLOQDGB2?=
 =?us-ascii?Q?Ds+wUQXcmEkdhOYVHeKVI4j2bEwTTIeomaX/XLrSKdeMHbzhLXA52osOEiUu?=
 =?us-ascii?Q?JVCOWgLLMXgl54lxA7IPkm0XeQkvWzzIYaML73wgVcy3EHF6KZ653eccHnef?=
 =?us-ascii?Q?gUys16hFl8NzQBXtyl3hZKvLJNYXn8Xh8evb0rUCyCreS2rQdTYaa5jSDRPG?=
 =?us-ascii?Q?D8rjvIvcRsIAgNdOsLhMHEivDTMn806T/JfWqZWmtHxG8yHG8cxexr4N80z+?=
 =?us-ascii?Q?sXHL7Abnh3Yz5izKtEsP7Spcmwgy4KiFI6DsJrHiSdXCafGHqKYmTi2VIeJQ?=
 =?us-ascii?Q?CC6qT4KJM3E8T404taMLwo7juh+8x3FAtVPfTaSW9+Fyw576NHIqNMgIQhN+?=
 =?us-ascii?Q?yIwLt+L4vIML7+WtdWzdDolmS5cfrNWuvyQ+4aVb639MiAawskzVK3vKme9h?=
 =?us-ascii?Q?bwVk2kawzJP8lMKyzOA23/EXpTZt389Ca6bKzlk2+PyitdX0PSYtmdNd9d+7?=
 =?us-ascii?Q?Y70CoOvgi6SR3hkzwV6N8w65SXHW0vsaubLB6sSXnUSC/ojxwdvEnwx481Gf?=
 =?us-ascii?Q?gsqQNEbeGcveS995qNbg01s7aG/CQPw9XLzijVJq7GBrYBsIih33fC+FOigz?=
 =?us-ascii?Q?LQNhAMwnDpzCEuk2rvNnDoEya1O6YSFTnkI71R9k6KCHOTlJES/PyT21A2t6?=
 =?us-ascii?Q?g3VmwT+K8YVp+weGgNcSr1OImJSji4ZOhjH4pni940EPfh0Hfhp9YAvB0pRg?=
 =?us-ascii?Q?DbSEZ/1VyIUoMUYJO1BCxYMvEiD5pyfMk2EjlyrF1V6kQwJyUMOSU2Vcl8yO?=
 =?us-ascii?Q?Qbo7vHK4RNiNoYgAahffFoKjuv+cbZpdvWt+tGEakNSTjzPEZJ1H826W1O0I?=
 =?us-ascii?Q?lF+tmAWkpq8lJwuwoBtV94Amekt6phRBbO4ntsD8dMXl2rHgT4s3ip/7hj8U?=
 =?us-ascii?Q?HaEODWZi3b9QtAd+yYXYbxsBoEmbhCQisW5AfB0bYobiR6YfrmkiyOWFUyIV?=
 =?us-ascii?Q?7KTVGpnqhnai8heqXJfoiqX0ik4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65979707-5d14-4ab8-d1da-08d9f3fe0eee
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:17:55.0691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IL76kGYlUdJZsc/vp60vbMSb3RosERkOJi8mlRLVL9pFnt6E+azBrTQkLlAiE08BW0skNXkBMp7SueP9uYJrDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8812

This reverts commit 64b8d85c6c3dfb6e87a2670f372046c5d2d4cf6b.
---
 net/mptcp/mib.c      | 1 -
 net/mptcp/mib.h      | 1 -
 net/mptcp/protocol.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 7cef7409e300..7558802a1435 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -24,7 +24,6 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
-	SNMP_MIB_ITEM("InfiniteMapTx", MPTCP_MIB_INFINITEMAPTX),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
 	SNMP_MIB_ITEM("DSSNoMatchTCP", MPTCP_MIB_DSSTCPMISMATCH),
 	SNMP_MIB_ITEM("DataCsumErr", MPTCP_MIB_DATACSUMERR),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 785cf751e5c0..2966fcb6548b 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -17,7 +17,6 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the p=
revious one */
-	MPTCP_MIB_INFINITEMAPTX,	/* Sent an infinite mapping */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
 	MPTCP_MIB_DSSTCPMISMATCH,	/* DSS-mapping did not map with TCP's sequence =
numbers */
 	MPTCP_MIB_DATACSUMERR,		/* The data checksum fail */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3cb975227d12..fecf4c36b55b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1238,7 +1238,6 @@ static void mptcp_update_infinite_map(struct mptcp_so=
ck *msk,
 	mpext->infinite_map =3D 1;
 	mpext->data_len =3D 0;
=20
-	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map =3D 0;
 	pr_fallback(msk);
 	__mptcp_do_fallback(msk);
--=20
2.34.1

