Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2087.outbound.protection.outlook.com [40.107.249.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE72134C8
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:18:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2/x8nJEPWyproB16jWeuEX8f5fcAb+VAk+y+JY59kwZshNf/f0D0yjCF1TJ0GgCDAE7evmdg9ZycmXnKw1eca6b1vJIyNEf9dRnVS15SQFeosCISEwujhRRI4EB/N99FBqPmDEGYShhtG0W+RnGvml8J58GxJu6dpoQC7uTtKUrPo3fSIhL2lRFXKwDK99YKAGl1AO3G1PF84EwNjwidXaODnZCGF6Aso6NA8LqdUuMcscUlWSyVnj4LDOrrZ35M2agSclVwxE5CVh324xQlXA2Zz9YTySkRIYztw31EyxngBvyjWgNbECQRVcIwZmyCqlHc6wEpNxxR7AfvrqSrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39Sbn+sLHX0BuCmf2RkegIYI545ueHQcQ7O++C7x34k=;
 b=Z/Aw66ZyaAjP4jrAXnXBwJv7RjQCLEYFuoQQj6DGQvIkpuXBCj/1yCIIwntUA8VtBJdm4OA6rAglKEt4FNZXSEJqAUkVxzKA/tIYEMiZlydv2z5itNOEJEVySWWguyz5xhAO6gFE+wwc/1DgLTx/MkpZmwtU/y2/1s/PvN2XWAxNexgPc6dthbfbMB4KfmPRmPlHlONr7EQwZF1gpQ4dQzlXyKeBpcd7YwNlG+lIzi0+lVT9fSZC6HStiQo1aa4lZLrl7Nax+aOTJtyP+DtlUbRIlrScrwd+VS6UFCJ7WD+HpdNrYbMUgaHgMnUQ+yUy1EWBEUyogK6ckgl6rGtp6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39Sbn+sLHX0BuCmf2RkegIYI545ueHQcQ7O++C7x34k=;
 b=QCR6UVF1AoG8hfDpElz4cv4rooq1D6rXDvr4KGpadQI60bz9lHDyKzRUfEj8n+x1rXq9HGPtZWyJtyDg7UbpXIx/wtH9hcf7Tn2gN/kx1ARvaUYHkFU4R+xfE6AU62mmWOksVz/IMdvMNS0AJMkAU9PR4U5CHbLOUdJXL3Mu/MIyUPyfIWdpBayKfq5JqBchrSuI/eZaEo2pEORQq0AsXniGfnE3rCw/Y0qVQMBIjcCjJYXkmRPPdLfcHp0slIcrohg8Jm4WfY59NZAkQv6w0d4f5mJ88Aqirzkdy70/OPRXh4MQacNx5yPbye/rb+9ooMPm50vkmMV2cB/RoqDr9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:18:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:18:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 07/15] mptcp: rename __mptcp_set_timeout for bpf_burst
