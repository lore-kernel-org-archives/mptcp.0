Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D732B2579
	for <mptcp@lists.linux.dev>; Thu, 29 Sep 2022 15:03:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNjFcPPxOmKRNiEz4HWZXQqLaT+dj1m/oAQGSHxSOjH5muvaH0i5Uv9xRm4EsZDVEWMGl5RMgnzLYtQ2Iy72MIvcqE7ZcULtYQpuFTeyc6kbPbySew/P1lLRbBiG3YfpN89AJ8A/Z0oES/C5MrUY0mRyCuUzYNZ/Q7eFK4EQ+ddQ9iRKDN19x+vCxk10/MIY2+EsqaLyf3S6sKWyFVDDNOc+4H6g3vZsrvhBjilSBP0TXOCeWyi9YH1QR8Q7d9nZn3pz3bNpkEKNWM3tq9nSD7vl3v4RryThcc1qNhL9rm8iFy4k5erFckbD5fc1ZZSg5DzkBtX4huVhi6HE5Xi+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYDzJWlQOWdXEzbgxl4KxDGu932zQyqUKELPdaWNjj0=;
 b=CxozUBs/3eB5F2xWmUAc/OJv5VPzyxR+FAlx+kD/yV6S19KSA296kERQdH1MI2hCPBGfi8Ddo66t5i/vypy38YmTM+WWnJt/CDhatwhFT1HRAMMACNQN6EHGNGD0ruRhDVhm08ri5PwNCiuzqLkIiM1h8GHjPYPOdUzgNuLaXtHgi476YFd5tCTYXLJSNnZKCTdMdAjYpCoqZvV5uoMBYYlgWtM9EoPaUQKofzqjSLLdZ+7yGdHPWBfziF5rvvp/O0kZUY4OTKBFbO5YcOj3CCMso74bC65G4g4yTrTcIdpaaG+2jm8vWgSlU6ASe4qIS4FlEoBx6XJMgZ+2PgrWbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYDzJWlQOWdXEzbgxl4KxDGu932zQyqUKELPdaWNjj0=;
 b=UvUZHa0gAUh19SV5WQk2ELPg3GkDiIQ0dMnYz7gZDwb/3p8JYybzsGCTNFh3N95InsY2kw2VPi8nXf89SwHMO7t3y3oRqf7ilwed0TIVPe+8yrOF6x3diuEhtp6hRGsk6yw46DyGK5Z/ZaTRjU8J2USeaVRpwn9QjLnU5U/ju3kRAxPVnSTB7uoy090/mpr0kt3V9IINo6Gf930RT6r6mJVdeE4bB9nnbq7K3fog/QQiLBgNbXKnxivV/vBoJs6gu7ZB9mqUQRHRTKN9gljMro1n6gzEZhvGS/Ar1ZLLPQBaiBoYXxo5d10maFUS/IGyAScKu3mNwijilTB1dbDbzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7822.eurprd04.prod.outlook.com (2603:10a6:102:b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 15:03:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 15:03:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/4] mptcp: update __mptcp_subflow_push_pending
