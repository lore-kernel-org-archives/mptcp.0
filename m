Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63089CA42
	for <mptcp@lists.linux.dev>; Mon,  9 Oct 2023 06:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C3zUkyKX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7Yp/ph/nTNbooc3h+Y4OvBzb8wJ93VwZbWwNeDV0w07NSKoJm++INSvv20gu9h6sOIdCAmzSeJ9y19TA9/dqkxTSu9LcJ+xQAXfEPy7G3g6qD+Ee86yzw3A+sKjENsTGM4Ie0oU3FgHcg+mawtw6MHzePL4+D0HipaZEXhHXwmgjrB9Nk6wVllidmrPz+rod1vkbyK0NlmaynD12sVAOGbMrKtXoC/5ALWFtyA56TkwYz2RDj27Ix0JL9rQ2Ab/2j1uoO0TJwxcVbhvDzoi1HERnm28YTsfxWXIeFIpN+x/vsAGafvTXAJgD4rLO2cnMKacEv0oQthuF6pOUlJnWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITrTqUSiTFPQLH+n/E4UD7SU+WUhgfcHxzNk2VWjDqk=;
 b=Dnf4inOTdKvurrB1PsvTriOATYe6YS9jy/Ca1UPBY2lm0y8GsFMnujGjSqex1ukyIsmFliSqulq+QGmP5EIX22d6uy6ySdcid6VKwUxFCRrIJNXsmgbu7dWVi/qrAa1p93mvZGVYshN/Dha7Kcv+fmnabBaY6j6WcjMTGf96EYqiHx9FEphdnwN/yUquq4S6CAazpaoDtpIfQs9NYmwmjhJ+iUclTr2V6Y2klDbuX93pvE0+ibeyyC2eSQqrH5JaU0xx1t9r0L8N2Sz3hFNchjHXrzHsKkF+NKmqCQu1zb56r4Dgqy9OW1uOp1MkLpFHM5cZDS/KpUfX0zzLjSQXIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITrTqUSiTFPQLH+n/E4UD7SU+WUhgfcHxzNk2VWjDqk=;
 b=C3zUkyKXoIYTDkRKA6E78lc9+UirzmB6tY+iRs/qH2DBjEruFotqgiWv7DVV7a+hglA4mge98e2kW5VtyGWDGaK0Sx0PzgH9lD9LDQNwyBoRDMNCoH+C/Yre+NRqvgeopOUuJvbKG1u3eiQS/Scc7LAyxycU+ZWxAotdE0ujjMPByBoXbx+ZaLmYuwEbsC3DJWhEy11UxndYzx3Ht/fPpAVsdXWPD519IEnu3HRfdCmBS4EZHtVLgnc5u4iNYt4yeJ8fw0MGIC6JvtQvo0V3ghjTrbtaWzUt5at2JXZSIuzCEztJ84CSU+4pvRDBiptHtxGIyIjVT5bHX1efbVyfBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9658.eurprd04.prod.outlook.com (2603:10a6:10:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 06:02:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6838.030; Mon, 9 Oct 2023
 06:02:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v12 4/5] mptcp: userspace pm rename remove_err to out
