Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63546621
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 06:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646287493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5+JeP+vCKtDwAvMImZ5Dmvqd1+5g9mou7cbfW47XvoA=;
	b=ThhAnCfCuHSf5yhdZoSTQhmngoTC/nI3n65Fcm4ke//LrFbqQS4xTRGEUXmU/LKm7zArJA
	VizBDU072a5st0IkkkXIsND5VvkteWw0ZfFaP74Hqdk5ZZE1++xFmwRnJ0zW4QiRCfRXZ1
	s0slj2ilJdkp356hpWRC5V81IoGTq9g=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-4YH-qmkFPRiOQdsVDywsMA-1; Thu, 03 Mar 2022 07:04:52 +0100
X-MC-Unique: 4YH-qmkFPRiOQdsVDywsMA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrGyLLT6mwSZFZDxbAKNTXrSMIsMjLvI9WpiCQEHQPt5Xc/1Jh4OEcYS5nTX9yPeHxrNOhG5Nd6EOfVSpry2P1hRYpuRJcinSi+jkNHsL3LZPIp0bDt4Ish9/fyyZ0GbQO+hyereGbQ+JIXQKcvzJU44cJ9dH6XV5AZd+XcqNyL0lZplGHbUzugXMn9bCo8CXhCjbPvmZUFz7Zh7Ug348LI3nSUytoeIRkfBuzcbc7g2jF2Yd3imHegOCBfxbMtDGcnBD0yuey4TV+s/rLBhk0LDpujImjBFVvtHSqyE+Zw4he1H7bvlPHYkXYuzoyerIAVsUzA5pBE5oUKt4vIPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sl0EBIIqwvv8SrbPKr251zB7ugPn1zsjZqYTr90TSZo=;
 b=bGue4sWSdKexhj9grCgrX52K0C9ilya5n85JsV+cpmE0uE2fsTW0GLq1dnCVIfNF2u67rYotK5mTOBNHbZrwelistC4ppCZrg4yKuD80PAhmGNw4lyujLI06sHJ5dUWBt/TQg25zJp/vsz1+Bsk3y/nCiv/1frWqdYoyG13Vso80d/NFdmvlAPnOawyax7lgEI5VJFu2JNABPIPdZUc6ZJUjhD6zvjtoS9LW6xJ1BSRZhFV+f034aXlpS6C2mYOv60/vsdfJPJYtfY1WeMDlCtrAdfVFA5BGjsw7nHmqOes+99TYNgj85m6M9poUQZ1CNRz2zxFzui7ltAtpPBULJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5041.eurprd04.prod.outlook.com (2603:10a6:208:bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 06:04:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 06:04:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/2] mptcp: add MP_FAIL response support
