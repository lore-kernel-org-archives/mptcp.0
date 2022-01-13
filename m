Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A642C80
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642086604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ioXXm5dj2cySei/OvbdNURbSrfrkcuyd6tgU4t95UrQ=;
	b=nkht61hyV7jMZsnPgtBMWByXJT8diiFUU/UDfRiJIT2IouGRCp/hcr6yZ5WPXtlGttehTx
	7AAxubjHyvPwIPRQlAVtGDd/Zn/bnw0worpxrDQxXK0cxL9/VUUmp6DmCZZ9SELTGShxVW
	ielw1vwhmXRgwtx2EvVBldCLGv6+y+Q=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-df7xcGvkPmGL6oSKIi20aw-1; Thu, 13 Jan 2022 16:10:03 +0100
X-MC-Unique: df7xcGvkPmGL6oSKIi20aw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIwmCLoqiR7IaZznQ5Ivfu4OTEBNMod+IQQuKc/2jr761EEQ6amPspy8skJPlZ1nXotHLzEqyeR6F8K0Hzb1tdfXQrx3euA6wEUv9Rn9+Y/4OVAeuIsSSAT29AktL/FV77DTp4I5Y/ATIi3ii8vYh8ZTHuDy9RqUReS9YHlq5WSTTlLDy4pBj94vkEQ779R4YZDbEpdaf5lsNk0GFTiLQmrkmlfLrOOMWLB32m1pyN7sVwiILopaJUAdmwSdwGFTnxEemMpByrUiAlas49XaK6435TjkyU1NRsdEk/HtTttQBMFR8JEnIKJca8OYhLIXs4kdJWWi7cxMiLXphsEQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peXLm9e9r++ppynZFAbEO2UtPGF+bU5j+xe6QidYMQk=;
 b=GgChwQB1ys8Oe38J4HR+dkFHiB9tZPCgbs4+B1b581CrppVJZnkPHlaMFc/RcWOg2xovF3txYSpUmYQqBjNvMb33KwiQtaupCa6v9asw8jX2DPA5MiCIzatIHmBEX/gZJ0zU2KGBakk9HcIXNH9ANGTWGamK6i46johcLs7g4GPotx6TModoG3OfezFjhoU6iJ4mciG1A6H+93cbA11bSqvkg9OQDFQL1DmsDF9jRaEt8u92tg/hiCtTqinFS4pu9z+As6O66unYHOkxu1TTfEsxnmtImMARwCqw+mvMucC/eUVUNVk56zSFi5KhvJxRV2QkkcjK6XEh55hbM5+p9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7361.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 15:10:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 15:10:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 5/5] selftests: mptcp: set ip_mptcp in command line
