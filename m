Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B459D7F
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 22:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644619529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0++YSGYsLdfFloQ0PTKvQW5dPLXaW0fJCZkSCcCEN3s=;
	b=doIuh+gtmnCc928iJFnRea+X6NvYh0amluLfwiING+rl0Z8z71QMD2H2HBxlTLYuQ0zeij
	8qMvGvbSlX9sQdzhYHl2/xyvBFSG7p8tINCtysyBNuOwvSLNu3v5OlkWnufkzPaYS4zPSm
	NhlMAqo/KxLGsBXvauD1PH8EtgS4yjQ=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-W4U1_ufDMuO5VNzr1FMMXA-1; Fri, 11 Feb 2022 23:45:27 +0100
X-MC-Unique: W4U1_ufDMuO5VNzr1FMMXA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fxz8YPXnMPkH7aIp4Lgc7HiIGR/AHeAEkaQPc9XXh5qI6eTCTNQReZCeSb8iGhAzyKegAu9RS9zyi1Z7N1oI27NYZHJG/Ba4Bnvlq5RqenFTFWBpQ5KknXf/Ns0RP1BFibQmocUimdWVpgnrk6tNe0sg3gsxwPw40bZKPhIIpB9h6/MVNvgnxJvxLYkz993oPvqzWmOdkQljngbrGruQkheNVRA2JlSaYeKS8Z6qLUPupM4TMM2K+FE1ZDK0Do6xlBTnM4CmJ6m0qZbvFlXSkAILOUqESP2Aay2v6J+P7MMJOOIXgWfBdOLgbhdNTkWmjsdxu00jyWMI8X+UsjTplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38fRJs9jP2SirzQ52ex7o8WTByCm/jNBUXobYkEmJjc=;
 b=jAVlEfM8CbvNtDGpqDOidAyz5SeKISB4x1R3Y+UTL/wIRuwEN+RcIzMctQ8hLu/b4ymUqX4ts39atkWkTs39+zc2GF1zyQadjHTUkzdxHoJrwO3odjukNLTXCLGCNoMHP2L91CYCVfhpcWRWSxTHqzD84U1Bz/np/1ilLVPHvTUEy/gUV/28fOPiNIZuE+8utioRGZy08pxoDW7HNaIL0BbXe9/pArmXceaixbbnF3Z9rRLbJAvAY7SF+ck9+36UL17a2djDLjG1BBYg4FL5kO6pgslqmjfURXWn/Yzt/Ibtm0g0BRsD6rejxrZOrCqqpoMxVOMcgTjmlq3VY58peA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5652.eurprd04.prod.outlook.com (2603:10a6:208:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 22:45:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 22:45:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v7 0/7] add mp_fail testcases
