Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2072.outbound.protection.outlook.com [40.107.8.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C181125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIsWpWUm5ZFe6/83HqvvY0iB+2NAnJSj0+yAqvFWcC+TrKa1AI630KTIWvJKvftBjtjsLXT0dyA7QLURmy/0Yji6PbG+GwOuPb8G8t4pnFv3IZkVrx89QfkhLnUIo85RsGecqnw9He/8XVta53+Zp0KPZe4oIk08glBeD1eniJN2hlCackAKLOZpQYlkz5zKhmUEH8gXY/2w1w806+B4j9YX1xjqfkvsNp+AQbx2naTPlmm3DROdRIg+7kMUR20jNRAw6UBwgzJ4lBd/N9pMJo0wDHLtvcAYNRIn9ZmLUlZ/EpXnJV90rbKfDczqodHMW4AzWjuoifVlxekKAjYS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJMYVcUnJHOmrvVRb6sHxKxtGacHjISedN79M97i4GQ=;
 b=c92RfGNPjzOm5ZCfzPOdjRU3kNsNJPJEcYu0dexxA1JEN5+DT09vx3vgH0NeNurICceg8EZvHzf7/mcb4jv3kB9Kwr8avssQRMDV1eX2dyzOpVDoxrHhuGSGajJIjblTnZqPcSzLO+uKwqgnoKaWqTztKkUC1KMlPrjtaq/Uh0DreGsyBz3uRscpf5jo4ZFaOWqEHP5WUUf0+cHXhErt4fkCsOnCcB9tOfAjeviI5OkRL4R/VDgdZHQ1Vnl39Yga5tEN1Hu1GP0QyuSmdQ2pQ8gWHD+Vqev2BjjO1y848oQXE16RHa9vCQTTH04bwX/ftnRTHR0TCgyB6s2KXDBf4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJMYVcUnJHOmrvVRb6sHxKxtGacHjISedN79M97i4GQ=;
 b=F+zVGsLCN9BtTYnhLf1EpJNQ/s7ShxL6BN/zmIA6k1fMu8Gec3Kxo/3w2WapPf211xPPDUht+vcsV+9ym8g1F8fjRcbhTXO902XUESPOliCDcGNrgOqAwKx/tq6x9l+LNjGj/fw2yc3T7v239JHrlAmPJ1TexvKhur6ABFxZq9LmA+wJQOko8x/TQY1+/B/crXMvFGnOk9jCY3MR83JIsIg4RjHNCPAgRwxFk4ChVtUmtyRvb+P79lJhw0fruXYItxyMPNi2sCUu0P2Q2V7bO8FaM+rXafJL+SJ7n4dZaDi/91Jv+iuLAeDSf26cAy1ZomlJn2jQEqNQvXxvHTy0cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:44:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:44:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 23/29] selftests: mptcp: userspace: print colored results
