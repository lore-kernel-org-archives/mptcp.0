Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7BA7E4
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 06:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644819790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9lwU9GhmHxYjr4opJjWCDgKgO7mwmi/1b85T97qj2k=;
	b=dF0LYvgh8Wp/rklbOGXsfjIMq9OAeC/CEAoAorpObZgqaa0hPz5ar0x0aVUvtBssDdopLo
	kUzK50x4fS4ctjW+ZyvcfGhIex2xmSG7WXbSVm8dwdH6FFyvcvlkYEG1TmfCznJQg6+rwz
	+xdXY/uPwFCfsDe+WaJwwAn3YPaODfM=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-hW6zjpJ2OBmKFewDzxaTsA-1; Mon, 14 Feb 2022 07:23:09 +0100
X-MC-Unique: hW6zjpJ2OBmKFewDzxaTsA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jttjUiOyxkpcWCB/IKGW5tGr8Iov46sBuab7yyl7n0WYEK4hee0QNvrREAWEMRZ0hbGGV2q32TYEseddXMlFbXWXLkpBp4p7ey13sBFcGz/JN8l1LTUlg0/0bDaxpP7BO5rLFLkKUIgNtDkKXrM4DaduniAATcOTvH9007GYRLU1qIKSQuhNiko2e6rkPLd19ps72XBSHPUl9jh3mzmSpURwXLsRwURvCGLJU4shCL8slL7j/wWk1jucbAlq71BxIaKSEtqkKrwFK5oF1caSeRGV/io5l1aFz+XJ218OVFo8ZVDFD2WYjClmLFT483ByHB3aqVir/AYCDFDTmV5UBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kK65UpV/yNfnJi8oDDPFtbsKnAn54rW9ry9/4kBcL8s=;
 b=BDdR51o9Wp9EG0WNwqsFQBCDFwVbmeGpfMc8YCjsxsmClFE51H4ym0RBEDC54zpKcN/gQYRtjeALuCUYeGqHQVnNEWx+0l8auBUzuorB2sRPu2JadgTNufmQGfQ/pJ0f8ZTVmxBhbT6caAM8Hkq5RK8RCS7JSx/BAfEDb0ab6vwg4qZB0gIlA6X2LHRpZAoRSWlpkM8lkhDjxvzMBWcxCqdwZi3GQ0TqVDLfzi4uEBDB79WR3+k+xbWVy/RJMichIuQpKum4NWilmYUHWiAID/MrQmtYc8gEGZ9UYq7rAXSwLTUVxqpH2nNm/fk84+NdlB/uAqClZ1I1Ff3ovUcCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8609.eurprd04.prod.outlook.com (2603:10a6:20b:424::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 06:23:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Mon, 14 Feb 2022
 06:23:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/2] mptcp: dump infinite_map field in mptcp_dump_mpext
