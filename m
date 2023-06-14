Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841E738E
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+4Vax891lUMVHxu7g1vW1+n6JVW0MGhR9QQxtHqII0mORNOGUZ7jYcM+htPdVQ0PPWb46Eedvpm024qW+irwGSV3/tX5Gu78eBoUqHJbi4395q9g49SQYmjlIHxvknpHfZjt33DoZopv6FnoEeVkYeERTpjbLz0yvl7foGWsl8+6B9/JrqBJx9TaQHQJ7+Zp48ByWxBUGErzoOr6+3CtOZt3TjbzQh5YXQPALOQGG3A7+X8NDvV1SU5DoxPC22v0huHDGmqefB3/84CrLL5AdMWqb+yMvU5vGW+5sKLfbCUXByFQQZOvj4InDz3ZzPRBwqbYCNyTftsXRzWUBS3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfad4knLaV2NslM+yGZ7Ga6/rgK3j0RdtjE+i/CzcR0=;
 b=azK44oKoMzzIqz3+N6tZXDe0ZNP6u72uiIVMEuruLbonQQWbu64mbn6UgZZTmpz3pg9G9VVCbSKP1wV9Z2w4tzLUE8r9pXtALhbGkVFUMw8M2XX54yuauCRTYjth1kkLj3r/xkne1rne+b/Ur+EFZ3Y4rA+7f2FXmJ9ofuFIgUA+/odc1Y60OSrR2ETGZ956+i0XdX+Jui/s1im9nKz6wDXj+u/3o+DIAlp4QSsDz16XlbdqmPDcASqzEH8fmHTRRIcC6TkcM8ib2IDM2BLHmqjY8+VBtdn64I6peGwrSUwqibMKNk0zHD1dPC7NMUq6cg/eDSeYoIYPJg7Dl00MEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfad4knLaV2NslM+yGZ7Ga6/rgK3j0RdtjE+i/CzcR0=;
 b=bOu/if/Z1ZbKdVJ0jHXxI1KgispB9m7DCnJwElk/cAamMuTSQnBtjO5Vs9+v06SgjyCu0jWuwhcK92gb0URDukLSwqP9vNyfvsJINuYnOZDZ88e0H7sayEa2P1aPeGyMwI/sz1T4ZYcp6RJESNjEWMZXjYXECQK8YFZryIXy1Acs8Wl6YjdbmnnLa+vfd0Afi/W0XtP1UuU5b3lsdKsXublDT8Tc99LHO9AJRTTxXY35KF0jBmYfyrnlXSzId7g2b/3KXCLbVGIN6hrfYDEkIIhp/Q6fD+egG153Ro4J4Xdei0ZMp/AO6Q6SZmIha+pGQc8egh7HnAt1WVB99JxTPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 02:23:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:23:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 10/23] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Wed, 14 Jun 2023 10:20:57 +0800
