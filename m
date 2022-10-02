Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10074.outbound.protection.outlook.com [40.107.1.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371AF33D9
	for <mptcp@lists.linux.dev>; Sun,  2 Oct 2022 14:25:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7sI7V/yY96yR6ep7yjkeE7AgBp5O6mrW9lD/7RW28IuIQVpBrqSnzMk7IzZ+DFFvutAp9ITb1U76nTySyj8Vx0x6JfW5XpvRW8M4PqCyTVMIb/gHTGrgF/SmB0xkE38/6/gE+2pagK2Sh9n8CZrpneQjNbmbUmi62ZS7FaIYRU9O/2KMrUQMpKdovPZgmOubesc1ovTiGVj9xu8OAmi3tvmfiPf9phk0dsUWcewHpFeG89Eybf4f0HKu19D68sw1+0V1L5PvaVLmkSScqrhmspRSoAEgz+jqS3mIlwxkhO87LYRpykIUPoJzSGvekhq/+gQ7u9roaXLwNe6Wb7tew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0f+Yk9vA/ZIZN7Kpj+basZnNz+yGimYLJKTmcxOvwNQ=;
 b=IcDHzb9p18Wa5RELpIisbnzAiWpCdcBMWrdQf/SCzST+OZTpaOev0P8pO1xo5Itq0myTNHSiCmz122mz1pq4U60DHIY9h3kOHtaBBKvW6pm5tt+HZH4fq6UAGPQ4sJ2lcqYqiGKZsw4hdHY7Fm+O+YSBEXMqcsg/JNBCdivE9WtaKPzA1HHz8roffA42Vn465JNHkRBYKOgsWQN5Eau58pnUQUpp4i4DLgjo/+zzAwm/4/pDf1Rntpmc44GS2ZRSYvNtJxZDGgsdV9h0lsPk11RF5RYWk3Eb7olFRmBYiiD2u/ZWdlIPJVP+ZPPF9d+xTjdKVgOpF+3AKmpzVqzrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0f+Yk9vA/ZIZN7Kpj+basZnNz+yGimYLJKTmcxOvwNQ=;
 b=jufkbm5yGxDY7d0hNILH4ZQ6mMzAF9mn88X7X//vrnCkootefuMQgbv95DP25qudetNtHn7elORz1BmlTozvF/NxxOXQzopG/r3n4+fYlA7diWCTrds6PvkuQlTAYFdLN7Ewrtynw0b52t7g0D/bZcD4dD7QAKKeO3J/ZyRdzvdNO3r9zXoi/l+zuNcp3HkvvFIsqWiF3TtJb/v5BOVG/N2jNgofDty4fXESNF5gYNUgxmqn0oHItinsmbJjhw7GQm6L+EFo1PYoiEFw4QaVMYtBue3D1/Bho698iYaVF8/27T7BcUUcAG8kOGFEOJNlZ0hSUZQVk4Fa4af190zS5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8738.eurprd04.prod.outlook.com (2603:10a6:20b:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sun, 2 Oct
 2022 14:24:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.024; Sun, 2 Oct 2022
 14:24:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 03/11] mptcp: move burst check out of subflow_get_send
