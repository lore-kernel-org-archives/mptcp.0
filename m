Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0269E196
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="t8B88HMt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VarbOHObC0LKccZzsPnWjbeD+vmytJ8S9f6snET22G1w3UKpPxYonvdjV3ydjyZ8F/6IWScWjYeClq4+tiv4beFZHhG09aJPFLueWEqZP+m4HqHNq+Ko8d/FBf9TLJuRSx+qG+KQ9yMpH+9mYiJu5BlEvhZur2iSCby3401YAP79qHcydX1EPSXpezEVE+JS1x899GQ8bro6KeaNZGvzfy2N22zJCrphKEVsZxSdfLCdvqH39SohHUnxVzBD1FbOFyA5YS/AtVhUpucUMkoAOf8fu/KdWW7QGaBdO6GVqvjQ7LyFtmOQRFda1fP1lzIyolxpDHfgahU4xuLpGVqpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWicl5sn5hmbFFiFkmZDSPHoSdkRA/uk6y7PDVsKOyg=;
 b=QJpdCGpy+tY7/SlQqJsUSqoUDlLIpODzbi75ea57aGsxZg0s6d4SBRGKFJ+LrQtIJkz4MzqX5ny9xn6+tTebZUvdlTUfkMMtK+lFE1ygY64qAJ6kp/avYtzeoJYO4DNHkFsgEVPGLUSak352+EJQXyfaGZnR7Megw3v0bzYMTqZPNbqkWTxGDdh40oEx54/wImxuzhaamcHjdi37wKC+owMyY1EfffZbv615tEuuY+RCQBH85Tizjo7+q1/bmwHW9sb21iNhO3bkzGlSEUE2VSOaaVkq45kHV9qme1vCaHR1GlnZzUXMHDlvl5NvCIYWmA88XeFUntmIeYFlGyowYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWicl5sn5hmbFFiFkmZDSPHoSdkRA/uk6y7PDVsKOyg=;
 b=t8B88HMt8Mj2hXdyxuShVSflDWMWmbEbBJiizcu0+z6bxg1YRvt8AKhuHZPhM8vjKb2mIFezi2zSyinZ4kDB4xXBKBJAqMqB6k8T3HtQ82kQEvg2UbPClyvrKWkQD9FFdBxHQqRmDpXd1jdKfT+dxwCBkAo0EY4W5C/sce00h45BHRqCJwy07BooODBRV+qRl8Q5UbDnhyX2oZ79g91K9Hcmu6R1HLsqKDrWLaE+Vh0wyREaxpmz8xlbyw/nljzszWQ/bR0NuJGQm+qfae0Jcj0KrSy7DXQeNWoDKWa9xWkqDTV/3r3imJUIDNN0iFuApW0S0BchNeJo6HPjXtF74A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:28:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:28:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 00/10] add refcount for address entry
