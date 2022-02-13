Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F1A373
	for <mptcp@lists.linux.dev>; Sun, 13 Feb 2022 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644763830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jf7ggTN1LT6SG/cNOvhxwM28cRgV+Hw8XKFdOc1RVc=;
	b=JaMcy8KfmAVqRQg1kuaIRtGtrjqCUnYX1C2J3XnvPit+qkIm0pzoWfMnIFO4Xx3pMUunqV
	wiDMjNJmZYGcB3BdswG7bxUA2Ps0ezpr3p8Cmp72BBVmftpKE2oZZaMfQunPI2Iu+ka0mN
	5OVvduc1/+MMNwOK1mPct5w/AaO38dk=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2056.outbound.protection.outlook.com [104.47.9.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-CjxKOK_hO1eQoIAjxfUsxg-1; Sun, 13 Feb 2022 15:50:29 +0100
X-MC-Unique: CjxKOK_hO1eQoIAjxfUsxg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsGq9AFlOOGEmNgb7SlGk7H3g1X3JzgYzedIgOys6SnvbeTHmS9yTwjCD00uv5lLMdRDtbz+QmNShTXBuch+xXZLbg/glWFZ7BCQRFoNS7HdZE6roH3LOA085x1atrIpA8UkipVJPEQw6PCbihgodraoKkjnYj8AI7StPoIfYspnQIhY/xBfMq8EdHS7uY9VB6aB2NEQ/TOiMKE4EyweIrNRvE1+Jtw+xXnmfAY/woR3IxeOTZvwCNdZKGoIQXDjqtD4sz2bAfsw8ha41Id/HWVEfzROp/Kl0kIIveMVJbwdexqkiBXV0I6KzL/gzadTYOME+M7VOkO57HFbprvSHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShXKQr5iHgn2fGCuFb4q6GNG7TfB+X12RBs6VH66If8=;
 b=horlyI/SQf2xKpbT5BNH1AsoXHqOD5oHSw5/AUvCBhu9vCasbaR8V0Mzxgj+qBP+O+KPb11PO4KgWWSTgQ981CKmxi8nfcFUGTFGsMCPKx4rSbsmNKp4yAzcjselfco6syzViYx+az5ObU/87RZiOM93tMMZO0ixIqqew1VcUTB6uWfHazEFtM8dIOJ0PtE4bZer71/h+SujNu5yi88/Cbt2kqkKttrogPq3uKPOW64bbwDPjfL6OsRS+mnqyxlzMAXA3GhoC8tHf0FpSoKobi/smvQKSmOBtp6PbaRuDmNHRId3o7zbUFQ+J25SESjAYaVRV44rRKgChc923j3zxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0401MB2384.eurprd04.prod.outlook.com (2603:10a6:800:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Sun, 13 Feb
 2022 14:50:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 13 Feb 2022
 14:50:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/6] mptcp: add the mibs for MP_RST
Date: Sun, 13 Feb 2022 22:50:33 +0800
Message-ID: <e3a9f958071ba8ed04e20d449e23f8c2a43ce0b1.1644763526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644763526.git.geliang.tang@suse.com>
References: <cover.1644763526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:d0::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20c41315-c21f-4121-5782-08d9ef002c3c
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2384:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0401MB238446998096E27518BB3449F8329@VI1PR0401MB2384.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4EsQSGDD70yh4oDdv1UUF2kpizTfIvOmxuO+nGKrIoPJ+MsFheMiGWc5c4Yf4emxNsO/FPPgL5ub5EeZQ3y5noQ3ox3j+/jwJNK2Ip3gwKKKoBfQGn6F6qOqKNw3xErgKP3xUoes8Lc9Z0NZMHM8VboAFip3MmMxUxt+Gc9pwliv+yWnj/3dzdkxmN8/l61ioXVK+AdMNVJRDZuaSQ4scMZDhjXgyRMBiFLXpOGmUsZmKgU5GqO9QserJ3rCVd/EIjrpp0b6BCWPhURsR4EaVe029kWTiWB8eA+hkzfcwZfCI7RFUabQRv77imqRj5lKhBjGQcrpQLne+DYSUVINFgAi+lRh5TJ3NST/N/FxfrVNZCxpnwi3HnD/dmNoaxENDs0CLPL2cIBPN37QvVhmxieqI8tLH9qmpIyBsNK1ySt61r1h+FzGVRrjgAfOGot2VH4yudNbwCPaZ7i7QGUBxO3EHEzQ97QR0J49uVVrI5vtYfP9OP9V32lLNeBq6NbNTFyWI+R+9cCckss3KY8bgHIDwVmuas/odMd2Gz4VLjnQ7j4MedJUe/5A7Q51my3pQAb51UrIIsHYav/oLam7Q6Ow1a0h4dpKAUrv/RuWSQdPylqs0QizDhWN6s1B4F61s9DRDFOO2FPgJCW+OMRw0w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(6512007)(316002)(6916009)(6506007)(86362001)(66556008)(66946007)(66476007)(6486002)(508600001)(2616005)(8936002)(186003)(107886003)(38100700002)(83380400001)(36756003)(2906002)(8676002)(44832011)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gRZTObeLXiaR+YkRgQZTYRywVTiFJn1vFcjylBfYHll5zwT04UYV358tCv7b?=
 =?us-ascii?Q?kcPTm2rwjk8+Gk+2m5ktsKF7ND/KbSfdeFhfPZv7LHXVyZaScQit7zmm4aGu?=
 =?us-ascii?Q?sUHYK5GYBAoIR+l/1X3tpe1BjhYZyfiiaVq8PU1l1/a05nVN0vYNJfHeXcX1?=
 =?us-ascii?Q?s6E63sOFpoP587wTvy6s3VLg54cH6v/DEpVsAMnS74sSfnKpzDpGIN5EKWN6?=
 =?us-ascii?Q?9PEJH6nnUwJiJL54tjRg/GNpbgA/JvGviYakNoSEo5dUowAPkYrVQyUQUelr?=
 =?us-ascii?Q?RKYMYs+X/Bkig6NFwZiu7VQQr//bLCPZFNYl4CBM4orahgXyxbS8J8hMrJbi?=
 =?us-ascii?Q?181Bm4x+wKqH+oNWkAurjcwcjruK/I+nhwcwhhrtAMQBtyf62kLVtRiZ4V+h?=
 =?us-ascii?Q?Yp/IMWWzuOmg6WHjAkkKCyGnFEX1gCCnhjZtgnGL0jRT2YJBtPitEbeq5CGY?=
 =?us-ascii?Q?D9DHahWLVhGxrr+mxZI3FICfiH6zW7SoRmYfbKKsSaNGXuNvmk/DokXrfqvv?=
 =?us-ascii?Q?982rAczO69Rscy2r+23BOJv3VmN+GNvdGh2UR2ANVIPii6z2bXWDxD3b+GT+?=
 =?us-ascii?Q?OkCrcAMaepkt1DqZ4ZNFLTfm7IDSWSeAG0EWiwju0NyhMAXbDxkJtujU00oc?=
 =?us-ascii?Q?KJhHTbOL+frGPh3jcle2eixilwgLsd8bgVV2HifKTUFLj6qT1g0086sWaN1I?=
 =?us-ascii?Q?pj7JqCy6Jj4JV4IPrbwe1vsBn35ShnjTLS1Y5my6HpNibyT2TFzDh9Cef2mK?=
 =?us-ascii?Q?qRaKJQu7R2OmfD1znYCpVBYyavJwqSYOraFv+WRjakKDvyot3Z0bh26RQWb/?=
 =?us-ascii?Q?hmBFhu0820C8041NTcIQlQ34FewAUWUy5uI6uP8H8TGaToJBGDKBlAfP6u2k?=
 =?us-ascii?Q?rTdYn1EkWcsyWjuMOsI2at5tPhtxU5e0smK7mMBhy4+1WHfjH+D5HujmaE/z?=
 =?us-ascii?Q?WQ3GVvuncBU5eAGFd7UVwGG8YmuRk1WUzM6G4QAUAJicAtXb0WUNHNCsr6LM?=
 =?us-ascii?Q?OYkm28T8O2pJ3Ga2Fu+c7llqYbABJWnjBDdkUm/ulmBfm+jr21Abd1feVxnk?=
 =?us-ascii?Q?5/3/WnQgcLlVUf0eiBCAIyhNS2iA/0yqh575SIoKFxb3/wRMb93fWj8Qu7Mn?=
 =?us-ascii?Q?TJSYkit8jSGGt6/dP/uHfCo0tlclCA69Y9oMYRp+wJzlH931+Xpe9nk0HkI2?=
 =?us-ascii?Q?Q9LBklv+O9aLpMSYj1cDTc3HEEWZ7Lyn4pdQMvjNIAM0cbUsu97dLwVGGByz?=
 =?us-ascii?Q?khUs7ojx19wvjWzNDBvdKBrqcWSEBn5JR8M1cbAFDZd2Rk5w3XYqZ9uQFiMu?=
 =?us-ascii?Q?C2WMfTsnIqqpFEsMAPPZJZFWHYODZll2SbHmP6FO8gKYVlQawK1sVZKID8dE?=
 =?us-ascii?Q?RGiJBOM5qNFKFhR8YmzSd7T8s8gQ05vSfXI5tfSdtr2GzXfsmpVVeA/ZsWFp?=
 =?us-ascii?Q?kKM3pHn4nNnUSC+HShu/uYD2eCDnRY8rwpemOHPu3TO12gHC9elwmfOw3sAt?=
 =?us-ascii?Q?AEj++//BKJB9FinJ9Sb9bXX3VwPUhbYmvc0cEvMRZTgWpiTI+40VF3yXxyXw?=
 =?us-ascii?Q?Lb5cApPx5iKpI1ZArqIM+CbHVVf/OmkvyMf7aETmQd2ISG6eyd79WJKYuZ2t?=
 =?us-ascii?Q?s7m/gvlcAInehUWryER9p1jWqY1emqv/55dcAKlPey8ySEVHkya6ZMTT6RkQ?=
 =?us-ascii?Q?7+BvwlCxZUfDtS6h75Kp4tHOUXk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c41315-c21f-4121-5782-08d9ef002c3c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2022 14:50:27.3638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nJLRLu1NgqOAvfcHenEHqWI6AmiAnWD9cvaZM1EYHi48Si03KcglTAEkcWbvenpEeXKPL6QM8vWHUtFvvCeHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2384

This patch added two more mibs for MP_RST, MPTCP_MIB_MPRSTTX for
the MP_RST sending and MPTCP_MIB_MPRSTRX for the MP_RST receiving.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/options.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 684643f8af53..d93a8c9996fd 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -51,6 +51,8 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("MPFailRx", MPTCP_MIB_MPFAILRX),
 	SNMP_MIB_ITEM("MPFastcloseTx", MPTCP_MIB_MPFASTCLOSETX),
 	SNMP_MIB_ITEM("MPFastcloseRx", MPTCP_MIB_MPFASTCLOSERX),
+	SNMP_MIB_ITEM("MPRstTx", MPTCP_MIB_MPRSTTX),
+	SNMP_MIB_ITEM("MPRstRx", MPTCP_MIB_MPRSTRX),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 93dd5176fd5e..529d07af9e14 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -44,6 +44,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPFAILRX,		/* Received a MP_FAIL */
 	MPTCP_MIB_MPFASTCLOSETX,	/* Transmit a MP_FASTCLOSE */
 	MPTCP_MIB_MPFASTCLOSERX,	/* Received a MP_FASTCLOSE */
+	MPTCP_MIB_MPRSTTX,		/* Transmit a MP_RST */
+	MPTCP_MIB_MPRSTRX,		/* Received a MP_RST */
 	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after bei=
ng stale */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e775d75807fd..88f4ebbd6515 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -839,6 +839,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) =
{
 			*size +=3D opt_size;
 			remaining -=3D opt_size;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTTX);
 		}
 		return true;
 	}
@@ -1161,6 +1162,7 @@ bool mptcp_incoming_options(struct sock *sk, struct s=
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

