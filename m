Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7EF15D0
	for <mptcp@lists.linux.dev>; Sat,  6 May 2023 05:10:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPWpVVTMSD1FaY3UVGuHQEvQgL9YO/vi4Rg7NyknavTNSlr+AidlQCJMyAqCl23b8iQ/228XZZyS6C4JQsqHa3Dvat63CTJ7zPoqzkzgjzTHIPn+9oeI0hcRd2+lg/JzmhDuHy6LSNFcgj0GuTaPTNJjpMFHLa07fyo2riIbFVOlfzR+ahystIb8tkN3HsVCWtWLifqruC7gYwVZe5IfrOOCjYCZ2FHjnEtctr2SgkxxruR3eOQ9BqHGXRLpMQxqP8zX/a7ECTKNmDxFkO1bO6+UrTbMx8S8SpN/mLm4X7xzUGZiIhL0Css2VHtmCBPprHLkJ4qPFEPlCBzl90WBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHxRVx4G6/sP2bQN0oZhNUblBloHIh51YlqYgH8YN6U=;
 b=WjyYpXFOZwiFec8TKtyB4JoZ2hsffnJexZgWVmgCXsp2nkm49f6vlIBgtlTSWM5u7wHrTz6XUxVF/aHYj1AUdz4HzUuXU5iNEVyV7fXfbTkK5DPIm2wIDKOO1K7pFkm07BSTj482RQyYInrY8LvOzbZrXIRRcsVO+paU1YwoYFicKwtBingxqp9pQdkVK3drHew00+HKiBvw7d8/bOWKnODyPUkDUPnE+ep1XujQIH6WtdJmKgcgaS89rZfez/vmNM78fMNeHLtJ34gosKNJKRHHf4zHumpXHsYdva1qEkBvABuuNRqPtAS+Igxxz7O1lZmjV1DMwTsqdNDAfW/K2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHxRVx4G6/sP2bQN0oZhNUblBloHIh51YlqYgH8YN6U=;
 b=hWplFrd1/1dJsM5XcXF0aJymxXBWnqjO7wahVcBnRNZvbHQWngXf5wnnwKCnThSbesXGm2XtHSvijNrGxxv0XnjAYVsYxjW1ifqONW3gxLqF2SXiVDCuNpOeouLpla62R02VCUJt6x0VpBj06USA40Ef/0NsVjeuugCHyqEHneNNEw/zsVxEvrhZ7P0ZIftcfLXiF2MliFJVUf/KcfiGMkhx3NtAtJoW77gjLznWVXjKprt1qakdcVNKjsxZmq8w1q18WxUDSdwYXTh7DPQoFQB1Hb93lvo2s+az73VSVzmEUoa6k6bYCm6DlcjZUWK3q6W2mh9sA1q3uUc9rCACCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 05:09:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Sat, 6 May 2023
 05:09:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 09/12] selftests: mptcp: check add_addr infos
