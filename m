Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77532813
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 06:46:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUgu+mvU4FdJB0xCybip/BaynG0TR/VWpBYdWAcD2uaF6cp66VD7uWVMNTYyXTxvhIWmawJTvH7P3CsPwmqNR9+rt3bdWt7Cf23056rVCsadm3WsspT9987FSBcT5nZwQ6RUnlVMngVtQRuEs/ZHM9EHgmWw2NaJpDgppeTzByX/pyWPpSt7RivWR1RdkYoPz1N7zPZEXrLiXIVeApHv30IVfaEMwcyFMur6AbxhNZ/ILTGrRUgauBCnzvOzys6KdxG26OaV/JxGOuUHS2QvUs9sTjxVppSxGY2tJUvUmn14cr520/EnD+k8YQ9Kq3I1lkBTzoVcCYR9Z/r8s3bmxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pQWyiwjjgeKPS87ddyLtx3+Np/qOSmdEelVgtqzPCk=;
 b=LcLXJqIPwwcjT8FgHmgVyv4BTGGqNiVezlIPiq33AvfUK3Wa8jkR80Nf/XMiX75hANyXG/ylcblpzPMV9Uuqxboj1xhiRXHM1yIpNo/HcUSjLYV5C2MU//w+C39iEHVG0lqm5vVueCR62OLW35Eh2Pp4ZyYp9YAT8dBKI5BFQXfsKU2TeAlDhZ0Ee2ehCnr6W1udsEECoD+OScTd0aVpSHItetRgIUUnATT00GwoZQJZE41LrtMP0on/ufX7fvKgAA5LkJTZOoZI9NE29xgkALMuITUp5aGN5MZHR4xxo3BqANUxgegB2RcXUjsgpl/wlFq6Wuul8qZJMD0x0zxAxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pQWyiwjjgeKPS87ddyLtx3+Np/qOSmdEelVgtqzPCk=;
 b=nvkR4JWhCWy7xjSn4twcdQRuNuHnP4/pe+7FT4NnXHJj+qITzWGkeyc2usinawo4Z+UUvBDV4F0U3Z0bdhvor1y3jtc0l0RqOmYiW6CxYc4lnsA5g3Y28mmnoP8GNN0EG/QCES18zQy3907SKQ8PCENJIhkUffj8B60tRkYraR+1L6KE58oshfPILR8JViFlQMQUWcWTlNACnLAXrOPiT2bEoWcggtICLcM+Tc48WxvIlOUIY7k1XLMQFeAWhpXxPdnarAa3wyQnIhlubKVwXCneTA11DEdWqWbfljzWp9lp6GCEBdnpKjR0soH2cQ0a17s9QSME428dUwZ6bNoupQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7029.eurprd04.prod.outlook.com (2603:10a6:20b:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:46:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:46:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 10/18] mptcp: rename __mptcp_set_timeout
