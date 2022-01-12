Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055A22C9D
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 10:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641985057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSsWyrjPjjH2+IhrYEuGo8p54SHH0oawUmzBjOxdvq0=;
	b=g0h0dRGkRHyE4HYbAqUFnKyOzUEu0jqWZmixZoywuXTNv+QLAKi0ef0goyRymOJ+034G+M
	/R2mhiSOWAel3DFo8f4XyUHiCqBhKYiYdoawP0JVWt3L3T7amYoIzGAcQ7OMpd4vndRWz0
	xhjzXbRHm8asM+QYBvSOnHfTG/BJO58=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-Hw6jHqg4PYSHAWzEeHK1mw-1; Wed, 12 Jan 2022 11:57:36 +0100
X-MC-Unique: Hw6jHqg4PYSHAWzEeHK1mw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyfnTRbwiadPhs/syQSuj+6+rOC9c2ODraXLE3TZawrvxy+j7oDfudZReKhou2I1bh/5GNlLyjMsFUff2qUPKGP8WSQv3j6ZQYxr1zZJRXji4BaREBkvxBSco7c55zI625nVuquN5RRSCTmecCQ29FQ3OMW/AOjXJUYbNVPAPvlQ/FrZ05KFdEKUwR2OiKGfc61cuvffunZ9za1K64cP7jg5s8dS4sndUy7cqA61Zmc8npUDiNUC/rBfb6OPtI8tH+vTD4+RbAK4zv7mDDnfzH29InJRMj7r8HxvgqrpZtWd9+7s5SFtvaUPEgLLl2ZSIF/dE981WPxgGAC/xYFI8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyF3Qzxq2ZW2MLvOD8T1degP8A9dxLuRM/+I6oMUCQ0=;
 b=do3+pCPc6rHK0B4caKX6dC29W4PI8BcvZTTXOfeBcmtiSLNJPXWl/B1uUVVfQ7jsMzn95YJqYTfMiS6cxfm9q5fDTzKzxmojdS1+HQgCrYrm4H2vkod9cgHxhR1ztU7YNl3ywSfUlR9xBC+SrqFmd7dgiHCCu6r6+GJJrX51jEXXhDn4hKZjs1lsRp3bHV7QDdo9MDWP8I6dFjF1imoq4h+6dHQbhc97XflanVLlSL/0CO1qsE6i8QoZA1mTUroMaIlNHnmhcU0dRGYyFeP7+9gqAjY2rO4idL0Nu7ekh57KvJ70aRXRVK8noKLK+6TdM7m8phHX/HZpvplpDSLTQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3483.eurprd04.prod.outlook.com (2603:10a6:7:8a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 12 Jan
 2022 10:57:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Wed, 12 Jan 2022
 10:57:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v3 6/6] selftests: mptcp: set ip_mptcp in command line
