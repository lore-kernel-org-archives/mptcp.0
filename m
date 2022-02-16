Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A907C
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 11:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645009511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4H29Pw7OdPNLpaOZpBJMLrBr4F7b9s7fJyVjWLd+v3Y=;
	b=WlEgSwIEmmMThEZ1RKGLnYyAPCe9hetWC+HIYmabNxzF6qnMPBXqS4nYQfDXwfTPYc1l36
	1iCvkHg1GPYHbFqf2fakZOVPwIQRnl0cDeEg6OoHe/ZIgDHGshfzSbUmUefK9pgjvx/K/4
	o40xhbezrmxDwfwL9W2D2SD825lsoW8=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-cFfeA3Y1Pza1lxYnds9slg-1; Wed, 16 Feb 2022 12:05:10 +0100
X-MC-Unique: cFfeA3Y1Pza1lxYnds9slg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zvyqn+Lt1Ippjy9RogR9MCwzmSwSsOsfQEQ3EGhn470/akEIO6JPIckxXvCRR/J6oHRRNTo00c9hwMAyGbqxTxxHp94u62icHpLqZwxDEi0Ot0FGkLe+frj+pLPVcpY/9uy6iEAeDtbiRBGuJV+gP3LyPymZxG1a+gJgv43ZC+8SnpEwmn1ynInAaRuKEbtAw4M4wJ2cPJA10OwLtvCVuboX9ifHrUP0456beSkwX3YU6ui3WCEubSys5q/CcWMQo7HoUZ8c/aKut+zEJqHRbxlY66+FGE0PgOLF57YyoyhVYurfyR/b98BcVnb/Rh8va6UnQGfwiGZUhi4h2om5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rN2mopUOG4QKfxSP2DzgPoqoVW42NHcqeZf2DbsQjqU=;
 b=kC6sE6lkN5qRvxjOroUosWvEhdV2EhTxGOgHmzn4fGVhj+eD10Cw6GxXhRbzFoYWEseFipldQhktacpQHMycUXnM75NnIoZLcXYeQDZQ1RaEQ0ddy80m/ZBnam7UeIwz0J9DarzCkMjkpreK2pg4AxoJnbRUKRPnIK3C4DGcoKE6KD5iMlX086GGsl1/ZPCXAwpYvVZXfqm/F4zgqrMM8VMBGTBs01Mi24GlM/69GPOC1U/PFbpqMHLAJgW/nTK67rhaOae+BISn+uQeNxkxfQAfKjvX9J6wJdHA4UqG5KRQsaie3Oc+0xooavUZ07cztaahJpFBgG7YXyPiqTb2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5799.eurprd04.prod.outlook.com (2603:10a6:20b:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 11:05:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 16 Feb 2022
 11:05:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next 2/6] mptcp: add mibs for MP_FAIL echo
