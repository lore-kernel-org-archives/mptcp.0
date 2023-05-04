Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A72A2D
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 10:20:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbN9+U8ZPu74imGemHVBh4fb+iqNWN3BTOJOPBXl9sHfWEkFG5K0MK9LYMS2pNTaYfaNTz5SeG0T8fQUSF7yCX4rGnDFTKPFP6VdlhbwhP8JXO0dIi4Na+1q2j7kXMbARfF2beK345wPfI/FdcapQLrdeqRTezg6k5fxm0QJrJoEFrnjgFqE8aqJcqCgX3f5U8NjZ80/bnAuO/ZJe2C7kfoWJCyLqphOoRN+6rv1D8E6RIfGhMtVZj9FbIVTT6PW7LF+5+wxpRPfv/0775gJEzrCVOA1ktI8Pq2BmJbqtVFLb9oFLMxlEnddh6YUE0kqp/jyg2jj9xB1g8bE1LbFyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLL3g45CTOF0rqU6goiJ0Dt8IxnCpoMUiDN7YZ4Jm0o=;
 b=fs9vK2aMfomc13o8PxiytbZJT+rXMQ1zcWvUooVCOO46mtA7nW+yR0QEyy9o4cIdGHSQHtAY/XUtFn/TmYOeLbP1xRkxKXsp0/6A9SnCZnttnjy6prAYEUs9QrK5PZL5KSNtnHduGHnal8IosdKzxEkdL5tnJPOJWzwroyQlo1Ds7OT7W7J4n06rmzrJwO6rhM4OG9GCABC4XPpyqasY/BlRodEljlUD707MMhdCUPqtK4g3BEph00Mo4wZxk/oO8GrQCrxCFzir+Chryko899Dwg/gqpNcSUbE1JKl5Aoe5/1tRDSjOfPbdZ+dI5fiyULKjvLULpIyTNN1k/8Irfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLL3g45CTOF0rqU6goiJ0Dt8IxnCpoMUiDN7YZ4Jm0o=;
 b=fxRH/idPyDg71JngtIpn5r/60RkYg5VTmU+NDpnc9f4ZINqzpbRIF5oHphLIHI2WUe9V8XisWumUXzkb/OhGCzazniaDG+AfQwDrUdUx6dCMKfu8hDRrJPFXPuEGTrvBf4NF6UWRugZhOCB0IFTps2x5pTd+0sVjqZOhcqDpzFw4n2ul6imb0lxZCDp/HZ5cDYABM1llDy5O5M6t/WvQ6Q81FcQ+lYlc0l5Qbt0wuRBba7fY0g6Lh8ntt/ICdupXkjPZjy27RsLA7R/iEFxw+sjPDDzHF/Mcd0TT34N8Fe1DjKgoCsVaNbiny07E2cz/gpxJxAfgQMFnK6ALAOnUbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8908.eurprd04.prod.outlook.com (2603:10a6:20b:40b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 10:20:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Thu, 4 May 2023
 10:20:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 05/12] selftests: mptcp: update userspace pm subflow tests
