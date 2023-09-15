Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927D73FEF
	for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 07:44:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgoOcX6acM2mRZCuW6bQ3HYR9s9PDz5fHt7VgJ6P1Qxxl9vb2zA/lkdmQ81eVXF2Qit+YAbA8/Fi7mAdEF54BH5ckOTy2aH0GkPzL6dzCb+iGTbPdQddZfq5kY8dCeJAqMhz/i9Mhitd3XxBnSs6C857XznC9zLKgQzku7JaWD+UMiN4C6ap3TmXSLI/Q8NG0z3vaH5iO6vOeBF9HjwhKh6VCz0QI+ddq3uCAEH3Yc0ZxypXWROaJpx7yKOV++xMv9ba43kGRIMmNMilSLox5hNBqYPV29vh8dZudnUJsR+L292SfIT1m8mUx5vsFSzqTrdTycLQkH7VGsBiqOkS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvUSIN2k01JMEuhxmWgxuB7s5WkpCO25PAyQKzyONHw=;
 b=hEvKs3CYMp/TdcQEJe5GnDre0Cb/lTe5GrrB/b+XdAi7W/VYuYvqv9mP91zzKBIaaFCHXXxgTVCQdAP+VR4OGO3sAq6+0CFnnRc0BROs4vBlw8tZ5ukdhmYJHdDTrAa7y7OdPrdYIE0SwzvTDDJGKvUUOfBTs0exSqswpZmsfgQoERj8wYwNSGTMMMwUCUQwLjqvB5qe7zv1FfDAaMoxOkcsagBUMa8hhk4JwA0JmDZfjvjHRCYYb9+mm9KYTqa5g8rBlMxJWPqM4Lx0LZ0vfed7vzXd0Lf63qXaFceIBchITf4cgB1I9/hviKwaCAPxntyh07M8fRL/WDQwLcKVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvUSIN2k01JMEuhxmWgxuB7s5WkpCO25PAyQKzyONHw=;
 b=XmEJi8YbytRdPUEdoPeumW9q3/Cr1XWA38NeyL4Akms0VAkPYG8rqWqLTy+ScOQi6xeRx4SIwFtjrXTwztOQ2J0zpfedTNDjQrMTpmI6n9j7A6zrJDniaUSr4Y//KPJDqtiL+/gzS3NcZ8/3ykwXcWciuMW7dwnm4RTJ80YoAjmjl4LCxX861upbatl+BI5tf0o2cSIzZ4s/C54XjSd8EwAq3eXr4McIm6gPj/B8ygM9+clcLtLxs4yp9rXz7d5TohVJFK85F+dIffPj02XL3M+E3fDsgjp+MTsB0M6XzRHUqZubl+VbxyrcbvVubpEq7CQCtdCFgux7r5vFutIJdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 07:44:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 07:44:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 0/8] userspace pm remove id 0 subflow & address
