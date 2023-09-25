Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD578125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:42:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arYOqnirQjsm9gypt9by6y0pWhcB9xiLarq21UNRCMqqpy+G669nYblBv+H+HfjDeJ/HZ3lvGquLU+jlgYzDsuZkswk3cKITBy7ksY614mfiOiwggn8umWZ8xkMsaif5icBrQkiKuRB6z2rCxk5HV/WgmTdk7zO3GZ83B/CzUl1zgGU6HpA5uqXlMMB4G2v7hLEdXjXsAQPHgSCJRklVPHILMlOiS3YjVWHsbhRkPXtf2vJj2JnbnnlMO5izMbiB4DWFz4Crhh6w3qnCccQ5HEwHnkc0lthgDTxmWO1VY4TgB5QfGALuF6JgWpaUCHwr+hBAMIQ10mAIjnmhUputAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CChAwy0DEqKfToaZLnczugRDM26ZOjxOSa9SBeO3Tos=;
 b=Q6NpJaUQ87L+JSacFIWmmCrffiNb7H8grz6Pt+4EH0dLzBks6lku4tJkWI6cYrKzlpe1qwSHQx4C2lXDzImo1TcJQbOjv9rX599gpm81cA0Ut0dp66jRaCVCXzLzq/fq2xQLnFRMQJpUL/H8C6MS3sYQxRbGrrYtJxyvA/F/i6elUe68l6lnFOpPK6jDDj97vOXuJ0geKgkUmbSBtEVve+Mo0vXJS7u6Ai5qw2ZJLdARCg9lJu8IclOA87EPo+i93r6szKCp7OEfuDGZFQBGoLjN9K8WPyDVfBYTHB2waepmaitCJL9n6++ahy8Q0hXFZ8ItXRSjwMMrI4riRNGqWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CChAwy0DEqKfToaZLnczugRDM26ZOjxOSa9SBeO3Tos=;
 b=aDDChd19DSTeBNxASmmQOGJQ78eL05qt7SluSa6BTkC7e12sIZmpRiWLlJewhBL+Z3fMkwkQPC0PLgV7EkFPyrPTViboFBhS78Sr48OJUypFB+GSQAzS42RY2m8ZPPda1yT7mxd2CKDE+KOLmAFxbGoSoIMY93WtuO75bz/lO3w9Kz8UA4M7KSGTT/mDitYGs3Hcg4ufUd51Jao9EVz3FP6lJB0P2Mu3Vs9fDlKa6/EWeDUJzLldVw08wdGOACtjSzxCGdaH3HHVe4daBXHfDdkX3kK71sA9u/absovtxgLRv1vN8z76bXUSr/jU8tBmt//6JKcVw7Cb6LJZ+y+ryA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8048.eurprd04.prod.outlook.com (2603:10a6:102:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Mon, 25 Sep
 2023 08:42:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:42:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 08/29] mptcp: add mptcpi_subflows_total counter
