Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFDF72
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 04:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1635482481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K57jOR9ngASuud0UrjcK753zcAkB9tfrgvKPgpaLyUA=;
	b=RXezJXSHN23mE6VLVtdokAx32LD+W110bS2wA+8NB8VHDivbHqVzrbGETu733IDafpYcAN
	lXSZ2LBalCo1uhGP7pawiMMv9lmu21qv+Wsu+QKeH3CCdCoEfD2dIU0viLzWdi9KCIxvvm
	RtH+BcZ+HMG2oUgsv2cui3QuOcsUCLk=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-40-EzRoI2GaNz2OtoD3nR4wBw-1; Fri, 29 Oct 2021 06:41:20 +0200
X-MC-Unique: EzRoI2GaNz2OtoD3nR4wBw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbqcyQWPzZZYByCYzGfQ+jRwD1NlBMdh9FksJY97DHywqpb5EUX46gzFyto90L0FQMlxlbyDNXERX9Zj2ALqPeGRfZ9ANoMIyTzgw7KF/BWQFjPYf5H4fPLNfZwlq6wT/72P8GhWussHFVWsI4u2AEmURWzseUt0HXfnwoGYn9ZOzMREHfpFGHgueWoCTYqaNAnzFNHfL65p1et3OGd8BVYJkQlLAxMfllZpyu/cNhVpxftDvLwG/FRRyI+gvUKbKL88HoEvp4zQQZElcI3c8NPNgOAqmFjU8NgAE2/zlFS0tHI9G5M1FOHmILNMnoUED+7hfTrw0QtCZj8sEzOVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghaXgkPK7E+HngmTVAu0klD5dODvPkSosYGzV/Mu6eE=;
 b=mTb7VvnYgoFT2Yc9JJ6MwxqwNqrsm21k2ZIFkbxTF8dJLYGVBJFPK1qX76dfhYUBVqAAldUiXna5vrfhMzYrJTNRnl73MfBuqARdK87RkZsk0K3tMrVSZkiz/KahYEp8ZNKMFp5pYkP3lD+CjH5e3av3CQ6VpqbPBgjd1Okh/DwCveGFRFyRlw9XgTwMFlHAbuaDV4U+t4Hve5SwOlKvIBUusfRXSS1kSaI55NuQSMlrKU7H2Aq4z2MhMyhui8IEcUoYHOfCMfNFLtK4U3rRTg/0WM+6y7w7V+RsR8iJy3XoSU1tbSsDj7zgEBkRidIQHBx/kyGZkHQ3KCnekviphw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2652.eurprd04.prod.outlook.com (2603:10a6:3:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Fri, 29 Oct
 2021 04:41:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 04:41:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 6/8] mptcp: add mib for infinite map sending
