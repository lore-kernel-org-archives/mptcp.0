Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E6B2CA2
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 12:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641818106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xg+v1PcIrQwVqjIFwOoX/5EhrRD/21GKisp93rLiUWU=;
	b=YKAf6Tj4yg11Yc8/+JF8JRjoJHgy6Rvp2acMp9s2mAVWtqmv6/W6nmph7hzNN7sDhVQ8Xn
	+6YRdzmwAg9jbW3peil3uwxsc401mUI3jE3qs0xbGuk9SO1mXiVTP53HKBzVmJH/PgExKi
	ScLbDnKZAoxYXFzr6gAjGkXDQjbo+sw=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2172.outbound.protection.outlook.com [104.47.17.172]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26--95dLramMlCIqiCoDpeINg-1; Mon, 10 Jan 2022 13:35:05 +0100
X-MC-Unique: -95dLramMlCIqiCoDpeINg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e44i6rPiJ28xyL0OKfZi+5gLUIY//q0s+MZ+44hInAFLhuBODsQA9va0/6ZlezzFwtzZfOX65txago/a19tH1ywUjCYP+jXSCf7ICvGYnDtWZ7qp/vPSK/W2973qRp9Dyqy9MTIsQRVGmvfibp6qWV98QvDJQR3GXT2ogeqOy1cGd4Z+442r2YhcE0HQ67gk3VXGbA/sdxRxmKam3B8rt4g4zk2AmAdfq/20SNzEQ2kkz1VTHnxL12Fyy9G0t/rjv6F0VUHm1nTojLJJ+UhBhth19GZrGSry+1Iq0iNsOqvyyqHbk/5rfBF9wUgaWx8fVVXIzvDHU7WAAOtIETUOkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg+v1PcIrQwVqjIFwOoX/5EhrRD/21GKisp93rLiUWU=;
 b=FBOLfq5J85cpJJPQjQSpAfhjsCWl9lTBgic/pnnYPlYQOYxKTUA3temgMHWEOHvHkGrCw/zZZcRvaJM2u16ueyuBnJCxcXMabVhq8rjK50KWs3Vazqr5iec/mmQs3kTbYuMtns9+mK9gcUUT9zonAiVOeUcTSFHmmi/82tJu6Mj0wdagVQ7T36qBL/vEY7LIl6JXItHXwjCRybZ1RVA3X8zq8+TXcGcFHBQ16wvG4vd5GO7x8kGsnrLli7ANUyaK7OJ4pnXQzyFo1+awLMlgZ6C4r5s0Kukwh+gUZo7IdYEiBApQf/zgEDLmO7EQ7oyEoFYGB9RLbSokN0smeffdsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB2955.eurprd04.prod.outlook.com (2603:10a6:7:20::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 12:35:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 12:35:04 +0000
Date: Mon, 10 Jan 2022 20:35:02 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/7] mptcp: add clear_flags in pm_netlink
Message-ID: <20220110123502.GB3145@bogon>
References: <cover.1641785106.git.geliang.tang@suse.com>
 <0132f80c0aa9f62deb00c816dab5d51d4032afb1.1641785106.git.geliang.tang@suse.com>
 <1b01c2a797fad9d2971d485b158d2dbd61d14fec.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b01c2a797fad9d2971d485b158d2dbd61d14fec.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR06CA0212.apcprd06.prod.outlook.com
 (2603:1096:4:68::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 565d40be-b0d6-424d-e412-08d9d435a0d1
X-MS-TrafficTypeDiagnostic: HE1PR04MB2955:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB2955DB7C086760FD8EAC73DCF8509@HE1PR04MB2955.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8mtxexur0PwInPlHOyqOsB7x5cxFjsB9NajIW3tRA18//Ym5qDyjATCxr/bWfrzK3rCF6mRtVvM0wczctKcCy9PcW+IfuTDTWbpsb5O6/C1TgzfxN2OPI6CoFRSLu2icCnw8ZpZng8INaOn+5Pmc3YZ5xBSpRqHnm09YsrGlOvnKWcQFnvvaLF6Ua9T089ivQkxB6zxHCsCgR1IOHWBCaEWJEhqOFj/fZqYR2VZ+BMpEaUlfn8at9jOvshQldb6aSoiH9enw0QVji2cmaQDtiqs7SCvHdvLMa2AFzfONH0BdGv2GwiWwxPXCIqkWXg3Y1ymwZe6bXAyfgkspEG08gOWL8S1tHthJ61KQ/v41jlDwNALkIACDfyr7IfxDOCBlp5VSrWMGeC5F6d2iUP5ujdB+SFymYff/3CILcVXOtH5TbuvL5CGkKiRMVl9orvHI/YeOMFjla+4qATZ8G7ncgotSVKp1LsbJ18TzxDW3VVOtiCug3Mdf57+bRha1m/FPMjH+mfI68ARk3etGW9MhOr0ylwbGwsjP3QQRUi4UoYqxG9OYWoKp8yv/BGIZBqnJdNKJWoMJpTfqDBe0WO6kiPPl1g8b8LwJp6qMDr3zx6IlXkwmwxz0tJlBQaJ+JcD8g7RjGw+jVEY/KAKBSe4kFg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(86362001)(33716001)(508600001)(6506007)(1076003)(2906002)(83380400001)(316002)(33656002)(8936002)(44832011)(186003)(8676002)(66476007)(66946007)(66556008)(38100700002)(6512007)(9686003)(6486002)(6916009)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CBNGhOK70sw2nSoIIB3Ltsc6GJsieH7fU2hbypIm5hQYoUEIwQP+df4UL/4H?=
 =?us-ascii?Q?kN9A0SMeRwp/EwKkr+XgnD3t9bDFsp6rsvo48lFlfNOsyS7Gdzz0DiElruXo?=
 =?us-ascii?Q?GnXC+bFkmPWWtqaAgAkWbZhl0JwAgcL9ZSAGKGicX6HQJt240KcByMF+IZ0H?=
 =?us-ascii?Q?zl1RiDHqcBVhxzjlTXYN2yEmuPrM75ZZdNn3L9eaSDTYPjrxBzjn61BFbBNl?=
 =?us-ascii?Q?OXFd3Nroh5fqAL6GvmYMwIrFIlMTSTDrI/3bm9jv5DK7QgEWUpdxVrOg0HsP?=
 =?us-ascii?Q?ow5b+hhuMdXMhACEQ3ytN52pbsRcUP3UUpXFacaNR/tsgf2BueUckCRb3YuX?=
 =?us-ascii?Q?v/EML8USS+ZJZcozgLTvr3SpNk/Ochn8he1xVwKu9dq4TJGDgTDlIfHlOaE1?=
 =?us-ascii?Q?xjRUuPzVjy0hao8iHBKIvXycx09jVdOyfHCNMw0PD63jmyXcNpVfVCwLdbXy?=
 =?us-ascii?Q?gioJUtUnVuHHbaMa8o4S1XLZEFkYfJw4GpurAMZrez8jnK3gEttdJ1zHJMRT?=
 =?us-ascii?Q?WT626Idu4ALYxWcD7TpxhxkNhHRIQuGUl4ORltLw2s7BzibAo/xGiRvZ6Q2m?=
 =?us-ascii?Q?KnPPTRzjbSHogLd/ike71hjmuE3ExSODHbL6iqygWAqIh94VL0F1fnc+LFC4?=
 =?us-ascii?Q?IKzDfWA7qCXUZKpdF+Grooh9yY7d9Gx5yZXv/YNdUSSPKby4COyVl9+cR013?=
 =?us-ascii?Q?N/zA5e+NFp6kimYWLBTaCiVel15tkxPgAfK41STORXxuzMq3GWA+gpPO4Egy?=
 =?us-ascii?Q?7G2jb9dQzwC6COtPsWfVEOshdXh92zCcrTAYOPbCjbq8QfpqxqrFf4DIkJIs?=
 =?us-ascii?Q?zCIlmRYgYpLXQEUIKA8OWOKoLDLwQDeCx4CPMQDUkPVzldix+TFQoUJ0EGMj?=
 =?us-ascii?Q?1rl0bw8GLGMZ3yTAxUjm/0gTWosHhQ5UL56LE5dAEFUiVbT6fhLbdUK3Vbp9?=
 =?us-ascii?Q?5cDHgbp1DWijqIBuSLvcqQl2z+6fMAnhPZ/k6rmO4Xr7qiF5oXrhHR0zfa4L?=
 =?us-ascii?Q?biJK7BFKYah1YeH/NaA7EJ5ZVQH03qDlzixQDEIGVwzXtdLRJe3rrFjQEPCI?=
 =?us-ascii?Q?6avNtfDp9gxqu90aYyI7Z2y88TZ8DxmZAujEvZKps2wSMbYtzJMskd4zm2FV?=
 =?us-ascii?Q?0NbpMWXLt0aw4/rnuOWkuqiR/PoM/vjl9X2fhrOPhu6rG4Fta8jmBLHaNZO+?=
 =?us-ascii?Q?jLqFsKY2vbnX7pQjf1bXCq62DT4a7B2AD7aqhr1ZFEsJKVtd7g3qvjZ7Oia1?=
 =?us-ascii?Q?POGdgRfB8EbTqBtMakn2fOFORV96N5lQKr8WdIJMnfQEA+i3M8oo4OnWUTQU?=
 =?us-ascii?Q?cLhNVo9ZDg36gDBEcIMP2ii5tUQO/Lizjc3L2Ri2s7y2dstC2FvyhuNunfCc?=
 =?us-ascii?Q?yCbomRWvK3bDVINVZC++njk0wFlgI6A+mnFB9TikLa7Xf/SW7C7ltclBSLPQ?=
 =?us-ascii?Q?yJ7afcYh3sdh9Tb72unepQ4YhgjWzrOii1DXyF/klZxp3bmAQZdMJSmMS3+4?=
 =?us-ascii?Q?BrlntLUgbfA7GRe2Jq7Pf/m6Ltf76epB6zVkhpPZ6tJfuhfYO86BG5ApMx/M?=
 =?us-ascii?Q?eh2ggd48tqVpMAp1AKyYdaUOTEheeaacobZDOAemRclFQ1e8HVIkggf+qSAo?=
 =?us-ascii?Q?hpJvODQ4pxyfhFfVXBw9I9YcQ8FZTp1WA+t6sx5Ntsl5BeZQxtI4bF9Pvv6I?=
 =?us-ascii?Q?MSrfnuQgiuctZs4wVLyFKzNVRLs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565d40be-b0d6-424d-e412-08d9d435a0d1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 12:35:04.8913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuVZTc2IfIJZSmOqGc5XlCzTZSUq9ruxBZZ7nHGYe3/I2l8uGxKsI+FinvKl6K+5J+C+zDjLD/odMFp7+4CVYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB2955

On Mon, Jan 10, 2022 at 12:38:14PM +0100, Paolo Abeni wrote:
> Hello,
> 
> On Mon, 2022-01-10 at 11:30 +0800, Geliang Tang wrote:
> > Splite set_flags() into two parts, set_flags() and clear_flags(), make it
> > easy to add new flags to set or clear.
> > 
> > This patch added a new PM command MPTCP_PM_CMD_CLEAR_FLAGS, and a new
> > function mptcp_nl_cmd_clear_flags().
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  include/uapi/linux/mptcp.h |  1 +
> >  net/mptcp/pm_netlink.c     | 36 ++++++++++++++++++++++++++----------
> >  2 files changed, 27 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> > index f106a3941cdf..1ca9b13c2ed0 100644
> > --- a/include/uapi/linux/mptcp.h
> > +++ b/include/uapi/linux/mptcp.h
> > @@ -92,6 +92,7 @@ enum {
> >  	MPTCP_PM_CMD_SET_LIMITS,
> >  	MPTCP_PM_CMD_GET_LIMITS,
> >  	MPTCP_PM_CMD_SET_FLAGS,
> > +	MPTCP_PM_CMD_CLEAR_FLAGS,
> >  
> >  	__MPTCP_PM_CMD_AFTER_LAST
> >  };
> 
> I'm unsure if this has already been discussed in some mtg I missed. If
> so, I'm sorry for the late feedback :(
> 
> Looking at the existing netlink interfaces, I *think* the preferred way
> of handling this would be adding instead a couple of MPTCP address
> flags:
> 
> 	MPTCP_PM_ADDR_FLAG_NOBACKUP,
> 	MPTCP_PM_ADDR_FLAG_NOFULLMESH
> 
> As e.g. IFA_F_NOPREFIXROUTE, IFA_F_NODAD,...
> 
> The above should require a similar amount of code and will make it
> clear that we can't/wan't to flip the SUBFLOW or SIGNAL flags.
> 
> WDYT?

Agree, will update in v2.

Thanks,
-Geliang

> 
> Thanks!
> 
> Paolo
> 

