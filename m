Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11C81388
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 11:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644924337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PCj2lgSMrIv5//Tw9M2zHPusfDOXdYGkewDaCYzKK4=;
	b=GWdNH/p4ePomEylNqfHi9SuSWAFswNiJX/KtTq3cE+hA+UizGuPEoISKA219VCN20ujRrE
	BFgp9dsKdifYus2amQtVH98j8he3yAwaTuNHqJP5KxnLYREwYCJd19vPpLXVMJiYIoWep6
	HnCSK7PVIjmUddChafq1ZCpkWrNX5zs=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3--SWPSZnfNjita3KCW1VH5Q-1; Tue, 15 Feb 2022 12:25:36 +0100
X-MC-Unique: -SWPSZnfNjita3KCW1VH5Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHT8RVKDQmU+W/Id9fXKWLbYXWDW7LoR8vNU/agwq8mcBD7z8jmuZLYIKu9jgK0uFnLtAWv5WVG6RgCHLJCQJ52VES1PyzSCFjilTVRDrDZIcs6G0O/4JtYZ+HcLSCOqm+lxSUcrNXTbKue5ooU0QPWm1/swngbAG84TQ/IJcf5P5CIk2r0uZzyH8lpjoHfphphjExWWI8kjr8lIb8ujjkssfCscjXGlQgz9pWbjsWaF2/jg1ZnBBlVmj9cDQgavvDAI2ooVTwcr/1XFNZrhM44rWazO4TUk/MDyEDwCtgjdeslyxZTyrB/BSlsr+Oz5dKNHEieUr/4hi3xjze51CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKGTpNwTAfeUHlg7o+sAl4ZIhpiR28BdA0P8AH/jBMg=;
 b=B/t4kFPtng9j4EAmrXZAr4JoESk45kR0T9ieh2w6yupdY+x7UOlJrpNn9TU25OaNoWgu56ETJSjcSb3+ziOKSdBkJ8ZghP06IPriXk2/H6CyLXXzY/pvRlHb+36kQwcHMqvYxWAVDq5SRh1uMWo9A2SsRCN5aBwG5Lgq0A9/sXnCBsyich9NkXBG3/M5CEmtygYl9zvIall5Or4pqR57TNTEBAHFB176BatadvuIVxu7SIev5zjQgVur6Tzypd8eLC9fTo7xOO+UdaR5FJUZNvqQr7oNeBAZqCT6l0/EpjyR9BCoLLGkzqLJnYO39Nnw2ouO2xizIJiFMJV+95jLmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4563.eurprd04.prod.outlook.com (2603:10a6:208:6b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 11:25:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 11:25:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 1/5] Squash to "mptcp: infinite mapping receiving"
