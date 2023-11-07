Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4DB2595
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yi8Wx5wT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INwUzYRKO6hZnUL+Be2r+fQVHijxm36MX9R4puItUBHXGodAEA2OHT7KHJkrtlas6vNCpimPdcZNlHPfejI0xZtoZFUhVnbHRb/y7Xwao2O/5WTX0aD8F6yT5SfCbZd8avGbX8F1Z/UFCLb0FBfz5Nnn+HRYpM436BIh15aQVrDbyHTuevKyvwE2rfFduoPqEqrONIa6VGugwUnJJFZTEI1DwbOuyuKfvUQ8pFZVjWDv6SSEPkBVYPJYa/JSBlMOaB9pFlvmmwX1SZsQjRKoy+8ATA5enPBMyuc5Vkc0a3X+HHn28pX6DAtTm9pMWpVJEHM8B6Acv1of8RZZE1I/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIp5cD0EI7QTXP0DCZ+EvQq9UnqJZrrDxfcKnTTWKtk=;
 b=J26OrfrjO/v54UPj/xnLGJC3E+394ERIhaVKnvjmBPLXm8GcC3IOICJhxBGSSMB0hXSR3AxsY6ncWOwcrJqbYt05fOpgbc6JW18KSKPD/2pP/jn9RDJvGt+KvZZSMtdKxGO76ZqLesNbAcmisx8kDCNCMATOMniFatFoWptHmWvm0grqcBlgy3iSMqv1fmkEVBYfQ4TIYmjTsfc5sBXvHGQFpjxYszp96PaPb+zIFrnwJPGNYbFAkxYWwXAKXUo5NDy0yWOP1aQJk1lTYtb9krGgyXCsQoq0RsIIbNlZ86SMlE0nrvRqO/m8M8ciyOF3VuBju/aRYOlnTUmB55cSiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIp5cD0EI7QTXP0DCZ+EvQq9UnqJZrrDxfcKnTTWKtk=;
 b=Yi8Wx5wT4zK7bJp9KokdrJDrJM5G/wkhH1hdlua89Z6UcQ0PQj9GukYVicsHNPlepoQSGHcTnjX4zpUusixnh0cBgzvCEnsG+GiWa50j6S8ZIJHlVWOYNtIoPoY1Mkz7DD4JIz2FBS0j4UYDvkwuuPaMcEM6jqjbWrzv9h3it3AXdyC4m88Z5Ja4jWU2BohvD7nrYNn4FWhr82lvqrNo3DfjDBWwWijD2dOuZLU1TA5NOArNwpVo9FzOEUWJ8NWoAWXifDwNdVEwSmatIJD8T5j7QBoS3F0E3dAnl9CRU80RtPYMXCPSKZ54lxWDbgrne9/PeRJsOX9xOa4yr4s1Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB10023.eurprd04.prod.outlook.com (2603:10a6:150:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Tue, 7 Nov
 2023 08:16:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:16:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 20/20] selftests: mptcp: rm userspace addr with random order
