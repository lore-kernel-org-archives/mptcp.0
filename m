Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB8715C5
	for <mptcp@lists.linux.dev>; Thu,  5 Oct 2023 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YeZtLyZL"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Si4SgKflB9oCtvQMVyjRK7T1S0I60plFrGcqNHXQrvT2YRI+SazGqGrRIjlURCb+axuJ0sIizNtNjzEaTeT8SRxUwveGwYTjXflr1fqfY5DpPr0C/mCCfDaMtV1Jn1Qhq6z9PSGE4Z4IWAmmqvBo7Pmgzx25xu9W3dycZNy6NG4fnlv+Evq9RdeEFqZUl0F3CInnDX46sm9tpol5RKwv2yahhZB4R4XqF20DNeXztrxgHtd8db2dVW0W3EJGaAED2ItT39q9kxEIFBtztqK8BfmpY4cw54o/wONfTnAzaMB6Tt9JeBCDj5m6F4oiyHEazji3T67o7CkwMl0dlIrxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MAgM1VvF45V7Ic1ZUqEOB0y4RZYUsp7fWTmuJmpAVs=;
 b=bG8SPjo5xRHKP9ZQGy/sNvp3w0JdRdqbYKtXWzTOyARiEmt5/U8lwqe4iUYFQ3eqn4UC7CKPQ7HGV3rXSTXSYV17+yuwBZ595esun1ChbnVksUizU+bB7WMgZh7vm7rBflUe+lx79LT1+T5ZEHVDXKSot4lkIL5WBOjs2MuLEevr/OjE6UqJj2SKPQt7YFZ7VwcOf3LBo5fkFSJc/RlTQHdPlRtyGaIVrJL/76iA/w9xNd2l1+84cZmpJ7F7M/3rYaRU8l/SFTqI6n8Op/QYt9vvumHKYyKgphrXHh2iXfvnqSOtsLapp/If52XQssDEqGxCHtN9fOwXCrD2osncvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MAgM1VvF45V7Ic1ZUqEOB0y4RZYUsp7fWTmuJmpAVs=;
 b=YeZtLyZLeShLEFob+N7I6BxZcuOpirn/FYmIBiIXMAMDiVGIui+EVnSOcxles2Bu9654W1/ZzMHrClxsTd7U3QUr66+hy6j/NzxYy5fNdAgsGkpSZgFfCs667Vh26baNpQX0llFInmf/acucHl0smkWvgEufI+c1J2av33LKzgF1L4JTufL+fAN9bjOeCKWrMLLo8a9SfO3aG7wxZaJfO36NnemSlYyItdUkYSaoDRfyJtW7x1DFgZeHv3xJBinr896oGwNEmoMHMOO0qZzm463lZeAIekP8XQEoO2BtycIn4Yu8Q60Is8NvfM8PU/AmlNw0OKDMrucIxY2u681prQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9751.eurprd04.prod.outlook.com (2603:10a6:10:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 08:34:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 08:34:38 +0000
Date: Thu, 5 Oct 2023 16:35:47 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 15/29] mptcp: userspace pm remove id 0
 address
