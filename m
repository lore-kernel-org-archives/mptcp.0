Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D200648A3
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 10:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645180739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q/XcjH/YmKwU28+JZDtksyDK6ZyyRmf5lrbHP1v4igQ=;
	b=hNKGuyPagXlj3Ngswy3IfH/pvWvyJz/OM8OwMAsm9cTSNP8gDrBikatab6ke9keR9TWUCY
	Msg6hZwl+4Yn/pL4sdMAeNeW2K5ffyjGYSJWZCxgh1lM4pnlY+KjBr/fSJFOdfUYYb0o/4
	3u1F6hZc8L7Xkh0HsAUG4AhA1gh0RC0=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-RGPKEt2KMC29YE8C6b7OIg-1; Fri, 18 Feb 2022 11:38:57 +0100
X-MC-Unique: RGPKEt2KMC29YE8C6b7OIg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqW35QisSvP/OSYmRyqTKjB7TU4Bf8u1KjgiuzvHG0mSjtTw1U824v+e9JXrPF9WbDqicCCmMprvMvyIou2q7WryRif0tT9dd4VtAtyEm5VJvTrLG/OWfiICFriAv/FiLhzZaMxlX+qGDkFbg1oKbHp43NjE0iZf2SQxnF8yXwIEMbTSmqKf5g1jsloIEd6d6bAjaS3vPuntL7f/qCz7bxdnaNZ9j7y7syqxwtbtTPyHcM4cwBNFnGt7FDUXOfzUIz5dBF+Tu61f+INAbnwvxlmeqf7mqCSaZu4DQxqmn5wLy+3WlrekFBZsnLeFMyaydTJ4dFqSNZxcOorhmkhwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDoSxsQRi74SEVSrx0u9mdstv0JQsjTuUDmog0XOhMY=;
 b=lz6DkdsY9xe1Kh3SbvsdkebGqW/svuM8TWsI39rUaD5guyF+6s3mpwPcViUe3LW/E85ZSqU0/gdebDMJLc17IcUemOb0t2xrN1OaqNJ9FbHpwtXH24bQE+oazIv7zIfUPI2Zo9kTNF3CqFzLIGUHf/dPEA3g+Y8ZgQrUlPmN+RGUIpEfFoegXe1iYBe3QZkCEb9OSyu6vnTSw93CZIur/h3seD3AbGFG6kkA0w2wFuTAKetfPb5OpUzVpxSXtwFxpGcoTzx4YjrjbXoY8B1s0qM4+YYDZHm22q/pRxo2v6OQptWGO4WoeEWIrG/AQk/cLJO88NgQq1AL3zsm4bWOyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3923.eurprd04.prod.outlook.com (2603:10a6:208:e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Fri, 18 Feb
 2022 10:38:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 18 Feb 2022
 10:38:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add extra_args in do_transfer v3"
Date: Fri, 18 Feb 2022 18:39:23 +0800
Message-ID: <0ecb29a09e1b2768ef1166a33dc089e1fa3ae339.1645180743.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:202:2e::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa6758e7-875b-44f5-d904-08d9f2cadd67
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3923:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB39236E63E6D454FE0B2B5DCAF8379@AM0PR0402MB3923.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JvgU8qnaioaST4QflbUxvsCMCzvfnwYRN9rKTNqiOG44UjKXlhokdXUv2VEGZAwDHq9BNVuDlTDiKFza1kuxK0v+gdUMCrJ21wBAD672skVNMMYj0DSQWtV7rQ9e9rmiEWDOyP/zPZosz/orzYCOLkQz6QWYH5TSju+97lOWP1hbaChEeXtBZHtLwUK0juynF87vtq+MUWP4uIJccARun30Puje7wH06WybifzDMDIKBL9Xpxh+PGx5DmVHewztZM9ECUrb1uG+A6jIfUz0Inl1OIThOpfXZK6JX776AjgoKNP+jl9Rw6QYPSs2MjnoiR4wiFDA7vONkduVpvcdSRDCCyPGGWJf/bIatbYs0Ph1RJc0sKPR8C94oBQQxyCPAwcoT87Hc4pX1LD1A6SZoR9rZHeCgZbTwz/7dQosoXEU8kA9LNAhhmgV4u0VLQCA8bMlq1alTrI8ghPE9WE/xthbW5zPTSFllCkdAWW08+wGg9m8ENtvYfahVlVMxwQ59NjK6SKbB+lAINO50onxV2rJVmqlAfW+FOhWFZYlGCVB9ebpST88xJXHUJmVbps0kpoMuKbtlmgzcukMnKGcjQby4ZlKNgqWHkrR4nVILpSz9tdGdu0qtamy9WlkRh8VkLliu7felEWsiyHCY6Ye1Xg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(26005)(2616005)(6512007)(83380400001)(107886003)(36756003)(186003)(86362001)(6506007)(6486002)(6666004)(508600001)(55236004)(316002)(6916009)(5660300002)(66946007)(66476007)(8676002)(4326008)(44832011)(8936002)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f1yxCiIGVdckJf887GU2XWLnAoh4hGSQmch3kG7+MdmDgAU1KE3ryz/F+r+Y?=
 =?us-ascii?Q?F5OKHWKMwjozmSVUZjqWCcWrjK23bzlefcn5EMUh0bPSXI5zU0i9drQYEu4x?=
 =?us-ascii?Q?gQ46aGlXK+57DL6sEl1Owc5LZ9UAXccJ8or9agL8CUAg2LDRmsCn2zFNDDOm?=
 =?us-ascii?Q?sDgdhGRdlVditwzVxCIAyD9mlpR1ohE+MCk1PUXnpzIIISPs0lOOKXNKCcIw?=
 =?us-ascii?Q?EbKhuhMNGgel2JkFqiYdGj1RcvTzxsHay++Ye7D9ghIttBjRCKtphRg8Ho8Q?=
 =?us-ascii?Q?kQqNbO5kU4u0+zs3GU1jjZ9SDS0Pu9cJid2LeV3AdMeG7osGX9j5Hni5MLbF?=
 =?us-ascii?Q?rwoNVoFTbs/Y6u4aEbkO2J8qEB7CJJ3aL3qunkGkGE+5KasCOQpHiwQol1kj?=
 =?us-ascii?Q?v3xHPV4O0LJ2XzjVTipP3dkGb2kME4FSXMdgPyIv/JhotznxqZ6ivK52Ik7F?=
 =?us-ascii?Q?eMrtVZ3vQw9I0o/gaAiAVm5D48LR1C0CyswYHc/SJE2s1UZ6XZ/kdr/zwDsT?=
 =?us-ascii?Q?nVjJ4wLfxNwVUwAmE76+Sf1XKiAV9xH1vww9Vte6hJxFn9sFmH4rEZk5DfIx?=
 =?us-ascii?Q?D8qGzAK3tvSm2x7MGYpvg7bK9boZeHCmYBJsJb5JzKK8+Uf6y7KvnfQfs8Ug?=
 =?us-ascii?Q?t05c8CqnjsUCM/opqJEhj25UV+v+0QplD4j7FDxllXVcX4pQPW0Eqe8PAoTC?=
 =?us-ascii?Q?lPM+swu9bzFyviPjRJmmbKxr5evJkFHXqnXluMLAJWOh+sa8m8gx9ut6o67z?=
 =?us-ascii?Q?BTnzemLkb9c4z2tSPIOvz3m9E4Am2d2dcsdNY0asxY1In7sJoMIPrSCOGylF?=
 =?us-ascii?Q?72R8BQrpWxN50lEtvJQAi9vxo8sGhKLiEAbie1sdtY6HPZglQYehFpaTRjTB?=
 =?us-ascii?Q?Iu3NzWALNPL5Ect/CJb+UbAAFHDYc9jq3roDjMizdjzBnyXogvl5SCWMadN2?=
 =?us-ascii?Q?86XdAAVteQMaTI3avoq+cHW1BLrCV+1k0Jwvq/HXv8za+AJmA5kXR71nMvpf?=
 =?us-ascii?Q?SQ/vUfZZtb7iHIQtdJmbQOS3P0GQzwACTGqOQ+0mJgXHMSUfkB0Vn2l/G6Dh?=
 =?us-ascii?Q?pEkgneU+RLxorjYKSJ06RIlhkmSvxw0mUImc7AeIC71U6XYWfUngUZC49ROP?=
 =?us-ascii?Q?9cQTIt6Zh+oMhA3SMtw1UlggQydfCJtFreild1WH3Xb1uAxFv6g0i0Qb6yrq?=
 =?us-ascii?Q?f4nR3kg6dmSP4Dtg92pe5NX6hdN1FeWgePGCksFao8QMC8EMz9jmkGZ9cXd9?=
 =?us-ascii?Q?8Vt9PteBLM/GG7Luf4DK+uGaD1zoYKCmRPdoZM2NVqMFeeHFDbFL3LA9abU5?=
 =?us-ascii?Q?JZmRVdcspZJAq7q5VdVC7c0U1XPI4DHhJkrF2N4gYX9w73DRzp+OOA2D5OT7?=
 =?us-ascii?Q?91Puads+85We5hsatK4rE2EGA/1j68PVp6tbq3h5jxAiCycWzKmduNNWAnFe?=
 =?us-ascii?Q?KAJ53EF2Ax8mZcPft3fZrUnWPJb3+P4YX9LEJM6lsZ+oJLUXy5vbIFvbgI1q?=
 =?us-ascii?Q?taILNrSCSt22KHDp9KAiJKhy7QG2CKaYwtjEOHibuPxWauvh2SpRnnDMwV1C?=
 =?us-ascii?Q?INKDTIZZLpOdVGj10mWsodNAlFRO2rzNeCmTK7wXAaPV9XWEYOEItD6edmwK?=
 =?us-ascii?Q?a7mV9a+TlACKW3+GNrOfwYw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6758e7-875b-44f5-d904-08d9f2cadd67
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 10:38:56.2459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGwYwS2JmPRKPjTDN8co+eMI5ZLLbfaAmNt56loXFXcKt712LHqFmiKSlVferLj51FLJ5ZStbtZ7yVcPO9rSpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3923

Please update the commit log:

'''
Instead of using a global variable mptcp_connect, this patch added
a new local variable extra_args in do_transfer() to store the extra
argments passing to the mptcp_connect commands.

This patch also renamed the speed level 'least' to 'speed_*'. This
more flexible way can avoid the need to add new speed levels in the
future.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 8597b4a52f4d..ccb11eeea723 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -458,8 +458,8 @@ do_transfer()
 		extra_args=3D"-j"
 	elif [ $speed =3D "slow" ]; then
 		extra_args=3D"-r 50"
-	elif [ $speed =3D "least" ]; then
-		extra_args=3D"-r 10"
+	elif [[ $speed =3D "speed_"* ]]; then
+		extra_args=3D"-r ${speed:6}"
 	fi
=20
 	local local_addr
@@ -1551,7 +1551,7 @@ add_addr_timeout_tests()
 	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 	pm_nl_set_limits $ns2 2 2
-	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
 	chk_join_nr "signal addresses, ADD_ADDR timeout" 2 2 2
 	chk_add_nr 8 0
=20
@@ -1561,7 +1561,7 @@ add_addr_timeout_tests()
 	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 	pm_nl_set_limits $ns2 2 2
-	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
 	chk_join_nr "invalid address, ADD_ADDR timeout" 1 1 1
 	chk_add_nr 8 0
 }
--=20
2.34.1

