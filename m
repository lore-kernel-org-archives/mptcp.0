Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2044.outbound.protection.outlook.com [40.107.241.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8770E63C
	for <mptcp@lists.linux.dev>; Wed,  7 Dec 2022 11:05:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fufHOnfvWolGzQUaBN2K7FD1uvmqXx0XtE/N+3OGO7rj0bPzx4BYugRixGSEGtjxehr9VmKZiFPbp09OKx7N7X/o9Yn681LRIsagHFYYZAWUpsrTJis8nLkotpb63yp+608N1evd59pXSszUtUPPdyUaAxktQFF7YqsXf4cpiFVRNcxS2b7xr+bgWxSfxztUgYrNyF7Z3lvCRifx0YBsg9nf8R8wv9/yq5NzPU02ZRuzXZMmy61afAbsU6fYeMA8t0cJF8HEItL+IRpWaIZZtdajB9pHRo6K2SYyucpfvxgM4mGK4eEHkEKwLtKdd8Kxlu06QaQKS7gLogAT9ifcGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIQPCpqeX9h876jvLlfnpZ486i25JrLCc4IkCYD4JNw=;
 b=SHcXIF/QnMi1g8WiQ+CLM+l3fI8xMRAxOsTl98HOktOt2zy6OszKT62hxxPr1LlOBHeg0VVptECdnaE2hCnJDxMGZGpshCUVLstEiHJqt4r/o9VXwuLjn7ag9WvhdbfVOD1wnlNk95V9ZGo1zB8avXllOXKYE+0a3trbYv9EOUYBL5ZzIW0kv5X196YcYyN225dEbvtVikmHb+gDaWV+HXwCRadm76FJdAwf0LsJQFMSCun/H1AOBYWMYNSVgG43mHAQYAdRg4r3kCf6ZlK15HxAzGt0y8wObYnkNGEkpCB7A9JIOsMBk4Rt7y579AmtM5njkkEKr31R6onE2UmQEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIQPCpqeX9h876jvLlfnpZ486i25JrLCc4IkCYD4JNw=;
 b=mrB06KR9dQCyLGx5aJMSBYH8WzPaMG6yBIFonHIziokps0yCBIMFiH+HErCxYI5T+Isu2UW30U9wsOfqAU3uWW8U1pu86b3Ev7y99hpDZvd0Ub/Iv+M3678WeKXmElK3DJECgL7hXNlWlXNlLvHaR2mg0wQpNetUiC0E87yRmgZXHlj1OzVwEAxf8GGylDtghSBKXGjl8ws899sZ663PQ5KdwJ32g7fYy4QbHRgSR1MDfVwFEGLiMbH78+2ziwt04bIcPMlAtSvxWIs7V0ICYblZuucgGjy8ADImgT9VM7uwzDsAoMRwhYqMqNtmaHmvdA6MvSsHaOJhTsbtvUlDeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8176.eurprd04.prod.outlook.com (2603:10a6:102:1c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Wed, 7 Dec
 2022 11:05:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 11:05:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/2] mptcp: update mptcp_push_release
Date: Wed,  7 Dec 2022 19:04:56 +0800
Message-Id: <84fa8cfe55c137e667ca06555faa3ef71629830d.1670410690.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670410690.git.geliang.tang@suse.com>
References: <cover.1670410690.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0054.jpnprd01.prod.outlook.com
 (2603:1096:403:a::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 91752853-c0ec-48cb-844c-08dad842ef2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4SGlAp4MX/pXMxikdLRIXyZ6fMin1QHitqWSnfhdfPemGw9/p+p/qgdLEtfbJAkGvtaamsQcF1Nofde2DtEXwugnLXo+QXp/ckWYxOLWTXPN1Puko0j0fvoWmYuTmWNZN/xBXQi0gUeA7ePWOc7KvkiZGp49LKLYuElsTDZCrVRcb0pgLQtcaseYoQS6NZmDRgL/kGSJfRtXZO8DVsAmjRGGPD5EOn9letbBpH1BKdd+ILulhCfRm82gG9rsKdOROFTgQJlcpD6EvCrJiUccvTSbcB6dCbCDSJZt7aUzmJ9ezT5yoTEE+xFdZK038X5tQ4x7/Lf1I6KPA60zJqyI4ps+PawGd3JtIg/l1VYBNF/a+U25/20R9H9oT2pPACe1RXq5rhmY/b5K2VzXdNHnJN9tSc+XpbglElAoG7tUDyFhEGYqyBGaDhvfFb3KJazgWoGgk4KTPouYKZfY4D7tixeIGwKd4edLTKIhQnhBtXpl+ebWdPr0AK2Wyobvs4SH5JTAKK5VcZVL+ZPzKqlU2tOTKjAfHIyEULBF+ulHHxjJDx/SQ+HB5Xi0jspWPdeNKUc5aFQgyFJoWD7hRJgoR5M5IB9hMYnrcdOA0Yt6LBs0pWYEpiHtJKsDqikZy4dhs8JgoA/yJAc7SNavC2X9JA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(6486002)(83380400001)(86362001)(5660300002)(4326008)(44832011)(41300700001)(2906002)(8936002)(8676002)(107886003)(26005)(6506007)(6512007)(186003)(6666004)(2616005)(316002)(66556008)(478600001)(66946007)(66476007)(6916009)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qzbkI/4VGA8pKW4hwP1Dxumae4nJOykW1y3Njq5JbrHDoi2V2uzWvMXlThtQ?=
 =?us-ascii?Q?Mr7pwH3kIdSZ4Nw65fNNrjw72eIDSnUQMUcm1Ivta9/h1tDaQuIh+cog7ksB?=
 =?us-ascii?Q?esTcCoB1coy7y1zyf54HbbFKG2nnkYWzHToZYZEa/XIVuP49GMBMkLJdobee?=
 =?us-ascii?Q?WKACUx9WhkzIOzhzX2Gg7Hi3R5SOWSKChDhWOOutk56vhv6hTImq+lOXBtmB?=
 =?us-ascii?Q?+23FKVTA0Tcj8FILTVvZGoUErDE2lL8qLkTbQvfbpOHynOgL75acR9sygHZI?=
 =?us-ascii?Q?w/txajpM5/nopq2e86/HMQn1Isb+9TcfeqgWN08Dr5o6bHxoSnjLDpU8VDMc?=
 =?us-ascii?Q?/McafD+atz5krW3spJjc5mAUhIWXlRtmwa4cHybZ/URBv/FXcYrnTvY8KL9h?=
 =?us-ascii?Q?wCu/QVQR5/EkNC0gUhik20LUDBlH0Le2qKCwx9hdgc38UcRWRgf6nss8NEEP?=
 =?us-ascii?Q?92jjpR8o/avJfupJeCR+zQE/DepTF5wgC1JQdMXuTK0J6ZBPZkNB0V1AWZPp?=
 =?us-ascii?Q?F//3qsGorPDatq+5StZ/rOfV7amuaK8221GmHzmxMLkJYgEmHrjiPfysu+Xq?=
 =?us-ascii?Q?23n22t8frvGFM0ioiRjMpJUfx6lSnPgScpon5jTbxpTHB+rM/KMyn3fxMHcL?=
 =?us-ascii?Q?ZHJt2C7JujS+qY2nsr2E3icE7AJIa5hGjrKuc5u+5ZR8SWKtNLuJMhRv4ShV?=
 =?us-ascii?Q?gs7heWJHggEsLErc3Hd1TZanb5WnyuqOxGopXbwBF7EgzukcD7UaIXjIwyTc?=
 =?us-ascii?Q?LMlCxHiBN0vgOBpkxN864yz0aBits0C8v5tR6g1tykD2slvsOHs0mMZORZ2B?=
 =?us-ascii?Q?Di7E7j09A/CHhW0H2bXdJj72NH4vw65l7vfctiYewUy7vWfvRmvFqWoTMj2C?=
 =?us-ascii?Q?WNIt6Nretj9EemKRBRATZHu12BnxcYnhbUn9jtpLqZD/2BAsV8Cftq61ilBQ?=
 =?us-ascii?Q?PWjmsq+0Nb2EtrG78NKb0eUm+IgAYY13tUD6cPFFyYbqJlv52H4ayd0ct9jU?=
 =?us-ascii?Q?9oxYl61dE6nDyZr7U4eZUZONZZQ/cyOfyaGWR0nLB9j7bgw4TTLkawmO6g46?=
 =?us-ascii?Q?yxESHiBz2feEVFkAOQKLUq3yKWf1V+rFFsbQfhKlqzhnnEWc6TlLjYNcpLD9?=
 =?us-ascii?Q?cCvHoB3f/Vb8zL3Af/8qyt8m620QA4DvvMMf5KYfRswzGsoYQ+8LZVnsssJ6?=
 =?us-ascii?Q?tFE6oKH9I6t4ZUppeWLia6m/nucJ/6RofxFtGUB2vCIbPyvn922vi5X01Qnq?=
 =?us-ascii?Q?DJRKe9tMTcFSiY/dPPyWOeQaXN9DnIB2zGC7f1Ds9n7JNuCIT5HGWkvOY8hd?=
 =?us-ascii?Q?iOwXs41iDXpPiZn1ZoKOXTlFy06jjz0a/nefXGkNXdw4Ho1/FqGuHzwrewao?=
 =?us-ascii?Q?y3SAYhH0mdI4dFK6WcmFBpoGIZ6cMrZMZzMj6dPJTjibsvASALZN8iAoQmnm?=
 =?us-ascii?Q?3SuxL8dCnbkAGef8vgc+yYkKKdi5RCWQuq9P4cZ0v76N1yA7k+A5hN6xGjP+?=
 =?us-ascii?Q?PVTnpMKis+5x2z9exV/FLkW8Vj4EIfyZ1o5BcdLpc2jCgg3xtMwieYsPPrn6?=
 =?us-ascii?Q?/cT65o4H6GCTC2RZ4SFQ9FIkgudRFkiq0OFu0WqlqkK/sHgj1cnZfPrC8I0o?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91752853-c0ec-48cb-844c-08dad842ef2f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 11:05:22.0687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKL9UGVjYJydjTnz/U5KyJR+QUFjAdgNIfwilPM6a4YkOni1fZphb/hBpCFenIO20E/W0FnJfFJq64eIR+4FTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8176

This patch moves the NULL pointer check into mptcp_push_release(). Also
add a new parameter 'push' for it to set whether to invoke tcp_push in
it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5505c1439b3e..0c4403c2aace 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1471,9 +1471,17 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	return ssk;
 }
 
-static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
+static void mptcp_push_release(struct sock *ssk,
+			       struct mptcp_sendmsg_info *info,
+			       bool push)
 {
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
+	if (!ssk)
+		return;
+
+	if (push) {
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
+			 info->size_goal);
+	}
 	release_sock(ssk);
 }
 
@@ -1579,8 +1587,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 					/* First check. If the ssk has changed since
 					 * the last round, release prev_ssk
 					 */
-					if (prev_ssk)
-						mptcp_push_release(prev_ssk, &info);
+					mptcp_push_release(prev_ssk, &info, do_check_data_fin);
 
 					/* Need to lock the new subflow only if different
 					 * from the previous one, otherwise we are still
@@ -1606,8 +1613,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
-	if (ssk)
-		mptcp_push_release(ssk, &info);
+	mptcp_push_release(ssk, &info, do_check_data_fin);
 
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
-- 
2.35.3

