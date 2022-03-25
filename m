Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF6546BB
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 10:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648203651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OXxs/IZQyb3U4xY8SmMV4FYWDj8wiWinvglXimDRXF4=;
	b=BNJNrPIZFSZ4Rz+Moh200GOiisOYxokVynQ1w8WufTXA6YXUiuRqdTrrKuWvEcIhLJkjXn
	3sYRE97SEnQfaESz/5O288kITn1kPkZYqtiaudz0jaomE7YthWROytK7RpeAYi0Ilz+aP6
	fBTC34RYXvuraN78eDm4BD7uEuZr53Y=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2053.outbound.protection.outlook.com [104.47.8.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-fJmyRKNDNU2NS5Duf_Ketw-1; Fri, 25 Mar 2022 11:20:50 +0100
X-MC-Unique: fJmyRKNDNU2NS5Duf_Ketw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1QoRXavoyHLmECqs2UeXOXADlnc557WCoj2/gKLqr0a3R90IZHJiI3/LCne1XLa6Yvn6+3w+lQgPKYBqUPcNBBRTAgOlcxNgzlzGtptCtxxP5eHSHRD6p39GJqLseOjo5aSqko/HqFw51GxCTW7J60eRtJeknQf2oJRcf46O0hl+JXPL+76bv1dh7bcFGqIMvWd3SZA5uHIQQM1wnWQJjx9DwL9T0EpZI8V015Zywze9ex8TQmExKL2TbdUVIuIjpgIT9BauuGC6ASKp6UVgTsxNUEj0MBsNpum7qIcpppAw+xxeSs51b+CrQV+xfqUGw1gPt6b36DKvTzrpcmbLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXxs/IZQyb3U4xY8SmMV4FYWDj8wiWinvglXimDRXF4=;
 b=aLXV9HxmtB3qUGjkTUr3hMTk8Hg7XZnQHroeegZ073UWMucK4z7VHr6XIUxx4Ky67nm9c9QbvlEH36CHtTJpmlVHDYoltOvAHXuuivrZNGqCtZVfMG8+/8tYVPCp8HN9NrvegkJTbWqjne0HFHOePY/EmpP+r84jEGhwVgXzIjyvmDoLjsunFoRnaVBVTVZMCdvvnOYxsRy0tam+C6TfyrbemLh3tUd9OeCTXsqT3GhL0ge/xDqNjMfMEYvWtq61TC9vqYJBEtS6Y8esWDe0q0a6qXXG8qGbOIzKfaXnP1JcsaL5q3Lcyw3jIDPtajmPjYspsTnJ+j78DxmwK5pMeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5714.eurprd04.prod.outlook.com (2603:10a6:208:12c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 10:20:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 10:20:48 +0000
Date: Fri, 25 Mar 2022 18:20:55 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v12 2/5] Squash to "selftests: bpf: add MPTCP
 test base"
Message-ID: <20220325102055.GA11225@localhost>
References: <cover.1648128255.git.geliang.tang@suse.com>
 <3fca1327933734f25222c16e4fb5c473630e91ec.1648128255.git.geliang.tang@suse.com>
 <36294a41-8c56-0e96-8ee2-675945fb177b@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36294a41-8c56-0e96-8ee2-675945fb177b@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d832371-859d-423d-f413-08da0e492195
X-MS-TrafficTypeDiagnostic: AM0PR04MB5714:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB571447807554BD8AD4090FDDF81A9@AM0PR04MB5714.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hXgqD7JIjNl/KWvFkUL0oyhEGz8kluzZk8Bv0+awzYksxc2sjBdbKMPv6vRtsUkzi29kpYYXEsm3ONT7NDgdGCfBiSLuU7JF5tuKqH2ktxo2tsdtUiNf4nnZj6IyDH6vMIHR7MJXkLwjdgtTiAXbXr3th+Q1BU2/tkeSpehIZdqbR25WDh/Kw/FmoygAbHkbDC0P4hGhryHT8+YImUnoHJmvH00EXHy8B9TvydTmcTxLpAOr5sjujT8rD/LIOHCahIjr1VfbyiLiOCxVMxn1o+ELx0jsUThRF2tkBVlHjas/oEgelqSY04LHYI1A7F/43YqdRYzWC/LAAjKuYknUb66oQ6Rmf8OObumnaNUD2J7nLBcbTCpO1uOWmoLDZnP1dPAC1+Y6xzbuJviALQ1sz/ByhZT8kktMuHaeGb4onuBssCTs9wbZD6tc2qmmaiHKhyhRU8KSh/AT0fxhKsepYYhaziMyn6QRPHZXPQHJH5iOkHvj/SGreSGv2ITcSxB12C/7KA87t7IiI4u7SO0oe14v0E5Or1N6Zxll9sqMsf/iSWMOGu/dRbryZTNITJYwH5gELk2pIlJUaRGrrdgcONKa9g2WbHXOygbO9WvnxGWbEDbLc1Qyi7DgCZvgG1m8SyLmMS0CAxdQYjERouUp9BnsaDm4dsoct4I6UY2j/A7h8Kvg2G2VOQLDg1tVl0FVvaHwF6Kb+VduiR6Abw4yTioPuKsEmC5GXUaosNJgqq7zxEF2gQpO+xn0EgPBOyK72vLBK0+XWTS+MwAgh+GOVBMsDqdLKDQmWiXKW0Fa0gI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33656002)(508600001)(15974865002)(6512007)(26005)(316002)(1076003)(186003)(6916009)(6506007)(33716001)(6666004)(9686003)(66556008)(83380400001)(66946007)(2906002)(4326008)(66476007)(8676002)(86362001)(44832011)(6486002)(8936002)(5660300002)(38100700002)(53546011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VJpCemWKtERO/44iDPvmqwZPgiAYx1z372CMgR4FReeLpYpQRpyR2IGs1Ft1?=
 =?us-ascii?Q?zbCXnaD8n85ZXAnhaEK1frMhQJj3yLKxPVu1y9VpkH3NMtvJz3rlgoobkLaG?=
 =?us-ascii?Q?iuRcVteG1+S5/ywztbgFbty+9f1uPIC+zN4EnITAz+2jhX+FvB+cwI6izPot?=
 =?us-ascii?Q?/MvNL3Vy46dqiQkiMTe/7cfyHW7FLhFpwwWaCrXS+5w8XPyXJaiJwnVLE8yJ?=
 =?us-ascii?Q?7mKfDnEtIrI/PjLVxETV1wnEN42puNvTnZnEHAcA2tNbgSmROVSpZL8GAqNH?=
 =?us-ascii?Q?ZI7w6lDtH33Yx9dKrtkjnEkA3uVBo5F7lFubOhFl6AWfLMSF8jvT8HMBlpRk?=
 =?us-ascii?Q?oC2oHGevzDRMkVxrsPdjS49XZxLOEzkOVNr1vQANZcxkHqVH4DX05rEh1h7b?=
 =?us-ascii?Q?kHK7ERCuEXu+IbvRu3bBjs77kQQd4RuuZ474QHH7rtDBakbLzwXv1zOfV0EQ?=
 =?us-ascii?Q?FffxJi+V5J85viTMQxuougxBGTWEM0pkxiYdzNNXoCGE+JftDhPYGZ1ttLU1?=
 =?us-ascii?Q?qFonf/GgZP8jxJa2JCOZGQhLA3621M9eZe4cSOaPvsSnGamGFF6vNVVwO30x?=
 =?us-ascii?Q?hQYEUTfvTDxpR11pPi9C9DOA6IoEZEBwbFlCGyhpaSyylnMS619RNimnLXzo?=
 =?us-ascii?Q?i4wYkHRIMtwYUW0kCnHFunU3FCBhGKpww4y+skHnC60JE7Luhx32D9R7kYHC?=
 =?us-ascii?Q?afVIOFYLzNQmCjvFpZtxtdPN9Mw/f/PCjwjvGeq1smKIMqyf0SHRbh2fn0cq?=
 =?us-ascii?Q?LdexT1MRvG1bXfDsuzuA08M43LpYHCSg4sxX7IJR6j7B37YN4SlaE25VXxrK?=
 =?us-ascii?Q?uPmtdzy4RlTMg9AiKO+rPuapY4wB9FRZWl1TFfotLHm2BWrVCk4sCwX17+ey?=
 =?us-ascii?Q?toE+uGW7hPnY3yky0Adsc5y+qNHp+7GfkP9g41j9h2juccYbGsSSiFMoDgZN?=
 =?us-ascii?Q?PFIJ2B0qRMLfI0JefwHyWpKXNp+i2vPnhKryTYlah78RoXdSg3sNKScY0TJo?=
 =?us-ascii?Q?E+Yx1sRcIa9uU6x9pI2cIILlf/5HJecIKH6TDeVkKinlkpwmony2Dm9/ex3F?=
 =?us-ascii?Q?kAqo+/yS8rkHoybyVQ+DEQ8BI6KX9EspsVaSNXesE+nWAP0BTHz8HuZd5+IY?=
 =?us-ascii?Q?WC/fiNlPwzss18iyz3xyecqY3NOqwInVUoHtWTKyzw4xv4YuK4nozBOjfnV0?=
 =?us-ascii?Q?U5cZEt8ucPNN5hD7Q19bcYrvFMBhLzN5wcGQr6Um3WfrTpjeBy/ka1YckrT3?=
 =?us-ascii?Q?8D3gal8y5n9sJ2qjyE0455FU3Ss9ERTduPsgpCB+/+ayfet6lUhGfJolrKXq?=
 =?us-ascii?Q?b6lcn1NOmhwYsa+mimJk+yUR5Eb7h0S5Y9qJuZ4I6vT//cZxC/bpZNhjhYQK?=
 =?us-ascii?Q?LJoiywyX9Y2P10PgHNP4NyFeD1onaVTeM2Ta7eMBkYgKCGFOgax6SZ2ZOftU?=
 =?us-ascii?Q?wXqMottqqM2rZbrgYwyv3OrSxSAZQStTk/4fdKPdWHlLjndUkGoqLFipMS07?=
 =?us-ascii?Q?+fnazyW4bO7nVdjCGUUGAStjmquTBw0cT6YXPvy2xfKmGD7YFKxsdSbNKOUR?=
 =?us-ascii?Q?P/sIIiEJzXyEb7BBhAdakDLJ/hxWfQYPZ5/Ygv3qFm+hqDcq9IVqqE3iMdC+?=
 =?us-ascii?Q?2tqmgQcHz33d5ZFHp0xVITQyNVmHT7BcPIl6aMQTRDfe/hOM3Ax6n69sB3zP?=
 =?us-ascii?Q?aO/kCH7SNJxDb8igrFGkHV7kSrvNfUj9w8xyBGuo5OhVMTlKtwy9E/D3oYZs?=
 =?us-ascii?Q?T6KpKkySdoKF0HO+e0RbkRR75D2nt+U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d832371-859d-423d-f413-08da0e492195
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:20:48.6942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2H5R2ZBrRb9iwHdn/96riTpxjemZxMY8IBboM8ZV/VOtvGRYbwJ+C7cimxnkwVyzH6TYjEFDCicBx8s2kqLzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5714

Hi Matt,

On Thu, Mar 24, 2022 at 06:05:03PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for this new version!
> 
> On 24/03/2022 14:28, Geliang Tang wrote:
> > fix libbpf 0.8 build break:
> > 
> > prog_tests/mptcp.c:176:2: error: 'bpf_prog_load_xattr' is deprecated: libbpf v0.8+: use bpf_object__open() and bpf_object__load() instead [-Werror=deprecated-declarations]
> 
> These modifications seem good but while updating this test to sync with
> what has done upstream recently, maybe it would also be good to use
> macros that seem to be used in many places now, WDYT?
> Please see below:
> 
> (...)
> 
> > @@ -44,28 +40,46 @@ static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_mptcp)
> >  
> >  static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
> >  {
> > -	int client_fd, prog_fd, map_fd, err;
> > +	int client_fd, prog_fd, map_fd;
> > +	const char *file = "./mptcp.o";
> > +	struct bpf_program *prog;
> >  	struct bpf_object *obj;
> >  	struct bpf_map *map;
> > +	int err = 0;
> >  
> > -	struct bpf_prog_load_attr attr = {
> > -		.prog_type = BPF_PROG_TYPE_SOCK_OPS,
> > -		.file = "./mptcp.o",
> > -		.expected_attach_type = BPF_CGROUP_SOCK_OPS,
> > -	};
> > +	obj = bpf_object__open(file);
> 
> Does bpf_object__open() not take two parameters?

bpf_object__open_file() takes two parameters, this one takes one :)