Date: Tue,  6 Jun 2023 14:45:09 +0800
Message-Id: <80e910d037d3d6bf85214b5b4f5c327b54509ee1.1686033694.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686033694.git.geliang.tang@suse.com>
References: <cover.1686033694.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d382ab-7136-4125-1963-08db6659baf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/bmWPii6ZbAbMEpZXu1J2goOYtXtTthhaGIYxU4WWcfArJ3CFYPdUB0bo1Tl47wu76tLmKFaDQDNTCRBZy+Kz6A+94VFnppDZeD6kZNAOmrxERWkbeJxkpxnsFyM/c3FkTJRFREt6CwN+xid3kgeM/ChYZi6rQaDYGD6o5qxhyUlnMKR0W08bDYYws03fiLiRXcLeQkwPZkrG0bs5rzZG23awBNrYi/vq1jDjs7Oj6+VMAISXzIzELxjySeG0YEvDOG1jo8OPvWpV6WFstJ6Shu/j+x7yTT8QEcmK8GEdl+8YedUbSacCueyHLK/RXd2afiTfVYRSY3c2Nhl1mEx5jcturjG9lgZ6O4VyVZwE9GuZcCrD/AH8HZBwGZ6jdJ1q1VQk+PK8k+lWseUAyPOgqSv62LdIPmMmhmPhKqxotVnii/MTBeOOjkxFW+UU1ljhcun6s7TrjoUpJl+DHt7ot4JZxGfPUBDe7dCEasuTUmgxvf63WSzM4rbKz9+JjkQv5Mefj0V5Oxh1xMo0XWUFOG55wMZiUxVgg69rC7ryoVjGr4YwI0F9rRjWUZp4w5D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39850400004)(366004)(136003)(451199021)(2906002)(478600001)(8936002)(5660300002)(8676002)(4326008)(44832011)(36756003)(86362001)(66556008)(6916009)(66476007)(66946007)(316002)(38100700002)(83380400001)(41300700001)(6506007)(6512007)(2616005)(26005)(186003)(107886003)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9qXA81aJ6V2uEQNq3eS387UkMgWnIxNDuOGd1pRsZAmjylyrkQ1hE2sgkq6N?=
 =?us-ascii?Q?P/pmfpo5SJGQEScUfk5RZGFjQKnNIzIqAsUxGvO8IwJqPIYKb4ESXwA10Rqz?=
 =?us-ascii?Q?qHrgOb3tkIKH3S3qYnlNgoFX5KLtdYnfDAPxopbkk2JuHUEXa99KoGuEWMiU?=
 =?us-ascii?Q?jtMw04ar4LiALgwTKGydHNU/DIeFwa9D8kpvAQO/3GBAqCW+f4LMEsYkYZmd?=
 =?us-ascii?Q?Da299+6tuAE9Ifj3pvfXwyCQ7Xtbpy1njSRDupCwaBAkDFogHR6L9JYwlr7r?=
 =?us-ascii?Q?v2LlkfIDNmSLuZfLJY5qbyX1jD35fjTmDLTg/+86OP0E7BFYtFG1eSoOxo8j?=
 =?us-ascii?Q?zhA91/O/fd06YtkGFRgHX6yElE8080l2WiXjswaNPaZ39katIG2jlJxzMti7?=
 =?us-ascii?Q?LSLWB9GQhqHF4SGtGQJLcHoExH18qv7UIeuB+x6GCqIauqAZFaeL198UPXS/?=
 =?us-ascii?Q?1hVzQLGr0wRwCgJ8f36En6cbwQipYon1OiwuFbhuNsMuaZturZlfo2uISl6+?=
 =?us-ascii?Q?o12mrgo3ODZ8nNY8Da1sb7VfUmsHnB7QnTeCB4vCwwLoh2aeqk5P+TrNw0GE?=
 =?us-ascii?Q?5zz/JUwakQjDAV1d+kq4tQyATGJU9taawrBMBPAprVRWuZg+GTrvEaZrQViR?=
 =?us-ascii?Q?BoE8ENcH1RiEsNkp6YM7oX1OR4MI5OzCGcgUrOnRSVa3tiP04aWGPpPlUAz+?=
 =?us-ascii?Q?138bOAI/9SvsmwYmKTKck/I3zd1T331jybi+86VSIdQ6IQQDEUFALYHUHGgF?=
 =?us-ascii?Q?KSMfN0x5i0QLAhjL0uXneNdLrKh92EDngar3YhqEvfn73twlrv2qcPbV4og4?=
 =?us-ascii?Q?Q1nidglnHz4qaaRjAjPvZ3TkhSINIoVZfpljd7LH9wlPQTKR3jSq7M4Pf+kB?=
 =?us-ascii?Q?djC9AlWOljn8cEAg9BuAhfm6KhAtn2Hvsh5xP1yZaoo3RfEayahPt/Zd9PId?=
 =?us-ascii?Q?KS4OUUfKwdyjZ/AgcNdzJYJtvl2kQqEZ2ODpQjRNssnG7u2vfpzKlTc9Zy2h?=
 =?us-ascii?Q?zNRsWgiMBwYaUo2UP7FXRgHU3SZnys34m9U3XHBpnl6kCEbcnoSC6V5kTbzL?=
 =?us-ascii?Q?sekTSUw792SehFvRBwO0e8fc9ACo0sY4MJSchctj52XM6US7kKCDRMhO3V0h?=
 =?us-ascii?Q?liMGwP8cXG2YoboPMPYoJ5IZLVT7nhoWRGoBmgtKBHZsR2e6TDnLv7I7PUmQ?=
 =?us-ascii?Q?TEUl29GspXKaEBUnT7qcbozF70gfxva8L//Y7ARf7W15vInlogJDmmamQVpu?=
 =?us-ascii?Q?taT7OrYy6Mnce379f4u5mkP3YfwBC93gkiZjOySTMLHELGv08FvTAHqEg2km?=
 =?us-ascii?Q?2J/fYel2ryLgwhE4fb8o7PLiNs0FCWUZXaDksk2OycQwtDWT7YkCwpsHSpIB?=
 =?us-ascii?Q?e7YXygUeeznpQ5oAn6FWJ1q0JSbsd+zsYLocnX38n76L+GSuUpxB1o4B4bEu?=
 =?us-ascii?Q?4lI5CadIc5xZL+VYXxiW6gRjNmDeuL0Ug5oCyDDS6DuAlxm0uXqawm23I0Kp?=
 =?us-ascii?Q?jWTK2G02D0Sz6DHhS/xBhEGdUXtFPQ1kA2uawAEadUCf/cIqdiKKDIqBxj0z?=
 =?us-ascii?Q?Vq/JJPkQq1aHkVx/Eay5GUkTDxYzZWbxib212od7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d382ab-7136-4125-1963-08db6659baf3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:46:17.9348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgPS2LegKPTIopIt4k573FhRHKl3psrlR3FvHfIDlg99nBwVWUJL8tU0h3Nfg0hvEnQDf67mpyRdbtUZl67Ckw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029

__mptcp_set_timeout() is needed to export in BPF context for bpf_burst
scheduler, but the "__" prefix cannot be used. So this patch renames it
to mptcp_set_timer().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 27407b48f3ff..55c2be2b14f2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -485,7 +485,7 @@ static void mptcp_set_datafin_timeout(struct sock *sk)
 	mptcp_sk(sk)->timer_ival = TCP_RTO_MIN << retransmits;
 }
 
-static void __mptcp_set_timeout(struct sock *sk, long tout)
+void mptcp_set_timer(struct sock *sk, long tout)
 {
 	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
 }
@@ -505,7 +505,7 @@ static void mptcp_set_timeout(struct sock *sk)
 
 	mptcp_for_each_subflow(mptcp_sk(sk), subflow)
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
-	__mptcp_set_timeout(sk, tout);
+	mptcp_set_timer(sk, tout);
 }
 
 static inline bool tcp_can_send_ack(const struct sock *ssk)
@@ -1455,7 +1455,7 @@ struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 			send_info[subflow->backup].linger_time = linger_time;
 		}
 	}
-	__mptcp_set_timeout(sk, tout);
+	mptcp_set_timer(sk, tout);
 
 	/* pick the best backup if no other subflow is active */
 	if (!nr_active)
-- 
2.35.3

