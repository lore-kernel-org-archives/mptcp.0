Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AF117EC
	for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 02:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsBbJxQkC7QP61z/7fBqIpUQc8/Y1m6XvJOF76MQGZT6NIO74lpI+ZuI2q2lyDRZuL/jDV+iMj5OL3TSdF8/K3RVZPNQlD0QVafbWGRkDzOOlosjeTLIfVZqnYJqlMa/oVEUHxKP35dcAFvSNkBM//tJvGNfSVFROsOMO6N4HZe4oj0jIzm7GMg6tzs+oZJpcnlNvqgHzeIgRcwqX/1+JObkd0iIK5qv2vGaI+EVRn+ZrjgIxMczQBz1Pc+Wxg2I9z9I3qbUE6W/q81BOyoX+wijvcTUZujEexzN/Ufk0Vuo2wIqv0L60sUO0GlX8pgxMwzjmA66OVv9ge9Y2kcMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PQIDjtdpVZssHJIBRyjeKazoi8P6lS1b+aElIn3hC8=;
 b=RcTe7Ys1llcgoQtvLQrg2EdD8czcPUYXU0ErIs/J9DWFBXa4PilMj36BWxYp9MLoj6MMGyhx5OQxFPRe9lES7L06bud7ueHPJT2pN2HqWRZYBP6cTuGLgoKf+WpQQMMaAqVefFqX8U9mplun2xJkgGLAmutUGhrWyyEsH321FXMKe2x2IvJzhpqTmr1yeYlILaGz9nfAbczesdWTtr23MgrmupYmfqv7Knjhroml2KeLoaad4BgTFGDHgPIhOieuIGmXVM2YJNBRLU7B2gHfU0RRL4RkNr2ZLatgjUuELarStzvhZ00IkX4fBUURo9QQRsFtOreR0A8332pzLAplcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PQIDjtdpVZssHJIBRyjeKazoi8P6lS1b+aElIn3hC8=;
 b=Esn6KsVCvt5hu0ejwXJAqwiRLKwURoDOM7/5vzHRmfgw5sI3kp4OanaoyxVAWv8RWGV34SYxzqmX2JD+tT1wQbEmpcf1yBQP/PTBmT5l8sZlKrOQNfQogKJ2/A3fDcGFyY4oiLo8Kjyu6n/PjBZy6KeN67+60L5FQI9KcX6HXXUaNvYJ8MQfxyuF0cafNYhDDBr2D18QTJtTftKa7L9ZcT6bpnb5Cd8ok59L+tKEEzfFOfrguHNdqGPFIh0SoXUMKVjwS1zDrLQ89YpMT3NHQfE4wGblO3xwid+Os08tvz1X7oMcqwtHvdn08Z4FmMOCksPs+PcwL0AGsfulVZN4WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 02:42:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 02:42:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/4] update userspace pm mptcp_info fields part 3
