Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8867FA
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EB4cf5g9CM7KldsOVaHrZ9UfQuH4hb6TkHfVdj7zjiE5UWgZn3ZQN3SuF40o8cSEkRZcD6JeXzfUWwXX/RDiLFRqT3S/gbIeCwHait1nMMxVZnvnk259u0qUEJXCZhsimA+P9/6arCklQxnFZPZGVr/IQ1ar/HfJqAC1RZXiS0yH2crqSHsrpoEXzRpuQQZrOo3ZM8bo329aFo9V9i3lgemMHvNDtjaj/B6D5W4FHjlgXHdrEJnSb96glg473fNDqnVOmP3fVWhZeWpMe+puEUc71CWduNX0+vJ0CH1ePnNmxTygqwYCyJ9IHQPQ+Tviv6im0PbZoz3lawDpQ8I26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFHYA/XTHN9uqzS/2yBq+enG0Zn6YuoFrwp/K4mk8Io=;
 b=XG9Wrt3sOKxDzliFOvSWJc3vmt3YwegYOkjFLd22zTyDIwz2qgR/oZ500qXHf4UQn6raBKYuzACjHzpQ0+KCViA/CIszdt42G2S2EXO3iUz9S5etj6NJYjx/ThOse9dTGFNQrrhCff/UyJC2F1rW+yb8RnUuujplSkO9RNJ99leHj0VIKjrh2GfeHh6kqFPSIjNizeZm+D8FrKvL5XX6a/0RC07Ggqv+xrjDqWa+WOAiIo7Ro26taSI/ybzokpgfoJ40ztFPHXQdyd8XlSzEaAE9Sy8D5Rtkd9G01W+9bOR85s7qNqCekSVIV5hLjj56qqhfEJcf+YuyXZijUmTpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFHYA/XTHN9uqzS/2yBq+enG0Zn6YuoFrwp/K4mk8Io=;
 b=VxjIisE0kVoWa4uAJUQDFENxGmR8q5obwgky6aEl7sWP9DgM6BIig9LDZSK0KGxLcxh3x4XL4bto74gbAg8q/XAJxlh0Rg8KjNvyE6ujAEOiM67Rk2vjnIMbluiyCz1aT+vr/G1ePMHdSDVa+xXT5SDYdtNNAfJ3KcNNpELZ+42isYl3c0Crkydt6DS5cVZ22QcW4KA1pHaVHYLAHelmts29BVwuorZIJ5Ug8hdyLQJdweE7StMRYE1cHZ1PwOBi5TsMYu5D7M2j2UgYAzXWEzsyfqMHjM3ydU+VdWpZvtbG+r+mW3Kz2XPA3+pt9Hjq0zgZuqYfTvj7/Sw9Oo81Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB9922.eurprd04.prod.outlook.com (2603:10a6:20b:67c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:07:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:07:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 02/11] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Tue, 27 Jun 2023 09:06:45 +0800
