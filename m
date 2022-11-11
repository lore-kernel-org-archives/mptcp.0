Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60078.outbound.protection.outlook.com [40.107.6.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4BD6D22
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 13:33:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knlJAPqujKY5aVMqY6G6TwY530pQUYYY6ejoD7m5WoP3gHAbUIK5gkOoJ96fRz0zflDSQ0GZ3IysX8ZgfIFRZB72yRiBIAZPyLQhNQ90wYoSxTJ2ImjwomUWJUFrU0w7ZcadMG3kWo3rUyAZZF1plKk5ilr0qItsCF0gMGoHweEObVPKAnGy4UbSjHdZ0YMVMWS1OlPI8PpW0ukrrYVyJabzD3IbhpG5sI6g+e1jEdlx445bqjtxPe+wiLeh0PfLqtHSKoDTT/+mOZvvsTOI48Bm4B+UrZY1IBNL+p5knWlp/2so1URsY4V4H/epXdEf6oE7qS3R9H8D2PAbhlYTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eh8+5k4xR7kcBanm06ldffglzqHVTEHy5txr9dFNi6o=;
 b=j81Q9U4gyasuiZ1v7DJdNjnzBpDfOw1+uHQ0e5FcGF0QeRPd6C0E8T9N38IM0NrheTp2ogo3r9HBsTxpKTAfkwf+0+O6we0yCJUr/sJ2zvRuQysCO7d0WjoyqXcNn70K8JqMOxv79Stt9sbtji+j4Eu/0mQseSR88SoYtXXFZeRZfalGVfLKC/LfqbLx2iOEp6uxnawd2bggKFs2y66TpI69a4kn4uNlifk/CjUJlEyZyA6ceu/ZiTOAq3nWyeLE9OFs4xq1k61eeE6qtYNubebhBW5LipH+oTdJu5MMJzSBH+ToOPx20l5qvffinGYIduWZxhfLg75PTHEuwTAxpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eh8+5k4xR7kcBanm06ldffglzqHVTEHy5txr9dFNi6o=;
 b=M4MRYz7SQeGWQoWXI+8pHDukFOJyhkB4lgz+tdv9NrJ5WM2O1uEUWgNIJ0Bc2iJkQyeeFMYgA4Xj8PIVg2v4/A+YLn6JuWjFSC6oTnCHWkOQlj7H+ABqWvWAaVkRlTScPQGzL8EASeioFCPkOTCgBdGocTSjfktMMjBimhhNdcmTFKPClknD392Pow7sZAVqilJh8WGVHMK1ixTDkSmaiYUEoL4z3NnU8taU2lk9ZTHmvPDGdhHBN2YgVJcmg8eJkfh1JdFzavRAQmtsRaXr+cyteNQwtFrdNVFo/lo08lurDdp/nVqXRmTGtWSGg+IqYCynOYgsEtrILGylI6tYyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8327.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 13:33:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 13:33:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 4/6] mptcp: delay updating already_sent
