Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A71D7E
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 09:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emcLmXwoaJuiqd5gN3CvIkJL582+41FLgz7GjA6kxZnYZ7RpHPy0I7IcDh9zF55Qlyo5p3+w2YvIYAHn9YmKs5UFxcNoLyKX1azwtyCzBbWDLU3syDKHQVVvlXOwOIsTxhDyDrXB/kTLwlW74+iW9jph4x/wMn/49mkcoKW/EQhLiKFup9LlSsAD7Z9mgX+8J9SkdHAaRcSRGvWwXGIv6Fjsx9X6DLxmJGVFuLyCppHuoquPMBAVhgjKVFncOcwX1dptjrCc1mX1Ew4r1f+C5y6GJ/EhRhbxLdA/7Xp+3CaAbwNcz/UEqFSxT8yEVMUKpaYnt6utnZGr/gbi2M/Thw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvmKDzhXVlSVOzhIgE7tAribL+3XC6XK6HbcnqpVjkg=;
 b=JfWXzRK+fzVIJ8UqUL9a/vWqFTY9l0+BNXD8MeLCiD10qKkVbQ30jDY53j3Ukamrkv/9yTYmZTD+tZYhP53fmxUZCrlJ/v0xSfhSTnWVoH1jqXzI05G9cDGrWWqu5IcHR/wNGwgx6FaVPI0vt64d424J98Yi5j+6kBTT/NPsDHvzQ/0uHKlamkXsYdmDVRsV8vR3RierDVVryzE4z3gNYjYp7ZIxYa1b2xm6uZl1cM1S7bUBF5+VgnddydFQ0jJ4GWJZRfbkn5eMXWgdAdOJ2oN7oS/Q5op8ijxEyXCX2pvcKXn3p+p78vjgRkdjhZaBB56y49L1fLPCwPimX+8SkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvmKDzhXVlSVOzhIgE7tAribL+3XC6XK6HbcnqpVjkg=;
 b=brB+ADfj0V78XDMFv19XSJ2CiwgrPFyhcSxyw/gxwiONrZT2UT3RZpoDy2daJt542lQmlGS19tnF75MGBB94EoYtcXbe+5To8Q2P8M8CjHPyP3wHJLLtgC22JamyLvy3FO8KtcbBbEV3I29z7Vo4HmVPHbY2PC0HHBnHv3Ed+Fglm8IWWKyHGco6d/XStuNtgdGjNs24NOHDJP0MTs5Rodws39/whxa44luFOIJEbQPdqECe2V4tOJXVP3/hc+yT5b/H/n1hkHhoqt9Eav88wUkwQG1iMSXaIwxZsVmLA+XpPFCTLLju85a+Q/uiEI4WWa4AGl55XQkUr0HwpXNYSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM9PR04MB7716.eurprd04.prod.outlook.com (2603:10a6:20b:280::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 09:39:47 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 09:39:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 4/9] Squash to "selftests/bpf: Add mptcp sched structs"
