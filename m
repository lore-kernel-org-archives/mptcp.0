Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8C818C39
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TpRzS8Nj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWAEa56xUIjpNQX3l+XNFD0xY2c5At2uPAZ/MTmx/lI64lvmkHfIGqHdAhs0cVZ8rPx+kPWAmg2Pe3QhzBv+RG7a3py15YPp32ZBJN7aUS/6imQb13J2O46z0qMjMTGNUjYW9Ul7RzfQVIOnVsYwZt0v0aT5bKwJtXUEaNi9MqqXqLQArT/mhrzbaTy1e54ISEZxwYsuNt5J9Fw+DWKDXhj/RpnQyp/k15nzz80aw6jjweV4d1s4zBN0nP168znxqFTIqyY2HI5QddTj7xo1aQ3mDDkqqY4Biv+WmKjF3BtVwRXRGraF/xnYskwXD3AeSp4VnE4kC54SO2T4BXotIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYr1NMFMKvfGcN0MRxRaig0LTgbAKiIHMgkQ7i4xZF0=;
 b=VUDwHxuRVkcs8ptJR8xEuGV5vTXJvPgNWdY27/rVanv+wCzatkd8eVC85p0KDRN1jGRbsKUgetQsvWziPOIbdNxZfPEZfy+KxfdYSa0Ms05ubBKY6PW9HLG4S3H5frWm6dP67TSXnw+c9TrN41ylnYzcNlTRdy6HEMA5lu5UtPcouwJk2sH2rZ7AOQDGLJsrwroNbMuI3KgOZc4VVpbwA3gtO1rwfF9T84sQSdg6HVtHhLhJCLzMZslpA96broqy0/Gt7NQ+hsxrA1WweJ+6X3SPfkapVEc18ym69NZin0x9uGP7S0yr/A34mQX+gqDZwtoNlAJPTHgbGPuEG89DAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYr1NMFMKvfGcN0MRxRaig0LTgbAKiIHMgkQ7i4xZF0=;
 b=TpRzS8NjnRPSsEuBZTffksMpPYEOL1+1HMzkmpJO3MbQR2pixjWXrVqmHsquuNqL+9xC07oDw2zuIgpUCnbAXc6H1VOjY18x9g144zBkHbNE281cpscdtDNN6cRU5VWyrTPfqsauFxOFDEGYRLiymh4V3gy76XdwTzq5EZ8q7v/bS4IAQtbusO6d4GlzRIiZazU5IctsTnCYCCEEEocoqnPjXjkVKXFuo8JYLMfbkCN97/y4vctk3K43357c/y6OxIXXZsPn9A8PzCbK/KRZFj/a2Hq4QMujI7ZMEhumTRJ5zNcfWm2rhRgSrLxjuXzAUqIplAjnoQQXJuYWHTMEKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:24:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:24:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 23/33] selftests: mptcp: netlink: print out test counter
