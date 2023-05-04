Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A39BA2D
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 10:21:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9ykKw0rqAm1D07tzzSVj3wr56D5bSvJpBOQlHmJafHk1oaVTZYzZBzSxeUr0bTbspTTvRpsFv2bpsBnO15aPSg/DpobNWWED4qJQhOo9oFfe191R7w8uXN8z8SiCfDAmEXlr5riHbvku4+qLGX3l854u4pJv+ynhcRbANYulfw9OI+dDW1PF59VJHN8ldXs1balSP2AkgprZduIPLsWD4tUhvieN6xvzlKOG/NPCmSV69E1ebw7XnBYS9E9WauJwG+Zxi4/rAIlyARIY4sSEkTjsNwIYG0IjVnMRQvpmk4KMYB2HVNG0EUpbOcGtu2NhRqSGljRgy1OG3ObgeGXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXJZdxhSlsqJtx9jAPcraa3fLqYN2DDuCp3oxj7AyNA=;
 b=QsB0zRf4cWL+FZDY5wT7hR/lVOrMB/PDs49kJtmFWmpZeskXHKfvToHOdAMtHqHIYb2B4sYJmldZSYd9TCRx7Rqp3vtHPYdYPs3AjpR/d1coloVDHyTL6R0y8599+G7PTViPo1bZgaOEo0sfenlhLWIMfvdkFvRQRG6I/bC/3rOkHV/lb9Kr00zdWBH2OjeNSQzRDL8T1U26eyLAaf/U4eCkvepDrk0mG6/4cRojSppw421eDtkeKhTLt31Avt5n44O6brEblsF7ombi0FoYLUZGrLW4kFR7wKh/iVHR0v6UbaMuqOq8bNeXkF+vIJORJdKlmbjgOU6BSIoxw3eq/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXJZdxhSlsqJtx9jAPcraa3fLqYN2DDuCp3oxj7AyNA=;
 b=rC15XTseEISW7+o+DxKcI662DylDM5qRvcdhNKCPDaVeUEjHozrAjskO0RtY5XOKBzWTcPtCn7WRvfTjfLu+Kzn1IsrP0YIv4d00Jz+zooZoHDDvaP6zLjzP7L7/xS8m5+r2zs/Df/Q9uLclKpKuaFBZSY7dD8RBdrVY6QD6MmB5hJWRTDF5zchD1cnFgnpn6NjaOhwcgXDfsbu7ysp8P4uYnU9wBQcTmVxCeOIk6SKxgGHfzomLWMC63O071OfIn28hDFSQnjwmzH0ly34iQCBEzrRhTF2wEzGgKD5BUC1DfGcqQBt44xnu55Od98V/PmlAN3CUcHm0cpiAKnW4IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8345.eurprd04.prod.outlook.com (2603:10a6:10:246::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 10:21:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Thu, 4 May 2023
 10:21:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 09/12] selftests: mptcp: check add_addr infos
