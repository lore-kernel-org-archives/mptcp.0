Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2411729CA
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 09:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641805718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XnIspUXdizVfwBHMF9kW+BqpF98bsfnM4PJXXeZwpsc=;
	b=HWGY8Xok3/ydP3iM0Gbd+K4wSeSb3SC0rNEa4sZntRGMNSelgSb3LvCJxo4Uy6Y1o2s+sC
	uZLM/lnW7y5wBzTTmZLup2Q1lHkzHKg+OtHn4kwKvyIscFt49D5gSlzskbjCfEeWTE+7qV
	NdVLQuWZycWOinCZ+XaefzTT4UHLgk0=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-apjuC2zOM6GL90r_fcSnaA-1; Mon, 10 Jan 2022 10:08:37 +0100
X-MC-Unique: apjuC2zOM6GL90r_fcSnaA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyH5ukCd8BIoJdIt3CHPq/oKxdVuO/Iii5Td9t8521jCwEaApACAg1v853EhKl3nCXNYJHJIJcVj/oSKgq7I5rX7yD7XlOmyWndWJJ5ksaWHG2cBfcyALMyMo+HQLgjpGPEYw5S5QIigqfSECclL0S9L/ZOoT60LMmadoQC+hILpKC7b8XKDzCYhWAabivZmOCTMK9/yPsmGk+TWinFAUac+u1wZWppep+ZLjtlWre3xaKRGjMmyXZM/dU68hqfzUCUjzvglOvZwC8StwcukOhvO6Vu7SfuKs0/HKUFOBenRuv3zip1JlS58n9oCK4BIjhqGBU9GeJ9wi3deMhO59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuxJqADmkz93qRSbwcoEll6iLavGHM2b3SzGPtrXpwE=;
 b=h/jxBn94Hmfq4Us13LWTh4pBDk+SJPkunsurFZngx4TbDq/C5N9QYVuIMV0llsBTJmpzv88NOI3Q3adYL8WSQoQ5EcV7+kRPNUNf41UWDP4gVczQ6MlwYRSAUFWj5qlyhnXTJtlDGhtQyrEoWpMRzz8DUAb0GbLST5tAOZMe31/xefizHPkAsZshmH0u092pHuLrSA6/OZv1rMW8OWRA8WyAz1M92cPMhwoAyPiXSgs6/S7+t3uyx0/16986z/keZfSmJ605aRREZ6upkyAD1uRD9U+Wbvkm7Fub4lMdCeARQ9oKNmObdtt6ZrklgrcypWYp7GICtaIMqkq0J1NMfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3244.eurprd04.prod.outlook.com (2603:10a6:7:1c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 09:08:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 09:08:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 1/5] mptcp: move the declarations of ssk and subflow
