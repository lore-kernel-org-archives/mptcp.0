Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C6BA23
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfk551zKW+CeyK6lzfZLiDs7DZEURyZySFVb3m+2rptWQmShApyrIAbS9zm/3KPpmquJRdB6UaHn5uegbOYtqxdt9G9ImosBLqpB/cVX7Yy7YTvG+JBrHe1z03yGWawczFHjbNfRl5QMOHs14X/4K9QTZAjus2z2kk0sZs/SpA0p/GFF9s/q/95it41nDk3klGsCo0E0Rk/NFZOFLgDudvVq+rr62/klMBnJrhP5P0Q5PJUzc56wH0bHWz3+9rUgsNdWlUdkjGg4I9HxisBkToukZz2mw1TY/Md0YfZKbISs57hsqEqJZF9WBH/VPuwh/ucCIRa7sQwZMEh4DM6FhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxvG6YszIDsQmFui+RSCVN12yJRmJnP9NWSS8V0WdF8=;
 b=XdWgIYbM+bi3R1oSCCFJ0dvamqWUVK7VuUO/dv0ZJCp9kCnYhJvS4RC/x6cF+y18IxLpyUgHcSvFABGIJRKA2X0Nh6isvic/ZEPLS71ysJKKl0qH6tXVYEWHzCGonCliGbZr/v1Ai/HW22H+gskLxjl4B1wIhvdWrVfg55BLD2s7iQgnyM5ArY16OxqJLsTLaivUir2KTCmHUfg2IxDZyMoz3C9Knijpz7FJAUd1AooO5vKvJQSP964kt20XJeXPHoSun8Rg0t9GS6rZXsYYbVbnuZX18SuhlQVUVhyKZF1deRI/oiim5pxDZMQ/LfinXGe5t6zsQSJYra+4PUxSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxvG6YszIDsQmFui+RSCVN12yJRmJnP9NWSS8V0WdF8=;
 b=So6olPlFdTB7qrIQlkQ49w2WVj3pOcx6WgXqNrsupYj5Cw3qZS81FizXLSPXjCVaa06zTzpJ3kZzBmFaPwcS52xxeXLySwLLwqirRhVQcLuih+GyN9xJ1F5dMtHEunyqwy7s/O9+j6o9Ofu37E5auQdKRufnnxlv4MX4uscbZsZMIFpIWaqqk+s5caxAgK0i/4/mapxPy1y/jhkcbSnlSulQiOnaRJZN9Rf48HBAmMZ1gsMtswHqsPs/MNYQ/TnqpRQvmhMhu7YHVvf05B9z1XmjoWQiBhcYnJCVB8PrjZQvufo8PgWPvvxFLv7tVeXy4UoujUg/5nixsnzRShRr8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8277.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:40:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:40:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 04/10] Squash to "selftests/bpf: Add bpf_rr test"