Date: Thu,  4 May 2023 18:20:14 +0800
Message-Id: <57fbe2854d91e6fcbf7110a7ec0e2e15cae55b87.1683195386.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683195386.git.geliang.tang@suse.com>
References: <cover.1683195386.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b675b53-2541-4c03-c07e-08db4c894d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	duGmLW8SCZUzGLuO7Wc0h/wvdAKqVREYu+VF/hkWGPRP6PGhFgHq3D2ZGFy+PyPG7QgGDVJvzVlmZZtOqW6dKz5hsMWX6Ua86jc5R2Z1Bkm3AZw2tNYyTGpbAp7Ikxf3aRvNil8BoJEztkDIymrHB4F+NRtUxhzy5P06qM/u1j7yDHovqjYvQlwLtxJ4JSuNU1M3JrYe2frV77HRIHZCcl+86E6N2X2OVD08kYO+iNvZChsXvzmjCzSO5yn7h0jEgXi2xNzYd56PvjP3BR4AACPcNVvFIaq6vJAuzk/cLDrq7tO/DwwtQb1HFKgKlDCcHifF1gyN1p/a9cxyEZ1GzwxuGgscxUSOWjIGbKl2pxU2LuSj7PTDQL2JDvDAorZORINRwqQqRG3/yujoTKPS0A1W4iRuU+OzazZXijTseEVkHf8iH8w/SYMtEaMeARHiRslhll9SIrrX7RYzIZmLAwqXjhH9c5V8KKEUHzrKrk8zLgqEDbu2MWdoWeo11pDQDvnF97w5E3NB1JwJRGvH2Hhsq+/DIhgCuZvRuXmO2eYiRrvjVUlhmJ+zMrg7fBUa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(6666004)(38100700002)(478600001)(86362001)(107886003)(83380400001)(26005)(186003)(6506007)(6512007)(2616005)(36756003)(6486002)(5660300002)(41300700001)(8936002)(8676002)(44832011)(2906002)(66556008)(316002)(66946007)(66476007)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X/6VtrZCz4X7vkLNlB1HOpavb6jajZHMH/dEqQIaE/li/d+TTXRErdW4r5SU?=
 =?us-ascii?Q?ZmpzXgJzlv5aoh8CmLJoDRQtZXhBfn0mZK82iHDVThhOQEp5eSwT5AH1Ut0B?=
 =?us-ascii?Q?hBUNc3vCxi47vbCKDlydLHozUUnq6m1qIJ4ICYODtdZcrGDhvmARuZxtJO8c?=
 =?us-ascii?Q?Xnv9zDRNRWaUrRd0GTbOiu01jFJrzFujXodQnVq3UYWy2TDqdY8V9xfw6N8U?=
 =?us-ascii?Q?osy+29RrKqhKQPkDylZl5KWyUTXHceLkJyhC2uk6LF3i9DJxtETC5H9WWICM?=
 =?us-ascii?Q?tYjXYtukGE+05oIFqPBggH9gOHFufhRQjvJxX2PWUqDKGzd457ajctlBrLzf?=
 =?us-ascii?Q?Z8wWJdpytFlMg2ta8POolg6oCE0ruoqSLAkgHfVgsCfU80WOrOCWp0pMJO8J?=
 =?us-ascii?Q?9uuX41uee5hqkGCjmvlZ9sg/Klt3IRIQGTZIjtPBl9SvsSIlcMWGoXBpP4Fd?=
 =?us-ascii?Q?GpTkzs0pZQPZGGECvrZrA6LZj+/Ciu9psH+M5qYQ28BQOlkTThIzP2rx8+6Q?=
 =?us-ascii?Q?gBZ3y9kmEa7Vi54VR65qZ13LSzeH6vWzs+nCiHP0uP1QwaOPolNtSTX0Sgxp?=
 =?us-ascii?Q?hO3DGHLgA1f+0j8lT2UUsLGi2fHp5lHvCyXJ0L405FQGRuM8g+x4SW8AwH7H?=
 =?us-ascii?Q?AH/eb5Rg00t/aLRzT6nkdnuwkfaPOAg2m1yy8qS4gTn2vIvxYJkQA14rbfnX?=
 =?us-ascii?Q?/U987ZJRM/aybJB6urE2NvqMm82lUVzn4nz4D8wizTUeBvHrDd6ZNE67Wjt/?=
 =?us-ascii?Q?3LzBUfdXZWaBp1OLaLuVRxQ7Zcmsqej0NUyOkKAerAOiEKtskSyjPXKbXZEg?=
 =?us-ascii?Q?IUmkmAeGWr4/yWN0g1fmUDAvjAo28Q8Vbbv4q410SYTsWNAYqwWHlhgeaB8F?=
 =?us-ascii?Q?WI5dZMpNln457pppgOAyrgBiq07YSbO1NOEyvrLYnuF4quwkXHyoKyTtI6UB?=
 =?us-ascii?Q?jTyDdV4GnQA0p1uqvOM9L+EdCUe2gV5NCWB2TxZPsBuU5mYzdPuqjrYuWxhW?=
 =?us-ascii?Q?3azylox224MwN67gA4zoiHqzT2DBu967qeQQFK0UwTRmPXlYGlWpHsIAA4j3?=
 =?us-ascii?Q?J7Gt1qRum8CwqS+xVxdMNH0zNvp1cSzHvzFHHzpQqz84UFj5Ul3qscKU8f6k?=
 =?us-ascii?Q?C4pYaPmxvCXKcX32SUMVnXXyHPstOxsPq/e/ipKhbgwZXeUUtfGfCTyK575L?=
 =?us-ascii?Q?qnI5XHSQ3tuYNWL8Peq2l1B7QCWNQHrBlL5Jg4/EyIbPEzPIgT2AYz/IrpIz?=
 =?us-ascii?Q?NB3Zs6yjtVN4/nIOwPtdTazX7bR1KqFVuCAiAhQ07U+tHZBySDNwW8gDkCHi?=
 =?us-ascii?Q?JTi+a6qKRoSLZ1tfWBl4hn7IuMsMku+JORY54leaUko30WxzYN5jA8L51S3K?=
 =?us-ascii?Q?/sRCraLnNB9Qq2PyniSrp8VSDw3HHuf/1ixMs3VtQZ8P9GRDvinZ7JJvkrwK?=
 =?us-ascii?Q?8IUdLz73eaM5y0cMmTp13HEiQYjTJ4WaH8f8tOtcT6jNWPfyz8GCuFa/+Or+?=
 =?us-ascii?Q?tXOfbmgBRY6t8vXtPKtkHrg2APHjqZ+phiqMwsVze9qDg960NGyTlr00UVy1?=
 =?us-ascii?Q?5UF+zh6d37pHWSws38dlA8iaSPsPEW+mq+dtBgJW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b675b53-2541-4c03-c07e-08db4c894d76
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 10:21:19.8256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0M1qmQC7S/9HOKhOygZqwCA3AXgcJM+PGkxRRC/OMdDTDiNR7AGA5K/zlo/xgZ04CQtBpBXzdEgTSnT69Cqww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8345