Date: Mon,  9 Oct 2023 14:02:59 +0800
Message-Id: <b29aec52808ccd4d6996d09bf13aad298c90a9c7.1696831239.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1696831239.git.geliang.tang@suse.com>
References: <cover.1696831239.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9658:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad5ce11-956b-4af8-c5c0-08dbc88d4bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gODxcEbsDih8IRRYMJvjdUkPYZJnTgdMOAvAwzt4i41/1BOsd/Axwd+ZWHjXAu8h/pm6oTWhwUfD0PKHy+6MuGjYffjjR0GU6VkfDJwmj5utxx0PqIrxqIBJxzvA5kibrSS4NhAdPHmkj+eZ09i0/Urgopf6mJhuGHoNFF4t9o6cIV/hChaWjRvlySucGySioaxyOWGlTPAi3cPf7UpIUn1MnRvmQpmpRivy39gnzPCExZf44Egh2/1ZLOrULugzCjAsK3I27V70yUBXeffCLszK6Md8wt3x2KB7PIbqeifT3q70dSZrjoj7S/YAtepDvx8AYAKTw0yLkoixZJ+8jCQ/MYqWsJz7/oowPeh1Euu2XKKNeii8FZNJ538sSOhjLfypjdcFWAxI8CEv0PctW67i2XjTfo1H/7aYZ8An4dGD3GJG+la877psNh+sBHp8uXQdvPGNe93PHwFs3Sp6272kRf91bkX/OpW1i6LluBPMz1K76obxGaaSqcWyPLjxJ+wWHjGpxMcXdc3LxG/t7m7hO+Lgsk9bnSbCBb0lxfY5se1FJ01sDZ8A5lQU+OwDUH0emCLuD0k1F8mFOlyU+5/9bYu5NaRY8+Ivcj8amYE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6506007)(2616005)(6512007)(36756003)(86362001)(38100700002)(26005)(83380400001)(2906002)(44832011)(6486002)(6666004)(478600001)(41300700001)(8676002)(4326008)(316002)(8936002)(66476007)(5660300002)(6916009)(66946007)(66556008)(54906003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PHakUTZmF4lYzvlwI4AXxad+TE1V2V9yAfAOvmtACGZ/wwpLgW1wj4ZSb48P?=
 =?us-ascii?Q?z/8sjiijjf1cRtIiiCGSC6P1sF0QosusG7aDbQSgPETYV1ueee/XZ4hpt8sS?=
 =?us-ascii?Q?pt+VVA9o/lNIwZ3mf1/1O/JuHhGZDhTfEzd3PxSNP0MfPnhBW4wocYiF+Mcp?=
 =?us-ascii?Q?NBD9qXLYjlBYtG4G7SySQj+CgEJN4o9iEpVu5iVXHq7jyXUOSyuBNj7mhJwH?=
 =?us-ascii?Q?yXoPm8+3TvOBaBiKrHPHSTrR4/e6Xl+9jfxDIzxfK8CmmgL+hHzunAi4sK8W?=
 =?us-ascii?Q?GcQBI9EJGgk3baA9vftKEY8DqtC9ZURied9t6iG03cZWWcW7mWDHV5Hm1l4J?=
 =?us-ascii?Q?vZYRkP9do9pcYAxwnLt+aIIps0Do173RCY4SbJ7QY14e2VT9+tPTvWU7JRG+?=
 =?us-ascii?Q?nD+mQ6a1RkeXoJpE+B6xdfN4xfMfoYw9N/MzSCTzTivx7oMAxUES0fHXFB55?=
 =?us-ascii?Q?f1fGPbmUFRRS7DVpwBD3AQkNyyIRES/MK/HlCb/GaYZHz3EIl8CRM2rGoHDO?=
 =?us-ascii?Q?FWn0LPuaL2s9Dp+5+AE0BMsBd4fARCdfrCrXQLaqRwTYpoy2pckTkph6iJGj?=
 =?us-ascii?Q?HcytZVqyZ4egp9yaCEu0Poj2Y5bIO5/pLRZ73lR1knKvJDm6rM8MVpJyLbK0?=
 =?us-ascii?Q?Kdie0bfeP+vVqV+O+3XmtAhByRK6uQQMAp1F6ls4JDyTSHKCb03B9jnGLUnu?=
 =?us-ascii?Q?uwRW/xDmLpF4bbVqAhrFD/ZarB9fVpsBuZ7lwavA7/8q1sEqTbA0XqEOiGS1?=
 =?us-ascii?Q?StjhYLblwR/+UsKspJzjCDXfGpNUcDkuPGMKyElaZxwSmfOrArgWwEjl39eJ?=
 =?us-ascii?Q?CrNI9zE3+5+hKQD5PHdg/3GTNTFDn2hPsB9A0PXgX+wEAIIdRJxAEOK2vOfe?=
 =?us-ascii?Q?KBtZ9WfnTD9dPEIQO1FXU+O1B2qmaYGtIXBGhwsUw8SKPCaw/9+dQ3Y892J9?=
 =?us-ascii?Q?xisb0BeaLuYkm0ndvVFt/Y5gn6LwJV9azBr8heIc3G7ih1mlfvywKSDx9uVm?=
 =?us-ascii?Q?zdwgJwm69ICzb/cKoa2fRnWUqP30HBFvVSbjhC2iVPIjcCvXiVHQtjij0SAD?=
 =?us-ascii?Q?XPzEjjJ5x3JTz1Ie4SKb6RF+CyliUcyFL7asBsp2FBEeQpF/1MxuEF8srmHN?=
 =?us-ascii?Q?cqgdw7oH9HTWLXcmGGpxLdwOcK4VqMaOKol4r/utBGInt20nd82clVuFuxkG?=
 =?us-ascii?Q?HeM0HApAdRMN7/nEOZeAmudbgzFOmmz2iOss8E0XVmOSTkIaot4iCHmgp3rx?=
 =?us-ascii?Q?MRC1XnHT7pcMAxZTCtIUEOkEqYYNidrTAwxJVvljaDgo8WFGhA+bUIKiphrz?=
 =?us-ascii?Q?xV1dPCXZkdfMkp5U1uod0rNng3joklMwjjylh1h4zIROGafL0p4eiooTt0/J?=
 =?us-ascii?Q?hqDATZyZXTv4MtUhKyTuHYtApGPe+x2n+XeYfVKVMon+DP2wjNit69UPWozJ?=
 =?us-ascii?Q?vn64LaUkqm6ziiBJ8QN4Uqkt8rApQriVUm9nVx96EY2+jOeLDPAfYJb0Piwm?=
 =?us-ascii?Q?emTpXQTLmru5oeZvG9HbUkws+W2HiwM+zwh9vT5dnnRh82z28XyDNU85bnoh?=
 =?us-ascii?Q?TxZ71DIF3QC4WWRaWN2QsRMd52ed/XbTmzIItULH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad5ce11-956b-4af8-c5c0-08dbc88d4bdc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 06:02:19.3023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H437QNWmIUT4BQ7f70s8GMX9Fkkiiy7G/P58tCs0DN3yGS3Pozgbl5K0L/2PoQ3+g5NoaTIHITXWiXy+6eff8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9658

The value of 'err' will be not only '-EINVAL', but alse '0' most of the
time. So it's better to rename the lable 'remove_err' to 'out'.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ea50e694125d..cdff3e631d2d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -276,12 +276,12 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto remove_err;
+		goto out;
 	}
 
 	if (id_val == 0) {
 		err = mptcp_userspace_remove_id_zero_address(msk, info);
-		goto remove_err;
+		goto out;
 	}
 
 	lock_sock(sk);
@@ -296,7 +296,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);
-		goto remove_err;
+		goto out;
 	}
 
 	list_move(&match->list, &free_list);
@@ -310,7 +310,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	err = 0;
- remove_err:
+out:
 	sock_put(sk);
 	return err;
 }
-- 
2.35.3

