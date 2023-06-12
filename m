Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C52520F9
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 07:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzWthXG/5ppbUCzecbiBWakiEkoiq0DFgvjgIsmPraYqsyxroUCJdi+niiHvz50qUi5iTQ28dnPKRdU5ofbA2KKjtP7t8e0IACZJbrbVU2cn7o31wl/f/+pr2LQfQkJc2zhqV9+/juhxLgNJlsd6Ey4J9Bc+hjwiCuY6hXL6WkdEZkMdbwDDyxfyRQCEMYVz1ywHf6PHbknq35f4x2t8LhHaW0FSawiXFf4uagKPqiSiUNW8mkscwSW+6zu2h8UiPe0CafF1CICLlRWOKG682dDXNdrX6/fg/ajwnqkTPL4/3TdKzo4LgmIyZ/0T9nA3n+7iXnDr3nBL7XBMadxXwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/SJKVbZnhcfluLJDoW0VZYCibjomlb9H8hIaJzEmu4=;
 b=ZIhdJgn8rRsbiHzWGzGWctiH47MNRmc8IUWQx2YXdnAyO3k1WY+DAoT7yKGhrP2oA1osCP9tSmL+YGQEoXMz/IOl8TBp97sTwJuiynWTh7zz1eH3BHsTJIguyEk36n63EV/7jznESSL2wodtGx/gWciAOeLInUE7Zcvi15i4TOWivz5LH9EBHx/pagcrMyDR2RRQlMPeLwmrXa4IaKe/fSbmDF7iZ6yBRWXiUlxvt3URpDBX8V9vq5Pb9Hf2ThCuK2iS0O/0oF1wzjPKurPKxJ+XSFZQ5NYeyCvLBVQTjbqLiEhJ5CDWZOLw3cJFRXjH3//JGdNGwgEfoQC7dmk3zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/SJKVbZnhcfluLJDoW0VZYCibjomlb9H8hIaJzEmu4=;
 b=Hq8Avin1LfEBHwBKJ/BJknR5ihEUOs9J39pdYHndwJjDmho2e1k7saZexSKtFkW1oAIxw43PdGIbPjBBPkD+tV9+6+tue0LH5wLOcAihSSTTWJjR0/pMLJLDx0EwdwkLUClm2WldYn+e1doPbiXpwmj4Zr2COKJWD78nr0naZiIAXz724DBobV2yS9cXtSVrjMAZjWchaCB+85k3WXNAQbe2PbFaiEpfjwO+uFZUIQlHvooqZic43K8xZmtOvVh5W4zmbY8vjCs6YLlmcr9QMDt+fNCj8f1lM2XccTjrUax3XVvcLDUAL2wo6dTJEkpP87LDV4IbhwFpXYUXu2nGEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9149.eurprd04.prod.outlook.com (2603:10a6:150:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 07:20:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 07:20:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 2/7] selftests: mptcp: test userspace pm out of transfer
