Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4E57D
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 09:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644573171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O3S3i/DCFDpl3AF2spU2PidFvf+OT0zz2OszZy0sa+0=;
	b=RZfaTvigUmHmrAlFvDiciEtkZ/RtRW+csXjF0cPnjr/PRRNkXXY7eq5qCXaYgLEZ93kWEF
	LKHcLIl/8EOIo2uCBIddY3z02pJamtLbREBZkkCu6hKJVSoRGCoaskCkBAPT2qm3vpvtN8
	rvOq0o1nXWCyOMMyI/qUguD0JRlhFT4=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-LHtUW6pyOTmUxg3kqPUq7A-1; Fri, 11 Feb 2022 10:52:50 +0100
X-MC-Unique: LHtUW6pyOTmUxg3kqPUq7A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5OI4qdPFK1pHlzYW1PtZKx6gpseoLvwU0/pYtS9mtc3ZOAVTts+Hk/AdDM2Q3mKwlvNYHHObkRBWiDAaLjnsqLIxSrJOOzPtwK7Xgk/r8172gGS/pF0ojahutrnKgcx1CYnSpLWglCrTcWjc2eL1tNxQwZmgs4kHt3/1JH8ro+NdECU0nsue0bUEDI/XOKru7Ewh4rj8hLaz/4pcpaRvtllZskVN0JyCxQLpb5jS7Oh/j67241/7yHIvVILcL/VPzUQyD/yhyYjKwlTp+FdHFHIXwAVM8kv1YNsEV92HHlsbMk0eTSb3LvTA+zFlOSzFkC631/TtJagbA4PMd0sFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePrvgckn8P2h57ug0NiINPXXmFp0Y1K5I4nkvd/m1Ks=;
 b=E1mMtnXaN+AQFgYGQQxs4eho9q08dKAYl/si68riQ1WHmriCatSmsysHGvOnoCifsN8DtEqUruuVv98cZjfZPJUzTtT33KRsIWF2ddjYUwAcIxM+pDlz7auK4PSP+9bJU3kHoyFwfaputBWV8ojiHMaDL8AaPOfN8bCq53NlEeZQDNvE0Pg2qkpCvM/DHdwAURerrxstBIl7ktIPi0S+2PQypz/OtLLkSZs8sRQp8QUNvs/lVTV0V9PvJa9j8OKfGN8kB7j/Pgs3/m166Ic8VWTAcIx//Qg+xn3GtjbDDtPNvaXEvhurPcwhfr6xSzmRlOqmVin31RIlx10ZdyrPcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8651.eurprd04.prod.outlook.com (2603:10a6:20b:43e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 09:52:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 09:52:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 0/7] add mp_fail testcases
