Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D07E2CA8
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="kAK0gWS/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBkYiVxHaubW0KIr++aYxbSqjCRHsvfZTvAfpy6h4GlRLjGWyQIKp/Tdck3DYpT6GVbr3XPHJXYJDTHv4JwVDqnHQMcYpb98pFGhH9qHbFJmQLwNGR2EyZNWChqKwSVD52MuA9VZ3DmJGkZsS4gD/uCv5qdez6/U85XidVNUkpnh/3/j1yCnzr3TqQ8I02NnBkRlKP3MsW+ttbjEQHd2/o+DyJxhW/yqzA1o6b7T4qp3Xn5Amhpon2HtCxpS5m6eRsfVK5Y0bJWuDk9nmjiGD6OLeQYKrjUc+jtY09u5uqWKdbgULw0THJHseMUI10mqt4GXy28Wha7xSfG2bpyIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rY8CNmC+Rrmivupi971oztbQaGCoCWTB7Bb6IUjC6+4=;
 b=iUJMmnbBPSRY8913BQhakIUn8nCiMaBA23VtVfP3JYBwpOdwwCqS+2VB7pLXR2aF4wbNIDUYlZWhgtfwh7Ci1aB8woW32b1xdKQb/vH2AmHeRIBU1UROeQiWCDN9FSHrkqZrRf4f2n5Bp6I20YmiIyQzTnB5xabbgpfeXkuSsamqVxRdVD6ifeBwGJRlirhk84Ev4wUbhGCw6SIhhBinfMaxvu+8Ya5HfIUYCYc2snoz2vxPY+ZMDsSiUy31pBGYpMOo5vXWTp97Piy60qny+vFB/EFge/mhTs4HpvQQsmMKn82GEhgAZEB/KQossDCAcUvbby+NuX681+tAiEOYSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rY8CNmC+Rrmivupi971oztbQaGCoCWTB7Bb6IUjC6+4=;
 b=kAK0gWS/wj9KOVc350ny3huakovTTeTfoVH5Te+kFgmj87JexrZ5UpNcgo8lIGo/Z/g2piDJpuYvl8lzLOXaaZ48qU0xSFK6Y5+BP6Uo375LH6AFhjlCAcBQer1Jub111HWAyNjbOdyOf6x3oAr8lju2A79aVaBlwyXU4CCucpP58SK3B5i9NT6HwoagQc4MHn18UXRxejquist8dfT+uk3IQKImKjlFYx1Rjp274KFVgzjOAqcOFlfviO9CaOVwB/kB6XA2dxqC58QtJEY8R+SslynCazB7gJBtwnGsEgJudXhbesJvpvPGNSCkW8WpN/tOnKuaw5Hch6kQyaCGSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8803.eurprd04.prod.outlook.com (2603:10a6:20b:42e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 06:51:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:51:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 13/22] selftests: mptcp: flush userspace addrs list