Date: Fri, 30 Jun 2023 10:42:30 +0800
Message-Id: <cover.1688092826.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 96cd7dd4-31be-456c-0d11-08db7913ab01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bj0830JwetNPuD3JCFtD9d8qnly1aGJO/iIPBI5Tz/y3nd70EMqC2UomhXofP4QYNUU1JjS50fV5lADQh0XNdcSzuVvZT/GveN/mkV4CeCXFvHdd70B3e9T7ZurcHb51byQQUj6cUy+OcNxaCwSuZr5TQnJb+3Six5bop/zRQtBKea1GqrWyazLHhmrLddKIZ+iKH7UmsR6saR1kP+2Zbtq6A7NJMirg1L8srX4lFqwcJz3Ru0PP6hGQRgHI5Cq4dOogPWZCOnR5VeJRII+ZP/D93nFgm+t5PS2s9yOUb3NOHYBiE2f/6K+Jn74HsjDtnyZh9KsMVeUyxYXXUIfp8xYfal4VV194DxpgD9KONgaupSEKCqeCulzl3OSy9QcL1zKKhfTez53DObXZCHQ8c4CKwYZOQ8rkFSjNIe002K+FQ9s7KQOj0DwOuYdJNZJ1iJJDYfkfzzFUOWeXWzAPkLTuSvYJdCaouXHiiyJEE5qaMcpNFL6rFLzRP0vrKqJEe+7uw+8PrGBbUSCfSeLSJRHklMNu63ytEoUWMk42C+IbNaRs5OFRtm5MYZqH08vg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(86362001)(107886003)(8936002)(8676002)(5660300002)(26005)(6506007)(44832011)(6486002)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(6512007)(41300700001)(316002)(6666004)(186003)(2616005)(2906002)(4744005)(83380400001)(15650500001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zu3ZERofk8Y1jzU75iY7yelOGFCv22LDxbTSreCYnPkG21SYckRTa8ay4k5Q?=
 =?us-ascii?Q?+XMqBhangZK3u7SL8eSIFwvqQLlOdeTpqAegC3h76mB9yYrRPJUD2oAdEjQL?=
 =?us-ascii?Q?S39Hk9znlBa6nfNusbqc+gPRQCbF5KyoOt/h1niMnEYtrKeLaHFc70etSR6L?=
 =?us-ascii?Q?Djv2+OC+HVTDsw2gErwcKWsA2mqP6qy0g5vf5ca57yhge0zE2Tq0eyIc7dG3?=
 =?us-ascii?Q?1C4FjqYUYw7FelqyVWE8RmAcOgFA8rpjv0EtsPoobev9kHczhM8Itp5A4cjQ?=
 =?us-ascii?Q?DCama5wF2GfJT/UtJ3oCs4PDC/hGT4O9eoMRoVuY1lJmf8Ziy+rIeCdJMGbU?=
 =?us-ascii?Q?TR8AyCDOBb/fbkSmShhLNTVlP1WtqNRUNc4Hd0ocU+VZj4tfkeOtnSgGHUDu?=
 =?us-ascii?Q?1S8YFd7W3da4x1JP2CN1NF8haRNLCYNmgLhsRk1eoC13vmWTNkZx2G46CLBu?=
 =?us-ascii?Q?JLgMAtl0geE/Nm3gJdoL/FGQfEeSAc7bXjNVuMNcnLmYDsR8tNbltX+Y1qUl?=
 =?us-ascii?Q?B2x619CEtqdqIvw1PplPzi3ifVv/DE6Rz2xQlnzbHKeDB3Uq9zF4jOcN4a6O?=
 =?us-ascii?Q?niyj3AsI1AHPaQEAEYzdr6aCnznqSzPxgpaQPUV10n50rVLzHKgv8W5G1tnl?=
 =?us-ascii?Q?q7y0PzjsFAvK/PlW0M7UT3sskjuKx8j9Oko5xUzL6Sn1T/SqEXH2LiIt0cXC?=
 =?us-ascii?Q?DJhxdux0KZETIZMJRmKOXYf94uIU5lMtl0h8D6MwtBNIjphskATlxpTLNMPK?=
 =?us-ascii?Q?OlMf+0Q8vPHzHD1tt58HXsxzjeRhXVhHm/RIn25ruYfP4sZHrSJVyzd8lJve?=
 =?us-ascii?Q?LfhI5E/kSVtNmnDI+tzPlq72YascHbNhLrb8SfZT76Rtb/039K5c1At5icxF?=
 =?us-ascii?Q?hvZJRRPGIrdgrPoNWjHSkpdChUjFWwFDfMjr4zLPi2odxfQ/Mkam3EGhZOI4?=
 =?us-ascii?Q?wmCm7UxW5SN4J1kTPvalijhgfsGqHsLn+lZ8GqL//hd31x52B0ayNEhRifsi?=
 =?us-ascii?Q?JUBlo5BlYM4vNLkLtvr83Th7oLDXPJSkPcpKXXh6dpYKVODJLVtrBASvOJi1?=
 =?us-ascii?Q?w+rkNnqfGMkWHX6rGnLnGi+achTHWYM/csK4PRM7fK9zIjJ6s38D3xYS9iAV?=
 =?us-ascii?Q?uf1iNT754juOWQPznsrNw2mvw+Bqrp+B7vAvjCYVhtNCh4y5pRWKULftZFju?=
 =?us-ascii?Q?6SvpecZzwJceFKE7vOV4JMvC1tvPbGQqIpufQ2a+ZIBTPa7WJlfhqzoVfiqU?=
 =?us-ascii?Q?PZgM4QMeW/tifmbo9vYX181YOlKA7iNUkSNcGre9Hvg5XhS9RcXojgdmDiIg?=
 =?us-ascii?Q?Rn02OEpKazrNq3n/NkFS+phWmwbS7xiKOJqx/axqKD27D95ccSWcHwe89Gd6?=
 =?us-ascii?Q?d8WwLv1TVEWZvsWLYAEoD8TVZU8TSUOIbp6VDHtupwdPuIEQSO6a0ladu/D5?=
 =?us-ascii?Q?JDPQy/oc1QvQmd93j2BZEoEfbxkRXbRkFK7SBqePjBcPlz/Ljg3a/It/eL/g?=
 =?us-ascii?Q?YrtYfwWGJLwbfE55alXbqB1xDjrybvrlfcvqVEW/S1kCZQSANNAKwrslvz33?=
 =?us-ascii?Q?fOsazMrm1b3gXwkCcaH8/fcFsegmfvmYsk5DoQL2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cd7dd4-31be-456c-0d11-08db7913ab01
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 02:42:38.4833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWoRteitH+IG+3cVRdBybwLQ2/5Vncvx8Jl31/cScN/JLb4KPqTwCSAav4KBrsMKrJ72A86t5NUF6IRXFpOhUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103

v2:
 - set all env vars as local ones as Matt suggested.
 - update the commit logs.

v1:
- add three new env vars
- Patch 10 "selftests: mptcp: set endpoint out of transfer" of part 2
 v20 is dropped.

Geliang Tang (4):
  selftests: mptcp: set all env vars as local ones
  selftests: mptcp: add fastclose env var
  selftests: mptcp: add fullmesh env var
  selftests: mptcp: add speed env var

 .../testing/selftests/net/mptcp/mptcp_join.sh | 270 ++++++++++--------
 1 file changed, 150 insertions(+), 120 deletions(-)

-- 
2.35.3