> 
> > +	if (libbpf_get_error(obj))
> 
> I was surprised not to see a check 'obj != NULL', e.g.
> 
>   if (!ASSERT_OK_PTR(obj, "bpf_obj_open"))

This check had been done in libbpf_get_error().

> 
> like it is done in some other selftests but I see in other selftests
> they use libbpf_get_error() like here.
> 
> I guess that's fine but I don't find a proper doc explaining what to use
> here :)
> 
> I would still recommend to use ASSERT_OK_PTR(), at least to have a clear
> error message.
> 
> 
> > +		return -1;
> >  
> > -	err = bpf_prog_load_xattr(&attr, &obj, &prog_fd);
> > +	err = bpf_object__load(obj);
> >  	if (err) {
> 
> Should you use ASSERT*() and CHECK() macros to include the 'log_err()'
> below?
> 
>   if (!ASSERT_OK(err, "bpf_obj_load")) {
> 
> In 2020, these macro were not common but it looks like there are more
> and more used now, e.g. check commit 186d1a86003d ("selftests/bpf:
> Remove all the uses of deprecated bpf_prog_load_xattr()")

Updated in v13.

> 
> >  		log_err("Failed to load BPF object");
> > -		return -1;
> > +		err = -1;
> 
> I see some selftests returning "-EIO", maybe better here?
> (same below)

Yes, -EIO is much better, updated in v13.

> 
> > +		goto close_bpf_object;
> >  	}
> >  
> > +	prog = bpf_object__next_program(obj, NULL);
> 
> It seems more common to use bpf_object__find_program_by_name() just in
> case a new program is added later I guess. But maybe fine now?

Agree, updated in v13.

> 
> > +	if (!prog) {> +		log_err("Failed to get BPF program");
> 
> Maybe good to use:
> 
>   CHECK(!prog, "find_prog", "mptcp prog not found\n")
> 
> > +		err = -1;
> > +		goto close_bpf_object;
> > +	}
> > +
> > +	prog_fd = bpf_program__fd(prog);
> > +
> >  	map = bpf_object__next_map(obj, NULL);
> 
> Similar here: maybe better to use bpf_object__find_map_by_name()?

Updated in v13.

> 
> > +	if (!map) {> +		log_err("Failed to get BPF map");
> 
> Maybe good to use CHECK() here?

Yes.

> 
> > +		err = -1;
> > +		goto close_bpf_object;
> > +	}
> > +
> >  	map_fd = bpf_map__fd(map);
> >  
> >  	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
> >  	if (err) {
> >  		log_err("Failed to attach BPF program");
> 
> And use CHECK() here as well?

Yes.

> 
> > +		err = -1;
> 
> 'err' should already be != 0 here. Do you need to set it explicitly to -1?

No, updated in v13.

Thanks,
-Geliang

> 
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

