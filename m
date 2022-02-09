Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8630329CA
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 08:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644397051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcCDJzHNV6kcFpm6QUQWBx6GY1KwXHjb2MCAhKpBMzI=;
	b=VLd5OhRpOF6TS0Tph6owziE5ofHhI+uGVI9sNU218PCOMmfvqSZG+1GGjlKcTMndzYU/48
	EuQcYoyMijIEzzLjHXmrsknI6sJF+x4J67053X7AetuDlv2EIiqUNpiUwFUp9MNcw4RLs+
	VUCtqRX9h7RxEChhg9ix+G7V/T3D2/o=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2056.outbound.protection.outlook.com [104.47.6.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-Q1gDuE9DNZuT-uEAGkapKg-1; Wed, 09 Feb 2022 09:57:31 +0100
X-MC-Unique: Q1gDuE9DNZuT-uEAGkapKg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIImtjPeLiCtxeTDBHnnAYC0ZshP+d/MuNuIuCXqmoFAKkGU9p8hEGh3OC6jqFMdngEZPUTXF/I5OtIP9YqGDS4s237+CXnifDLqI1MtEvHJCPZxghqgh05qV4yrvBeTP0akslI0ousFNrJR1P1G2uYED0Fz9ChWEOWxjNqzjmH8UMirPZJmLbR7hWZuYOnlUY70gatXylw4cHkxs3Fx5NbZHURTgopjj7bxDRA/kd2sO2vFe6Xpo429TbtscVHugy2uKHYQ1qZHWVXcg36cJ92BSunpPNyEjSt73Dkubs/o7Q42FhkPI+EZbHkL8v2Zbe+0umI6XN3qvTL5RuqUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a26/8dAG+o98EF8E3cZi1/wwV7DYzSfMYnFb5dQLUqc=;
 b=TF6hAD5GHofDpHqmi5x5N45RMMtsQY3TlegzYAXXycZcBxSfpBaSYGH8xZo4rGk3GFmTtS6uZI/bHoMb9qSYMi/kJJdUiy607y1OirEA7Vh0S2FhNmEJTxWBHHAXVlc5eyY0+Mjto5UH7lRmwQgvui48YCe267mtG56yujukWW911nHXhOCPmOX4qLV1I38cmoCZHMpW5ZWF1dCACmTWBYJMqh30+mabJ085z6sNaR8Knuh0eIRaLzJsCL4kEfA13ktGm6QeiTohMLEvwdvHNxcK1fzdgFswWdquj2gUtoIwzg6Li8DzNwgq5xCADfuy40Pp5wqcONOZXj3xA74klg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB2961.eurprd04.prod.outlook.com (2603:10a6:206:a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Wed, 9 Feb
 2022 08:57:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 08:57:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 1/5] Squash to "mptcp: infinite mapping receiving"
Date: Wed,  9 Feb 2022 16:57:37 +0800
Message-ID: <621a0237b6c15001e3590b27358dbb854c2ab6e8.1644396927.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644396927.git.geliang.tang@suse.com>
References: <cover.1644396927.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0173.apcprd02.prod.outlook.com
 (2603:1096:201:1f::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b7d02c0-9b0b-432b-e039-08d9ebaa3392
X-MS-TrafficTypeDiagnostic: AM5PR04MB2961:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB296140CCB6976555805E151BF82E9@AM5PR04MB2961.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gjfiRiqkVJHhEHuWTJRNa77rbjYHVPEYZ9ujAAc0nfIw6eNavV/znQnz1f8FZVCvJPNL5qb/39HOR4jjGgyKGO3WzlZV+pgcsNwS9g9xcGxdMO8g0yZ63trYG6bhcTkF/43A7eOohh+v2zW4OChq6n1KYsWYztxUXAH6Ya4pxUsgWtmYVgoHO6E0X/VxypFrOS1kfHoL9GQm9LvUf8km1UE5ijyuE7T2ofdZxvPfg/Q5IQZPQIDh+dmqhmbmGIU05ejIj8NV0XIDHb9rDGGljLuULhXNb0k2RuDRUQW4atGgxiI1LuJGWp78+wRmLB2EHf6gbef1CyQuLmJoAX9Ptn6giKdX7uREGRl46p/AHMHTivRMFQRFADKBCSxvTG/klqfZdxSjQS/XXA9AnQWtZunRRRMOLOgIM9vvqJElnCk7PESGadKWyx9wXHn8RvNCvXDKlsponC/FvGLv0jCdioVBHgpTeGMcdcBGXhBQJ/R10d0qMfnNONz53Hzos+Cp0Kh0KdBMjE/WVyDkrejp2OohJO7/mV+aoBP6UEJF8ObknCN4tNppdRtGRzh2KDEWdcuhjTqzYekrx3dpuKddTDx5p7eoRlZXItDLD/R0CZd/ySnQVIsNXo/bnlfORaePKnz3nWoKLPqjaRuAI2cscg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(8936002)(66476007)(4326008)(508600001)(38100700002)(55236004)(2906002)(66946007)(6486002)(8676002)(66556008)(6666004)(36756003)(186003)(26005)(107886003)(4744005)(2616005)(6916009)(44832011)(6512007)(5660300002)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FRX7k3qkDhgP5Pu5W7NG5ncqSf4U3Kevg+I+VIT+MYPA+IlUH1aHaCJ/9AMO?=
 =?us-ascii?Q?QOl67aXHUoPeQEzUByA0e9QTAbTWS9+BM5Cb7pMXusL7L7tt/2/jwXjO7jPk?=
 =?us-ascii?Q?y6Cr2+6jD6x2ApRLvdbMqyyl2Q54/Z+T2y2a7qYnIdOaq6MFhh/P1DLVSS+p?=
 =?us-ascii?Q?HRBgKhKG95stseVs93BrS5fQSNygQivNI+vf/+FgXuFZwVW1I91+ol3t2p5h?=
 =?us-ascii?Q?oONlYy8Hgiuc8aHO3fE9hnl39SYqKSmNW1iDHvaSR+ao9JDGB+bnSoxi3d3V?=
 =?us-ascii?Q?NlCU/LQJaCkrQylWXdkA2dmpqTdnKg1g6ewHPvkD5udVi82Iag0ffOEXcYCj?=
 =?us-ascii?Q?TmvCudZ+BwG43ptGishYtLJ4OTFbwX27Wjintv0/13OxQbHf3whzQ4DCeDy7?=
 =?us-ascii?Q?+++tzyteKDOoV/ObYczPqlllC1Kd9s+b4sX2ba0ftrw4Ozzi/rq0D2PfayeQ?=
 =?us-ascii?Q?sJcGdGX0DlaEDXhdO5FNwHIl/cOPB18iCPuzVxeI0ztHjmagYlV7uCoj+wGY?=
 =?us-ascii?Q?1Y6B7ho36TwAfuCJ0sbMYymgzvxH1CnYGfSwylimntKtCuaJXekzfO71v1Qv?=
 =?us-ascii?Q?z3Nr/0Itza3SKswqy68UtdptWwhxW3GmtbUe7O6DG72Zqn1ApDpgXXznab0+?=
 =?us-ascii?Q?TPm2lRBf3Dr/NZnauD/xhrr8GnbDKOXHHWFB3QXh2FTuQRzZMiYHtpXHLTr5?=
 =?us-ascii?Q?wLd732QtYsclDMst0j/6zdUI6Bh0jwFs1Qj+DjgPcErVMhKAxwQ5QWk/VgGg?=
 =?us-ascii?Q?/oNbyBL87OKnGWrcTvvQEmIqvO0dPAEGzO60TQ5OJOPRHhcjbVdHmAsueMLh?=
 =?us-ascii?Q?GMyacCh74Vnd/CHnUjA+x7ZhrV0OiJUGOeA28YuKu1mKv5SqmrAQ6oHczyRO?=
 =?us-ascii?Q?aS9lWIfWQe1VMxK6SVJSh55cVRGW2WDGvgl9mREAITznwnvoe9A3WQOBfsMp?=
 =?us-ascii?Q?uvcCB55MzWAjWEzojV0WpieYDYz0p3Eid+Dlv9nwmfzuKXBP6a4kfp5SrGi5?=
 =?us-ascii?Q?070Q3ZbEnjZmxf/WFE++IlcyZ424auCrUd2Wnb9tI83O74p+yYuuUQx0U8iC?=
 =?us-ascii?Q?MooCEPc6xMsSllIJF/KI5/2VVYVuSrnrhp9OvqmsluYDMgJ5EASccPwnnxo+?=
 =?us-ascii?Q?1/SrfAgBXRsGHHWvYXwl0lsnHVjSaE971Lmq+qxsFMDMBIVUNaSVppUhFZdi?=
 =?us-ascii?Q?sebn4AQP4xLoDVJKREpmllOB6XjwcgG0dSOMoT3jcMJJR+FTo1NVz1qPViyV?=
 =?us-ascii?Q?T2fJ5bArGON2VwwfMsVHjjUPyIKvqsRA09j0t1fPTy5TuUFS6Rj7yNMqfb8+?=
 =?us-ascii?Q?o9G5OlG11T1rQzqar+qiriT5aGVF3Z5/3DYAzkVzsi+h58D3ZvW7BldE/1TM?=
 =?us-ascii?Q?L8fndpwpDBMzKId/tEwHQYTbiDtTW9G7r/ThDF5ghi9uq8yT+y6IpdRSCzl/?=
 =?us-ascii?Q?/J+kCDxJBrD2bhmhi9cRT5fL3PenEBn3lWbUQ5uiS1yhtk8nhv0QkUbDhZjI?=
 =?us-ascii?Q?I4JETZ3asHfQ2VDmqhkkeKp20jOoptRr4MoPcE2ZBHQX0vWdi1rXRFkhiBJh?=
 =?us-ascii?Q?NwoQ4sAKcGI6EU4NWBS+1uVl3S6lGQS/2GD5aqh6lvl6XQPr3Q7x3nTwoQgB?=
 =?us-ascii?Q?rrLhyR2jMoPBLiAkGttuHos=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7d02c0-9b0b-432b-e039-08d9ebaa3392
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:57:29.2648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukDFzl3drPm9k1xA/qtaw55aUFngSPjUnSd2R3Eu/dDvVnx/8xC6GnAN4p1t1cXJLDQ8fpY5zSVa7Np/fHuy0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2961

Print out the infinite map received info.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 485f00dcaf84..ae4d855f3c2f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -962,6 +962,7 @@ static enum mapping_status get_mapping_status(struct so=
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

