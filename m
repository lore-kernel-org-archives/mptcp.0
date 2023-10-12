Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D71D53E
	for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="w0liKCWY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfLuFZtGDZaD91cIj3kZfQ2g8TRQpR/6GPMOyv/TYOsc+5zTVxUxKf8GrelWq861W3nhymDXgukT6v3RQz0XE7mAfSQ2ZtCv+M1T6mA/vEm+BiRzwcxU7VV6scWvmzkcU1aj9KNCsm3RLL8iE7xhk9OdlKlsPeUUeeBySpU4hqGhPZHkclEZCKNca8TFepj39F9rh45xPDV/EQ3/iBOw2d/Pe8C50u86nRTGPazOM3ZOR3PWfkgDt2OSImuYF/9HtELJZ4wQxz+waF8rMYG4pqi/IGCR6b5tamme51tiYSJ+duNnqND1h7Sp2g8Tuoe3sXfc/QVgZl5t8EM5hvod8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITrTqUSiTFPQLH+n/E4UD7SU+WUhgfcHxzNk2VWjDqk=;
 b=CpWPlZGynkKl85Z4e/0oApL6KbRKfRrrVT3D9vZeucRT8MKa2eBYbWHifXmNn2Xyk94xRcxIR4ft5Qbe3C4kva8W0MSkH3sW1DcG8QRb/k4CUMlPaLJW/cpUDGxgQprRnTpBFd0gZ+ENrLNXwO2LW1EuA4BJ/sisZ7sFkVGPCnIf4T2SYEtf+q1GI0VBkyI1ga730VC88wI5I+8UxiltZqZQcWujVKW3A/afhzha1EurOEjNcbycTmsD4NmqueBUZs5Yjrx5DovwsX8AWk3UMFyscE6NbD6wej9rp0+92qWakgOI3QASvDq6+ZlO+t48eco1d1cr1xIoV4FAipkvfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITrTqUSiTFPQLH+n/E4UD7SU+WUhgfcHxzNk2VWjDqk=;
 b=w0liKCWYl9eVhjr8j02iABIfIiN8q1nIUBXSBWdKXtc68oTWYC44LLf8NTQy0T9wMnegOcIBRVNBsTT54RIg3gp7DZlNAbYay5qI40Q0LiVhvATxbLO0ez4yYkr/WAglc1jIVpB8WkN3ZfZbFo0ksNTBbhf1teA1XDa8etci3cyNfS7/bjWPvx/tiPT4DIMe5xQUsPC3bmsksedMLFnrRc/XgBRD+UnQfzMX7tb85bHl0UQE178VPlPeGzGxfry1aAGATKeNUbO2NBm4kXGV+IYqPb6Ag98iVrf64xFgu9X17NWdDbazQppor7AUOX/8NxyB7+vSPZY//VdkldvZOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7923.eurprd04.prod.outlook.com (2603:10a6:20b:24b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 08:52:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 08:52:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v15 6/7] mptcp: userspace pm rename remove_err to out
