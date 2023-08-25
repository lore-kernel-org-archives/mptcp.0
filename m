Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2055.outbound.protection.outlook.com [40.107.7.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4077E0
	for <mptcp@lists.linux.dev>; Fri, 25 Aug 2023 03:50:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhMoUbvNsBlrHXEl3HxTb2/Zk3lYoqRkucoolfWLPKJ3r8HVtVehx+ZwdzijHL6okgFRZn2eVvA+XGoqoQWNlPew6uvemVHHTvT46zU8pevca8ogoZ1cjSXaRz2ThnwAQwkRgjwI5FDNsGcGQdPdmMIcBc0YcEVrM2fdwBqfAezO2sAESA/wE+WCfpdbmiAHKrZrkQLGaACLfSh7SUP66JhqS0wt5yXbXA49LdDeq01AGg6w4b+ie1sggNmtL65NevQzkWnPpEbuwwdwPyfi+b+z9yHbXeZTxDSm9jpQ3qWfJpVidNv6Q9OBabX5PyxVXTnnbLJ1Ua7x28YFNZI7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBm9SOOxjGm+PKfmcxNE2rP+Z9uQ5QS0gTSI+HcodZI=;
 b=iLMxkzL0IBML9zZ3nbi7mPIm6S9axmlT+T412ckPHFjvVpEnbqajYz7VN2CuyuxmAbrE7lI8lBWJFGr20tLSotY+abGTmGwEE8IsfHIRkJtSEsLCFWBDnF6RZxtt4ZInhsnGHFsmWleRKQklN/l9QZ3GWHpH7vupCuGEcT75Nq+9/UNnRVBpZT+Rgjguxg11GqJghd1b79g7dvQJqwvZWkL4tHoPNT6xAUjn8Qb66FB/scC2d9Qs82viDNBalqoZwfpPBigWzESBfQHeGh6bGw89JeT4hH1qZqW7JZ3srf/q0Z8vsTP5nC2O4Sxj5ikLp8eMPRnJsbgZmO3KzMHdPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBm9SOOxjGm+PKfmcxNE2rP+Z9uQ5QS0gTSI+HcodZI=;
 b=m5++vLo+aISHNs+M2/qMxt/ihWUa1NQUNT66Lcrtq3VT8q8NtqtA0YmDzUZOo8iLUqbHDxbunJAJbW7ucEZ02GvLd24cfsNxQrrlvdrhqmeC3dTzSpdD6czdc0MUlS/Xl3CmN0+tewrHJBBB2+gIeFzoA9ZUFmly/u3utT8/Ow+iFZIIrQonqVjaLAtBZ2QSYCzR6mkM6cTJUOVjzwJv8hxwKzA7s8c8/CqtXFiNSLKw45rGh2RYtA0RTz8JojeVY6pa6q0P0dwUEuaTJBjOfPL4PMbgOdjgqmdFSiPf0tKjgq/S7g45US4mEBBxdkVv+JuMjpKPVgrCX3PwZ9P5TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7091.eurprd04.prod.outlook.com (2603:10a6:208:197::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 03:50:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 03:50:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 00/10] userspace pm remove id 0 subflow & address
Date: Fri, 25 Aug 2023 11:50:18 +0800
Message-Id: <cover.1692935143.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0125.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c4f001-91dd-4518-f777-08dba51e5fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ipxlfnRhGavYHBVynJ1LW/Owmj1eBb/miYH1/N9xk6xHSBl67I+mTAJ8xHu5sK3F1MnDbLp3Csfn94iRr893y3ZEADxHguDnwXGZ6fwhUjE+65ar+P4lH+yPXuCW9lWfONKPEB076B7cp/TIC/v1iqKmtswsYKyqAMRni/U9O9NmOZzwpebuBIdsBURcSCBKNqhJHnhTLGyBYi5ImEQQ4gYzVsf/omekZIRwaMm6SU0N5h8s3l/Z6wzSbSyxRwxtUIp3fJx3TwqQWHqXhhn8xfRoLNyh+8IJpSaM3l96ZVqgDkoqvIw4YW9/lQ1hQvpO3ggrj3r0NgkoLEUkiVkFlILUvDv2VsBFiY25cpKFd3TAcbup5Izrei4lrvqAAJY5pOKk2wtpoRHBvexo1MjdP/IsbsBeeXfHB4PyGfkgwdSdmprZgqRsjjhS6t/q3YouNURXTKlKx31uqokqTag3yrroLUiUuOQ6HtNBitxJdh2BgVO016Lxuzjp4O0Wn3tD/I5kFnP5TJ5ZmxyLlmFTvlFPa3WIABTrlTWq2XcTsByx15ijqgEcRXCSIKInAxJO9mvNXlQ+MpQKo1HNjRprGpzv4Mn+ug53HwCmkqkabPI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(38100700002)(4326008)(8676002)(8936002)(41300700001)(6486002)(6506007)(316002)(6666004)(36756003)(6916009)(66476007)(66556008)(66946007)(86362001)(6512007)(26005)(478600001)(44832011)(83380400001)(966005)(2906002)(2616005)(107886003)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zKq05dq0/r2BnTPUo4MXXWPWEalEewyAXdmWyXwpKRDN+2osUIe3YDKotNpF?=
 =?us-ascii?Q?BzaZ279cuGhsmtzopM8hofr1ZjvsZhDTFkW1oTbNpliWPa691LPGH1vSim5V?=
 =?us-ascii?Q?SPTbSdYMXGbx5HZ9UerXcyWmJBr7FF0YNoHcH9vATY04XsCBDsR5n0jL6/nf?=
 =?us-ascii?Q?5HRxYgExgJvuilpnIam3AMw14Ny3RspjdKyBS0LSfmerzrmJh3B79Ig6aWsT?=
 =?us-ascii?Q?9Gtam98ZjGZrALvAxaO1a3JibPk03C27k3VOmBtmcMbritg0ZcuDpDaIed8c?=
 =?us-ascii?Q?tT+35Y6Yc+se1DJiLoaZJ2/MPQasEs55RryoPl7mr8xjccszsywZv+zEithd?=
 =?us-ascii?Q?1o2PZdv7btAxqIOUqLaGFgW7NTTwNSFApnqMbxqC6Dtr0q8dv909VmlipAO+?=
 =?us-ascii?Q?vFUj6ke9g1KXZhBTlDh2C+X+WiTsBQwulvpU9DeEYAdTEgTp2zL0vTvbplgN?=
 =?us-ascii?Q?6nH9Eo3+vAyipAbDf1nFyRhpDHwNkpSsbCLM7OgfkwQGfBelGztIlNW4Z/iK?=
 =?us-ascii?Q?T57hPLstIMQBT5ZwhZKSG5PfAoFXH+xmQnITwVdseWukT33KeqQDPjBw8Xat?=
 =?us-ascii?Q?wCpM9BkDrT3XG/mVRx4Pi4BL00Do+uZRAIMnhG9oF8nXnkFlJ/YN/u68aopp?=
 =?us-ascii?Q?fV2T0EchS5smoBNjfI9DJyfoB2xR9PprXe1pYGuYenNGCtKOcJXer13RzWja?=
 =?us-ascii?Q?01+jRF4ClmHIuVXzmybPeDdBSBJ3Z7bxf6OYiB+mRtVKxX/tAtx+mdwR36Ov?=
 =?us-ascii?Q?VAvXzTJbQd3T595dUQDAFrlqkJPXVWHqSIiUkTxVaAr0ZD9hdGIXfAEUpstm?=
 =?us-ascii?Q?P6uqeU7FwVWFRYZSt6/tOIxSOgvtG1Vjs70fXVkxjNcN73UPD1PCqgE3ko55?=
 =?us-ascii?Q?tDjwYu9/j8QOv0QTG4+VNSFfdXNIb5QYc+E4beQ1RPLQ4bFLzRKO9z9pHlb/?=
 =?us-ascii?Q?PCPKYsB2T4uKrplJhjzYpzzuHD9GWkI39mwNbNdsEbgGLNaavrv1M2IQgeTp?=
 =?us-ascii?Q?+gslWISZIour4O/+Lxe+KKCHRcqrbDrV3JzZ/Xp+BSxJKXcADbQgs4BNPmS4?=
 =?us-ascii?Q?Sk7YcBnqChMYpBidILeK/7IsNyrefY3MOXnFKwbsVBgx4ymrUVolY8HD3eO5?=
 =?us-ascii?Q?5PCATQyoRgoaNaAi8wu5mVA/danpnJORszqBZET02lGnykeasxQOsxyFsdx7?=
 =?us-ascii?Q?1Hf3ba7whznHkj2uStPZenh2kYigyDg0Bb9T8JZqPu0Zss8+zCpTKOgMLqMp?=
 =?us-ascii?Q?QWY+6Vu1BITn3F1oOoRNfCMxyCOy4SKLphirWmtvV7eQaJ3OYZBRkNYZjZe7?=
 =?us-ascii?Q?vhOgERa1G1k6MdMP+3bRavImejiQf1RSBNEz8PbBFAtNGNII2Tt4VwPKBlX/?=
 =?us-ascii?Q?oJVnZqxQEAXgE+XQXvKZu8VhffkA+iljcAc4Vr6p1CzpaMr/NmnTIhZYtpmi?=
 =?us-ascii?Q?D2NMStgnncNR2/YGznuwbVVbEGst0mK+DBCmPH12Jh4rwUQfp73I2Usm9AzP?=
 =?us-ascii?Q?IMmR25cm/qkITNndL3nE+sIHc3LDLWYPkTZbh6g2Jd51DCMLAtbehGkEq4JI?=
 =?us-ascii?Q?VI7SdEzpBTrLMPhTB1jVQGlpWj6sa4mdYoZAcOVV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c4f001-91dd-4518-f777-08dba51e5fb1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 03:50:07.9449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVD0MuMXsGkX0GiOuJmay5UIIalgZGL9sfhzO56Qi+33RTXTXq7sSCCHeNT9IXNuoBPH3jsibiO+ISY1zr9Oxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7091

v6:
 - add a new helper get_info_value, update chk_mptcp_info(),
   verify_listener_events() and pedit_action_pkts() too.
 - only patch 1, 2, 4 are changed, other patches are the same as v5.

v5:
 - update userspace_pm_add_addr/sf helpers.
 - add userspace_pm_rm_addr/sf helpers.
 - remove id 0 subflow or address will send MP_RST, add chk_rst_nr for
   them.
 - add two selftests cleanups using for-loop.

v4:
 - add evts_get_info and chk_subflows helpers.
 - split the selftests patch into three.

v3:
 - address Matt's comments in v2.

v2:
 - fix CI errors.

This patchset addresses #379 and #391, add the abilities to remove id 0
subflow and address for userspace PM. And a selftest.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/391

Geliang Tang (10):
  selftests: mptcp: add evts_get_info helper
  selftests: mptcp: update userspace pm add helpers
  selftests: mptcp: update userspace pm rm helpers
  selftests: mptcp: userspace pm remove id 0 subflow
  mptcp: userspace pm allow creating id 0 subflow
  selftests: mptcp: userspace pm create id 0 subflow
  mptcp: userspace pm remove id 0 address
  selftests: mptcp: userspace pm remove id 0 address
  selftests: mptcp: simplify checksum_tests
  selftests: mptcp: simplify deny_join_id0_tests

 net/mptcp/pm_userspace.c                      |  40 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 353 +++++++++++-------
 2 files changed, 243 insertions(+), 150 deletions(-)

-- 
2.35.3

