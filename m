Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCAD17CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGaLnv34PWdfer/4GYHuejVRae9fuOH9g6IW2FezRVbBYmavdbBdaFyi+diUkYuRv2OqEK/l3rNvs9KG3oCqaDzqf+zdSDN+PdzTa5X0rLG4fCp709/fcODFLqetB2WS/Vv1n5HdMPDgZl2nwja549w55gB3vVX5MW0mnOshgVPTExGUopsIxTpzbg09BBsnrbUog0sFqFb6B1AyljTI2Zx50NKx7SO2LxIVTqnU0DZzVUkaFIm0vYzIaWPkT9GvL4o5Ta6pEvciftMwSqjvNJK2r9Zj0HzLLKByRbhJ5uDQtMBQeodQGKD2lii3T5miRortuEjbk+JgHUXuiyqH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUxX51OiuTsNUwmtXaBtvAbRUsihC9OVRZme9vFQ1ag=;
 b=hyILrRw0xrJqKw6MFAKsYPZYTi983ef+Duki7GOYIYaTpTrN4jcEjZEy7AHDP1zFP2AfryxyOZln493pY0ejvcjb8BYShuo0NmfwAfjBDJ0b/tGjqv5zDUJPanGd8xjBQkS25SQ7Zz9Oapi5R0Du0eicfSLIH/oJL/ebIWeVKspXigkV3hCpltdVPBX4Le0wrQfOtBmdKYOGpNrmofqO6dF3LokixrP1iCckwG+sKc2Q6Tyzvm7wjH9inB77NoWz3b96iMEwkC9fRzZsqkowMa94lelOR97zjHDr/3i2l/1ajoWx6KWnkIzIzcPt17r75u6zejASddNij1RvpIeN2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUxX51OiuTsNUwmtXaBtvAbRUsihC9OVRZme9vFQ1ag=;
 b=vdruf7hbqZbbc9Lxgph7TcRWZIiHa+7YIaZ5YNqyR/D71Mis3eFO61H/n7FxY9QhG4RPgx752Dz1Ny+NCi1D880SchGqNodLnk/p3pUu4UBYiRpzMMQTvFJUs46lA9FP9WHyU2nDGfi0lTDv+UMepaYUWT81/yu9GNqLUEjW7GfSrFaOgKD3mAmHGivGlRx3ynw/15qChWti3+D+Sx0FNQakVFVPYEGlwWhKKo7ypiyGHVnxNBIzvhmd/kS/bY1AJy11pC0uOme4loRooC9tbAqBCb1ejckranIpDWjR0Yh+QhReYjtXErikG/G1twtwQLQvZxc4Uv6epkLR5I8ihQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:41:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:41:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 09/12] mptcp: simplify subflow_push_pending
