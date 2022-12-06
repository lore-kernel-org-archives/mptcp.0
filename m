Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42876AB3
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 13:30:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTpmhS1nCUOioDkNjbJlGC4SkB/dByv4CR+ftuvgCHiMbW2H4YMu16U8PbpaI5cVxOaniO2ZTVUr/k90KFEshsTi7oTJUETMq4JSIWbOa7AvPxgaAW7D7fiiUh6liIptlzX4ADRpUk8tORWKa3eRwVSwkfVewcYemrdKRXdA8pTfyWI6uJ8yxzpDjw9IRheZ+2ArEK0pDHBoow8jsBwQHW4nhBsLZe0zmx1g8OhQ5pbhS1Jk3hVcW7m81x9FfTxc5uUNzNFkAsUjE1xebVFjQBvs5Bc8vPcn4ImGlIcKQ0hAr9SnNrslp6+Sb2MXYSfaVAxS7krsD3tR2ba4jIKJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MI101J64JcCPGGkapYWVpCY9mG7vX/2e1upC7OnlGMU=;
 b=lSgafti5Om8mipRU9gEpa39H2KDBECA1bk1AqwikecTdvHgIoMgI9FW9TAksQeIiUQaODYQml1uryVKuCenUCDW5dwN2m7PhAw46PRstfU8BfAlONDo+rRiolHnmtnZFYs3hXcJ1mtujPeOJYTF2IWGJQI1IEJVJSgRShzy0VWep/gH+MqGDVGYQIEPdtwG7V4zSmkorMUp4FbKS0gk9aSdGmfKyYSA+faw2BB3Zzp2lvXpfafLZF/xZdCzwSeTbhlL/IjU9LcC0dwB1y0QBCl/J0BO78xmFvmvArc6b0AZ9iDggmmxyzHR205Fi2zDbn1mcxw0NZxEo7VRQDIgcFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MI101J64JcCPGGkapYWVpCY9mG7vX/2e1upC7OnlGMU=;
 b=VMZR/N+WkIwbkQzNysDmaYd3ABVkYjA+rn15lL8+15GyVeygQCctV2EsuXPadXTIWoh4gYRKKtCjUngPlKdIqZMAdbn6/sjsE9S9OINVMrE4YRmzaSA+1XkmhUHbS9AxD1pgZbyeqz0cDyks79YPbixiO34AUOwqUUgIxsejJZU+j1TFPjpINoIJtDnF0c54eMVPUvauRkyi+DXQdbJwrKsrW5T16Ipby6Ox9DXt4uB8LQl0KgWkAh+oV7eETSMS0u1Pz/LgcBYaQBO2IZxv5/ZYw9G2LqyW6vdEgBR/oJLrSFIZpel9865V2MNIXdVsabVNmjD5X03JwtNoR7gAgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DU0PR04MB9228.eurprd04.prod.outlook.com (2603:10a6:10:353::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 13:30:33 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700%3]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 13:30:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/2] mptcp: add use_lock for mptcp_retrans
