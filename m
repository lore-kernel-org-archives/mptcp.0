Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB09710EA
	for <mptcp@lists.linux.dev>; Mon, 15 May 2023 02:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mx8MN3j6b9rSyY4LYN6RtZPnZWI3OYB+8DkEXMZAgmQGpjPJ+lusBpGA8Eui5FZpq8cJBSHKE6sdAH9XObXiLJSjtNWtnSFn/V5INSdeY+YMCF/k0MbNnF+TTCkaqww32stuT/Mv1EVTnnoQ73C4k/py1S6VfMMoXqDkrOhhK1vobhBVt4geDxbHjd8YqFimVW7BhPEU5Bd1G+hiiRq4pJgGzTYNRB7LCccdfkag9xA5141XsiSD2flSiBEzkGo3DVcEkSq9gQ7e8g+LAe74G+6Ou0UGMSuIL5x17IE7oynSonQqmTZRjBLH1lIdlFRZNZGHumxaDxLZQhoOuVzdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8O/iYORdGCi4eN/Wy/C+I0a9T965+KcWYpWZuZmYok=;
 b=Mm5F3aMjaGMXl+0uuB32Cjum1fGUe/KAnE1pKPBluwjpU0NCnHotyIBAuygEH+H1twiEBwHmE4Y10Rg0wGg+LojmZRU9w0Tbx7MDkrYsYxtLiuajQasJdQ3m5uFyTFGWzXlsYp4bzjVa7v2KmOgTdWsZaxv1LFBIdc+ZY/25yYX7jzZB0jpFBmJsl6IxPWcmP7Pst7DWrhFGU9M7XFtuAB9wx84hNc9Aj5RPORuoyCXK1UKtk0nBUNzSifY2q6TqYkB+uKnpd2/au27mZgShCv8f8NZz2CPHHOwyrK4sBdzBuzII6igAoN6nmPszR1ABPwbM0k55yw0gbm1GO1iVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8O/iYORdGCi4eN/Wy/C+I0a9T965+KcWYpWZuZmYok=;
 b=ILNvGblguYedmz3i35lIsouQrrM4WNypky2BPxjMtLFffA6paBCS/j3GzJMkVOBfcJPv2SwsNFCcytW5lOiH4kkLe7ZTUoNHbWwrR4vP0ACkeq0MjNVtoS1GZBDKUiudINMFNvG3br7sAkB6MTHYZOQeLDKRlw46MfuibT/H6jDtNNrEQgOGYczg0CKS/GcXcsv0YqZtlZEro38Uq57TWIfzmmNosBsZsyHBYkNH0SYHOjLfs9xt+Nf3IwbPIrvO5XIVOlO98nuLwz+aVh2GriNsu9OoJ1n/yqpnFG7fTt/svlBG2XBaLIJuTYoWqWfdZrrMM8B3B2KABthnvh4kQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9361.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 02:12:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Mon, 15 May 2023
 02:12:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 4/7] selftests: mptcp: check add_addr infos
