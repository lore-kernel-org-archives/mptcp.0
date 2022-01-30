Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1494D29CA
	for <mptcp@lists.linux.dev>; Sun, 30 Jan 2022 04:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643517190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCnJ8Ln/qjt22pokNQYw1ro3DmdOKVjILjb8SMWG4KE=;
	b=CQFkyYa9OMqTAmoItn+VsXAafDvAcGVRQJXWMC8QFCuJ6efngjVZsaTKOkGcjOp602r1c9
	HnSP7aNLxJqchSbgBNdxu+93/emN21vVaT9qAyeqJpnUSIWA1jsvHs2pbJjr+CDLn0MVJe
	6guHmNKPYgRKA9BDlv8bdl8Qvt5LG9k=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2058.outbound.protection.outlook.com [104.47.13.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11--vIjB0ZYPxOfIzWJFxtA8g-1; Sun, 30 Jan 2022 05:33:08 +0100
X-MC-Unique: -vIjB0ZYPxOfIzWJFxtA8g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLURLsA8U3UNN93+RawS5A9eQZvUXC7IAeweP1Cqusw/P2vxaiRwCQ9wspRgQqdaR3B/jcoGjuajR4rBAv/ggUIIv/3yNqaLdswIam3xaA7MQZIl++Rf7fEG6Po024FTbxb9b5BA4+eNf7ZZtffMtdGZGT4BIL4FH3dfd+aYkIgeWjCXU2Wa3uI36yxbiL8C0cRQeEYtgAbxRajgWk+yHHh6Y+OJx8MTUxTG+jAz/IRbxjQrU+iPddY9kJnc4zvAP71EuQ9/TwPeb6zOWdddWKffy0Y97EOLqSW3x/hVAKVg31qil4B38e17qg7cn6TDB/+beUfu6LLGyDytp8eU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCnJ8Ln/qjt22pokNQYw1ro3DmdOKVjILjb8SMWG4KE=;
 b=F+SD/KG1Xk+xSUfXc2SfSIT5rYcLpMaytNeHwzW5aFB9TWuJh1PrEQGcj9GQo5i0zCgHomuz/vyyniMKBpKhhwnPJt5HFkoklyLsuG82kBWANPb9m6DU0VKEGRCdxxIddjMon6Du5WmVQ7/NUYUfja5d2/Syg7KNNLLnSJSQ6sg2Irpq/RZqmjwjHG/hm/KeSLNXB+86NKaaEEMyq+NakLwi7TYMpw3guNMjSfZJUu713cgBXCcTjfxKadHaWnZWhewkQiF+cduXxrnmUZayqLV5+nUVPHl8FS2xViO4G0qNSU0QBFP7Hh4qWhuDt7ulJo1xRvnlyVPJLi3+zLW9WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5876.eurprd04.prod.outlook.com (2603:10a6:208:130::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Sun, 30 Jan
 2022 04:33:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4930.020; Sun, 30 Jan 2022
 04:33:06 +0000
Date: Sun, 30 Jan 2022 12:33:18 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: use nla_parse_nested
Message-ID: <20220130043318.GA7781@dhcp-10-157-36-190>
References: <022caed0c9e5964f525336aced8233338c29386f.1643437533.git.geliang.tang@suse.com>
 <25250bc9-015e-df2a-582d-5b5dd3eabdcb@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25250bc9-015e-df2a-582d-5b5dd3eabdcb@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0219.apcprd02.prod.outlook.com
 (2603:1096:201:20::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77304cfe-baac-460e-ce2e-08d9e3a99c56
X-MS-TrafficTypeDiagnostic: AM0PR04MB5876:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5876806678DB361E22F4DE99F8249@AM0PR04MB5876.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Sgyb6den+WZl5Dn5tTULpAOhrIkddV2h9UHtWJKz9BH9tcz5w4LwVCQZs6XgFfOZlw3+swsLHxQQpuY7xiy9WvZ4JJW+08WJB1XItW2cfClIG9F3cAtR/t9VM6mYQRLxgYq+Q8SA/Z/0s1ACnA2LiGLj4wzc3oqI7HkL3qhR793/oMtzDVatLDcfvpONDLEfBfFNglrbPv+QxJKcaeXS8udU548PILtKZLcA6280mkmMgDfFl7NOwykksJMjzt+FN1hbTeb0F6p19l5+x3Qjx4qzCk1jKngqfcZFr7wqjC9xDM1IPosIXBxvGiJgX4WvSfuRW0WYs7M9cCheNmQpFogl+9xz9FOHW4LSiv9umojw+ga1YNUGqpN+52Jza+YWn+jdYg8PioDqgxFYSS+s/BHtYaYqAHRwBfUb9Op7sHOifYCKtRg900A3aRz9fN63dRRq3g3roa96UsmDpk4Y9a8HmanPav2iRWR6zIp7tDgnRVUfHOvGoXgWeSiZiSoWLFU2uyhG0S0LngH2FZ/RxEBhYkK6KnjGCLqXy8GY10zGlRWa+MawBPRSXe5gmCYj5DjTUAuSbTepa/RUPnaVHGiNYoIaa5q9ZPxO7QuDclINsTWUYuPxgP/K2F+L5DuRnpvidT01nH5MrMhxCy5r0TVEyTKgdZRc5eOVyR9SKHF/DuJEyLcEEyNmM8Xgp0JwoNZl+JIkDsa3wHRmZCVZnsIiD/Y/r+kYqO211EUExeI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8676002)(53546011)(6666004)(66556008)(44832011)(66946007)(8936002)(66476007)(86362001)(4326008)(9686003)(2906002)(6506007)(38100700002)(33716001)(6512007)(5660300002)(15974865002)(33656002)(55236004)(83380400001)(6486002)(1076003)(26005)(316002)(186003)(508600001)(6916009)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sziqe328w1CkqT6U+pcu2lyo3E4WxF4ck7OSGVAZ9T5aSY4myTzIfRwoVrqC?=
 =?us-ascii?Q?owKesvfTAGRKtgHd1nJPyGyuXyRgX/pWL1RiT0FWMyLNZ2yvteRs7nVP+MQB?=
 =?us-ascii?Q?MA676msGtPyJkexRAUjVOGSSEgZN2MMf+2JnUPLROn8GaH0cFaMQ9Gx6e1+I?=
 =?us-ascii?Q?sTJwpywCezDrXMSySq4r8BiOKpsOV5Qv0Cl6cp2V+n+Sgy5TW+s09ozGTkk4?=
 =?us-ascii?Q?p6/pGuPV9zV6BLPl2FQsnn5oIJAd4hXUF/h7ZR1i0+56R7t62ZcYCdQgO2rC?=
 =?us-ascii?Q?poyGQy8394n8TgsPp70GQSg7erIfYmVPNiGqYuB6EEocbQZEzap1Het2IYn+?=
 =?us-ascii?Q?9AoXfaQJP+lbS6he/LJUMJtT/KfXkmmdAXCLSDOEtWB0cocoeIJ3QDnBJf7y?=
 =?us-ascii?Q?H5XiAHVDjOHKt3L+0+ZqmLG1u/MEo/wEXMxeJSBF2F5FLpnSe5/txN8/OIUa?=
 =?us-ascii?Q?Ay41BGjr78HkNROUAvzkwjEYlkONscuXkz7L3JnJSjkdgj93m+lQkvsTca7P?=
 =?us-ascii?Q?XjxLaZtZNLxsLST1QeYMZlAlIpfoM1S/+kYETTEcVXq8w9ghKGTApJkRWfnJ?=
 =?us-ascii?Q?foards7gtrmC17VNdJyW0xm0w75ZwM42HRXoTUxiH8BIhGBLTq+kdJFsqX+l?=
 =?us-ascii?Q?jtzkHGIySy95OLtJ+oEmePDCp7BS1wDybTBTico7412wV3gEBc7Sp1D7fwAF?=
 =?us-ascii?Q?axM8nv5KoltRFVIHkXKzLzSLOIa0Eajjl9MI4tx/FbJAfv1NSImolEYunG0I?=
 =?us-ascii?Q?H8mttdk/68B+ZJ4psXkRoyEPC5iWmpc/pjtSQQAWq2MlXV6GHWnWl4+IlljL?=
 =?us-ascii?Q?J1GsfG3rFcCwqhJRq3vD9GDWItjLiPj3hYNT38TsUnwQUmgPxz0QeflcainR?=
 =?us-ascii?Q?uJA/S3heQThkuOQdLhySUZYysPLthNBhyuB17Yde/EjINtLp1cOdkbY0tRmI?=
 =?us-ascii?Q?iirv5nfb3ucr9+rCu8WuDukbhPERTYMQ+652ktDTxVGyspOilA0Vut/ikeqs?=
 =?us-ascii?Q?kyIIf6X22YfwH3VVQ3nD7azBQbJQlsrkbWapoxogHPh3wYCEvxn9k9NmtyJQ?=
 =?us-ascii?Q?PpLuWO/ktYLKTO6wfhQFH4C0mIjWGgqp+2W7KJjSzHZyFD3nu15diCmHZQO8?=
 =?us-ascii?Q?IeJWc8rmezC0XwKreyOXfPBVmkZVaMOyMh8sYs0hoyw9CUiNLrP1oakXXfNy?=
 =?us-ascii?Q?4kgjVFIygFmQxm2KqYSVxZ++0m3U81SZgFMDq5Lz+d67olyHndyuWpELpJTC?=
 =?us-ascii?Q?XRsZejQvOebnmPYnyelZSPi0D7US1rzsP94nyzAwbdfxpwDmtsALI1yCPSyc?=
 =?us-ascii?Q?eXAB5JrRaZ2hbjMxKbIrDHgYtcn5tgpfn/8ommUocDx7KSbCj0OWEKvCYgwZ?=
 =?us-ascii?Q?Wwelplzsl/ySXfsfsCLiSFlzMvECOpLCU2IsLo09k2/tNIj1COkoYsuKas0q?=
 =?us-ascii?Q?y/4vU6nveomPxt07O+3kR7Ds/5ET7ENYv/3aoeH3QMp3jMMxuhyVXX5iUfmr?=
 =?us-ascii?Q?HMDOtb+hhErn+pR/cs6Z9IbQTdUeWmqktHd3VAMwH5rEynCsjJsunjKSJ0az?=
 =?us-ascii?Q?Q19fV4rqLwDAS6cU9N2Y27K0n9UD1SEyDREhlafwUZ4hVPK0GgzEQiVCm9RZ?=
 =?us-ascii?Q?miHRi+yPlunAtFu6bW4KmFM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77304cfe-baac-460e-ce2e-08d9e3a99c56
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2022 04:33:06.4048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUGkolxyy+TPqvhkIpZGudeyPdajfaK6lpI11O47zZV9ljYCy5gLiBaC3t6tqo7aerHfgoKydEgmcNPR2C/i2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5876

Hi Matt,

Thanks for your review.

I don't know why this commit didn't show in the patchwork. The CI seems to
have complained about it.

On Sat, Jan 29, 2022 at 12:53:20PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 29/01/2022 07:26, Geliang Tang wrote:
> > NLA_F_NESTED has been used in both 'pm_nl_ctl' and 'ip mptcp'.
> 
> Was it always the case for 'ip mptcp'? I mean, we cannot break the user API.
> 
> And even if it was always the case for 'ip mptcp', there could be other
> tools not using NLA_F_NESTED. Maybe we can ignore them in this specific
> case but I'm not sure.

I think now is the right time to switch to the new API: nla_parse_nested.
Since now no other tool uses our mptcp netlink yet, only 'ip mptcp' and
'pm_nl_ctl'. There's no need to consider about the compatibility. The old
API - nla_parse_nested_deprecated - is reserved for the compatibility of
the netlinks that already have some user tools using its interface in the
non-NLA_F_NESTED way. We are not the case.

Switch to the new API can force the user tools to use the NLA_F_NESTED way
from now on. That makes sure no user tool uses the non-NLA_F_NESTED way for
our mptcp netlink. Otherwise, one day the old API will be abandoned, and
then if there're some user tools use the non-NLA_F_NESTED way, we will have
to deal with the compatibility at that time. If we switch to the new API
now, we can avoid this potential trouble.

This is only my opinion, and I'm not very sure either. :)

Thanks,
-Geliang

> 
> Cheers,
> Matt
> 
> > So we can
> > use the strict mode parsing function nla_parse_nested() instead of the
> > deprecated one nla_parse_nested_deprecated().
> 
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

