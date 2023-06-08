Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87689628
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 05:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQR1vSrXp4oUhY/hNK40Vb/4AExeAdDFpH7YT+jvbqUbGxKOxaT5wZzQRU5blvTV55cVWMU9WeF6U8kZSd7bT9fHoERQZLwlUErT5NUmb72UATWDeWy68pN8GO3aZBl9lcFRYQoDLyRsJYvJK82jBKDW69vn1f9cjYYKNDUGtZArotJ0hAvHmlzqDntdPYlPXWQGvwS/appG9NBCk6UcVqAXZHvUbTckg7po05NM5jIJA4NMM/jXpCzp8vGZ++cikvLmowIF+eYZrstLtXkkRSda5iX4+VWYiNVeApC7IqA+9fb2ZLI+YNx/Ndt/Mg1KCAM+zAxRGgbPA/cTqnTeEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOpdRYZ/SdTM/zz9KQvEh47w1CYzCKq9KVI5TOmixOA=;
 b=AMQGcxBoMSpXhh7d7zg5ncnX6OtOverq7iK8y4MStltpcbVXM8RXfwpAryV4pJ+rtozIgFNkPg/7s4lx398LJIRT5peFPsfhVBbS4mp1utLqtDraBu3RQWnxGlLITBWLTJWcmopkpUPNp+5aYULG2QuViPwR4Qh0IagaYAEF6DDmgg57olTDpp25yzA/BoMPEfXLH79pAeeo7zJV2O6SllP3rEsHjvG3ZllXlUYjduQd6dRI8lUpfZuVvJy1EYq8VOqlFbB8nlt1f4vk4331yEOxuMgBXBE6AiF0S/AwU7citY2M90Zx87pUaduwJn9TzB2kB+E8/eMcBkGMNZR5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOpdRYZ/SdTM/zz9KQvEh47w1CYzCKq9KVI5TOmixOA=;
 b=egKe2y/C06LYF1BPRmvsLtltcqbzQwzgfcTHU5QYx1+kFLO+NZMmXO/3dCwjefEZ3NyXCEpjZ7E4dJL3kUU7w0cuX+moHSNOFl2BYU8KCK52TCaaH734ol0eyRiZMzJKG6P8onl8xLpmeI4k5BIO9EQRlX5B7yldWDZcEoYPfP/UQ41QL+CyF8qdPPItLd1Wc9X589GjjdZOuLopUtCG7FzVmQv1F1ARJeqXVBtybuxOTKq32qDhRxII6EKkfcJ98pRzIWGOnFbWDkGZNfNXr+3mRq+5BHfOGg2Cdi1MAxhf2N1D6xmqplvS0VtAVLvASIKkVF23ICIAVpKqC89DBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7600.eurprd04.prod.outlook.com (2603:10a6:102:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 05:48:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 05:48:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 09/17] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Thu,  8 Jun 2023 13:46:47 +0800
