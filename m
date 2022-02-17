Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555B1FD3
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 11:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645097017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+Jithf+ou1wRL82Vp5OBHU8OKG7JGAV8TevFZdqwTg=;
	b=EQ80HEpE0sbuAmOSbzhQIZC0M+1WLP0ChIQEJGRYiLmho1wbicG5IALVTebMfvdlNZvnYi
	M9c2SVHz4j0ojv2oRdpIzIHkkCwnB/n0cNLo48RDm9uCuO0MHamaZ+xe5qYa9QG5VCikQk
	LKYZlaY9WSX0PyDy0MXSkVbn8Aymd54=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2053.outbound.protection.outlook.com [104.47.6.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-Ai4MApUZOKS8FAoSHXlpPg-1; Thu, 17 Feb 2022 12:23:36 +0100
X-MC-Unique: Ai4MApUZOKS8FAoSHXlpPg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBqt9RjwUFO63uCq1gSejBtYygl5Q3m+h4Ln1mlvCdlovnpkPfCO69t6NWeymWyR5wgWaiD856bnjwmFXyDZ/T7gWOExtTVU2hIvjwY/OPhi7qQalBvFWIWGPeR4NpExN288ZgCLz6ygROl60RdKF7akeLWdDM+EpsV40paXVkBT1xPjyo7W1xFTo+Cb5aS9D84BPrU0r8xut4EAeHdUrFamy5BqCbykb2Yxs38TWFC4kjwYJKGnHMzOBHQ03cg7TlsO56amAf3f5a8jPb5C+evpafgAYdxZIp7Y8hqUQviOfAS6buRVlxWNs9dXzSDvIRlsBH0E0YTbQUZe1Y4SKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WROLAK/N6Owe4Ro9xZ2UP62w8JZjP0gNJvBHCfXYeo=;
 b=S4ElY1pCK2Y/Pvkm/CoBDAtzLbV0YQS618PRrHGVSC7aTNCKowoJJUf1wEtmpYr6Ot8cczSaGRqltKYwVjUuHOdDxMFr3jv+527Rf8gAzL9l/Vc6re8P5UQuCfj7gwvgyaFeJmfM1sSXm0hZqr9Clvi02uR2oySAVhLrree3wW9DJA/CRdrFJyLDX/n0uDUWA5YNmprffe7w4T2YZxXn2OnB9zieB3iYwh2QRdJExN3jmznslRoSsHXMu2K38B9yFuPG8fZ65NqcLiATwcvaWmSmO8MGPqC83KPw2OCxAoXPg3OJfTEkY/SE2NgSHhsCAso2so4hQiHpaQxEIT8vPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB9413.eurprd04.prod.outlook.com (2603:10a6:102:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Thu, 17 Feb
 2022 11:23:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Thu, 17 Feb 2022
 11:23:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next v2 2/6] mptcp: add mibs for MP_FAIL echo
Date: Thu, 17 Feb 2022 19:23:40 +0800
Message-ID: <d6a87173b232074c12d02aab95b27a4cdbdb20fb.1645096378.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645096378.git.geliang.tang@suse.com>
References: <cover.1645096378.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0054.apcprd03.prod.outlook.com
 (2603:1096:202:17::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a799fb95-8040-4700-dba9-08d9f207efb5
X-MS-TrafficTypeDiagnostic: PA4PR04MB9413:EE_
X-Microsoft-Antispam-PRVS:
	<PA4PR04MB94134354C0CEEEB23340B89FF8369@PA4PR04MB9413.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:61;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0gjMbQz4WE4pmxuoKtg1S0f2sSHplDKvfv9bNil4otFiMW6ZMMuQsLkFQXTxzs/l6r2bDrIQBel39XWzhvs5NhFNbccIoO+vSWR/C6A/bwvndbsN+4dZ7eV/Em86y0CUo78d1nERVhd9lRTnRNGTbmxINriq0mXdPFUAmxSeuw3psrLh+vNJdQ4DZHXVmqtedX4l9HU0o4KjEACjyNqyhIZGUAaPQ+AlfUQJa3MxQFUCAbcOjZWHrhG+aW08vqUOGZm8oLrAL1BxXw5/HzHm6OpYJzOt8ozfccQ4H0EzL9kr85E1giITaAaPGuyutGL+eBkfDqIMhznw5+TO4bjarL9LitIII8ciCC3/BF8eohKhovREbzPMYLz4yM3xYsUu/Hhlvl5XyPcFZxO97GDXOBmO8VQZIFbUpTRZtPnxSNT9/MHpsda5wARPkErth+fIU5WeSx1rlIkiRm35EwSmf0mYD/QrfOtoKOnz79zxtHpFaO94JTW/VSRd8g2i1nlyw7uZBAKPDV8Rq7YeAJpfmi/s1S69RwKY5DPLzDOJ+3IXnnUPxv60zv0eg+Xa9DjfORMfcvsFgodI3E+saM2+mDvxCOzgzjvluNN8jf9Gqxc6bSb2LpD+AQCpdOivhrvig25jfVVbLxKCYQSt6uvrYw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2906002)(44832011)(6916009)(107886003)(316002)(6506007)(38100700002)(508600001)(8676002)(4326008)(66556008)(66476007)(66946007)(6486002)(6512007)(86362001)(2616005)(8936002)(6666004)(186003)(36756003)(26005)(83380400001)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1CPdHnDluccGnhORd1qj+o5rlaRhCseBFnZDozjul1y+DISFSoK6TXnvZ2rJ?=
 =?us-ascii?Q?UkjFP/PdxiAso/wLB7sePfg5jHQFDuUjfezJ8rs9g+VEuLGQfB7sRKEKjwUY?=
 =?us-ascii?Q?BZ8RxzA9bXUKG05v7EJJlPLgSIzf1TGYVSoMxKqhnsuruZ8uTUGaFiICWRHf?=
 =?us-ascii?Q?eOGnnXI6NnmymG3rRT7vWBS4RatTNGNzsTHWtb9+Dm6Bw4w3sGqdhFnnGGcN?=
 =?us-ascii?Q?LaMV0i6zbgfTb2kOSgEWNiJSg7fpcoI1ccQ3bxZy2yMXCBYyOJrC3T3EbkKk?=
 =?us-ascii?Q?L/ssIP75ZOX3Ts3cgWlByH8nyFFwsMPgYACq3kFdKCTmAHC9c8IhSKPsl5qi?=
 =?us-ascii?Q?LZNI5SkFXtr2LrYQxouCRQ+zk0nAbZLnTpShyUGdTj11j0z7H09AUidFKVYl?=
 =?us-ascii?Q?t75q4qLBk/KDowxaJbJksBuN95NG6bepI0Lbfe8xFKmhfEMlpGfDeOyU03c8?=
 =?us-ascii?Q?3yjKZDzqTTa1WFue+6RXTcD27q84zAVw77/H1oQHzGYaCCOAjhYu6mr8+t0g?=
 =?us-ascii?Q?tQI8QkgUhRENkr05NB9NVMEsEr+cID2FKRhWdlytOgkYgFp6YxQsDIENlz0f?=
 =?us-ascii?Q?kHON9fQgXbte9ICNlopMXSETu/1IA9sZSNe/KdOEvVsd52gMHq2ndx5u3YzX?=
 =?us-ascii?Q?NlSJekbtaT3KZuB2MHThDuHFQ7qh4R5pyABXE+RJg4LQXIyh7AQrwGEROgLF?=
 =?us-ascii?Q?5KNWCNIATtJtkIYbO6EW10BTUcJvoHJTi+g4mrS+xT46w8/QfNiHY+4hci42?=
 =?us-ascii?Q?TAEDQrnci6kQUHCvyIQh93FcT7N2iZEJ5ZU7XVHNQCOiU/I+GLYZ2DZnOlB2?=
 =?us-ascii?Q?meRmu9RvIiOPTs3ePDQxOBiqsrTKzi0DskFK/JMfKtFXOFUMNMJ87nSMlhp1?=
 =?us-ascii?Q?KrqE1XrtcLrb4ArLY05UqwWGxd0VXRDrsYDw2Sr6cKBg+gCFqfHAyFFPPzly?=
 =?us-ascii?Q?BFtMPHqOUEkhUWI4F2yovOq2RfgzYR9sixE1FcG2qTz738OW7/ifIuNHWghM?=
 =?us-ascii?Q?N2JrtL1CMuIoYdtd22iw1Pm5Qjh9UlWCzynwz4YVmgx2sHjWf8mBT8cAcK5c?=
 =?us-ascii?Q?bNCcZCP5CP3DQfj+hChq7Ms14zDHYeB7HBvKgroGe3B3G/K+R4OYa6Z2/TRU?=
 =?us-ascii?Q?HtukLVbjF3IPAHMP+bgN0o9k9/xBM+wyOCNfN8Y3yrfcCT6MbjQgBp/yiJVS?=
 =?us-ascii?Q?0XWJOBWGyKHRZTO/DUWAXlEaxFQf8cgPcMcBmPO5Iopy2Ke+YCkLiBqQCVGC?=
 =?us-ascii?Q?/hVDJlk1YsgEhp/Sn58GpgbmBSGd0pqmknuCLiCUCKSJ6xAX7o675z22X/PP?=
 =?us-ascii?Q?NtgbZ6aEZP1wCufP+AONvYlOaO/f53DW6H/9zHmuKq7xn4RpkI5DJvwI4dOs?=
 =?us-ascii?Q?tHiV99AvuUAIhJHfMRH9o8Zvn2TBU8yBu2qOG+Z3X/+RWeZi93IQm3Gg+y5i?=
 =?us-ascii?Q?fZm0we1//EkbkWVjJMPoFV0t+IRf5rD/mrlJFUOABFQHDDweMAYf3WfIFesg?=
 =?us-ascii?Q?2wXYndRbL8DwVe5u2d4dDJ7chbFnR1x2KnTKjaJDwXhcPloS0U7pQqXz5XRI?=
 =?us-ascii?Q?tAX+m2d442j05C8/zAo875+BpbX5UKQYUSKYdibkSQTR/f1HyUUWSnVOrIK1?=
 =?us-ascii?Q?7BLVMIdsED5CfoAaAf3E63w=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a799fb95-8040-4700-dba9-08d9f207efb5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 11:23:35.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpS2H5sMJQaZTk6RdSItcTnEiRfoJ74h27DB0QejcfeJV6GqGFWl5ezCNDn7VvkysIAQrbD6bqVbggyMCTd+3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9413

Add MP_FAIL echo support.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/mib.c | 2 ++
 net/mptcp/mib.h | 2 ++
 net/mptcp/pm.c  | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index d93a8c9996fd..f3070daa013b 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -49,6 +49,8 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
 	SNMP_MIB_ITEM("MPFailTx", MPTCP_MIB_MPFAILTX),
 	SNMP_MIB_ITEM("MPFailRx", MPTCP_MIB_MPFAILRX),
+	SNMP_MIB_ITEM("MPFailEchoTx", MPTCP_MIB_MPFAILECHOTX),
+	SNMP_MIB_ITEM("MPFailEchoRx", MPTCP_MIB_MPFAILECHORX),
 	SNMP_MIB_ITEM("MPFastcloseTx", MPTCP_MIB_MPFASTCLOSETX),
 	SNMP_MIB_ITEM("MPFastcloseRx", MPTCP_MIB_MPFASTCLOSERX),
 	SNMP_MIB_ITEM("MPRstTx", MPTCP_MIB_MPRSTTX),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 529d07af9e14..83219721d337 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -42,6 +42,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
 	MPTCP_MIB_MPFAILTX,		/* Transmit a MP_FAIL */
 	MPTCP_MIB_MPFAILRX,		/* Received a MP_FAIL */
+	MPTCP_MIB_MPFAILECHOTX,		/* Transmit a MP_FAIL echo */
+	MPTCP_MIB_MPFAILECHORX,		/* Received a MP_FAIL echo */
 	MPTCP_MIB_MPFASTCLOSETX,	/* Transmit a MP_FASTCLOSE */
 	MPTCP_MIB_MPFASTCLOSERX,	/* Received a MP_FASTCLOSE */
 	MPTCP_MIB_MPRSTTX,		/* Transmit a MP_RST */
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index dc0dffc1b6b5..314e110588d7 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -283,8 +283,10 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fa=
il_seq)
 		if (!subflow->mp_fail_response_expect) {
 			subflow->send_mp_fail =3D 1;
 			subflow->send_infinite_map =3D 1;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILECHOTX);
 		} else {
 			subflow->mp_fail_response_expect =3D 0;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILECHORX);
 		}
 	}
 }
--=20
2.34.1

