Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7785A6ABC
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 23:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645744982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pcE2TqFG7o/QQzHWJBewf+7grl1j7JQaqSy9QCjIL9E=;
	b=BHBbjs2pkDigd1g2Itw2YrfvJZ0QoTLnLf4vFP5wK1ifXzEDKB736Zwk/GIuPps9Jj7/QO
	YG0OZKoAmTvkAUSRmAq+HI0gX2/vDZuRmPhycwPnOyqllyPW7jQ5MuIQszUiwOz2tj4zEH
	MI2BrkveIbr0DlbX9v5MXO8yop5+nbU=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2056.outbound.protection.outlook.com [104.47.10.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-sgZzW2TgMEqdETuTMzc-rg-1; Fri, 25 Feb 2022 00:23:01 +0100
X-MC-Unique: sgZzW2TgMEqdETuTMzc-rg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERP1YTdXonrlq/QIJZ0W9BSNHpMOuh8vuWGXMup+LHjoVEjuuIa+Oxgymg1dwUX/Mvg+1q8htXd1/GsAtOuXcHeeJMlGVCfULyhXYSL69xZVTEutcsaHS1yqlSWgN2kP+gHi5IcYxzNnsZigNQkzeuwABTVZYPk+tQ2m+6eeYPa1PMKcRjlG+FufP5vsyZdh5HVhy42ywaUAMzJIQXm5Kfd+BNYnCP9pFGwbZNIMVAy5dvz2OcPtlTmogVN73mlBtDXdi0l5aHTOJg0+da255T6S2xGXmHcKvJ8D3/Qol2lPsMJUMoJMCOa+HkaI5s5du1WZ+cmwv2eLUyhmnolpOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pF2XTltnYnSuSoSVJTSMmS/529kTTm9gNe/IR/7Hgek=;
 b=f/T6YxUXV8ZyyQaGX9zJZ1sQB9Pv8ZWxOvCCXFDR5RPlQH5sGt6RQu+8ayS3KP1g/8sWsBEwOu5mHF55C95TIFqNaTrUCTvWjqJyNR7sEZAesQjo8FCWUupz+2s0JHjKkUqoUwHm5LevnR9HiEN46Kd2X0cgVpXmj77pdzf8fyBQYeZbgExkXngQF6IcIJsGVp0NmjpEjyO2XvIipO0f3CrZNOxIc5GUe43HVXAl5pihj368pyb+TYw/jdZ78SqbHWPQgjUG8U2qQMiVIrdIB74sztB4wBf2J9GA8R/ImjKzFHdrt4iYc//HuXchE04MQvk2XndfFyjKgKrWI0WyiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Thu, 24 Feb
 2022 23:22:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Thu, 24 Feb 2022
 23:22:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] selftests: mptcp: drop msg argument of chk_csum_nr
