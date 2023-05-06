Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477A515D0
	for <mptcp@lists.linux.dev>; Sat,  6 May 2023 05:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlR85fxZozqzmTI8Lp+HuOFDPMz+YwjntQLd4bfWhu8tNU6wZqQDMHABZm0kl1JAgQQJB74WelluCyhhNuUNAELNCRvbQ8T/QtRL1TyxPF1bFzPoWhGLMz0jCViZXo9pFccEV/9L2zwXQhc0DpktUIwP9pFipMasqT4sU7qWLXAf+ZtqKjb8bF8yoRuIlqDnnzc32xC//a94vM+waQEdwbVaal5xXBslu1wNvCMfDjodb7ugs4SDh8P2bW6d2m9NgSJTsfxO3N7EXg+9QR/HOJrb2ivgkaN5zkWnjAx6aOFFBMYVVTAy3SuotlBlEVEEgG+y2i5ZIkmAArrd0IP2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLL3g45CTOF0rqU6goiJ0Dt8IxnCpoMUiDN7YZ4Jm0o=;
 b=QO8Kd41zs3Xh3RFU95kUNULAV1C4LV7pxFPs5hKAA1kaBhO8+ejN3H4/lLKfGfQFjSX5KPUJWRgk8khRFwwy0+SQSRG2Emvy+FmacxzGX/pvePtldidVhB4kNc3/y27Do4mWk3IDi96aLtgKy/2yJ4ODxzumaA8TgudzHQAmJWERRgjY1FS0TbgniEzoe58H7mj6EcN3dJuA6R83SUd10jwjo/w6I7d2wmg5u1wiIVO7T4Z4/ts7umAKg9WTT0irCv4IzKcB0Z6BF8lfzA2IkIlTr5PA+3TqIGgRoVdBJ/JzfV/aQwP+NW2u0KJ4C3EvC4Uz5q8SBEc3MjbOv/N9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLL3g45CTOF0rqU6goiJ0Dt8IxnCpoMUiDN7YZ4Jm0o=;
 b=rBgM7PrL40wfx+c7XC6i0FnpYLLYon4qFrrQMh6PUj8lTLms1qHYu9iS8zJDl9ewvnyGmOyIrtA+4OB4EvPtEq3WFLCj8NScG9Y3OgaQvCcn3YkywzAYT6eRdeZoHOGl9ra4WEtwOm+/TD8yOMmfwAJu+16ZV0oa7Po6lZW1NJYg2tME1R094TbNqR8r3KDncWoCuLO7WK3PBcCDwkcrY4n6rlkbdH9nfZHbGG4bcvu0mslPgvyQqtZwq8whVA/okJrkkCFdqCBIso0M7n/WKeWUPvNZJcbdwOVZi1Tg9yxdwbcNXuwdnd0YMJEQGyoCK8o4iE/TSbEBGwwvzfhEug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 05:09:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Sat, 6 May 2023
 05:09:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 05/12] selftests: mptcp: update userspace pm subflow tests
