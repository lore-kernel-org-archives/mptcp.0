Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB9A160
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 00:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651537177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LIPUbE8rlIlVzjy1MhUAODVOYonVKzgA2Tt8TxRwhy0=;
	b=j5dpIXGZizUqqJEd/iuC0T+2j25tTynxEQ8SDYy4kYdBA+yP9ESB8S33NWljlb1h6hmbU+
	MZRJWAihSnG4kgYvVIpG1K6nHsBpAdIw9dEiSDWGLgSOThhrjwOZ+BQH/FMdbeP+HpW6th
	pWqtD/oq0PP4fTOkUpNQIbxT3PNnYag=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-XoBibvuPPx-k0SnTgrnMKA-1; Tue, 03 May 2022 02:19:36 +0200
X-MC-Unique: XoBibvuPPx-k0SnTgrnMKA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLs4PNiWmAZbv/sjxn43xQ6FG6bFSrXW/vJpfBDsETeJRV60slNCc503nSEsp/wOWClufr2sGkg0q8lRwHsBCfQxuH8wi7f9SO41QVdO8BOibph4YGPm6+rcAr3wtPTiYLPjxCppyqGsTPOufO59Fqap9hD4dX8RQ7j6z5ohzCpfGGzaIyH6K8Qy0TinuBTlIbOIum8XWHWHU1Tvd5amv8+Ibfv8omKBtCeEqcQHcdjBQVVkUfQpPf27plKzHv46miOzAdl8CbO6OfIFBurk2nChN8bdBGESpTCKgVD8VUwjUzsGg9Jzk39eNAHizYQHobfK9y2nsM8kCyu0cdfSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3u3yE8Y+GaVe1xrHeHszwnfjcHDe+r3Yjn84wn5vYkM=;
 b=Hz1oMgbr0VS0rPr7Sq+D1d7BzJActDMyF1ToAxJGHZtotzlyzRAYdRFc88OJWD/lECIYVlnMEkLLSYpwVgS3SDeVJ/60p0/ckQo0+kpUhXRPVjkZy95j3N7L4oEwgjjkzmGTz0B7Ffsih4j7epjrEIrt78h0iLknOqCqb7189LDdFnKKsBBQ86XeJWKkyaNhudB56GLjozLHd3ZFZg+8oDbwibMD1yTlx7KEY/D5q0gq6Yw/6CxPO9FT5RbW3kdTLccp3BN3Jrzke3eufE/3yH1aHCzATc+1BiJdmDzxrkDySm8CpRnZlKKehBtQN0lHM75gdqFCbizJWIpBag8kbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR0401MB2676.eurprd04.prod.outlook.com (2603:10a6:203:2f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 00:19:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 00:19:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] selftests: mptcp: fix a mp_fail test warning
