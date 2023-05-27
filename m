Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2053.outbound.protection.outlook.com [40.107.7.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E871E20EB
	for <mptcp@lists.linux.dev>; Sat, 27 May 2023 12:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiZm9PoMCbsxUENBjUnLy3Y0albgyLNqTUC+LAGxcWETdh8XFABOUtCGnZEwwKJb125p4wNOk1AnycXYI6VBAU1qRSQpWFLVNPv1Ug66Pfa8yNEf+VFHCVfNeqFq0oSwPNpTpYQzk5eJru6vI5BAsWlBZHXkOCgUzhUMYCxaeLizLofGqALsR766y85xoH/C7TBr5OBxsGDrFb0UD6yE8r3KQaQf5oZrhAhXmHocsUP71eK2CsEZSpjpUQV/T99UvSxTSHlsPr584SfDmRqDIehZF/Bh7e1EsSIO/jf9pxoLYO46vXohCNuO3DitqA1sju2dcSfY+xZB6M+r3q/O1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/qjHRg7jJjBUegLayDwYwe8+M0QqEH65ES/mnOKsAo=;
 b=DmR1LseF5BQhfWljxlQg0igD7g18lK5Fj4FhlZcI1QkFSX/4A4m7RBeertG4uUIEt2NoV9gcbZkyJXgBk9K24zk9XB1A8KnzddgL1liEXyWwODHrygVfZ4b+fRmlW/aCkaqmjmyBD9vge8hCShZ8y+IyU5A+li3zny32VjtkinHzU/aXN+I6H0hM3R9/8VWOiyurPu1XUCZ0FMqlgbJ7PPdTTfmNu3wdbnS8oBawl7G2m3qs69QwT9Wa0PTgDSvNSZWNm/nS9A7U2xd55bga6xIWEbvZPLbxvv8o3VFhhYvTC2zyY/vUA7Q6VA5L7tkJVSov5fqrSwsaUZIzD3s9hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/qjHRg7jJjBUegLayDwYwe8+M0QqEH65ES/mnOKsAo=;
 b=Hy4X2sNHOYbbZiGNYkOyLNtLvUEjWX/Tt7cRpfsxi9G8EXmw6JP7xvWbnxg2vp9ntKp6tJoKjKbJDs1mOKtVNEG0OIx30p+lto1/GY/ZA06FBZdPApjBFyKTobt2FIZHBV7IZEwDRfhCR5miK0+6ARdDdJ45FPUaFMKokmYf6kUxEPmhcl4/aSZi9erfdFf0QRlsNiUhY+9CiWjAOl5EyoqqEA9i22ELCulWC4P0qNpD/rYynF+TC7WH7/moFXvXtPsRWF1uQm4BCVIRH2VxJAGrx9sPlPKFHElLQGx0wiuXdsc4C42jI9Nx0jrAfX/o9kXWrBJ3zl8ADfMr/n08DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8371.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Sat, 27 May
 2023 12:56:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Sat, 27 May 2023
 12:56:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 4/8] mptcp: add last_snd in sched_data