Date: Mon, 15 May 2023 10:10:55 +0800
Message-Id: <9e205d5cb37fef98cf6434bda295e845155102cb.1684116357.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684116357.git.geliang.tang@suse.com>
References: <cover.1684116357.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:404:15::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9361:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9d941c-20d2-49c5-76d7-08db54e9c4c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H7YIcN9mYVEMHVUTh/RNc2MYnX80+TJ6GJTj3TnbouP3DtnpcWWSCEE4LSi7PZ5bTKHtbrQt9W2qwwXw4pUFkUnCLF7DeYWmW+JYaChn94NC2gR3bydt0EH5QXDXLvlSoqUW+xvUUsRtrDMPW8VOyQGRHJYC3o9+u1BgRUCKlPKpC77v/wjr3yuXwUX+MXq2jNeiJNRdr62wlo8e7kv65+zgaSG/FJvj8BdZnzOkcxBbw4FNHDiwFSEhIQ5uBwlQrR/KWKg9/6DUZMOV9aNUG+kWWCvcRR1tBHJAKDyTL9V9ZjUb9jLmZK8gyVUelCqUTd1V51gVLWNux6COQbHoq6ZietqoAFTKEaImRDGUaR311ckCVH2kFuKJOKtKQNplbtAW+V3mrXDzJZnY1C2DuJPJKOc+8orGKzGfDzl+FO80MRA4gpU9eljO6R/o2VxkTtgls2uknnLeTApR1e2usnCi4MpZwQtb1UStQ/WaVBKcqHw4qWHwqtp3Tp0Evjvsb84LJYfumaXCmP/dRMcHTRHpFUvizEnJjA1CVDuG+Lx9zx3WaFHHZMDmF4rQSSVh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(26005)(6486002)(6512007)(6506007)(107886003)(478600001)(6666004)(186003)(5660300002)(44832011)(86362001)(8676002)(8936002)(2906002)(36756003)(41300700001)(4326008)(6916009)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uvV9utOCu8cZQIfTLWxRY4sTZOhtmbP5aYvXyT9Ukk3jhwlDAltzDHurLw6K?=
 =?us-ascii?Q?VY8bWC8UYkWjmc+KWCqv7Qvq9gf567cLVznFplqsbNwpf0TSP3mJlTyatNUB?=
 =?us-ascii?Q?vnaX8GP2xnuHC6SZjMcpMyl8Jx8NL+1F4KOGB6+fLR0Lx3rAfHm47WN1E2UH?=
 =?us-ascii?Q?KdLLxftYtOrMqGe/D7m3/JtsdS0O7liPDS9QrU85MWRB/mTWlS6fdhgmt6hG?=
 =?us-ascii?Q?tpRcO9KuXXUEG8Eq8krQwz8oCfzcVuBDpQTTX0XQXDXWjUO1RpwitM1vfwSc?=
 =?us-ascii?Q?CWlVwRJH4QpFvLxEoKrHDHiqSrb3cvvwt9yz1KYU/DHsLWbqeSaFWGBioCi3?=
 =?us-ascii?Q?v6LCOwcG2qvLPxoEOov8Kb2y7siVlGq85WVb0CwvD3eA9d+H0VeFgIGFDhaF?=
 =?us-ascii?Q?w2Cwbka2jsQ7mYJWUe03KkqVA6K4VA9qhCoGOgakaKxX6hddDabdAc42aDpF?=
 =?us-ascii?Q?lAcgCUK4s0HcnbL5bobQ478Y5frWigi/O2pv5dNWschizIHr7oaWG6dxMNje?=
 =?us-ascii?Q?Gbi86Bmucmz/bFI8eKly8qr/X8Jn0bGmPo5kCwcBv+BNtMWrt08V4zP1AaXa?=
 =?us-ascii?Q?68w+SQx1I+Wl8oW05zWBcZOnYozuGHUCgzP58nFnu/xoeY61zWN79mEvwLOI?=
 =?us-ascii?Q?6CAXYSmSvvfnO1DJAdGyJKC3qrJ6bTHkga5r4EV3URYe1Mmc6X2MhCStV8tS?=
 =?us-ascii?Q?GHVeK+zzCk8Abkbnkg8zuvOzG4/2O6VN3umApXX6g3IaCc0hGQA5rj2vWE+3?=
 =?us-ascii?Q?Yr5orhs3n0BKpt/VZVoXfLhdgTePMXQKomPqI56eniPdz9LwF9uqDHnzRIg8?=
 =?us-ascii?Q?W5edSphJrD8klPjIjQ5Zxurhhg5dH3SOx0jOrtVFA2upXJls7aBfZdTqEioK?=
 =?us-ascii?Q?AC422tMYdB+UGtal1ADdBmoi3yq2AmiVRAy9QWgQrz2hnlDmaOYfFwVCKPmP?=
 =?us-ascii?Q?x8kPAeABfZ9dKP+spTT7ZmS3w8WnpNM8yrvKfgq9k6SE6m8PV79iV9TF03PW?=
 =?us-ascii?Q?YckjSoUKhd3eQ/YLkxEyqoS+MEtcRkjUuBvCxl+hk2Dm95Pd5cFOePj+FFCi?=
 =?us-ascii?Q?xGS77NT8Wo8aDjzGbMXXXOui5kcQve+DUgvI6clyLKdrGHyXRz+Bte+fOHLN?=
 =?us-ascii?Q?ppYBCEdPCrj+AHAym6lI+4oJGy9FPSoo+o2+7y+z8J3t6DcTihWnheLhMqgG?=
 =?us-ascii?Q?+NTpy3/rmc3IoXS1iGh9P7d8zQKx0mIMEZ3g7Cq/biDwrlLLxwhSjbq0wza7?=
 =?us-ascii?Q?e7887vn++g6gtmgXfF4he7bfbsQLsVOAMBq71xfz4/D6YPKUv7Km8tES8RXK?=
 =?us-ascii?Q?FP7AeJ+Mk69DI7r6WCsGSYpLk0PftBFDUf/2zvuVRLP2j6UtWHT1kg7Egv+X?=
 =?us-ascii?Q?w1YIRA6VgqF25HplQ0TZ6sm/EgLpP36+GANeCzBprV4abMbflCSua7jQDlh8?=
 =?us-ascii?Q?xXT79dUHzeJK5Rd4GebLaS95EAPLMvjSRbdkmOf1bAdQD222Rdvwq+twePb/?=
 =?us-ascii?Q?ozIsHl6blpJMBKqRBROw3YSRhMjxdwNSf20mkfCz7y8Bt0aqX6890Q6Th5R/?=
 =?us-ascii?Q?HHLVcwU/ZPIuXZNSoY1hjPFKfdyOR/QHbxJV7gBX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9d941c-20d2-49c5-76d7-08db54e9c4c9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 02:12:01.2611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXAVOgWr9CxK5l7GqIS09JVxlD/vg7u70i61AcMfnbkrJb+I8rv3XYd24vIBXjefmufiTmdjI+nbzQOTKU6GWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9361

This patch checks add_addr_signal and add_addr_accepted in
chk_mptcp_info(), and do this checks in userspace_tests()
and endpoint_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 ++++++++++++-------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0e8124290c7a..d8404d1354b7 100755
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
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows_1
+		chk_mptcp_info add_addr_1
 		userspace_pm_rm_addr 10.0.2.1 10
 		wait_rm_addr $ns1 1
 		chk_rm_nr 1 1 invert
@@ -3205,6 +3210,7 @@ endpoint_tests()
 		pm_nl_check_endpoint 1 "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
 		chk_mptcp_info subflows_1
+		chk_mptcp_info add_addr_1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
 		pm_nl_check_endpoint 0 "ID change is prevented" \
-- 
2.35.3

