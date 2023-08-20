Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC815670
	for <mptcp@lists.linux.dev>; Sun, 20 Aug 2023 12:18:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moz7f+D158c0CDnkLMytyebnzI0MuuqBpppM9CjJ487kyCliB2Q0U9/kx2GnFjxczBjQxkv0bOGsvmZVCFpCmJ1ApqGxRNsKtk9a2dhGGszl8iN/zh++VJN4GiqSPz+RTJGQj0OpT4Bc/667OS3aik4iSSCWS3kAmoB9BU9bCmOkfMwPBAQDDt4dzprBmx9RWCgY/XX2zhZUXwvC1JN1JgCmaUPnsygBpYamLOqdR9KZyxxfNIWUQNVTqKjL6vwkFyKqtzVHSjZ9d14IouKcVjZ9sgSOlfQH0fufMAzJfZxlRMJ2vkHrnjZsngJ21qRLRIy9pEr7AIAYe7yxxFWr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u24qKXBEmGE5t4YNUVGcTf1yCo72/rgzkV4guG4hI+o=;
 b=RKF8p4l4CV8Pv2CQvyea04Sdj6OGJfKFb8sTfCmLUz6MLuB9I+A4SC+x2g1d8QDPPlpK2rvHZYSwt4G+BAjCq1GnRG4VDzYEiaE4PV/gP+Vd9gVjiIRRPFQQLmvx13GzY9wkuXKmm5cEkDXHkrDOg3cJq/NeKTrBdUJh0l+D0XyWW7aCJUGgWtjoALPbexJrobdLktSbWHYq16oLCRvNZLtJwfvJ1WuF/h+Ih7D0S3Ar0EZCZcsotvWbCScqzQiuozk3ItmWsVu6mRGXLBrN+5g8Jxf+WpDUicztPCD1FC3ziQ4Mm7Q66MznnSuaxUBTUopS85E2CdS4FXz+1a3h3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u24qKXBEmGE5t4YNUVGcTf1yCo72/rgzkV4guG4hI+o=;
 b=MpvYCKXhply7f0uHOF/tOUpUshg1IgL5pWtYRpqGs5WokHj/AfxysVMO+Et5CW/RMvjEWiXyQO22S3/tMlIKvdgE2DJPbOFt/bEdwGPGD28Rt5tPqSogl6KjCmGC3S0QbzlRhkkEVF90xU5VzcTs8S5TxWEMBhujpdcT5w/qqJEsUyzFMEwRlzjSctQzPaM3lZs9oCTSwblspinnX5bsU9CuHNi7Xa3qoz9Jt6jFFOofui182Z93whxY1uGqWmPXF4LYRV0KVR7WygeJKWvwvv5ogofSvQrQV/NNkqPlCrXYXvdVG7FZ8qk4OEYj07Hfkv2+5IjkriFmbzCZM151RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8349.eurprd04.prod.outlook.com (2603:10a6:102:1bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sun, 20 Aug
 2023 12:18:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Sun, 20 Aug 2023
 12:18:08 +0000
Date: Sun, 20 Aug 2023 20:18:33 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 5/6] mptcp: userspace pm remove id 0 address
Message-ID: <20230820121833.GA13838@localhost>
References: <cover.1692342519.git.geliang.tang@suse.com>
 <3c3c0bdd3e0d8fe5be8701e38f39ce1fd3e20d3c.1692342519.git.geliang.tang@suse.com>
 <fc630d2b-b6c4-48fa-a175-cfadb1dff604@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc630d2b-b6c4-48fa-a175-cfadb1dff604@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCPR01CA0119.jpnprd01.prod.outlook.com
 (2603:1096:405:4::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6ec927-634c-446b-971d-08dba17783a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6wQhgHiox2d2ysztHMXohtU6QCUbFLbfHM6j9dvPf5/OdF5YkLMtoPzhcoDttLfbaFBeysLCjrvUreumwaG5d9wOxzTMuZyiB7Qwgnc4pxnC3p04tQMO9jTn7BiHaTauzpWOIhXt+zOYZ75G00/2YtjwVMqKhhWj2vVbQP0yfxE8v2Ztrr1SbI42uNktwapRjsVzLDKStWocbTUAU/ct3rQY6YiYe7T6KJonlhz/c5Lgyj7gWZYB/8kZMKffMYN+xiTPEGvOyPepm3AapjbCuPS5Z5pO3lGiJrYnOFbwHVi+zPYODLsM26nzRIqXoGjELFgqnCdpfzzFS3uDxxdosFw4DpdOB0mbA8DUaetrq0nzSZgZycLmmfInHq8Yg7yubGeEVe7fQKGKQYqmQIrvmn3pg6HXU8q+9AeJ63HMeu5qnGg2A1HJprf7DojoUee35P1mha7rolPeKk1WPU8HA9hBGzEcJPVv/1z+FO6CkNnU0he0SMG8TyXlWUy2AqvUpVZ9OT9a/ZjOU0mtqvHt5QSLxsuLuWsVBhqPv/moL0JDkHo27T8c2p7YTAVgEjLcloMOFXvK3eiGcRGbn5cAhNr0jUHS22GcA+Zh1p4X+W2ZNL6eY0Wk2hhPyBAljH43
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39850400004)(136003)(366004)(346002)(376002)(396003)(451199024)(1800799009)(186009)(33656002)(316002)(66476007)(66946007)(66556008)(6916009)(2906002)(44832011)(4326008)(5660300002)(8936002)(8676002)(478600001)(1076003)(26005)(6666004)(9686003)(53546011)(6506007)(6486002)(6512007)(83380400001)(15974865002)(41300700001)(38100700002)(33716001)(86362001)(966005)(13296009)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sT9XOjlRiLTzgqtWVZ9h06+pHBo7pl/Ciw83PttgGkb+eZ9qu+Ht3YXeFjwM?=
 =?us-ascii?Q?X7sU0FmDX3B73Vr6DUAxoEZ3e889SeQ338OuD4xfn6V8KcldvqZwgB1QVStg?=
 =?us-ascii?Q?gBpPAtkV6G5sxbQyHpa2SOIFNxg8X2//QgXyklWsKza9M4SwRADHA/67vfar?=
 =?us-ascii?Q?nlzu7KyxAbX+QW8dBmfwldiJi1LimSn+iGcUsgxe1k7RGQREfXn/M4m3iBXM?=
 =?us-ascii?Q?vjygJryMokw4TjfcCcf1HgxqU1kVlLSVH+JTy1fCokX0KdOqNAY/K/n4eHg2?=
 =?us-ascii?Q?3NaYA1k/siWbuhy+csWOlYf4bM/9LBDR8lv+QWj7Yd8axKUjXRNFsyEjxi4V?=
 =?us-ascii?Q?NsLGspp+v1cgVuvdzje1XZUsDm0FbjWNVUs4yaCDlQkkJo+jmOUm9YI9JK5G?=
 =?us-ascii?Q?D9WDQB+w4Wg4O5PEgLgVXK7eN88tZ0HTONao7FTFz7Ofmvj4+h+yqtYk8MVY?=
 =?us-ascii?Q?gtCP3uN/XnkrdBEYRd5r3i7GXukHmnhsdy/GKqkc8x5VeSUykLA/eWS3GcZA?=
 =?us-ascii?Q?uh5/zuI8j8tht0T/ZRZqAOqilVluitXIFsWAGkzEK81vBCEV0E4XqYAPYPrw?=
 =?us-ascii?Q?5fSRTNGnkI7ifIBabyy4hU6oJwPQxQ+VfLMp0hXalba0p1pNojwCJvzgH769?=
 =?us-ascii?Q?sTxdyZM21XkzR71oqM+SZAV8Rklne6irDniwdj2dD5z3YWqgBXhe+P0kLKzj?=
 =?us-ascii?Q?xc1l/3VSJvQT5RrNimUHTcTik50mO519VDw/M0wvh/hfeZQhV3RHq7hzOI2a?=
 =?us-ascii?Q?14bkW5io47WIEB0+Euyu0F46EIr/pRlgqkwLgRwl6i3JT9KGytebUw996WeO?=
 =?us-ascii?Q?4P8pPDjb3BY4MKZ2CKbSvwjTuxgnrKGnfJ+TpBHPMTclHqrXxRTBiUqbxUfK?=
 =?us-ascii?Q?nakFtLHA3xbwfxXpN7egl+L5un9AwmZcuE3WuJEsFyk6Uhu0zZvCAcPgS+RV?=
 =?us-ascii?Q?e1MDrQnvYdLcyTtCeaM7h+cgGxKpKdmOjfBheeSK375qvB55FAZ7QCG1KpqD?=
 =?us-ascii?Q?3A103yToNXFD0TUQtLGYYvpqjJ9n5SnxnkNwXKoSiOvCje3jesPOt1gNN/MB?=
 =?us-ascii?Q?+L6rJP0iOgOULg8F1PsCgxAnIZpIzn3Qfm/g61LSeFPUMrwM1YM5vmJ6qmu+?=
 =?us-ascii?Q?SrmHMW7QS0k7zfvGipEIPbqDR3FyH/oP/Mj6RXiu5mB9NzCF+EZ6Jc44+xWh?=
 =?us-ascii?Q?SGWaUHrSOZ+B077g58kGC9hBp2yzvJEUwXiVIymWhYgrOTmcQluGR4gwo7QV?=
 =?us-ascii?Q?/8Takpr33GjDE9kIEEZYwj5GjQt5P1p7X4jfO4bukElh+1U8AwrKGsDjzuOZ?=
 =?us-ascii?Q?UMDxo0XzHXR8fYnyOklvxEJgqUenAd1VL/HxVnL0s8YYQnHD7Cc6A1Ic0awE?=
 =?us-ascii?Q?r9nwjJ8+6OAhJ0KvCD3PxpwvnOn0Oo/opm1PtHbueUBoQAMbp9rnxG6GF1Eg?=
 =?us-ascii?Q?31ySM7g7qHSXkw+LwAZc10YL8NtzNRynO7Oy8bNRoNe7gn2pMNaGEZGqwnHT?=
 =?us-ascii?Q?u+BbYdmjvO2cTmSk+thP9jDAmzCfbw4Ap2dyx2n719bHzHJcxX/W/ZPEWzjT?=
 =?us-ascii?Q?Lt6rWSzZ0e7zovad0WhE8vPlqeRAlhNkNqhts3UeAYxQQvXE8gRSLV87//c+?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6ec927-634c-446b-971d-08dba17783a7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 12:18:08.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GryPuCdHmUIfpg2CvgseeVGQ/+ikveBKAueFyuYdJSmmUdFk1cVGaIkkalIKvfJInZ8vCEfSAyDJVRfT/slX1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8349

