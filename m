Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011ED645
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 14:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648650132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4POvwCeQD8v2Z1wS8NYy5LlbHz9MthjyfIHQUtbhem8=;
	b=DWY94PKwvp9FgwHA4OkWQwapaz4XfQXezZk4zS3+xTdHBLUtK/uSOPQMSzlIGMkrvz9KL9
	UDZGMhcXph2IBMCbRxcY5fjJJr28rQ85ctnu2ZDal1KjIyBMD++wD8QEYmIIJs4zRe5axE
	7HQ4KYzr6cEOX9F+3SZ35m7zgAADy88=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-566S-JP8NFWGJFSrg8mWQw-2; Wed, 30 Mar 2022 16:22:10 +0200
X-MC-Unique: 566S-JP8NFWGJFSrg8mWQw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azWwxOkngHr+RfvqoSUX5115MmTwpobKCiEY4xrabJ9Kv+A2OyZLhA0Wb6CSkfnvGdmCRKd8r9wLYI0bYo1KMLumaZPML0amL6IAZsF1lT79h1soAaYBMq5DaG0WCAFpMXTMc447lAAnDttzmrKkPM7HBTWgOG03wFXFIMmNflpBcdbVRhE+7dHWSI+VhCtIYXmKqEmoaPgHLFH+0yNi3iu8KKAqgg4v6ds1J9G4PZleazIbZYtPU2l8aMPTrs8yIoPTuMGYRsla3AKsUWVHkSBXOoQbMq5O2qQM6XYVbM+giJghYCKDzhMi9bQnbObwywig7OQyvcAuGdNzotLMcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4POvwCeQD8v2Z1wS8NYy5LlbHz9MthjyfIHQUtbhem8=;
 b=eMtCrvlzeGP+9uhAxqusbF5NbP1BOnYPjJSZj0kA5ay9umjwBfpg2TrT9gXmyk2NTuAtQUepPUkjBNXhLStpKUjub9iVdmOzm/k4sVJ3oj/ifQxEEf6ljD026U2yQ/pISSH9rjmipNa7mx8Tkbe1zruBQnsPSVq5r1pVTwNAl81h1m9o6/TC4yAKAKusS7sTkS2v0Wm41WupDW53LSQ9hf9hjbIRQWl/ziktyzskQ+X8VpBv03yyuCvEc5LHq9Rvmy/qdqljvtQEZRgxMWnEPk2oOgQdp3D579jUbeOuO6SWW/10EhQmm6FJMMjlfExXihji85MQreWdRZIr1p6XHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7253.eurprd04.prod.outlook.com (2603:10a6:10:1a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Wed, 30 Mar
 2022 14:22:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 14:22:08 +0000
Date: Wed, 30 Mar 2022 22:22:14 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "bpf: add
 bpf_skc_to_mptcp_sock_proto"
Message-ID: <20220330142214.GA861@localhost>
References: <ffd704984e4e76741161d35ef127fde082d0add1.1648624018.git.geliang.tang@suse.com>
 <ecc7a980-d75f-2172-8fc2-eb12de7cf7e3@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecc7a980-d75f-2172-8fc2-eb12de7cf7e3@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYAPR01CA0181.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e44b931-7588-48f9-5872-08da1258ac85
X-MS-TrafficTypeDiagnostic: DBAPR04MB7253:EE_
X-Microsoft-Antispam-PRVS:
	<DBAPR04MB7253D2B29ED994B8F57B228DF81F9@DBAPR04MB7253.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BRjfir1jaRyjCxJjByv8zscxojEBLeQGOq0Xh0TzBsbuonrAtmKO997wpQHJPCiGD5/8GOCNf/jVTX3pzS8zEkfPXeXIYJgYIvy3BIAbOJaJK19Uhs+pY57DU1neYpMxkQ6dhpvOK87WiCsUIfMq/dAE6c7ObNDJJA2Au0SgidbgtNlxF1AvYES1WMfPHAMy9lN3ez+6v6josSFjGqRI32mi54XTf82MYR2EpE4Sz6lHMYrH876OERjNJHRGZ5fq5jWVK4PQx7sWmN3TSDFZ7yb89yQqXUd58XF1dz5dATH7YfbYb/BSNgsrNZnLhfru3K6UjayYMnfPghxDSb3AbZj55w6F0KLQpFZ4wkZj8gnBbA3gGEWP4hXjbaPXQcQjlAhFb1EIBp3+rZphu8lLRi9ajEjuld+Ivj3ikQerCJlN1seCDPyOmENTxT0xXhSgGqRWDs7z3Bn74lScHur9AkbWcVyCdwQwjdqdd5w3MIYNYP7KF27NiMpteW4FhUNd7Sy/6Z5pqR7tHRqKwq+X6SYXDwKYz1z8EeELasn29RhdQjSbcZKvjwWwvXT8aDF09I75+3phzl4+3SlwQU7ITA+LR/HS/73lJ/lj+VdHq3MYWm2bsSe7fG+XfyrPsZ6iM/dC0YP/kzsor/n4FI2F54yDiNqrLcMriIyTO9bRqfHyBiNkIiNj6Bu632Bg3E0cB2DFbN62p5JTPWzNGXnrHV8vQ2SSjHBXm/1fIkAIrG4HySATaGrpbUKFoFaDnqjJd/U2t2mn3EzPBXpQpiwBMTNs/AE84LRaTvnP0r9YJ/s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(4326008)(8676002)(66946007)(186003)(53546011)(6506007)(38100700002)(1076003)(316002)(26005)(6916009)(66476007)(66556008)(8936002)(5660300002)(44832011)(86362001)(4744005)(33716001)(6666004)(2906002)(6512007)(9686003)(508600001)(15974865002)(33656002)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XaNDVqh9viT7Vy/VMip2pnVGHgDDkvkV+OIEVtpXNyyeR9ZEZ6fzQeXQ8qqU?=
 =?us-ascii?Q?mfbpV6fwPYYrRlS6rpQWCKmQLLMYw23fwxK/4JoNYWDSk7+/n7taswFqj/Nc?=
 =?us-ascii?Q?Ok5+jz76eIyKQJ/Po+0RgZBoCeC8KsysKkojuNNjYbmrIGvsMVVQnQ3MzXIR?=
 =?us-ascii?Q?Iom0paMKl6Qd0XC4SL2jwgVgnRXI+OMmlrqyASwmanXLtUb1heYfOzpT8kp6?=
 =?us-ascii?Q?FtnkijSt4hjMArV+3G+vIAj+IFQImTZgHCVrJQOvuzdJ9YAIYWXecRGpT2nL?=
 =?us-ascii?Q?XzWFDPosVMJrvXWzbgE9ARkloCIA304VB78btF+J0w2BDjyIUfD1ZT6kAho6?=
 =?us-ascii?Q?JgGVaAbeQQ1JYu8WHwvoBFLfNDy9gLRIElQGib3o/LFVq/qnsa3beGIrgkGn?=
 =?us-ascii?Q?G96S8Cf9PZGDw0iXp98OZkrhpiIKWfzCLuGi7H8q3TYKlu7d+fgs3A1pL0aP?=
 =?us-ascii?Q?B6zNfN9ZsfV8B2nrmWyx0YkOMuAXAtQT25Mbhv8YwC0ski4lz+S2PT3cRK+F?=
 =?us-ascii?Q?zGYPSOWZlmHC0xYDheD5+MJKr+wnYcdsBytl9UMWF5vTv1ZGIiIdr6jJ3Lkd?=
 =?us-ascii?Q?o0zAzeKi3FXW++fQ/hRNM8yd/wnRAec1BYbgzldJloztvmQ7vuXR2mQ5itkB?=
 =?us-ascii?Q?v5rcp6yooAyciSQ+4F2Vy4pzsptAbtlEJ5GQqrQ2XTOe4uTW5ZefbXh2jZsG?=
 =?us-ascii?Q?Boa5DLzMeofFFs5CALANSfrEs3tl33AZqkwuside75P8tR/T7jfHpOU6ROA7?=
 =?us-ascii?Q?/UNDwKK4vSuT39XS+F4VbsoAeHi8blAqTJTsgsKoQkascV6NIbV44pXI7wxR?=
 =?us-ascii?Q?y87X1pRxGA16D1A4nnqOy9sqAoFx8Awu9A63gOgUvC4dihcGRkIcW9O8VNRu?=
 =?us-ascii?Q?vXLP/cGryv+CxGUJDkmedDBsVkHAXuhMLVOWLmQPu+qnsI0tDk46NQqb7wmw?=
 =?us-ascii?Q?gqocfsdAsiJk+Jyj16EAgBDD3m7wq/BmdJ696PJIl0/Mnbkq5ugJSjIp2xNm?=
 =?us-ascii?Q?k+wTOmMDO3G6CWu4I34VnBsklsjdt4MrqYU98NvTy+iYBalS+hoRKTNQ1wVB?=
 =?us-ascii?Q?ySZS/yOicOqxIq/jIW3q07dYAJKBPcQPKNT5nu8traUAu/DFSO/ibaKe5/Va?=
 =?us-ascii?Q?YKOocWBGlOawIJlvOxrlZO1z7MjG47P0za1WhrfehhrC9Cofreycavk8IRdC?=
 =?us-ascii?Q?Tn3UKW5iYdtORAMDwE3Vmx65fqto7B8N6BpkFddxB/2+9nbzZuJeWGnLKWzF?=
 =?us-ascii?Q?TKIuDLvaptxGEihQN3fycMnOc4OKUS3Uy5yur7AHI2XmtTGNGtrYvIcZ+IdP?=
 =?us-ascii?Q?0cmwZOxDWyYbFInTIUERHU19CHWfSGXY8kG7pmknlH/TVmqNNkFMMTA48i97?=
 =?us-ascii?Q?Cb9kF9v50V08iA4aRS7pfRwHoIgNYmmV/IPGjIbFVuZ+ntSc+teHzlk0Wc7w?=
 =?us-ascii?Q?dD8gknBrUTk1n1XK3K7kD1N2IIkU6pUnqeKD7A8FhgJF1ncrg28BfzDEnsKm?=
 =?us-ascii?Q?+/V44YOy5op7aN2SahGEVPzZl3Vp2l8SvK63PYWyNSGK15H72kyOCNQPbQCz?=
 =?us-ascii?Q?IDMoRoH+sCRFQDcX3fhAMHC+AbZUrXVdpiubSLQ76n3mMgZ2H7Yvjw9KIaYO?=
 =?us-ascii?Q?bcIQMuZ6UT9cSCx6cGRAAm+CO5ilnjECRVa/8b/RfMAQvlNHB62nxG2oZfa4?=
 =?us-ascii?Q?Lc1jRGIG2ynA4lHUFfoU87VoAHMhlQWBOYFhxfeN+PDgaGN1qfydHPVUdSJ3?=
 =?us-ascii?Q?FfHsq3SqGgK9VkDAdtv2gNx5g1tCSyU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e44b931-7588-48f9-5872-08da1258ac85
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 14:22:08.8438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZ+TqzSGpKmg6QJw3xNKf0OUNAU6YoX7wd2AI7tytyfc3QbOU333DN89heiHHFwCUeh/+hZUDqAv/BOfRe6hlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7253

On Wed, Mar 30, 2022 at 03:29:06PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 30/03/2022 09:08, Geliang Tang wrote:
> > Fix the build breaks reported by kernel test robot:
> > 
> > [mptcp:export 32/40] ld.lld: error: undefined symbol: bpf_mptcp_sock_from_subflow
> > [mptcp:export 32/40] filter.c:undefined reference to `bpf_mptcp_sock_from_subflow'
> > 
> > - add defined(CONFIG_BPF_JIT) too.
> 
> Thanks for the fix!
> 
> > - move bpf_mptcp_sock_from_subflow from bpf.h to mptcp.h.
> 
> Should we add an explicit #include <net/mptcp.h> in filter.c.
> 
> But maybe it is enough to have net/mptcp.h in net/tcp.h?

Yes, net/mptcp.h is included in net/tcp.h already. So no need to add it
in filter.c explicitly. No build errors for this occurred in my test.

Thanks,
-Geliang

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

