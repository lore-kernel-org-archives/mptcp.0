Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3701A2C80
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 08:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644397064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHIoEQngxxTS8Zj+lczwXnx+sqlyp66bjyD95ldHVD8=;
	b=e5hoLQzLLiS3yHV2+xY6BvIBVKqIhWlUbxFsODD3VOfa3a1CvOLRI16Uz97RqDfgCGjQlC
	bTvE6JwJAYEVWwqWWpaSYoOOStN0J4mSplVK9tIKPUfJtnV3X+e9kFuc/MLSyk9GtAQEzX
	C6FFmC/2z4YbR8X0fuJSrTi2XMzCPx8=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2057.outbound.protection.outlook.com [104.47.6.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-cIQyIS3fOHyIojIaumiRdQ-1; Wed, 09 Feb 2022 09:57:43 +0100
X-MC-Unique: cIQyIS3fOHyIojIaumiRdQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2LKiAjyzX0S5yVoFsurm1dRMkNDlWAHkW8MWZjCR/q2+90NeRjtvZtFxeYiaaU9rMMfPXOTWNQhSAtwtXljSv2Mv++JIb+D4uc9L4ldcqARBogHT9b0zE1vV4BfT2K0EuuE3974HAeSBzgPfvBLfHMWK1gsRztG6I383RLg7ENSDP/zSScQXSLD4/R2I3IaN/9eW4kcGmNhB8h42fYfKiYjT2FPW25j91l0OyIV648m6NTMGnZFnMuL1tZqAV3aIq2ZgU2gInz03iJ9X62iTgficQ/sJ9y+iNJc9DFDz4bS8Q1FNve/atYIqurae0U0MD1A0lypV9qXFnby2wrtOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qg4WJsQGr4yLxe1BzNPIO9wyNDnShHWops5zccKF0+g=;
 b=LCciL3zk69qNriqPGCQWA1xb3xDHtPJQjbhjCE2oWB5B2Db03zPE5orGPZRGrpML6oZdZxGL4aIHpor8nHKihOkeUPyN5wn1LfhmSDC9FtSCEGFgV5Vi9exhGX4UqWgz+p9UADK9Tn1Jekk5peQlmjESxFwdyLY4ALXI7bzyQTKr1/cgIvaIOJhCA+m5QXLVippVH+bccYt4M2w1CkOgK6J97P063GiSj7uyODSh3Y9l4iqrLc/KO7wjzoi9JjcPucjFFgkjcilJLFBl8cWl5RguclVT6yI6PdhGI/PAAb41NHrFhLQzjn6tZ5R7G2//oU1dxZxZizJTOa7LzsCDkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB2961.eurprd04.prod.outlook.com (2603:10a6:206:a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Wed, 9 Feb
 2022 08:57:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 08:57:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 3/5] mptcp: add mibs for MP_RST
