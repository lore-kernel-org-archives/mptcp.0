Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C8173
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 08:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641890272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S1olWjPQEckahzTnPymhF/X4ceWVtIQ3FuXtErk6GCM=;
	b=MhFRd1+lkaxfdPtOT7wASdrpvpOLxL5TkDzArf6LOA28d4i5Pe5kNEkLPHzPUFAWfSqXZO
	T/VDTwAHLavHrVWgLoH+o2ii9n1KpOL7Y6GBoLyW7djX4NbfliJYlbG09+XPX+Q1WB+H1P
	PPFB+ILM/hoH03bPY2qdpvZ7ftzbHW0=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2058.outbound.protection.outlook.com [104.47.5.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-7yf0_fWRPEqkj4e-q5i21Q-1; Tue, 11 Jan 2022 09:37:51 +0100
X-MC-Unique: 7yf0_fWRPEqkj4e-q5i21Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxVbjQfH+lBgAm75Fw9wBhbcV5OZjyesGYZcUZRVH9cRdxMDRZmR3Wot7BzuYLeDWc2mx1JEkIIq7LzJWoSpjcFcfj6ZRk59R5tltDmrUIjrnECOkCo++km3V94ZD/WzIB8/XAlJEndOkP+KhEqu6rD02eQkJVzX32kqatp71cteykptw/QemIUJdi/GLCJwzIlgLA+vD/bL+brogTi2eGc1ZmaObvNwpWpXINfLgYnSIUzbRAqEjFatcLhctHmsDzviELnjr00P1OX5ZMXIsGiA9Z5MqbDWmLW9PqBCXEqxQE6+5Un0gFG9W6UqU6F33Zb9ByCBc4gpayk3AdrK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+5rpnimUWUoi0y77qzI/iKOHjn4/GiLKJRM+Yl21L4=;
 b=P3MLLMaomdbWPv6sK94EhzguypTLYWjsarV9NZTgStIFtpBp4SwUNEiAA3eLCfKKYZP9/GuTiabWJyVhY9fIf7jLjhKpuisaTW+gjnf/lU7YxhyfMcOwGGNtfc5wTGqbyo5i1El6WOBEbN9Wm+OzzWOa8Kkv6bxh2zRodFd1lnpdm1Kv+Fcl6nVqrNnoUeM8LBQd1Z6rhmAiWg8m9b1fpfwzarGxm1sdi4BrTYKC3U8ruBEBmjFE4eYMOTSimttrssO3XwiUteRyK2IrEgP7fKLcw6aKFix3iUBcee+iSVv0kAZBI1J8UjoBg97oNYGCLr4i+gOFIeJgstSxoaS5NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3275.eurprd04.prod.outlook.com (2603:10a6:7:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 08:37:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 08:37:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/2] Squash to "mptcp: set fullmesh flag in pm_netlink"
Date: Tue, 11 Jan 2022 16:37:33 +0800
Message-ID: <31324a202c23ac880d391f2d38f7c59b3f348ee1.1641890078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:202:2e::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8eda8211-6a9f-427f-7479-08d9d4dda576
X-MS-TrafficTypeDiagnostic: HE1PR04MB3275:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB3275DE970BE32AB18AB45AB8F8519@HE1PR04MB3275.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tE93QCgER47KJ9XYScg07RnPmY7YPOT+og/BIU1yl0aHHJKQmZCVyVHXB3Fj7FRf5E96Uc3zyRXzlxQw/rzdAB0PcUO7vJU/bhD5ot6rzMbYCcMFGGeP7Rqux7hQlAE7dsjkOk8e+8MOd7A4gDsnHlV+ceaXYkHRNF9P1TvVbHPShrPdCFsFeJop6rrd0PMJl4b+uHKLFYtg2U+DCy6ijYJ3IZnettZS63xA9qYyrHo+iMmWZFXcZvps0Fw+jQem9YAW5gZY8UzF8TvXNhbDR4e9GwaiKQ7TnBUMyLEuPcx1FaOjCAPlBYND6LUpcsmiWwiuOAYfTp8dbNF3FVLx/0fMm1U94612gGwY6aBloKa00j9k/DVtONJ4ho59N6JycDZ40YwC3P5XYo4jUC5/75pzeXjjx/QllWNKCRw8EaR9SdogVHkwGBJw4D1BYuheX+CM6jrNvMOZKoZotyvd/NIuQxUGhYZntuZkvLw/Dl6jMPisJKKHnYsYvpc5GFm69hv/pGjNStc6dWanJBlXzRR+fEMlFTxv6RWqONYRz6OSHOwB2V+Kn1+MeMe7ZAYIC8VDUYTQIP/uDspfWZAzgujg72t4mqq8BIC61BTWf8jpNniGJik7Rt4askcfV8uuOObU4iMZRPZxSMqA+GN5gw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(36756003)(26005)(2616005)(6512007)(55236004)(86362001)(66556008)(66476007)(5660300002)(4326008)(6486002)(6506007)(107886003)(6916009)(8936002)(44832011)(66946007)(186003)(6666004)(316002)(508600001)(4744005)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EqUCgPWyexcWcIolJTJx4RlF/BSJmOSPQbo2ZXsw8fi65LnFhQF8xif7jZX/?=
 =?us-ascii?Q?Yy7ERxHp1FKXEwq4pRTYoucMD0wX7OnNVBRefpXyUBFb1FnHu9NV5hnjpXfF?=
 =?us-ascii?Q?1MUmUui4tRy3rm2oIQAqNohZxFM863OW1CVf8Ed0zWWUsEr45mPgD0yvHq8G?=
 =?us-ascii?Q?9GefUgi2JSd8AIjr5ryVC7Vs2m0uCK5xsYG0gHFbwIYcqJjY1WgRX5ccASb6?=
 =?us-ascii?Q?ZIXy0mp2jwODG67aXRTzNX3m15R+phRNpZClZzdp0lmrJSnIHOSegOge8MIG?=
 =?us-ascii?Q?PjB5ZFYigzReZyF9Dvc2/hbgvomvHVwruSifW5Nl6+/bCzkLm6Ja3PccdExm?=
 =?us-ascii?Q?UwuYMa4lJh/e5GACizGPt7idUxEKXY1jE8b/z8hcrNwTSJH911yNhQdK/QfP?=
 =?us-ascii?Q?BvSg6AZ05ENOfcSeyYZQiSTHouWuS7MccaCpveFmSr9ZOYreRVPYHDz+OCEG?=
 =?us-ascii?Q?4IuMrEbw5Hq5YukpfeMG8DZETcz9QF7D3xCoZ7lntPZQeQ1S2vnbj4Bq3VBb?=
 =?us-ascii?Q?6pbMZIuItAF9/vZ5Tp+36Kss5JWUpHAY3ZMKAluf8EnLc2rjb+r3Y/l4UgOB?=
 =?us-ascii?Q?vDRBMaPjdvGeEiMMKX1ty5PwGQL16vzS56wTRdw3BgmMdH+v4Cb6ZYKfGj3n?=
 =?us-ascii?Q?L9CpK4fLbUmiCYf4dihtKcJNqI+713Wr04mH37RlSEb75Ymb5Pm/FZGh5Thi?=
 =?us-ascii?Q?Jg/l4RPBE/wcpVoqE5J+S8ANts/2OJWqNA3eM8M1mvgLSnQx5YJ3wz2nODUv?=
 =?us-ascii?Q?aqkPTRWYF3k+1plFnS+4gTkUDVzidxboP/WOJId6OHDEoQ8luZdsjAiKkQhb?=
 =?us-ascii?Q?t6myGyZUjDnJTQ+0wlQTm+q+SX0oq6/YwcxIybEAbTjJ0dVY3FEGFX4r82K/?=
 =?us-ascii?Q?AEMnxedgJlaffZuSWZ+cJe7lOqHmbW8tJho9wOIC+7vUSvdrfSN8fo0U+oAH?=
 =?us-ascii?Q?1Oc39iwE+L7GTyJY4ddcPqO/C2l4lYgd5RV/I6s7sblfA4526EWQIo2ZxLwy?=
 =?us-ascii?Q?ChpKY5FFgxgENBxCm8s9XDaj3nIrrQv3PjJaJd9jST84PHtY70A1OUhk6iwn?=
 =?us-ascii?Q?/MdyrdKb1jxCaWHrGDzBtgVTtGHSy4knY3v+SuMVvqSPUCpMKCu5t1VPdEbw?=
 =?us-ascii?Q?cwZ1O/fgn7ykAm6+qkdOwqCJPxKgvUuk5z40QK1yCnSCV3JC7qltAEfP5mxr?=
 =?us-ascii?Q?LF1l/gpOc+P2SDHZAZ2iVQmujheCHysTWXyUKcjL92SF9KsqeaOswYXDqO+m?=
 =?us-ascii?Q?HSIASxVK/K8TAbe9koTYcCSDQCeg2Y79ovmm7SLb77qj+H4L+TGhEXtn/ipg?=
 =?us-ascii?Q?JxAIHwfX/hrFEADE4Pwu9ZxFYqi3mrRuErWWLh8UKn4ILhthNNsFdeMrjKZ+?=
 =?us-ascii?Q?nxg7fVUbyBWgk6UhcuMS50XOG8G/EInTGKPIclAxR3G7ALdMk+ecSaSi4o2o?=
 =?us-ascii?Q?qleW/d6hFeuoNHRMfpFa2VurwaHOqRgbOKYZ4H3pyplNfTOQvbC1xg6V9uUd?=
 =?us-ascii?Q?ujbNpEp9NoEilvTLoz6wCHLdXf+cmM2o3Fmu2YOLiTIl67fhmOzlyIaUF680?=
 =?us-ascii?Q?3czV4gFdPRZVJikmN0FtLTjk6Wnfp/RwarLzLy2iHSRwfJpqW9nVDq2QMybZ?=
 =?us-ascii?Q?G3m4Qduci4x1+uYi6EDFW/A=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eda8211-6a9f-427f-7479-08d9d4dda576
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 08:37:48.1468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 910hfGxOrIBlcThbdF8Ql9hkArUkuxEBJmlg0XlUXkZCvzSsngDI+3jWKHrFDv0nNB9yJ70Pm7wq1J9A17494A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3275

Add the fullmesh flag check for set_flags.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1cdaa774cafc..b4d7ba265529 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1765,6 +1765,9 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb=
, struct genl_info *info)
 		if ((!lookup_by_id && addresses_equal(&entry->addr, &addr.addr, true)) |=
|
 		    (lookup_by_id && entry->addr.id =3D=3D addr.addr.id)) {
 			if (fullmesh) {
+				if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
+					return -EINVAL;
+
 				mptcp_nl_remove_subflow_and_signal_addr(net, &entry->addr);
 				if (addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH)
 					entry->flags |=3D MPTCP_PM_ADDR_FLAG_FULLMESH;
--=20
2.31.1

