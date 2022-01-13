Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5D52C80
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 15:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642086599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNVtYcJK6vuVSkIheINpN94YYpqtGl1UyW51FBPOvZE=;
	b=YrNt9Mzq1dWaK+vs8rbIetASqJNRcztyHVjI30wefXFkkiwCjFWtvbdYuQbTSq2RtvS8fJ
	m1IHrxhjjH4zE5NDphMtjqE/M1S1Zm+Gx3gfue7mWzr9da/5iBFarG6iA9ipHGYyPhx97J
	ryXYq2up9l377+qiSUKD1QcwR+9nRz4=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-TSbeUaveMg29yJAMwyUgzQ-1; Thu, 13 Jan 2022 16:09:58 +0100
X-MC-Unique: TSbeUaveMg29yJAMwyUgzQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FurLu2PVxzCACYulQb9xD16+qmepDYc/IYsZ5xBlRlgxPfp8Jp8Hb73STTpx9ZYBClpWcpN6Cf/UAfp4zG5/KC74eslnIVdREsmtCXGE1KXFcCOVMg99GcF5s1NlcsdLhEOZIzB5GKRKHxOyjOe/RIo1AJpNxu6z21D5l/6Tebkz7Kzk6CHqjXbK9ktfHNlpF6gaaNF9n9zzEyBsJa4+oK5p3PX7YIB+h3qCMk/Hr2nRZNmS67La6J72Up0Chwxc+HycWXEbh33VSR7EKE+bXA2Pw4RnkGqrrU8XGeFxJDbnADoH8ON0HQL+2tEQkHVb3lVb12CV4NkpbNuMcjKMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9z33dTlhWch9eDLNhhCW6UM4aJgFzu1I98VpoP5mde8=;
 b=TT59c5zWJBf68x1iYtK7IbWrxXCXZOfAJyBdWXa87/beSoUBJPIpE4cbNp19WW5LPnegWAtW7noD/g7GPMi+1Rpz6fjSvi6ptSJBNBIccFMncpQo/bq3bgv+eFQbdr3wIKihIhuKvPokLgkCbTaJ37FO35W/z0yB3eYneleJiH47ViLL4arhmTkfPJFTGaXnRQGr4NQYi+SK5yes7XqAt4eMipygFJ7LdxNUsu/hgheMPUKdeVdwsnHTUMqHoeh8K+T7ODNhEWQ9GaWTcPQLn9fl8ZLoZWnXickwWmo+vJJSNtX/NvjsiWxvQ7VVxssTdpgJe/IX3DdNSCnToUpL2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7361.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 15:09:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 15:09:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 4/5] selftests: mptcp: add wrapper for setting flags
