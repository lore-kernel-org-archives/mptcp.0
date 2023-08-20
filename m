Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2077.outbound.protection.outlook.com [40.107.15.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56A423DE
	for <mptcp@lists.linux.dev>; Sun, 20 Aug 2023 12:06:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcUwwFw6goySh+ziAMoPn7c2Sn+LIoIcYfcP8+P8YaQ/yTGzAoFRBXcLccgFm0VDWe3LRy4fYeNunsqAtK3QOqW9PPVjYj1rouiOrPUnt/X1qgI/lRRxs08Hd/fCoe8YuNRYAI9bpYz9M9H/Kw2VL2N347qiT/4u40papZ2KUmgEu3x6VopgywBBrrmDaHTKqHv2lbf4wTQ76OEt7WYoco95BBwuEQY5MP1wQIk5Vp89vHtrRAFrY+ICQWEqW418KrpxDak8w3JQAFrxYjFuUZoXWNgqT+idNZsBGYuvxU2z9t06neoI/E1kX1CpqvUhbuCCDNAoUQCzOpf5xqZzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0bhC3+Rn1VOXsbMaijasc5+qJeZJ+qBYRy+0096jvo=;
 b=eWHM5x/+UnN3gWScMFn/mbRtb9I3AGZDeIwb4NKEC59xNPz7mVWdCOlSfOU7Afmc2gVVBHMeCqhRgz59hWHEvlkxjqQ7K4Rzr2Kwy5RhePrvzx3HEKawks6XzBNE+gbYfcDDluEgLfKZVc0xOTIMX9Iqc5i2ajp+f6Bj7E0P685rxFomgc0QS8RzlB3w2SrZ0asRE/uBSSSS/wUAk9cRplYgbL8p1OsxDWFCyWpOuE8mV324+wziebFhIljVUAWb7W8F92/zI5X0502c2lc6rsTYP3OkykqBaZ/glMgWv2IPMdXS/m+me4JCtx0xC2t/ipdxlRLpXPBcmkNqH04wSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0bhC3+Rn1VOXsbMaijasc5+qJeZJ+qBYRy+0096jvo=;
 b=axkZoMd94t1upn/yNf+VM6a2wcTh1ic/ZRi7p+d6dzmwKOB12pUIn350Ks9PplscRCYXe1bpUHH33V58A/5q9d7X2bpuYUa3uV2qHrxIrNuDCJIp+jOmp0945xR2k93x4DTKJqL+glEv1tPniDOh3UdV1kOqO7WFABEOimCeT/ppVclxP5nxwN71HDWc4A8jaRg0pCGfJ7zU2jVAC3MMZVpSO+MFmO0HuogN+MM5uoVxBnB83Ya2W6Qkis/z5DTQ78m49x/IsEDtsjoCszHzPUcmk4PJrUxtWgk41dXvy3YnDl42KXounpmdt0rC9m21bxBxSuOn8sWlxFlSsHWd+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9523.eurprd04.prod.outlook.com (2603:10a6:10:2f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sun, 20 Aug
 2023 12:06:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Sun, 20 Aug 2023
 12:06:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 1/9] selftests: mptcp: update userspace pm add helpers
Date: Sun, 20 Aug 2023 20:06:32 +0800
Message-Id: <bbc9a4fef451e670437576967c933008439d581c.1692532859.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692532859.git.geliang.tang@suse.com>
References: <cover.1692532859.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: 291498b2-7ee8-4cdd-8284-08dba175e2f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M2tnT36jBdZFfuKnllmi4i3lunZQXt9hT7rwBeCxckWWGfGG7qcwT3u6ip8kUQBFdGLH3TpchB6Tm7SN8+8BExMvjbBXwx3nTttHsQvPSEWFvUpboOfwCDIHkG07gSo/u3TNT8T38FrnM1Q5sbUF+ibAKpZspqUkDLiDD68qL25J8Zdd/wpyME+5HrthChPwos7w3IVvtAr3VF7TlTaMiLQxHCB9pRQM6aiCXi+gxN7xfQc3aDGYvynxoG/SCuh9txxqIDic5pnAcoWtPPtdSj8GD5OFYAeMtRY0ge4NaNW8udDS5PnmKAuY+wb0I9KN4SpnUR2T8Ze0KSdkBYvGYN2MfNZryDO74UCNs1PMsGYr4K3D8ZppYc+0htwT4oVIrJpdC6q62wp4BCW2DxbXzKltZw4SA9bTmLv7ZaXaGmpeDfZ5Aeb9OnnckFRVPXKXMdld1VT/vO0bnh3Pe7bpUIfZvYNRuLXMn4zV3V8Q/QEIzEJGEhnPEFo19XV3qTMOg1/wPilwvC2f09sLj1aJhhZpPFD5BwxwXA22J6z0YPdsxlIFy2i4Lx23pwhAiys2CR8uZs2twevWFawFXdq0SxFWMoosdyy7qeJEevR+VPY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(376002)(396003)(346002)(366004)(186009)(1800799009)(451199024)(86362001)(36756003)(478600001)(66476007)(66556008)(66946007)(6916009)(316002)(41300700001)(38100700002)(6486002)(6506007)(26005)(6666004)(6512007)(107886003)(2616005)(8676002)(5660300002)(2906002)(4326008)(44832011)(8936002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GSkmFeTvzHcVfBWFbL2HZbbkXMSl5v7s5HMSUZnVikmw8aWXh/jqUvJvh4uN?=
 =?us-ascii?Q?HdUcW5ff78djLcBckrx+nMa349HXM/bdeUSjgwMEiQi5u5w4h3h5KKhZkzof?=
 =?us-ascii?Q?9GOfci6epD8HKO38dN/0yrgPnMqvDk7M+OVnYIpI1KhXRJZiBre8l8NqpW8h?=
 =?us-ascii?Q?ZYEUR1TtV9mEtXe25F/66wjUBP1ZpvoB12MZZEoQWfSEvHXUtZqAhaG/KrUT?=
 =?us-ascii?Q?7uccVYvxXlJ2sZM8KT/H0T7LcLQhh0qG7fWop3XjEksZv6UPNS1JldLI8XJs?=
 =?us-ascii?Q?twPGZXn4GnQ5y9nbHE9aQdOHz4OMmf1BVrtuNLLsI7/S91odmfG6a5BWeNjB?=
 =?us-ascii?Q?YDrppdY8Bm9bayGqUI/HtrOSwpIK+o0Wnz8xa+uBioblbPyYXiYFupHkM2wa?=
 =?us-ascii?Q?jfhwb5lRyiOIPTgf2OgX6/9r0bQGwluOr2EX9jeLXD5KcMrqC/ag/9qWRDd+?=
 =?us-ascii?Q?jGYZytFfz3XuSW8EHkRNJoowErgSQ0FVQ1NiaeZICfCdHlGdXR07zbhfbug6?=
 =?us-ascii?Q?fSS21yf4u9zYpA91r+qw+OA3H5baLyqTUXS+8LUmOSshqDjErOQi8P1zWBaz?=
 =?us-ascii?Q?JAllRCqXWTDFbim2MEfRNDTXzu1/DkJTogGSiWokfRua0c93rOG9OHGSaTjQ?=
 =?us-ascii?Q?REaIeuwtlA8TNyqwnNV+Qsm/chZaJjgx5E6BYbaOvy1YkV33X7Ukz7BfRL/V?=
 =?us-ascii?Q?Xyf+wyn7bk9O995TjeX6oOoKTArPkqKokiSlQauYJZpafkB1V3jGYNPRaGtn?=
 =?us-ascii?Q?qF+s6f9DdZeIKOfskRVJrK6IyNDQzPhGplIeewwodExeP56bEgvb8fXnFJd1?=
 =?us-ascii?Q?CIj1M53tl3TuIT+G6bwcQMPXyzjl5ivtzp5a5goHCEbwisPJXVjIBds/YicZ?=
 =?us-ascii?Q?tZw2QNQx8DjqGBItSAQgAwBpHbbYpyMambpXR1qZw7vZ7QtImnBloHJWrqBO?=
 =?us-ascii?Q?vGtTMYSpSDXcTDIDNDvk/NZtbUDaQp5yoaFuLIY8ShjOZwsK5w7gow5GaAuW?=
 =?us-ascii?Q?A0zL1czI8KCVpXvzq6oLrnHdcWhjPLeeAjWvVDZI8v+m5weOsNHGipl8OZTt?=
 =?us-ascii?Q?RxMTVGZNfNsj+3aWnalCVFXsoQnHsPnYCCrcZMHtOyWcn2LRZrduEf9bph3u?=
 =?us-ascii?Q?nkibgt/5CPaTT7taWxL8hXttsHnbqGqVbma+KMxbnDyuUkuO/blA9/rH0X2F?=
 =?us-ascii?Q?HXLzXxG3izXMMexlIN/pwWrA5hKoXsjXPCjq9lqjSq+93s2RleRt9OYUzhZv?=
 =?us-ascii?Q?j6s2Su/ydE4TFLv1q45PfSreip2Q6cL/5lVFbJYdwRwcL4w6wqZP8XVu6xfZ?=
 =?us-ascii?Q?XlUF2z0ijjghCGSHKbsqmBbEbS97B2IY2tMuCLKPBqS+tXSSUJccjshQJkXh?=
 =?us-ascii?Q?529H+mtfqaDAxDSs2s5G6tNQW2w6UjPKi9LcEB/zXipC1pxnGQXAogvjwGv5?=
 =?us-ascii?Q?9pHnpx03PLQLd2GWU0hJKlG+I9m5KXmCoprz8vGgHVZVUq6EFZQiHI6JNJBg?=
 =?us-ascii?Q?c6vyEtZY4gt6tahJsdItGIUWPCu3VWJwzz9/PCAKL9Xk0BO2lu7Iq/1aHoaI?=
 =?us-ascii?Q?T7XKeGAU9ojMJ9ZohhbIU5nVfSt9S9KJUQbgXD1x?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291498b2-7ee8-4cdd-8284-08dba175e2f7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 12:06:29.5137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IQCCTm5MREFB9IJeO3nvzbZUxICrY1Wgk/XzYkSHctb6/pt3O6Y2OESCzPpewI6VqyrQwbhrKVyacsA4uz2PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9523

This patch adds a new helper evts_get_info(), using 'sed' command to
parse the value of the given keyword in the output of 'pm_nl_ctl events'
command, to make the userpsace pm selftests more readable.

Then add a new argument namespace to userspace_pm_add_addr() and
userspace_pm_add_sf() to make these two helper more versatile.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 36 ++++++++++++-------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ee1f89a872b3..a0912b1d6405 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3255,15 +3255,23 @@ fail_tests()
 	fi
 }
 
+# $1: info name ; $2: ns ; $3: event type
+evts_get_info()
+{
+	sed -n '/^type:'${3:-1}',/p' "${2}" |
+	sed -n 's/.*\('${1}':\)\([0-9a-f:.]*\).*$/\2/p;q'
+}
+
+# $1: ns ; $2: addr ; $3: id
 userspace_pm_add_addr()
 {
-	local addr=$1
-	local id=$2
+	local evts=$evts_ns1
 	local tk
 
-	tk=$(grep "type:1," "$evts_ns1" |
-	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-	ip netns exec $ns1 ./pm_nl_ctl ann $addr token $tk id $id
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl ann $2 token $tk id $3
 	sleep 1
 }
 
@@ -3288,16 +3296,18 @@ userspace_pm_rm_sf_addr_ns1()
 	wait_rm_sf $ns1 1
 }
 
+# $1: ns ; $2: addr ; $3: id
 userspace_pm_add_sf()
 {
-	local addr=$1
-	local id=$2
+	local evts=$evts_ns1
 	local tk da dp
 
-	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	ip netns exec $ns2 ./pm_nl_ctl csf lip $addr lid $id \
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(evts_get_info token "$evts")
+	da=$(evts_get_info daddr4 "$evts")
+	dp=$(evts_get_info dport "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl csf lip $2 lid $3 \
 				rip $da rport $dp token $tk
 	sleep 1
 }
@@ -3404,7 +3414,7 @@ userspace_tests()
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns1
-		userspace_pm_add_addr 10.0.2.1 10
+		userspace_pm_add_addr $ns1 10.0.2.1 10
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
@@ -3425,7 +3435,7 @@ userspace_tests()
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns2
-		userspace_pm_add_sf 10.0.3.2 20
+		userspace_pm_add_sf $ns2 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
-- 
2.35.3

