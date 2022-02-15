Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4211388
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 11:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644924329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N0XKV85fpjfDZwIW6MJIk05ZbxO1vjfqQ7StvIX357o=;
	b=lFyrxBjJI8600zR5RTqUE1gkM51xKUfqVbwC+zMl9/TzYJWofPYIXY76yLXzToIT+726Xf
	iNugktj9IgfcU6UajQFl2TpBD9y3zkLIfCu1X6NEp4LfpOCPOFwD+4A7m/NTSm2Rg8hiwL
	Y6RJVFk17xXcPU2FpNk2PHaISFFOuxc=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-9og6uLGTNMC25j3C4s979w-1; Tue, 15 Feb 2022 12:25:28 +0100
X-MC-Unique: 9og6uLGTNMC25j3C4s979w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuZxknIMq26nkKCgnM0lH/zl3Ra0IDqGFSezVlCSIKDn7/beg5PDnU0CKr/OV1+ROJ+xncaJWV7zQuVCBbuOt6MuS2LCC2edq53L8i8sybliaVbXlpMqwnuOqgQ+0nhWnBtpVr7+mLDZY8d23Ch+csHeUYmLpE+SAuGwgAQT7tD106uRDZFIAdysHfrnYJFwY3uv3ioCUIaWcd/OtJn3JTelhXoAV/VOU9DfN1b8BE5LTsODHVnuRKKo043nFJp0cp3ZUBeCkPre1i1HZpzEwwdQP96mq176C4CyeaUb3pGsKh1WpAj73A1F2UPTH0oWSC81oJNLE6iczWl1dbYqSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dmq6HWSy7ochQUCWIhB/paOR8uWmyXzCr2cNoLhi1fM=;
 b=U3aegBp9fVPyYAtfm1qLxqzoT1OD2a0lCzMTvDmg9DwFEFZQTPcygaJ3Xj+kTECJcFDSIllnzLiTPIQ/s1wr1fP7UXYl5CM/lEtybyDaBjPvUIFyrI2vGbscwC398lSlbeKyFvwznP6nhWiQkZQVlvA2YSUURcFhBKmPs6XmNEoSP+C/NsdWoAhPA5BsiX4yFZ1mMrwyAorfl0lQKfjFU+4YwGd7wn9OZqzBwsYslfZabyetPBI+vpGz20Xbb28n/U5e+zebgA5lKTRhb2rgASkVkWWcQo5kBUGu4lUuJeU89jqftJolHWQKRbT2i1F/GsGQgoo1s5VLApQDNGWibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR0401MB2561.eurprd04.prod.outlook.com (2603:10a6:203:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 11:25:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 11:25:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 0/5] add mp_fail testcases
