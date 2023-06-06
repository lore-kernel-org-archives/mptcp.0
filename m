Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CF628C0A
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 09:02:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxstTl48003b2Idn6lHEDNxqtevesuulVNa2KDCQkSYshg19L6NomKpf5Tc84NJIdgNznsiRXac0iwj1cEUcQcrt7fd7OScI+7tL0dR4Hh1Esmz6WL+GzX9hNHqNIAtQvMid+3dWWUGb87W6+0RgSB1R/FCWjPIueEhIh/NQ2XPno1TRIZBBWh036LIcFjPXcLVGWWfhle50qGzOOrzTKaQ0T5dPAC6vaYQEca2atpDxl/ym1T7cnlc0HEqMdecy/ZhrB93uUxZ8VXUmMcFsCbtgSIdX/JRaC+zjv5zsBY8XA1T31AvPv7TbJo9Dgp3gWladnmDzzCU5M7sJ/iromg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGqai7DOnvtT5S7TE0eujlgu8GJ97/FpVZQ0aJQvVvk=;
 b=XMNDSftp6mdPPX56/a0DejGobrzSWTN6xNqlgv7LBUipOAmDLk/AvMos2sWJk7L46OYqxwyRf0AQmONpEBqRDRsDszF1kSH4y4JV/yNp5KpVSo6xnWXasDtyZnXWZUcxNkUDSC3VYrRHOuiBpWH+J+zE/JggPY7Ssa0rrGwqrLyjLBqsk4MTxfldW7U2wiEnZ2rFehwHpzMUku/EGUdq7X0jKTo/yip32lVXywd0CYGiZvDAsh5A5Zm4OVTwHUPcc1xmiTh4MoNcVFbzmGXR1Ut1UL1kxlfbaNJ1ljH9kH0+ZYQFpl5iyWpTx290m1xjyN4kKJ7oAl0CG+HNMwMlTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGqai7DOnvtT5S7TE0eujlgu8GJ97/FpVZQ0aJQvVvk=;
 b=DSPSN6uT43ZyywC4KK6Hv2TE7krz4+JeGNAk2yapFUO/BeparzK6OM2HyWR5UP1NBxtP9XCQf6sIRf2dbcfpQBBoD2tAKqVAZaWc2pDA57G+5eQaZgwvbaMd6MyMf1OrWX9yMDTvhqu8D1zOCG6X9meikyl/YX38YtM6ma4+AZD0b5Nvbn2u1ny3GIAS5Bbt4a90c3Jrnyp8At1FMVJUMrlR/CtYzQTZTmDdRGm4iNJu6XQ36bwTkeo936h0p6hWqwRJ0mUve+ij6Q0u/QI7/M2zjEffqq80Fm7l384fhJOFCS+5ghWHeP0dOEQcyZomz/ha6CNc4Hvp4M2XBWc8pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB10059.eurprd04.prod.outlook.com (2603:10a6:20b:680::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Tue, 6 Jun
 2023 09:01:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:01:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 11/18] mptcp: add two wrappers needed by bpf_burst