Date: Tue, 14 Nov 2023 18:21:53 +0800
Message-Id: <69739b815bd03762c20576df7713512cfe239876.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: a927ac70-7fb8-4784-47ed-08dbe4fbdc0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mMx0fX+XdrGha4tNs6oLaAgmYtSyOXS6wiTqqtRqT4fJhVCD3XHsKiFhxQuXTrzCfdn0cxySwOq7CXwQUxVIZiFixl5HSUkwaNFJE8xXz413X4ErhbDfgjtBhdhNNobx3asBbxhYvhsOmmC3SRpeR3axxEGpAJ7c/8qv3/jRQcmLO3DMlIaUp7KwdMklnkeGm5AbyeFzwvFzmz0Gxn34DG5v6Dwgs8dLK+koLTMA+qkP8XEPKoBT+0dpfAFcx/JYZrp58c4yrIxnnj7AeZJy6WU6h8BxydNVnc/OvdGFg/GuqRUE+p8PGCrKNt2PO0RJ7fy6R81DpGsDoemO2TbUrzYMwfEY39K9ASl+4d5yxooJHXPQEQISyy8FHixlvL9RoKT2WU/iTcUTvEoW65kX8u8ztLfINPThOwA1dC6aL3qT23syGVY66GYNJWlrefnxl6t6q2kvBwSMDLQL/8YdosGdDSINrcIios9DiBgo1VZ/nyAAxhwGfdtSkw5sO4Q0RK7dYI4bHKwV8EymeOYbFVO22FK2ITbmpgv4cGfisSbCOwn7nBy3LHimzY2oT3HP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(44832011)(5660300002)(38100700002)(86362001)(41300700001)(2616005)(107886003)(6506007)(6666004)(6512007)(6486002)(478600001)(26005)(8676002)(8936002)(4326008)(83380400001)(66556008)(66476007)(6916009)(316002)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IEDlHpqN9XPZg3n+BE+FaPEaiRdzIDLxC6D0ZJrK9pN6Mgp/BsN3/qy62Vu/?=
 =?us-ascii?Q?0kjXwNuxWovGoYV4FyVHqTkWry2C1ITmfGJJQrf0RWIFzsgLzIdhCMFJdQZA?=
 =?us-ascii?Q?hZebhR0ZPNanVgPqGDQPXMQWh6q0CFdqAfKn2mtM2EAKUvR6dY13YiGZNGjz?=
 =?us-ascii?Q?3AxNo3h/yfmzF0ySRCxiQMf0e4FJ/qu0GZkqOuCClNV/BiwVQPoY6ES3k+xb?=
 =?us-ascii?Q?oMu3BDffrXLgpnwQxagaJ755L4sRYA34zmxvsDyYI0VPBe1v42g1OrSZ8nu2?=
 =?us-ascii?Q?BnY9ReUqQzL0h0jJ7qrQV+9FJOh2Kox3DQJuxUW+CrcCnGKsdtOBjReN+C6i?=
 =?us-ascii?Q?UCcXgyxtg8cmfSt2CPaaPekT6sCg5kJqAac76Ru8VmsBBF81fKAhv5IRe5o9?=
 =?us-ascii?Q?quCKOQNIjEu3/1gDYcqYtFmv5JjovmypNXPgETd0Egdd/hjorsdGUWvcYJuW?=
 =?us-ascii?Q?Sv1ghLmA6LlaUQ0kis8/steh5zW1tMIxNl2hQl8SgAa0Hzvox+pN8eEw5QKB?=
 =?us-ascii?Q?/INjxamt3ETkiGt28mNOxIUNIPEDTvJFhCc728u171pXXm0JG0f7mEnVuoNE?=
 =?us-ascii?Q?mZEjKrDMkwxX9oBTrg6JfDfOE4Q18LVX0iA7gZvDpmuFJC+wa49DCujLU/fv?=
 =?us-ascii?Q?o10GjdWTn3AWtcMgk7hznistZrSVz0uQl1opohQvhwno6Jvt3P9XSezeIOWU?=
 =?us-ascii?Q?hdendd81/X8RvLX4Ar3ZScYeevMn4eKX4vREsAdGBDcUUyN+fXXc9lVHqJ3W?=
 =?us-ascii?Q?FVZ8skWWqgCqsrENt4ihEGg3MTkToB6rfTIYqokkvwh7g1WW8/WFRvg3x/k5?=
 =?us-ascii?Q?9YLVpeo2iR403WqcY1beBnEe/SAmEKTYn9lEboOYR2GQtQ1rBl0MvN5Vj1ca?=
 =?us-ascii?Q?I84p+nP40lJMmfbyTjvmilOXftxAkCFqgf3xy0ahvqpu4wvUkzAwHQthulpw?=
 =?us-ascii?Q?Szxc0X7yI5OZ7V5zX/SZ/T5ys5baxEDdk7RCV2HSrU00TkEU5MDQtcrDHVVb?=
 =?us-ascii?Q?uUxLfHs/4zKnrwyt9DQPiLmRDTuUi3c+t7e0joSJr8JImnupj88S5qCoI4XH?=
 =?us-ascii?Q?iE18gtpIc97TM0JjmYSCTE75arq8Kt3/FXNtxSB810Q6bDaFX8LhJOfQzKON?=
 =?us-ascii?Q?9aCMM2c8VfIKCioIDxQzf0MU+xagVWFSJwVub5LWGJvZGg2QpWN0tc95lvSU?=
 =?us-ascii?Q?iUb3nKMHke/Ts2WupRxGU8hQWW3+0JDm0aoKBnSejOjgPCmVcvm8lo/5HQs9?=
 =?us-ascii?Q?w9injEFJNfPU4kaw6ipi+GVFVxAAoiZzGEIz/ojJ49959ZTzOBz6Y/qD4ftL?=
 =?us-ascii?Q?U84qt/WtgkLAJI7de5XX3O53rd5rWXKPsO80+Z3WDOcarD9alRN+RYHjxOmD?=
 =?us-ascii?Q?AsOZ9Ibzuf+6iRIehbSTCTE2fbqTmKD59ELDJ1MaAq+h2vQR3JqfN1QHbx4n?=
 =?us-ascii?Q?rNRhQRDUQz17lsaEV44DbCn3fbdIQUBBAyVA2KQWiiM8ymwyh5PwXyFUQXx2?=
 =?us-ascii?Q?fKE1gC8kW5Vrd4Ir/KAk69DT0W1SPrUeGfsPzZ1stkx9FLEvO/JuJzDZr8Yu?=
 =?us-ascii?Q?Gpknk5ESfycHF7LnZS6rktSf/F95B/pf+0PtCcosxsfVDUM7F6l+QjgWaRMY?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a927ac70-7fb8-4784-47ed-08dbe4fbdc0e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:24:18.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unNsFgBxAEbVhXvLE8g0Rz/i40rP9QDRH0uMgS9EjuUoi3MTz/GFRWLF16JjgefivWFZXchZJY38Mi8bSftqug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

This patch prints out TEST_COUNT for every tests in script pm_netlink.sh.

The output looks like:

  1 defaults addr list                        [ OK ]
  2 simple add/get addr                       [ OK ]
  3 dump addrs                                [ OK ]
  4 simple del addr                           [ OK ]
  5 dump addrs after del                      [ OK ]
  6 duplicate addr                            [ OK ]
  7 id addr increment                         [ OK ]
  8 hard addr limit                           [ OK ]
  9 above hard addr limit                     [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 32265d4ecb41..e89b78e7d4a0 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -45,6 +45,8 @@ ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
 {
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%2u " "$TEST_COUNT"
 	# ${*} doesn't work here since there're spaces in some arguments.
 	mptcp_lib_check "${1}" "${2}" "${3}"
 	local rc=$?
-- 
2.35.3

