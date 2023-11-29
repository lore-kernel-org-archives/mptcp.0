Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE11B277
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="1uZ8Z2kk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhF+zv+CVpkUyY22BsG0xcOQfIxSEGt1O6aYgIy0RmFijr6Hoj107y0Upu4BIC7Xl8nH7o3RFWSbJPxvXYwmsNwlSZFv9RsBCUzDR1gx5UpC5lViZUUryW6O+gLi5cHLdPgYWIHj4fsC7LixSddBQbhrUFn4RKI25OnVoMVErunnxaEAjvCshkZHgPdoM2UzfKKq+xbwrANeqzqvPCayNZ/NH+i11C2sgmxmTHM6b6vzVR01yowkon5iLsZRn9KOrwix3TD4K+u+aaSEqN5SWmThAPVAc2VM393uSAce/61ZieNT+LBkN9hDU6CtxBhsjQpwd1Tc1lr4DzjgbJLG4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSjB0p8eF+L9rLQzSCrjmuOvxEFcgy8tIgNP4m0pVvc=;
 b=P7xIKRrRLBoQKIy+NVwB/ANUFbzVTFBJBAMW0Jpff54ctmlbbB0Za1pbytwwU9uokumL9ka2gSzoxkzK6ghSUogFvRJxA1JtjfWJPYcbVCe9DYkepmMk3eJzuSxUWxK380ZD0c/M4Z+kT5z57ntfU0226M6gx5AFGyLDsZUlvfI94LPTql8As3qvkKLauyW7e4mSALshxPo+4nkjtMc0wZkjeQHpyV0KxUly2EXzI0qX+a78iJLNIJBCVrYfN+4DgA9AhU4ieU/rMsPIMJFw4Hkp4oYCOhz8QJOZ1QQcR2ocuYnn5vopqOB6/OPOMJOyfKCW7yo1++yQlD7vSRLlAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSjB0p8eF+L9rLQzSCrjmuOvxEFcgy8tIgNP4m0pVvc=;
 b=1uZ8Z2kk6Xhe7YrSkGjQne/1jBwaRj5n9BFlAascCHCSAm4yXfaUS9ahPwWHH/BoAaf6v63emRxP1tvVd1zZwaWmw6FOzMiqAzfSbunsqeYmOMeLKrFwyOrCJzfMl8HJjv4FhrI2B434EwNl5IQQWcehVphf7Rqo3GmfiGThX6bTDYwz6QLtDZwEOPN8yHxWyI6N7BBRzUba8INOQCWt0KFKXf3JNC3+yWHQzL3B0hHG3V8svpcTRgo3QfTJ3+hTg9C+KdgWjfmzgkDnUVk9+uxwK1i9iW9O4re5BdBGkZ4UfFE467AXQvx/AQ+OROgLS23o5uvAVsN6a8g17Zr6mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9333.eurprd04.prod.outlook.com (2603:10a6:20b:4df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 11:10:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 11:10:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/5] mptcp: add mib counter dec helper
