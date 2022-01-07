Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6C2C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 05:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641534742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Cb7LC4ewgL/vQ75LhaVxDWKT788NzzjQeQZm0BxCB4=;
	b=AK3dze777phJe9V3W7TYlJWGNPwUBjvPM+77cZ7s8uj1RRBQkU6GecKph4VTKqbwulpvdk
	PtnXMGOasRv+NzUQxkbEHDDVkjXtLoAUvbUIeI39NRHBjLOrTVuo7t/EjMoUqUf83uye9Z
	fkO4LyMA/jinDbEwQi+0BZS2glmv5Z4=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-MamCvV3qOy6rK_kbSOS8sQ-1; Fri, 07 Jan 2022 06:52:21 +0100
X-MC-Unique: MamCvV3qOy6rK_kbSOS8sQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8+DYKYrnTxt1GVaicjjQs64wx0CDeY65IeBV6ilN5TuP+zHKs+n45gwDA8HeTAAL1wANI/KJJCUN9VMIauoybTFBfPZOIRHukHKoBMVIvdjnrhlWgWMT1NRRlec1F4X8QciIAlrM9seDDKhv6vKuQkHOtVxNsIQuEC20B9K7C5t1ePXs2kMg89TUM0Mb5d0/wwuJ7WiQeNEQU8TuaA6iQu0e4gpq5vjqKxdohVWHspx+5nZF8ma5gz3NzblPr/55IsvF6dpAHPyrTrA6yjmj/XfMoxU8P7eQ6olQlI9gVkBMvc2a8gLWR7n2buY9HrJc2Hbxk4B45hND6+Y256x4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBGulzsGm1LwtiZLMGMyt/BKuSoMQlY7NDDb5yRlzmg=;
 b=XLw8/9Emt8095cZAXlRHM0/7PGmy7tUf9/1vthvxGyKUWlkvbwRxrELfF3t4QQcXQsqM1bP2bSbcV6uBX2eJLjyax503K1TNVcyRF3o3w4C8Fl+K1/eQHe3OS38fgsM7HszwI5dbuHeIAd1n7FBqeqWyCYWUmEBetqrOYT8VVF79FkkD2sKj1A5+a4M6CiLrKvgTkSC9b7Ve528tqubO2D0PWur4cExIqWSoCOUDzKGhiYhTyk/i0nWCGLsd9a88DKIo1BcFW0KqL3LxYMTvNp/NCrEt8sA5FbTKDtQwEIfsWXwcjeSWmJFX6OpPbgXjEGY/p94QByQkzAUi38Y5nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2731.eurprd04.prod.outlook.com (2603:10a6:3:d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 05:52:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 05:52:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/9] selftests: mptcp: implement pm_nl_set_limits
