Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42D32C9C
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 10:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644403420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nj5HhsN4FBm6qCeTR1W9NK9GCfy0YFPY4neg9Svftjo=;
	b=igGiDLvnO++7MlK0IyITGt2AAdA55AX5QBEWofmtHiK36pKiKYqHPFyM2+Zd4ZAiKybj/J
	0s40h2j4okvXlsSnzbLUZHCR6qVGJcmQr6rahffZjy/OSqaYJ9xmOEf1zANMEt57XgO93y
	MO+TSNBaLetLUcPm6VULk4+WSE84D5I=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-tzQAI4oGNE-Zm5vfgg3frg-1; Wed, 09 Feb 2022 11:43:39 +0100
X-MC-Unique: tzQAI4oGNE-Zm5vfgg3frg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQBsxW62mhobMgBO70/pftLBN/pb4KKKGqxFI7rZpZ3G+jIGcDunuSGR9UHv6cbKQrWTlG5+G5QgjyV9KPiS8a06GgFj1qWnNjmjVwYZD1sksp6zDZT6KvqCA1IDF2cP4UUku+V47miQ3wdpYm/r8lYuZe/MNlWclc19SvyW1S1oqh0M86f0TuXj2xS+8cSA8MnL+95/19PeLXbraxTxx/RrD+cVIuog/nenCn6fYvIPxwhK657svwxeI8BY6Y8Lx8aSHQXyR61Tm5/fmCwza212wZWG04Du8qwvS/Se1HBYtlmzmdx297Zs0KBA0I08Q89fg4FCaVQPVsWN871kEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIS0iiWvzfWJ9fl7EdkrYPiYbDH2CakyGvRIkVWp/kc=;
 b=TYUyOsBw37eQE/aHkxPA7inyR1ZUBIlA1plA2qo1qvpP/SfV8Y7vMU8/bG9kVYN5mJjKFMWko+HIZnvwX1BA3saXLtPVYkAoHZIeV8A98+Xyt9Rj3IdSAQRy3Ll9oE6ZITkGUFxLkKdaBMEvkVN9TKjNt0C7XuUzoiV5U6pC3Ex8z2HgQ0g/gveYaZwO9U4Y/BOsb4oH/L6Jl9/N6lRpPdM6ltrxZA7qLhcP5P4Nk1BYItUMo3+GT5FmxUsUywAGj7z0U9PqHsvfxgw1lJjV5pqEK3s6V+i0/DwsK2ORNW34x5HfvBr8wpft81F3Ytetsakq6h26UlZdut8oJG/v1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6997.eurprd04.prod.outlook.com (2603:10a6:20b:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 10:43:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 10:43:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 4/5] selftests: mptcp: add MP_RST mibs check