Date: Mon, 25 Sep 2023 16:42:02 +0800
Message-Id: <47eeac58e9e21a389d29c74a4acb467798af65ae.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0208.apcprd04.prod.outlook.com
 (2603:1096:4:187::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa9d5a8-9dc9-46a8-a557-08dbbda39ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	empt6AE2WXUUbNqU98i4H/ScxMXNlvfDExZIOQn/vIsx68OjR5mWhAgk95MuIuWZqGJrLI/iXfsW8Zz6zsTyuHp0rqe8Qx8ez53CuDF3kh8vvCGMaiIN414KH6rVHscajigBxDLkjB/MXLB72MRX1qE08TUj+LAA5FVtIZsXNg9UsnQ8lUujZunsNN75wsmoiSF1IO/oTm/ZGN5KezTXr7Z1GLabaHVJOmLOYfMFMoDA2yETI4MWteQnv9s98rJ86RmPzVKklyf6csaVuQirKC5BnCRfzTmFAPcwy2aLDsfw9P/p3e0OS1n8HYidWNszXllED8w/jT/zoMvUiqUVUTOmt3HqM8KTQQYTKC/zBabxlfHgy9o3ZCNxF5Luzh/tmiMuGjL7/T1tpmVhiv6FJqLeMXpzAFh0WBEmAv9mqbYBUnCv86umL94AQqvW0zC+hTt29n8nGJzh1vZ9HbOGwgXdt9HkqKnJGCrCUkXThhj2D2MuogkgArPa+rvIwpKGnVVrNt2R3vcXpuvhY4nAQ86D11R4wtadK1l1tdMQJ8QHWaWpmklrh4BMD/Ky6rC2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6486002)(6666004)(6506007)(83380400001)(86362001)(38100700002)(36756003)(107886003)(2616005)(26005)(44832011)(2906002)(8936002)(8676002)(4326008)(41300700001)(66556008)(66946007)(6916009)(316002)(66476007)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZGZZNJ6ws5wR1TvX21wd3aanYeF0JJkpMsFHarc8KsBHAA4PSlcytyFu4wRK?=
 =?us-ascii?Q?/0DdoB7r8iL6wirgtUZK951MgauqHJXNcrA41JzMkvquWWt9sN96gODGC9db?=
 =?us-ascii?Q?dixjnQNlTgnkkoT4nRNcKTpzRxAwvkqNmo8D9Wz0w5Z+hmcppqTX7pDq7MdK?=
 =?us-ascii?Q?4yf0o4NPtMJSjM9UR5u8hvYpGQR65dK9qZZURIKsh+hg28qNXwxwB3j3Ceiu?=
 =?us-ascii?Q?CZPL9doXAO4pdulnTtTrmhLOJ1APQA71af9WzESBoAHRElOnn4CHQoSyXnKI?=
 =?us-ascii?Q?85Uvt16GALlYaLmDC//bXQy9dqZ6hvkBT77rjECyGkfEQXQ5VWLNLrHZ+d+M?=
 =?us-ascii?Q?VAtPxFqZIS/DcLKHkGQ0ug+yzwuZZa3zxKeeEBBKCXGKKH1mHQqNfadrxwqa?=
 =?us-ascii?Q?KfMaSunJKXPOzS8yGgY51o/fTjylnAx4w6ZRV22jQp4ax5HRHP0+9dPy3ce5?=
 =?us-ascii?Q?iyV7WjbhJdWbszJwIHL6rhUkFTSjvmWBkTEXUECpeSGaDKH1B4PAbWqKvN3X?=
 =?us-ascii?Q?QpqzJzTAthkjmdY3GJ6HoybMWan3tMz2MP16EMd76SvMHgz5hR20SNdj8Xfd?=
 =?us-ascii?Q?Wv9p1WpCNbU/t8IL7dlfuH499rwBQpf7ls0nP2J3cE65drI0XXMAZHIujmIs?=
 =?us-ascii?Q?Hi01VgsR1PLZdhx5TtJ6hBj2D1PMNu+yqW8HT78NvbIrw1S5gvc5W+6aIAbI?=
 =?us-ascii?Q?jxnL0+Lg7uSLrdmtwizIgjIaOW12DhipU94/pu/ZVMBpa4DENsuoTBUK+D7O?=
 =?us-ascii?Q?2sicZSLnYRh5M4iDUXxrq9mXUUqIa8BHH4z+8tqMZPFUGlHWCA6dG9+mJXT0?=
 =?us-ascii?Q?gPwaQUWxur46SI2IuA+E8dUnNLSGzLa7ZZCZ3Nr+iD9XDrOytgGjBRMWyNfx?=
 =?us-ascii?Q?mQQ02wObkWRZTV9FphuXfo8WSkzIt+A4aAUbSrwyHRfNzWx3yPs88LAD1T5X?=
 =?us-ascii?Q?gfDNcgRfhBo9bpQDpd37Pr65zy2qAIAMHJBemRqEQ3RWlEDg2MeuzH4VtoQh?=
 =?us-ascii?Q?umc8yEP9sUi91cHMZ+ti1txi2T1ZlpjSli2JJbf+LhjdAX54HFYauSPYTdpn?=
 =?us-ascii?Q?I2C4iwNnaWmel+SxTLIE+I/mQJcfSGRy7OHqmNw217h7BYGh1Bzxd03FBxGv?=
 =?us-ascii?Q?C+JNCv6e72Xxy31dEXcA1pGpBWcOCKY5rzStbwwnPpPVmQa+Ep8h/5lUpgVi?=
 =?us-ascii?Q?GKHLD4blgy/TPjqxEcwELM5wqGGPQZBkBnogk747BYzcMvMNnMXnnxD5NW+k?=
 =?us-ascii?Q?A22OVDrxk6ykOS2FTLPLCL6dQrxJxsc/ey4nW7Q+stD+DaF6s05z3XeAMkLo?=
 =?us-ascii?Q?XfkcbTtTERmt9N+VSqxOiwYTzV2vwVQ++KARsKjD4ONfuZN9VyKMosIKFOCM?=
 =?us-ascii?Q?/rgHT8nYs/m38m56dBdKzSMHMN9rcKV/mdU8i6BBCBU7N1Y+e17FyWfpAaQ9?=
 =?us-ascii?Q?lpSxnDGedo7l8OSS/z2SROymyDg05EXGC11Qhp5AcErgzdHXmV03UEpUoLiN?=
 =?us-ascii?Q?yKIAU5gGAf1DaxN7kIVVPyBaTaPMVxVX4adOMWv1dlsTlw+c5HV3ucYl6xtf?=
 =?us-ascii?Q?e7zl78CnKanmESZiNtJbN8V+Jm7UEYwH6Fkduv6V?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa9d5a8-9dc9-46a8-a557-08dbbda39ca5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:44:21.0702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9RvzhS0qVPQn3w+ySith6n7EJI4dVO7ndJWW7F/jhgLSJzVhW4rhSJffLF3GOiJbynJHaqq0vTsVkA9J6ULnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8510

Use mptcp_lib_print_ok(), _warn() and _err() to instead print_results() in
test_pass(), _skip() and _fail() in userspace_pm.sh to print test
results with colors.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 640273d4d7a1..84a77ee3b633 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -73,27 +73,22 @@ print_test()
 	_printf "%-63s" "${test_name}"
 }
 
-print_results()
-{
-	_printf "[%s]\n" "${1}"
-}
-
 test_pass()
 {
-	print_results " OK "
+	mptcp_lib_print_ok "[ ok ]${1:+ ${*}}"
 	mptcp_lib_result_pass "${test_name}"
 }
 
 test_skip()
 {
-	print_results "SKIP"
+	mptcp_lib_print_warn "[skip]${1:+ ${*}}"
 	mptcp_lib_result_skip "${test_name}"
 }
 
 # $1: msg
 test_fail()
 {
-	print_results "FAIL"
+	mptcp_lib_print_err "[fail]${1:+ ${*}}"
 	ret=1
 
 	if [ -n "${1}" ]; then
-- 
2.35.3

