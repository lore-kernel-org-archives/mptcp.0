Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4677A
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 09:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646298740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=poH1ULmWtvobH7aABCQCz4GD02caVrgFV71Ca5KbjOE=;
	b=ABV7V8gQ5iCZGfr7laX2+cItudgjJXSz3gA5mtbkL+aAjsWWRKOBSwsLT/erlLbezAAd6W
	NltsBXOrHUmybDWcegZIHo6LlmoW6MzjIFv3c/DJ9HKp72bBtTRJ3tG7ktndvMaL2kMJGd
	bw0UrTa/+5Ack/TTTKnkXvU8TkTHeU0=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-9IpVg1qTMWSsiflbF6CEMw-1; Thu, 03 Mar 2022 10:12:19 +0100
X-MC-Unique: 9IpVg1qTMWSsiflbF6CEMw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJCAN1ZGVvZNFvlgdXcAg/GirsbKQXyrsILALljpRpKTvfWvY06cCie0HKSR0NlU6uC94HNw8yugzyVq7g0K9Wc5CQc3A2nwKfxTBqxs3PGGZaN1piStluBryH0N6uTlm9T48qWDfY+H8nQpkwj8pNcum7iLxzYhg0kJPWRDGcj5/T87O94p+TGCq+s1bsdQHbpHwO2iEOUZkIC5CvLtBCCKEVCWPPk/09BZ5qBNd2x/P0lLs0b38NlVs34/Pk73nGzu346aOKeH+FOxNj9ZYtccYmWCGcDeT4Yx4nFOiOo25HZjuPdJk9eCrDD8Mi0XXux21v9C9MjGwOzPIdW/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poH1ULmWtvobH7aABCQCz4GD02caVrgFV71Ca5KbjOE=;
 b=D5RBpNp/dubh8TojBTrUzylYHLgcvLMDfkLnaCzZrNxNaAWYxEc++tDxTX/gcqMNG8sC0cv59m5QPguqCAaYv03H0g0MaMImc7PA6Ja6umKTfzY3S5G+CY0r0+kMuJGOBXN9B63m7dAeNUSzGDEz9wb96kMVepBioUOyBWlBPRw6rQ0nEiwh5O3JkvK1TFR3v5GBaBdgCfT0MU+ThIV8b6OUbK5LiJJl3ABjc0Lcy3PokdCmP4lcuu7mQeGWXA2nZRvZVy6Vz5ZPa//ATmdeOZoRU/svGjoOjWqCGeuA7kAafnlo7Mg82lShXBhQYENuwUiEFjAAfFgimRFJpKNflg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8146.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 09:12:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 09:12:18 +0000
Date: Thu, 3 Mar 2022 17:12:05 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4] Squash to "bpf: add 'bpf_mptcp_sock'
 structure and helper"
