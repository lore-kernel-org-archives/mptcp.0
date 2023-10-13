Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2072.outbound.protection.outlook.com [40.107.104.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62698290F
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 05:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y7lCnmJb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEqX9tiPS2i8C0P7NJKGVdq1yXIUQERfSYRX61dPnMLCZGBFcKOdIL2s6iGWL3+V32VVw9QBX71eb5ax8iemYNGvtl0lwzG6sWyKGLVBTfzkAzBu/dNV5NN6bVJnsulWknVIwxZjAqb8EZ1zSStopzd8mSAFTQX5nf7vxdXOXLHLEbB9bRPhOLLl/tUzQIXNKqI4jHhr70VSO/niqV847AmVqyxLvLFI7wZC3lK0sc0bWPiYlz/rnFFQlZBstBiyBq8rMQ7CR89y68L66lTwTEUFh0VcItpbQz4wcohopognHe4FeP0zx5fmW7m2+vHPsqLgoRJ64qfPuwSS90bMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNOPTkkzeW91N3uhD/bgyDGxoueS6Ex8jvpDB7ysxPE=;
 b=a7XOIlrx9IP+geWqWmNg1jXatq9Fi9IcH6zHabxJB/z2k8xKFHRbCAzeyq6xfLT9VYNetTcdNkOy1RNrGAAcklwY5/Nsc62EE0acsxlGOQ/5PI2b1s4vUoHQ+xxDmufcVm7W/bdMuHlG0urcn3atJZFjLxCMtNzMrpfHyVoVTpYhNLtzifMrkwaDlXxhG3WNNVMvLrxbciJFn6A2qA566+9h/wANHTux4QtP16GnfBxXfC6F/kL1le4JlGH6bZPcVJ5BCllMU5xw6odwurzl7gv8SY1YjfP2hq/b9lfww24hGhbIr0Y76FGGvFDFY6Ek6L1dmqEovW5IFR8ltJdnVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNOPTkkzeW91N3uhD/bgyDGxoueS6Ex8jvpDB7ysxPE=;
 b=Y7lCnmJbEpb966EU0Dw0IZRwaQeke4E/p0yRFWU0a78fO8Kg7JxuXBx+GEQcc9TjLli6+ssyr8lMqgsEb2or//GIaXoDLTj+Uffd2KlaA5iaO1eMZ76ILJ7NVxyFFz1ey8s+LK+uWKBBdQXYxK5jAplF0N8prfp2bKkGbESIadpCUfTlTVWLN6muqY6gqHA/9y2xkNS6emOMNtnGK/8+M/XMg/Nu65/hzt97LHPXG4IoX/K3g3WvKG5gcUeDR/GYAM4mycbbvheLzJwWA7zeFYc94kXYx+kUk9AYxaxB7eigaWS4ztwWUgTe53X51o4zUtyO3WuO0yG25k19U/ioWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7288.eurprd04.prod.outlook.com (2603:10a6:10:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 05:45:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 05:45:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 0/8] userspace pm remove id 0 subflow & address
Date: Fri, 13 Oct 2023 13:46:35 +0800
Message-Id: <cover.1697175899.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 791a52c1-4036-4c3c-671f-08dbcbafa28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HGZCNV/lS6kBTamA0+lTQEM43XQB6py1ZFOua01N9fqgSRQQhkdPjwpRNo33G36Xao3CSOWfz3VoqwdH+nd93cx2mZJikAdTLSTYbFcuodEZxN5WHgvCq+AYnDLYueszVkiQaPrUlYawJLgm+h3FP3OFTppmkPO4+hLlER71X24Fhzdf91+WxmnbHakg8e3RpQ+4P5ugkKJVZTt6y85LpvuDo9FSgEjLz65nBwo5of3BcVbszyZchtPGVBu6ToTclFiBNh8lToKxLgx3x+XeWvDMCaJU7HrYKGUedqqwao3HI8Cc/3Xx1ZBIKaKp2UPN4PWFsjLCU1Rvekcidk23CfcU0wGB0mbD2NxyNYo0zfuUYh4DkMNXaS80Gx3HFj05yu49kNtgo2622X1o8SF7+UW42JiS1wPKIokhxsy4AmFDnMZuLlQQuJOaSoXt+QPm6RGdR9E+yFCHGANfaF7eHwTiS1We1lDQp5FZzbwIYpdgdGVMHgV9lCELJh6/9m4uP/W52ecCjeGseDw51iLr7yQb++9c9rYzjp4m12yAqSlSVkKZpRLf3po2Sh9Kb88UgTAhNMyiK09afljJ2ddZ5fP0I3VBPn+Oq/vGPCsiFRk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6666004)(2906002)(6486002)(478600001)(41300700001)(4326008)(8936002)(8676002)(5660300002)(44832011)(66476007)(66946007)(6916009)(316002)(36756003)(66556008)(83380400001)(26005)(6506007)(2616005)(6512007)(38100700002)(107886003)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mBn0pqNq1GmK13/biRy9zX10ELeLtbwV3XaI5xyEJComYCtP9drXgZCHQ+nT?=
 =?us-ascii?Q?fTFCaKrOJTdVwU01H4OE3x2w4QpYl8h56MC9yxmQf/QrOub1OfpH+XHdQSBK?=
 =?us-ascii?Q?AAeFszB6VuOJvOOZUl4EXf3k/RCjzwpHUpIpETFLTT7ifVn8uH9714PIaymx?=
 =?us-ascii?Q?BsyZzW+PnusMfrbCgqPUqKOZxdCIEqEdiGkrX5NnD3glLKe4kjbH+SASG1/5?=
 =?us-ascii?Q?AS6Ku1r5zW3uBif3Mkza5PlfSuPTsW/C4yNyeUkjRFJmMC9ouVCZLOOCkGfX?=
 =?us-ascii?Q?OvQcOeg/Ae2lxc655zWulNgfHLw9YaP59ajYx7/OPOxVX//e6um0TCvgHoIi?=
 =?us-ascii?Q?YkxWKeXG0F+FZtn7GxRm/yxg/OdR3yjI0NwXom+7EPOQOkoFG1ZUL0RY2//z?=
 =?us-ascii?Q?+rtUZc9ohYjE0LoarhjvDiz26oCwD7RAzPgIW46rOVpn7GROwHL1QiKegkzC?=
 =?us-ascii?Q?ZwGKNQnftGzNflSHdaH9h/G9dhhnIKVJYgvWtl7IEL+CPPLNQqcbLndDPHQF?=
 =?us-ascii?Q?uVX2vAiOirgLIstxnBlc0kU2MW26zS/KRjCDh72G5pjblrf0q3V9408PQU+I?=
 =?us-ascii?Q?hyIOwG93Xi0R+xzlwZtCHt0Rs9tPsNOoGjIQiaIIfuxMtEWg209f4GYvjner?=
 =?us-ascii?Q?FcO8XNd+KPi+wfcaK1zL38x6CY4IgbNB/9Ewkr6GiY5C+qghN5toH/AqUPX9?=
 =?us-ascii?Q?x02lwx77Vdee3gIIjaEuR/AayELhbFbXhvQJ1NUFh/06dF1H7l16iDDJDkIj?=
 =?us-ascii?Q?7bGEqV40cp5MTF7xfv9Ya0Rxo0tfzMOFw3++Q7BirgbanQ3HFm+fMCLFZsdq?=
 =?us-ascii?Q?N5yfF/13zZP89uRO4C2PNNNmVAMge+75K3jnLUMxoHvYT6/IonA0WHbtOLse?=
 =?us-ascii?Q?Xmndfp9U6l+6YQc1mqlvqaKPL21yPcxBND/cRFFz9gW/Ifsksb/1e6tsm+5W?=
 =?us-ascii?Q?rV8T00qW6LMjJ4xzn8DwvJQTdzt0+vnFPUIhPQjdTqmybY9fxbOSG3QHEyZm?=
 =?us-ascii?Q?0wgHwMKbpk4x61u+tqf8bFN2FcT+oAmTlbHogabIyE4njMzM46wV55GG5MkM?=
 =?us-ascii?Q?6rLPyywPDmpBPUTahvxjJApT6JjVQpOga5QCHRMMYKNwaZ1/S/E9iwaKoT8p?=
 =?us-ascii?Q?lYmJaMwjwbPmx4QuvgbivPVK2xiz5ygsTr3jXB6ZRnmfctGifwpXPgBPK460?=
 =?us-ascii?Q?Ag1brbcWxaj6gMw75jG9fHFtljs2WUxPXlkpj75+mi+Idan0LR7fisOKIAWQ?=
 =?us-ascii?Q?t2DtzYCDLM/ThJcBBm6fufFmOr845ZVxzy/oITqyDveQj+gvVpin9+R9WIQg?=
 =?us-ascii?Q?iJ/oGggMBctISVnKPL1GCvpm9UCx74YyYQu3r+Emdv4sO8gOdDnsXAiU44T/?=
 =?us-ascii?Q?BZmkiuCvKS/OHnZSXtVtOmdPjIacH6XXMEiSv2viwGwSTSMpPYQjRF+csJv3?=
 =?us-ascii?Q?/TbT2qlVKy0QwwOm99HKNHW54nDcreAGJm6iQLjMtiuBnb8q/Ffo0za+r3Hj?=
 =?us-ascii?Q?QCHeXT+fwdN/8Jjn2znsK3d8vxe16R1FsIO+w38lL97bq6xpzD5/D7Npr33X?=
 =?us-ascii?Q?faNjjnMKN8vEdeN7g/XJmv2H0y116nDe09AJiVwq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791a52c1-4036-4c3c-671f-08dbcbafa28c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 05:45:41.4823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgrMhX4V99iJDXeukIgiAwoAiSZKSYgdp3/aIsHDL5P+gw9C77MqzuvYXVsE9KT/cFBVSoObxGQC5dX6id/dWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7288

