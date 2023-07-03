Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F58FA34
	for <mptcp@lists.linux.dev>; Mon,  3 Jul 2023 06:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUiGgEldzTUBogtxECx+qfXvIUDTc4n2Wfv/BkenbipvzS7c9JMwCzOovKzrjYHxpcfX3+7OCdqJmq1qv8qlIPUQ3PlfJ+5fjaSDbxutLez7Su8vb8lNZrxzVda/XRb30hhvdG/L1ezUNhnsYqbySykKLhPkxNA/HwP4iATBYPBMS7VtE0W+tl++QmQL86zLX+4zP3G9Sr4uXLzpgULg9R5pBV7bxZCvCbsAsnjzvVOfN/zR/Kfcemhbbxax74DAKb5tIwgeXtF/Ap06bbc3PYq2s/4luLyZs07DK1n5Y9W/AbCj5xRZp7t1/95VWNMdbUCFqHZog80LO7xIrk8phQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1yOCuVeZaoGyapQ9oSUYein+3O+7NDpxC6sD8asZPI=;
 b=gPil93KNQcp2zV1LD+NaVWXXSDSCxkCFYnfn1S1APqw9nUqff0JccCHoVMQA8yf71JHirDfUa4/uvfsEj17T+vqkjK9A02FpwyXTZCGfjBOaM6DTnZoWUCk+JoZc5sN95T80gt85kMEM5PORKs+f3k/S7tg5iSPCDkSDZtk64fORiMbYZA2up2muc8o4rd3VQEnPrpDBlBLsGBL7ew5Ll2bW/ATfDuK6lG4LZrYS93XIDlyqyzlLEBrb7lCz4GtkXMvT4tGf215Z43fWV8wv992c1+u2Nit1vxfz1JT0vmqEwl2A+VwPLWpAjpJUKGls+AvWjv3E+IlooX29y7VKHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1yOCuVeZaoGyapQ9oSUYein+3O+7NDpxC6sD8asZPI=;
 b=kzDwBPVIh2M316xeHrhvH5ViLP0L1lDHrvSVSzyYCnqSYiNUREID64vjVl2Lbcz4CikAOdIwu352tFoXv0Gow1DMvW7/QwFsR9H6ZNY2m/Kdx8xWIdp/2K8Zh86gm+E6WESG5PpWzGNmzUP0Hv+SDI9VW+IJb524n0nsX7mJ5xVENSFyaGKJ1Mi2DsYHUyTQmCjeOi5g1N/TauilBA5HgWj6fe2xchnOI01nskAxpb+D003knfhPgtIL6MLNP8mfYnaAB0d7dT9uiTiZAeUFHALCY9ryA6qCiXG9jZ7d+3KRWiJnyWX174k/dZbOnzRmkXVYvHPwHZM1B5zfFbjR5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8950.eurprd04.prod.outlook.com (2603:10a6:10:2e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 06:54:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 06:54:07 +0000
Date: Mon, 3 Jul 2023 14:54:11 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/4] bpf: Add bpf_mptcpify helper
Message-ID: <20230703065411.GA22455@bogon>
References: <cover.1688004307.git.geliang.tang@suse.com>
 <53359d2572fdd676206c35d29e823e9dffd5e9f6.1688004307.git.geliang.tang@suse.com>
 <72dce095-9e4e-b9e2-0ce8-dfcfe58f7ed2@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72dce095-9e4e-b9e2-0ce8-dfcfe58f7ed2@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: c89897ea-af4f-4f0d-64e9-08db7b924c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6wMAuxJWobOm/9nZ8s2unpPVqnu3EbH6shdTb12mhJsWsG2QxY49dJUFuEsvh0+FV4b46IDJv/3mlD+LtR4crIvesPA6jtjc///qpJYhmESitbn538Rp+hVU/JE+NIFEPg/iZVfrqltDMdWlc9KR3q50VaKopnBk5SJP1ODn5NuIqA4KgnAlULnm1AzaDO2jjGQDWEL7ojmW/T2YeoufctWq25YPJX+ddVrK2Tg5XxA6lheLjG6v2y7922KBewF+c8EGFF3rMub1zF4pl9twHKDjuAl/HR9tzLNA7oe7Tok2st2r7sUeF/HoP1SaCDxlXSwtXZj1zrXqzQT8VLD24XOPFVyeGYDcK+hATI7yEoVFK7pIww2lppJE0rnaeEOn6DXaBdpn9ECH1EG+NXqLtLuXTc6cDcmQGceT9oLovSDrr9f6GF/0HJ24eIY1L5TedpF/cMoaxVodf+jn2zEqzHKu3ZzbRQjDGLQkb2QzkHzMYjf0EbBmmhDpxLnSKNARirkzY4/1WqWMikoRF2aolwC4b5b+vEWerSpKMywiN+70cOtMdg7rusFQ055IZVVeRA9WYPgQIHR2lSOOMV1oCpW1kuZggd3inpXebfu4v18=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(39850400004)(366004)(136003)(346002)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(44832011)(33656002)(15974865002)(33716001)(86362001)(186003)(478600001)(26005)(6512007)(6506007)(9686003)(1076003)(6666004)(53546011)(6486002)(316002)(6916009)(4326008)(66476007)(66556008)(66946007)(38100700002)(83380400001)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GHT57NkWjFOXC10U1I7D7IrpV7+bkGOG3FFDnMfJNVyQJceSyp7ICcawb30O?=
 =?us-ascii?Q?fHh7mLpuTlrBdtiJX5RXisezUCT4Qo1i/CVzHOV2vo5ZeieQka4UjkhsY9vp?=
 =?us-ascii?Q?3RmVei2+WHjzMTii9Ee4avJRigkYH5dn7UMHXVOLX2DAotWGOXd/uO50LTms?=
 =?us-ascii?Q?rfwiuSFvgVI7Ffi50I3UZmQH4zNuhUNSJFZ9EuN5yvgwfNBErMYMZxu8Batz?=
 =?us-ascii?Q?HLQsH3wBpiNWaDKluhKqiYmS8LWty6B/uiRHHTsno7sKcKGXsN5x00U8LHBc?=
 =?us-ascii?Q?vs1GkZ4vr+XEOsuQ7u/rLd1tyM5W4zKEM97hvvDSeBO4pv9QGLUPu1KLX6Ql?=
 =?us-ascii?Q?wtFQlhVDUxwlupAi06zEC50vg3oRa59O2WMUaOnoWdnEkWjWKrwBVU9vvUbP?=
 =?us-ascii?Q?eQKDqrC3PpKRsg/VYtL1R25a/Wz6JCaIwcN0WnReHHWuGPfBH2RDiV8Y+bCH?=
 =?us-ascii?Q?E3aM7okf+AeHDucKLbFfNtGGEvlDmZYlpTmuhlULcZ8sydNx6BHlDMbFYmoc?=
 =?us-ascii?Q?GxLllSevZEKEhquwmZ9YfjmVkV3zXt0tK/lzt7pcU/Hpu7cK8qSCarJ6ohFU?=
 =?us-ascii?Q?oS/XsdL2E0jzhgTCgvHrT8duYkXFv1qKqLLci9ad9RFC2akDd19qTEnGaiuH?=
 =?us-ascii?Q?fdTasgeqxzZsat9BVMoV11WYF1dGNig6sBgNgwndFb0OjI8agru+22X9EI+U?=
 =?us-ascii?Q?7MwZGtdVPdlU70Iu+Zg4b83dHmBfYv2FXBdlOm0xbjpHKS8poG20nVK63+n7?=
 =?us-ascii?Q?YDwGMn/jZs+D0in+gENO3isLUB8OVmBLiTc3IQoGMDpZ8DulLwFwtxf9LXs4?=
 =?us-ascii?Q?GqLhXl1f0WkpGE8aSrdwuPLG+ld8euXZovkN4Mgu2V6iU7JUok4UBAV5XX+W?=
 =?us-ascii?Q?8ZiDsHWZicK9v1YWea8FaomyHhY0ushQuQT6Utn34dNhhbhCe26mzVklOCm6?=
 =?us-ascii?Q?hGgHe8EZwg8O6lfz14mxgZ7c11Znq0orrOh4dUxPxHsE7YL8jHoEtmdElvKF?=
 =?us-ascii?Q?V77P1Xo3pAdpOM+WpjvNGMSdkHH4cYf/ZQIeubeFP/KqcH92hXo4j7cd9Omf?=
 =?us-ascii?Q?QkaTa+z8S6A7I+Sq13tzy4hmJ3yG6kEK4KPj5QHBA7wYz+W6JsuiFES360Na?=
 =?us-ascii?Q?grllWVnk6T2R+4lKfe89kQqJzIIP9Lt5akwRUeTU8dc3KddrDoaKVw+e3BcY?=
 =?us-ascii?Q?A35faVeZoeUl5QLevni8PiClwt42dv/4GiDwQhcQSApYdhw45G7KonQR/Vyg?=
 =?us-ascii?Q?yczg+c6p8OPrwEI2rKmBW53wDR5vJAJhpCvNU9Je/TqY2fX+huadRH8X5Xi8?=
 =?us-ascii?Q?xtqXN6C/hMQchGgelxBIm7Bi84eEZimDI+mFva1GYj5mGNHOKlX7szNsxIM+?=
 =?us-ascii?Q?2jQ3rIffmqzrdbTABJ4R6ksmH2HGxGTrLWd7cKde3+UsB6EBDSh97KRlM9Fz?=
 =?us-ascii?Q?tssqRKm6XiDpoPv+AMx/sk5XAYEmP2caOJPERBaDDpOa/4mn5rD3relNRr4o?=
 =?us-ascii?Q?+7CT/BX6W0HCj29Z5TDSmfy2ni82n9sAB0NZB6OwQcu8oCcnYIFjnVJuEm/t?=
 =?us-ascii?Q?hjv1FlKW8cTZZW9zzDZb7taJwQx+HD0VuQe2N6bv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89897ea-af4f-4f0d-64e9-08db7b924c32
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 06:54:07.8282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Bi9z9Qkbp1ZN9qvXwHIR28l1goj4KpIDd8ogh2qTxJ/91GHMLhx9EAdLSSf870Lt6ezlnmmn01f4Xe1s2uBJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8950