Date: Tue, 15 Feb 2022 19:25:49 +0800
Message-ID: <cover.1644923833.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:203:b0::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07aad1a5-72b4-49d4-35c0-08d9f075ddb4
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2561:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR0401MB2561D07B11C1202BEF94697CF8349@AM5PR0401MB2561.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lPLomb0fz2GJX5aL9YH7fOAAnUX5ts4MfLXpfBZjh0gFEUAjdCn+TUzExOdF1BZW6nIJa21818Dd6kntCwuyZe0I8RTD5A9JguVyPj2DrzZuI9O1ySp0wtpl5/9siJ02WoXFdQW8xAMTKTxOsjKgMcXDiw7V+Ll7S6Cln5ipN264KMjYW8+r1hbVEDFr6sADng8wU2gl3T5pEwWtfD3r7UD/Jg5MEJNap9m+gLoqzqFZbnUDFWaUBPzhjOmN3qcypYJnotJgFkReO8uQ6uo+cdTNS94hOuUrY2RumwIN018rJAAWzCDHjLXhhhAmgm2sO6ay/0twDQROsG5wL6pcVVLzEIjTcL2/AwYl/tkKHkidyl20GEVPL4siVw9vkqzz5uriYNztsUxrVLcNspdMR8x4SRjwsR94WE0aGPlV4OpTi5cOqorfq51lxdIg1AC6kopA2hiYGzI74wtKYStwL2fwmS+KRvolxxqkedytrSn5ik6w7MQ9y5ULSdQJ29nWSTJD8MbsmKo29btcXnqyhqXhpflFU9J0GByKOhGLeXrInuEj03n5DCNvZC6saHMknfzHZgbxTVpwFKoTU5S7hr+IgeQoI1PZ7CAxZDbDIpiofWTc+7VB7qDLPf0NCZDgDMGIutXH/OJsCdQTr5aeWg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(66476007)(8676002)(66946007)(66556008)(508600001)(107886003)(6512007)(2616005)(2906002)(36756003)(86362001)(83380400001)(19627235002)(6506007)(6916009)(55236004)(26005)(316002)(8936002)(44832011)(186003)(6666004)(5660300002)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FZpReuyacxoGKry0Uls252kcU+EURjXFSJ8VKcdhDf7w5+ne/HsKzqZEa5Ek?=
 =?us-ascii?Q?2tajtaGwsgBFCHta5UGtT6G6VpHHsvcFLOiWMVjJ0Id253ghVFhdWL1/+JGZ?=
 =?us-ascii?Q?ieQyMAr67d6piy7z/Glv7hUHaqxXyWa89bEV+IkVtN+cSEBhpPtDpLq3vKtG?=
 =?us-ascii?Q?M1b97qmbOwA90FnPtM84cGW2jnwJC6QrjXHyGekvn1cPFi2KYjlMAAUG/kKq?=
 =?us-ascii?Q?8ShuLMSPVDEleYuWKakg8uxhDKroHhZiwMQ9BNjgWNVrNKTebAToVE7IWppC?=
 =?us-ascii?Q?Km22AaDGQ6F89/4xsMOPprU/I9FNDZZ0xxvHBHV1xBE7NugQXecxBSzIQzuh?=
 =?us-ascii?Q?hPkiQgsqpkkzjd35dvLIV9VJTLS9Ri86jS6eJw6I9nNLjneWz08JESWVutJb?=
 =?us-ascii?Q?g2VDOU5NOXDOHoe0uTM9jvs0X8/ZKbqFaN8sKkaP24FnG5qFNbi8aA0zNTQt?=
 =?us-ascii?Q?v8DdQDByK+GUVjJfwU/2XQ5Yq3+ePqUpOpS8VkWlRWpsiAVR86Gmz6tSh75u?=
 =?us-ascii?Q?8hbPt+M7lrQ+KMxuWkQ9SdYqHwRPijH5YTuerJV45w5tf07EiAuNmLRbGF0J?=
 =?us-ascii?Q?xKwmu79mPJQ0FpZOlA/cp5G58H8cBkBFaGXc0CxivYuaBUH90+JHocXCUzJ1?=
 =?us-ascii?Q?ndUHME2s+G8RPnsC3xy28cbWpWExTyUCItMqAZiOM0W5apUCBD1QN0UO3RIw?=
 =?us-ascii?Q?884Bq3zFlqfrFSQhF52tUammG57VZeg9D+yI2oWwywUF8AhSmKAgD71WPRxq?=
 =?us-ascii?Q?hlVxWDWwRlBW+aEcnDyHimXObGmDUnyk0b6IsAyNeY1xHh2FBsOzk7cSb5LC?=
 =?us-ascii?Q?BdO8ZHmb+3J5PLo//PUYiihw5E3IUKISBX6ystI9z6f/nKeTCFBmADyvz6Hj?=
 =?us-ascii?Q?3NQcKtGwQFoCiQG5FMZ81X6XgY21/llRF9bJJaGmsdfGMvg9UON4Q2VMysQJ?=
 =?us-ascii?Q?74ABeV48C04Lk66FB9BEszSDGeajXsdMQJsbwmX4xldLWQjoF2rtywh1RSX2?=
 =?us-ascii?Q?VJl+VmeBD8nnv6ok21Q0DxNDtEymNMGpNqdA1licmyIo3WjbDx54hvP5vhuy?=
 =?us-ascii?Q?cqlRGOFi7OPXy5FvzMmTU1F7KvJNSHqUJh1gi8w4MyGzUxZsHOfwlKbcaOM2?=
 =?us-ascii?Q?dUdqwazXIMoYSwgrDzhAKRTXgDjyUjLvO6m2Il9WfEb6YM4j9Hx1YC+klRTU?=
 =?us-ascii?Q?zT0W2SXyk+0nDEBR2w6SCisWGpaPzgCCj4TvpnQiKbEyBon1RKMPt3a2H8oB?=
 =?us-ascii?Q?VQc6QxdXZiNTLA5plmwt/oCmoTi1h/34466mHDg5NwdH7+LgrCuPhqFWYq7z?=
 =?us-ascii?Q?4i9jB6aQb3Iz4bZ0oogdPHTyJ0bYxpPrIIcoPC7hxrobfthlIgFedTKv5kdz?=
 =?us-ascii?Q?/Q0BZositokhEjfUdVdTWTKfYKfBq/vGLnCM5rR6lhYYIIKYAAicJQqm+ubA?=
 =?us-ascii?Q?YVJG69k4GyhiuLFmQFAu2q3k3d/KsMQ3B2NkQ/EsJP6h+Ju+PhvlvPYwpwKH?=
 =?us-ascii?Q?Cv1hJtIfj52moU1mb0iMElROzIKc6KvrWtBqO5DSCPfciLA1X7RzbnHjfYZa?=
 =?us-ascii?Q?iyfXCP4EvEPsWzgHt1Sf6LpGyfTqDx749bu6GGMPIFzvJDuYaIsntiudXcw5?=
 =?us-ascii?Q?Vh/N3wyCBw76aPoAtnoGSSw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07aad1a5-72b4-49d4-35c0-08d9f075ddb4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:25:27.4175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpBY15ZBLzGFrP35aIbIvJxzD1b2yg+IbqCG5R41L/FLGelqMxegWrI7LcB316H56ox/RD5K/LpXYmxDZRtU5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2561

