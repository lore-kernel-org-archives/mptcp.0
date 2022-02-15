Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDF01388
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 11:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644923533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8KpuZVpzF+bAAVys0+PZ/IwynSD0zwCWsUrjCOfjL2U=;
	b=Sio542b08DfmFGAzLPLvWBgjIWYx3l7/W0ZR2ryD4DOD0b0qxv94mROkmNYCnOQiwQISf6
	QgOeCqPnHGffgYxG+aRQQEBNZ8l44gSXCr/TuC2q0rxpQighAt6+RHhzEnv02XUJTXIbWa
	65GXwiEeMve2NwIKBcA6NyBTclm3buA=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-QdHwNk0XNvinMnPKaAKvpA-1; Tue, 15 Feb 2022 12:12:12 +0100
X-MC-Unique: QdHwNk0XNvinMnPKaAKvpA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFlBEFjaQbnH3ppGwFvrBrApxAWmjgyBSrYxxtkfKXIhPAQ9jOTSbGwiKLF2pBt5Y/Sjt4jc2f8w5UBQZZuUN+MFuGlpfs9jp1FFZ/7ER4pJs9fGnP0hzz3/kedrCXG2JjSfsfX6JaXUDHFmghL/gWpK3WDNELa8YMv7QJYOAYm7Z/dx1w8PESaaeLU6ebe3rWog+5+vb2P31MOYY1P/Fw4yZnfZBWF6ZEiqDOzuDWWObXujdsxA12MAtJygbuDyQE+2qNnS7fxOe3neqtQEdXkz+kw0SFlOqrDR2Datjp3DYKbI4GHzS4xc21FFxPzTsou8/qNfWYH4CGVcRPURkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlLFFyvqyQbeuKuGk+tzDgmSBzLiDDaUb/+MsZzTQrw=;
 b=EDxkWLYF/rbkmHvgKByq5A36WXK2n6IjWQFnFeYtV6Orxj9nSeYyEHc+7U9bYJMBwvckHmk/ZKIsjlwekfe3PKab6TMyd1nUIk+5RsH4j/wxjxVmllcpNFS+Stio3JZjxpH9Rpa5J4JDVrBgml6rrYQsMYLHe3jQ95YcppjXxh+rM8lOa/E8F0aY057ZNUZPKcUUlvBR1H+I/UwhfUzffQDYnqYMeVUHFxEss9Q1dCxbcJvS+MTuMSadUobBqbrh9xdLGwjU303zsp3yRxdaVMs8ecREmAR+9m+EO0dfbDUZ4KbKl22gH11m1dCg3wICYEbamxl7l4q/owLfZwsbWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2921.eurprd04.prod.outlook.com (2603:10a6:3:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 11:12:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 11:12:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/7] mptcp: add the mibs for MP_FASTCLOSE
