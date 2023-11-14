Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37641D527
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UNUdWqPE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auup1p8D751wgpgOqFa++Vp7r7iVAyQFqHwUnIL3eEvpHD8xq4FBMCXqRAWI96jjirxiAmpuoe88GWPYXe3cD0SbhqnDnyZH2l8c8kx57JawGoulROvbZEdCV9PJeqmAaOrVIPRHccrqLVawijBkBkkL3165NRIl7Nm5MrEQnM5ZZwZuz+NEIcmoNTKJTkbTNQ4N1VLUNwG+xd0GZqfipV/klak6rv5mtQDEfQa5qGKFDrIvpVn7JQU8YqHO0tX7shkr3eRySCw3Xjjb3si/6HPzvaMB6LO73KU6YcLoc+aqQswWai2z7GpOAfotFVp0GBQ4qOZjoqoBPJ/HbGBozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ca9nzGNUs6xZshM8KaLRmTPcxbkcV0AALdy6q4A8aC0=;
 b=i5ZGJ4VFljaLCW73FiLBhnUzTf/flv31dKsBpdnyTSMgZtCtEJDH4FRlffaG23CkL3Ql2RjGJ0RWCmL3G3yPSaz8D6jVcwXjZ/cNFF43m9siRdiojG+x8oS60ElCYmjgXNUdw3FQqvNVPKszW23fA72buT/heW8VRxrVoXqExA9VMCtqHJDCIyce7WjRzg5rhKedB10tZt73hfttnalZRIWz6qj9LLv5wEXSZyUsu8OTJaPFkoKhp0kdgH8PxgRyfe52MINjjaDm4b7Oypy8ox+V5DD8ORR55icizefA49bjd3LiekbauYg4bN4kF0LVhFsIB419Y3vYdAGBnzC7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ca9nzGNUs6xZshM8KaLRmTPcxbkcV0AALdy6q4A8aC0=;
 b=UNUdWqPE1d3FdR+0pKz+CizM4+2xediSnNrSGDeRLX+Y/ninKqmxXb0CrbA/qxjKKMdQSRj2vzovuBMWcpNW9IjPx6dFKHjvy6fWU28VHDGlkt8yvo2yCM2l6Rf33RHuoZ6FajGQ9zld2foJYP3iS0nXfozi51QEi9pM01R7PfnL2+R6LIuIqC8QXWtLGMYQwn+kBEcZ3MzOyEpgL4LLEYf60F+Uh8DGDZBqqLXr/7H0VfxqvKcDPnn8qE+yPhXiix6EwwN0CiZRIAJgUJCRrFzY6dKcNWvvQQ2B1oxaPg2gSGpR0AtYiYIswEatYJdeRFupZV2c/RcdNGt/bagH1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8896.eurprd04.prod.outlook.com (2603:10a6:102:20f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:24:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:24:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 24/33] selftests: mptcp: userspace: print out test counter