Date: Wed, 12 Oct 2022 12:40:04 +0800
Message-Id: <f800bd607364e03d704fea794f8a10430392c501.1665549148.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549148.git.geliang.tang@suse.com>
References: <cover.1665549148.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:4:91::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e801c36-48a8-400d-ced5-08daac0bfe26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MEIKzrRHT2a2D08IUTK3aG6KlO4tAKvGx2UO6Lea++3HJHyjXdzFrRfK0c0GogHMaqHI8b/vKP0GA3DLDB7wI1/xGJg4r9q1MY4Bss0Wnrf0ZT7NEmcgzH1gHt8z/cBtv9YAKGUlrSplzuPEvyvEnyKj4xVVVfKEZpu2Ttj6EwouP8rCaLHv944g3H8tiINRrJB8/jo80/Rio5eRRHLoHCEwxXfBxIgUoDQKp8RleFuBlLmF0L5nmv/UfsPKvPowFQ3cAdHMSg9MRDcvXD/KNpMjaP1BHjqmTwxFzuuqsTU/xpRf0m1tBbkDi0wj/EA3ilyZhSXHiPJRHHLr7esJRm9Pu6Qr+wjIvPh33mMutxu9R4h/qZUbCU9m8oJJ74UCkoUhKFRFgVWZP8BJJ5uhpttsgpuSsD3hGWJ3OfAxa+VxMzaV5FNUp99Ulfmq0HcKkizp3F5QXeKfj+5lPw69eGdAqwq/pqURXq81OIHfjsRYj1g4m+ZdH3SqvBdZ+P58SFt9sLgiR8JL/EawLKpLOSqUqy/wJcNps8UXvIaG5paF2RUFiiqpdiaBwkWf9ENKj2Gc3IvAaAhp8jz6Z6ZA9qwZtb3CHU02KGj8BFfCNr3QCRpnBVX1jEtXJrxC0n9ag6g5hxn8W/W/ibAyxFXzdpRgkxJ7E/KlFfZt7NdDAvwF3AjvGHFG189szi/JH4QwSxF3AiQGqw1IZAJYmMruRnkQoTXXNER9Xtbt6cZHNLl/mrIzQreU2P6yC5BZE/L3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(107886003)(83380400001)(8936002)(2906002)(36756003)(8676002)(5660300002)(86362001)(41300700001)(66556008)(66946007)(316002)(44832011)(6916009)(4326008)(66476007)(26005)(6486002)(478600001)(38100700002)(186003)(2616005)(6512007)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LCqmw+rfmA1ukidRBQexGlnuv/fJdDc5Dl5BlAvP2v9cAwyCr6BNlosGu+a6?=
 =?us-ascii?Q?hiDDrMotTB9yIMVvxcR2RYBJTCoZzqkRdYVjB4jhyhwSgyLO+UbOEmItwNUc?=
 =?us-ascii?Q?mzp1DSP/HXX293KLJ7XGP1kLQIp7QBQxRysRVsHisDdjUqEXq3CYDUsOCpU6?=
 =?us-ascii?Q?si+EpUD0ryFV3QALw58RdCRiTSJKS/U8mj6W20pGFcTA1gkxoaGpZPuIe5Gs?=
 =?us-ascii?Q?k1KAR+sYIK7k9k4lRzL26O4VZ1ssV1p0sEGbh5gsHA9IKfPAfvmF7prw9Y5C?=
 =?us-ascii?Q?sjud5P2cas6MYE9v+nQr6IhN3yrefEZYHPKX6zkZboQuaGB/oYWzHHRlt8sm?=
 =?us-ascii?Q?Hv96NGXmY6UrtDLf/MmOiYhLHfHATC05L/P6eB8XHi76ILzy9vPA6SOVmhWj?=
 =?us-ascii?Q?eBwpKkvafKfu7PpI+3JKjmeIWgjztpINnbUIh5KsNlp0m630P3X46SuqC0Yq?=
 =?us-ascii?Q?alyqy8sVo5cxEdYRaMC1PrCDzNuY6VBrg1EJZ8Yy8wDMStJufckXoxn4rgMZ?=
 =?us-ascii?Q?k/VQI4PlZORec/rDJUgSIw3MM8agD2SMR1Hy4WoroNk5zwOBek11pYtzjxmT?=
 =?us-ascii?Q?5SSsh/GVnrKBjDouLGV6TnNPEGz1P5gnp8dRm5v/M2tM363quUzqwftlkLOT?=
 =?us-ascii?Q?RcEJjpqWp0YZFt6MRgPsMZVUp1EpaHNpQTBKcm4L8+otFk96aNhNqCknYNWf?=
 =?us-ascii?Q?eEuF5I6Z+VKS8PjO4W1KjOP4egfKdHQfkG1mofGts+9rIvZn0vykh3clQjia?=
 =?us-ascii?Q?Wo6wI4eD/RnNo7HkRNdAnSVaGkVIOS2lORZ4bJBjATuftVYG24Y+Yedw3pyE?=
 =?us-ascii?Q?LWEIIvcjXbEuZf3pQhC6raiDKUvh8+mS3fwjHFInEcrzq6Ue+9ZBe1rDNFc8?=
 =?us-ascii?Q?UhTaSP2qaSlXuSPQQhVsBQJeLUp7ZKHz75q4hJkhTle5P7IDUO7m1plAim5q?=
 =?us-ascii?Q?SU6qEEsUk66v7AqOpBhPMEclsFdP2C7nhfN5V22stDNFDudkWitKwHPBOeag?=
 =?us-ascii?Q?9Jg8WJ0TV/wHMRkqhR8uUJeNIQcUL1YtRwETP1E20oquohaa8vrripeiz5OG?=
 =?us-ascii?Q?iB6JECliS512xsFHR66yZN31PRPXbNYKTC/fx5506W+84OD0tc7MjXrTpXiE?=
 =?us-ascii?Q?aulYXn3TCPeFZeEUgcJ8U2mP6eF0+6HPl3BAKucrYZn8JDYaS6YVbYg4mKFs?=
 =?us-ascii?Q?0MB6V+IHgiU9km20ZErxOaZT3naKxV5nMLYJyClVUEAkS4rEmp4UBRI9s7PB?=
 =?us-ascii?Q?Tl4TD6rQXIb0cUkQAhN6ApTdmk8Rdu6uMemcxF0DwWGp4g29MNNSxAn094QN?=
 =?us-ascii?Q?Prl2TYlN1f8SiyJ7iZ+eBWL+MwS1UHb4ShwFnyNEFRWSNGMTHSUZWcHcNRk+?=
 =?us-ascii?Q?op/76morSEVbg7fSczg0rmWl9eCPuphDuC/l6qGD2Zxiuues8qbnPYI5/MmR?=
 =?us-ascii?Q?NiF/uphSFMbD7jz6BWmmOBnxtPVe35vgm7AwmYgKiuLG04pFcuJL867rQtqK?=
 =?us-ascii?Q?G28BTWUJrHSe5ZEogG2R/Ory5zL4xHZGN1BzVtRruz0LFQeAbypBlLWEGmtS?=
 =?us-ascii?Q?3Xw4+HgC6erME9p+M5+8Vp6zVNdB7dGudFifdTWxxF5LnP8GmjRX0O5g4bsr?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e801c36-48a8-400d-ced5-08daac0bfe26
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:41:13.6014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9m5MrRsu0XWqMOOxtUcHcI5/w0UpMPD32T+Y0NXL/pY9uzSxi9goKVzg2DAsz4LmV9tq4ETKSYwABR06NP3Qpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814

