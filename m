Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043F5173
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 10:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642156008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f5K6JjTMPqv4Y+woNC0TrP/7vJKD53mNSh9hS9ILyhQ=;
	b=aK2JGO0I/muuMUPSb5QPoDt7upiViH9FVS4tI7mFDzFD+zOLwWKOGJpyTIH/4n+28JOAio
	7GayzpTi5/FfTkvPIZidiV3AyFxbM/DPfBZLW0E/yWPzWMFtGYdplnXq83W0gl7sXNURTH
	OR0dz/bBilyOPdheDjNp4STjsvb1Bp4=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-rFUd4atRMBqyz6eXIpa7fQ-1; Fri, 14 Jan 2022 11:26:47 +0100
X-MC-Unique: rFUd4atRMBqyz6eXIpa7fQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7zNE1cCLFXcIxNfA1k0Nd+QmnGhaUklKY+zqo+kM3YKspDsdkLPh9NGSCyUvyBM4WmGYyfXybRvz8excmrIGT1AY1YqYHXD/mSkSRwbFbLPScgjyuVlp3yO5RjEezuJl77jpRYoDDArQzBjKl3lOIrCTiJ0UQILR3YF4iQjhiKTpajwiU4W/nZRi1eoIZQcOI101SAY7oroBpqxfKfORyKB+2cKbI0ufiosogGinh62me6kHX4m9BB3IvMPv5i7CtuQM/RW4xghG1i/17H04X7RIDZZSCQqkuLkgO+OFQFap+cWSJ/wLv7zbRifdNW0M0UpMiUU1ocG04ZvG98YFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFVlF38qtndy72Foa9eUG5aIGAJMaTx6BBix1Jhv3I8=;
 b=AFCHpVQnHl646arX3fAhHpCkBgNqbnAcBVT04pwbV0TRDI49NoGD4LUTQgQtxnoixtRzFekNqesF3TTgKOmtQNwXKlnHLsOJaYuXiuat5LZxtvCs7vkrCnLdlyyC+3t05d0qWGwb5jBS3D9a7eX/GabogngHqgypXvHrO0u6g70GtvqnWAUs55OCNrwASklUIrYdn1SZHh7HKknzJF0+W2F1ndn7aNWI0EumC8+yyi0NXuvE/uuAybzQSsXXgwGk3T9SSpPnQv8tZ3JekafrfqMyyWdh2GRM+M+QQmHHUyc0rBrch4ceTN/w1dvC2bqolGGyHD6Sqwhea0KmJ4ddtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB4317.eurprd04.prod.outlook.com (2603:10a6:803:3f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 10:26:45 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484%4]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 10:26:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 00/11] set flags and selftests