Date: Thu, 13 Jan 2022 23:08:39 +0800
Message-ID: <01aa080335478b774fe99f83167fcbec53d86302.1642086296.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642086296.git.geliang.tang@suse.com>
References: <cover.1642086296.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0205.apcprd02.prod.outlook.com
 (2603:1096:201:20::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1652afd0-a122-40e9-124a-08d9d6a6c5a3
X-MS-TrafficTypeDiagnostic: AM8PR04MB7361:EE_
X-Microsoft-Antispam-PRVS:
	<AM8PR04MB73616C8715FA5A9B9A05DF35F8539@AM8PR04MB7361.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GwlgJVUSr3IaSk8yODYPYP7nHTNF95pQ3ybmRvEZmXMG7+1TF6WT2jqp51CzodI6WKtCqXk0+Ugq6wI8v1q7rfwL56ydfHmmtkjWwsRbEllHq2uOpjLwSPm6cll7Gf7AvAOM28ZleeO5sq9xAM8z8HI8UuCa22tapokqrsGt2TNdrzd+qvNBNw+D4QpdWoH83WhB4dlzuDhKJem6jyLAaB8QeOwCWgIKPDCpJd6fl/5bJ30NMLi12N3uVtbaeuG6plKhqsvvN9IuNPPoGxQDqYRSEj0/VlQG5FHWLIgKMRAVgqu0jB2OrETjqIFpklbBiR4iQlegWKLUY/RBZw2fHvUCBk13pZAJetk8KjjNeSXcSfhC0kLX+5N+uc8Dkww6QnH1qP+kOZmH5619ZxuX3G2b67CkjiE4tIRNA9PTI8tvQNylB0z9gtOKpV9Or1HaF6Zj7XE1WoXn5374NBYVNH3ymGwHypLyG2GPCpVd4J1zlQVy0ujY/J/avRjuYLBsQ59zrG+BDViJyliBf2od/TiOMA53a37XeQ8O6h59oqcWLbAINsiH2kLthAA1n2TXpOQRju6+T3LUTSt6PbPyLX23smTFJgOrEWIqn+65IkSUn3GiNQB/wBlSNUP1SZH7Dsh2DRbDdZ8CHX+BQvDI/g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(8936002)(86362001)(508600001)(44832011)(107886003)(6916009)(6666004)(38100700002)(316002)(2906002)(36756003)(186003)(66476007)(83380400001)(5660300002)(6512007)(6506007)(66556008)(8676002)(66946007)(2616005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gCfFYOSQSBUIfJp2gogyqnZvGDY57OKWdEG01cc7U4IiCJAsi+jueB/crKIX?=
 =?us-ascii?Q?sRo2H/5VACSVEv4zYV+iDKeHQYFnKC3+pxGivIRHEDZafXrYbBT80bIDoKMH?=
 =?us-ascii?Q?1mdMTw9u2NOrLlZVzixwz+m2XFNrsf7uhGyEorDdOHJlOvRJOXolN2F0viz6?=
 =?us-ascii?Q?7iOtxvji+Bw1FxqPnmwnTegSA1a63/oOrLSN48qftRPIoF4ZWOpiz/mC4cD/?=
 =?us-ascii?Q?gJ+4t0UZn1krm48gFUFrwGdy2mV1Fq+0ySGosMtJyprPkyf/MOIxpA5wdV6/?=
 =?us-ascii?Q?3m8tqHLIaV3RLYcFrJDA9/HK7kaQpTOnYSn56IUfrm/8rRiBjL6vrl9E+hEE?=
 =?us-ascii?Q?1jAUplgKjBW6GGuQTVlIvu+rrphzrUONLKURZtxrXlK0FiahTdGopllT3t7v?=
 =?us-ascii?Q?bkFEKEP7KVhgt7bW9VVzS6EYEW+tVLulUyNaAqsMeuDsa9EV6+uiOzglzdij?=
 =?us-ascii?Q?NAAYxiE4+CnC/9mdEu8/4ytcXO109ilbIhbj1HEcgLd3LQijuPCF2IucIg9m?=
 =?us-ascii?Q?efnO6ZTT+8P95w653TMXXlSGgjS7JJ5UIgIBVco3YhNmACyIzp77Md/x5F5M?=
 =?us-ascii?Q?1w8OkUnIKrulSgVgFTEb2bhc/KCW2zRLwWW1aiJqtWhh0V5wCnvT3mh/jfSM?=
 =?us-ascii?Q?431dz2/+FkLEtTSU7xiJeCkndsaWpHiRa9sKjNDbt4PTJx07ipyagqpLptHr?=
 =?us-ascii?Q?CIQJIY4+sXhkZ4MK2L1Lh/7j+GIEnMhb0oErfL1+yO88MBZuxUqRgcpWKWEL?=
 =?us-ascii?Q?xvDFX4CbpRNwz3XpekPRToNH/mxT6oRWdNDFPP8qHdHg6T++mlUiymtTBv9T?=
 =?us-ascii?Q?HETDj1ZLZg+MF9paMxY2U90K4dFXx1bIou8/6N3Cc4xnNIXJFmqNYbY6vOZz?=
 =?us-ascii?Q?eEvzIffkEptkEriTqjIbMGX+jTvmPaUeN5h84Hh94RiChJgKNbB7tzLdLQCW?=
 =?us-ascii?Q?yBbhOVRGZTRLLZ5+eN1Wku37QYgTzwUEeq+1xMrpN8Dot6IEVcbOHMEDGp7a?=
 =?us-ascii?Q?dVdbIPSkMwTZ34/ThvyhH2qTF5/7h7GgQse8kOpNprWxzCeQdkeRfWlGM7gk?=
 =?us-ascii?Q?9FpxZZzuLD1FVpOVoUQAYn4bPWFaIH4FKeugVTbWyHufMFYqZTK3bsqn5H/g?=
 =?us-ascii?Q?n4mzA4/z9R/Ycv71/elMsJTyeWzeZMi1Kkk0o9HPOw9if+mv6eDph5bzGFEM?=
 =?us-ascii?Q?gPxsnJ9cbn99qprzvDoYUviPeqe3XZLymYTuUPECVhxXV4xNL9m6AoApGhTe?=
 =?us-ascii?Q?c1UUdbUflCECKxZKd9Lna98poWp2Bv2OX6o94EU4j6/mSmYzyaCH7bsEJk69?=
 =?us-ascii?Q?sh1Zub99uqBPQvaBz4KvAbdQ8HHsyjTpwIq10fGmUBQC3m4uZ2wWCsgOwRSo?=
 =?us-ascii?Q?3+QnPfyg6Ja8baLti2+Qd4XPcE0u6u3t9JHZFKikzN2AAoJMACZ9GPpU47wV?=
 =?us-ascii?Q?iNHXBUaanfuWuaXRh7h5JvTCuk+n1PPbN+XBS6tg8klo7Mr/KvA50bsbaqYX?=
 =?us-ascii?Q?KVkEBD6f6RrsSPyU7GFYdBxVmrosDfrwdTopntOpnsQp0reI2EiUaqVhllcV?=
 =?us-ascii?Q?IJwgUPGE/+jW9ycbOElapamMXF93X46J2VhgQqIaPQqkYQ+D9zu8tPxcZYvq?=
 =?us-ascii?Q?Yzx3qHJhl8ogOR7c7OJDaLO1jsgYG2JlkvBpxpd18A2WmiPBezk/vv8g2ZGv?=
 =?us-ascii?Q?5V/2rtapRWD48IoEqqsraMd9rBE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1652afd0-a122-40e9-124a-08d9d6a6c5a3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 15:10:02.1318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29BxZ2eTAxQoJk+yMTXd3K9SnM2CQIZDgOBbsU1WeXXGLeNxhUwuTU4BKxIH9O7D36d73+3gYD8nqfOeltRA+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361

This patch added a command line option '-i' for mptcp_join.sh to use
'ip mptcp' commands instead of using 'pm_nl_ctl' commands to deal with
PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 529765f3ab5e..193fa5adb9ad 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2203,6 +2203,7 @@ usage()
 	echo "  -u userspace_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
+	echo "  -i use ip mptcp"
 	echo "  -h help"
 }
=20
@@ -2224,9 +2225,12 @@ for arg in "$@"; do
 	if [[ "${arg}" =3D~ ^"-"[0-9a-zA-Z]*"C"[0-9a-zA-Z]*$ ]]; then
 		checksum=3D1
 	fi
+	if [[ "${arg}" =3D~ ^"-"[0-9a-zA-Z]*"i"[0-9a-zA-Z]*$ ]]; then
+		ip_mptcp=3D1
+	fi
=20
-	# exception for the capture/checksum options, the rest means: a part of t=
he tests
-	if [ "${arg}" !=3D "-c" ] && [ "${arg}" !=3D "-C" ]; then
+	# exception for the capture/checksum/ip_mptcp options, the rest means: a =
part of the tests
+	if [ "${arg}" !=3D "-c" ] && [ "${arg}" !=3D "-C" ] && [ "${arg}" !=3D "-=
i" ]; then
 		do_all_tests=3D0
 	fi
 done
@@ -2236,7 +2240,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCS' opt; do
+while getopts 'fesltra64bpkdmuchCSi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2290,6 +2294,8 @@ while getopts 'fesltra64bpkdmuchCS' opt; do
 			;;
 		C)
 			;;
+		i)
+			;;
 		h | *)
 			usage
 			;;
--=20
2.31.1

