Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D547F6
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 12:18:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2YvreWUdqWQXdpYV8r7kMoySSx+kskizcSxjlwRFX2qUYfGYdouCKg21fg7C6XJcTjM0YNgU+mdMhi2MZ+95HgxnpSBFupxXhJxpHK14hDv1tH5rN7acmGnoxVe60ukRMqWUAN5HlIJNmxnkXuEgYKPOgoAtQCqsg0wUZchDUhih7JKivGkkLuTdiZTlnNDYegFVxZDOiDploLrda7og50pFkPT6mBGTZTSv3exQRlQS52lyoFrtrlS7ixa/EZL642T9rMlchfBPTp/gD5lPB8FCZpim4XZ75YOx+vRKYTfKUseLO/0lkMWfv/rB9T6S8LOnSbcT0abRRHwF11Cng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8TCz4GEhB25ZGFegIstJI8jx9SAdmlJZszmNULq4lI=;
 b=IVQbsrzhfnxWKg5mDi13m4S3aoJfoIOFmrWQcwBMI2aZQZ4//TLDvtP/VfOSL5fQ7Dh81xJjLA99r5oagSj0z1IsgKQwhmoGnqPxyDKiMywybQQtKb1afObaeqYV1qlsraa/ipPb3ojO4pusPRr7Z/K0MK5Od4dv7gipbZaGJrGwXlJIbKRzQ7QtAzbjWH/UekA/TnpAR7te5jvecElraJkhqMwRiLg3pTMfITwe6mJ1zfdENhr2NpvjzWBmQn5aRWLmx/ClMcCGLtcsvYzD18y/pBZ7W+riveVoghO7YKtPGX3HHgMcXKxFk6olneRDB8W2bi5UjpwO6vUypflTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8TCz4GEhB25ZGFegIstJI8jx9SAdmlJZszmNULq4lI=;
 b=mmh1x/W6zvdjOEfjiwDK3yZtOjD83/dUrNX48L+spQWiIp+jYOLTLBj/uSGdxMNac/pwCsC+e9ivoXn72lWr5V2Dk4HU2qPkizmhvce1mte76HhLTzoKbEQF+IFldrXsX43A4JNUOlKnlPdWAF6ZTdZZeHorE3Sd91aHAxjqOCgjgtuYeqGPGoxnKZhenXf2wGezD8qaVS6zEkVlppEXVERQaAenugz3CO4IXfC9vB3BufE7DNVSFvRU4SMsh8OB1lTROCOwEOgv0ILlcO6BqGblYXB7mqoDSkcBOmT3cnivnyDwTjT3qns82iDu96LgumZNPhyYDkGGvfv4Fe5nvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9292.eurprd04.prod.outlook.com (2603:10a6:20b:4e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Thu, 6 Oct
 2022 12:18:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 12:18:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 11/11] mptcp: multi subflows retrans support