Date: Sun,  2 Oct 2022 22:25:11 +0800
Message-Id: <8beaaa2c182775909a6040433497b1b69ef882eb.1664720538.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664720538.git.geliang.tang@suse.com>
References: <cover.1664720538.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b52473-402f-4507-8e62-08daa481e2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dx6wge7KXQk2DVutpKYBLxgHJE6UDZFx5yP6WsCSIo3ULPb0WtIYWD1yiVV+uTp96VKiCwi3/hUDRzjCf3+UuGH7ZaiyyZnNZFdKT7wOagdHvwr8NSMyRnv7Dr/gD8q/9MEUga3XPTuTtBB9r8C91shJnNWQGg2f/+pFwy1sPSf3OAn+Ko4x5OTE1SAwWPGiVLqBU2ORSk9RClU2RPMImAQ+Q5bjiSp2OhKGyM3rPTNOi1Mi98vLkmux9Ited3DXcDu5wXTlC6G1bfe77TIWruncvsXHaZFTy+U938crTLnyoQ0OQZNigvrw1gTlDpQdCEwuPIqN3mAnw8ZMM9g/ReS3jUG8AXGMwKXV02eo3ljj7WT8/JC1yabc1QqGk8DaJt/p/pl7lP3lS7DDmX4zIAHJvHSeAGZUP6R7Ibp5a3Y0fC/xVVzharEkxE284I6tj+hwgLvsDdCSAvE+6pqJAaq5GdpV2DOB2w+c9KMx7uggP3RumnX5Fkh5J3sJ+tJ5q+T/AKbUTfdndgaLYVcHEI8O9X32f8ciPGzibVbVY5gjiBTpG4cDCu3JT4vhGEjgz1W9jvM14mkDH+6JeMMEylZxKwzsRtHfBbSVYHvuw38yicd0dxCX3MnywpKTEQSkWOnl07MtCduHCDpCW8cGhpNr+WGvB+dqRZhOhac9DiOE6G0SdZ0MKi0zl+WhebTkTAq3pwF8MNSpC1d9rbLGyg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(39850400004)(346002)(451199015)(186003)(86362001)(2616005)(83380400001)(66476007)(38100700002)(66556008)(66946007)(478600001)(5660300002)(8676002)(4326008)(44832011)(2906002)(8936002)(316002)(6486002)(107886003)(26005)(6666004)(6512007)(6506007)(36756003)(41300700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E+z987bV4jUW/pUZl80MOwsYy5tfC6LRESSe/H5DmzfHUpi22/UHcsyhMs19?=
 =?us-ascii?Q?TMzk2CW5P8/wxRG1HzE+fJpovg4QdPT4E3+IxyBRR9mmexWB2C4P2IbyRcXT?=
 =?us-ascii?Q?iEfagZwN1Q0aG+1kckaFD2CnHULf6Lxt7yy+8Pm2vGUwczJ9iYJipsJ6nryg?=
 =?us-ascii?Q?F9mNBri13FUkwdU2XwFZQXF+938BSO/K2VkxOzkaYexrKjEIMx03U5GjpwLd?=
 =?us-ascii?Q?DyYqIFY8oZ3/T0zugH3MO3QZ3ruTnwE/WA62Eh9Uq//kL6lphr52wuY6mytD?=
 =?us-ascii?Q?jn8zyZFghDl1wByctvnjezLp4D7I+ZoO/M9EUPfLpvqkDIw7SmM87lqF920F?=
 =?us-ascii?Q?MKPoVSX6GmbTdoRozrzjvhinIX3QvdUvX8Lpc8NPP77NBRfvXLlJ/FdB57pr?=
 =?us-ascii?Q?LXs6lsoNzkhleX5Cq7Q07I7Rmprqf0rQ4j5xrSAFUFPDLTWL3l07RUcpemsL?=
 =?us-ascii?Q?jSigQ12nrqTAx1qqeq04nmRZBRuuUARYnvN/EP2rA86lAVMvPwi3VUiAkeQn?=
 =?us-ascii?Q?TyZyOHtcuhQFvN6VsgxAXkLThpEMRoKhCpKxC2Wv8K9mw4odTT3KSjTyl3Sd?=
 =?us-ascii?Q?mU3Su1AQc+TV4QH25TjYxzIDBajIM7/qVgVdw4kf7zEYFKTVUt5C2RCB86xv?=
 =?us-ascii?Q?VmdNJrMcFa2Ydn449pzaZhgYhTlPR32QbQ4e1+KT/zKiK+cBPUc58DcuDXRK?=
 =?us-ascii?Q?5EhN+ZfrKUvP7VAXYlutp4Y0tlIlNe7viKhujVdScQ4WgWG/UQbUFF3xEis7?=
 =?us-ascii?Q?xlQ2xbndAwAveysgtFZ/OVWfpXL4rWFo5MKJFMUI6IYvBJn1qvd2iLcF/YWg?=
 =?us-ascii?Q?MrvQx+SfaF40yAQmBo4bxMBI6I7geWuZdTVUZCZTC/yLO1LB3IP712vdDbv5?=
 =?us-ascii?Q?BXvplvQFIyPpIWwSTrPT41f5iqF+fh0LbVLlYCcceHaz4ICwQDyeTAL6EEjw?=
 =?us-ascii?Q?kmbXZtu+87s6qlBDVrXX3c1YkM4/G1ulRTC8mLXw0XRtUoPpKD9pZBARq9NG?=
 =?us-ascii?Q?HFe9cZflU+VmtQC8m6v9yww22Dnwb9Yykl5abZOUb0/oASsr3LlLX/lJYiom?=
 =?us-ascii?Q?cCubCl6WYtJCkMO3ir6oB74U7w2Fj0W0aU0MtOqOs/Z/k3g8EhULOjkH0u+n?=
 =?us-ascii?Q?VGcWpJ3itgs3PZnZt3GFMYwhfzKBquin1eb5erNp5HDBPlbZUnlCrzq2pnia?=
 =?us-ascii?Q?QJnIePeXNKO9PP/eD0H2wkJyTfM3wZgSdVpj8QwLFGrFZdnNr445sV+zKMbV?=
 =?us-ascii?Q?9LjFTmNn5GREPVwqZG2dseFRKYTEAoqUd+cjgbppd2ddoRfknJIj33l/Ftni?=
 =?us-ascii?Q?Mn6DC9I/A3X7djxS7bsj7iBPacpQsNqvPqaxr4UpvgcBOm05hqsSLp/VJD0n?=
 =?us-ascii?Q?hqpgvREUVqzYuPP+fy2LayvyNz4yiqla6ETLSnwrzf9fmgsvzdHKyd23LOfo?=
 =?us-ascii?Q?nSHJL6fT9H1qsBBv+TJshZgpKoRblgCPgeyn/90goBGH05FSmz6PZS0tetFm?=
 =?us-ascii?Q?+DmmUFqk//8X11uKtZjDOS6b5/ALzEBF2cLT8UzIMJfO5bSqbcwSDOpSSd+G?=
 =?us-ascii?Q?IoRnQ2ggbrHZ+K+GQXrP5ZptnxFZAET/gufT6atI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b52473-402f-4507-8e62-08daa481e2cd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2022 14:24:59.0142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxM7s5z70XLvFahX/74i1PW7ZeskLKeYyAl47r019kmroAqnD9ckWVNqI5w9rhviyBCmyE9BltnrQkJINTKnRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8738

This patch moves the burst check conditions out of the function
mptcp_subflow_get_send(), check them in __mptcp_push_pending() and
__mptcp_subflow_push_pending() in the inner "for each pending dfrag" loop.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bbc43212a20f..785c52b738cf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1417,14 +1417,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	u64 linger_time;
 	long tout = 0;
 
-	/* re-use last subflow, if the burst allow that */
-	if (msk->last_snd && msk->snd_burst > 0 &&
-	    sk_stream_memory_free(msk->last_snd) &&
-	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
-		mptcp_set_timeout(sk);
-		return msk->last_snd;
-	}
-
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
 		send_info[i].ssk = NULL;
@@ -1477,16 +1469,13 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
-	if (!burst) {
-		msk->last_snd = NULL;
+	if (!burst)
 		return ssk;
-	}
 
 	subflow = mptcp_subflow_ctx(ssk);
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->last_snd = ssk;
 	msk->snd_burst = burst;
 	return ssk;
 }
@@ -1579,6 +1568,13 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+
+		if (msk->snd_burst <= 0 ||
+		    !sk_stream_memory_free(ssk) ||
+		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
+			goto out;
+		}
+		mptcp_set_timeout(sk);
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
@@ -1637,6 +1633,13 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+
+		if (msk->snd_burst <= 0 ||
+		    !sk_stream_memory_free(ssk) ||
+		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
+			goto out;
+		}
+		mptcp_set_timeout(sk);
 	}
 
 out:
-- 
2.35.3

