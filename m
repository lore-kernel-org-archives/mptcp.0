Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D60357D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtSIU3UEFkw6SEidnBvb4J8P1OHSFYsyRu+UcNqB2wk=;
	b=fs3uZFQouyWwPzbdRLp4fBfw1Iynr9V2oSj5DdyXFutXIjXbXKRhrfx/8b/cJ1qJ4DdcAV
	0GdqGQOzoz00CbOrC1cO/nDoUaoGI8JN6KMqurSBvogIl7WjDS5t+agViULdt0wUIUFUbh
	Zqa0t0gCiRqJW9BnkfcxoWmiyYvnal8=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-YFOqupAOOqyNrlDbukAlDQ-1; Sun, 20 Feb 2022 00:21:08 +0100
X-MC-Unique: YFOqupAOOqyNrlDbukAlDQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDnMJrosxtYGw2NQJwoWhyZIx8YqBAeTrBGOZFhMBfeE4OSUT680rxkaV0vwW23hpz2Uo9PrLMMVBCh6+1hp0RM+rSLSzUMLbcb8d2732IhmohZo5axINf72Kn5e9GKyxzRsyLCXvgb+USF9Hv+o+LGWw571C9jEWc/gesP/VafGU1hKCB34doSTbx7PaIL0+1Cekj8xyOOvJibpw7qnuTMy3CIHz14vSI+3TZw60DlEovBDzQ9hnG1zr3v+QbnML/vpZgRc334yys0yV4Alk+YOk59bU+kRWRPnyrq1mb1dgE3To/XfPkKqlZwbxtELMYZb6qXwi+FSM9p+mE3Ntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vE+utjFsFCiqq8qjTOQR0uoEev0X4nb9y+t6wfEfbIY=;
 b=P+ADkGfL4OIEKlCAhq+M1Us+9tAqv2ZOUjm7i9QAD+cBQMWmVIHuDFF8DivRj9wjQINGBghmvg8DMALA8hldU/bKFpd+cnhQlNTSc0jIVcqJpUFDO21e2r3SaB2CHheZxrgA5kXOxnXn+G7BBf1os+w6zqUYJnK8nwaQ5b15Tyeb9tD85VZ2rlA+0fGQLZj09MwE7MZSix7khtBhwwX8TbW9AOZIs8vZTKlT0Q4QtJeNmLDGzWHtts3FiN/FD/FIPbsFftx7Xrjor2/EOQr+aNYgf3k/z2paocGp6ZfFcSZNnbykifjNevumWa65H6H6Riewfspd4qaI7ukIfUXf9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6841.eurprd04.prod.outlook.com (2603:10a6:10:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.25; Sat, 19 Feb
 2022 23:21:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:21:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next 11/19] mptcp: add the mibs for MP_RST