Date: Tue,  6 Jun 2023 16:59:25 +0800
Message-Id: <c560c8a5eebe7b76408312b02476f5394e20964f.1686041504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686041504.git.geliang.tang@suse.com>
References: <cover.1686041504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0030.apcprd06.prod.outlook.com
 (2603:1096:404:2e::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7f0b2c-6a1c-45d2-4846-08db666caeb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KdzKkevlNGXzysWUCb3tevfktZapTP4IH+NWNFNILYG4E7nbeM0FvnxZdQ7X4+wLXcc1xFwdZrplT0VZtMKbQ6xhg/EKdb+YyjwjXFRSeU2F3AE6IOYhMc8Qdabtuz9TERfnfwC1h3+/5ADL/fo3hhHyOeVVljYzaupacibAp5/XIm6Dcup4lHPGyN/PvK6/ipPJTFBU7sraHY4tfn+qUkoCTlUqAu0D16bLraZcCyKHfGBExHQbUSQQFT61mkdYEQ833QFDWPfWmPW6YykAmwqrjRqfrRUo93tVHRLO/ear2sAHw5vukkjJCIIOHfktQwuF+pHn1OzG6dFwuYkat/IPqzhK7Gk6wXyHI9YbdaoeIRDJxvCICU+b/TGhg1ZNJHilEm7vZAidqs7W7YAp/EMoritsVeIUHPeMsK7zSJQp9MJC3FCSdZVU/X1d8+kOvLdI0vJzK9cvoREe6fD84LXt1pohj3dsD+agrRLdsH/KX9G08zy95PunUrVbBN9T3XBxgW0Bv2s010+gTnooZWA2ToG/u1EhDLQ62wd9WzLVVL2bmCHqUmTmXAouII17
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(6486002)(38100700002)(6512007)(26005)(186003)(5660300002)(6506007)(2616005)(8936002)(2906002)(107886003)(44832011)(41300700001)(8676002)(6666004)(66946007)(36756003)(478600001)(6916009)(66556008)(4326008)(66476007)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XjR28uoLkQI1Jrtym//yCZh7aRXuOkiN8T1LJ8P1tDi6qoVIMV5CHoQhbt42?=
 =?us-ascii?Q?LMTTERpUovKjt815mINp5uGrieluBtxrDD+6sUbyKWjhV6AmBnipZzLrcseM?=
 =?us-ascii?Q?DJbvw24xJwI7IA+wD4hBu5c+DdOWgpOC5q4T6t71Pfo00zwbQMkCMqSLr8A6?=
 =?us-ascii?Q?jDQlapcrgQAvme1tITATa0MatoWj0phcYpNuzQL7Gzj/82Q88O3dFO0LjC/o?=
 =?us-ascii?Q?HHeiKZAKz/zSxN5TS5sIJIriAnZvWvlimh7DU5iYPB7EDjO1Jk8nUSOWtzRh?=
 =?us-ascii?Q?6BVnAv0ytgqt6xl7GaFo+6Vvd7gqEST4ZsMGKTHjo92krzszkZ3glUKWBwbB?=
 =?us-ascii?Q?M9SNKzM2OHGzXSKuCahiOlCnNKqzwE8OCLWxFDyzsj+dHPNCsWZnXzz6PwO8?=
 =?us-ascii?Q?kOVvAaSAYnVtJCU9w7Ye3OUCX8++wGqaPiHFmrq7/6P511HbsycutCxajhpq?=
 =?us-ascii?Q?gIaushiYnt7Z3pGutoarWSzo/Eoi+sp6Y/0307lL7yu+SWawIfRwS/9U17W9?=
 =?us-ascii?Q?o3X23EwnyAxlWDHf/sEK8FJxiGQ93vuDouXQXez5ImXsnzpelxm0GL1k2kue?=
 =?us-ascii?Q?bZWeBH7Br6ppZwV5Q7zqsPihfN6TnmDoHVM7TAbiGVSuJjqOWx21i5BsV2F4?=
 =?us-ascii?Q?WezF5UP6K+4w8DIhf1NHGLyt+nRizqSASFBac5JllqHmrA9eMJsXoHHeE6wx?=
 =?us-ascii?Q?I3lS1Iiidx+AbTXmVWEarNLftI9SY+QsZLO67lu3Sxn75uQmg8ptM2jxDnj1?=
 =?us-ascii?Q?23EiIZJhJn4Jdele7QhaF/qHa9R1eSReCdYKnVyOinkXRKcjqWmtiMafCcAU?=
 =?us-ascii?Q?q+5AEUBXI57ZTeYLPzWT7cafI2VW5aoNTP0Dc655hnVK3M46LWzHqrFzt/xe?=
 =?us-ascii?Q?/2FdP+u6cD255zxVEWSsWfThRRA1SJcMrnsEBpnFjg4M90iQRvRhkMrdHxxU?=
 =?us-ascii?Q?Qih9DouiDxNlSwwrY9riuazDZL1IB7wkfBGqAI6BqRN1kFuxxCrxH/vUhANq?=
 =?us-ascii?Q?pHNY7vhW6Uomon2RMjM7Qjcds0GM032CFBBlLBOME5HIxhwhm+J/g/+cl/9T?=
 =?us-ascii?Q?N3UlbA5n1IeLDPSw3+o+OGJyu1IFIbcEh84ktm9lnQFQKLHRcS121oi6ACqS?=
 =?us-ascii?Q?UCFb41r7EZakFFpErMSBqhSdtSWrRiUqLglq5zRPV+iTcRDtAE7kWBO4+Otg?=
 =?us-ascii?Q?5eLhN6ghnb56vGotTx8GO64oyrUjsYaIzOYg373qBB9cCesX3mAO0FPhEVt4?=
 =?us-ascii?Q?Rt5Ua1FrHDGwjmSCCaCNT+yElwlyUsIBFmnpBvu38njZK2vd/7VKP77xeJDf?=
 =?us-ascii?Q?swaTu37deCHWY8Yjo0rYpBH6Cg8Qqzv1g/OifkehfmhhC/iEVavXXw6vm/9H?=
 =?us-ascii?Q?4C/2CDO8/gbN3ig3gmavm/za4tto4HHw1SrbOlkuaiLchC1Rv/gRbcMcFJfW?=
 =?us-ascii?Q?EOYebZvUQRe+enjxZTquoRr4Ogb7VZECEDW1W9hWuBpao3G2oAPBJJ0jP/BC?=
 =?us-ascii?Q?6l+Eh1aUkpZpWftMZRa7n/QUG0xTtgaQHzdshKwIvcrdug3BYleabvIa4ecZ?=
 =?us-ascii?Q?QyKQLdPbiBpGJLPq/F9lJdaCV+p6yXmplMCbhKFB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7f0b2c-6a1c-45d2-4846-08db666caeb7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:01:57.8401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymZ/APAZrpSPcURHJ4HIiCXL7Dm2yIyDsejONGwgR6nhRj1JK2v7QdERLa3HU1nNeLEv/MsWINg8tLPYQLFiIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10059

sk_stream_memory_free() and tcp_rtx_and_write_queues_empty() are needed
to export into the BPF context for bpf_burst scheduler. But these two
functions are inline ones. So this patch added two wrappers for them,
and export the wrappers in the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 12 ++++++++++++
 net/mptcp/protocol.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index a2bf8bf691d1..cea6a8562f70 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -166,6 +166,18 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 	.name		= "mptcp_sched_ops",
 };
 
+bool bpf_sk_stream_memory_free(struct mptcp_subflow_context *subflow)
+{
+	const struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+	return sk_stream_memory_free(ssk);
+}
+
+bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk)
+{
+	return tcp_rtx_and_write_queues_empty(sk);
+}
+
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 12c8c95abf52..29bba51b948e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -668,6 +668,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
+bool bpf_sk_stream_memory_free(struct mptcp_subflow_context *subflow);
+bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk);
 struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 				    struct mptcp_sched_data *data);
 struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk);
-- 
2.35.3

