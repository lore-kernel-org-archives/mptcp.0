Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44C812
	for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 07:13:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlU9z8LTZq9T6RR/20HYaAXDwtAeyt7i1yXuDjhfQXKFzSslAXbKEsavgFR4FH7Lk21NW+JV8FSgSct8sBUPfbgIh5w++mAhuQV3Ve+82QIIKEBpJ3J4B3Vk72GQKPR1BBkNgbOTtfQRZDVgtpr6UfKUjKliJH2uQmg7mCpo+FIcxPhEKDB1cGyQTMn3/V0a9pJ9r5a65BmLWDp3TgeJiBMwt28lZpAL6YefDpyIjG65MCHaa8TeHFFL41PEGvo+6Eq0VPrjRp4MvF/CrljiO1KXgYpE5iO1NyEhmeAzymZeCqHsULuAJI2zrPoXdG+0OFccEcMejSjzlih4wxi5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=km0FNlC/es2X8jf2VdrqaPihgwzADTkNRwIMP7Zn7vY=;
 b=XXxP3ROW9az13+jGVDjYaQ55prjBnxRwGWDVU/dRtiUpNNJwxvflCE0nd8gBgl9xT+Y+Z6H8UAuDALhHiAF8X9ia27FZNTdjbmGOhYines/Aeln66CMtMriEAeQh1dGr98ecPeHDDjG3iBh1lxjyR7W1b3hHb4JsApBhlfrw/ctbgW5aaK2dKd7lT3wHvQ1HfiZ3D2mbmPMYxzAgmcFhTGJbhlOEZA6Ifcfhvn/ekHnIpKaZQaintUkwvRC00zmv9EwSXs4JHV6XoapsF0+JNgfCjZGV+04A5FWU0Et23xZ3gKd1g6Rq4EcpBFyrOo5A0f5uCHg0Ict8hRLOIIXDvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=km0FNlC/es2X8jf2VdrqaPihgwzADTkNRwIMP7Zn7vY=;
 b=MiN94JhNispWHUKOJFS1yk8TEfgeDmEpaznsXPESaH9fTs8eYRC8NJWqDZsW1kds9VHxIkb+CtGjWV6Dd6ssysBRHIIAW5yPtsQ4Xgyf7mt1apWIhxBtPc4cv9GTSDb6yoTbJXLRXv3OXLwFL/G2om2J83rmscY5dBkjY4+EXoJQ+mpUGuEP61wu2mRfpwPgijpZ/+lyhRB0shLaKA5LjU4j7YtVfbDJCJJ4VZcTXoRQdVmS+Y7lzgkhf3mENRNMF0bunCjdOkrXKpoTs9T7N2+daXgI2TyqzCttb9UQYVQdlzMJ0NZYNRi0EswIxKJzYOd2be6fTGl8RN2057qZGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Fri, 18 Aug
 2023 07:13:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 07:13:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 1/6] selftests: mptcp: add evts_get_info helper