Date: Tue,  6 Dec 2022 21:30:25 +0800
Message-Id: <ef54a367a29de9d28be13df29cb3c074ab874785.1670333050.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670333050.git.geliang.tang@suse.com>
References: <cover.1670333050.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:3:18::31) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DU0PR04MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: 6451a1e3-e43d-4b8e-982f-08dad78e0d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q4Yt3QBvR3GqiMD6LAg0XjfCWfG30PRWqXMQCX8aNQu0xDiY3MwZFUmOaC31rJsgSA62g/8pI3SDmacqgbQV3WKH2GIpNvBFqKzHZQCVceHwEE/ZenbOvLEzAk7xtD3mM4wMtkJNsJoYdsQzCyqNaJhmBMFzFIh7aYr8+whZVbwMINLmyHuiU6XBrY9xK2aowKkjf32cU+ywH7OhhwM+U3h9Ef9Bn5llWrEB/1QesGhEeiHlofOSjWBJrE/9Yodu93wW6gdDvVwjb+iTY+vbuBKvqgVfflYcgYOcX8ws80ydZtmm+FqIfWZNf+kWoDUewY2G4jJo8C7kz0mrczFLZNhQdyUV63St7xFfIUBfw3gU/SiNrAtzW6Ttq7wV/Q9LU+tGn90usVyCesnNVHWYtrmFVyfBSkV3+pg2ZdFsGF/T6gRtyHiHQ9Yju0ZJoacjuwOynHm3sLfDb0SnSfr6OqfUnos9yCSau8HK/uBSydBDFPd8ktBmO8Cd6hpAtqLGP/UFpWjyWjnHAFHNZTUVCnFoOyj2nkDTAvISK8c5mTn2PhbLwSex5Y6+t1mwgsdN53QhqH4jZcSCylobsxhO8KEnuvkkMlvOumu5/MxGe3qSph3STdn6SjsYvMaRBGMq8Qra/VjZinfmrNWnbtXtCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199015)(83380400001)(6506007)(2906002)(6916009)(86362001)(186003)(6512007)(26005)(2616005)(41300700001)(44832011)(316002)(5660300002)(36756003)(8936002)(66946007)(66476007)(66556008)(6486002)(478600001)(8676002)(4326008)(107886003)(38100700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R7EjDM6KVlo5k7r2XxMVCB7hn95/OJmElAhDqMytSfMjxrxMortrlK1sFmyB?=
 =?us-ascii?Q?0zW37HNgo380iG6ld4y/0Gc1cWZSr2E7oaZF6P4pX2vsQIlgn2NUUqCdLWMT?=
 =?us-ascii?Q?4I41qYRMQV7Wa5iaZqlHl4Awz0dJ+5sIz9ukfDDNVnFNgIJJXkxrA8BURUEu?=
 =?us-ascii?Q?Xl96aq4C3Qn6UfxyH1Bw/W1p6s8yPFqYr2Ia0gnumorCWup1j6edO78zPQWA?=
 =?us-ascii?Q?5wfetx8/Ce/ilJAdQ7swmIAzDczPypdJmcBBylAfOq5q168hNx/QwEF9MBIW?=
 =?us-ascii?Q?nWdvoSyZY2fciWoWOosNUJjcK7Ud7yI5n66jtswuE6eLiz1MMiCCmLqgIw5Y?=
 =?us-ascii?Q?UyMKQj/QS8ai0q3NkzJeIP8cU5O0OgYTReWTalQG1OH4z+HXNrSF+t6BGnQo?=
 =?us-ascii?Q?/yq75IW7kXCd4NET1wP+jhWuIvn/OUc+hkky4Sy8PdjwkiOhyP3PrdGulsHa?=
 =?us-ascii?Q?NfB0lNmLs4ga6fslpjgI83GzyjCCmkCYckjI8qWQQAeQqjSdzuwin7yxg7rC?=
 =?us-ascii?Q?fwVRUmwss3PJrZyYryrdbElsqkQgKYcG3rHSdhm3ZJIQt0APcx5SE7et9N8R?=
 =?us-ascii?Q?+lNyyzvVOCRR69kxOOEz65Ykcu4bHIWiY4489YfjlS28K0QURYKZ13VfDpmr?=
 =?us-ascii?Q?af7uXrvqm4zmTgq6kpceMTE5k4kCXlM0urfZAIFite6rNS94zZystHHtSmJ+?=
 =?us-ascii?Q?q6Rx6O7FlLXCJshKoVFAfkhTruw8IUVGXK/1C/I+dhF5U2/FuX/VANbDEks6?=
 =?us-ascii?Q?ix9lPY1GX6XAc906HmAN5wMSzPrp3qmy5X7XWchvlGEeIIVm5aqFPBctxYr8?=
 =?us-ascii?Q?a7KH+adHmB2UbiB4DBo9nMUmLbzXcXkACCUUX8JBleKfzAzl436rxJdom3Pn?=
 =?us-ascii?Q?2Ch0vFvsCeW/li5xC18bYbo08AhEBMcsuRgDTLUB+MA9nJn2n8obRc5WbSgn?=
 =?us-ascii?Q?DiuqD5LH20FtrXPQxUkC0ueR221UBApfasfDXiDNJZV2lRLxKHhK0Ah92MgW?=
 =?us-ascii?Q?0clr5R/LISsff2uWSbmhAPheqmirMz5YSc+7SqYlNgac9ZPr7W+avvjKsEiQ?=
 =?us-ascii?Q?FfNRqS3omsBIyRx6QWe/8JaknmcbEgeZlz/UZeRmsbn4c43gPCpngx39Acz9?=
 =?us-ascii?Q?5r5ER+yLYj7s/M1NxbUsKi4v1ac5PCkFpBKuFM+vbC1gdOX+w2XnAXEErICZ?=
 =?us-ascii?Q?co2OF2CL5m2TYEUxFYuFMp0FFFfZaG8GqC+AqVk/AHJV4C1jQJXSacrFih37?=
 =?us-ascii?Q?+KTMSWcknnHa+2GzaCuIImp17P1z3IcCPZL4mpIvXrc0wLm5qR7q0DkLIika?=
 =?us-ascii?Q?+zCRZhxp11+8kyuyv96UEvQcuGTl5sXA88pZH+yG7aD92eyn6DtBbm3kW5AW?=
 =?us-ascii?Q?KnX2lTYFI5X+pYCbsnttzplbDlymcgGiZYGTVEayK5vkUR2wYCxVNEvKxNb9?=
 =?us-ascii?Q?SbyPzY6t3LKn3iaCnjyN3QG/WWBrTKYRKeL0Fs9DzVjT4b6l0fXq5Y2cPiji?=
 =?us-ascii?Q?vEY4AuEyo00DCqEk6s6hOsUUX4mTuaAvqfPpjNd9hQkYveUrgWScAykGS2IM?=
 =?us-ascii?Q?t0SMqKZfy3f+20SgJ+Q8aEhlRmOoubFKOA1lnu6E5n13K7IXtDruZ4D/6mF4?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6451a1e3-e43d-4b8e-982f-08dad78e0d16
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 13:30:33.2508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOLlcJHI/IESLZoZDpr8f6oNhxo/NChKnc1Dy0bz4Snirpf5p0ut9vYWqDQiSVvVEAp904Xzowou6C3v3S/qEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9228

This patch adds a new parameter named 'ues_lock' for __mptcp_retrans()
to set whether to use socket locks in this function.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5505c1439b3e..9f0237b5a4b4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2523,7 +2523,7 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 	sk_error_report(sk);
 }
 