Date: Fri, 11 Nov 2022 21:32:47 +0800
Message-Id: <e5288bd26ee1fbfa91024c5be08a2367a1b3f04d.1668173360.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668173360.git.geliang.tang@suse.com>
References: <cover.1668173360.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbfaabb-a08c-4dbe-07a7-08dac3e94533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IbIeXKT31rvT9QgxMGMJxbn2jMt0QWMhV0Z2Sc6ZnoIudvKcNRB/vk7IB4fhfEnc1TEsLwpl4mUW/Aa0ccRqdiSW6/CPvpHBkNylS356SUW4Ns7PzR3SU2fXPdu3gOayHxfY9LiKYyyGZqTysFv96woKBTi30u8LMW1zGe56pkXXnfKi8qoR5vUOuuPtjoJNfvjIXmgJ6Ga+BduP7q+pku8YT7gATz7widZh+Ur2EEp7mYoQv72QQAcgtvqMTfrro8T4z/BavcDC2XeLd6HDinVRg9oN8kTe6EZvUIsJWbYYlsn8PnOSK91lILG089aOfwHDb21ASh2CQ5TFwvo1VndGXxQaWFNoLnK22wk1pDPBZoCEgF6ZMO4xwrQu7UPS5fQW41iLMLzJVp9UsxIDoH85ZjEFUdkJSsP0LMjUxI3ROqnQgjkKA/G7W0rkd5CWFmylZ4bxtPB1dt+sh8pzHVpPWkfrQ51evjEa3XGzwIYwBjpv0ogGqIfIU+pxxtLgIeHyMGqstiv61ItnwreNqFz6gWC65Ob51ZtSry+keBAgRt/QSrGUZwtuQsWtwPZAgGNFaQXio0IZMy6zzwvoHfUzd/mFuqJsMQeeMjNsYhj9hMJE+W6TrRX6+AyXMOAYCu8Mjq2U2mw7JLYNL1FG2g93zh5Tmxp6lHZLay1L66Os5TrFu/Bma5v1A/P0I6rHOQw/9E3pXIUOrLq/t1H4wA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(38100700002)(5660300002)(8676002)(66556008)(6666004)(4326008)(41300700001)(107886003)(316002)(86362001)(478600001)(6916009)(66476007)(6486002)(8936002)(66946007)(186003)(2906002)(44832011)(6506007)(83380400001)(2616005)(26005)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rix9hQ2WnuFsJ+D0yRf3Sqg/pWaIfwLRtdE7ViQ+fPiacdXzr1APzUqM2RSp?=
 =?us-ascii?Q?iMR+EuW2mRS1wo0cfrlLzKGEpzIcPSUEV5bs3Rkc6OE/aMlI/I5Ljl0T2GwV?=
 =?us-ascii?Q?UaGoJRV9Gpml9MW6xpFppl8CzjBh+rq/35h8sCLoVIVdCcOi1MK5VMxcULQ5?=
 =?us-ascii?Q?YLAZRtpHCzWdz/mgEI4dv5ZXK8MNZUaCH+XUp554scUrwUwvP3OpeoRj1BIW?=
 =?us-ascii?Q?a1WGJmTneO7zKDm8MfEY2zv8yZQcwekz8L7YzMKJI4v7HeiPYJ0raTop/vK8?=
 =?us-ascii?Q?FK7Na4DhILg/qwsoEe/3u/VfUzKrvN/ChJxkGggq/rwr/vcg91chr3iOKm5J?=
 =?us-ascii?Q?E2xtTCxBPEMkVr8OwphPBBbANQ/XYscX38c5Kkf/3p3yg5hxiM7MeUAjMLVu?=
 =?us-ascii?Q?YuJBic0RB8lvgPwGLZP2aXxct4e1MkdQsBRSO+8iZuOWBu9AxjS/GcuxDVNo?=
 =?us-ascii?Q?2evPFpXCpKvSeSWJAdRZDpADZRiuuGCE7DKkS5EQnjvDURSGUuN7WJNfwvR4?=
 =?us-ascii?Q?+eF5LqtqtqzDd9//kWGHXzgmTyP8gRibjN+6sA5cXpBewA9MQIA7XFdnWJo/?=
 =?us-ascii?Q?6VbZSExgdLfJ1UxQt6RyDCG9VgcSH28IRJyLsjUqFyZUqI9KU84qRjkW3pxJ?=
 =?us-ascii?Q?dUpgT0LLYCdnKNTo0MLbO6NuLwxNwMgWgcAzNtjMFqC9ZwMhWMqOoGD1J0s8?=
 =?us-ascii?Q?6wAD5sDFnWWwMBD7PK9vVknJSM9bbAvFAFg3hOmEitOb4eWk88Pez7KBMIMl?=
 =?us-ascii?Q?tt67kFOqPN+a6A5bCXUzcxZsLEqulEwCSiIPv7yLZT7L7C1KaC4sngcNDBui?=
 =?us-ascii?Q?ybdLpJ02isJiQMxGuebeylp/OBQwnZYhPJprapsGWktTlDaeDbWq5PWOfC2F?=
 =?us-ascii?Q?l+hXYv561cPm8WdE/dDbg5yaXp0vyOuCsE479V17VwXrpq22SEnDPQy+6Ewz?=
 =?us-ascii?Q?AiITAb5b4hAgEqiSeJxkrr/2EgaQ4/A0b+O0qVV2ckPSX9BojhYannGEw6Qm?=
 =?us-ascii?Q?s7lcROc/6QAdpPQSjz9zA0stuMVlegCUbP3Iu4ZiSA5PXzqi4Cq7PEkP0Oiu?=
 =?us-ascii?Q?a5Nu+2ogsTr5FLzCU5W1TKjT4LvIoAhWtPr9RJ32cRZ1eJ4aw9awPlbQFhDE?=
 =?us-ascii?Q?658nO6pHKDucuedqecsM8xRuoMB48a80NJNQg7cwLD31tplhBSiGscYU70t2?=
 =?us-ascii?Q?DIog43uCXKCJ1PEt89O605pojxCV1o8kMrIJTofP1pVtQUQur6GU+5blz9Sk?=
 =?us-ascii?Q?x2MLz2TF+lLuxXRa+TtXTIWiasiNVt21hVuLTlSbSmc6G3kiCi8vv/Gt+O4P?=
 =?us-ascii?Q?VsUMowKGvE1XdGX6r0rA1HbXKA2pqkSI/OmYi0MM1KPx6QnUb+mmgWxe27uI?=
 =?us-ascii?Q?2w9AnQaJLASSYNKxyeFB4xVqslunj09V0HZrAxOKtYtYVwA3e5Qcyxrm10Zr?=
 =?us-ascii?Q?rBE/ygrATd0ua/DlTjcr9+RgA6KJS909Q6goz5vmb7KH3tBweSOJkmxZQPUH?=
 =?us-ascii?Q?OnunuLScNpPwqbGhDW80MLehZ3g5ul9cHXQkCT6bz671hOIE8q0JPnUo5SyQ?=
 =?us-ascii?Q?m6oOl+meI9nYjlO3BEQhTY+M3/2nemVM0pBfG19IToIfxna0vdeQXPfzcZDc?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbfaabb-a08c-4dbe-07a7-08dac3e94533
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 13:33:08.3052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQrhKqqBaVPOfKvigASRFdJ2+YaDhYTJgiFKJn5GhKAiMODr50jq714jKXCHbfUUfzJKYlxqLnJImCTwxH2Olg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8327