v8:
 - move two MP_RST mibs patches into the "add fastclose testcases" series.
 - allow multiple checksum errors in patch 3.
 - depends on "add fastclose testcases v3".

RESEND:
 - no code modified, just updated the commit logs and comments.
v7:
 This version makes the multiple subflows test more stable.
 - Add delays and drop 'retry' in the multiple subflows test in patch 7.
 - Don't add two addresses for the multiple subflows test in patch 7, add
one address 10.0.2.2 is enough, this make it more stable.
 - Add a comment in patch 6.
 - Rebased to export/20220211T054659.
 - A 500 times loop test log of v7 will be attached.

v6:
 - Split two patches from the last one.
 - Retry the multiple subflows test three times to fix this
"MP_FAIL MP_RST: 0 corrupted pkts" failure reported by me in v5:

Created /tmp/tmp.e4nE5Q14mj (size 1024 KB) containing data sent by client
Created /tmp/tmp.QwpQYClFnm (size 1024 KB) containing data sent by server
001 MP_FAIL MP_RST: 0 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
                                         sum[fail] got 0 data checksum erro=
r[s] expected 1
                                         ftx[fail] got 0 MP_FAIL[s] TX expe=
cted 1
                                         rtx[fail] got 0 MP_RST[s] TX expec=
ted 1
                                         itx[ ok ] - infirx[ ok ]

A test log of running v6 500 times is attached, named v6-loop-500-times.log=
,
in it, we can see retry happend 8 times (116, 136, 236, 295, 297, 402, 444,
457), and no "0 corrupted pkts" any more.

 - Reduce the single subflow test files size from 1024KB to 128KB to fix
this "file received by client does not match" failure reported by CI and
Matt in v5:

# Created /tmp/tmp.crkOA4p7hr (size 1024 KB) containing data sent by client
# Created /tmp/tmp.jFbZEAnYZa (size 1024 KB) containing data sent by server
# file received by server has inverted byte at 195585
# 100 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ =
ok ]
#                                          sum[ ok ] - csum  [ ok ]
#                                          ftx[ ok ] - failrx[ ok ]
#                                          rtx[ ok ] - rstrx [ ok ]
#                                          itx[ ok ] - infirx[ ok ]
# Created /tmp/tmp.crkOA4p7hr (size 1024 KB) containing data sent by client
# Created /tmp/tmp.jFbZEAnYZa (size 1024 KB) containing data sent by server
# [ FAIL ] file received by client does not match (in, out):
# -rw------- 1 root root 1048604 Feb  9 11:37 /tmp/tmp.jFbZEAnYZa
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER
# -rw------- 1 root root 1048606 Feb  9 11:37 /tmp/tmp.ghV0iWPhu5
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER
# file received by server has inverted byte at 169
# 101 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ =
ok ]
#                                          sum[ ok ] - csum  [ ok ]
#                                          ftx[ ok ] - failrx[ ok ]
#                                          rtx[ ok ] - rstrx [ ok ]
#                                          itx[ ok ] - infirx[ ok ]

In the attached v6-loop-500-times.log, no "file received by client does
not match" any more.

I think this v6 is very stable, but there are still 6 tests failed in the
500 time tests log (68 77 97 112 161 243). These failures are all due to
get one more unexpected checksum failure:

 > cat v6-loop-500-times.log  | grep "\[fail"
                                         sum[fail] got 2 data checksum erro=
r[s] expected 1
                                         ftx[fail] got 2 MP_FAIL[s] TX expe=
cted 1
 - failrx[fail] got 2 MP_FAIL[s] RX expected 1
                                         rtx[fail] got 2 MP_RST[s] TX expec=
ted 1
 - rstrx [fail] got 2 MP_RST[s] RX expected 1
                                         sum[ ok ] - csum  [fail] got 1 dat=
a checksum error[s] expected 0
                                         sum[fail] got 2 data checksum erro=
r[s] expected 1
                                         ftx[fail] got 2 MP_FAIL[s] TX expe=
cted 1
 - failrx[fail] got 2 MP_FAIL[s] RX expected 1
                                         rtx[fail] got 2 MP_RST[s] TX expec=
ted 1
 - rstrx [fail] got 2 MP_RST[s] RX expected 1
                                         sum[ ok ] - csum  [fail] got 1 dat=
a checksum error[s] expected 0
                                         rtx[fail] got 2 MP_RST[s] TX expec=
ted 1
 - rstrx [fail] got 2 MP_RST[s] RX expected 1
                                         sum[fail] got 2 data checksum erro=
r[s] expected 1
                                         ftx[fail] got 2 MP_FAIL[s] TX expe=
cted 1
 - failrx[fail] got 2 MP_FAIL[s] RX expected 1
                                         rtx[fail] got 2 MP_RST[s] TX expec=
ted 1
 - rstrx [fail] got 2 MP_RST[s] RX expected 1

These failures are related the checksum bug reported by me, issue #255.
When transferring a larger file, the checksum sometimes fails. Running
"./mptcp_connect.sh -C" in 10 times, we will the MP_FAILs. If we solve
issue #255 in the future, this mp_fail testcases will be more stable.

v5:
 - update patch 5 as Matt suggested.
 - use '|| exit 1'
 - drop jq
 - drop pedit_action

v4:
 - add the mibs for MP_RST
 - patch 4 "selftests: mptcp: add MP_RST mibs check" uses the variable
$nr_blank, so it depends on the commit "selftests: mptcp: adjust output
alignment for more tests".

v3:
 - check the exit code of iptables.
 - add ip6tables support for reset_with_fail too.
 - add the null check for $packets
 - rename nr_mp_fail to pedit_action and get_nr_mp_fail to
pedit_action_happened

This is v12 of the mp_fail testcases with Matt's changes. It works well
and it's very stable.

Geliang Tang (5):
  Squash to "mptcp: infinite mapping receiving"
  Squash to "selftests: mptcp: add infinite map mibs check"
  selftests: mptcp: add more arguments for chk_join_nr
  selftests: mptcp: reuse linkfail to make given size files
  selftests: mptcp: add the MP_FAIL testcases

 net/mptcp/subflow.c                           |   1 +
 tools/testing/selftests/net/mptcp/config      |   8 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 216 +++++++++++++++---
 3 files changed, 192 insertions(+), 33 deletions(-)

--=20
2.34.1

