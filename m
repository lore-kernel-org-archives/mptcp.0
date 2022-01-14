Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9164B2C9D
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 10:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642156084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/IvkPZo4lwDhppfDXy3vy735YdrwZ46xMsz6HvSjbQc=;
	b=G3A23JSCkyasKyw/TVxMmi2MnqxuGBD1UHp/kdEfbSL/+l8LmVRxFDqFvzGhV+AuYX0u4M
	rI1pHm2RWH4kdG9baE27bEF+clSfpaTpv23vgYeamRFgc2ju6t7WtbV6247rGu22/Lqzln
	cVTeisnFkx9NDHw5t1joFB2oOfsCgOI=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-hPNCwNQ7NWyQV3W87QiJqg-1; Fri, 14 Jan 2022 11:28:03 +0100
X-MC-Unique: hPNCwNQ7NWyQV3W87QiJqg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1ED6ckTMzvjiHwNSQ1JPU57tyxmpPZxmIjq0eMZzfYAIQ4huM0jJbZcjhvhQNBFbexps96H4kE/PyvEg0MvxF2/AfhhLE0fqfCHS1xTZhj04c671JR0HRZjsckpAqsfpk31cauDKBT4q1wcEgE8T1VKjp66dZ6/Kavi0NZo9/nLBrP0O1W+uY5kEHYo2B2yG/fFATod6uOnbCLvOHTlkq6VKx0XBsqpRZj99xjhioE+vWobrqgYbqCG8yMBRHeUZ8gUTushC3oTyK7CUhCboyZLijdbVwlL2TfchiFCHNScXxCTnYBMG8nHnhBci+YVASY8qnE949AWWzdqAomzwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8M4//1L6gKBj88KjSgw387GfjNSYPYui9aZ1WGG7Jw=;
 b=iZ1yL+wJTJgxJQc70RLHsP0k/kkD/2oHCyuamnzrRqPRoCxPG43iM14+IrntDQt27jhOuAQbdOyk75KWGPXCbQU1vPd/wzWeRWheqjJeH8/EWounvIzhlqGEIz2f3sMJzUPhwflQStArnsynRovVXHv14njY0mUKXt8+X16ZH0e7VpFoHLpvz9MPSVBfF2Mrbwk5+erjtpweZ1BZGlwh1Tam9Dp5wxhOImiWY0uz8aY/TPxs+vmYrncoTEk1OR2y8sD5QxPlORCDSUPxLRRBqQKv4mb2Y7IST/HToC+EqFORrFd/Kc0OvZTTTdFFZY+eAAu6o6zLfTpX/I6WzXzZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB4558.eurprd04.prod.outlook.com (2603:10a6:803:6f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 14 Jan
 2022 10:28:02 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484%4]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 10:28:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 11/11] selftests: mptcp: set ip_mptcp in command line
Date: Fri, 14 Jan 2022 18:26:30 +0800
Message-ID: <337113ce83fd60465eda2d21a0bfeb18f7853528.1642154579.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642154579.git.geliang.tang@suse.com>
References: <cover.1642154579.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0171.apcprd02.prod.outlook.com
 (2603:1096:201:1f::31) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c289dee-c498-4df3-39ea-08d9d7488b1e