Date: Thu, 13 Jan 2022 23:08:38 +0800
Message-ID: <8a2d91283f44b89e855aa838ed9ea4985370aaa1.1642086296.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642086296.git.geliang.tang@suse.com>
References: <cover.1642086296.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0206.apcprd02.prod.outlook.com
 (2603:1096:201:20::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db592261-8bb9-45ae-1f10-08d9d6a6c16b
X-MS-TrafficTypeDiagnostic: AM8PR04MB7361:EE_
X-Microsoft-Antispam-PRVS:
	<AM8PR04MB7361D7A06212320E24A2B1AEF8539@AM8PR04MB7361.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n0GU9Dvns3x70ILUOyVzHflHOqc2u0x/fUsSAz/W8tGuk3ZDqgVKuod2vYNMo9iT7TrRB+OafJkVuNGs8zKhpjO5ZFZ9NxhUXUc2uT0igxH2t7UOIFnHuqoNjlbj5mW5Ad0xg11PsBqFliAerel7Qe9Ga+ONznx5ZeSf91xRJWsGuI8PrjzL2x6Q1hGIRqzFWB002EN2P5e0Rd8dWP//i0q1rE78tFLs9ANIR6ccEvktVpVWxhEsCGGJt61GXF5mTMTpQiRDA9HFGU0BEH2s4r/3FKhchNM8IMaFahAQA9I5kZ5irgwrpgie0hV58VgX5y3Rq+RfL6M0Yh565gq6Okqi7Ywd8+OzL/3prc8ZFr+9UxgdDfN1R7M3zPHrcTtwYFnxos+jhxjQR2LoE2PZLZLv9YbtRxh/cpftPTMj4r8QZdUGhecxbNpKzfa33Pz09MSOgyD15Ff2wU3Gs8nONJjvYJTuRBhNL1hhgr8c9AtgAUlaAs44N4QFwqGTBbnZ0RKNp5//NyCLaPB1VO9L8hCmfRL36kSnKr3XoS0shQiO3eBCIlgPR1DXzxT7SECwMu2x+FIzkOD6zVIYDT7dtp0JtKMFQ1A7iRtZgfgE17FRKql08lPFPpIF79U7JMVUMQHfg5Ud7Mgh7cXcHl2Nmg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(8936002)(86362001)(508600001)(44832011)(107886003)(6916009)(6666004)(38100700002)(316002)(2906002)(36756003)(186003)(66476007)(83380400001)(5660300002)(6512007)(6506007)(66556008)(8676002)(66946007)(2616005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wxSv3BXP7mwvSA7qsQ4PLRTOXZc4d3pABhhXMx/puhsWQPdKy4YyNltKvQG+?=
 =?us-ascii?Q?m9HhHahf8yS4dI/ndPjZHjlUFFgH3w7S7d1vJTWI8N0IX2SzSJeq5zuGfuNk?=
 =?us-ascii?Q?/n59+1e+NYcvUf9ubMf9seJpPXIbLZp0HpQN/Z0ohKOGEviWLTfJu7XJ9M11?=
 =?us-ascii?Q?azvkl8EfgoVER7p2YOfW0+VRES6g2h2NdUuL3H6sxb+4Nxn86sAiZsQ39OGk?=
 =?us-ascii?Q?Q5k3B13B4Jk2vLgrd37hz6X66yarmWFaWEAVh4cT0F0jyMSRNfinRni5VLFz?=
 =?us-ascii?Q?4gagxbYEYCMfjlG3DpgC8vaESJBCAmgXFQxL1hfSP7mllGRYEFecnCvY9C35?=
 =?us-ascii?Q?UGM1Q1nj75EPUOZSHxArME40ZcKyLijU3L5T812AWOJVhaRPELg4pRl7upoi?=
 =?us-ascii?Q?PimosJrih92TvYbePrXFaqJY8CaKVvE/MkuijVsZm4iWuLc/Wnh3WA2CkUX7?=
 =?us-ascii?Q?RF8crpgK8mZTg7AdCYJ1Nkk8gqnpzpJsY1wI5AoouCCo+PXWLJrIdi9y9QxQ?=
 =?us-ascii?Q?fDNax4TF2uHNaR5k/kb773w88lRyJ080ERh8rhteBqnA2T0BBXnhZN4ttTMe?=
 =?us-ascii?Q?q6A89m3EOumOpLtBBJnz1fTsXSiR7Q05D9APNl/9cBGLT8ntH2a1hd4Mde1/?=
 =?us-ascii?Q?48dtJ1VZrG6V294sFmlEDXChP9oustxUHO3zv1T7I3YfPUkfhtgZvqZuMHCr?=
 =?us-ascii?Q?762ymJNFfjqWcK1UMHz1EMZUkFupZgejbs98s1Ac/b5WhZTLw6klHKXNdgC0?=
 =?us-ascii?Q?sFjGajDpTMxvZjZEhE/O6LtYNHcCkCTJTR6+OzQ3ekUCLxDSICavb++7OZgG?=
 =?us-ascii?Q?7V2iak7eMl+BKrJI2qsmSxwejvhtPcG+eLaqgNaXkDNQCfAKjeVPUNeeo/6M?=
 =?us-ascii?Q?pQ03xGoqbpksqqfZcS0jlno3bXX/pb+pcugeAPChcusrrswaNFR1PXeib4jU?=
 =?us-ascii?Q?9+Ei+GNgf5MkzIwyQl5nU5/jFzI4Lq4z6bgmbJtQsiHIGBZZeOXbssHtkst1?=
 =?us-ascii?Q?9e/YEoBYgC8r/SfdTBqkDsf6sKagUX4iQot+awOtXHn6flQPXg+1epL/nyo3?=
 =?us-ascii?Q?i1Y1RY31IjT+nBSvxjAQMD4K4LE6yS7j9z4YWUrxPxKAg0VFS7aEAyYznd8H?=
 =?us-ascii?Q?FxEy6d87o6FziS95jSoFolvHluapsQk7VqXtEm2FyNRZ/mvsa33LTcdQnlnk?=
 =?us-ascii?Q?fZed4HmIe1UkIjt4Dzm1rxWNtYcHxSt3DcT4WLRe9XNChLjVpyX8ruYulw4J?=
 =?us-ascii?Q?lacT0Z31nov0yvahMQwkNSxTW8v0qEIg0DeM5QPGCQnbZNsPyygCnsFwGoff?=
 =?us-ascii?Q?1UgZz4BibSA8IkJ+GqM1yPzu50jQj/yFSlYNGCtdgw3Fzs70EyUcJyI37jyw?=
 =?us-ascii?Q?yuYhhF4ZVDe5qnK3FnOS3JgGKrXZn4ZqK8pcxaBNeJAeDloCbO8sSyX0ABq+?=
 =?us-ascii?Q?nlTiVGmQ1SYZmJPjJMH6DKTDSjFNOaOWf+DFLf47uwQcXtH7RmQXCUGMDJJY?=
 =?us-ascii?Q?cLhkVL3yf+WxULXsJH/25vK+1qXkwu8ypIpTOwFfvQqkK/5C/3AXDBtY9BfO?=
 =?us-ascii?Q?WoQH60EvLC4R59DEL1QlY2wXOFu5ZzP4WK7B2vD5/T6kIV7qGKmisK+QZIZG?=
 =?us-ascii?Q?xmM+3CltNyItvjtW2qwZMDRHmx62dhqBH9rDsQ4VTKb4LLwtGp1GPB5EI2hZ?=
 =?us-ascii?Q?W2TVtZsQSUMldE6InsqwmTJ2T+Y=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db592261-8bb9-45ae-1f10-08d9d6a6c16b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 15:09:55.0698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvhK86NcEGIXuipjUV6kS8TEcGg+yuvzflKaXfCeUEecyEbcnPLiQthMWuX79taKq1N+RG/KljxJGbuEMWoESg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361

This patch implemented a new function named pm_nl_set_endpoint(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use to set the flags of the PM
endpoint.

Used this wrapper in do_transfer() instead of using the pm_nl_ctl command
directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 31 ++++++++++++++++---
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 06b1a3823bb4..529765f3ab5e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -376,6 +376,25 @@ pm_nl_show_endpoints()
 	fi
 }
=20
+pm_nl_change_endpoint()
+{
+	local ns=3D$1
+	local addr=3D$2
+	local id=3D$3
+	local flags=3D$4
+	local port=3D$5
+	local _port=3D""
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint change id $id $flags
+	else
+		if [ $port -gt 0 ]; then
+			_port=3D"port $port"
+		fi
+		ip netns exec $ns ./pm_nl_ctl set $addr flags $flags $_port
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -577,7 +596,8 @@ do_transfer()
 				local arr=3D($line)
 				local addr
 				local port=3D0
-				local _port=3D""
+				local nr=3D0
+				local id
=20
 				for i in ${arr[@]}; do
 					if is_addr $i; then
@@ -588,11 +608,12 @@ do_transfer()
 							port=3D$i
 						fi
 					fi
+					if [ $i =3D "id" ]; then
+						id=3D${arr[$nr+1]}
+					fi
+					let nr+=3D1
 				done
-				if [ $port -gt 0 ]; then
-					_port=3D"port $port"
-				fi
-				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags $_port
+				pm_nl_change_endpoint $netns $addr $id $sflags $port
 			done
 		done
 	fi
--=20
2.31.1

