Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2841E7A
	for <mptcp@lists.linux.dev>; Wed, 23 Feb 2022 23:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645660275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AoR/ZdXqKH8g5XyAkFsHYK7H7GGzG56Yn7yDUha/9Z0=;
	b=WkqAwGfq1X+qEoWvHHHIZVS/KKhK7Dcu0IfFKJtphNnd+se6r5T3Yb5y9W3rBVyM0pnMFV
	Pfvg8Acvljp4QmMBPUrz6XAMYET/2xBCqn9qK6R5me4pguFxp5Hfc2/ztWY8rkMKnoN2WR
	dCWWYv2FWilZCB2mZdwceZTAcLQ8IFA=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2055.outbound.protection.outlook.com [104.47.4.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-nYV6eiQDOViFH1lEVyiUzA-2; Thu, 24 Feb 2022 00:51:14 +0100
X-MC-Unique: nYV6eiQDOViFH1lEVyiUzA-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSzwoBr5ObYOt4o7tjt6/eDhhhHgcTGL0ECHRLdtfUA8/ZUcNrN0j8eHINHQYUe44VGWcL3iapd/UXaB/UWvHCZgZqL80yaFwSOne+gs14qyNS92FEzZ8yTTIHKuWHEbMIrGsIyApsj1Qvcb3a69gBC/7nWqPkQ00kZTE5PXbkuo9Rpe5c6eeCQ6WWY8a2FsilJkhMNExVnO0u9DeBz/G51xGByD6+7qpUUj9ogeHLN28mZZMOiW1WXQtDpEpqBdOnxwI31PD4He/87wCvsoKZJGR8oE4PXRmnmuec03/AM1TTwI46k2M6ZGOtTu0xHYVZelgzSw/X+gk8zMpu4xHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoR/ZdXqKH8g5XyAkFsHYK7H7GGzG56Yn7yDUha/9Z0=;
 b=W2Z+ss6dm3QNPhXyNGnzmXrDESJhK8px2YJBQNe7Jd901x7yizuegEOWrWfX8y/2E751SRIzfMTd17cRpQqTrZmAhknGic9IC9Jgzh+363zu0oXX6cGjkfldEcOfv1fhpxDfutNET7MCTQYryEf3rcOKYk0bB12NsKbqULxUJFuLzwyq4LKCpDRefIMUeDq/c2Rnks0MQUi3fP2pzuHYiReYwKykilskxr0pifdVSPVBuJHtfR5yoFnP+5h1TJ8Z0KSxRPkKG1XzVWrOjfXGpPTM6H45oRSAvlp9EqPLaWqAGmJErCHjDKgBrNhNoVo4x3F6eRYYYLKPsiYw+fPNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3857.eurprd04.prod.outlook.com (2603:10a6:208:b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 23:51:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 23 Feb 2022
 23:51:12 +0000
Date: Thu, 24 Feb 2022 07:51:46 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: add fullmesh flag check for adding
 address
Message-ID: <20220223235146.GA4231@bogon>
References: <02d082c77c58ed6400d319d40e719a4ebe4e7942.1645419055.git.geliang.tang@suse.com>
 <7cba6dc-53a-29a5-a684-6f47a39cf568@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cba6dc-53a-29a5-a684-6f47a39cf568@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HKAPR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:d0::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 428a3a84-f2f3-4c59-4257-08d9f7275f22
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3857:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB38573F129C63CFEF03C482D1F83C9@AM0PR0402MB3857.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T+QgVflJ4G1c5qhPjSLyyUQJjaQ3BYtcUUcw4Pc98UoBR8NG3VRdEDDG+9aI+95le1FeclPbXb7WgLCw8N8VR7X4Rbjm3Sh+CrY45t4xzvEoM6aWdK1XgnS4EykxRLCNbqNDEClKneVPWt/qGL56Mj3fg52AHlzRz/3L0EdV0Tyd899GS/94b6nlG156eyLC42DXDZzO3OAK7J3/DDZLtU0ioA/CIrOvDJw9SDMmfnqdW31KLuyhQAtE0oLNVYBlk9Fst60x94LgCG+qwKtQJDK1mmYnVfOIZvC7zO92rp+YmxrVHSpg6BHackCnZ6dIesUQcrEKGxB9C7g6R9mus9FBmXOo2yq9UekMnyVHF6AyG4g3udl/5BfxL5BZ2EeeIZZES1gR1dqoZHlKXl0l6wSQo39I32AI1wNpMOqNaBsgi8zSsrwJtZnfKVTRb/8Q5x1XoGcG3Fv5HJuP/3tOiLP7NiE2mIpMrYijpLlBdptjvIawgycboW5q41zchI0nOeeirL+jueEDPlxzmXBw+QGdKyvFYNxVFYfQCnou3Bjv1LOGBfBzGRV0S4XXy2RPT3B7tHrDTaLe62zPEw/r0vhXcXqK4igxJqSYlyiUmbdnmjdUa6S6a0IKbLK7mFloVO/PGqv0geAwxIz8LLayLg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(86362001)(44832011)(38100700002)(316002)(8936002)(6666004)(5660300002)(6512007)(9686003)(66476007)(8676002)(4326008)(186003)(66556008)(508600001)(6506007)(33716001)(2906002)(1076003)(66946007)(6486002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+1aNK7YT2hZmJU8AolZ11KQHUGV7cThGD+PZN2/cbr8waAIMFPSUcvnR3jlF?=
 =?us-ascii?Q?Nj0ncSAWdWuNspSmdVj2evwBqqpWbyM7Z+9fcXvZu+Odvo5CcVLzH8OetinB?=
 =?us-ascii?Q?KQYJ6ZitW7Eu+CrMos4m8XCwFR/EsS58OIBxIAQKu2P/fyGz8TBvyuMpndw5?=
 =?us-ascii?Q?mow20Fod4o/xjG5Wq3EdCOOs5KDoWl6Yg+FwoKAgDHXeyESe7fnS6hvabpeP?=
 =?us-ascii?Q?GmJkdI7va9ms30DDwuVibcxH/B5N9Ltwx8ovwjgr/h53W++eHmKWYbyu3+yg?=
 =?us-ascii?Q?QWucF5FCocup+jwN7gwXuU628mW/8QwQR5UX/a/1SLdpJvMLtj8tVpZ1RyAV?=
 =?us-ascii?Q?ohft18hOUwV8J40rLx9QP5sd7aQ6xca3UGLQg72MzaTw6SYsatMpsZs/x12U?=
 =?us-ascii?Q?GMrxgWDAAQP8ewOMY5iRuzyZbcGD1HxgeGFgN7ySaXG1f/O/gZ+4hCBEsuib?=
 =?us-ascii?Q?gLeCKcYVftHQ/8wfXYrt6G3qTi6fQEkt4Ekex11sZGxzHeFnDurf/kwkU2aa?=
 =?us-ascii?Q?4OjF3XLQ7snk836fgnZcgLYH0ZCnHe5JUad5xr78Mh3ljPTVDLfV9B/qBoNv?=
 =?us-ascii?Q?9qtNqdb80eNSWNVu21Dn1ZVztNyyGeU6RgKkrR8f620oI1LWFGMLVCqv1+J9?=
 =?us-ascii?Q?9dLw0QNjJbK+EdXar7NCUkAsUHuZMvfnfruNTT8LpACFq2nU82xvu5lAsC1J?=
 =?us-ascii?Q?/xhADue4gfHhTybaLFgEyXOnhfJJWipkdVVcQ8uIRgJXyJE0Wjg2C3pdFU6J?=
 =?us-ascii?Q?Vdkobce0IAvUa095Mj5+Sz5Tp4aIy5zbssb1/0hjwgYYAfOYW5TGQZBYOfMJ?=
 =?us-ascii?Q?ggHu9Wim9ZSwy8CNg9msY6BSlj/Y+CABGQpSQNWDGfJHC31qH6PqD14jF/Ar?=
 =?us-ascii?Q?4cDNsxgqh5nwHS0Ht3rAYlD+farT+VW/rtOxDgXM6sjJKtvUQpjgXmB9B1Ue?=
 =?us-ascii?Q?jVF237IRo11+n2A26qee5lf9PCX+zFQtMvlsDjTCUTx3ZpMQqootkhVJGD4y?=
 =?us-ascii?Q?/zgtrSgzfb3ZT68Lj4DJuZLHvlYvibQ/l99C9SQh0s49cvTS8L7P7JCsdTG1?=
 =?us-ascii?Q?ASKrhk6aH+8upQTfXVzLnjgt7qFOM+dc9Zy6SLGF1SYhL7u8JXG2h18DRblU?=
 =?us-ascii?Q?IUGXcUGLAtoP5cF9RqXatK83Lz2B8UKBC7bXWya5aPnxDYnxXcjt+IBwfAV2?=
 =?us-ascii?Q?EW5mFC83PoGj3fQGQ9zGBJoqGK/EwxwvY/zooMZqkDW0+5YmP+N0fJKZHLNx?=
 =?us-ascii?Q?FM9V2SCd4LdPIRvOWqzAWK08M4b6p6pPxfv/L3cwkFHxx7GxwIKJMNCNx2YL?=
 =?us-ascii?Q?r/VIYWlc0ZIgK0qzljKSa5DatwaLtt/6M2L7NWZSOOE8sMQivVIFi+gTlrfr?=
 =?us-ascii?Q?8INiUpgmPOfDMHmYdJ1O6ZCoTCNLOAEike7HNmTf6rJBmwJZ3KMbsTaHkAD6?=
 =?us-ascii?Q?vo03II0TJc01KCCTuipqzwUd606DjQfJH+65PavwAOPoAYZTwcQWGguagz5W?=
 =?us-ascii?Q?gIsTQLajo0GXAwJzhfzoAhnZqxxE4qoQuptwkFYOOkGYrtUHI2Cf5Th2poKZ?=
 =?us-ascii?Q?VTzou1cpQBSOXneBzeKKSA4d/TvJgiIkAV+u6AKORZcmw+B0Y48ZYrzzr95E?=
 =?us-ascii?Q?isDvw8XEOIUwbxEDjtWEJDQE44AEcC8mFj7Fi3WSA6VCnGl1xjq8zJ5hmcQZ?=
 =?us-ascii?Q?0rYMDz+XhIFo/JX8/2fEc7Fkkj4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428a3a84-f2f3-4c59-4257-08d9f7275f22
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 23:51:12.4314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4y1dooiRK8Ts9EaLBlvR1ctWAdk2nmPXUpU6Uuuo+nQ3WCrbt+4uFTA6sPQaPe0rwrtTSZfNsMonFfpvdutwtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3857

On Tue, Feb 22, 2022 at 04:52:40PM -0800, Mat Martineau wrote:
> On Mon, 21 Feb 2022, Geliang Tang wrote:
> 
> > The fullmesh flag mustn't be used with the signal flag when adding an
> > address. This patch added the necessary flags check for this case.
> > 
> 
> Hi Geliang -
> 
> What happens if FULLMESH and SIGNAL are used together with the existing
> code? Is this a patch that should go to -net with a Fixes: tag?

Hi Mat,

If 'fullmesh' is used with 'signal', 'fullmesh' will not take effect.
Since there's no address signal mechanism to send the fullmesh flag to
the peer. We only deal the fullmesh flag with local addresses.

Thanks,
-Geliang

> 
> -Mat
> 
> 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> > net/mptcp/pm_netlink.c | 6 ++++++
> > 1 file changed, 6 insertions(+)
> > 
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index a0e7d5b7e22f..e3b0384ff79a 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -1253,6 +1253,12 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
> > 		return -EINVAL;
> > 	}
> > 
> > +	if (addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL &&
> > +	    addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
> > +		GENL_SET_ERR_MSG(info, "flags mustn't have both signal and fullmesh");
> > +		return -EINVAL;
> > +	}
> > +
> > 	if (addr.flags & MPTCP_PM_ADDR_FLAG_IMPLICIT) {
> > 		GENL_SET_ERR_MSG(info, "can't create IMPLICIT endpoint");
> > 		return -EINVAL;
> > -- 
> > 2.34.1
> > 
> > 
> > 
> 
> --
> Mat Martineau
> Intel
> 