Message-ID: <20231005083547.GB23632@bogon>
References: <cover.1695631132.git.geliang.tang@suse.com>
 <1119bff10cfc3c6b3fe4afc410f7803f27f49f1b.1695631132.git.geliang.tang@suse.com>
 <6c6bff5e-56fb-49f7-af25-d5cb1347bc63@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c6bff5e-56fb-49f7-af25-d5cb1347bc63@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCPR01CA0164.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: 880b2623-ed6f-45f8-565b-08dbc57de95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2IC07hM9+xquzMdydcTEpK4RJe3/0wVbuxH5KkRrwB9A3JWtnz2/u9q8gp5wXuPfga+DG2Zv1sezY+Oe8XiZd/li6eomy7Hlu9iaYjoRpvMNdOt00gSbPeii1+BcRog7CCjYHEmFcwNlS4VTl5Lm5OXfhXyVxeV7r/cJ4QucS/2n/eCP9LbTXSINnALdeffgIeXAjUIpdecAPiceSrgC81FYY0mAdKE6ZqPdpdPEQaMGoBPjO6bpzWcC6zS1HA3XdKnj27hQZOcQg51cl8+ZC0ddjomiVVwGwM6gYZKmogFnSkvR5e0aZaWKpAFyPFVw+pAJpAkH2qRGPDZuuXZUbqrFKDzv5MKSqW/3CK9EjwUrEO2gqGd/dGI4ufEcMrbU2Y+0ZrmOwvOUX9PHBXXEoybSnpIflHgStvpy5XUxs3weS6acwTz5ZC3k7c3y4hM+50geqRmlpIoYmlGaeIL6FRO3Ta4kl/+9b2nSnNddbN0Y6V3LvlyFVgvrtEIRWa4dbYT/tGZOnQl9ed9KSs+ZN16Sq40NEdU5bTcFL8yx7c1HUag+Dpzx7oUuBxVRO9QJa3tXYI5vQdVggok9vj9lwrx+XcH/K6jlqfAHkeUq04MtS0uH8Dfg1CaNH6fJtLee
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39860400002)(376002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(478600001)(86362001)(38100700002)(26005)(966005)(1076003)(9686003)(6486002)(6666004)(6506007)(6512007)(53546011)(44832011)(5660300002)(8676002)(4326008)(2906002)(8936002)(110136005)(66946007)(316002)(66476007)(41300700001)(33716001)(66556008)(83380400001)(15974865002)(33656002)(13296009)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEd1ZnBJM3BNTXpOc1pkTllSc0dFOUhCTVJJQzNWVVAwT2lEb1Zyd3Rick1p?=
 =?utf-8?B?QXZvQzAvNkxobTRKUGpub2VObjRoVi96OEFUcjltandzckIwaURXS2xFbTNT?=
 =?utf-8?B?MXRTa3N4R2tnRGZETTJxT0NWYWh0eXgvclNSOUZ2WG1wbldYaGkrd1J5ekNB?=
 =?utf-8?B?MVJ0d3dBSXhVREdCMmFreERnUUlMdjFLVStHT0hobTduSHJ6dzZleWNnaTFq?=
 =?utf-8?B?WXF3RWFuWFdDY2szTVRseFRQb0EyUEtRTDBqSmExVlZEYzhwMHZjQUtBN2Nr?=
 =?utf-8?B?a2MzWHR1YzV4bjRQZ2xFSEd0TjVReTlPNWVFR056SlVuaGh0Zmc1SE1YeDlX?=
 =?utf-8?B?Ymwrd1VGVmkvTUJDMXBYWE1kYjJKV2Naendra0xySU9lMXBXdUtQVDQ3c3d0?=
 =?utf-8?B?T3JVSWhLaWN1WUV1U3FvZi9xU1dxaTQwQTVZTGx2MHU1OCtZajZ2YUxPT0ZX?=
 =?utf-8?B?TFJ4NWNTb0l6QnZFZVk1WEljUG1ISkpRc2dlTjhXcmY5ZWxUcDNjYWpIVmZx?=
 =?utf-8?B?RlZubWNvMFFraDhxNm53K1hDcWhpRmt1R3NJOGtRaUtsNk00MFM3TVUrWThr?=
 =?utf-8?B?N2pIUmRXTlo0MzUrMW1OYjNRc2VLTU5OQkxyNDBkVGhJNEE3Z2NlV21vdmpT?=
 =?utf-8?B?VWhYR1N1S0VZTng1TmFJOEpjTHdUa0Qya2I3MnZrWXRxU0JPaUVWZUdJUlE4?=
 =?utf-8?B?ZlZVTVRKeEM2MFFwK3p1NnZUUENkQnY4UWttNXNWZjJvbkZiemlJcXB0d3Aw?=
 =?utf-8?B?aGE3bmt0N0NvbmdGV29NWnJLUytIVHNjNTBKeXJnb0srNXNxQXpKWG5yZ2lt?=
 =?utf-8?B?L1dVZmN0WHIzSUw0YkNuVko1RUpCUDVnZENuU3NIVVFzRFNvRm12elZFaUh6?=
 =?utf-8?B?bldmNWZ6Ri9EQ1FkRWdSMnZOMXJOR2xHV2d1R08yUktieVlUaThwK1laRDF2?=
 =?utf-8?B?WFVobFdPV3NUZVRLZkVNOEFaWXdDdWFmQlZYZHdYT3A0YmRhNDNMRDBTSzhX?=
 =?utf-8?B?NFJta2ZQaXVnek5VSFgvWHd3UU91dW85bEVUWXJ0QThDcHZLVTlBbXlHSlM2?=
 =?utf-8?B?b0FUdUt4cURlRVQva2VIc1lkR2dZUUN6YXY4QWZaQ1FvMFhWSU9ZN1FobTVV?=
 =?utf-8?B?R2FBNG9WVjNJSGd3VHVENngwbFBnSmY2LzJZczdpWnlMVE9Ed0x3SzJ5SkRy?=
 =?utf-8?B?ZGphekhja3MydjN2QXU1Mnc0MG9RTFh1RHc4ZllQNXJhU2RIc1ovMDlMOWNl?=
 =?utf-8?B?ZFQyRzFhQW5VVlZzNzQzU2U5U0JOQy9PMGxIYTJ5eE1oZnJveXBFZDRGQ0w2?=
 =?utf-8?B?RTJiZk1DVDZmcGRwYnE2Mk1qTVN6eCt3VTlwSEN0MUVzclNERitvVHNONkRi?=
 =?utf-8?B?RWhUNjJScEo0aGtvZUpGbFF2dDdwNmpJekVZMWlLcm8rdDZyTTBJcXZCQW1Y?=
 =?utf-8?B?SDhneHJRbllCaGpCdDMyNlQwaC9sdUNvc3dkTzUvVktNYVp6SjZxcGJ2SVBU?=
 =?utf-8?B?YWdLMTVjVjY2SzVtZXo1YUNkcTFjZG5qU2tlTzBtdHNldUJZV0NiK3NUaFRZ?=
 =?utf-8?B?WWpKSFlaOEhzRURTSHl5bHdTbTJoTWgvWGFiMEVlRi9zR2w1SWlNbzZoVFFw?=
 =?utf-8?B?VWJ2aTdYcndwYjdCUXdXajZ0UEtOM0JsWHRCK3I4Mng4enNsYVAvSVZsWGV3?=
 =?utf-8?B?TFFzNG9ONjAya2hjSFBVd1dRb1pCVXFGUm5PUlBrSnhKblEzVUxTOUlhM3VK?=
 =?utf-8?B?WDFuR204UUEzREdRU2QrRnBRQ0tXK1pMWWNFbDM4eEdaUStXSlVnWDA1NU9l?=
 =?utf-8?B?K1ZVYzBVODcxRGtBVHZnb29CWks4YVVURTF5aU1yUnEwSHFMNVB2SVJCWTVQ?=
 =?utf-8?B?blQrbFhLeGxNWDVOY2VJK0pxSUZGWllsVmJXSGgrekNwNTlnOWVPVG5qZlYr?=
 =?utf-8?B?aW1hWlplM1c0NE5IZmVwVE1mNTBiNkRBOE55VUdiRFJWd3FDY2pmYXJ0MVFh?=
 =?utf-8?B?Wkx4VG00NGZjeUJyRXh4bVNuUjJ2TXVzdjF1QjhxSWZDV08zZTBPMEJUMXdU?=
 =?utf-8?B?c2FMQ0NrQWx4c1BhVEZSbmh0ZE56c1d6YlBFQUVCQzZ2c04weXlhaWdYakND?=
 =?utf-8?Q?7xcVtn5mG7nG8TWTJ4OACVJBa?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880b2623-ed6f-45f8-565b-08dbc57de95e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 08:34:38.6554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbCGTNDw4bMmAnOb7YCR0FXeL/EVC6yKSZThBFt7B/CjwfHmK0bVTzlEkmjRU62+GpFr+5ahWkD2EqjItUkJ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9751

On Thu, Sep 28, 2023 at 11:00:55PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 25/09/2023 10:41, Geliang Tang wrote:
> > This patch adds the ability to send RM_ADDR for local ID 0. Check
> > whether id 0 address is removed, if not, put id 0 into a removing
> > list, pass it to mptcp_pm_remove_addr() to remove id 0 address.
> > 
> > There is no reason not to allow the userspace to remove the initial
> > address (ID 0). This special case was not taken into account not
> > letting the userspace to delete all addresses as announced.
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
> > Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  net/mptcp/pm_userspace.c | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> > 
> > diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> > index 6b8083650bc1..8d97cf475cac 100644
> > --- a/net/mptcp/pm_userspace.c
> > +++ b/net/mptcp/pm_userspace.c
> > @@ -211,6 +211,38 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
> >  	return err;
> >  }
> >  
> > +static int mptcp_userspace_remove_id_zero_address(struct mptcp_sock *msk,
> > +						  struct genl_info *info)
> > +{
> > +	struct mptcp_rm_list list = { .nr = 0 };
> > +	struct mptcp_subflow_context *subflow;
> > +	struct sock *sk = (struct sock *)msk;
> > +	bool has_id_0 = false;
> > +	int err = -EINVAL;
> > +
> > +	lock_sock(sk);
> > +	spin_lock_bh(&msk->pm.lock);
> 
> Why do you need to lock the 'pm' structure? mptcp_pm_remove_addr() will
> modify the 'pm' structure but it will also do the lock, no?

mptcp_pm_remove_addrs will do the lock but mptcp_pm_remove_addr does need
the locks.

Thanks,
-Geliang

> 
> > +	mptcp_for_each_subflow(msk, subflow) {
> > +		if (subflow->remote_id == 0) {
> 
> I only noticed that now but you need to look at local_id, not remote_id:
> when we send a RM_ADDR, we announce that a previously announced (local)
> address ID is now invalid → so we need to check for local IDs here.
> 
> > +			has_id_0 = true;
> > +			break;
> > +		}
> > +	}
> > +	if (!has_id_0) {
> > +		GENL_SET_ERR_MSG(info, "address with id 0 not found");
> > +		goto out;
> > +	}
> > +
> > +	list.ids[list.nr++] = 0;
> > +	mptcp_pm_remove_addr(msk, &list);
> > +	err = 0;
> > +out:
> > +	spin_unlock_bh(&msk->pm.lock);
> > +	release_sock(sk);
> > +	sock_put(sk);
> 
> It looks strange to me to do a 'put' here because we didn't "hold" the
> socket here in this function.
> 
> Should we not do the 'sock_put(sk)' in mptcp_pm_nl_remove_doit() instead?
> 
> > +	return err;
> > +}
> > +
> >  int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
> >  {
> >  	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
> > @@ -245,6 +277,9 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
> >  		goto remove_err;
> >  	}
> >  
> > +	if (id_val == 0)
> > +		return mptcp_userspace_remove_id_zero_address(msk, info);
> 
> Linked to what I said above: maybe here it would be better to have:
> 
>   err = mptcp_userspace_remove_id_zero_address(msk, info);
>   goto out; // the sock_put() will be done there
> 
> (rename 'remove_err' to 'out' as there is potentially no errors here)
> 
> WDYT?
> 
> 
> > +
> >  	lock_sock(sk);
> >  
> >  	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