Date: Tue, 15 Feb 2022 19:25:50 +0800
Message-ID: <ae0cada552137912e7f9ba34dc3232024146d48f.1644923833.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644923833.git.geliang.tang@suse.com>
References: <cover.1644923833.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0deea50-a01e-40dd-f0a3-08d9f075e1d1
X-MS-TrafficTypeDiagnostic: AM0PR04MB4563:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB45635A4E874CE726E04700B1F8349@AM0PR04MB4563.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zATPSL4kp02pvmST6+uI9NYSOYNNw87AL5FemQ7Kf59LSkgkK6sQvB7MweUumycyHJoiNgd2WhYIK+0nnRNSgCVXHz/1zhyuuk3aZkPg5JraMNF9cEHO+a5xi+SKw3tHJdMzCjkk4gKsiuC67t3UF3Y6up9+Isqr2ux6ITZtHtexIMB93Sq0oqamQ7/XBcL8q7dzO5lBEG3iKCfSJQphBCW3NQsFD21QxgeYxY35L8UIXNJBW1ttfItG6RzBaraoutXEqxdzuE6i3IIaNZJ+xzH78N5+4zINoUIXSae3Z8R1qIQPC3C6nYH7m02eZGobs8R4OYUGXcLAR4sRpSi0mclpZSdoBonhdV2MvXlZCboLBsIKEuut8c2E3W0gmsLEdpkbH7AMMxPI5OXHSrIA9MivNcAvGjJL8KvseZgs2gdYqgs2Ao56QLSnmpr/eEqBb9l9FFjJX1zWdX43j5quCdpik4qjWraBIkvCIBWksTeMwgfJwjZGAxUfCzrP4Wsy3tV4mnQgsX5XNG7rm3rf8yOZwRB2A8fooYSwx9NXbYaqm7RU4Zt31PwvA6aw+965t1AzwNsk0OMHdqeYwAqp2xK+bAIKfE5vzz41/qD8ychtn836JMFTHqXJ2fBi/ZS9MONuZGV7Vv8hpdKh5dJkww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(66476007)(66556008)(6512007)(86362001)(66946007)(107886003)(36756003)(8936002)(55236004)(508600001)(2616005)(5660300002)(4744005)(6486002)(6916009)(6506007)(316002)(26005)(186003)(2906002)(38100700002)(6666004)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5bePCimLwDhI/jQPK73BVw/WcezcMXLzMhQ4/iew2xU04SN/HpekgN14YhTK?=
 =?us-ascii?Q?OxXLtY0gffSHNv9sNmvGtUJ2Mu416z+p0nrvH+lMBbhUuLU7SqRvw1mfkV5v?=
 =?us-ascii?Q?ddy7Is2xv75Nfi8CLQySDBCrIE6kAzxzFpYCNTMII8UXZfQweBk+NYJO3xfT?=
 =?us-ascii?Q?nm3GXqaGy/HZ6NXc+zpLrSu8DcEb593XuBAAVH1j4DbYum5//AcCyQIDEJ7o?=
 =?us-ascii?Q?g3mwV3uvYchTz8gZ++OuWLckhkuVZZx7SMvA1XWRUrkAIGuZqPknJhQzIs3Q?=
 =?us-ascii?Q?P12XGNotwbnvuZL2GqD27FM+TeVE5Ecqf8a6mMMZ40IzfWbWU4/ijffbv0hq?=
 =?us-ascii?Q?kjlA2VwofyWZ4ISN3/xRrZMjobRvzXWC06Uy6BwYIZcaafLnM5m5I57Flf+a?=
 =?us-ascii?Q?qnS/rUbeflVDWCmQGzHNGR3J6RpbQcBPrjy5PTVwjuywAkR+//UI4cxtbp+4?=
 =?us-ascii?Q?b6BhzpYSBdl711CyGD6r8V+VW2p3SjQdKlrLjElZgGcEmpueMsaGInFJ3X3M?=
 =?us-ascii?Q?FnJRHhG6ybQ/MGDKRGJ/e44IBrgOreJFc8NUiUvOTsDoS3Kpod18f7HMVntc?=
 =?us-ascii?Q?Ja5BdpwcPoTkBLgnBa3ebMbqvRru8QvnjkagFwYKB4dsMNKysMuaWqAonTzn?=
 =?us-ascii?Q?ULbq/REVaHAgEmbtNI0FzUXXmobxEMRhuzlVBxLGL6qlfn0a31WmAoxuJNvr?=
 =?us-ascii?Q?UjzIsT0dvwOtdADPQoILlV03j7kzRDycaqKsdnHRVzc/GV+uegnbMXFc8oBp?=
 =?us-ascii?Q?oJAVZH6h0BucvUHridY+47GWxz1z+RjLOYOLMexCllGojEuIkersq8lIyQs/?=
 =?us-ascii?Q?n57BQMuNg2TEw9rHDX9YYKdMU37TKvoUbUiwwZu9SDylI5ghuOSzy88crXlW?=
 =?us-ascii?Q?9pOhqA/RhAIKEobz1X1wqtFTVkQM9ChKsERKQyali0njWZi0J17BD7JeyspA?=
 =?us-ascii?Q?xs/QSv2o2t6PfW8X/2e3k9R1iZJk6p1aI+SwtB8myEQy9DVA4MK6tqmSwqcm?=
 =?us-ascii?Q?YBjIaWmpFr575aS7vTcWYzasceIKM37MNAuxksrHBxBTWyeKmlRsUEbhyYsF?=
 =?us-ascii?Q?uyySRHzOhheNVBdy3yi9mQGnoppdXEDXIkI6kbBiRuiHWCMFBxJnxgtU5PFv?=
 =?us-ascii?Q?sZl3yfOPPL6oz7YyH6irurqUiLSW2NCOwCm1hNkWVAJRCj/sBN9ZfyHww1jT?=
 =?us-ascii?Q?HTQfyABE4X5XiR8+YZNpowiJi1OdHNmAvqlgI8lHUQJIYpm66hF6+NWh/asg?=
 =?us-ascii?Q?AtoKVDthsOs2szknel9QEMOTE1qbiI/x6kOxTxaLqXN5TmAGzrFMuZc55IDP?=
 =?us-ascii?Q?NSt5uvhT87Sxkl6m2iryZGr4omh86B1tPcC1RdOuIyISUa7UJ4X6TMMj5pQn?=
 =?us-ascii?Q?U/Eita9CIsr9TYdp0sEnQPYWuXn1wiLwqM2itHcGxKOkCwvyIyBlwf4vNI09?=
 =?us-ascii?Q?u2lg3TDfTBFhgZPSGHOuJvAJ2q7mMJDpIyXKgjFv5TCaACQzr32gACOhYX8G?=
 =?us-ascii?Q?hHeABIQDZZR/2pI1jgMQ0PKxFoEzn24hvoPJLvI02lkgDn7KxZ8gy7I2SJIw?=
 =?us-ascii?Q?KCuCoBgKD+xN5eOVOhXCmVmm9Y+dM9gz9AAdUZ3+hy4RM/rOMauIk0A8PMCS?=
 =?us-ascii?Q?rProi4ze5/JkmgV4Vda4QMg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0deea50-a01e-40dd-f0a3-08d9f075e1d1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:25:34.0732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJTQAOLH/IG/zTLl++aSTOJZ4LK3DZRQHoDkWBdO5P3nWwXNJ6ua7MfMQXuhwU1tN7Z+ejL8kHj07/AQW8Cs8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4563

Print out the infinite map received info.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e727d838da0e..8d086641bdc5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -961,6 +961,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
=20
 	data_len =3D mpext->data_len;
 	if (data_len =3D=3D 0) {
+		pr_debug("infinite mapping received");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		subflow->map_data_len =3D 0;
 		return MAPPING_INVALID;
--=20
2.34.1

