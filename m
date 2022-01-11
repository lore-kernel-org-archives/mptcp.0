Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E282C80
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 03:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641871403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=huQxN2c7xkWZhKfFfOEtGeKXZsMd4mUqN+mzEtycHSU=;
	b=QK86/dE0zPiZxYbQ0rB2Xq7l6Sh6eKpXpPGnb9TxRuDAJ0uIrXpz810KldVfIciLnHXy1h
	HqjCQtj05yfQ1jfTpwUQqUYoH7qzsbt7sfaGEWvkrlJxPFNjaQi1qvG5vgISZgLAeiQlFd
	VCk68uvsA21xRgsVx4ApLTU+bt91Pqs=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-LQz0Ys4OO8G8aD2V5r_MKA-1; Tue, 11 Jan 2022 04:23:22 +0100
X-MC-Unique: LQz0Ys4OO8G8aD2V5r_MKA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJQEtnSbrL2C4K4w7FxfDLXX/nP0btUfKHFten0H5PO271kRNFlHKA0xIrIN8lR6eXGAbW35fPl9DdK7bjwmHjibZcwsGODqo0eYWm8z4z/RzCF3YJTIIXirKtSWK1M0hmsRRE1CX89GYpVqkviUklFxnp5oPpYLx/R7LG0sucNe72t0EeNzTLNCvkWF9Hapzdak9vJqJLXXLGiz/i9HgDJ9zBDHFQvxBnwKrH23FdCbtoxW9p7QUkW3h4F7cR8B+xQCDpzr/7eMe5wvZJgKnE1S9NsOsO80QrzbVe0WF5LYE76/9zFdXUxZrmzQ4gIrbs2WmLl8BYiKkSNQyAxlqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s840MDMTCdgkmPCwz19Si/bvdvnVo+Ph186em10ExZ0=;
 b=Vdxe6TCGdSxTqueAmzgrCZQ7vOX/CUepvZnGKxuNxYoz/6Y52R2Gg7q91ncsb5K7u2/EqBJFavMPMeVeaSsGo/naunCwrt3tJF5yXML08+8mXohIx7cFk+iYKMn7ouX1+RNrPcFKiGC5AOjky/X2NBX+3RUDRXPEhzJ1P3NJx4xndvcmTQWzYX6tKJj2w+QM/GtcHUwv3swfuCOWMahvgbzd2H9fgmoeZ4tzvSjPX1+QsyVbs+MK9NXtRG+f7RWXLNu+VmKbNhKVmnwlNNpbhbLDm+ce0qz4ePPdG+yt61d5tQB5g9bmKruorz36vVZwVpkeeT6xNROXen+B92rU1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3337.eurprd04.prod.outlook.com (2603:10a6:7:88::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 03:23:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 03:23:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH iproute2-next v3] mptcp: add id check for deleting address
