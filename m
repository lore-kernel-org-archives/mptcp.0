Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20052.outbound.protection.outlook.com [40.107.2.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F667C
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 11:46:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JP6GpRMTgq3f9fkocI+sHJwEWM3aNuUwpd9xKLsYVfJFo53dwvFvuFgmcA+qVE0AMl4OsemEfyh8PJUmXTVI2ra74Kc98kboRQEX6fjr/ymWc5q2L/QUv6gmILHxlK4loKLpiJNLK1boFLQbt34IfFf+n2l6r8mWKd/lIxBQsN/1FH7MLQKhe0Vo55omPAbnQNrRbw6Av9/vMiBGLoYS+JKJX+yGAvGEJ9V/3ULCK5F/yK0B6w87OzdTck/jy27ezRnkUBg9i40fVcXoe9qjOE3kQ6CfUDEyy1q7MUbkrDCIpn5v+ic8+eDCdOoHv7ImDhMZI6kKgCBae1nPGTLECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF8ttSRAoDQvzRahf8gtyI/IcjgylmXPSk5Tm/vST5o=;
 b=SxFLsSb2zawAwaS96bz0bGE0WKaITBmL6bbC2Zl1n4q71m+itPHrNxKwryWX7LNI5u4Qf1nI9AiRMzRvGySbv0bArBbDibgqR3Rp3ZuEneHYbIUEK6AIpS2mGcGWflqZeEl5J19Pdc2oO6aE22dhsOwXfyP9BsuhnH2ZyrSNxBl0u+xLfAxxWsY2S/Ca0MFzkgb5vyLPbPsbeqjlbOXpJX0VCl0XPoRqf0rtNuXy4XV3njqbn2ytOPz3kvt8TBOqY/001kCN4Z2M9MwwsxSTt7sB9P8BTarA8HxSfVzfR/jlPtQOB+L+GUNT4FrhL3914turfJmPkL8R/5yLZqwqbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF8ttSRAoDQvzRahf8gtyI/IcjgylmXPSk5Tm/vST5o=;
 b=OOl8zk4h3mtvZrYHm0iTgtrr4QwKiiwbb+m71r/WEX2+8cf0ooP1Jd81UGCVEm2fxXZdy41OuSm5JmbCVvFZl+m03JfFuwkbds7WR0iNCqAsYmbJPJU5SeqJl1armoAGDRDqeiV/mo2pCuiaMuLrurYrwWo2GMQVAwRqMwpJxLjCNniVM8d6frA69zmdnlg2QMWaDFKYrakXMz/BIxPXrjsRTwQ1L4eKNjFQ9ZuMNYpZwYtXvlIwYIV1XF+6U52yazVYUpIAX6WxDT38h+FoZol/ZXglcDlgZcmX/55CC7raulfzS/37+JUjh4suF3ZH0eUxQmWi3THa5tyTzf5hzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8430.eurprd04.prod.outlook.com (2603:10a6:10:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Wed, 16 Nov
 2022 11:46:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 11:46:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 2/4] selftests: mptcp: update userspace pm tests
Date: Wed, 16 Nov 2022 19:46:18 +0800
Message-Id: <8ff444f2b41ff403fa8d3efcb9128bb99bc51bb7.1668599064.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668599064.git.geliang.tang@suse.com>
References: <cover.1668599064.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: e9fad183-722a-4543-d953-08dac7c82d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VJZ5YaoJQr1MOeGwInw8wE83LPWW9QVjx11issRkHZ8MzrAacjiMpNO7xDct1/Ac33ceIFBFzGcXwceiFGwPq7RkbbID58cPPf9RQ95UMZuqtPmKxKqEzrqIBXyI3RyDNVc2n8TMyyqGWaM29dyGyZU0ZwZfpu1D2cdaEB/x54K0uzZcOGFiFwVc8AovkouwxmHwoAqNWrH9pEA44juHZK/ySzHzY7gBBUp8HvZIF2bNlMIoNPR4MmUQhITLp2pWrpvvpduJtf6Neh87w/SSDZ6RRcMOIzv7a+cFj5nMdRumPRWt+RjP3KvlGHfLeJihmiXCLzs8c1naty0qP4AEvuaRvbYzZckrwHALMwavSSwUwScdANmZHLi1EXPTjGd1cCnefgYrGPGVSCpQm5Narq5Wb3HxJnP0EEcsw7HLnW98KU25q6/URF7Pd+27jrFWBy1G4p3oqCtf67EyV8lntm6isEB73tDo5BHNRlRwwmV+GSDp+X2YfNuJW/V2eUtE3u+1+cjmB0OUnjGOYhcwmwxbsz/1O2ioh26K4voHB4G+fDUUtIP9eiiZ8XBPYp4PnlPzRo172pLLAQUK1LgEncyPAP1WaCGKCmPY8RFMvq8XIYfF30DhO7IjTUAme2+zwdQY5u326ptdKeK7abtZyq6fIYSqnvWixAneZT8sMMifHoWZXSjLE3QBeTxkdnN5q2cnWSASOxymeT5UmO5+QA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199015)(107886003)(478600001)(6486002)(6916009)(83380400001)(8676002)(4326008)(66946007)(26005)(66476007)(66556008)(41300700001)(36756003)(86362001)(6506007)(316002)(38100700002)(186003)(8936002)(5660300002)(44832011)(2616005)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6dH1WnP6Ci1pcrDPeY5cAHRGJq6Fa+RRZ0BzZMhAVxU8m+lD/dZCSI60S10u?=
 =?us-ascii?Q?uGW6eGoprSYxOI9gM2OKo2bp6Yp5UYdJ1m4cn2sV0HZ+F2Sc6mc24ntlhEUo?=
 =?us-ascii?Q?KzWwUe0F30WYo7e/7/oehcZq0S0FH7eKNn+9ULej/5U0Yc3b2qDOZnU1h3fh?=
 =?us-ascii?Q?D7+T7JdlKO8E097JJGBkHo2sHMqIz5C5xt4eiWtaSPYmfsOuHO+uS6qi6vjL?=
 =?us-ascii?Q?p7OcCnmurMmVUysBfOpDzWKu00pN9XJnRau3QqQecl8+40IU//WNSYfbmYUJ?=
 =?us-ascii?Q?PJe3e4cHlnXbg/A+hB+Xd2Zmc+i9GeArjCbgWIeiPBjSV9O9hG0NNXm5IRLX?=
 =?us-ascii?Q?NYjqsgMEfZBQDBgX0EaBeBPvampFZAcfIgBZWXWvzhtg6A6lK50BrM4v4YuB?=
 =?us-ascii?Q?aLMMoi7vHkBnjSgtCQtD29bIMN4kKUBltIwGSR3XjuWUy1GbypPNWK1+6Ybq?=
 =?us-ascii?Q?zqosBBwbCZFJrunoDr0RNs/lIbjyP5XFLz2c2rNso9hEgqhiPHsQLLqD4LkU?=
 =?us-ascii?Q?hUONk8GG25gcxltIfHHjsnNPNuXiUJDk2I2YUi6G+Ndqsz719S7mgvIA7Xzm?=
 =?us-ascii?Q?d1UVq+4VwvX4fPO1KRePv7oe6PzWHugpca/kNGc5+SNPp+EVEI2+Gjkm8lMy?=
 =?us-ascii?Q?NkY7vO1LUWgDRTWFU6LrXpjpx2pcR/+e2p+TFwxqGESgBzWfet+nGu2TB1ir?=
 =?us-ascii?Q?4pfAf5NdoBxuiIKC26ENlSkIy/xlSXLuK/N6Q8hjOI5vDC8DQ+agYggErX+0?=
 =?us-ascii?Q?kIIZXya1pDUsKfukI5TZZi3Lt/EpT73zuuEtQVcaMisEaNR1rGiTEN6Xjrj6?=
 =?us-ascii?Q?/CLqQYoxqpF8m5xqBxXpU0rOha7b7GbSbyvNDXPxaLgsWBxuzcjPjtBhMBme?=
 =?us-ascii?Q?FiIOtxCx9t8x2lEFJLVi8mgXdT0iBnaoHW3Ne4I1SQXOks3s5WW5EvRJO4pz?=
 =?us-ascii?Q?6sm+CRU4+IZGzr/9HFlRjCeTOeV5v5x7v/Y12qh6c2kLG+frxxQucf/BtW7y?=
 =?us-ascii?Q?GfnUfZLbcybtH58d1+EeYP4KF6AduUpvA05atWLwjSxjKiafP2nzTYvMTM+1?=
 =?us-ascii?Q?twNES46tmfDusqgpuM2T2G56TVkW78Q7/xgy38UlTCB1zqL4M2tUcYt73KmD?=
 =?us-ascii?Q?gNQNARLvGLHg0KODEa8OaGnnqNFQu5S/9SYlRAGtx4DjX2PX4GDa2dXupkbO?=
 =?us-ascii?Q?nneeAfpALizcZ4YmaHYEHPhGwHwycJp23vKEBDlvFOyLEeKJz5lTfEqOp/ld?=
 =?us-ascii?Q?xHChVQHwLqBsQRShJ9W500rEpQlUbwOOiy+p9PE+4b/SNuo8C83isPzzTwuP?=
 =?us-ascii?Q?SWXMNEmOBZT/sTeqll4o3AraSZLC0lPTvMUOhH3C12tAOWq2cT0PXb3BzXiV?=
 =?us-ascii?Q?TUcq+uLAQ/irmjrn5A1MscSTSmDTmSuo7ZRMIT3SyAnqBYvefY4wVonEKRWY?=
 =?us-ascii?Q?yd5v1ZM4qLaTS6XgERG616oCffvjCKyKR+d9pB/+KnX5qfoYqI6yTdCW5eaw?=
 =?us-ascii?Q?ZOvxMkd2bLW6tfv4hR99G4uN07Na76n/0lnEa9Wupivq+l4is76bFewVX87E?=
 =?us-ascii?Q?vqH3xRzTX3Pkw6BRpP3Z8oGC/ifDrLupsK1Ex5n2c/DXdgRZQT3xNnAfrBrF?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fad183-722a-4543-d953-08dac7c82d52
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 11:46:19.7730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmSdDUiSxQnSlVdEUpnRpfl+UdVojrntrfMHS7+dr7RnYAAcIKBO/gBk+7lCVkrEeMQ18LWIWeu0kq8uyYLTXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8430

Some userspace pm tests failed since pm listener events have been added.
Fix them.

patch 3 in "add pm listener events" series.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 3 ++-
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 7 ++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2a402b3b771f..f10ef65a7009 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -830,7 +830,8 @@ do_transfer()
 			if [ $userspace_pm -eq 0 ]; then
 				pm_nl_add_endpoint $ns1 $addr flags signal
 			else
-				tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns1")
+				tk=$(grep "type:1," "$evts_ns1" |
+				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
 				sleep 1
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 5dfc3ee74b98..08a88ea47a29 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -172,9 +172,10 @@ make_connection()
 	client_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
 				      "$client_evts")
 	kill_wait $server_evts_pid
-	server_token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
-	server_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
-				      "$server_evts")
+	server_token=$(grep "type:1," "$server_evts" |
+		       sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
+	server_serverside=$(grep "type:1," "$server_evts" |
+			    sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q')
 	rm -f "$client_evts" "$server_evts" "$file"
 
 	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
-- 
2.35.3

