Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2057.outbound.protection.outlook.com [40.107.104.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B651323C
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 06:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyF4hBdgimz/1hWDS+GLt5FzGslZ3KZSd6KXJctVMUOXP8JozAxy7hIpMjqO2OFzFMXN5r7zdOPVyHil1zR0OSGVKa6CGhOX0hwtgOLyFGkj+FADkNRQqPZ/YbOT7gKB7LOPb3aeMyRQZ2lAys3lBsUGqeKvu6i9NeddTOHgNJoAK8rW4UDwjhLXPAAw8m/+O6oaWUsAdcPTC1b6jHiQ54fJqcq7AS7XJxcFnR+8SBalcppEcuDc3Wy0acecaz6cY7iDHJFEi1jUABWc7J4l6O4aMGXAQGptqz41WFGyYdW8eYJLhqrQfGXREAJxCWDV8YUmSHz8z5ERI2WdNxKuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mY9P7jrKiUJPYjNOq00RFu10IAUuOACe1NVfhBehyg0=;
 b=O94ZpkWDLP+JILRb1Rshn27KJTERlpL+pgnYkI7Mz29ngtCncHKPm5VifdbhcL5FjigjBHkbrUJBmH4l9K6nQMsQizxKaRmUtd9Izt28Lc1vQioE94QoGQy5oFqJX4rm+mjfDeo1pv7GzxCsf0LZJkJrn9xHQ4BhdqzJWfRhU66PVMwFkuPqUY+c1IfgasQR6s4iHtgI96gm7G+qr103hTIrV14GvMVeV25PLlfk/yLjOZpUG1oytykhryF8LMGgBrBETgEARrjfe3s2UYcaP1X0e1kQ9uFwO4RH9r25SWRUEm6wN5RDtkVt3CmyKTpAD3w4+WRiSIKAoK2PnTAgzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY9P7jrKiUJPYjNOq00RFu10IAUuOACe1NVfhBehyg0=;
 b=48dQDhDd4A2gtPFsOdrp1r8D17ychxPDM3eErZnqYvy1ogqybxBZ9RDMdCLcg/sfYeOiFiVwPpgKV/BOcW6Nh0a4PhS1LxD19Km6VIRa6ARIzCBobLgauJYwnIiYPq5bQBl94WtB0AJE6h2pC9uSS4KJozBbtKGiraF9VKN6XCvZ0rdr3iqpuvYTfH00gA51UgA+6lV7KEITjxGyl2N/jYWWXgJMcnQKIoAtvrLfU2PBzOMkQ5qtuqf4J9ijI/HR7s+5wMyr5SGAC1JFAcWLCAhIGs0L6MDvfqXzi/qIer7grYE/MpEDkwnXMzoGNale2tWOhktMou4hpNcJck4DTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 06:45:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 06:45:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 02/15] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
