Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AB757D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+1eAYVORN79OwMVhvIzdOO9ATRjv7NBp4vxeXkDX60=;
	b=hMRr0iyKcQb/XOC+iqXqqT2zuLU+qTeQI1NX3N6EsDaAqUAm9k24XhG48f25ircOH01B7c
	hSMSYpx7iPYsebYlKf+9mSNa0AVo6/BSl40+nZs8etYbfUdFbF+txg4Ank9pOPcR9afISJ
	sy8jvRhTWx3Iu4hr3orFntbJqNXjMzU=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-yY_DMVbtO4GR_zaGwk3YYw-1; Sun, 20 Feb 2022 00:18:29 +0100
X-MC-Unique: yY_DMVbtO4GR_zaGwk3YYw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENkj+F4/KtZLUpFsidtvyaqn1rOxId4fRdUrU7wr6FzlCBWP37O2xyUaSTyVKxwvfxCqyur8JGgJz2M36rN1ECgQzelBxUHNRkdO/aT3npysJRk9CTpSzaBZvknbKjMBywlJqJ4N4MqDRlDIojHNNyltjaA5401Usim7+4VbANlb1QWFB7AjgCvZK4kkabHFTJMeqgiW330i7vL5mDNvoyBZ1xjEtCAp7e5PjIIRbPpE3LkIYNU4orEQhXGogyIMT7Bbo4v+6Vyp78zWq/RwrNQqIG0CtbrQvY60JAB8zAArPJjtuxGjXshDxjNWjzQDR5UlARonQmtHLrKiamfPPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7aW3DzNPBB7SGAdLa65igWwLydbfsYUy5nUou+VE+I=;
 b=PEn0Iq1oN5i1W4XiXa31DKeIF1CBa+Pz7LQ3PpUMLuIyvyIhIWcvRwjLydgVSI/QdsM4Rxr/FgwNwJNTtKxn/Zn7qzTPanCaiUkNcLKHbf3HwcUzw+tdxEUP+2AwtiQpX+ylySVCQg4spGGnelm4o7ozevo6W+T4whetv+Mc/J3EP4k01T/II1z1+ApMP1blGhDc2k9ar8QI3+4CaL3Kt72nmlb0Xjo5TVZteJ30eXgA5qvrMlinOWN4I+WWFq5/eCw9z+d/T3RDneXlnqF6OL0Z9cog6wWqkTGw60V39frSBWhRqwM5ljMzszAYOBLeItlJYKeI79KVHxmD1H453A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6841.eurprd04.prod.outlook.com (2603:10a6:10:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.25; Sat, 19 Feb
 2022 23:18:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:18:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next 09/19] mptcp: add the mibs for MP_FASTCLOSE
