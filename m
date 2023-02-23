Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D1B258F
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 13:34:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fh69fvRwWOmlejgft89UJSg4f6kT7kYkztGKmzaCiUshouEgEyTkHlextB+tnjS8pmePoPZipVyezRGQWDeL+1+at1MSkYaJBuJFm3OhcsnQuZMFvXbBbwNij/c/KD10RZ25Vo25C0wshJv0QddKPgvbhpUvhmmA1VPmHp7Lk23JxcB9BmebsRuPkcpYQDJ5li90Ms/07wrMyHPKz7+RMRnRKI8fb4o9BkEXRCf19Oy2JqnQluLWkwXf73YiWpOHMNu3TAb1o5rJEXcknY5AuYQus4SrUwP5VqZXeWcqba8Mv4Bptu+WipTTxdv5TUFiLsx7PTe3Vb2z17QOw+MH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqAutQzUcRvs5hPMH2LYaJP019ZY6xyJFiUoZAO7qmU=;
 b=ipJGT5X5Uz35ls+LG4XACHLmB9+f7NfpyFlZeBh/IkDTMYJ2rQDPQkvTaebxRmThDD1ptzJwifx3EwZjpVe+CQ7hZ8iYi85BKVyCGIv2pbhwE5H/qE+n6IXfMFMOkcFa9oRe3aB7jFfeH2mhhtmCEWw20P9NVwetQOtR72McDIiArS25zyqU0YZhEY4JExtuhz3os+oA4eBcuY4dzz2wiTjToVIFhqM76BZs5oKbApSN7FNn/ZG+GwLFBgTA/VHR03g+9hC9mDfLz50JFsXNQ69e0PWcQ4M8cxfub+EM/d/NNg2WuHT4765GreGrCs8idPZ4HpwwxMyoeQmmOUCfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqAutQzUcRvs5hPMH2LYaJP019ZY6xyJFiUoZAO7qmU=;
 b=CU0vGodE2hXuQkZ/9u0rPY4h9gQQEADLdMSB3x3COPCsvrT+55U3tEiW9CIA/vfx44HN1/DubXvpdPJyXMrCsvt62X4+/G3W57VCxXpFJ8X0URQRjYLuNf+aJfjPCOPjJREOFc+K9su+Tm1+iy7Da/brasNxvXYgL68MQv7NCew5AcCo+bWs9hRPqcc4ZzD4zGbTGiEqwIJfzXIB5Na1YDJQAVRYXk5hHpFEnAwHes0+mgHOtmeVN1cGQu72DiL1qmvwK3f2/wyzpev2U6kj9IXVmZiLvgujDgta8ZU/YOCN+aTiduDIUFlrAlhKfwbp0zNztCpOXCilPGxd42/HLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9379.eurprd04.prod.outlook.com (2603:10a6:10:369::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 13:34:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%6]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 13:34:54 +0000
Date: Thu, 23 Feb 2023 21:35:58 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: add ro_after_init for
 tcp{,v6}_prot_override
Message-ID: <20230223133558.GA2878@bogon>
References: <f2d3a14b9382645f8770ad6496fcba6db699ad19.1677123443.git.geliang.tang@suse.com>
 <db64d10e-3887-fc95-a91c-33408e3670f9@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db64d10e-3887-fc95-a91c-33408e3670f9@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCP286CA0216.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9379:EE_