Date: Wed, 29 Nov 2023 19:10:48 +0800
Message-Id: <8308ca9192aa478bdfc274757dd31bc4e47bdc7b.1701256112.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701256112.git.geliang.tang@suse.com>
References: <cover.1701256112.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0068.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d29c15d-0092-411e-350d-08dbf0cbd2d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KVsrmFaMlnzEfETq0t1FCvBr3R1n7sHvU3HoL6f4cGrFrfhu2GC6JhpDijYlxMZXmB9HB871XSxdfhMcYKyCZkELoAPN1+o7AMzpV/pfmYowG54NU5bqew0Py38jdFJO3od4i+r4bLc3esaClU+olVcQN9agNs0yyRnrldzx5R95E1unu0FBIBiD8ks2gRTiUTIFVXQBq45k1tXX9hzVI/v3L+pC7EZSwSBXg0dNeJ/YmzDNO9v6GdwNHumLrFKpJiju5POciZgEYc6pV7lP1iRIcoqUQbGhNnUo4hKoFmAoZhoQhBjBOieaIcmzZT4tWvt+H7GNfjMPrfXq6vhg47XB44WOcpC1ZVJktW+V5v9Xh55p6V9L/Rc3gJOpLyg6OG8xKa9BK7tIEJaylnS5mzOsYW837mBgFtmaVFR0zRjld2s7L2ZyMsrdujCBsGFsAbU0cUeTnD8JCTa7qemTc6gs42jjnOfbKNSqcFhXE/BaO+HmcOxZJFfZa8rZhZj24Nz2C8ldKQEpxQwqfO9uGMTtvuz438LlplNliF2FBlAGi9qXJE+U4EXh3AcxHPeVdRtY3aGIxlMszAt/cSW6Viv8MUbU+0ysINUndgRrjuk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(107886003)(6512007)(2616005)(26005)(6506007)(478600001)(2906002)(4744005)(5660300002)(41300700001)(6486002)(66946007)(44832011)(8676002)(8936002)(6916009)(66556008)(316002)(66476007)(4326008)(38100700002)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nMXmBc+clzUBL7trxyjg/Pd2/vqQEXvYCsAowHIp+Z1vFPqNuO5wmGkAaAT6?=
 =?us-ascii?Q?Gw6JPBU1FUz4eu2IxgHbFRSWoMMUlqj/A2BxsFg6XizWCt6Jl3gUIANuf4a/?=
 =?us-ascii?Q?XfNYxKzDtSWXIXVUiIRUz4jggDjgMphlp6fny75xp9uQUZ4Qoglc8T+CXEE8?=
 =?us-ascii?Q?8nfFW2GPCq9uNS5u15xbcEo/xWmlJJvRpx1o1Ex42fOSo5fdPHJH5o2qbG4z?=
 =?us-ascii?Q?YyCZ1ln6JdkfmftrlEs8nNyEX6+agESUXRTpHm5XhjqcVUJPtkh7lhU4fed5?=
 =?us-ascii?Q?d3Z8TmSBEHRDmXsyaJLyxC0byORQgFFkbby5UEAFfTPMpXErFO7Kry6C62C4?=
 =?us-ascii?Q?9hwHdm9xYO9MkNnNAH9kPENas5eboXXhx1DCBG1uIoogkuO8PdaJ3Tya1Xzs?=
 =?us-ascii?Q?spEQXfIUlV+jc/uxvJbcHtEV2MNLlbQPvlOLUUciRa8P7IhhzANLLJQrti3i?=
 =?us-ascii?Q?GK7WzUo08bg+hUd6DsNhwTwbs8793HQ8OCSsFYwza8B/UqcB+fu+h3X+FnmT?=
 =?us-ascii?Q?mWDkrlCt3AIAf60wcF/oipI86Cg2Zt1hxULYGCJ6wr1J542UvocrdMDhROvd?=
 =?us-ascii?Q?Qn3H2i7aE2LG70LUvUae1ewAq1sqgLggNSfkI8GDN78RjhCmb1GZd7RIiWB7?=
 =?us-ascii?Q?3RxBhA/JPtSDMsqgTPkuspKxdg3ecLNAsVl7EL4yl2qd8mUIQHpnW6mheesA?=
 =?us-ascii?Q?zN5nfhfROULrjxAnLSsmfE23RvQoT1wij3Wmg9pw2NcUmeDjHTUQuCx4rxoC?=
 =?us-ascii?Q?8f7Egou3uIow7ycSNc+PTkHfsgMwL/lbBgYwQhar/W1X9eggDcCQQmAejQvf?=
 =?us-ascii?Q?hsFSrfOe6xGDZgPQIGPv53ieoDFd7ydjldPPldmayMrx4t53c2FcC5U2ei16?=
 =?us-ascii?Q?bG0Jjq3/iggJgR71GhqKDD24Vtn9DK7Eb7YQwfFQDHlhs0DWhrBriJMulIM4?=
 =?us-ascii?Q?cpDKKRO+CvdhNBJhGe4bDPAKzXw5kZ0BPAJqU8yTNODC8nPSoKQNJCthWIsh?=
 =?us-ascii?Q?Wh/QWJramVuW+ADlmWIDLfeT03WicgkLtA9EP/ke78xGQpn3xOaQP+6JJsTx?=
 =?us-ascii?Q?jy3IFHBKyPdvXi0HiMuaEnQrRGy4eemR9/HBgndu5T4V5HjausJOASAdaZUk?=
 =?us-ascii?Q?gTgTDDkhoVSpOhy5uR11o3Nlt2zxJ+QTjbequE56uFzbh4q5yAg2YHq5ksRi?=
 =?us-ascii?Q?PYU+fflNtoPxQLS49ixzvrUh8IlgdES8XTlPHfNQAyTOwHyKuGkpdta/5Lax?=
 =?us-ascii?Q?POG+TrUiWZ07/xG6V97d/kFvCoHjSQVj1CVrGzbpDIS4jx2VmsNXMCbbq3Zg?=
 =?us-ascii?Q?yW3icFcLkNuIMhj0zGndfa/OIKQ2Mco+9SIHU1iIvGVZ6M51vAHIp/Ye1lKc?=
 =?us-ascii?Q?NSnKBC8ydYWHFNNPQ5agLEwXlJJpP6ZvcYOkIkpWUtve02/NvkzMcF8gwviV?=
 =?us-ascii?Q?lGv6FVeZyDkooiKRZLcpLqhl/rrU1GEqPSbXWJ56I9e0lGyWk+N8AbBQ8u8s?=
 =?us-ascii?Q?2sGJ/r86edCrXwDwt/YqayyfFrDCHLFvqyH5oUxCKx26HFpylPMjrQK4iw8s?=
 =?us-ascii?Q?saODjnMmgo+6CCz/yLU8xf/Ej6BI7IPxp6oNf32SbQjZdgBw+vAf44vLT8O8?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d29c15d-0092-411e-350d-08dbf0cbd2d2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 11:10:41.0570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NPmrH41oOo4cxu4UagfqrzU/t/0/VwTgEi93GrNebEnbfr662pQ/HZWbWP3FVnZwTCP2s2fnJ9NK5/BbYdYZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9333

Similar to MPTCP_INC_STATS() helper, this patch adds a new helper named
MPTCP_DEC_STATS() to decrement a MIB counter.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/mib.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index cae71d947252..9b7c366675ec 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -95,4 +95,11 @@ static inline void __MPTCP_INC_STATS(struct net *net,
 		__SNMP_INC_STATS(net->mib.mptcp_statistics, field);
 }
 
+static inline void MPTCP_DEC_STATS(struct net *net,
+				   enum linux_mptcp_mib_field field)
+{
+	if (likely(net->mib.mptcp_statistics))
+		SNMP_DEC_STATS(net->mib.mptcp_statistics, field);
+}
+
 bool mptcp_mib_alloc(struct net *net);
-- 
2.35.3