Date: Thu, 12 Oct 2023 16:52:04 +0800
Message-Id: <2090fa3ed8f7ed178c20826c8a4321526bbf33b7.1697100600.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697100600.git.geliang.tang@suse.com>
References: <cover.1697100600.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0053.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de00253-5037-4cc4-3916-08dbcb00802c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W4QaCy/ApWhIL2c3XLTG+quRgwGIS3BiiD7tkCCUhrYEN8UaGSVEofx9uvhWxsoKYBbPDMl2ks57v6E1UmpDHLzoH+/Vi9MS+T3OksLWWVBUyXUFEy8LoojwX4NGjxHcQwGaGNVmY4XBwR8SmMm3J6jl18NO0tuGYtKKwFay8n2dT3Oxwgfkbq5M+T8mpZtz+D1wGSpP1QBSohW77A1ubFFzmF1i2ADTeXBdzOvuqr9XAHSspzFKOzNUlG+gIzGmGKT/8DxCvYEYBTH+v4DjGkj2v7foW2NqN4snoq4JtCahGO9KV98BjoRkewTfIKZ4RQZgrlh5XvDd1c02QcwDGJXM00AJ3a+4LeBO51u48i5LSk80p6sPIpImstWwIOC0zE8al+d6AJAvesoR3H1d1U14lT+Sa5M0+FByGaQIrj4sJmVdBsKohXs17iLTAkMdcuIIxkn8gHrt9DYFJRon2epi2YQ6LVjFfmUxXLZCub6Ic+dKUIMRS15PoFuff6gn/VRiX1nOLbMNkNnyEuNtuxyxXYiOQaPkGHyaLigNqWVUnePiOvF/OSeKkOnahWVs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(6512007)(2616005)(478600001)(6486002)(44832011)(5660300002)(8936002)(8676002)(4326008)(86362001)(2906002)(6916009)(316002)(54906003)(66476007)(36756003)(41300700001)(66556008)(66946007)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jckSbWfYckDNyCJIHLfIb85ffR9UiPhubEtn7l0JHEjRQnVac8o/UYbpoRGP?=
 =?us-ascii?Q?TCIjx4/ioC2hsmLWFoXbkTQ8yUAnMakP9joz4PImdBp9dLH5K+tLh6cz9DjS?=
 =?us-ascii?Q?4/y6L4jZVA3qQKEGnJi5zcG/biXrU1NywTovz2hsk5p1Tf7egZA78wLgi+ci?=
 =?us-ascii?Q?O3VMxCHZim/shFAc80Q/MTjPdRv+cvL/ULR5nWL8h4OrP+QJOpLKASNtqseI?=
 =?us-ascii?Q?p5eXsx++QE1uOadXJM/zjskH+9MxWAAjL3qP9/MXS19MKoqs2xv4jQ7GlOMe?=
 =?us-ascii?Q?iXltaGq9yFyH/tsIvGZiCPLFWjlw8dY+uBUNOSYXA/wYP7m3n7LES/GZRYSO?=
 =?us-ascii?Q?qqNVn+4kY7UZWtRghFy0XJetZyyNHsNqUGx+FTuuBv7HDsuQCP1YGOW3Y8gr?=
 =?us-ascii?Q?/FKARaB6+p15jJPnozHwSTUb96GpvqIZa3WIXGsWmB5/ph2E+k+TQMHpd+IO?=
 =?us-ascii?Q?0JjA2otNg1CieHDOaBeJE9ZabwiurWmUK0HCcxDZPb0avmeNZcVoXnfewLKB?=
 =?us-ascii?Q?xrA+7R+4tZ9EnuA+Gib+FESsDlERiksUifTepGTAhkL67BE2UeXMXY7koI0s?=
 =?us-ascii?Q?zNfdqPqu96PZVw0U4EaV5KmZaiv7NCRdve2WAf+I/ei6ueqYF0b6+7aTvJwH?=
 =?us-ascii?Q?0siUpmIlriEUAZLjqZkgv0Z/vUz2XHssq6LGqYIQTcDtwG5mWJJRx6FHcE05?=
 =?us-ascii?Q?QZdilVQEr5q0fBBrtDnm0misI8+jskBOwzubIFvJ9LeerdRXGZdb1fR3s1Yk?=
 =?us-ascii?Q?O7BK+cxEKs3yqfRZ2fNt14wnnoSkdx15P2vk8JbWr54aFskYVWalGO6IIQUF?=
 =?us-ascii?Q?0/1iIHIdU/bqcJuw3G8PMb6JsxNNqQG1EdFEYs+qbTdNsQZxDIfrnun6hgvD?=
 =?us-ascii?Q?Z13tn+Y10IhNGmEUe8lugW52cRIESMIncMFAh0QDLDIDoQK2XnbSx+sHzcRk?=
 =?us-ascii?Q?4EGYyYLzIKGcBTg665oU48JgLPoPoi5fZTsjTCeqIKRmuZCm3BozpGo8LCoe?=
 =?us-ascii?Q?iypA2oRq1Az6zsdFHhKRcZDFQihTfdw0MXDEZ5+OrQktCHDRfGTkN1c2CbBd?=
 =?us-ascii?Q?zECBvT5HPI44fy3jDrhHr7OV4sDWBYppPzlGKUu+N5mfD2rpdHvgMoYexkeW?=
 =?us-ascii?Q?Ih3jNKMsjDGKqrUrOccX7lRe4zFEtbaQDLtKZSQGpRINBi3zUAsLHtaoO/hG?=
 =?us-ascii?Q?7qRj2AlRJpFTTzFG8FcFr7nPVsvbYuKy8KjvAyfeqDKhdORaa/mkx1uQpOV/?=
 =?us-ascii?Q?paDHY0Lo08tDmd5KmePuVwY/qF1ZfWBqknwrk3f3vIdIOz/axCvlEMXsTo03?=
 =?us-ascii?Q?LXNarhvLWH28rXxrkZrI/r3TOwiCdpUC0tH6WELxY+3BygmQpLqSpx6GvNce?=
 =?us-ascii?Q?eWJGi18lvSqaS9Po/JU89AoUjpAenDxx5IiEhqMA9M3juUcXvgqkVab+GLEZ?=
 =?us-ascii?Q?1xMTVCD1T/9LNmh+8WirX24FR4a8+XfpDngaST9hKep9tpmPLM7spg8N7cAb?=
 =?us-ascii?Q?xBM8fBwmMbvosgIJ4up7VegVhpvbGQ/ppHRc7EA7Q4F+XacQY/Ei9QRGkhjk?=
 =?us-ascii?Q?3ftPZ4wlB9R5WSXsXXEuUd3Pcv0qJddTEpVtyfF3SHUzGU8q3+2C1yMc9lI6?=
 =?us-ascii?Q?2m2qTNMzhxte+Be+23+YYPz5fGEzdlwuSeIgEJ/s0VnB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de00253-5037-4cc4-3916-08dbcb00802c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 08:52:01.5433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8RRUmZYvKBqd0sh2l1OnxALfmgg+vxvlS6B9lTu+Zl0dIZd1ZScskOKHxoPYkT5wwdcrt0XMVzdInR2t7Qqsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7923

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