Date: Mon, 14 Feb 2022 14:23:20 +0800
Message-ID: <2c505cbd75caf4908f540eb619b0f3d939de3136.1644819421.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644819421.git.geliang.tang@suse.com>
References: <cover.1644819421.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0124.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7cb73e6-41b1-4304-678c-08d9ef8277f1
X-MS-TrafficTypeDiagnostic: AS8PR04MB8609:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB860938E99203F212A62EA343F8339@AS8PR04MB8609.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:357;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	brBvbaGcKm+iAMFq0gSp92dpcaIZ/xYy/7HwFwJuQxmniFKCmhOOPZebwKbv/45DW0K4d+XDyxFVGHePIKmg8Mf1s9vljkXRwHS2JfVrrtixydJA+4KG3OsrSQEipWwSZmVxKDxoPX1mlynFYbdTr2EyoU/9rcuxh9GB2YwVajxi3vV6veZOKj/8rEvKe3MfvVMrkS4orSQ2rkqySnYoZLZH/FGBA1a4+D9dK0OYKMG/BviIkE6tjFJfBVhpjKHpG5Q6Up34kb/yTP08hFXdVv2b3AClfHC2O/awmejRwi3QEUcKOR+RQmnia0r4RVrWp1/5pglDuao40fW+xlqGqEPpH0/Tmnokrtdq909KzR2XxDotYEwnJWoJncFJhf/oF0uY9KNiCt2mv+9HupZ6UhQEwMwnGEeV+FBIM3xTQF6Wz6vaUd9QFPPgLTF9GX5Tc4/Tgy5Bv1VNyOMsJFd5Nk9dVmc4nZr95feSLG3Faht/XpLVuQ1aAKrX02eX0S+KkRi99NkUaNM8mAkhgd1I5VMd+IYFAvoAVDGTmHFEJcg52A7T0h+wck4Ohx/pbSZ04SB/+Nyxk3STMtRYX5YkRT0UViwKNI5fP8N0HKBVA+SNRfw8dqrhD2wGm9ERyCoVXP3M4uFab96TLEllJrzWiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(2616005)(186003)(26005)(107886003)(83380400001)(2906002)(8936002)(36756003)(5660300002)(44832011)(6666004)(8676002)(66476007)(66556008)(66946007)(38100700002)(6916009)(4326008)(55236004)(6506007)(6512007)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YvQMiPg5XwmxRKs2sxCW9qXHlBMwMVKnpo3+GYoF+QoBakDtkHJ27g1ee9Hm?=
 =?us-ascii?Q?GQ4gf6X30YtAN91POyfBYdv/+E0mKAiPgSK5PoHTU/4SD6276OxfIJR5QflG?=
 =?us-ascii?Q?wrcddqyclAuDdsgfkKWouFjNZCytotdz5SEBqIGCXGCSe80QAvM1Bg5lTdtO?=
 =?us-ascii?Q?rcIvfaIcLGkNuvoHzPqCxHax+iPl/BjglaPIvfZpWBnvsL2T1R5lMqytQ8l1?=
 =?us-ascii?Q?b3sQWqoZwOfTlCANkuAOv0AWQJA1dBNrn+WTBTjjIk7BnGx0ISR/OK7qEFTS?=
 =?us-ascii?Q?F+I5XdtFYlHTzm76zNnWUpfhB0XPmSC3HcmqW66Ogtcz+I9aBkwj63jTRRkN?=
 =?us-ascii?Q?T686h/bszgNmtoJGm3GW7I6R6b4FrEt2IsOOS5ase5UvY2kjuZBcAYRWI5a/?=
 =?us-ascii?Q?rpXUf5pwfEYKoHa39Pl8ku2scL77Ii2lMP5JL2E2s2pj5/cs4KkN8FiorpqA?=
 =?us-ascii?Q?dnH1Q6ny8iRuWm+REOK70LeFbnMG0pNVmYWQEF0zmmnxfahLhrs8wYrh0F+E?=
 =?us-ascii?Q?XZX80fqYwtk+uhGx0JD2q/lLN5AGQmISHD0dN+DAZgTHvmIwNyGFINluZYsr?=
 =?us-ascii?Q?7dqRlWWdbhs9LLl0aieAqcOUtANIjJ9FpBRc6NcyEDh6nLZ21mk15eiPmArG?=
 =?us-ascii?Q?r2UCLIF8Yd4Tomup4jOzze7Wa0QIUsxM3ihQgjlBtaVzjr6r2otvMtdiX+Gh?=
 =?us-ascii?Q?YjV3qeRS8MlDT+/Wt3ezYPLYkWP3p8sQwxSvurF0VPRH52VcnB3GZKqOgm24?=
 =?us-ascii?Q?tXONSm3C9vWbW3FEehU9oJdhAgoqH6lPQOEhU7BJRBUf/9p2CwhLp+gorKqy?=
 =?us-ascii?Q?t4p3mW5rIyfut/JXW4BDClKvGzS1aGoAXK4v5dsnyHQSAotTuk2EWtwmpKOi?=
 =?us-ascii?Q?gXqyG72ZEK5XKgkiS30B+nDbog86Ps9B6iieTcdLOJCeqWLdski3tvTiPrc9?=
 =?us-ascii?Q?S5F6XaGmAWCzzrrGa5H6HyS/g0A3glJNvw0z/zMot89Io/iFsg0/Nnb/ON4I?=
 =?us-ascii?Q?8V1ct1bgRJj7Q7WjGEGsCTQOBYktyrpnK8UxoUqVRZbw+wNY1uKy3hNTsOH5?=
 =?us-ascii?Q?sZ3YwfKoe25/MYcgNv7gDJV+uaDWufvULbXxB8s23gHwuxFVvrkK9335yYFB?=
 =?us-ascii?Q?OzUuTDvYdsgTLFV7edLicU/oU3XbgX7Fws4K7w65pSyOtUZV1UG4Na00ORaG?=
 =?us-ascii?Q?VbCbcjBe/7F/2kB8F3vdimkFbtBDnjJ9ilpIPrHqmPdRxTKmfObtUqJi/AhV?=
 =?us-ascii?Q?U6HiAUj1lAVmMJlZElXj9HHNqk8aNIglNq2vX+uG89+faRUn1UPNDSZRs6AI?=
 =?us-ascii?Q?SystAuElD8sXuhnJDF4UeZjsCAyZJB1eEUNpgqHdQGhQnWX/hNhxDnIV9VCu?=
 =?us-ascii?Q?jIqJ7b2n1TDaTKoW5PKh+KtYNREUiLHq3KM0jnPdTfxWAezr1xO7JgYLZ3wo?=
 =?us-ascii?Q?U7V6qGe2QEOo1m5LvftSqWuT3yp4ItO7nCubyqwFiKID4oVqVSVSCTBKDd8o?=
 =?us-ascii?Q?MHhsA1Kpao5YtPZHxqJzcar5UZhx0h0AcPchC5lTAjmA0eMOTEDWco42GmME?=
 =?us-ascii?Q?+zSdyl4UyvazvyjzcwE6tPkeBZVdqD1WozIe/69zhzdyoAb7zhFXQ6QurOV6?=
 =?us-ascii?Q?beWdrZnsbUX8jwf9xuIItYs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7cb73e6-41b1-4304-678c-08d9ef8277f1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 06:23:08.7357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFKJpFgw44vRwzf6BrTezt1/uEq19PA0aB/2UbTiQI9oLkus4AEBp9aZLEVZX6wsqI3qg4jYpfFgTpFBaLYaaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8609

