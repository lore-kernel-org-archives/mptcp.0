Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629BE20F4
	for <mptcp@lists.linux.dev>; Wed,  5 Jul 2023 08:15:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcCrJ82JX2eMluPyo5PZhQLMdCeBYEuktPTC6lodk18YburOmBobwgvjpLtm7B6Fo5Si1FP+MD7jz6Vz4eBPLJSvP/xjYZv+/nSJTagAfSo14SvMF6J6IuLOFblLgdybzJIQOsKsi8OAh+lCDM24l/CDu38iECqHe9QKXC2ORIswe1sNt6BMvISr0iwj+WEzBr5sncrqn88bAsouvLabDmHraBVA/2cOFKVNjM5qJk6b6WbOzVM0vMhAOFXSe6uLVtNAvE4iA/3zNu7FfKa98YWJSGMU6JJ8baFMAApOQzbMM/PD5EI6DJsrMTdIU0vWOoFqYVUPHbTAIfwYacJ9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XevDgoBxjSCfI8o65y0KxBIXeZMyewzbCCwmpFDF8Aw=;
 b=hpd5WOECJuz2zTvJMtdnMijdSDoRPJYwr6IGd9KR6cDKOQyS3zjyfMF9cMDgQT06bbELVA9A5hZvmWGhw8yX/n0y4PMkRgJGIvfXWUrambf3R2BZhJaoZy0hwTKY+/bv7UjgnztbJVG6tEYDzHWagbOc1SliOem6NL0JwK9iBXAaVOrCSyoLUUaKstCDEoyE+xlMQWK71FgveKDQ+bEHRIzqkLqyxQDg2iAgjwyvDMjavIUeYYMib/mcKeMhSoohJSCE44jSMZrTFXYiW/AEkDgZgqCbxcRlPudoWGEsuSQoObKG939iBQsjSUFC0l8WK/8SqNm6MgjD1Hjl8P+c5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XevDgoBxjSCfI8o65y0KxBIXeZMyewzbCCwmpFDF8Aw=;
 b=vAlEJZrE0bfT7XEAepcJVEj1M0HaVRZ9UeVFluKG5iFVKxRmUzTwvIVyc4WioUTAaKuM0CsKKgBkTaLUcPDtBqlQQUtwtTGcU4g6DIcr3PTmeqr1owc3ZJT4iBw6vcn4QpnLJ5AXERZ2peGUXtGASYpt9jGAs/kNcxLn/ViJo8x6T6nUq94hqCLUu0VYMnFDLVusmaKGfO7FKU4v80gfiXI8uQPSET6LHkI17+OBkAmfwcnHGu3xKrnO0bxNDoguOEGVpdF6ktzORr+81+nRyO7fQ3f7bixRXepfHw4jeoWHFOzI3Ugn9SzKE71VZaaT3YAyVndXaQ+bL0eoQnw10A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8800.eurprd04.prod.outlook.com (2603:10a6:102:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 08:15:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 08:15:45 +0000
Date: Wed, 5 Jul 2023 16:15:48 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/4] bpf: Add bpf_mptcpify helper
Message-ID: <20230705081548.GA17311@bogon>
References: <cover.1688004307.git.geliang.tang@suse.com>
 <53359d2572fdd676206c35d29e823e9dffd5e9f6.1688004307.git.geliang.tang@suse.com>
 <72dce095-9e4e-b9e2-0ce8-dfcfe58f7ed2@tessares.net>
 <20230703065411.GA22455@bogon>
 <75889293-09ec-a3e6-877d-c67154e36b74@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75889293-09ec-a3e6-877d-c67154e36b74@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 1361ad01-cd8b-45d5-f097-08db7d30083c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	raWpWColNyglQrlNjhtJT5nEj1Xp6VkFQIdXuhKNtFB4ltojUJbfW+yYbhC3JbgXTtrylYGlrqSoVaumtcl8B4l0c3RuY+FlOaDNSxyZHZKmHCCQmwC4iXrIFekQ24G28YPO23JXczx8lU0dkDju1UeqzpbfezHzJFV7aXUZtBqdKUXkMBrPptrXMurB5bMkHDogA8yrqR7abdanlxakuiBCbsEz/hW5W9nOVP+9OHjo9io9uYE79+k+LmPgm7oiF0F3+XhjAI776vUggvRxuhR8zNHYjBQskTYYTK+xpDIXQmkQV+9TjIpQNkTPUK1F31zhqIVCfERJEJ7p4dbP6bN8+8WqPETrGBo9lorUhNLUNqJ31hEWef8CeQmPe0wJIjawEwf3fNd5bnf2l7ZXtUNI5MxyDg6YiQJfb8ukmqbAD6BHnPe7qNoqLHYum3vU4zddwfVY6a2/NtDqDOp4etjaFMp4IjXh2l2uu9+gApQPG2CV47kGoGki1N+UCJ3X8j0o8KkjKu4oVlLf4zTogpwSE9ETZ34zunmFYGuwFRn31nES3OqHGERs3oj5w5qdlvDOiqGIGEz9wmg1bJYHG21jcbQGV9zqw/Rwr0X3JIjidNU0iaFfIW+7X5DBuDAL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(2906002)(478600001)(9686003)(26005)(41300700001)(86362001)(33656002)(6486002)(8936002)(8676002)(5660300002)(15974865002)(44832011)(316002)(66476007)(66946007)(66556008)(6916009)(38100700002)(4326008)(53546011)(1076003)(6512007)(6506007)(186003)(83380400001)(33716001)(13296009)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m+KO6mIRaqE9REoMZ40RQOcJmq1e3eqcu997YRA2wuBsb7XcIezkJZglmFh8?=
 =?us-ascii?Q?dTVNodXQALt0tu4s+7+FQQuxsQmeFT88qTTvIH3flcrZP/ykyDW8WWm7B3+O?=
 =?us-ascii?Q?475NOJQjJMiCXLKNDntEsDKliJEf+J2Gkf0rCBaj87ZHcJIAoZmiPLeSXyap?=
 =?us-ascii?Q?wblfy+biFAkeeIzs5eDmm1Ck8t0og5S2sVh/AqXFG0nt7AxQbvr8KRHyBGgi?=
 =?us-ascii?Q?vuWqVJRLHVyxm/x9udgut8w+nPS+kzW9KDJjwz3qrX0Orv9MtW9J1T/6UlAA?=
 =?us-ascii?Q?XElANZl8Zxv37MVL75MaQY4yC8GsvGd1HeBtDysT0vHtGsgu1RGL64ih3H71?=
 =?us-ascii?Q?oGj7HbXHsfuraG87Y6R/25J4uS5CPrkuWOeRlinAa3dXbj5u0mRxcdNZ5vXx?=
 =?us-ascii?Q?/1QtaxrfXMjEDhPZOn9hxTmINsBXlqC/uyN20JDrMCGeEaaixWPfIxuF/B+Y?=
 =?us-ascii?Q?cwNVvwryAm9SF3FGSOuS84bvqPgJPG6nv6bfBAcxEhsD4lbnNUa59AbWYvpy?=
 =?us-ascii?Q?9voHXvd1b9Ik2VLmljMBgCnWhsn8T/xvW1csN5PpHpjeAIC3v+fT79q8gyxN?=
 =?us-ascii?Q?0U2JCvv+YRegGjQvdciNmh3tDesxWfYgJk/H6LG9DVODEKKdYfISulIVyEfO?=
 =?us-ascii?Q?30mqhXpWcRdkiDw4d3c2kmKdclocUk13c0xze7jga0DvtEk4XcRv6Q/q5N6J?=
 =?us-ascii?Q?QgTf9VMZrC9KBg0MYR5eYsF+rlecX8Yq7Qbv5p1ep7aUp8By+X54gILVSl8d?=
 =?us-ascii?Q?LbUzW7L1onfyZ0XHUzho0fGFV2knRO9emL6HeImBZCn2nLCLyoIzViz+cepX?=
 =?us-ascii?Q?yY7GCqOcc+AemXd9GmSbrQAZy+3rv75/7O+H8GtJOBRfZD0yjdBEQGRJGT6l?=
 =?us-ascii?Q?HGXQOOwTVl2S86ItTnn9SHERfD+2JVUk76GskDqr/8CJXGEfc/tWaE5hJj/S?=
 =?us-ascii?Q?8EAsPz9x/nJSTR2n8anrYV4YV3C4161RubcMzCNzvR4jGjNXSv9ZsbFw4wqG?=
 =?us-ascii?Q?uGxP6SxmidEJDChJaFmh9dF13jn+oLPIly1FqA1vIYQPV1qrqdhh4fS5p40o?=
 =?us-ascii?Q?6ezRrCKUco3p/5oA5e7LZ/+oxa0iqPth3TBgYzGhDqfJ2LeEz5iJVn2aBJaK?=
 =?us-ascii?Q?Kqby1IoEpTEe08yMwoYu2qe16YL4AwnBRXsdIQhDJp+Tc5mmLy1PoT5XwwG7?=
 =?us-ascii?Q?35Mcp8mM47dWqCcFVHV0Lpmuq70vLRx2wiSADE2MRA98STCmpDulBXD39zzk?=
 =?us-ascii?Q?7V1aElUg9TSD6a2geoRgySK0B5peoMInk3G+DnOj1rz37l6U3n6tpuU9jlNk?=
 =?us-ascii?Q?HgP4Yp+VdEZik+kyk7/ws2UBYzI/9vWMqny0kiZ8S0YX7axpi97mnilxBQX7?=
 =?us-ascii?Q?q8edTu1jNjxuVs1ldnR72fApQ4y9RLiNHbivw4OVI1/km5Rfm0p6ZYIkbNDT?=
 =?us-ascii?Q?TbOl5bT8/tVBjZPA5ZZEu1n1SCsLzmatVXOzmkfvYSt1ZgvcBD4rFi8MJFaR?=
 =?us-ascii?Q?FP4hnJZjXH/ye63rRyjjyqL2+ZM8k+lYcHfOeV5i4zruTNJR+OynvA+aqR4H?=
 =?us-ascii?Q?ARjtd25yXjehljfqZYPppGZTxjeCmynzH3mLOJ3n?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1361ad01-cd8b-45d5-f097-08db7d30083c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 08:15:45.4955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OaH5i6tuQb4CKp0LZVtoBxB5uWrTfqL0hjmpSoYgwP8PW6RFkB0XB7vM2VGX+Ja+WrFoj673huUDJzWCJv53g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8800