Date: Sat, 12 Feb 2022 06:45:36 +0800
Message-ID: <cover.1644618926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:202:2::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71aace6e-3703-47cf-a364-08d9edb031e1
X-MS-TrafficTypeDiagnostic: AM0PR04MB5652:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5652428C5BD437FA0F718F15F8309@AM0PR04MB5652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qcVG05peF18D6vyOLFzjf/NZxp7VsVR4v72AhvOYc5xzKfjGssdguYxYbzRwiTYHkab+WgzCqmFeKRTehXvVHNXfT0bMdhTIhjFSonv6zijDaMBCbWJRb1nMCAV4cPkyBZOcWjJfcBd7bl8+oQN3Bl2CjMCIVD8dE5sea2PgSwSTDHMAYBRtj7pYAyW11jmHO+S26+RJHjXYtxb9JerrYQ6YgNiC9DqyFLv6wFNwl94erlRUZ4f4cYjw8/XhpXcsMmB4B2UucorqyvRPfIDuIal9HiJ9W7NNalOgjDUbsqzdZiDMzwDBTb6WSQS2zLygrngr+MugbWaUKSe4wD0jZoiY6hxhLODbKJilvL34j1ybzTyTzWKeitsgMqF0BegsfdGQZKjntvRykZlrxLoyaaGXILwbfr4+8jIzqbv3V1cAMJARkWBHDfMCFC3qwaEz6bSXd3TfhmyNqIme1G51T/TIkxzf1MVYPvCEiluZ7Z3IJGPscujoxYXcSYx8SQpa5QDybDWZrtBDJShsHmFGIYSczT6iBkoKNER5CDxLVXE6JC2rR1CyrG0vM3k1D5PIGmsqwtht0hq9JWO6vQchgo6qPVa226+JZesddD3y3VLculPs1pEcAAAY1Ntf2w7eemp0/seDzeqdJO9vnr5vpw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(6512007)(316002)(66556008)(66946007)(66476007)(86362001)(2616005)(38100700002)(4326008)(8676002)(36756003)(6486002)(508600001)(6506007)(8936002)(44832011)(19627235002)(186003)(6916009)(6666004)(83380400001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C+Sv514jLCNiFm/HfMhye7gfwK5Xc121ZTqeeam5z0450PvLV/VTfAS68SO4?=
 =?us-ascii?Q?StKHjPyeCjR+1FxS0MEjdbfrDaSmmVv5Jj1FLrk41okTp9ulKZX5I2bpKl3j?=
 =?us-ascii?Q?sQ2YCOAvcoxaZ1ftcbJmJhU0PS097ctkLpeomn8a9V9ffTSx4ZAJZujfK0tz?=
 =?us-ascii?Q?HSzSYFNpZW0NW9CuM1aaxitELPu+sTU+fybgJY3dWcIXpxR5hNxVUpzjT9NJ?=
 =?us-ascii?Q?PRhQuyShAvc9V8XsMmKEECV28J4BytnZ5bm0RlEUKlu5XxoVbvqq3iJFbnya?=
 =?us-ascii?Q?B4zPO9Au6UV1V5pC6HaM0kItlhnYKTnmTuft4AjUk6NQbCg0SbTKLKxAM8DL?=
 =?us-ascii?Q?nzlyn+VdB7uwxEsBfIqS2pKNe8mqVDUko3s/g1JOr3LA+4HKhv5pUi9OQIq7?=
 =?us-ascii?Q?69owteYTXj/WdHfSpied5C6lEG9dOTe4IxHEWR0uo+eSc+q6XUTVVgm7J1EW?=
 =?us-ascii?Q?m1aQruDPHTx70/7VxCc5FiKTdNDfTEswm24L7lXivcbBy3i+6zFHUwS3G54Q?=
 =?us-ascii?Q?+WF+FhCnshgIvVffB0FWFAbBf14D58okw5XRt54PXQRE5AjNWPAsMNgqLgVN?=
 =?us-ascii?Q?LkSHEr49C+Qd4gk4DpFQHQxgqzCYN8FJaObWYzuon3vEzETCMhPLu4cVJ6XU?=
 =?us-ascii?Q?wRbzbcCPIM9gckbVbTfTK7u10NkTUjFL7br34WmPLWOmyjEUCw4w08LdctDG?=
 =?us-ascii?Q?xWATivPWh3qj8x4gu+D7uRNh13z2g+rYeZopUJraJ7HB/cP0gGCGhvIzS07O?=
 =?us-ascii?Q?Qyih5l6mK9OdxJi7yUBUgpY0XNM2sdGbGZfFQg7Qa53Hffru+9+EYm9/DJWI?=
 =?us-ascii?Q?Vp3VqGXUa9n3ogL4RbaoWlSOd7zKv+0/zW/I4Si/7Ud5Fgwvhbl2kDnLuYxa?=
 =?us-ascii?Q?g9PtNT+zF1GQob1Z0ayrcBsUYhlfSxnw+VroKrrXfmnfCCaZxF27r0o7xtJr?=
 =?us-ascii?Q?K/ap6UOoZFYa04rQ43k/+BcHGL5JwfkroOJDJ2jjsACIKfbByN/5FJOKMclA?=
 =?us-ascii?Q?h9ZJLBSMRhQLGDvZgg/4pLMBnuznwiPb+CjIRjN5tszUhba5L/JfrLtGdFpu?=
 =?us-ascii?Q?225kHd+rUp0qPfR8n6FZyGGSB34ZgQ56dNMVoiM4juxCUsZ7/DtNxoxxyxeh?=
 =?us-ascii?Q?sJAwh6FbZP4ZHGUomQnvNygDYCc0vumtIzxwH4M0SZHBBq9yvd9b0v5ZqyXz?=
 =?us-ascii?Q?apJMJrL8ra341ZMG/lqcoQkLpGGPU2fdpH3Ex+Zuzre23gAosXt4wgQmE7uT?=
 =?us-ascii?Q?JkA9YwWfiCUxZygkseO8gKYV1m4XfwSgbvwNZ79USvS5LqDCEs+gLwpjBbCz?=
 =?us-ascii?Q?P/Cia//dtxW1k8nJ1XsGtM6VLs4fvfwdRBRl+xzeRtWP9gGLaZtiFJfiyy29?=
 =?us-ascii?Q?BoRjl0AUml5/1h9rjhRlkcrq6PK/ebZ13jfKC91Lu2vhmc+lZeBH6WqMohBW?=
 =?us-ascii?Q?At1Lepz1zR3Sjs5Om/Me9NWfhFSdV7VzI4KrC6CztOke93ulhF2s5V20IF73?=
 =?us-ascii?Q?Mm6UkUpg2SoIq6tg8A3TQfW+LhGXwWkds1tHhEITCuDXXEU+yYbzrbk6Ej1K?=
 =?us-ascii?Q?7lA/rXbRJPy7zKwhoE4jZNJUINRXDT3tDStHGp3rQ7F2S3OfUNu7KpxRVyJD?=
 =?us-ascii?Q?D79IQ+VijHuAH+nzAnapH1YIYQdvvY4m6yti3+annRcAiNpQpKdZ4kHmjp8P?=
 =?us-ascii?Q?zmSPSyTTW1I3vpHpFKSPZRAgzNQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71aace6e-3703-47cf-a364-08d9edb031e1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 22:45:26.0439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8ZqerHnBGzfZcdej6g7Gc+B3wMF8hxgoV1Cv99kkwfYw6WapG77+i5FyUXbmCRSn/ade6zeU/J2yNUUagsY0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5652

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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 194 +++++++++++++++---
 6 files changed, 181 insertions(+), 28 deletions(-)

--=20
2.34.1

