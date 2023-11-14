Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C71E16412
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="abxAoAXy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEAN6hqdqoEqXDVdzhmh/hyE4R7B92YbDReMN5gBn2Aq8U/f4jUsYrvj4LDGH/oOqMsT3mNVb6dIIaAD+ffOkvZLIxPgOyO44ONfML0fqp9Y60+qwZOpLiTL3rJ5wxRgkWaySi9/2ij4TiV5oesSwdzTlVJRCiPxiVqQWo4THDAxyHOFVIzMEPDP13eOW/UiojO4tSWumRQnsw2/pmw/YGeCUTMeSIMk0OVcyAyYZs4BI6eWylnC+vklQwTz/Co92nERKv789B1CCzdsZkGQ/frZ3xxV2c9u3gu/7Z6gDFbpJRqx5baneBX687PihMF8C3XZzIE4/W46Wpbk43pWXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysUkp4mVylQeoPS+00bES1AMp/um1WXzpOnC8sAj910=;
 b=iWL1ddk+pucCyzpoatdvOmRvXwo33hngI3H1SADhow6PPzu9uIytyzaupfop4wkZlBIWEMSmLu2Y5MTslyrzbemsOE7w3W0DJ/a/c/4Lodo0jNKlPN//MsLkSYwwk2UpeG8YyGYJTT1QBBDfR72oHUxO1Ah9pv9AmATrI+nACdYKWljGjhdrzC0Q8LfqGvtDQj0jy9i1jYPSDwOAxirLo2c5eNlgbWR2Z5syXg4N7TYRcdZZ1gXopOE6bQxGbdGzjCVzNl67Rn8yLZymErifrvhnDaNKzL+YKd2W7nicSzpjNF6R08I14xPYSyxIz+lCS3XFDGIs+zMaNajneICo2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysUkp4mVylQeoPS+00bES1AMp/um1WXzpOnC8sAj910=;
 b=abxAoAXylJAIYya6BomwqvIYf29G/rag1wJmSnKO1dxo8Zafv+WueHWP/9p6cQUQ39laojRxPklzePoZdEbOSkKKHsUfv6M1+TENsjp/skcqE49FGactN74ip5JeDXMxyq8SRlZuaeMBdSpBSruLmg4MgF/h8OYVRpOmdfqgYEz32LGiiczH2Y7g6+1/5NEtwzsiO8bJx9F7CvypfMTQz0or2sYR4RZUim2Hkt/rbKia8jk//xdeErurqiW8EguA1CDnZNSbOWN+4gv/LJP6i6aSUg8V/iLhumU3r51aL/biJqeohZbpIMIvlZ4OZvEJqhc+cmnE3FN+DcBOQv3k2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:23:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:23:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 16/33] selftests: mptcp: simult flows: print colored output
