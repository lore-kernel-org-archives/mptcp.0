Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CC7F
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NePJAx7rsVozmt+ml2m4wkEmOe4AGNi0pTOcUdvR88AX/cC8UFvg4CRIsbm75PFTXNpBk4dAli1ERfJWyADgchvziBb3al/11o8qSV2YJZRSINAQxcVykQw7x+3WaYPDD2Kcb973c3vK1X3Y/yIkfGHFECz9hlKUMW9tJsax7++XNLWhuXxdGaars08QggmbZXj7QRMFIAkR2kZt15foLkz4Ts6yNw/kuGOHUOHLq2woZrdFLW46b/sUrdiAW3ieabQioUlCtZEExt6huOsQ2BsA88+aysyU8nhhjMzD+GC8bGsFa7Ipww86HjZVRj1WDy/Jtd5UE+17KLkOA0SiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEX6mMYPAG/GNNFZRX0es0hM5K2Uam6+qycRSMJWqxg=;
 b=EkJpzAajw34aGvsP/StOsW9LItfjIuyhWHhkRk4vE3mY+/0cpJvLJPc2qUUkm7jxKnbD089md2aoSMJJsTE0lAlLmnnTn5GtXiDD5LZ7CM6GaoCKJvneU5P63pT8ft4aG2sQZn4PJQFa5adEUnTu/efoE8m1NBaf/x77f2+iAel3EzYasgBqNk+NGUt3OIPyGNpw8ERP5xg05ljTid0AVZiZ7smovo/fdWaEmdrXsu39EJxx7BkDNNfNedeyTe5xjZmQ44JfzW2I1Jex0iT9lij+9vflUoHMKIIQZe8Xaqzx9mrhm8Ri/9CU0qsN4WJfkPMBwOnt23FrgX2nbnKLRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEX6mMYPAG/GNNFZRX0es0hM5K2Uam6+qycRSMJWqxg=;
 b=lqPH91TLhXn6vVRk2erwF+SUq8D0CST7eja01Cbxe4VvWUwwC8jVjxD4MHBGLzyj/MCejKQVj4POoV+LA3Otb9ybUNzJnXlrs+KDp3byyogpX2q/xrsiCuZVgCrwMaXHzI4Q0aPRuJABlI3k62g4aiHAQida0Z+J/lMH/e65HQKDunGzqiTpU7pBerYx6MtiO9pmm95IAl3YUbsi4t840YQrK+fKVqSBCdP9u2kRU/0HmQsnx4een154LVa9FF9vg0kYSRn8QD/Wkh/9AmjGK9NZTb6nfcVSzbODUCdSLfZUsxM2tY2Ls/yclr3q2bgpgTV6GoyDlM4ebWqPSGHb6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 02:22:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:22:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 03/23] Squash to "mptcp: add sched_data_set_contexts helper"
