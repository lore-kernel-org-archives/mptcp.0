Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF487472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P33EshG4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSQ3EUmfwG+TG4DlfecD8a4Sksoe8LiPSo3AXbqciPNChscw6yezjnT6mFyDAZTu/Tx/ochx1QtGdBJGwNoABWOtSUkwidSQvt4Ulz7CLdGgWddF1BPls4Zk8MCbqNXz5hC0VyhybqRpFVGdQ+DtwqLN0FAujqFJr51nbAfeC9GAOqra52BOq7xW9o3fnrpNwN52bVn1IMJc39iwZZqrZA2QoUflNUkY7R5GjvmP6l57bNh+3byMlrphnWLj3bo1H6Bw+K1aUSPhnl8NubxcBHBTsrXIJD+RmX6NY2t3utJuCZ5ypn1gWCTZ5IOzwKDtkSbHzQekS1sKth6RiTErww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L97WQciFddA7c9qh7kd2Pvr8agY5jrzV0Wska2LTwVI=;
 b=fodWhmJf3c26HVJ5h5kd3pbLJy2yS7DK/6KKkRBb4fO9apsZiYeGYJ/nVM4w8gUF22N8LuSKOBBf5SqjUNCONp4njoyO0FDrtblfHnn30MVmeaFtTQ9z7x9zuDXsWXfirBPeAhEW2mqyqdg+udFLEOKOHsZ6JZrwGwAsUZo4vrAO449ECB+XLnBUNYOpPJvek0PfS6csQmjlpQ20Ptctm11inYs7YnwqwNUyG0+FK+WXMGBsMDdkDphvAmK9EDQyeZ8kQp8Nq2zKBM2b25H3dPgpIKukKroPvxtWI/z0niK8yxIaSIKHcwPof5R8DU2AqL9aO9P2z9pbqzYpY2X6JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L97WQciFddA7c9qh7kd2Pvr8agY5jrzV0Wska2LTwVI=;
 b=P33EshG4UQt44MW2U5+WP2LMgk1vSEub3/tSHjIsezBFCbjDzgNYHxYTntF9F9I6RpFSTyWU50CaKgdxnh3eys03I8hv58qz6AHt2CNZtii9ZXUj41nkh2JZ1olYzQ6T6oHv33ISbebHlgCy051z9ZrjYGLOkjVCX0DLyXV//60RAHiuDSw7SLOjLu4FBfBhETT2ivJqhGsG9Y5F4AJCqFM9KSZiMdX6aDE163Tv2PdcSoeB6OLEbwx0nHBZ4EVCAbsQtES9z9rbm6dqVKf9XHaKqKWsWFcDmn4J4miJXvt0CrsHIp7v1prZjM7tKPq+Eplxqi3ao34vyiiCXc8auQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8874.eurprd04.prod.outlook.com (2603:10a6:20b:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 08:36:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:36:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 07/12] mptcp: check userspace pm subflow flag