Date: Fri, 25 Feb 2022 07:23:32 +0800
Message-ID: <87d043bc528d81560d964f3536fb549d3ae75a8c.1645744986.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0077.apcprd04.prod.outlook.com
 (2603:1096:202:15::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f1774b7-425f-4700-4eb6-08d9f7ec9836
X-MS-TrafficTypeDiagnostic: PA4PR04MB7726:EE_
X-Microsoft-Antispam-PRVS:
	<PA4PR04MB77264CC9319D90FCE3E23113F83D9@PA4PR04MB7726.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zzdMFevRqhOagLHxZ1Nrw26r2rmzpXopjab6jCqtUXvQj/dXhXD7l1HIIkU0n+Nu3dOJXYSohk1EmKAJk2JGi/fST/LQdqzpuk5c0CDmtOq+hZHSbve9Bhj/2YkXuRfps/X7R7tOXxdxgyfMq13S42zlXNuaSGQ0qH5V526kJLHmCrZ3UZ4ZZAyKcEzZpk7A/v3EfGTlVr+o16T0SRFRGYNJiEU+Gya39Nmpa9yPz+EY/s9Y9ntv4z0RPcu4BWg1g8tiFNaZa1TFE2l4HYj688E4OjIL7PSgv5aMaC9rh2FXc2wx+uw81NYuTgrIEEFohUchDZAYnAaha0fnJ7YKWW88iDNN2rMjpxZz6jIK6TKboXTmvbL8ydN5V3/WIUq9VXdNeEKTZXrV/8tAysOY2+kbgH+e0esjTqfsRb+S+2wELtlS+gxdWCHTnTUPr72fRJOjYIAdEo81eheyfp3g3iZLbEKv/fhrsZpoqF7wXI1AMR0wC/V9kxpMeApOLmWHxb5xZ60CO8P6JwT0UXWwzQeZ9nadR9Qs7P0tjoWneGHF3bzxUoSHNKRRch9fTLEhdAOqFm7HPkT8YmPETEKurjpyRQh0pDUR1rncZuxM9OO8N8fX/y/UvU00lj23vpthwhl7pHYmGAIBeY8N1iKtUjRaragI/mP8Wqg7ME7NgntKIVmRp8Bw8txSjnZfaD5D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(6486002)(5660300002)(8676002)(2906002)(66476007)(4326008)(66946007)(316002)(44832011)(36756003)(66556008)(8936002)(6506007)(6512007)(6666004)(38100700002)(86362001)(83380400001)(508600001)(107886003)(2616005)(26005)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gMNhihbB40dOHYkKAuZFWtllzFBFwVwQ5D7SHU1PjQQ5NYjNUC2JbmLAC8QD?=
 =?us-ascii?Q?CYK24H4+5ZMZpGMQQDMzZAvqD2NEiXPZY0FnHrZWYaT1dJOjIRGm8Pcd294T?=
 =?us-ascii?Q?ldnX98/jjhwmAaHy3k4R2lwgVB20GzjmMX7aeGWypMKyUFJmL3x54hyaq6ZW?=
 =?us-ascii?Q?4LcShZkwJU/KwVxpFyuhpzlgh96kBdPs3qmIX5JTJ2niW+EyXKX3+s2MVsBU?=
 =?us-ascii?Q?e3TPr8MP+xpQN71Kx+WTvCKU+BqAV3jfo2+XWQ1OHBegr/xqeR0XLL+Q6K84?=
 =?us-ascii?Q?T/hNWO5nPMLqxgZfiHXG7hFnGLrlDE32bjg863QGlPiGqKXzZkPITVlefqnG?=
 =?us-ascii?Q?DzCBT4hpkrYRNx2037aKljMv20yZEZRK67R/oDDghhQp651faKqhqALkmXns?=
 =?us-ascii?Q?8XicZAD1g36oPPl9gr6JjtouDtM8VZOBWvLEkpkyV1LH9Nw5oVprxbClTOPG?=
 =?us-ascii?Q?rD8+y9f2ie+fXOETYbivBJ3X5eQDzFmbf4s2yAVTtUlnBu4PnFytIUNEXTqU?=
 =?us-ascii?Q?4b472/7dXU6BYMyBg+i6N/VIkpqw34XVM32o9WUJx2XJQmGO6m6mXIhHJpQY?=
 =?us-ascii?Q?SQsz4OExFM4G2njvvsK1/p796bBdfvl+GHyfblQeg4/3Oo4Y6H7UklP0uaWF?=
 =?us-ascii?Q?vyzawZO9SEc9PNf39qUr5qrqRliHy2B8Y4BV+ATpk96Gby2CTv8cbhqsVMZa?=
 =?us-ascii?Q?JvfQb/t4Gx13gMROcDVwDKnd8HMXWxJPC7AMtuiQGCbQebLYaIqlkPnLAPOG?=
 =?us-ascii?Q?DnCRieK2OQZ5RiR1XFP3B8jue5PAzB9MGDjyXA83IQcrNthNlQCWCY6hsktj?=
 =?us-ascii?Q?HvwlbtGpxKje2Ss2hESNLA4yc6OsaAw0crTN4agl6nX16gk6X3itxK97zpCV?=
 =?us-ascii?Q?NKcqKwBefJGigUi/3sweT/IE9upX+/9r9OAII8CTU0wQjjs9s1v+W6M+nU5+?=
 =?us-ascii?Q?hoZwE94oSU1Z46CEh0tLPy5fPf895igJOKc4FZIvL0aL7Je1bvjMVGAJaS/z?=
 =?us-ascii?Q?hnpNfNWp1M+ZD7OmIfpoB7Xsq53lqt1ZRovaY66DFanpgCDWzkgFC819dvah?=
 =?us-ascii?Q?GwWKRT+O6McJBgnX/eN3Jy6BnwonGcFqZDGlNpOd3mxM8d4mZglqlfK8w3rn?=
 =?us-ascii?Q?t/N2fzO0aWVIJPEB8ACc+k41CtThjphBwaa+j8kydJcDERN7uJJBa6iapac7?=
 =?us-ascii?Q?x9YhajjEJBu09BXSriZXlnlCIc3ksk9xaoLoSzRJaoRlWDPxf9q1ag9/b60q?=
 =?us-ascii?Q?ecuuddbomniF9bD2F4l2bqXQnMytRrrMvHaSRIDc3WgPp9iBe7mQy+UwmLNY?=
 =?us-ascii?Q?dJY8znMk8Z/FniJVxYkc7PTJsta1eUTya4gGi+YF9+LcW0KoQ+K0YrcIsDGr?=
 =?us-ascii?Q?S+R4pwpFz+g+ITMWDL9irQjkYCi8nzJMnnYMd/FGeoOXIk/0TFbyTI2WKZHk?=
 =?us-ascii?Q?HhRSwZw/nkd5ernxVGztKXz+63kQ420KL5CmxwDv7jAW0rABWLmqSRJVdAUz?=
 =?us-ascii?Q?7imzyPigyhiFADCr+H1CuzGv+69TPPPxUhqF4Tjk0iBVzVzMCl6ZSdf0Mh/j?=
 =?us-ascii?Q?lJQlhNSFsIX01oqAvYkyMcrmCcbjjxml0vu24MwM+k6xIRw1lxKyOLZnncvn?=
 =?us-ascii?Q?EwJ/kRmCAlZODUC6YnFl9iU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1774b7-425f-4700-4eb6-08d9f7ec9836
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 23:22:59.2517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZ+LUYlmRJL4E0BBV8X9lshXbRZJRM+n+p3ebdRWt2oXHO0VBXg/cLVIfeeQPJ6eZXhNlo+POOQce6Rc2MVi7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

This patch dropped the msg argument of chk_csum_nr, to unify chk_csum_nr
with other chk_*_nr functions.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 ++++++++-----------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index ef57a28cf722..9604555fc812 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -196,6 +196,8 @@ reset_with_checksum()
=20
 	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=3D$ns1_enable
 	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=3D$ns2_enable
+
+	validate_checksum=3D1
 }