Date: Thu,  6 Oct 2022 20:17:59 +0800
Message-Id: <ef567186b9f3920e2043d85a585a4db957646d34.1665058389.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665058388.git.geliang.tang@suse.com>
References: <cover.1665058388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9292:EE_
X-MS-Office365-Filtering-Correlation-Id: 6235e9b0-3cb4-4428-ef9c-08daa794efaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	msvR850Fo2q80Vpl/AN2+MFlL7e1fnb7eUWSvpjAG3YFA2Zc9HXCH1SShmyBzm8bQZaMEJ5jrdEMpa8bao7EvNvUt2oejvr02I3htQwKCmh5BwM9VcQ5djlTmvr0HX1Uth2yVVaiAOm2IIVDWTEimiPFyzus8AB2nQwQfob50WKRlFyo63aVjBVdxi76gavJOsYP40NWWUKlNjPz90nuDgM2TTHW1TJKudM0p0tPw9Fobe5bruLAkUGo589aVzkzUSCr9+1InSSCeoGG2Ri/HaeWuFUG6E3UWr1+QIt3aFv+xp0CfaDDwKpWqb7Zof+YPHh2wkZoxpWCtHcKiZgemlYH4F2O1jplbVSEtEdJkUsz+W3Lm6W6mIoLQauK/lP6AyKL4/sIZihJlQcemZe+4ElnT7w92U88b5DlDe67vfBy+IBG2b7OG+zEkV8o3h/1MzdyhtgA43lvPGX6ScG22hWVx87dmZwxiB0HQcCgCq/AVPNF72Yn+/2q0LmA/wAuQRJTReWIlwoCT69L0nq0I3wFv1ThhqknfVRXn7+Gs9nJRKm7j2L4PqSq0M/HT7uD9e0yR4n9aYNRowAQxH7R+P58A8n9KJnF4n5pqoJ58ozhMEASKPauHP1qdzCfZNtaWaOjRO9db0udUMZLxzNIb0EOp4kCuyx+FDS6rLT3f/jZ1BznJBQVM+tUjYxrP8jlYFzIwx3rvt19Uzwunw2c4xr7T5ljO2+wBlQq0YNNgkbSyUEGI5wW8v1kfPnWx3Sr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(2906002)(186003)(38100700002)(5660300002)(36756003)(86362001)(66556008)(66946007)(107886003)(6506007)(8936002)(4326008)(41300700001)(66476007)(26005)(6512007)(44832011)(316002)(8676002)(6486002)(478600001)(6916009)(2616005)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1MK1Y1phspHWL/4hUe3tOpYN7lRqUeXw5Fk4trTnKg2NTRFtq3Gp8NrSJNB7?=
 =?us-ascii?Q?WglC9Hr8cyqF0tuvpw2jCTnHxQyH+CRHeNURg8mydxvVSWWbW5POb7gJIMGc?=
 =?us-ascii?Q?v8ChelEXIizJHLjBSmkSm15kvsgQTBjWV0fVXfzGNi94QugwkmYnEOvHSbl/?=
 =?us-ascii?Q?OAW7vCdLoKufkMdoCBZ9vfpFUuYmstxlt1XUxHQDtm0yZAS1lmKEUJcVlZI7?=
 =?us-ascii?Q?8OPnrLY+6AZSLq8eQbOXd1DNkEhsP3R8rE+QE0loo9RaLCY1gDOvlKABPtAk?=
 =?us-ascii?Q?sUjKrGpNrNVW0ypMzsmqAV9e4HpBuKhX1s+OKbH6pXsYLE2fCPvPPkUuh0Yq?=
 =?us-ascii?Q?aJUsvn14nQKwXh9+X4Dabe2dIMBvvYRRwCvBKlpNZJu4OpXYMZvNevjtcEAO?=
 =?us-ascii?Q?1wbb6iDR+697e/DsvIHjChyZt142QVOEHu5M+jbovbkJTVaEFNK5KDDcwQxb?=
 =?us-ascii?Q?zxvdtdrIxQvcQGDOdHlDmvymiD+NaI5RRYkCS3q1yPnHY2dfAjzAIF/I7zUl?=
 =?us-ascii?Q?6Mskji22aGAAHjLPLBYDVXyctkFSCOIeDiWeRJNwJUP/1GcCRv4a7xnlj22q?=
 =?us-ascii?Q?yCQoMHYsfsVFo/7ID/99LyjsLxyx1qDzTUQJAyUNf+QE6w+BxyLTZG6OvH4X?=
 =?us-ascii?Q?yOQppXSEwAdmg8c6nr/WvpGwoOmBpSX4AUSforeZfJbcW1cS2UPH5Bb1zw3A?=
 =?us-ascii?Q?WSKXZYqKexO0WI4QVGPeDEg2sGJqSwolc73I7JZf5vnR3wVny0ghBpLu1jq6?=
 =?us-ascii?Q?LiQJYQ2ouzE2or+HfVObO2/Qo5uUOz2HI2GYy9rpeeKvVxkYyynKcJ79Jgls?=
 =?us-ascii?Q?S2bl0umUBQI+rwwdTWPLby3MO8Rajax4nS5lBRHSv/xwZOFxAxrn6V/gz8DU?=
 =?us-ascii?Q?IwadxopKOR4WWOZ5/BihqJ8snUCUO0ANtSeHEoRQBZFXkXfgsk6VYxaJ8FxO?=
 =?us-ascii?Q?LrVo3DqNhZpXJ23JIOEyRcduzs4WceL1ecO7aWekQrhaq6C87968go1pQqVY?=
 =?us-ascii?Q?SBe+rw2rMchvrW7f82gMtywsnURTua14MT9Qy6YRN6ItOCKatEne65llaZ3C?=
 =?us-ascii?Q?mLEmNSYL3vrKVIVC6W5vDiQCcrZTxB4SOs/JdT7FCIVpp+TUD6Y20MJ3t4ze?=
 =?us-ascii?Q?l078shMBPF0RMhAWQ3N9sot9rXwJc/91h6QZf4haBBKXeeJhyauMsO/xvXl3?=
 =?us-ascii?Q?1Lx9MiAKO9DX1Z21ofhF/iSVNgS+PEN6uCIDA7JT5+WZaNc7NfC62ledHYTB?=
 =?us-ascii?Q?5VOuAQyo0o24LSHR6gmLXsqSQdcISSQr3m4+oTovh7AruLBWeVa9bFFyAQZJ?=
 =?us-ascii?Q?RfdOO6nlUGdhPRuVFQl5esZKl4BgmMvxxRfAVcL7a9vC3AkLGnHMkt1RFFXL?=
 =?us-ascii?Q?BuiHUzjuTkkn9F+57ZrqAusdWxy0MaIT36JhgyQrRwtJQUGCUMOALXF+n9SQ?=
 =?us-ascii?Q?Aq7MPg6alRwO/ccKnUzUclDZBoBpeSbymxDfgYbjZ4dEny3sPrlNIvPxNV+w?=
 =?us-ascii?Q?6EayaRryziwjvqV312J5x6umzdpoicYhr8EIq+/oKGVc5xnktoZXLlhQT78g?=
 =?us-ascii?Q?T70cEECRodGlUn94kjCJQQ7h/HYNMuthaRPbQCddvtyf5ZK2mfnBW3neUVu0?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6235e9b0-3cb4-4428-ef9c-08daa794efaa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:18:54.7114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzmLH0glBDQ2to+exz8KxH86Fgg8tmXlq2MCY12/fKsWu5L5IMMAgptTb2ePwxlJrdhDlf/HwImxifRa7I+uSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9292