Date: Tue, 14 Nov 2023 18:21:46 +0800
Message-Id: <f7f0fef15b3cff1da4c906b4df2ecf0fc1136bff.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0234.apcprd06.prod.outlook.com
 (2603:1096:4:ac::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8a049f-bd19-4faf-f28d-08dbe4fbbedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0lpapLRyWZIbdN41AOZlAYKKNeFD3TwWeUjmp/CQCz7tIncjDzJn7aGVJrM3EQqd3h9JHuyDJkkAChlSoI5XxdlOA47OUzbOueH2bowC6hky5RqMmEU+7K8wRj8rSo3TRfkOSaK9ZN8YpzNIQ66PEycoMeI+221zBjB7DDK7lPamlI21R/fqefI8cwKZ4vYAAcuKI69UY8zK/FPPf6shcWWsl1ZWCkjculaRY5WpvEDw+da4VrxXFYtCrEZlNA3G56qHOYcDbYnYleXO0AWqGEndPWFzW/H9YrKUMUxI0Q1IzMWaj5BEONucc6XI1BdPxWqZ3XBVuz43ZyMtqFrXpLKpHvo/O5DxdsNLCpECy+r6ZrcMCXHA/aA39+QI1mo9mbKhGZ/r/Y+6rwpmI2f6KmZ1QFFUFQ+rGrZjx1FOD8qhW06gquLdXzb2j0abBT2L1C4ASA8g1UNKtnpttr2ajV5RgZn0gcb9RLhqDkhlpV7j6BSUicVd4aDx9AI89AjKWJCLJj4V41dieM22v5fYTuA4LfY9fjy+Q7FPpweySssGHLYZZh+IheJd61NcoQIL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(44832011)(5660300002)(38100700002)(86362001)(41300700001)(2616005)(107886003)(6506007)(6666004)(6512007)(6486002)(478600001)(26005)(8676002)(8936002)(4326008)(83380400001)(66556008)(66476007)(6916009)(316002)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L6BTkG4OryrXlrI1AkyO7t21/qD9/t/8q+8ho0pVsTjqd5Hv0keO8nuwMkb3?=
 =?us-ascii?Q?1jpskX2tCWi8ZgvqQdpUnY3q5O9t4GUXJ2J+mH7C+V+tEi/Um02JFCqinDO3?=
 =?us-ascii?Q?F2jSgRf6y9T56SfI3azGF5bEoVRv+koYglmkeO2AgL5830qDSHrs4jVGnhdU?=
 =?us-ascii?Q?Ewkk44OEAiYXj4N77hUxKw1wQ9FvDJEjUu7jX1//Qhwmi1OWNsA4EWCA+p6D?=
 =?us-ascii?Q?Z+zmciR1pUP25aqq8nsuhlzWOfJrmyq+9C2vKrjlFZPYZv5QvvS0/2bqYwAS?=
 =?us-ascii?Q?kcqsWqZ4FrqVe3hh8FsNwu1q7/t5addUNjipKvfyzkZzhq3Uz1mTWEM2BwT7?=
 =?us-ascii?Q?NMLd8duTHW5lGh5d0w/4+0Duktowc87kjalBuck6FwYR8U5qjSogHYDBepKU?=
 =?us-ascii?Q?VS1PlEVlq+/euLyWyqJZ+whqq7WDfcKw4RAYrArdhRIG9pXpKVt9kJk/z2DC?=
 =?us-ascii?Q?BkVUdVNJYyZ3s9mA8FEJfOyMb5mGnug/ATlcvlxoGuVSfspmJvhsjCZS64Z8?=
 =?us-ascii?Q?GTAfqz2saWHNtAZFEzqy0PTCEOFGwQhGQ3hQjRyafwvDLNVhuB6st4TX1Xzr?=
 =?us-ascii?Q?hzkWXoAVWy1mwBzuib+H68aQxvDtriGJIUogy0zQDqdiodVm4DplvE87R8h/?=
 =?us-ascii?Q?zhrkAP56vgFP8ui02+IfFG3zt4f8Sc/Tx04QE2e/tqlL81zOH/4ANcc5mmZq?=
 =?us-ascii?Q?Vt2kaaXudJ6hkoTash/9Dd6ZueWPzMHh1UmATtiHKV5yvniekYdXwi/IHgip?=
 =?us-ascii?Q?+NXxVcoIaHxZiRO0lou+tO4BzM0MfsHSrtZsDemYJEmfvFItp5pDs3860NyE?=
 =?us-ascii?Q?WbBJwGFaC4O8vUMnYB5xPgfOpn8dtU6vWGn21vj+MHpTcNL6ykmsPZNTdwwG?=
 =?us-ascii?Q?T872AirMd+qQxg63UJtJG+V7fg4G7UTXqDFJljErYQcQTtISXXwkYn/KAXzl?=
 =?us-ascii?Q?Ngrj/cv9+3sNZcF6Ni0+PyaK5HHsWYY1WIzkE+Nac27Hkxm4srRRqZN646Za?=
 =?us-ascii?Q?uS1lrt0AsFlGmbSk4Stn6+VtHZ6mIW1qN34RW8zoAjpCS/LWcguyhTj1X23+?=
 =?us-ascii?Q?Y96oGnHPt00T1pqDa9M+u8P5y+QGR0HKO8yn9UF4DREHoiy4HecMPhsKKd+Y?=
 =?us-ascii?Q?tN21yGqZRyZtPGFCjMDyJL7WCBpXS2IoqVj/E9gtk0umD/XqUuEmCwhmYPaN?=
 =?us-ascii?Q?A1h1ywslm6wYUCXyMATQNTBwQRox5axKnkDHjFS4FLpBugs+w59vh/fFsaUo?=
 =?us-ascii?Q?EuRrQm9GmzGslBEbZNQSpd83hW9N7SwZ1NlZP5Ws2H+tFWZHaj2XHXw8ThAE?=
 =?us-ascii?Q?YfykZuXulJUoEMkSb0XFJSaK/AupVcDMwk78tc2lLP7oYj5ooc7JGi6rgebG?=
 =?us-ascii?Q?wGNWPPN1P1iL5TA8wbSFE4hgkn5ekHS4/xA9Nf/DOAto2lU7hyqPev3Q7oN1?=
 =?us-ascii?Q?E4hwn4JZ67sMUIN7yXnKfH3r2C1NEP0AinUXMWWB2y1Sm1B+J8Fp3x5t4BDp?=
 =?us-ascii?Q?xzVJcxxhXxWsJrdAV3KsWOMlTVLiXkdvok7mLyhnDVKTWL3Rd23nzCaMsD2x?=
 =?us-ascii?Q?TS7m2XjQ6QzffRS5KxWyN+FZ/+xwrPVC5wrPYr/GYxHrxZyPXx2AEoimEnt1?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8a049f-bd19-4faf-f28d-08dbe4fbbedb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:23:29.5004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bvxlyj8eOKX50JF+YJFj0b0qIx4mP+GDE2pb18OSgZnW6bqyPJNLRnIdWD8b9Tr5kFeDfSDkBK6cBKguhKVk+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

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

