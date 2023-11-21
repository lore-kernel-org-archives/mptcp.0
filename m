Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2043.outbound.protection.outlook.com [40.107.8.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5BE3C077
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hP0HVZN/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPhFN7HkPWbjeQee7kvJ4pM5vBqeJPBf5jKGhhphvwnc+t63P/N1q6h+wNxpdhQeYkmYLyaPfHR7ExcRFl6Pqrnm/GuaEHt1B/qVMS80L11AMMOJuoMrs/HzxHqem+dKqv3dG0YWEotUDzUCK7uGMSzwZ6wWYbV6s6H3PP6WFPWmcitHb0mMj6ilwTDmwIkoG2cnTuAdpoWY48uUyvRiibOTOGe0Ud4HTrZHk6q0B/L5ZBPFY1HZuaJyoVZujDe37WyLoARhYS/9aXExEcjaDv9QdYrP9Hw4zBxaf9Ppp74ccbOKPLjI3V1RY2UDg0CpsrCpoonLAcWTUgfYjhMOoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOp2TWhtoPPob1E5rhy13X9kUGO29azvPp9LWLnT+zM=;
 b=hnLD5yXn5l2eMVFy/DPIjHC7yLZK6vDTcr7sPgtMjBIKO0mBU8sj81GAdMqUnt6FVzs4G8ymHc9lxoe6aq+LvOczFMGBgKD6RFi3CDEeJdDm1QxteICrr7ZMHn5LCFQ3itsjMRIgJ+ejntVqhJltU5ETp3wLP9oQvbdBDEB6YTepGKX5JgakUjFw7Xk866HHxEKrpgmhjBeW6Y6L8VyZg6wJDE3k3rwdog3naa2aj4evJLOJVxF9TDAqd8zHHC9vvjlTLXnsjMhVdcu3e5E/JnMTW0Tr/SwfZq6PmOvTfSEoY7pj3g7z9dqvZH8dJiTxhQtEUKu8hgnpRdetuxMr9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOp2TWhtoPPob1E5rhy13X9kUGO29azvPp9LWLnT+zM=;
 b=hP0HVZN/ICpk2M8VYZ459QejlFxb7IptTWuzTZYJvNznjJHFdPugTJr9ratNkRPuo7eal370J8RHRVbAKe5XOBcXp7rPRMq+gZ0fScFFlxbYJhPIJPeJ3NcMg3o5nQBFj1/SBUwfnqSCrNJxDWT7Ygk6dco5an8sZidnZ/5lhFp6BmIbMR94ouBv9AAnm959oeOWxaMQ89Z+OpLT/HTjVepqfI9hi1zbqdOoGzRo8xm17Shtxot5sT8CC5JWu3YTJsQErzo80vldqt0iddMVvuk+xbSXTfXF4625kgtdI+JdDljBHlfoSQ7PHQB+MLcEMpFjbzAYqZFW8jNFXTQZWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7750.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 09:54:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:54:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 08/28] selftests: mptcp: add userspace pm subflow flag
