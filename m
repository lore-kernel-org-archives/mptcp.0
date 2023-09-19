Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DEC34CC3
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWYZMFjmxF/NbyOGdQIzuGHuhp1gQZL2HIxH8eKP3PJm27GvhaFREbZJJYSXV9swyUygn20QbnB4Ku/FvPc76zNhfagwVj+27K9oQJcDVP1en/GQ/IP+EySZvtkkHUsiA6BBKw0IryePv6PzkXByFiyIl/2SuyGlqwBplvhP/RtKwP/JaEFDc4+VEYyq/pPy6BolGrxD4fO+Zp5ANhKb8K4+syBB6DV6vVsQhrNhwURazCrkefWRRCBm4qhbUIay+z6YfYUgHQVvERpSINdQr7d3WR0/NPXjUPzn3b10Zg7OE4ZKZr0PYcNslGWL6sBCG7JxHn/Wha3lXpHE2jcZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uqBYhQPB+BAt/U7f4jWrIgBrDRGMZa/NaM+G/0YCko=;
 b=Ar3Bb5R2QRqKEKS1VL617bAN8YVmZTd7hxAH66VmPknfIhIxfsjyNYEazpVKtpTv3YF2xF/wo7+m/kmbAr+CKZWXZ2iM1itXQrByOe0TEVwQRmcyqdHyghVZCk2XQ6+mFdge1Yz+JGZDYS6LG6CiCOyyx/gi2Ndo0pEwhmeviyNGi2dXsHq56mddMRdcyvMto3wJd+4AomQCun+ttl/9tcvvFPtzk+1n3w0bHosuVv/XBHM6jPnVRr9jlDnifkGYARmApaPTKNlvaTHanFvGRSx0dPsl0oDZAetL4J8d3H4LDmbD2QXoP8vvjeFgetXLIszjQqY3w4dIBssyRY9aqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uqBYhQPB+BAt/U7f4jWrIgBrDRGMZa/NaM+G/0YCko=;
 b=Pr9LhpdA88V3+WQFlxL/TOSrJi6Nn8J4Zl5ZjI8/vVF4p+EKhmKyNhsIonhTkWNtUN1QYm3G4Rm8gX7nC/aF3FSN9BT08BidHl7EObBvAUA5qCj6OZv+ZCnhQwZsO4eqgqRV/wJTZVt0bshCOmXsbP2Pkk5x0IAaWHDdiCvG/qWHOc0nNqD2+R6pfQVYTdBtEmPfcNjuvRRMQyGV11th0irDaDbGoJ6gslKlYA1IzfmlCiwYdwem24EhbI9mf8UOBOr5oUQ6GAlUjAkGhzA0N42aq0XPyMas3jzfDujhGuVo4Yo58qY6E0JX3vH/tzH/JH/ENcAyGUEnr7SlMph0TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:01:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:01:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 00/30] userspace pm enhancements