On Thu, Jun 29, 2023 at 07:43:50PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 29/06/2023 04:12, Geliang Tang wrote:
> > This patch implements a new struct bpf_func_proto bpf_mptcpify_proto. And
> > define a new helper bpf_mptcpify() to mptcpify a TCP socket dynamically as
> > an MPTCP one.
> 
> Nice feature, thank you for working on that!
> 
> Is it linked to what Nicolas Rybowski looked at a few years ago? I think
> he put info in a Github ticket. Was there not an issue with this
> technique? Did you see it and fix it?
> 
> I didn't look at the patchset in detail but I have one question, please
> see below:
> 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 968139f4a1ac..e439f8b5f203 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -11587,6 +11587,24 @@ const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto = {
> >  	.ret_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_MPTCP],
> >  };
> >  
> > +BPF_CALL_1(bpf_mptcpify, struct sock *, sk)
> > +{
> > +	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP) {
> > +		sk->sk_protocol = IPPROTO_MPTCP;
> > +		return (unsigned long)sk;
> > +	}
> 
> How do we ensure such modifications are done at the right moment? I
> mean: we can only change the protocol ID in very few places, before even
> creating the socket (__sock_create()?). If we change it after, we will
> break stuff: tcp ops, security labels, etc.

You're right, Matt, we need to do the modifications at the very beginning
of sys_socket(). In v3, a new wrapper socket_create() is added, it's the
right place to do the modifications.

The v3 works well now. We can get three MP_CAPABLEs in the log.

Thanks,
-Geliang

> 
> I thought it was not possible to hook at the right place when Nicolas
> looked at that and/or ensure the restriction was done but I might be
> mistaken and the situation has probably changed.
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
