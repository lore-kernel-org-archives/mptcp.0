Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21272C9E
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 16:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651507568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cl3ygICShnfjW29KIvjj4zZks3vdVZFKV2COtQb49gI=;
	b=cQC4LTyysbr6Y+U21whKO354cKMh3VVU/n/Y4YD3f7mKK/h1Q4kCySiA7pEUUxXNswds4A
	VAokdjvpyecQmUTB/BvfZXuc5YOcSieNEg9cOEvSNhq7YnxOWfcI9dn/eNqFI1v6edj2Om
	czt9eP4zxb2fE24alV4jHDGsyun1ors=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-LjQGET54M2CcBlcgbNr1Xw-1; Mon, 02 May 2022 18:06:07 +0200
X-MC-Unique: LjQGET54M2CcBlcgbNr1Xw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVJSq9j3onI480hbMO6meBHwtMbGVN2RD7U6aoW9+0anHLtt/oVvfe9MwKLXJdYtvyjKGK2A0OezoCx7JygMKPJFYn/MicJ9B8pcLqUTc4bTvSv02qAnenRlZfsOOMNcqIFE30Evd0gJxPWehXz91WYGh2qlmKmDiboFp7CW4N1Ff0nHq+i7jjVovxMJgwyMMYP7ErkNZQgecA9sCzgDF9I4gEnSIl/wHPDNA4BBXyreq4ltGXp+sLUvJ/4ZCJNrTZjqn1CfJs1mmx2KcxV6FRDje2M1E7tTQAEKMd80ch/nBvTvxXuU5UdQnz4k3XOFBKVNQjgN9svzr9fDcHHArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9khtQObONY/3oAz4uKrNPwtxl9P/e4GJPWPA1SYQnco=;
 b=eyaygXN0vD+TdYbmr4jhs8jXh1kSakGpDOWOZSgp1B2uru3B5Ru2w4eUymRvKG2zEbKTj8vivBdUycAdR5UCI8f/JNN38j39AEjbGB3Pg69gg1MlxKeARLqWSLhauUJ2/BWYV8AaiPDbuNL5QY1PmGVR1xYVWgh6IeMARnAKxoe3ejxm0kUsgH3Gk81auOxdeR2sRLgCciboygsMLUMBalXQUDMYMYnAX/qBzaTGb482n20K7hYxWP5Bn5hmOAA6NwHqZCUxNzLeLYi4r1xMjE9eO6+OkjHn06OMZGPg/tt+JNsWORcO39Uh7wNe9nIYuNpLLoWPARYnoSOZcCTavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB9269.eurprd04.prod.outlook.com (2603:10a6:102:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Mon, 2 May
 2022 16:06:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 16:06:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: add bpf_mptcp_sched_ops v18"
Date: Tue,  3 May 2022 00:05:51 +0800
Message-ID: <73c235f6266ba565285c39f4fddc5ad3bc4bbd07.1651507531.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46a07a93-e9e4-493d-d04b-08da2c55a994
X-MS-TrafficTypeDiagnostic: PA4PR04MB9269:EE_
X-Microsoft-Antispam-PRVS:
	<PA4PR04MB9269D8A7251A3AAF1F7B19A7F8C19@PA4PR04MB9269.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WJlpXFQ5tCosPl3eKDEzVOMCbN8NAVJdWxb7ceKRNMfhPXdcxRKmNnQca9XSjHm4+HBY+1iIcGXOGdaRmLw2JDmvrlobM25qlXoac7aJCrGGHhXwtvMQObXukiyEKZi0jSrpWLPl6aI9Lcx0LzKuEnhIr2MdFb8zwaLu9nVulx1vnwM7tuqIjlYk26hoG5t2xj2RS4Qx5UPd4ty8X2HgaSc96gVQi+nZLP8COc7vKY8vEcmjMEAVa6W7UBaVGBleZY771dt2139EOTqPPkLjHbB33bqD0obE1FIjpEo/RTvAeCKJW5HuqejA8v/pGFIdL1gPON+LRAyB+iQYheK5PPTaq+oK1hFRd0E+306N974jL6R2tp+YP4jGDIpTokXU2Ng2nvvCnZNiUWG8A8rR4BJ5r4E03y3FIQJ8KFjVicg1OBoRmS9fHyB5QR6cig5YedspgB4PcHbA+cZ8qVlohkW3OXs6IoA2bdmJB1b2kQCAMhigvnGLZwSqG70RWGhNpaRLUr+NItDItbWbWZ7EWRt5D7gKfPVA1b9AWP6uaddv/2COZ2hz0Jbsbih/6caFxKhBcODouXtmTs9jls4cWNiS9/kaI7XDBdNVq/ay2PWtiS1OafY3Bd8LTQMmBXsCg6iDQXlJVJjvqxXxyWiIf4h2JLZRnzC/Nm97rUgzRMT3Hy9bOxTl1IetqKk3Wqzf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(316002)(38100700002)(6486002)(44832011)(4744005)(5660300002)(8936002)(86362001)(66476007)(66556008)(66946007)(4326008)(107886003)(8676002)(186003)(2616005)(508600001)(83380400001)(6512007)(26005)(6506007)(6666004)(36756003)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+kE6xSiMJEqdY55EI/3vGszx/wi5vBDJlP71lfQo9+2MPJzU3bMSiWyr2VFi?=
 =?us-ascii?Q?K6PiNgG1JSwUo0tUIE0FPmEVZtBKld0k9RTnAGo4Gs+53Pj0n/5e3BDbhRiZ?=
 =?us-ascii?Q?fOWWi6vVCt+I4BRTaZh1lDePz7s78N4oG/9EmmVi8VUg86jl8Tj40COXqXbY?=
 =?us-ascii?Q?kpcPbs/9oKO8xWho6Iuhd4WI6amyz1zl7hlRF9m4lwrb6Nbf88ADKyynMTKR?=
 =?us-ascii?Q?tQSwzPh3GgIcnzHylop/uV9gPsEErsKXhT5arhSDOIu+NXdR1BCqcoT3cRxm?=
 =?us-ascii?Q?RBF5U/+GfSPFAfx8mKL7RNRV1DL41IKZC4Pam7xN3rsVCJ+en3EDHLqjDsAq?=
 =?us-ascii?Q?V2lqfdWNUYcUmMppeRQJCISxLhByuyteDRxFX2Z1QwLk23YhkpNJU1BF18zr?=
 =?us-ascii?Q?+jCgpt2Xz2UBm7hKR5bqZj24e68PEWtVp8Z++EkFQ+1XI86WjCtGTWg+mmeB?=
 =?us-ascii?Q?SMv2GHW5yep3+bBkqKMPV6l06DKXx35fqNB17KZOhjBXyjdLIgnLSC77ZRp2?=
 =?us-ascii?Q?mHpjwMm3cp9TqOCN8cphhZimh7RBy+ZIqrl7pEtikKhEbT3+jHFBYRXEv556?=
 =?us-ascii?Q?ANxRyohmFG3cSTGBi4yKoBKkish2OMCdRQ5oOLgygDtV/n7CTmC63nMkne7h?=
 =?us-ascii?Q?5i4cECxMVU7M6wtZMYTwyik8g1gXf8ecUH+zsvPWOnvWC+e8qcarKR5OAhfH?=
 =?us-ascii?Q?Jva2mZr6nViRC0eq9kZ7Ro64f/c7OJcITzQOAs+4p20PrUrcegHBPzQ/svMN?=
 =?us-ascii?Q?Kfs77Qr3KbrwXh9v6HO3DHC17HQcXIMkmvtVvsZ0YiBbNOkYafTqkoHWC+BZ?=
 =?us-ascii?Q?UqDtbPRn2IwKaKiY9BvI+EdaBn1AjFhgpeQx0/r7Xk7V4df9RkevvGcd9n1d?=
 =?us-ascii?Q?WR5DZIHqZOGW6pb37h7+ce2BG/u+49bMGsXNq0IzWNG4NwQHul+fJdaHqsH8?=
 =?us-ascii?Q?4bffX5jBzEg0fj1pV6IDfgF51osBXdsGHjlJqGwEKRM+J2XlOvpRTzYluc/M?=
 =?us-ascii?Q?aR7IVmftewjJvzbQZB3tf8tEym+b80sZuerPR7ZLTNgqDiB9XnK/+7FZHLdI?=
 =?us-ascii?Q?JkXbjP1gc1Wr3yg679vVj92KtOxNTjlghZK/kTXNFhjQ5LLZ9gkvulQ0nA0E?=
 =?us-ascii?Q?/CRGxB3QO7YOSl39poGnM9cCi/hmOYqN/PfIvzvE8R/L+eCQJcWRn1mJ2WcP?=
 =?us-ascii?Q?Q8o8JZWlnpw9y8UUx3EHjp23M5F2wWO29ybgki8jpiI8XIgWOZ6gujVCTvMA?=
 =?us-ascii?Q?kyTivHoFPpPW1J5kQn0S2RbErZLyKM53XGv3oCMC/38+DF8S+bsHVEAvM2WA?=
 =?us-ascii?Q?BrttERB6OafDXgfPY/L6BoL+P0wmNqwq6GOG86CStIlyDUkz58mvFZChXKYb?=
 =?us-ascii?Q?K2VT6CjUqdb/6IJkEbglT+Q6OBrcVGP1mQrT5O1suBUPuJWY843ETBxw55b/?=
 =?us-ascii?Q?IvEzkhU85k7RM/yJmbvUbPf5JlN2BCxCyQgwK9m+EnPLyzGPtUzQaODt69Ng?=
 =?us-ascii?Q?Ba7t4ETQnXzH9g28T0ezcWSh7wDFSoBMTcLy0op4qrFttL7TY8pnfd3iblG9?=
 =?us-ascii?Q?XWJ/VQ2/OcEtpkexOtRemJdtzbNwbZHX9zGpEMBuQPTBV0wjzgHJv2cyVPZf?=
 =?us-ascii?Q?Bu8vEDlEYPjbWs29htouoyrzGqMmLaosR1f0ax/lQG/U73wNIRsWpyT7Q2XZ?=
 =?us-ascii?Q?Ecb6fYPCVSSzCg1IwkkET7dnEmz9yX8blLatKEsbO/BieAfgPl9pAxCjPysv?=
 =?us-ascii?Q?hLP8T9RH4WMeSJB7eivljYFuUWIi1w8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a07a93-e9e4-493d-d04b-08da2c55a994
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 16:06:05.7009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jB3kHwqIQp8s1M4X1mXqmXIDGinghblUy7dArJCpDh7oV+pQ5PYSJkzHj8Zth3xNEWPxHycwldt7nfXBivJw2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9269

Drop get_subflow from optional_ops[] as Paolo suggested.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index ad770deb5a72..b7cde38f7a6b 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -24,7 +24,6 @@ static u32 mptcp_sched_id;
 static u32 optional_ops[] =3D {
 	offsetof(struct mptcp_sched_ops, init),
 	offsetof(struct mptcp_sched_ops, release),
-	offsetof(struct mptcp_sched_ops, get_subflow),
 };
=20
 static const struct bpf_func_proto *
--=20
2.34.1

