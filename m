Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E788072
	for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 12:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1634560467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2u24DgYo4DiFYMn5MBkJHH4KD5txuAt2b6UMGB03vo=;
	b=MyA4Tqoone1HvbItGqkP8oEMjPcdEDKYc6cdBB2o1ca8ATIRXsEgqz3JLYEibUcOyTEzo9
	kGeNv8e3gUc9lCvU/P4xnqFzJe7Bd6rYCQ+2IWhaUl+Zti8ykSTvIFYUXvEX0RO+RIsUu/
	xD90Rs9KHx0QtispCNXe+LTgLabsBWg=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2055.outbound.protection.outlook.com [104.47.1.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-9-kwGnA4K1OfqSlYWZXQ4zHg-1;
 Mon, 18 Oct 2021 14:34:26 +0200
X-MC-Unique: kwGnA4K1OfqSlYWZXQ4zHg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1iOEJ4SSLr/BP+4cpFEmP1UctcwG/w0GoMkjHy5XQxxdlX83GrSvm0eyLr6u5MHE4RCxpQgDr+xx73QzYfAf94jzDOigMnGhW/LFnHJzHtVPRAE1dkHUF4YoAJ/RLBx2Wx9Af5dNfXuA4yWJ5rq3QrGtgYpDLrE2XNK3HzNnghLc7ltL308JwWGb8uaytFv0xFaJQrd7dt4JToYKRJFnYkAXfIQOiepFuEPWyZNQq34Y+ysdF/4y1bl5aB0BMaP/zJq/a/NzO18W1rjvLuOTTkcAGnNo8A6tgRdJqLS5wsit5BTPET2CvI45R4ROiduga+gikguWc64wrmsk8MQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLFW5DaggXeTNXwkbU9uq+mkCjLnjrHmDCBBYfUwkZ8=;
 b=SNPgLzIsf7adE/jDLUzAxvDCGgYg0yJ0Rx3qRARp4QOYJcG6F6za+kRoVM9zhLlTUPzm7ealjFTBglbzmdAqT3EnqWISkB3wO4P6mg1t++6wmw31ShGGtR5dpPuuaAdxe44X6Mt1TI0LsWsMCFcHbiDicRvFq7FJJOvDT4ofYrFpCzxGduCjvHJO4mrjbnDkJLCxqcrXbLUDCzplopWmp+SsbdBHFV7srnACkgY7t35DgtsiI4Fc9ehZ+pcqsLXzsJwLU3Dc6P8/IEOXpXI9Gbuaw8pdbYyQV/xXJscBLGeYYsIoGIauwEnyl4dhdOH41MIHiBpiAaVZeKIh1JANZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3340.eurprd04.prod.outlook.com (2603:10a6:7:81::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 18 Oct
 2021 12:34:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 12:34:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 6/8] mptcp: add mib for infinite map sending
Date: Mon, 18 Oct 2021 12:33:13 +0800
Message-ID: <3c4cdfaaee83ea9d7a13073a5531f1f620240de4.1634531093.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634531093.git.geliang.tang@suse.com>
References: <cover.1634531093.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:203:c8::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (2408:8207:2546:b4d0:1867:9999:db2f:de88) by HKAPR03CA0012.apcprd03.prod.outlook.com (2603:1096:203:c8::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.13 via Frontend Transport; Mon, 18 Oct 2021 12:34:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ef10629-6392-44c3-7f4a-08d992339edf
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3340:
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB33404E8B6FFECB6797E710F0F8BC9@HE1PR0402MB3340.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X6cXhrS8MmwqQcv7oViKgKOhaiKhcQ/SlyZoHWoewf27LeR2pzpoj/mzBNORbZqXDIrqDrilGXnXtPF/ce875uoullG6Ejuct5e8te7Edwtq+8+Bl+kTOYAhYakZQpsu79AlFFyV/Th5QDlt6V4UyQ45KdOJdEaypY4cI0Y6dsvntDhetzScxsyJj1GQ9O989EH1DjImj5TY8tzQ+NSVTcAZcZpD8/KRR0f2SjNZLzWtQjT6KEbkxZyaUyIKEMs3HSOqBdRNlWQF+3D9+CCp88y0n3fcZAnvGbNA20HrHW54yYh6iIOvBkrosUaFlrAjFhuMSF4x4eY3zDraJi3EYpDKWIHwkWocQ3vX5ABgZixJktV31z8/TlGk7juHGLH7tZlOp98Z6NAHjoSjtWaM5eCp0L6YPcB00Eq+SMaaN7GhxcxfE/BFnOpKys6gyob/qF22ScFCfZ2h8ma52FAFFvkIBgVH4mKqDcyuCtp32mPP26BJhVWCoGWi5ZSpsBZ/E98Wj7FOB5u+eh8zToDwb/C/skU9/nmz6v9Zz4lRKioLx+zs+E2zfm/prChF/4tDFzJSGlghakaa/mPNHr852WW4o6i8qbjMSrN8L5mwXbE1xg8hJAJENgsQskOLWXV4fT+Mw8dP+Wq9/sNWUnjGDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6496006)(66556008)(66476007)(86362001)(2616005)(2906002)(5660300002)(107886003)(38100700002)(8676002)(44832011)(8936002)(316002)(66946007)(6486002)(6666004)(36756003)(83380400001)(508600001)(6916009)(186003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1JjrpLm8RhbYj6rPKvrT+4UJlcjTf/iJn6k2/ocyD1y2PeI8ac+826yMKsqr?=
 =?us-ascii?Q?PbOPzwriq8TQncPLxOGOwU4invtX60z5uBPV2HpKTuP2CQ6JWqk8oyqWFcsv?=
 =?us-ascii?Q?tl6azLELbe1PDWXfueIjB4ca7Td1yqR3pzbtZXavYv0cp9NglAWVyYtsbrZx?=
 =?us-ascii?Q?PEXCpZlIwTFl+eECMdaaKa+sfAJi7++sSufOqoDGrqQVIQK9agIPKg2AC8Ld?=
 =?us-ascii?Q?qGVADd7IubcS0DLX1GPGu7d6IHe6PGYwzqWkMouheNPTEojS/K9Bl5GYvOnQ?=
 =?us-ascii?Q?P8NjmnyjBA0lIUaUoFaLwqP3+MOPZY+0qaFH7e/0zxi/FK6mqHU+wyQ6l6Dj?=
 =?us-ascii?Q?gZerx1eoy9Zmnp/+2trHSgYljicD57daovhETbbXXVp9YIvjFJVKrKjuvBau?=
 =?us-ascii?Q?MDPlF7zle01JGs7pJvXlJpzmKKYitINVvslvhsal4W2KEYEKQqAIx6IwEw5t?=
 =?us-ascii?Q?WfIq6Y8PJMsO3trETDR/aPCYkkAK80W3mfafH6DtHOwsYDLcibW2ycBBFzwv?=
 =?us-ascii?Q?unTr/GEbk1eNpnNmxHBkY0ZklSl8sT/4zvsALr2Tj+Jo9PzdmPYUFPxxAcxD?=
 =?us-ascii?Q?RtSEPC9ZSTSWsplrtmxxpOuYuPhYMT6jygBMyENXeNG/4Xy6XEUf32AYqubH?=
 =?us-ascii?Q?49bv6aCkBA6MJM+NF9VTYsue+wioi2uCO+jJoV/2SE6S1QbD42cQ1NLLsoWi?=
 =?us-ascii?Q?GQRODVBD1GXms1Pu+P7qIzN463UUPWQI4sP4j0NkuJUZix/W72g3LKc6Yr1x?=
 =?us-ascii?Q?4jLVockfukERmI869n5mTtz/mvLWtgpHvhBlOORUrQkIbva5C5y4PspZUoM2?=
 =?us-ascii?Q?SUDjpoLAdKvy6QpP2U6K9i0z0lE910YC1KJEy8lavSM0UQeE9cMUO6TipgXO?=
 =?us-ascii?Q?dYZh1FhqvZojBaPbAHbEuF65yi/V+M3Is27drb/5dS4qJCoA1xIQrzngqfLp?=
 =?us-ascii?Q?uVDw44U/HmPYDOtKKkkqxZxPMw8eDG95Cwd9iNyhxRzDtwQhobUDF2xw8Tfy?=
 =?us-ascii?Q?ALU27oYX/g9zsnn+K0Y9JKKqhlzKecYMea5gyAGZhz8AQgOsbyTctVd+8pyD?=
 =?us-ascii?Q?syriXCBENiu6CoPTvH4Nb3zy4kal0Yu2cnti1nVuYg9fPy4oUEaG836W6BEJ?=
 =?us-ascii?Q?/r/AvLu72wOQGgda1CX24lZcFK3NYg021DASTzE0RjK+WUFL1WFsrOuBuiAO?=
 =?us-ascii?Q?qbRrKevMCP8OiWp2Jvov932ZINvuDzdxCx4MJx6j0BQyDeuEOg1T7A7yrN6y?=
 =?us-ascii?Q?9M539nvD9IrWMLcI1a1qDDtTTHo06Q1v+prASjQTTiTFT7uSQAlaDSq7ojzd?=
 =?us-ascii?Q?eWb9Qtqu+NpExYExC4NWM5qwgp5m29gy58eh5IO4dHmBWyANyzrx9JFzNpMc?=
 =?us-ascii?Q?jM+su76ndUpXvpR+SjmosOpwGyw2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef10629-6392-44c3-7f4a-08d992339edf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 12:34:25.7279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wsaZPhU3GD9JMY4lS7D5M+znHesS22iwoxea3VSMGxky4MP7tSQTcc05TB047zMtchAsE1CzETCARbiqPyVow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3340

This patch added a new mib named MPTCP_MIB_INFINITEMAPTX, increase it
when a infinite mapping has been sent out.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/mib.c      | 1 +
 net/mptcp/mib.h      | 1 +
 net/mptcp/protocol.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 3240b72271a7..c12251cb0d44 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -24,6 +24,7 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
+	SNMP_MIB_ITEM("InfiniteMapTx", MPTCP_MIB_INFINITEMAPTX),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
 	SNMP_MIB_ITEM("DSSNoMatchTCP", MPTCP_MIB_DSSTCPMISMATCH),
 	SNMP_MIB_ITEM("DataCsumErr", MPTCP_MIB_DATACSUMERR),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index ecd3d8b117e0..7901f1338d15 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -17,6 +17,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the p=
revious one */
+	MPTCP_MIB_INFINITEMAPTX,	/* Sent an infinite mapping */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
 	MPTCP_MIB_DSSTCPMISMATCH,	/* DSS-mapping did not map with TCP's sequence =
numbers */
 	MPTCP_MIB_DATACSUMERR,		/* The data checksum fail */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 70f2e0e212fa..2283efda1bc9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1237,6 +1237,7 @@ static void mptcp_update_infinite_map(struct mptcp_so=
ck *msk,
 	mpext->data_len =3D 0;
 	mpext->csum =3D 0;
=20
+	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map =3D 0;
 	pr_fallback(msk);
 	__mptcp_do_fallback(msk);
--=20
2.31.1

