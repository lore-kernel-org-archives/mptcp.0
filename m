Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476E18C1E
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="xE13rrJi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JP+IiKonQ8IUauKigQOXD6YKJBtJ4hj7jlVBcPNFhptM8RTBdcX0J0E75woLmzDWAQsW4xjwWBKu0Cuzqk5GEfW73munrnUvDMb02GagEN8Qqi9JShmsu9PYq+PMkp15H/pwfa50eBioyF18yoXwCz3I122j3MA4PHsRx8IpO+n9ILmsXXT1pUFxTAA4Ki5ajuoqUxM5OihhpKJeMXRYA4sL8aMiw55nRCbiZIQEdPj7lHrTeH1crlnKEBP1entUACrW+1+iw5yRgEnVlmfSHIIkCNvXECQQA6KmuAyYacOyI0/vyUGErk08bN05vnW6fM1tdfVfR8i1EPctP8XeJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78uC9nk/vXQMliWPPphFJpXgelpCNlLg5Aqsd40dB7E=;
 b=ISrRpJ/BYavRfgpbg9EuD5HF9tek2ZA+9SPIsPkHUnDVzCJPOM1G4NHrYFT3M3XKoEukWkRSVJR4lx/r6VlZYo6Vz6F2+cUwC9x9D0Ap6mVyC8ok/umy/zIrLHNDOjtIq3Mntu+YKYNXbN3mN0E1RikoB+JPplSQ9a0iF4S5KDYN19hh9RHFrphR9GBY6yj83OfigPVLa2UYYxJJQFrEajEA7AlCewz92ApajcOehxz7SKTaaT5HauqtdfZ/09ryySHvb24mTJMsvEoHqPeUa2t5OAuSONPxLUXgxR8ZvEmmgv0ClQPhKXNv83tnK5Rgyt2xOIkjgXf+noIqExyNjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78uC9nk/vXQMliWPPphFJpXgelpCNlLg5Aqsd40dB7E=;
 b=xE13rrJidB9Imi5Ex/j+3QvMrkYYX3A3i4nqZzHwwglYMyrzNEcBvYSE/3/TT8WYVS8rLyr6KnS6UC0dExDWIfVawhukZ57EXPQtu6RRJTtKieOCGLXdXuQjJTRGesYJ/zBWRncK+da8fdi6SHrCfxCbq8fuNKm1K3TsjVO8PxQR/Lqfl81dSWnh2WEbK6Tee9Fhp70/mtT3rjtJTStvDVCIwhjNGcqQJHnFhALVKeQlJPNuirf22iBSQR30kjjUgz7EyO6WXTgmF/CJr9U8jJ71BNa+SjssmiPOvNfnu1KX0/4fIg9otZQ/+dLxaIHeWhwZSZETXe3vEDyn7Eqn5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:21:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:21:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 00/33] add helpers and vars in mptcp_lib.sh