Date: Wed,  9 Feb 2022 16:57:39 +0800
Message-ID: <15d21058081166971b94f461b412ba84ac02099c.1644396927.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644396927.git.geliang.tang@suse.com>
References: <cover.1644396927.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0024.apcprd06.prod.outlook.com
 (2603:1096:202:2e::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52d489d5-0f1e-4427-6a63-08d9ebaa3ba3
X-MS-TrafficTypeDiagnostic: AM5PR04MB2961:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB2961A255E997CD8B70AE2E8BF82E9@AM5PR04MB2961.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f70u4I7QZrAbcnAO9HEymDYQabqXuINx3nhnAXO0mo1EFSoqmwdW/654QAQ+yNDtrAHY5isTKR8sji5ZAURG2vwUtwdnbmIGTAiXvuSTVzxQ0q5zTyItL+L92vQS2rA4H8KVgQIl31e79cqmBXIbbf1ESyiqXTQ5105BTWImaglqRyUwi/2k7FL/9SpM4ICgBkiZfAJAKz1f+pxLNvIJ8C88BfetsY4tFEbZBIIhLXyQIVAJFz6go+sz673O02bmbL3OQ4UN/Ti50gmIlvWSMCoPs0+Sx2x/i2RMHcmqPkrk0qJjycLsHFjDGz46/TiI8S6r6bVMxIG2Je2ZNY7AuH3/tuxyiTYtuajV8/PCgkNT/aFnuNObwoIxqg5T97mYpj71V6gteWyr5Q0LDQ2BcNYx0FtDcWXZxfemWpGWWSY8JMfIfkiaLHc7MLEeQy1CakQIBm5ytReAMvtdE3d3cuXeN8VtWdjvTFvfGWHnpXbvyBPiSX9t6wDPrSkknNbeX/aa2ylzoJD3R0fq6F+iBsORAGMc5zj48G5wkJip5duuCj5IAy2uvKd0Aso67kpzuqJadCkzZBJqCsZpV8RjbBepk+lKybGgPgo/4+XPjvjExMJ9bY2MM8vT9inh2DueHoVSCRbZOK0X7yMKqBHUsw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(8936002)(66476007)(4326008)(508600001)(38100700002)(55236004)(2906002)(66946007)(6486002)(8676002)(66556008)(6666004)(36756003)(83380400001)(186003)(26005)(107886003)(2616005)(6916009)(44832011)(6512007)(5660300002)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?az74+VbKqbEPiDS/podji8s9bDNJ80wtKflcKgdxDCTv4R69ymqsz4xR2/ro?=
 =?us-ascii?Q?5SDxOlVNx6gkThChtCgGBWBSDo65F7V3TOhQwuuydAXH92fiuFTGAwZGPwYp?=
 =?us-ascii?Q?/ID3SK9q4zBKKCT4s1k2x8iVuKxqjtvwqxkucTTcPyA1oQJTxHXNCHjmauBl?=
 =?us-ascii?Q?Lw6JfLm7ajJn1eO0eBBnTVE4Qk5rp4rPYq2YojXLJXg2guqOQ03ad0SC8Wim?=
 =?us-ascii?Q?jT4ILy6EthBFNi1f/znywpN4EeYXozU9/rTLQ0+EAF6Y2V2uDpOVcz/RTy2P?=
 =?us-ascii?Q?NWnmc0hUmoVzyVz3N4myXu+fJVB1WaH7afvzsgx0JUm2KcfgwhE005ptEReq?=
 =?us-ascii?Q?asg+dZozE3ClcIrhCujyRMzvzTZVffK8nrgSTkNGV6523h31XWhQarfVhX6N?=
 =?us-ascii?Q?iAUqoJZnZybdrveI6b5M6zVVWwkgPClcsuk3InQG+qsidPpLIj4rRaWnhkaG?=
 =?us-ascii?Q?rhtq89O20ktxJmTAod/Ob7XS6lptcaL9meAT5l31ANVaIG9Xrsn6QhjTPJNN?=
 =?us-ascii?Q?h7a3EIrypMcoqve/YDn5pPiXHvxcvTSy4uvHBkDlVyJ1vb/egxSP/DQWLnbw?=
 =?us-ascii?Q?ayrHjAWyNIMFlsHDNtlcF387dbmXP9K3oFMFinBxWDzSgJQTfZ4mCRCYikcr?=
 =?us-ascii?Q?RRUB1vnziv1Ii1iKglE8dVHe6JFFbzNAV1ZdOXLk1QcdMDZGI9wijSAd+K+v?=
 =?us-ascii?Q?C51mLOoAZmBxYIBIyqpoLNz94mPFiuoGhzeyIPnw9QDqDBz8sHWOxQdtXM36?=
 =?us-ascii?Q?gsI31nVqf5CVuEX/4/ADwN41mFlqCBHXYuyZFV0wjR7PPs0EcE5pH/bnw7jr?=
 =?us-ascii?Q?AcwYidNjOmIZI9a4txDtaNZYwibS62f9kbkSW5WAdysDM9jXuRP6arRuMVwL?=
 =?us-ascii?Q?nPfv+VEO23PBUvbwHlMvUMlLc7iuB2mOKuKtr1UYR2yzDFWxse6G1TiDl+kf?=
 =?us-ascii?Q?K0inrEww3DTAfRKSA2XxkLEWe2GJ0K5RYSmoxEAfS2Bd7hevpvmq96XglU/s?=
 =?us-ascii?Q?9damnktOraCpZe0ThFBLnKqE9+Dd3sji60BcyExeCFmGcNtaQ3hfEAncrmyp?=
 =?us-ascii?Q?yCl4Z5a3gwh4raHdVylhzXBICjTqh3ibPph1dmpVF2KSLGgUr0/YNrRKn21T?=
 =?us-ascii?Q?/Z3U1tDLjNsq/H3vNiVBO/RzoGwbF9R8rtp+CgquDWpLLAphHxcYBshzda1O?=
 =?us-ascii?Q?RK/UKe8X8Cg75MXeYJVoMHfVcb1kgGuTibWcv5SxWk3US25UQL2CjSKn4lB4?=
 =?us-ascii?Q?DDUb3EVtqmnmLzxaWZfV9Ong4NjbyU6GYqLjP2hlRIvlYxN+vhe8/qtAhW+O?=
 =?us-ascii?Q?gfDabgemzqMzCTyoVYfXTLreooFBBi0nOzDiH03to/OShZOD/iF9Pci8FQYO?=
 =?us-ascii?Q?b+zclEQqVTNDhyg67+2jVE1GidU/50+MNhAHz0I+ALwkZr4SQ9s6bjiz7aKv?=
 =?us-ascii?Q?iOzllP6qIMFUomCjPt3187EQ8mPE79inqRnhqbZW5iES5VCJBkyAujDwJ7ob?=
 =?us-ascii?Q?qvsFxtLjMykpmdVHitLa61rflOFr/HnuSi70FXSHCCSgkpvo507agl0Xtlx4?=
 =?us-ascii?Q?X/g/jZWViXTTRL3rCY5JRPD68MnEXGUYRF5BxCmIneiUJuJlRsLgevUKg5e/?=
 =?us-ascii?Q?88xZDsH3VW4BEnmLFD9qD3E=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d489d5-0f1e-4427-6a63-08d9ebaa3ba3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:57:42.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPYV2NtHWW4HB1GzYrNc4o5yd9DiMQ/WpUm4gNK/EgIyv0iFd2kwGbFW5wiHmHQlGV7EwK1aVYnt5s5gkfuZNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2961

This patch added two mibs for MP_RST, MPTCP_MIB_MPRSTTX for the MP_RST
sending and MPTCP_MIB_MPRSTRX for the MP_RST receiving.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/options.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index c12251cb0d44..bb7808eecab0 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -47,6 +47,8 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
 	SNMP_MIB_ITEM("MPFailTx", MPTCP_MIB_MPFAILTX),
 	SNMP_MIB_ITEM("MPFailRx", MPTCP_MIB_MPFAILRX),
+	SNMP_MIB_ITEM("MPRstTx", MPTCP_MIB_MPRSTTX),
+	SNMP_MIB_ITEM("MPRstRx", MPTCP_MIB_MPRSTRX),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 7901f1338d15..37226d8d5339 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -40,6 +40,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
 	MPTCP_MIB_MPFAILTX,		/* Transmit a MP_FAIL */
 	MPTCP_MIB_MPFAILRX,		/* Received a MP_FAIL */
+	MPTCP_MIB_MPRSTTX,		/* Transmit a MP_RST */
+	MPTCP_MIB_MPRSTRX,		/* Received a MP_RST */
 	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after bei=
ng stale */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 670364cd455f..556d68e0e50b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -838,6 +838,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) =
{
 			*size +=3D opt_size;
 			remaining -=3D opt_size;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTTX);
 		}
 		return true;
 	}
@@ -1159,6 +1160,7 @@ bool mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 			subflow->reset_seen =3D 1;
 			subflow->reset_reason =3D mp_opt.reset_reason;
 			subflow->reset_transient =3D mp_opt.reset_transient;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTRX);
 		}
=20
 		if (!(mp_opt.suboptions & OPTION_MPTCP_DSS))
--=20
2.34.1