Date: Thu,  3 Mar 2022 14:04:28 +0800
Message-ID: <87d47204cb7b125d2089abb7dfcdada8b2ce1795.1646287286.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646287286.git.geliang.tang@suse.com>
References: <cover.1646287286.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0200.apcprd06.prod.outlook.com (2603:1096:4:1::32)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1819c3af-4ff3-4d57-f7f9-08d9fcdbbad9
X-MS-TrafficTypeDiagnostic: AM0PR04MB5041:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB504170542C722D4B47E84015F8049@AM0PR04MB5041.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c6ounOd+fn8T0YfVCkmktgb3v8C06mdkry2Z8oghlptNPwhABD0u2jCubTe3a6h21MxdE3Mig8VTnuJ3D1PbIQWdDHW13362oIJAcxossRkoi5toS8DEKFoqJWIe/ofAAAMbMaKe9EOPwWsBVjC/P3ZtSIBJDkHMod1Dq9HYFnA4YJFwcGUQ8u2s/kWMrfnZ3fMdv5ZCtWNj2GXpQbj1hNNDjXFuUE3fA49pUCTSSLOjyO+qrtMkBTiuoZqz+q5WWxGk2Www3X8OBxlqU2x88m+lOnF1DYiMOrLFuNisBKIG5K1hug8/AoRlId28Ov7dl8tygQytMp+pFKnsm0pene+H+CHpCzn+uAuPIXXeVMnGdK9sXW5FT3t4bwSHw5bRhsuwN2OfIZ6qjzgTSyUHMpa0AYyifMD24ekdvfJ25QlffcNbK616O/+QiF4vbybb/q1AJ49SgDiRhcFfBBZaFBc9HgRz6boe0FwBf9wnP4FkSNT2V/aUdAEheNvQ29OWHMDzTDT6wFW1+QYvqtG4/2zDUBWeocdORLl4xPuWmHYLR95VE7HgH94BsCw8x1QdmU1QP3/7K+rIISWC4HVGe0/9XF0PbKMs8UKpyAas+r7BW21PW1EEUnhzNt4yWBlbWeWZpx2kUYR+sT66c8zTsQXd2bDtxcVck91ogYZd905HhMTdFuZyAait8/edKbP2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(5660300002)(44832011)(36756003)(186003)(38100700002)(8676002)(4326008)(2906002)(66946007)(66476007)(66556008)(26005)(6666004)(6506007)(83380400001)(6486002)(316002)(86362001)(6916009)(107886003)(6512007)(2616005)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kGxPuG/fs9hkfK8I4yOuB7oWrNEmM4DM410Hvxt6G933titkoFVatQ1j5Ycj?=
 =?us-ascii?Q?N2FCFoiLm6yZLHWMlNdxu0eedoVAynC/KQxnxMFZIbBrUnxyFuO6/oUpkyCs?=
 =?us-ascii?Q?v8ISi2kTMaGQB+SSOTh5TGFODdhGVOP1mCvNsZy3RllTvzvFCk3gU4gOJUTN?=
 =?us-ascii?Q?CKRUSJjf8f0lTXa2TeatDJl3xLwTBat0+eVfiRpMut3G1H/c3c9ian/C3cMV?=
 =?us-ascii?Q?VdtDSsw1xWcR7np4y+djEtgRBl41e2/KbaDayO9s58OY46Eigiv71pU72Hbv?=
 =?us-ascii?Q?WCb0k/J/r8y7axjpozH1hGOeTomTtbJZKVDLCstrMggZWgvZscXAm2sdkaut?=
 =?us-ascii?Q?iOCSaWQc7gj+TOhaDl0abd419HC48ODyhHHjrJkvB2Ex3yPwuPr7yMi0lO9b?=
 =?us-ascii?Q?G9qUq5qQ78k7n7USPzWDDhhDCbVWz/yjHHrZ/bkLsSnMYet+R9+NDrH8ntCD?=
 =?us-ascii?Q?rzQpAbq1eRhe3dmO2gGulOJUCJKF6KLLoEv6A05Eitd6X3AgmV0Iae5q/lUU?=
 =?us-ascii?Q?azGNqmi0lzC3zihrvqfa25AirVTo+ouZOMC4/NQfF550GHwYCMB+R8bOMVlZ?=
 =?us-ascii?Q?U4VeVQFkfnRL4eAul65cx0rgQ3xy3tyDQKd4FVoN+O4UDLN3DR12eJ/+fVrC?=
 =?us-ascii?Q?2nBE4YMPhU/Ah7aXIJ2OitXWUHbq27loYOUAX6wJUBlI9VfiM4RKijgb0jH9?=
 =?us-ascii?Q?YMylthhask3B9pGe12XYJ5TrwdRuwbt1qwcXUBij1Veqt0C8ITT1YLLGQGNE?=
 =?us-ascii?Q?u6nJjVwzRf/WkiqAEmSWWtGN6D0fFlvSTc/K4JmBqYgdssXMJTvD/Ia/6AnS?=
 =?us-ascii?Q?Nnu/pwAz13pnFK3jg+G9KD4GkmoJq3tVwAXEhQo9g1OwUoQwCQ6YnV9MF5/o?=
 =?us-ascii?Q?WLefGyC+UcfuA14tN1PNE9mmMaIr13YCf00G2cewG+mMLapDjyNJj7pBTqgM?=
 =?us-ascii?Q?ITearJv85OI7DDQ+iLU2/3drD1MgVB1LpzJqSYTM/eQCzu06GZKVqIeFAYTe?=
 =?us-ascii?Q?QP2/AuwDmPEMzRx2SulCcBBIFT5kB0EEhhWfTP9k0oLGHs1i1EdgttaGs1LC?=
 =?us-ascii?Q?IliC+HDlfdH5Akbf8Bpu5/J7a0Roeeqm0DgTSFokEV2TUpvOyzQFSjNgp7ni?=
 =?us-ascii?Q?b2x6LzFM2zL538UEmEDjAmQO1E2DwczUC7HMCe1CxigHq3jjGG8jf4POl6k+?=
 =?us-ascii?Q?b7R9sLQojC2N+OpDVzjr6g8MqC1frwA17oxrDvB6beKxl65yLY/vsHj/8Yqj?=
 =?us-ascii?Q?Nwhss1CNriN4Q15EC5/L4ojntN29LtgDdGYG0/7Z8Ulv3GleG07I4jBCfmJr?=
 =?us-ascii?Q?zYGR4XrWw1rF5Gr3J3ih0Nt7VLVDIkietrtjL0kXxebIe0sZEWUaDs/JK9+J?=
 =?us-ascii?Q?rOzhh60JvLHISHmIHzrBp7JvSnkAOMkFNO6SgqMsMEibByZFITch0q7GKh8H?=
 =?us-ascii?Q?lMkDJyzyoAMkLaLRrCaKciPvRzLYsVnN4nc7Vbye9YCECbUKoBOeRCrOir6a?=
 =?us-ascii?Q?DUGudhMRZzTdwLbEbzexp05ADEiEbl9jx+rKm+l2C6tBAa0py5lVPj2vQrxu?=
 =?us-ascii?Q?RJ1NgcfTuTil6ukLEbtARN4ZK5fhJWTMKVLINeEPq08s8fyOigDdTPP+psS1?=
 =?us-ascii?Q?2PMVRFz0F5NkId/P5d3O69M=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1819c3af-4ff3-4d57-f7f9-08d9fcdbbad9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 06:04:51.5019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSUMkijPaUmynRzHwLpEX/P2f5SIZ2HxbF/o2bi5PemFmKQ3+CAUewTAwvSbu88xy0xdqNvVlOIjBpyB2xNZDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5041