On Mon, Jul 03, 2023 at 02:58:33PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 03/07/2023 08:54, Geliang Tang wrote:
> > On Thu, Jun 29, 2023 at 07:43:50PM +0200, Matthieu Baerts wrote:
> >> On 29/06/2023 04:12, Geliang Tang wrote:
> >>> diff --git a/net/core/filter.c b/net/core/filter.c
> >>> index 968139f4a1ac..e439f8b5f203 100644
> >>> --- a/net/core/filter.c
> >>> +++ b/net/core/filter.c
> >>> @@ -11587,6 +11587,24 @@ const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto = {
> >>>  	.ret_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_MPTCP],
> >>>  };
> >>>  
> >>> +BPF_CALL_1(bpf_mptcpify, struct sock *, sk)
> >>> +{
> >>> +	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP) {
> >>> +		sk->sk_protocol = IPPROTO_MPTCP;
> >>> +		return (unsigned long)sk;
> >>> +	}
> >>
> >> How do we ensure such modifications are done at the right moment? I
> >> mean: we can only change the protocol ID in very few places, before even
> >> creating the socket (__sock_create()?). If we change it after, we will
> >> break stuff: tcp ops, security labels, etc.
> > 
> > You're right, Matt, we need to do the modifications at the very beginning
> > of sys_socket(). In v3, a new wrapper socket_create() is added, it's the
> > right place to do the modifications.
> 
> Thank you for this v3 and for your replies: it is clearer with your replies!
> 
> I hope such wrapper can be accepted upstream :)

Hi Matt,

I just sent a v4, adding hooks in __sock_create(), instead of adding a
wrapper. I think v4 is much more acceptable by upstream.

> 
> It is then important to fail if bpf_mptcpify() is not executed at the
> beginning of this new "socket_create()" wrapper. Will it be the case?
> 
> I guess the verifier will make sure bpf_mptcpify() is only called with a
> function having "struct socket_args" as first argument so "by accident",
> it will only be bpf_mptcpify(), right? Maybe there is a way to clearly
> mark that bpf_mptcpify() cannot be called elsewhere? Or make sure it
> fails if the socket has already been created? (maybe that's something we
> need to ask to BPF devs)
> 
> One last thing: in your v3, I think you restrict the conversion to IPv4
> only sockets, no?
> 
>   (args->family == AF_INET || args->family == AF_INET6)

I updated this in v4.

Thanks,
-Geliang

> 
> (and I guess you saw that the kernel test robot complained about one of
> the patch because the new wrapper is not declared in the "include" dir)
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