Date: Wed, 16 Feb 2022 19:05:09 +0800
Message-ID: <eb2dc48d73dcb4c6bed3c6f82625cf6b42d7d9e6.1645009373.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645009373.git.geliang.tang@suse.com>
References: <cover.1645009373.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0207.apcprd02.prod.outlook.com
 (2603:1096:201:20::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d88765bc-b45e-4565-c17a-08d9f13c3279
X-MS-TrafficTypeDiagnostic: AM6PR04MB5799:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB57997FF8EEE724E727FBCF44F8359@AM6PR04MB5799.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:61;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KW/ckPzFnHRXvD1oJYOo0UG/v3S2Q/8BcHRrxRsjCm0kZoiV/acu2JJQRLaJxT5NsD18jbVTALGxBMk/KrInMwMKK9sf1Kl5MlylL/OMUr9I9ccEDwe8+3xCfzP1ZhDDA80rzWFecYLyuCt69i/spLnilJDgTtIS2PqA+GP9AHzAVnYp4KC13IPR5k3j1G4JAUsp55BDI3NUrpR+OMsDCb3bHYvX0GobsdCbAlwA7v9AU4z2TsTBoYvJuftfAoznL/VUs7MipOesdkY+395y+DCTw55Mrg0Dlrb5498Z+Aq5nqgz7OXxs9mHZLjuXlCV0XETPzZc+Kjr5KYgePdwANYZtFbDCsEWgiq2HYnw+E2NdOjB4apSnQQs52693Rqhmp11kUO1vFPgJLLAbMI0rLYAFEvWfXAygVPyxPnzqhgdcb5Bi7N+9hbslSAMr4QLNbOCymgBw0qbd0IJupIHqMrborCgbyGvWPLefTvcw1ujvLn+6k4GOu97GT+HI3OUb5x0aXDbGBjFqLECzEtHETmJM6zjZqxEZFjAzocdeC9SkhuPAuOiPo6LTco1HtzpJsNy16SY7Drh5/ezDg4GSkkhtg4DtYWnVJ8qctOZjfH4GWAW9pXl6CFXSRX+/3nY1W6t2k+zf0PNnQxzT+jpNQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(508600001)(36756003)(107886003)(86362001)(66946007)(66476007)(55236004)(44832011)(26005)(186003)(83380400001)(8936002)(2616005)(6486002)(316002)(38100700002)(6916009)(4326008)(8676002)(6512007)(6506007)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/xBtWjCn7ygk76jvP28M0yFaODbrloL7PtjBF3n2y6g5wk5Gqk9NIlhJmG/U?=
 =?us-ascii?Q?PiVbqaVwe1dMooxBZ7fbwHO8sUYPCMQHZrzO1QuX49xN2SOfnKyZWYcU3qjX?=
 =?us-ascii?Q?pJ4UZzgga7GItTmO5hsNw6oaLCgeyd5d6kSvYVnizLTCzD6OwLqE/r+kk5w7?=
 =?us-ascii?Q?0abs1s20UBPxVOFlbyetIq96Msp+2Ai9wDmiAhCHagQXwaPnaX5YG6KVzWz/?=
 =?us-ascii?Q?jhQ5QwVWjxiAeGPHyyRqM2U3G9E2CGi81dQRZ/fPsqwK3vWewjyxJMQZm+S7?=
 =?us-ascii?Q?NFH6rJPKWZETIuC2JNntBC4eUikIdaUzS+j02aAkqsEd8jNtDi6mByjf0n3L?=
 =?us-ascii?Q?q8AgUsQ+Pgrusvek13lLxU3q+lWRFKBCEz02OA21GwLXWNUY9PCR0soQsDxA?=
 =?us-ascii?Q?jBUeHZMHPRz7MjbSxb+8Q4qS2ocyGoUJyELb7ysQXWMfPc9ex/WlyDEBhutt?=
 =?us-ascii?Q?WOk+CN6nvk9xhk5Fz2BouKdk+LrrOAsjGEzcviu+X9msiUKXeoSIj5UYCGqN?=
 =?us-ascii?Q?qUo6E35NPmj3GJXx6WET9WN7F8OCVJhil3AeW/ec0Y3YyB/yluwA8l8UCDPu?=
 =?us-ascii?Q?nkQTJ+VtjrRioEbOcoHxpYGhTj5DJG6o2i4hurvH0JWQvTWc9hbRwbb6PSmm?=
 =?us-ascii?Q?WR+ZBJofvVpXYkpFDPw9mEGk1UIJbGohhKL1nDHgBQr0EU06/6pO32/rBV9D?=
 =?us-ascii?Q?Gsrko2Cu4F0S0hD0Ekdm9Vr/jXgBpHOrTfLWFZSvOltZb3hTUEU3Uwsy+bd0?=
 =?us-ascii?Q?BL1iICTAUEwIhIEO5NOY8qw7PAhnqEmvcWhq/J64sXYCd13/BwfZlSgpWCuu?=
 =?us-ascii?Q?AMKUGz8inwGlDveSXksAZ/AlPUKiq6/495iEmZIS+Use+e0XnI7OmJ4D2cw+?=
 =?us-ascii?Q?oxJDa0cXZC3hh8Ww7CQ/yrUurEPxUeH4adBe42ndWWqilpQ9ThK9sdedun2O?=
 =?us-ascii?Q?uOIy+dJbLVbuhQNJ2oncW8K1KDpmebq+G1OxJBrrlnGYzqffOKKS/AAwVDfW?=
 =?us-ascii?Q?sQY7n4SKGyGSh8XjDCZbHRAKuPKVu/0+biEUPg+MjEjp6laSLAbT4rlazgId?=
 =?us-ascii?Q?uL4PYOEIVw7LgBeFldyyzR0uSxa+/qGPy/vDV0GXgFINpmAYoGBjXP/uZfBJ?=
 =?us-ascii?Q?hGK/8jdbmlFRGjkHc3CziiztFHFNzeTOjzAM3DZh7999MlDgia/xZuAJr9qW?=
 =?us-ascii?Q?6UNIOkoSDWLWRhwUfmb4KAfsYzKF3jxXNiq2c6u4hYnPVklrohhmdLaYf5BU?=
 =?us-ascii?Q?dIhnkYoMSPi5iBNVkK0T51HGiM87vEUkc5TRBMZ5yvoktB2ZIxmFEAPG+qrx?=
 =?us-ascii?Q?eIcD8ZHInk2Un06Rz5wj5LRQL3YyqTZNlzlUuWXWa0op/t3YuLPIuwLfR/IJ?=
 =?us-ascii?Q?0j9Csdix3d/+S2N8gXkakXugjN/+KtHMjS6Pq9n+MX2Uc/gwRkw3FZzvG6vu?=
 =?us-ascii?Q?rZ1j489/AYDMfbECZAySnE5KXWaBx4TXfVmXVbw2pDCd/QBZiQkGeWV+8IbX?=
 =?us-ascii?Q?HP1ih9hahb4i1IWdlr2tN0Wt4XCmncYsGcrFVcPmEWsLLcfdneMobhzqQc5x?=
 =?us-ascii?Q?ydknzS2vPbE1mZX5l+lFa9hrztYwzWhYMNmiihQgw2+UIgfcCsTbB+3pv6+3?=
 =?us-ascii?Q?7VEex9CLdfWmSykyk7nYZqo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88765bc-b45e-4565-c17a-08d9f13c3279
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 11:05:09.8057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFSqE7Iim69adCoUhouVEeLLzhhBTQ5e9HWMBfe1eGdGsD859rczigYJcrcAeBis4d46AVIQp3Tt27k7CPj2qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5799

Add MP_FAIL echo support.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/options.c | 1 +
 net/mptcp/pm.c      | 2 ++
 4 files changed, 7 insertions(+)

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
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c4d66fca9c5d..67dad62f34f6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1171,6 +1171,7 @@ bool mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
 			} else {
 				mptcp_pm_mp_fail_echoed(sk, mp_opt.fail_seq);
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILECHORX);
 			}
 		}
=20
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d58fddf4d5a2..5e133b249492 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -286,12 +286,14 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 f=
ail_seq)
 			if (tmp !=3D subflow) {
 				tmp->fail_seq =3D fail_seq;
 				tmp->send_mp_fail =3D 1;
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILECHOTX);
 			}
 		}
 	} else if (READ_ONCE(msk->allow_infinite_fallback)) {
 		subflow->fail_seq =3D fail_seq;
 		subflow->send_mp_fail =3D 1;
 		subflow->send_infinite_map =3D 1;
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILECHOTX);
 	}
 }
=20
--=20
2.34.1