Date: Mon,  4 Sep 2023 17:39:23 +0800
Message-Id: <3cdd61879c23d5e02af0c2f5cec88430d00eedfa.1693820153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1693820153.git.geliang.tang@suse.com>
References: <cover.1693820153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0009.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::21) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM9PR04MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: e94e5b48-1890-41e0-d64f-08dbad2ae068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z03z0UShj0DofiRad3bH/JDc9yU1uhkAdX5LDZjiLzwcw4fukuTHzZ5LQIjgPMNFGg7hXQNqJxRxm6OL5PkHfvQIHRPddvB3sP5BKwrc60qALzK7GX4TpIb59ji7I0fku6kZb4KlG6YfR1XNytfh8Pf6SBGqC07X8iya+YicE+L4UAktn8odCGMqB+AF3eb22vShTOLw74TIIuaVmKTVuZx7IYvcXPWIL+ukuh3cOfeR++uer+vaAzNECpoiGSBQzGsqS86tS2ZVxVxmUCiKyY7buFrVsf3cGy9xQfa6NGbSF+ay70bf61g5RzUzyNUZX+wvRYrov+cbarkAfR+uUepZ71jp7IymrFdXK8BTUxgPhpVeE+ZHC9HZnY/jJaH50BEhsD7G045GSvAiC1a1Yev2TjJlHbBxLoKJylye8azrdjw0wc+8LreFgCVXUq+sxRmQ63pqxb5KaS9O5zypcbbsVW5Y13awQDO/QnB8Jjf1BT58yzBaZQo7lZ5zk6YnWvTlRtGo0Mo4RLj/Ad6wxwZSrxf2uLqj42XJEAqiajl6gcPWnakEsjF4S/vCjoaa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(6666004)(6506007)(6486002)(478600001)(38100700002)(83380400001)(2616005)(107886003)(6512007)(36756003)(2906002)(66556008)(316002)(66476007)(6916009)(86362001)(8936002)(66946007)(5660300002)(44832011)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oUbTxOuxYUbsf+d0WxzufV6u7abBvIJmPFuPVizujz1rEk39SKpWtX+wYvmd?=
 =?us-ascii?Q?ACgy9HQ1ZRbFnHG8Avx/SyG0XULBtFyZ6turQOzZ0HTXQ1WnaXskJIS6bjFY?=
 =?us-ascii?Q?LzntRI6uO+Z8YKyl3J2sN9cN3Tmk8wK1yBz7aS/wF8K0eqE2P7jlELo+QbHV?=
 =?us-ascii?Q?RinEoFDr7uIQ9kGW1fU/mFLH0d7c9pjwSOsOHVXdVUMveFjHPpglawUTbhzR?=
 =?us-ascii?Q?QJXq+oL+5vqVd3YO/wE5DWtBFhR0sv+/fd02btdZ9CraWq4/cICFegWIUqw7?=
 =?us-ascii?Q?2kIINf+QBp/yuwMDznOuf1mW3RwE0qkKsUeNxwL1vTM878VRcAvwEV5GAdcH?=
 =?us-ascii?Q?32bzKLhg8gnF0yfEx3QfAPwR2Fhv1Rh/0FV3EgIHQgjPm7iMKDK8i8CTZP5w?=
 =?us-ascii?Q?jRyOSB7510obzBUDK0Ze51hW5hlQEjbRP4osr7A28FCL6A2T1DDRZf2kEkWE?=
 =?us-ascii?Q?P6huH4s/mfU3icYd+T/U75huo0xLBZXB9QoW2hwt+LmchZrLoZbKfM7nsJtQ?=
 =?us-ascii?Q?GyoTGyqtmVBWSn0qqqE8pVFVsKRe17a7/SzwwNIWTqpRzYTC6JX0rE4r0hut?=
 =?us-ascii?Q?zUeyq5JxyW7F1t7w+PKsmJ6liGJA1mo2uobJ+H++Hi2ro/nOWXbzprlD4F9R?=
 =?us-ascii?Q?SyeV3jinLHG32Eo1QO7KjmO+NICPscv75LAZvZhdfMjyYf+JYZOqVxnR3iRO?=
 =?us-ascii?Q?7tYRmsmcNmVkJROi2lJzdW+rQJcm4p4ZfTcugD5qXj05ys/6zt/iapWXbt0/?=
 =?us-ascii?Q?7M+G8eEjRmsec+OTM0M8pwM5anQAE1LOUfAydvOxOs6uQDhD5rLDweAsr3p3?=
 =?us-ascii?Q?xHreIcKXPJt7PJWB9trUeQivfPG6oTeNUlPamownkML1Shm1uVjywTWkQWG/?=
 =?us-ascii?Q?Kb99NRDvKjoUX+Fvcp5k+0wkGP317tH4z7ozREcTnGL462QXRbVRuVl8NSL4?=
 =?us-ascii?Q?ZTpfKhB6gImxA8m2typLRCFTQ0+yDJaZHDNfIBHkrLzSAhj1BI3Sq8d5H7Me?=
 =?us-ascii?Q?4jPNHskMV7Hl5cx91WZDNLv8vY+rhRAS9l2EGzY9SqopFt+tmQVg1GxFkSEz?=
 =?us-ascii?Q?Wjj0vVUmhvLLfITZinPtwToZ7V7/jhTR3pPkrSv/w1Vlj9bhaPDe75ovjsBJ?=
 =?us-ascii?Q?5rhP6zROodYPDRQ8VGWmBZnNX6RASZS2BrSgaJNMkUVRUFs/PHb51bE2zXSA?=
 =?us-ascii?Q?t+LRkJ3ipdIiZNjl4k+RaPOpb4kNDymIetZOGQtpYKq19eWDgvSTivSv/1FY?=
 =?us-ascii?Q?D9btQ29gmq8F20ERf5ZRA0d1aLdUIW5baviTa0RJPK3rkx5PraDp0WRo7AKc?=
 =?us-ascii?Q?DTRCqoJCLrtxx7CU7rK3UbwIMWKNX73oXJEhoX4hh9mupBfWZHo4M760n7dE?=
 =?us-ascii?Q?o0ZGr0Ui2Ax8OH1lILyTWD/rn0eN+1/26NTxhLh9A3qmxgVxKRuB7v3TtXRV?=
 =?us-ascii?Q?aGsZAdXXVzosKlTLOGYcNQ9t4Ia7/TCMtP7XAKp2XWMB5PZRxXzNVo+0lzOT?=
 =?us-ascii?Q?cgje4yOYP9yUPFhAwatuXXo3rngKx334gUQvlb2LN/26wWq6HL1+QYupXDyM?=
 =?us-ascii?Q?d8QoFZMMzgb2oLKkkyjHHIJdM/BDpxpnCVYIWFIWUh595BUKdohg6Knpx5k8?=
 =?us-ascii?Q?YMQJ2txZRylQEuCuWycUsaLjc43cK5LGMRDFCuIt4IBA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94e5b48-1890-41e0-d64f-08dbad2ae068
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 09:39:46.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhAxmcC9Rvc628lp2gVSU3tMrpoMEN+b3DxTjb7dZDQWnk5NWVtFWQISOyCEjNZMrw/pjsMXf0qH4gPby7I6ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7716

Update mptcp_sched_data_set_contexts and mptcp_subflow_ctx_by_pos.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index b687f91f2da8..36a53381a4c0 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -269,10 +269,8 @@ struct mptcp_sock {
 
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
-extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
-					  struct mptcp_sched_data *data) __ksym;
 extern struct mptcp_subflow_context *
-mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
+bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
 static __always_inline struct sock *
 mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 {
-- 
2.35.3

