Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD767C
	for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 10:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648723245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gxr+aupegOqUEEIyyUjVQ+OfrdgeSEI5cPVxO1zUHaU=;
	b=d28jFt9VhIcSpv/UPESs3WVon7Jv+oQnKoAeSnacnO7U1/o+kJJaLgysfYTDl4mm0iASUX
	uEu/588HOher3qpMQPUZ1YJAZvZ0fqZnrAh8a4aatjTBHcfTP4ZrHa3k4Et8MgLNqRKjvv
	usPjU+UyDU8F3NYY8zwIRG63epLo0kM=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2058.outbound.protection.outlook.com [104.47.0.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-rtAfHwhBNBW12mIKwYeNNw-1; Thu, 31 Mar 2022 12:40:44 +0200
X-MC-Unique: rtAfHwhBNBW12mIKwYeNNw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmyYMDIkiqLeoe5LuL1Qthxx5cW58bedYhJs3vuxGU8PfmWQhDwuXFnwWBM6YFrSwm65pms0dxLKLUzvszOg5VqbNrppOkmoRmhWBPYR0YuGhB+8quqnTA9/fXkSWFzc9ZrgOoWnY7EqbYivjeKhVipBZYjgEHW4zGF6puhh1EMRLdqnEI48pbWMpP/0ff5HPXbuDkmOHWdUDylONCXHAD0YSS49ep8fkSAo8O9OT66H6wP1GWcGSJS5KgFvPfd+nB6IAHbWzyGI+WQukqE8ZF/w8/ikaWWXG2y2iS/UQ1P4sULsmaGM8QWAS5o0J74L2lxoAZVpu8CvyVrG9llAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxr+aupegOqUEEIyyUjVQ+OfrdgeSEI5cPVxO1zUHaU=;
 b=c5MhXi4RKYzS2fX/6UHFaeN/67/rNP34cH7uK0avYPvh6FUJWZ2AkTLfOBbIH417A7HOw+k+I22kUtvjT9IMo0Ea5nWtd7aF71HF+2uFbhlSM4obNzb2HEFG0ld0cpBtyLNKNJob1i7Gft74Vk3zMG4o4L9YrYdGNR8aQ7YIeicFMNzcUaiVXh89j2x15WsIzA7KV59jRKBtkRyWB/YsnmTCh4wXM1hwwxGf23LyM2clW63xNFJ/ClM7xT4dryUjLnP+mmYuvSTV0Pd+UJDVOeHMv7D97WBvtR0gu9XTBif9OkyMjaG7dQ9XLkD4Fx+5KNJBRoYgzek2fyvB/8gGxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB5405.eurprd04.prod.outlook.com (2603:10a6:803:d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 10:40:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.023; Thu, 31 Mar 2022
 10:40:42 +0000
Date: Thu, 31 Mar 2022 18:40:51 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: bpf: add bpf_first
 scheduler v8"
Message-ID: <20220331104051.GA22988@localhost>
References: <e6bb3c020929be2e6a41ef994e740eafe7fedce9.1648714973.git.geliang.tang@suse.com>
 <7fb77cd5-4d97-0697-d88f-f20348a79347@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fb77cd5-4d97-0697-d88f-f20348a79347@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYAPR01CA0144.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 070a7820-26a0-4bea-f05a-08da1302e724
X-MS-TrafficTypeDiagnostic: VI1PR04MB5405:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB5405763D75BA2731345BF3D5F8E19@VI1PR04MB5405.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZLT7ThzswX4+wtAWfc7enn1nkqrWPe57cgXqORXWsNIJD39aQ7itibDuSKocus9VYjC7h3kQFxc3jGV0k4JaYrHmJ3TgWFNnhZXny0wM5WCzbmbJRHwxLucZ+bCP4AjsPtZO0EWecsJOv9fV1HyiB0ZW1Af3KLCGCqoutm86s+x/3crUI9hb9HJVTaQiHuHKMqUUcJiKKPjeFJOZLsVOs9yJNLU6e31p223YIRiMUNm2K1WtlAcDZXPYTlAQAeSHIwvVMochy6qwCL3Ad8EZ1gi6/Ci8VYWCAbqL9Q+BD+ObHBOOCdKR9OMyUSwup6PORel27doEoQdD2drw9qeL6sL/9Dct9BMbvBS/uM3rBiqcy0ru27ptzY9IzsWSPNgnR395cru40M9Gp7USr5bJ/v/jnEwm9R1rlNgqX2Xl8kLgiI7HP+qpQjnfCIxkVmnHUKfEPS/LZJA6PjkCh9cpgAAQinVYQtlj174QoQRMmBikl1tOzk+K5J/gO5s/shQmz3pz1QV7HCs2JExOPSipDVK1Y38ghro3z6Jxr0azGKiOEiuYSlqhZG6fHD29t5vWQY2BCsY7VEjMPQ5kvJNF6kJS9Bs/pUOxqIY8sleD7Polb6wIM1kc3Loj3fAjtDLwwch7SR2VyFGo0kF0S2A6hg1C+HCir/G1eKqDU45Ijj3/TOBVNMH1h2vcIv4p+kBWYZe2l9b1pa/jHQgmmyOj06h3GviMjNbGPT0KCZJC9VsMTtuAkXFmZZnGgGEb8Oap/kyiXW0LKcCG5c2kDL5c9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(83380400001)(15974865002)(6486002)(38100700002)(66946007)(33656002)(33716001)(66476007)(6916009)(86362001)(6506007)(66556008)(4326008)(508600001)(44832011)(8676002)(1076003)(2906002)(6666004)(316002)(26005)(186003)(9686003)(6512007)(8936002)(53546011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+BD/JU2MBG1rcvXa4QDXhI3HJsb8msPqM+4q8R0rUQMR4fvBY/nvogtutJBM?=
 =?us-ascii?Q?WpaRqOFy6D/0hEvgg9Qpgdhlikzm6Fl1nJHdsr4QsApKYtT7u1qzGmiqKdhz?=
 =?us-ascii?Q?ljayZmcwNJNXr6W1sSr0KwT7ErpZSzRUa1S+FEUCt0RVlsJJze6Hdd+ikeeU?=
 =?us-ascii?Q?ziOfvyF8qD65XHbAF66QUjfVr/K/sB2et1xTtEjxTfn+m+Ws1Qdzibp/jkBZ?=
 =?us-ascii?Q?YHXVxD7gCGcTus5EgO2rp6ymvPxbehVXCKB+LoeS+2bZKVyEIJlYzBoeYr6E?=
 =?us-ascii?Q?fW923Dpx1vrwhyTV4SwdhmGA/SmIb4QPlPIe7BmPNGhjEvdahGgDpfDv7ljF?=
 =?us-ascii?Q?kDs3XF8r2Dss8pdNILVuo3XGTl8+YXMzVWy5ZKykvgU+q2A6ya217p6nodo9?=
 =?us-ascii?Q?7B1O7v1QCvQXrZrfVLy8xNo9vQMMQ3mHoDev2RTvu87qyMEaFrpiQUQp00D3?=
 =?us-ascii?Q?XW44nfG/e2E51BQeSyDfvDWbN972QfLwDJWLERphDg+s4qfjO6jL1DQCM17x?=
 =?us-ascii?Q?kBl9dzYjADj+D/2TsL4jySSg5bpw7S5rz7BaBBExfCCIhlXTgf0dn9w/npud?=
 =?us-ascii?Q?Zo0WT7i7EeIoMfBwJbTfP3RQpcQPyUl/JfhgavBDpSXAFuiVNw3US+B8LhSp?=
 =?us-ascii?Q?vZACJdd6cEXCEC/eteHE0tHakGZ2TfvNB8kJRqyNOtTb6cHISet70wnk0c1K?=
 =?us-ascii?Q?5lqyR4QR6ugwgOehDwOQcUo/rvr0YK1HW4Ry9O1baiiXj3Ko856GvksH9XpK?=
 =?us-ascii?Q?s0fkhgt60qxX94k5r5WUhuKm9q2Ya9kxYNQJAjtkR7WefvSIOdpeAvSSWvOT?=
 =?us-ascii?Q?YAV/ctiOGQLHrEmPo+3x0YbLI7cPdbVNTm8HhYAIxXabqfOwGzD4cEosNgBr?=
 =?us-ascii?Q?fn7EB27gBoSPwtWtsUUUfBXjpI+zAv38NnjWhBjsqpU1qVw/67uKdz9mHE06?=
 =?us-ascii?Q?WtU0Xti1IN70Qg0q8zW3bVMECVoNLISu6jBR5ugP00+hEN+hJXEl0NQzSYK9?=
 =?us-ascii?Q?7cdbjHBu1s2XlQVE7Ej59wfYky/wO5o526FC/YFFeSUYWi9wBYmwJJF3+buz?=
 =?us-ascii?Q?j+AI22SdpG2WTdyncdDGb/mwVuE+TID3D75voNdFz67Mqc5JIuoXtxNtvzpP?=
 =?us-ascii?Q?nDPWGk3+uJKC2Fo7j3e0/Lsw3M4P/F4H+wGtzA/+dTeI7PkrQsdPGHFbuY8q?=
 =?us-ascii?Q?cccJU35C7fwY+us/yQjYo/nbQuAUUWQ2WvKRkV1d27R4JEVf1/IlUV7zwvH6?=
 =?us-ascii?Q?s9pHD+mBGS9R2LVXy0nS54S4nUYrYzwQcUqA0iGetR3wf+1faygsQxuyCb5J?=
 =?us-ascii?Q?X8iA6NJFqAPIDxZiQbjBtLRyGZ8UA5gXBUdrGM4DxxqU9dWkDFS7XSjSFu+3?=
 =?us-ascii?Q?U5FvXsrqwZVkgrQ10Cvq2zcGgyqRHPqmdxTY4KvvSL9gfbyYydM0tbMpNxa6?=
 =?us-ascii?Q?o7033kmlurF9Dl/BXq36DmeNNwcaxXszp05gYkvAur+uOfNqCi8iDtvCioyk?=
 =?us-ascii?Q?I1r8kqIL8tu9qZSWw7huGUjCEjO03DHhkgbIuzj+SycCd0Rt6G3PjggNZ8u5?=
 =?us-ascii?Q?pX7vWFljO8VmcnbIFWUnFqEUSp71sd7yWR1x9RBlrVc3wjvia/y2sutp9pdS?=
 =?us-ascii?Q?D4dfDpsp72r/Aa/kqnZKqkGtwkrBgTk8sdAQFIzE97r8WKi6wv3duPM2ixI1?=
 =?us-ascii?Q?ueIGwMBYy6119szDPVmVy1jRCJWzygakIjBw/F0OQYO0Lr6TmrBfaHkdsjs3?=
 =?us-ascii?Q?z7sGO5jKsqd74qBAem+Lt54D/J67MEQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070a7820-26a0-4bea-f05a-08da1302e724
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 10:40:41.9384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiFD9kt7ltFpxdbwA2SDJJxMOLIqJOVq8MjzQV+HQgOU15HPphqCiJaNVfVlBiCOKlodO9mQjXJe+CYurMGjhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5405

Hi Matt,

On Thu, Mar 31, 2022 at 12:07:45PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 31/03/2022 10:23, Geliang Tang wrote:
> > - Move mptcp_sched_ops to bpf_mptcp_helpers.h.
> > - Update MAINTAINERS.
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  MAINTAINERS                                         |  1 +
> >  tools/testing/selftests/bpf/bpf_mptcp_helpers.h     | 12 ++++++++++++
> >  tools/testing/selftests/bpf/bpf_tcp_helpers.h       | 12 ------------
> >  tools/testing/selftests/bpf/progs/mptcp_bpf_first.c |  2 +-
> >  4 files changed, 14 insertions(+), 13 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 40a62dc29e31..852e21ca47f8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13746,6 +13746,7 @@ F:	include/trace/events/mptcp.h
> >  F:	include/uapi/linux/mptcp.h
> >  F:	net/mptcp/
> >  F:	tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> > +F:	tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> >  F:	tools/testing/selftests/bpf/progs/mptcp_sock.c
> >  F:	tools/testing/selftests/bpf/prog_tests/mptcp.c
> 
> Maybe we should start using '*' to avoid having to update this file all
> the time :)
> 
>   tools/testing/selftests/bpf/bpf_mptcp_helpers.h
>   tools/testing/selftests/bpf/*/*mptcp*.[ch]
> 
> WDYT?

Yes, using '*' is much better. Could you please update this for me when
squashing it? Or should I send a v2 for this?

Thanks,
-Geliang

> 
> I know in 2020, we didn't list these files here not knowing who would be
> "officially" maintaining them. But I guess it is best to list them here
> to be notified when they are modified.
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

