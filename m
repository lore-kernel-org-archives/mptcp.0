Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B791612D
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L0GA1XZt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7NhyG3cWFX9Kbu236P4KFoWWsHhSZgk6hn+rlybN/umEpbEO76fDvHVKi873uOmDdo4HD9QO7pP69k1w/rg6iyJvuRFiRx8VRwSEGM1bCSmsvMmBjsnCUbiCAz+c4a4EIO04wti77tff7kzvtfV9vCZ6bOCjrdNKZj1BzvgBgeITBfUbadHvnEwMd409crjmWKP9wxMNyAPYVAuoY1dQy4VRynlzf4bs21gWSmd/AuXhHFLMCwQ8uLPjpOQUOQbXYLS/IgCTHWqlHrJ5AzebT2mpX+SBcP7MUYNODo5f/Pu1L/r63Q0QtRkwRaZ0S7kZwMuurmuHIiGZOthPPVGUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysUkp4mVylQeoPS+00bES1AMp/um1WXzpOnC8sAj910=;
 b=Jqksg1kbw5+u5gQ7MM6RbfH79hA9TJ4xDb/HMlzupzpI97seY6+/3e+vBnU+pUpHpErLhE8x5O0vWI8O78UMe0CtzS55tOnNWxIuBklyj/WjBn0X17yt6Q6g7EAvdBv/43JmVDE1H1IWkAbioi0nqjfCY6jodkM5wPcwyF/Ogx0jcGgq4M30Q9oEJmO7BAgwlo1NhxaFWKozkLKyI8Z7eWMotsptO3FUMsDct/nYO5R/p+VTG98UEC4thyjbUVZMF6YkCKLKZyzxV5uZo/uHCBMZhQjW9J7BJTkRjT8yKMeX8/JGm9F+xItR28W6Yi8ilDKpIdnwtBTvjkhAyncLDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysUkp4mVylQeoPS+00bES1AMp/um1WXzpOnC8sAj910=;
 b=L0GA1XZtgupJ5C8o4NFmLW5yLrSXwtekFzOrNKT06FIf8sVfZ8iuqcpeNJXUfy1nEu5rWbeCJltOICMbd2N5fb6lY3O+64/0Ag+xSNLHB9sZOnRo03/46/otOpETwImIqbJTviruLv81omaDXeV988j7cTPPOx8tI9UPvtBqE1t0jA+Vh3e/20GoGXFiPJaobGVe0ozO9y4XWHOz3vMAVpYOF1uw0U9SsuERi+s0d4kAa5bEw7pJ5isIPwSTPyY1ntYE4MRBUF/KfbUDvSbF51AsqB1H6i+vT47ksUY42PjPDRBJohWMVxicNWAyGDULH6UUo8gRKcLfba5XTT6ozg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:40:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:40:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 16/32] selftests: mptcp: simult_flows: print colored output