Date: Sat,  6 May 2023 13:08:57 +0800
Message-Id: <44a82b30ef051654208ff852923b37bd6b9e4c54.1683349666.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683349666.git.geliang.tang@suse.com>
References: <cover.1683349666.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e3232b-d3c5-4d6a-f5e5-08db4df02337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GmMi86rhcYyT6b0UtBeZbqORHGQyrtkl2867q6v/wg0OOWybHbcy/nkrTAYubWgvcjlykTVfqbUKtHlJDu17jzxjgkLO4PJ0n/+WjTA42lFKkwR/UUmDLZfh9GjfHEgwUCqcejvCjwxDEX0cILHDBMUDz6BnLpCEEQ3wRtgHmFDDLLhOHvAmprBJk7JmFiPCYIaGTrhIuO/KMIhFYAiOvKl5q5rAR7bqRlVSzai9Jz77N6DBBgQiMSIe58jWIPowSUPo8SZajaZ2AkI+9Qs7WjQxzw83+t+/JE9we6CiZbWkYN4SHGHeagdRxL4NU1TcpnB0ofeNk4O25IUDjyoLOFYJ8/Rrawy8xv4R8JObxqDaxetI2WCq4Lk4EGJJjTNcu71j88inJv37fdcAjpXPjiK705iOcyENga7k02lPAylimvW6WRrdCVGAil9LXwGrDtmNPDT8+07g8CZcSMetuyJTyZwqYMLjgANGigQQdtk9Hvh67zBYoUYYCdluepSrtwfAN8ZD/RVnTgB8g4+cv2aznI5zARJR+Pr4hy/VACRDkdNCFLKKz70ewkR2B1eM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(5660300002)(41300700001)(44832011)(66556008)(66946007)(66476007)(6916009)(2906002)(4326008)(8676002)(316002)(8936002)(478600001)(6486002)(83380400001)(107886003)(6512007)(6506007)(26005)(36756003)(86362001)(2616005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XS2YRu6cQf9PYqgYxXQjtpy2GFAdCpzuFY/89M9JcTCkFRX+BdBldxFxMOzZ?=
 =?us-ascii?Q?hXpGYtEFA0tdyshd+Vj4Ri6qW84T+eEzX0uYCl5lVSh2JqcEmySZYfETuyPf?=
 =?us-ascii?Q?qDgNibPSa77N5QNYq/T8IKoYMgsTah85B+hHv+142QsIyz4H5CA2kbfGgeYr?=
 =?us-ascii?Q?u14/6sTksSGDfNPeUpgzqT74gncD8zUk9J2YEeA+1Fv637OVAJmkfSBw311v?=
 =?us-ascii?Q?802SUHUKpvvyc38ug0fZPwAA8uNnqVw79YH9r2Ol8B+zTg9UA7PLcaL+3cU4?=
 =?us-ascii?Q?3jtg1cG/+gtbns0gwnB6VYrnHPhphqaYV0z04RFhj0yrzS7jo6/ArCCvC7vB?=
 =?us-ascii?Q?O9BGVVAKC4/EATR0L1ZosLrGJxp4O78i1MJqLLPun5Wjef1RBD7/kCj+jKAI?=
 =?us-ascii?Q?3l8+gIyIK0Uy43Dy0JTIyCpFV/ufhhlYLc12Hdk3wcqA5JV1WILDw1+3EESx?=
 =?us-ascii?Q?Kwa+ptcN72Nx7pQof9lKrxkXll63f4QhjfJ6mDAjV3PBc9t2hw2NZGibkavB?=
 =?us-ascii?Q?TEdh1mjaqeTEBnEJdeCvPt3rY6xu3Q84gLMvRjF6TZVPKbcCAmhPlyTBlzFG?=
 =?us-ascii?Q?xAFTpbIVOtuDidSch3psLiB6a6V3qWn5YaHbYOPzdzo5//8bT0iT8hrvr4M3?=
 =?us-ascii?Q?5BHlQ0WvsqAwAUqp+s6/6pm54FPYunQyJOcQSPl/SJyZuUbb74D3B9CBXasZ?=
 =?us-ascii?Q?TQllCg8MOo7PWJPe5GA1rVBs3jgJMlUZNzXZj4FpceC1qP/wbRc084EmcSFt?=
 =?us-ascii?Q?kAC3UlSWRftLUopTiwu8/OSd5iSM0waZwNCG9ISMolVoPZh80yfrqT8fa7UL?=
 =?us-ascii?Q?mh3zkv1EmiTYMV05USTxruSoF4bENR1C/f9Ybi75jdZjAwIp1Qg7O5PDcxn7?=
 =?us-ascii?Q?e2j8Y2mNla+t/R4zqSD1TLdiYlmu8n92gg6h+5hobvk+lvTd/z2ok/jNxf/W?=
 =?us-ascii?Q?GL524LkxP80JqPrzAEMvrtifVDNQegNKrsLbv7x48r1+nmfIgFv/miago5Uc?=
 =?us-ascii?Q?hIiDafKeX0pLRRYVl4WUl1iPEPDv0QEVsm6j1CXko2d40x+ha9sHwal0xnin?=
 =?us-ascii?Q?bIt/gW8+DiuGS7YLcwmrAwwbncmSvNxp7+d03t8P+6uX22g6W4j3LN1bJ7Cy?=
 =?us-ascii?Q?oo+0URYSm844nsHS1IBEea2CAhV8n+xIl895dQ5oYPMqLtEvLujRq22uh+8Y?=
 =?us-ascii?Q?P70gYY4EXkOF+07a8Lf8DFur6La336fVMMdVhnm0W+I7DdSWuXNw5m7yTQmy?=
 =?us-ascii?Q?yHOBttRgSdUwwYkHgbWH7TvOAtBmMTAhW42VIoRyi5nab3M+oIVRbXr9mwad?=
 =?us-ascii?Q?yN2qW+W/E5IO+Q8gUjkXSf+65KYSD6kZ+YvHf9P6YwphtpuTPS9/mR+QIXhn?=
 =?us-ascii?Q?itwBTc8DV5jgma7866yOwyQkGLuoq08h73zUw9I/2yX4kzn0eY9Ewgur1Ve0?=
 =?us-ascii?Q?0vADn1qSJ/2V795yj1ehuRaj4aRy/SKmOGp4pNKb99cN9sV63NRxwl8yh1T/?=
 =?us-ascii?Q?EDY9qsoKvzs1THN4JfB1rdVTX0pMjq36rfKQx/IfdjslVkzxfTmeIiiMd1BE?=
 =?us-ascii?Q?wg9y6/tSsfwoyrqGxX6DbMuiglE3M4tlMng4d57j?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e3232b-d3c5-4d6a-f5e5-08db4df02337
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 05:09:58.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQ7Nq1ajXwt9B+rgM3kA0FTspYLyzNQ4FwBFXguQZY8iiVoyiOujLS0h424u9MHnb3ODJVEJsqbF2GYRkJP83Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

This patch checks add_addr_signal and add_addr_accepted in
chk_mptcp_info(), and do this checks in userspace_tests()
and endpoint_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 ++++++++++++-------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e0ae26670809..2973a4ca0833 100755
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
@@ -3165,6 +3169,7 @@ userspace_tests()
 		chk_add_nr 1 1
 		sleep 0.5
 		chk_mptcp_info subflows_1
+		chk_mptcp_info add_addr_1
 		userspace_pm_rm_addr 10.0.2.1 10
 		wait_rm_addr $ns1 1
 		chk_rm_nr 1 1 invert
@@ -3206,6 +3211,7 @@ endpoint_tests()
 		pm_nl_check_endpoint 1 "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
 		chk_mptcp_info subflows_1
+		chk_mptcp_info add_addr_1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
 		pm_nl_check_endpoint 0 "ID change is prevented" \
-- 
2.35.3