Date: Tue, 30 May 2023 21:17:27 +0800
Message-Id: <bea85a828decee63599b7d59c0ec099ac0f46bae.1685452619.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685452619.git.geliang.tang@suse.com>
References: <cover.1685452619.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0119.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 785faf08-2294-4a4b-bd6b-08db61106890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SMDw/T/lmttAAvsJIkt4qxKqypHCudHqsWdLEZE2lHRY9Esr8BQ056sgRdoL3lHocmAgr9w62MV788cLK/lTV1r2QxwAcz99076ndF6OzoYW3u5FNjjHDIT5powXbkJ6SJca70U+aGu82HdKfLQQcSSXXejiLXkJgHwyEXzHX6MItsCcegciLvuSLlG0XlZQrlGvG3LDJaQ9dOyMBh/QYNRcIWEPFUvLKpTY9fY20FCpx59NKHpfR6k0CNFUfpJxncupvDrMI28K/ZuR50C0/3WZalMl56OuNSV4oy1mL4z6emumP0jxl/LU24lxfEmnmIbGlipyRNctZp3aVNP9NQji1SdninzpCE98/ejM+iRBlrQNzIncy51Bz+AyLRocaz0zSuq2bzkia05krjPqzWrAibzFYSjAKG6cw3VQrIjF5xmor+MK7QoYTnGO5w5rtn0mV7bmeCPvBZXZ7+T0NWgpdaNSPIm6fa1Zz46A1N468ab8doVl/u4UAAJbFfL6HyZuVoUrosNoq7/2lwQ68ZEX/V2gqvtQ+rt6MSfTwHOb+Vy3WpQM8HAbQLdBDfOY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(478600001)(8936002)(8676002)(44832011)(5660300002)(2906002)(36756003)(86362001)(66556008)(4326008)(66946007)(6916009)(66476007)(316002)(38100700002)(41300700001)(26005)(107886003)(83380400001)(186003)(6506007)(6512007)(2616005)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wzah0q1ny6GD2h/W1Iztzgyzk/LSyF0A0Zs7wDMtbdjq8zPlnTCYP2p8BbV1?=
 =?us-ascii?Q?TO08yYuAelxx9ISdhVs11Lo+PhpZYykGOH3B/1sHYaN/BRZNrY8XIQMe1tca?=
 =?us-ascii?Q?MkiV6Lf1pCZrD0Y9E2oCJGoksHdwFhCQx8jQ0hwBHTf+4vX2LSEZXArtCDpb?=
 =?us-ascii?Q?PP3LJCIvB+7i2E0MsFofPcaKSv8UJ0fgz3XlpaJCBJVljFE4YiKE31VGurXI?=
 =?us-ascii?Q?3fsBjbkxUMGIQ/c8W6bnNK362fZmVIqvnALFtQzH+yLD4SgoVgGWTAKQEv0N?=
 =?us-ascii?Q?10r5S6aQrqwbg3ZkSGBYPv7qG0r1KSUD9OvFftfnmZw6ZID8h9CyzAEn8SjW?=
 =?us-ascii?Q?wFg7mR+4nM/FFb8oV4te8ucveBrFOGSE3Nt33VThvl50OjrlGCScWQi4dy/x?=
 =?us-ascii?Q?GAydmyXHDxuMIl/k6t9bRMSgSZApge+dmEpCp9BKhOAO4E/5BvhKRWE9N3lE?=
 =?us-ascii?Q?dn7zWFCg19eT1JtuRDlH0IgaLqL46v74WdDwppk8uEPxUkVEGBVhNvMCHAK0?=
 =?us-ascii?Q?xKBe8qDGrc9yleLCtFDBlTzaECdH6COIHlHL1TSWnlrKzzQ/d+zCkYUiY272?=
 =?us-ascii?Q?zqs49dBjH7ZqRMdNMUAOEDg4IS9lOv7C3oibvn4RaUQgvLF5R+9zq2KlhGy2?=
 =?us-ascii?Q?fjVDRAfsEAc9Fg0YeC5rv/0L9pwII3IqBOIZWqK2vZ8Q2GMugRmLoMVoitL2?=
 =?us-ascii?Q?o8LCxZ/6xl1upcql/T0suaTKU8pL5+32ZRQZUsw7Uemj7R2p0YyoIlFwyReZ?=
 =?us-ascii?Q?zOF8Hzs1NohVZa2Cccr2PwVEhCmgAGJjvAmg4oCmB47s5aZcqrg5/CvLw9cn?=
 =?us-ascii?Q?z7MryRip60TRbIVj/91RIy0CFhOqpCfWjjJgX3bXpWtmMzKSK+naH0kY1gad?=
 =?us-ascii?Q?DyqmAgs/NTK3UcAmaODi2SS9KxL/s1/0AvpCvqS7vTedM+0JBAsKYmy//pPe?=
 =?us-ascii?Q?1GnIEHeeGZw3ZBJuqHcJyfvO3iCZB9K/VdQaujhvM0OjiO93VzsPXK8XJ2q9?=
 =?us-ascii?Q?3HzU2i2Ks0wrNvNmdwoh9JY4AWyIV8pKBDbp4U6XqVaH3PxqAtQ/fdn8vmGx?=
 =?us-ascii?Q?AHdwYSsIkvv7zKKk7g+WoIApv/2rOhA+BR9f/KiPGkWF5i0lEyL9gB0EdBb5?=
 =?us-ascii?Q?vCwB/sdbGjjQ+Q4+uha7a6rCWJCTw0QJ9St+qvNyx3tS0hK0izzKiXDucRdu?=
 =?us-ascii?Q?uF+T0D+CYmLCwUeKIEsRYdquAf5D2ggyhzeWcjnFAh4ANqMlS/NPjYE0Pf/M?=
 =?us-ascii?Q?f99WLHm+GmOKGO0Zs6NTbpoO2G8J2uqGOgRkkaIYKNmdVJ/6WoRwI4a7mJav?=
 =?us-ascii?Q?7MZhnZjxHJCPaYOmVy8++9p0PqCold9al8PidRCM3HR7NdfNTFIbj0HE1qkw?=
 =?us-ascii?Q?mm51cYTVwkHYYqx4dy06jKPNEixFaorM2tzKOsFhbErviD50vorZPsjO822q?=
 =?us-ascii?Q?coDmly2qv7VViYCa6j2uTeZIHle/1YdI6EeQjkyfLr8ZVUZij1zS2cRX8ms2?=
 =?us-ascii?Q?Lnyz9fQObXDuucKTsaernhm7KRgZsYXdj/uRJ7LLG7tNaHSERjHLXQmZO8LT?=
 =?us-ascii?Q?WA73xntcNimlSFTDeYtSZHsg89zKJLTC1t8OP1LU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785faf08-2294-4a4b-bd6b-08db61106890
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:18:50.6797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXlfD75otumXQFWChrXwkVUF20jPHq7mj4OUxMoD/5mGg4FDq0GOVbrWuz7vDssePdJCxCj1Rzp6fSveMpyAww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916

__mptcp_set_timeout() is needed to export in BPF context for bpf_burst
scheduler, but the "__" prefix cannot be used. So this patch renames it
to mptcp_set_timer().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0d85add4c8dc..02e22bb49eb0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -483,7 +483,7 @@ static void mptcp_set_datafin_timeout(struct sock *sk)
 	mptcp_sk(sk)->timer_ival = TCP_RTO_MIN << retransmits;
 }
 
-static void __mptcp_set_timeout(struct sock *sk, long tout)
+void mptcp_set_timer(struct sock *sk, long tout)
 {
 	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
 }
@@ -503,7 +503,7 @@ static void mptcp_set_timeout(struct sock *sk)
 
 	mptcp_for_each_subflow(mptcp_sk(sk), subflow)
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
-	__mptcp_set_timeout(sk, tout);
+	mptcp_set_timer(sk, tout);
 }
 
 static inline bool tcp_can_send_ack(const struct sock *ssk)
@@ -1457,7 +1457,7 @@ struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 			send_info[subflow->backup].linger_time = linger_time;
 		}
 	}
-	__mptcp_set_timeout(sk, tout);
+	mptcp_set_timer(sk, tout);
 
 	/* pick the best backup if no other subflow is active */
 	if (!nr_active)
-- 
2.35.3

