Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2048.outbound.protection.outlook.com [40.107.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6ED14AB6
	for <mptcp@lists.linux.dev>; Tue, 15 Aug 2023 06:31:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8HAwHvvgV65nKStxmtiuinOAxgU71+SzIWCg6Y/n/6/WJ5bTynFMb26470IHrrisun2XQQTkRbiPyUKdh7VChmnViFChXMZ837GCNVP777mbKoVho1+zPxw9EutjoYpTtpXBRW3bUwNkcSbdvxxdPcgH3AFhNziASnmDbgOkwjGVIWpqAJlHpLQb1Qv/bzTTTLBoh3nq/URYVUS+xuayVPnhrFmX+i6z51XWvbL02kgTdK+2tr/S4a990BbRZ9i9IGRTksgCMBgVk+8Dn6aLFxKymaosTKWslLsB5fKGJqxPCro38f3ef0z4MWKCXc4/JezJfC8PxEv9erDqGkg/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itQm72CyIQjHmA2SkWM1Dmqy0u+gIj4PJbV2pe9fJYA=;
 b=UaTltGK5ORcL3zi/NEmP0tXR5aaeoxtEaosCR/RCeVlyLWi9RiArCj/mHIpWyOfxUPpF7Qq8sOVfpTQGuYZ61ZCbn27WzdHymYOHhjr0MuJQwFSTmG1M4LmXQOwWuP6S/dAhd5HYjmDDpAdtLyJzUslNs14+rcd2uzj95m/P+aQK60nSQznJ+PyrDYor2bS0X35OezAgD9LG/Eh0VRFjm0L5vaAblIyxhCQEf/XT4dqCCxR7IUTNtPbx2RcrLW3WQPZ9rKVVd0PwTxLQpkW4SEaENGlFJWjoU5SVzfEvMVozdCSx+5Gns0ajmdirlxYRmIwVHpfrJGASuLMmClN8rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itQm72CyIQjHmA2SkWM1Dmqy0u+gIj4PJbV2pe9fJYA=;
 b=uQjthvpf2sc8BqlfC+O+evlJmDPqo62IeQT5NhgFOyUin3FR+wbbUVtSXlQK28rkQlSMzMe32WbGPqhYidftqiysrqnLEuY7ATlY+6Z7cUHHTrdCuoaBzbKDzPGQYux9diDTik4mOillcJ5Ek29mQp6aMd9eGyoRhanww1CJlq0Wn8vHJnMiumzZY2Bpl0fXS/eoOZmysbvKZIK2QBaA3dYEtj6UVmEHvBmltSm5MznQAJ0Z5XnA6i9shnZ5No1P/7a+cBmrZc5izYLkKUVDzGpdgxEn5PZ1CwbV9MZpdp8JtZHpp3y7N8OCDm80Lhyo1TRk719Rh/6/4mRvyEJjqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7239.eurprd04.prod.outlook.com (2603:10a6:10:1a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 06:30:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 06:30:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 9/9] Squash to "selftests/bpf: Add bpf_burst scheduler"
Date: Tue, 15 Aug 2023 14:29:29 +0800
Message-Id: <6608f9d9fea9d2bc57ec8378a7afa4fd52c66d17.1692080803.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692080803.git.geliang.tang@suse.com>
References: <cover.1692080803.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0099.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f620f3e-fcf2-4ef3-db6f-08db9d5930b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3MMsnFrc8boXoQQEWiviC+NR6wvXZGzFDK3vPLFvurOGgXwxtS2RK1IqXdsfB/sJyTwOA6YlusaS0vyDECiESpCP4mzwT4OW7MPpEi6BQ3JWbO4uTey5AyhQzTKw3EA7HnxIN0GMfSYW5X+FTs+Q63dOJUeiGeZM5gOTvdisupz8ENeVhmHJAVylt7gD3h7n5ZQbyTiasTB7oEuqo2vG0iy/FdLZhBxXR6Wy+RlkljMZHJ3EtRryGIOellNaWfZjJXPRqPOPuI04qXGj3ushyhQ31neDavrHjqfbiATfhzoPS81VIAUfvCjRZZpcK/jX5FO47ghB8TbHnutbe/bSpxpR8vY6OiJxDLR5n50YD7RE9rU31mBkEVs3/tMm9QKZxKyJOr9zo7TuGuEtS/05yri/tsAfRCbNAT7COGcCZuJaydrZ3CKKQUucu4h6UinxXsa/Q4KWpYxAVMoTSsWATtGJJKREbediOT3SRvr40aWzg7EhUbD2x7KjnBFM/UWMpkk4yj2HcOjkcpUoh1Rmld5CKnIqI9akBq+4KKu+NrxLSvd/QFiVQcZf9We/OFUiVPQdzU2El/jKnvDMiPYh3d38Dxd5cBD+55VFoaz7UUM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(1800799006)(186006)(6486002)(6666004)(6512007)(478600001)(2616005)(107886003)(6506007)(26005)(2906002)(44832011)(4326008)(316002)(6916009)(66556008)(5660300002)(8936002)(66946007)(66476007)(8676002)(41300700001)(36756003)(38100700002)(86362001)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0UyTgqxuhJByrvLktRBk8GYhxOt1S5MY6vF8KTdVf1O4vR4LtHUKzHS6YR5J?=
 =?us-ascii?Q?wMCyRrFGGsie/v53n9y/VCI9uAnjj9XGWJgGSYZrti7wTuZl+PgRv8zLRcHJ?=
 =?us-ascii?Q?tfrMCaGIZINwY5jAzBcFzE/mwO9xNG+7Aimrba0XdwzC4pojva3COWWMrVOQ?=
 =?us-ascii?Q?qsOKF6ALI7slli5j+GKNxOGYh9rgw2yppuu1QlMsdfmRPcClECwZlI6J2c1T?=
 =?us-ascii?Q?axjy1dZ4+KpmjauYoaOSS0ByL2trzRrQ4/8mdB0UjC63bI+nHD5aGtEekJQc?=
 =?us-ascii?Q?NL4PtrWVfymceKIdeZXcvv+zLX7oehwNnH0KCMQWcNWQRn92Nj0DnqRVxGDA?=
 =?us-ascii?Q?m3dt9WQGWAKHPsDshZm4RaY4WI2Nv5wxIZT1d7zow572tFru4lrt3cISFWqb?=
 =?us-ascii?Q?iAc8WjAjYz6pZVQTGKeJ2PLM4fqFhUFurPqkDT8Ey/k8tQ943Xa104/cJTD6?=
 =?us-ascii?Q?W9OyZChIeDXOBr4ApnkXm+zq/gStn2LZVwaPhKm7rECriu8WNWwHkMV8LjiI?=
 =?us-ascii?Q?5PjziPn5rK+ZpejO7THnXFMySN1disOnGvI5ug++jM7nyEkiPuPKbpSa3E94?=
 =?us-ascii?Q?SiRn1itVXVYvkaNHp4fLM88/DGozR0Yx0a7e7rHRt7BPwBHUHXwpSNgl5mHN?=
 =?us-ascii?Q?PNaQ6l+2GkntfM7++qLq03l5E1Nula6mbH83oa11pthgVRo1+Bxvm3Nsx17i?=
 =?us-ascii?Q?ZJcwkMPsDyo0oGY9/OI/+gEQpfY6q6D0DoytaMfn34n4pCo7lC69PdAxFyNu?=
 =?us-ascii?Q?WEYKdLMcuCIdqcIlGW15Tz9ZvPWyRoupH+x32YzqelrF4Qdl1Cui8pN0S8CH?=
 =?us-ascii?Q?NZM0NMk+THLrNli30vnycRz+7Ccllqu4IO6LHhgza5lqDCnRsfk+EJq0/RbV?=
 =?us-ascii?Q?xWhpxDCoJwr8d8uyR6FPhAMfgjRvsjZqWk4lKQtS0JHMHeSw+KXu+TDQmfoT?=
 =?us-ascii?Q?bxI3pe/2EXuFz+04YN7PmKq+WKm4N8c7KCceTQfNU/TRQl9EVb9wRDF3JG27?=
 =?us-ascii?Q?J6T1mSB1h0i6sjLHXMuu15f4nVM9IT3LdR8MQgx+5/XYp7CRigAQMmPpbfMe?=
 =?us-ascii?Q?i+OuyauDkqO9XOeOeOikjdnQR66U7TalmOrPbUldg4K0cLzHP5fBdM3ZI/KQ?=
 =?us-ascii?Q?ImEm3iRyF9KDMDdAcO60ApQiL2LFDzJePO9Eftmn0ITVa5Cv7UjQUNxEqJ35?=
 =?us-ascii?Q?MHEOh+1LXVmRgnfbL7jMKFnDAP8tywZQtThyhpVv0R7ixw05T5YgXUes4kbP?=
 =?us-ascii?Q?HL5xAWQodnQ2qVzF+UF1vdbL9pCI2cb5xlOBv+qH/DzDoz9ZhKR55su1JNAN?=
 =?us-ascii?Q?k3ee3YRLOInuulGTWEdvJskOk0p4HiX75Zx+Yqklxej98GzncjcaNPRbtYBy?=
 =?us-ascii?Q?TkgVZjVhNoyrNAU6USRZSgaWzpUuV3+lnTtgTNawLwC/WOzRxM6geb3P4XJx?=
 =?us-ascii?Q?J4cmM1RRMgnXls5tEvWCjD2ktXmhj1Q5oLiT2pZo+lIQ7h+iFmSBS1AIfZLs?=
 =?us-ascii?Q?NkUs6vRI/zUbuibuxp3GLulBsU5bMCgC1TxXsoBAs6wRXkkIHoZc0vgdG9DZ?=
 =?us-ascii?Q?jzXj7sKZHFzL0a2HCIkQ3aLY4xj+7nRq8WCk7Bci?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f620f3e-fcf2-4ef3-db6f-08db9d5930b0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:30:59.9051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGPg+n9yMZl1EAcU35CKhwaJ6S1yzKHYc33X5Y9lMJ250XmQnhO5ZrUoA2yfotNGpEzGLIkfain8lhheXMmayQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7239

Drop data_init interface.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/progs/mptcp_bpf_burst.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 8cf2ab32c159..2962067568e7 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -77,14 +77,8 @@ void BPF_PROG(mptcp_sched_burst_release, struct mptcp_sock *msk)
 	bpf_sk_storage_delete(&mptcp_burst_map, msk);
 }
 