Date: Sun, 20 Feb 2022 07:17:53 +0800
Message-ID: <342a658b426f47fb069191a88f693fcb6fa6a5ed.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645311956.git.geliang.tang@suse.com>
References: <cover.1645311956.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0052.apcprd04.prod.outlook.com
 (2603:1096:202:14::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a665266a-6caa-4f74-ecc1-08d9f3fe22fd
X-MS-TrafficTypeDiagnostic: DB8PR04MB6841:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB6841742CB7EE13A02E00DF62F8389@DB8PR04MB6841.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mxbUzuSsjPsdllKel2sALyzc+Km9f4tWp6O6BGtB2yemX3rHcM2s+Fsc91FBgHGBcksTGiMGNKewJ4uslnVLmJkl1dICx2QSP2XtY3V9ovRlh281QtZmHCgxnE8GOYOjj5gISWpkQhF00MraWEz9aDXCYI1af9yzdtUOhXFhhciyXt7LYEshZsBQm2iOVBTRbcvM/RrtADlo/e6jivtLVaB6HtuuHHc/isYmFt8p5Qaq5nZFpfYFZej4yieh05gMUxyGY7RqGpRusKDmGXDr0Ii4k+egJzQGf0vk8T8Qrurg5mObXHb/CiRAa34Diy+kbR5aILGsikWu4lTZSzv41o0quqyfqn0yMKoxdVcCZUeDsm7pSOp+6iKQGeXtJ+f0WY6flRqJt2tLyz/ClyCyLlVNkqyaNwdVc4o/DsLlgK1Lb2s4TKlJZetTl5U8voKQf3IG0P8DWHx2a3mkW0dTzID1SK4Pp9ppx35ko9L7/2WRHWTAliqv+vremw8svArMl5gjCIdeZGNZvpVW5IPFxxheM853uJRbPlVhWB4zdQG4/7X4QVT3VVdeDO0cktmCUzi81fV1mVXFWnJ0tS5d1PRLRC1laCclUG7q+qLLPqZld9O3b+bB1Wuk+LS5++luVW09sDxvFUF2f3NbxrLnBQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6512007)(54906003)(6916009)(38100700002)(8936002)(86362001)(2616005)(36756003)(6506007)(2906002)(508600001)(83380400001)(5660300002)(6666004)(66946007)(316002)(44832011)(6486002)(4326008)(66556008)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wdLNRccXvPYHZMZpLM+R+NVIcAVUb0rKnZGtk7U5o3ITtULBOdTSWkFK7vlx?=
 =?us-ascii?Q?tW3VfzsrOIsLa2/ccmeg/tU4cedcsieMD8wlEt4PSjxXZeBGFJxGU2yHA1Nf?=
 =?us-ascii?Q?WOGInynj2aJufiIeHm1MNLqKgmfsD4R5EJbWD7mQtfP0mQYCNUFCAaQrBVtK?=
 =?us-ascii?Q?qM2Yrik5r3Oz7fwxKkOvlkW+tYiix0g7MbA+KckzeL4QsGIOx7p4mTmctieW?=
 =?us-ascii?Q?HHSR35O0lHTAc3shcnRZKRPr5QGkIQi3NyzyAXYqlhPJZtk5svAeQ4Qa3gvr?=
 =?us-ascii?Q?y2l6kFQba3pbC8AVJKd3UgNxyD3OToPzLzj+OPpnV6VAJuAyy7UFt1IG4wPL?=
 =?us-ascii?Q?RSnx4G8oa656K+5xoiD/c0WSvDcLN1eSVckGp+LaJYaDewr9cuu5HNKgToDz?=
 =?us-ascii?Q?KvuifT6dNs66BexYb2vGOm8ueT8dsZV7U0OYnZXJv9U2l1N24lX3bikx/2lz?=
 =?us-ascii?Q?B7dhd1yIeZBVxrkJehHARN4AgWPoETOqBcPro+zBCmKwdX+87dx7dyOGyN0U?=
 =?us-ascii?Q?qhGR+4DcPRDEt24u4qPk6qvDBJj2aC4zewVZuz5Nceotfdu7uHPFLoD+GF3q?=
 =?us-ascii?Q?Ls6IzZ85QvP2afA9VjqIp8y59T1oRKnVf3CbXxACZYFOoLyLBYCoryPR1eIR?=
 =?us-ascii?Q?NJ8By4RytFFTvhZu45e35Kk9ludQa2HKRRcUteX4aI6JmTOplpdSoHOMAOqG?=
 =?us-ascii?Q?mzlnBDEOhkgKiBARI3apEQgQTCPzkMgQ6reGvo18ES592CJdOkjaZ0Vsf3OM?=
 =?us-ascii?Q?vg515pzycIKbK3Ed/46lRRqYwAaZjpRrpfLbGdxKDy3RAkAtqKg5ER40ot2m?=
 =?us-ascii?Q?j7aRS5WXBTRWKAI5KkSugAhfoStVswjWAsbu1GXNYyFtfUuh3VoctaCAMohI?=
 =?us-ascii?Q?IbvTaB3pE7caXPnOoMd5JMjPidm+jB5M25WhK6WkmzILKMY2TvIhAp/p8fHA?=
 =?us-ascii?Q?h/4e6kd9ssh7bvkfwk8X4WEixdboc45Z9qg62wJm09MCCTNW+Jn89hlOjC9j?=
 =?us-ascii?Q?S+r4aUGR6EA9PD3bQBMidZ+JmDQpDYsJr2Q7GEDNndDCO78LbmyCLBNF+Nmx?=
 =?us-ascii?Q?EjBzbg4uTzGVPWsAAL6nQM9Y9bzGWa59CMzRbo8SBkuxN/gkKTyGU1Ksea97?=
 =?us-ascii?Q?dKMR5z9RnwkWevm7qF65K3uqP3Noo5ydRXQ0wgJboRd9FJ7HKev96w8WvRuI?=
 =?us-ascii?Q?tbfYBqCjo6DQ4J4n4Jr4IsXxEl+AJFJ8qPbTLVeshJJrlzTFS/8im3rb0vpu?=
 =?us-ascii?Q?SA5cl1EPCJ8sINXrRgjpfTGtSPykdLMQKBA0OfZR60/5gux82en3oKa2OPjn?=
 =?us-ascii?Q?cHybCHDjIPQsDhY3xOgNC1EG+44RxQOLin+J7GflcIrfntgg8scs8gy8tjzo?=
 =?us-ascii?Q?oCqJaBlx3I/NQBUiLK0qetwwXIjQRYCczKAvG50iWu8WhGc8MzHSFSB6tlzW?=
 =?us-ascii?Q?NWw0zd9YYuPIYxgJE6tOo5jac4+EedKluDgUPhZ6n3ZmH3RtYW1YXyeLfH2O?=
 =?us-ascii?Q?JKM7V7pmCZDKppbTqn/E2sRbuw8sZcssRbNt77vqcsv8oJUWs4EQenXYVqAw?=
 =?us-ascii?Q?3T3Bq7qCwUeXe1zGOHASJ8cP9+XFBXjl7QfWwlujZj1KEgXzr8GIc4Rb11eT?=
 =?us-ascii?Q?ABMZjvo7TX118pVpc6J2mJ6TmnpNj/iTb4iwsJMQnbkHl+D7r8lVbJrV3hVG?=
 =?us-ascii?Q?uaiCF+Q3EtjbtaDbjDu4oH2NGHA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a665266a-6caa-4f74-ecc1-08d9f3fe22fd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:18:28.6757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EghE0egiXi9GuaZqMxYNzfl/7I0+i/DsKtkON/qzc3CAXV11J8wsjA5N2JJV7XYSYy9JfxYZW+RDf963GK01Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6841

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