=20
 reset_with_allow_join_id0()
@@ -890,9 +892,8 @@ dump_stats()
=20
 chk_csum_nr()
 {
-	local msg=3D${1:-""}
-	local csum_ns1=3D${2:-0}
-	local csum_ns2=3D${3:-0}
+	local csum_ns1=3D${1:-0}
+	local csum_ns2=3D${2:-0}
 	local count
 	local dump_stats
 	local allow_multi_errors_ns1=3D0
@@ -907,12 +908,7 @@ chk_csum_nr()
 		csum_ns2=3D${csum_ns2:1}
 	fi
=20
-	if [ ! -z "$msg" ]; then
-		printf "%03u" "$TEST_COUNT"
-	else
-		echo -n "   "
-	fi
-	printf " %-36s %s" "$msg" "sum"
+	printf "%-${nr_blank}s %s" " " "sum"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D $csum_ns1 -a $allow_multi_errors_ns1 -eq 0 ] ||
@@ -1134,7 +1130,7 @@ chk_join_nr()
 	fi
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 	if [ $validate_checksum -eq 1 ]; then
-		chk_csum_nr "" $csum_ns1 $csum_ns2
+		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
 		chk_rst_nr $rst_nr $rst_nr
 		chk_infi_nr $infi_nr $infi_nr
@@ -2252,28 +2248,28 @@ checksum_tests()
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
-	chk_csum_nr "checksum test 0 0"
+	chk_join_nr "checksum test 0 0" 0 0 0
=20
 	# checksum test 1 1
 	reset_with_checksum 1 1
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
-	chk_csum_nr "checksum test 1 1"
+	chk_join_nr "checksum test 1 1" 0 0 0
=20
 	# checksum test 0 1
 	reset_with_checksum 0 1
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
-	chk_csum_nr "checksum test 0 1"
+	chk_join_nr "checksum test 0 1" 0 0 0
=20
 	# checksum test 1 0
 	reset_with_checksum 1 0
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
-	chk_csum_nr "checksum test 1 0"
+	chk_join_nr "checksum test 1 0" 0 0 0
 }
=20
 deny_join_id0_tests()
--=20
2.34.1