This patch adds a new member sent in struct mptcp_data_frag, save
info->sent in it, to support delay updating already_sent of dfrag
until all data are sent.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 18 ++++++++++++++++--
 net/mptcp/protocol.h |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fed825d0fd06..c3704336a51f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1099,6 +1099,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
 	dfrag->data_seq = msk->write_seq;
 	dfrag->overhead = offset - orig_offset + sizeof(struct mptcp_data_frag);
 	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
+	dfrag->sent = 0;
 	dfrag->already_sent = 0;
 	dfrag->page = pfrag->page;
 
@@ -1484,11 +1485,11 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 {
 	u64 snd_nxt_new = dfrag->data_seq;
 
-	dfrag->already_sent += sent;
+	dfrag->sent += sent;
 
 	msk->snd_burst -= sent;
 
-	snd_nxt_new += dfrag->already_sent;
+	snd_nxt_new += dfrag->sent;
 
 	/* snd_nxt_new can be smaller than snd_nxt in case mptcp
 	 * is recovering after a failover. In that event, this re-sends
@@ -1513,6 +1514,18 @@ static void mptcp_update_first_pending(struct sock *sk, struct mptcp_sendmsg_inf
 
 static void mptcp_update_dfrags(struct sock *sk, struct mptcp_sendmsg_info *info)
 {
+	struct mptcp_data_frag *dfrag = mptcp_send_head(sk);
+
+	if (!dfrag)
+		return;
+
+	do {
+		if (dfrag->sent) {
+			dfrag->already_sent = max(dfrag->already_sent, dfrag->sent);
+			dfrag->sent = 0;
+		}
+	} while ((dfrag = mptcp_next_frag(sk, dfrag)));
+
 	mptcp_update_first_pending(sk, info);
 }
 
@@ -1539,6 +1552,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
+		dfrag->sent = info->sent;
 		while (len > 0) {
 			int ret = 0;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index eb3de51ae1a9..5620a3eef9e9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -250,6 +250,7 @@ struct mptcp_data_frag {
 	u16 data_len;
 	u16 offset;
 	u16 overhead;
+	u16 sent;
 	u16 already_sent;
 	struct page *page;
 };
-- 
2.35.3

