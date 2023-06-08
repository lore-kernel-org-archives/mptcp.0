Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22853628
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 05:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+2eavt0QFFyBZOgW2LFbCVKrJ9BINg0o6dAOyd6WzoilQvD86S+Gkfne7sV2T6dvkbZ5NwSpuX33P/3DOgReDWaTeCIaIML+C2tsTWjSmSrkOVQPtYsFpT3sLStrsKfPx1OwKy8TAAjaFEA5fJx+Cq0VGvC8SdvZrKXkgiS0/NhqJ+L5P80MJRIq6NwWQXvWn50oVAW5wQ2VhhUR1wAbVtFRaZlxSRspH6WELsvrlsbMMGIWAS3RudthL8VN7MECQVV3otCjMg/j3N3jT6LHvGBYWiRoCMUDD1LevkpyU7fjD7hzpSXMPfBzTLEeP2ABV1qGQlZzc/82Y9kr0gWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbY6l5z29I2ZvyBRHz7xvWbDR+PfhcmGG6gZ6gC2l8Y=;
 b=bg6wzfuNHrv08Uhfopb66OFIV+dy+myQ4pB0A7lf0Z8Gw9JcV/uRbMYjYjnb3O7fNI+ikMcmZKn7eS8xyTuCurmX+Q2+FWkJcYAf5+olkYpB06XtE6H3i+BuUYP49tCOkgCzKfsZ1B01DFRXyHtf0EmuFqlvR48NHTR76ju/RyvIe1tcTDTbxHXpKMBWtwNMA68tKGycZoj3bWWFnfRnffYNQp2N7rco5o/l1D8LC2pKYchJ6HWQ9UkIOKZWJDeNw8y/41UoQAL4vdjKpc/9mvMdoKq7XRZ1jv1WAOmyCTOnAB6TRc2738EsZY3tEpcx8t2hcnSOfXXVNI3P+TygIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbY6l5z29I2ZvyBRHz7xvWbDR+PfhcmGG6gZ6gC2l8Y=;
 b=AK3MnAj24RsT2qzW1v2N9plFGAs2VDT+6JZlL+pdCgC9XkY1+MLMXm9xUT5iFiwi9sOmMhxbLYbCP/f5aTpcb2Sj6oyImpsajbJyHZgmJe3RDrTsHUP17m46RD8T5Dfa/GZeAlNxoGNGPQycv4R9EAI+wjqh7G7b7fJyyP2vZ02+Vu4FQFF8PeN6hgPuVmIcsGmbX4WpmjEjNtc9AJc16J0uHX+PaCX9fpODc2Zl5cbWG3RaTqgVuIYRxj+rGr2XL8P5gnXyO7W9KJM0fEIIU4AzJHiL4mNjsniXR9T0ilxlWshJxv/SAuP8ALwoD+ZFKsHtz4tOqVsG1mC9S4tOSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8609.eurprd04.prod.outlook.com (2603:10a6:20b:424::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 05:48:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 05:48:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 08/17] Squash to "selftests/bpf: Add mptcp sched structs"