Hi Matt,

On Fri, Aug 18, 2023 at 11:30:01AM +0200, Matthieu Baerts wrote:
> Hi Geliang
> 
> On 18/08/2023 09:12, Geliang Tang wrote:
> > This patch adds the ability to send RM_ADDR for local ID 0. Put id 0
> > into a removing list, pass it to mptcp_pm_remove_addr() to remove id
> > 0 address.
> > 
> > There is no reason not to allow the userspace to remove the initial
> > address (ID 0). This special case was not taken into account not
> > letting the userspace to delete all addresses as announced.
> 
> Thank you for the new version!
> 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
> > Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  net/mptcp/pm_userspace.c | 42 +++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 39 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> > index d042d32beb4d..059b672b55f7 100644
> > --- a/net/mptcp/pm_userspace.c
> > +++ b/net/mptcp/pm_userspace.c
> > @@ -236,7 +236,43 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
> >  
> >  	if (!mptcp_pm_is_userspace(msk)) {
> >  		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
> > -		goto remove_err;
> > +		goto out;
> > +	}
> > +
> > +	if (id_val == 0) {
> > +		struct mptcp_rm_list list = { .nr = 0 };
> > +		struct mptcp_subflow_context *subflow;
> > +		bool has_id_0 = false;
> > +
> > +		if (!READ_ONCE(msk->first)) {
> > +			GENL_SET_ERR_MSG(info, "no subflow in conn_list");
> > +			goto out;
> > +		}
> 
> Sorry, my previous message was probably not clear: if (msk->first !=
> NULL), it means the initial subflow is still there and ID 0 is still
> being used. If it is no longer there, ID 0 might still be used by
> another subflow and it is required to iterate over the subflow list.
> 
> But maybe easier here to skip this "optimisation" (remove this block
> above) and simply iterate over the subflow list like we would do for the
> other IDs.

I prefer to skip this block in v5. 

> 
> EDIT: mmh, if there is another subflow created with ID 0, will it be in
> msk->pm.userspace_pm_local_addr_list list? (I didn't check) If yes, it
> should also be handled the same way we do for the other subflows. In
> this case, maybe it is not needed to iterate over the different subflows
> but only the local addr list and if not found (!match), just for ID==0
> case, we check if (msk->first != NULL) and create a fake entry? Or we
> always create an entry in local_addr_list for ID == 0? (I didn't check
> what would be best)
> 
> > +
> > +		spin_lock_bh(&msk->pm.lock);
> 
> Is it enough? To iterate over the subflow list, you don't need the msk
> lock? (lock_sock(sk))
> 
> > +		mptcp_for_each_subflow(msk, subflow) {
> > +			if (subflow->remote_id == 0) {
> > +				has_id_0 = true;
> > +				break;
> > +			}
> > +		}
> > +		spin_unlock_bh(&msk->pm.lock);
> > +
> > +		if (!has_id_0) {
> > +			GENL_SET_ERR_MSG(info, "address with id 0 not found");
> > +			goto out;
> > +		}
> > +
> > +		list.ids[list.nr++] = 0;
> > +
> > +		lock_sock((struct sock *)msk);
> > +		spin_lock_bh(&msk->pm.lock);
> > +		mptcp_pm_remove_addr(msk, &list);
> > +		spin_unlock_bh(&msk->pm.lock);
> > +		release_sock((struct sock *)msk);
> > +
> > +		err = 0;
> > +		goto out;
> >  	}
> >  
> >  	lock_sock((struct sock *)msk);
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