Date: Tue,  8 Nov 2022 14:45:01 +0800
Message-Id: <72805e221e6e1ae59e3f30adbab4dfbd9f7f6de9.1667889809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667889809.git.geliang.tang@suse.com>
References: <cover.1667889809.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: dd197588-0fe6-40bb-5c95-08dac154cb15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QEV+WKTjZ4AdI4dCfv8KnZfYzAY89QL12wQcLTfb+oB4+QmbbNTxdaE9ThCV0lajh5/7Xp0XTYCU4CBW3yKytmOiWqu2G4haSWbgSH7aWjfC/Brv9uGa8DK5RpwHgca2EKm2EG6HnAqHYPCJM+BYNHbMgBJbf8CB8m2QLDYGE4xS3GqxnO9jIaAdLjoATjoWdkMQEmffImdMWf0Plej+SMkcwlsKcr6OpvqdeIveMFM6V8soiKMGwYhTmxdGVke1VUfNVKC9cMK5j988ENmSjHdH0vkG/6MYZpmLTUvroitL/b9RE6Cb1ojkc2+ppOPphb2XnUtWU49ucIRIkrLCeoNK0OXsBJv+KgkseoNxb0NMzppY5C4+f9vlrxhqa5SQ1hNtVd6LUnDWsH7LXAeDLpZz4E4+jp5ZDAy20rR8Oh9VI0LtsklqctZvSowpaTpEa+7/DTNq+vgdicI5pts70AfeTbXyaCFh6g8rAqYzqmDH2xikeEX1u00fhnIAEB1X92AH8BoGXWKNs+qMPmU+QJf1PDGedZEeomUJzGSdmI5iJJPBFSvE/B2QwBnDzNeN5J4xwvNjrskhkUPU5ta7jQKh5yuOSpUhg50bTZdz0aGyGUp52YEVETWubbF4W4cwDk/4HkG/harRpnsjl6FlTVfnc9xZnu0FUyTToPQvWMVi0E1ZBZb9SmQvKD/lXYxyAfXL3+WywpfooL6hbVSeIh3XHHQs7c3Rx8ZLgQOIPkuSEyQeqte2Q1aZNlF3lVJ5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(44832011)(41300700001)(2906002)(5660300002)(8936002)(86362001)(4326008)(186003)(38100700002)(2616005)(83380400001)(8676002)(6916009)(316002)(66476007)(66556008)(66946007)(6506007)(6512007)(478600001)(6486002)(107886003)(6666004)(36756003)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OoL8sJRGvRtO76BL0Q99ocnu3114uiEEHqzUq/Elf1kLEu2IJ4L9IPPVNAYg?=
 =?us-ascii?Q?dCxFFBYyWh9xcX9CH+sLOgeDxcPcaISaeJz05sljd6e4UgizMA4Ybx71DWLw?=
 =?us-ascii?Q?hUdkMb2iEF8q1+phsVnXIAZ/+v3xqfXML04cEhxaopM9Sws2JB4DYn7YT1D0?=
 =?us-ascii?Q?h0WF9/la002Nj1GOft5ivvomFduoAV1tWnETcEa1aH0tnWGtRytFE0XG4tK6?=
 =?us-ascii?Q?LMxSNEAmtPzeo8KV5vBGbgeLrEaQD6HWecC7/6D8QI72i+c4PAbAj6VaOcxo?=
 =?us-ascii?Q?UQbUNVj+BIQKAELMmY1Db49pfi/EqqCn4smwsVu8pot9nECqu14QsUSaPaB9?=
 =?us-ascii?Q?zldsj6I93Hc3NU7jDjAtnOE/J7xTF/7ntGX9QBR4xOPWbzRpxa/weGTLFlia?=
 =?us-ascii?Q?CM3/9gUhu5THJ34fhriXJQUeZDWhVKbxmO7wd3RcpbGl5d5+ZKp9htdsGxJ+?=
 =?us-ascii?Q?Q92eLH8j4m1cmoGa1fAQjZN6jy84EjDUErLUJXjviT72vmIFB51s5YXVfsP2?=
 =?us-ascii?Q?TF34qJmG6vB8iWMXwp5/id+BLJOTLJqgse+XGckCuhnxs+VUHQpKqaDq/1X+?=
 =?us-ascii?Q?EJ2Rm5Gvm83vF6hc+6ff3FKIDw64aeAtqxR8j5q5xK82xXT3CKgGHC3v8Bvv?=
 =?us-ascii?Q?EikxRN2YoWEtFkxhSYOxK+T/f1p5gi+kFsoS1lNiUHY1uEWnEOVM63obrVqj?=
 =?us-ascii?Q?imH3ULFC9VUwZb9rQzZBDm8VonGSQMnn54+uwy0l9TZF21FZpf9zZ8VwHXIE?=
 =?us-ascii?Q?eDGRawoWwXlURZEqNrurf3V7I/bzforffXVI30flCz0B5hoGGO+rl//TaVnt?=
 =?us-ascii?Q?Ur74DKXTdbZsEjFmRe4ER2RIH/V+BxS5HNvOpPNqpOoH3qrwan7ZMDPS5q+2?=
 =?us-ascii?Q?A64aKHugQoKc0O9HhY1sO7XYeEc+RW8Pm3AvfY1vLlsvO6YtjFr9zkSmrLS2?=
 =?us-ascii?Q?tQfhYKOk7PZ7fBLdDjUQA+UVRbOnlRYj8CwLyMBO9TzF2HX7Wc89x2Ur24GO?=
 =?us-ascii?Q?BMNHUKIcWi5+Ev6WCXPW/+OgdADODwgcmOKaehJipPJZAe0PPHdFk8qGKQIf?=
 =?us-ascii?Q?ckoXGKcUPbIQ6WrBP/Os/bRM/OyxkzSwJz2Sp/MgVR+Y6gr08vtD8spHOEuk?=
 =?us-ascii?Q?IFbA7fF0twNNme/jm+uwX1YX+E/g54nf2aU5klTS51esSlvcr4KsFkB9KT17?=
 =?us-ascii?Q?EOGzUUFLkI2s0csq27bTFG66STFjCRrMNkMaFbz9rQIwlzVUK9e8/o+NucsD?=
 =?us-ascii?Q?q+MLbaXxbLQ9m8jz3nmw9ImYA8hrgW9cUOBgQx+EERb4Txx3bn84dAhlyNav?=
 =?us-ascii?Q?0lop0wGnSqWKMFgR6Hb0kU9MYxBE3gT8SUXssK1u1e9BxUK/ktuXZJt2XPC+?=
 =?us-ascii?Q?4/Y1rUYO92qeFWsj89rDuJ2r18Wzlv8z8HNtaOYeuXOGcIcre9SPip7l79dm?=
 =?us-ascii?Q?KVSAApYu6NPR/N2ak1tX3aYM+t5Pxn0UiOIRFCjzkyKY+Csayh75gllqDOYO?=
 =?us-ascii?Q?BwN94/EDknZSf5PDnWFu1hs9IvjVFWD46YDUZDsXDatx/fXoLJqnG6k/zrwO?=
 =?us-ascii?Q?IQuASPRFNkgXD4vM8GPWD5wQM7rnmIDHCk0x5R8v?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd197588-0fe6-40bb-5c95-08dac154cb15
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 06:45:15.8372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jkGSpTi9EJgGixO5OjVyRYXnIZUvpXEJR8WZSXnMlbeYpTHD1gcdb3V7RZEEgWI4w3ez5qM7m2zYFPvsGLRAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