Date: Fri, 29 Oct 2021 12:40:16 +0800
Message-ID: <7f0fc192434a43191e70d7fbd02c377f3c1a87b4.1635481641.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1635481641.git.geliang.tang@suse.com>
References: <cover.1635481641.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2P15301CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.2 via Frontend Transport; Fri, 29 Oct 2021 04:41:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de84b182-e3bb-48b3-69d6-08d99a965a33
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2652:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB265254DE5CD93967A66FBD98F8879@HE1PR0401MB2652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UxAIzB5GZW8dJKUAZAMQ6D9qUMxjlKKgrv4fTNFys8MG5kd/VXycrjorlEZUJKqni10L8URdsvYw/uF9Ang8mKVwas8pN/NJfToGWrwHMGzs6pWl3Tnzwv6PiASn4/m8iqYYL4pSJ7olgK9Qu91Z/oFQj0tQoBq6OVtNH9LwLDBRaBO9UkA8twV665508sSoFwX8bQ87k/xWwVkDgFpMVSaXF7tuDJc+t1tPbxzgN7Wq1kcAlcaRaPnlFrOUxN8DML+ZBHPaYmXWbGTce9tCsgIXhee9V6OMP+aXqKF5RkBwwJDXjfynOOPnt1LcZNQ3BzeFMcmtbv/7GcnYkl9piB3hbptKo1+fK2k26pQvZr3oRX2OHikOZMEFXIIz88ScWmGPHyA5Bxhu8C71lhkDCz42B02IVyo0IlFasRagP6po5hR7sNe6htmcggd2cl7+4ZVKXGwyZhuFpq1mEpgMhQW9komNou7IxcBCMMshHxrf//3t0J/5/o9DjlU3eZ5+HEUPyqNM5jwAEw8Mj1qXeeO2TSoIdmhWvUnB+gO28OriXsf4egc/TDKe71RqTJNsqmEmuEzfvElWoEIA2ZyLkZEF6HzgT2FDAy7fSEmJslvJ57ITTbpWVvS2P/m5zENIzoYN26XvhSwEcRtyTv+obg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(4326008)(66946007)(316002)(6496006)(83380400001)(55236004)(8676002)(66556008)(6916009)(6666004)(2906002)(44832011)(66476007)(86362001)(956004)(6486002)(8936002)(2616005)(107886003)(26005)(36756003)(5660300002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6BIndgjA5fHKNfZ8UQpCyFFYe/UOqdRW9uI6okxisMWC9+87xzEcVSyugaO4?=
 =?us-ascii?Q?AxQzGCbg+9lQfBPkG6E1WGW0F22PKD3GjvZlxsNvB5VeNs3NYI6Z13De1ted?=
 =?us-ascii?Q?xWKLbgp/Jv3VsuskUBugv5z3a5RzyRgy6x/AKWI8TBo0GPXji8Q3pTDAtxD/?=
 =?us-ascii?Q?rTJ9eQXZjt2jwvW4BT6CWfzIasxLR7oZZs4i7PiaX152bw34ZfyA3/GGNTB+?=
 =?us-ascii?Q?pKN/gu4m1dFoSosrAWFjpGuS6tQ12Oa6bOpeUhXvHL3XyB6iN4M4YXJKxeM1?=
 =?us-ascii?Q?aa0mGI+2rExIa1uICP4i+z16w+Cc3BHF8dh7036M6DJzSAmiVpKJmRBRDR2x?=
 =?us-ascii?Q?Jd9w7mHpRylh1L7gLNTwpIZpmjiHCaJrAF59rOpGGf0NPPbL9dv/7OAMu3Sj?=
 =?us-ascii?Q?n2Bg1O3HwRDW9phzd/MldISUPWzQGaMs6IoB4Kig/1+t4LK24FtLQOqv4/JJ?=
 =?us-ascii?Q?pwf/LE7MWNEwuQBs39C2IvGQkFZGnXjfwwDLcjBKGQEGTR7Ja1CtNub53b6u?=
 =?us-ascii?Q?0+hcP+JkpxmAFZY5eAZVfVzmokUGc6qEuBvT6rnG+w8sLVPAeSrvUGT11Mgz?=
 =?us-ascii?Q?V8egy5e9w50n45S2NcHqF3n56ahsEm//uQMIM3V2qwbUcuY8QwJhh3F73MO6?=
 =?us-ascii?Q?RTDwuo/WLxmrtkL8ds1a9skYBWG1q95t40cwEl2zI4Pzkvn9UTDak176pvou?=
 =?us-ascii?Q?gw1WdpDudZmKvKhcqlK8pw2FwR1pYolhwVi1oZtQAYYPJ0Gn1j9wQDTsPm5e?=
 =?us-ascii?Q?aDhL+BoRrjpIXUqHWrYKa77zHALZHmByJ65WAW6F6YgFYifphLXUmLm+JT8J?=
 =?us-ascii?Q?bX3Ta73KEHLbaiUUZIx38uAafryxJUmdqhkgf/uiKu05Y8Wt953FANa3RFCJ?=
 =?us-ascii?Q?5hzUmteI2EUGMUl481C/S4lsxtyMlvPA7A1M3eyImnMZCmrrmpn+q3PrNxZb?=
 =?us-ascii?Q?+9aZCqWXhQLzVkOT17w2G31GJ3PUpBtsHNpgsWxBdOrsvaZI6mHCZRxRV3GL?=
 =?us-ascii?Q?7zyeFfOwrwPfMfhv0FW+TPu0+idMSKSomPK15I5ceMz2obX4+//Ecy9jpckZ?=
 =?us-ascii?Q?coTJfMGbDQHyd4SwGYU0vW/ARkDiRbLP5bPvEKa4s7sv0ZU53/QgEgY+I+Xt?=
 =?us-ascii?Q?9ezchxGYpuvcffhOtmI9t3hmh4bLOwndAka636cvJ2SH+1E37owgkDGX/ifA?=
 =?us-ascii?Q?l5ld3v+gspS9SWDKfTIbhooVnNoxjFqSKNEV0c1V1M6cpPKdbA3LJDzYXk/O?=
 =?us-ascii?Q?p5nwA7X7qi4pXfwRXHdx4LrjH8ZGPazkjeEOnWv6rFIV/qsQpdtzV03sV1/C?=
 =?us-ascii?Q?yDduoGZuyUnBOf/cKPsMxlEA89Zj7kohax/V8F1F6vSGKsXtp4ccpQSFvRIw?=
 =?us-ascii?Q?XVTyuH4IDaAIOVmhYkR7oDRjyn2JHBRF8fKqqlgt1nqFeohfYVUay/of6iFI?=
 =?us-ascii?Q?Vz6DNRE52OQg6lgG4FoyscuVFLDmjyQLAvk3JNRgDj/AXRhrn9ceV91A5AfF?=
 =?us-ascii?Q?3X8cUieERLu8f22GrdkZhLCG6Jfqaho2P8q42FxeJoP6y778qRrSpht8J2Z3?=
 =?us-ascii?Q?B+IlHGTeq3z532Pye141t99h/NtkPLchpHsXb4gKEwvA5MLyzAp+3i66m5xx?=
 =?us-ascii?Q?X+yVHzy4HI63PRO0rTxnEoo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de84b182-e3bb-48b3-69d6-08d99a965a33
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 04:41:19.9729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYXlJYUgOax5RhTUY/KRZ88qxA2V4gqYDH3aKTsJpwRzL3FgrIHfymaKELcFYd4MMle5eYtHlBaolaPBBSAPeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2652

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
2.26.2

