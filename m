Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC63D65
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 22:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654122349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xW1Ao24Ch/HD4q/vC0KsN5lVFgE8Gs4yWPxvAf24jV0=;
	b=TERQ80uckyJxZt3f2i1jIKbUhOuqBGSgdYxzxK+FLnwwq6fGENi8ka/8PE9679cJ/Q5FIH
	nH4YZFThju7HCxxAdYhdIaiisk5w1Bq5t0c5XMhr+Urc5mRsIVA1Omn9DgmKtwF3zt9QVP
	Coi3nPV5eyULd9K+wOChVkc6Xyl8aYk=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2058.outbound.protection.outlook.com [104.47.0.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-6P6_ntf1NsmZLe52MFeDRg-1; Thu, 02 Jun 2022 00:25:48 +0200
X-MC-Unique: 6P6_ntf1NsmZLe52MFeDRg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaY0EQpqv6rlssKPMeyAKjjyDQ0+g1O4whzCh2Eg7lVtooU5TckiCJCIHVBDnt0uBRtI/Q36c5gSs8pJQ2u1H3llVslRiLNZKGM4a0DxyAw/JNX36ACIs3HIJAlTjpYErLn0brzh6VQ/opIrtaahIi+bHaPX5iLA1220HyE+eRs6Nv/P2SvJPFJrrBnKU9qeWhb0wMGAhRgJhwKa7ToAEqzIUp+sdWAKmvcI0Dg8HKcPzE2CxrZV7DC1ZEOc6Mc+jRGd3pGwz1dxVShn8wTM5kX+6U804tXKEcyPi1oTgxWgqTAWK8UP8RQgkqQWBfYs18T3sTXoz2yz4zFRiwG4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xW1Ao24Ch/HD4q/vC0KsN5lVFgE8Gs4yWPxvAf24jV0=;
 b=TbqwgI96TrQbZ4fkQXBFI0JacmAUe0l1PHOoEVCWhnt/2sWtC5eGaN03Bx6T0uNceqxiq2F/2uxLrTpJXEi8rm1VehOodrZf23NyHtPo2W/iLV2lBJLzFAWeOB+GtCF15JKPnwXCm1910ZP7tcb9Y86qbYQEdGEBrG23degGXgvZSajfJ5lxElfv+yfz3+aMfEnDvJfOW1gQFveP3ejqubfkG8u7UO5KWtP/bQRFOqFeDSfWz6LLQIkXzXDDntD8pb6a1UvgXHxhx2M4HBWk9z1jEflRt4/+aUqpXPilh36mSd0FmRSLhEQvDJc0n9V9ErL7gOXnIXohkL4TCNqQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9513.eurprd04.prod.outlook.com (2603:10a6:150:1e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Wed, 1 Jun
 2022 22:25:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 22:25:46 +0000
Date: Thu, 2 Jun 2022 06:25:56 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: selftests/bpf: add bpf_rr test: Build Failure
Message-ID: <20220601222556.GA3368@bogon.HOST>
References: <94de6d463bde36d3ad8e50324b9c40ce9ae36467.1654092153.git.geliang.tang@suse.com>
 <dbd58b00-6a0d-91fc-c739-8f8c453b0c42@gmail.com>
 <0e945e4c-212f-bf6f-04ce-50d32bb6e330@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e945e4c-212f-bf6f-04ce-50d32bb6e330@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR04CA0043.apcprd04.prod.outlook.com
 (2603:1096:202:14::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2313a9e6-a0ed-426c-a181-08da441dac82
X-MS-TrafficTypeDiagnostic: GV1PR04MB9513:EE_
X-Microsoft-Antispam-PRVS:
	<GV1PR04MB95136DF7F51CEA9B30F2F87FF8DF9@GV1PR04MB9513.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Bc7O5amMDNiAH2MQD+9qTSKiz+FtsueApFVWlvYoZko7uf/PaQGF0fqnW7cf1oweZABPcF0yJTV4qDZUZ/4k7YPJcEIG2iN9WyHbzENBSk2efTml4O+b1lBUoNdzwAgWmI5NBBfQpaz2RGc4B9fDBjZrmdJ4ijTVosdoYpi6mziYFDWXXqYoIHkjxEL6hc9SDFUsneYQkZw1+s3724nv+YDNfiQqXSyZHGLjayAzX4pvS5rWJiQYELy3xanfSV59o5q+rQhQAU3HX8ccDFugsvm/5a+Yiw/sKvxfewUHOhlcUP/hnQkj2cfrk1qXszd8fgr5Om3zDjeeXQMbYyZA7HedO6Dj5f/iDnyVnL8mwsfkbntZjARZxHLTzac94odMQyW0tDgnsClR47jsHxBMXhqgW6PAA+P1rtKfZ1wInKcaLg1/XalP5k17j39Of8qYJTkLSA9VY4KpDwFqlvVKrDrzgjfdECUcHABjUrMwHIU052l7r/WmF2a0mWE0qxM25SfJSF2f1pDqvC7ci0c4QrgJhN4lmWfUIXTZuAhXsrrCTBoikzisMh1OyFfmLvITfD7/54koqKiZQtN4SgVTlt0toqMgessWAqxnxZsDCIdvDPlYng6B7rGZMCBEYFZsozmndKTtlGClTvECuN2H/cGCfFBsM6z9dSUy3umlMDDSoVctXcjTznrXIxJMBZhLxa5Kqb5t3bWeOF9TVnWFnC6ELR07/t0Gu6EcnOycpQ2BwxUBnHmlx1hR+Zaq5ex/dPdQJjlVg/t052+r5SrS5CR9MB8BCTaTIiCSHWFY7ibo99dM8TDFo6JVgXH6O1VP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(33656002)(5660300002)(83380400001)(8936002)(44832011)(15974865002)(36756003)(66556008)(66476007)(186003)(508600001)(6486002)(966005)(8676002)(1076003)(86362001)(4326008)(9686003)(26005)(6916009)(6512007)(6666004)(316002)(66946007)(53546011)(6506007)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3e9kgSxtxED4z976TnJReF9d/ugwho8NlWIYlCzhOSMjUbCiz87wElKOHOu6?=
 =?us-ascii?Q?UyWPLxeqv2RO4ZrDVD9IGjHEhEWIg6NyqaL9BtGZ5No//QAEreNIyhlC7tNE?=
 =?us-ascii?Q?1+kXrCIhGkeULmwhkc62IDk0LSlTqDaV51I2MSc7Bdlrso5tOZCGoaWqtBiq?=
 =?us-ascii?Q?KvbSyYNBEhxbj99EVsQ/qwDLbj6FXKEaJG2a0qAS6GrE0ZnWVygvtCypEcaE?=
 =?us-ascii?Q?K5IWbHpFo1pJcbbcrPmnMcO2X8CSDmwXAVgwJ/aba8PDqJgEK4xgSLlhNv1w?=
 =?us-ascii?Q?l8Sw9LJQLAAPPM+vb0LlBgSwN0a4UqXR5ifxbgVHuD0rDnZ3Nk94+5MJtv4m?=
 =?us-ascii?Q?kayy8ShQi12yRzyR2FJ772Berx9q1xwSBBxjQ1EV8NXLgdramFTcgN7ErzPH?=
 =?us-ascii?Q?CGBFsSlHee5uMatoUw1eEJvH7AAndBA25wKuZ5CcgvkYfPH1iY+jw9qwQ2G5?=
 =?us-ascii?Q?0VPbwGPDdj+y87LwW4YzGerQ8D2WLDvdiu+iRDWXYQNw0ApeP0JWP+jngLzL?=
 =?us-ascii?Q?pTidNDMb30sFPRLelspyyS9ejs8IjAZRY1N6Msut44N/F4SAfYZD4smepRK1?=
 =?us-ascii?Q?U6KEdKVFnJXNZ9O0ngH9UlQyCyZ5xUbNwM/aga/l0BYGRR4i3B32040g0+eA?=
 =?us-ascii?Q?qQMUb4oeYMyJylDrI2S+A6M0jVisfskra7Tt+ZKdb36AFLkfWyDs4T49CqiW?=
 =?us-ascii?Q?sZBjPEemcVcBuqocN9Rv1uQagvUk9K58E9uWq2kXrNmS3NLLgDidVS3N/dn5?=
 =?us-ascii?Q?P2vphPNFossedEQSEoJ6PErcymKtsTQyKzNrG/yYl1iZPt+jQlUYSKLIgkbD?=
 =?us-ascii?Q?JP4TsAzWA94Ud42hfmrQRuvrINQpAJV7+CP1mh2C6bz7UGAALPFM+2hSvHWR?=
 =?us-ascii?Q?gbGm9BvcMqvxOqe0BjSAS4er6Qh+6pQ4Dr9biZlVjBHIcxH3dwdrEHIswF4+?=
 =?us-ascii?Q?QEma42E2AukYuAyn9wBwxnXS42YCRQGYwZHRbY4thy08g2kPfm/dihOO4wDW?=
 =?us-ascii?Q?DtUI0M6lCqH+rzZ0ftvoybWewP3ennS7rnLIsKpg58JdiRlAE0Gw1vpPNHb9?=
 =?us-ascii?Q?IQkXS/DCcDidEkQOHJDF3Em940BJZrxZTfAv6pxW9DEe+zTqp80J1aJGvA/o?=
 =?us-ascii?Q?uUFYl64TRhIewwN48DewUIQYByKGRSvnWcLvbyhbfcrRDB+A+rqj8HlT+pbf?=
 =?us-ascii?Q?t92t/MkmR/VtwrzrR2OdvhJjB83go43rjTKQKz3cGnKf9CPzRPO3GMT5vAwQ?=
 =?us-ascii?Q?crEUxX/s8nyW2h2DIcR2AUgFPxQyopKX2FfDhV/EiQ4xzzTJuRjS4F33iE1f?=
 =?us-ascii?Q?VlBgW+Um1VXq3chRcRl2rfCX5AqEGqg14zozIOQCPOUBSuN3SG2KrnWuy14W?=
 =?us-ascii?Q?EHTYCnpWr0wZ/ZxTgiXGwuMBqeHUUSF+PdwGeFaU3wjVyF+xWy29JCgijeSO?=
 =?us-ascii?Q?bslDhJ/k1wyNI/iFvqdYFq5Llks6LnAlSzHNk9QfiKmL1I5Zw+sYPzpU8O40?=
 =?us-ascii?Q?yse7RAK2tcsCXLtp43th/jD2rhw324SfItlL9k0jALD0eo4GaTgmclRZMZb9?=
 =?us-ascii?Q?DQKxWkoI8eTubxz6ToWOmvFp2YRohBapBH0h8h8+kKxfNLEITqHcwnoLllJN?=
 =?us-ascii?Q?PQaLOlMg6pOaKVK2eer1I2tMISfUdxamNpPhHf4Jwavy8x4b7zPgdEqNCMTf?=
 =?us-ascii?Q?ggYHYpYITxiWXI7bHZN7F4UOEWDS2afSBV+7hMNZVOQkZ0jcBp5RDSAwjNls?=
 =?us-ascii?Q?wPW3Lgt89VkfYldkMwjTXj+ja5R6GoI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2313a9e6-a0ed-426c-a181-08da441dac82
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 22:25:46.8609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pL54qnxjAUQyDJbvu4KLijFZZsV2VON4fvVP7mYw2msseX/14aWfc3smRUO6V8kVYK4JkshSrojcgwDmpB58cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9513

Hi Matt,

On Wed, Jun 01, 2022 at 05:04:24PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for the new version!
> 
> On 01/06/2022 16:21, MPTCP CI wrote:
> > Hi Geliang,
> > 
> > Thank you for your modifications, that's great!
> > 
> > But sadly, our CI spotted some issues with it when trying to build it.
> > 
> > You can find more details there:
> > 
> >   https://patchwork.kernel.org/project/mptcp/patch/94de6d463bde36d3ad8e50324b9c40ce9ae36467.1654092153.git.geliang.tang@suse.com/
> >   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2422165357
> 
> Regarding these errors, are they normal? I mean: will they be removed
> after having applied the different Squash-to patch?

Yes, they will be removed after having applied all the squash-to patches.

> 
> I guess for these ones yes:
> 
>   net/mptcp/sched.c: In function 'mptcp_sched_data_init':
>   net/mptcp/sched.c:94:6: error: 'struct mptcp_sched_data' has no member
> named 'sock'
>      94 |  data->sock = NULL;
>         |      ^~
>   (...)

This will be removed by "Squash to "mptcp: add get_subflow wrappers"".

> 
> 
> But also for these ones?
> 
>   In file included from ./include/uapi/linux/posix_types.h:5,
>                    from ./include/uapi/linux/types.h:14,
>                    from ./include/linux/types.h:6,
>                    from ./include/uapi/linux/bpf.h:11,
>                    from ./include/linux/bpf.h:7,
>                    from net/mptcp/bpf.c:12:
>   net/mptcp/bpf.c: In function 'bpf_mptcp_sched_btf_struct_access':
>   ./include/linux/stddef.h:16:32: error: 'struct mptcp_sched_data' has
> no member named 'sock'
>      16 | #define offsetof(TYPE, MEMBER) __builtin_offsetof(TYPE, MEMBER)
>         |                                ^~~~~~~~~~~~~~~~~~
>   net/mptcp/bpf.c:55:7: note: in expansion of macro 'offsetof'
>      55 |  case offsetof(struct mptcp_sched_data, sock):
>         |       ^~~~~~~~
>   (...)

And this will be removed by "Squash to "mptcp: add bpf_mptcp_sched_ops"".

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