This patch added a new struct member mp_fail_response_expect in struct
mptcp_subflow_context to support MP_FAIL response. In the single subflow
with checksum error and contiguous data special case, a MP_FAIL sent in
response to another MP_FAIL.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c       | 11 +++++++++--
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  2 ++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d0d31d5c198a..c9080230b800 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -279,8 +279,15 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fa=
il_seq)
=20
 	pr_debug("fail_seq=3D%llu", fail_seq);
=20
-	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallb=
ack))
-		subflow->send_infinite_map =3D 1;
+	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallb=
ack)) {
+		if (!subflow->mp_fail_response_expect) {
+			subflow->send_mp_fail =3D 1;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
+			subflow->send_infinite_map =3D 1;
+		} else {
+			subflow->mp_fail_response_expect =3D 0;
+		}
+	}
 }
=20
 /* path manager helpers */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c8bada4537e2..39aa22595add 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -448,6 +448,7 @@ struct mptcp_subflow_context {
 		backup : 1,
 		send_mp_prio : 1,
 		send_mp_fail : 1,
+		mp_fail_response_expect : 1,
 		send_fastclose : 1,
 		send_infinite_map : 1,
 		rx_eof : 1,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 30ffb00661bb..63a256a94b65 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1217,6 +1217,8 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 				tcp_send_active_reset(ssk, GFP_ATOMIC);
 				while ((skb =3D skb_peek(&ssk->sk_receive_queue)))
 					sk_eat_skb(ssk, skb);
+			} else {
+				subflow->mp_fail_response_expect =3D 1;
 			}
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return true;
--=20
2.34.1

