Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344A5180
	for <mptcp@lists.linux.dev>; Sun, 20 Feb 2022 03:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645326012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzXwcVDuNKqrtO4NfTg9NIF8TDNB4V7sFWnHPTrpW0Y=;
	b=fc20XrnnT7NzKSOC/XZ+8OibHYw5ZSMpV4oaAPrhHRSHELmCsJKCFJiJLMFlYVHMuOPHzA
	l65B623TFR48Act6uCBOP76kv4P98MSLurYA51GTgU7pkJ+tC/IlJuZk7eAFSwL1Xg+7Y3
	LoganpasVpgCBUcHK9HfFBF6QUbY46g=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2051.outbound.protection.outlook.com [104.47.5.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-kuwVfxFDMkGlic_5Zu248Q-1; Sun, 20 Feb 2022 04:00:11 +0100
X-MC-Unique: kuwVfxFDMkGlic_5Zu248Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fk70nlH2cf6+We0cqr7BK0VJRkOBCgMuhFd8GMZ0GAWQdrdORuZefyz4Rs6nUQamtZn41A4NBjU8CzIfNmIpDOu9+64rTEXrVBxevTHlUG9xT42yLN0/bPGetuNLQ9KouuIF/Pu4qq8NCyI/Kz7glmkr+sXldk7UXX5bQ2h028f5lwaqAEOZ4gg/GvMrfz3shSYv0lNJTqC8xMkYY58ShHHYsA/PbLn6Lrkejs6O8tw38nB2NlsDzPquXM49tRToMMWintKn1F/jkmTzdQiQTVSQZFUxtw1agpSDOIjL8FXdRp1y9HCubgugZOx1MQktn7eNgLpSRSKLaVJcyZn99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgvkD6LDOzHte+GB3x3jzDk9bJTipAR8a/ghSHJmFPs=;
 b=l2IZYfGAfymQRWXPemm74vASUD4ItWQRa3LzPzia64aX0Vv9pdX9/vomjem0/KLOQ9vJOaDk5yGQHIoIlKOgqfcsaK/h8Qd87gFEqkSNpqEG1uD1Vel9HSJutx0u6uL+BasHAKycb/XjbOpuxvDXyHE9vzeVGcWbJjn9ORbxWJK5nLrrFkggK6tGGZQcsSk8oHQav3B2G/CcaXw4rMh5QVNpv0XT+I4XmDbJS3jyVnaOAakIWycl/bAD9zN5OTE/GH4qXmPJUUmiym8Jc52LKg5GNNFpxlZlbJ7IwXLlyyTJOpcRlNowBN4YTLGp99XtYqjKZVrYumC+qRMvYIqrzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3414.eurprd04.prod.outlook.com (2603:10a6:209:3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Sun, 20 Feb
 2022 03:00:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 20 Feb 2022
 03:00:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next v2 08/12] Squash to "mptcp: infinite mapping receiving"
Date: Sun, 20 Feb 2022 10:59:34 +0800
Message-ID: <c89d73eb0a89c85c4d8483bc0d73ab93fef0eff4.1645325178.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645325178.git.geliang.tang@suse.com>
References: <cover.1645325178.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0019.apcprd03.prod.outlook.com
 (2603:1096:202::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 798313fc-ae48-401a-ad43-08d9f41d1b68
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3414:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB3414548BBC7EC5F58764D553F8399@AM6PR0402MB3414.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hu4uIm6/6vdJg75SxmVl6uaVKazxMoHbapgxDzTSNbOX4CLJq7qTGDYLu+y1U5vpfQG6/aNUtHbplmtOPKN4boeDItCwkEqmc9NoRDbP3YGoYlPxCLH7l9nM5fP7lSHxS8fwvM7YE8hYVimlnNK6JLBrfEZxDTLzHYZo8sjcvo7oGJqYeXUaRpSN1d28WPmJnQ5WiljiGkp+c5whr6917jORJcF6gaAi8SfxHCZhekN+jpMPMjCiR9erAdKsnyf6ms5GJBKxV8Vsiil6Ti+oEZD1cyiQUYOaQOlnHQZFqePTKg3DphJwP6aCeOXDNALH5ljDP4mSz9vo9sjEQGXdUqVwzu3jtg4nn1aMrk7enZ3Z02+UkCwAcwyBK1O5KVGIwAOLeKdLsrDAIO6rIsqoOfbWalc+rMdXbGlIsiTBlfD1WoSTdwE+iyTaITlNUL1j/Hm+YDDjJFiwhRG6mt0qo/qe9zqBV6CEOZrZHfK/lEgNamm9cJx1o8DGnrdOdcA+J6YC526wl7zy5jY6iV+DUSDyIc92DqdiTOiDopa4da7OBnyAdzzBxNWM+F9fski8QEY/s4GP1mYxe+ZF09v89BhzCJJRNPJ6cmlVzodCNrF4HDw7imE8LjKWM7UyUn9yO7+BrF1nM9ZJ9Utdaat/Cg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(38100700002)(2616005)(36756003)(2906002)(4744005)(5660300002)(44832011)(8936002)(6486002)(508600001)(66946007)(4326008)(66476007)(66556008)(6666004)(8676002)(6506007)(6512007)(86362001)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5EMFWHlsS6RJ9SwcgZ13JeEDrrE2XMndmTau0d/1C78y1t87q66oGsEr7CN8?=
 =?us-ascii?Q?kofybygwoosNBNONs7YRQwaP1YyO0yebLQGeGOGIOmo46yTGvRIUvrgUClij?=
 =?us-ascii?Q?zv6bHucP1v88tT2xpKVcWEYmNFD1wHbySzd01NOb7c0DO8GE8vwE+vgvuO9f?=
 =?us-ascii?Q?WH0W6AeaxgBhoDbjex0HdN4Og5U4hfqog50t+AyXCEYeRb/9iXsMlukFA9Ae?=
 =?us-ascii?Q?g7J9OXVc6VSchepgdTseMSGXVjZhm2YOd9u33BuO6uEPGw15erZlAxMwBRei?=
 =?us-ascii?Q?uGgR0ZCy3DDbEUcqx8T+I5Qg7PooWBc0Q1x3pkLWxdRfsrQWn1NO1llZve17?=
 =?us-ascii?Q?EN92wRNcQsMTeE1hUiPafOvooUXjkcTcenrAdyUmF9Gp/WQdahJ9pj2m6QVE?=
 =?us-ascii?Q?4xq0/vl0MCG8KD9HWkBam7WGHZpL+S/Mi40j+4pS2oPO/GoEIlcQ41j6xGqz?=
 =?us-ascii?Q?jj7Q7fURqcusv1UrLnBnIQpX303NTEoOC+V2EWloiXxfgJifzTYKX0vrR5Pp?=
 =?us-ascii?Q?8Up5bL5J9dXSys73ryi1WLJJW8/H0Q50nPPiZguOcMk4Wd16YIBEWQJyqOjz?=
 =?us-ascii?Q?6088hep0H0FejxK7MdhqClcrPp7L5LAVY2b0ZYf+rhezxloiNsHe2uNCwOmK?=
 =?us-ascii?Q?92yW7lT/x4aLO94vvDAQWvs89IoV88T+lL10/lEs95Xik5bwklFLO9Tjprel?=
 =?us-ascii?Q?lFnCIYGLVXxbCukRnauHWx7d6XUKG05Ar6rlbMJayBmHj1j4gxOybcDdDN/M?=
 =?us-ascii?Q?rU/xVjzjpO0PICj/mkYpo8m37RXvMLBtU66zpbVMXTxkfkcCFk1SSKLelvdS?=
 =?us-ascii?Q?79/72PJAPf1jjdsl0oan2ISWy+6/xzPOzR8Csp/qHlRXPh6c9vRpwEZxy0yc?=
 =?us-ascii?Q?Jsr8a++gDeJkhH4xRAoVjI7BbpWoew0y31H4r42NGxUHh1dQgi2uGW4h4nOZ?=
 =?us-ascii?Q?WUIpWqf5FqGXbydZMlWPeqNQM74ms+TlBGvRCxKVegOdaToyyKzsJ2JJZ5n3?=
 =?us-ascii?Q?9Ij1SHK5OQPYrCSX9SW6vM+acJyNx68ywAkgUVMjV+DTgYGaTaig+Ddfo8+a?=
 =?us-ascii?Q?Qa8pMIKiGt/NY827NpV1sm4oz2x6tsKXdEv3tW37UU6IwubuLpoAyN9gjC9d?=
 =?us-ascii?Q?1zWgA0agv5i0XU2uy8qL/pfYfLYTmkC+Sv3g0kYN0NG9QCI6WMjA9Q9lMJv4?=
 =?us-ascii?Q?iYOAHLk5IduvV7z/Ufy7Bnl/7FU+KxvDzHrcsT7i9y0z2SMBy6aXrqvs38T9?=
 =?us-ascii?Q?9nQI0e7USeVCjQB68i9q1Y3Tz0/eqjh9taxM2YKtYyPiYY3qMlbSy99I51EQ?=
 =?us-ascii?Q?KrJ2Ea9kZyuhbQfMgli/r0R+B28d/4LGgmajwA7vTsbpzB9R6C3L0LCkXjRC?=
 =?us-ascii?Q?fG1qRftRZfCAGPZuPvGpcvg3UPtDudmWzBv3H1S2Na5B2QVsgsrmLN68eIwG?=
 =?us-ascii?Q?8NgJJoJNoeXGnDejEstXzA9LAheUejSwCb2zYFVTANtbcTQ87W5QZCKsG7hg?=
 =?us-ascii?Q?PZg1GbT62Ewbp97SFOY5R4aQCbnb03qwbAxO3Vgo+283Cz1gn6xNUmV9kro4?=
 =?us-ascii?Q?qXIq8exyQGaSsKdzH8ZtXTe/EtOUv31bFYqFrSMLr8SCBjOrfWoKnL+29yjU?=
 =?us-ascii?Q?rdUBl01p+B9AAEHDMgXykO7Rkj+XRQNXvlntu2gqbC011b3oa4o8T8OkucEW?=
 =?us-ascii?Q?L6Ln5joRpVuOv59yuH4UAaOtebw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798313fc-ae48-401a-ad43-08d9f41d1b68
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 03:00:10.2896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0y0g+t5QZ27OzBCMQ5tlA+1JDrL2WoqN+9bicLtoB1xX/CI/DqDvymp4CQeuETIa+KAdlQBDghiY0dFvhlPLug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3414

Print out the infinite map received info.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c05c19f92532..30ffb00661bb 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1006,6 +1006,7 @@ static enum mapping_status get_mapping_status(struct =
sock *ssk,
=20
 	data_len =3D mpext->data_len;
 	if (data_len =3D=3D 0) {
+		pr_debug("infinite mapping received");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		subflow->map_data_len =3D 0;
 		return MAPPING_INVALID;
--=20
2.34.1

