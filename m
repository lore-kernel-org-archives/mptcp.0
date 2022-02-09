Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C332C9C
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 10:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644403400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHIoEQngxxTS8Zj+lczwXnx+sqlyp66bjyD95ldHVD8=;
	b=RD58KpdoQyZZ+l+rGAjzCFfeIgYfJA7S0MXJbbvEff/j4Q3vUb0qEtRISGPg6xh2OQQaWm
	jIx4rhOsToV+qnWiYSQPFfjKd7wYLcrarVsP0q7K/cLRf2FGHS2w0olC09MeQlkgjUk0kl
	nprAdTZV0Fa3LeFr1tfEhzUUCvVY2eE=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-_lnrUAxxM461a46ow-xWIg-1; Wed, 09 Feb 2022 11:43:19 +0100
X-MC-Unique: _lnrUAxxM461a46ow-xWIg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nME11vs8850IPc48PVpmNUvhuiwwb8GeT8FPG6qULjABjWxY+2YlALvXvidz2oyv6vXaQqSXCF1T0UcPVLjfLOzIYz0rPpobMi6xIO2BgI53mvJaJwSVwYx2pVRbRZFSBMcDP7+8Zj3bHsbGNrM+s1K/uoeqfb3skeZ4E9+TlDlOlH+LXwMIEweuv8TLY07I7u5qNGn1HOqwlqu15ONQoq3+7d1ejnSVWGdgdXdUr9Zr6qusII2rvlzYbMNLB0HGQzqy5j+H5VbuX3XMP4I4moeHDinvWx9wPgtJJHgL2hmtBN7OiTwY3qStAO9xw60C9sKIqqd0ljt1SO6iMcxzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qg4WJsQGr4yLxe1BzNPIO9wyNDnShHWops5zccKF0+g=;
 b=RCGZ+T6yOMmehsFwhcIAraBmKM9cWnFDRdCPf2gQpME5hA6aAnnhLA6UvQcFfbZhcz57CTSRngXzpB/UROOGP6C5CAAP944dsfKn+a1j2x05dPGWg2TLm9KNMdd/YTbbDMBBvLu6eUq9dh8Tk0vYo8V98UVpMU1jrhbibzUh/HHScDr/iL84Hv5czFSrNr4ehW82e8GCFcKk1Ngo74v3aNLTBrX/8ojGsAWmfIihg6Da6bcOdOW1S/h0PF+YcSi+R5OMxhprngqP0zL44fbEiVHb9FNwjky8ywiuK8+mAGwLojiofIYeK2AnoFLJ5KZWydiYz01pBrbfy59WXGd6bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6997.eurprd04.prod.outlook.com (2603:10a6:20b:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 10:43:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 10:43:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 3/5] mptcp: add mibs for MP_RST
