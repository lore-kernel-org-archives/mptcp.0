Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6004E168
	for <mptcp@lists.linux.dev>; Tue,  4 Jan 2022 10:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641291090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u4WySs3rLppwLycRiiH8nWZSlAj6GD0FhMnnLtw1Psc=;
	b=IIhd2aa5Z4agU2yxe3NrtYTmPHgJCsKA1S5Q+1ZbmThsJmi1OAI+z5f7heF4CDj7OKuJes
	Y/Rk8lRAXJFDn7Ua9B1xt8kyGT0KhJGJH/HugmYSS3LMjl006IpzxiWmRfjGtTFK+h24Fw
	0AJ4l9yqWZXY1o/uWQ5K/iQXYlX9fAE=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2052.outbound.protection.outlook.com [104.47.6.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-34byTbVKPVqAnRelz3mrPw-1; Tue, 04 Jan 2022 11:11:29 +0100
X-MC-Unique: 34byTbVKPVqAnRelz3mrPw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGzFpjT+yiYnNDs6sMjp4CiVSKlXffdEBq0OkWrtaTw7fZVuGOzqJdWmRq2majV6yLXCdH6keiMFHjhleg5+sb3c2otjiK5MW8mNUnpGAvvpDcAoyhoUImJT3pe/LkPcTtXHnU9RdQbxvuOcNx0delfQxHRsWTvH7LJzT2Fu2ZIF4VD3AYi/R+c9erUjbWX9h8m04V/yUhzjmtwcYtH4Z4XaFtkUcU6/Vjs1sNYofvGZ8Np98rMOtYuOD3mklWJcoKpHcCxB9EOSI/WhRDM8osOfFn5cYdbdyjtWWjmAH+2zP3xy+R8zK9ArJv6wbb+KKUcuQi3hIPq79Cy4F4QUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKt39mxsFfEEV8/Vr3ML6Bnd1Wr76yDC/S29DlfNECc=;
 b=G2w/LT3vHUuYHwRsun9Chrjq/2uJ8ZDlThviLcrX+TulDWtONcYjTNcF6YaBb3rsdLTCzkSvFDoMuvXnEHKEqnUZwbF/+YcmoORwVzhHHy5THRK4MpOLDuQ1FxTLxyLmUlT+df38KwY89L1lesFpMtScwTyBI4vNog9xOpbxMbEm/UtiKXryje43PBO7ZV0DFBs7Sn/4ESYNB+ESGgyrqKi4H0WRBAQjgqhR3pvdZhBnz86TH58jljtKyE/0cQ7NPFwr6LJaCc9rTGpTiKEMfLGQ9RSiX16R/7r1LBrB++EPI0wrlkYQypZgJWiOoilhTZTwtAp7LPzp354tkGD+aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2540.eurprd04.prod.outlook.com (2603:10a6:3:84::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Tue, 4 Jan
 2022 10:11:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 10:11:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/4] use 'ip mptcp' in selftests
Date: Tue,  4 Jan 2022 18:11:15 +0800
Message-ID: <cover.1641290905.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be97be0c-5092-4991-501d-08d9cf6a9177
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2540:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2540BC6D9FB911FB7787D463F84A9@HE1PR0401MB2540.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SnTFCmAajQhtjGOe0T+ha/Gfk1IT/EdwVmrWYspqKvT+DQarqy6BahnLRPUH/Af5TDnp/nWSiGlfsqS1XVPWOhqHRjVfaGW5NJ1klNjJZ7UxmHNqNxjnNDIKoPmx/0sgCQkIIZV3O9T8USACXTv5JYQGvgbBhsiKyTBvSUC8FVW2j3xJXT17BdOWAX1CIWMrtsscnBiC75WgAp2lblooxfCWpXm38aMfyxtq4IwQOGh46PunbGMs2nj7ysaqxY/eZIPOuZIs92Bnl2sxvNgleLydf4obQ+ZrKL9SCxU+ncRhvhExMOjvEt9lP42UwK+YrDIICLsPNLRYne+h7SgPqGo1A9NBV0o4SZj6LauBQjKENDXPfdi02UQu8ApT5XtIHqJ5YLe2TpXMkULzT/rVEFkyzhmjupa2vuVeZ7RVWt8sk+7nT/3GzNiljkAhteXDZy4AE1EOnuAQpfVWk+LMu1B42Kp9MsoBFco6/gyMu32hLo9K1GnGY5seK3ydPkwbONw11yJe0HtYhWwHKS/Ce/2E88s4CCefXSb50i+O69c1Lkpw+f4w7JuyHKwXzKskHbov3Wzy8TIz+R5KktvwZLJ2P3nag8I9SHRVn5imuLWH2/eviG38o+5JTekabm5NfgCt0GRRSztwKuEw923Jyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(4326008)(66476007)(8676002)(2616005)(508600001)(6916009)(86362001)(6486002)(5660300002)(4744005)(107886003)(186003)(38100700002)(8936002)(36756003)(66946007)(55236004)(44832011)(316002)(26005)(83380400001)(2906002)(6666004)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZFc5bcM5lJMgtiykgRR+m0XUS+ieg9eIO8XJ5A1BfMPFCQdg/hQEdu2gaswJ?=
 =?us-ascii?Q?YflXhK29ZsDI7l0ZogTk2MM3TlCaEUgE7wJUNdDDgUPKzjlUbmhPMYOwTUec?=
 =?us-ascii?Q?l/p0IcSuT1Y9am0ONBFZ2kcduhNZy3wwHMQxOOF5w9CYUyRTXy4Qwfc2nGjP?=
 =?us-ascii?Q?5UTUMXYzvVmeip+whSFzZqvwjLGK/dcZ3nnLltucPzsKl7kDvMzQt3FUh1/X?=
 =?us-ascii?Q?N+2fdwhbj6n3ZXDuEvPX2xIv6N9ZG31gAbw1VD57cKWUVHuX4PIHx3xeGXd0?=
 =?us-ascii?Q?pMMyh5IF1/t+j0v36w1YLvuZarLboZ/kSPWOp1v+1xmNbPfMW3oU0bCoOHZn?=
 =?us-ascii?Q?3594Ux5WdgNv16dl/qUrkQntyL+bRpOAHhVbv4F0aLFuqZ6daux3vDcfoT3j?=
 =?us-ascii?Q?UIhYlK0ledkB2tK3UPe3N1VWDrEf/sZC42LJvDaL0a4/GHvOKq4voDyMzTp+?=
 =?us-ascii?Q?flSvCM05kkxmWC4BhCEeP+Ap0V5G7/ThfgdT60rT0scmAXkuCtBwDXcvq7lb?=
 =?us-ascii?Q?hrvfkyocco6KXm7u+QiVKqAUs7uqLZEpsnNYnJhN57LrgvkHMhvQdj/RdI8U?=
 =?us-ascii?Q?hzKaSfxVECfBHb8mqBIm8AmeQanu7MUt3ApOagvdJ3DAoD17jAD7+kF/xxpi?=
 =?us-ascii?Q?xjsqZjiP1s+tPvCPbABL8gLxZ8vo1yJb8RJ25l0bTYeXU/RfLvV6UhN0W5zW?=
 =?us-ascii?Q?AZtq/VckMoDpsoZNkJ72nAzLPeWA2GOP8V5R0YWnC1CDmcgdWOSF0t9YAFxE?=
 =?us-ascii?Q?hAVgwoqp4UIEcTF/gKNuGkWhcMJQnD7WHsMpchjnp+PhpVQ13M6YdTSKo7RN?=
 =?us-ascii?Q?BGXeEtKfLDhQFoh5PQc+YQpP+HvwxKe/YiXqP2l9jvtT1haFMAjze5Wdrtuq?=
 =?us-ascii?Q?GKIlSMOWaknG3Pp5DkZwDReOhbKCpB/6fm0sI+m5jG5YcYRCYM/jyfnJk8Ij?=
 =?us-ascii?Q?9sSsoN+vhSlvpOSHQt+2GTaYd6g/BHHs1N4zqpNo8+RijiW7sYStHwuDF5WM?=
 =?us-ascii?Q?SGqbj4HXH0wJ67hJ1ns8Ni408bg/+uty1Kngl9l3dS+Wq8URkHgqn6KGZMWu?=
 =?us-ascii?Q?sQJH5xCx4RKCasaUmIvcBt17l2fTgdmSSiGzRIHdgGkhy7HWYRq5pcNSPEI+?=
 =?us-ascii?Q?uDdcZhU2N+V0+3xbD12tGFA4h9m/i3I77XQeaDoxfATc++0t8E6AnBRr2gpV?=
 =?us-ascii?Q?F/lenK+GtY5exGHNBqrXKdTG/bpIlBXvJe+5fZypH9Te6HENWIzdyx+Ad8W3?=
 =?us-ascii?Q?UUV12RtzzebrouJdIBeU6/x2eX35XeShS6NKjncsfqHOKtSu9VksOSXwmkeS?=
 =?us-ascii?Q?q+3oqGPHnkj7OU22TPoAB0g8JUoLkFgPSMknDtMY6D0FkHEQdr4TKsswhOeL?=
 =?us-ascii?Q?veUbWx6cGEHb6aYB64RMmcap8M+MmMbymz1tOlnUTq37LQwcvl6sefKi0B5i?=
 =?us-ascii?Q?QO0foKcOUc8bWWDft7YrJsJnsx5t+BrwjodC+Q4lYoTMSoj0C2vADsnDvxHj?=
 =?us-ascii?Q?5z8e9sth00uCuUrpc2//xGYaD6ghqUVpvsl1HNeuSybRKbUQ/rfKGv8eNniN?=
 =?us-ascii?Q?QyEq4S9119NtK2+aDUv5PnmSbaOPpzdKGnVq0xnzjtz5kqVImCZc4lpXIlrX?=
 =?us-ascii?Q?1V30SCIW6zXonly/ALZ8RmA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be97be0c-5092-4991-501d-08d9cf6a9177
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 10:11:26.4728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFmQSFpJNN5Renh4OxkQ2JId0ArFRLDkWMlBm/hvRxeFTwYQlLM/dZkK0NFW6q3Z/hgFShOyGwxXsA/jEl1AMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2540

This patchset replaced all the pm_nl_ctl commands in selftests with the
'ip mptcp' commands.

Geliang Tang (4):
  selftests: mptcp: use 'ip mptcp' in mptcp_join.sh
  selftests: mptcp: use 'ip mptcp' in mptcp_sockopt.sh
  selftests: mptcp: use 'ip mptcp' in pm_netlink.sh
  selftests: mptcp: use 'ip mptcp' in simult_flows.sh

 .../testing/selftests/net/mptcp/mptcp_join.sh | 686 +++++++++---------
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  12 +-
 .../testing/selftests/net/mptcp/pm_netlink.sh | 164 ++---
 .../selftests/net/mptcp/simult_flows.sh       |   6 +-
 4 files changed, 432 insertions(+), 436 deletions(-)

--=20
2.31.1

