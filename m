Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80081.outbound.protection.outlook.com [40.107.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80FE468F
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 15:02:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeD5i7JgOMDamMCc2Wa8OyBeifvUC4ZRi1OCYi5YMFIMwoS8cdD3L6QtEh5ULnX4tkwgSf4pcPa3vNwqwcQNWdBuNSpuxryg72Tv55aDR56Fj9RjibqF0NjnxnZnsEiRvFLnybpbMnjQx0+wtML1nfkiy0rMA9HcwXITcoeT+phkovMsKmdiEVFR8DGr2gIyV/tCMHDtomuCgghAotQboxKtAFHdZUc6ZbV1Im5qssLSvJ3AH6eI3X70uusQfjXoZVgIynUqc0zFPHnaQZm3GBCLDvd3snW5oNxeAxk7KApYx+xHvw+RZ2mlDfaemjpZN/5dJWcbxy+RPf+1xZRDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UAGZceGo/z5fKHoLJ69QG0hidL0LQn/DL4oMzrmGZ8=;
 b=hfI22cDN8VB6PY08BaLmylAhTqnC9pdUcVT54tMPyATlljdQgWeW+tK2vr6aXgyRtnSvhgU5YcQPaP76IdnGkYUnEZRQdhnLl+XunGZHxqRco7wIqq7ez9oeH7Q8oUf0KtouuW4QXqEeERm0ha6KL2FNkK+mXkMIhbkygKem2cQz1OsP5LIBtdFNpB6oqzIn/L2v4joyABeYi6ME4tvNz7phWY717I5lp8OOAL2KBIfEkyGDFQE+HH3JphafCTi9QgvJa9LQflbiX97VgDUcmcdVJ87uPrwmbXWeEljVbd0DSwiuNync7NzoRpp9DRIuXY16dOV02grm9a0J1sSAGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UAGZceGo/z5fKHoLJ69QG0hidL0LQn/DL4oMzrmGZ8=;
 b=K1tNqfTVA3OP5mwRtxcs3kLVUsGE2nOCjD5+QZDjEhFTDZj7a9AwQNdEOMIpqNNGWb51tzE3itn2ImublvIbpp2X6z+mWCLNy4d+eEpCzOTBhEPy6baZO9hRPqsJfqcuyhcmIPHYPztqM8sbhd5NLJG8/1dFVt6NzAbYi36wTi98iUZ2exQ5RJM7aCZRjg9OwGslhTzuEjVbD7vpD8R62O8wH3CxDoij+KBFouQaOGoVUeBjDKkcwOaOW4O6r2i2vbNxQfjWnILYljCUn7rJ0jdzL9FuNGKo1genW29x92jnof5Z0bbN10fjZ3iNE2Qt6rJxDAtpnulKXcokKA4JPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8295.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Fri, 7 Oct
 2022 15:02:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 15:02:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 02/10] Squash to "mptcp: add get_subflow wrappers" II