In trace event class mptcp_dump_mpext, dump the newly added infinite_map
field of struct mptcp_dump_mpext too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/trace/events/mptcp.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 6bf43176f14c..b4175a52bdb2 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -84,6 +84,7 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
 		__field(u8, reset_transient)
 		__field(u8, reset_reason)
 		__field(u8, csum_reqd)
+		__field(u8, infinite_map)
 	),
=20
 	TP_fast_assign(
@@ -102,9 +103,10 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
 		__entry->reset_transient =3D mpext->reset_transient;
 		__entry->reset_reason =3D mpext->reset_reason;
 		__entry->csum_reqd =3D mpext->csum_reqd;
+		__entry->infinite_map =3D mpext->infinite_map;
 	),
=20
-	TP_printk("data_ack=3D%llu data_seq=3D%llu subflow_seq=3D%u data_len=3D%u=
 csum=3D%x use_map=3D%u dsn64=3D%u data_fin=3D%u use_ack=3D%u ack64=3D%u mp=
c_map=3D%u frozen=3D%u reset_transient=3D%u reset_reason=3D%u csum_reqd=3D%=
u",
+	TP_printk("data_ack=3D%llu data_seq=3D%llu subflow_seq=3D%u data_len=3D%u=
 csum=3D%x use_map=3D%u dsn64=3D%u data_fin=3D%u use_ack=3D%u ack64=3D%u mp=
c_map=3D%u frozen=3D%u reset_transient=3D%u reset_reason=3D%u csum_reqd=3D%=
u infinite_map=3D%u",
 		  __entry->data_ack, __entry->data_seq,
 		  __entry->subflow_seq, __entry->data_len,
 		  __entry->csum, __entry->use_map,
@@ -112,7 +114,7 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
 		  __entry->use_ack, __entry->ack64,
 		  __entry->mpc_map, __entry->frozen,
 		  __entry->reset_transient, __entry->reset_reason,
-		  __entry->csum_reqd)
+		  __entry->csum_reqd, __entry->infinite_map)
 );
=20
 DEFINE_EVENT(mptcp_dump_mpext, get_mapping_status,
--=20
2.34.1