Date: Fri, 11 Feb 2022 17:52:58 +0800
Message-ID: <cover.1644572307.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0064.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f0883ac-1bf2-4828-6d31-08d9ed44432b
X-MS-TrafficTypeDiagnostic: AM9PR04MB8651:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB86511C16868F8FADCE6F4042F8309@AM9PR04MB8651.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bGsypWecejXxPOw3npECzEXkbkMCUOwBn/lGOrZSs+E+Ez1nhnaeZ8valQ9xvt0ZvRDzvEGsDP3DZaJ105sK6lRj37MX6DMSxemH/v0iN44XuNpkwEGEVuOc1BCulfyZfMfZnyGEsVhaNTDXCWMgccnuMdNcfvT5Bevg4gLvpJm6ILBrSRndhnUFaWF3LZ3YaCA9Ux3iyMIPgW2TneuQ7v4Lpx/JX3riaAITwCqar8SCzy/s7trOwS4UOlyFac33xU0z4RTACXcjqMbCi6vdrA0wXnXTAd59278BzKJMvOTdUcPakDdz1G1k7q4e8oN40JTaEJsUml+CuGGJwIzP2nzhcxYC9u1A9j8w10e0K39P0ZVhn5N503+5DDDU+v/EIU19f5h5DRySYcV3nLVl9XZEYHNw//6yiZoA7LXB1cHfLhQfQt0b8sNvH6mm6nd1wUaSHqcxikb1m/twhVNGyuNL+fuEWN0oJJNEjjXMdvE/waQC7hlnpPimzACQ2fpTASUWQ8K70fEIFZFav3ms93WlQ5To2sTOu4vBcLqMOIS5QB4EABjsnIYkv9sNZR8f1dzgserD9NOdtcoPLszzHWSnVX1pNNJ9/9tE+eBFbZK5oZKwv1uVrOsxe9X2HtqHk3OAso8qDWDWPm/YccBBBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(2906002)(44832011)(26005)(83380400001)(36756003)(2616005)(5660300002)(107886003)(8936002)(38100700002)(55236004)(6512007)(6486002)(316002)(19627235002)(6916009)(6506007)(508600001)(4326008)(66476007)(66556008)(6666004)(66946007)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IRi0iXvMSWdQVc8CPvvsqS4P+/mcRsgSG7rqNpJy2fz/gRFlFLxABewlZSg9?=
 =?us-ascii?Q?5GaVD3vQOh7N4cshH8mO5+JI9BvQUihLzW/GDLDE5BSjzrDxhUG8GciFDhky?=
 =?us-ascii?Q?GCt/lMQ9L+dtlU37wgm7pFRnqMnGF3vEcOLiK1xMTSaszuyOeTlgZo/91Ang?=
 =?us-ascii?Q?IJ47cx4BrGX3HxuNgEMTf+Ns3IdTrU/VpZOarLSd+y7S5S7VfKlD8u9vtFto?=
 =?us-ascii?Q?D72t0ViyRtCVdfGmN8fP4WWqhFRBjYQeQ0qbDGJSZRALj6fztXkktUdTJBTS?=
 =?us-ascii?Q?Nee0rqZfLCOax3+MQrdZkvJ41nrgkY7Ufm/jP4K4gtkvObqmzg/uC6RCtRrm?=
 =?us-ascii?Q?OjYNj+KBLR0pzBsQXQqNruE3HsdQ+Jzs8ePz/3QhLCdcedq8pvOsudS7MBS/?=
 =?us-ascii?Q?1wXzQGr2PqGAPiCdsKfxfzHFo0bHnR+GPYbdGFMZ+6H1G0WIRsHNjQpXKR3m?=
 =?us-ascii?Q?1mHKmGrad0E8o5afLl5aRete++iJpkz8OPgZcAkHWCDrrGhC67no/FeQ7BMB?=
 =?us-ascii?Q?DJr1JPdnQss/XAsPfbRN0YD1mkNJOliNzzj6xW+k304Cz9Z0VlmKihXN+Gy2?=
 =?us-ascii?Q?UFedaWHjhnjs9jIAD6bq+mi4YZRlktVqSEwupnBedO7Q0mow60UWLDcgbPF3?=
 =?us-ascii?Q?F5O+yBaPvaFfre3ZZIS1kY7i8JigYrjvvavwfqqjHMHze3eeA7FWE2Pr/V00?=
 =?us-ascii?Q?ZPyTHQaGnFfk7TGNAsbMa1bAXc0HelzHV65rqJQHM4RkzjW/R8qGPyrVvzet?=
 =?us-ascii?Q?v9DGMgYrcU3qJh8z5A2jPbIBoKEtfYrEZvIpbaKTvoPZt5T0m4ktttXDkWLT?=
 =?us-ascii?Q?oH8yx/ssU6/H1C2lA5H7EeazPDuJ7gPUOFFWh/8xm11gCkmr3pDcxCvOVKPk?=
 =?us-ascii?Q?22IhJUqtu0yEhbsy/XLdUpc2NMvrWJg5s13+mZzuSv6BTa9iEs4fC/aCYlEQ?=
 =?us-ascii?Q?Y3WAqJy5MRJH1wjKkM6CrUtKLY6YX2+OEkRilOhk250e7HFxI+J7mgf2RjHm?=
 =?us-ascii?Q?Jo5t3DTufqZH+QVI+N9KmdPsku2dVDmjjzQR5Zp1NWOvG7eGqcSBmn4PiYK/?=
 =?us-ascii?Q?BpnzeTLeniZeWqh/UdT/nCKux9ZYCtmJI2tuJ/yHmnTsRQ1Cxf7JLgeykU1f?=
 =?us-ascii?Q?72EA+nhLg/MIHzRgYxjUXib6tJawzI0tdwtOa9se4hXBq0qABgRl8rSrWTq0?=
 =?us-ascii?Q?9JV0CwhBwAE77wMP8SWU2hsHBbuSBkPPBhlCUumf0AgNJ8pYU4C5827H5sI1?=
 =?us-ascii?Q?dYY3HgSvOslluHGNp3lVNz77rrO/+aFtKM+RN3m9QNBx6+A+WWUnaWhqrhgY?=
 =?us-ascii?Q?B17tD2SmqK/K/cZAEIwKYHqzIp0PYcGK81bOxMPEGVL+YeF3oj/3XeZ7/LCR?=
 =?us-ascii?Q?VJGWCrALnSzv+N2LDgqaGkCNYdtZLE68ELxYMFjlLCJlJ0BKqNkUzVt3d5YQ?=
 =?us-ascii?Q?lZUEs3JE3INwWcBz9v6qwXgWliRnGEKHn6MDOZwLg+1PIlqCCskdeuqJMEPd?=
 =?us-ascii?Q?tDaKgra/9igv/o5PEx4bSFQQaT4FqbB6A27LBgXFrJnsgfgngUI8voCs2HGI?=
 =?us-ascii?Q?qljUrNLqLlWuESHbsEufM3nm3/pArWGtlDOkty60a+HoUi0MxuwfaBwvzE82?=
 =?us-ascii?Q?k1HrQM3H6HsChxhIyRub9oI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0883ac-1bf2-4828-6d31-08d9ed44432b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 09:52:49.4489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcDLwohy2xVqMKbpKudsdJ5kSQb2WuRxIhUKX3kDvrVB1YTPnUsPUfJgGX64ZU0HNkbVQeQ61kazgY7lA+ws1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8651

v7:
 This version make the multiple subflows test more stable.
 - Add delays and drop 'retry' in the multiple subflows test in patch 7.
 - Don't add two addresses for the multiple subflows test in patch 7, add
one address 10.0.2.2 is enough, this make it more stable.
 - Add a commit in patch 6.
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

Geliang Tang (7):
  Squash to "mptcp: infinite mapping receiving"
  Squash to "selftests: mptcp: add infinite map mibs check"
  mptcp: add the mibs for MP_RST
  selftests: mptcp: add the MP_RST mibs check
  selftests: mptcp: add more arguments for chk_join_nr
  selftests: mptcp: reuse linkfail to make given size files
  selftests: mptcp: add the MP_FAIL testcases

 net/mptcp/mib.c                               |   2 +
 net/mptcp/mib.h                               |   2 +
 net/mptcp/options.c                           |   2 +
 net/mptcp/subflow.c                           |   1 +
 tools/testing/selftests/net/mptcp/config      |   8 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 193 +++++++++++++++---
 6 files changed, 180 insertions(+), 28 deletions(-)

--=20
2.34.1

