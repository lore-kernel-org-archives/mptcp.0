Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A92568
	for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 09:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645434322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NDnYrDanfzu3UpumnK+TRWINuBbyEzVeEXSO7jMVIgY=;
	b=HLBQP4vNp6AeKH7//z/E016B3ToYsDdWcvrKdx3e110D5ejBF5cJBGQTriHWvZvwtmhfk3
	tDYaQmoN9CzIo3jAzECaKCDgzm7YaFHUtOn5q84QwGZDfgcD0fT2AGlwK6XStr0xmjl3L3
	Yl4EsJECcNVG8npig9S2nQNkSexCk/M=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-wNPZ0PtAMWqlX7iI8l154A-1; Mon, 21 Feb 2022 10:05:21 +0100
X-MC-Unique: wNPZ0PtAMWqlX7iI8l154A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXfFTHKvcAJgyoAK80sAytBdT/geOuiWYpm10X2j+nJdc5TIxMrx6EAzW11uScqrNrby4aRZmyZ92l2Iti7WF9VLl3rg0OqHKN9kFixgj4jSG12Fyx5va6eTWvY+viTMcyaQe+/rL5F6aikY103pVR6cZHXNB3qDra9tiezK2kQnL54aTwQqFSwNbH+pgSf1ITcYOWTuxHB8xnVA9ZRgBjMhddvZGdTAxmJ3pzmu9TYyEn7wdK5tUNJmgrf0Y1m4op7NAxSppkKxyHKO9czr/yTz+47OwakuDz0RZoiUsTm+ZYK3TPUqCvnkBKH233hY8DaXZwwf8N8YXhOs2w1IjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDnYrDanfzu3UpumnK+TRWINuBbyEzVeEXSO7jMVIgY=;
 b=FDeXJTACqTDZhZ91lhE88HQ1t69TIA+2p3a0J32CImksa9BIK/rYZPBDrweD4l/r4I4/Mj4pX4HsZOxTqQlznxrxZkxREGNNBB5y+MZifJjhJwo0A8mL8Ba0C+tG/dhNzZCwNXKpv1BmkqXV40yAu3mewkyWF4K5fIFXifRJFCSA/tA82FwdC+XnIqvdHaEqbtGDaCavICbkqwNKo9NdpCCv86qcRL5em9QVrWYdirZGaCnxdyJSRtyZ1WUbMXVs+Uxq/I62NcEAPbFPCug9BISDKmAHVJkrFxTCFrMrm2MDp4YZhBJoou1okr4YVmP+OLlR/j8fRCqMf5gVKddQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2262.eurprd04.prod.outlook.com (2603:10a6:4:48::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Mon, 21 Feb
 2022 09:05:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Mon, 21 Feb 2022
 09:05:19 +0000
Date: Mon, 21 Feb 2022 17:05:54 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "bpf: add 'bpf_mptcp_sock'
 structure and helper"
Message-ID: <20220221090554.GA4912@dhcp-10-157-36-190>
References: <8b35b6817474d6b5ea0a3e5c8be617af6d130867.1644491001.git.geliang.tang@suse.com>
 <1f8efee6-d9db-8779-14ca-65d744b5991b@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f8efee6-d9db-8779-14ca-65d744b5991b@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR04CA0138.apcprd04.prod.outlook.com
 (2603:1096:3:16::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baa9665e-58fa-49e1-5927-08d9f51948e9
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2262:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB2262D41B66F75684586FA1CFF83A9@DB6PR0401MB2262.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uH9M6uGe45JHTP/bDB9D0ixr9xWg1Sg8xaB16AeEBshKr+xgf2Nl8wr+RBT67g/SYQNnHGkXJRItBqHP+MXgczOmTJFcEURa132ggYjeI31O4KU5GUz2zAVQLLevaUYrpfV+4Xi3jmbuBsiOWlM9hBgA4Q9DhHMpVbrc9RO/fcOP3LbaNuq+ztF5jRthFu6iFRHiOGXUatxHYNi1my/FRFuZM3M9Z8qZDzAIJFuSiYuAz/GL6EcxvlZcx+7vKZ0NxIoj2nlOPi3z3x4/w19ktnlaiQukb2AddVoJdohJJxGSR0XK78UVkf8kDJCyeF32BCAHSZtPR8S5tD/7OCmOukYkYizaXArNSWodxGmB+f57mQc6eFdy2AXRcZHX/iRmrYDfEU1RMNo/3evqW+ZsDOZvBZC1GHdz56vep+ha/DPe4H2jdt45etTPQXxxypMgshEXlk/4rWZvL5sXgHJMqs2TiWsXwz+5qzJQalR99P45j03nr57ORuhXQ5LgA9DTBmKHVdkrIQEJWvaHMft0/r5Q+4AXmspQ+bFEUEdXWf+6oGHSppSu9rUTbU1if9e7mjD50I7VoL7J3MlptFVNvTVMeIJxbV5RJ7We/aaAbKn+wpNxlSeNVBKbFYU0QpanGDAT3MD/s8V67+FKSj8ymdB5ymgsZoM9FFb1/5Mv1E4lU7RgZ6h7vxV3fgH7rkLgLe6hRY7bQNm/JA15QWYYOjRHD6BrGTunTEMGu4WPcXU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(38100700002)(66946007)(6486002)(66476007)(4326008)(5660300002)(6916009)(316002)(8676002)(66556008)(83380400001)(33716001)(6666004)(8936002)(44832011)(2906002)(1076003)(186003)(26005)(508600001)(966005)(9686003)(15974865002)(6512007)(6506007)(55236004)(53546011)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f4aARgMKAHCTxhgXFBH+tV/O7uBtRASJgE/pYXGn9V/05OP6FZUIEaRbPSzl?=
 =?us-ascii?Q?z0k0L/+4TZgLelad1y2E2/7hWdWb8eI2mhQNIyVDfwU0+TzctP2GddoO8zmn?=
 =?us-ascii?Q?LqZYsc9l+WsTEnj+diOVE4M/1A638L43DFWPBNXWRKSgrH7ha/tVEuZYN38U?=
 =?us-ascii?Q?73T+ZPc+c4AZ0qFFXuH0ccdzrBtp+8Z3pFFFRJgT5FyMS+WZhI8Kx+dcehs9?=
 =?us-ascii?Q?0uXFgr78xf8JeENY/x0SilDcnn6O1CZBTBt1yAh2wy4sKEzjDgP9rM3+5Wkk?=
 =?us-ascii?Q?mj0+oaMhB8BkfHHt+aaS/Xs27EvSZPvgRKQKXX6/sEkRJqtCLsuynITIR28S?=
 =?us-ascii?Q?UA+9FX4O2CGQUzW7kITz7mk/ixjUA3iaviubGE5Zrbe1bO7xzRzmuiMxgjpP?=
 =?us-ascii?Q?WAumzw0r3AHIJ0654JPBk0Z284cF0/lCGEkNIttXpDMHVlBd6rcdaAZGrdoL?=
 =?us-ascii?Q?jCs+xlyAuEaFolurK6RixFVn8jnEQrLeY6gxtaaF5Yjkl/9Iw9R/UBtiTHnI?=
 =?us-ascii?Q?CkUMKnAELHSNAJsFCzs2kFA2YCy1PtGqLBKSfB8BG0LhEwt/utA2jA8tjCet?=
 =?us-ascii?Q?SAJYfARIGS0NjBiCL9evzidDbM4BSfmYaUziZzNtLV7WmgNMg8gACfNfmJPg?=
 =?us-ascii?Q?COn1dQkugdjfYdE7N5wqj3ju65I1VwSwcZYbRqv6lwg3iiQM2xMQU4tHBgOn?=
 =?us-ascii?Q?gUU/azpv/ADT4N2OyDO8hrIel92SY5EKaSArBfxp9eUjq/kmS/mcxvbVdpCB?=
 =?us-ascii?Q?a5EyrUvXNbXvyvbgYbWRccmU4tYZpCxSdARhvKAcUGxiES5+BdjBspKPEEyH?=
 =?us-ascii?Q?GMemqNnHyJLBtsslpYrv2wecDNbeDc1BjBF09HP+x+jFQFbm/Bn+w2nDc1Zw?=
 =?us-ascii?Q?sRcAFc1/uszsJnM5XBApeXDem2iCZO4qjRXLBx5+Tn+fbbXBzthQ31+qOe0G?=
 =?us-ascii?Q?PeLKFNstjvVwCOPQVYrOFXqPStRPBYLprqC/93LylR6oBQ/JdUy7Tdo7b/jr?=
 =?us-ascii?Q?YnT5wSkH+18Q3g2izoDZHZbn7lc+weS1/6q8t4/rHR6jZpZQBM4BYOc1+ZPJ?=
 =?us-ascii?Q?kx9AHXUalACawzlF5zmf0AZ/+QRjFqF1RSKFq8BfvlVB7ilcnx+zgq6CxM6+?=
 =?us-ascii?Q?LnqW976oopIOx+XFccCOyBQzT7wk134i+OAf7T/hbPjDpu5JWad5YESMgFLb?=
 =?us-ascii?Q?z0fyaJgr9tnM+fEAAqMUnkL4rM/rqxDdSCVoKT1a6b4Np7HnPnSmxbj4xcCa?=
 =?us-ascii?Q?m4fYcOdVLezYLA8mA4+6bL18BpTziEHdCXRsCMfS7FuJJYahmvF6NAZicMMG?=
 =?us-ascii?Q?wAUrhW4PyF6zFfxUahc0DwKnpSoWA4nLIK8ID/J1Su10iMBer1GW5N2wLIDw?=
 =?us-ascii?Q?yesFWDeNZySjuJ782rsS+9QWO9Mndq5RpOxM1A8zHtK+UufXqn/MlliZP1Sl?=
 =?us-ascii?Q?kmh409v1O4FtscNUb3hnVAR5KKwiGh/MFTep135hzET8NoUb7XwpW4xRbNla?=
 =?us-ascii?Q?gZyvX7T25Cqd70jq2iZzC3atGHPIvRaJQ7MI9XwFaMQuhoO8ZnSeRYG8Wo1m?=
 =?us-ascii?Q?BR2hrNMAUJI7OXrXqqPT7XGuSq57+UhOlACknacevVYJcv+KptrGboCGO2EY?=
 =?us-ascii?Q?8UjkFHcyvWrP8kj1cuXY98c=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa9665e-58fa-49e1-5927-08d9f51948e9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 09:05:19.7594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2xRetPgf6slZP1ADQaYt7RKqbkbCkgs99/duL15nlPE8T9Jz/qDAQPZoV4VQ1etAixb2enEvPBeeq0jXFisyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2262

On Thu, Feb 10, 2022 at 01:01:43PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 10/02/2022 12:03, Geliang Tang wrote:
> > This patch addressed to the comments in [1] from BPF maintainer Alexei
> > Starovoitov:
> 
> Thank you for looking at that!
> 
> > '''
> > On Fri, Sep 18, 2020 at 02:10:42PM +0200, Nicolas Rybowski wrote:
> >> +
> >> +BPF_CALL_1(bpf_mptcp_sock, struct sock *, sk)
> >> +{
> >> +	if (sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk)) {
> >> +		struct mptcp_subflow_context *mptcp_sfc = mptcp_subflow_ctx(sk);
> > 
> > Could you add !sk check here as well?
> > See commit 8c33dadc3e0e ("bpf: Bpf_skc_to_* casting helpers require a NULL check on sk")
> > It's not strictly necessary yet, but see below.
> > '''
> > 
> > I added this !sk check as he suggested.
> > 
> > '''
> > I think we shouldn't extend the verifier with PTR_TO_MPTCP_SOCK and similar concept anymore.
> > This approach doesn't scale and we have better way to handle such field access with BTF.
> > 
> >> +     }
> >> +     return (unsigned long)NULL;
> >> +}
> >> +
> >> +const struct bpf_func_proto bpf_mptcp_sock_proto = {
> >> +     .func           = bpf_mptcp_sock,
> >> +     .gpl_only       = false,
> >> +     .ret_type       = RET_PTR_TO_MPTCP_SOCK_OR_NULL,
> > 
> > In this particular case you can do:
> > +       .ret_type       = RET_PTR_TO_BTF_ID_OR_NULL,
> > 
> > Then bpf_mptcp_sock_convert_ctx_access() will no longer be necessary
> > and bpf prog will be able to access all mptcp_sock fields right away.
> > Will that work for your use case?
> > '''
> > 
> > I dropped RET_PTR_TO_MPTCP_SOCK_OR_NULL, use RET_PTR_TO_BTF_ID_OR_NULL
> > instead as he suggested. Drop bpf_mptcp_sock_is_valid_access() and
> > bpf_mptcp_sock_convert_ctx_access() too. I tested our case, it works.
> 
> Is it OK to let access to all mptcp_sock fields?
> e.g. local/remote keys?
> 
> I guess it is fine because not everybody can access them but it is
> certainly impotant to check :)
> 
> > Now only one comment from him I don't know how to implement:
> > 
> > '''
> > Also this new helper is not exercised from C test. Only from asm.
> > Could you update patch 4 with such additional logic?
> > '''
> > 
> > Please give me some suggestions?
> 
> Is there no other selftests looking at tcp/udp socks?
> 
> Also, do mind looking at the "userspace" tests Nicolas developed to
> check nothing has been broked there too? He pushed everything there with
> a README:
> 
> https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/bpf/examples

Hi Matt,

Sorry for the late reply. It took me some time to run this userspace
tests. These tests still work, although there're several building warnings.

We can't drop RET_PTR_TO_MPTCP_SOCK_OR_NULL as Alexei suggested, it will
break this userspace tests.

So I just sent a v2 of this patch, only do the '!sk' check in it.

Thanks,
-Geliang

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

