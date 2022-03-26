Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75BF322E
	for <mptcp@lists.linux.dev>; Sat, 26 Mar 2022 15:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648310145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ys9ckVzkq9Nhr+iq12KK4ZwU735mX0oZGGmGXjz0fAA=;
	b=YUwxlFFvPcD2CkoPKnh9o/+97UboGJHKzR25olNkPIt9ztnnOa+k6riHorFZGyEnezFNu6
	OM7hDEeZu5DiXk9apW/9dUWYF36vhhcC22ZkiWxVoiIc17fA7BvEtd3P5wr0AxJORqnD18
	FxuqlF4KCC30G62h6LfaH18upwQO3jk=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2055.outbound.protection.outlook.com [104.47.1.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-FU6JBKhhOv-oZPamh9sK4w-1; Sat, 26 Mar 2022 16:55:43 +0100
X-MC-Unique: FU6JBKhhOv-oZPamh9sK4w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAXprnWelZkbWQZHLkGtueXlXdMuSyIW6LFCNKphKUvu3HiMLyl2ss3/Yz/56/W7cBmktJA//ksxlEDIFgEY3rWvhREFZ+fXXvNAx3lR/Nnxbfa0V/UEwva7RmYSSN4eXC7yZ9o4+LXJOdqSl5aHy1raunymKgK7Nf6w1wwQRyRvySHAW3asVKuhi2/Ubj4A5NCBEd1ur/VZHx7lwfJ2UNyVF2BxkyJ6EM6o/TSNPjQkNjvbwwRNmFfVxETPdeytanKpD/7rRpL/s9Q/judvaNYWCQ07KpogWFdA6xM6tw7Kp/qy0av6Xj9nZnQv2i/OX0EmsJEnSbgdCL04vYIgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys9ckVzkq9Nhr+iq12KK4ZwU735mX0oZGGmGXjz0fAA=;
 b=auVLnENTMjqTPj9mp88loLEZVSW/NjcoyUEnC1MC0IgaUCapPThGB6PguNcCHMx8YoiZzSjAakuW83btziJfUj7jtlacFFqJSsitK8qluKX3SgQQuSkJ61LwjlyOY5OgLbCv44B0AFVq6z6M2uxpdbVgb40TIIe9RVl4Jv9mZVLx4wph5IVcDMcWQVksOzOGCpN9zC9joXbhbKerFU6YAZpIEhvHIVDIss6tYB275Bvou998ZLDBs0/CPnAtztur8iqVbdFWyU8LvQJ6lgTeJf1M6XmspJhNJ8Pd0+FQW/zV4BN2tIST+b/jPdff+qHFXfwvO04oqPE6ev8/v50lxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB2847.eurprd04.prod.outlook.com (2603:10a6:800:b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Sat, 26 Mar
 2022 15:55:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Sat, 26 Mar 2022
 15:55:40 +0000
Date: Sat, 26 Mar 2022 23:55:45 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2] mptcp: add pm_nl_pernet helpers
Message-ID: <20220326155544.GA20234@localhost.localdomain>
References: <60276cb27a70bf7c789700fad30f58bb26921585.1648030937.git.geliang.tang@suse.com>
 <1d93ac60-c7a0-8441-76c7-e1c8344dd566@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d93ac60-c7a0-8441-76c7-e1c8344dd566@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR04CA0063.apcprd04.prod.outlook.com
 (2603:1096:202:14::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09e29e62-d41f-46df-b15a-08da0f411362
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2847:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB28474CAD18C97519837E76D3F81B9@VI1PR0402MB2847.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	reHQSAAeveqq6O+tjVYuMXcdxFkkxa3Uqtc5lkkDxirqTnrUMbVgPSMdf9giM11wmmI+qlDHlvo3cBgYIkcg3XXemmU0SWnJZfweXfR9I4mW/bTdW4mNu0h+PRClKzaCMPTMouLoOM0yRlUcN9kYZmnfTJsp/y104qa+tyfTWf01+VT1L9UK/6ubbG+73HKv3zEUSHjDXx59mQLXQ1flEnG0DGKHjALgt8tbOl3DQW0LQLQ4ysFEwAq5KmlfFViEMBl44Q/a7UhhJqbDL8VtnqnZbJEH9jeJUfLKSdhpS6aTZa0U9itURcFFf4OLRqR5vyx4979Oh18WbWv2rgkbViZXSaZZzVjb6Y9kersZ/N0gAKmxVceS7ckIPEU7aUrozMwYvZI2xUzcWoySjbfwRh4EF18pS7Db8pl9EoiXAMXLYKqACsKTQ8kdaR2X7zhgQt+XcUi0rjbCCRKgMZwMjVWVkAADkZCT7HiQKwWqf3J+8SDDpcMlchcooPeYan9VABsCRUWsQjs++ahMgONHJCVWTFYvy/CivRXcTkqMz8apXJq8bCTK5JjMnqE1CP1MvWyZnZ5uEyQHuj9gLMhQf7Oz0U21YjQVjPNCzsH2INHwI5LqgH9zGUcSQEoQf0z6bCIaJRaAoXRz+7PAqsl6S7YG5ky3kBUfGUSqlshqZbfWRkNCoTH3wS06RmmyVZdS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(9686003)(4326008)(6486002)(44832011)(2906002)(316002)(5660300002)(83380400001)(508600001)(1076003)(6916009)(186003)(26005)(6512007)(6506007)(33656002)(86362001)(38100700002)(8676002)(66946007)(66556008)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1wl6ZKXIsXAwOkra+gP9lQRxUqi1ClSafUCUUqP1t0Ua55uYYvqaoUwlNk5R?=
 =?us-ascii?Q?TK847ioCFKpQA3aGyglEAt/+4nSpo64RSNEF5AJKRLjW0m9DPTNervwGktrR?=
 =?us-ascii?Q?WVwM0ZD3nN+NsjxpELjZMe1J+nlcgo59Wl9reqHOspFBdrk6M0cUMeS2BlC+?=
 =?us-ascii?Q?WGRhhuH4Rp/oNtAW4MffRajQ3T3wygg7O8y8Bt20MgrOlJ86IYeX8P7PcYAY?=
 =?us-ascii?Q?br33q3w0BwYS5p7yiiL1E5ZFb6cpmWfFT6AX0LDjGGJ9cJRFkdykR4u85sBQ?=
 =?us-ascii?Q?d8VhIktPZwfvzS5ffQd/EHJYmFqvHYDNvJJO1kLwKMX4GMFSd49/4ifUWd+H?=
 =?us-ascii?Q?ES+706eF4Fv2i6o8296esOxbM5BXiWHSd/LxFeYsGCRndBJRdsNAPifNE4vL?=
 =?us-ascii?Q?X8+WpbvpA1ZLyOZ89yWtAg37/J2XyyBVwQRaq9AB2UbGc3OMqH00oRbDnR1p?=
 =?us-ascii?Q?1QWmILGqEOd39NqdHcUeidEH4T/3JqVZSY8yvw7wRRplrPMKJUVpjYoGuR8F?=
 =?us-ascii?Q?cE3fPIP0VF2UFysujf0Lxu/a5HKNaINPe6rXoGqK2OPLxJ8GMPjTIwiq2S1Z?=
 =?us-ascii?Q?c+T/I3bb4qMaQstznrahyPGhsrsQMUEdZM40i1SQLDgQPIVRrRGHG849pmBb?=
 =?us-ascii?Q?8ZkzJYgBoTmzgKlELA8xGENxq2NDh5utM3saK7XvSMxeBPa40lGBj1Ci0gMG?=
 =?us-ascii?Q?YV8/SyVF/vBa48xH8uxLXIUWt8AgkLHKJLjXJXW4aOLdYtpPutsALrlYdC5I?=
 =?us-ascii?Q?PKmsJLb68FAXMeEjPSk1xOrggZ4qmV9yp+1IG+yo6Pz66eWhDLag8JtZLYOT?=
 =?us-ascii?Q?X2Ib3/HnFaqXmYym7IMj+5OofthzqlFnSd+ifNfS9zZL1h7toViqNs2WDlMg?=
 =?us-ascii?Q?qWfPqW6NA3GngoPy+9JeKnzjh1X9EjADbISlAnWHxmc9CmF9pmtJeXH98nJE?=
 =?us-ascii?Q?L8FnHS/YJT6Tw19/rOzt3b+sYOVQ2KmnzXuumZvVFapffZFNHB6vx9+B8COh?=
 =?us-ascii?Q?7t3nkJ3eae+1BUyqR28FYq76EqCgb2XWRSpOoMLTLeblGdYTSuodg4oYCUP/?=
 =?us-ascii?Q?eIjFLbHF+EXfPbir4N5/pCk9LCjD8k86K/HmIWVkQnquJJAmgNltT6xFkZIE?=
 =?us-ascii?Q?LHlQnBnHpdiXeW9m2NKVWjmbV10Lglz4MTfmU456s7J47Xz0hDPAUfJK1ma4?=
 =?us-ascii?Q?x+4Rm5FAvmgJATdjxfXEeO3RgBwX6T1mghRd6K113xRfjLARs5WPRJKsjT//?=
 =?us-ascii?Q?qdympacWJqau/NKfUmTsgKX3kg83igBh7kOKRmOCJiju696oWL+5j2g44e/R?=
 =?us-ascii?Q?ue7hP2RQdL2Erawf5DSFaDk8z8ccczOq4IdARjt7JKk/Kn8UOsyjfWGpABad?=
 =?us-ascii?Q?Y+X8u/8Es/MsW8s2INOG5ZaP+DtmOu1L3yrHIcrxxgUqbHjwVz1R7lt9loSr?=
 =?us-ascii?Q?GhY+J2RiTLf9c41CPFXpNcSLC43Z/WZQeODvXFklWaj6cVK/jBf/9yM1PHgp?=
 =?us-ascii?Q?zkYMK+7uZ3mTG5KhkshtWbeVOA1glrJ+9DD9rCrFQfSMeqgNkyUMhmkUUHNh?=
 =?us-ascii?Q?0FQS6xDP+IrHvlb8A5eoxtjyoH1J18WI7lJe1dd7X6/mmSAvA95oni/NqWUQ?=
 =?us-ascii?Q?uiu3YillYIXhyHFXKsr23PfC3eR2JCnEzy0S3+M4ujtJo9XZDaofoCQhKDBb?=
 =?us-ascii?Q?LJWA5oaVzfLvFLLAwHZ/flh/4wbRXKeXnlazY7KddQS6wefplcOoscSYnaZo?=
 =?us-ascii?Q?ZMAvB+tHamU14HMpsOMsH+cKQwKoW6M=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e29e62-d41f-46df-b15a-08da0f411362
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2022 15:55:40.1215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRr55C8LuoMWzrXeOX1uKdoWSWz2XhC9kExFlVR8fLNTLEEXZzNGTM19tfUfnQuS/azYQb4jmIimS9Byx1VKUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2847

On Thu, Mar 24, 2022 at 04:45:27PM -0700, Mat Martineau wrote:
> On Wed, 23 Mar 2022, Geliang Tang wrote:
> 
> > This patch added two pm_nl_pernet related helpers pm_nl_get_pernet() and
> > pm_nl_get_pernet_from_msk(). Ues them instead of using net_generic()
> > directly.
> > 
> > Suggested-by: Florian Westphal <fw@strlen.de>
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> > v2:
> > - add pm_nl_get_pernet_from_msk as Florian suggested.
> 
> v2 looks good to me, thanks Geliang.
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Hi Matt,

Please help me to update the commit log when merging this:

'''
This patch adds two pm_nl_pernet related helpers, named pm_nl_get_pernet()
and pm_nl_get_pernet_from_msk() to get pm_nl_pernet from 'net' or 'msk'.
Use these helpers instead of using net_generic() directly.
'''

Thanks,
-Geliang

> 
> > ---
> > net/mptcp/pm_netlink.c | 41 ++++++++++++++++++++++++-----------------
> > 1 file changed, 24 insertions(+), 17 deletions(-)
> > 
> 
> --
> Mat Martineau
> Intel
> 

