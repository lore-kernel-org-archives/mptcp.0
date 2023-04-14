Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC49CA45
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 09:11:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnMbTkCIVZaXaUyt4a8JP6P0vaARJFS1F6zlGHqKib+aAx/PbB9sbgVVG/pY+S0Z2UnXWzotwfZ3//Qd8PuYGdZLM2UqC09oI/Bg0TkoNmBEunZlfXhsbRsS9XHfIYGPCgNfae87wXEr/h1+gE6OeWi5wmID014CBzg7uJy/hqlgFpd/QLp3f/Hk/60jUL4cJP5RSuGRWlUXKdEYQJuHZU3WJEdLOeJE23WDuuvKNeTFI98vKR2rUoQ2kJWDA8pj1meXGgrNhKpv4PIDGR219a7dqPzft/Xx9HZATN8inJ0eP3ZT8aSiCOxPK7QNd1271eVtiACRlNaJiBsVLaCmKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eroes/aDw+7YKreUCcujTo3qfNo/RO5+kgxApb8l9c=;
 b=RO65RyErJ6xF9pbzogBf/Ekh71CdkEeWwnsncGLdeWSPq0fiJm7T4m+AvgwO+B0CYKhkHh4IKTw/yK0Oc5Sqyj/xuqJq0+d4/+cQR540TZZWc1fS9qoaWcAw3CNxqCukQ/yTNMppy86rMasTwziuvd/3Ww8UZZOf+rezM7WSDCXduG9YsDRprvyHUMxf27eLGawzfG9A7pJlBairE8SDN6AdF16NEgR0YQjgri7WLL6qDXrXtgNxUUiuqKxXnSjaMaQFFAdFmsHpw1BElvee1rU4ARt8MXbiEjSLwuH5PYDaGD6fY0sktzBT8xHe8hS5S40/FYTbL2fh/2TMvWo1RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eroes/aDw+7YKreUCcujTo3qfNo/RO5+kgxApb8l9c=;
 b=fNmooS8a6FKhBYQbjXk72Qg4QDNkTMa2jLuu5ouogWN63GJE93IyW9EFp1MOQEC/CsNO5haG5WEiGJr5kNSzAlxeBlnjTTwghUy8663FKelMRvOwAHNgNTQTRDXZc+3v1ZHeqU1/rRiIgOTRyRBQqcH3LT/T1UPjcnU/TzBUWtFmwDIRUSjJ3EpsMgCmlbjC49NEnyuly/Nd2tn11XWTxCHcm1nGWKdZCIBaxT14IV41ujNC9cvxjRSO0YTaOmsRNV1EXaq2UzpHKoRFHOKc1fByy7GI6XkBUIHANTQIwV/a3DxcdxVOpgwTAyVozc5zycrUDD/K9HDSEkNNvYr5ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7553.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 09:11:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a%5]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 09:11:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 5/7] mptcp: increase userspace pm add_addr_signaled