Date: Sat,  4 Nov 2023 16:35:42 +0800
Message-Id: <675f12e6353058e96e50f599c0d1d4c126eca0c5.1699086244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086244.git.geliang.tang@suse.com>
References: <cover.1699086244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 10869e16-e897-4a8e-5fc6-08dbdd112648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+Izr0Hx+8nrt4gOGlYevbynNAwRvk8dSEKY8zu2g46MZj6QeAucFPFYuoDCwfdyJxjHGsdwS5ZYAhststBJnOoV/DynzuoV+fS2+ebOkKiCkIY1F2QUP01M+zyZFVyPl2kBn92WJc8Pq5AyEq5noqM3wzTHKp5V4k2+wwgvsJg35bZ6YMR4X16t2mbOgsLFTWZ6NHqcG1w7TQMU0Rn/puZGZLyqtDaOoBNXjgJ6VvSEiAZ3tU0vJy/W/chaLZHYPUQTGWfeoiLCrs7QTsCy9oZFyleYGLTD4YGXq9puZsQgYH/lp63/yqwLnVnVEjbG+ve4Sj3gZs3kMjm23fKq09UK6arJnjhQhXkb31NJiqpfGqfbyMPIX0QEp6SIIwamVFXAYXysJSPamv7Dx7p+kqPDxO9PcwsYD2Epr3HWyiwyQxk5j3k/jKvHpJt5wrubHatW080NDb5QdSaIqnpgIQBKrON+zCnhFTh4SbAmhAYUSqzdfJgWRQ4FuAJYgOZIJ3RfdqvQyq8GYV/dCeGxFQCdZlThcjPaKP4eZauAex/c4vENZpeplPwWHMBIvjGOV98D3hISe8osSWrhjAKnuGdkD/h1SVfJiruA9OZ59Tzw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(316002)(86362001)(83380400001)(107886003)(6486002)(8936002)(44832011)(4326008)(478600001)(66476007)(66556008)(41300700001)(66946007)(6916009)(8676002)(36756003)(26005)(5660300002)(2616005)(2906002)(6506007)(6512007)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rjD/GSZL5j4IgT6EJ+IHArMs1hm1dKF84LukXwwgSdlUfUpVBHq2Ix9uhIR6?=
 =?us-ascii?Q?A2EvZCfDM+fUQ7+0tDOOUp5LKEqlk2GVyLMBGNL7HmjQ6dEgJkC4zj1TZBDk?=
 =?us-ascii?Q?VfCY26xPbPUYM1/OCHeoK7ZIEQ8gtQKR3TPBc0D+Wa4fLsKOKvR6+7CjN5+u?=
 =?us-ascii?Q?3ftMapq9HPzjK0eetmA85yeJomufKjCEYMqMrJh8eUk7VtpwmqBO3zf9534y?=
 =?us-ascii?Q?lSTe9TU5ZYEnwPx0kMMgCj0R+stAfGD3j0VsHIOg10PrpiDEfgJvpOqS79DC?=
 =?us-ascii?Q?A9zDlRxaL6t7TsxzO2jeb8TxIahLp1j+mk8PskmIjLCInyj7e4AMHflDT9+a?=
 =?us-ascii?Q?Y6tSMEe5gthb46q39z4HV8IT0H3/ERjLRot8v5gDHVElSMdsgEWQhnaaO45X?=
 =?us-ascii?Q?vMC7OUKse5DDxI7jku8JfYC5v0LF5iMj7s/Pbgq9zezrte4P8IsCt4hoaqri?=
 =?us-ascii?Q?RQsfdY+MaeekRc3AiMGFPRswU3yUhxRyyDJp88LyKJLDykvEFajSOf585vA0?=
 =?us-ascii?Q?8glNa/+Tm4HTAidxEuAtPRqJrLwFhJD3aNndh2QCKB2WaONCU5VyU6+OMnSp?=
 =?us-ascii?Q?I2ht/4TfybLqveMswDEScClfdKl+Zlqy0X/deJwY5teIOmw95gvj+cBhirax?=
 =?us-ascii?Q?4c7ju4Koi7DbhYGXIQwFxTQF0EDj6zkBPljKpmt1V3vcdy1llOBlDczMVe1S?=
 =?us-ascii?Q?jLqsykDzRur38zE8X0YzV4MIO0qok+Cf6wGvjNqZdjBWmMuPZH12IezGErfA?=
 =?us-ascii?Q?HWLo0V3F6UjFPxdggclnvVtO/ep4KRhk8esrjSZ7DigAoqeIpHbUNQhtp8tU?=
 =?us-ascii?Q?BzFGV0oKNIS9lXoOdsFGLmb4m+k33GIOEbYl9PuFwghj6RLMRQxA4S2xOChU?=
 =?us-ascii?Q?r1r/0DnxyqPwEuwN3YZv2C92Oi+/Ypo4GckeS5iMHBcD0IMDeQHnQPR7hCD3?=
 =?us-ascii?Q?6RMNiq3RJAwczGw/6Kx/Dx7X9PA8T+B9/46FhVgkNSM32EDSSM4dqNoCKs26?=
 =?us-ascii?Q?cuhWrkVTrFq8Rj8DAPIILx2cedaGi026wMd1AAThR9oJqK0EWyN6y+P8dBtq?=
 =?us-ascii?Q?nxZsjDdEUFPfh6fUBDdbJ7JOqDm7mx6lnezf37fBYfEKGQqaXogRLeJsmqSK?=
 =?us-ascii?Q?1LoE9gPXl4RZ9X8NTfn2WGuhTJlgGEKtx7Q3rwFmGmgbbbZERo3+HTfdpgJz?=
 =?us-ascii?Q?fgbIAY6e5LtW52jJDr1QRYNDb3iqzo0nKZ4dCWmlOqqHNdnStiHwPpiKlw2g?=
 =?us-ascii?Q?TztDF2dcQyGYrjAgV1uQDmIYkruy/tPvG5aoNNKIzaAtU6DJblA/+XheLe5C?=
 =?us-ascii?Q?dR/W229zzer7MkKwcnbeylkneYzUghrTC4A72MvYzIfzc4JPvYtkATea3Nwj?=
 =?us-ascii?Q?ukn+kEoaj8fcc7XFCUUnIKiwscsiObS8bviAY5MDmyFdBPs50rQCjUhfH5Sm?=
 =?us-ascii?Q?FM93FDu1gVkD9dqzDzb+LP5fRASGT+w/s5WVURXcQNou5oXO/mK6wAHvusZF?=
 =?us-ascii?Q?JTuakoVKvpZPY4OHn3hd0DxiA5xVBq6edxTUsduZ0oKI4QnQRcGVfjGIKK9f?=
 =?us-ascii?Q?o3QUJN9SNyCXkiIclYY3o/2fdU+l1w7jUvHEeMj5Z0CVtkXMubsS3XlozN64?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10869e16-e897-4a8e-5fc6-08dbdd112648
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:36:33.0678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FavBpz9SUUuI56/CyRo6DUmoNdhjciZxQ/rfdy13/Wo5Ss/d9LrHeyofe01hWTgyIO/pjWKb9yDBgDzQvXpkbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8874

This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
to get the flags of the entry. Add MPTCP_PM_ADDR_FLAG_SUBFLOW flag check
in mptcp_pm_nl_subflow_create_doit().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 0e65b32cc073..98390d048ab3 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -352,12 +352,19 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	err = mptcp_pm_parse_entry(laddr, info, true, &local);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto create_err;
 	}
 
+	if (!(local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		err = -EINVAL;
+		goto create_err;
+	}
+	addr_l = local.addr;
+
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
@@ -370,7 +377,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	local.addr = addr_l;
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
-- 
2.35.3