Date: Tue, 15 Feb 2022 19:12:17 +0800
Message-ID: <a854ead2766ebbb8837df5d127044636e6311715.1644923074.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644923074.git.geliang.tang@suse.com>
References: <cover.1644923074.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0186.apcprd02.prod.outlook.com
 (2603:1096:201:21::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06d14805-7bd8-45e3-82a4-08d9f0740286
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2921:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB2921630126F0172936BD1FA4F8349@HE1PR0402MB2921.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	urCCm/TJiPYtYqjblqrCmOqdEADaLXqEjMVyEsCDiGJVSyDGbiTL1ngSayEVEReKN6UAcpMd+tlRpRMp7HR2+40TKEX+CTVu3PvgHzvxTmIFA/BevZsIxno7r3o78s07ollI0QvHaNkwbW530Epx3LTXSTdnD6BoU+mCPwBZpq1hmwBxdqdzDBzrjLQlaEzNjUu2cD/c4UfEA3dwLLjHHwAwfkWPuHPQfiTjoEWVyDS5oWlRby9ylOShvFff6Jflr1u9xwWgP67xGwK6/nF7i20mHPCGz3iU9O1FMnFMQ1w8hs8yF57lbVDPHvVX1GAomLIWms2w56Pzx0trEYBr3xQtDVfXjQur2eDnJ9pFPDOTUTFQ7D4Zr7g0cpOF4q1eP8yT8pDyhdhfmfUq8LnspxEFzZZJUPNjTwBSVwnyCz3dlrY1Vgk3iVhJvhTgbPO1RYxbRBIbeiE9ASI1sJiB6KaCzUsZnRRcgnTRGrCYBlkVTXP+KYKoQ+/E0xfDPEHblXE9E4O/wsGAlb6cH+2Iz8a/hjOUFRwX2lZg2WX29DEPrJknxfq+dQ3t2pXrb8/6hDh/wU9BbLzYDMCpwbJIUGi+6gSSBHV3WDvVCEaIPrk0WfN84vDH9cdzeEg05XopCw1bQqYkao7aQzM/4BIwtw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(86362001)(38100700002)(5660300002)(55236004)(8936002)(8676002)(66476007)(66556008)(66946007)(508600001)(6506007)(6512007)(316002)(6486002)(36756003)(83380400001)(44832011)(2616005)(107886003)(6916009)(4326008)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f3PGBiZZdhRJ3mQ85jEBnBXZS73dPR4QDZnpBIoQvXS+nA3WBW23fZmwqNlx?=
 =?us-ascii?Q?OZ0vPu/ScXVrIWtj1ECpEDIBBSue7B/Eb+q51Yd+RT3gSpZ82KFT1GGODStN?=
 =?us-ascii?Q?+pUZeCpcdX4Ix007pq/F+5+cto2bI1xVqueyBYaGlo6ZOro4h/kJI3u4Fbb4?=
 =?us-ascii?Q?nfvEM+9LFBhjyKUPaZNG+hCoxIzlGpa4U/uJHM12jVIOXIp99hMgyyC1jaCn?=
 =?us-ascii?Q?eL57SGSZOh9wYtIKzC06LnZZaHhxxZ0w5jq3DIxjRyB1LFUmV0XTxDNpRdZa?=
 =?us-ascii?Q?EL6rodDqb3dC9SMvjVQxVIW7eK7TjjSDHzKyNMmHP+Su8HIa30NMmMd7oA8Q?=
 =?us-ascii?Q?LFVYG8Os9qNmxA/zMHzypZhE2sFb0jjPJ+pn8NnPqpfNitD3RSfIDJlrPOwj?=
 =?us-ascii?Q?n6ClUfN4pc7KXHwDVPM/FY6Vfc3lMmIf7K2yjkrlDvB3vVNXfAyvop4Bmu/q?=
 =?us-ascii?Q?KSIoRAYzvCXKrDePioNtmwYvW2XKe7h4rCskM/HtqOovIYEHcq/W+pRB1XEM?=
 =?us-ascii?Q?jieAuxgDXCGf/1Mm5+oY0qvNEc3FIRHSA9JJCL5nLYR00CtdwCXp9Ujal3uz?=
 =?us-ascii?Q?RG8gNL2o25uaJ7ngwEsPus9FuQO8vc2qlCDVdNLvGnz3NbjthgHTI7ItQre8?=
 =?us-ascii?Q?C3hqnCW6+QztdO3LFzAoG9nCKtn1ooFdDEQwCc1m6LxY171Ec4KGii1OkxJe?=
 =?us-ascii?Q?Xyh07QnW5DyCn6Vwm9NKL2pys13ZEb+yoGwMVHj2dGni9ZftGZSYw8qi9qhT?=
 =?us-ascii?Q?wME1bULlXYGafeXN+pYZGMFREVcbEN9J5dHp+apL46kkQX8WLQ3FtUveeCvP?=
 =?us-ascii?Q?RBf/wVwh72uDRG76wXaYnsk2lGOfbYKdKDxP15RuoDkkK46YlO7hTGU+lyQB?=
 =?us-ascii?Q?OBK5Vh8Uv+uyQ1sjt5QUOskYmQsBJmXbsZxL4VbAF+fMVlTsL2Nm756NsgiJ?=
 =?us-ascii?Q?uXz1KR1PXqEp2dUjnNcOPQ/Ck7aFHsv+d/D/U2eDI+j7x0KCaIcgQ48xqudX?=
 =?us-ascii?Q?KCZ10rZitDc4OB5K7Mcr/QNWyD5tT5omYcWsPcyhEOElCPmB1NVbU3glQUDY?=
 =?us-ascii?Q?KgDsATQ7lzL94ZgoXM07qIMHOAfzB0Ach4NFsyc8iKWseTaKuH1eCD8zrRr7?=
 =?us-ascii?Q?EYhfgGjC8lxG+H90GoRCY5/xHG5gdA9nkFR3+d6lCfBUzakDD0sOUx9TdujO?=
 =?us-ascii?Q?jOj2jTZY1n++QQBsyYL1v9a5/hsihXwVcz4fsmIfuwQSjDA+f5mrLF83GL5c?=
 =?us-ascii?Q?k2xo6dWBfQdTLxjCH/EWBJgh4hOkWYyIeKYXbGN5ccjJNJoenuIleMMge7eu?=
 =?us-ascii?Q?LvYjIW3nrcyJWPH+qQqqDk1h4BHJK8WbeesCDvKnG3nVvklOp7quxbunmVV+?=
 =?us-ascii?Q?8v3eC7uFRIbGovHDjxNo0m4gmuaDXo3sjaEkncpwNR3d3EEcOqNpBmOen1yM?=
 =?us-ascii?Q?RAjK5jp2Z/czbLDhL/auCF1KWKFW3kOdtv94y7R04GccdaMFz9qGwvj4UQih?=
 =?us-ascii?Q?I0gftonIbVQsDjDfNtzI/Jwxxa5EN2tRi/Z/SojfRHwbVqlk2fMqY6hPw9V7?=
 =?us-ascii?Q?He0q0eOc/0mZOgpME/MaTlyBUbVa45HjFSthjHw+eT1SmB2HomlYftA4+egS?=
 =?us-ascii?Q?K/aluQLkrzfujykFa/7ru70=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d14805-7bd8-45e3-82a4-08d9f0740286
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:12:09.9815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1asyH8nhlHWK2o98x0ws1qDm/rOY9v/PL5jWkFT+761TpD+NG/bKlhjcOdNkkcFyxQTUqB8tSJeR/b6p0ZAP7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2921

This patch added two more mibs for MP_FASTCLOSE, MPTCP_MIB_MPFASTCLOSETX
for the MP_FASTCLOSE sending and MPTCP_MIB_MPFASTCLOSERX for receiving.

Also added a debug log for MP_FASTCLOSE receiving, printed out the recv_key
of MP_FASTCLOSE in mptcp_parse_option to show that MP_RST is received.

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