Date: Wed,  9 Feb 2022 18:43:11 +0800
Message-ID: <15d21058081166971b94f461b412ba84ac02099c.1644402973.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644402973.git.geliang.tang@suse.com>
References: <cover.1644402973.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0060.apcprd04.prod.outlook.com
 (2603:1096:202:14::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3ee31f2-c5dc-4fc4-c078-08d9ebb8fbb9
X-MS-TrafficTypeDiagnostic: AM7PR04MB6997:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB69970228B5BDB1D2210E23B4F82E9@AM7PR04MB6997.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tt4kh01gSOsH5LuPCnTGslmNLC7q9OvR1Lx2DC0BJd6xG7N1Oj19ZgDFEtmuWNk81dhk6ZybGSNfPPQn0AhQXyV6Snrd68Oy8JRXG8Uf8ZTVo2sEY/YjOTRtPXD8bcIYX5mUl/gCmSUUq+LIsqMRyOeHv3VUQd4As0INv5rMLMmIUqEDSEww1GhryetKYRwWwhIvyimoxG2CR4Ha7kfDiSdCz/oe2MvNZnarzE5/TQO0lepClNaoLBbcGdj7QnKDcMq0RKjOs7OZARVrDI8LTXpfX9djKdBZOurcQ2Veen+MM1gh8Y92VwQw8rr3tRFGHlh2njPR1Du8QmBM1W7EALwTfeVmoLstUooTwqCjV5vRSvqXHpmRUKvfqpkvY91vRe4nSxWkyWtRymE55prRvgmNJIywtRyH+Es/AAFY79rfL5Sxx2KVjm+hmaTGVRnypVmRkGMIyo9HA0X0+KH0pUj3HQNYChT5OMIynRUhyX0zsdcDM8M7e1kILnJW259AdYzg2azi02yvYnUK28W2DsWCntpIzW8dP7eqDubPwHCzewWjV5ogvEl+e+SgC8kYYv8Es6qgis1j8VYMHJ59j8OLbXhVmyMvBjihtKfGrSWBfltsdQPBf19Hrbe56Xy0H22gFMO+f3cqhWsbgMPhnw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(316002)(6666004)(44832011)(38100700002)(26005)(107886003)(6916009)(2616005)(6506007)(2906002)(5660300002)(508600001)(66946007)(36756003)(66556008)(6512007)(66476007)(4326008)(8676002)(55236004)(186003)(8936002)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DcRIJuFkke56lsUspOmXy3A4qEoFk+Twdje6wk8FRW0rFluuf4+FrSRjJXoe?=
 =?us-ascii?Q?0cz7rAwAL7vhPE0719FPLxPCuGHQjia8gZILCDzsU/NQE3yfjiHJ5aIzs7If?=
 =?us-ascii?Q?ZeNh5mFdXNozvVkB2J1XHNma/x49j572LJ+0cHjEd0sf6EvZjzcR9/4DkYuH?=
 =?us-ascii?Q?q5UONi6jVsdMypK1VBDllLFooDOE1MBiuM9n7Og7K+rthaRIaTDJonZvL1ug?=
 =?us-ascii?Q?RLfwFi7rDXtf65B+ZU24+oVXj27DaZc+RARKoSw4x8QmMcIuERpgOt6kxrqb?=
 =?us-ascii?Q?rcdJizYqkuJos1A1QTpLaCtjNPLATxY+30XYriYGI2k3zrkG7zohtV6YCc2A?=
 =?us-ascii?Q?NK1caD8nd5w8k6bZyh2Mk/9U0nje2AQ5wrgjr/3BFbzdTtrS+C3Xwmc6sBbk?=
 =?us-ascii?Q?YyR41eK5CY/eXCUFqhlgRweHRWEbXeLfkNWOLq4mm7kI0z8kRa9wKv7TX/Yo?=
 =?us-ascii?Q?U19YwAIHgti7KlYikMDG24FwbB4QwvSCSA3/Og7lRS6O4wwv7OZO1fin5EIS?=
 =?us-ascii?Q?FSvCFtQgV+YU9SJcwjW6SZUhB12vFRmam8aKlxLKuCYdgyok72GctrAwQ/u3?=
 =?us-ascii?Q?j8tWYggyuarz3aXEQ8ivKIeSXg1YCB4NM4kp0B3vEW+W9/ehfs9slAZd2L/B?=
 =?us-ascii?Q?K0RdgWUaMGwXvVZtTulLGFA9wQgnr2uh5pMVZfST6MIxlEwH5XErrNcMYvVj?=
 =?us-ascii?Q?dBg8eK9zfW7WxaepM9fVuhyt5Kr4f1OmCpzSesZyOeW2mi5niWmLPKxAG/mj?=
 =?us-ascii?Q?7Ndhb5LvU3M5nCNME3kX39410APFYna6ROcQXrV8eJ9bVm313PTSTatqarqw?=
 =?us-ascii?Q?Zjyjxw/gLBkG4UMm/uVGNQRkdDIRdKIH+TDdjxPGugeoko6cW7JfdhfZq8cc?=
 =?us-ascii?Q?ABEDrE9GWgmcv5VNGB2YkFrsWzF5VNtYYwnx4b28WbzSBGJ1VcKXIxsD+qgy?=
 =?us-ascii?Q?AllRt+ublVr2pzUbZrk77tMzxTpFnDVrByik5Og8okapApNUyzL4B8ca7xQf?=
 =?us-ascii?Q?V+nCjzVVOgI2EwpUxzTlxkBiKlQltpD/LtJimUQAV1d53SXWRb0snDDGRdvG?=
 =?us-ascii?Q?c4/NA8awBb++w/as4nl5Ym4wnnefLrUR7iQ8C7RPjARSCVpB1WSjqanHKLpZ?=
 =?us-ascii?Q?aCgZHVuoAhbaxYeoqcRSn5TR7ANBdQkk90fC4rTAPgFqDO7eU1OsjmFoxyuF?=
 =?us-ascii?Q?W9SYEATltrZMmAOgF0OglJ/gf+nJfqazMicJg8JMa2i4sOZvEb42BAORUcV0?=
 =?us-ascii?Q?zu+TdDw7hHDsMm/X4ag2tkN/S1f9NKxJSewCXGx2Mw4i8eRTQ2d1REN8KcsF?=
 =?us-ascii?Q?9BOjBMSvjzWeAZ4EEViB+1gt3rvIMJmiojR+R1ZRRmQEF+jNQQN9sF+fyOe/?=
 =?us-ascii?Q?TEJKI9JEPhOlHYoKsTxlGJQ0psJVRh0zW60K4m6bpjRuvzLiL6awdCefOMW+?=
 =?us-ascii?Q?Nx7n1jrYvlDI4U1CaQJExk3KFmDzcv7Hy5XfnIh6XOW40jPFe2P9zf3Kwp+l?=
 =?us-ascii?Q?cLAQS8ONWqw8LzKGG6+bH9llGFqc/anvDFdQjqog1R6HTYqmQo51WfhhGltn?=
 =?us-ascii?Q?je3IaE8uGCcDaSYytpCJ/6xbrYEPyRVSO7ODu0UZiBUGnZRapPaykzF4v4NQ?=
 =?us-ascii?Q?81YoCzi/b4STe2w36A2uMgw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ee31f2-c5dc-4fc4-c078-08d9ebb8fbb9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 10:43:18.0181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qB5V8Zq1NwxpsCH1mVWGqEtaY/T4d/KI4fuENVIKafrRd7wHHdK68EcSrBIUEkZhe7PNW4gd2MVHwBqQQ6YNJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6997

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