Date: Fri, 18 Aug 2023 15:12:00 +0800
Message-Id: <c4f9862b6ca52723bc087fe623c7444f72ca6995.1692342519.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692342519.git.geliang.tang@suse.com>
References: <cover.1692342519.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:54::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ddb8958-177a-4499-694a-08db9fbaa7d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wldZRkjLF/qAT//mgyJCDRzaTn0HZKxdQkHiyHasW5rvjzKazA9sFn59ZesFTWsn3F0gekf50qefYPgAp+nLkLk1pKjp9RMPI+Kyd9kQFTL0yVpoH06/xLyFc4rHSwVmnh2wRSfptrZ/gF2SmKwaQpQLJQaFU7wWj+jt8h5zznlRnfRpTrUPER6XDL2yEcN7KxvrW3Bz92IeVys8OoOPvhh5mYTnvuwPYTCAmfLWZZdblAcndHMP0WWdDlzJZ9hXymnSgFXplYhWUUTvMXdjy5cvBaTpOzZPa+ihGPxUvC+cMmuHVMXUdydtx+ZsMYBjG8XWuo+XfDbC0/M21MpGVNTo9P0ylMFQ8vuv+wtG/OF+Ckhd/gY0aUt5xKseXLuw7qm76n6GMv0F+47q32kBwrkSuk7bLV/2614WQWRbSS7tpD/R6j12eVQbYD8TD0c+M1vJJeoMg0WfURj6KIaEtWPRYq/URZuHNetILLnCWiFgOaRXIubkN7LpcsCU6b1UCekq3O6ap1EUryVN0KGiLh0qNAWRuJFXKXZX6Z0afGq1B7nWgu/LH2thPzTRIavIk//banShnXSn4W/NE5yksYqA2i5ZVgNNAtNJs0jNCJ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39850400004)(346002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(6666004)(107886003)(6486002)(2616005)(6512007)(36756003)(44832011)(5660300002)(41300700001)(66476007)(66946007)(66556008)(316002)(6916009)(4326008)(8936002)(8676002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fbF4+5gK7rU+YGSL84zlW6DflwL5yyWwnM/WwPoznOTbG0w7BSSyIEhr/X67?=
 =?us-ascii?Q?gx24cp8SLp877s5I4slOkXCGxkoeIc3Bvy0dIDXbULTDISJZWiA+BOaO+2Co?=
 =?us-ascii?Q?HbM5zXbQdNPxjKoE1MZePGJ/E1eMoVT8iH3FkygAEvG/Ex1Q7ugGllqdhNdk?=
 =?us-ascii?Q?XV7kTlW5D9AUCvXCa2vZ9FtMzgiL4o3IwwX/+mGiSNwMQ4lFlcveHscwZHg/?=
 =?us-ascii?Q?Q0Yz+taNmDAjaKGU+lUaH2xFfSDwPiI2HqK08inBZXOmXAPtYNuMR/sJ4076?=
 =?us-ascii?Q?Wnoc1Ab2YpoP7EZAAvGfBumbE6fv+1Wqnz35wRk8QVB/qcEMlCzc8UZ7ACwS?=
 =?us-ascii?Q?Eg32gaBxvCofUL9aOoD3/sp2vbzZw0HDy3ynh/QLndXpIUMDplQ5jAFWNicx?=
 =?us-ascii?Q?1wtA4emBGXmyIp8mh9YkI42Cbc3stAk1AYXq9fVh6TKjaE9NOyjHR682Q+HC?=
 =?us-ascii?Q?xK0N4UiZT1qzBnxgCze4OT/njY/rqCpSO52WZeifZq7EfhW1jrFq6wCC1G1l?=
 =?us-ascii?Q?nIa32Q1zBId8riVu7vyLwxvmLYpPT0ucnorT23wRf3nRNmEN1ftgLIjpnsNs?=
 =?us-ascii?Q?jbQZQIn7Bzec31hF9BTmanzC96a0kD9kKAfT7b1DOdcy5JzqdWuLu1RuK5It?=
 =?us-ascii?Q?jLTy9YZPhWWXprDxiXnKzuJ/+ZvTUCQlAJw0Yo00kYTPtAHxYa/NGHfeC/ml?=
 =?us-ascii?Q?aecWrgD9E2kp594VhhEy7AAa8Wb2Luu8j56zH1dYDbLdxUsKkUYGgNyaM/Cm?=
 =?us-ascii?Q?Uhsaod8J3EZChdzMZbMyhgoy73OsOrDYqI9ilisTHMlqNC9qgZMZsfhN2SPi?=
 =?us-ascii?Q?rG7hpCB6BaQUI66dD0j31e4m4iN6JYOapZWlTkm/nzWhNDGgg3GVfGU6UNs7?=
 =?us-ascii?Q?Aon0LL1RVaWar9X7wK94N9AmVUnbt683q8sb72PVPmhd4jt37lQ3i7RSx1Fs?=
 =?us-ascii?Q?YmyqGSDqAHvW1vXER4ZAWjseaIRmCF1N5Lro5PSOpIaf0rhNl7u3/vBhnnIC?=
 =?us-ascii?Q?fd+4RYk47p5ikEP/L+XZmmN/i9/XxxMr/IRdg8OC+5zDeB0qsZBnSrAQdxj0?=
 =?us-ascii?Q?9YQ1O/Ex/ik3ko2wfJ5tjWNmWIYei5OrRbMjU5vdjAkoNT1XH/jYPalrDq1N?=
 =?us-ascii?Q?jEiF76TJJg0sRXHtqFVoWkTYueVG1k/Pdg7OGgwK/ZzQ9NOhjfogn5YpoQ5M?=
 =?us-ascii?Q?YpHEGv/BZQdxaTBDoxdZyXrJKzUZ0NT99cTiqc89c3b+PLo1j5oEHL5qPJTd?=
 =?us-ascii?Q?V8/KHqcLLd9+54iteWyGr2uQbRjgnoHOGDTvR5j8WowTMXSbSApAJV2IP9kL?=
 =?us-ascii?Q?zMXs0mshYZVFGPHiJi2W+XtjaoFCnETuus3pOZs3SVNpk7HM1e3Kp0ExaETO?=
 =?us-ascii?Q?Oy5AT7vc6rGztVc/oQVxMtScXQvFWQ8HPwqN3mLqc56MmL50vl1NBM/at15F?=
 =?us-ascii?Q?uA97rGoYuASLuUet7BWc8WbJiGmyw008dBXRILYeHjkolJV4RbJu6Q+nYBsZ?=
 =?us-ascii?Q?hryb5iH5RbTfcWHR93tmD3+9wKa+d0olUeW7zHUqsww0rvz416iM8B8iy0Sq?=
 =?us-ascii?Q?bSFbWekIejPg1vQ6zFOJa9fCsCXKqgyD3s3g5B3t?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddb8958-177a-4499-694a-08db9fbaa7d4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 07:13:43.2467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9I8S76YV+MUo3cpv8CwV/XQ9yOhKkxYLgDOHS6rPOk07Rc0A/2Y9Apn49Zd/SGJVm1RkFWQra+7cOn9q+lIJjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975