Date: Wed,  8 Nov 2023 14:49:43 +0800
Message-Id: <903f1300236dda5d806a612a27d12678b4b5f8c6.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0111.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b612376-5f81-4f2e-65ec-08dbe02718b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QXG7NWGfhhyszebjeRp6KBsexYIYSOZLTJzjF5/cxcrWCc5p7i/KrwTiOU0r9PCRtDNQ+M8mSQBXf44RDCq1foCKtG2KJ7Ou8LpQaRBJpyZiC/PEwEmDF6dgya5stYctx/Z3A70RiP93aaqwcqzFCxmP+IdQx6xFJInySQQ/7qHpFstI9IrvRTT2n8CMudqPlQs6mMvxrFocTXW3mEM2SHEKG9AZgjIhvY3qBCIa2O0mC48JYZUdFqeG0W10dXWMyM0AGuGh+PseKgiFEDtCGqOUv2JqZ/D6IRYxCaZzfZRiWpaA9jswYx47tj8jasNtnCCd3rhWbaDRO9HRrjxFVPHKl6UWOMcyBl2g/lAzGM9nQ3R2/NL0XPcnAUfxbfXz0sXsDEhVWiVVq2WN3fgSBcYrDyxakTnLYsvttNslYEYSefMgmIqpg8OrTs3M/88xztcT0Az6S5QqeFb1C6vYR/wap7wsFDBAWYYnS/5EuXvqIntTdBdJggDEi9yaNT+LBfjoJzwImCTz6+zkcfF1T89aQ6YmWZX9oEGZ9oddeK7OFmthUMZHMWbGGbl8gKHGC+afTnz7qzr15Z86cqiz3VhgzHNtnp7amlUebAW8FyY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(6666004)(6512007)(6506007)(478600001)(6486002)(107886003)(2616005)(26005)(86362001)(36756003)(8936002)(44832011)(4326008)(8676002)(2906002)(4744005)(41300700001)(5660300002)(316002)(6916009)(66476007)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QpEcxvfO9GdwkSr5ObokPYa/EXUYiDem81GWw81fgG6GqyfmY8K9WIoz1ZqE?=
 =?us-ascii?Q?oEoQUMovlNxidmGqBejmSdUhjrrdTzzXIaLGSb+3oaiY5TPmqC6FZcuWQiFf?=
 =?us-ascii?Q?zX5rrtp+p04hR764+Gbp0+XGNspPrmaddoCqKTIUxDD3rhZemkNnf3wY1BcN?=
 =?us-ascii?Q?TRbaTbJScyNkzDmbHl8fsnW0eUOQkaoDu8gjqaIQsJ4pETliMdIPPmWerabP?=
 =?us-ascii?Q?Msc/b2VbySea+PMLoiSFJxnV0zPJ3Y2Xa6hdvbTqr4xQlavj+lSH7wpCtdLt?=
 =?us-ascii?Q?ZI1uuaHDmHQDhBwssxUmZA0qp0Tzsekj3DrLO9NF36Ccf3lrrMHN7kWqJZ5l?=
 =?us-ascii?Q?3H8JrfDZj7VnCQXdsr0cLyVilr6IWBYArHZYUl40d9kubRpCLJMT5jAu6Iy2?=
 =?us-ascii?Q?WFguKiQmAEJoqeyFhRUP/eHn36YmUCHNtiaO85t38Hu5SQSTq24ukHDpzpOw?=
 =?us-ascii?Q?HLg8NEtGASEv8HwzjGLomVRQGZGu85UR2cOcz3UP2CuHEabeLJp/RpnzBUTA?=
 =?us-ascii?Q?9KTg/okqhWyWGNVWc89KVYilK9+rmO7d9ne92hEKPriibZfsvBL6ZO0KNhbI?=
 =?us-ascii?Q?BhAM9vOT1b89iBhpsmjej/+uki/XoXGip3DVo+WT5hS/M/KXTwSBqIOx72Vi?=
 =?us-ascii?Q?PLICTLvcKfYrgbesLJ6ZdbUhp+ZOxoXR/s9IuhVXiw0ipLnRYjfu05pL8azB?=
 =?us-ascii?Q?Oc5AuSXdOdAJfUT0GYHoFsquQLlQE11x7lGq9ndd/nZDV3g5xLOv2iOVQ1Tg?=
 =?us-ascii?Q?Pe2vANrckGV1XxQm4XbU07EO6DSvo5FzCYpGNskbosiqAPK1h2J9Binh+eyj?=
 =?us-ascii?Q?gjmVIeP8bWPyuyr4CIbL0wCzzdaoBWEldnkESRLdkj2crvbbPVlWKHYuT860?=
 =?us-ascii?Q?cz/v7LlYkZSj8Wq3WN8RV9w2mYU64OxAZS4ff2kP+usyImWkj69MobWi1i5i?=
 =?us-ascii?Q?gj6CX3y6OAQE8ra3BdduXZ8mvIU8cxm1KdDDr+J3DpcjOn0AF8TLAUIXFhUi?=
 =?us-ascii?Q?hzAh0BEyaUpzyZ6/Hj0MBlG7UkFUPxMOLxUnpC2PfKFJMYdK+hhYj33B1f7r?=
 =?us-ascii?Q?f4L2W+kbf6Q7CcGJGs/Je1mhlogy/DYiUAQGyTd0iMQnPzyjB6kDqdUhjWkq?=
 =?us-ascii?Q?IuK/MQDQPm61LgUqPtT8YXtRL2rTQxgU2uCELRIM6eRdXhuoE5NnLRYvl3Uj?=
 =?us-ascii?Q?lRDfCail3juq2+3BNk07h4oxJ52S1kEw0lXlslHN1nRW2jXA/VDol4DFGOoB?=
 =?us-ascii?Q?nIDAXznDCufpYxUPPFpsShfcn4bezkBb9/i8ZhBHwwb6QaHkbfgFPTMA1j4o?=
 =?us-ascii?Q?FqbekTw0RFxNQ7IATt9peCjqQSQwdL2ySp44sN/O9jjiAHMx7KZI9y2bS5hc?=
 =?us-ascii?Q?N4k6KQLBcPkZAy2/LpVbiqJ2TAXvKtWEI6lfWvinJtTQt425L3HtqKHpdxfq?=
 =?us-ascii?Q?1NYMItUDnbb5XUBT1FO9nKhLoD6kW8/e24o7qkQ7ikwwubbLkNY0VQNTPglD?=
 =?us-ascii?Q?ZGdCoFu5lPkrM8q25ZYX9kQfXEIN8T4FfJf6nNtHdDPJzycl2zuutOgkC1Mj?=
 =?us-ascii?Q?+YNopCEAuOB3Il7Th0bWoibR/P8i5pmjwcvZKrCIWPc788ueCuNceHGb3gBZ?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b612376-5f81-4f2e-65ec-08dbe02718b1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:51:12.7394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aS+T4VnDSWyPJQb5f4xDKmoKPvwq9gykhe2rPKGAoLy/Xh8LLA1maKaaeFemyuXupycronThZv+tdGhd1TV/0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8803

This patch tests newly added flush command for the userspace PM. Add this
command into userspace pm test.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 581d61448253..634b51e40435 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3442,6 +3442,9 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
+		ip netns exec $ns2 ./pm_nl_ctl flush
+		ip netns exec $ns2 ./pm_nl_ctl dump
+		chk_rm_nr 0 1
 		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
-- 
2.35.3