v16:
 - address Matt's comments in v15.

v15:
 - update __mptcp_has_initial_subflow
 - address Matt's comments in v14.

v14:
 - reuse MPTCP_CF_FASTCLOSE flag.
 - use tcp_shutdown instead of mptcp_subflow_shutdown.

v13:
 - invoke mptcp_subflow_shutdown() in patch 1 as Paolo suggested.

v12:
 - address Matt's comments in v11.

v11:
 - avoid sending RSTs.
 - rename 'id 0 subflow' to 'inital subflow'.

Geliang Tang (7):
  mptcp: add __mptcp_subflow_disconnect helper
  Squash to "mptcp: add mptcpi_subflows_total counter"
  Squash to "selftests: mptcp: add chk_subflows_total helper"
  selftests: mptcp: userspace pm remove initial subflow
  mptcp: userspace pm send RM_ADDR for ID 0
  mptcp: userspace pm rename remove_err to out
  selftests: mptcp: userspace pm send RM_ADDR for ID 0

Matthieu Baerts (1):
  selftests: mptcp: join: no RST when rm subflow/addr

 net/mptcp/pm_userspace.c                      | 45 +++++++++++-
 net/mptcp/protocol.c                          | 28 ++++++--
 net/mptcp/protocol.h                          |  2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 68 ++++++++++++++++++-
 4 files changed, 131 insertions(+), 12 deletions(-)

-- 
2.35.3