Date: Tue,  3 May 2022 08:19:21 +0800
Message-ID: <6dd3d1ae0042025c2b4b4fde0e341562c200024a.1651537116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0109.apcprd03.prod.outlook.com
 (2603:1096:203:b0::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 056f9472-9e34-405c-bead-08da2c9a998d
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2676:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR0401MB26760AC6A03520458044F789F8C09@AM5PR0401MB2676.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yhNEfI0aHXrN/9BikfOHd3zVzmc2XGefl/B6IjEcurqiOv9tjB2VrHSxkSvpC8fuOm7N7piIjnEad/49SpNQsEhjZHYSYNk1UBmdfvSZXk30YVL1NFAIjHAIBTO0eNOEJ7AYIdacsbw3c4PjIViZlfemNBNev4sMollVWuDBZ2gC69Vk+5HR9KahnTx9lMlYtW2+gGDLiF62gTvQLcei4RPYpgFf/WRxF4lRBv/o56ryf943HEua5h9PKtuH1bxNIa6fTXduVxbmsX/b9GKsG7mNFOUWQmk58/29QzrBIEueDN8kCS/bPyh9TnO8xENErs9NLbb4uG0LO+377UVk7CXYfQrMU0jgOyyJ5rHFbpk8ayAbiRmsfeIMbtoLB8J3cCHfOlsDAiutQ6bXoDKAyiZxaTqSjYZ1ZC/Nvud64LaVtjYvEfGtibqSDhK419G7HSesWvPlniM4VTYJiqrqNCtdmCGtR7YkuvLC+1+1T1abMS7kZWbBPAtMn/cQmpNc7hO+j03bho/t3OnhcISWuHbRH3WCGM/OqgAJGu5DU+Q6EgqIGckLtco306+v5vzt2cPVfJmDKtYLC58Tnh4HpvEPEBHq1zxWKb78XrHVs6/QQEwVD5XmwyzOjNYwEYpNQhlpRjoKoyWnzdTkBy+STcMLoG/gY8fWJwtInMNjTjd2P5JKogFfQL4138J4OlD1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(66946007)(66556008)(26005)(66476007)(4326008)(186003)(36756003)(6512007)(6506007)(86362001)(107886003)(6486002)(316002)(8936002)(5660300002)(6666004)(2616005)(44832011)(508600001)(38100700002)(6916009)(83380400001)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q2PPnoG+DBoqehSrCTMDWLsQWhtLMXZA7Dx3PPmuBccKp13KSPT9kVZBKF/i?=
 =?us-ascii?Q?h7cTxipSoYrex0Jhk9/COHmzijpzvZtpozZytDHAZDjB/gyYfhKitRYAn13G?=
 =?us-ascii?Q?nm/UW769uyzAV2wKyaVm2+yLwxG3536cw4kJpsG+wiEAMi5XfwsBWvNhYxot?=
 =?us-ascii?Q?Z5/0lewT8Zof4xl7crHL6kCKa3CJ06CuAsaJMhCT7e4mOQ7bpb6yeNmDUf4B?=
 =?us-ascii?Q?I00BfENRd6jbSeyixUUX8Wl8jbNSggYlzoATGrQb7+YkitFYsydb6meQoKZU?=
 =?us-ascii?Q?cF+FSy7WnsqdqJh+HByWhqSsm0suUyUFKTU2KYCFEi6P6d6Oj4qd2wbY3sCn?=
 =?us-ascii?Q?b6cSHe3EWT9EZqL/hpGLuUOgtrSK090lgehcO5+7YyZzFHCTJicLzofeOO3P?=
 =?us-ascii?Q?Ws8Kg7Hf7gxAnj+oI8753puZRDiTj+e+7BXGDtg3m3HHsop5nfgIcj6mI5Hh?=
 =?us-ascii?Q?H/mb1S4MwfXLPUBVciuQ10rBW4JDnP1Xh4ssCxwya6TIuiYCbhoNEtE2GRAm?=
 =?us-ascii?Q?jhItOed3R1Z1AqoaXQeUfAcR48RgwvTWt4oJfzuhV3RCOeBoN/HqfZA/uKuQ?=
 =?us-ascii?Q?IRuRGq6zK2drNPQARahKt1+73MCOgfO2R8oI9UHaEo/rkDUsfc027Ep34XSM?=
 =?us-ascii?Q?mefHWSHwkhkCsErzFcFDLSRhJfE4lTR/gXscB9dEpX1gPuiWT0uaaVRl23Zs?=
 =?us-ascii?Q?zl1N0v6Aew9vxPeTBqhNVu49eXuf1X95TeWop3oZZZ2m4fN1K/31MemH7KTw?=
 =?us-ascii?Q?uFOcgEl8L08tVEuiNimWv9CddDDTd2J+TYTfEk/mkJg+ejdJ77P57kOpuufl?=
 =?us-ascii?Q?sPB/jUkPY2oqVY/pNv3F9+gA+R0/VcUv2apAw+NiRfPUxp62xtXZNdOETQK4?=
 =?us-ascii?Q?OitCACL8ILVUQT7C7M/cgRbNIGCx8HYDuUxGpwBuHHMlhBzW9/65+8ROM1wk?=
 =?us-ascii?Q?JGiMsMuwxiaw+mzMvsi4+jPfmlgeexErG3HTUhVlz9+8QjhOrgVek+fC9nZW?=
 =?us-ascii?Q?vRCys9t6YwAdKcTSd1n9p0UsZlTzaW1XE+nxZPXQGgGK+ovgTVNERFbSxRMX?=
 =?us-ascii?Q?4CL5QycFwLY7LUqG3hPovi5H2VdPwHYOQHdf5mFPvoJzq92hCV+wbxfpTzKU?=
 =?us-ascii?Q?goLWQswWMZD/Vcg6dIJcu9JKsmnYYv2SjqNfgprbmL4L/d26MZApN1e2T/C1?=
 =?us-ascii?Q?Z2Awgy6Lcr5xnZydJGpSAtUVX1CQ+X5rs7zbu3ZcX4UXC6AcEtvGfuY/Xs1g?=
 =?us-ascii?Q?ZN5iCzFpCCXjnK4Jdky1rJXhZf7zyErY9IjiBiAabdqwVV5TFzmGKCK2USX3?=
 =?us-ascii?Q?QUMRC9U94XMlPtXKXJxgLzHEmrAv8QCLmJLBGngNF2Up2LwD7kNj0t8eW7g9?=
 =?us-ascii?Q?WbGo1exqiC5A8LHTTEHshcn8dE/RrIiXAC0PTsDeLGlJkd3K9uEkTti9wO9m?=
 =?us-ascii?Q?cYMrbZEOVI7nZZjklk4df7GV8aMatKH3pZ1DmWU6rmuvLyqL9bm6Y0tu9SK7?=
 =?us-ascii?Q?6XefriHLT+OnUJYxEUmzEDoPP3vSP7VkRbH5kLEfV/2zSniesj6sSUU2Pp5i?=
 =?us-ascii?Q?/TIvOnR/wZygBeKCDvUnXo982Ejr6J36m0X/HwySSrTacwZkvVh8LvPJQZmf?=
 =?us-ascii?Q?fycaSAY6CFpU+syI5Vre4SLU94E83XU6fTeSXh996TNsU7UdzofCo25XeFig?=
 =?us-ascii?Q?MGB/cKMeXWZvGGHWI0wyRK9HQgR67i5VtdUHzFpXf1KeiZxioKW9Paj84vYK?=
 =?us-ascii?Q?yxD7PizzKMNN51uCowBQE1Xe1pXlihE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056f9472-9e34-405c-bead-08da2c9a998d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 00:19:34.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++sz4Kxzf6TeCPyNcRY7rYOAxIMNOnnmxsxzScmGKBJO8LM5JVciusOtxlNjGnaQFSRscP1zAEePM2KZnBGEng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2676

Older version tc command (iprout2 5.3) shows actions in multiple lines,
not a single line. Then the following unexpected MP_FAIL selftest output
occurs:

 file received by server has inverted byte at 169
 ./mptcp_join.sh: line 1277: [: [{"total acts":1},{"actions":[{"order":0 pe=
dit ,"control_action":{"type":"pipe"}keys 1
         index 1 ref 1 bind 1,"installed":0,"last_used":0
         key #0  at 148: val ff000000 mask ffffffff
 5: integer expression expected
 001 Infinite map                      syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       sum[ ok ] - csum  [ ok ]
                                       ftx[ ok ] - failrx[ ok ]
                                       rtx[ ok ] - rstrx [ ok ]
                                       itx[ ok ] - infirx[ ok ]
                                       ftx[ ok ] - failrx[ ok ] invert

This patch adds a 'grep' before 'sed' to fix this.

Fixes: b6e074e171bc ("selftests: mptcp: add infinite map testcase")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index b703b61562bf..cb1ba78da3ce 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2693,6 +2693,7 @@ fastclose_tests()
 pedit_action_pkts()
 {
 	tc -n $ns2 -j -s action show action pedit index 100 | \
+		grep "packets" | \
 		sed 's/.*"packets":\([0-9]\+\),.*/\1/'
 }
=20
--=20
2.34.1

