Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D2557D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KYfhMFEkKP4P3LuSYRY4rtEDGdqmgE2P2whAcOK8VqI=;
	b=VT3FnRay/gsT18AOnLwi7ZJJ+MWoc1L4fVmKV+MQZfsg16A1VKnJGJNZzJM6KzeTCNuPLv
	lA8m6ZSgCw8mDrOdynuTFLtz8CvbvAGY3FJqdvTPV90wreL0b6UUrkpLco6WTSbRSRWhVX
	dADfDyomfC9/jjHQ4/xZGAG8/7AyZx0=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2050.outbound.protection.outlook.com [104.47.10.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-Cmn0CWATP-mpGtnCseBYNw-1; Sun, 20 Feb 2022 00:17:29 +0100
X-MC-Unique: Cmn0CWATP-mpGtnCseBYNw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCrh1162eag34S+YysfY6Acdh7AwPb5kfBBPFw7QoHCv90jZgtm4pcUq9RJxxDMR7AgJfQdJwT6iuKXlncgN49gR7L5AffBhAoUAq+TBueoE515VbAOrLhESrklQasaeartNrrE7Tbns9LdHBJIJNKRAKLqr/furJ2T8dSlJgLIXkKL3JuQkcyCMvYNEOALEl8I6hyqlbm6PplrTfUz3Czatgx8RGusQEz9IYXrMd4YFkU+FRYuyEbyjN3AG6WPUElAHvkrr2ywe7HPx+n0VZsa8nR8il5A1aM9QUo8Tbf2wdbgEyRYrhcEZVcJQQyQ36frNf/VaK6xoNHuXCBoTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WDIwMoi9brxWchwUhynLOg68NTrz3BiuvTWcODrlf4=;
 b=CDXc+bq5eSQVEGni4NtX+o72GejzNDg2k2Zq9FoNOe9zotFr4hMvroifugOV1bXvhNjPIcXteRGlDsQ1hw7fjAFXG8Yq2p2Yc9UOvkvRPH0jRDfcGLsrPqDXzNoFCqm1Z8VV42XrHoQPUZNJT+JwK9jAgM3ddM+8to8T9ZCPOSnUSlda4HhSNEHPcu63TNRJJi2Ja0stVIUemC123JVkN+Y4OAaqEIJpBIRn41qVIqcwNKMqHAoWQkk3bYp7O5CSgySerA5s4ManG7VgFUsROKj6F9nmh0f9DL0522+e1j1AMVFfxcrhsAYIUwH7cFfUGaURc5ts5WxnBhCChpbf1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8812.eurprd04.prod.outlook.com (2603:10a6:20b:40b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Sat, 19 Feb
 2022 23:17:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:17:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next 00/19] fclose and mp_fail testcases
Date: Sun, 20 Feb 2022 07:17:44 +0800
Message-ID: <cover.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:203:d0::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7aa6160-389d-43e5-0200-08d9f3fdfe8b
X-MS-TrafficTypeDiagnostic: AM9PR04MB8812:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8812782125357C6941B3EBFAF8389@AM9PR04MB8812.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NMZQP5ATTDxArec4OAmfOBwIjLrOgYbmwLLC2nV9lkrfrbO2Uaq9dlri8qXSJkr+9kK0koxX4J4+8Qh4AGmOXO//M9LFzL6ocflFpNcOkru9Skrv/cN6VHWjfwgDdeLG101vSIvObECU0Ly7pwIQtYT3xQfqs1SqQQb8eXHKnDjdXPCKwCDPuAqzQK3dlyXOwDEziVuQaegPLeEcXt2AeKIzKDUcY9unEfysWvicqVuBPnwoCutx0NF5oXBtgggPsMRCG2LC8bl8KnSdJj0MTZFn266hdg9yZ/ITPZydYiK/q+LT1fQeog/2UVHCogwPbHW0p20sFIyGxocnhZo9XObr/vryA/xU1EQtFdUUGSgm+mTgb6j5QqbfYaMKvrgHiC5LU3ldYhUx/jMej9W+yzuMzDP8J4MVWZ257eWTo6aUjVuywd4/Y0CtshHXtg0BiMQ3mE4PALosd8sLsDkSZpQesfxvC39q2Jh9zGS8tJc20KcxrjjvLF9OAFR+uUegAo1fQ3AZKoMb9DbgjnRVzSQypeyJiMkz9Z/JBdYYHsBozG+JuaatAZ5ek/2CJLHQEK41om0Qf+L7Jn93rk1V6VK8VXpgytfh3AsAHCjnHqMe5jRT6XoluSjEAlWlwFi4m8GGVoJFhpOfil+/mVKu2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(66476007)(6486002)(66946007)(66556008)(4326008)(86362001)(8676002)(5660300002)(186003)(8936002)(508600001)(6666004)(107886003)(2616005)(38100700002)(6916009)(36756003)(6506007)(2906002)(316002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zw60jQkJbO1+6O4YCcsFw9OW1LKgkUE4O+o1VEVxcUlRjgH2DuivIYDbTvTH?=
 =?us-ascii?Q?FPCehdXkt4YeifQw8YEjXuSxNFGRZxcFg8Cipo+CNzAF3rtg0RPCyQXb967x?=
 =?us-ascii?Q?0hy9aiGl7B9QLED8mnSm2iABLBXxsNdid2mGWb4KNzmsqIdoFx1QYVl+jYjn?=
 =?us-ascii?Q?CVQBajK0C+y54LcQgNHjl3cRdH9+lFdHEmlYAfMal97cXrfJ5BUFYuOOZV6p?=
 =?us-ascii?Q?QtSJE96uAvMsSalhksQEU+c+Zd53n7u9FHYhoj3kGaNdTGqNIZiUx218vrVh?=
 =?us-ascii?Q?bGcxCxhFxH99aeTnEIgevnMb9lezvo2tptQlKEnlEpTvm2uVvHdnd80c3ld3?=
 =?us-ascii?Q?MEzGTKfBG+i2UJG+uqZmTu9bHh/3tzar9KxwZOgQxb7/95iKkOtF92FgkvTp?=
 =?us-ascii?Q?VEaSfEBIjRCmQl5mwFJjinDAQRbLTuMZzGHnfnMv6MgITqOhWv3xhZU8vBqA?=
 =?us-ascii?Q?qbabVRtUJjiVdEFBl4oA0ztf/oLPK//67RBoyjYf1dry5umq42dJSDZ7Gqxh?=
 =?us-ascii?Q?bhzZ63qKVinPVrZNVPDDzzG2NS4kGSuNO96FS/qpxqzK52riTaGS3WJnfzEQ?=
 =?us-ascii?Q?7Mu/kkRAOGHjiIIFLVK2vE62o6giKDIHEDRdMhFwrIgEBeoWhjpC6gN90dwB?=
 =?us-ascii?Q?cIJtJeyHUUpU+STFP56hjf/kr5f3oimsibeIvENH9p0APduFSqrsxUo298tj?=
 =?us-ascii?Q?JzhbaZtZOCaxcdiR2tqpKpVNO12qfCVgQ7MeSJPDY0jTbwmrZYf8/OE4OSzx?=
 =?us-ascii?Q?Dy6/GlLPvIcK3aX+wjXbI1S4ggWCsJ83u5zgjWe2uZTP5qX/qCftC6ssejA7?=
 =?us-ascii?Q?jH1vctcvh+FIwf7NkzlDB1bSNOBS/cxeRX0IW5xMuTA+1XtV9AxyNRoaMlHn?=
 =?us-ascii?Q?UvsZHVmLNaO2e5etSqZflty1JswwMkAf5D8fkGDknseMU9p8gZME6YGzL1KG?=
 =?us-ascii?Q?0DrOGZQ+X8L/u2zlURe3ZaaMBGLwK4cX0ZgBTudxw8+b6CtD6lQvthKou0pI?=
 =?us-ascii?Q?bSvZi8L8h4FfxtGhvzwppIVLuZ/ml36rqZOK97H84YGSXKv3zoGAZk6lMrho?=
 =?us-ascii?Q?cMtj7Z6UlvYf6U67OnebB9XSDLTcMZr99oUhONLGQewMvzW7Y8h53Qn1r21K?=
 =?us-ascii?Q?SMIRTm7hfyDppNU6G938wsD2St3tlaERkCY8PkUEtMTELZ9XB/7RBZ28wzYr?=
 =?us-ascii?Q?LxvAZaxKTLpgCLSQhMhYqTCXn69D0Js2cxdj+3cpZ56ZYG+A1WZ4rNcuxp96?=
 =?us-ascii?Q?soC60Klq4NT8LCuAl5LSyZZPgRh7hxQoRuh+9rxSt9n95ii+sdcTUBQqF01h?=
 =?us-ascii?Q?+jn/ppAddTWvGD2QBsSmNbVTxWthtk/fW7fw9aQg9jdWgpbieDoVVfS+Uzk9?=
 =?us-ascii?Q?8CDqYQc8Q+1QI2rby/KUZR1zeuKJx5qESFIU6EWQwwRv7aqLHsrvMuY2H3jo?=
 =?us-ascii?Q?DOBmycCBh9VyeA9gQKev/4AQ14RfqM0ev1xa7KuEkb5DVaUpI1/YxUnwseyn?=
 =?us-ascii?Q?+9ZYQ13Zou4BvQOUJFdMudEelalvbWY0vViXGGPILEVJyh46zk3lwQAG3Awu?=
 =?us-ascii?Q?kqx7jbTy9NfhyebaF9iGHADrZjK8ZkCOcvfiwXxvE99NM/Ga37oinrC3hjlf?=
 =?us-ascii?Q?KF0eMK+uBmkLKI5agIUVCkMIDu0atOyVEZ2VC6QgUkoIGJZfp0qrv08ZAWZF?=
 =?us-ascii?Q?XInsJ7VDjrky5BdtUiYaKUd0XeA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7aa6160-389d-43e5-0200-08d9f3fdfe8b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:17:27.4308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIRLKR6GjXO72MYb9OahQSv0Z1S04MVQiqda+YwIJJUp4+heBbIxO5Usss7jE04R1PtYdiObp8LlUQ5HysusYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8812

Resend all my queued patches in the patchwork. The sequence of 4 applied
patches is adjusted and rebased. No code modified.

Geliang Tang (19):
  Revert "selftests: mptcp: adjust output alignment for more tests"
  Revert "selftests: mptcp: add infinite map mibs check"
  Revert "selftests: mptcp: add invert check in check_transfer"
  Revert "mptcp: add mib for infinite map sending"
  Squash to "mptcp: infinite mapping receiving"
  selftests: mptcp: adjust output alignment for more tests
  mptcp: add the mib for infinite map sending
  selftests: mptcp: add the infinite map mibs check
  mptcp: add the mibs for MP_FASTCLOSE
  selftests: mptcp: add the MP_FASTCLOSE mibs check
  mptcp: add the mibs for MP_RST
  selftests: mptcp: add the MP_RST mibs check
  selftests: mptcp: add extra_args in do_transfer
  selftests: mptcp: reuse linkfail to make given size files
  selftests: mptcp: add fastclose testcase
  selftests: mptcp: add more arguments for chk_join_nr
  selftests: mptcp: add invert check in check_transfer
  selftests: mptcp: add the MP_FAIL testcases
  selftests: mptcp: update output info of chk_rm_nr

 net/mptcp/mib.c                               |   4 +
 net/mptcp/mib.h                               |   4 +
 net/mptcp/options.c                           |   5 +
 net/mptcp/subflow.c                           |   1 +
 tools/testing/selftests/net/mptcp/config      |   8 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 336 +++++++++++++++---
 6 files changed, 307 insertions(+), 51 deletions(-)

--=20
2.34.1