-static void __mptcp_retrans(struct sock *sk)
+static void __mptcp_retrans(struct sock *sk, bool use_lock)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
@@ -2566,7 +2566,8 @@ static void __mptcp_retrans(struct sock *sk)
 
 			ssk = mptcp_subflow_tcp_sock(subflow);
 
-			lock_sock(ssk);
+			if (use_lock)
+				lock_sock(ssk);
 
 			/* limit retransmission to the bytes already sent on some subflows */
 			info.sent = 0;
@@ -2588,7 +2589,8 @@ static void __mptcp_retrans(struct sock *sk)
 				WRITE_ONCE(msk->allow_infinite_fallback, false);
 			}
 
-			release_sock(ssk);
+			if (use_lock)
+				release_sock(ssk);
 
 			msk->last_snd = ssk;
 		}
@@ -2694,7 +2696,7 @@ static void mptcp_worker(struct work_struct *work)
 		__mptcp_close_subflow(msk);
 
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
-		__mptcp_retrans(sk);
+		__mptcp_retrans(sk, true);
 
 	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
 	if (fail_tout && time_after(jiffies, fail_tout))
@@ -3308,7 +3310,7 @@ static void mptcp_release_cb(struct sock *sk)
 		if (flags & BIT(MPTCP_PUSH_PENDING))
 			__mptcp_push_pending(sk, 0);
 		if (flags & BIT(MPTCP_RETRANSMIT))
-			__mptcp_retrans(sk);
+			__mptcp_retrans(sk, true);
 
 		cond_resched();
 		spin_lock_bh(&sk->sk_lock.slock);
-- 
2.35.3

