Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634F514F9D
	for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 07:58:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1bdXjS1pfHV3q5IPToGPxQ5PcRz36jsFLdzIWUZi2vKIE7qhv0ZAxWbvIdmzsHfI7qkPx++xmngyGeECdc3ArSU50R5twbCQlb0ypZcFG44ZClGHWKlyd4gf4e5v3ZSW+kodMagryOeVSZUeyq08D8J9JTyz+5Ea26EYapS6hN+atap3pIk8EnE5r7+lzkfC+IebGSWa8K9FhudD7czyFcVen9fhXAGmiqOUBLU9+EPPwtH2qOqhlYljjzV+zeTgOeasm11qOfIFJGRiRJAmiTJpwNHegm0BdBRrL0MVLQgIgsKIKL1f93XavssFX1N5MkuWp+F3yQVBtWaN+f9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWgUgO+OemqX8Ms6JChBrr1ZC75a7t88JYd/tnDRukk=;
 b=Ng0LBFy127v5urFTLje7MCNKEDtEOyobQ3He1mNzungTy853rbSJ+QIFViuK3NxPnvoCDcrjvECNNhtjlsa9AwKFpHnHzDPRescU2iAzJxe+ZGQvO2VgFAoMIt3a1lKvI8rAuzMedWbDsqpid3xEzLzs0MyGpm5l4kLyE6jYfJfesymGU0y7tB6tgD9ZZ6ks+pv3tEDHUUZvWhkGCEd0zvduPtjIu5rzd3B+pvqKQ4tAy0ilpMpg45XYv6pvpAuYTHeK0N8Z7/ziSGY8fpVpBKjhnFV12gP2KMfp3m28DgTP33EmCQtX0kKgI+kHDNKrUuK2V/YIRN5uI5mOK6MrSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWgUgO+OemqX8Ms6JChBrr1ZC75a7t88JYd/tnDRukk=;
 b=lMPbqTd+wZmrWWEBmcy8W0uzMjLEU5hTEz9UtOn/7RuN6B//kRpukzSDvs3EzyhkuwktxnqbEPiKiZvU8K5AqVzYQ4wauw3FTCiRsLrv9QJyKrPDjgnfAQDEO3/CVcNIyhlGhIKSDUYDEyTI9WDBME6hEatV2BEPpeCfnJpD+LykJ8SBx40CnXbuTpJlIIwoTgBF/FKITO2qunxZBz/TGD/+pgPdjXz2/dc5UEPUo+eOm30Z4BKrR9QAWeo4S+A8LryOFBsOi8+3Sm3cpdbuhVYys9C89d9mE2pkkA5HHMUlHzCes2sStfhr/AoyaoFC2ZdTP5zFVRJnZfHqFQp9zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9212.eurprd04.prod.outlook.com (2603:10a6:10:2fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Fri, 18 Aug
 2023 07:58:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 07:58:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/5] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Fri, 18 Aug 2023 15:58:30 +0800
