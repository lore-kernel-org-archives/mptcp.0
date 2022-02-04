Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68A52F21
	for <mptcp@lists.linux.dev>; Fri,  4 Feb 2022 13:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643981537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0F0Ny1eBwAlS2TY+rYiaqexcR973GWB3hrCGlV9h9lU=;
	b=eoEfOMmyFBMiR4bfcwnAgj9VZJK6uJJ3QQ7PiNcuXxNpGhyG9q/8EKjephNLmG+ZeT4NoS
	82jbnJWT8M2SqkCClYc14mZ7rJ6mhxgVYgEoVbsa/E0ZtvdbtzNhr01wiCUq1z+ZQDbe2c
	Y3gtSdbQ4vnHjxLd4TbpcrHuAWbefl0=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2052.outbound.protection.outlook.com [104.47.9.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-zt6bRxHWMvqQlTRyGDfYcw-1; Fri, 04 Feb 2022 14:32:16 +0100
X-MC-Unique: zt6bRxHWMvqQlTRyGDfYcw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHFinxTJU5XG6ySSSKXY5XEuJJg2Cfajrd836kIi6RcEmZdc3HwmZz1pcTNgBTGya1ceCz4qFQjU+9c8B6K441hrY2VQcgYKC7E3rWkEvuMlHMV/mnQf/brCjbCjuiZIyTOrbstJevUpXoULGYXp4gcCmIBRLXr8rcl7i4EYOIn4e1H5y6KI7lChm3OyfcQXw4OK2o8xt2ZcbH97jvwQ751bDsUAJvOrhVjd0J2G/kUccSHKJzcgS6ZLeQpBtqtqayczKNmsiXMA5HIdMxbMFnQdqXw6RhLp2w4vCTDjOkjPOi2WeVpQYQkpjWpjT+8NGRGxgGnpW6PgH6GhPpwbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0F0Ny1eBwAlS2TY+rYiaqexcR973GWB3hrCGlV9h9lU=;
 b=UqzeKEeiA2gBC9O4sZConLQDmR4pChI6XriJlr/yBgSfg2uqXL7ETd4RbUrgHSK9oFXYkEf7fjEZrTCOGLrBj0rvOGryNgQPQqR6kkMMhRTaXJU0/9Tm6NMLJKs1IVGZKiyprPFCeGIYs044Ha3YfO/G2TuWrArwpgpue6u4lABYN5LV+VKFyWcP9r4RIN6oFp1OFbFtw9CboI0sRoABqeUszEBksTkMiqK7SAvHg4AwcdSKzwVuVIH78LjhlS/ikg1N70fAGqZpI9JJVOQW8oWid/G/DatC8qZQ3ZXDF5SQk2TDM6ev09fsKpzgIbrtkPxxnr+6nuTaLGasxY5sbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8581.eurprd04.prod.outlook.com (2603:10a6:10:2d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Fri, 4 Feb
 2022 13:32:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 13:32:14 +0000
Date: Fri, 4 Feb 2022 21:32:37 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: use nla_parse_nested
Message-ID: <20220204133237.GA14880@localhost>
References: <022caed0c9e5964f525336aced8233338c29386f.1643437533.git.geliang.tang@suse.com>
 <25250bc9-015e-df2a-582d-5b5dd3eabdcb@tessares.net>
 <20220130043318.GA7781@dhcp-10-157-36-190>
 <8339d9dc-4055-57c9-9c97-9ca4075c7496@tessares.net>
 <a83209f-7839-d87f-5d27-fd337cd972c@linux.intel.com>
 <9c95d09f91ebbbb702261765dccaf81852d479db.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c95d09f91ebbbb702261765dccaf81852d479db.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0175.apcprd02.prod.outlook.com
 (2603:1096:201:21::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cad7ff4-52bb-42ce-5bb5-08d9e7e2c118
X-MS-TrafficTypeDiagnostic: DU2PR04MB8581:EE_
X-Microsoft-Antispam-PRVS:
	<DU2PR04MB8581BF37FB0690FB0201E114F8299@DU2PR04MB8581.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x/+LRzH90lYk3nzqx30SwbYUY+VxF47DInQw8xPNjg2CJQi2wNUtO9+pspRMIFCJxpi/8hPhJy1B4UOlZM/7mtFU94ocMPFaXs+lwq05TXEacpIfBFdNjEVznxB7s4/Gp1p9stKAEwyRJkzV3SCWa1UGye0vb/yesPrDj2z6QbnJt8GrkvrMbpc5474FC+tIQ6i2QrjWLaiOSZgBVUQLGAM+HiRlhI7C7phGZ461zh8xo+TxxZ/TLCiMEUpIWhXdyxwI20Xxp0WP1ojjC8o71UL2W16zlxc5GwFUite371QPH9mxFraJefTKrSMJ4FO//J2VFll/t7MQ2wISB94eIMKtf/nrV2hcJAuVyJdfM7LLFseHWCCeS0W7kl9LnBV2hUvc5OGaNmvw23ryZmoPT4SKX5tNk56P1GJ+EGJhjMhnhu3DOS+vyNPCmB98E7opFSs9mRPhUCMoSuhCLqlcSaIWRaMFwrNbfew3PWwqRQt2LbO1A6AXL/v+PvIR+UAIW+iQbfzVcYckXzeRc1FXIo2rIA6jFv7ImwlTC2Imr9Sc0plUcnv3M8ibbKKC1XSpWBNK2NpK857A95Fe01288D8k8DYIkMbi7g+zrvZ/ZqJvKFCCeIfZdM5KjtZIX46XGRiZr2RIL0pOblZW2pabaQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(508600001)(8936002)(8676002)(86362001)(2906002)(316002)(9686003)(53546011)(6506007)(6486002)(6512007)(33716001)(6666004)(44832011)(6916009)(33656002)(66946007)(1076003)(186003)(5660300002)(66476007)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tlhs3TpSYMTh12JfAmB7vnvBo/Cr99mn9phBoh3picAWn1lPzStmubgtYcNs?=
 =?us-ascii?Q?REvoq2D+iKZIcooqZgDmtMNDGYU8lEVfgZuElwXLRJwOilQShKtxYKgeFbHx?=
 =?us-ascii?Q?9UFogbVw5g/Vwp+2p0UEcJ2YmsLp2EAxj0E1tbchKtGye97L7mXCc3wQq7Ax?=
 =?us-ascii?Q?YQlODVwg77ZxoHY+801bgRgefroEFGJmJjnGtMcm/oeShPWRzsSMGSmHOUe/?=
 =?us-ascii?Q?najHkur5g0yzBQ/KuW3ll7fuixba8LVAbAQka7eoxKvrAJiGvQ6/+hZZa6Wr?=
 =?us-ascii?Q?XkIBs3MxswUdv93ZbbrRJ0BFDo0wDwCVXHHzn1WRnAFBd8N4H+vUI9JXCW/R?=
 =?us-ascii?Q?c3pYqSL+ZhAoHy/mEhjlOLO1YJruubkpCddn+F+taus8YvRFM+V5/qO158sQ?=
 =?us-ascii?Q?cObZaxEloQdNq19P3fP2U8x3UK8mtdFrChw2yTI/MHxenh0+qCDVuMJc3sS0?=
 =?us-ascii?Q?NaaFFjju8nhl1j9OBRUE555AnAV0wzS8Nhfqyi+jZCY98FVzns3x0vFf1vxR?=
 =?us-ascii?Q?P1h/SY5FFMWqUSIEBcmB1mb1IeLqOeMYr3KC7fluPa9QLslt7AKf6XugM4PP?=
 =?us-ascii?Q?0PTfvHFc8M+vIFY44/0fev6wvs4p4YuFQpaQGha+dKhbtHckccDn9kx0rGgN?=
 =?us-ascii?Q?+wqVF1zeMLRgTmBJrkOjxSe0wY9krNYa10lhy222hDzvyno+nkbp380Gnc7U?=
 =?us-ascii?Q?Nr8IR3sQUCW/bkKpL7iFprelZBDYQgug4pWrIubahhIb/r+YMR6m+emNmMZI?=
 =?us-ascii?Q?kMBP59blAXSuIqVoA1P6M9MzS27ChStSOpNaIPVSiscc3d8qIbjdG+V2x0tB?=
 =?us-ascii?Q?CXM6a1X+4btj+2EA0wb6KmcbSaNcBxgog1/v5s/6q9s6SioBJ1/Dyct1i7k6?=
 =?us-ascii?Q?LqNDhh7iv7l3OThui7Q8LyD5kL0hZ3Nx+elzEyw0k339wutewU12WXd/N6HM?=
 =?us-ascii?Q?Q8TzIgwrpI1hT5SMvHz6u91ou1OpfJ10fpORMtErPgF4Pk1MOfZIwqCzzLwY?=
 =?us-ascii?Q?OZzq67KTqUlZK2s2N6YmZikCbWHDC3iI/J1ejE09YVsyoc3Xn/KycdU6Mdz2?=
 =?us-ascii?Q?Nr5UO5Eg/HbFEHc+0j/Umxez+pUnw/Vi3mv9EofWy1S86WaZhjL8ltuKaXSz?=
 =?us-ascii?Q?fHvAG9B0tG4m6nK548Ximfi6vQU1o7xRrBn0NyoB6kYuNkTnPxZjdmSApuO+?=
 =?us-ascii?Q?LftmxW6GXbaSRMnq/JaKHxE1/lfLHxZBoj1NGL6VJmGxvwwI/lOwD4Cnd25G?=
 =?us-ascii?Q?02zXA3SCb6uZZj2xgGuz0TwAr6mT0NML6kgkg9f+uQnkFigGWHs0zkWHeNbJ?=
 =?us-ascii?Q?8ECFa5dltp8NiXPGjhw5TsNoKT0+Zum/Ytjeb/uvIAzCE8hNnPNJP4AJGbB8?=
 =?us-ascii?Q?8/XQyiqTyTwU8CsMN/st//qNlP2S9CIvLR9grCCa8MM42YFhnsRw3n5KRqGI?=
 =?us-ascii?Q?vVnhypUlA3xf8tv1DtSKquiH9MemzwVkvmC5Mw8HVf13rJYXyZwAp9/kQTBw?=
 =?us-ascii?Q?fenvMyc6LVOObbRpsTE5wK4JBRsm6YTP9ZN7DPbSdjLVfo0Fir3+1LNfg/F8?=
 =?us-ascii?Q?IOs2zHYtgQAcXMypRuQBNoE2HOdl1mqM4sC5fKo97hnumP+PsvjECClYP7Sf?=
 =?us-ascii?Q?OdZQ4chzpjHeaGarFh10USoMnMd9Fgw50SBJCV4NuKubgVsngmXvL33oxXJd?=
 =?us-ascii?Q?PgytMzA4r3tcF/wV+FgemSOZQxc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cad7ff4-52bb-42ce-5bb5-08d9e7e2c118
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 13:32:14.2859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGsTcNMG9JE8mGmTGVdKPU0YUt/ciYq69y7tQm6rRifnEIIpNpQu6CGBTDsCbJNDS0Uqary0f/HXrTthYmG88Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8581

On Fri, Feb 04, 2022 at 11:16:21AM +0100, Paolo Abeni wrote:
> On Wed, 2022-02-02 at 16:38 -0800, Mat Martineau wrote:
> > On Mon, 31 Jan 2022, Matthieu Baerts wrote:
> > 
> > > Hi Geliang,
> > > 
> > > On 30/01/2022 05:33, Geliang Tang wrote:
> > > > Hi Matt,
> > > > 
> > > > Thanks for your review.
> > > > 
> > > > I don't know why this commit didn't show in the patchwork. The CI seems to
> > > > have complained about it.
> > > 
> > > It seems the issue was on kernel.org side, now fixed: your patch is on
> > > patchwork and lore.
> > > 
> > > > On Sat, Jan 29, 2022 at 12:53:20PM +0100, Matthieu Baerts wrote:
> > > > > Hi Geliang,
> > > > > 
> > > > > On 29/01/2022 07:26, Geliang Tang wrote:
> > > > > > NLA_F_NESTED has been used in both 'pm_nl_ctl' and 'ip mptcp'.
> > > > > 
> > > > > Was it always the case for 'ip mptcp'? I mean, we cannot break the user API.
> > > > > 
> > > > > And even if it was always the case for 'ip mptcp', there could be other
> > > > > tools not using NLA_F_NESTED. Maybe we can ignore them in this specific
> > > > > case but I'm not sure.
> > > > 
> > > > I think now is the right time to switch to the new API: nla_parse_nested.
> > > > Since now no other tool uses our mptcp netlink yet, only 'ip mptcp' and
> > > > 'pm_nl_ctl'. There's no need to consider about the compatibility.
> > > 
> > > I would like to only consider Open-Source tools but I don't think we
> > > can. It is unlikely someone wrote a new tool not using NLA_F_NESTED but
> > > I don't think we can be 100% sure. This is an uAPI break to change this
> > > I think, no?
> > > 
> > > > The old
> > > > API - nla_parse_nested_deprecated - is reserved for the compatibility of
> > > > the netlinks that already have some user tools using its interface in the
> > > > non-NLA_F_NESTED way. We are not the case.
> > > > 
> > > > Switch to the new API can force the user tools to use the NLA_F_NESTED way
> > > > from now on. That makes sure no user tool uses the non-NLA_F_NESTED way for
> > > > our mptcp netlink. Otherwise, one day the old API will be abandoned, and
> > > > then if there're some user tools use the non-NLA_F_NESTED way, we will have
> > > > to deal with the compatibility at that time. If we switch to the new API
> > > > now, we can avoid this potential trouble.
> > > 
> > > I guess the compatibility will need to be kept of a bit of time. This
> > > function is used in 250+ places in the kernel. I guess it has the
> > > "deprecated" word in the name to clearly indicate "you should not use
> > > that for new features" but not to say "in a few months, we will drop
> > > this, deal with it now.", no?
> > > 
> > 
> > It seems like the meaning of "deprecated" is the former ("don't add new 
> > calls to this")... but we did add our use of the function in 2020 after it 
> > was already deprecated! Given the "do not break userspace" rule for kernel 
> > changes, I don't expect the deprecated to go away and for now I think 
> > we should leave it unchanged. When we discuss patches at this week's 
> > meeting I'll see if others agree.
> 
> All known users (self-tests and iproute2) have NLA_F_NESTED since the
> first implementation and I doubt there are other user-space users out
> there.
>  
> Still the downside of breaking user-space are quite bad, and there are
> other in kernel users of the deprecated api added even later then
> MPTCP.
> 
> I think we can keep the existing code.

Agree.

Thanks,
-Geliang

> 
> Cheers,
> 
> Paolo
> 