Date: Mon, 25 Sep 2023 16:41:47 +0800
Message-Id: <0b42c1729cbf39a6c5537737422cd8cace854456.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0157.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: a3241d2b-738c-488d-353e-08dbbda3522f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2MzvsoQIyuMeYIHMYHPAXFLN7wIBdEUdnO4L6pLGcxcAkKthF6YYkQL3ugy5i5vHiOtFxWr0wJ0vYUyqwmQFMY5HszcLboCTrDmhhYwqvZE2etRAnNpQtekMbXunXpc4wulwwh46wOQrto78+wFXBCkQWtfLI4DKEmcNteXAVZRhXKtS76MOspiBY4/c/XhexKjqnVlwmsURWlkvwBkYc0ppG5SpwM0c5YJ9402sQOEWWSIOz6jOMwa40Q0WTZLDNG6Fw8bMMBrXMAh10wq2NDpBO2dS6zWNo7V0CysHxkQCJrZbfzmjUdW18jrGXhLU23f0kckt3ih2AJS2xHh3OOXKTUwXNPveDJ0CosCDrSOXdxeC1DP3mELhdh+THtLX/d1RpkLrVWtUuMzZ6bSJPw+0XSy0UFZffklDtdLGAjcqbgSrlj8gjuwuHQEINBEbD0zhms7Qm/p1wU9hD7r4zzeeXLc78qjsVNChpM+vFLikZH4x0c2+yFNlG5OgArSAh69EMKHG1iv5HaNgUGxbJjEcfcEz36f4Lvii45ksXGA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(186009)(451199024)(1800799009)(36756003)(38100700002)(86362001)(2906002)(6666004)(6486002)(5660300002)(6512007)(478600001)(44832011)(966005)(66946007)(41300700001)(4326008)(8936002)(6506007)(66476007)(8676002)(6916009)(2616005)(83380400001)(66556008)(316002)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jscNb5+2xbjD8Xe0HhPKXym618jeT2kouPGB+MwPFkujaH8E+GGNlmwtsqgZ?=
 =?us-ascii?Q?V03LXPkxEZozLhUgKJfhGQlYeNkeOzm9I9wRYQNfq+3r1A2wJVeV/oG03KYF?=
 =?us-ascii?Q?tWK/Djq06FeQlDovlsPU4hxM9jFqss9s+Q7LC5xnGkvjmQywln7oMf4ExUoi?=
 =?us-ascii?Q?OFWlLSKq9pYJOtZFfSUrm2CFYLk6QP0AeHiuKxD71i3zbNLEiETzDfTKAqS4?=
 =?us-ascii?Q?eZXctHHYK3W0aS+vPvNjnq2UymOGjzy1nZDSghiFtEwzLxjHC9KxqpujzlF8?=
 =?us-ascii?Q?LfzYVNgAlM4dMgEu7RpgWU3ebc7mHxiojOsbziJNpltPXHBXbCM5wjUBL7wp?=
 =?us-ascii?Q?2fIiP6Nl143/FndV1xrR5Wn3V6Jqvwd6Mh9JY8cb2J/ldXRg30q6qtzSv26B?=
 =?us-ascii?Q?etAB14muewnq+EjHTdRxTCURqDrA4dZwRZdYf82eScl+7D0jfOKllDXEpVbT?=
 =?us-ascii?Q?hOfGgkCVjo+sEPujRnCpC5awvCqu9sqFqN7LrFCyjLVBeYj7zitdETZpXytc?=
 =?us-ascii?Q?nTnknjnKlmbGlwFykso+DSt7iiI1tIxEij3fODVbV9wyg6sK5ODZ681gTuCx?=
 =?us-ascii?Q?Lv0uVJiRsQmlg7U9gqbsEWT7wdPvSFRoswiKLCdubhiHYHemPSw58NhYcTXA?=
 =?us-ascii?Q?++Tca3eUfYPkm0mP/XB7nRBsB0Sx5hr8u5bd0zli4I8R3rPr14sjzjxyUjUQ?=
 =?us-ascii?Q?hjQRv0Fk0AhQcsCcCZQ6YcVXcIN7qLHx7M2LMiT0uys0rKivHaCKCqDGlu8X?=
 =?us-ascii?Q?9qqCkTRF9Dw6xq5PWTRI0ErrqxIFspQBSWeKX6plZR1yoH5Si7z5FxJCinX2?=
 =?us-ascii?Q?1LbOAiw/fzR/gSR5JIbehRaTOs/VOqw0mjgQ+Uggj2cOpiIkEfjbZ2ZWMcOC?=
 =?us-ascii?Q?+DXFlFJmkbWTxywAQDimS8/IWtEsQbroL9qX4zkRSCXjOXrBWgnShBdMWG20?=
 =?us-ascii?Q?ChEZt11GCcKKk4bvMd2zrWJEYDZcJ/AqjNHKoT0HGfB2ZzfkdX7tVL+F3JyJ?=
 =?us-ascii?Q?qirNnpExkmN5FGI1ArtRTsFx/H5Lcvt9YFTcQ6E23XkBtc3YWqFUdCiB6xXx?=
 =?us-ascii?Q?8zN6LZSkxSMmMkvRvYH3RzzGZ+jmNdyqXxOEPVx2VO0EfIKzGiU+L76mpuJ+?=
 =?us-ascii?Q?Ipq9XdNsEb3lW+Vm3DU46E/aAVs4MEpcNX0/0Aq81UGXuw+E7Jvj2CzSy3dD?=
 =?us-ascii?Q?kOWHEYnsDL0p0Rq36bkKChZVBX6UobLp9qBuHgbxPMMxTDO9s7GOjtuJS38H?=
 =?us-ascii?Q?oSA5kkSpkIF9TNxfa/HRoMy/vKJqER0OlUVkfPFTWqYf1sh2WNcPaxHJfh94?=
 =?us-ascii?Q?d7oHGo2XwXhj/DvjP1eSyEqBjO6ysjxLvP5dcUj4Z8IvEOI8yJDLgovJZm6W?=
 =?us-ascii?Q?MtUph2KyZmOEQ9qJW91XOVvMQg2I3/55R2ju4Z9V72HELpX8K/gokc9LOtTL?=
 =?us-ascii?Q?GpGSyFwcs2CssSmByS7CLk9g8lZ8su5FU6h5q5FBrPubg52P6JKKksptLVEv?=
 =?us-ascii?Q?KzNTgnbDVpBP8BddEJQgyq/cvDYrvQmCoyWAXV3grWex4VvfjDsOYrTmPN1k?=
 =?us-ascii?Q?RiSUkOBS/JooMqswXggV/kxtW8U87niCUwj/esy2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3241d2b-738c-488d-353e-08dbbda3522f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:42:16.0135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPpax9m+YxaNQhdN9OUdRB6awbCvHZP6KCkQNloXZW9QrVtTzkT+2bslRw8U9Voeh6U5vKSG9gLqYFrWWpY7vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8048