Date: Tue, 27 Jun 2023 09:39:25 +0800
Message-Id: <3a40a2f85b999718cbe56427a7c20afeb0298433.1687829823.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687829823.git.geliang.tang@suse.com>
References: <cover.1687829823.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f1070a-05a7-49a1-122a-08db76af75a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4d7+0D2Vkq0pOfeSMu4GZjHgeTgU5BfE+n3v3uLcP8aViaoBhWtqqL5u8mjTHviI6pt6dz6+U6e0AZ8JVKqRGklJu92qw6tlpu4bNe0r05fSfccmb9IwRkjKkfaWj+rRr3LVAs1vtO1zUSKEibdQzZmO90zems3oWPBV4t6EKkY0EgJE5CdAOMn1w9mDVwTjd1segoSzQKyPM9Ohmz9z3Ko6B1DVAhl9tHRjOgTIukkqQpWYguUe0/u0olg4ypzE+rp00pAB2KeMiOg6nsr32epH1BfmeIJCGXtcvnyCo0vk8kF/zAHcen9zBA/kn84+PwjinP1gIq+pUdtWAXogQUc2CfyPIBpn9Ls/Jf0t6pYED+2MFBzF2KSwopOk/QRi1aDrAw6Gz0BQkWFXcHu8uQRNmYEC8kD0znmY+rGnTaRjwOuFX6fvo4f9DLByjY6inW8IQXL1qd+ijiSrQZLxSSMdqpxkOH4FCgdFc6d6tnhsteHroEEpBZpeMX9Q4tAr1FDvPt1pW5b/ePqGF9sZeFUa5xtGFOyjb+MjrHy+SQNMwBmsvBBYXTjjtUd29nad
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(6506007)(107886003)(6666004)(478600001)(2616005)(83380400001)(26005)(186003)(2906002)(4744005)(6486002)(5660300002)(41300700001)(44832011)(86362001)(36756003)(38100700002)(66946007)(316002)(66476007)(8676002)(66556008)(6916009)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dsrh1ixn2ttNUHbciSx+OftZ/7pfXE/lEtjyHJGjlWPc5aaiB3lW8BnlohaM?=
 =?us-ascii?Q?P/3cvcJblAJzqj1jcIl2TB59COPqRuMmGrArq4o4d0DEYL6IAU9Fh2jnyKQy?=
 =?us-ascii?Q?Ba1DNdrtBJ72K9yozuy18Hl8Jxaeyi322ykEhiyinUB2P34n4buNid70uCud?=
 =?us-ascii?Q?y8v1//8aTlW0n/jYp26I/HYGay/KgypGToZJ9JK8swTLGPJRf/mg83/xwI1P?=
 =?us-ascii?Q?WXHuD07QdWEiu1UuewX8iLSinUrqcHpBIa1Q9oe+cXZDTNWZMNQBS9jxnKmh?=
 =?us-ascii?Q?gyvxne8gK+o/VPDloHO+yef68nHeIm+RzVadMPFiypV8EJAbFF3jzwaMldbV?=
 =?us-ascii?Q?1ii2Nm1tQvc3sl/MB3F6PWJvnZxkxDsGSlZzS1Rcy3KSRFIGk9cW84TtmZEX?=
 =?us-ascii?Q?/drMLyjb9J5GRaM//P9oEyASVJPoLBfPmsumh8HTGSjfZ538riW72HyrUikE?=
 =?us-ascii?Q?iNfk/JqbrodPxo9+Mdss3R/C8mkatm0OqMejGrXXzM2QDF1dN+RUrvjvsfIz?=
 =?us-ascii?Q?/wH81vLoe8bnmJL9whd35AI9Fp7FatHRDB9/DkqZn6zk7gCHnTj7GlW3ckhQ?=
 =?us-ascii?Q?Pf3ju/QHBkvdagTx003OUBGGHFW0Vg+skeUee4FNpseP5uX6aGc+ibGL0cji?=
 =?us-ascii?Q?x3MU3JxeyvOzQ1+46cFet4ABERXey/JPEBKho8EoGA2FXCkE5rcluftW3IlA?=
 =?us-ascii?Q?nY8J02irErcb+Bk/h5vcdndgsjgq77iz0l7nDDCxw41/mIiaagFSr0bpseok?=
 =?us-ascii?Q?aVyGoiQDnkXRdzqPQQ63XReAwIsK/iXi16lsebFJDRs0d9CeL3PKrxR0s1Zf?=
 =?us-ascii?Q?a+++c2+dyYiMYM6dEjg/47MP9yGnx3wubr8GwQ7f6K0QPtOusPM2FcESFj+y?=
 =?us-ascii?Q?e0U8A1rQImlQwNvNl1JfSfuo737GxjS6/3XbSwjeC9MbMx0OiisyWfP5TClv?=
 =?us-ascii?Q?/2uBHcnj1igGGsoClhhdvBT2NorwKFyYp43T8zbwtBDG4PiDfE1iplPMOLfC?=
 =?us-ascii?Q?pIYex/2s/L+u57FRfkNZcMPCVfS6+hb3W3CIEXTstx1Jc+ZNbmNrYwG20cbZ?=
 =?us-ascii?Q?iBukWl5Ax4aApMFo+s1MTNtj5iNBGjkwwDnyy4aIlx/4JjraT29YUPhB/Y0q?=
 =?us-ascii?Q?RUA0RsJ4nqK9tjpArPVA/rnRRVkpKNaCJnZjtWIHqIJ5CJfWZOxqraxysUjO?=
 =?us-ascii?Q?EBK1oACvOyXM0SPUwJ89psyIs/aR852T8PNN2/RRefTEhHK8RltuXf7vormp?=
 =?us-ascii?Q?AnoZ8i1F0UJy1dBJ6blZTq2F5dwz1bnNlSvkUnfDuotTFV8zXWfYECMvI6oK?=
 =?us-ascii?Q?CrQyT8IwiKtkRJRKZ2MeJVmTL7lSIEMxHA4hip5zVDPkMmsbT/FH+EbAxzKE?=
 =?us-ascii?Q?1ukQDwQHNe/LiZD7D7S63rQAEE/RH51Pwas03/mvKTjYvLqmxMze2WrAlZIZ?=
 =?us-ascii?Q?EUi0Monmj5abBfokf6lNfqhl78TAnbDB1j/9G1OYbnu9kBb1iw5fd7Oh0hD1?=
 =?us-ascii?Q?/B1ssm+oQCHbROOsN5vHkiSXKf5HrDxi5JOeQzzVdKCibhI0QhTKJwzhPoWn?=
 =?us-ascii?Q?Gbj1joCu0drNcpB5DBmvqTcCoFqsfkGJV+BiBZI1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f1070a-05a7-49a1-122a-08db76af75a3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:40:16.9100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cc3WZVd6BvN9poxBx2TiFAFbAgJ7AdETpOycUPxePusTmUO+DKiUpxeDG6jONhA0WqW9Q+tMk8P6fUSG+y7fmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277

Update send_data().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index f58b83ebe52b..0da7f83fdaea 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -441,7 +441,7 @@ static void test_rr(void)
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
-	send_data(server_fd, client_fd);
+	send_data(server_fd, client_fd, "bpf_rr");
 	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
 	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
 
-- 
2.35.3