Date: Fri,  7 Jan 2022 13:51:45 +0800
Message-ID: <f4d5d1b1122215ce7a1bb723b96206852e83e01f.1641534346.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641534346.git.geliang.tang@suse.com>
References: <cover.1641534346.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:d0::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32c7155f-bf77-473d-24af-08d9d1a1dd61
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2731:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB2731C65E92E565D6B486D833F84D9@HE1PR0402MB2731.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OZ5WWAIvHpgVI6RUWZjV+YC0e0E5WlCwnM47rONHFk06nOgRvoHigdnqPUq8f1FczNrBQ+oDKN538kya3ChEyHyrfoICs16AHxcEXnnRyHhjDLK1tgq+IJ7dmaf2PX6lfA4zbFLOaV0p0p+AdQOKBc+g5cuFB0QMIuW7v9tiWZuo62mXkElBEEK/JdEiqfvildcIYz8424NuE5aUB5dogX+kwAuTkLPG+iHP0+2rQhDmRwv3xZjF8YlhHJU8QSNmDC1H9pxGiBm7s9f/bXask5ORJ4HfEZ+CKSBpWf7NAD/2ivhD4/pJ5tLoBHxmA5jmdB/uxMVzM3cF7VrrTBKh9KSDSm4U0DOuSz2y0wjMn7sZ2UsOK4ZugmkUPQXm5NgvctspUg1F79e2t7xBjzFf2wiP2J15KVS+EyMInvm12JxN0LKSPhK7r5nlHpL3W15dhis9EEeSeEJHBe/PgbDkG2xxKiCgX/jWKuRh/IX/V4rh/srFWRL8dgV/S03avI7Vw+SH5AAsw05veJd4WoRdi8AMZIkIPnBWrFs3npWAzb/VXejFJ88+JbLB8U+dhq+n8IK7vdC9DVbaL0yij2uoeWMKIC4FnFnsSAm8DdRwNEs0hsTHo42EWcPumnF9MObP/QwC8GmdqqtMbSfdmTDAug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(36756003)(6916009)(8676002)(107886003)(6486002)(6512007)(4326008)(186003)(2906002)(83380400001)(66556008)(8936002)(44832011)(66476007)(66946007)(2616005)(6666004)(55236004)(30864003)(5660300002)(38100700002)(316002)(6506007)(508600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ilK6mwS5h5poEl0zk1NVe4kywgy1Nie3jqMAahWotfFihDzwo3FvnQ7nDg1q?=
 =?us-ascii?Q?wwqGBlCNajQsJA0btlWJ/XHfUvAebl/V+0ZWlI3P9aG/YI/w/ah1MR+a1YbX?=
 =?us-ascii?Q?y2tBfqYqhrUJUfI5l/6AP92gMmcSCPnBNfWm40kzH9b7AXSWtsAB1sZ2VwFk?=
 =?us-ascii?Q?LKjJVwkIqP+CxzcuwmF1J6dfjnHDgz1bX4mvLS3dEjQk+a8NkSXezE/goTfi?=
 =?us-ascii?Q?6F7JH0XSlXw4zZ8O9GuVtoTQGTQ8NSmpA6gmT4eAeenRKrp3B1irrFRB9Jhj?=
 =?us-ascii?Q?JAe9kIwVDwbDgcK+eEKydYb9UQFMKsJ1buYd4H9to7GZiU6/nONcXt95wY5c?=
 =?us-ascii?Q?+c772RK1tath/sVCV385JtxL8cyxMiC+dVQFFZFRBiQCGcMkLyB+R2fJgyLD?=
 =?us-ascii?Q?niylmAuDypewjZjAqj/OOFII0tsHfc3PTmdyoJ9eCcJxvW11HiAE8MGeU9F+?=
 =?us-ascii?Q?W+UgiUE0To7xpSK7ig+K5q74IBUYg31f/dgxiWblu1wutHvQsPhbfBDM1qtY?=
 =?us-ascii?Q?NWn+cr3525XyF3wU2+lN5GYVrL8QjRqPMt7y+adTciNnq5vV/282Wg7zUUfO?=
 =?us-ascii?Q?ZC6w5B1E705/d+ZuV+w6JA91itx9BDtpMMKFgUGyz2ta+t/dfetIBvT+A0fX?=
 =?us-ascii?Q?OSSQ/Vc35FB+H0g4UJQt5BdEXy3yqjHSZZQWr8MJPorBB9s4NFllCakcdAiS?=
 =?us-ascii?Q?FssHvztXs9WA+ffVioO6tQ/7deM9nd78ni6EI4K8TVLral3VgJ1nCqm18LfU?=
 =?us-ascii?Q?1qLzXRWKdycu5WeeYeIcW7/TmpSO4QHsozrh9DfTPyVlhKvsdvDyczB5+zu3?=
 =?us-ascii?Q?0O2VPHZO+Dg5Hf0NVm1gJtrT0hP/DBkrwv5qhPZDsLo9Xd5Nw5bgDewu/BuE?=
 =?us-ascii?Q?xLZZTqH0Mq5KUuYTE9tQmXTPYLHI1T1MMOeaVoNmPR+C1yaxLFtponLEtyjc?=
 =?us-ascii?Q?UqdQMXo1HQx23DQytHtKVpnPHbKrJHaTWrcxbJIuZ0toXtouvJayIfTOHzMm?=
 =?us-ascii?Q?82tMBkwaprHQYG5OHvpwckNOSqd+TjvpQrx0ixkNPwIKC13YsEyxuv0ZfsAu?=
 =?us-ascii?Q?A5+8J+ifIwjNRgAFOTCkfVQ5efRDsik2AeKj6QRPBDNx5MoAP7v7IyUulrTx?=
 =?us-ascii?Q?trUynr83qbBIEWNUpQ7EfNiIMvPQeYqzTVS2oITdoY3NT8M6K9neUdPu9/FP?=
 =?us-ascii?Q?kUjq0ORzrngMSoqJv3yxYWiCyEA8VJMrioX8Nhgok2ZFEP2UZ/deyLK63dy+?=
 =?us-ascii?Q?2vdlutQqkC08YwJXbx+1FUMRjT1PRPUnZ60hm0/i31pDpA3mmlrxDPs6CAmm?=
 =?us-ascii?Q?3YkKN31xsm0rTJHZhIaNM0e2FQWYHcWWRp/5GrsIBF03FJCZMjC3pxYQaSI0?=
 =?us-ascii?Q?eW+g2X9O4g1qiqtkQKY6McK6TOH5Ym3x18/rAf3+mkrFI4albV4pcILJSmaS?=
 =?us-ascii?Q?xFjXF0RstIM1l5L11AY/kqsgLx2sC+gbmpOgBbQPQKud6h+PdpsyJCu9Dn03?=
 =?us-ascii?Q?vLMKpcjDvqau0tfkUyMsecht33i4yiusMsPzbAwP5iYj4KiAHaJlQFuRihFr?=
 =?us-ascii?Q?0bdnwEM/9mbzfa1aVjk/n5kZtxG+wbhCEDRaB0mrus9VE7i3ISOaTCWUg0nF?=
 =?us-ascii?Q?mS5ZvuT9tIxSgLQlZluyIdo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c7155f-bf77-473d-24af-08d9d1a1dd61
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 05:52:18.7456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63oR0fPxU1LAvx67fWoUnExYNE4SJb21fqACrEYgGEEVEjO5oBbP2Kwl1RoNsl0g2blM6hrqqWM1j+UJr62unQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2731

This patch implemented a new function named pm_nl_set_limits(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use for the PM limits
setting.

Used this wrapper in all the selftests in mptcp_join.sh instead of using
the pm_nl_ctl commands directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 378 +++++++++---------
 1 file changed, 196 insertions(+), 182 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 5d8b1e475127..9a571665f7a1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -15,6 +15,7 @@ timeout_test=3D$((timeout_poll * 2 + 1))
 mptcp_connect=3D""
 capture=3D0
 checksum=3D0
+ip_mptcp=3D0
 do_all_tests=3D1
=20
 TEST_COUNT=3D0
@@ -278,6 +279,19 @@ wait_rm_addr()
 	done
 }
=20
+pm_nl_set_limits()
+{
+	local ns=3D$1
+	local nr_addrs=3D$2
+	local nr_subflows=3D$3
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp limits set add_addr_accepted $nr_addrs subflows $nr_subf=
lows
+	else
+		ip netns exec $ns ./pm_nl_ctl limits $nr_addrs $nr_subflows
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -1023,32 +1037,32 @@ subflows_tests()
=20
 	# subflow limited by client
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 0
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 0
+	pm_nl_set_limits $ns1 0 0
+	pm_nl_set_limits $ns2 0 0
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, limited by client" 0 0 0
=20
 	# subflow limited by server
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 0
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 0
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, limited by server" 1 1 0
=20
 	# subflow
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow" 1 1 1
=20
 	# multiple subflows
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
@@ -1056,8 +1070,8 @@ subflows_tests()
=20
 	# multiple subflows limited by server
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
@@ -1065,8 +1079,8 @@ subflows_tests()
=20
 	# single subflow, dev
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow dev ns2eth3
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, dev" 1 1 1
@@ -1077,16 +1091,16 @@ subflows_error_tests()
 	# If a single subflow is configured, and matches the MPC src
 	# address, no additional subflow should be created
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "no MPC reuse with single endpoint" 0 0 0
=20
 	# multiple subflows, with subflow creation error
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
@@ -1095,8 +1109,8 @@ subflows_error_tests()
=20
 	# multiple subflows, with subflow timeout on MPJ
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
@@ -1107,8 +1121,8 @@ subflows_error_tests()
 	# closed subflow (due to reset) is not reused if additional
 	# subflows are added later
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
@@ -1138,8 +1152,8 @@ signal_address_tests()
=20
 	# accept and use add_addr
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address" 1 1 1
@@ -1151,8 +1165,8 @@ signal_address_tests()
 	# used for 'add_addr' subflow
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 1 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal" 2 2 2
@@ -1160,9 +1174,9 @@ signal_address_tests()
=20
 	# accept and use add_addr with additional subflows
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+	pm_nl_set_limits $ns1 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	pm_nl_set_limits $ns2 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
@@ -1171,30 +1185,30 @@ signal_address_tests()
=20
 	# signal addresses
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal addresses" 3 3 3
 	chk_add_nr 3 3
=20
 	# signal invalid addresses
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal invalid addresses" 1 1 1
 	chk_add_nr 3 3
=20
 	# signal addresses race test
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
-	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
+	pm_nl_set_limits $ns1 4 4
+	pm_nl_set_limits $ns2 4 4
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
@@ -1222,9 +1236,9 @@ link_failure_tests()
 	# active backup and link switch-over.
 	# Let's set some arbitrary (low) virtual link limits.
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+	pm_nl_set_limits $ns1 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	pm_nl_set_limits $ns2 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 dev ns2eth4 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 1
@@ -1236,9 +1250,9 @@ link_failure_tests()
 	# for bidirectional transfer
 	reset
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+	pm_nl_set_limits $ns1 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	pm_nl_set_limits $ns2 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 dev ns2eth4 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 2
@@ -1250,9 +1264,9 @@ link_failure_tests()
 	# will never be used
 	reset
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	pm_nl_set_limits $ns2 1 2
 	export FAILING_LINKS=3D"1"
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,bac=
kup
 	run_tests $ns1 $ns2 10.0.1.1 1
@@ -1264,9 +1278,9 @@ link_failure_tests()
 	# the traffic
 	reset
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	pm_nl_set_limits $ns2 1 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,bac=
kup
 	export FAILING_LINKS=3D"1 2"
 	run_tests $ns1 $ns2 10.0.1.1 1
@@ -1279,9 +1293,9 @@ link_failure_tests()
 	# for bidirectional transfer
 	reset
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	pm_nl_set_limits $ns2 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,bac=
kup
 	run_tests $ns1 $ns2 10.0.1.1 2
 	chk_join_nr "backup flow used, bidi, link failure" 2 2 2
@@ -1294,8 +1308,8 @@ add_addr_timeout_tests()
 {
 	# add_addr timeout
 	reset_with_add_addr_timeout
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
@@ -1303,8 +1317,8 @@ add_addr_timeout_tests()
=20
 	# add_addr timeout IPv6
 	reset_with_add_addr_timeout 6
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "signal address, ADD_ADDR6 timeout" 1 1 1
@@ -1312,20 +1326,20 @@ add_addr_timeout_tests()
=20
 	# signal addresses timeout
 	reset_with_add_addr_timeout
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns1 2 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
 	chk_join_nr "signal addresses, ADD_ADDR timeout" 2 2 2
 	chk_add_nr 8 0
=20
 	# signal invalid addresses timeout
 	reset_with_add_addr_timeout
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns1 2 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
 	chk_join_nr "invalid address, ADD_ADDR timeout" 1 1 1
 	chk_add_nr 8 0
@@ -1335,8 +1349,8 @@ remove_tests()
 {
 	# single subflow, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
 	chk_join_nr "remove single subflow" 1 1 1
@@ -1344,8 +1358,8 @@ remove_tests()
=20
 	# multiple subflows, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
@@ -1354,9 +1368,9 @@ remove_tests()
=20
 	# single address, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
 	chk_join_nr "remove single address" 1 1 1
 	chk_add_nr 1 1
@@ -1364,9 +1378,9 @@ remove_tests()
=20
 	# subflow and signal, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	pm_nl_set_limits $ns2 1 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal" 2 2 2
@@ -1375,9 +1389,9 @@ remove_tests()
=20
 	# subflows and signal, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+	pm_nl_set_limits $ns1 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	pm_nl_set_limits $ns2 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
@@ -1387,11 +1401,11 @@ remove_tests()
=20
 	# addresses remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal id 250
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove addresses" 3 3 3
 	chk_add_nr 3 3
@@ -1399,11 +1413,11 @@ remove_tests()
=20
 	# invalid addresses remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove invalid addresses" 1 1 1
 	chk_add_nr 3 3
@@ -1411,9 +1425,9 @@ remove_tests()
=20
 	# subflows and signal, flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+	pm_nl_set_limits $ns1 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	pm_nl_set_limits $ns2 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
@@ -1423,8 +1437,8 @@ remove_tests()
=20
 	# subflows flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
+	pm_nl_set_limits $ns2 3 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow id 150
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
@@ -1434,11 +1448,11 @@ remove_tests()
=20
 	# addresses flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal id 250
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush addresses" 3 3 3
 	chk_add_nr 3 3
@@ -1446,11 +1460,11 @@ remove_tests()
=20
 	# invalid addresses flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
 	chk_join_nr "flush invalid addresses" 1 1 1
 	chk_add_nr 3 3
@@ -1458,8 +1472,8 @@ remove_tests()
=20
 	# remove id 0 subflow
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
 	chk_join_nr "remove id 0 subflow" 1 1 1
@@ -1467,9 +1481,9 @@ remove_tests()
=20
 	# remove id 0 address
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
 	chk_join_nr "remove id 0 address" 1 1 1
 	chk_add_nr 1 1
@@ -1480,37 +1494,37 @@ add_tests()
 {
 	# add single subflow
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
 	chk_join_nr "add single subflow" 1 1 1
=20
 	# add signal address
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
 	chk_join_nr "add signal address" 1 1 1
 	chk_add_nr 1 1
=20
 	# add multiple subflows
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
 	chk_join_nr "add multiple subflows" 2 2 2
=20
 	# add multiple subflows IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
 	chk_join_nr "add multiple subflows IPv6" 2 2 2
=20
 	# add multiple addresses IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
 	chk_join_nr "add multiple addresses IPv6" 2 2 2
 	chk_add_nr 2 2
@@ -1520,8 +1534,8 @@ ipv6_tests()
 {
 	# subflow IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "single subflow IPv6" 1 1 1
@@ -1535,18 +1549,18 @@ ipv6_tests()
=20
 	# signal address IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "single address IPv6" 1 1 1
 	chk_add_nr 1 1
=20
 	# single address IPv6, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
 	chk_join_nr "remove single address IPv6" 1 1 1
 	chk_add_nr 1 1
@@ -1554,9 +1568,9 @@ ipv6_tests()
=20
 	# subflow and signal IPv6, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	pm_nl_set_limits $ns2 1 2
 	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
 	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal IPv6" 2 2 2
@@ -1568,16 +1582,16 @@ v4mapped_tests()
 {
 	# subflow IPv4-mapped to IPv4-mapped
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "single subflow IPv4-mapped" 1 1 1
=20
 	# signal address IPv4-mapped with IPv4-mapped sk
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "signal address IPv4-mapped" 1 1 1
@@ -1585,16 +1599,16 @@ v4mapped_tests()
=20
 	# subflow v4-map-v6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "single subflow v4-map-v6" 1 1 1
=20
 	# signal address v4-map-v6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "signal address v4-map-v6" 1 1 1
@@ -1602,16 +1616,16 @@ v4mapped_tests()
=20
 	# subflow v6-map-v4
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow v6-map-v4" 1 1 1
=20
 	# signal address v6-map-v4
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address v6-map-v4" 1 1 1
@@ -1619,24 +1633,24 @@ v4mapped_tests()
=20
 	# no subflow IPv6 to v4 address
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "no JOIN with diff families v4-v6" 0 0 0
=20
 	# no subflow IPv6 to v4 address even if v6 has a valid v4 at the end
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "no JOIN with diff families v4-v6-2" 0 0 0
=20
 	# no subflow IPv4 to v6 address, no need to slow down too then
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 dead:beef:1::1
 	chk_join_nr "no JOIN with diff families v6-v4" 0 0 0
@@ -1646,8 +1660,8 @@ backup_tests()
 {
 	# single subflow, backup
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
 	chk_join_nr "single subflow, backup" 1 1 1
@@ -1655,9 +1669,9 @@ backup_tests()
=20
 	# single address, backup
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 	chk_join_nr "single address, backup" 1 1 1
 	chk_add_nr 1 1
@@ -1668,8 +1682,8 @@ add_addr_ports_tests()
 {
 	# signal address with port
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address with port" 1 1 1
@@ -1678,8 +1692,8 @@ add_addr_ports_tests()
 	# subflow and signal with port
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 1 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal with port" 2 2 2
@@ -1687,9 +1701,9 @@ add_addr_ports_tests()
=20
 	# single address with port, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
 	chk_join_nr "remove single address with port" 1 1 1
 	chk_add_nr 1 1 1
@@ -1697,9 +1711,9 @@ add_addr_ports_tests()
=20
 	# subflow and signal with port, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	pm_nl_set_limits $ns2 1 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal with port" 2 2 2
@@ -1708,9 +1722,9 @@ add_addr_ports_tests()
=20
 	# subflows and signal with port, flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+	pm_nl_set_limits $ns1 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	pm_nl_set_limits $ns2 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
@@ -1720,20 +1734,20 @@ add_addr_ports_tests()
=20
 	# multiple addresses with port
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns1 2 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 10100
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple addresses with port" 2 2 2
 	chk_add_nr 2 2 2
=20
 	# multiple addresses with ports
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns1 2 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 10101
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple addresses with ports" 2 2 2
 	chk_add_nr 2 2 2
@@ -1743,16 +1757,16 @@ syncookies_tests()
 {
 	# single subflow, syncookies
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow with syn cookies" 1 1 1
=20
 	# multiple subflows with syn cookies
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
@@ -1760,8 +1774,8 @@ syncookies_tests()
=20
 	# multiple subflows limited by server
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
@@ -1769,8 +1783,8 @@ syncookies_tests()
=20
 	# test signal address with cookies
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address with syn cookies" 1 1 1
@@ -1779,8 +1793,8 @@ syncookies_tests()
 	# test cookie with subflow and signal
 	reset_with_cookies
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 1 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal w cookies" 2 2 2
@@ -1788,9 +1802,9 @@ syncookies_tests()
=20
 	# accept and use add_addr with additional subflows
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+	pm_nl_set_limits $ns1 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	pm_nl_set_limits $ns2 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
@@ -1802,29 +1816,29 @@ checksum_tests()
 {
 	# checksum test 0 0
 	reset_with_checksum 0 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_csum_nr "checksum test 0 0"
=20
 	# checksum test 1 1
 	reset_with_checksum 1 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_csum_nr "checksum test 1 1"
=20
 	# checksum test 0 1
 	reset_with_checksum 0 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_csum_nr "checksum test 0 1"
=20
 	# checksum test 1 0
 	reset_with_checksum 1 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_csum_nr "checksum test 1 0"
 }
@@ -1833,16 +1847,16 @@ deny_join_id0_tests()
 {
 	# subflow allow join id0 ns1
 	reset_with_allow_join_id0 1 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow allow join id0 ns1" 1 1 1
=20
 	# subflow allow join id0 ns2
 	reset_with_allow_join_id0 0 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow allow join id0 ns2" 0 0 0
@@ -1850,8 +1864,8 @@ deny_join_id0_tests()
 	# signal address allow join id0 ns1
 	# ADD_ADDRs are not affected by allow_join_id0 value.
 	reset_with_allow_join_id0 1 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address allow join id0 ns1" 1 1 1
@@ -1860,8 +1874,8 @@ deny_join_id0_tests()
 	# signal address allow join id0 ns2
 	# ADD_ADDRs are not affected by allow_join_id0 value.
 	reset_with_allow_join_id0 0 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address allow join id0 ns2" 1 1 1
@@ -1869,8 +1883,8 @@ deny_join_id0_tests()
=20
 	# subflow and address allow join id0 ns1
 	reset_with_allow_join_id0 1 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns1 2 2
+	pm_nl_set_limits $ns2 2 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
@@ -1878,8 +1892,8 @@ deny_join_id0_tests()
=20
 	# subflow and address allow join id0 ns2
 	reset_with_allow_join_id0 0 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns1 2 2
+	pm_nl_set_limits $ns2 2 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
@@ -1892,8 +1906,8 @@ fullmesh_tests()
 	# 2 fullmesh addrs in ns2, added before the connection,
 	# 1 non-fullmesh addr in ns1, added during the connection.
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 4
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 4
+	pm_nl_set_limits $ns1 0 4
+	pm_nl_set_limits $ns2 1 4
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,fullmesh
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmesh
 	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
@@ -1904,8 +1918,8 @@ fullmesh_tests()
 	# 1 non-fullmesh addr in ns1, added before the connection,
 	# 1 fullmesh addr in ns2, added during the connection.
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	pm_nl_set_limits $ns1 1 3
+	pm_nl_set_limits $ns2 1 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
 	chk_join_nr "fullmesh test 1x1" 3 3 3
@@ -1915,8 +1929,8 @@ fullmesh_tests()
 	# 1 non-fullmesh addr in ns1, added before the connection,
 	# 2 fullmesh addrs in ns2, added during the connection.
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 5
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 5
+	pm_nl_set_limits $ns1 2 5
+	pm_nl_set_limits $ns2 1 5
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2" 5 5 5
@@ -1927,8 +1941,8 @@ fullmesh_tests()
 	# 2 fullmesh addrs in ns2, added during the connection,
 	# limit max_subflows to 4.
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 4
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 4
+	pm_nl_set_limits $ns1 2 4
+	pm_nl_set_limits $ns2 1 4
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2, limited" 4 4 4
@@ -1940,8 +1954,8 @@ userspace_tests()
 	# userspace pm type prevents add_addr
 	reset
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type prevents add_addr" 0 0 0
@@ -1950,8 +1964,8 @@ userspace_tests()
 	# userspace pm type echoes add_addr
 	reset
 	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type echoes add_addr" 0 0 0
@@ -1960,8 +1974,8 @@ userspace_tests()
 	# userspace pm type rejects join
 	reset
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type rejects join" 1 1 0
@@ -1969,8 +1983,8 @@ userspace_tests()
 	# userspace pm type does not send join
 	reset
 	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type does not send join" 0 0 0
@@ -1978,8 +1992,8 @@ userspace_tests()
 	# userspace pm type prevents mp_prio
 	reset
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 	chk_join_nr "userspace pm type prevents mp_prio" 1 1 0
@@ -1989,8 +2003,8 @@ userspace_tests()
 	reset
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
 	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
 	chk_join_nr "userspace pm type prevents rm_addr" 0 0 0
--=20
2.31.1