Date: Wed,  9 Feb 2022 18:43:12 +0800
Message-ID: <02b525e9e44709015b2331008afe169aec7add96.1644402973.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644402973.git.geliang.tang@suse.com>
References: <cover.1644402973.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0070.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d54c186-8d30-4517-ef59-08d9ebb907f3
X-MS-TrafficTypeDiagnostic: AM7PR04MB6997:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB69971A7EAB7F6775F2E6C880F82E9@AM7PR04MB6997.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QLhLAU9p6+kk35r43MhsyG2o1X0x2iX5p/NfgvvJVDPeXEoNgIlbNMN+z5n1Pc/9XaNuO/0ydC6EducWJAqjh1vtBLPG4lNspcMmEvoow4pryb6ikyTr3w+eTPJMcgdvp9sQr4+54BdvmHxZIXXDeoyS/Fo28UKxrKqdi9WawxuPaYvQzIk0lZSbe3+oryCdF7wZaa9z+0iVC9oFEMENr8C6UsD+hpxGXxMWdwREYSVXsEoCkuWyoxeLAVafSo7JAL9PHJmYMEeDx6DZZeFEER56KhJzi6/7kHcnfPutOpw6UpB0N0J7KJIoXxtmA7rDktf/ZpA4cxPUzq79NPPYdv9fprlph97KZQo0lzQxR/TsuGUl7NhtcvvlRjuh0Y1xr16c3e4SOKWDrYXUB2EEY3lRlfru+kUMyd5i43rjI2D2EJ4l/1ODKFHiK02zMZiVq6XQCWNd18dd3iSO5o4ZQmYlmT3Pys/v4aIvIG4o4g/Yf79ursEIuvAx+I/vgRCovqxC2N7ZlyWcGgak2SzKLRDOOj+5tzIROaH+84jYoMLALb46f3maO9tuHUk3QPEiCVrOa1Fni1iRS6eBN2bm0oZVt83f6ygt2D7gGPv5dfpYukFvzRiDC2KF1LxZUJaw7n7q3lbACVmEqOYIhAOmqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6666004)(44832011)(38100700002)(26005)(107886003)(6916009)(2616005)(6506007)(2906002)(5660300002)(508600001)(66946007)(36756003)(66556008)(6512007)(66476007)(4326008)(8676002)(55236004)(186003)(8936002)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aaHEH46IYcJGPYmU0xULqvDfcIIzTTyXX3rkMpyLoURskK51kVHN9YVhzgTK?=
 =?us-ascii?Q?i5qEtLin10Shm6WJUC8/usD8nIVKPQAOS1s5q27nDfh5OVKD8g+aYucpTwK+?=
 =?us-ascii?Q?HVc3NWgfn2BAyNZ51zTEyJHWDmEXx3vgjS0PqAYnOF0JarhDuJlhUMiy5Uv6?=
 =?us-ascii?Q?+emCWdfPeYnAI0i/X0gCUHWNAKI31GFvsktrpLtv5ykEosHX+TMBuDb+WFZG?=
 =?us-ascii?Q?4ihBAJzXoalNHsWtdYo8teHEsLGHPvzUXOVSmBlix25+BbJWOw1fz/4FtI5N?=
 =?us-ascii?Q?tPwZ0NAAnzo5l5BQuUP/dkA93cjB5P73ihYeVLRMeomKbIrY6b20+EEeY9VM?=
 =?us-ascii?Q?Sf/kg+29oTDPiP32Umza06owaWtdbXPsOfmYmFgABarlft7VS6sWgCUFxxdF?=
 =?us-ascii?Q?gf3PmtFIB8sPNoDusfEEKDT3kLste7/3TIcoPMCiOePfP61rcSSewYcD5KxX?=
 =?us-ascii?Q?G5y9HRmxwtZ5EPYDK9cxDbvQgnkPPQSI1XCmcpqlLwYKsdAtwUOuARL5zzCT?=
 =?us-ascii?Q?u0Rgrf1r8Mx+rKQGBKkOYhMuxviLilCsnaP5+mZI2+9PDbqSvg9mpFnoD6ZK?=
 =?us-ascii?Q?8UJh6nZ3Tmc8zFBIASsalHomqCKYKm6G5KtvLgpFuxWr/hJboApzI4Enq4it?=
 =?us-ascii?Q?fnPV183QL/Hzc+Pn9zRRNB9LPdODgSJR5hs+cM3qn7T5vGVD5EGy3MYS2JMM?=
 =?us-ascii?Q?nYM7IpOkU7PMr4CV9jz06WztQ1IqJmqPtkfoDOYoCS4xmVk6OsbfeID1avHa?=
 =?us-ascii?Q?i6UXu1ecK0pQtMcGqWZV6aaYl0pWtTpl0R10ob1CO0z3uEByeulvFSM1tITM?=
 =?us-ascii?Q?dsxNUj7Qu/9iuzlSbaS6nJW6yjW8dKoMcj+P2iKw/fEym0wbPjFMfyZRqHG3?=
 =?us-ascii?Q?wVjtwu8pj2LerPHPBmhK8c43QpowrqVMd9Wv8ZX0ajs/4NSHSOSF59Yh4F40?=
 =?us-ascii?Q?Ou3i2Di+seQzPt+Mt0Dq/0bNpSrXuHkPaBu1UHnUtoTDZoB72jRZYZDKN+wm?=
 =?us-ascii?Q?ZgZND+q6WU/v9ihwf+e/a2m2BLRvhJg5t35HyWt8nkSE2Eoko2bufrOXIcu4?=
 =?us-ascii?Q?Q44mGIdBtCSWDAMApqBjEakXZMYE0yHuSpAmr43rfQThDuOpi+kO5RsV+WF4?=
 =?us-ascii?Q?sQgyeF857eu/6GVRkMhlqSO6HSIRrV7ECJdUO7dpimAvGhvjnvh6txmkys5M?=
 =?us-ascii?Q?8o7N7FniOi/1cUYYvf4rSEMBCeRym2FdfW2hVtUjA64CKXcWLtcgCpmpKOPz?=
 =?us-ascii?Q?EjocK5Et7y8l4BVaPlFMRiXhUU8GWz4xRspWNIWMe7qHsZCxiUil56XtZtWJ?=
 =?us-ascii?Q?Tr5dqdFFBzxU1gy9ivfNkHjXQcRbPeWZ11FGYabNF5u5KbKu2GFDExs5+zc+?=
 =?us-ascii?Q?b/goRr2hsomu/X0f6E0QQYZkisy4N/tXNGPPmfkkUSYV48V6hyXfHapUO4vn?=
 =?us-ascii?Q?oARqM0vJFUno/cEQJ6cXa584ZU5UyAX8eLmv9vGrBUiKd06yvom4uFYEP6zb?=
 =?us-ascii?Q?5jYGqWKzYJPFfZh9D8tVOEntRpLWzNZdAhwK6K6bW/AmBiPD5GXglufjM6Mp?=
 =?us-ascii?Q?jnesEz7DTOOTKn8Nbv/XBtF049l9ol2eylllvOc4eCX2XxXvxV4bl7N7yjwN?=
 =?us-ascii?Q?DwXMbBbd37O63+InYb2v95A=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d54c186-8d30-4517-ef59-08d9ebb907f3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 10:43:38.5789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UABvKL27PcE2zOSxKYoRfPJSulMKHGAcXnYG/OjjLmCa5NsI5rhI4dPR3ie429ujTdSmEGZnfPTSzvUNrHAdhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6997

This patch added a function chk_rst_nr() to check the numbers of the
MP_RST mibs for sending and receiving.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 3577716cd5e6..95d61c97ccad 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -782,6 +782,38 @@ chk_fail_nr()
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 }
=20
+chk_rst_nr()
+{
+	local rst_tx=3D$1
+	local rst_rx=3D$2
+	local count
+	local dump_stats
+
+	printf "%-${nr_blank}s %s" " " "rtx"
+	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPRstTx | awk '{prin=
t $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$rst_tx" ]; then
+		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - rstrx "
+	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtMPRstRx | awk '{prin=
t $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$rst_rx" ]; then
+		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo "[ ok ]"
+	fi
+
+	[ "${dump_stats}" =3D 1 ] && dump_stats
+}
+
 chk_infi_nr()
 {
 	local infi_tx=3D$1
@@ -859,6 +891,7 @@ chk_join_nr()
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
 		chk_fail_nr 0 0
+		chk_rst_nr 0 0
 		chk_infi_nr 0 0
 	fi
 }
--=20
2.34.1