This patch adds a new helper evts_get_info(), using 'sed' command to
parse the value of the given keyword in the output of 'pm_nl_ctl events'
command, to make the userpsace pm selftests more readable.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 39 ++++++++++---------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ee1f89a872b3..f311fac5fa0d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3255,14 +3255,22 @@ fail_tests()
 	fi
 }
 
+# $1: info name ; $2: ns ; $3: type
+evts_get_info()
+{
+	local t=${3:-1}
+
+	grep "^type:$t," "${2}" |
+	sed -n 's/.*\('${1}':\)\([0-9a-f:.]*\).*$/\2/p;q'
+}
+
 userspace_pm_add_addr()
 {
 	local addr=$1
 	local id=$2
 	local tk
 
-	tk=$(grep "type:1," "$evts_ns1" |
-	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
+	tk=$(evts_get_info token "$evts_ns1")
 	ip netns exec $ns1 ./pm_nl_ctl ann $addr token $tk id $id
 	sleep 1
 }
@@ -3273,14 +3281,10 @@ userspace_pm_rm_sf_addr_ns1()
 	local id=$2
 	local tk sp da dp
 
-	tk=$(grep "type:1," "$evts_ns1" |
-	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-	sp=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	da=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
-	dp=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
+	tk=$(evts_get_info token "$evts_ns1")
+	sp=$(evts_get_info sport "$evts_ns1" 10)
+	da=$(evts_get_info daddr6 "$evts_ns1" 10)
+	dp=$(evts_get_info dport "$evts_ns1" 10)
 	ip netns exec $ns1 ./pm_nl_ctl rem token $tk id $id
 	ip netns exec $ns1 ./pm_nl_ctl dsf lip "::ffff:$addr" \
 				lport $sp rip $da rport $dp token $tk
@@ -3294,9 +3298,9 @@ userspace_pm_add_sf()
 	local id=$2
 	local tk da dp
 
-	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	tk=$(evts_get_info token "$evts_ns2")
+	da=$(evts_get_info daddr4 "$evts_ns2")
+	dp=$(evts_get_info dport "$evts_ns2")
 	ip netns exec $ns2 ./pm_nl_ctl csf lip $addr lid $id \
 				rip $da rport $dp token $tk
 	sleep 1
@@ -3308,11 +3312,10 @@ userspace_pm_rm_sf_addr_ns2()
 	local id=$2
 	local tk da dp sp
 
-	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	sp=$(grep "type:10" "$evts_ns2" |
-	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	tk=$(evts_get_info token "$evts_ns2")
+	da=$(evts_get_info daddr4 "$evts_ns2")
+	dp=$(evts_get_info dport "$evts_ns2")
+	sp=$(evts_get_info sport "$evts_ns2" 10)
 	ip netns exec $ns2 ./pm_nl_ctl rem token $tk id $id
 	ip netns exec $ns2 ./pm_nl_ctl dsf lip $addr lport $sp \
 				rip $da rport $dp token $tk
-- 
2.35.3

