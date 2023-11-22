Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2054.outbound.protection.outlook.com [40.107.14.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A63D882A
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 03:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="faATY/vu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UG/m+IRlWWJyJSRdZT78aNChbxhaM6OOD1VZFYMxyIBLkFbHfN0sVWsm7fU72npsht02Ebro1LXnK9NnOiV+7Hl9l6R0w2LNHxVkL2UPOeolCIkN8n2tbyT/8poUUih8oCiEdZ3U7SN4KycOw5r2nUnFOaxEOi9vY4eNHBvpc995QVgYivyc1REFHVJqGae6xlcKjJ4ccTJljdD1uqj2sgytU36qank23uAIowY9xx5Ky64yJglJINHisJrB8lQwQcBzQA8HTKCTjcVHVFSbktxAIYoK4s8mhmimTCIgs19hH3U2/eI1Rp+itnRUzcJ6LP16fZ9TGlPY1m6SmEixBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpU9MOpelJMVACUAhPHTmDwCpC4rGJPwSQGYhb1YqsI=;
 b=HZXJIWvwjRHMGRXPPCNZAzVVAtbczWaFFrcysELZCn4cX0lR1/R9tL4NzCnCCFgVf1q2LDnUnWo51B2ZnN983ndKlCzHJO0RXcSa7jxRS/mtxeTQwGiVByF4ndxdLI37pu/K3xKdoElgj9U2vHKJQh4IXdczRd8yZEHovLlcjkQMaX7BqrOAWBBxnSZJbB8A9m2bF85N8utLrE+M+UzSbZ/PACPyZLkBWvplxGXVmbcBxwjxXR5EI+pKQJnoD3+u+m02KEusTR5IajSFkAuL8BeguQRIkf3wdkPC8dLBVK6XU1Hcwc0D4t4fpeUw0gfiYKogMK6VwcgSDVNUZbRyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpU9MOpelJMVACUAhPHTmDwCpC4rGJPwSQGYhb1YqsI=;
 b=faATY/vu36zulNaujepAp80KI9bvtLhC4S6IZoxvcPSFUmSjF086iDuK0v7qlLES8KeCiRwSKrNEo3DM9rJgqRhI9rmQFCkvgZo5hv5VUDpgPQx0/nQuLiesUet/ajDPlRlzKhZOe344ZPJxg3bofGXVg93DTszjbRuWkiG3mUEb/JXmc6FrewFWjHf6UTOeQtJA7UJwpRicKibkXC161ASXkHt/ExVacqTqGQScZ/DZzxtCR9Z7LvrgiDzxMWDqqwS5DHyPIBKGqUX+HH3bjpHm9yRxh3OHeszKfvmqUTtczd7sRXsfOTrVyUMuLmQiMYsYuA62unxAt/Wje+vLCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9723.eurprd04.prod.outlook.com (2603:10a6:10:4ce::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 03:42:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 03:42:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	kernel test robot <yujie.liu@intel.com>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: Add bpf_burst scheduler"
Date: Wed, 22 Nov 2023 11:42:30 +0800
Message-Id: <14a1120c9bc792ead2b926208ce85b5f10cb99fd.1700624540.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba01169-3914-482d-9f68-08dbeb0d01e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N5cMrOs14+1o5isyb6MHc6oKvdSGiQu5d0IJrZHk4wJ2h0LFm4u2/2rJJVRVi4tnrO+laDxaZOVRVPByXZWHKj7W9jfmdR9o29aX7jNJkHFYxF10aWiFavEvOoKOW5YaCl4Z/kXakTUCZUkdQc0vAH55CiiOQ7/5/tEclEDwk297FgLo5MWBG01PF7Ik8GSLYTD2TQD9x99HbdNEO7jzbXxrIClgFz9nllYWiqOIk6tyvZaPcmwxuKHZ01/H3Sqxb6RI3LHeB2R4W6FWgtlWrAl1FF9Y28lbKYhd5WCamRV7rsXfTMuKqLI/InmesqE7vJRT43NFeyxPf2eXTgxPf6haY/B7G9k6z8XzPuhhmjkyJNTXbLpVU99goD93kIH+boM3JS1CqRyswneUYwQVQFRBR+XfEaAGol+URfkd9TJOr7wyuk71R6hBWXwLpWwNh9sqFYTnQH3pjQ05mdDwiLgCyERa/CFhznfbVPqEIZS4N2w1DHhaxAwEGMW1VfBeHTzbJCi3qOjw5HK7+0+4Pw1Sk5pHx193J61kqPLZscpvvvtvcDfiOnSE763RwyEGxSuzkCWfI78HANn1IZNlfRgAf+UcBp5gIkzZ7i+8oSs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(5660300002)(36756003)(86362001)(41300700001)(38100700002)(66476007)(66556008)(66946007)(54906003)(6916009)(316002)(26005)(6666004)(2616005)(478600001)(966005)(6486002)(6512007)(44832011)(6506007)(4326008)(8676002)(8936002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0/WmxtMkci4sG5t1DyEq05RpXTmJe2drdqJ7GtJBibGBmEzeivRlUE6tcRNm?=
 =?us-ascii?Q?7U/oL9prBpWBFMVWyfzdTWAGpPkxS97MMuypYaPemzHgHExZy+d5yoOPl9l8?=
 =?us-ascii?Q?WeSHK5wG9gAJSg5Hogjig+IrsX7W2OfVRkUlBPqCx2g9k88MpFuT9dbJ0NdF?=
 =?us-ascii?Q?Zf5ep+dg4EpqSIDtOBXYzxgcbxNlrMGQwCcwmk9tCq60eWYTWjHfuE4Gi3D7?=
 =?us-ascii?Q?f23rMebpaBiIaXCVrVmwoyM43ajwtz1U76tlCqEXxhY19Mj7ATzcV+6XkrfD?=
 =?us-ascii?Q?hwtRFuIzqZpthGnG9hemw5bhJC8V0Tp1onv629UYpV44ZJpb5gQEJDbJIvB9?=
 =?us-ascii?Q?JIyDkof8wUtxDovl++YqarIayLfpd+/lE1mB+wW3olRkD92iqa+terWuGjZx?=
 =?us-ascii?Q?BtlrFtxk0RXexMgjPjn8//CC2GtnMvIdGtQnHObvFvH5TzPCBKiROYWPsfSH?=
 =?us-ascii?Q?uOo33g4Q9HhvWk1vLWTSWi6zI3sc9YHTKi2vBwAQk3CdrdPdaKKDa7b3vDUg?=
 =?us-ascii?Q?RxDuNyNQJ5tgC6JAfbaneniSaz421GEkMx76aWM270JXamMI6z/QRMb6MeKz?=
 =?us-ascii?Q?Q/QeaTt9IkAQeheU3WPazsBIR0IXjSdCyeynBwIqyuvnslwK+i6pk2RXSr3A?=
 =?us-ascii?Q?taeywmzSAfjQDw7uXkLm/CBMAda8wznzVH0mxLsDMZwJ8ZcSGDYGTlVa3Flq?=
 =?us-ascii?Q?4Lo8HXcTKa1eoIGpXLVxUj6vfZ33J5GftcZjvDhxz/Xdt3emNIDEI80yWxfl?=
 =?us-ascii?Q?AzarRzXdVlOHoNqdiCpz3/W8SFKs2zh+iB5Z0pTdpEodQcdOntlhrz9hgBSb?=
 =?us-ascii?Q?5UJS9xn4Dscsbv2OO+hBBvsUQ0oCF8heolEA9iIOQMvcvt4N3qnZuHVFaQlP?=
 =?us-ascii?Q?LpSZI8PKt1/6OE5qQUGFlgzMsIuKaIeQtjNR0nMt6sGm9yvF5WRX52pp0vER?=
 =?us-ascii?Q?x+An8rfb3BjNlYSRT9IF8CN/3/c3quTC7XrOvkU+9kBKoz5e427eljriKpxj?=
 =?us-ascii?Q?dsjb+1VcgCW7Sy5+3f2UP4QCB0oSuZVslqMHjq16LhvxsuL8NNRVJJDgqwC9?=
 =?us-ascii?Q?RGg8MSBLJAz9ofc3a0N/RP+0tlLgWND5JJzJ3IPvCF2ipf/WJt0scsIf1qdm?=
 =?us-ascii?Q?aNZvkCvjgr8Ar+229tpTpj5cxlK5xNeh0THA+fwc1NKzV8q2qAY1nMjRJhx8?=
 =?us-ascii?Q?2DhNnFi4jqQWmxmVkJwSBQLvBh8bQCtBkb6RFlIovyCCfadDRXPtXypT1Sza?=
 =?us-ascii?Q?kb2tdrf7t2ZVnowO9Mf/5d9tPwmvVjcdUKlGWH8G2QXTH4wG1aBV4aK8QsqL?=
 =?us-ascii?Q?xu4rq/LHPi2UrryCsgeWR628IUUBcIWsktc06aImCQAG1rhBE/KQ1GEScqVX?=
 =?us-ascii?Q?wO2PpJgEozbEyDDCD1ClVMpriJxw1LccAgWiIcn8wsiZSvvdSYtm6Z6ZOFNX?=
 =?us-ascii?Q?x45DYJ+kV6E0tXo8i3f6AzH5KKji4CS7lDb4mDgHkolpJYsMbvxylwi4T+8C?=
 =?us-ascii?Q?3YUmHW0XgZ9YeRrBs/Tfe9v0P7sOa/QlmClzNxy3WoJV8DTj6nag5x0RG02p?=
 =?us-ascii?Q?JJDcLNdsEPl7KnP4J3T7BXmBlmtw7xr2/vp1ub3Q1Pf7N85ZK1fZdqrhEi7j?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba01169-3914-482d-9f68-08dbeb0d01e4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 03:42:10.6740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vM/AG9p82XiFizaqFWpEQEJZjAYpQzV+xFpArz0hcVJdrlFsJbAngStX00CwV5t32O+ssh88dLX+mGD1A84Xog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9723

Fix the bpf selftests build error:

progs/mptcp_bpf_burst.c:37:18: error: no member named 'write_seq' in 'struct tcp_sock'
        return tp ? tp->write_seq == tp->snd_nxt : true;
                    ~~  ^
1 error generated.
make: *** [Makefile:614: tools/testing/selftests/bpf/mptcp_bpf_burst.bpf.o] Error 1
make: *** Waiting for unfinished jobs....

Reported-by: kernel test robot <yujie.liu@intel.com>
Closes: https://lore.kernel.org/r/202311180438.KHYloYBe-lkp@intel.com/
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 6b43845f1234..2c71226b3631 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -87,6 +87,7 @@ struct tcp_sock {
 	__u32	lsndtime;
 	__u32	prior_cwnd;
 	__u64	tcp_mstamp;	/* most recent packet received/sent */
+	__u32	write_seq;	/* Tail(+1) of data held in tcp send buffer */
 	bool	is_mptcp;
 } __attribute__((preserve_access_index));
 
-- 
2.35.3