Date: Thu, 29 Sep 2022 23:03:17 +0800
Message-Id: <593b52e17c75a2d605995f4b2cb7424d6f4db995.1664463491.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664463491.git.geliang.tang@suse.com>
References: <cover.1664463491.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::23)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 661cb854-e86e-45dc-4bf1-08daa22bb707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6wDG38jeo8k+GmIXcnbv+4H9NfgEA0yzcsD3RMrX5cYDTYKjXUgcPpdf/Eo6ia7YEkp9QoD4H74XDPgo+JiMRgcVz5VdCGD/sF84zZkMfWW43vbnP+f8PncFQaWwGnn5LZBgf4dn5JbhRkru7nFpbmPkCrFW7H79yJyR1mwJKF9cNvj7A9Ez01dutnXfZrPmhnPCexii+djIY4IG3jVSQ9ifGjVSFbro8ROvRy38p7y8OLADdAR1EiRvNQTTexF86rzVnO833I/Zc1Ic3uT50Qv7EvVWkFq8i/HKfNck5hiTlEUIt3V+A7JQKcH5pe8ExQ/liTDOWcIbLdKOgX7A6nlyDQ1BiNrUVJKp2ze3s6G+WgY8cYKKfScK0GSHUPJ4JfViEdu6cGzSsX5VrdD6lAl28TLsAG+KVhHeYqbU/SEIDpxEoTQ+/oGV9MJ/9pR5FlW6JPxTS+P25k7NjKXmcTmXrqoSiY7Ss361bqWJ+o+YRnH3Xad+xVr31Oo9gOtYdQOcADl6xeAMbiNiJKIMyxRLO5Ae5LVrQSZ3N4SFjpgbgYpqEbXvpuFF/cuXFmKRZTJgyQA8IYM4n1vMoW0FZAr1mFzmdJ9UACZFPRZJ5/+D7lREoK23ZQMBKZTgPCwYok012mwv4zCeSb5Kh7LRyD9dFdIB+TwioqurQXKtBLFZ807llbfjYDPNQ6v5zbr5oywabKo+GpFDY5hrzFpnU59dEaxFXeBJ33ChECh+eir29FLJAFZ/akREZs2yvKLX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199015)(83380400001)(186003)(2616005)(86362001)(38100700002)(8936002)(66476007)(66556008)(66946007)(5660300002)(4326008)(41300700001)(6486002)(2906002)(44832011)(107886003)(6666004)(478600001)(6506007)(26005)(6512007)(316002)(6916009)(8676002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zbx8oHPRY4aCIohLYdTf10wyRfHd3d7rjhw4edPAP/1PrVz1KDkFUE6HhFTq?=
 =?us-ascii?Q?ZraaXBlboOQWW/QizSaii4eFcaAAYTkIqjQJ45Hyl7jTpBZvASM5mRH606tZ?=
 =?us-ascii?Q?fTZlvbljh3FWV8l01wbCWKpg5k5i3bJiPUZAch4XS6+yIOo2lM5DG8SFa3TN?=
 =?us-ascii?Q?lELLAZX4b3osBZbAZ89KhUn4l68njRm3JhQ6kDLLmqZUdSR9cQoq1XwrFlpB?=
 =?us-ascii?Q?oUGUvPSXdsEi7/M1oQFw9mEfcX2cK8t0OmiRroGdPgnVuOb4s2Lu3RssFIqo?=
 =?us-ascii?Q?KYFGyHUv1jYTMa/H4CZdgb7nQeAPYXSBOi5PBA8kSwb/SCXR22mGvmBicgwl?=
 =?us-ascii?Q?DHxbrRRCpgSnOgG0MvAj2rNoFwDdrJ/aMofeN8eRMrAmbzDfmpqrtQbYMbV8?=
 =?us-ascii?Q?05XXy1EVHQf1bVIWt51m5Tx/Otvhvpp4h0wTzW65O+H1Ljpw0Qh0YQfpWtXi?=
 =?us-ascii?Q?wsRMuxPDbm3QO0aNd9ZsRRMcT8FWufnXw/O5djUJ+Gd3S9GY9ryQE0FVm68Y?=
 =?us-ascii?Q?SpKbB/jYWbdLO7A5kGxxYxv22n+Ixd15EX7Sb+hISvI5ewrjOfd23aeLbE+B?=
 =?us-ascii?Q?XVGgazcjsKQHDR4bfaSyQ/IZaKh5y/gdNhMSUt+9tc1V1cnvAgvU+uT3FGyk?=
 =?us-ascii?Q?wDjyJtT42Hwimy78cL4qTspeHlYfn7/VVO/TbqGrvvyVq2VqukGIMsxql63g?=
 =?us-ascii?Q?qGzPiiQRPLgiNLFnvB12XqIDxTmnYE9ZXnYnXEGgdaZI+7aUGu2OgWqHMna1?=
 =?us-ascii?Q?uGs0ExpTnDaozA9r7AnlW0aHN+jUTojpiGmcHRbvTnqDdts2u4JOeGv4I1S0?=
 =?us-ascii?Q?gq4mkQCpLLXPyj+3NdOHAqGsOFV/eDP/8XCkQrv2dkCDXFjfSsi7WPa5s1ZX?=
 =?us-ascii?Q?d4rq9qwrkR/hPlUf+gObqcjrxT0+4fvd0Kqlh1iMrzO8tsrmJ8wyTIPex0kN?=
 =?us-ascii?Q?p26YDP1aLZaRfX4+qjg2hecyeybP2M1soE+yMcLHZjZckUEPJR+Ef6dSUfTJ?=
 =?us-ascii?Q?kqvW/SHltpBd3TpBR7RvMDpH5R+y8JAslFXpkghOFkjihUJnWlBJ/nYql3Gr?=
 =?us-ascii?Q?LyNf2u5IqZvR9tMg8BTV8rwvcMB4S41STnIUqdTeaqZAkGq0FDquLNVViM5F?=
 =?us-ascii?Q?vGN7SLIodJIWTXo0yr5X/37S1fR68nCOjxAVSDKYzpCM0JxHnSQ5M8zq3KBd?=
 =?us-ascii?Q?clSgMw+Yr05UuepptaGjTf3EyIEoIaOYjkbWqPMGcHpzndLZCtNstKn1aPqJ?=
 =?us-ascii?Q?06ffMKSyl9LaFxP5BLtZDg7ZNXg2mGPTGROLuBzkY6vw0KtOoBr0jEQKijCh?=
 =?us-ascii?Q?mW01FDp0joZmK8BMnEWdt2oX+59QwYuN2hjzOQAQClfoQn4vOmytC1q5yyP4?=
 =?us-ascii?Q?/Y6KApQceIzxpSC+MlYreiiUgsob1q4QujUKQ4KvAPMaazR0IswKUtIF9EOb?=
 =?us-ascii?Q?kuxmFd416yQ4gxeePJin3abYqcAZFTyzWzYGi+A5CfaiGoUD7AmjXSwti/MY?=
 =?us-ascii?Q?Bb0oOaTDiTF8Ih1pj16F0rhdF3U0F20hGik87S1pS8HpopWrp32OiJqQM8Uj?=
 =?us-ascii?Q?8tXL0mjNBXsmZdmRiipg5CNHRZ2FxfDkDe7Lk5S3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661cb854-e86e-45dc-4bf1-08daa22bb707
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 15:03:06.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gd8u2uZ8LLNSkZXlKYJ9CsyICAJdyihA+0qbZ6wFTzZ6eofDwAK7bK8Auaq8X+HlaSQYRQkD6ETNLcQ6RpUGLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7822

Move the packet scheduler out of the dfrags loop, invoke it only once in
__mptcp_subflow_push_pending().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fe92a301b8f7..af37b18aa5a5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1598,7 +1598,15 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
 	int len, copied = 0;
-	bool first = true;
+
+	xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
+	if (!xmit_ssk)
+		goto out;
+	if (xmit_ssk != ssk) {
+		mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
+				       MPTCP_DELEGATE_SEND);
+		goto out;
+	}
 
 	info.flags = 0;
 	while ((dfrag = mptcp_send_head(sk))) {
@@ -1608,19 +1616,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 		while (len > 0) {
 			int ret = 0;
 
-			/* the caller already invoked the packet scheduler,
-			 * check for a different subflow usage only after
-			 * spooling the first chunk of data
-			 */
-			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
-			if (!xmit_ssk)
-				goto out;
-			if (xmit_ssk != ssk) {
-				mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-						       MPTCP_DELEGATE_SEND);
-				goto out;
-			}
-
 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 			if (ret <= 0)
 				goto out;
@@ -1628,11 +1623,18 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 			info.sent += ret;
 			copied += ret;
 			len -= ret;
-			first = false;
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+
+		if (msk->snd_burst > 0 &&
+		    sk_stream_memory_free(ssk) &&
+		    mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
+			mptcp_set_timeout(sk);
+		} else {
+			break;
+		}
 	}
 
 out:
@@ -3191,16 +3193,10 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 	if (!mptcp_send_head(sk))
 		return;
 
-	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
-
-		if (xmit_ssk == ssk)
-			__mptcp_subflow_push_pending(sk, ssk);
-		else if (xmit_ssk)
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk), MPTCP_DELEGATE_SEND);
-	} else {
+	if (!sock_owned_by_user(sk))
+		__mptcp_subflow_push_pending(sk, ssk);
+	else
 		__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
-	}
 }
 
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
-- 
2.35.3

