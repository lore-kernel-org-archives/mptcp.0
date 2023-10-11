Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D081A711
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UpkfRaNT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ibln+ZbsnnxOadjyKoBlezc7pYkLYgGOWulhzYQqrV3CEajempEX9FzTGfTH/fnmZChd7GOQx8tcPzHcyz9f8OYPeAGxDoB9NDt4c74ofMzc2d7arpxmuh29/k/jV0IIH9OCfCTfHhRQKgq0oo5qBMzi3kcysMDVYCTy6AOd90vtnrJQTTUVWuVLdC46DEdrNXIPFI/XTf/pZfJJdOJ68e8MD7S6S7VP8NAI05c6fRFYUN1u40Xrwk5sYQtoPLCRIGQAxqVQVEXrrCCvF3y2+htyiftW0nMqn4/5Cq/b94j4gfw+UVpDuC+3VpBsAEGzJL6UngdJsF2ioNB/fg4ZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCNmJPWWdhDiCsoZgavY++DGIjIWvE/9ktjGrOy23LY=;
 b=mZk9OKSAH1ELi1r0bhBtV5Voel0zPwOwpPoW8QvsDJGYfc8CowW5Oki6UxqN1IxeQSQXDuDVuCmQ7PajDplEabKyFSLUuZIqwiLESzV1+kZjcLFWdH+y4YDvCB4KVNlY1iFs0PVRhqCf1/1rxEETwQRtr563GHwQTk+DWdJ2fxdJ4J2gIAga/gNnjTIzNnGIRmQHQHZCjMSgsgmn0r2vciVmwNvI/IHUa+VXlmaKMfym3KcMsqVn1J+H86JC9ETWD/YQ3yAlLORPsBDJ60E9QykE2yvNBvSDo/dX5Uv3b1SWH2bDsgfWDNRu5Mt4BCMfEZybXDboA49gFxuCAmwScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCNmJPWWdhDiCsoZgavY++DGIjIWvE/9ktjGrOy23LY=;
 b=UpkfRaNTLQFUu4IBImTD/JRb2SyRt09Qc/chPVYJNMjuLrBh2zn+A2RKFaJUenwHNzdysLuyHbKJSg8RhgEjKvUVi6AZDfrD1H+BvvDCMry9LeO2A7+7T4wuD0lLNcbdzImzp9ie8gxhEdJabNEdM0X1hTPmhnMTOmXufGGZhJ1azQt9/oojUK44SU2W2b3UBrmwwVbFSu2Ymas+JeB54x/RU3vg8RqjO62O2Fj3EBZpVwCXuAg0cdL5Laizf8pzyuvbkvj1mwaLy2IpXtsp7hwK86C4nk8C7i7D7Nu7yQ9ZfzaYu4sM53lFYCen+vBWV+h6I0jJMTDD3zX7KLwOkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6960.eurprd04.prod.outlook.com (2603:10a6:803:12d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 09:49:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 09:49:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 0/5] userspace pm remove id 0 subflow & address
