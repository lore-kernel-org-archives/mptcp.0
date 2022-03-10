Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E07A
	for <mptcp@lists.linux.dev>; Thu, 10 Mar 2022 08:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646899806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnn9IZtqT4kIKhVOcqxMgAMgBMJFPZzZPkyzjN4QOtM=;
	b=Jfem7DvBGe9G4lWsyaoxajPisv3kiRdjJPMGKDTGt6gakceqhHnLvqJ6iHgy1ulJIUJMSM
	fkRKSxLgmQHdVXDQ6urJFAVw+NXnc5giyWsql+0URQ+u3iRvGUMyh7mKVNbSDIUFWhzYNq
	2XZgfwWFW0zISvVratr68+LKuhe8OHM=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-KbUDfW2qNKiDYUK923edQQ-1; Thu, 10 Mar 2022 09:10:05 +0100
X-MC-Unique: KbUDfW2qNKiDYUK923edQQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEFzUtDFcdvNE1xS99AAftMAX0YYiGbqov4nuSHTySmAu+1+cHoojm4lxB2jBlsGX4Ojn6PJ9it8qPWjWNF92IxgB9ul+ttdDh+lsxwYTOzCJ8EkexqCRHAKqIqbk7POOX3sXiHJeeu32CV9tKRvJ002xJghL8k1elSm/jE/kZ7o46puYod4tGaiwfWSSSXX9KzqTk37bpovV88r4l7+FOTbLDu8SyRNcqtgL5Gigo65yZjE3rzG3upMmQLz6lRFkSgIC7vrrsYY3EhnMvxm2k6HttOY8pPcYqK7GADJeIZ9xdIusp2f/stmBBDy9D4IXrkjGZwimk3TDAscoH2eGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JqS73Y7HFpZcVVKEOxTx68bXAb6XxNNvOwtcqTbRLg=;
 b=AuWz3vXd4Ou/rQ1EG2eXsp8kd2oyBFvlFdlrEJqNnmv/jBi7+a6gk/RjTOpbVEYH/pW6Uh0A/NTuE/HVFKAP/SqecFTM1EBpnBk/FN5JLFtHPxoVwEkWSmN9P9J2Kd74zIkwunQsfjse/ynC4InpnRrxHJvPp+cS4SfSj7//3Yb2+fGqciApyap0uK/f1LZiGWTtt60dfefWCRt+Ax0JVVNwWPqFbLSV8F4v03WRo/po4qAU0hrDqtOPJ7+Xz0v0T1hwVXp7iYGwmGwfxo2wkPhYFiEDxGSOGW4+FnD+9euzH2hxdBlLRlV9o0EeSRpxT5pn5xQUcImUxVOvzmpIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR0402MB2772.eurprd04.prod.outlook.com (2603:10a6:203:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 08:10:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 08:10:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 4/4] selftests: mptcp: print extra msg in chk_csum_nr