Date: Fri, 14 Apr 2023 17:11:08 +0800
Message-Id: <55b8848e621adcf43ef2c4a96d6d600ff44cac6a.1681463340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1681463340.git.geliang.tang@suse.com>
References: <cover.1681463340.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0032.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::19)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: a37f51b5-2c35-4a2f-81f3-08db3cc84bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RpRUOQMkRRFn0l/S8ECeTySR1ARiFIzaHptb2m6US+iSxDilbm9zT2yIHv8pnho4KtV/yatvtRQvGAwZJ7w7+h9AohweXTFV7SkCRZaQrJOzTkpIAMOwt/0apJPLNWjZAETmHZzHd9UrUZUhlMPo+QwIYoEq9bR41YJeQxrp5JSCzyitD2SVXkWiGqRCVbDoGaAWbsNXXvIpsooiBN/m7N2vhd46ixLMi3vm9Ol2x3P3Qwd/XTSvSXfihih4EHs7lLvgLdyMFXigwnhWyM6Wq0MG/xa7n7bD9vbTEA09AuKQJNkwjFhGQdLHIp7QaDw9DM5bxP3N398wBfvo8jwZl/TBp0oW0tapRbRi6A521Y7H7VZ9wOj2omVq+K1lMSdJcwOVnessoBIJ4ZteSXIxjvpbnrYzFnr0MDYYgI6sgj17GplhiUj2psImc1cgSadGZChf771aYFCVYW7+G7n78dc2gjLRrv3+AXD68Iy/ypFF8I9edvxdrX9uioQ1Re0huucMutHUmXuExyfaFJw4mLx/JL0OBAE5WUA99TJ+VYzhfY3MDrjaR3SI0mcsuMVS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(478600001)(6512007)(83380400001)(36756003)(2616005)(86362001)(38100700002)(4744005)(2906002)(316002)(5660300002)(44832011)(26005)(186003)(6506007)(66476007)(6916009)(66946007)(6666004)(4326008)(6486002)(66556008)(8936002)(41300700001)(8676002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y9FNvWY8cZZpyeMX47mzYAEixp324NASPPF/8K+TKKFqTQNP2IGXcFMdyNEB?=
 =?us-ascii?Q?pajfeKos1ozUypeyD0xpYQuJqkC1QOykVQCegyV+LIMdliwYjExajPDplgPJ?=
 =?us-ascii?Q?eXMJLOwi9RFUeWhnQv2WWmBY6MEM3v85PTYjidLOU3fyTg2eJh0uEX+CkLlr?=
 =?us-ascii?Q?WA4GiyFPRAHMfiNrz50lI+QSCAsMKBolVsq75FzmZQzbBeFW39871yvdcqjz?=
 =?us-ascii?Q?y5dLyQPhdsAtJswmQbSdoSvmLvOQqOyOsJ7htvej8OYBWHg5I6TwYutbH+ws?=
 =?us-ascii?Q?XpzFkTMxio5Ba1u/CmotXIHQ49Nne+0EdAzkCiwiR9rhost/dt9X25s+N8Cw?=
 =?us-ascii?Q?IE4uVEGS7OE7M141ampxszphCmWeMJbmzZ7B9JIUrYs8Ks1f97LGiiEzxgGR?=
 =?us-ascii?Q?WTUZXiNpvW+3psxXWES0Z/Liw80RacwMw7zxIvBwk3JGztbb+WyAwNfxmxBE?=
 =?us-ascii?Q?Wl/9zEunPiM9Piva3yTfROwwynlmuU5UEqh5WIc61A5N7hmaFrtBNXcN1QGp?=
 =?us-ascii?Q?TTYf2fG04I9+QoyK/yyOqsVvxzzdCsLWg307HLbn63Lz7J0BW7RkpJlD1oiM?=
 =?us-ascii?Q?MxhaLbGDWCGmGjZT6C+zn3Uyu7nv89YingnTSU0syFmTLlibP1L7Q7hRUJXZ?=
 =?us-ascii?Q?hWa4HClaXX9bYcLLUPYz7r5eN2hJcTwwce8lOdjyxHJsacJkhW03SQqgcvH5?=
 =?us-ascii?Q?SZe/rmFeZjtN+9++4QAbcf7DuW1DTGIeIklwf71RGca9MFAPsxwCOfQ25XXT?=
 =?us-ascii?Q?s7zJzjWiE6mDt6BRQMr0BL740XDHInq2SJjLZAw4y7QeqENub8+Cpkn/y8n7?=
 =?us-ascii?Q?tl/+O0oBINwDkFYNCGzIPW0EnlDJniSbqnzCIk49dg0V2it9dO3zg/qDfAy8?=
 =?us-ascii?Q?W5hTSipsMG9/fRTNpXnwis9hFpTrLCg/pWwqqELIsVaEGn6k0FCKeKdNMX0+?=
 =?us-ascii?Q?347H8dfWOMp6vOG90BwtMQMYtwPKcQxa8vRx8SeqSqhOFRQlN+3CjZ4o846w?=
 =?us-ascii?Q?D5OYnCUjwoQvOJMgQx4mHdQGdH8p0oLV5NVdAYGwv6WzF43Pze5Q9yimtTF8?=
 =?us-ascii?Q?i+XQSb+YQGTwU3WsnbiUF8tEh89QiWbfjRJH/8TYVRA8w3wjOHXQgBwO1xdM?=
 =?us-ascii?Q?xpCFpM3hohKUIvHQC8llbPIK6iEk0Yui+KYz9xxTMbon1in2iDOgpvqWyFL2?=
 =?us-ascii?Q?Y+3kkOGlW55Z2GaaIBMmmWm7BB0MdbGnJ1Le9VSIrCfQnTJd/Ac6G57PyEVx?=
 =?us-ascii?Q?k5lWrE2fxx8++EUb0lxQ4Lz9pVW72ZsPwUmDFbVKSo7sV+9OTjzY6LCLbof4?=
 =?us-ascii?Q?6JXbWrIVQLQs27T1xjC4KNxREHw9XExRvJ+6ZI5SwgqLz+esRsXqx8wf2OnV?=
 =?us-ascii?Q?HrPeJ0/Z9j3w1TOZnPab6t7JRwetXwfL72/BNEZ8oRE0lK7DZidKYCEsWhFb?=
 =?us-ascii?Q?ei6kFX+zkt5frfsNYI97BYYv8zLY7wPUfN3OHaVgNiYCWIqOO2kkjCFL6EqU?=
 =?us-ascii?Q?2hQWoDV6CRxoHmEHREMkn1FZW5URWWGVWGb0WujY6VXTwF8u2CUGytSja2T2?=
 =?us-ascii?Q?g+iNLG91tPL58eijolH/oy2DMBlYGgXHmOzRrf0m?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37f51b5-2c35-4a2f-81f3-08db3cc84bbc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 09:11:56.6551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QecnjNKWnVOXKUL9x83el0qyXUiy5dwrp+7YSSEICDkJ5dVG2VukIOEuI5hEHOeA9QLqcozOYNwI+wLbFv1oeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7553

Increase add_addr_signaled counter in mptcp_nl_cmd_announce() when the
address is announced by userspace PM.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 99a3968f38ac..e5b250d39e57 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -170,6 +170,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 	}
-- 
2.35.3

