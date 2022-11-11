Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2072.outbound.protection.outlook.com [40.107.105.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE55652
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 07:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erMtyDxEbk3IbzNc7ZZg8mVooP8KJNGfx2F+Ehsmvv8TwCfYIPZRoMxdAqEpKfaFt/ct4EoVjc+AwbQ39xnENV6HJ/c2Qz3gh2dS6mNEvr7u8eFCrzXmDTx5SzYEGgXzikUXPbefTxB2c+FN1HC39istl062kHVEFmhU5mnWo3hTntiNbBNMOuWP80zjfFsaFfUzXx0TbXLc/OLTdEYuq9dxecwpzkyOw8vU0V5aEy3erPbKdts3pDKV4GbN9+TOiImuf9eOG016AgYllIJ3lfC28Yczwi0kZle6haDpnTiqXs2IFdrA9T5DZDfL3hmsMfheO9idnHXmmEoNZQIdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKrkdCE87NzU+XdrELRcXHVhJvKWasTkIYQ0i8XCnJI=;
 b=e/sOmK9SrSef7Vx9/OyeV4m81/Q3xVFU1DLpVK+O0pLDift8OQSNPjUjVOFqOvG51OBJ7LPi1ujjLuGkq9JkhsfsnfV0/eVNdI+8VuNPjUMEuriey/A8Mgz7S6V6aoqdlbjYCGSDfPQ+TkX/JL/E2MmtIFuh7hj+MRI1raAqWhYpmjQM19BIDqTtEzn0PLFksd3gZou7dTrpPIkT7dJIHqYjBprvqvXMxWzgEl11TreEKwRFNsWaWj6ZuAqaoFsuoMwrfrShUDKEcbLgVHIGkIQewqe8q6584yq+clHofgS5GObJcLll4qrIYFd/lwHqZLg04lb1e9JlvpQs4cTMEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKrkdCE87NzU+XdrELRcXHVhJvKWasTkIYQ0i8XCnJI=;
 b=p9zRdMqeXze6MQPa39wuBQ+OJw4lu09khcGfYUI/Q5CAflt0BJfQQAzC9w4XMFoitoWfhuTf7BhtTsu/Aucv82bv7EdP5ZDQ5OFwjkmK/iEJ4IXvPQg+sWF8xVEmLiKFDWDINc4LZjDeArgzgDDiYZWdKwLqBv7mClxrKGTyLFvvUoCt1rFoNohxJreTQfoh6YemwAcHfjo6hi1ZVsBpgcBZ1Kbpoz2gph2ZNSBK0I9mV/RAZynWJTvkKdxYQlBdwWeLr53F27T73j2m0C0bB2MA9uWYB2Vtw0tPq/Gbp8d5XxQFPAJ5SOEynCnzUZPr4+0Oaf+7RAimcEXCI5FiXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7521.eurprd04.prod.outlook.com (2603:10a6:20b:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Fri, 11 Nov
 2022 07:48:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 07:48:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 5/9] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Fri, 11 Nov 2022 15:48:00 +0800
Message-Id: <79113cb8d3e8377d997b9da9e595256397916aeb.1668151131.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668151131.git.geliang.tang@suse.com>
References: <cover.1668151131.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: c515a765-f01c-445f-fc19-08dac3b925c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vunZnGhqNl+n5x5Jsq/M9MYqVSN5zF5zkPiShWBB0kEl4aRghb8FMNSlgzbbeb454jfgJ7bo5beJ6A1ubTwzwUDvDbH0ta1VO9IzRY0IOJDDuJl/kpjXans6VPiH7Gv+/G3SpFeRKp+sJFRSTxwDEz5LhCtohGxOqx2Mcz3Y69YceNolqpqGAoHmEfng/W/QYiu9ZjXT05oX4Gr4ZjHMPpYGETKseV0FTQL4yimp1AfjWZ4/65Jv5LheOLk5vMdK1BpngTl1KP+wXojYl2nFRDK841aHto8fIXX2L7F6cnKBfQnHOSfRuqUvmYKl6Dyd0NReQPFeMPERVgCFN/YsFjFqxudwadv/ius8WVAO2UuhgcbZX0ivpKWoxW8x/gZA93cDUAyaneAsGkksACujM3Yu2DlZW+Dyqs/0EUZnS6ODjUHa6FvWQuVprJNaIPtVTdN2zk7Mlp3zBcZB3Lwh6m65e7rbQEQYqoVcGlpKD/uqJyru0B8DmH/V0V4gZj1AgmA90of1XGjFoa0pFLhtEqSKoeok1BU7+/pz0DtMerT5J5AJE9mfE0Y8j/Lv4noGpHCHULcZ4nlKO1YBKZDjYgpPF8Z2P45/mIoQ15EXC5vrRoETumT6isIGpabbB4YD3dvYMY1he1+r9k/TCNQ4wpoNVEDQ8xRtA9XFY9ZNvinGzJgMApM3MyF1JS6p6yozyQman4HJ2jgmNYFh2im4Vw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(2906002)(86362001)(83380400001)(38100700002)(186003)(44832011)(4326008)(8936002)(6666004)(5660300002)(107886003)(478600001)(6512007)(66946007)(41300700001)(26005)(2616005)(66476007)(8676002)(6486002)(6506007)(316002)(6916009)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cOiaQjivXJSOw1kE4ABn4UYiZOfgAIMbE7LIfhfJI9mchUuROknUwqW3i8Xg?=
 =?us-ascii?Q?rP0+j4ORc0kNUn3DEybAjN7ROf/du6Upv9VJPHBk1jQokOJkjvDmnXG5CL/z?=
 =?us-ascii?Q?AZRoYULSsqpbO16KHMovV4mvjaxPLWRqG24ZmyBM7X1tPL9V3vH52ZrlvKST?=
 =?us-ascii?Q?KAIIPS+1dsZarQ8YJdWU+RoA+Sabc35/Fr4X6gSFzl0LphY4rIv0V/t9vZpO?=
 =?us-ascii?Q?VMmhOHf8PN26h1ZYV1Cl3VDRCWVBbsHTAZ/3jDmKfnfhnU994zmoDZkWuYxm?=
 =?us-ascii?Q?8FUZCHLtuXW2m7qWQ9WfUN5dWdg58dC9aqY1EgZFUrCrExpEGaGYjnKP4KB9?=
 =?us-ascii?Q?uhqkGXjKGUzzUJCmzMYs50gmwOPfvMf9sFQJU3fLBqTP8uqmWOyVCJnSnCLB?=
 =?us-ascii?Q?4iozrz4/bH+rf2K5YPLovwt4bLS8DYhB+cLk+IEcf5Vbrx+aWuKNS6D2K7F0?=
 =?us-ascii?Q?mW8zm8fJy6zR8bJMO/w6Qe6CKd1+R6zeCJNfPjsS/LYKvQrJ1CedCr27mfnC?=
 =?us-ascii?Q?OaLzUAkIyRJNYD3BFRvnTMIkJd9wEtteNkzu9PUIQWTWf2IJdrIja8GVrf+3?=
 =?us-ascii?Q?NT9AGq/H5DQBSO9r++fdfTOuPNQl6dpqIcN2n+uquQxptruJVmKGEYcGWCC/?=
 =?us-ascii?Q?rzLmd/fJ8v8H0XD4ty4w7/JeK7BA3Sro2ilDk4f94Zqwtq7nzCMSW8NT+3S2?=
 =?us-ascii?Q?qL7HsHzGkrOfh/m5l9Pch5V+fx+V5d2JF9y4E74aVzdx0EChkAKpke0/2ki6?=
 =?us-ascii?Q?5st6ctsbwZUoublGQH3D92cKzund95YD0f3pR7FL7Hg5nvuGc9WUocpN8ITG?=
 =?us-ascii?Q?JNzXB2glqUaAD8OcfiKcYpO4fCHSlt8O/dKAYhcWctnfdMf9If+kCl/Yw1Jt?=
 =?us-ascii?Q?b3G/ZWP8YmkoJV+Y6kSxg6Twjizqwn2PH2WtmXFVqiWEJHKO0CNOR4bGbGp+?=
 =?us-ascii?Q?YzI5JBNrwyLiVGx5jUGBTfi61nIBKS/8cJUkm3TiTF57cLj/KVTk6QWMjZox?=
 =?us-ascii?Q?iA6SnWBYjz4HksL0AMvm0rf0u01S9S/dDeV9qDAxX7+lgBope1HhGOFPn60i?=
 =?us-ascii?Q?YwJ7gQQcr4hyjEyBxtSgRzW0EUBeciCPsJn6/TmoulaPxXkmro66Pe6z5QEJ?=
 =?us-ascii?Q?Ncu04Bc9WSYXmTnepqRJDzA1jYy+e5120S/3NlWYMmrP4nf2VhlIqUIyA/hY?=
 =?us-ascii?Q?cbcFbSEsMmFRXalrxfy74ZOuw+B3jCx5AQK+e2n5F9wXNY88HO29t9fd8NoU?=
 =?us-ascii?Q?lgSHd0dqe8Ypfm3MajE7F2YhRvsV79jc1mnk6+neJlSafr92bUjZNu3lnWt6?=
 =?us-ascii?Q?mbuHXo0xWLJ0INj5yCc7tF5fq3Kr/V3O239TagmAJgxwHFYSUFkXt7p6wBPi?=
 =?us-ascii?Q?gJTk0tc0FR5pOlgCUIbd1OPjntaFDTU6aXpxFkp59W05GbIjdkhHXO1rAUax?=
 =?us-ascii?Q?9zG+Kvoi/H4mwkgKir8HCZRwvjJj6Ew7myxRua0uO13/3Ux/OJK9td/YV/AB?=
 =?us-ascii?Q?f130OUX8Ev0WsFvBWfj8jBneE/bAo0DT/XTzBALJfyyakhZCCTBU/HeQ5fun?=
 =?us-ascii?Q?mlO7n0h3peQDTZmYl/KF39vT9ukm50H1XyT3pQIzSA3R/DGbpapmOlajrg/4?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c515a765-f01c-445f-fc19-08dac3b925c4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 07:48:39.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWgWlvwFZudc9cvo9ZO4BT6KHH+ECCFZtyb5wXn4c2CgVVWOh7jGhm3bWxhPumKXB9iUsaPoiVpI9QjZLkXf5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7521

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index c7d4a9a69cfc..72c618037386 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -249,8 +249,10 @@ struct mptcp_sched_ops {
 	void (*init)(const struct mptcp_sock *msk);
 	void (*release)(const struct mptcp_sock *msk);
 
-	void (*get_subflow)(const struct mptcp_sock *msk,
-			    struct mptcp_sched_data *data);
+	void (*data_init)(const struct mptcp_sock *msk,
+			  struct mptcp_sched_data *data);
+	int (*get_subflow)(const struct mptcp_sock *msk,
+			   struct mptcp_sched_data *data);
 	void *owner;
 };
 
@@ -265,5 +267,7 @@ struct mptcp_sock {
 
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
+extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
+					  struct mptcp_sched_data *data) __ksym;
 
 #endif
-- 
2.35.3