Date: Mon, 12 Jun 2023 15:19:41 +0800
Message-Id: <08a9ccd5c010ead677267a0bfb29869bf484ddc3.1686554287.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686554287.git.geliang.tang@suse.com>
References: <cover.1686554287.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9149:EE_
X-MS-Office365-Filtering-Correlation-Id: bd398b51-1ef5-4f59-8e6d-08db6b157ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SLRgIMqB8Nt5pjNho15Cj4bGzXVdDQ9P9M165kuoK3Nbw+NioiClHqzoK44Px+FZfDG9VnWU+HDFiVUBM1lo+Bo+y1CpSw/xU5sRnWzBF7OFzHwAh0iWxnKTijbRiBeNRYxrlduFpg5CpSWqhR5ViOTv7rjF3LiV7UGl2iarkY9GbAh64Eo/LtjlUBOjKN5CkT6vNu+eKrAH7Yaba9W/3qhp95NRzT5yEvKMecXGDFQrSBc87mgY1o+q+16y1PYPEup9PpcFs4V2qSYQ7Z/wLcfndkzwaNwdaJ+Ij273/KPj6/a8B+8vSHCZH//mZXBqQdvSyBzYEAp2zN652asuPz/hw2xiDdt9XOeX8+rAZsBoZQYWsevfA7B8uXEdjWoHYlcLm3f9C5UEnn1QxJzq2jsYE+TuHSHPWRheAX0P+idHSd5xzl9hr7uyWZgOb2pv8qP+9ygoJHSVj2zcPEKxGGMpgbctBLMZolSV2n9zqD/8GBi1nW5J6kYkMIt5Xwiz2VUinnG6b7Hbz4eZj3imBCPgNzDDywO3KvNGmjOOF7lBd3PkS6xSfVw64siDLkjh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(107886003)(6506007)(26005)(186003)(6512007)(2616005)(83380400001)(6666004)(36756003)(44832011)(2906002)(8676002)(8936002)(6486002)(478600001)(6916009)(5660300002)(41300700001)(316002)(38100700002)(66476007)(4326008)(86362001)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sFgqFyEArPtv6EqZFkyu/Ay85Lqb+1D9eVndIwDw+Eh8Zl+wNonezzSCWbK7?=
 =?us-ascii?Q?uCKwpWu2FOWgnl/66c8SHgWhGHG7egD0b7gQeqYEiZVLokb43+/ZVeY8x4FM?=
 =?us-ascii?Q?vH2FMWy3ku3ylZdEpizCnqZXtYwPQRei4guoC3SkzAlHpFbU6/J3uRaALCSF?=
 =?us-ascii?Q?/Qr5C7dCGDpolUIi/rikj2Z1CkVcxC+W1ElzAwYr4EuKIUyvkb5SGbRffQ7W?=
 =?us-ascii?Q?jGmZinfCV7acwuznK9TyJfQz2PP7vmg+lIXv9Lz+5ZbO2r8lO7BFG4BQs2/B?=
 =?us-ascii?Q?79Jc2Vn+mu5VVlPxmtW7bOFKA68+t3ZcPOvtWcrb9hlzExrEZYCzPz2tacmw?=
 =?us-ascii?Q?1ECAfsv1INaoPJKncoOlxp8VrpeBK+v9RBp3Ygq3k9JhdDWvGJAvhvWBZB5Y?=
 =?us-ascii?Q?qUNAFCL7qXTyHSSXBAMKIi/eS0Mgx3lTkteva4mxy9j3ItE6HkLIhYUntaAV?=
 =?us-ascii?Q?4l6j30eusst76qX6duIZeRWIK9fiXjcB5PrGosEHzfRM3MAGfWHOPTbnl/fx?=
 =?us-ascii?Q?IHH2hvy1ceGxEGu1Kj0w8xSixidNH23ceo1TjQ3eTDoI73mXCNEUY5/Hffna?=
 =?us-ascii?Q?0oMb2lzAlFreb9ctLlbLUYw7kx+7hlc9oDvjMspujJrE8viPJ3KX3puqtu3W?=
 =?us-ascii?Q?oDANjFH/0vO00iK46U2Ba90v0yIl5F1rYcoeUJnFNFm1eDLEtAGsiIP464CT?=
 =?us-ascii?Q?rHAPU6IH4FBMNU9Jq07z4nvqSSS5vSGx9JmXp4avFNdRcgeSYAvIUEXV6E3W?=
 =?us-ascii?Q?7cePJigoJEowiBEzPMYP//4QD66mp+AAR1M6PvSbM4ukEVfSnLMxLOCkWIVg?=
 =?us-ascii?Q?AM4CDuSiizBpTQLe/qzhZsCOmzihX/rdMhHaBLKEurF6Oc5XhB4DogdACeb/?=
 =?us-ascii?Q?VrCOjMrBONh4f6qDpW+Sujypq2j6dt/Hg6Gv9tLs8Y5EnIeCc/WnDYcIjiCg?=
 =?us-ascii?Q?3zD2lo32ApAILeYHmITSlrQyDhiOIvRNWL8UpRN6URru6A1lB8VU+8PJmMhB?=
 =?us-ascii?Q?AM4bYOZpmf1avKmo9iwAJYwirFTi4jdyZ+9uPsNCKD43DEvIj2dmGDDtPNlr?=
 =?us-ascii?Q?WUh7QW8w3Apf4154pwmGPmra+/oGGDMbfBFwoDa6Xt+iRdZCR3lhtbFZryTE?=
 =?us-ascii?Q?qq2WiJdAUaX/7spsoedVpO5J4d4xVhBhVXOTTqynJ+58vmFiVeUzzbSJu0Gc?=
 =?us-ascii?Q?XK5qBgdhkZptHbHmErKBOIf913gUzm0C+09a608fjAllPpqusLRQCFRxr2mW?=
 =?us-ascii?Q?baEUnSbQP9PvhGMhnrq2wP/K2GUXAV/Kw1ZwGf1oodmVMN5c7+R8ZfiG/BJG?=
 =?us-ascii?Q?QDXIKWLupp+1LY9ph8wlvgTzcQVAqIWBJVjXqNTi/2w8mIVLJulYtwa6FG0C?=
 =?us-ascii?Q?q0XJKUat6eQYgpVLke8QLwjShhx1upoeSt+VVpSa8LrvCU6MGlQJAKKqwpq2?=
 =?us-ascii?Q?y1RAn6cEW9fV5AWIF6R9CC+t01EUjzDMKtnt7/66QGSbxpBZEkAdk7hbDqVQ?=
 =?us-ascii?Q?CdXJkLekRhD9ATu4Sm2ovb9IlZWJEqNnaOkq9zhw+TCOQm2z4HNid0K7NQe9?=
 =?us-ascii?Q?vwNkXzG//s462g+C4fkbxHLudfUNpvivzTb7V2IN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd398b51-1ef5-4f59-8e6d-08db6b157ee3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 07:20:27.4452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpyonr13RDDKuM6Xcjg1Ar4BeNob/kxSteis3rf7rTo/1xNJ1QeDCj4AiG7T9h0eOp2cedwXhaZiw029ce3RKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9149