Date: Wed, 14 Jun 2023 10:20:50 +0800
Message-Id: <47678ed2470a8b03f014ac67c9f13317a257aec5.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
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
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: a620f00d-93b7-44fb-80f9-08db6c7e279b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S6w/lfKjJ6JmgRbmj/wggKEenxBE0rLkQ6/U+AARlR9kiGdPaV3RjmRhyLsPQmAnnfeuoJV60zf8uBfedRNDxCXlJlKh9KjLTWlNpUtsrgYPe+cI+Szojso5q902B9hDCfgij8RB+P+e13Od1ZaYrFvsQhMTHXABpasI6LLDeQdGmEf887B7q2BYo2jP4CJciLRsQFoU8vP2NZmzDSq6f9oh89vz3k4vXDqNjTIuhn4tGQNUugNfHJXXgQELbpNtOL37kjbhmHC3nI7Q2D7bkSG9w7qaiflPxWZ0fOdh335RBzRY4t2iyhq+1Tl3adh0NFfFaSQ+msLfeMmpXJDb5f3ByJVuvwDHAu5AfWzieUZq/9OwiL6qj+jnulkJHOYs/9bKWZ6dnbK2O/zpg0IIw3t8LsN4+h7kxHhS9oDChHRJa41OGqTxTgHUDOSA1MISQGWMPgyuq88skIxMLz/aTQvvLLuuWLFUUFjOl/U+2uSMyeEnZGsr7EOY9vlz08JAhnKJNHiqmkNnIMCGCOP51W6Say1H4DqKmsCtEsxTincawOARQjLA1u9YEBoHPj5S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(6916009)(66946007)(4326008)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(4744005)(66476007)(8676002)(6666004)(316002)(41300700001)(107886003)(86362001)(6486002)(6506007)(8936002)(44832011)(26005)(5660300002)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PSKndSCM7mjujhkwYvl76xP6xReZek6qPHXJOP6Abzn9nqMLBsKkyzOKWTii?=
 =?us-ascii?Q?VB+gJzKwLkFfmJrsSzoW5RIR7BbhMRTSxCfywcJpHVXp9z5viDn7c0Bhf5Hc?=
 =?us-ascii?Q?1TLXC1K7gnK1alLYDpl8jxMvk4RsbE5Ki3aNpCF52uW9CNZXsrJ+3o1tLGk4?=
 =?us-ascii?Q?vGh3Asq6m95frcJyyqpc6Q63GWnVipTLHrM8efD5SXHNw0S1LjRet4ZtSqZL?=
 =?us-ascii?Q?5a30V2n5MN7bqFIULD+n+ijwrmn13MD+h4qyRTrlz+ZDytzpwZNBgzoF1y+Q?=
 =?us-ascii?Q?Vqmuxz8eo9MfHq7RlwsSdWTogd/2EEawgBoUupByKZrNKp2L/ZP4x2rx7hlC?=
 =?us-ascii?Q?sAyp9reLvOGATZN3g8Zre8CTLp5LW5wcCY+xdSbkeNgo6+ut3dkGziN9uBZC?=
 =?us-ascii?Q?n3dtwb4iDdFIpMMbjhc1hBLJKgTGydH/pmQPrZXH37zBLd+yLJe16xWbEX+t?=
 =?us-ascii?Q?qmney23QLi+4qs8trlH98nNwWPycDN+Q+D+JPwYNVM3fBV8IFnXPyaHotk7e?=
 =?us-ascii?Q?7KhE5oDF8j2XmxHbl6lnNTzFHEMkqDONgknSv7mJF9UYUHfX6mQyEKHEp6Hk?=
 =?us-ascii?Q?o6GbDZmmBGEGl1aZN+luXh7EEgnl1VxdBcPvzXvRYU54lQKai2W6pYbxtBTn?=
 =?us-ascii?Q?bXZR1vazmulXsL9bOKLvBkMrP9Os8bo3cY5xl4ARPvqMeAdJFprRBWDjPaEU?=
 =?us-ascii?Q?lb38RF4whL99OJAWCJFlZ2rYoDOtn8YXnsIj5tAwO3VTy+TQ4lrDk2TLyord?=
 =?us-ascii?Q?LmeXB6aSYDii6/AbWw28gbSVqFbQUL3ojdg9bVBOt8OGUYfiafpI67gXY1IP?=
 =?us-ascii?Q?eqY0jW/WdzpOl+2u8Mr0VgpkUIgtkXSXf4beF86R6djqwyzg5fksHE4LQdTI?=
 =?us-ascii?Q?fNIDIAI0XIRlZpymUEZVsFOf8YiDf0gOdda1PfmKNicY4VQIkxsnwwzw/g5N?=
 =?us-ascii?Q?+HX1GhCIR67oHcUqzT+t6TISfohxoWSbMhdxknuUTzaNAjVNa5vBiqdEWS0/?=
 =?us-ascii?Q?SF4u6uB5SwOL3y++8KGfw6dMFF5peS6dGewD5YFBdXjl+RMqcma5qb7rxUcM?=
 =?us-ascii?Q?PUgX94QH9Ndn3aduEadU/8I2AF9LYK8KMyk3scB/RobHY/7/g9Bll2rIh2xB?=
 =?us-ascii?Q?1cOifMb0kwQKaAhGOgD9EUK6JYmdUFzRU9ic8OggW5BLGKIwRyY9D6nMc076?=
 =?us-ascii?Q?UtEGI5B4C/+/463XWy/zlpEgOLRX104u1dJocIiZ827kuTDXF5gzmnGDJbZj?=
 =?us-ascii?Q?wkYcd4vOzQwGegaH7NbEg+fUvhbvLOn79HjFH1UAM/lXqu/iKRjT61ZAM47c?=
 =?us-ascii?Q?VzRjbDrEdlGn9ChceX1LVkTOlJRm8Gs/vAvylK3uMQhTkR+eZRAd6i0wW4E9?=
 =?us-ascii?Q?q7JNPRTDzbyZeLBBJ/YZa2af7+HTZZ11wsQxYKiQX9yjTIQ497wVFk1DWuNp?=
 =?us-ascii?Q?UHC+TaoIaygXS8IXLc/BLJrWEXP9A2Y63o4XSCtgU/16lNFCDhPZU2pkC6go?=
 =?us-ascii?Q?K1tpI/TEMopH2pcP81NgXl+845mKe8MkPB12Nwr5w4IGxGBM4Hp3UBpb0X7u?=
 =?us-ascii?Q?tW+RqR/p8K8TVSM9bFNqxSnYFQM3GgExCHif4an9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a620f00d-93b7-44fb-80f9-08db6c7e279b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:22:09.0485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tb6nUvcxycx8dctYC1IxPA3lxcBoJuNxMGxs38X1K44hKNbreFWXkgOkZjmk5awAwVqlcuxoNa4YG5wWdGnCUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956

Set data->subflows too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c7c167e48d72..ea4b06322d78 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -108,6 +108,7 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 		mptcp_subflow_set_scheduled(subflow, false);
 		data->contexts[i++] = subflow;
 	}
+	data->subflows = i;
 
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
-- 
2.35.3

