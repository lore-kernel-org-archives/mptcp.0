Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F8329CA
	for <mptcp@lists.linux.dev>; Tue, 30 Nov 2021 03:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638242494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcGTMpxZNLYk4e1h1lJzJmerLxCOsFdyV/zQbH66VkQ=;
	b=I9PPhwwgVmo6QUuKKw70aT1klbUvsAbWZtSRDVl/xh2AMx7BhLHC8W8zxX4tjcYRvVJFS0
	zrdNh5fLg8S+tP3pfOF1xICmqYSIjOiphCBsIIvq+mp5wTgWx/DMM9S8OLFVuSDeYFbwpb
	nJusEl2neb0gKBMF46QIBWdAWVfyH8s=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2054.outbound.protection.outlook.com [104.47.1.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-oy3I-csWMnSMalUjxDmWoA-1; Tue, 30 Nov 2021 04:21:32 +0100
X-MC-Unique: oy3I-csWMnSMalUjxDmWoA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBbDMuie88PkFKKFFl0kN7dk+tmDrhQVFko4um5sGBX//mrAMqOYoh9qC3lds9Fqb8Vvoavq7HduOrGudZrehOImiLUqLYqlsHPYqO50/WZTkXXaZqOaSYHSedPIdEulk8cIVqoR6s2U30rswCIhb+GZMRilgefMXdQUosixmSQQ1WIAB39CinQpKs8cfWo1BgSIvvBCH9JrnwSVGEbmToOUT3TfFODJzaQggNQxHfGklZlGC+iUf6ZXVj3pwBKjKCtP56jAgewlXEzBaBv/IgVbtkZ/MKemKO4fg8HQsBvp+zQU2ffE458hx9sWVHYteeQr1Uf8Fkl7K110D2UfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPv3Ucni+91J1zN5VJoLlXx0MrlqlH3+y3VGuSTODIg=;
 b=dzf4s/AwRL0N4Ygxxyj4TO1dJ0SD+0XFaTn2/6fdI/LflT/hq9ddxcbzXSX9IJtBiZLOBoe58KKMBEmS6RZu7DWwpsH9Bl+fJFDr4XqNCHe1O0RoIf/9g5uMcGajQuN/O33xnfeJYIUymZAZeLdy3MQXJLUklWRZcueW6zn0jy0IrapPmB5GkOllL8D5TuntAgoKq2TMluHeeGKwdz/bB9+uQ7PuGr3bGOKmhhdsO+7jQLCxmIT+UzuHWK6j8juH7XfvENxNgoNu1we6w4UEwDMFcJ2ifQyXNsuv2zQLM4Je2TkXZdFf2xZcQVM3uljIniX7c+7m8X8lrnzIUledSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2346.eurprd04.prod.outlook.com (2603:10a6:3:23::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 03:21:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 03:21:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/2] Squash to "mptcp: implement fastclose xmit path"
Date: Tue, 30 Nov 2021 11:21:07 +0800
Message-ID: <a3d0dcbe4167eb77b7a275e113abb484d3cdfab0.1638242181.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1638242181.git.geliang.tang@suse.com>
References: <cover.1638242181.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0056.apcprd04.prod.outlook.com
 (2603:1096:202:14::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR04CA0056.apcprd04.prod.outlook.com (2603:1096:202:14::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend Transport; Tue, 30 Nov 2021 03:21:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9588847d-25dc-4bc8-da90-08d9b3b08172
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2346:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2346C239ACC4B23201C66763F8679@HE1PR0401MB2346.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+9gOoMZIPXMVV9cypQjRd1k8AjIfRgX8gPbyCP24FDPSgZGJOkI/+9H8Q5Ty80eME5v/FkLusJRPYyF7HJNZJcHVwPxPDS1mPoc0b2c7J4NnOaqbvv7z2G1IX9AkN1QaqVNgPrBmhQcDXd1Rj+B0wgfSJq6sBkWLgSV48ASXFWUaM7bo4sd6XSmXqwv/u4Ee54eyhyjygRiKu7CVVsZgJ0imT5c9r3LPgmxpIWF2JKh1L1ACfPgHLB3eJvErfFF8i7DZt+IW1tmq92F015wTIq8HopVfVpMECkGX+FjxFf3EQOnUqgM1dzRJvshsN3rjb6mC0syx/HcSPcB/GhAuQQ7691HzZvtrLuW+zMJX9LAkRtwrI49aCWpld+7MS0Gs/kb9aaZQdb6N9p/2tMg9vtrmFYUzZJ4kH9Vg6UZxHIFsF73BElqlNE+7gRupd30bMoti6k51h/nCVqUHOyYbnUhuWRwvKIac5MH4x/HlGMGrFpAa3HWvWM1aZx3nzyweSJTiDlRyzl3PqAebx+tVvhytQ4K5+wsREP+DpG+pebxqKWa9j2JDBhQEkbt6CSDTUP6brYjMhr5F99EvUH7a2FH6uHZs5CKz0lGkBlBBxMRtVVMwgK9ktyokAtVRW2aj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(8936002)(107886003)(83380400001)(956004)(6496006)(4326008)(508600001)(5660300002)(186003)(316002)(44832011)(2616005)(86362001)(6486002)(6666004)(36756003)(38100700002)(6916009)(55236004)(66556008)(66946007)(66476007)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xyuqDdAffxnpr5CG2z0XPLOSoAKU7U3i1XB6PZaCnBJdbsrl5zzeunz8EoMz?=
 =?us-ascii?Q?W7Z/05G87tMSwnY/2fzOZsnrawLd1qVHg4vh55gCu6WZg9JrHMzmY5Uu1DN+?=
 =?us-ascii?Q?hT6gx6VxliPoWiV0krvOH/Ep/zrRnzw22rKyzTpAkWepciy6iRSmuupjy7Qw?=
 =?us-ascii?Q?D85/M4QC9DrGeFxxAjXeV5+CFnbuhuAGMwu4vj1Ymqt9CWj5RyKewN0m2b8b?=
 =?us-ascii?Q?1VO4JQPRWPP9otxmEAaWhl6o8P8rKJbo0kiWAEW3s1AOeY45+n8BCzGhvfF3?=
 =?us-ascii?Q?4Sgqy5+m6hcWqQ7X5ydRSsr/oCjjvHLx9sBkXmZCV8qgaPUhQ+SM6A5mtlE9?=
 =?us-ascii?Q?n6MH/3+oI96eGzbP54/CPXjlLZ4MKj02uVFVehcAM6m94P4p8EBFJGwq0x2o?=
 =?us-ascii?Q?2KxMoBWyYQdVFTF9tvTBRX/yLHxu+/ZV0pBP4jfSoeqTRzSPHNPiqsb3o4Ce?=
 =?us-ascii?Q?Jk9MRbKJYw72MJBXt5bNCRPR4CFsNsxX4LjapY0vfQi6FAXkAwN3yNNnPzmc?=
 =?us-ascii?Q?IYClslA3mDL7AaZDpBpeyzowQP8n9cB/oNEjc8FjHMoL1GJnAZvKFMsCck2T?=
 =?us-ascii?Q?FKwW2D0yI3iFHwLrap11/Ppvpy6ZxTwfWJcNWmky9pR0cPRpeDiAURk4mDzH?=
 =?us-ascii?Q?bpd8nCzBURte3QF8V1BwGtu8Ey+CqMk3ShTfigT6goX3PUT1E7U+J5F4AYqf?=
 =?us-ascii?Q?79qZANRzyR/kNXUAaeMVxCe9UXAqteLf2fu79hZBeo9L6lpYhtIL2K5zWhQr?=
 =?us-ascii?Q?QRLsf6qI4JPEXg4YgEWtbvrqWXHUft5NuqlmuBSUPwxcclxVRzcA3XWguI5I?=
 =?us-ascii?Q?NMdIrftYlWW3usNlKfAx6xb+w6oMBLA9/eCu0BuC2W2w8nuvqGvvyqx5QfX8?=
 =?us-ascii?Q?LeEqEC0ipKPN6w9OlEgyDbydyfustKAsmJChFfIrK5vdecKAwWiQ5++v80r0?=
 =?us-ascii?Q?fmB7Oaljc0yyR8iMEWB9Y7H6xqWMV6dySm5zUTqE+kdm8g0EdhjBK8YxzpUO?=
 =?us-ascii?Q?wIrcVMfNkI2YDd7lO+tXVfJUbLJIVC9b+ZMmdQp1KI+sW4yWt08qW4kp4mEY?=
 =?us-ascii?Q?St+yHVv8pW55pr0L/Hc6OtTVW9hZgJe2+JjM8W8GIprNHdoHmMXNzNazCkad?=
 =?us-ascii?Q?CXK3pISXhTXZP2g5K0ZZ4tSUVeYs7MkMkAEUGIJsDnqQTKj5MTlJAL6f8FkZ?=
 =?us-ascii?Q?ONfqhRuUTUti6iFuFrsGqUc59QT8YwRpK3g2NnSXRbhcq1SyvYZHw3qEsJ74?=
 =?us-ascii?Q?PZCAilEjXusCt43gZcirTQ3ltr53LLRialgDCjGos8HhfZln49c21F6ZvgwF?=
 =?us-ascii?Q?tuidigP08iOdIXY6BeTuPnQzI/JKl+et8NKNEsjkiGV0wPh8H6xkt62Ku7Z4?=
 =?us-ascii?Q?V2KHMeW+acHrsZeaAdDJNc8qScLT+O5HtcozU3ixM34TXdFDVbRlVbZeBUbq?=
 =?us-ascii?Q?gytiOFHiTI8I3c3uEuhUGCu6aAPV5z0klWRWrZrQXcHX/TLmB8hT7n2JGJ2y?=
 =?us-ascii?Q?eyOr2ySBpgxfbgdOdDdmuhJXkD/xCAvb0XQNj1fJmYvLZiKwG4k3+AY0niTv?=
 =?us-ascii?Q?/FGVSl4j8zkI68uP+y/NqptRaTlWB+4RFeztJpVWZE7GFBHiLwdaJZ+qXJYC?=
 =?us-ascii?Q?3nj084way2x4o8BtaX4iSkw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9588847d-25dc-4bc8-da90-08d9b3b08172
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 03:21:31.8229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkoNpjMAAfNI2AX7+TCpZ+fKF98QBIU509suov+L7LsRvz7bf21zUpGtGlB5GI4mf5ytsisGphTc9iFGYME92w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2346

As described in RFC8684, 3.7 Fallback:

'''
Therefore, it is not possible to recover the subflow, and the affected
subflow must be immediately closed with a RST that includes an MP_FAIL
option (Figure 16), which defines the data sequence number at the start
of the segment (defined by the Data Sequence Mapping) that had the
checksum failure.
'''

MP_FAIL could be sent with MP_RST at the same time. This patch fixed it.

This patch also did a small cleanup, to keep the options order in
mptcp_write_options() as this comment said:

'''
/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
'''

This order matches the options order in RFC8684, 7.2. MPTCP Option Subtypes
too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1020e4285c..35425fb4b179 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -828,8 +828,11 @@ bool mptcp_established_options(struct sock *sk, struct=
 sk_buff *skb,
 		return false;
=20
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
+		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
+			*size +=3D opt_size;
+			remaining -=3D opt_size;
+		}
 		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) =
||
-		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
 		    mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) =
{
 			*size +=3D opt_size;
 			remaining -=3D opt_size;
@@ -1458,13 +1461,6 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 				ptr +=3D 1;
 			}
 		}
-	} else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
-		/* RST is mutually exclusive with everything else */
-		*ptr++ =3D mptcp_option(MPTCPOPT_RST,
-				      TCPOLEN_MPTCP_RST,
-				      opts->reset_transient,
-				      opts->reset_reason);
-		return;
 	} else if (unlikely(OPTION_MPTCP_FASTCLOSE & opts->suboptions)) {
 		/* FASTCLOSE is mutually exclusive with everything else */
 		*ptr++ =3D mptcp_option(MPTCPOPT_MP_FASTCLOSE,
@@ -1472,6 +1468,13 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 				      0, 0);
 		put_unaligned_be64(opts->rcvr_key, ptr);
 		return;
+	} else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
+		/* RST is mutually exclusive with everything else */
+		*ptr++ =3D mptcp_option(MPTCPOPT_RST,
+				      TCPOLEN_MPTCP_RST,
+				      opts->reset_transient,
+				      opts->reset_reason);
+		return;
 	}
=20
 	if (OPTION_MPTCP_PRIO & opts->suboptions) {
--=20
2.31.1

