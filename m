Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2088.outbound.protection.outlook.com [40.107.13.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D971C01
	for <mptcp@lists.linux.dev>; Fri, 25 Aug 2023 07:29:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vw2BUpDDcbarJGiJzE2U+FdvglFaSptZ5Zn+jLfP74j03B34z4D9lBfyuI0tJzgtgiI9LvqhrxNitXa9O2R3mvrGFK4SaD+MniqL6dGCJB5OX73LmzgLxR2lTQX+ZU3iZxC5TqpjInP5Mzphy5Lqd2kyOWQ6HdzgQbpTi88QBppU3tGSeDcs0TLfsHo3oA6+UORxVNDG0Grh8A8TWXjjZILLxLWOjXAu01yUAGQyTbZpw+xCaaEbXtb2+7ufmjM6noo7YieWUkqiGGRvl2yBGeiNxxz9MbLjQyM9v96c2JAarfVbMBbE34Vt5pF7rA2Pc08PUk5OnQdTo8RDwTs2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrulqtRDN5l4XE9JP5NzbRDKOYPlY0sh32nA9w/ogVg=;
 b=HXy+MlvIWtRiisQBwmPU8iu7GM7hNehki7BbKRkSpMD3434Boq/qynYndkJ5Pk6Ggyphf1i5PcGuxXL/2grcW2CvmqnecuBIUEC6NUoC+fR2eM0hPrm6FVazSo/6cnMclg2DE7jYbJ3xKHiPvl8ueU4Duz4HE813chLE67a1OeHUwzUn2Ow4BrusI7JHydY1WshoctsltGqYfwOFk7aaq7sKS8uiq2Y3Dcxtgw7H8xQY7uzJLwX538yy1TrUWOG37umxqYBsAF7ZzI4c02Ol2HGhoF5/qKBWLQWeVvkl/bYazid8JaPjPDxJcpj7arbZH+WHJlokCppmoT14kQloYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrulqtRDN5l4XE9JP5NzbRDKOYPlY0sh32nA9w/ogVg=;
 b=FYmX4BaMo2en+4wNGZEcvb5t6Kxudtt83QuXg0LkXj2gzDpSFcexLxwU9XwPXBqMY3yOARkxoPe/OmTz2D2mQhSMFJMn3hh1kAbTDBiT8n/fp2NpaRiApqQ578exT4wwLdR8GlJmqbTTR6B8cxVKbqrhbGIZNmmbGLSbuNdtfowSkT6R5sCcE5WJd5X5q2Pl/s+/dfMmC7+kUjBToHIIGueSczmNBtNyznXEzPRS2GAjTCqPyWVR6JLPwUAK9uIQj+L5/UXr36DgtvO9jfp1ZfLokwXYxLrmiYK/qjqFqvUvBH+otoQlnXL/t8y3IY5T20L7KfQ7U5fk/8KspDa4WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9560.eurprd04.prod.outlook.com (2603:10a6:20b:470::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 07:29:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 07:29:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: userspace pm create id 0 subflow"
Date: Fri, 25 Aug 2023 15:30:13 +0800
Message-Id: <4903c6b26eee24ea8f179f0fda215cc03b3a58ab.1692948580.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:403:a::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9560:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f540f1-6970-4dbb-9410-08dba53d0f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UsF9OnZ4BrAzKIp8em4CZv3gg1eL2/5nqZ6V/g5c9Sc7A5Z9JN4N1xwQCxcuY89yQ1rQSzJmoTk9uEWxZ9QDTn0NY6bREhUDHS0k49KhmpPaC6qMlWxBAQ73ajUFUnJi2P8+PGflQPM6J2r7jI1saRqBJpxM99JNSsk9Z7T+QoROi4QEwSltkwuaMd6AqLrr34KLd49A6yuC3ZiFCnWOzr+spmcpimMSnKoCFsQ61JtCOh6oOjMykDyeHYPqN8I9TKKSsT1Znm9+i09wtIFUj4VN2zXfSlLEE8E2Kape4AVEqA3Nbyzuq104J+Vz7+5mr/7FSZRJPZ5fCN/v9tkfrg4DnjHlGdwSS4Jg26AAPPxUYjN6JQ8VmXBLihAiO8lO5v0iZvZDS+6GLM2VgCWLagh/trAuH8K8ULaZaWZhPLj5pq+L5Rqnk1aZ1weBazepkdMIh9+wx43ZpOVH32M09K0gw/NyiKrwO9zggMeHsMxs0TpUuV3MFryfqsLUuZOM8qkQHpH/cZPobja0oOZy5CnuPv9hSwQTNHC4NI3spoJHYUAnIYWk1eL9gvDkEHI+1rN+RJ/EFkj/YbUv5YWRzg6bnhiSNdAAexCIeys9Y4E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(44832011)(83380400001)(6512007)(26005)(478600001)(2616005)(5660300002)(107886003)(4744005)(2906002)(8936002)(4326008)(8676002)(38100700002)(66476007)(66556008)(66946007)(6916009)(86362001)(41300700001)(6506007)(6486002)(36756003)(6666004)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G2/Ednzkjz0A5x87knHBngL23eeypMxEEztZG58kR0jwZvpZrY55+fu3noHO?=
 =?us-ascii?Q?Zxq4Heg0MoUcnjpZhHR1TvKRrqsAoV7HOCNGskS8Hr5EWuRoyfNKIRbaurBb?=
 =?us-ascii?Q?IESmnxwQ2LhbQCxx1XTdw8aFhl1l6cOPibsJyP4o8lVwjPzx1n3Y8Tvamsy/?=
 =?us-ascii?Q?5DWpyWanTzQatc/VMVsXIod+xp11XWhxv3wFs6IzoNHbAzGn+vZWIqN8nSU1?=
 =?us-ascii?Q?A67yRKZzrmnQvi7BG0iq07be+Bjs67nd67W8WKkYQ5SdEPbhTexqILfEa+WN?=
 =?us-ascii?Q?q7l/31hT8kdIdd8S02krg61GFh03vCDP3Zvbc4l23J7DTZlq79MGkZ04Td68?=
 =?us-ascii?Q?D63k0VMv2F1fVg3xxXNV4gpujIFrGhaGl+BH/1PHZbiLE8w5S7oCkAbBUgJB?=
 =?us-ascii?Q?hVoB4keC+uNDc/qtN8JVblYY5bB6rx+X63ecbINZZVphxvOn4/mELAMsGnbB?=
 =?us-ascii?Q?KSezJjMw2dA7U9nCNkxRXSfWPWdEJLyZViNaLDv66CyreGiGVipvpBeBLyjz?=
 =?us-ascii?Q?DSV/iajG60A6cfYJ5JEXHlmDW1TDWmoVE8eF9Qc7eJp18X2dQFy4tUqhX3t5?=
 =?us-ascii?Q?NUEHh/VZLf1i+fE2RGv8L9ZWygiomI9XDYfLTmxMhsTPIHGJzuAqCEYXviQo?=
 =?us-ascii?Q?T8YhcYFxfq981yVSGbXL9qewJJLgzAyaHBjF7XQk53MkhF7GuqbNJniFyrKG?=
 =?us-ascii?Q?7Phbm1kQlN5sVC82Ew8sGDmAp8wz24Qii6XQQ29xwwgFSIIP+Mz06/xsGx6B?=
 =?us-ascii?Q?aMm9fxuHeSIZVxnY1OpqQ2IyoLBe4OfE9Sl2XqDwu46zEAUF/2OF97NRE2m1?=
 =?us-ascii?Q?cyfKugMhXA5Uo4zfIbVldyF48KZ9eSUEqYgMrMPmMoHmlkdp56DRvz7dKLzS?=
 =?us-ascii?Q?mRZFvyH/GgjIS5iFVDSTXiJGaPDP1xWH26z5PHDH6k2djslPEC81nWPdEsUs?=
 =?us-ascii?Q?6dzIoNTNtLAVUgJgqEwpgv4TmEubgkldkP1u3ElEwjaSDIOQq/5JjUaYjPq9?=
 =?us-ascii?Q?GwFsm5f+87vuhNxWNhJXAXBlzHllfhS7XCKjKv+CKHrqYuR5FtPZeNxi5a5r?=
 =?us-ascii?Q?ENLE/E076diP0+8q/Hli+MMDaZ/86WVs02u7WHjtiK3tmGJ1srcVSLn1jObg?=
 =?us-ascii?Q?bEt4gN+s1zLXg8OYGBhkMJW/FrlS1aC+GeOsLH/w02Fjd/7OdMKU5lYFiD+2?=
 =?us-ascii?Q?1yb7ZSDBjEhsd3fuJcVhkGYHTRMO5+on5I11HR7rSiOVv7HvS5FCLXrEi6Nw?=
 =?us-ascii?Q?lJEugG1VT8HHvD6h4y0gcsu+cfYJmivhLkiXMmGfoka2cEJmvis+SQWxEVGw?=
 =?us-ascii?Q?GR+KFhhF5ukDjIS3UidvtMfYWO6LCbh4Up2L7rRVLhZM+74W/1KkV9HNIvqi?=
 =?us-ascii?Q?OGwR4hwmrMmDReTe39BUiLxxUYxXyf2qnehl9dksxC/W3p9nHSubGUn6qxIc?=
 =?us-ascii?Q?8SnmFq7U8Qz3Bqjo9QM7OJHMbQBmMACY8SIF3dR8l2tsMj8XtSoeGOkaVrNB?=
 =?us-ascii?Q?Qj/I9ueYWgAsyokUg+iJCEP20EWMQF2t4qte2sL5flGU8dZhmmKjNCrBHElg?=
 =?us-ascii?Q?adYxGmyhTMkSLV50DQdnhINm268Edh/Y7HK45gPt?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f540f1-6970-4dbb-9410-08dba53d0f59
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 07:29:47.4990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPAy1v63gPqyk+Db5LP2bJHm6KZKqTiJbXtwP6kbJkpeawUzla/U7CRlh/0N885s/kuK5lNAh3rF6LhFFidCng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9560

Fix "userspace pm create id 0 subflow" test failure reported by CI.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9862a27da487..42a81d1bc0f0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3472,7 +3472,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		speed=slow \
+		speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns2
-- 
2.35.3