Date: Sat, 27 May 2023 20:55:33 +0800
Message-Id: <93395093f67a860f818b0f34ba1770f6bdf59dcd.1685191581.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685191581.git.geliang.tang@suse.com>
References: <cover.1685191581.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: b605a100-b33e-4a2a-c7e7-08db5eb1be1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2TITwV1jTXbn8Zpk00Ge8u1WI43a/1Z69hY/prkPV5YILcbybZpYIr854Oq4N6u32gT07mU6FUfwtHkLr3jLT/XetF3eo2UD1QXbkAQnweheet9Tt7p9b5tJyzqnpmqZ6A4mozY4maFdEzYFeOnfB9EaFR2OKQUxfJLCO8wLieao4orIe1u0NOOHQA8hhEz2tr+x75PQjjvo9ACsFHsXCEzyeL41CVpWdd+Gir8xOVe0gwA8VGiDRoVgITnjgHobM5/F2BQyIt+xVGS1V+nXAqUjweElrIk02jQTJCxYN/9U676ZvSUXtmYcayAvUiHjpP01nNYyVBC3s3fLdC9B0a3+Cf66LeARfQSPhFmfqbzTU8xuUbTsGK1hIQP/6znexLSh0nUrw7o/Y6mQUpRhzhoAWX1AHwRWQANL7NR6zY23vAdIqhX1xxUqz0T4BoOF4a2YIIPnnJrjSFqGUuTjKhuP1nPjJ3fQQFCRkFuSgtu2Zeez/82cDxpN9vYCBjOqofI/0GoV4lFUdh5MThUnZ6IiV5YDI7TcMG6/gQukeaEFZRXm4EGHylqZpAPrlXdm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(6666004)(316002)(6506007)(26005)(6512007)(36756003)(66556008)(107886003)(44832011)(66476007)(66946007)(6916009)(4326008)(38100700002)(5660300002)(6486002)(41300700001)(8936002)(8676002)(83380400001)(478600001)(86362001)(186003)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YE6lgbRS+0R6PWQJphK58ppSS77dk5jgEKc1FGGGAomlEXSWEGY4Mzdwt6yg?=
 =?us-ascii?Q?a6o1K4VCZQzS0S+JS92thB1Cz/NiPZqYfoNR7+l1WozmP/iOqyDKNUdOZt8w?=
 =?us-ascii?Q?6H84O35FKfLKDka1IyU7+7jMexZ4jk6T1hbtUt/j4cq+sQacTv5Z2/POXG8N?=
 =?us-ascii?Q?WlsAaXYRUGvfAsjox2MxotFwSlKMD5O7V0Rt6Dj2ncBlfi+yT7qookTnqvR9?=
 =?us-ascii?Q?fzY399Y2jjcjz7cy6WpjHMT6YAuZZRVXge3mVaoVU0rMYld9Ns9XPZ1gCLas?=
 =?us-ascii?Q?OffQMWXloi99G2AXZVQnhS9TcRK7xsl1+UYvpl7eGmJb7yss7UxDK5eyBMi4?=
 =?us-ascii?Q?oTLntvvNsYCImEhftZ5SDaQbq3QDYtwhf9n5jwzAEHDZ+kEG5zxvudoYBbBp?=
 =?us-ascii?Q?VIpLvLoZDlR1bUzzEaArNheTQJ42TAD/K/qZ/bOsyAOY7xw2jy0h42sr/ENT?=
 =?us-ascii?Q?L518CTd5RwzT5ZgY8DTaqvyhgcvkQGtWjOPL9MFlbrwRO35TeSX4E3ILtUbF?=
 =?us-ascii?Q?V1Dx1K7yDtgPyz4Wmb3QlPGRgv5B2NYl1OaS/VwO4QpglWmXCs7W/ws1u+S7?=
 =?us-ascii?Q?lHTNagLFdDqsUyH5Co9rTN10j5T+l9UAURbvVmnrpUiHGQFjvhpd4UHb+zUq?=
 =?us-ascii?Q?iBuso+HNcC2+nuN5AW9rZaNb17ibHnzDJoy5Txv8yDpYoaFGrJ1Qlj8OLGzE?=
 =?us-ascii?Q?x4TUAuJ3eIJ4OUoKSn0bIKZEz06AObhnyLyfdqi3Omg0EVvLvoiqZnQu9Fxd?=
 =?us-ascii?Q?lXVcLzIMAagWMd+43/tSZ7zjHlnRJRJUH7nQM2wU6Omyw+Pv5pqLs/KngEH5?=
 =?us-ascii?Q?vh5rIJuKNtKfS50q89rDfv4Zhqqx+q5dLOkYKvUT4eE/fhqgJvwJdYBFhZSF?=
 =?us-ascii?Q?3R7eBRMses888GT6bgqFasijTVY1d2Bt1ckZMaHJNB9JdzrgsvAFbQ9Xwb6O?=
 =?us-ascii?Q?0WXias9vdoKhVBfc/epdVoojt+1DU/ciYuuindZQMnyG9okqbJxx5T4XoyuJ?=
 =?us-ascii?Q?Da4wjHnkQuoMlwu1qzj5f0cO9GycCH5mfXIQCMM9ygWx+g59kiFhQYupkgA6?=
 =?us-ascii?Q?vYYAA+Mct93TKw+7w9RSfUc7TlEHQjlV0Wv/n5Xwq8u2jec1bDXg7ZgCilMr?=
 =?us-ascii?Q?pyffSKBvwusMrsl+gTMO7E66ZYmgJ1w3+SS+yCQ0Ar6knzkqvdKPivvCYvX5?=
 =?us-ascii?Q?P6qXdOUuC+3j7tbarLIjLEiuxL65qiqFyYs8IEtavnJGR4Wy7WFpcZdmFRMf?=
 =?us-ascii?Q?GyB8PQI+YeIH4ujLr5YIj/lMqRp5I8XF9myxt7ccSIZhG2ezVQ2JVrfIqrRS?=
 =?us-ascii?Q?Yui8w/kFbFIxrrctvdXT7C9Ub7KJqwAGyokxq0bbWGKSaEsU4cgbzopS23bT?=
 =?us-ascii?Q?WA92bgqqljS1tsRX/3EhEwQEdyupmQKstT0qFRs206XiP4wkFv63NekDp1E8?=
 =?us-ascii?Q?WuBz3DWXs6nge4VFG3I7tPnyJL8HCkX9ooiL2AP8BqdbmDo3MvG2w7QthZHb?=
 =?us-ascii?Q?DNeNNYvTieVVk0S1hlVy/FBX1kekTHzdSRrKRwUOuXM0GzwRxLXQnz2OOToH?=
 =?us-ascii?Q?zx62wqB08HPgkz6R+VAoJ9ODxmsObTm16WVaGnKj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b605a100-b33e-4a2a-c7e7-08db5eb1be1b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 12:56:09.8222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOizYDYlYHuw4S4z7Y47nmtCdx5li0htVz07RM4EV/4EaQiSkQd+1abpN/KNPhdLzOihvDd0R6FRaFUq/RbV0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8371