Date: Sun, 20 Feb 2022 07:21:26 +0800
Message-ID: <0ce1a8517b11b594b0561858ad2c8c2d940d1898.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645311956.git.geliang.tang@suse.com>
References: <cover.1645311956.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:202:16::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60b1b9fa-9f21-43e9-4160-08d9f3fe819b
X-MS-TrafficTypeDiagnostic: DB8PR04MB6841:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB68418D244254694C77023231F8389@DB8PR04MB6841.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d/c27oZRKQX6UYsEyHjJe3MkI0vnmtycnKd/7rbuzLHURk3s6NPfoUUnMzHMPuPDkrZcr1SMsDojWKiADVtpcjFWNLh6Jw4pU0q20/R5QGvD7uwGMDubn21jYkvJHfpURccmVnYfOfwihargNzOWr04shhyLOwBpnszCKben/OhN3XkDdnFRb3T8MojwPPsVaonFcmjvXXOCNszknDa7YLYJd/EFr+d1kO+V8esgBjXist+6zCTh4hJ8zzGtv0uwQrqtRObp6TZj/hc5bufyKZlphnGG1reLuYnWsB2+5DKZA1E909FGYTf95GYzCwjDRKbLUhWREmZAEYVDH2hWXxatfRD0jxqn/vbty5yiBLnpkJANAekwBwduu/7GDPCulUGTnRklrnGqrb+AXRwRx2yaQyA1jLcy9CeZqAuGZf6NIY5JA+ltR7ku2YOmWZ6tB7gNdbpF4phAOk/FbrVBiMBucvp+7QOr7vn/wyLhJnrh7Bd8DwZWZqmSQ9RQbv+X0FwM386n+9uZbF2H2D5n9VZmhMvkDL5gU3ArIP0Fab1OVxYmNpn9dIy6o16G/6YHpsPLANmirHrhGATxouvxQjUJ9N3EEYnwqHH53fRnjHIJu9mTgHwOIG1eiD3DVR/L2Dhw+vt1VzpWZ1P6JwiOIA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6512007)(54906003)(6916009)(38100700002)(8936002)(86362001)(2616005)(36756003)(6506007)(2906002)(508600001)(83380400001)(5660300002)(6666004)(66946007)(316002)(44832011)(6486002)(4326008)(66556008)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IVKkF/6ZPen3HW5fA6yps1AcBdBaJuF6OmJhttWYVoH+nv8iackkpn7EKH07?=
 =?us-ascii?Q?SU9YKyMvJFWFhsBLybS59WgUO0SC0enI2GslUTu5klI+uYnaTMG4yZIO3+jq?=
 =?us-ascii?Q?QdaIdQenUkJdl/arNlmzVcSZzf801uSFBNC8nmZ3oCbguuy5jKjTvTPIKCk+?=
 =?us-ascii?Q?O5+BpnQ4nisp6eH3W6uNtkWKx/3IKrWq5gexgn7XWHklAcVr8pBz7ihEDfh/?=
 =?us-ascii?Q?+FcTCNAiBfAyVy7Zo/yawVcIujH7R0yqAT9r4qnhpuEPvFImZTlExdNXgXeU?=
 =?us-ascii?Q?sn05LaKnpd11X98Ioi4XV3xXqH/xPsCKzJPt3b4K8h58ZTRKDsYC/G++c2C/?=
 =?us-ascii?Q?1/10Bzu5PLbPb3HnihBgm+B0Mm9DxzcSy9rK0sjJTY83gnJ7hQHT8zgXGh1U?=
 =?us-ascii?Q?W7MypmzAqgXO4Vi2+jnp9g99mQl9DHTZZS4KcV+4yHBJEkpHpRgNzkDlz1rU?=
 =?us-ascii?Q?2pAaDsa8evzhn83DPw6MgnFApaDz5kMTFtN2cIhlUqJMqC4rIEwQmlm7dXtc?=
 =?us-ascii?Q?ExxIq4fM4bbK6XhHSyIFqfpHlyJ2tNNojQoz5GCGyJdARcSSMgYYZgdy1a03?=
 =?us-ascii?Q?CaiMJjzirIqQtzeZ50LFb2/GwlgwRFIETPUjO8p4ALedRKkCKQF4CeZd02ad?=
 =?us-ascii?Q?egyfCUM6wr0+P+bvVWRXc7yxBUXDttT7iyBncs0FRhzYdn3In6xG7pzEWdoW?=
 =?us-ascii?Q?PReGS+KxtUcE8WCqMccX4UiTie0vIfCCrBltrJ2GNfkA5A38PfGLT/P+j9cM?=
 =?us-ascii?Q?RBw1a1vwPDiVcuPqy/LnmSYUD5v6pgD3UXtW7BE+dt+oTIoFkbDZmzx9vd26?=
 =?us-ascii?Q?d4quXgxejaiEhnXDbbCQjLd6mka/s5oReUOfYMmQnn6/g4ePAQ55QAy0IYvN?=
 =?us-ascii?Q?vS24odL5+5ao9PYjTLg8qtU7p2AgKPDa3TBEiIiplL2eAhZAcI4z70GSeR4j?=
 =?us-ascii?Q?8DYaYJwi/FfOqAfkmur2pOpu0JymYG+jz5fMB2MCTlffHG3jx14fCId3ILVv?=
 =?us-ascii?Q?PFpdmxJTxAWAEwgsEMXhtzfV7P9bHtIvNjNcYX6OLjnHdie7yg3TQLLDbHhx?=
 =?us-ascii?Q?qiZXylOVwZTSIAlfpMv3dzx46U/4zUjTnuExznEb6w3TDCvtDQUkUFiWH1AT?=
 =?us-ascii?Q?2UWTZwXNdQSzp1ad9BYrJPVD29vOCQjngULn7pF7alIJD3qKrKXr4hJDJ9uk?=
 =?us-ascii?Q?rZIWtj/9Fm263+DjgGSnqq2A0PEBFfCHPoIu+Q6kPJIj6YKYtdjrXWAdMvyo?=
 =?us-ascii?Q?IFGToTM51AZ5Kqvl49r1xzX1+pksbJ0wpRawJOTrOngVtWHtoqMDHBIZJn4e?=
 =?us-ascii?Q?xgqdttEcllWze868JuCIPwQfagX9HtVa6/l21ZiopNbieY559j8FaKwZ7PMm?=
 =?us-ascii?Q?XmURE4jgv2vQLE93rz8y5+wvTwXAUHdv/BhPol7MKOlF2gbLuPQIxaGtT5/z?=
 =?us-ascii?Q?COHYpWje44kD25V73mcGjG4kIoxIwSnCbt/zZPQxxbNFqn9uLUQdQhlSgpt/?=
 =?us-ascii?Q?sQ6tpIvjtiXFMrfQGQBDY9eRLiNHAcsL+HHo0OEzLF5ChLZyAIDApdyyeF3M?=
 =?us-ascii?Q?Z9aaJ7DUIg4T5+a1k088tua7UckTvAko4kXC5KXucrAFWMA1LDPKKTUdJqIr?=
 =?us-ascii?Q?w+kxYDw9HaxSHokANEy+haKbJXISaD5eGdDIzWuxDN1mbywu4Md8X3VFu/Jj?=
 =?us-ascii?Q?08mNTh2SNgRa7zX9RtVgOhlNPfs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b1b9fa-9f21-43e9-4160-08d9f3fe819b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:21:07.2095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTDMsMJMF1tN29c+CWFX4a+evtdbHxt9aOdWx6mV74k/JwEylfJjA4EW1jraRo/swn/lGpQGUfyqoJB1fQfPkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6841

This patch added two more mibs for MP_RST, MPTCP_MIB_MPRSTTX for
the MP_RST sending and MPTCP_MIB_MPRSTRX for the MP_RST receiving.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
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