This patch simplifies __mptcp_subflow_push_pending() by invoking
__subflow_push_pending() helper.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 39 ++++++++-------------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fcb65c4ec774..36525d7ea8e7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1603,11 +1603,11 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
-	int len, copied = 0;
+	int ret = 0;
 
 	info.flags = 0;
+again:
 	while (mptcp_send_head(sk)) {
 		/* check for a different subflow usage only after
 		 * spooling the first chunk of data
@@ -1621,32 +1621,11 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 			goto out;
 		}
 
-		while ((dfrag = mptcp_send_head(sk))) {
-			info.sent = dfrag->already_sent;
-			info.limit = dfrag->data_len;
-			len = dfrag->data_len - dfrag->already_sent;
-			while (len > 0) {
-				int ret = 0;
-
-				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-				if (ret <= 0)
-					goto out;
-
-				info.sent += ret;
-				copied += ret;
-				len -= ret;
-				first = false;
-
-				mptcp_update_post_push(msk, dfrag, ret);
-			}
-			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
-
-			if (msk->snd_burst <= 0 ||
-			    !sk_stream_memory_free(ssk) ||
-			    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
-				goto out;
-			}
-			mptcp_set_timeout(sk);
+		ret = __subflow_push_pending(sk, ssk, &info);
+		if (ret <= 0) {
+			if (ret == -EAGAIN)
+				goto again;
+			break;
 		}
 	}
 
@@ -1654,9 +1633,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 	/* __mptcp_alloc_tx_skb could have released some wmem and we are
 	 * not going to flush it via release_sock()
 	 */
-	if (copied) {
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
+	if (ret > 0) {
 		if (!mptcp_timer_pending(sk))
 			mptcp_reset_timer(sk);
 
-- 
2.35.3