Date: Fri,  7 Oct 2022 23:02:26 +0800
Message-Id: <c28ebcdb19d49f5963a261cee446e4b10c863b47.1665154582.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665154582.git.geliang.tang@suse.com>
References: <cover.1665154582.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: dc65dbf9-98fd-4d8a-905b-08daa874e6e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UYsfMC8oLXMctIPxpM8BrixMFIdTWlgYrnNRE+tjv32D9VSJDyYMl9CeLhOiL7qcw36gGCqxwKUhqB6LIuQ5Gpj/PcsQOINZIeFeE+FU1ZfL4leRhLTm4j7T2Nc7pvrjvFmMWnjGbVjWtVN5PICbM6xFjPTGqGRTKTasqLMRwZOANYlIzOJePPx+YisJbUYRMnXBktLg8nWHlDMxq7K4xYf/l8UIKQguzu3E808lXsMwSkWLAvnzruCnmpERPDFW7z0lNYKoRtXXJWKmumjNyvR7y8zT0XMNdLECKkjvhu38AY/vbkFjYiVzFnYUx6bSMfzvFe+L8UR0VszUcC/jYVYjAu7gP74u+NHEHvTcKgS/0gfT8HVlZg3QtuuYPEmPdQYdnkHsxdYoJmmSLXFSrhWCn4n/vq2FJk6lxjFcm7c76kZl6nKk2cIQzRw5xFOc0LX5e0F34LkuYNBWhNW0Ih9pym5EE2UFqT4zUkds+1O+s/HCEBvNZg5tJuEXSqF7WoJDMwnml3+0QcjtZoefFKA7si83jwPnUfQDLLbYGJBlts+W8K+AKKcF8tzE4X35gcS2FErDABDSBV6CkpUDEmTmaBJSyxPi3/+lXxrjDfGlliA5dbNtK1cOfhRw2Kdsu6M25aFSHCc/fqMlUGS8w7Bjs3OMjdylHx0xVjGttnzaHYEEX3QlwLbaIOcMF3dWDN7KlhbB7kbDTG30ant1GXPHoMtds0ZlP/8aexxOxqJq5WBdeQV7l2h56ms+JNH1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(5660300002)(41300700001)(8936002)(6506007)(26005)(6512007)(36756003)(83380400001)(2906002)(44832011)(2616005)(186003)(38100700002)(478600001)(6486002)(6916009)(6666004)(8676002)(86362001)(107886003)(4326008)(66556008)(66476007)(66946007)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+iQZCXflhK0dd/rQMT4IRi9pXt0n3GNajmUWcf6u6CnOH3m6/q7peILg97SF?=
 =?us-ascii?Q?k0FXUq5MG8dErILDwAcAeF6mRul7jxlckAN3bNAEqOLeOfL2nyq7o44ID7pM?=
 =?us-ascii?Q?VwsU9bhZS/NFvEh+C2aavS46g87uUgwWhw2Jaj2oWpYlBgJNDmBOT9gPFXp+?=
 =?us-ascii?Q?tFqCmOt9U8CDv9n3INWsJvGhrfuL+f/AoVKMcppP+VPyeB26ay1q95YoDiP5?=
 =?us-ascii?Q?O0WZEZE3ZDp1q+hyb7JH7zE0Ki3O2vBVBP2LMOf9R9cplNbbioZN5vsAtDOe?=
 =?us-ascii?Q?2uQwR7eI/G5hWrQNRbOO1nTDSTYpB1Jivayl6m0nGlIkgzRmvv7UVUiGLjHx?=
 =?us-ascii?Q?5RwE5co4DQW7eDventagZ4iEElvrgXNaE+tc89mtdfgZe677zdVb7aJanC4Q?=
 =?us-ascii?Q?tMmmguvIdTYT/ugKNUEia5K3dtOnTxNMqV+led+929Ykm7kTdrwAF0Z1I5IC?=
 =?us-ascii?Q?yanJWEVn8TWtWy/ocDbTEo2Xh4Hgl614y+UZSC0GZwt46o2f5XpAy8xkqTgt?=
 =?us-ascii?Q?nA05/oOCB+vbtZY3ILWygk4d/slMvOK3KQxNRiQsF07VsmHhs+Zf42/Dwsqh?=
 =?us-ascii?Q?3/cMmJFmQ0J1SV1HhJNk0EUqvv4Aye3j5RTPNyMpLgLHzLUREMb0no9Z+WTS?=
 =?us-ascii?Q?eQu6FFJVO0U4GoSP6nwe2rcwucWdeQS5qr2uQ8BDIabaQclFk4xYOVdpBjCH?=
 =?us-ascii?Q?jByGXsAr6gXJSshvkeRV/IVb3Pgrq04cxMzGTqJc6cktmhvpk+scbW7oH9tL?=
 =?us-ascii?Q?wU16WYlkygDiZTHOotSXWDkoq5ocZTKzsLQ8tera32/XdeTrkG3ShbvVsfU7?=
 =?us-ascii?Q?Wrf8WnLNqOtHS9RqpTRO+t9EAF2Qq2LqO7BgX5T5EdCA+DPYInAIGXw3v91C?=
 =?us-ascii?Q?yCvWBAC+ngAg3CTIyx97VX+t3u6pqV0SUWd0Izf49Gk5Za5jzjsedqXUGk0/?=
 =?us-ascii?Q?gcr2rn65kwaQ/N7aji2q1TCh1aLSf2FrUBOWBuJkA3oD2sB6P7rrLxY2kD5U?=
 =?us-ascii?Q?NGyn+wQHjtcFzy8HGNJzPxRAMBML6kKnYRb8cLXFdRUpAnHq7BK2OjA5DmpS?=
 =?us-ascii?Q?8M3tb2OrZVcNxNaybtBUh/E2d/4uyGJPNqZDJZRFo+I0uCEcd6s4inJsDCvF?=
 =?us-ascii?Q?cj/yd4Sn6vXvhj9XUyMh6FghuOEJbp9Pr3/6vDsfT8W8OfUm5mCzu62aNGgc?=
 =?us-ascii?Q?NY/k+ojre0SHV9XU4HON+TxhjB8bgGJA/5LDBmg6fiWIsrn+0xbai0BwzJsI?=
 =?us-ascii?Q?DnDW6lfYXeg7tNr0KR+Cq+QOGBfYoef5absFlWlX0g49VZkG/0aJaAh3ZfVF?=
 =?us-ascii?Q?cVMEoFTbQptmhkp3kFYskBzxX3ZmUT1WPtteYexbQXNlXNy4YgEDxAFnp2jf?=
 =?us-ascii?Q?6iuiCq9RRnTnmKx8erY02Sy0izesja5O98m+w7o2AO6TU7VZF3LImV58FyyE?=
 =?us-ascii?Q?82DzL5j9mpsubPVU+uUU2gTtTKymsPPMJboOc+GF/O6tWIcFJBjhMzvUoKvE?=
 =?us-ascii?Q?LhDVXIIvNaRaSl3g0FbHej3I0/4S1iuVPHnIeRa8cYY8HZVtFdEOBCVFBDIK?=
 =?us-ascii?Q?DGZgJuDtTuxTve6IroIHscHBEdLsliPBlpOCmM1Unj+1z+2di6yPmkgQugML?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc65dbf9-98fd-4d8a-905b-08daa874e6e3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 15:02:07.2504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ch2w3Poqif61+9FzLeeD15CC2aSWgBmz3vurrSjDrxjuqX00ni+/KIBDfKXcuNNy0S0tHTvUFRgmKZFwEx/Ylg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8295

Use new api, use the return value of get_subflow.
Some cleanups.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 52b734e696a6..cabcb34d8af7 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -116,8 +116,6 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 
-	msk->snd_burst = 0;
-
 	return 0;
 }
 
@@ -126,7 +124,7 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
 
-	sock_owned_by_me((struct sock *)msk);
+	sock_owned_by_me((const struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_send */
 	if (__mptcp_check_fallback(msk)) {
@@ -148,9 +146,7 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	}
 
 	mptcp_sched_data_init(msk, false, &data);
-	msk->sched->get_subflow(msk, &data);
-
-	return 0;
+	return msk->sched->get_subflow(msk, &data);
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
@@ -173,7 +169,5 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	}
 
 	mptcp_sched_data_init(msk, true, &data);
-	msk->sched->get_subflow(msk, &data);
-
-	return 0;
+	return msk->sched->get_subflow(msk, &data);
 }
-- 
2.35.3