Message-Id: <6b07055614d61ee2c2c5378f45953d5e762f475c.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0040.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: ba862fc7-0f89-44b9-15c4-08db6c7e4ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	It14+1H7xnAZvMp+DrDx6gzOaOB7GiKms+zE+4qXKvH4tBhl5VxHQnDRGvFH3Lw8tSJFaEiIRgpZc7yYRzaSZ4hLMLkPdvGEqICDZgH8AmLYI9VQHGZ+P43qhq1Z8ob1RsWpDH7XuaY0yIPojhQzy44tcyX70MvOAttTinahN/rQfusGV1ZM/e6urIkJdOGAIemRW1eohZqFYoqmOFoiw6X0Svcj2vD43Zmv/icer6O5DW6LNCoa856wz8hUxCs+WTkbvXfGU3dJxd0jCd/qbaOB+rIc9VI6jMIOoBc3T43I7RKz0DJRvRUn+t7VyK/xElfvVrB1TXC54KXqVlls6XNK7qHerxKJylumuKYVjUKmgQu9HPL4Ai7CYPG7HOfyUu2PVm00UKMWL2CENXbkHUe63uZzwmOQWHRYLfrW+wXi/phYpvALVHaPtBYlNJd1jvw9w1n5hPHG2Dj1NwXPNvbtAsQPhWRbMYqDVUKte+pigcrm8sps21zB1L5SgHvDfAv8ZVPv4C6T0V/lUzHx/Zkx0fV2chMWQqqdaD+RUNAsWayTkhtH6xH3zy2KZchO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(6916009)(66946007)(4326008)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(4744005)(66476007)(8676002)(6666004)(316002)(41300700001)(107886003)(86362001)(6486002)(6506007)(8936002)(44832011)(26005)(5660300002)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tC25x8jQmVKo7X7clA1YaOxI5ciHYTwUUugjwpfuATCkqjZVejGfc0yOe93C?=
 =?us-ascii?Q?N2Y9Sc1OmonSN0mZgWfLTGUCfUzCEtgI3VIzYWupginvGwYFBknf8HE06MCo?=
 =?us-ascii?Q?lGH9sLS4Z21zGPHNnUAi3MjtyIz1tQktpByYGWvOib8DFftOkkyN0InZCJMR?=
 =?us-ascii?Q?7hkH+YQRh7fgGECpZlkPDFa+LAB4yh1q04dj8VxIxEnHJN7EPmnrDuuIB0cC?=
 =?us-ascii?Q?N/Hb9uDteysZtFs27K2SxK8HD1rOOHr2Us/vo0RpIkReqTpzNXgOF/pch5As?=
 =?us-ascii?Q?tCGaMBmfqJxPNk2lTpWWaMigQc/IKjoMoCWZ5fEkFZYMNbOs919iAY292WYA?=
 =?us-ascii?Q?ZBOiEcRJixkM+KxjWxaSzfsVywBeAY/QrGWGO/CQTDY+pqniIcnA06eCKt5H?=
 =?us-ascii?Q?wwRPUHUI/3EYteOFj3jisO7FqwM9hjORRDzuEbVfokOHx7NyHGq259M0UGr+?=
 =?us-ascii?Q?5/8VhrGeZSMPjxBsO/PlBbc/QQ/QARq6IT4//XntKqZDN/B1nll4Tg1Uf9p6?=
 =?us-ascii?Q?JOrYCRlJXEAmdxCNb338GHWOlZY0h3XGI5WnMqTFaw6t7olByakEX+l0bTpN?=
 =?us-ascii?Q?1YmC6ibIQWyhTqLD3ABZRDpECwFdFD/cxiiE/OwQdCDFsjnBRBooRuvzuOLU?=
 =?us-ascii?Q?Q3TZ7t85F4LsFp/Sh6tEpsHFvqHbZJVz5KzyYIOyO6n4cTPTjxW/+UabMPvU?=
 =?us-ascii?Q?k2WVpdk/su3MhjP1Pf71UgKu8FBMe2loj3nR6lIa6J/u6GNhE5Un7vFzK171?=
 =?us-ascii?Q?3zUNic3SeARJk7mF+9g/QdT//GdAs0svt8gi7QlygkI2GlkLbNHOhziQLkgo?=
 =?us-ascii?Q?67oa9CDahblok8Sj82FovGXaauIbiwvEI9gXcqdikucD0CKizSMEBQbyxMz5?=
 =?us-ascii?Q?Ye/6K2B4HtxV/1dfqW00IbSrJFYLreU8yk9n8XbUhU6BHi29HUFwSfdDeIfR?=
 =?us-ascii?Q?CCHlMcx3CvUv6hW9GI2zCOwVIB2heMhPBKm5aIGY0c3jqew4E0CXq7GDfMyB?=
 =?us-ascii?Q?D2s/UoG1sRPBA+Zgc72f5OiiUjZs2faa3tOCWReUQcJZM/tiigJNt0orysDk?=
 =?us-ascii?Q?MaLdMynuxBBWIty0rPufw6wSO2gXujBgOKk6eRFa+zql8WSUu0CtJGPhxRNy?=
 =?us-ascii?Q?2HG6Mjz31r1vP/WDj1A/D0T3ksUiqVjinxzsOdr84wbDuYonnGzq5GY/AoeO?=
 =?us-ascii?Q?ryFmko59AQwHzNPzQOMhv6aSAlO47vrg49bu4dy2PjDCKT/pYWI5ZFH428zy?=
 =?us-ascii?Q?5kIGoUMWM8XGvSgyWHyvZJvhUs+hZMhZOIZN2b30BnLJzMshHzfMISBzf+op?=
 =?us-ascii?Q?1dompIalUJxzeTnwa8SXGqCt8lZH1FEH2BygPect/+0K7Lm276ozVdAZYstL?=
 =?us-ascii?Q?lArKf6Kut60958TUiYfy7EQKsyfkr0I6WJUSo63BtLQBVycsjTDhIlofrKK2?=
 =?us-ascii?Q?8biY4oYH6TqXiHjGK1kRwmlAaqBVVQeYtsavPHn/RhKsB8F24irM79leVHau?=
 =?us-ascii?Q?Bu/9w0KriLVREz+b4fVcBayLsuwCG9eRtwnJod3GsXjBfwrlCkFBB+CWw1VD?=
 =?us-ascii?Q?Gs9kef3mZPJKPfMrOOsppkWH42h5cC4vPhJS9y5E?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba862fc7-0f89-44b9-15c4-08db6c7e4ac3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:23:08.0075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: airUqBXliepvUZWJ9MC1bEiHG7i9jQcqq4LUV6g5/rCwYo21rVLprMYtX28un75qOVQhzcVHB0Ptwa4yyMAElA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956

Export mptcp_subflow_ctx_by_pos too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index e2ed4223617a..0558e6a0e794 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -172,6 +172,7 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
+BTF_ID_FLAGS(func, mptcp_subflow_ctx_by_pos)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
-- 
2.35.3