Date: Sat,  4 Nov 2023 08:26:24 +0800
Message-Id: <cover.1699057400.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057244.git.geliang.tang@suse.com>
References: <cover.1699057244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) To
 HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e22468-1e4b-4287-47c3-08dbdccce88d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VQ1SipmambtSlM8eg4N5q84kGhJW8rfR7R0vblQ7G1N35dQ4EdPw5+aRbYuj4iUd8lf/MZ+blLn2AUI24jx+Rcv6OY+89g8UbdX01AadDpAmXNhGcu93ZLH2mZ754+tQEcPz4dlpvNTumZoEVVlaMys+d9U1AI/r1m74YfyKjByBuhcLPSjK6NIr7bC52cyyByhbosXv+e+IvpRh/XaRkCg6TZzc2PZulSmjABNFG1HbwCDtOjXKzQ7Sw374EuFEKwuqvP2AOnXLLSTghAxK4y3BhiKLjX+SQjcvmwXOITw0j/K06IVfUEggqlWsBoK+mbfHuocBEMIBLN+uQyYTZxCNE3eZLIca+qfyOAVmdVrgJBhuqsBVo0Kg29ePlcv4bV40/NI4tUZH16quQGDkHqtbG6qp74T7z1EwkstSvcwtLmOOy8TPZ/NIfXlf/GMwIw7KsWziNsW8tnC/zTHPlOUhXugUkv3/vhOGVZO2ZZbANoBtlQx25Hx0agok2uvgEO8U+sZf9mfLQQCL8Blo+eInKR1DSgCHPgG/naQyYbPApMovwG6aQUVHLNhYNGAy34RonwcycBjLQcPi5nicRbv59evnCY4H3rTA7HDZwmg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(5660300002)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(6666004)(478600001)(44832011)(6512007)(107886003)(41300700001)(26005)(2616005)(6506007)(83380400001)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DYrq1v6mJ42yftt1xREVlJ8+hl4LPVagTHsovYNUXylNv66fKKWKaHkEPD4Y?=
 =?us-ascii?Q?SsZJUbVkLIRvsddU/Qta0PLqEcxO9Ljg4HJUf5DQyv+Jxo8ti8nnkAOzCiym?=
 =?us-ascii?Q?AGid8jWFPYYUGYSIge0c1XW5/bpHldOP4uRIEES8544kdFMbFPrm71yX6ygB?=
 =?us-ascii?Q?PyO0wXB941t0b92o40CWkYBDETdn/HO8Az7UFJ8duQviWGVm4IwiK0i2aO0S?=
 =?us-ascii?Q?kfU1xE5IKYz6gaoOju4uayNpYl1iMjdW65Rf20MgQmCX4Y8E0Fnrt3mgKZUV?=
 =?us-ascii?Q?V0yRPQf/AjAQpskNkeErTCDrrgIjPfULcaiqleXX/FUH5vQ2IN0EMRjDIOdP?=
 =?us-ascii?Q?NVukCuGQFxqXYM887MjM9wvsTwotmsmRZ5+9Uzi6lKw6WtKfTsltj6Ea4byh?=
 =?us-ascii?Q?LF4DiNIZHqp6IvcbOcg986ixG2Z0EYw3YubUsD2KDP/8itaqmFk1x+v53vH8?=
 =?us-ascii?Q?NvNiVQ8gOAIFMl6x4k+u0ZUxmfZi/tIdUwCxJXmerZUN6YzPfL0A49aV0dKd?=
 =?us-ascii?Q?OatuKyWmmST9Asa3IhUQB9U+uoY8iAQSWAuJszo0ePoWc/gEJlTLCpQ2fxyk?=
 =?us-ascii?Q?rL7qOX737AdKYcKItRK8/qV4Y+w+wd1Idb9N/pyAKrrksEQK1QjNBOqCgIU9?=
 =?us-ascii?Q?youk3S9HklQEPfJVpc6c5OhZ8vxJ+aZ4a6xm/Xm2siGF3LwOElvldXgxAcwc?=
 =?us-ascii?Q?LTKrZJ/oLOYUkJ/5lyKgEUr3NwP1K/Gs0MPvH5RcernyKFNlfzu7JG3Fl6zo?=
 =?us-ascii?Q?USlkK9A+QbowUSVPRfkupUuSlKnbZedbhZxHjAmqJaSWVngS4nnU6hbk2YEb?=
 =?us-ascii?Q?hqVl3SDmrjNpnU9S3cNT+e7pzJC5XsQ9pZZxtddMtyEnjHFPQg2Rh7gF3Lgr?=
 =?us-ascii?Q?kCGsZBftj2VJZ3Sa3ZZ17Fb9a59+IJJ5KyFaiiclJK9yTcGBFYq4C2b3nTW0?=
 =?us-ascii?Q?1VVWoo45FiKrbPw9QZT6BvtTejnIR7zlwK/I7gLAB9nDPGw9FNGaANC9dy+c?=
 =?us-ascii?Q?oN3uPJ8MY6iVvL0cIMBlhcHVAq/2QwV2voetqXcvQ/0sOW0o3kayFjWOWg3s?=
 =?us-ascii?Q?nOGgsq0BhH+ve7rr15xEuhNRufAeBt8Cve+HTLuny9QmV0HgI3wMIxGx0B0b?=
 =?us-ascii?Q?zndn7Pnu2/sd7CrqOh653EUtSFDeeCyAZFYU+WUJ6VmDmW2qJckj6vVvkGAH?=
 =?us-ascii?Q?EpUkF6BezselpbykGse23s9vbhu7i9bc9600Y4hlTI9+Nt1lksH63mGLwEoJ?=
 =?us-ascii?Q?wJMA//UvlSyz9AJYKW3csM3UFyWSpNtUJ+q/HgohoUmx/ASw8b7sYhqHBZtP?=
 =?us-ascii?Q?O+BIny/od5QgkmKxNWiLYujh3ac3rAM+dTZ4sEeBGLfJhRV3SWSn50Ugq2gI?=
 =?us-ascii?Q?j2dM3FDVkCCWhS+nVbX23y52GXLwP0MbjRwroGVcy84M3yFLLaRp+2DoBk7j?=
 =?us-ascii?Q?grLX6rLgB3eMA53uPJL/TAPxd4W/2ipaLOUEPIiWKv4+wc5QaRp+M4EOeYMm?=
 =?us-ascii?Q?SLiJfiW5odBxHUPsNzLRzM9HTYNJ2Y5XlplPQ9ivNr2Zf5dGuE7soN+olHOH?=
 =?us-ascii?Q?y9xXQCbx+EN+pcew9EX1BDa3RwLT1HrSF9wBwo9uqHlWgQG0XCOwSoNyJNw9?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e22468-1e4b-4287-47c3-08dbdccce88d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:28:03.7470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBKyQIFd5jQkVxfa0BhUVAkVl7TP198Rab/ArmZ8kxXhBWiBm7XHb0zkIE5HaNyEv/5Pv1ciR0lN3ClBnMevOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

v3:
 - add four selftests patches:
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: add mptcp_lib_init_ns

v2:
 - rebased with "add flush and dump for userspace pm" series.

Add refcount for address entry.

Geliang Tang (10):
  selftests: mptcp: add mptcp_lib_evts_*
  selftests: mptcp: userspace: print colored results
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: add mptcp_lib_init_ns
  mptcp: dup an entry when removing it
  mptcp: add userspace pm addr entry refcount
  selftests: mptcp: rm userspace addr with random order
  mptcp: add netlink pm addr entry refcount

 net/mptcp/pm_netlink.c                        |  19 +-
 net/mptcp/pm_userspace.c                      |  39 +++-
 net/mptcp/protocol.h                          |   2 +
 tools/testing/selftests/net/mptcp/diag.sh     |  48 +++--
 .../selftests/net/mptcp/mptcp_connect.sh      |   7 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 129 ++++---------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 162 +++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  16 +-
 .../testing/selftests/net/mptcp/pm_netlink.sh |   4 +-
 .../selftests/net/mptcp/simult_flows.sh       |   6 +-
 .../selftests/net/mptcp/userspace_pm.sh       | 172 +++++-------------
 11 files changed, 321 insertions(+), 283 deletions(-)

-- 
2.35.3

