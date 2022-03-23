Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E5A3C
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 12:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648039406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tGtNjMyjN0o6POUqC0rXbaqa6cbc6gwLbNKSm7mv868=;
	b=Xh+epjV3ySF7hwDeE2IErBw/v5kQeLxIdOziSWuI+VXgmpiDVDbIJzlMAn/1mVriYrGGFd
	vZ38lPUnUMtoJBOs3doTfV71j5GY9Vzowxgz3NvbouVTAZFWfgedk6UziteXyGJTtAQ43p
	5U1+339+rKeIv5VDk5vrybyo1RdQmZQ=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-VIm4CTEtOf2GrYezlgQ5GA-1; Wed, 23 Mar 2022 13:43:25 +0100
X-MC-Unique: VIm4CTEtOf2GrYezlgQ5GA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoCPjt0w0CIkGhXaYcAyEIl8cWGNd3mBbizHbqZkUVEpt0ETpFzr+l2yBypQxE6AzW7waUT7JgTXDzgtwfgibd272OF+rr6iQg5A3dZxMw2cXQ+Jq2e7gIXw59Pv70NRa8CskoDrm+PaUu3YGsdOZVDRwQ8KlGz8bh2Icaa6pEtCTNPSpu8mxGcFrXAWVeGwc9LtDbc3+eCcvEdcq82FUhSNTpUHKMWr0YfYNz/wWZATiH+Bj/efD3Wg4lES+4ZxYCIw9UQ2TgqIxdQdm4z7TTO410epA9xgpQAzrbgf4vPe35VJaOyRlF/CqBpfgdpKXg7E2QwL6tnNPc4BqHBztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfYWPmxS4bjIFAE9fL//aZbIbasLVEUPNt2/VCV2xck=;
 b=bTcDPeTdz8roM2z2+I/VInhpuigxIVkbnxN3R1g19x+bqd5QiXnhMyjlCO6Nl5U2aN5YArKQkANcsGooL7r+ujTDctmArSjPHPoa/5TwpmjrS30D4EwiqfGjqrlHw88BLTsGepxzoPIi/e8pwYvTlgqjxN3NbDi7BUxR17RxqBLpZxTEJLhdyhjqW2JYfYWRLRDbVCO2Ioh3s4mzQbDvvDryvufFG4SExeegTTfyShpLScmVD5O1+JJdDv6dNPmyLv+U52q9pMbXHEMShpa+uP6kBAPf3wrZFZoSDcIoDD1rc36TlP4il6+QVspkg+PLQE8ZOo7mS/Msp2+MG/1Zjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB3696.eurprd04.prod.outlook.com (2603:10a6:803:1e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Wed, 23 Mar
 2022 12:43:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 12:43:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "bpf: add bpf_skc_to_mptcp_sock_proto, v11"
Date: Wed, 23 Mar 2022 20:43:21 +0800
Message-ID: <53c933656e0c35fe2401007d13eac17ab6d39f8b.1648039341.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:202:17::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d72767c0-1afd-4365-d93c-08da0ccab782
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3696:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB36961A9B9D7FAFD47D80CE99F8189@VI1PR0402MB3696.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kpVAg9ghHAtZdhW8EL1XbowTBZtc8Cnvw20MiN2Kk1P22EbWbuzduLS2RN+l88SBIVZsnGnjO1BYIOT5o8A4qlsu5MDlCdhkWQQaksRSiWXARkOehwLSS01oSkWT9R9h3WfnVQN3J8BhqnoubXYYEFETRDqvrgq4AWj11pQljNNy7U4PQHAaJC2hmX9EjkvrqD0Hx3KdAduvknsGAb/sfDVhcHJufrXEhycr4ZxiGXO4m7VZ49jaBAYELBwuGolBIZgSz0VFe0/5zkmY985sTIykS8SllGQ8t70UCxVTCPppE+jpYgM8eR+FR1RqrTFTh2/RuzMdYBh+rcQ8M8b1rrheBaYuSQz4j5j962dodC4ByMsDtSGjjZrlUDGqLYa3Qg7JaQqoLFWHoMKteDYvLupB/VmSKTyFR6Dk5/9b2Or+KZ3z/kX5mGvHI5i8WAv6J5nr9Tdq9liEG842L7vcXU5B6mhBPAkNDUYvdOdFAwPrPtRHjeZOMrN9D/F1Y3iCNOjGv1z4ExGEYWxIs4s/WnCbWIJg2Xe0HLPv0fPqfyqMm3/VED9LqFEOEjNREzm/u79Pr6GGPy2AE4ubOqbTABfxEJ8QR5G9VvhrhLLQ4NB7Qz5RJLldwOng94Y/tLkgl127KNNcIEi23F2jUBnw7OPQ/Zd/3q/qC4fIh5aZFI95WvH890tWoXWVuOncr8uF0Ox0xS0UuCPV1MaZT8iRnQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(5660300002)(6512007)(8936002)(4744005)(6506007)(8676002)(6486002)(66476007)(66946007)(66556008)(6916009)(316002)(86362001)(44832011)(36756003)(107886003)(38100700002)(2906002)(186003)(2616005)(26005)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FSMeKnNees0Gvt7oWSbPq2qeMUDEWh3iUBAw6nnfjjHNZjvBqpzIhR8NFKzk?=
 =?us-ascii?Q?MoveuZ5BN4TwZ7ep9pZNqbkMXy1/xYuySP3MyNRy/b80lvSEaTfkhYRV7ZTc?=
 =?us-ascii?Q?Pkwwj5Ao8j7K0G4hTRy/IE5ua61eRt+tjGJiGhOEzACRcwjE9s447Uib8hxi?=
 =?us-ascii?Q?pna+ebd/7mZVEpRHFqUIrf46VknhlJAr7e55bd2IqbI2aKbzZP4tsrM3Lzqg?=
 =?us-ascii?Q?do8QHka/FvbWDIuYmiTOr1iW2dNTMNlVIkn0qqqcNWDXk+Qe0a/fs3mLwcfR?=
 =?us-ascii?Q?Fm7jT1DqGVB5KqHry/OScyFxNyaoH04/z7DLbj+3KnMW4BxxCa59WdPYFOjE?=
 =?us-ascii?Q?Je38La7E6+zqGqZNGNC5xPuulsHfA9rAqvpj8VG1ui/l7527q4mWKIdAZqk5?=
 =?us-ascii?Q?iPefJktmk/ax1iKyqiL0ClNqXp8GipFKZEf+cYqJ8k9jMS7ai2dGjF1jjKGV?=
 =?us-ascii?Q?SCP8sXJadNsYRJfQ9H4JU3oBoWlV9kpZNQCiJZNMu9dUYo4zkQA1QkNpLE7b?=
 =?us-ascii?Q?un89DQkuxYnysjYljFHNlXD//PyalYPWK8nRs4PYd8TjRYwJgbBqyKfYCIpu?=
 =?us-ascii?Q?ZZWPPUhUmjevp+UnUq+i68WzXx9YVB+O+OubOLXDVqLs7GzmMjJqjXeIou8J?=
 =?us-ascii?Q?F+1/2+zLjv25KdK5A2GELZ3A7ltAAV57XOOiGQCvXx3s00TC/IfBwOt4zBUz?=
 =?us-ascii?Q?v3f01JVhNJJLN/xP7802LXBeq0bsTEcBNmAP7JGVKHMxVGsfjgMIxQZk62Nt?=
 =?us-ascii?Q?lk12xK64kSBNsU+EJgyzGwatzJqcQRK9HWGmIdWy5QfJFzndCv6Tlg9nKm63?=
 =?us-ascii?Q?7iLQ1CWc9kDk1ZLZGEkt4S7NwCNHqJ22Talkp1f0CvxwhLEi3WNUhzQ/cWen?=
 =?us-ascii?Q?g9ObbT9p/+HJv5o1smRX1kvkjB+9JeD/ZJqmlTy8kC5u496OLEIwwep0pkSw?=
 =?us-ascii?Q?de7zKl2MwP38sYJQ6skbQ1vKoXCFro08D32bgm5hr7gAydDuWom2uY6y0ezG?=
 =?us-ascii?Q?vy6YQx028AYmzh2Z5rfI2ilf6U8pYa4UP+fMBaqlMRxKua1M0I6zX+Ah84vV?=
 =?us-ascii?Q?0/o6phHO44WHZ3Pstx7qaesNuCyPxnOszKLyzxE3avPQuPGWOkhID1W0bSiv?=
 =?us-ascii?Q?ru7pafL6lMBDuiZCk8KIMNHv+D41foH6LxtjAy1dgmz/9guXW2CXoLGbJLUq?=
 =?us-ascii?Q?OqzZmvvTpCjRSLNu9YEFRWV5AOi7cdNtsvzZyV56hHQX8aUfx8YmP5xzuc7A?=
 =?us-ascii?Q?S/goKpUbRZ6qI5+NryrXNV02uvNLamxu9s1DkEMscHDUwco+zcoq2BN+3cdE?=
 =?us-ascii?Q?okS2apyEzgwbwQJ63Pd5ZegLpEC+FSM1ZOZRWEOmMITErW3ayJblHsdIP9eP?=
 =?us-ascii?Q?7OBD0HVCImg+55sMBm3cep3f0jv/NPIN7PP7OwViRZ5+EGl86JRp7u1HnSh/?=
 =?us-ascii?Q?vkQusGekOHsU8IXXLk/zgFhKhZCLRGfy4ZkO2ag3Yvmv88Wf46Fvzw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72767c0-1afd-4365-d93c-08da0ccab782
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 12:43:22.9329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlqlfQtxnXVOFd6Z7VWcBQtYWogOBoHcRTD7i73c1KronwgzbmZyoXrMlRLqX6b5qF5MlVX6cibtYly3BEDfmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3696

Add pr_fmt.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index c3b6f94f033f..535602ba2582 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -7,6 +7,8 @@
  * Author: Nicolas Rybowski <nicolas.rybowski@tessares.net>
  */
=20
+#define pr_fmt(fmt) "MPTCP: " fmt
+
 #include <linux/bpf.h>
 #include "protocol.h"
=20
--=20
2.34.1