Date: Tue, 14 Nov 2023 14:35:35 +0800
Message-Id: <b1f00a63941083961ea0989483a09535429a2915.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: c86fe163-2cf0-485d-ee95-08dbe4dc863d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RZd9gRdYkPOZ0vMZc0ZlgDU00yH/VOjfPUHgNb8A3BXHYNHQyIl8a6J0160aZFinMtGDwkLcHzuESIVul0WUo64AVLGDloImRuTTpY89mKsRidzIKDNj9Vt5NG4ZOccnrL7hgRiz49OvqkD53y6YpquTqGAoCVOefV7C7x1vva6+6YHBj4fOm6EBREEkpPzdK1dkbVTKxEEp4Fz0ejpYO+6lEq5b9h3USz0DD9DCoAb+zA+11vQzO2b2sqUGuPNoYvWcsQEs9Bg0gyP6eBZyaER+GSp8Qa5ZL7nDNDLKTu2x9k5+4Gw/4kRclXPaCHJ2J9w6w6z6YHc/e/fzRI5Dxd90rdNhssP4xH6ZhEoEaI9Mp3DbOq0WDUa4RVHWdybYBgQkOf+G3tuAQx4dyc7p1V23ckD6QVUSZv8ItYeHnjQaSpV2vO5dZ1AHnUeaVqr4FpSbqUBE0wYFo5W8bXrKYzgP+42JL1crXvnWwZBcOATHBD1lgp4BcaEaPuQ9sRQFcaKQZaTb1jzlVwL/vxCAhwULumCuakQhFD47ShpZLhVNWcbZKpO/tplMXsawWeNM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(107886003)(5660300002)(2616005)(26005)(6506007)(6512007)(44832011)(6666004)(83380400001)(2906002)(478600001)(41300700001)(6916009)(66946007)(36756003)(316002)(66476007)(66556008)(8936002)(4326008)(8676002)(6486002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mfm5dHesJ7dsZ/IYg48hfnQcgXjruV/vmHiAAX7bhSeQK5qJXluZwBligELg?=
 =?us-ascii?Q?ihsGgEM7YsIuKIjpKaRNlsI9QnCqjCjBy3OeCfIcQB9cc+OP85a4cXje594d?=
 =?us-ascii?Q?nZQwUpcGFp6Rv1sFmWKecEPAhGiwblpM7B/WtZWcq7/dTPjrezU/W0ClpxcL?=
 =?us-ascii?Q?OQp5I+0YxT+rjAzADJh9ZwO/SqwogdJp0mFcTAznD+5cGVslKeXWzpreBTj2?=
 =?us-ascii?Q?VAYYyt5QGd06/161jUtc2ap4u18viVHfTxKMU4VWOXdY+JLwTxJAj1sxdoYb?=
 =?us-ascii?Q?1AxC51pWHMlREUZ+rce2AvnDBAHNPkn4y0BueC0x8D8oeSMMiRk4ilnt4uCO?=
 =?us-ascii?Q?DsGV7WN3RfGVL6VjXVOjzu7cUC97Yn27eR8TDDFd94CzvqPcTJW1nFORL5Aw?=
 =?us-ascii?Q?FvRL1AcD3T8/0Pgu4iMXKjK+lpI17103Gb4qDEAU1HtQCuzfFWEz985ZvAgD?=
 =?us-ascii?Q?OPi8xs8S2lUwkmB6iD8DvOhzWZwMvYD1VZpNKQGj0QyTmgG0XpYY+vHAuamQ?=
 =?us-ascii?Q?YsOaHTzekDQI+x94fS7YUlq3aC8HqEb10l+XIfbyHEcyF3wUS1TIv7Rmdmfd?=
 =?us-ascii?Q?gBL5qNbpDu1crcgWH0/pwkL0IAjeIkekHQtDvhPqWOGS0xL6cG6hZxIhDjG+?=
 =?us-ascii?Q?DhJPA/rLvVYju9HWKVh/vdUymiJ9zH3vweo/QnkEzLTKz+wen6XAPGwfR98Z?=
 =?us-ascii?Q?cejHuj2b+I9flAWjZroNckFWhi8Hn06PcfxWM9OTeC64CbtoX15YyRIVls9A?=
 =?us-ascii?Q?Y5/cqSenB/Yu8ooHq0nC432+2HBBliTaRFJmRlqWWbG1tZQW9YrxQh2RiTLX?=
 =?us-ascii?Q?IpySPYZQ6XvJCWNydAaJAwtnr04Q4CDGjtQ3j/Jzh3isr/pfug8Kesa9z9zl?=
 =?us-ascii?Q?CQl5bh2tsfFhYU6RzoyVGXZrPUMrL/2v3j0AtDi/O5BA81vvyYtKtG4j9yVq?=
 =?us-ascii?Q?TlQXuOz2p/Tp30i2vUMIm/xrWyylkIaCVd5uksM3GBCo80tXClcx4bQtw/ZO?=
 =?us-ascii?Q?RLwEmYFZDOpTZM2a9GeuK61C1+H/QpB1dP4GYzfTfFFId/3KEmQV/Gz9giTF?=
 =?us-ascii?Q?GG3nQ5gRxK9/J0+K4BpTxgN70blF01TWS+eSr3ujlzNJzjrdrvgAc4Vw95ii?=
 =?us-ascii?Q?uJVCNvpGq/R9QJzAW03p8+1EU4DR0et3g6DrNebaOylzp8z+1y7EwSj3cpOT?=
 =?us-ascii?Q?VYhFmp1BGWEEvcQT/9hRQBfalsvF5VvyV0gJJZy6KezGEBfWRS/0E3BQ9SKs?=
 =?us-ascii?Q?BuEO50g2vIseTHWFcgETdc8mRKnrHFTTWBdxI+aamFYMq1K8nmSrAxC9H/E3?=
 =?us-ascii?Q?taRDBVk6mTjWxwdqyqI/uASHMPCf9Z7ts/FdD6oYAUdMkIDxZ6Ep0qeQx202?=
 =?us-ascii?Q?42ime0rEYLYsAux41pRoIvUcmhepQS7bpg0DM2dM8G5zuRE3yQxe480/bmDZ?=
 =?us-ascii?Q?3Z+kZagk19T2z9qgHRZjYeKQ7tK+W2RpYsGsQOPrPaBfvC5D8wHg8CExo/4D?=
 =?us-ascii?Q?Goaw27i4XVJapOfD7G5dDc2LGRQO0ZvZLi/4kupqNt5q9L6DfsXmMzKoCE8g?=
 =?us-ascii?Q?5AU1sTCF6O884PEvgIJTlxsU0UHc2HUdjcNiYQmu?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c86fe163-2cf0-485d-ee95-08dbe4dc863d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:40:00.0111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAgowdJaCkwqy3tsohConQMrPosD55Akr2Sk5IfuYwmTb7zlfzBCieKbF+wbCbCJLbIWC67HFu5nQbMbfP/TsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932

Use mptcp_lib_print_ok() and _err() helpers in script simult_flows.sh
to print test results with colors.

Having colors helps to quickly identify issues when looking at a long
list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index c1a21cd8c076..86f021bccae0 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -175,12 +175,12 @@ do_transfer()
 	printf "%-16s" " max $max_time "
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ] && \
 	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ]; then
-		echo "[ OK ]"
+		mptcp_lib_print_ok "[ OK ]"
 		cat "$capout"
 		return 0
 	fi
 
-	echo " [ FAIL ]"
+	mptcp_lib_print_err " [ FAIL ]"
 	echo "client exit code $retc, server $rets" 1>&2
 	echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
 	ip netns exec ${ns3} ss -nita 1>&2 -o "sport = :$port"
-- 
2.35.3