If the initial subflow has been removed, we cannot know without checking
other counters, e.g. ss -ti <filter> | grep -c tcp-ulp-mptcp or
getsockopt(SOL_MPTCP, MPTCP_FULL_INFO, ...) (or others except MPTCP_INFO
of course) and then check mptcp_subflow_data->num_subflows to get the
total amount of subflows.

This patch adds a new counter mptcpi_subflows_total in mptcpi_flags to
store the total amount of subflows, including the initial one. A new
helper __mptcp_has_initial_subflow() is added to check whether the
initial subflow has been removed or not. With this helper, we can then
compute the total amount of subflows from mptcp_info by doing something
like:

    mptcpi_subflows_total = mptcpi_subflows +
            __mptcp_has_initial_subflow(msk).

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/428
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/uapi/linux/mptcp.h | 1 +
 net/mptcp/protocol.h       | 7 +++++++
 net/mptcp/sockopt.c        | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 64ecc8a3f9f2..166bb9bad05c 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -61,6 +61,7 @@ struct mptcp_info {
 	__u64	mptcpi_bytes_sent;
 	__u64	mptcpi_bytes_received;
 	__u64	mptcpi_bytes_acked;
+	__u8	mptcpi_subflows_total;
 };
 
 /* MPTCP Reset reason codes, rfc8684 */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 340fdf2a7473..6508179e94a6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1077,6 +1077,13 @@ static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 
+static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
+{
+	struct sock *ssk = READ_ONCE(msk->first);
+
+	return ssk && inet_sk_state_load(ssk) != TCP_CLOSE;
+}
+
 static inline void mptcp_do_fallback(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index a2845be0a4e0..36602cc8c12d 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -935,6 +935,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_bytes_sent = msk->bytes_sent;
 	info->mptcpi_bytes_received = msk->bytes_received;
 	info->mptcpi_bytes_retrans = msk->bytes_retrans;
+	info->mptcpi_subflows_total = info->mptcpi_subflows +
+		__mptcp_has_initial_subflow(msk);
 	unlock_sock_fast(sk, slow);
 }
 EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
-- 
2.35.3