Date: Tue, 19 Sep 2023 12:02:01 +0800
Message-Id: <cover.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b48c00c-ff18-4beb-4368-08dbb8c524c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pB95FY4iFa2CQHMvb7B/KzSFru/HAgsKLLk9nZIIufFf5ItvR3/qprfBxhf5I6hlOFYLXXpgU3ssUixYORzsDYTjKeXOsNPK7qSBTBdoZ5nUJyIZevvj1mWQJm/4UdIhHPq4L/xkwCGVJHf52/aNRRBlsZ+S3G3jkj0/BMIqfxZEKi2Ii+Ln+GZJ1HSjBETwNN7l2PRetO4HCICiKwT7ekFOnXPpx8WP3IF81a8WsBMSbQZb2Ab1foKRS95tGhmYutr72VqXpDVcdHMbCruvm3i7yFJLmRYyw/y4318cZuk09Ky3gyROkShHwj1pmdeQ0pbF0RWk/vR6klGyXG4/g5r04JujFoOMFi+9XN6J3NxmBkdw4qeOAuHWL7BRUKQS1iY1G7/zicuB7prOHNryNj2/pTjsKOwXFfjdJlyhn9a5PXvxRfPb7GFFmbi+eTFoybqvFAn/c12o3yXQxDaPC9bH4mF2ko5UwNmZ9ijS5C84OvXAlFX++fZPEXSzkBohgp4V3MD7DkZMmvyEnxOAB+wI8/TuZ3WrfHK6RwbkQ7u/Q7OMr+i0F8YJNyuUtdcIJ+ANCbGQUT611DtZGnVjxuVRn30NiHFcMFsY5YxzPGw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(2906002)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(86362001)(26005)(478600001)(44832011)(6666004)(5660300002)(107886003)(8676002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gTTOyZwrfrFJp3vqqyp28dOXt5Vr01jmJELtLoYE7RLYRX3EpndigL53RSV4?=
 =?us-ascii?Q?/NDKBLnU8ebrUr6UHV0LocyMCmzBIIuP1lwnTB3SqbC65MLtP2QuDgGqvFvY?=
 =?us-ascii?Q?VDTPyi17YhXXW7/+CXDHJt3lVKMIjxIwbVYyGXn2DxbfGUn9mPpoEWlok+oa?=
 =?us-ascii?Q?XiEWIIggdX0GP2js2Y+30LmwxJyUiWpojaUz+y1fHJHsptS/EbJxPx7vBWmh?=
 =?us-ascii?Q?tojM5RDeIsdNOFAMZBKkkFRXf30ntorOpNx/7ztJh1D/1CEZn6G8biF24P2g?=
 =?us-ascii?Q?scl60xMAjMaCjun8zkRhQ/hbTRUBActsCy/N/YOiykfFh7lI4YuLKLNrsClJ?=
 =?us-ascii?Q?D6ts2PCAOZUC1tuaK3Lp0fREh+f+Kx3Z9NB/NxrMS3Nut7JQEjS6cyDeVYtf?=
 =?us-ascii?Q?0tD758VcWFvxZQWzZ3j2lOwuPYuzgPOUoiYjQn0uBmboZ7msny4QJNbookfk?=
 =?us-ascii?Q?4q++EughLpCytSg4ZoxI6OJ6ry7uYTtRBar3N7put8919Zs3RG1bdbQc3C6H?=
 =?us-ascii?Q?DYUAQstOSS4UiuoTpMWLT9g9CeDYi7wpPy5SifirVF8E5sLvXs/QYwAvPtGl?=
 =?us-ascii?Q?pKA0CprLfmH/PEfcAX2iMyuWSsUbklgNrc1L8Qv1CpVrNZ2oc121mXKaKXkT?=
 =?us-ascii?Q?VLmz/hwPP0sz96qR2lwQdZ4AXfFhw4WTJvJF4JfhowJ7ZPWV2YwzREASbsTQ?=
 =?us-ascii?Q?OUfzkWP/pcW7fJLOtoAx2TEl/Nsfqtol+LzU30EK5PGTrXhPVFw5db60g9Qi?=
 =?us-ascii?Q?EIzvUlF1UyJk0sf62b3awrcjg5g8mThd7z2VFNvKMLs4f2jbyNbUs6GFiUxt?=
 =?us-ascii?Q?JOJlW/Y02Uez2GZX55vB2EG0a0KGFfxlHeK3K+eF/sUkJmo28Zo8gkcLozP2?=
 =?us-ascii?Q?1M6mjoLI3/ORn3QoNp+9iqMhGhUTYdJ6dVD+YS10yUC8nScqWC+CKHUF8WPY?=
 =?us-ascii?Q?ubEKCO4XDUd9oZtEkViOSXTuDTMb1vKGFcqXIcIg47wEoGFwkBHX9MScA/ul?=
 =?us-ascii?Q?eoSYJYML2ZW3PSgrdkjRvWXGuUOnOUr/G1om/scUdTDEoiZ/9MHK1OMNxuZ/?=
 =?us-ascii?Q?yv6DjoRKEkGLcFhCSE5qPsDdKQUB/RCQN6Cmgc0C5fz9kM4JbOUagyKyX5Li?=
 =?us-ascii?Q?+DgQvy42+4CeUBNHqAJy1KtqOp6m94mEHmTRVtpUkE2U3k8TVc76uPbZ+gFL?=
 =?us-ascii?Q?RjuGsuB4WKinb/cqIEsY0+P8TMtHSJDa3ZNJY7wct2Ji20aB7wLbkqUU/kFP?=
 =?us-ascii?Q?/2tkzcwgfaD8YmEcvDIZPJHnHKBmLS6qjNXFjEIu9ApG4TDFKDMqkYMfwEZR?=
 =?us-ascii?Q?7Hkaf1GqyVR6PtyAyqLbD9XLbwAaFw1QjtRrguJoLbU+VUVlhP4mmm+qFZJs?=
 =?us-ascii?Q?4/VSf3LZKwLjqAsJ1e7t+HC4wbaigGLVxSBYDPEHP0WO5qgTi50w1Vb0bBve?=
 =?us-ascii?Q?iVtoVuHlkEgmlg3FufMlO7hRazqFe/UojHVXYG/3u2mLyZoG6qvdM2CFQ9jo?=
 =?us-ascii?Q?Xvulc7yfPoWMAEo2s3OBZbRtAJByzDR41ZnPw0mH/suslnGO+aiq9ozkEssb?=
 =?us-ascii?Q?8GhZJcUAacOEwdyAWpA3l5iAb+JNfUIo/s5XXAYs?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b48c00c-ff18-4beb-4368-08dbb8c524c9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:01:47.1426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zryAW/bg2RQQW4QqI6iloY9J9yxpdRteaFXoUQjiKW4solaUqvlMnq/ysIlzzVA3W0HTp5vB6zpNXZ62syn/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

Some of my patches in ML are conflicted, rebase them into one series.

1-8: some small cleanups, v2
9-10: address #428, add mptcpi_subflows_total
11-17: address #379, #391, userspace pm remove id 0 subflow & address, v11
18-20: address #403, add refcont for address entry
21: add userspace fullmesh tests
22-30: seltests cleanups

Geliang Tang (30):
  mptcp: drop useless ssk in pm_subflow_check_next
  mptcp: use mptcp_check_fallback helper
  mptcp: use mptcp_get_ext helper
  mptcp: use mptcp_wnd_end helper
  mptcp: move sk assignment statement ahead
  mptcp: define more local variables sk
  selftests: mptcp: sockopt: drop mptcp_connect var
  selftests: mptcp: display simult in extra_msg
  mptcp: add mptcpi_subflows_total counter
  selftests: mptcp: add chk_subflows_total helper
  selftests: mptcp: add evts_get_info helper
  selftests: mptcp: update userspace pm test helpers
  selftests: mptcp: userspace pm remove id 0 subflow
  mptcp: userspace pm allow creating id 0 subflow
  selftests: mptcp: userspace pm create id 0 subflow
  mptcp: userspace pm remove id 0 address
  selftests: mptcp: userspace pm remove id 0 address
  mptcp: add userspace_pm_get_entry helper
  mptcp: add userspace pm addr entry refcount
  mptcp: add netlink pm addr entry refcount
  selftests: mptcp: add userspace pm fullmesh tests
  selftests: mptcp: add mptcp_lib_kill_wait
  selftests: mptcp: add mptcp_lib_evts_*
  selftests: mptcp: userspace: print colored results
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: add mptcp_lib_is_v6
  selftests: mptcp: add mptcp_lib_get_counter
  selftests: mptcp: add mptcp_lib_make_file
  selftests: mptcp: add mptcp_lib_check_transfer
  selftests: mptcp: add mptcp_lib_wait_local_port_listen

 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/options.c                           |   2 +-
 net/mptcp/pm.c                                |   2 +-
 net/mptcp/pm_netlink.c                        |  25 +-
 net/mptcp/pm_userspace.c                      | 139 ++++--
 net/mptcp/protocol.c                          |   6 +-
 net/mptcp/protocol.h                          |  14 +-
 net/mptcp/sockopt.c                           |   4 +-
 tools/testing/selftests/net/mptcp/diag.sh     |  23 +-
 .../selftests/net/mptcp/mptcp_connect.sh      | 108 +---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 460 +++++++++---------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 188 +++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  55 +--
 .../selftests/net/mptcp/simult_flows.sh       |  19 +-
 .../selftests/net/mptcp/userspace_pm.sh       | 199 +++-----
 15 files changed, 662 insertions(+), 583 deletions(-)

-- 
2.35.3