Date: Mon, 10 Jan 2022 17:08:18 +0800
Message-ID: <935c92627ac820e2a2544a4d79af0c6254a629f1.1641804767.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641804767.git.geliang.tang@suse.com>
References: <cover.1641804767.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0046.apcprd03.prod.outlook.com
 (2603:1096:202:17::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f30de170-96c8-48e5-e160-08d9d418c878
X-MS-TrafficTypeDiagnostic: HE1PR04MB3244:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB324443E48F1236AE81B034E6F8509@HE1PR04MB3244.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vWPoLQe2013y9X7wlWn2EyK7QOhPcLXYcUeXEWOvbir3bVNXUYBqDDIpEn7d6/va51QQhlUVYPeWqSMs43IEP6DRWZklh5qOaM48p5ErUes95v8zZde7A45NpG6/eunTDOap1YoHVZbUokv3+syJaFcIjpBsoKN43SR/0kX4IpCTceZi/zuhewj3ne3v6R4CuAtJf2pknvzu+ETdJjs30odvKkAZOPn0lQrC9d6ydCC2uUXYmRQ+HpfFvG4AMPE5thkkBEaox61U/1WxUtL9feAfBt+DHLI5jOFPG2iR3g91lCWmgSjdoGIsnjDxvwzKrG+tr1pFAWfRmajLYJrRZ7Ooq0Y0YPwE+e2aG1GcwNTTo/bxhKJgv5gXEE8t4zoiPwkfxh8Zs90nW+To23LPofe6jOaF4preY+y3PTrGB3xvaiwXH4dyvnOhpk5sz7fLvyCC/TnUstkdp9/+ZVLdo6vZu537bfscwloFjxt4TpjdWY0hjZ3tHZUXBFTaLTNvttYrju1UECvRfOrBymrWQzqxmJc3rQSCqaiUQvDxtq8pUV9ExeOm20DTUfsb59o0aIuRPNBGlLS147IEvsQ6seo9eg5Dn1ExTCeI+mdpDsijT5xkDXLZ5xbXq4TAWWiocWvLQlq4WHjp83B1RB617w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66556008)(6666004)(316002)(6916009)(508600001)(83380400001)(2906002)(26005)(186003)(55236004)(38100700002)(6512007)(5660300002)(2616005)(66476007)(44832011)(4326008)(107886003)(66946007)(6506007)(8936002)(86362001)(36756003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fyy7FfT9GTUo+IdwpdBozAezBDopKY1kWw3ysTb7HUXEPdBqVU+Hu1BvobAW?=
 =?us-ascii?Q?kXQ8pCX+UXru8aWsd3W9crRBEtkw3Ne9VhA5r1/b2Ey7dMVP4amkilyHAEav?=
 =?us-ascii?Q?ihYdYy9nKbQC87tUFVAQfApFcgOiokyjyanEBbjkTSvvt2K+tKzBG5bKy5sv?=
 =?us-ascii?Q?uBICS6ZYl+TSh+MncIlzxi4fki1hLAYu7enkLOOYG69oSASoYfWc/wOv1e7L?=
 =?us-ascii?Q?8YF7WUxUnt6guazX39ofcGVDjwQd9fSvNS18romqbdM/+HOt2Jj4ygXXNXHh?=
 =?us-ascii?Q?ItM1lI6UkphAoiyTQ6DtvYZ/IY3WaDPPVAxK5wzvAEz3fVFnMn4mo3Im8xqK?=
 =?us-ascii?Q?8EYfCUJJROgAj1WmtQCcuTNG0J4PLM6Efw7vCSmD20GBHB9y106AjjLPXR46?=
 =?us-ascii?Q?eQ1sjAVh1HmLp26OpIyrH/ttWeGTeixXyLKWWMO4F/5/CT7K+rrDUqXbLirZ?=
 =?us-ascii?Q?QChA1YvOmmMT7TEo0oRotvuNHvMMRsjwV6N7GZcAE/W4+EWk1QOojqP+5wMm?=
 =?us-ascii?Q?rsfUAHUcio4iF7rgGeOtSCC2F2njkFlMCCO3G25O55BaLweNkdfCyH3vO3Mw?=
 =?us-ascii?Q?sBvx/XP84YF82FmpOieQccdpafFsIdgUGj4tWXjBhdl+PFq/xCry2OYrajZy?=
 =?us-ascii?Q?07UV/kCa7Ac9IQ51Rljwh5CWOL9XMTLMsfQ9YPBe5/YzQk+m2oDSxNosBbq9?=
 =?us-ascii?Q?u6cA0EN02SvugEfuTGvWAa1eSheXO7LFDYFbpTYA7kjs91RgoikOLfs0OF/W?=
 =?us-ascii?Q?CJ/N+qbKPTPXcZdB4lZ3UZXakSR47PacUngzIcKzW7S2JbMfYzYi9eIdkdrN?=
 =?us-ascii?Q?c0y8Mv4iWTXuFqQklVP3D+74czpq1ybxpsgIzcTR1w+R76IKbuepTc5Pgv0w?=
 =?us-ascii?Q?VIzwX6UodvgZ0imBozpe7S1HGAu2EZS+/ev6vY9aZf5QLu9Bu7JnyMxVMrRX?=
 =?us-ascii?Q?VZ40FvVmmfBrtMMsVeRaqawvJ5YqcdKaYGj2tn//tZVD88KoSsGA3jKTZUFJ?=
 =?us-ascii?Q?Wdt0KUphmSF0IeIqWWCmOofsWhN1pXH8E/tP0WDmQxm+zIuo6bIbzswiT17d?=
 =?us-ascii?Q?f05lrVeM1cfWwMIfaFcdumVd5zrLhV2441EgduzN22BSmZrRoxEXTnZkIqtO?=
 =?us-ascii?Q?I905SGTk+d96KVqMeOw4VUkHNLarSYzM/rBXdzzmauJFvaxNk47Cp9o6ogj1?=
 =?us-ascii?Q?yMpC49H3W3UqVfkf/uk8GD3aeKcqZB3Fs0vXnScKQM4TBu+zIfJsFULteo/V?=
 =?us-ascii?Q?csFy/zjEVfE7Yo8S/E3RCl2aFjyd8xZ/aO5fQWD2SaNY1KOmKxayVPbqB6Fx?=
 =?us-ascii?Q?Ggs9oNcqw0b9LoVttetsjtPXqf2QOIj1ygMMoQUy7Sj9ir0WQNXoGNWAvdeL?=
 =?us-ascii?Q?2X7GFnc8w9MQHLj111Zf6wO+rkzePwSAaxGqpQo6LCCoM2fOs/bI8QeAmPD5?=
 =?us-ascii?Q?JxC/kuRIoJkM++6pdMeI0P4cb0xTTnfn3UepWppxmeOqyHGXSIzzKmvkfXnD?=
 =?us-ascii?Q?6b4zBYSTtXxq2VyaSkfTe8voDaOlEToKmT1YMzpvVzMAcJONlqUnPMZFX8iB?=
 =?us-ascii?Q?Lk6mJWWicilmfaDSpX1Vu3stUl/fwhNfXZP2Ze/CIBCUHWWIAtG01GYum+Ig?=
 =?us-ascii?Q?1G7WTVjGz9zPKy/ZZZavLkM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30de170-96c8-48e5-e160-08d9d418c878
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 09:08:35.8398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILZJ2Uvfs/uHizrKs7cas+mOHVtvpvuvNTARtZZRu5msZQTkysG5dogg1SedC6CmX+2qvmftSgz5IFWdLkK9nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3244

Move the declarations of ssk and subflow in MP_FAIL and MP_PRIO to the
beginning of the function mptcp_write_options().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index bbf61dedb4b5..3230166d6f83 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1264,10 +1264,10 @@ static u16 mptcp_make_csum(const struct mptcp_ext *=
mpext)
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
-	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
-		const struct sock *ssk =3D (const struct sock *)tp;
-		struct mptcp_subflow_context *subflow;
+	const struct sock *ssk =3D (const struct sock *)tp;
+	struct mptcp_subflow_context *subflow;
=20
+	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
 		subflow =3D mptcp_subflow_ctx(ssk);
 		subflow->send_mp_fail =3D 0;
=20
@@ -1489,9 +1489,6 @@ void mptcp_write_options(__be32 *ptr, const struct tc=
p_sock *tp,
 	}
=20
 	if (OPTION_MPTCP_PRIO & opts->suboptions) {
-		const struct sock *ssk =3D (const struct sock *)tp;
-		struct mptcp_subflow_context *subflow;
-
 		subflow =3D mptcp_subflow_ctx(ssk);
 		subflow->send_mp_prio =3D 0;
=20
--=20
2.31.1

