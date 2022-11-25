Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2060.outbound.protection.outlook.com [40.107.104.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8FB33DC
	for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 13:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8aLgmNyBVUDcQWsR3Iq3K07NOCptSe+Aqigfa3V9I6pYVPRwx2aUSX6JB/vKg9q5JSUboQkR4TzY1qNaUeVpdaM0WdMuLhCZS1+KVmyOrqjPe0NDu7UJ2MbajMMjmVfAU4DPS7NlZreSSEVMic6xCLiZpvNxOMBwD4DlNebqAZIHAUnWSszQE1vojH6gPY5Ff/S4a+VYC3hLmtkGlRoT2qiryOJx+ObnnhST/Mx3E4ko7TnCeYM7NpummHFAwxB6O6w6myz7oMdT94S4EL8Mq5wQbsmqB4BRbwZkXutAA+ZwvnLe1NjB6WAANBVuAHT0WfTp+4e41PiijTrS7oDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqq4DOLupjVQ10hIEmz3DsfPFoRrCGrizG7h2p+p9DY=;
 b=kCkqEtsM4W7vg5KjEPZJQFVpBD4jWwlJNvpyN48GygzZVJ+/u01vxZTU7Ne3e679bvw8sewmHqBWZzYm9vIl70cJw2BW6sFkJtRs06g5m8c1ytrrCyHz5HIB0It1JFBuFym2w/wWCBuXlI0WW51nYstgmyZ74x1szWH499tw7pxV4NrGOf/iEwnzcJ4jBmHaoqmYvTK7h7yS9I4Up1hi9b8y9SacX5fgebMqMqHOpWeqEi05PzKSBiocRV0xGF1vqwAVAevm89540HT09o/l6uU/TwpUfBbd+xkxsAt8c9cB00TObBoHd/syLwt6c6RvQa4GDb3fNXFF5Cb2mOedxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqq4DOLupjVQ10hIEmz3DsfPFoRrCGrizG7h2p+p9DY=;
 b=c8DjKIBVMjStCqvE0NO75YL02CfpkWDVoccpzIpTq96OZ1uvOiCy1Pk0ImAm6g3QgRcJWULIJdG6/cD6G4Mv7aSOGJGgoa7wZLqd1lbmVD79ADHPaz4I5EWGZHxbqp7qKtt3G55TGNqSpY+fGIgV5HsFGrsUKmH95+F362LkXZA4mpbrvRfVDjbJQ8P7BHLjeIRYvafWDr4LX4yU9BvcoN/E+JhIN1bqbaZK3dxiwPJYEd9iHA73LEImVFoiXUsSpgB9eWltuxpFzQNZxEv061bAGlAww8wRSFFagz7mA+PBDDrbOBKuaU1ZrZiix4OfeVkcbCZ/XJlWJ3/bH0bM4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9116.eurprd04.prod.outlook.com (2603:10a6:10:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Fri, 25 Nov
 2022 13:40:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Fri, 25 Nov 2022
 13:40:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/4] cleanups for pm listener event tests
Date: Fri, 25 Nov 2022 21:40:45 +0800
Message-Id: <cover.1669383374.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: 8943a856-5432-4b7a-928d-08daceea9730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bJ/8H0iresIkY5cEwraw2VN/Vl4KPSAlQLqmcHljYSzMGVIoTWCrrYnDk8FGcx1V6YbKvhkmeLTFjM61TvNSosHhphdbA87y59id9SLCLRKqD8BiKOI0H5JgP+RMmHVkXeyAGYK+EnS2yAc5tJAGgydtfUwpHJ4z2npjZzUKmyrYW5yvD2Q/AGsAGCz/1YVPwmOgY96dbwQRQA6YKo2xiLwAJtHinBnN8hs1ThrT2pJel8c/6ZpLBK/FUnw0mSrKxtuBodLClBLmQzG5siyCsyKQesiw4OKo4ijCt7irjZbkFBjliz2GpGOlpxL3ir55TCSozd8Xb0r1i5KK/bd9dM2gAkCVqpxDdOuyg+wwAFbIuzxaTv7byMK2UOzM58smcpGKh8+ZhHsvaGmAw6+/G8foB9pKrET0qhKUIFM7fhJYmWq87YvWI5SzpfVsle5wagIgha0DhvoqTq00tndpQ9tXHBQEz2g9rVd/iMoxgw2zeab0ZABeJ7IVocefD1pvvlaAcLg37eKX1FJqTlUpecEfFhBYiV4Nf+R3G/op/dS6P89W5SNo/rjtsuxm/MB+7IRceLCT1zDSTfHhMdJHCgeOeFiFy8qvu9vLy65T3i6TA6Y1Z0HQh0T9SChQWtaONsPRDFgYuWQCg8OZbFxFWQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199015)(2906002)(38100700002)(36756003)(86362001)(186003)(2616005)(107886003)(5660300002)(316002)(6916009)(6512007)(6506007)(26005)(6666004)(478600001)(6486002)(8936002)(41300700001)(4744005)(44832011)(83380400001)(66476007)(8676002)(66556008)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aZj7A/YPue6lxg6JRJgkYpUwnT+JqbIZE7iMDlE6rq6FCdxisvV3JFLQDd82?=
 =?us-ascii?Q?TW6ubLCgpusiojey7SkVMUOwD17m4I50Je06xp0oS3Iu82rLFPzdI1oRuqPQ?=
 =?us-ascii?Q?k1mIQ0SbzCOaGFKIjyvcecc3d2dS3K3euBirk9xO4iV7cxzRdWNjMULwsR/Q?=
 =?us-ascii?Q?qrnGklaP+9lyi6zbJ06gkT/VAYOjH+eS1H8ZMimr9uHVPcavxwMcahtK2/u1?=
 =?us-ascii?Q?EI/tnCRHSIn5EIccLTMgqohYAB/mOZOqEqlkhDm0InColXUtjUEa43VhNiqc?=
 =?us-ascii?Q?eu/VUGAwOruv1rrwS4hpErcP/tQuGoYtygxRMTriGo4eaIhwvQX4XW0HhTop?=
 =?us-ascii?Q?7J4XlUkbujvD6F/kyeO1czER7e/Ab44ZI6hOazJfUOE54/Fa+HwXNJXhiXyu?=
 =?us-ascii?Q?Igd6Yfp0qmao5gU1IXZLWF6/qPWJOoVNpWjiwAcJcPNTGw8Rre4MgbzsGpQv?=
 =?us-ascii?Q?OtVg7YZCMGp3Xm2hg7eYbzrAjwjcJGbwXbv6pOWfeBhE3aS/IjVZyY9H5YwJ?=
 =?us-ascii?Q?3u4Wo7NW8lX09b1+myGAov7ucYO4oZmI91DeX2pE32CkM1OFAIpibJyT28Qt?=
 =?us-ascii?Q?CAavcXkQkCOrC2FJrBFkzdZ6oBiowXr/X08onRJ5AwYAm94tIjFsKhMRpvRW?=
 =?us-ascii?Q?CHT90KXbGBQQ/9uoUnopk3xpJqwCU+Xkj3//QwLkjpEd8wjww6MLoodUvFsY?=
 =?us-ascii?Q?O4WRsrHzE9Du2KzD+eLruggpSNpnO3ygKFwUvAGTCMzBNqqQkqMaEr7U2QVh?=
 =?us-ascii?Q?mErqkgIGdR8LmenS+fZy0lUWmvQBAX3/lw+bY8hT9cyEO5KerRnniF+ISiMt?=
 =?us-ascii?Q?kI447YieSkdoqfNVLMw9CwSe1Se0sBkh0s1ieQxZbXVwZr8hou84E/0FLywY?=
 =?us-ascii?Q?1pT8qUJ9tj16Egan9rUCvDd7Q8tA30wYS3n4Zh6s3QrbIju79KaawqKQW4hO?=
 =?us-ascii?Q?pYlNxE1iFXjCGoQtX/rVrW/Jnpxl8yuKm91xqardu8Ri0NUl/JFUeainKoAH?=
 =?us-ascii?Q?OdGUA7M84fX8KYNvosROSZNHp6Qio35MxF3RuQLiKLznneiF6mMS3PdYTUKt?=
 =?us-ascii?Q?3PE6FNweE4tKm7F70Fm/nZa9P9qL64JKKExEB7RSEVHYzbLA+BG7hReXBcOE?=
 =?us-ascii?Q?ST0Kq+qRTrarWKotFfKh+ijGgIY91XwdtP2Ov93igYjn53lI5/JBlczwn7wC?=
 =?us-ascii?Q?V5xmoztDtr6ZlIwCJ4/7sItfPk4lsamQ8oSwMRWAOTw/n1+I4L/cMjC6l6VW?=
 =?us-ascii?Q?Qb2Ate6l+Wmg1zAsdegmV/HrKLRGVRfQglCd3VKJ35mSGbzVTIYgdXA9DZY4?=
 =?us-ascii?Q?Mjtduy86rSd9dBxzN5J10tqJ3+EipbTJQIypLJVgOuzeW4Mchepcfkjk8dXu?=
 =?us-ascii?Q?tTF22Kx+ItQfCyErPsmT03GjBoyKgbQFXLi1HZ4TVVQ2KvbIxkE6ys75snjS?=
 =?us-ascii?Q?i2m84BL5a42XsBbngGBLYR7cH7dMMsRn/x2UzDRlk81672H/UOW3Bd4ZYi5v?=
 =?us-ascii?Q?Nz2vBZFhhQZtgRPr7A2XX8am9vV+eu/lOmmUAidRlhy5c93uGGDAAV15yzQo?=
 =?us-ascii?Q?UNtPVQZIQEJ+EPEEoTBFTU3Y3Y5LogH7Eay1NH8WuMVo0bzDU48btzJ1R6Yc?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8943a856-5432-4b7a-928d-08daceea9730
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 13:40:18.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdOGsHDdJeDU4E/QcHQoCxBQY7k4XrrH3hzXlWQOqa5RFk2tT4/NkL0b4F4Nu3ZbJE9MjodykKAr/lTi7Drz/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9116

Order of these patches:
  selftests: mptcp: listener test for in-kernel PM
  selftests: mptcp: make evts global in mptcp_join
  selftests: mptcp: listener test for userspace PM
  selftests: mptcp: make evts global in userspace_pm
  selftests: mptcp: enhance userspace pm tests
  mptcp: add pm listener events

Geliang Tang (4):
  selftests: mptcp: make evts global in userspace_pm
  Squash to "selftests: mptcp: listener test for userspace PM"
  selftests: mptcp: make evts global in mptcp_join
  Squash to "selftests: mptcp: listener test for in-kernel PM"

 .../testing/selftests/net/mptcp/mptcp_join.sh |  95 +++----
 .../selftests/net/mptcp/userspace_pm.sh       | 233 ++++++++----------
 2 files changed, 149 insertions(+), 179 deletions(-)

-- 
2.35.3