This patch checks add_addr_signal and add_addr_accepted in
chk_mptcp_info(), and do this checks in userspace_tests()
and endpoint_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 ++++++++++++-------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 700e525750d6..52d569651485 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1707,13 +1707,17 @@ chk_subflow_nr()
 chk_mptcp_info()
 {
 	local nr_info=$1
-	local info
-	local cnt1
-	local cnt2
+	local info1 info2
+	local cnt1 cnt2
 	local dump_stats
 
 	if [[ $nr_info = "subflows_"* ]]; then
-		info="subflows"
+		info1="subflows"
+		info2="subflows"
+		nr_info=${nr_info:9}
+	elif [[ $nr_info = "add_addr_"* ]]; then
+		info1="add_addr_signal"
+		info2="add_addr_accepted"
 		nr_info=${nr_info:9}
 	else
 		echo "[fail] unsupported argument: $nr_info"
@@ -1721,16 +1725,16 @@ chk_mptcp_info()
 		return 1
 	fi
 
-	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
+	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info1:$info2=$nr_info"
 
-	cnt1=$(ss -N $ns1 -inmHM | grep "$info:" |
-		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt1=$(ss -N $ns1 -inmHM | grep "$info1:" |
+		sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
 	[ -z "$cnt1" ] && cnt1=0
-	cnt2=$(ss -N $ns2 -inmHM | grep "$info:" |
-		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt2=$(ss -N $ns2 -inmHM | grep "$info2:" |
+		sed -n 's/.*\('"$info2"':\)\([[:digit:]]*\).*$/\2/p;q')
 	[ -z "$cnt2" ] && cnt2=0
 	if [ "$cnt1" != "$nr_info" ] || [ "$cnt2" != "$nr_info" ]; then
-		echo "[fail] got $cnt1:$cnt2 $info expected $nr_info"
+		echo "[fail] got $cnt1:$cnt2 $info1:$info2 expected $nr_info"
 		fail_test
 		dump_stats=1
 	else
@@ -3110,6 +3114,7 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows_1
+		chk_mptcp_info add_addr_1
 		ip netns exec $ns1 ./pm_nl_ctl rem token $tk id $id
 		sp=$(grep "type:10" "$evts_ns1" |
 		     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
@@ -3169,6 +3174,7 @@ endpoint_tests()
 		pm_nl_check_endpoint 1 "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
 		chk_mptcp_info subflows_1
+		chk_mptcp_info add_addr_1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
 		pm_nl_check_endpoint 0 "ID change is prevented" \
-- 
2.35.3