Drop the useless msk->last_snd and macro MPTCP_RESET_SCHEDULER.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         | 9 +--------
 net/mptcp/pm_netlink.c | 3 ---
 net/mptcp/protocol.c   | 7 +------
 net/mptcp/protocol.h   | 1 -
 4 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 45e2a48397b9..cdeb7280ac76 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -282,15 +282,8 @@ void mptcp_pm_mp_prio_received(struct sock *ssk, u8 bkup)
 
 	pr_debug("subflow->backup=%d, bkup=%d\n", subflow->backup, bkup);
 	msk = mptcp_sk(sk);
-	if (subflow->backup != bkup) {
+	if (subflow->backup != bkup)
 		subflow->backup = bkup;
-		mptcp_data_lock(sk);
-		if (!sock_owned_by_user(sk))
-			msk->last_snd = NULL;
-		else
-			__set_bit(MPTCP_RESET_SCHEDULER,  &msk->cb_flags);
-		mptcp_data_unlock(sk);
-	}
 
 	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, msk, ssk, GFP_ATOMIC);
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 02469d603261..b0b83e03a4fd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -475,9 +475,6 @@ static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_con
 
 	slow = lock_sock_fast(ssk);
 	if (prio) {
-		if (subflow->backup != backup)
-			msk->last_snd = NULL;
-
 		subflow->send_mp_prio = 1;
 		subflow->backup = backup;
 		subflow->request_bkup = backup;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1ed23b1e6c51..3c38ad7279e6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1478,16 +1478,13 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
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
@@ -3293,8 +3290,6 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_set_connected(sk);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
-		if (__test_and_clear_bit(MPTCP_RESET_SCHEDULER, &msk->cb_flags))
-			msk->last_snd = NULL;
 	}
 
 	__mptcp_update_rmem(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8df6d95a3247..e93d64217896 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,7 +124,6 @@
 #define MPTCP_RETRANSMIT	4
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_CONNECTED		6
-#define MPTCP_RESET_SCHEDULER	7
 
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
-- 
2.35.3