Date: Tue, 14 Nov 2023 18:21:30 +0800
Message-Id: <cover.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: f120a0c5-18aa-44a0-658f-08dbe4fb86bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XM6CyxgaFGMfTwY9KSiexBA05nJdG9cK0JKroT3BQoxgLOhWoQRDC8/iv+SEMVmnfyiiJhhVgO2+twaRiXwt1DGha1dE3SXHbcyychDN17rWBuIcYdLOJib/4W4o9Yrgbo6/w8EDafMnRWISbYIIw7Zyj2FKIzPI3DrAnWNs07WrkgjnectaeQNWNwZnE6WncK2Q3Im4mUjkI5kPEkkTM8ea9gSAC7OlyaHC1TZiiwBiph/p2oY5Jt7RPTAAIVtcV2brt5ZfDRE5p+Mv0vsKvdv1wQUxzklSOZwswFaYXEQd7AwRsrpIWJS0HGnm4tMov8RxkOtYglXqGQpDq6u93K/I9Mb8MTX3mEYI0SU7WoPukPZ041jFoezvsCEoyfHqo7xIbCbPmvBT08yR1JC8KC9tVVo3DwRi78DD36J+4CqtaBeLs8JAIO+XGxtmkZwldt2G9ecenOt0K/wPsoMOQmDvpsrk7PWyvbs+GkPVrHHwTP31OdxTJFxxxKalGxc1EBGl+qf/NIEZ2TiwjV7b34Z3dK0jk6lLbAWMnGMOsOtt9K6Upi/Hd0E/ZITo5t0q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(44832011)(5660300002)(38100700002)(86362001)(41300700001)(2616005)(107886003)(6506007)(6666004)(6512007)(6486002)(478600001)(26005)(8676002)(8936002)(4326008)(83380400001)(66556008)(66476007)(6916009)(316002)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rxx+XrCpOlwv5sT+lRSw5iiuvd7agTI63JFe8S4uPPxBcR236hdoKv1Kf2cv?=
 =?us-ascii?Q?ncGJ0ta4olywr7CRlahJ4VHVuzKPNmY62iOs449bDtiQlnXkuLDA/f1MGxsN?=
 =?us-ascii?Q?1ncuO8TD02o0Icf4Ob57vtqoVBeLBb+9aa+zfBzEObXABDss5BhuGf+PL0Qr?=
 =?us-ascii?Q?7pOiFZkB1u5P8kqxjS0LIoRhc+0M33KP7SKbTD4gfZRDHIAPHMlrF3h32hTy?=
 =?us-ascii?Q?cbhQ8VH/D2QsalXuOAALOYRsnc16jYXnJnrQZzprKStMQsEZRd3l94INo8Bl?=
 =?us-ascii?Q?PezvMNKSsXMMZmImQ728UEAW2L5D/pw4lpwnRf1DKoBHunuOnzbIJNrfoaa9?=
 =?us-ascii?Q?r9TBu1hnJ2FEjWZePRrhQ71dOGft7yq0Cg4oPSFpQIEv86NNxMrqxO4gnvUB?=
 =?us-ascii?Q?xl0qNpSYp3omQeyxX8uVjSRFC/Yo/foef5eWY9aP6s3/PTJhvBrpmC3+Nqyw?=
 =?us-ascii?Q?xbAAhjEUhsAHuy8oroLsAHWNC9cGl51hgLtGrnW65GLnUhRN+GzhG0KlDl6d?=
 =?us-ascii?Q?m6Lw6Iy05kZq1/CZqxtdQGG7XOi/TBHfj3jp9D6RkMMGFY2o3aqNhm2GlI6w?=
 =?us-ascii?Q?4OzTVmjWZz6VUh5gLFi46s4wiPdHtHABNTIcK3oC6hCWrCnb/OdhKhzgLx1j?=
 =?us-ascii?Q?gBg4CqrB6lgUw/2uvvmAlXgfmQDBzN060J/bSc6Vq8ijOccJu2wBYkJNbBUx?=
 =?us-ascii?Q?F7xTrOB7f8lxrF29f0wLyeSwVCVtt8HXmY1zg23daNpUgGC1P6PCU3hxJL1U?=
 =?us-ascii?Q?nk4SGEplIxqKMP/NN47jLXgwhlSDvHM8vvlEnH2EgUdJIyKPh151dsd1F30p?=
 =?us-ascii?Q?OsFc8XjAHAdE3pQGc0Ce5+9h9vL5gk8CT3tU1FPs9bRfzjmlQLYX3wG7hndZ?=
 =?us-ascii?Q?OP1VAsEdLyBARYVvSM9TkUvVOWx1Ifj1w6Uw1S3MW7ZrncOsahwawxbgap4b?=
 =?us-ascii?Q?BlmyEM5jVxHdqqzLj91WG/b7+dugtVLk/4VQlSP8SgFSFN5SKH4tIuvf++wl?=
 =?us-ascii?Q?1yDMrNH7EDa5jcmxKwul16caHXQyxVMM9uMrgTjGDvEmUgiy5D0C6jFWFlEX?=
 =?us-ascii?Q?abQc99F8H8FMjn4nuDbTvFgxLEYPKVMk974poiyMvXraG3l+NOv6NaGJnNyZ?=
 =?us-ascii?Q?X7sOZR0Qb24s39q50G6b2leOujH9fwMBLU7boOVEOv9M9ettRwB8F+u7F2q9?=
 =?us-ascii?Q?fOnR1v8DjjawMvJ2toS6rS8pmOxJt3z40sq1O/2zFbhyz/8Vg0HJwqWQCOwC?=
 =?us-ascii?Q?opZ9l2jcQtlxJ6HzGdDsbZIVupvfViKp/bRRCSMQqzvo9F0OryAsasMH5ySu?=
 =?us-ascii?Q?0O6eM6K9g2oWJH97DrlBRFZAOax5cYGUCFtRHbiW09rwaJHb6l9RWF98oW4f?=
 =?us-ascii?Q?ca+UQg+dCvtoIgg7g4FZdhiQox04D/n0TVLEFIEukCYssqisMFOw6+7EYW5W?=
 =?us-ascii?Q?dHFrQdRV5wYjsSH1ws8q7rERyhTKXIFdN2k3t6PzI3ccx8CaT2RubBVCowqD?=
 =?us-ascii?Q?Ux/MeW4k7INqlyxwr1YaC9dWqa7aMn8rEhGSsm1Wpm2+d2szl5+y268dosix?=
 =?us-ascii?Q?vdGES22cpyHvfhciiv6MKLkW7h75u8YnEtR1w0Sw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f120a0c5-18aa-44a0-658f-08dbe4fb86bf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:21:55.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wrfQT9VdzWMBz9RrJ4LkiYNwFhYRZP0nG0UMDJC4kn+ej7wNXxZHdWXUWyB+2AnLdwEHKzZ+G2h+ovWfgaDcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