X-MS-Office365-Filtering-Correlation-Id: c31bb393-805a-49e4-581a-08db15a2bf71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lQR4vvs8YB86IF2BbDNgmJGp2D38zUhWNJBMAJ+E/cGZ2F7GmfrHPkzkUhJxvlJ3Bj2QdlZ+MV5BBN0ZPu5t9//mE6+r0UaVCsSqC6lS1lWF2uqWJeb/E6WH4gf0zTmvXis7rQzZvkEEXshwzTd6p0m4nkTCRknYZzv9sbySuysj74x1wtKQs+MNKWxHLXikfr1/R42jsLY5M7YzBC3EF7Nnz8kbBcUtfo95XBTWiKmwUyYH+8AM5j9JUsweoRKqrFIq+/rAnpNAyD2YGlKoMqegog95eceE2p8XwPFLnOmlhfN3w17uCUwm8q5WM6sD9pQRSJhKxyAKY+yegYX3PRVpMOb0ZZB2qPhwpX+hLOEXtfTiTKYCyoI/boGCaxmtZlzIzcGCfPbJcjMQAUGatJZkqSspkXJWH+Gy/0ST+WbJBTCFhplu8sX2RRvv920k4Wi9dKNxxl+v1MR+CPsOFRE12JpLFOBDefcRVniecBIZ0zYLSzAr29TMfRCkmH0lq6auZ7lwou1vo4evqMPyWrQZ4BVRURwj0LYnM20LMQ5WkRxb6Or6N+sTYfUcehgTDXP4CIfG4GgNI0zhHWMb+y61yoiZ6X8rz64U2WNmV0mgEmERunjbjPfOfiWWNGdjN+SMR/B8eoiBpMRbqTbilu0X4PPollzKxYk9g5BcGT49RHkXIGlvGdzLQdnfl9ZQZAVzIRybJj09W8kVd9ceJw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199018)(4326008)(83380400001)(38100700002)(9686003)(8676002)(6916009)(26005)(186003)(6512007)(66556008)(66946007)(478600001)(1076003)(6506007)(316002)(66476007)(33716001)(33656002)(86362001)(2906002)(41300700001)(15974865002)(8936002)(4744005)(44832011)(5660300002)(6486002)(53546011)(13296009)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oZ3bmluLy074v8D6HBqgCj3oHCmWJFGaj3AdJp2DpG5Aw2r9Ke5JgW3URSiK?=
 =?us-ascii?Q?QqsTmrO6l+QqMLpCiGUQKW4WlJTYH8NVSQ+h6koj4hgtrdhb993gx1j6dJdc?=
 =?us-ascii?Q?aEpcwQmsnkjwo39hEN+QmUv0NL8tCbG2D8Fw6gYYllTwjqpWaBScKw8CQ0Yj?=
 =?us-ascii?Q?G6wz6yyhAjky1H7braLglaDemLuThfNHpB7D/cMLfFvi+GtW2DLMWZ0g+4AG?=
 =?us-ascii?Q?tUPFthHLBnNdSinQEPEfOgbb2cZGBxUliHam62zGJHZOXANcx2gYeNQhYQtm?=
 =?us-ascii?Q?lUR3pTmO6v71uBa6Eircp5x1NB09h6B36Z2hEckdJxx2Nu19No64bOG0249j?=
 =?us-ascii?Q?cou76Ap/dlENig4PjxiLH1gQJQ5mUKBsFYlvgCB4kXL65mFcylCm8p+FrUaX?=
 =?us-ascii?Q?7rbIwkx/spTBdZlFxkqMRLEql28IYR4HQ+7I/HWUhDRCxjKtbxvJVGVQKMZK?=
 =?us-ascii?Q?1zc5l3WHJWArVur3jiFmw+aMU9IRjtPQhJ6EIcLrdHB2eTj03MKrdjwkiWVR?=
 =?us-ascii?Q?JxUYhYyAmY5t8ugjyiiJsPhXP6BPfjrMiGHK8H+48cj6/KkWofResNz6QfnF?=
 =?us-ascii?Q?np8nNtkwjQodP4L3V9sQC3SlH8udQMb/ipZw5MtTwg74MPeBNpTXk4zvF5fc?=
 =?us-ascii?Q?QusGBbAI4wpYHIBS5RO1Eujc7XPyf/NxxIfJM4jekRikrySi8OgzkDE/G+/j?=
 =?us-ascii?Q?Xk6ZBX0eLDYx39F/D32DcwEREg0YK6di4RrTWR3iCH53LcSi7tHXuC7M6ZoP?=
 =?us-ascii?Q?8s+fEh0ONMeesyBLKY74aGBcYvJ4KVa9c0WgMAlCYOrug1Wk2X94ApUk7enN?=
 =?us-ascii?Q?aR9EJuJjxu2Rt0ySnKUH/A/kIszreSAtxOZy2Gk+Q5EJj1vN5xrHxq4CAP8e?=
 =?us-ascii?Q?1yfo+PIlmv4tDGu9TJMrUkWoVljpyXC2J/WUc9NaG1seDh2twrVlAItCFdGt?=
 =?us-ascii?Q?iZH7mesg3x6EhrbgGBK6nD6nv4nv1XLsejPTLJ0MGzZCT2MOEIqqiI/k+KNE?=
 =?us-ascii?Q?6IzEvOZQrUI43+u1ih+zzCo65glg+zX1QVhdA1jekUkNthfHW++RLW0tUlLv?=
 =?us-ascii?Q?Nxzf6qq2f/fLJuCj6b329cWnbzDd5/PNkaFh6AWmsOWsB2KzSi6Res9nzFLq?=
 =?us-ascii?Q?/Vh3hUT+089GN+Ik+kTupmc7J05jJp5xlHlDqE5qOiENhapQGPYhQHTWY7a2?=
 =?us-ascii?Q?y+ZpXkAZRHRmVEVALDI9bd07Z+Tv2Zq2DLVmn3/s1rDEPtqxb29lc++pdi2H?=
 =?us-ascii?Q?gIY/T7lyfryvsIjFmVVZ3vG2gLg0Fr79HD0XRfgy2GVigVziPakwBWG7O9oF?=
 =?us-ascii?Q?K4vFLJUaTb3HPwR5vpf2KZLTxoBlSUGdElGx1nWmQl5cwfKNa53RxOaKHcuc?=
 =?us-ascii?Q?KaBYlKtBAEr2K2m3EWyQtva3sDjBdMwPOuDn2h7XTjIEaT26dfWXDuzbRyUQ?=
 =?us-ascii?Q?bM3XoJgcJrFLnF+bvsvgAydlBmtz2+YhehE0+s9K7Z2H1Ba1uhVczMKsQmAh?=
 =?us-ascii?Q?nPFyAm5HGgwbz60yctDZ2JtswQ2nQ/EwnUIewGY3PUoAUi2pqx0nCQ+uS/3m?=
 =?us-ascii?Q?VKKs5mxFSJ3fXbW613jOMnf9QhELEbpdtPkyUepgwRyrQglYUw85KstwnTbd?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31bb393-805a-49e4-581a-08db15a2bf71
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 13:34:54.6787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Px6QS4UuumclEOC7f3VpfhvW8e99IOiPHql0sTY6f4Ul5Hjoxhcgl6ItSloD/ABdXv0P2dBbKyhwOAQBgRdB7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9379

On Thu, Feb 23, 2023 at 10:10:25AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for this patch!
> 
> On 23/02/2023 04:37, Geliang Tang wrote:
> > Add __ro_after_init labels for the variables tcp_prot_override and
> > tcpv6_prot_override, just like other variables adjacent to them, to
> > indicate that they are initialised from the init hoos and no writes
> 
> (Do you mean s/hoos/hook/?)

Yes, it should be 'hooks'. Please fix this for me.

> 
> > occur afterwards.
> 
> Good catch!
> 
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> Do you mind if I change the target to mptcp-net and add a Fixes tag when
> applying this patch?
> 
> Fixes: b19bc2945b40 ("mptcp: implement delegated actions")

Fixes: 51fa7f8ebf0e2 ("mptcp: mark ops structures as ro_after_init")
Maybe this fixes tag is better, WDYT?

Thanks,
-Geliang

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