Message-Id: <1f754b89e2ed4b1f1904db88ff8f1109e4eb5835.1692344463.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692344463.git.geliang.tang@suse.com>
References: <cover.1692344463.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::15)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b43641-948a-48f8-168e-08db9fc0e87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	034q25NX0l4+gTrXOPtkVP2x4NumzF/6CJ8EuyV0NP4HtSAtOlaI9zNC5ND+3HIsS99FrOn/SVeRJWtfw+UwMd2YOlhyH/18DewSf8IuFfhPc4VERWskhShdhpzuJ5qc3Lbqnzf7CTJlew8SKfZ0sxr+u7R9c+hF5i/MnX0NoACFrnwikexiPf2um8FBblf+410lsFmvthGn/pYIIIKYfEj5kg7Sxrl/ihaz/bG7xn4tC6FUd27Fhl/cu4qywkBOLHuidIi+eDzEdxKG98/q83pgyaYOT4t9PvbN4HJMRajHiGhFgw5Tpmdo7KfKwXr6PaUt40AnkWhjSi8Cq7/QG6P5BJLEwKQx8VNGjpyLGsbnGaM7+GJCFi5IbAR/b8vESRcpuVzlRjaQd4klGpg9xJYtM1gPcJdc3b5nraDwPiJMc4dG8EFhYXYIGYiq7SMnRtHzZRWoftVJxTFeT3Kj4V4DmVnG1jujGiPzVkxcLrRLdQySczYANkxrG3Mjdyev5LBVIp9hSD1prxhE7XBdtHi2keb+8fYAUnQWCdELShz/pIoLysNpb1o6bHz3WxjBqpLEOgKKOBmNQoE8GLPfdBptXDdZuCPvVnw5dhr+Lr4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39850400004)(346002)(396003)(186009)(451199024)(1800799009)(2906002)(4744005)(26005)(86362001)(478600001)(6506007)(6666004)(107886003)(6486002)(2616005)(6512007)(36756003)(44832011)(5660300002)(41300700001)(66476007)(66946007)(66556008)(316002)(6916009)(4326008)(8936002)(8676002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MO/58dJLmNZgqXmWcDKDNftV7fPg9tM8FHGH30fjOxB8AMFFUVyRBjtJwh4D?=
 =?us-ascii?Q?cn0dD67B+7ZThMTuNcINgvKQMdSzt3LuIO6f4VDXDy1d7y2CIY+e63uQZ4Ey?=
 =?us-ascii?Q?z4Je7Qr9++bOTmtjLeicm1uknLwIO4CbNalILgWqf0Xj4GIi6KkJb+oCG4qW?=
 =?us-ascii?Q?uZo4YmNeyP43D68AN563FataUyRfKsgV+31nnAdIVi94WUQ30tZvdnwvyRT6?=
 =?us-ascii?Q?Gl3alNc5AgYwsoi30KFo1VKrlu+SggpiYaenB7HZOo+9vWHOkCgZHn4eoDQq?=
 =?us-ascii?Q?6RaP7Znd6yadvoryeh4Kl/blrkzndY+Wfy6UY0zaNbp3CEzmx6WKOL//d2H1?=
 =?us-ascii?Q?14Udk7ZjCsi6BeM7fYg6Zb3WucToeNUK86iY5MW57pagfUWufZlf2enynlfp?=
 =?us-ascii?Q?L/VzW50iwcF5H3cZl9Nb2Hfh9mWYTww8BlPyOpwPqY0rBeSY4NSKUkkGYN5L?=
 =?us-ascii?Q?8uuERj5AB4Hb0wiZG6pQFZ0DUKDhJjeSyIVOOuTSP/WKcNIJA/HrPWsGqJyB?=
 =?us-ascii?Q?3hqvslNdlFahqzHhcO157xtwxH3ActHm3Q9lcx/NeaY35TTR5gE8cMJkdTIb?=
 =?us-ascii?Q?EyWZ8iq+kZwqsT3kgWzpSfNzJ2z4vXiYbO6aFAzOYi1WrTJFCQ/XZHX5AmFU?=
 =?us-ascii?Q?0VFt2VVfhirWEW51XPB0Dz4rhtRciQ5zAR58Kq7XTN4+0JIMKxH9ktU/YHDw?=
 =?us-ascii?Q?fxd/otKl9eCA3Z31Q5Hq0ROvLJtGhVG97O/MWxSJQOeH5pCZPZJFPK1mPvAw?=
 =?us-ascii?Q?WP6b+IcQ0KZMlZc2YXb1KYX+umQDb3T4cn7QYEqvpqEF6mpkDSgbSLMnOwgG?=
 =?us-ascii?Q?WlGvdZemARBjeNImoXO0Z2qAm7aVm6YTteago03NNeL4XnqeUBTSrXH1ewlE?=
 =?us-ascii?Q?c3QCR3CEDeEY2WlBPn6DnCwrwigRAq+FHttjT7NkaHzBseSaUMGSXXFFy/Ko?=
 =?us-ascii?Q?n3uOPP2f4TB5Z4Ed4pTXnuM4GV6kuo7QbEwXZZ50D2X/6qfVqWx3d2y4SNk6?=
 =?us-ascii?Q?CudYmdb1tlq7Vyh0mTgIobAHDl8Epc81013EMBx9vfoU6NkXMjMdeOhBiE+/?=
 =?us-ascii?Q?IMDW2t6CSYE5Zod2M7WPd8ufvdViVtn/55rVSKVy7+1rjI/w1cZBiVz6HTgB?=
 =?us-ascii?Q?jB/fpKjVxbmK7yJsKtpW1pPyrkkBE9IWdoj7gXipxg1uHGJBEMfpbvy8A8P+?=
 =?us-ascii?Q?UAPbqlcDOqXTrScDeiGcLbRihtBsR6CpYVNRQ4P1yZmY57wVIXZX/ZwaykP+?=
 =?us-ascii?Q?/BiBJpu+y2nqiTi7OWqTIkvs8r05xYCmatBq4vWO+WzO9XlVrn2j4QUTmfSf?=
 =?us-ascii?Q?7VMZZ8zecwu09eEMciJrw3DLNRYnDT+RkbN/7wXjcvPcSfZYkc05FA1kK3iV?=
 =?us-ascii?Q?VwHO36FKLUBJXbr9QRZruFRcXLpcsQJ9H5CEo7J4cIjnKX34cUQaQa5Xg3Qr?=
 =?us-ascii?Q?WwPuQKLA26ZgbMLJ7uiE5bt5bJ7Xuwd/kn0Rsy+JmmSL1tOmF21Sb8Fvsz4c?=
 =?us-ascii?Q?e6TlrOKDGnxaOyn0x9MgC3NHyJQMEysLsYr7dFAODKOSuL5tPlBuJV79kX17?=
 =?us-ascii?Q?9hiH2Vxo86GgrbN1kBqruYT34UJ8H0vTWlGU9Ih7WlV6O+Th3QXlTc+8HwM0?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b43641-948a-48f8-168e-08db9fc0e87b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 07:58:28.6882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5VxDO6FClGDm14umL7a07FcRXxabuD+K7t6hD/DgwB46j27HGTLrVqwaqB81iLp/pjbUyC5tDRyACd4FD4BYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9212

Alloc and init mptcp_rr_map first in mptcp_sched_rr_init().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 7a5c058d2408..347ffad90860 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -20,6 +20,8 @@ struct {
 SEC("struct_ops/mptcp_sched_rr_init")
 void BPF_PROG(mptcp_sched_rr_init, struct mptcp_sock *msk)
 {
+	bpf_sk_storage_get(&mptcp_rr_map, msk, 0,
+			   BPF_LOCAL_STORAGE_GET_F_CREATE);
 }
 
 SEC("struct_ops/mptcp_sched_rr_release")
-- 
2.35.3