X-MS-TrafficTypeDiagnostic: VI1PR04MB4558:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4558722479E78ADB5055CAD6F8549@VI1PR04MB4558.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d36VlLzx3Z1G+TSHd0X4cQIYZcalViwQw2G3kjGhgowkC57jwnUvIVe7dJjNth/1qILg6Zzh7JOyJ/1HHPOB/rwO80AyXojbHRmh1qSNe2dX80Vl7Er4ylknuep5FydXDMfNomCYLCZfC6QS3s9rJ9I0Zk+V3Hh1Uw0KcBcsuqyFcwl260mVITEVez8lbvRldq9yVcz8VVdwOpBcHAuU1GI/WDjVj+IWdTK/jI7BHcEVRvPEDQM7AbLyCNEteriFrfr5oOPTHUvG/p0xzDpwpMc6GQZ6E8FDtOw/8zkyRcwsgT4zHI06FFJRLnfk1V9YcqJOcuOeIoVDF98db6VGvLXVBptgZAPyJkzS02rzHWSppmgM2GeZX8VMnRbIf1x2BWY65UA9oMyATz9+gWmQblX+uzjP1AGv3vIBPkyJcsekVrEU5HNQ+SG1uwXGQSR7aOaiiBEYz2nugrORHfMA4s0cZqteZXrF2+U7Gf3Q5Ffk6QxM61VsMlb7s6eW3mqD/DRZmD66uR0GvS2Cy/DE0j6NCu1zRnnxCG1pQjfkTCnj3Wsixug2s4qFV/IzpEtZM+vvSPg1lH1RFzG9u4ZlpcoG5a41+b5593ruoeSR+i8L9ZpCCDIUMs9R6No5wwFkTzCZatzsTbYewLoJKP4r3Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(6512007)(5660300002)(38100700002)(316002)(66946007)(66556008)(6506007)(8676002)(36756003)(86362001)(8936002)(44832011)(2906002)(26005)(4326008)(508600001)(6666004)(2616005)(55236004)(107886003)(6486002)(66476007)(6916009)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bZAJs7OYYybVNjxYFCz14oDQgTsReyDFwqrVqQ/eCB/tzhVmMRGoGN0a34E7?=
 =?us-ascii?Q?qdjz9rStMKOXk9KQF9At7pSneXBo5fdhv/dETchYT+h5AmxiQzIzQSknX6cK?=
 =?us-ascii?Q?SAfByS62A44CeF1TIZO6HxRLV9dm8NRoOky5FDWVq1c6AxQIgHTT51C9yfkI?=
 =?us-ascii?Q?aO6gOK8NdbXiHkgotW1XDfVroa6CxhaxBTEohniwNQOTu7JB47XvVPxTCQ5m?=
 =?us-ascii?Q?Jz0mGpu8jqC/TuoopjGOWGCf3l0kLmXiORkVvwW+yDLC3GF55DhYbh1SbHMF?=
 =?us-ascii?Q?t1c5zYm6egqSeJUtU360w5j1Wwt0l2kasJ7RWZM6SciDKprR1O0yGaihG+fV?=
 =?us-ascii?Q?iXgFK+NttZ4CN3MLX6eO6shIxV3g1TliQte0nRxFQm2dh7DeSFeIB9YBPnc8?=
 =?us-ascii?Q?4uykwU90ti9YxSNtOrp4rjAU/5GlV9JI8t68fXhS9kDJupYfbCZddKg2qjAY?=
 =?us-ascii?Q?jf95rp9Lt7fRQ/8htXQInhLnw7cYS5+QnIbEPNmeFiQjLXkfdtCFUjRUjfxw?=
 =?us-ascii?Q?lnJATVEUFNd3Yv4fpDJp0ANZIVK+CVOjJEqUTHVrcY51pCGaRFCqrAYqjaev?=
 =?us-ascii?Q?0jhSpJCBgNvSAzRvH77HYXNtaxds0sZtPfkUV2baKKsj41ri+0g2IVPX08mm?=
 =?us-ascii?Q?i7/YYZzOkZz1VtotnHCkzbyMDw9Bb5MphiFQvuZnZ3wldpdZYc4Wht3m9nSA?=
 =?us-ascii?Q?N+92TFJriHjQytj6+5KvrqCaWkYCmyVX9MmfeJ9C++7OH3nU6UuYFFcYY1zo?=
 =?us-ascii?Q?zGwk7aETQiHMXcA5v5xn47o+pIQsoIsitj1lzqv0eqoMBawbYMtcm2Os9e8e?=
 =?us-ascii?Q?n52eZAKAFe3mHekMEQiMaiAJe6/F8SNAhXtC4V2Qdq6WE/kr+ol76wm2E6LA?=
 =?us-ascii?Q?Os5aspNnLgSSLuPN2yBtCJ4U+BjKJpyyVgXWMWtaf2+ElQJ7fcOue9AGjfv6?=
 =?us-ascii?Q?K2nsYiE0SmW/3spJoqA9quz7tS3sE3wYgtsqmuBhUBYlSdqTmI901fZuHdT6?=
 =?us-ascii?Q?Agi2CTJt2Mc5hx2A0DVq7PxrJYs7enINeyGGd/v+fOSJSNceGgCtH9r6/KBW?=
 =?us-ascii?Q?r63WJlozetG3ZK90WbKOppC4DIdxOGYjy+z+sx67iSFGacuwXrZh5NTPselm?=
 =?us-ascii?Q?7dyh+lXV4IH4AazGMTjKJXiCxb/qm2DilOe3f/eEO5jT1zamn5LN8TRywJxE?=
 =?us-ascii?Q?B69UQ6+bBcxaXXm9VWoHZakWbbI8BdkkjDNtayseAkIp/TBC6Lnj2mDfcfEj?=
 =?us-ascii?Q?yXAzPNCziy8+fqFWxgd0pMbS99uVMQImqxBB60qUcRdJb2BJM/rZMRlnoGP2?=
 =?us-ascii?Q?pTC7ptdmsyeU1Yg4bWVnco5Em8kZoxXTU/I3rfmo6PqB3uCF7P3h2xQH/Q7M?=
 =?us-ascii?Q?Rbol+S9gQ54/Y3bfP6SsUcVgAGafMPItOGkh0jt8IsSrKxlOZNOYlwzWlarU?=
 =?us-ascii?Q?TcWeWIQby704KQGjkQYJibiciH4KhqYOoWESRuwRDn70j6ftv4OME4IXh4WT?=
 =?us-ascii?Q?/7vkZeLFEwVPkoD8Q3Aqp4iF7lSlbtRwRXqnf15pIm73M0gTkiCPmJkRkSvD?=
 =?us-ascii?Q?XK8NXjmhrHeBj2DNfdPHKCPZ9vlf6sGMj6im8F86a828g8kE8I95RI0uj9bl?=
 =?us-ascii?Q?4oE/Mk+88ql0O7Nha5HR/HQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c289dee-c498-4df3-39ea-08d9d7488b1e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 10:28:02.2360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7q2nmNKMW+b2Uzwht0Lvw+LDxiaF/CZ7L8IkhHuX8sXaU7+aCO+wqumvbK0xR3ZCB+WYXhxefOjIWKlxmfDUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4558

This patch added a command line option '-i' for mptcp_join.sh to use
'ip mptcp' commands instead of using 'pm_nl_ctl' commands to deal with
PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 4df7417013d3..c8b7f84547ea 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2220,6 +2220,7 @@ usage()
 	echo "  -u userspace_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
+	echo "  -i use ip mptcp"
 	echo "  -h help"
 }
=20
@@ -2241,9 +2242,12 @@ for arg in "$@"; do
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
@@ -2253,7 +2257,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCS' opt; do
+while getopts 'fesltra64bpkdmuchCSi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2307,6 +2311,8 @@ while getopts 'fesltra64bpkdmuchCS' opt; do
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

