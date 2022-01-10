Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36B2C9D
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641805742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kgyBQ0ANWOK0TpD2uoNqRap7NHyvB6G9ii3v7UegqZY=;
	b=jyfSjyCJ7FydqQHl0OQtyIagWH7clY54TN0pC4+aZ6RldT42XuMJFTsxoAzDMzJ/INAzjh
	78ZkjqTgFggmfseIfpxOkVNnGyWdIjewUgKMvHF+XC0jlmamW8snzIfna/95YBiLlQVFfN
	MXlSk3I5kf+JXpSG1VAfXtQNPsgn05Q=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2053.outbound.protection.outlook.com [104.47.9.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-ZuPOrf4XNI65puqW9mLmgA-1; Mon, 10 Jan 2022 10:09:01 +0100
X-MC-Unique: ZuPOrf4XNI65puqW9mLmgA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAg5ySuyoa3eT/NbSxmSUh+JvPgPnZfdLJ3sNuaxkOXdb1I8oJWzNGgJshxVbWQNvbVh6HPfL3h0tOEUc+A+V5LrQXvVbFhcqs0ESbbWrkSg2owXCPNb0u4KQP8uMF3qyQDji6LSMSE0GTtJQS/NaoNvu0/qu35tWDOaH7bDDJt0Ndf71s1gkx9utkDjOKZcfEwEsfVT4+SiqtLVExF+74mI/w3sOAS4eI7s2ih8MqEeSLk/aICFgtiJOVjcTh11sPHGHtBSyC80t/pM7wwdR9JIjEDumZlY7v+suWv1gN1AojXcjLiplrgNio1Zo1GmzFew/4IyXxegW7OxnbWg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcDQCJQEpulJZmatV2IeMjvRd2MTwrG2y9qomyPmoHs=;
 b=liRjJ664habeX0TUX0Gm5XWCleXBI6ejay9CZe0wctJMa0gGptHg3BAzOwfwrDTaZ+MGECB9jM1Pe42RymmURTbromKJoUjg+q0c3gJdcZUzl41agOZSWUdxjPYVERPepFgiiDBjq3Mo+VzJhgXpGrdAUd0QNQ35pT1P+0LIgGlDqsO8a7/yaIhtsHkuleO08OMkBgZv77xGkcHihm6C7oruylQVePWPKJuykQVOgP2i1dTfXlWeHY+RMGu7PfVujh3oRoSoBtm2rf83wNLpMtVQ3M195nWtgbbVmcYiIwwuVGtDdkDWyxjn511p/+bcqnk6My9CN40jSKlyZvC7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3546.eurprd04.prod.outlook.com (2603:10a6:7:85::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 09:08:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 09:08:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v9 4/5] mptcp: print out reset infos of MP_RST
Date: Mon, 10 Jan 2022 17:08:21 +0800
Message-ID: <dc8edaf1ddf6b26d36f5f503b4e4bf7b0c5915e2.1641804767.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641804767.git.geliang.tang@suse.com>
References: <cover.1641804767.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0188.apcprd02.prod.outlook.com
 (2603:1096:201:21::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c42f6af-3a34-4b17-fe4d-08d9d418d5c9
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3546:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB354612944558DCE3530FF8EDF8509@HE1PR0402MB3546.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TAUOxlOTBeK2pZL/g7zj4kHudbR4Ndo6McHZ3bWEWhxL/JBHEZXoe9vF0wdiSMAWHlzANjKwQTpFWN3tIoHyxHVOFg0iqugJCyAKhqTi+0O1LW89VDT/UYR4B6VhfmHrbVTygVLbD/8ZTMmbge7Zsu7iCbqXpvy4BpdKIk+smuXp8hexIQcXAqHbGUwl1cXC1XPCivIFp6759Tn7qtO1Lo1Z3BsWqaqvA+rv2+I7oyZs9YzDL6BdSp6TeVZqyKwcu2wGG/XjCYkD2ISkofZQmOcTklwRNbaDf1ualDO1v6+7IR4nVHBw3yLL9IDg73v8TSzGgIwXK7A7aY1KqcKkvqGkSvMlZswK0rxcN5a99VJgXLxJ2pdPWhYuE+1rkdndErazk5rWftyoLt5ubY64ntQV+3NSX3UVbC84IdiPvqPvQIxgIU4sTyCgN81dAdjbcamcO/0sQPIB3JQB1wtXpHLpLy09fjJGhd8VZmQoZ0DCNS9lKdQt3ELXndCOxGY/z++uRStg8MFMu3q5lo8gvTMM2pJIvZWA72PmlOt59vWbBZiC/TPW+Sf28oQyrIe7N/+WaW7p/44WHZn+98SI9hQOYffMgYXj6eRjNFfrWCc2Xg4TU+htTP3h9ePTEVTHbAcO3McOyaD6Rv5eC7qIiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(26005)(55236004)(5660300002)(508600001)(186003)(54906003)(2906002)(6666004)(6916009)(36756003)(6506007)(316002)(6512007)(86362001)(6486002)(4326008)(44832011)(8936002)(4744005)(2616005)(66946007)(66556008)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HwS3OLGlwFxfnDrdQu3tMOmGVIi5Mq6WoyY+54+E1liPbUDYeQ3/JmyVILhV?=
 =?us-ascii?Q?nJTCDykwkBRedpq3xEubZTtI13yxWIXNm/zYnxLxjW9ja5NfvZAC7Ak2pDLE?=
 =?us-ascii?Q?y7Q+O9Xt/LaxXxcu+RwY8SzPEiIdqPwCyCQiMBAmTiHODfsvLdrV07anZPA5?=
 =?us-ascii?Q?VQf4O/aBP4NBysMl37IHf8Nha7RjzBaDPX3beNTldaYhoIg3ehJeBQOqeQaV?=
 =?us-ascii?Q?nZ66qrAq0pnGAys9arJXAAVKky7hCHzKQSh0NejJuceL0NIvzXZLlCOIAxBA?=
 =?us-ascii?Q?yj8mFcGv7JF3RgK0mxSuTps26JMfLKm5MBIhMwSetF1xuZHW4yusoLGATThA?=
 =?us-ascii?Q?pe7pHdUojOf1T/iqfPYQNeZ2CUQupni/IHpEjlOr7rHnI8xPHTK6EKFkOH2M?=
 =?us-ascii?Q?KInvxV8hfDIx4nO2gN8Vsw4qBL8jsM4J4Ljw/rMsIjiJ6xOLc0aQ2PBkl9pm?=
 =?us-ascii?Q?pxtVKtGchINa7NqyEIV0x7OBp1SC3ycubUeq6mItucbqaBuEmWxuSS51KwTE?=
 =?us-ascii?Q?WH6oI1AThSwSqlt602CX1hzeFh5LP6oC5C1FOMOPlMF9bIKxOWiFm2xtRjlI?=
 =?us-ascii?Q?W5wLEQLBdzg+mG3wyqBXtAb1y4oP6Ky823I3+Mkl72K7cCS0BieuM/OFANB7?=
 =?us-ascii?Q?OhjfvIpTVt60TFAqF30GT7Duv+sHUOEAcmUbw4W/m51aey62C9TF2wlhORin?=
 =?us-ascii?Q?CA+0ZVAohNs7clk79J+e4OzRvmAxebzdu9prCRo1D4L5qDVSKjz8B8ARWBZk?=
 =?us-ascii?Q?+7V+/69bGjalZwTByOgONq7luNM/kW7/Thk5+bImJ60/JhCRwUhOfAoWn9GO?=
 =?us-ascii?Q?9ABlxJs/fy4Xr0Og8AQ0Ej16JSdbVMhgsPaTvD0MymTNVFEmeo3ZJVryag9k?=
 =?us-ascii?Q?eICPV390L9ksSa+YswBD/Gc12AiNTVWW//nPaDtP5yTnd48Ut05z2JUlGv4z?=
 =?us-ascii?Q?ICsKVXwOltKBNwcbwxgHvhQfsBM7OvmynEeJY4o/YEdiChTP+DZfrBaLMF63?=
 =?us-ascii?Q?MvMK7kuD+P8BfykPpShEt/ajldDER7cuBxaqRXxMhFN7VcHw8fJUSv2Q1OpB?=
 =?us-ascii?Q?WYZ+hnqWaBf9E+slOZAfrfiYIV/6ZveL5l0pk5pm5+9YTjmwGnYvsMukze1Q?=
 =?us-ascii?Q?8WArodc53L5Mo1z//QB0QXgRgEo5GhqUClafvogAqVFwdVi9LAzZx0unsMhM?=
 =?us-ascii?Q?SMBQlRiKgtf3vkH75IvTp+MQWTeBsRXhazekrioVyeDhI1zWiEweuo4wEL5W?=
 =?us-ascii?Q?BCP94FiqtqNYfEyfTI7jb7a2Eeo3diDcODWmcA/06DItWzAQ/CESar/YyGvF?=
 =?us-ascii?Q?Qs7kQi0WafptBPWCHXQrCp88625ZJ2M/86Xx3LLmC70gh9m0/7lHo85dvfKj?=
 =?us-ascii?Q?LXZBS+EzWG7rsdX9ejF2CtT6LUays3yExeTpnkPda191z4+Pf0TVo/WvyyKM?=
 =?us-ascii?Q?f/zNV7L3s7t9mcyULXbcZYuyOwHGuqCZZ6aaes7l7O5iFChSFUeNh1Ol8RhT?=
 =?us-ascii?Q?WMTA+ElfH5ri1pNY/9TcPNyP575Lxm9IWIlhRupi7dxkMZlqljHcYpJZl1dY?=
 =?us-ascii?Q?Qq4fBuudlK4+iL3oK8Vyg/L5sAOoFSRTpsfiqGNAVuVVGPK361NSFvFpIUN1?=
 =?us-ascii?Q?XAWYEghnjg6V4svFM7DBw88=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c42f6af-3a34-4b17-fe4d-08d9d418d5c9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 09:08:58.4473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrRG2RVPyZ0rj1vS2ylFUVrwJB9LgtajhKoi/3WHGfCRhQuo1mOXS1Si10xH6WNHRK+51AeWAHFW2GjuQrzpew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3546

This patch printed out the reset infos, reset_transient and reset_reason,
of MP_RST in mptcp_parse_option() to show that MP_RST is received.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index bc2beeb6b5a0..0d0d2eb8c8ca 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -336,6 +336,8 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 		flags =3D *ptr++;
 		mp_opt->reset_transient =3D flags & MPTCP_RST_TRANSIENT;
 		mp_opt->reset_reason =3D *ptr;
+		pr_debug("MP_RST: transient=3D%u reason=3D%u",
+			 mp_opt->reset_transient, mp_opt->reset_reason);
 		break;
=20
 	case MPTCPOPT_MP_FAIL:
--=20
2.31.1