Message-Id: <8634072d697210e57bc48962a46a8721af12f4eb.1687827857.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687827857.git.geliang.tang@suse.com>
References: <cover.1687827857.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB9922:EE_
X-MS-Office365-Filtering-Correlation-Id: 850cf390-30c7-42eb-0d1d-08db76aad6b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s7xX0L/rvH0DjQaJBJ23//b2YWgdsx6jmmhM9JGADR3xA+e4CK0TwKpgdxZ6gBtGGoEtFFlAXOs58yAEykBZCiCdDeiBCuJDpVUeLzrvC/W4M26yUU49IIrcHYwmj3APFinGkWI2mtHBS/z0spM48WXNcMKiTUJObqSDRauJMRwRJqQYkoimPF3CTeOM7gyNyWGSHQAXHhuzhfVFl5F/7WSqokLzDRJgOXDxy5MbSb536ZwlRcF77tRqdHu3+gaTB3wLnUGt6bzq8f4+QlO7WJZhz1IuEzYv9DrVCHXMqvQ1DiKvfxo49tYgEEF9Qf0KXj2y4GNkp+t3jzpU0/Jt6nI6CESfAAfnuZiwHJlxUJfrX/mUOH+/mKQkUriyLY5wRSpAijVdNxAQ9aVoxZtFyjse7RI5LObEeHGPDozTrTlpvX9JF3qzTdUAAM8poDtmtoRN8e/S4PMhXlEUG06Q7UJY1aME7BMIlIIR7tI5MoIDCrdqCUI8ouk9ASyEL2AgVkTWduUjFGJtHx48ufbuxbS8reU6HKWMNaMcg1RoIcmfRaz1byJcsx6ZgjxR+9Ms
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(186003)(6486002)(107886003)(38100700002)(2616005)(6666004)(83380400001)(26005)(6512007)(6506007)(41300700001)(86362001)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(6916009)(66476007)(44832011)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M+p0D4sDJOZiKGizaVzwOz+z4AJLiFta6fC3UPvjK0VtFM/dHMuCEIU3JDaT?=
 =?us-ascii?Q?4BaoT8m8QaSy3+9ZSWLkD1qvELBYQSjGz4tiXKhowxHlFz6rxJ8modzjx7AR?=
 =?us-ascii?Q?ogRVQjxS8RXcVn44SyBQOyNT49TFySkpCVOZpwF3miSHkrO+oKhiE9qRqF6C?=
 =?us-ascii?Q?I4uWxkF8Ng80aguqGvIBKWN35LOSoMLU+9HuaiRNy3mTIkXpY4Vr+Ng4EPsw?=
 =?us-ascii?Q?aB5TYPvRd8eu35V7T6D4uDGAHsMm1v3iHAPTlsTh06uiFm+4O5v3grI1WX/8?=
 =?us-ascii?Q?06rNKh4XvXh5W2BauNgWebZAaqsmmm90KZbk+yACfDSZzSEL147UcPUyIYMJ?=
 =?us-ascii?Q?iaI8TZV/rpFcyJi+pgNA3EjGBiL7PJm2qHF+4CkqNMb5Kc0SGQRJPWbPltjD?=
 =?us-ascii?Q?0ZBS4uDl1Iw+GA6fjhqHi7ouTjIYivv1EvbvHnI2dhGAtcJamOmM0tvm208p?=
 =?us-ascii?Q?1tRUdfHFLcb00E4bjoVKBtzHmLSG6S3f0X+nJmjsOtNFfJi5UqwQZvFrr77/?=
 =?us-ascii?Q?gNCoFiKClluXo0byIaDXEn+T4w+zdSsmQaopYsCwOAZ8irhafR5fAnvhyxJw?=
 =?us-ascii?Q?wB8uoo31y65/Po+1t5tL23Gln+x5VS5GBijKiXD0wPSPQz11dEIG+LNutDJI?=
 =?us-ascii?Q?MWGQOagweIpy5NA8BoDCQ11baGf9Gh8kGQJ7cEVzlxxvuowV3mtXcBvihJlW?=
 =?us-ascii?Q?8CAu1tR8TU2X2dbenl/imwZRXROu5bu2Z3fvwezzmPGtHMWX7Bg9HtpwbYO7?=
 =?us-ascii?Q?pghNEIbAiVg041WG84UAwrBjKkBJTmAPoxozhLwTH1ctHIL6OSkANZQEboXU?=
 =?us-ascii?Q?2BkG7Ux/oor5+K2Fg+p4ceU8/f9cWBJT0F9gYgWHBbC0sZ6JVUvpPKPf1CgX?=
 =?us-ascii?Q?ugAERmkQRZVloV4stTiCHV/AThWPK6ZaKDQDoS0RkmWt09Uu+C2Cqg8kpLAr?=
 =?us-ascii?Q?mYH8aSAbOQVK0gXZZbjuIDyEbxwZ8thnyyCnbWoZvfQt9WO8eRLjrTG3SklL?=
 =?us-ascii?Q?1Hdy7E8w7IFafC2paWAh8RZgJzSGyny8dV60+wBop30z14mpbtXtBz/uWER9?=
 =?us-ascii?Q?89ssVB5kZWFzYGF1BROEUz3lhZ/tnJNkWi82mgdWO95PBN0iRghiqSC7qxFi?=
 =?us-ascii?Q?nzHyYgBKjd8DKu3swPVoB4F58Bx6iQsogVFGSDMW/Z0lk+VjlpF+3QFoZqu8?=
 =?us-ascii?Q?1pkh8RveyyAHfUuxsCpoilJvAJ3wOKnAyvmJj3t9hTaPv/l7iUFp9zixKnXU?=
 =?us-ascii?Q?1z1+i7xsNqtGT0xKEGKYZwj/aAmOaARvNuxUp+F/PGWByyUtZ8QLyy4YcqVb?=
 =?us-ascii?Q?24NM43FWIz20VpPY7IkmEVvt+icAeW31+CcL51PN+ILDvmob8eszz1Dv9Ujy?=
 =?us-ascii?Q?F4vHlWJlWULSa2JXfbEVAXZ+mYBuxhc93d3EOJKWIB6H9Ix/PU27+oRiNaoQ?=
 =?us-ascii?Q?1TQYn6dxMFgbha115sAc+C7gbK8AF75Tl3jXW0+G6OCg/c7DDFFlApoGY2lC?=
 =?us-ascii?Q?F+NkOu+s5Kx1AXXm/B9qIk7/mi9erA72y/fwd4/Vr7erhDRPm9yo03kofm3D?=
 =?us-ascii?Q?RFOzto8pkhzwuBawGL5y25LggEo6JfjXmZyW4kIp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850cf390-30c7-42eb-0d1d-08db76aad6b3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:07:12.3471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VBH6eM64KLZCxTrKuEqM9aqbPFOHXme89RWRqcL6PY8cDAtxhgQiQqXysmLrWwC7cfAY53aWK++pipRjXSAZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9922

- Add subflows in mptcp_sched_data.

- Drop 'const' before msk in sched API.

- Add const before data in get_subflow().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 828b10ddabee..ba0e1ee68a05 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -101,21 +101,22 @@ struct mptcp_out_options {
 
 struct mptcp_sched_data {
 	bool	reinject;
+	u8	subflows;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
 struct mptcp_sched_ops {
-	void (*data_init)(const struct mptcp_sock *msk,
+	void (*data_init)(struct mptcp_sock *msk,
 			  struct mptcp_sched_data *data);
-	int (*get_subflow)(const struct mptcp_sock *msk,
-			   struct mptcp_sched_data *data);
+	int (*get_subflow)(struct mptcp_sock *msk,
+			   const struct mptcp_sched_data *data);
 
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
 
-	void (*init)(const struct mptcp_sock *msk);
-	void (*release)(const struct mptcp_sock *msk);
+	void (*init)(struct mptcp_sock *msk);
+	void (*release)(struct mptcp_sock *msk);
 } ____cacheline_aligned_in_smp;
 
 #ifdef CONFIG_MPTCP
-- 
2.35.3