Date: Sat,  6 May 2023 13:08:53 +0800
Message-Id: <f98bc5ad27c19d7e12bb852cc659805feefccba2.1683349666.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683349666.git.geliang.tang@suse.com>
References: <cover.1683349666.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 27cf5ecb-f2da-47ff-59f0-08db4df012ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cEZFw4w+X2HKFFkN2rCKBvJQncgCP1rbEMz9qPoodyYyOKypVQnFqG8+xKWEeB1a6bYl6VV6xETntsEBOpaC4OCM4WrYeDgWMBJFbEBOxa69pMVQH9RlFYtRQ6pwRVxOLMiQSc/RKf8r0abmCk4bm3YJN+nHth0SWnXcfIYHrq3bC2VdF7bFZo7FARYytWgxcRMRPGezzuiZ3GtFf/CB2S1MMizGYqjiBq/6CaZlNLi7mAaREPEe3yNwqAt5C2zQrqV9sJ3QXch0Hqv7qJWu8d3ofU682GvV8UgD1buGh7+Vdpl/InTwOovhpWpl2I26hxwaQb35/lkHAcYxlrofQsrTFnNIrn5ZbckbIomMdp6gyYQOkvNHNtNZDFFqeMyrMQQ4vX5kGI68+xzj4NWaMoD29jVeXIZlHE4kxGjrMvnIOUooaDyiuojWZ8B+qG+IuAAz85OJXpimpqKlcaSN7rcUk0xSsgWhRAAuMNpyk2Lo4QpT5JTH7YPj21P6V+Mye9fw9v+jdtqKyrViYhx5aB1RydfAnw7rfmdqj6dsiko=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(5660300002)(41300700001)(44832011)(66556008)(66946007)(15650500001)(66476007)(6916009)(2906002)(4326008)(8676002)(316002)(8936002)(478600001)(6486002)(6666004)(966005)(83380400001)(107886003)(6512007)(6506007)(26005)(36756003)(86362001)(2616005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E0ruDic+2P0xxLps3XMECjojnW4V7npJqMKa0xSYQ00VF+vJPfYkhob1+JRR?=
 =?us-ascii?Q?OCfPd8bp5vzQLF8iz8Eli/q1Ast2exF8XC04EepcwE59VncL3iOK79MBJHHc?=
 =?us-ascii?Q?jGlv6MZyBcFHEp/mJ8JzwMZsuo70ViFvqAs+msX2Vy8DohHhW+8ZgcvF4RMI?=
 =?us-ascii?Q?iBK8bSnWwkmUnRr14BHHPdZNdOx5sayXRcSIIoz7Yv0B+s3iI98SWmMQ8+WR?=
 =?us-ascii?Q?pyTKMAFM45y2f13vCzcCO+U2fQfknzZ1cOfIsw5V4L6SVuuv8Po7LQwr992W?=
 =?us-ascii?Q?044jy9rSXMxDzP/KeJe5T6luD73j8ms5jAVNuhQRii9XBhW8ltHqv4wX6QlP?=
 =?us-ascii?Q?LqkkZdDeYY/1dZIMaygiKtpZv33Xtake7K+gdMK24D7szp0NhgYDOLzSTCtu?=
 =?us-ascii?Q?MalLUPz0uu3s6/RE9zYijjC7LPls0ndl7sDjr0EqnIvQAFS1IMcxZxS0bTND?=
 =?us-ascii?Q?FVIEWxbPf5b3ouw1reDxqkRc94dpjoQzHmRsbEosLvm7sH5ylHUlrF4yli3K?=
 =?us-ascii?Q?lgmeOpT54Wri3tYSO2EWSY0kDpGi0FHw+eh7pbcaTj+fWjmS3vcgFZsTej/a?=
 =?us-ascii?Q?ZsWq2qOTBLyQm4gxor2P0qXk+NLwhdFaT5Z466oqlVZhNQlhDfdEQOZI3PX+?=
 =?us-ascii?Q?/aQPtnmhYLl9uCkxx+YGr17ne/SE5YA/bf4y45TMBlto/P1KNmCa1+SSR1EJ?=
 =?us-ascii?Q?UM0rSpq18UZbGCiu8Nxl3HIyFvEjGhhrHofz7mh8/DWudkZQycVw7c4olby0?=
 =?us-ascii?Q?ah3AcdpVoXpxih1w/BAkNpJ08yHSCAtGuHOXLti0/WTjcKxDJvxHuLoawkzB?=
 =?us-ascii?Q?rwIHJ0IfP2NgeSFqLc+WPk7UXqx3+lL+zuk3y2v6cAujrH9tKuukXufyTIQ5?=
 =?us-ascii?Q?yBJw4EluT8NAEprmCby5nbH+9HOHlTsbvTUPsUqudE0u2oLsVWthnJjVKmm+?=
 =?us-ascii?Q?+vMEQvhZ6rPcgZaqYdTLgwjdqv3wncO9FiITaOHKgWahVvXiEwcpv3i1bdGz?=
 =?us-ascii?Q?QnvFytWpX8kCh8eTkS9RFgDak8X+w+Ak4L2Mgw651TQC2b1FjPUK7DT1Cf1v?=
 =?us-ascii?Q?CYn9EZcwDM00DySM/+BPGyO8j2ungCzv5KRcr6QLEyasD9xooiemQo4WxaqW?=
 =?us-ascii?Q?cJgp71fozML6Ok/imPPzS+FYBHQvPuZLDnWuGRx4U10cELjSjHVOlujPv65O?=
 =?us-ascii?Q?SbQaQnCm1rVEvGo4J/MjBtmVqjfFRk+/DvTc7fMixhHQ6yY+pG52VBpzdZx5?=
 =?us-ascii?Q?OYRNXUXQaDzyhNZklDDEb0JuiSBt8kC7wSdmD+FpjMj9SVqehFVhei5wFxez?=
 =?us-ascii?Q?CuY+zDBt86Og0hzKPgxjNvXX9QlJD1A5ID6BStQZHugbsSh8r/MJ7gzfXFMd?=
 =?us-ascii?Q?ACb/w+9cOjKeffVZvnI1o96M5kDNKdO72M+HcM3FvUeyxSdrCy+UVd0m9UuH?=
 =?us-ascii?Q?mYj4ihMxKIlN/wJEm6ZRWMTfmFqf/f0wMAmbpxTe613DGyUjiTxg9mmUYmQO?=
 =?us-ascii?Q?xKosQNClpvmcxVSXA9Kgl9XycK4cqEDHWdr/HSiOrBdcZrIZGmRpIaJ/chiK?=
 =?us-ascii?Q?XQYJkaYUzx69dPmeCD/W/YkUF/t4prtIC3m5C3/9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cf5ecb-f2da-47ff-59f0-08db4df012ee
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 05:09:30.9527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOlRKTwbH/1WOWWc/NdtNbZW8V6I2VMPVte3E+w2sR3UvSu7ydVyaW2L3KC3cK0F7JnupdTuXRTnavBnnrrxqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

To align with what is done by the in-kernel PM, update userspace pm
subflow selftests, by sending the a remove_addrs command together
before the remove_subflows command. This will get a RM_ADDR in
chk_rm_nr().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Fixes: 5e986ec46874 ("selftests: mptcp: userspace pm subflow tests")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index cb0ae133f5ed..2dee1c6ea932 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -937,6 +937,7 @@ do_transfer()
 				sleep 1
 				sp=$(grep "type:10" "$evts_ns2" |
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
 				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
 									rip $da rport $dp token $tk
 			fi
@@ -3152,7 +3153,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
 		chk_join_nr 1 1 1
-		chk_rm_nr 0 1
+		chk_rm_nr 1 1
 		kill_events_pids
 	fi
 }
-- 
2.35.3