Date: Thu,  8 Jun 2023 13:46:46 +0800
Message-Id: <5f7948b55536627fdd33dbff5d763f4ee3f5769d.1686202841.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686202841.git.geliang.tang@suse.com>
References: <cover.1686202841.git.geliang.tang@suse.com>
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
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 8074830b-28c5-4231-cdb6-08db67e40364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8eg2ZojDNr8eAJEOQ35+qq6T/y5pTckMwv+mAkZzvhg0hMGhvxLBC8rM0l/oghPCTOmj0OFmYpUnWdSz9ScdGmzYbK0aUKoTwjtxNvVZtYwM1YqOebduYvQEYIHqxW4rc2d6fgin2+qqM4HREwontpLoeqa4TdgALxEj3jQV/FuneAKYLSmbH3fUgOmh54FVoVD+aLhi1kDFNf8c76Of8X//RllLcYEY8dDVmYSxPzdVvq3qtuCfEOmH+NwklrlVaMPdtJnBRbxEgxusOZLoOEWIaji0fNQG6LhyVy4TnksI4xZ0iXZo3kla4jBmZkGHdNM3d9MOCe4MYA+mOkzSL1a20jnhpsaFf7oogU2i0OSdnsyQsNQeoflVM2vHUK5joUZGyXWvM5dEOd3rLbx+6bpCToL4uliXQ2sCvsSb0XdIZVmIqVM/+41q/mdBZILD+SdXNpPdnLwqiBuxfE2OHRzZxtJ9AlV2gDyM8n8txiXNuLUJXo+vbUS9yzewuGn2DDgSj3ZObg58jgB/QTK+4cwJ/SM+GSitVsduMgimt8ubaMeyb4MROuzexBncki97
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(66476007)(66946007)(66556008)(8676002)(8936002)(36756003)(5660300002)(4326008)(6916009)(478600001)(41300700001)(316002)(6486002)(38100700002)(186003)(26005)(44832011)(107886003)(6512007)(6506007)(83380400001)(2616005)(86362001)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4JoFXSt70pnGe/zKUdJRpdeBEHQYhaIEuNxaEofBsPZca1tvC+qV1xLc786J?=
 =?us-ascii?Q?/MMAQKhP7idHwgGDaUgqR9LVDUQfhrj9up0cocws6qWmXCFaQ1eIjJgcF04W?=
 =?us-ascii?Q?jaWbxevHc5rQjlf3sU1FKOS6PQ/8K51nLiNvX4fU/oPLdL+1ZlllaGdNN/WE?=
 =?us-ascii?Q?RhDS5eeOvOnH2wd2XYa+8HGX/v3rZIhzT8f4egaS3tfVU/384OkrCA8u4uO9?=
 =?us-ascii?Q?1Ztim21hoxLVZ11m5gU9ZSHvAVWyilTI8dKv+j6mL8buPg0DGF8fvA3UiaK5?=
 =?us-ascii?Q?GgAd8+Pgpl1SrZobTPsgLIaPz94U7Z+H2WlbZ4tD07FQn+OyN4kxTZqCMktQ?=
 =?us-ascii?Q?ANpXi5pcTg27HACjfvwVgqcb5r2ywtJfp7P4V0yWQEgM71lKK5WiE4aszp/+?=
 =?us-ascii?Q?v9rV+p+/bPU1Qeod0Rfh0/e3UyEq8ZH6YMdAVuu0qjVCsqXCM8SmkwN4jNZY?=
 =?us-ascii?Q?sJhe87VmqqjjZJo6vHKzKbJ4bSW7bfFRC1rgl/gufKEyeqkSie76/sspIE6g?=
 =?us-ascii?Q?5GwoSNakr8ddHL/VR0nzdeZs6VcltzYO5QQ5PIo+5rLTAaCtU9enmPedms0g?=
 =?us-ascii?Q?xUtv04rx3D9jG+sIWIbjpL+eDp+aNWua2w4FIPwHVnHt5H2qA+DlS22bUfGi?=
 =?us-ascii?Q?c7iLAdd8KTgPb3nBsNf0SKNu6gjPCPX0d2jS9iS3eOTQEDHPNx3OXVB4K9us?=
 =?us-ascii?Q?FyTtYDgkWYoCtGOEPRbsSCzr7dP9Dktki+iFnalDQ0Qwxo4+1YHkM9PkITzb?=
 =?us-ascii?Q?86lnnI8k5eKxKPWugMFr1MQaLYqWlVHTC/r6f0a+djkjo6t2cj3soSOUIzn5?=
 =?us-ascii?Q?w3eAGZk7ztcWZZPRTHmSTFlLhXFmqF72CftX5DiBK6hjlBXgQK4XyIZp/T7Z?=
 =?us-ascii?Q?dPO1pQG0QFfl6XZHrClmWGGEvJ89sIOJm3M7wFXDkzDzBkiO3VUVpaQbBkpm?=
 =?us-ascii?Q?8zLWQ1pLdkTzanzdbCp1dZK6jgN7l6mMXAIu0LQlRHSIk9TaIrlrhZFi25d6?=
 =?us-ascii?Q?qvQ4oGX9LaJL49zQn9ljvpEtKFOLetzwyqOFqnV0VGbSJSPPabvdsj0ieOEm?=
 =?us-ascii?Q?hMlSSTwaKi5VPX3MgwE6Q/2veZAurg8wvAfat2Dfp8tJ7AlV36dOVgzvhTYf?=
 =?us-ascii?Q?zF5IbvUNcj/kHWqwVYwc6KJ5dpcfBs/q3gJ7bT31fYWs/rsjPWKLfJ3CQyqv?=
 =?us-ascii?Q?cKPwpkCXzkmkvsbVX8cjbU/+lm0Ia/9uJ0fGnZYYMRCb3vADmmZIqgXZYy0J?=
 =?us-ascii?Q?U/7XlCFZ1DIAkDo0mZWsaPN76Mz08bIhy6svcF9ZUhPGvY0dQDJJHp04TqIR?=
 =?us-ascii?Q?lBwkjn6Ge6o78/fI/H5t+K5wmeNADpj/Q2JkU2KxBdDgNyDexXd169NQMuV3?=
 =?us-ascii?Q?alvsSvQaycHSBDky3zj+sg3b4//9wDbQrmexCFFg0hxwNhRbWlQ4vLhhuuwS?=
 =?us-ascii?Q?pTm8hAqHSppOJdej6cDW8QNNqJ4QBF3ATFix4jhC3gvcXKkpz9CwBKr7VYWj?=
 =?us-ascii?Q?Lk/hHWYv+tLmFu9jgZ/CBo9vIAbmuc4ZJbHLZF0t2xCUCylZxFX+h7v7baN2?=
 =?us-ascii?Q?yoQ/wUiFYg/ZR+Hq0PG1NqnJkRpOT6EQbYb/8tRD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8074830b-28c5-4231-cdb6-08db67e40364
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 05:48:41.1204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OS3dV5sAswCJTy1GXzuYbWGMysBHKawsvYbpn8qP5uBA8LjoIyXphvxmVuyRtW9ATZdiIPXw+mo10/0FaMwSyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8609

Use two tabs before reinject.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 72c618037386..fcb023a749ad 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -239,7 +239,7 @@ struct mptcp_subflow_context {
 } __attribute__((preserve_access_index));
 
 struct mptcp_sched_data {
-	bool	reinject;
+	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 } __attribute__((preserve_access_index));
 
-- 
2.35.3