This series includes three parts:

Part 1: add more helpers in mptcp_lib.sh (patches 1-11)
Part 2: print colored output and test counters (patches 12-24)
Part 3: add more vars in mptcp_lib.sh (patches 25-33)

v3:
 - merge squash-to patch for v2:
 Squash to "selftests: mptcp: add mptcp_lib_ns_* helpers"
 - add a new patch:
 selftests: mptcp: simult flows: define missing vars
 - update patches:
 selftests: mptcp: export event macros in mptcp_lib
 selftests: mptcp: export cin/cout/sin/sout vars
 selftests: mptcp: netlink: fix positions of newline
 - update some commit subjects and commit logs.

v2:
 - add more patches.

Geliang Tang (33):
  selftests: mptcp: add mptcp_lib_evts_* helpers
  selftests: mptcp: userspace: capitalize test_name
  selftests: mptcp: userspace: print colored output
  selftests: mptcp: capitalize ok/fail/skip
  selftests: mptcp: netlink: drop duplicate var ret
  selftests: mptcp: export ret into mptcp_lib
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: unify namespace names
  selftests: mptcp: add mptcp_lib_ns_* helpers
  selftests: mptcp: diag: print colored output
  selftests: mptcp: connect: print colored output
  selftests: mptcp: sockopt: print every test result
  selftests: mptcp: sockopt: print colored output
  selftests: mptcp: simult flows: print colored output
  selftests: mptcp: connect: add PORT instead of TEST_COUNT
  selftests: mptcp: connect: print out test counter
  selftests: mptcp: rename test_cnt to TEST_COUNT
  selftests: mptcp: diag: print out test counter
  selftests: mptcp: simult flows: print out test counter
  selftests: mptcp: sockopt: print out test counter
  selftests: mptcp: netlink: print out test counter
  selftests: mptcp: userspace: print out test counter
  selftests: mptcp: export TEST_NAME/COUNT to mptcp_lib
  selftests: mptcp: simult flows: define missing vars
  selftests: mptcp: export cin/cout/sin/sout vars
  selftests: mptcp: join: change capture/checksum as bool
  selftests: mptcp: export capture/checksum vars
  selftests: mptcp: diag: change timeout_poll to 30
  selftests: mptcp: export timeout_test to mptcp_lib
  selftests: mptcp: use KSFT_SKIP instead ksft_skip
  selftests: mptcp: netlink: fix positions of newline

 tools/testing/selftests/net/mptcp/diag.sh     |  81 +++---
 .../selftests/net/mptcp/mptcp_connect.sh      |  82 ++----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 172 ++++--------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 191 +++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  64 ++---
 .../testing/selftests/net/mptcp/pm_netlink.sh |  96 +++----
 .../selftests/net/mptcp/simult_flows.sh       |  45 +--
 .../selftests/net/mptcp/userspace_pm.sh       | 261 ++++++------------
 8 files changed, 479 insertions(+), 513 deletions(-)

-- 
2.35.3

