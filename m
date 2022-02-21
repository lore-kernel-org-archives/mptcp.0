Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F4B20F9
	for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 06:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645423939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PkeatfizrXQIJ99/tdPYpVW3OtCAmWZ3EhQ+jqvxDUM=;
	b=UTlU2sNuwgKZ6azdSrwFPulb0MRZ8Zn2zdiCk9oRctjd/EseEdauJ5p4J1j977wCKIBOxY
	O3TiAleruOIAj502RKieWOkUeGmuzYW69BRzElU+1Uc5Tbm/Ts+ooUzpHgC8aQxfdm2vYW
	trN/pr0loKGyypba1+kOlGSd1Sb9o7M=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2054.outbound.protection.outlook.com [104.47.10.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-pACvGJNcOTqow97sxTkj7A-1; Mon, 21 Feb 2022 07:12:18 +0100
X-MC-Unique: pACvGJNcOTqow97sxTkj7A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0Cn+UuXE8M92bvp6Rqu2GOtBNYXbsbbgFX1oDMfoTkeF2ZvgAy9J2/gaTdxPBEdB3VeYKPYP94jldBFIQsSMXSm7iZIrGouaxHBCiXfVU0SNF39+CqPL2Z0pp5LPEb0ZJfmJKtjwWN/aWpmRGGWIXnawo5+15jyt0u6fRSM9Kz7mAgfZFczIxSN6EzJn/9Y47s3E4hlJuSrhc9VdtdPX+9O3I2INXAo1b0YE/rSvDkgDlpeGyVnZwC8CSFfdnHkLgNHvYJnfNoUoPakPSR2qCEVm+TpikSJcJCR+vJbemgDu1cS7tHaxCU9IMxo4ToFeRRse1Apl+vzdU5ujgsPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V08zv6rkhHHKj34mR7Ygn/4fZ3xuwHPdv/RprAC6dWw=;
 b=PsM8G5EaSmqcdOApHcpsXWAs1COaBL97+/GylLege821mnwyuL7SlfnHh1IWnYvTDXR2eVv+rp9Vj6S5XejeQbOX8Kp6nexdNvSMQAQEYWdlR5EKHXQ940N0bFcR0Vm6e9zuZHFWn0/FaeDWXiKbKAB1mdnhZPWRFHjzhwRjzgQJ4qtQPWLYAEyevN/0LKInUhVjaUUEfzEoAAZo7+bQoZnXLpJTktE87dSjJFez/6vHXSxWbMryTKuKw4sHibNzDyXfOygnBinFsCJ/trXs0Jjm0eF2UqIhikNbATq432K2w3DyF+Ew+5yo9/SySYTyFCEStwMSpo3CIOm9J2jSpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB3053.eurprd04.prod.outlook.com (2603:10a6:802:6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Mon, 21 Feb
 2022 06:12:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Mon, 21 Feb 2022
 06:12:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH iproute2-next v2 1/3] mptcp: add fullmesh check for adding address
Date: Mon, 21 Feb 2022 14:12:36 +0800
Message-ID: <41e5b4267e4cdbac429e82504e1e47cf4284aff4.1645422873.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645422873.git.geliang.tang@suse.com>
References: <cover.1645422873.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a07dc35-9650-4913-8e56-08d9f5011b4c
X-MS-TrafficTypeDiagnostic: VI1PR04MB3053:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB3053BC8D39B5581272A649A8F83A9@VI1PR04MB3053.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BcFN17XaF7bq0qK4lfCid6vGxUOkX8Qw+ao7Qo0y3jMtXkr0m7JmokUDgYFCQiL/+U8CLyjHNwUfJHnpXTtMtftj06cI4qsb/Df7YRVPzDWdMT1337kMTgKGQXS6G3aqRQIJUz8E1KGfg0Z64lSLXnjKPY3hiYhD/aUyC8q2WP1ERVYbdPuc2dEWWV75vFttZvpKBAU4tGUBsLGQaS7Gi/S7mCAJgMUgP52SqoRWgPrJVn722m4wvSrV9qY2MSoPhgPpqCaEm0bT9LwXlvWWNo9+XTdTL2r2PQN5/gd0n2IlJq8HYjoiWdCuvPeLSWE3mG/bO1qnQTmg0wGeWPn26o2F3Erk1nMbjfSQ7q7gs6Uy6yVq2/zuXEDLf7IKT/LvZL6RGgjcz8czusSHVdn0M4ITObj8q5xET0MuAX2bPL3grRI/m3yX9d2I0vgdG2nsF1ORWM4WH/TulyPFzNT/75HNsZ0RV4Sm0y0NVQz7zhoqaCOKOM2TPbiVWTi06KXwAg7d+lCStUYLwyKkgBZELUwqVB5QADyI4SEBWYHHVj86fDswDYvvcnu8TovFWOpehlIzcQQS2JS2Fy6bWK+33+KM1wif6PL1867ABdeZWT5CyWzRxYh2x87bhfDm3oVN7e4EslOmnhfRAbhYARUzmw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(4744005)(2906002)(2616005)(38100700002)(36756003)(5660300002)(44832011)(8936002)(6916009)(6486002)(508600001)(66556008)(4326008)(54906003)(6666004)(8676002)(6512007)(66476007)(6506007)(66946007)(316002)(55236004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cS+iuMbDtQggaZXHfBgVDUrLgBDJ/aM1AIPHc7L9zE1K8G+DJcR0VtmoL2lI?=
 =?us-ascii?Q?gTAI0V1jOJmUPX3+Z3I2Vw3MnEXgwv2xvXAKaOkuxIK0y2BRf1pYmCxbFY+c?=
 =?us-ascii?Q?6G0Nnan5kdVS4Upv2opo7Hkkx9UUKLD3tvBvx86khtLQzqJ5NrsP/Rc/ILu1?=
 =?us-ascii?Q?aJmZ6fUL8bptB/Tg6AXdgSVC1cGCa+vaPuQerD+C3Wx2xUM9npv9dHSa8Klq?=
 =?us-ascii?Q?g3zNuoPKX+IIKU+SzG51AEIWkgHvOguvTy6nDGU5jZNUtyP9bLR//D3NBgM2?=
 =?us-ascii?Q?d+gjQJNN/9eGMo5lyu8c5IgbnGM4jIwdvTFiH8YLBfGqesxAUCbroZdH/59J?=
 =?us-ascii?Q?HwsMP0d8BVPKxlU+fZN/kHP2XB7wEsL5M9zjbtqUJ2t53HIO06VtFIN+sRA4?=
 =?us-ascii?Q?4AbnzLhLeWXXj0RLTaiqBl59H0B59hGzxrmISIC1kuLymWOM2/2KO5XSaqKJ?=
 =?us-ascii?Q?xK9I87hGG/WVu+iPKxIEWXWh8HZDG8C4UgRjrlS4M2seXczDvqpok0YW8Wq6?=
 =?us-ascii?Q?Qm4397cvtqolVkqlSFNb/xs3a6AHMplei+Uc5uqvgUymgdZwnvPDyCUF4Hr7?=
 =?us-ascii?Q?6Rae8dW3pkiaqRbyRJ3dJBlDRp5G1hlZ2292T4NzvsDOaG/4Iss7DKJYRxzH?=
 =?us-ascii?Q?rILNDO95yKWaZRKAB67m2AOzxCYwyMuRnUH+BDizXigCVSeGfGJr8mlf+AE8?=
 =?us-ascii?Q?ruglZDmRSq3tnqlVp8qjkT3hVq2kHbl4d4aBme6+wuf8l6wHlqe8ZQlVnXEB?=
 =?us-ascii?Q?WCPeXMr/qmlV/JSfeUfRJ+/gLoN+gct3LGDlC6hsAtrEk2m3gTsMhLj3/cIJ?=
 =?us-ascii?Q?5ZXT7ymT6OaOjQlVi4rKbEYs7ZzgU9z0V/85w1QH9j9UnyZgMwjuEEk+512/?=
 =?us-ascii?Q?NwzxaMuTPI0ANUx1XzNy8oQCanZCcOiLMRZn+KwB+0r8kFLsZa2RAWz0rFwh?=
 =?us-ascii?Q?wgc464K2J6mJ/crkzzJ4R5DNQ0KIfnVfhs4AOwVmJQ2Lyk7RZYbU6Ys/MpqM?=
 =?us-ascii?Q?xmZIiAzBgdNqsHOrKrk4YlgGZiExRO/j9ODeda+m3ktz0MsLeu4eHQdzi6mY?=
 =?us-ascii?Q?2mRIdR37SPUCKQCn8GIoNhQsc2BboVluHmpUB/Z9ZkiK6okbC2xzEfsXF137?=
 =?us-ascii?Q?6SR1DAKVH73tRxBjMCEJQpu1N2RsLH0I3j01gjGbVsaSbHUZyEKOdMV+qRba?=
 =?us-ascii?Q?J+Og220cThFyzjc5w2pg2VK3AMZBroAxxc6Rmrp9sdbQApmFsloCoqNqaj9K?=
 =?us-ascii?Q?iP+qrXUrKiChJNQprpXWh/UnsEHbjfp95cr2ALigiyrVA6XZlfqw4PlUlHYS?=
 =?us-ascii?Q?t5cPI/Lh1R6Cuj8n6CDusjYsJedWqIxBs/nj7WGd6ZBb4rEtIuCd8jEXnL5k?=
 =?us-ascii?Q?yBHQtQ5MVhhb7pxU1CqhvbXtduY1Tva2DvTq3ftHzn5z1EQgWpQ2Dpw8smAj?=
 =?us-ascii?Q?NpLyPPC8+uEcATRTbIIe7+YHWND5Jkvup/W2nj9Dnk2DUMWTqxehG6e9RgN/?=
 =?us-ascii?Q?loXEujg6EOn4fUnfcofwSgafcEhXOYtce2q5/mgY4RZnmt2K6plmnVpLdNFv?=
 =?us-ascii?Q?R3p5sfhZEKZNrYm34YUT3CAiftHPqT1/bt7rp7cfdaz+Q44OeyWxWtLvCgQS?=
 =?us-ascii?Q?vKPlVYmtMq5yEwA1P8NBCW0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a07dc35-9650-4913-8e56-08d9f5011b4c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 06:12:15.2972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlkHpTfCtThsvfKSskdhSk+ENHsCs+M9WOFRG85AvimppqKFGzYvNM8XNcLFQ0SAzzkkaS+iuMh08VvMFH6d8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3053

The fullmesh flag mustn't be used with the signal flag when adding an
address. Commands like this should be treated as invalid commands:

 ip mptcp endpoint add 10.0.2.1 signal fullmesh

This patch added the necessary flags check for this case.

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 ip/ipmptcp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index eef7c6f4..0b744720 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -116,6 +116,11 @@ static int mptcp_parse_opt(int argc, char **argv, stru=
ct nlmsghdr *n, int cmd)
 	ll_init_map(&rth);
 	while (argc > 0) {
 		if (get_flags(*argv, &flags) =3D=3D 0) {
+			if (adding &&
+			    (flags & MPTCP_PM_ADDR_FLAG_SIGNAL) &&
+			    (flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
+				invarg("invalid flags\n", *argv);
+
 			/* allow changing the 'backup' flag only */
 			if (cmd =3D=3D MPTCP_PM_CMD_SET_FLAGS &&
 			    (flags & ~MPTCP_PM_ADDR_FLAG_BACKUP))
--=20
2.34.1