This patch adds the multiple subflows support for __mptcp_retrans(). In
it, use sched_get_retrans() wrapper instead of mptcp_subflow_get_retrans().

Iterate each subflow of msk, check the scheduled flag to test if it is
picked by the scheduler. If so, use it to retrans data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 62 ++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ecea2a400e6b..b422d5de435b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2479,16 +2479,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 static void __mptcp_retrans(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
-	size_t copied = 0;
 	struct sock *ssk;
-	int ret;
+	int ret, err;
+	u16 len = 0;
 
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_subflow_get_retrans(msk);
+	err = mptcp_sched_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2507,31 +2508,46 @@ static void __mptcp_retrans(struct sock *sk)
 		goto reset_timer;
 	}
 
-	if (!ssk)
+	if (err)
 		goto reset_timer;
 
-	lock_sock(ssk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			u16 copied = 0;
+
+			ssk = mptcp_subflow_tcp_sock(subflow);
+			if (!ssk)
+				goto reset_timer;
+
+			lock_sock(ssk);
+
+			/* limit retransmission to the bytes already sent on some subflows */
+			info.sent = 0;
+			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
+								    dfrag->already_sent;
+			while (info.sent < info.limit) {
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0)
+					break;
+
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
+				copied += ret;
+				info.sent += ret;
+			}
+			if (copied) {
+				len = max(copied, len);
+				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+					 info.size_goal);
+				WRITE_ONCE(msk->allow_infinite_fallback, false);
+			}
 
-	/* limit retransmission to the bytes already sent on some subflows */
-	info.sent = 0;
-	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
-	while (info.sent < info.limit) {
-		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret <= 0)
-			break;
+			release_sock(ssk);
 
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied += ret;
-		info.sent += ret;
-	}
-	if (copied) {
-		dfrag->already_sent = max(dfrag->already_sent, info.sent);
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
-		WRITE_ONCE(msk->allow_infinite_fallback, false);
+			msk->last_snd = ssk;
+			mptcp_subflow_set_scheduled(subflow, false);
+		}
 	}
-
-	release_sock(ssk);
+	dfrag->already_sent = max(dfrag->already_sent, len);
 
 reset_timer:
 	mptcp_check_and_set_pending(sk);
-- 
2.35.3