Date: Tue, 21 Nov 2023 17:52:31 +0800
Message-Id: <37c21db4b03b769dbec59960e0f1ae07cf9250fa.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0352.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: a012c6e4-f682-4ffd-1d4a-08dbea77d51a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pxXPk4eKzxEC0UdGApiVAhd44s7hvh7CUuVp/P63PF/Bfw8wnRtn1y/ZYrS+IiN/dyMmfIFHy9NeuRAekn6rSeehoVomOTDqWIxYrqU9iXbD8/P2Gavbd4MyryNKFSnD1ZE5APben49NbNXTUIWb/8S/QDsl/8uscdQNDcA9peN2hNVeTTxWP2AOdHiAK7hnYUxCN9OFazdaGW35Zr0zz8wKyy5//sWhmHRzWQ8SS8bphaTiotfiAW4NN/l9K9P1+DUGTmzQbaQJw2TIp1NxF9rmhV9ybwN9nuwDXmGgzGLSYZWm9B5s5sPZ3HDdepYhdzo9J16LK0axN7EhW0CPjKc0NB5rxHAa+g7ArdDredxV2GrfUJa9MakNopDQnd1FraiUAnUnQba02GFkYpGZOw+bhUUb1YH9VuSl7/pLaQdhMOahIAZKaFXC+3utOU3UzlCsIHp2t2D3rJb55wMqUViDXO9ZSR62SAv/ft/ivlx4Ce0iBqbipv0N733q2CxCSR16IvwUdKn7ravEZ3OQMl3t8cu8VaEqzViEpeqOgyrymK9/00cfEpssxtHt0v+r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(66476007)(66556008)(316002)(6916009)(6506007)(36756003)(6512007)(6666004)(2616005)(26005)(107886003)(6486002)(478600001)(38100700002)(86362001)(2906002)(44832011)(5660300002)(4326008)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1c52u/2t6iGwtyl+t604RqivOQeyEjPQwTnhuegJIuU1v5Wb5gkmlNPzK2Vb?=
 =?us-ascii?Q?R22vtC81YpQ33zF9vLTg5djQertUz3YOKd3tXTO7faxDi7atpqj/hgzeUQih?=
 =?us-ascii?Q?NkOPGINHj+mZsgp/S5nyoK1NUklSdRgRvada9pjHZ459FeEVq6Zn3hIvDKpf?=
 =?us-ascii?Q?sgYG4AyR13Xqw9MBpKmYCCYC0eFB6ziVpKr0hbsnesCmopfEgNnll2WJU2FF?=
 =?us-ascii?Q?yumjbyAKPJJu2PQv4Yd8ZDVeDfvzYXEBEBI8vdV1amB8PE16CwkngRs6WOii?=
 =?us-ascii?Q?kVzGLzczHaFH1CznmGk3gz9ev77UTsDzeLpz/OftkYB5/C1MJJvan8hc5sBR?=
 =?us-ascii?Q?3+kjGddDLQHHi33IElZmCZKze5kKRqWvf50WEBg1KKro4giAdgOkGJhoflkA?=
 =?us-ascii?Q?JI04YybmWZl6kl0PxXSN8Pg5W3fdGj/WWcOnJS2jZHhMPtfRhGC7bKibKgyN?=
 =?us-ascii?Q?u9sPiskZ/fofwpu379xvcZgJcz04mTd0k2GBYqw6bXo+kv5saj/44xWbH55Y?=
 =?us-ascii?Q?kzl3IQcKLmq2y4s+zyEluaOlsHBhsHP+rAqpauuyDAwfHbRZuLFHSO0niOs3?=
 =?us-ascii?Q?6mFXJHMqZo6RPQkmbl3dNBiX2jUjIRHtwe1McU+LgFxnbwKi2aYZI9MoqE60?=
 =?us-ascii?Q?8J3l7yHq5SXtqkLNC+kv4ioz3nH522eUeT2y6WTN4xk9FT/ygV/8+BnZ0X42?=
 =?us-ascii?Q?hKZ/f8U0vGX9y3mXa5+DwkdGoPS02St/wSGMCNX5J1Gg21f8VSlU0HmxnsL5?=
 =?us-ascii?Q?fM9+BJB1W7NojrGcfHcxC3VccnNP1umzJX8e+HEUHmw8+lk7Slhk3w7PnBbq?=
 =?us-ascii?Q?BYyUlecXlIP5RZy6t85E2AcDm7yNv1rPJ+CrmEuII6or4qW0UrdIisUYF129?=
 =?us-ascii?Q?pGF+YnSEINy8xhW3NYjyfo0mRZV6Ab/rOm9tjfGN8/0Su4eKtOf+cAB7NY0w?=
 =?us-ascii?Q?AhwVhNTAir50MJbHvR0p1TJ1gHEnOIZ7DEdi/Hc+zF1R5MGOjNmUoQh2K/3F?=
 =?us-ascii?Q?X54QN4yoklapZzuFyRX71ovUCyGFUFrLBD2/3FDYgnJP12TrhrM3QUMPQ6po?=
 =?us-ascii?Q?kUEbqpqss1GyEYP6Hxd8pne1LMNs5tQAeB0o9aorB/yybnLPdVeaa5gF3UIP?=
 =?us-ascii?Q?bSbrxXeWkPv99+yNbEDVA58fR3PSQjy/E0o+urDri6kTySoIwgFMdzdJpA5a?=
 =?us-ascii?Q?2vj7cmXoBUTKpZ8lZGi0eEILZWasYd9L7jOTgDngHn74Xu0mlZUFhYVVlVtD?=
 =?us-ascii?Q?yreZdk4sEnxTd/lQRhaeDiMkMA0MguYLiGWxM7zn4GzrMk4KlqhzAW+Eyblz?=
 =?us-ascii?Q?3sUy8yM7WT/StZZH8chJORJSYysUwcPzh5XMlN5/xT6xYP96ISkglVNk1SaK?=
 =?us-ascii?Q?1X1Fo/heze9DC9GPtmJSTfiAGv21ZNLlmfHgRHCeCazb2+XDx87LUGifO0FQ?=
 =?us-ascii?Q?NUZUXWPnX+PV5vnE7BZDrWS+A2YPcgAwfOlyvhcVQV3tqV3T0hIW3oD4YgCN?=
 =?us-ascii?Q?9a9euTC3q7FqI684OpHgwpl4piJOoCJfPXJtZPL/kn+6ksKwR0SFCR+qynEC?=
 =?us-ascii?Q?hu/LwTdD1nz/RVAIxZEBCLJ5oUHE3AXQ2CxP5la0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a012c6e4-f682-4ffd-1d4a-08dbea77d51a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:54:20.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48ebjAxNr3B15Q8T3BW64tUAyyX/i2jV2NCRDbNIyFaTDn2eBrIT/LhEi59rghwvyZv9w75lGuOyKjYR7NRwnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750

This patch adds the address flag MPTCP_PM_ADDR_FLAG_SUBFLOW in csf() in
pm_nl_ctl.c when subflow is created by a userspace PM.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 49369c4a5f26..e97856323ec3 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -453,6 +453,7 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
 		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
 		  1024];
+	u_int32_t flags = MPTCP_PM_ADDR_FLAG_SUBFLOW;
 	const char *params[5];
 	struct nlmsghdr *nh;
 	struct rtattr *addr;
@@ -558,6 +559,13 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 			off += NLMSG_ALIGN(rta->rta_len);
 		}
 
+		/* addr flags */
+		rta = (void *)(data + off);
+		rta->rta_type = MPTCP_PM_ADDR_ATTR_FLAGS;
+		rta->rta_len = RTA_LENGTH(4);
+		memcpy(RTA_DATA(rta), &flags, 4);
+		off += NLMSG_ALIGN(rta->rta_len);
+
 		addr->rta_len = off - addr_start;
 	}
 
-- 
2.35.3