Message-ID: <20220303091205.GA19132@bogon>
References: <4a1d63bb7976c1d61308a875132107e17272c8f8.1645519631.git.geliang.tang@suse.com>
 <f3d4da00-5483-7da4-8890-d40df6ba34f4@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3d4da00-5483-7da4-8890-d40df6ba34f4@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0154.apcprd02.prod.outlook.com
 (2603:1096:201:1f::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5f69e04-abd9-455a-ef6c-08d9fcf5ea6f
X-MS-TrafficTypeDiagnostic: AM9PR04MB8146:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8146E8644B2375EF108B5BE1F8049@AM9PR04MB8146.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	li+23PqdhERvaftsDM0seVLroknrlTjLni/3QYF+y6RMbVLudt0sriINVo1lB9vRiNXgqAg0tQ913l2OQ7nckCb0/2bMylqIOS8x9fel93wSfn/GV3atsu/AG3wsMippDKzGkiYZEQJzmbgqEnR/5oHHCugD+fc2UPAtfCdzH3AEU7qSANnoQtru0SsoB/FUfQ4Ycbm3P2AqwxjpayPdbRRUwDKoGDfZpDM1SrZbdMJr82UavKjB9r7VYsf9gDiq43l+b4M7fWkA9KkiC5mYIljBYXRmDfeVAAxtafnNn13KYQ6/35e8qLMPiNaEsN3NIawPHLkrucgCVdDENGqR9eFOdtVNaDA1PfLPPg5c7k+Q1CaUPXz5k9cWEEuu7nQAr9dW8wIxZdzxVlJI/zcW1Dmwgr9gNgFgXtKVXuYxUXHxwTi1yUM4DAh+F6QRXbpxDIzTU0J3xlIvWrBf1Bunx8AjrMgDQkZfrJi3od9D0Boe+Dj7lHvkhaewv+Fv0fodqVQOT2YAI5GijzuPOH5JbysX0NH6pxaxny72mxdw+q5D6barQ4LVmpiFBNzuyntKWQv6Al14vO1koXthXZyvPvpszn/aaDFBAxJZYKwvCa7ePEEJz/dEselOWqx0XALFYwlxPpIvwxGM5m5gHFZhoB8y8I4/9FUotmDa95vjYRW8azPTDXUJOXXl0/PjM7RSX/ZgBlqW+h6OkgwxmaweMsZOrnO56VwQv24Qf+E9jU+V3HHmcImfNYQFcpasd+JQMSCrNjweWSbNIpbcgKJGng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(8936002)(316002)(6486002)(66476007)(66556008)(8676002)(4326008)(26005)(1076003)(508600001)(44832011)(66946007)(6666004)(86362001)(5660300002)(6512007)(9686003)(53546011)(6506007)(2906002)(38100700002)(33716001)(33656002)(15974865002)(83380400001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mZykbEP2nP56P7JYP9Ech/OHFTX2S/o9IUp1uj64/FvB3fHIKDh7SxdWqIl7?=
 =?us-ascii?Q?qeTQ/gyXwlBs5/ujZzjDckdgfZMkepsIHGf8TFpjnDbtV1pKRute3oGbQJ2D?=
 =?us-ascii?Q?ItJCGI6P0kG5jFkc6NZMwyHKflBbpKud3aKC2zH/WioxVw+OZSOfQ0bZEz7A?=
 =?us-ascii?Q?p1FjmuTzin+e3W/cyRirQ5jfeAYmcvMpELwM136DqL+1iP8vLs1Na7j2UgK1?=
 =?us-ascii?Q?A7+v6MbeIV+ddSpQmW0BhWHrj7Kx5qf1/D2U1gJPN1xBGT/6yW7mPFN+xt6z?=
 =?us-ascii?Q?f8unOyCr1gKUiEnXFZpi5QUP9Ie6DgefZDKL+8KUkT3fox8xrE5B2rTbmK2o?=
 =?us-ascii?Q?sPdgM/H9cLiwVbQn2RJ/Ub4kMKg2VWeFAGPoP9kHTtM7hqIYQTbf1gtn3wko?=
 =?us-ascii?Q?wLHG9XQIKp/8bvCYWymWW8FeV4LrHQXeJpRD2p6zepbJmCcitkq/0uoyF/rr?=
 =?us-ascii?Q?RA/XBAvMGNcS+qdCAwFtvBE5YiaUL5GrKRn80KGSf73l26UnqN4bvoku9Lvv?=
 =?us-ascii?Q?+weRNB99rwx9XIFyMaAXjZQkHFj8Ow3D3hGPGC3zgCgeu7GhmxxyhKWNogsA?=
 =?us-ascii?Q?Y7b2ipqaYLSIRcqwddLSSrdiF9ZZvJ1jJVtuYywQMEwIFTnjMVynO3lHhe5G?=
 =?us-ascii?Q?IBbdqmhucHkr/D+jmEro2Z7ek3xBSAbKZlURgZ2WIUJBnxj2kAQO17SHTdQ9?=
 =?us-ascii?Q?25a7kWg/i1q8pq71FQ4Gi+FqF2M/ieB5PIqYrC0cmmqKiWJKeX+V1Rd3AHu7?=
 =?us-ascii?Q?cgMKYPhYD3eDR2rUWw4hdcRrid0CCZ9EfxxX/vQ/jKeWKRy33ymfT9hZKeFW?=
 =?us-ascii?Q?k4dbPDg3tBrCd3Jxq65zqqtaHEjeRL2xboIJvgUXwGAWPk5ZkhFpJi354ML+?=
 =?us-ascii?Q?WwMdwH07hVJCCAMSAfeiIQUuG6sIII4LH79buWYvRpXg/6H2xjSs+WVeD/im?=
 =?us-ascii?Q?NHgEXvLgMIMfv3DaUCPj/QzT1J5eWvVEBzwJQWZIGkWkmsWTTXBlVxeXBhgB?=
 =?us-ascii?Q?twuMxg4lqM0B1WQOMgH5JbdRvaRkq0KKLWhtAoBTvyhi+CwYSJWx1AmojqY2?=
 =?us-ascii?Q?BYJXiePVFM9gvWE9tP8BcuwwOW67+lYwt6vor7LMi/+wwmEy9HEr746pl5dA?=
 =?us-ascii?Q?ahnXC2xqciOrx8wjqTQxv1uTAcspKPxtEES+Oaq6DyPYlzr/wVDjKteON17f?=
 =?us-ascii?Q?vZQIw9RykWHqWM52r1qhuYGivjcdjk53OHH6TmcjdPM+dHLR4ERsaTk+kBgl?=
 =?us-ascii?Q?AdD1UERVvFmLubxk+l45QHN9VULd3t3ivk9AFVFsHAfpF82ZcqdyzpHUwn/2?=
 =?us-ascii?Q?ClfSgjvg1DlxRZST6DvBRcR8sI3SJk/YBpERsFqlOOfqMtzuQhx+kmq7oyJw?=
 =?us-ascii?Q?4o2toVl+6GdAsh5Z8l4/VLW4JwUSB//Pa75MoAPgIkavwiuaTUnJNPgWs/rx?=
 =?us-ascii?Q?EbHlhQWU3jzmcctUkEfKqXpIMNV9xdPwHrRD/3j29LNJ2OR6C/pV6aRA8Ta/?=
 =?us-ascii?Q?bL4eJ8R1yjALIROtOzCMio9eehHbnr8uSCYk3xli3vlLwYtiMWJaIq54cF28?=
 =?us-ascii?Q?V4a/HzlTxr4vlzJd4jqpJOoPmxmRkZtbpe37xg+RhKazlYeQdeGf22VzrAoA?=
 =?us-ascii?Q?XCwjES6u8D+aYdBIMZzdYs4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f69e04-abd9-455a-ef6c-08d9fcf5ea6f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 09:12:18.3308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMHT+oFngTMbbzHSy4hxFcBjCLJLuMiADHZuCmiIeBW23aFxgI5QhfwyvbZdU7i9PDsE+X/lsapc0BduTGI5Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8146

On Thu, Mar 03, 2022 at 09:44:52AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 22/02/2022 09:52, Geliang Tang wrote:
> > This patch addressed to the comments in [1] from BPF maintainer Alexei:
> 
> (...)
> 
> > diff --git a/include/linux/net.h b/include/linux/net.h
> > index ba736b457a06..9c1a634e5ac5 100644
> > --- a/include/linux/net.h
> > +++ b/include/linux/net.h
> > @@ -238,6 +238,7 @@ int sock_recvmsg(struct socket *sock, struct msghdr *msg, int flags);
> >  struct file *sock_alloc_file(struct socket *sock, int flags, const char *dname);
> >  struct socket *sockfd_lookup(int fd, int *err);
> >  struct socket *sock_from_file(struct file *file);
> > +struct sock *msk_from_subflow(struct sock *sk);
> 
> Would it not be better to expose this in include/net/mptcp.h instead?
> And prepend it with 'mptcp_' as it is exposed to the "outside world"?
> 
>   mptcp_sock_from_subflow()
> 
> But when thinking about that, maybe better to name it:
> 
>   bpf_mptcp_sock_from_subflow()
> 
> as the implementation is quite specific to BPF.
> 
> In this case, it should go in include/linux/bpf.h with the other
> bpf_mptcp_ functions (with the #if/else CONFIG_MPTCP you need to avoid
> compilation errors).

Thanks Matt, I'll update this in v5.

But v4 still needs to be improved. The token value is incorrect in it,
since bpf_mptcp_sock_convert_ctx_access is dropped. We should do this
convert in this BTF_ID mode too, but I don't know how to do it. I mean
how to invoke this convert function when we use
RET_PTR_TO_BTF_ID_OR_NULL.

Thanks,
-Geliang

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

