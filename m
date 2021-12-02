Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597D52C82
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 04:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638419180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQbZW4yu8YT1O240hY6dENgciYwBbI+/2fdcuDOAiDY=;
	b=cw0x0ssuA2ZNWfyNzPpDYZboPUe6JYKLUfYEaQF6QJuN3yrauSdZ6PVI33HsxRszlWHlJz
	GEbNNbdGA60FhSjX2qU4Y/42OzUWwXmt4eGvGr41L7XZzioLb02JAcSqGoybiUO9KG+U+O
	ZWYvlE4tDU08TnPgDGKQ3yrm/c1fUQI=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2053.outbound.protection.outlook.com [104.47.2.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-5U9NXfuVPCOYQpMJuyJ71A-1; Thu, 02 Dec 2021 05:26:20 +0100
X-MC-Unique: 5U9NXfuVPCOYQpMJuyJ71A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRBTxhfFrBDbOPcudc2IoWPr8wNvrYSDOSELqPDfh3XicpP4tt7L0AKSLAk1Cnv+xa1+JN75yV6JaVoYCu5s0uUdovPw+5MO/5KwFMy2XuVVkD/d3LjVg+AFqHjYaSxJ1lmXT94ZLqRE32ShfChQxhIpQv/fcGse0eM69Nvdl7U2sso6MwefWCRSZ9OEWXdVLP1LGyBYY3DRs0YGmz7xECJ6572A23v70Z4PoMD0kS3Ft+J9HYcuCMHyLkhXPoa2KjAPmZX/ooxR9QGRntAJVGUcc+qrKOue6mDIRzrOreF/sFlk0F9Pc3tRL5EkpBp1X2qa62qtSzmCtb/m/hGVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4aMfhCRD4nnua2Qg72E7t++mynKRFMrk208E1uJr14=;
 b=JELpvSX5O+aUxqlDacM1ac3vgolj88c2YvF/pNGPpyTuLabt9f5CaRfdzVfawxHNOGFZTGEFKF7dhE9VCxsxJ7pBoUMpdsDV6K1JYtJZWCLBzeYKHOR4VuFC0aFPEVm1n5r94nP0T4uqkX7OjKi4uSPES6GBxYAdBFeDlrWnSAaTfh5j1iWJFOpQaiKTtjltL/3cjSCSBFI+gy1pQmF0Nwf4gGJ/5nMYHMoNanpxh1qkI/ChRbXnWfGCLYrR7mKJobWQZ5BwYTXNYkJwIfX74useJYEQDFDjpaVouIG6b+k1zTANZUE2Tm1HTlinWXM9CeX1tyNMsKTgE8SRh7Aphw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3403.eurprd04.prod.outlook.com (2603:10a6:7:89::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 04:26:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%6]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 04:26:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 2/2] mptcp: print out reset infos of MP_RST
