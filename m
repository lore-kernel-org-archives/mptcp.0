Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A312816412
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TD4qx85m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGVncGlW1j3PBLS/UyBdBmwFFms5lpCbeq7abpH7+Q8hnZpISEag8CS5oyeR1mQRJdPbgBS4VPFQvgIuT8IE6fVBuWyNph23rXYEegsChvoQ2f1aSc0j9lDOVUSGv6W18ayy7GxQVLdRY9rlDW6KmqA9s7XXp8ybstH55dwQ59AweDExDWrw2xghyQuUIGGSHgoT030NSUa07rlyDNyyyVQilPYVyBzV/6GhZdPmcIgZUIW9vSGKRWjA6v266WBIYg1NTaPRtRqh81zzyf3e5OhQ+LxaEH34lh7TtqFl59lg38HZVzca5i/zBV6xsZ9Z0T/O/LkWQvuebsZ9w8mTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zegY6h/fmqcRrg/93R+5oej5y1CXdTsZnW37dwfOeEA=;
 b=Ry+hygW3xM3cMT6wdI/y8jrOJpw3Uo8rMEHhSoNBeMz6QMs07h0NS619ZBjdTwIH2t0XZnEZLNuok6fyIxLiv/OUyGMPTxyptHMPXDXqRdit5ZOimRn9BnxDLlyYixNHRICKBdMJlOquT9c83+5/ACP3/7o84TZ1d96dHzj3oiWpBIHqzq8uYP8UUNGqn2/2Qoko0MmFTGS7mW47sR2Mkvazia0Y9ZALwRLC06jboEwZlPBXpfKH3NLJS2Nw3h25yh62Fxcro1/dxXvJpJPs5Ga96bjM+jH8pQrIxD0WqMy4VqZy1LbTMUKG7XipHtQGgNBwGOHm+trmyJb9qV8eVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zegY6h/fmqcRrg/93R+5oej5y1CXdTsZnW37dwfOeEA=;
 b=TD4qx85mZjeuXLo1U26qt2+dybIEwFRJXVz0VXlsWDDA4c5qWXYaIYrXqCYgy32rxgDSVgWNY7W7rbZZzbTTzKB/7POc6EaoNL16911GjT1gWMvub2etCNKMGIuFi8azHw96aqR24NFUxu+A8dfOi5CvSPrpO1OZIwETxpjoRz7MesWzIGFLyDw5yvJNS0ksLktHncy90Zikis8pZfUVWOpcBKk8vmRVTs6uNQOM7Ot9z20+EgDc8Kv7mtndfBj+4q0WQLnHFghy4lsfuGlEDsLvdshoV1f8pd5dHX2gB87LUnSwLRTIwpWJ08moU3FCeau78QdFAgCVfZbwKC03mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:22:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:22:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 02/33] selftests: mptcp: userspace: capitalize test_name
