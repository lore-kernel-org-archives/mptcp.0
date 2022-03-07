Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0BB7A
	for <mptcp@lists.linux.dev>; Mon,  7 Mar 2022 14:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646663387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ubyf6229todlRuc1J7Sd8MUrOVNIuHA1yF/eAsXW0Bg=;
	b=ZE0QxEuVXnnF6bAVSDvk/OFd7b9i+xwtCG1v6lMfZVRNEVl/uOoUxuxm8DoZaXEsnDWz0J
	WpVLwdlKsbrWl9weDHI5htaYsqVIGcEa9uY3P05atkxJAqp0QJyjPBIfihrsPY0uE7YQv+
	u7xIKTKKkZDH4eKnVf37nGIPiKNn4tc=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2054.outbound.protection.outlook.com [104.47.12.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-tz7joaFlO9uZspzQ646DsQ-1; Mon, 07 Mar 2022 15:29:46 +0100
X-MC-Unique: tz7joaFlO9uZspzQ646DsQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8l76mlZBMS9fdxkLtWj59iN5Mvkf32YVVf4rKGM9MpFpZr/zHFKHM2IgQIGEQG6kFwS+qhj0bzvSjZlzD9EL7pwlmCJ6/uSMYEckpXpX1HGpENyErkP6op18wZnnOhnsVJV5QFVvaiS763qkOJoAYuph/w3mMYHZf+8O3g92eUNBuEYcZ/enJwXb0q42lylgzMVUlg44yCN52YsvRlvKtpi8a3Yn2T9jTaHetdk6pxG5O49DkYBQZulGv5uQtYZl+lyTjy9uK8ixh/63Uk2lPS0elPP1dEDXTBjXVd6gAwqZNBdq5bH2BTwirt2xZOawTON0jPr6t6h2P1XU8wqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ubyf6229todlRuc1J7Sd8MUrOVNIuHA1yF/eAsXW0Bg=;
 b=f52vR+LbCtn59oBCXYfaXhjU9Fo6XRwzM0tKLka9yIXLRLsY6xXEKlU2rv5Ffor6E1MK8CExRa7qrHEH3n0EhE9ZqgrCJDQB6kmzV+ELjd7yYs8DDIDn6Y4HDaexk9ZYO2wrLGvAoxNk0egcXiZHFEQnEyN3rjvVE+1F1pQtaSlm94nmZew1vpLhoB4pZHdm3kTcYZhcmbd8rOp9Y8KLibmQXUtxYtc+J9UoYM/gx1ZfT7N4aTd910u98prSpnBxtfSZl7D/9gxUhqnW1hAasNrchn5j+XaJqo0rgsYJ/3uY3NuKvSmzDj0ULAtZxqSmes6vqu5JZ3g0Ke/MDLR9Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB9125.eurprd04.prod.outlook.com (2603:10a6:20b:448::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 14:29:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 14:29:45 +0000
Date: Mon, 7 Mar 2022 22:29:36 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v6 3/4] bpf: add skc_to_mptcp_sock helper
Message-ID: <20220307142936.GA4199@bogon>
References: <cover.1646528337.git.geliang.tang@suse.com>
 <c5594343d3100143e8f24974d893e57a645942e3.1646528337.git.geliang.tang@suse.com>
 <8365785d-2000-9d44-fe28-78bd077c3f17@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8365785d-2000-9d44-fe28-78bd077c3f17@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HKAPR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:203:d0::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22dae124-05db-499a-d117-08da0046ecd6
X-MS-TrafficTypeDiagnostic: AS8PR04MB9125:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB9125EFEEF2339767F12D76A6F8089@AS8PR04MB9125.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J1+DOG7Q6hqA1OzPTlTYcF1n44gqzSmXI+5vbQAkV1HeDsMBcz46y0gXIDeeYbUxC9FFFSnb0Qpb5eceirTO3QMXrz+I1ze+NF0QNVsvSsR6deDd4l1yXmctlbo0udaNKTjsYVoP/ynujUqEPbIavZdVXvz5aDtHLi7jrRJFQ+gnsm6QVnB1URcEL8Aj8BTORmIhKeSuA3UDuBBPy4moKR/DHJKcRt7sZNazUuGlmF8njWVUVO+QbXRZAUS+0hEFUE25c0AqKtkyPGI+kKeZeTA7iIHqMg2fcjvrXGSIBq8pBr0LSHTKuig8vR06TmbI4yazXZl0mogfpSgSGbM3pwDHw7rhxlWIVOIjghRpNXgqgFfR7KcluzHwqEKcodnGWUqq1XtpkwgdN+lYIPthhd+pOygjXo2J6lo6/H/cDMY/w7keJwmywZD0RO5p8/NUB8oHT2QVCCjcWoU+iy/LkOKtYkCfP3sWRDzUxbMo5jG1fJSVczbVbwQPQqqoL5DXBAvVAk9vXHaJVC/DLcbLJLOzDmnNilT9dBT8cVzG1+okN2KBxegKGHNqNfPE23QQY+Qto/meUIL956aXGmb+Z2XUL5iqf7zi0g3Fb1evUXiKO4xMxRoNVupoBhnnMGejjz2YXb8woLQSkkhWi8mJ7d4a+pLvJl9jIP0kVUcAM326Vf3re44+XsVLFBg3G5kqUCMLzsjQBs8Tnlr+CSalB6xO3j8pSoa36kQG6U1TnQN+cnnb7bKVXdeogkSq/r3pgb0YoPsTtxuYHA5suZJJ6A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(33716001)(38100700002)(8936002)(86362001)(508600001)(8676002)(44832011)(6506007)(316002)(66946007)(6512007)(6486002)(66476007)(66556008)(6916009)(6666004)(26005)(33656002)(1076003)(186003)(83380400001)(15974865002)(5660300002)(9686003)(53546011)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TjBvlHTFuXsUBLAb03ATzCZj+wIE4BQK0PPmmsxjbMY+P79CSWmaH2jSiGWu?=
 =?us-ascii?Q?oQEdLFvUFqXPNgLREiFyW8Np6cRjLSs6Ghdx3lhTGl3s7PujiL/LBWs1mb81?=
 =?us-ascii?Q?n8M5F/7P1HtFX3YRCQge6dyA9oC7aEMwSjkqdtEbzqE45x0aENUjvN41e1Vf?=
 =?us-ascii?Q?v4cPUrhnGUOKZR6bOI5vkGmd/B+y3dgKFtMWm7MSJbIr4jnoYYDN2AxXVxZj?=
 =?us-ascii?Q?3hoSNdKz8R/R6ksIbPU9Ltmc7v7O/FBWTmTD6nZkb8CpzqonoBuD5bQkxHqI?=
 =?us-ascii?Q?rqBRFAREnptdORx/8jdagAfAk1S3BRMNWtM6c64bfGqNExof9Q10w1VBq/HD?=
 =?us-ascii?Q?h/KvbmaewAG38dCADuic6ioTuReAYxcWhmw3wEeG1ypHhe4hAc35duuRz3el?=
 =?us-ascii?Q?Agr35nXcJ78NIb2gbuIyQ7Zn/LPr/OAp67jfWji2jToDNT5YKC4V+ROVlMBF?=
 =?us-ascii?Q?l/noC3Frhq1LkcAbFMjLWnSdGRURiWMCHI3D/4zX2Eo8zhQOkIiRbJqFg0fh?=
 =?us-ascii?Q?m/IuZMvQeQVdoj4kEPBl/AhtcMOQT78Ml4cFAmVC2dUy2RXNVO58iqHfdS3r?=
 =?us-ascii?Q?ZEb8vJF57/oiq12El7Ar0QmMgHPn/TI/LR39xi0YGH3Um7hB5uMfOVXjPB6G?=
 =?us-ascii?Q?fNoToArgkWI6d2p1QPAa4GYz43ZVUlrtgUtsQMvN3k3CsIhUHsEu5kobh7In?=
 =?us-ascii?Q?EFJRI3RaTPHFtEhbjZhXxDBFp5xp2lJzxCsnNDY3YnEk0Pb3GN+go7SPA5YK?=
 =?us-ascii?Q?OkaioHrtcx3mJoqhAggnda5Rn5P+VwO1v31Q4uszGWYj602R0aoAwndkY3zI?=
 =?us-ascii?Q?D/tjTSk94nZtAyCyObTfOAIfEtNGiZrCXuLouH6UjRTMfrda68FQIsMW83/a?=
 =?us-ascii?Q?tTxAGpclLdLhYuGOscLdaj6mDwS1PD09vxMNewi48RGcZ0hZUWtlNP8xrsyz?=
 =?us-ascii?Q?O3mEOuGAbNWffaJP+2k9z3j2cdB7moygKeM+AQ+r+tCN23dGFgIEa1RObhhn?=
 =?us-ascii?Q?PO7sX1OX+zuVLPx+nTC9gVhxQ/aoIBNXxNK+rxFKxJgKJYq+JygjPbScAQqx?=
 =?us-ascii?Q?LZYoLYV7kFAWievEPPe37/OsC3R5Uey5++cnxA/gN9FIvyStma19sI1md4mA?=
 =?us-ascii?Q?wuTdX5zxpAmJgKshOQUavmokGqvBR2sY4CCJVZUCCLfAtk1PPKMctjPgxTfB?=
 =?us-ascii?Q?g4AD8or9BQBqk7DqJVpLmlsyzp6o+3gS9Da/vDD4IwRwMh/0xKGePiaJGS2m?=
 =?us-ascii?Q?09NxsFgXHxSCoWpiWRF6Wxr6ryU8DiWmjFYcY5yUeaiNjunyxlqnVnSQoJwC?=
 =?us-ascii?Q?ZMxz6Ojeiizp/KOd8LxzQDFRM6Suq32+lU9BGd6sdCp07ziEWeCgBEW2rc+5?=
 =?us-ascii?Q?T7GXMhjlOchO7CtzcajF60dlkQCgURhJTAKr3cuOB/Pw4iA141bXmoK5XRet?=
 =?us-ascii?Q?rBvH3eenXvO74lv8ozOHjAjbMqWa9qkJKU8wuPB7Bbp1rosLSggu0BADS+5t?=
 =?us-ascii?Q?uO6V6K+2o7JfvWhveSDNtyIosBcSYMpRPyOSrjIpC9DbT/M5gc8Hta4dzGfc?=
 =?us-ascii?Q?rzw8EYtsIyXHd+FjQMpstjVAKIbW8H/rP3czGmUgwhn8/RIyzhKpCS3xGpmQ?=
 =?us-ascii?Q?yk3Pbzcrh1aed/U6eyWDRyY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22dae124-05db-499a-d117-08da0046ecd6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 14:29:45.0370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orO37ybvIS7rsi5G6KbDiq2LM0wIJlBZ2KeQMWtcKs+XqTImc+BhtwpVOlfw1GG5bXLkIAirrrfd1bceRHV1Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9125

Hi Matt,

On Mon, Mar 07, 2022 at 03:04:29PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 06/03/2022 02:01, Geliang Tang wrote:
> > This patch implemented bpf_skc_to_mptcp_sock helper. Defined a new bpf_id
> > BTF_SOCK_TYPE_MPTCP, and added a new helper bpf_mptcp_sock_from_subflow()
> > to get struct bpf_mptcp_sock from a given subflow socket.
> 
> Thank you for the new version. It looks more like what I had in mind
> after having re-read Alexei's review!
> 
> Patches 1-3/4 looks good to me but I just have two small suggestions for
> this patch 3/4. My review for patch 4/4 will follow.
> 
> Do you mind if I re-add Nicolas' SoB as a co-developer? It is fine for
> me to change the commiter name because after the recent review
> iterations we had recently, the code has been almost fully rewritten.
> But still, I would prefer to keep him as Co-dev as a "reward" for what
> he did as a student :)
> 
> So we would have:
> 
>   Co-developed-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
>   Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
>   Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> 
> No objection from you?

Sure! Please add Nicolas' SoB tag and your Suggested-by tag. I should
have added them. :)

> 
> (...)
> 
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > new file mode 100644
> > index 000000000000..d140979181f9
> > --- /dev/null
> > +++ b/net/mptcp/bpf.c
> > @@ -0,0 +1,17 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Multipath TCP
> > + *
> > + * Copyright (c) 2022, SUSE.
> 
> I understand your modification but is it OK if I re-add the previous
> before the new one?
> 
>   Copyright (c) 2020, Tessares SA.
> 
> (I would prefer to keep it not to forget about very small companies
> contributing to the Linux kernel and I'm not sure it can be easily
> replaced :) )
> 
> I can do these modifications when applying the patches if there are no
> objections.

I agree, please re-add:

// SPDX-License-Identifier: GPL-2.0
/* Multipath TCP
 *
 * Copyright (c) 2020, Tessares SA.
 *
 * Author: Nicolas Rybowski <nicolas.rybowski@tessares.net>
 *
 */

Thanks,
-Geliang

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

