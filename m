Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67612C81
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 13:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1635513813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oaw85ZLEuoCmmDpMiEkHY1LHy5VshN9cBM+wEjCYOUQ=;
	b=Atsotsbvi4zXhCxbEoVSqqZvjx4NcuggjsDXDkNyriESJEV568XDjD6jwl0ii7GDYH9v02
	5Xm8TEXtMOR89EytviHiYJDK2R7DukWqBTFrk6G66g9x/YL/DEZglGmqyQPRu1mEEAvvz7
	xYnap6BpBPyQI7OXEx5XCyXgngFMhFo=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2052.outbound.protection.outlook.com [104.47.1.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-25-FDq32pmBPsaSMWCKyM023g-1; Fri, 29 Oct 2021 15:23:32 +0200
X-MC-Unique: FDq32pmBPsaSMWCKyM023g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cF1Rac2CZDoujcYN5gfQjr8AZQIC3J7wwj49g+6LnQQ0KRLUo6Umcfi6BEwntr7IbHJOXkZ8CWkIKf3QzLHMoo5RUcSjc+ZYITSh9eJKwNxqrXit9mgBEhDKCUEdFRD3hnSiVDOYU4n9riQy98b977/Ftfsej97YR9TZ60LWcqoXoezA+ywjUZeiJryybKXSXAW9bzWZMWtL2aKSYB3IFnzjplOCjm4xxOyraIJtxMcDg8fDHbaQOW7P+raVKgMQrdR8idi48E+2HjyZ2g5Dm1kKWGePrwc5gdSAgQ9Aa84g9D9a75q+pSzSdJzwGHg8h6YaQsuBqJz7V/NOU/BKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaw85ZLEuoCmmDpMiEkHY1LHy5VshN9cBM+wEjCYOUQ=;
 b=m5AEDsThrLH1Ys1UKnVsp32w91LVsxIJimJW6E7vs4AKVYFC705+8whZ2RKFaQXVUerI/Dr099bhg2k6iVV76zCxk0w6RG7PQS51d40824dLiLb88Qlm4TBmsSun7aqZuFWKm0eAEkzTHtsa+HEKUOTZw9xqHzR1L8Mfs+q9e6hlnvSPy4irVsP35F9YYYdsv68KCsvlaYvyXfviRZNf+q0Gyu67mV5VXBFgITciL0iFAkWdQPyAe6imzpIk5JGpJXm1aVeZgjF3yFN53DqMnwFl+60Z8f6lEoZNGyDLcEnrzkMAzoa4T31koG5mtrWwM3aBe6BcJFWX5wtcZFTcCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3001.eurprd04.prod.outlook.com (2603:10a6:7:22::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Fri, 29 Oct
 2021 13:23:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 13:23:30 +0000
Date: Fri, 29 Oct 2021 21:23:29 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 0/8] The infinite mapping support
Message-ID: <20211029132329.GB4144@bogon>
References: <cover.1635481641.git.geliang.tang@suse.com>
 <8c3e2143bcd123e81d4a7d339ee2e7c6b46ba92d.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c3e2143bcd123e81d4a7d339ee2e7c6b46ba92d.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK0PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:203:b0::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (2408:8207:2546:b4d0:c652:b659:7170:192c) by HK0PR03CA0100.apcprd03.prod.outlook.com (2603:1096:203:b0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend Transport; Fri, 29 Oct 2021 13:23:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9ddf0d8-de58-4e91-616a-08d99adf4c4c
X-MS-TrafficTypeDiagnostic: HE1PR04MB3001:
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB3001BAFFEB4CEBE3451FCEE7F8879@HE1PR04MB3001.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0PlfccsWCswQU3dW/YESZCCTXrBlDirkD3kpzJ4nYd6EMUO8o1spPRL6bnPbdQ0yLw1oiwCWYPaBSkKN5fSvcn88VNYFaBg5dzXusYd9waZpTE3Zdfjiee5vHyQztmpyGm2rtDemRlRpwx3XQJFweaEHE0KKz2+gEiMozCq3PmRk0f++p5wow5EtSGNE1Hq64WUQGq3IddYl+U0O/GJxTnjTNjDOStLNf53aNQrX+08+aH3TFjgg5tBQEwnyKhu6vGKIizyExntxFNQ464z+1XXHedgVhmKeBEy8iWRMAbpInuRO/qK2Wa0+ywi/9dGJzPHc7cfWndviQUS1hwRFEPHQceKT6zQeboqHBugOujqnVBmIcGbd2oFtMhxYduwHW5aUiXnWl7+zI2+rLprx2Yc8591Tm85/tSYnj8MJBScXSgyRn9b78tOY/PmNdo5sraj4IyjhMMKpGKFOTPpbrj8ow/C3llbZp37y6KLvRMTz6PLeJ8G3NYgDSxvhKm8GKt/igDtRpTL0UKYRz47EeLQ2MOX4Q0BcYhxlgouOchbGDJStJ7rXBMviXyL0jfiJ1D4YKu3hImYbqQTG94VOCpjTifvIYkwVVwty06aBAsyD0qAuyf+BkhvN+aC4a+USQpaA0NS7+6KGbe5SFN8xvN2wDGC7Ne/g2ccQqdRyLwmsbPFdB1n5uBiN7K0vlvd/mOi6cuHEYDqNIFhBGRimeWAD5fsYsZX1vmGFKbgC7x0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(38100700002)(316002)(8936002)(6486002)(83380400001)(186003)(66556008)(66476007)(33716001)(6916009)(86362001)(508600001)(66946007)(33656002)(6496006)(2906002)(4001150100001)(44832011)(1076003)(8676002)(966005)(4326008)(9686003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TtwhPUkz88ANAqtkgunDGOmlwRwbKRPg4WDGZ7ZXHciC5cG8uslma97Rq7OW?=
 =?us-ascii?Q?wWOCfKTrN9i06qBdHTO3Q2jSmgNmmt+bXsmy/QehKtUxGIgpTlDq/5/aqM9r?=
 =?us-ascii?Q?gQ6k/R5ierb+zMxD0t+I++5/+jgbYL/ZkSvodZ+ylX3BLogJQ06EQNyL6Vd7?=
 =?us-ascii?Q?+EnnqOYo5YvHJ4AB3eCB5tn6kTBYiM8pcPRfGLErnTM043aKkRUXTvlyBsIi?=
 =?us-ascii?Q?vc8FfgIEW6eSnmUuTXhLfpXi5ijYumdDUgKWCHUPeuqofWddsAGBoSxpY142?=
 =?us-ascii?Q?8EbWkpXe3s+0+4ERhMocNYdNPiQraNfNjQVbn+bdq9niTiPBeCeOhbhtQcOc?=
 =?us-ascii?Q?5IK6cDhAi1HNHrbyG9/o3dpNdC5Xkh/z19wwXmFZWHU9ihYkRMBHLOTceZRD?=
 =?us-ascii?Q?6kwgbAIQws25L6mBx312RPJpro8SUPtBrY/u2id8ILwotO0Q5z1g9IGLtvQI?=
 =?us-ascii?Q?FZvnWYF0GX4j0IxK4SacS9bE4IuE36yC/KOrhO6THcKuwGrvtYJztuKBhIdF?=
 =?us-ascii?Q?6Br5Da2leDB0uAsnqHfonnKocUJMJDvEFl156uMZpmLgbyypXf/KGrxZv3W4?=
 =?us-ascii?Q?zhHzs0VRWLRZQAV4HuxIsTvQOOxqwEFfGF21dP5bSahyLH+KvwZfpSvjMffO?=
 =?us-ascii?Q?p/M1cvLmFMcbY3l24t7XjMBpBjxkmuG9n9tLOKQAYYgx3jJBRTv4AvedoFP6?=
 =?us-ascii?Q?5lQH0dTLvJzn6Rzv0doSagXUFesPhng9pJbSBs65NpXupzWW8T7y5QKOFvep?=
 =?us-ascii?Q?MMJgYz6lcHct3hb1t+RF41PhEzi9ODJ6i1d0FOKxr/AUKh3/VoKOqpbD0UQ3?=
 =?us-ascii?Q?+nw7NuoB/2YzomMBI6xSIi34OJCk7XPco1rAcs6MHTLIdK4e7VfzKfMXLD6d?=
 =?us-ascii?Q?B5FXQ9SXy/NmyyLhJZj5EtzlSkMu1vmaG4ZGLPwjHiG33xP3OXlPvNFqnahf?=
 =?us-ascii?Q?ues97TuyNBJ7pXW6VVwU6Nv9kp7qcJ09W/X7x/gRSU+Fud5UIUE4avFpYePO?=
 =?us-ascii?Q?cX2x9hNhyJke6ZmcjIoMDMCyS8vzU05LBZBpvj+Vo967uNYS0nSYKdsg+EEE?=
 =?us-ascii?Q?dYJwN/PyVJKY6xR1LMFFC2TOivC54xaNj3Vy+XBSffmwfEbxOMulDrRm/r/d?=
 =?us-ascii?Q?+oN6s3aYWFcgiEzQM5Of8JSkoYYAtbSB+8QPglzm50xy5Ss3lUDt5FuPIQt4?=
 =?us-ascii?Q?UI+ZgFa1hEP8fC7YJtWtGuDn17ZNPAtPYny4R7ds5qHcM31HF3e3hjBBekRB?=
 =?us-ascii?Q?Sw8+IbEjuLFH4KjuTCJFDV4GvBYLEQPqEP12cyAjFj6L/r1uXdSOfLAfu/41?=
 =?us-ascii?Q?zouJk9sxSWR5fz9jcjZUO3N0wTLAFMX7AtuxQflScVXC9o/IwZbPdEJbd+Os?=
 =?us-ascii?Q?G3RqJ+bLzi/jLOwoZFZTGGx5WxDnqlt3k+DpOxqANjCSKTACrAaAeYpYFRIL?=
 =?us-ascii?Q?PDU69zdv0WGsop5onF5nEfTVLCYmXqcO+cySpJhZlYC+g2pgnfuBB0+SkQ0O?=
 =?us-ascii?Q?7JnLXb3rAPR78vEPRlqegksqj047bFxh+qDhUQKbOr+GgAzsc9o0Rn4SLMLx?=
 =?us-ascii?Q?X98DrMPpesp3QhkTYbjwHa2P+oqTm+j+rQ0+9nW9iNT2ybSxJMna3/cjpHVI?=
 =?us-ascii?Q?gOaKpN4U+6IJDf56TYHVjiYgPd+HxPUlt8mm1JShyNrYp9dGW8tg4K0Iz253?=
 =?us-ascii?Q?8WutbweksN54unQ8nt0KonzuCRU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ddf0d8-de58-4e91-616a-08d99adf4c4c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:23:29.9357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmGUIqIv0b2/Ji4bkkanIYS2UCMbwMrPWwj5nr9g3ZVgrA/7HiqFT95R1fvW34tezaPJyXJC5p4/YqEH4P75xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3001

On Fri, Oct 29, 2021 at 10:17:13AM +0200, Paolo Abeni wrote:
> On Fri, 2021-10-29 at 12:40 +0800, Geliang Tang wrote:
> > v8:
> >  - Patches 1-6 are unchanged, only updated the selftests scripts.
> >  - The patch (Squash to "mptcp: infinite mapping receiving" for v7) is
> > dropped too. Since this series only implemented MP_FAIL in one direction.
> > The TODO items, "MP_FAIL echo" and "MP_FAIL retrans", will implement later
> > as new patches.
> > 
> > v7:
> >  - drop the patch "mptcp: add last_ack_dss_start in the msk" in v6
> >  - set allow_infinite_fallback to false in __mptcp_subflow_connect and
> >    mptcp_finish_join.
> > 
> > v6:
> >  - use allow_infinite_fallback instead of last_retrans_seq.
> >  - rename mptcp_is_data_contiguous to mptcp_allow_infinite_fallback.
> >  - rename last_fully_acked_dss_start_seq to last_ack_dss_start.
> > 
> > v5:
> >  - move last_retrans_seq from msk to mptcp_subflow_context
> > 
> > v4:
> >  - update patch 1 and patch 2
> > 
> > v3:
> >  - drop MPTCP_INFINITE_DONE flag
> >  - drop MAPPING_INFINITE
> >  - add mptcp_is_data_contiguous helper
> >  - add the fallback check
> >  - The u32 target testcase has not been completed yet.
> > 
> > v2:
> >  - add MPTCP_INFINITE_DONE flag
> >  - add MAPPING_INFINITE mapping status
> >  - add start_seq in the msk
> > 
> > v1:
> >  - add noncontiguous flag
> >  - add the mibs check
> >  - tag: export/20210904T080009
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/216
> > 
> > Geliang Tang (8):
> >   mptcp: don't send RST for single subflow
> >   mptcp: add the fallback check
> >   mptcp: track and update contiguous data status
> >   mptcp: infinite mapping sending
> >   mptcp: infinite mapping receiving
> >   mptcp: add mib for infinite map sending
> >   selftests: mptcp: add infinite map mibs check
> >   selftests: mptcp: add mp_fail testcases
> > 
> >  include/net/mptcp.h                           |   3 +-
> >  net/mptcp/mib.c                               |   1 +
> >  net/mptcp/mib.h                               |   1 +
> >  net/mptcp/options.c                           |   2 +-
> >  net/mptcp/pm.c                                |   6 +
> >  net/mptcp/protocol.c                          |  22 ++++
> >  net/mptcp/protocol.h                          |  13 ++
> >  net/mptcp/subflow.c                           |  56 +++++----
> >  tools/testing/selftests/net/mptcp/config      |   5 +
> >  .../testing/selftests/net/mptcp/mptcp_join.sh | 111 ++++++++++++++++--
> >  10 files changed, 186 insertions(+), 34 deletions(-)
> 
> I haven't reviewed the patch yet, but I have to say: nice new email
> address :)

Thanks :)

-Geliang
> 
> /P
> 

