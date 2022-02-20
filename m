Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D0028E2
	for <mptcp@lists.linux.dev>; Sun, 20 Feb 2022 02:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645325956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+1eAYVORN79OwMVhvIzdOO9ATRjv7NBp4vxeXkDX60=;
	b=bmO911vyPx0AQ2XFuBF7IX69l4FweKL6bKy5f+5U6y43TQoLg2dQ1siGTcm/dLPqjumPX3
	c07YgKOsdC/KQj5HZpLDSpqHzsDOmq/2aNb+28ROB2k8PT25yf42dELHXHppSVFxuSB+tx
	XTNhlTR1J5+bcrvDT/PdsbfcGtyvkzk=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2058.outbound.protection.outlook.com [104.47.5.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-hrugubexNmiANZd46snMHQ-1; Sun, 20 Feb 2022 03:59:14 +0100
X-MC-Unique: hrugubexNmiANZd46snMHQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOdMbHQY3/9WwajOsOS4HBA7dfn/xhLh3srCWQFoOeOHmE+gzPELxhXfPXMkKndGVgvA8rOlTXlJ7h1/iHFvC8ukVP+Oa7EGlbUfdtEAgvd27wBEdR3zzmBHDF75WdK1d9azeq7+W3okyflXc4hUV0P6BVMdg4nQMud83veJUzYlk7j2/ElVsq7p/KZCbzMJXh1l1Wlc0ebI2ogdsH1qee+Rf4HP0a/ikTNcPMWum+d2+zDydVRu4w9pdAc3/6sPK87Sj00peIwciXR0qGy8CYsA6UUOz85Cxbt6TlCuFB5o+OlENhzf/UxkIPjCaWVkUMIOYrEt86mi2+UdEKCUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7aW3DzNPBB7SGAdLa65igWwLydbfsYUy5nUou+VE+I=;
 b=Le0LWI7ALOOxGBXvtxKlUE1fI29st/Z/ixpqLY4FhfuZV7c5S7VkJmjyFuRxkb6jq/qV2mnn+8MjkJhn5iCENFrLZ2M4u0yg0UwJzgW3UU0RD0n25lyWLf5Suj0G0m9b7beuwkknhZ8b5njYdtz7Bker/RIAF93g2LwVeFPURWEDAVAoiIAbqRKyk2hvJqrCvy4z4P6SEk79zTUPjFyt7Ztvv5zY8b6DsYTudQAqGW5wfpCL0Kd8PtmHZDqb59lNZ/X0wUrVALzV0dTHAIJRQVk4DAa36USiol7N2cW48AxWGwnEehjx54up5MoC4Sx8SgKDreKKfoYcrfsuLQHnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3414.eurprd04.prod.outlook.com (2603:10a6:209:3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Sun, 20 Feb
 2022 02:59:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 20 Feb 2022
 02:59:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next v2 01/12] mptcp: add the mibs for MP_FASTCLOSE
Date: Sun, 20 Feb 2022 10:59:27 +0800
Message-ID: <f2f27ab3c38118d6ba0662bd302fdedab038de6e.1645325178.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645325178.git.geliang.tang@suse.com>
References: <cover.1645325178.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4e979c4-2114-40f9-4388-08d9f41cf991
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3414:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB3414D0BFA8AAC25045331320F8399@AM6PR0402MB3414.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	taMH29t1bgCflfTdsktW9C6L2kIzzUxjeWH4xhhTX1vXAqYte4GccAsVwy8hmIQciM3CbCNjQUhBMxIEQ7wXoZeG4IO16wm2WrkZuf0Orw1CKNIXK9WyA1I6CHg+CrfNW934G2EbYxGSyJCTlTfWXkGOoFeLn/XSX6lIz7rBruT9cUj6qfCQUsAtepXEI0lipmqgOiRBabNKTmlpXC2m3SlD5eGvNWZWpgc4i7FrmUBGVi+gGSX3EMgGjwe0tAX+U1qoDeUUDwmeeZmELCDpnjY6+cSYD80hpG3/8kEVLtCyK+jVvBx8uKjsgTiFi/lwYmdoFB8pts2cG8gPg9C0j1DDKdPziA0EVH5CTywhY0V5/ayROyYXBB3gxybQkFwxCWFLmyXFxrITCCPfDNAxLob1ZgdYRmHLlmTL8WVVTcdQmDB1/KadEKwgp0eqQvKYVDEjmUn44T0obyhcQoYDXw2nrb9AgIGv64gmYYwtqlLOI+SXOM8PN+YdOq+Z8Tjz6q/9e3954kfKyzNnl54NAPVqmNSsDtTQsr0zUJNH69GGQ0z5AKPuTB05HbVxxaYTT0xNF+TBwosITC1pJYJwUjtKp1wiGwonIp+6pInuK/D7pYcSTplPUYNbWdkC1l4wiY5x5b4LXJa/tlsb42RdzQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(38100700002)(2616005)(36756003)(2906002)(5660300002)(44832011)(8936002)(6486002)(508600001)(66946007)(4326008)(66476007)(66556008)(6666004)(8676002)(6506007)(6512007)(83380400001)(86362001)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GMqzJb50uen4pkYTf4Dq9Uia8opBurtTFn8WxiIRS2blvdjFXhUI3mmyRTWe?=
 =?us-ascii?Q?ZK21AiBsTMugPxfJ2FwvEucZ6f0YNfp6xHvkohV3KirQzQRGtIOd89+oBUi2?=
 =?us-ascii?Q?60Opfpi/kHJaIKuxsgv95SkGH90YPcHviZxMgQnq7L7tf+D/cHcPca5OdYYl?=
 =?us-ascii?Q?o1WoVP5dooNcUJ71op37mFYqECnCX/l+WmuihJH4df4yf4xZdVW5a5jCAzrC?=
 =?us-ascii?Q?SsYQ4im3pf8jYUDHL2hL5miiSlsf3Pem75Xsc4xVBZEmJdPQBdxCk5N3rPHJ?=
 =?us-ascii?Q?4lfvEFp0N8RFAj79E6NZD6HVv1+WQhgCVsxd7jZbVRVOtTGjJoN4nI/gOqQA?=
 =?us-ascii?Q?qTpHvrPmq8hU+RH19P7NhrzyLubhDIRNTucKMtQdX0bQJEZj/WQtXxDLoNAY?=
 =?us-ascii?Q?wpptvNI/PmPM2WVrj3OH18cfBIFnQfiq9pTEMDZXIVKzCs7KwrqAEGK9mMLW?=
 =?us-ascii?Q?zjCnHc6fenJuW1XXOR+uja5FxP7iL/QcWkWxswJevqMc0B7anaBf0/1/dQ3Q?=
 =?us-ascii?Q?Iqr5Xks3oGo3CjuC+epdwnqIHXIs1IpGBS0oEQBaKla5M2TnNg8GpU0qKBwj?=
 =?us-ascii?Q?oC4m2yh2gj9jXWWBHu5oPgRuHW2pZvYzEbJvQ7S/HzR0/docv69d39WBw+en?=
 =?us-ascii?Q?axUI8DUSuGMU8gKvY3vG5MBRPofMRQ7MeWHssfe4ixdM1BjvaZdFCwi5VZIH?=
 =?us-ascii?Q?6fQlySATUtQicEpxWSPvghMwwxq/jBxK48aJNbRCJbxosf3KNzN7/hxHSClY?=
 =?us-ascii?Q?OTmkHzFIFgpDXI5rJybnnVELS6whDKQrnUCX5V8aGRQZgka4JTk5FXiwHNnl?=
 =?us-ascii?Q?VGZvOtFpXS3ITI2tf4l16mQ5J8kYBkLL0bfZIzqY17E1jhUhkXCGiHRHJVKX?=
 =?us-ascii?Q?yiIFLNmRvreHXj6Y+iFUqa9i50Sy7NqBuVJtAqOaaNOeDRB16fbJ893BdP8e?=
 =?us-ascii?Q?7Rxcf36UtyP64fE5jOhJq8Ho7pJwohHH+D3ZQc5mDQGVuv2Z4lk9iKY94G9h?=
 =?us-ascii?Q?k05PAkN4Ai+td0mzjrGOi1jSikY84aHJCmYS/N5cFDQmPWRQkqt8DzOhrm+S?=
 =?us-ascii?Q?SLJv2zn8fRKcdGRDTYXbYx6hUOt/aw51y+wG0AJeaJoBPw2+I+1tqA9g05tk?=
 =?us-ascii?Q?yEBQPDjBzhU3WQigjAHlc5aX5wUj2C3aXhhKOZ//DPGuPm1dGLf/E14ogwqD?=
 =?us-ascii?Q?Etl9NavRe2dGZMF3sv4da7/QfHjNs+tvt4ZQghDvcb+aagFo0tLmdoeTrbFg?=
 =?us-ascii?Q?4uZIv/PMxlvP55okw+vkcU4/9w8BTSK/phjpuM7qWacLkZPTR2v3ASq9vgBN?=
 =?us-ascii?Q?LuYl7M8faZyhBN+M9SpWOHgBfr1qGgM4YQFlZhQ1dFnPhClqxyFZSbaGIVBX?=
 =?us-ascii?Q?WFTYGM6q534cnF1MM9XwjYPHbUlz5VO6OLzpSyF52rjxqvEqjU1qpOWh7NQ7?=
 =?us-ascii?Q?bIF7jxeNFgSHX88A7R7IKMYvigrvTu7MzFyxsTMVwKASWlUvxfA4ODyg3W8Y?=
 =?us-ascii?Q?ZGYkK4s3+dB0lR37nc2LKmUTGqRxR4bBCRacJyqlWwNUgn7cKHc2t9X0tB66?=
 =?us-ascii?Q?mNoqVjhx30QpFHkfsCIoc1dHRfflQFI1tUD/S+a/aW+eI6G/qSEYS5oO+LHJ?=
 =?us-ascii?Q?mR335bwbBjHFDt/5eHt9VBke7PzNFUkBmEQTDz2Ht0303CCUzssJZU0qRkNX?=
 =?us-ascii?Q?io9g7unj3KKYU7UvwKL4QDc4jYs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e979c4-2114-40f9-4388-08d9f41cf991
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 02:59:13.6069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbzWh0eznAI8Cyjd95xJ04B4TLwYGezi4y2OK0QCACwo772geJa+n8/QXYL9JhgYdFgaYIZ6ElWi8qGblRKFAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3414

This patch added two more mibs for MP_FASTCLOSE, MPTCP_MIB_MPFASTCLOSETX
for the MP_FASTCLOSE sending and MPTCP_MIB_MPFASTCLOSERX for receiving.

Also added a debug log for MP_FASTCLOSE receiving, printed out the recv_key
of MP_FASTCLOSE in mptcp_parse_option to show that MP_RST is received.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/options.c | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 7cef7409e300..684643f8af53 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -49,6 +49,8 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
 	SNMP_MIB_ITEM("MPFailTx", MPTCP_MIB_MPFAILTX),
 	SNMP_MIB_ITEM("MPFailRx", MPTCP_MIB_MPFAILRX),
+	SNMP_MIB_ITEM("MPFastcloseTx", MPTCP_MIB_MPFASTCLOSETX),
+	SNMP_MIB_ITEM("MPFastcloseRx", MPTCP_MIB_MPFASTCLOSERX),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 785cf751e5c0..93dd5176fd5e 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -42,6 +42,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
 	MPTCP_MIB_MPFAILTX,		/* Transmit a MP_FAIL */
 	MPTCP_MIB_MPFAILRX,		/* Received a MP_FAIL */
+	MPTCP_MIB_MPFASTCLOSETX,	/* Transmit a MP_FASTCLOSE */
+	MPTCP_MIB_MPFASTCLOSERX,	/* Received a MP_FASTCLOSE */
 	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after bei=
ng stale */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0401b22128c4..e775d75807fd 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -323,6 +323,7 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 		mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
 		ptr +=3D 8;
 		mp_opt->suboptions |=3D OPTION_MPTCP_FASTCLOSE;
+		pr_debug("MP_FASTCLOSE: recv_key=3D%llu", mp_opt->rcvr_key);
 		break;
=20
 	case MPTCPOPT_RST:
@@ -832,6 +833,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
 			*size +=3D opt_size;
 			remaining -=3D opt_size;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSETX);
 		}
 		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
 		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) =
{
@@ -1124,6 +1126,7 @@ bool mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 		    msk->local_key =3D=3D mp_opt.rcvr_key) {
 			WRITE_ONCE(msk->rcv_fastclose, true);
 			mptcp_schedule_work((struct sock *)msk);
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSERX);
 		}
=20
 		if ((mp_opt.suboptions & OPTION_MPTCP_ADD_ADDR) &&
--=20
2.34.1