Date: Tue, 14 Nov 2023 18:21:32 +0800
Message-Id: <d33219f39e77fb4416703c3fa467c211918ddbd4.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0195.apcprd04.prod.outlook.com
 (2603:1096:4:14::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e0a088-adb0-4d15-9b03-08dbe4fb8d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NFVxyTnZ+ztQMJ2c5FoI3cwqXbw2iOLCDWFaWbDnQiegAVqelyJVSzOhU1suYKORKPkIoVkHh1XxyrSFQ1xfHyq85Q7BU/8V7BBfYUbrMGPzXhKzq2RiXzgdw9axb+XsFe0CRX1pfOEqtdRqvesYpq/7dyip0FQRBCTiITgbgcXAeL3lpszNsJ1573guAVXBio70KWnHY3lv9OlA4VKKHQqtZKDpJbnnTsZy/VhSE12b3VNSR6GAvb0q7+6HDBQ9xIas6FUjgINOg+kvKMcJvX1oVfxTiTijgcStOYqUPH58iNMc4JcCjaH9WVsa8BaVzMLHa9Rx6RxlNQ1D/5FZDvSXXlNcevmoSkBQWatt3CXyW61NTxfsfM4N6ixwusxuX97dvG6NvvUOi+GJmJS7Iag2mh+ImKutr9vnMchwmwntB6wRXah5s3S23K9MozpaZl1hGxZppP9QqP45UxKnag+eEA0x1yCA8Vc2YVtB86L9ICqI/RIV53OXuS12jEzaxVI5bLckkTv78nlL0mFX5jH0Eyd5vlRwq6jO/mVCQZs+yqZzc7KVf23PT00PSITL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(44832011)(5660300002)(38100700002)(86362001)(41300700001)(2616005)(107886003)(6506007)(6666004)(6512007)(6486002)(478600001)(26005)(8676002)(8936002)(4326008)(83380400001)(66556008)(66476007)(6916009)(316002)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QkYdFbxtiiP7T6rwaJM4dJiLREXwqnzPxIjWV+ugZDZj9wm7S6D7y1OTWiGr?=
 =?us-ascii?Q?7w9K+bTs8RTKUFvuS6KYmIeYgT7jfFqMllxEj4W1mMNcPXFWX9FS5EtqCOl/?=
 =?us-ascii?Q?tPvfJJf5JT2SX3tnmIdD/hgz+6IH+oqR+iSfA0egog7hb0x7jBqtB9/D4gu3?=
 =?us-ascii?Q?xqIgsr29FrYWQL0RpoO5l9rCFLk0dXLKg45EaUzzTt3c6Ihb7/OVTgs8aif8?=
 =?us-ascii?Q?cUmXlklJ0JlB01ZzQlKb2axeSUqdeyLEF0I/9oh4TjOs2L7n3GA7y4rmjGH6?=
 =?us-ascii?Q?1P86Ow9pUCyix3fbB6Rlou+mhlmuVQm3SBZVEkv77pm+rHE0XzGPTLrf/Olz?=
 =?us-ascii?Q?8zZ8V1o2MlH09lM4b9i3VUChvRIItJ2L1woWviNFkwawBluAhay7HSIyMzAq?=
 =?us-ascii?Q?z+spWCVdBUbqwaFd+rdvUjArCHROPz7hFguSLtZ+hqAOgu7kXFNEKEVQeQre?=
 =?us-ascii?Q?c5T/ym5MVeAqYuKwS78XNr+VZnRse1ZixJjO+h1RO81mfr70mMYkA16nWYZo?=
 =?us-ascii?Q?ZKQX9a54ZITOyZV+S+Xa1bxxNOBsZDZ3DtRuEEuCcJHjJyT+iiuhP3rDGPso?=
 =?us-ascii?Q?2BJT8utTqrbsP16JOsVXJRwRdZdMvx7Pjwvkwo1l3yGxuLQ4KuZeC4jzg8io?=
 =?us-ascii?Q?hsxWBrU/8p+h/yJ4/unwLPKY1GcWWmtWUARzN+1h1HAJZmEYFPFyuC5fPNFR?=
 =?us-ascii?Q?od8Ql2DcazK1rV5d+WdkyJ5wgJTAAWIlm2/z8BAjULk9PDRsnOth7dqdpPou?=
 =?us-ascii?Q?T3BcxM15hvcQ/Zb++6lCALwaTtVIwC1BsSPSpNg72ZOlVUw95aecNCVMIIJ4?=
 =?us-ascii?Q?lfUEg0okw+NNqRLauc3hbG9iKWGNQziWC8J0RI5f1Nt0UzFTCWU7tVF3tQbK?=
 =?us-ascii?Q?sH+Id/5Wi17VTrJfeIxkS0XEvF0sD75OnHsjxbBlY1RuLHEJvCcoxdS10PfB?=
 =?us-ascii?Q?mcLbTbbBmJ/0H2ZfhfxF857kPTJmz7RDqo3O6FxhHDXMTAleq+nk2maMmF22?=
 =?us-ascii?Q?Ev9XwF04rczb3XTypIjPFE4sFk5yVtbrwVca+cmdoKL6LNCf9xnYFB/UJ1Gf?=
 =?us-ascii?Q?2zH8Q9GTO4lK0Sl7WrxkIHH1EityuoCEFyMizhDnLV62vcOmxtBrvlF996tr?=
 =?us-ascii?Q?0sxzwT0Zjum77nrIvaQdLvY1gSdrIBNub3IC1srxeBVK6/J9rXO/G3WUrgjK?=
 =?us-ascii?Q?CVqYau3XWxtRqf5chpRw0Xkx7ySsKTr5I4Htdh1qUviRhxmUgi28yCHmRbO6?=
 =?us-ascii?Q?smKI3z7dfqzpaOZ36aLvzPOzbWZ+3Q1934guaPxyknyRb+hqwiaIcM6tPp9d?=
 =?us-ascii?Q?8Me5vI0uahPu3IdY4PKZBnShtpCic5td3I963Y1E5ctF89p7yGj1gdEg2tbo?=
 =?us-ascii?Q?XqVGOpNuvYbwAT1/sIvv1/1rk3SuFygeqABOummgOmyiBWTto5IXzZYbyL/k?=
 =?us-ascii?Q?BtVm0NPq/wBrNVF7Qhw3+SbDVVZAjK5mERNWc2lkb7p7EcetgVS82qTT90pA?=
 =?us-ascii?Q?Al0T2+231C+N1WsLaCkTQLqBPC7Twb4uOJz+DtqRBDr9CNFywvCAWguSrE1B?=
 =?us-ascii?Q?3FbJbVV3/dfY4D+czBEzC7Ee8D8+diCq6tFG16wx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e0a088-adb0-4d15-9b03-08dbe4fb8d71
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:22:06.5545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyTrI0kSi7oy7qnPGw7p7PZq4vK5DWjc2GXEKjIVoShU8qvko1SpdsEWRrSZY1yKVM4eWu+TyY9cl5lUNia6vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

Most scripts use uppercase variable TEST_NAME, but lowercase one are
used in userspace_pm.sh. To maintain consistency with other scripts,
this patch renames variable test_name to TEST_NAME:

    test_name -> TEST_NAME   in userspace_pm.sh

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 55ed3ea0a691..f1d5cd4ab95a 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -55,7 +55,7 @@ rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
 ret=0
-test_name=""
+TEST_NAME=""
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
@@ -69,9 +69,9 @@ print_title()
 # $1: test name
 print_test()
 {
-	test_name="${1}"
+	TEST_NAME="${1}"
 
-	_printf "%-63s" "${test_name}"
+	_printf "%-63s" "${TEST_NAME}"
 }
 
 print_results()
@@ -82,13 +82,13 @@ print_results()
 test_pass()
 {
 	print_results " OK "
-	mptcp_lib_result_pass "${test_name}"
+	mptcp_lib_result_pass "${TEST_NAME}"
 }
 
 test_skip()
 {
 	print_results "SKIP"
-	mptcp_lib_result_skip "${test_name}"
+	mptcp_lib_result_skip "${TEST_NAME}"
 }
 
 # $1: msg
@@ -101,7 +101,7 @@ test_fail()
 		_printf "\t%s\n" "${1}"
 	fi
 
-	mptcp_lib_result_fail "${test_name}"
+	mptcp_lib_result_fail "${TEST_NAME}"
 }
 
 # This function is used in the cleanup trap
-- 
2.35.3

