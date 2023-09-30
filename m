Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF72E1C2B
	for <mptcp@lists.linux.dev>; Sat, 30 Sep 2023 08:29:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2iPBXS5889kCT2enEGQ6G6sQjhjIFu8WS5RkhfiGQpbiT0MD4hY0WPIWRhn86QpEEZijh+9BpvDqg2yQD0zlqQf7K7dGlz0aAHYGLe6IcbQOHJRH450Kn9Y339/v/Cq8y6yZ4vQQJ0Zg8w5xb9kOtGwRZqC4wrtrsg7mg+UznkSlol2j09qyZ2vgm23gfrDrTYZVghhmicK+5lJ36YJ3O9DQLZFWz9MEwN9VCD8L6rslW03TgY0205OR7OmcaY/wpHZK8rx1zxpUVdypUdG7F0ktMcRXG2zQG7us85KLo8qKJDhPwnjhk433lSiQ99NFNzeMdhUW+Ec2KgLCA9/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAfuuKsy5S37Jug0VKULAES2RR/je8WT9nmF1Lz5ofE=;
 b=c7yzogpFlek4U3PLHdodJvLNpuMaSIe9DdKqp3KGqZxhzWYF+iE/bEVPi9HM3hNI61WVnJ45OdygpPdpRdIL04+QVS4sP24v2tRnsD3d+F+8dVx/sCsAn5Y5ZIWS3POy7L72mpLNZlNfXJf3ptX0TaJ/jV9n4LnmGuwBISHuXT2CF2afiLRjkrQd3VrFC5C8LsJSnq5kuOyL62FqQ7fbu/YaTeHLDuetu/ege0zH2Ql9U97905amdhoabQ1qAHKtN0akHIPCLlYPf4D4521hEISdAsFETC7FNOOTuZAbricorA0mzykQPkJzcEL0PrzN3XoDrpyiKiIi7ZI62/YrBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAfuuKsy5S37Jug0VKULAES2RR/je8WT9nmF1Lz5ofE=;
 b=U+ImoLzaqeSVTP+5wkM4kLqgN0zZ28D6L9sFszgSOc6L+R8YyxDVSLO1VjhzG8DnHhBuVf0nENAXIFeV9UBnLJh/B6TYfRxLVXIZCM3k6jPP8FUsrlY+VLjK9BiAKHm2IlhRzkpsRvKFA5U0aT+CFYeCp6ZBbfKEk43XS9RrQqVqFG7GWXMlC0YsbVbdnN3vIIkKePgBYqX44Udy5sNHRCnx2A/JFI6GffgBte6c06XudksuaJgdnAaal3dHc5XEHjdzDHGRsYScIahuHvUJ5uaudJNkYZHrybLR5/aDzNFLgNnxPwI7KWmy3Y6kq3O8DvGA+Lp8yFCXF+uQ4KghzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9684.eurprd04.prod.outlook.com (2603:10a6:20b:474::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Sat, 30 Sep
 2023 08:29:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Sat, 30 Sep 2023
 08:29:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: update userspace pm test helpers"
Date: Sat, 30 Sep 2023 16:30:47 +0800
Message-Id: <7a8234908b8198636e231d1ce6e42ab6d5864d0e.1696062626.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0280.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dac22fc-4df7-4a1a-bb6b-08dbc18f6966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VmqnPT5VUBqU5AHeGPDyhPCkhrIIdvcSMhxHbgpIOmBgXfS1taIwkIZp3HPPlA465lcYn7qmruwISHDKQqL7/Tr06LJBvejdx/7WHBBH89x7Fssue57/7RELEptoAu71C9FboFsjbUyWecmDINjFmW23T0JEUAt0IqFgO9JyiRetednGzJXqkrmjNPZqrJLGZ/rMtDS8xTOmx6Z/l3cJ7S6Swqa0EMXWEOJuIn7HxaTQhT9B4d3/JDFB3p2VP8jJCH5RXTEdLN8yhS/iiwJAPhNVIxP6mgjWkWxMIv/WeVJrsNINWY/uk3/gpNL+O7u5P3Za6Pd3EByXbY5qBWZblo8RfLq6soG4EkK1Yb3HvJglAQM3tpn3III2UKct+RUqk4dXn5w3EmtlZgf9ooG40lxFs6p8hFV7zhWMAUui+tfsQ8YYfu/NbJIxru/fIdGr8cUV1TkT9dCbnfq2UrNMwjsuYnheNsLa6QHp2LobNL4q6gtW7jjaVYIPDjINk4BdsfHt+bJN4C4yZsPKq5Ou5/FerE44/WiaTELYRuKCgOrKAOCpI75Jn5FSXtlU60fPdXvwQlG1csWs1lr9LjGHutmJ0SWP653Qjr9bwS9z/DA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(8936002)(316002)(66946007)(66476007)(66556008)(6916009)(8676002)(4326008)(26005)(36756003)(41300700001)(107886003)(2616005)(83380400001)(478600001)(6506007)(6486002)(6666004)(86362001)(38100700002)(6512007)(2906002)(4744005)(5660300002)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?goyyxQoB0egyfM5VgQQLFYit3uIzuVAxlJG1LnlYcQKEjmohI3srTiXfOStv?=
 =?us-ascii?Q?/xBMrlJmwloVc4Pr+MT2S9smk60XK42YlrwGN0mX1/5hwSmyaCuJtQYUTKuK?=
 =?us-ascii?Q?wJhD4lp1ahAZoz8zwVhGIdwCmRcfuZmh0BGkcn4narcFp4w3BEkVa7AnaYj8?=
 =?us-ascii?Q?/R3bdpAG8rjkSheQdgExxY+htHVSSLnFDeHw6VGB0EIiMN5C3mdXae52/Hzv?=
 =?us-ascii?Q?5zCcKTUo0r1IkyGS6AI5foTNxJ5/aKlAJn99Llqb0qcvWsA+dK38zdJLQoJY?=
 =?us-ascii?Q?ct3qVd5LbX8UFCL7q2+qR4RJt84ryJe6xJYVcBxKmh9PC9lJqQwmDEKjH4Qw?=
 =?us-ascii?Q?cUAYw015gB1sqa/GHa3nEW/L88Sm8cYlYHk2rzgscCJ0G/5cuJ4PuJJ0mRqQ?=
 =?us-ascii?Q?Lt9TI6gLOeRyi7GkyFaElbfAoVwP05SssLvSMcPTcjwOegUqAKCz4VjXYQ+z?=
 =?us-ascii?Q?8qBO4o6X+EfD0cILqpui7BUV9LDV41KzZWBgPd0SU/AEDTIIJUaGRICO5ott?=
 =?us-ascii?Q?uHCu85c32+Nm/JsuZBQ/E6YWqRv+OpwxTlS0ZO3z8UhPn66OrU24SrCPvkBR?=
 =?us-ascii?Q?pOuyJD4S659l/ffJvf2QZYOGC7JLIGdoUZ39Zyhcs0LXFHQ9RYrgqprrNrC6?=
 =?us-ascii?Q?CIWAj6Ap8mo2prTz0vyBuiQdOAZX5psxZpQlu+fN7YZIIwtJCk5gtaeUhge7?=
 =?us-ascii?Q?W4h30+qAaLvNUY5ZAB+rUv9o0KEQQrVIzpMRM8vMQcJHb5HnCzTWVr7RwkN4?=
 =?us-ascii?Q?GIeCJ/Wc1QBe+8dNAGLYAGKUOwcrnnrQnr/X26wfPqP8ZBLuTWMFwZMTxPmb?=
 =?us-ascii?Q?xL2c9vGqdhvG4olAeiiFCcgSqXU/5TMxNshdXMbHIbZaNEu3obQ5MXz+aulS?=
 =?us-ascii?Q?UlY/y8BYhmGLfN1BTWJpMBDSknK4YsdVEdDgY9E9fh4eBIcjOpCEWJ7Yrr2x?=
 =?us-ascii?Q?+PbgQRu7rtAJ3nffIdxkY+3+PpDnFqw1FMm2h+IuHO9MLW4mRxMV33Kd8Y5m?=
 =?us-ascii?Q?QruznVJJmyIrq1Ku5q9WCFtSyLKUnwO/iq+FSLATLSjkHj+TeAn1MhKoCcOu?=
 =?us-ascii?Q?/QjHLWUmytOy2bxcVVUa93maSPLUJqv/rdSsbTwNFkFu2++oqRnIIX3u1MeQ?=
 =?us-ascii?Q?9/vIWsGSs90O8ncjsoOxsx2WHq1+q9Vi2pFDHVleJKvTcnWgyZBECxzl/zGb?=
 =?us-ascii?Q?WhWzJMaP9hddq7dGG7Ei9jJuF1zSa8GbFIiDkps7M1j3ojB4rkSudetDE8D9?=
 =?us-ascii?Q?tbMdq3EdLkFnEET8/hmd9XziLwOFKYvoFQFKLRSSD14eF3cZYmjlMw9U3UWC?=
 =?us-ascii?Q?yYPBPUd5HiMu+rcDS7UlarbP3yDpA0htBKtfof87bzLa3yyxgoep+fmDJeCp?=
 =?us-ascii?Q?bVwERxlu8Ag3igKiC8JeJrlgOJ/L2Rq08xv5ec/q9pP7AqQlVXX4ge7OwQFs?=
 =?us-ascii?Q?RQCXiNod6a1/6W6cdI2dc84+gS1kwSisHia7O0FU2OHrDtb5ZkomqmPO2x99?=
 =?us-ascii?Q?/VqQwuz6FUbe/BIRt+C2Jmp483WvboUmbwplHZ3sfyEfj7sCrFnSPMv4PqlP?=
 =?us-ascii?Q?QS53QEqobMNGBLC4syiHyGrCk5rs2fmVBAudeYpm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dac22fc-4df7-4a1a-bb6b-08dbc18f6966
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 08:29:49.8367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kT0WqKW49BPsfnCEa1mF4mr6BZ53XhH+bJkG438b5kXT/qOXs9OvxESCRzZeEgAIbvgh1LeLhR04zH7Rd0MJtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9684

Put MPTCP event macros together.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fefdb1a4c465..ae38b428e42e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -51,8 +51,6 @@ TEST_COUNT=0
 TEST_NAME=""
 nr_blank=6
 
-SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
-
 # These var are used only in some tests, make sure they are not already set
 unset FAILING_LINKS
 unset test_linkfail
@@ -2830,6 +2828,7 @@ backup_tests()
 	fi
 }
 
+SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
 LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
 LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
 
-- 
2.35.3