Message-Id: <99a6e701a2afacb56c3721a544e422b678e642c0.1686202841.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686202841.git.geliang.tang@suse.com>
References: <cover.1686202841.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: ab791172-d5a6-4090-cefc-08db67e407ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v//bIPOjOvc7vdhgyoNVB8woM1P7fSYGQIdWySTo2Rs51hCrK/Dv3yGU5PUT34wzMxzxsGVNvbpnhYET5L4Ouyerx5y5lvPZ7BWBG2gCaR6rjL85ECXASk6UMaSswVEWKXYNT6QXq71xrgdK0qSfw851KOhsOXmc2HXKgzFVN4H7pOKNAikWZBD+TqtUumECEB8QewuBLknmkDywTW/7FWS+wSBY2RPWN7nL0abLC4Q1mZK5Sw5Vy/Jmo0UfF1RDG+FQ+Xrae73SYyetMtYwHeRbpssEPw7veCHYu3xJYI7+sGvYSAQkQiPYKgjKu1qobPeR6cpPQx/XLEt2biKdqwGFWGOJHv2lg79JNkY7txu/vu8A/xFLQk8B2lwHkWMfOYm8iC8+upYSH23V+6SsZxUu/Bn8Ivb7AnGNPwsOYIh+UXMN9FrY+6XxP2XQCY3CRE6St6MC60qJBjTsIwcRG/E03tujO0sssNw7RFAAQy43MTXjkx1kaeBtxFBmYXsjRDm5TGfZC6JPSyA/OPocLXGwM6RTjRiGrZk6jriF65uerQiluktORbM6pvAjqV+2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(6506007)(6512007)(26005)(107886003)(36756003)(83380400001)(86362001)(38100700002)(2616005)(186003)(41300700001)(44832011)(6916009)(478600001)(66946007)(66476007)(4326008)(2906002)(8936002)(8676002)(316002)(5660300002)(6486002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R/UHRe6rIJZSBvr+iVTUmTazXlrPkkOyMB5G/9+yiCf/Fe7xzN62pEHA3HDy?=
 =?us-ascii?Q?0FgR0xqA13N9pyNdILYe7lmQc0skTb8ZYrDl3ZPKWLT59daR3L5ZJuVhdmFt?=
 =?us-ascii?Q?z2zUCTDBO787BWZuMVWfgiFy3ZSGQrM0xgqtLwXTddVnw2Oeqri/AUMQiGog?=
 =?us-ascii?Q?22hhL1Gdt1SHNg/Ei+Zs8eg7N8c+D5XizbZ0kdCZOjG2M8cL2BYFfjqkiuXs?=
 =?us-ascii?Q?9TJoTtiEaZvP17MqpQ50Fhq2TuYzkbNnARy89edbXYJhd3pCQslRUYzwYtqA?=
 =?us-ascii?Q?9dS2K2jp6dBTJTZGvGWd5zPV+gC78/P4wsE78a35rItoZNBm2/MbidxYck7F?=
 =?us-ascii?Q?K8WJ8TvGRY04v7+QqpgBVls9EMCeJCnqBBquUvmSTBSktpPhIXdfPzFzrKXn?=
 =?us-ascii?Q?8cB3cjJyovfJsEN+83R2O4yXtcuvV45IAk+oPSpTEdGuSPRC7qoAzEtiiy9q?=
 =?us-ascii?Q?MMjj42T+Dq9B48xFal/fGmBF0AFCXUvANCWUID7hAkGz//sJNvcjuj+UlJrl?=
 =?us-ascii?Q?yH54h8mGQ3UQhDgeDHRoUjwnAXGox7YZNyNYOjeH8/50AwGWjm8ExKU2D8mu?=
 =?us-ascii?Q?jQOusuWmZGwo6TSoKDtslD9LdmGZ18J9NeI0EIpjTHE4ffcFiKPPVgL3EQZv?=
 =?us-ascii?Q?iKasyEQy2PI1G9AcPe64PJcUauL+dhY+mQfDaX64gcbrSjMCkmV4pv9OMmMz?=
 =?us-ascii?Q?fGR75EY8hn4c9AjbkSYVQGqt+as68/AUPTd6IPW32M4T/WjREqIw2pEUxbzM?=
 =?us-ascii?Q?L+7pjLb6ronb+HZPmWJ4ttMgZUy5NhPJs08fnw4Vig+sJXULwAZYJ8KJYQ1c?=
 =?us-ascii?Q?1QFfzsXjTJolx0Yf84x5CJZCcRjZFKo1xEwEX3l+85gBtldiffs2jKvjXh9+?=
 =?us-ascii?Q?VvN8/kgM2MMPeiGRpB8NeeL/CS0NwQ8d4BWShGavZHsy0WiG1PlIl85SbVek?=
 =?us-ascii?Q?Irvil2g8k09zehYN0mVeRFtCVAUYa9gohtUzEz8jXCXTQLWbiaRCqET7lVBs?=
 =?us-ascii?Q?iMi08epNrw5rSMP0tknTmy15GhhEBQbw71bG+r1Gw0uFwAyskyBWyfg8/r6a?=
 =?us-ascii?Q?MVo5zjrzW11m/vozXFvKKDjyO30V55QJoh7w/zNk7m7JIKV48sy4cQApuKlY?=
 =?us-ascii?Q?Gd6Dx0rUdv/YlkKxsYX64RGd2ZNN1rG4Fr2Him0ICrZRednJNyWCfT/kjur9?=
 =?us-ascii?Q?nh94tpVKfOIes/NBPGzd2pHH0FPg+pQ5ixRpMJMpxVc+WHAfsPFuaU02/TIg?=
 =?us-ascii?Q?mlwvA0He+vSCqilqUWFObgr/pjglpFZsK0GmsLQB8dpdZDLGy3kjTzHp7Pos?=
 =?us-ascii?Q?2f+jmkD4kfuoqbOg12GuOxc+QE6iZNIQh1msUJJhU1yXU8pz8zRRExf8SYep?=
 =?us-ascii?Q?IAAiv3lRTJo0PaWoVxBLep5Jldy2pd7YjXbO12B4+zki0a4aKt3jr/5NlPUt?=
 =?us-ascii?Q?fqNIqJYUDe0ehSlXZ5s4v0YZxZCWgy3Jf5LXvi95Bax6TVedHYfABqQTyO1G?=
 =?us-ascii?Q?eVpYioK/ihgAviIAK7jr3fGzVv5TplgQ1QhOXXZa6/9br8pLUyi5YUpgidRM?=
 =?us-ascii?Q?i6WojBT96R7omnE1ymA+8NPl+gkOrQ4kiNwAZNDT?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab791172-d5a6-4090-cefc-08db67e407ed
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 05:48:48.9668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjFVpBHB2CECVN6coD4u8f9WLC+KSzorGBwmN1GbsQqCYwK225s9IoWRd8cDqEyLYw0KQwIVbJz/NOYM06tssA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7600

Use data->last_snd instead of msk->last_snd.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h    | 7 ++++++-
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 5 +++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index fcb023a749ad..44c356772798 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -239,6 +239,7 @@ struct mptcp_subflow_context {
 } __attribute__((preserve_access_index));
 
 struct mptcp_sched_data {
+	struct sock	*last_snd;
 	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 } __attribute__((preserve_access_index));
@@ -259,7 +260,6 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
 
-	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
@@ -269,5 +269,10 @@ extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 					  struct mptcp_sched_data *data) __ksym;
+static inline struct sock *
+mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
+{
+	return subflow->tcp_sock;
+}
 
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index e101428e5906..e3ade9346f17 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -28,10 +28,10 @@ int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 	int nr = 0;
 
 	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!msk->last_snd || !data->contexts[i])
+		if (!data->last_snd || !data->contexts[i])
 			break;
 
-		if (data->contexts[i]->tcp_sock == msk->last_snd) {
+		if (mptcp_subflow_tcp_sock(data->contexts[i]) == data->last_snd) {
 			if (i + 1 == MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
 				break;
 
@@ -41,6 +41,7 @@ int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	data->last_snd = mptcp_subflow_tcp_sock(data->contexts[nr]);
 	return 0;
 }
 
-- 
2.35.3