Date: Tue, 14 Nov 2023 18:21:54 +0800
Message-Id: <6fc13e8956dbfebf53040cce1725856358129d15.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 480407b3-e815-4b6b-5b79-08dbe4fbdf2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cGfiAJrDXhAhbS8goNthMb74RuNd49TKDk2ethYuSVK0N6pv5W3CbMb50hM3whFtaKBz/txlyYLvs5gPrqD7o6Bzkv2BywBZX1HqANBD4HUcbe48NHDkV7zi6X5eRMxafSaL1zqAgHQd8orlSmTTEVfOAdQQ/o8xlg45KhppiEIypVoYGo89ynzBdVET6LiLeorgXLMz69EywqGE2O4EusSg/OmwppcjCjBGFeVuw+ee279xA7gWMf1X+QEgqvsOkZaSRPKYD73ZLdrwZi40FdndLSrTcMg4uThQlG5qTm7fvJS8FwxnL0AIqk8Dtn5QflKh5XDNUD+GR9IemNw/ylfNbhQoAOLsqcoJ1zcuh2v9CwueiOu8O4empz/ufz5xQbhbLscLF2KxDlh94i4DTtr+Wq+xMO06lY8eoSnIcv+Oe/kNZak+qefNBbxbFDKApoHfIHOZhCiMrPYkxhfn3HPWYBCE6o8pPJEyUs1AdsmHitrXH+/gM7yc3lJ/d90omxtRjyvZ20z5pprGl4rq/YAabji0zEhK9BCYRu8u4ywj1wMj7UAH+uRrtGwAVEXD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(316002)(6916009)(66476007)(66556008)(66946007)(478600001)(6486002)(38100700002)(44832011)(6512007)(2616005)(5660300002)(6666004)(6506007)(4326008)(8676002)(8936002)(26005)(107886003)(2906002)(83380400001)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s9kbfKIAYar5Nn2DHvYvwdJBA+pQuUICMNKa5dhFctyHUshLhh3xG1OQuZxs?=
 =?us-ascii?Q?/Di1gOluRgMYnl8UFXL3cFvUAkKAdhqb7j6GQcNw9oYtCHq9pb6AJlnHGFIV?=
 =?us-ascii?Q?Xibi9REsRnSZehXoAscfWKJ8NUwomu5zHD6Ys6Zkd5B6731IDORBVWzKw/Jd?=
 =?us-ascii?Q?jqo4k6R87VatvDnHk8gP9dgkAbwX/QsqFUH7hNy667e9dxPt8A6pH9tRkQhS?=
 =?us-ascii?Q?4QTodSJyPs5JuLpt08ka4CP/mPRw1rFlC0B5THjrMKsftl4Pk25QIm8WTogJ?=
 =?us-ascii?Q?trN3Y1Mar6HQ9wHDdaiPyqPK4tWlB8wXzIETAPDxUXdgHKJXkrxnTsXpspVq?=
 =?us-ascii?Q?y5sJJw5zVNeXjzyQX/py17Xi7kErcM5FZSXRy50nrXkrFnLuJb+guetnuyYe?=
 =?us-ascii?Q?bDVm1K93877L5GNTo0T1TOMw7ZwC+QThBRhRvKONcUHa6l/eAKbU1at5NIos?=
 =?us-ascii?Q?AO9kCWCvPhZwOL/rNguH992u9pld8zJmt6rzlSdBMy7lhuQzD8+2WECLva9c?=
 =?us-ascii?Q?ROvla7+Cd2uNKk6Z+i4Xp+3o+codB3XneaYhqZ21EA3LwoDHtlx0klO3/oDA?=
 =?us-ascii?Q?RYo/zk5odUTj/4xRKn7VaIJ2H7cGajbO+UTJrns+QbhpcrP1KFkSDsCrWo9k?=
 =?us-ascii?Q?oNMMRJnxXcCXrYvI3CYmTVrmV91yzGtC7Wag0JIUqJme1xp00KwWuQno51KI?=
 =?us-ascii?Q?jVjEJiHGSHlB1qCF9DOZEyLCDMzzSQ6Qzoimq4Ju9BfQyjTtECOGfmVxGFz6?=
 =?us-ascii?Q?wxz1PVhjiMdzfUm/1KHk6xmlQvlZdio80rqhXj2Md/edY/3H/lWOESBq9KzD?=
 =?us-ascii?Q?Em8BzaH2wY6ThgdvSu+qc+bUAYeQHTabhIUxE2fJ+jjxzCsI80Bq++H47pC5?=
 =?us-ascii?Q?9YO7xbJS8FaKJO5tFLKK2vb9ngi6BNiKlCKh4pKG/3DyxFUdyb7KzHwxNvuV?=
 =?us-ascii?Q?oaknZH3Ymv2yM7Y46sKJ7gCyHtmWGwrMQ20WNLtVOmaMItJgC0bbMCXKhoIb?=
 =?us-ascii?Q?UE+voITkwBsVHbdM2UgwkXlr/8ScuRhH8nBhAdbfFciI9lRw/oNY009l4Gns?=
 =?us-ascii?Q?ZsuDqjWT0RdvGysR0LwQyH4AnPHQTAImkOoTRSGkb+jlHrO8YEUhhpDxP2F5?=
 =?us-ascii?Q?H9w0PU1WgiDIRjO+KYQ3XJluCS1tMtaeBk4QFt2FkB1v7EHY3T1zI9qLhAcd?=
 =?us-ascii?Q?3wZPupqGrIXBKq4XajMnH/Mlmo0W5ShjguN5UDEGRzLOcQtZZ/qryJOxKqN7?=
 =?us-ascii?Q?eVFb//po2RFFVeMoVV+ICXTPHhDSvNgPPmkIgPOrRS7iMTYTAy7Pb4aExKis?=
 =?us-ascii?Q?M5hkMrwhbvYnGKdMC4QVWYgowp2CFWZIXdBRvpyN7h2BQLNe4p4eGy8nKd4e?=
 =?us-ascii?Q?g0WsZI2hbdDKaBl/+RTKkS43dueWr0H5fbDss/PCa9gNOcvxmH4c7y0MBAah?=
 =?us-ascii?Q?jZp46NAZMgBTV+a9FV+wSgY3AD3JVzCiII946TncKOZx+FF62nSCcC8MoyII?=
 =?us-ascii?Q?49gigLl4FrhMtOqVjWx+u5WnbEg7PkX7odPytrBgN/v5rV9QioBlsOcbSRwP?=
 =?us-ascii?Q?HcF6geiAXL/bluO/ofkd+oIAmoSWxFqdzujEaOVncrR8HwUT5gpJNZN359Ru?=
 =?us-ascii?Q?iw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480407b3-e815-4b6b-5b79-08dbe4fbdf2f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:24:24.0906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6khF7DQk3V05BucfMbbM98/3hVgxtVn3EI0L3c+ohzu+YDAubmyDqgHK1EmHVjwXvqQtiMNRY5qmz0LAkoP99g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8896

This patch prints out TEST_COUNT for every tests in script userspace_pm.sh.

The output looks like:

 INFO: Init
 01 Created network namespaces ns1, ns2                       [ OK ]
 INFO: Make connections
 02 Established IPv4 MPTCP Connection ns2 => ns1              [ OK ]
 03 Established IPv6 MPTCP Connection ns2 => ns1              [ OK ]
 INFO: Announce tests
 04 ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token             [ OK ]
 05 ADD_ADDR id:14 10.0.2.2 (ns2) => ns1, reuse port          [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 6512d198ee23..b25456fad2f7 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -42,6 +42,7 @@ server_addr_id=${RANDOM:0:2}
 
 mptcp_lib_ns_init
 TEST_NAME=""
+TEST_COUNT=0
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
@@ -56,8 +57,9 @@ print_title()
 print_test()
 {
 	TEST_NAME="${1}"
+	TEST_COUNT=$((TEST_COUNT+1))
 
-	_printf "%-63s" "${TEST_NAME}"
+	_printf "%02u %-63s" "${TEST_COUNT}" "${TEST_NAME}"
 }
 
 test_pass()
-- 
2.35.3