Date: Wed, 11 Oct 2023 17:50:24 +0800
Message-Id: <cover.1697017655.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd2066a-78c2-40c1-8318-08dbca3f5794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zrAbw8E5TtFHQ/v4NAzQk6HH8vVdU8HJPWG+ZlCl8aYaA4EwVRsQchmeYGuFuzVndYAi0au26GjRoow9ppS3lXzD4J0zIygU2pvy0EiAbodWzr8LR3lPhyiBFZ5cRCrjacxsTs43TcEew3mEddFAKuNOd4EiD2FKHW19d511Gw0RiUs4utwM3FvjYIwCuQIQ8+4/znUc4JLUVxY/8aVMhPffSi8V8M+i3tXlFlrtSlWk4+hrBObEisPPiqFOANydIpnoMnqqzYJ9qVT0GoVtfgvJ3EpeePwAnKFSdJRh6+5HSxVDDo8CeJTOq1McUX5yot4n0z45p6Ti2Eel7oUqrhNHENITRbGPa7WEQr49DxHA2kigG7zIfQB6rP4rjG284Y16wcvKGNivpV8IBTz6w7NEkzANivxhLCuQqBbH1cIOi6uX9yLFC+2pt5EkpNgdMHMg/xf+3pIcBivaP3cJSG/Dzbh+rjEj/7ACPELDNySG+aXwSRPgkssELWTS3LCXFz/4RRnVSyLJ9/0SEkZZzbMH+phdNl6A0/3VK9uQaMrqf2C396voh2BdjRsFIaDXqroHrKo529doCSHQ6L76ZAedZXEokltiqXUCT8UoCoA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2616005)(107886003)(478600001)(26005)(6486002)(38100700002)(6512007)(66476007)(316002)(66556008)(6916009)(66946007)(6506007)(5660300002)(44832011)(83380400001)(4326008)(8936002)(41300700001)(8676002)(36756003)(86362001)(4744005)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SRGPoJSACX/mAoqaif4lFtvwTQgIqoONvc8Xzz72L+ac7z60slqv3vNBxYqe?=
 =?us-ascii?Q?M8dIPPq55zFtdhzDE6C/kAs5dWyVyunugfOz7L+OkSdADskQqQhv1zET3606?=
 =?us-ascii?Q?ah+vD68SNp/4+K1axZlR4ILBhts3WtDV5kbtw6K99iR8BAlQd6itxyyHjmIi?=
 =?us-ascii?Q?OTkKF4w7BMmspSJEMyzM1O+bUyx5lZscY0TTwSOjAlxgYOnBtfxcgLQgpWFb?=
 =?us-ascii?Q?XNvPxlrjyEf985w9FauR6QBw9DFeG21DSJ0Wa/0pho6gIkRpMpAOmUj0NP1k?=
 =?us-ascii?Q?DoamEbv5JgbwpHIJ2WbfnaZsFZ3eM91pXxCVNsBLQB5ZIUm+VPvuX0UvfnWr?=
 =?us-ascii?Q?ByJ9IKs4/8RJBQk3muC6ZeM6ZJDbBoKOPiAtmYwme4e1ud9FN8VNcq4BqnKO?=
 =?us-ascii?Q?i89h2zJGAhEeQhnbNjg4qJdXhG9t6TXILM0zmFjKm4TTyYshlbSDws/Ty6Pt?=
 =?us-ascii?Q?l0ZdE0L3egSx5XU+5wjqEt2WGSNQaEXOz/paiEA6GDZTqRJwvC2FEnk3SDlW?=
 =?us-ascii?Q?PIVmSwU3kk+i5pBaGyDgrp29VA1xGLOIDKTxl2ZTUIutfuPrRJRsMRYPYmJw?=
 =?us-ascii?Q?kTEwMlHAzNNOU4jC1KhilCUdycst3P6g+AG5lp8jzY0U9pecYUwqtv6VX6Y9?=
 =?us-ascii?Q?nI2/EB2AnWPMK+5pRJeo2IOHYSKhxlhHkrOc4HAiAnwabPNw9ILRxeidDYGV?=
 =?us-ascii?Q?DmU+gCjpxtCnMX/Pgwk93JLGngU+yEXu9x8rP67+vN7gH+3AHsA2KGoJTjt2?=
 =?us-ascii?Q?H+NDu5xTacxP92P7id6DglBflF+s46qQJwtQNUd6uxbp6k9gB4v2PGUYZ65O?=
 =?us-ascii?Q?XMI07jwpgzIZfyDD2uHG49XY8ULrOXs/60b0ES5lL8nGz9ErwYSU0ikSRyVf?=
 =?us-ascii?Q?fSAmQOrCPkfy0xrh5un9VGWh5jlECVZgMDbnVC1RjgOknTn+/76CpErxj7IA?=
 =?us-ascii?Q?TIn0M7nBzxbI0niiLHR909Ep50zJV4JyLCl5xzlA5mgv84NtoMI8j0iqTV94?=
 =?us-ascii?Q?kUm5PWz5JQNq4Fzla3RwyPKM1CV0vhpPz0yQH6uRuQeTfBphzKwDCO9EkwEr?=
 =?us-ascii?Q?LiGa8cKgZOhqyIYqGmDr9MLEFEIUVU/xoqwcKUJMdqLV/TR25CmL/TpRhATl?=
 =?us-ascii?Q?ERHbhAOhjQImXHOgORY4OlbjNdR/T6hxTUfHoPYzeZVBgiblvNG1FdVI9+x1?=
 =?us-ascii?Q?LN3a+arWNVlcRrHJPkVHoCJkItXQfzjEP549UaVtIPcvaxkfrVg2SyKQUpYy?=
 =?us-ascii?Q?fqLE+tRxpApNlOjiV7wnp7DWMhnu6FeKxG/SuUrQuZ8NplN+jFsXr+Kb3O7J?=
 =?us-ascii?Q?kS5OUgaD6U3tFUU0QHpCrDrrrYqlAtQzgNeqFhuF1m8wczXHg2ZC/oZexeft?=
 =?us-ascii?Q?UfDj93caisFTDlTwrhQ2FuCzq4RFqnTJOW5ZZvu68ncaMyM0qsSsIfq5zpBw?=
 =?us-ascii?Q?pvXIMjqnZLt5mZcsxCeMvxI6iAiGVN5VHHFWj2/+QU/190+vhyEFU+vPkmR5?=
 =?us-ascii?Q?7SA+ZaPr7UwlfIfhA9XHl3pjsjxxJ1ANWwMPesRfoyx1y6QvGxiRMDrNC9kZ?=
 =?us-ascii?Q?r8y8aDLoXNDueYZKRlK7lhUCqdbO+pmuXEsBM3ob?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd2066a-78c2-40c1-8318-08dbca3f5794
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 09:49:20.5523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xchwQQggyssPVXakt/EJ32u7CjkH7vWsX/KnlG0aiyY2tTU1whz8ZIRkuGtUiqnJpX3x+F9ISqAQDpd9Uw39Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6960

v13:
 - invoke mptcp_subflow_shutdown() in patch 1 as Paolo suggested.

v12:
 - address Matt's comments in v11.

v11:
 - avoid sending RSTs.
 - rename 'id 0 subflow' to 'inital subflow'.

Geliang Tang (5):
  mptcp: avoid resetting when another subflow available
  selftests: mptcp: userspace pm remove initial subflow
  mptcp: userspace pm send RM_ADDR for ID 0
  mptcp: userspace pm rename remove_err to out
  selftests: mptcp: userspace pm send RM_ADDR for ID 0

 net/mptcp/pm_userspace.c                      | 45 ++++++++++++++++--
 net/mptcp/protocol.c                          |  7 +++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 47 +++++++++++++++++++
 3 files changed, 96 insertions(+), 3 deletions(-)

-- 
2.35.3