Date: Tue, 11 Jan 2022 11:23:11 +0800
Message-ID: <b28219d0160643d91d154c1be5c7f9ef6f204f07.1641871277.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 917d6279-992e-4eef-5126-08d9d4b1b75a
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3337:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3337082FD0261248F064F930F8519@HE1PR0402MB3337.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d3+ykVe1IbJvQlwjh6bZmtQcpuEvfP0QNZmAMGp5ieN1vAqw7gqMQk3G2Em9tPYgiLCoRwB7iEL5/hTgPWYVyjqKI6eBn2L3tSSvnM1uoF1r9JQu3RS5C3oZ1+65PPtzX0DX9SZzFL3MMBbhQsHDUo58GLEv3+5d9/+Q8oVbuE4UHMeXah35CVor/iqFdPp0qTf1STgEPAcklPc/mrfX3veowz/KJuxQgZHIeJ6z2pIUDtQRhgVob54VfDgiwt77fZ7uUo2pgGxLuNLHmbcFXXJbw3Jm21poN8k8POBtxLdgWozAzs6t1mKrg2ubFlPcsxywka5x+UxDyUI5oKrwIovdTXszWbP9hXgYDd0e15qOEWDi0N0FCzLxR0/qovBt8SHJ9z+E28Gs9QaRJTMII1DHwwcWH/abgpgk2yM+STttCFvOOzeXe6AhX3g94twLW9dQdxKgGQDUB3Hj/spIF4w+ryUmuUQ6y3G0/Y9AX3Nbj5UxtDoZUWkKJ4D0OFfByXE9/W0a8J03izI/3Bb9LueYfc91kG3FgCyofJXFtiZIDukfUyBjDVutD5Y8yKW+Wk6Uf6Cc33A1CP+4YI43ruXJ9lv4BoEwTz4AOQibLgS71/t/VCnJloZUk/NBHzvXIosw2mxq/0Q4Vzn4uzkor/vPMBxWktTAcjtlaEImnaKoui2PDwE5h+FtKZraoZkf3hNcrc2fpw0etQqBNWcOSw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(8936002)(38100700002)(36756003)(6512007)(4326008)(83380400001)(107886003)(6506007)(6486002)(2616005)(55236004)(5660300002)(6916009)(316002)(66946007)(66556008)(26005)(66476007)(966005)(6666004)(2906002)(8676002)(44832011)(186003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DdYEB5oN71UHZjcPJrdXLKsyOgpUM/S/l2NPY3F/pz/5b4+6YyAAgmtAIDZv?=
 =?us-ascii?Q?iXsllkwujIY1nZ30joSSmKFJ+zysNB6lW1D1SbfCQ+NwBJL/fFuluhO9xCXr?=
 =?us-ascii?Q?+jTvyZt58H0YqSpkqagg5qxccirEZbtvpCRuJ7+t9p9ph5rpMim0SwM61c26?=
 =?us-ascii?Q?0Oc3CisUxdpZTSKqcl5CkJCLUcoZcpl0zfGBqNe2klFzY8hYyIlRWRDwQJpq?=
 =?us-ascii?Q?gK09Q9gCCICoNyjbeUjZXfSXQlZQhdkxeh4Nxylmx2ra3rN1AXS2fzVL+5/n?=
 =?us-ascii?Q?wog46kJUOKyA8MW8QAipOShBQlFmoeQ580QJZfFKNLOZjG/5JQ3Tvi+LSmO1?=
 =?us-ascii?Q?IiWsphYshUyMb1ynvu6RWiyDp5DOoPn6/VJK3psiHyrpxnEGC947aw5BmstM?=
 =?us-ascii?Q?/DKKYybOWE1+86O/AC6mn+wA0dtf6DGaZBiUbTNgyGwcrLH1nQjW4y9rmEB9?=
 =?us-ascii?Q?+TxdEAGS+M4biwPpWP5MmHH4j9BMsxShf2Vm+85yeqWgAVJmh/7SCquyHBo5?=
 =?us-ascii?Q?/Qm/a9yLQ/8Rmc3FhudvgFBLgiU/5tt53DtAtybLlE6IsU+CTzXmpaQNZEAk?=
 =?us-ascii?Q?Jlsq/N/06xAOz0mJ37BSBw0T//uQc3Bw4AB7P69P1HahQ33rDLBJRiVJGxK2?=
 =?us-ascii?Q?AA+f+EzUnfD5xNm8DAZsTC3JVeEmOsH9JwxlS6ZuuHkOUW43xutroldiix1j?=
 =?us-ascii?Q?0IFDrLKB4onKmvrIoa5v9h23ShGRayHPqGUXlejPMWo9QibgQGEoQeGC2Kou?=
 =?us-ascii?Q?UAMb+xZt3gVZonHOH0cEF8Pe3AN1+jq1c3tJpia7XcenBkV6MBwR0Zm+cEH3?=
 =?us-ascii?Q?MyH0f5r0bY0E8s4hfzbC4iPA0YSYrsilxcPSbmXnufKbouCG4tFDtOuDRkJj?=
 =?us-ascii?Q?Vyq3DjKU6ZwB+zfX0DVpjQKZXhoXZXSiho1afdcAbiATdIWpKEY6dwsSGa9c?=
 =?us-ascii?Q?Loo8Haw1stxy9RRAj0V9YQcHnQl3BLvmk3nCvz2L8YVlP4BPvK0ZM87bmpa4?=
 =?us-ascii?Q?N4+HeG6krxMGF4z4sCbur7cA7kJjmemnJvGkBFvt3Dl32/Qcl8Fc6wmPcPCg?=
 =?us-ascii?Q?58/2CrCuhZ27si9r+SolNEu03mGK6ZGa/XOqpUtg+Z5XIafs/OEjr7xZra6f?=
 =?us-ascii?Q?gnhTo61yf2vzwC9+kaWJIO7fp/7GTEm8cvZHvFF8YjWdUMqZBF5HC5j/N/OV?=
 =?us-ascii?Q?3LXTI+GKI2Gk7ld++WI0/C/URmNvCJU3Aa3/RHhRBaASMlr9pwhZ6+wmDcAq?=
 =?us-ascii?Q?tJ9MbV1jGF/2/igA6wMp2yn2RHEp93YIAk6SYaxGqN2TxTyCTAWU1oIzEA3h?=
 =?us-ascii?Q?agmb5UUTRuvtlkV4Dnu3b1hHn8NIOIkj50pWz4kebZKZ8rZ8v56ZyQTlgCaB?=
 =?us-ascii?Q?4gA8H7JrrNaoqi+xeLfYqzIrfCDUOX1xhyoTHOhnUBTzlqXkhzjQdxhYwXDi?=
 =?us-ascii?Q?eaE/AlLBSazQ9geEZK5yUtpnhEGLcsXI+5YJDLaHR39xRUR2uF9aAcaZo16G?=
 =?us-ascii?Q?DRpStIJItUg4FUonFiKACP4FTZcmGKlB16FjUeJVzXIlQfXxXRHxhfCf5sBl?=
 =?us-ascii?Q?z5NI4aD7zHjYNyp68vGaSXKpU2OCR7A+JSu0JbqtWmrAmAYjr8T8kRRdgSsP?=
 =?us-ascii?Q?30eXD+FOssxCxl1KrCaP7Zo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917d6279-992e-4eef-5126-08d9d4b1b75a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 03:23:20.2428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5F6a4MzRohjQ1EVyxXura/E2zp3TzXBJD2STJuMvCbz+cbxkKDDf8tDMZ7OCXPUrdeTqJtfFKQL+C3anvPVlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3337

This patch added the id check for deleting address in mptcp_parse_opt().
The ADDRESS argument is invalid for the non-zero id address, only needed
for the id 0 address.

 # ip mptcp endpoint delete id 1
 # ip mptcp endpoint delete id 0 10.0.1.1

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/171
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 v3:
 - update ip-mptcp.8

 v2:
 - rebase for iproute2-next.git
 - drop patch 2 & 3 in v1.
 - change ip-mptcp.8 too.
---
 ip/ipmptcp.c        | 11 +++++++++--
 man/man8/ip-mptcp.8 | 16 +++++++++++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 10dcb1ea..f85c49a8 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -24,7 +24,7 @@ static void usage(void)
 	fprintf(stderr,
 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
 		"				      [ port NR ] [ FLAG-LIST ]\n"
-		"	ip mptcp endpoint delete id ID\n"
+		"	ip mptcp endpoint delete id ID [ ADDRESS ]\n"
 		"	ip mptcp endpoint change id ID [ backup | nobackup ]\n"
 		"	ip mptcp endpoint show [ id ID ]\n"
 		"	ip mptcp endpoint flush\n"
@@ -103,6 +103,7 @@ static int get_flags(const char *arg, __u32 *flags)
 static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int =
cmd)
 {
 	bool adding =3D cmd =3D=3D MPTCP_PM_CMD_ADD_ADDR;
+	bool deling =3D cmd =3D=3D MPTCP_PM_CMD_DEL_ADDR;
 	struct rtattr *attr_addr;
 	bool addr_set =3D false;
 	inet_prefix address;
@@ -156,8 +157,14 @@ static int mptcp_parse_opt(int argc, char **argv, stru=
ct nlmsghdr *n, int cmd)
 	if (!addr_set && adding)
 		missarg("ADDRESS");
=20
-	if (!id_set && !adding)
+	if (!id_set && deling)
 		missarg("ID");
+	else if (id_set && deling) {
+		if (id && addr_set)
+			invarg("invalid for non-zero id address\n", "ADDRESS");
+		else if (!id && !addr_set)
+			invarg("address is needed for deleting id 0 address\n", "ID");
+	}
=20
 	if (port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 		invarg("flags must have signal when using port", "port");
diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 0e6e1532..0e789225 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -31,8 +31,11 @@ ip-mptcp \- MPTCP path manager configuration
 .RB "] "
=20
 .ti -8
-.BR "ip mptcp endpoint del id "
+.BR "ip mptcp endpoint delete id "
 .I ID
+.RB "[ "
+.I IFADDR
+.RB "] "
=20
 .ti -8
 .BR "ip mptcp endpoint change id "
@@ -107,6 +110,16 @@ ip mptcp endpoint show	get existing MPTCP endpoint
 ip mptcp endpoint flush	flush all existing MPTCP endpoints
 .TE
=20
+.TP
+.IR IFADDR
+An IPv4 or IPv6 address. When used with the
+.B delete id
+operation, an
+.B IFADDR
+is only included when the
+.B ID
+is 0.
+
 .TP
 .IR PORT
 When a port number is specified, incoming MPTCP subflows for already
@@ -114,6 +127,7 @@ established MPTCP sockets will be accepted on the speci=
fied port, regardless
 the original listener port accepting the first MPTCP subflow and/or
 this peer being actually on the client side.
=20
+.TP
 .IR ID
 is a unique numeric identifier for the given endpoint
=20
--=20
2.31.1