Date: Fri, 14 Jan 2022 18:26:19 +0800
Message-ID: <cover.1642154579.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 718ae298-777f-46e5-bf66-08d9d7485d39
X-MS-TrafficTypeDiagnostic: VI1PR04MB4317:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4317CD3F7492CD058D679F4DF8549@VI1PR04MB4317.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cknf4J1Z7HQwFjQoF9qFUik2Cbfk8NXPQzoO1ODNQNgWtb2abMiQwvr69uWmAEO9DffXKpCqkD5gkvDHrJSs7dvTDYYbwBaYi+71TIsDqRXTmIugt/f5jnBnOmr9f9xbv/rgM0HbCuuIjJo0B1vBJOZzJ2DjLiZm4J3OYX/1F4Z1LY2enKHqY5MKwx4PnnzLRAZb1i6J0/11O2WpAksL+goaNtU3nqGIrWCdPhuzU6DxnkrC1KHIqlcJtA1FB4CW65Zym78BTQJcAZ5I/944FYUwxLiKSVhAAVOzAm3Cb6czU8WLPxA547x0suknGAGHAijlYv76FHkGvqa4pVuJ+A2LrELkW7KLlg28x4xrJR9u4k8NNdyOKaEPW7W3QvPyPAglsGFNMETiJJ/pGaP5B0RKjRimUpck2xxDCiurN0erigrV2BOKqSDW2EyP2ZNL6R0KBQw/m65qrqgOvREPO8FXjO31zE5txZHg/IaoowH0ITc52VMqUugk9/Jhwggg35G8DWqzYF7ZSsJGk3TLnUeQvXq9VkJI2msJb1+7i/iFzKF89AAIZwjqdEZ+8J3TtajUdWt9TRw+SNr+YisIiz0cRWMRFLXn3KpX0zoBD1Wi4Ab8RzuSiN8e8a3OZnLU57pvmz1QGP4IRaR0+dFUgg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(55236004)(66946007)(508600001)(8936002)(6512007)(6506007)(26005)(2906002)(107886003)(83380400001)(66476007)(5660300002)(36756003)(8676002)(186003)(38100700002)(6486002)(6916009)(2616005)(4326008)(66556008)(44832011)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rll0o2l+RV67S5899UFWBdhye3GITetta0xX1WMmn+Ap+X4m+UzhxO1nMgol?=
 =?us-ascii?Q?XKRPTReLrXkCqux09ztehFRggHkAq9RkGRXFstUn7TNueomTCicKSocYGRKP?=
 =?us-ascii?Q?sxnlE7mJSYDOqcdiaGifQCq7fcxd1LcNLXwYcVFeDjEaCjBBP7+j7Zui+LPq?=
 =?us-ascii?Q?gjgnzjKJ+n3ppvOqYGNPuJ+5Q4kiejjCaU/1yKE3M6/t3RuTmtheyc9qeZ1e?=
 =?us-ascii?Q?oNUbyXNgaHEHiYOcCQYUy3yMT0ge5Rkbq1copHRX/PTuViesqFVQ8jFy0+Ry?=
 =?us-ascii?Q?tJCBmWNRqAZPYoGoNBLMnXBQCDzlF15UwToQHUC+IOhWnoIvLV1zHBUthhIq?=
 =?us-ascii?Q?dhRj80RkgkbCkdhHko45ujdU1w901UGAu5zQandHOQVzYrY7Bfe7pv+yZczz?=
 =?us-ascii?Q?A1ITQemal02L3GQtPJva/NEfCt9l5AX0qFlPXFnMq7FAcTXCp4QQTVHd4J76?=
 =?us-ascii?Q?tnFTBfOlVO0uNEgH7WymXvQOp1BLSLIGGWEAN39dxmDqwcvAv/qlgUMvoMEM?=
 =?us-ascii?Q?Skviy8Fh+yw9FP/QmUUBr9H/J2aPnHUBIPGZfGEW/OnEbUxwYrOxSkjwqMgn?=
 =?us-ascii?Q?58kZXXo/W/LgRlXTVOV0AIYHqWkMeCWwQ9JTV3jEUTssGeIQq6Dx9e7410ns?=
 =?us-ascii?Q?12TnBzFlWDs/VeW2UUNmiLwG5QyAVZfshd80HEycwiaAfEXiI2dcXaU0Rlk7?=
 =?us-ascii?Q?iRxP4UV/0zWIGldF8ZphcddN/NsjP2cc86zzQ7rishON9eBpJi9YKnb6/V4J?=
 =?us-ascii?Q?R4iHrQVWBgmXiPIHvoOQyv+rmUtBx3nJRbBK+AyQZStBRdGbsTnG3qFl/2BS?=
 =?us-ascii?Q?6jpjVGjBx2LrfUrO7L7vXQn/41wkLmfNdJgVSro66wxlvvX+4yjR7DTXwHxj?=
 =?us-ascii?Q?bosr3F1WGErLi3YZWLG8wi72yUa2yj+aO/t4bCG0laLTZU8dPRFBef71DN8t?=
 =?us-ascii?Q?c4ExoiNUvTiIYBeuvbCOa88Zplfkkmq4K4p/gLmGa8Br2jBEKbKYX3CWUwQ1?=
 =?us-ascii?Q?FZ8R76i0U5zMP0wgqlo6jNhCJJDQbYdRpFsQTY4sQI/ZnctIMyan6WFmX56d?=
 =?us-ascii?Q?l7M261+7ivNCNuWgU7rZtYdPuaaP6lzH4D5wf4DTq1EIK4zlmALIwI/fFiLx?=
 =?us-ascii?Q?eetkU4/hVR1tP3U4cuhNTF+2PjVcZdpJ6oP3J6hUrxKGrVj7wjpOpHzv+H7j?=
 =?us-ascii?Q?2p522/tl8B43sq2Ta1S6laq2lYAjhg4NejkqAi2a32WdndQr4fhSSEjHkifl?=
 =?us-ascii?Q?2LaeqKjoO3QXK8jKT9V1aEdA798Pmfgip50E+mgmYNvJUajJjUWoc8kKhsVH?=
 =?us-ascii?Q?/G0d8psMDXo+IHLcOZS3jIQbElbMxQyoCUnbabp5vbYFy7j2vzCwqxCzcQG3?=
 =?us-ascii?Q?ONcdyKK5c8PHHxpxMO7B5tqHCV5drAOfUYdcIbmB9Xl7ScwPuoyo/bbTb+Sw?=
 =?us-ascii?Q?A0/MyzSJPr3kX+ewUNTnzRe7XN8HVHCRoPE4V+5q6T4IEHMccAvvXbJ6MNpz?=
 =?us-ascii?Q?wLsU+TYIKFi7IpcNg8x/M8zIt4RkNSL2QGyvZoKuCAmK+cgz78RGkNRtyCdZ?=
 =?us-ascii?Q?/wM2N/4VaG2C9MKqMgWmGbhQM4bT+ncb/Vr7UXVVzBOKfJwOqxqBkQJXEwr9?=
 =?us-ascii?Q?5x8yDGEkg5w883JWbarOxM0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718ae298-777f-46e5-bf66-08d9d7485d39
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 10:26:45.4130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vU/3QMERsiOY1m79Bz0mz1rhy6mVj1dmCxvI+pXUWW12ueM07uIV2mY/AeTuWbRWN77PLX9bLLeggFtYE+CacQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4317

Put my three series of patches into one.

- update patches 1, 6, 10 as Mat suggested.
- support to set 'backup' and 'fullmesh' flags together.
- rebase patch 7 with the queued patch "selftests: mptcp: fix ipv6 routing
setup"
- depends on:
  "selftests: mptcp: fix ipv6 routing setup"

"fullmesh flag setting support" v5:
  mptcp: set fullmesh flag in pm_netlink
  selftests: mptcp: set fullmesh flag in pm_nl_ctl
  selftests: mptcp: add fullmesh setting tests

"set_flags port support" v3:
  mptcp: allow to use port and non-signal in set_flags
  selftests: mptcp: add the port argument for set_flags
  selftests: mptcp: add backup with port testcase

"use 'ip mptcp' in selftests" v6:
  selftests: mptcp: add ip mptcp wrappers
  selftests: mptcp: new approach of getting ID
  selftests: mptcp: add wrapper for showing addrs
  selftests: mptcp: add wrapper for setting flags
  selftests: mptcp: set ip_mptcp in command line

 net/mptcp/pm_netlink.c                        |  51 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 941 +++++++++++-------
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  19 +-
 3 files changed, 626 insertions(+), 385 deletions(-)

--=20
2.31.1