Date: Thu, 10 Mar 2022 16:09:27 +0800
Message-ID: <f0b54cd0233d236cc42637b0d759e7037630b23b.1646898548.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646898548.git.geliang.tang@suse.com>
References: <cover.1646898548.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0199.apcprd02.prod.outlook.com
 (2603:1096:201:20::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b99ea9f-fb23-4969-981b-08da026d6213
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2772:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR0402MB27720947F30D6E7A68EA9969F80B9@AM5PR0402MB2772.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	36mF5CCNbfwRkGRQrBBNMzRchY6TLSQGWwLMX6csrlvFSB+HgdN2Ly6CVl9nHMOHIuywiud+pWQaF6AGhdsADjWpScONfxkxBBev4CyrQREK7a8eRuRt2e6fvMGMpqiv1EGIxEMDQd7CLhB7zp9RS3HtEGAjPVMqmMbFS1pTtbv4d7UO/Am1gS+p3dVeLlAtZuYgZgdF4gAoNZiRVA/yqo3hpo6SiBqwwKZqqeOb2mu4l1XfESqWhsMuK18VHv1feWTpTsYf0ODbJTiuGU0mwn8x33VOfT1c8eg248UeYoTxumsmPGV7vB7Og3Z19mGrJh02vJLUQIgn94zIlR3fcwGlwI6K7wX9/GmZ4Q38dR/nSr5GZ+vO1l+ND2pMDiXv+qdvcJfRcmndm2WsoYnpeF3ZppWrIYsfd2otIw0acaJHBO9TNPU0YMsBrBIVlXU+MuOd4uxZN/X5lyLT8MYqUvEbZC4SgyNS6jF8LNF1c4pLHBFcHNALForK51CsizDCF5Q9wS019h+486cCzPuBEOWS8P8NGsluA16pCYVd0ry64pEYPjnY9kka9tyqb9dVB60cIYGcYwrcO6huA8r8j++gEuIhei/rfIp9VWyiX/KqcGkjKPwKfWz3yMeQMSVXQrVEBs6WGMkvtboeOrHcpwG8SZd0yiSa9+UUit889wRXaw+gGILzCnyrwY1afB4LGwwsL8qVmHR72ypCCW0jYw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(66556008)(36756003)(38100700002)(2906002)(2616005)(6512007)(107886003)(86362001)(6666004)(6506007)(44832011)(508600001)(6486002)(8676002)(4326008)(316002)(6916009)(83380400001)(26005)(66476007)(66946007)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SwfsqbLYYMMF6c/LAXLhfTxrnP8cdJiiGnCB+TdijCj56kFd0UyhxUBgfbQt?=
 =?us-ascii?Q?YLLuavvm88ws1lGSsmgTFRYatfk1ZXcD5iSVzRD9/cwtnqpRveJAmOThRZ9r?=
 =?us-ascii?Q?zTqVWptd2ppz1eZARAfoBkuvHrd6XoT6p8X+8qqrJs0PFsThLpIAyQUdH/Lo?=
 =?us-ascii?Q?n9BzmKUmuzREHaJmFQm/1kuWaQATuiWSPvm8Vl130UBAxnQc68jTH3xWguQQ?=
 =?us-ascii?Q?Wev8j538HZtBXfdxQLC6yMBTOHO6A7hZtvD1WrKlIhIJvaqWcuhWMolPzGRO?=
 =?us-ascii?Q?m5RsG7B1pCpzrqJLRr7k9GKUenONThg6VrzdEuIuWdoXM8WXb2uDO87KrQNy?=
 =?us-ascii?Q?h7pDVB2MbGVmfJkv7OIvoazgu9K3vG5okU7xd/Rn+ix8y4XZeaM9wd1ZGYh0?=
 =?us-ascii?Q?cf4bOaj/moBjXLMMPIs2WgC5cZUt50ROrD0TFdebo280NZFZfa17KRM25Mjm?=
 =?us-ascii?Q?1+Ea68L0351X1kcYdGwLI2CruFeD99u68jabUWVlKXO7eBuQljsS8gSuusoD?=
 =?us-ascii?Q?EcnmyexqG+oSwPzJ/3NquZ14YCGLaavB81dUvYgbOQNwE5rf6sM8iQPf/0Qc?=
 =?us-ascii?Q?3qBw8gQrdMbhQRuRnx7s6HIMauw+geg5040JwgfxFvqqfQo/JAYf5Bzn1fDn?=
 =?us-ascii?Q?b2gcEwXKm6CJALAKZM2y3rw7teOK/25Ft+CsiEZhvZR6s5FK+ptXG/4WNjJA?=
 =?us-ascii?Q?8Tg6SMG0kuAgW6To01bAhjg6sqyulGReBFCLLABIe75KHafWpto+sV/UYmGY?=
 =?us-ascii?Q?RJkIL8uZRiokkoFzZ4EbIOnaCRCJlH9Nn2ESvs9PodyfM7YyMx9bQzrYGxVP?=
 =?us-ascii?Q?y8LmkEAC1dn3O/scpU8nA08QLbOVdKHT1yys2TVFgpyDYmcjc9VYy43H1abB?=
 =?us-ascii?Q?RyMMVcBGzsiXnquI2vikgDoLzDzYi40gezFPaSL73D+tBniaa+I+O31O/qs3?=
 =?us-ascii?Q?4B5Cyf9xxCbTNDgZ5H428tblzy806z8IDPujE1Q8rqbLcGx7SEqGxFKr5ciA?=
 =?us-ascii?Q?lKQYzHKi9+gNyC7YIkh1bUVCKiupOnGj7e7YDPKHGw88oaX5Lch7PvwSp/+L?=
 =?us-ascii?Q?bM4QoKz6bd9swHBdsbGoCtnmCYGq+w7rfTloB4b9+gyJ4DBvXzr4Zy72MoOU?=
 =?us-ascii?Q?Orif99rgc18LXWLCNQpndC/LtctxmffTylcxtXtE0rbQ/wnsgz1JLedu9uge?=
 =?us-ascii?Q?8xSRmdLjfFVpjU06Wi3zI5viu+KayOht7sqFLhSeIi7KPjeQn0Qx914kViXu?=
 =?us-ascii?Q?OJT8iR4OogiYO8vPVXJaHZIx36/ykk5u06vzfYi/2rUaihd0CeX8AScEULUM?=
 =?us-ascii?Q?HDJnE7myah+zbl6QITl5ddfneW0YQwgw8CuI7YjJ5WLu8/3hxvPdUe+YXhBv?=
 =?us-ascii?Q?pCxklyjAeL9bfeQMrW70jEwVLaVzbLx3VAfffJZPZit2DWT0zMm8wRnzeCsO?=
 =?us-ascii?Q?P0u8bFQ+ATh+5mCjfqdD+rksqCrCk95fptimNKNkxRJCy1tdKgv+8w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b99ea9f-fb23-4969-981b-08da026d6213
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 08:10:04.7738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tqO6GawyHoe84LG1ZaJb7rU5kg8pPMzmUCb86n4/gK8rtgR8TRgzgPgBAvkU1AgKeC7kkUftYCFAvuJpNNDYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2772

When the multiple checksum errors occur in chk_csum_nr(), print the
numbers of the errors as an extra message.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 2b77576d773c..375b087edc7b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1014,6 +1014,7 @@ chk_csum_nr()
 	local csum_ns2=3D${2:-0}
 	local count
 	local dump_stats
+	local extra_msg=3D""
 	local allow_multi_errors_ns1=3D0
 	local allow_multi_errors_ns2=3D0
=20
@@ -1029,6 +1030,9 @@ chk_csum_nr()
 	printf "%-${nr_blank}s %s" " " "sum"
 	count=3D$(ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '=
{print $2}')
 	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$csum_ns1" ]; then
+		extra_msg=3D"$extra_msg ns1=3D$count"
+	fi
 	if { [ "$count" !=3D $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 0 ]; } =
||
 	   { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; =
then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
@@ -1040,15 +1044,20 @@ chk_csum_nr()
 	echo -n " - csum  "
 	count=3D$(ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '=
{print $2}')
 	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$csum_ns2" ]; then
+		extra_msg=3D"$extra_msg ns2=3D$count"
+	fi
 	if { [ "$count" !=3D $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 0 ]; } =
||
 	   { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; =
then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		fail_test
 		dump_stats=3D1
 	else
-		echo "[ ok ]"
+		echo -n "[ ok ]"
 	fi
 	[ "${dump_stats}" =3D 1 ] && dump_stats
+
+	echo "$extra_msg"
 }
=20
 chk_fail_nr()
--=20
2.34.1