Date: Wed, 12 Jan 2022 18:56:46 +0800
Message-ID: <68c839ee370c92fbb0d27beb2e37ae41f171308c.1641984855.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641984855.git.geliang.tang@suse.com>
References: <cover.1641984855.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee5783e2-6536-42f9-03fa-08d9d5ba5736
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3483:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3483E15955D40FDC6AD2D48DF8529@HE1PR0402MB3483.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dHiCUuU4cSbt+fEv11xclNs6B1AnCyvkCQpZ7RxZUSq7Rwc7EgJC2pn4V5Pp0wNOJrk6dcIqK2u7Z3Qm/MasnuFyO1ctzMCFNnkeRhk5rqgE4HZBWQZ+pM39gv+AQgVvDBET3bl+cAg0zu2XtIjj3huww+wSdE0BSVg0zDvqfWSasH98GqqCGmovXWEHdZH931yud35EAT5i4I1ft1pOhL6/mEFkkGiRpN9NsKT4hZs18wGhXHJvSF1VMiIeDpmz0VSxij1Qnv9+9031NMRM9QVszP720tNPISlEdDABZYoTA6L8cXwSXELulOfyUQtBQ/VRb5OqpYaCzifccBP6AA32RDnxzpfRObbKfRrDRJ60zOaYjyl2w84JGBwy1WDhFLDn02mY5QPCYSWKPo9obXAuqYP+SH/KSfC6Ll0gqAt3r5DG7MJvoqviHQttuphweeTiPmga/9BPt+bJ0Noyv2DOdNEuw0nOS49z3Wwii/Hy6gJ5SL3c1qo9QF2cCRdbMdAvtziEtnY/X/QmOFxKUeLeIEZou8BmlIJARlrKMz4pQ91e6m9UXL4QWwg7L+1wO9oXKIAJXYWWAtQE9ngTAbVP+FNKNs7yFwdAM5HFsdOs13b/jS/akKRFsAL0s9mlfvkzW+mp5bY452bVJwdk3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55236004)(8936002)(6506007)(107886003)(6916009)(8676002)(36756003)(38100700002)(5660300002)(6666004)(4326008)(186003)(26005)(508600001)(44832011)(83380400001)(2906002)(86362001)(66476007)(316002)(66946007)(6486002)(66556008)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OJmdko2rbPaISJzx1AFW3398gzzlGju9g1EqycDXzeGTQKe2W2JQGLC3VuHB?=
 =?us-ascii?Q?p+DtsgljJkIk0QRI40BRjskMRjooJUt/tykMfEEtcSQ3umd/h8CvFD9vSbmX?=
 =?us-ascii?Q?wknGF6flX4cPHaXFQLWEqStkebbqimV5SmW56UuS8gHxK6tDpbuzuC4hzUll?=
 =?us-ascii?Q?DGyGVZxejGKiATkhLxorqI9FARZ0XvkTM5l9RK4qelZGTA6c8BcbIPdM6U2o?=
 =?us-ascii?Q?sYs0Dlv8Zwdu+MvZCvwtGDyoNL5nPOPw6IBwgQX5xTrOqMybnpvPeRXU+Bw9?=
 =?us-ascii?Q?TbBa3UToDLtl8+CtBLo3sAASXQ+Xj/aQpM8E2SOPzMy4c7YlxpU1tuxd+TUr?=
 =?us-ascii?Q?lm7hTQCmmEyCc2k0wmAACEV7iyqZrpGNghxGkuAfqdfPTkcwgyfUGE1WpqXA?=
 =?us-ascii?Q?UQTygTSbpPmlpEC6taarvc4lQsK5AdSlFCrxiqu+x5rnWuaktO2JdWnYyYJs?=
 =?us-ascii?Q?EbL1RCd0cLplnXtNPZ03Ydu+8SpgHt+HGu6lKUpPdFvnPG4B8OYHw80PC74t?=
 =?us-ascii?Q?Ac5O5OQGycYO+O86xOfSua2XXUx4Zi5ja2Uem77fDXiPOrvvh6SXEOh/q7DU?=
 =?us-ascii?Q?MYq8HDjiOcntownAyPWh5JU/R5uTFibOjJ+Dc2nDRrf8i17a8Q7A9HmVpTpS?=
 =?us-ascii?Q?PHsd/Z14bQmNMVsvol/43O78LZSRRy3Wh+SU1aYSpTbXt/hkCMPE6YADyzCS?=
 =?us-ascii?Q?5jEHnMDcWzAmxo+LY3TMCkWhAt80teHq90zo2GK/WF+5SWyVU7ikraA9QSWY?=
 =?us-ascii?Q?0qqOsbgdWw/Ab+BBlEBgxsu2vf2TQduw6ImwFM8SrQMBAFPwb015PSjvUI/y?=
 =?us-ascii?Q?9wZ0yYgk5zjyl/eLvlKRou+poO/+q7T9dxPgCLRUO8FwlrSReVT887ZuiMs8?=
 =?us-ascii?Q?iiWQz7qpEw1uF4Qf2w+AaUpCcvOkheXI7pyqT/lObYHmmFfAZGG3M3WOnNyM?=
 =?us-ascii?Q?UV3Q5pnwT88OWOQYWt6NdSINcKbg9XkXSt13Yf7AIaGpOgghhxbTamppOzn6?=
 =?us-ascii?Q?IV7kwIniGzmna3nNjf9sLCY6oLOjuvB0eA+VPTNcMPZlh1tUxlohD0z5Ss+u?=
 =?us-ascii?Q?KhGwNFAdpQiGd7u0BRjW49/TzaonjJwxSoIZ98ynzOTcnd6yGtBi/A8+oKI3?=
 =?us-ascii?Q?DdYjTiY3NnCNFFEbM1GVVOtLZdIV4pyscZ/zGo1JLAywk5vxSALgnmq6Xlwx?=
 =?us-ascii?Q?FRCQwJU/NEq16IQ6uStvLhZWrByDBIXYF6KbcLo7wn412nVgitN/OM4/iyVX?=
 =?us-ascii?Q?OcVyDFc1qsUDMe0DxTKz/b4YpnO06Kl6/ZsR2wP27jj5400TREn/rRi2iQDG?=
 =?us-ascii?Q?TJxz37ccsjfh+p+cR7AOBTC4bPMXwY/XQg+s+UHfSaLNpoRqoIp2+QC9EksR?=
 =?us-ascii?Q?78FvyhEP0PsJOUoT0yB9cjjleZrocpeAXtdNOTxKG0C4WLouJPp/LBRhAzS9?=
 =?us-ascii?Q?iCLMiPnVRemFzCWQbUnPZp2LRv2FD7QdXiXAVX5JAsUlWuNQ+0QPQMf76rQv?=
 =?us-ascii?Q?3Nc50U4k5txC4D971HmhiSacVuZJO/odyO2frPt3vX4uWtLdtH6X+8lwPYKn?=
 =?us-ascii?Q?4fZbkSvilqYm4GSVFaPq6NW8CTOVQR/DIqGo0wMkpXKwtbethVMoiy1WCJo1?=
 =?us-ascii?Q?Zi1gPQraKbAlUTl+Q6IaYNs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5783e2-6536-42f9-03fa-08d9d5ba5736
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 10:57:35.4364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQTUn3IVLgiNKlaplaafm6Gv7j5FlDhBTEOT5jkW0Ea1C/e6e6AYJWtu3t0pztWHbJ2ju87yu6j5czBgKXRoIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3483

This patch added a command line option '-i' for mptcp_join.sh to use
'ip mptcp' commands instead of using 'pm_nl_ctl' commands to deal with
PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 512dc92a5646..647b435e4e46 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2180,6 +2180,7 @@ usage()
 	echo "  -u userspace_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
+	echo "  -i use ip mptcp"
 	echo "  -h help"
 }
=20
@@ -2201,9 +2202,12 @@ for arg in "$@"; do
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
@@ -2213,7 +2217,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCS' opt; do
+while getopts 'fesltra64bpkdmuchCSi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2267,6 +2271,8 @@ while getopts 'fesltra64bpkdmuchCS' opt; do
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