Date: Thu,  4 May 2023 18:20:10 +0800
Message-Id: <ee85bebf364bafff9e21497497fa97c160b75503.1683195386.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683195386.git.geliang.tang@suse.com>
References: <cover.1683195386.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:4:188::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee36aea-162f-43f7-f042-08db4c893dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zjPEpLS1NhS5522EfeUYzFParsEHSRxdMV2Z48svzqdcYKgdeytsZ+VBjv25tdLdqwrNoosy2UHkLc0cZqCVoxE4qQZ2mdLb6BLebw94Z52LtuYsf+9bvVV/lgezsNrWqv7JU95L0vnLNqJxory0eEvyOev4X3SUBt71PmV5V274rbwQ9mKQ8tn7ccXTu/SbXMBF60bMjI63vSvWWVM1cqw4VoNPCXZcFpwwpTqLtOFospA1HbCG4BdL1ikqrjeqKZmZp1JhigZ04gTQqExVTGebe4jYUVnRhoqjvAAUWrqb5kWeTvSOpitL+CtwwoNd1Mgio38mUm3Zki86D5Y374bHmwkC4IJRkZG60W5sRPmCxrVAgsw1NB/jXyx3SmYWtaEE8D3FDvjgylrmUxysmW4hlGiTtXggsYNBwdMCyEO1PYn63EuHZvq9on3mvF7BDfds7s2zdlm3Ti7QorD5PLF+bnKDKtomDj5JzV+x6KeD6ReXaDUSXb+3j3sMD6fIMtSUwdHzDjrDOVfSD6N+pufQcZtA0JQgrHA3SUPYdZ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(44832011)(5660300002)(8676002)(478600001)(966005)(38100700002)(8936002)(2616005)(6916009)(86362001)(15650500001)(6512007)(6506007)(26005)(6666004)(66476007)(66556008)(66946007)(107886003)(83380400001)(6486002)(4326008)(36756003)(316002)(186003)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?syoof1hAaXjCgSOaiXLF+bmllZQjZYigp6s8HvJrlprZgnjsuIdkZF4t2Tpw?=
 =?us-ascii?Q?B9kMv4VgZOtP/PEVTlxbFewmVod2W8GpVN8rrr/eT5ktfXpvSysdiNi9Z+fB?=
 =?us-ascii?Q?byIgiekFoumBdyH3wXH4dZyUndf91shSYfXtFrAERVRgopcidr6c1hQyZm/h?=
 =?us-ascii?Q?NizW9opgccAtosXxCsqNif+6E6Y5WaqqgZUQHRSeUWJ8sA2STrBsKHJL1x7P?=
 =?us-ascii?Q?SpaWvnU8+KdvORPeS7Zi7OSyV+Qv7EChS7YhfugvGcxf8WoIZMp6+keRBFcp?=
 =?us-ascii?Q?z6Y4JBC4T4XCt8tuz6WNLD75Nb53RnIjnnhDbLbg5+Z4Dr+K5/DlWeRj+A7Z?=
 =?us-ascii?Q?zbm5F3lVJhAvDCQF8kl8IZu7ygzakTn0jJsGEe4e4xy44wVKupAV7pcxZYVS?=
 =?us-ascii?Q?baj6GkyhKk0KkKnXIlTtJz5BQDMGL1bVp1GKTYMNqJFApphzg3Vznqa+QWNO?=
 =?us-ascii?Q?N2xZaJd+vDOQwbXDnXZ/0QScDFnAc0byujDdBlfTY++LRDza5wNPf0pUjib8?=
 =?us-ascii?Q?W/hEapweJuIYyJiN+Uuy8CYlvOOh+J3uXhQq+cDkhtHdB1Z302v+tL7R0DTi?=
 =?us-ascii?Q?Dem9CUbNrt5lMRt/5iPK5VE9UDuA/leQeARo5g5m5LQKriXBDgtHGQ4AL7/p?=
 =?us-ascii?Q?FRzVfy938DbcsSEUeqBf6qYfb/etQJdqK/jaKq/QupldtzJfuOoMSSVXogGt?=
 =?us-ascii?Q?UKiy2G9KSXR1ULmFqXYAvgSwTwI8Ct6X1WPZ2TdTgvYM2rcsf2YkKbORIHgZ?=
 =?us-ascii?Q?M0Ejno5MgP+Jc6WZg/0GmFPCvc10X87Iv3Q5PU1xU83hNW2HKD10ozFqtG8k?=
 =?us-ascii?Q?QpxTeuHmXlZYBR6SJxbjbmyJOoFYyMAVCAoU5L/QFG75+eGaB1u3ziaignWU?=
 =?us-ascii?Q?HxsUAU++50DlJ30BPSbunIkesdCs4h8PyFRKV1QEKw3qfFdPTYNkfaxcu731?=
 =?us-ascii?Q?Jko3mV0dBQM1TD8hij4gMOctH7nOU+ldc753jqWdSKyyl3kQ2HXknSd3Lbyq?=
 =?us-ascii?Q?0Yjj6OL+u4EbrN2fcmD7lEY3HahZApUEwUvKoI9uPDwjKqfcXe1kOTrWu0Dz?=
 =?us-ascii?Q?mohOS86gKaBqDyP3F/g+TSlnFiq8CA2swwrcpV1VZ3QrSx+sFUYqczl6dMMU?=
 =?us-ascii?Q?E9ZzDi+NSMwDBpeA1Tk0zSEeO87I+awLToHAqG6mzS2PN4g070deov1o4YBr?=
 =?us-ascii?Q?+O7U4oMPBpKh+aH54TvVgwq7tTiewU11Lt3IXDylPRsWTuOA5H5RQoTYU9Sc?=
 =?us-ascii?Q?8qiM7vOeUSZc6QALM56GZBecxVORn/ey6gSEtXyGASWix22PmqqvTN7YkRiR?=
 =?us-ascii?Q?lu6re8kzd/JF3jCZnHk6HbuYBnvly3q6/zhBJWZreD5daLnqomJQ4szdYiCH?=
 =?us-ascii?Q?7iqEXvytO99vkO1sFrKv4sxw/Sk80YmtNCfO3meXFo7mGRBepYOgc9oYWPsL?=
 =?us-ascii?Q?T3HFya548yqlZkQRu0t7oKhiuZCbcW+Mtv1asqzEa2+FZqxSAJkWwLWf0DL4?=
 =?us-ascii?Q?Df32HJ5Hy4tXIwUpoq+ThVNhOxOa6SJWfERd043WR0ZlbHQCVXgCvHNKEiFo?=
 =?us-ascii?Q?P3fAW6u3/Fnf133/D8V2SqALUnU3J/Mm7FVGSU6D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee36aea-162f-43f7-f042-08db4c893dfe
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 10:20:53.8878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXvVQ+LNwWOjBeAaNTQbfq5p3Y16U/D0G84Y6wY/fEwJfmfKt4sN1VojwRM7kyUqqD9+6cdlSRQnmlzCvIOqZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8908

To align with what is done by the in-kernel PM, update userspace pm
subflow selftests, by sending the a remove_addrs command together
before the remove_subflows command. This will get a RM_ADDR in
chk_rm_nr().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Fixes: 5e986ec46874 ("selftests: mptcp: userspace pm subflow tests")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index cb0ae133f5ed..2dee1c6ea932 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -937,6 +937,7 @@ do_transfer()
 				sleep 1
 				sp=$(grep "type:10" "$evts_ns2" |
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
 				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
 									rip $da rport $dp token $tk
 			fi
@@ -3152,7 +3153,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
 		chk_join_nr 1 1 1
-		chk_rm_nr 0 1
+		chk_rm_nr 1 1
 		kill_events_pids
 	fi
 }
-- 
2.35.3