This patch moves last_snd from struct mptcp_sock to struct
mptcp_sched_data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/protocol.c | 14 +++++++-------
 net/mptcp/protocol.h |  1 -
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4bba29c99172..4fd84768c5a3 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -101,6 +101,7 @@ struct mptcp_out_options {
 
 struct mptcp_sched_data {
 	bool		reinject;
+	struct sock	*last_snd;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 763f709fd5f5..59d36b354f6a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1619,7 +1619,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 					continue;
 				}
 				do_check_data_fin = true;
-				msk->last_snd = ssk;
+				msk->data->last_snd = ssk;
 			}
 		}
 	}
@@ -1660,7 +1660,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			if (ret <= 0)
 				break;
 			copied += ret;
-			msk->last_snd = ssk;
+			msk->data->last_snd = ssk;
 			continue;
 		}
 
@@ -1673,7 +1673,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			if (ret <= 0)
 				keep_pushing = false;
 			copied += ret;
-			msk->last_snd = ssk;
+			msk->data->last_snd = ssk;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {
@@ -2457,8 +2457,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		WRITE_ONCE(msk->first, NULL);
 
 out:
-	if (ssk == msk->last_snd)
-		msk->last_snd = NULL;
+	if (ssk == msk->data->last_snd)
+		msk->data->last_snd = NULL;
 
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
@@ -2640,7 +2640,7 @@ static void __mptcp_retrans(struct sock *sk)
 
 			release_sock(ssk);
 
-			msk->last_snd = ssk;
+			msk->data->last_snd = ssk;
 		}
 	}
 	dfrag->already_sent = max(dfrag->already_sent, len);
@@ -3142,7 +3142,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
-	msk->last_snd = NULL;
+	msk->data->last_snd = NULL;
 	WRITE_ONCE(msk->flags, 0);
 	msk->cb_flags = 0;
 	msk->push_pending = 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 09a5e23adca1..21d59b0875e7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -266,7 +266,6 @@ struct mptcp_sock {
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	int		rmem_fwd_alloc;
-	struct sock	*last_snd;
 	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
-- 
2.35.3