Date: Tue,  7 Nov 2023 16:14:26 +0800
Message-Id: <125303e29562b201f1f6f441ba5289b1904bacbf.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB10023:EE_
X-MS-Office365-Filtering-Correlation-Id: 63024f06-6671-47a3-eec1-08dbdf69de90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BZPZ1O/IkRhM+MjxH1UwqqjkMjIqIArl8wenB1IoDRFjZUzmRlGtr5GvFtb4xBZ/1jf+y2upqH76pWzHsiK97F2v1sntSCqIlTTZ7b/Dr5aR3iyGxtk1hIwzneKWPcJSR4sD/DUJ64BYB+d8WH+Cm2QHmI2u5OvEZ7GnqPIQLGkxaztjXLUoVVClfJMojZ25HBXcglPkF2ZW5w+jr9/fmnyDxXp/t3aMjBI2um5QLKAZT80+OI+6vk5yQ6y92SBVo6FnRoT/NqBR/mOzViY72sEk6WKBh4w31PkLbKRRMiC/sjwDnE0eFQV1EgxT6j6mF41gQnX/wsCdyugKKBYyyCiflEix4cbet9H/r8buL0gc/5YPqonuIjGtnzT4O3wQyIcD8pzBcUbiuzHsb1ERLjNHLYhe8sG9/W6dMgyumeVjx/LnmTqQpNqFFLIFlzattT2HQLgByijDCPIV8PW1YWnyGNKWF3rJGjrLgir+ZUXaiKuVmcBBinM76+pV+5BxKK1a1yzmAj0B9AmHR428vh380MMxKjsg0vsgjiHGrQRGGN5VB8XN2s6D2RSLCpb5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(346002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6512007)(8936002)(2616005)(107886003)(26005)(6486002)(44832011)(36756003)(8676002)(86362001)(316002)(66476007)(4326008)(2906002)(41300700001)(6916009)(5660300002)(66946007)(66556008)(6666004)(6506007)(478600001)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kjNR+3kOVZs2PZXnm9lXXp6kqReCz5f87piOxX1z2ORbSrm5Ew2Kf+uhuh6h?=
 =?us-ascii?Q?ZuZUTIOA1PSzOh3A2Xhx7HzvNJZLV3ONaObYj64f25gV2BMRPI+VYwz8kkEf?=
 =?us-ascii?Q?5RhgsTYZTvF5isFEk+ys2ewvEK9giz/DgP+VBeiEcKZ9Ei8hvwwYyvJTqV+S?=
 =?us-ascii?Q?rrPgFb37WBccguV6GvfUfy13rfTv2M6ejaVi0Q8NQxFbovljmtGAFub6DzZt?=
 =?us-ascii?Q?kz9KS7c6Q6QdV/q63qRjBG6+ZKVxGhukQJ6BPKvkod7M/sNNqLZkg9rpQ20j?=
 =?us-ascii?Q?In97p/sX9OFAXVmtNpf5cGI5FjxxGbXtIqFp82om70bbf9YUelvVVrH70sT5?=
 =?us-ascii?Q?M20AUZEP1Yo26Kz1eHVAqOQ4QGVqlFcfdd1sQa2RkQHd/x+TCgb/RPWUMjzn?=
 =?us-ascii?Q?7jCqpUpnF6qBDq6PtmD7Wvuvm+jxJfecQ4PenIsj99oGl5oDGgtLcpoG2E4I?=
 =?us-ascii?Q?wy5EKUG8qNFPcwkVC6LIq01dZEB4XxPyCz5uK8Cf+zLakcSI3BvU/JMFvJoq?=
 =?us-ascii?Q?gNzUrNzyfILUakpHVFCLEIxbi8So8FaX97wkI7xdYACNkEWu/OHlyqqZC/Ya?=
 =?us-ascii?Q?n+gJQrTYDVAahYM6whdWuyKMKeJAfKjjNn25vUAzQl1/spXVf931V4sr1Qx/?=
 =?us-ascii?Q?ikJXR1m+PQddinjZ2gdLiqdlbeV83pX0H5k6KtYoYToVqBSmhUQRK6dhqLBG?=
 =?us-ascii?Q?ohXinl+mZoDZeOGyD15eaUQ8JPgcSmskWER4hngEBAjZK3orc28AcZdUmoA8?=
 =?us-ascii?Q?EIq6xNhhhE4aFx8ktJoI1Gr3aU9+9CoK65+lxPHOnaedcUaS/tz+4SX9pWvu?=
 =?us-ascii?Q?Yd0oqXUb55wGPHJbC+M7Y76gv6kwSc8qm2IpyuDUtTPswU72+Vx36LvT7nw9?=
 =?us-ascii?Q?ELJ6MGkkJf00CzJSilJnp7JnXBfordK6wRt4UAYzQ7Ua2gnGyXtYO9KOC4yq?=
 =?us-ascii?Q?5AtZKLXctq4UXDJUawGtzfTY1M2ndhBKotMxhIO4gM8j37qD41FjkzV7blRx?=
 =?us-ascii?Q?x/1bjIkE9mG7JDJ3tabd9uktmZYm/pjn9iPbNFmOpJqfhVBsQU8f/DoBUpZE?=
 =?us-ascii?Q?4IlNJi54wwlF8pl3Ls5xB1KvedWrCg6ruwbOq8gJPNazXgr2jx0wKk3KW5a1?=
 =?us-ascii?Q?CxsHtkRX3Uv89cKYZMI/CC1mQlzBv1GpX7K0AJ6QCyW0mohQKPFc/THbbMeI?=
 =?us-ascii?Q?8a/viIczAniVtMogxHHWnu4UYRDW5fPNZ7drMbNAtMtI0Qw5X1CbtEelISF+?=
 =?us-ascii?Q?sPCNcnCA07I1Qowh7OnvI5gWoJOTu8EzcRGooG8XW7xarlLPbYGgW3ha/89S?=
 =?us-ascii?Q?SAYDHNYZb8bK1V43IWQ55uK2KLVYcnsbWts4KQd6crAtZfrnepZ3ZiL+5V3E?=
 =?us-ascii?Q?n6/NoOW99AtlDI7RjnpLfQ0HnJX989NiEbOqsRFnFBX18KS+2bJrknep6k+0?=
 =?us-ascii?Q?shQMKegHEMveIl2/fR9hWD8CcTHiAv5gfWnwDXBKWiPgM1MU2ax58AYw7dDm?=
 =?us-ascii?Q?aDkkswXSHej/QXebUknG6OKPpiyfdGi/RfrJiG2d9B18SXLuI9JEHXxC33aM?=
 =?us-ascii?Q?NlEqcGDAMmshfSJtZeeXvhVOVLm/Xtap6mqgO4Bt?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63024f06-6671-47a3-eec1-08dbdf69de90
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:16:40.2699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUR7T53UTaMhMRWi4EGPkmlctRXpkV5h1AAlMp1HVAfuCi/VYoHIXfCDQgZCe0jT+QPQhGa01sC7Zcfjs6MXTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10023

Previously, when deleting a userspace address and subflow, it was necessary
to follow the current order of deleting the address and then deleting the
subflow. With this series of changes, addresses and subflows can be deleted
in any order. This patch uses random numbers to add this type of tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f922d32f4f20..8f7112cb120e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3390,8 +3390,13 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_addr $ns1 10
-		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_SUB_ESTABLISHED
+		if [ $((RANDOM%2)) -eq 0 ]; then
+			userspace_pm_rm_addr $ns1 10
+			userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_SUB_ESTABLISHED
+		else
+			userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_SUB_ESTABLISHED
+			userspace_pm_rm_addr $ns1 10
+		fi
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-- 
2.35.3