-void BPF_STRUCT_OPS(bpf_burst_data_init, struct mptcp_sock *msk,
-		    struct mptcp_sched_data *data)
-{
-	mptcp_sched_data_set_contexts(msk, data);
-}
-
 static int bpf_burst_get_send(struct mptcp_sock *msk,
-			      const struct mptcp_sched_data *data)
+			      struct mptcp_sched_data *data)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -157,7 +151,7 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 }
 
 static int bpf_burst_get_retrans(struct mptcp_sock *msk,
-				 const struct mptcp_sched_data *data)
+				 struct mptcp_sched_data *data)
 {
 	int backup = MPTCP_SUBFLOWS_MAX, pick = MPTCP_SUBFLOWS_MAX, subflow_id;
 	struct mptcp_subflow_context *subflow;
@@ -205,8 +199,10 @@ static int bpf_burst_get_retrans(struct mptcp_sock *msk,
 }
 
 int BPF_STRUCT_OPS(bpf_burst_get_subflow, struct mptcp_sock *msk,
-		   const struct mptcp_sched_data *data)
+		   struct mptcp_sched_data *data)
 {
+	mptcp_sched_data_set_contexts(msk, data);
+
 	if (data->reinject)
 		return bpf_burst_get_retrans(msk, data);
 	return bpf_burst_get_send(msk, data);
@@ -216,7 +212,6 @@ SEC(".struct_ops")
 struct mptcp_sched_ops burst = {
 	.init		= (void *)mptcp_sched_burst_init,
 	.release	= (void *)mptcp_sched_burst_release,
-	.data_init	= (void *)bpf_burst_data_init,
 	.get_subflow	= (void *)bpf_burst_get_subflow,
 	.name		= "bpf_burst",
 };
-- 
2.35.3