Date: Fri, 15 Sep 2023 15:45:10 +0800
Message-Id: <cover.1694763508.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: 2291c232-2ed1-43c2-09c4-08dbb5bf9c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FvYXbdzWUwpKTrm2UmgLDX0z9uhDFzYv+TK0jKtNCb0Nfb5VDKOedP/Nj6eRxVhNhH6PaLYC/0XdNkQxH69evolmXqr5p4jG9v01YKrWvf5tU9gIP+7rUMzGeRixPtBMsnSIw96kyIF2HyIfCybzyK0/wA/1pfWSyWZuhLTRrN4eQPxfEueWy+PkcMkN4F8iOnv+3SSuP7sElXF9MjURnGuJElwsD5HP+BW0Ws6V3PMBxJGNx1/rfmy7v53RYpEsM4EQLxdXcll1+Es+iFlJKOrk/cLNGYOGmMnJeWqkFFJ8h+7/MY9FXc5cSxQ6bJeIU0TM1812oE2fZlFAAZbUdwdxABBOi1BGC6awLWGscF46nLM31S9/j1zI4NVEsXIIK3EwE5L99Gs17qdf3KLq59D4ryaKUbZdQRSgdnEPggCpW98l0mEk6J0x9u4RLrdM6GsZN8KAeid7XxetU7CDIpJbEy7cOhuEYPYUlb4oQ0pMtPFCjz0o7gBzSeDhNPKHBrxYyUgCLSyl8KGQghZH9xh8JKp3GMdgryV4J9ge5/Q8X5zNbyLkx/hzDnQcBd44SmWdLYeM2LBCDCkGW9QgDselLGqeWCb6ZhFjXYxnDEM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199024)(1800799009)(186009)(2906002)(86362001)(36756003)(83380400001)(26005)(107886003)(44832011)(2616005)(5660300002)(4326008)(8676002)(6666004)(6512007)(8936002)(6486002)(6506007)(41300700001)(38100700002)(478600001)(6916009)(316002)(66476007)(66556008)(66946007)(966005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yDFPWq81lURqACOPGLD66n3SG7TO3KFIw8JChrJeqESGBK1rAtDX5CZLVM9H?=
 =?us-ascii?Q?kzDmD/v3TlfmZ8VX3b0IEBgKoaMot31W6zldbYqLJuz1d13N25zOx/m0uxqb?=
 =?us-ascii?Q?8rtkkuepP22sUVnrhuz64IwGdUGhonGqXkO5RRsvMewOr4d7Kop54VYWuHf5?=
 =?us-ascii?Q?dGTo/EMVlPsAf0MfXtfNFcSgD4Qnk8sAbcLMQJluz30GkYr7fMbVfJ20FrTZ?=
 =?us-ascii?Q?yg08NFSvEV+WvtXyjHZSe2z/p/tXrOE2cv0cyf3D+DCbJc+w0bFnxwEG7gWC?=
 =?us-ascii?Q?azn+/HNYqeG0bmi32nGzXjRWWS/+PGr0N01ONLpSVEuMptCIcBSGvQWCgD4d?=
 =?us-ascii?Q?jOozVmv64YOB8UDh3WZV+F1Xw4waYYZdbAbIQwi3Rfqsmk2c/mvQZ6GJKSUj?=
 =?us-ascii?Q?rjKq3L8V+SG6r18tX7nCOl5gXRDdFd0n9v5GYjzLu783ouVH9rcK5TTYB9Ns?=
 =?us-ascii?Q?NpDDsHAZcMKzRnsf4fkftNWKawU1DT/CKKTE7jVdpTwFo6N/9HTTPSXbIb1A?=
 =?us-ascii?Q?M2k0DGmxALgQgZzNxwISEuHq1hWIc93cCV/pYz1sXN29ihxZkx6RE2AAR/0b?=
 =?us-ascii?Q?wV2HL3QfEGOZTQ/jWSXRHXos2KUjiWFGYn7vOfv2ID0p13MYpefcu7F8PC3m?=
 =?us-ascii?Q?/2x4zgyUKbEKMbzkoiriI8krVLndlWYDTv4UzwyidA/TQ6eEwZG1YAA4TiXb?=
 =?us-ascii?Q?+or8BRzkqXb4RsdDcmuFG8loUHysF6Cl1WwknydjPnoPVSmdWo/o+LavvTbe?=
 =?us-ascii?Q?drzOZXo2R0EAJ6AXvYDCiseRGYfXllC0tsCeiZa/bozEDaeZLgAGEMqt/Abn?=
 =?us-ascii?Q?TcNLI/qDhiSlhnpIqM6mW6gpFWIL2GwRmNVR/mn/en98RoO4qKyJipmHLQPP?=
 =?us-ascii?Q?jx5AgVbls7RhoXVYzeSZLwlAYx7OIN2PTV2JlNuUNgkCdd4LAQhS2qf92aiD?=
 =?us-ascii?Q?bI8uFK82IWhnFSpjUoIDwTYK+UwQ3Tyd2Df8gJ/WDPUqRKViCKucgDarP//T?=
 =?us-ascii?Q?uApHOW9mukxUg5vrDEDzTymwGJLCPBCNxZ7mcrnYRfB3WAmc3X48QeNIg8dv?=
 =?us-ascii?Q?hVm9qIqIUEIMXNKn5xOVN2zvvcjM3TXSab8enCTJOsgqV87LBEpDEH0Jjnj/?=
 =?us-ascii?Q?nW4R8rAM3ZkJN55Owbkaf1yUUNuDvT0wl9hoUG25sHLRhF7cYV0HM4E0ZVjo?=
 =?us-ascii?Q?WRv9ZXPwS4jEAOcqFYC3n1UqBOl0TdqtK+nHaIs605ZoAefF602V8Irx9/Qk?=
 =?us-ascii?Q?E7tfDk6uTNrPTG24B05kYzLnHT3gU8Cn/wCJFOkfHf/w92M6qS+Mddz57IVE?=
 =?us-ascii?Q?pDMH3Wx/UozY5MZtswl3KbFXTb8e7yc9TzqjNHMcP+XDZ31R7K17MjwWSbwX?=
 =?us-ascii?Q?/onM5sFJ5M/SGG9A51rbAx+M6DojjVoSM1sMKdxs4N2atdL/YHJR7I8xUpsU?=
 =?us-ascii?Q?qJ8Bwp/gxqaw2hDH83hQIEj57UqUIbMXl/X6kMRpzytkn4itWH1n8N/xzKkw?=
 =?us-ascii?Q?jhZ1RFQF7uFbtIbqaf7aMnrbcr1apnskMZFaMhVR6RGUsW9bt1TTkBJo1Mga?=
 =?us-ascii?Q?2wHRWC5/YXvP/21ZsDQVGIAjxrEBd7mJdWX522Pp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2291c232-2ed1-43c2-09c4-08dbb5bf9c9c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 07:44:37.6397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzzY+igxATq7oSefHoGUKaX9WBROlf10NdY4tBe9vklOh8pkVvVKGBBGtj+WFjmigPHlw53vF0gKHEQrss9NvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9079

v10:
 - add mptcpi_subflows_total counter, instead of no_initial_subflow
   flag.
 - rename the helper to __mptcp_has_initial_subflow, add READ_ONCE() in
   it.

v9:
 - update __mptcp_check_initial_subflow().
 - split the code that relies on the 'ss' modification into patch 9.

v8:
 - merge two squash-to patches for v7.
 - address to #428 too.

v7:
 - move evts_get_info into mptcp_lib.sh, update userspace_pm.sh with
   this helper too.
 - drop the last two cleanup patches, they'll be sent in another series.

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
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/428

Geliang Tang (8):
  mptcp: add mptcpi_subflows_total counter
  selftests: mptcp: add evts_get_info helper
  selftests: mptcp: update userspace pm test helpers
  selftests: mptcp: userspace pm remove id 0 subflow
  mptcp: userspace pm allow creating id 0 subflow
  selftests: mptcp: userspace pm create id 0 subflow
  mptcp: userspace pm remove id 0 address
  selftests: mptcp: userspace pm remove id 0 address

 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/pm_userspace.c                      |  41 +++-
 net/mptcp/protocol.h                          |   7 +
 net/mptcp/sockopt.c                           |   2 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 206 +++++++++++++-----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  12 +
 .../selftests/net/mptcp/userspace_pm.sh       |  87 ++++----
 7 files changed, 245 insertions(+), 111 deletions(-)

-- 
2.35.3