Date: Thu,  2 Dec 2021 12:25:49 +0800
Message-ID: <51f09b833bb4a7e04be5806a9810161d04905a66.1638418477.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1638418477.git.geliang.tang@suse.com>
References: <cover.1638418477.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0217.apcprd02.prod.outlook.com
 (2603:1096:201:20::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR02CA0217.apcprd02.prod.outlook.com (2603:1096:201:20::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Thu, 2 Dec 2021 04:26:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f3c83b7-b9ff-4b63-fed7-08d9b54be345
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3403:
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB34039D8892B4614A66AEEE56F8699@HE1PR0402MB3403.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cP45AjpPlVIHXJS+GflPkd0Yw1CL2DHRCDpfvTaCoyxRmhjmZvTa69rRBIs0xCZglRtGXhC3S0vdvBP9wMJ3Q83imWsXSUoqGtKqN24A2GTFxwyh+ro5ZylPqm820SSd9TsywC8emyb8yRMIB3Rlobi21vrevJkZtB/vdbGpYw+R/aVDBESZUtyZHv2t5NYqAfTR3fgvcY3D6epJ1POEYmmwuw8WrAqND820bXBDscuZhKaGVLiXMAv0XBFNQT7pocw80jzDzQLOeO5eP9/t5DRvZ4+EOjdil/bhBYRJhVqpFW9YYem0CGRKA8XRg2KAxRw3ov/vTucqCJCNJOrUhyUEUe456d3XhNJ0B8SaKcDWlIU/Zw2JlL8ltUDdoBdn9vggK1gQQCgdWul4lE4kgTdpOss57GvJ7i4WLLOzRTR9FP8B9kECQsMWyfCnDxCfpE5cfmngfdzH60V4fSd4wQXcRdKwrFkk384JPEva9S195lNaKXnBmENScsBqbvv5Wmz7MoLYcH/OgdJA57Bggd1ZVJ1x7QoHmb3UflIrxphVWTOkZqH84O7s0O/h60cyF+wd8WCBvj2u3UnbnloOH2+2wdQQbcxQhtCktKh2QSYY9U5voSh8v5HhfPofEcUMxSH+NcHl8AJa/SMeLHVNJw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(6496006)(6916009)(38100700002)(86362001)(26005)(8936002)(36756003)(8676002)(6666004)(4326008)(66556008)(55236004)(2906002)(186003)(6486002)(5660300002)(4744005)(107886003)(66946007)(44832011)(508600001)(66476007)(2616005)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aovhcU59c9li+zGA/GuyCjnnr5AR7BeadUj2gKrzT6Lo1LLtFRu6aJJ7LIoj?=
 =?us-ascii?Q?6DwzwvBmRNypbcEAamQTJPeAAWSq0bsrGVIGLeOk/yGeIaSxgncXa4yrvkTb?=
 =?us-ascii?Q?OAouDiNGt9wunV1FqSGyNOZj9Bv96jRePs126oOB3OknQ1U0y+AVPgWOjKEd?=
 =?us-ascii?Q?JAX5rUEACph7yD1mbF4YBcT9iq3pSWZiuluTfk9gPAsyJy+f8WPLPoQ8biKI?=
 =?us-ascii?Q?AmHiyZtYXEmEO6+cXV1VOedbgtM81p6i8BogbMHJiqNQSLgp5v39c4J7ZCXS?=
 =?us-ascii?Q?5NdBFfF2tjdaBXmVxBTym9r0ImMPHQoU7FSA806yeUtZ98VLkNluCyCEiGHp?=
 =?us-ascii?Q?4Gqm087KamHw9OxYP1GoGPQAhhduK/6fUcH2Zsyy3625jZy4v/9HSnDDWiMY?=
 =?us-ascii?Q?RMwvZNbXVJPzhFjFaC0r9ejaQ24tqU64H/Ygb9NebCcbe1X1xpJIhsOvhxQR?=
 =?us-ascii?Q?YkWvqwpB4wTDZc0WGcjk/AZgwqRXjDUFGyb36M87jQyq6Dne8cH7jwV1zwQH?=
 =?us-ascii?Q?Ct/7l6AAACODsitUoDMuIG9xvqkkuv40a9YSMce3qaXZ9nNAIbl4JxfqIXQB?=
 =?us-ascii?Q?N/vzGEhBy0uRkLJOBap0Y8OF3g0lqKpFYB/fYnptmPVEPplJjKZ+RMl7rT2E?=
 =?us-ascii?Q?MpE6cuMYPSqvv9TEwNYY9M/TkilkOf/Qc+9N/6ErZisE/+f29xYyT0A4URqH?=
 =?us-ascii?Q?zjr8dK2PWXiguh19t450fZOMUt9MMubGYhDiROYerHBHDXiUqCnhNz1wzRDC?=
 =?us-ascii?Q?ZGRR3mqTMAOoQIpT/nQToR+WyL0U8Mp5a6LeyQ1dHxdXZTFeKFjX1fQPtqqP?=
 =?us-ascii?Q?dJeZV6o/RYZuhqbk5mbzAFil09MPKKsgnChGMifPebqgr2HgFzvMZ1fV5a77?=
 =?us-ascii?Q?F593OJYD1KdusgYymdbGPO5/PZBNFJWADQt1Ngtr5KL6vqfte9/fnfhDOmmi?=
 =?us-ascii?Q?xG2M66oPZXGjnyPwZILL6iLMSG3cNxj7UYcoaacmrBPxFddqV45RPthsVRlV?=
 =?us-ascii?Q?lk0bA+WkgHr10AH+05H6EPgNfz62JTRwe/vDFhU7WfHyp17QxjavNSFITz8m?=
 =?us-ascii?Q?86HxWEWxs+HwJTKJdLnYqhtRz7jGTaD7TbJuoEMyiP4m67jsgNhDzjktb93w?=
 =?us-ascii?Q?VaB2m5sGt1QVGbhjHSjbcqdtVNiPA3dqaA9dPbhS2DMQc+aKfbLfqNUqiXgb?=
 =?us-ascii?Q?0ZPyVG/Q6Zf0br8LB+gusewQIRA3GDlEwVHnP4D3jZulDA/9bUXNch/vzmjI?=
 =?us-ascii?Q?NUQ3uvQqItcqF7m7T3iJJ94HZcHvItH0TdzETHkdmXWflRH7Rc3maS38ur3u?=
 =?us-ascii?Q?iJGHkFIe8uy4tldyZDsDbYT0G+euRfRRJbPl2O8DogwcIvtPhg8NFyHjv2U+?=
 =?us-ascii?Q?RU3ez8dK42IcT1Ql9fc7ux/UTguk9XCoXQp53bj88lZ4L0b3Ta6q8DspAfIk?=
 =?us-ascii?Q?H9yrjjNPoVKcgxTDlJASFCJ4IACWjHN9aVIBLeVci95cqrXvYiN0f0D3rAuc?=
 =?us-ascii?Q?7kDHlnDWihZ6CYaV2qF+8AzEe7cN7H5zs0dnMRFL7xQh7XckkDCU+eIZ5/yD?=
 =?us-ascii?Q?U9930FR+0lTwWw5lyX26bG3e6rgoabuvjnz7VdyfVC3yKthSU+9UQejLoFPp?=
 =?us-ascii?Q?Pa32a5IBKYk8tRYraDAGTck=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3c83b7-b9ff-4b63-fed7-08d9b54be345
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 04:26:19.0605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lw0DTwiMqudyCDllaPLfyBGXUJELb6RjGAM6ts0/ZqSNBFTZhuLl9uzJOBBj8hbqzlT23ScKHPV+kyE8jxCE3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3403

This patch printed out the reset infos, reset_transient and reset_reason,
of MP_RST in mptcp_parse_option() to show that MP_RST is received.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 078187456467..efb828a4edaa 100644
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