This patch moves userspace pm tests out of do_transfer(). Move add
addrese test into a new function userspace_pm_add_addr(), and remove
address test into userspace_pm_rm_addr(). Move add subflow test into
userspace_pm_add_sf() and remove subflow into userspace_pm_rm_sf().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 143 ++++++++++++------
 1 file changed, 97 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a7973d6a40a0..556d21c4b7a5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -589,6 +589,26 @@ wait_rm_addr()
 	done
 }
 
+rm_sf_count()
+{
+	get_counter "${1}" "MPTcpExtRmSubflow"
+}
+
+# $1: ns, $2: old rm_sf counter in $ns
+wait_rm_sf()
+{
+	local ns="${1}"
+	local old_cnt="${2}"
+	local cnt
+
+	local i
+	for i in $(seq 10); do
+		cnt=$(rm_sf_count ${ns})
+		[ "$cnt" = "${old_cnt}" ] || break
+		sleep 0.1
+	done
+}
+
 wait_mpj()
 {
 	local ns="${1}"
@@ -813,7 +833,6 @@ do_transfer()
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
-	local userspace_pm=0
 
 	:> "$cout"
 	:> "$sout"
@@ -850,11 +869,6 @@ do_transfer()
 		extra_args="-r ${speed:6}"
 	fi
 
-	if [[ "${addr_nr_ns1}" = "userspace_"* ]]; then
-		userspace_pm=1
-		addr_nr_ns1=${addr_nr_ns1:10}
-	fi
-
 	local flags="subflow"
 	local extra_cl_args=""
 	local extra_srv_args=""
@@ -882,9 +896,6 @@ do_transfer()
 			return 1
 		fi
 		addr_nr_ns2=0
-	elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
-		userspace_pm=1
-		addr_nr_ns2=${addr_nr_ns2:10}
 	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
 		flags="${flags},fullmesh"
 		addr_nr_ns2=${addr_nr_ns2:9}
@@ -938,7 +949,6 @@ do_transfer()
 		local counter=2
 		local add_nr_ns1=${addr_nr_ns1}
 		local id=10
-		local tk
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -946,24 +956,7 @@ do_transfer()
 			else
 				addr="10.0.$counter.1"
 			fi
-			if [ $userspace_pm -eq 0 ]; then
-				pm_nl_add_endpoint $ns1 $addr flags signal
-			else
-				tk=$(grep "type:1," "$evts_ns1" |
-				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
-				sleep 1
-				sp=$(grep "type:10" "$evts_ns1" |
-				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-				da=$(grep "type:10" "$evts_ns1" |
-				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
-				dp=$(grep "type:10" "$evts_ns1" |
-				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
-				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
-				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" \
-							lport $sp rip $da rport $dp token $tk
-			fi
-
+			pm_nl_add_endpoint $ns1 $addr flags signal
 			counter=$((counter + 1))
 			add_nr_ns1=$((add_nr_ns1 - 1))
 			id=$((id + 1))
@@ -1008,7 +1001,6 @@ do_transfer()
 		local add_nr_ns2=${addr_nr_ns2}
 		local counter=3
 		local id=20
-		local tk da dp sp
 		while [ $add_nr_ns2 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -1016,21 +1008,7 @@ do_transfer()
 			else
 				addr="10.0.$counter.2"
 			fi
-			if [ $userspace_pm -eq 0 ]; then
-				pm_nl_add_endpoint $ns2 $addr flags $flags
-			else
-				tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-				da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-				dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-				ip netns exec ${connector_ns} ./pm_nl_ctl csf lip $addr lid $id \
-									rip $da rport $dp token $tk
-				sleep 1
-				sp=$(grep "type:10" "$evts_ns2" |
-				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
-				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
-									rip $da rport $dp token $tk
-			fi
+			pm_nl_add_endpoint $ns2 $addr flags $flags
 			counter=$((counter + 1))
 			add_nr_ns2=$((add_nr_ns2 - 1))
 			id=$((id + 1))
@@ -3205,6 +3183,65 @@ fail_tests()
 	fi
 }
 
+userspace_pm_add_addr()
+{
+	local addr=$1
+	local id=$2
+	local tk
+
+	tk=$(grep "type:1," "$evts_ns1" |
+	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
+	ip netns exec $ns1 ./pm_nl_ctl ann $addr token $tk id $id
+}
+
+userspace_pm_rm_sf_addr_ns1()
+{
+	local addr=$1
+	local id=$2
+	local tk sp da dp
+
+	tk=$(grep "type:1," "$evts_ns1" |
+	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
+	sp=$(grep "type:10" "$evts_ns1" |
+	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	da=$(grep "type:10" "$evts_ns1" |
+	     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+	dp=$(grep "type:10" "$evts_ns1" |
+	     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
+	ip netns exec $ns1 ./pm_nl_ctl rem token $tk id $id
+	ip netns exec $ns1 ./pm_nl_ctl dsf lip "::ffff:$addr" \
+				lport $sp rip $da rport $dp token $tk
+}
+
+userspace_pm_add_sf()
+{
+	local addr=$1
+	local id=$2
+	local tk da dp
+
+	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
+	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	ip netns exec $ns2 ./pm_nl_ctl csf lip $addr lid $id \
+				rip $da rport $dp token $tk
+}
+
+userspace_pm_rm_sf_addr_ns2()
+{
+	local addr=$1
+	local id=$2
+	local tk da dp sp
+
+	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
+	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	sp=$(grep "type:10" "$evts_ns2" |
+	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	ip netns exec $ns2 ./pm_nl_ctl rem token $tk id $id
+	ip netns exec $ns2 ./pm_nl_ctl dsf lip $addr lport $sp \
+				rip $da rport $dp token $tk
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3283,11 +3320,18 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr 10.0.2.1 10
+		sleep 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
+		wait_rm_addr $ns1 1
 		chk_rm_nr 1 1 invert
 		kill_events_pids
+		wait $tests_pid
 	fi
 
 	# userspace pm create destroy subflow
@@ -3295,10 +3339,17 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf 10.0.3.2 20
+		sleep 1
 		chk_join_nr 1 1 1
+		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
+		wait_rm_sf $ns2 1
 		chk_rm_nr 1 1
 		kill_events_pids
+		wait $tests_pid
 	fi
 }
 
-- 
2.35.3

