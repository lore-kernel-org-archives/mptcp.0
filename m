Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2053.outbound.protection.outlook.com [40.107.7.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAA920B1E
	for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="kB8FaI/V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGDnGIFhy06oD36bFGAVjsWAfZ0F+e4HvK8PFzDKfpmAPhSlX93uNb+k+KWQbTNIaXf2HT5w5Mgm6LfMimGKgc8JBtrivCdciSb2bk23CeJstCI7lTz+qnWJzYQdG2+stEmWakoZvP4luFiNF2jFHeUrlba77XWAqEEjo6D9tXN4m457/BB1NlDlo1WezaET6TkZBj5/jSQjwgLfHcxlBWowCgGIqteZYGH/vIr99aTO2DJsRFpopKopHx7t75f+J5pSgSCHJ0MOpRENY21p2ctPNnqxCMx9xrpl95NrDOX9ONWI/NxunwouMGbWyofpKAyB+R8vnp6/lFqN7DkAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mX4Ok0/vOYbLbhevHSxlF/uYYYXaZE5EjgO6mm9vrkU=;
 b=UJ2L1+zWHK9/VwUXW6wnMGyPV3vGHM8NAQNEc/Ak+kopGBfr7uUYMqxXRCpx2LcmNEK3thOdP3VeUc+SYg4qGUNezGJ55uA9afP9mp+EHev4Rh8Uky4y+n5dR9hsTy8w/bFV4GEUtIjoG3dQ9prhle2MQKhcLt3iEOxRcxHXspyxduCasawbw830kCEtt1jtWUTNdo+cABKgWvPwOttFgk4dQ5c2JFEDBYqnCF2iK7j6iRvJ+keEsZpDX8IIEKxZ5l8zYqreaLyQlnEnbvWl542ixNqyr6tarzCwD+Q0DmewtCzVKY+ofCHTxbCNFeLxrwsJ/x6e2yscbQWlXmiYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mX4Ok0/vOYbLbhevHSxlF/uYYYXaZE5EjgO6mm9vrkU=;
 b=kB8FaI/VXtwEbU7srUHdo6VZQSDIJWZffAStQqXRa1umO8S5gffxRW1HEIJLXZ+HKNsY2GgzsyVz70WTucVP8GdTnmcuQxqlEQ7oZzc/p46W+76HwOOs0bOzDcdhGf2JF89/sfzLmVkOlhWi6ng+9JRpaErgpTTs3BOJv1Srm3ZGW7j39nDDjzSKeiKCzi/aJDau4LNsoFA3JoCl8rpk0E+CbwtC5t6naQlCGfRf71Y/9ZPRZRzHjM2tkHsoCPzSzlhMeJ+KVI3h2owkpZ8Rl1sJLaxt/VnZNqSCGV06mJAyv6gmoNFX8KTJ1vdDUB5zTH/sk9OyF7cymcY4ZdpdeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8964.eurprd04.prod.outlook.com (2603:10a6:20b:42f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Thu, 12 Oct
 2023 09:02:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 09:02:36 +0000
Date: Thu, 12 Oct 2023 17:03:50 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v14 3/7] mptcp: add __mptcp_subflow_disconnect
 helper
Message-ID: <20231012090350.GA30030@localhost.localdomain>
References: <cover.1697031190.git.geliang.tang@suse.com>
 <e75487344cde69c5b754ee1fb3bd8c730d54e5de.1697031190.git.geliang.tang@suse.com>
 <73963454-bb2d-48b8-9202-666fc2fc5ba7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73963454-bb2d-48b8-9202-666fc2fc5ba7@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR06CA0199.apcprd06.prod.outlook.com (2603:1096:4:1::31)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b85549-8269-4a54-063a-08dbcb01fa02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p+2bFBoOh1nsXM1DcWcjGrqqzufk8o8/6aJMfl/O7W2Q3piCuA10tKyIGlIew2FrpXPrS3gKvtShcMw7QSvc66Wlzb4kuURJaPeC/gg/IK2T36cXGEjgEYSMHEcgc/2NkmXvWaIMQg7bC7jcfC9JJ6yO/5hmJrhQc1XeeOHuJS2eQBNONE98Ort3/OqHo7q3Bz7HmQpsK56JTYhxDX5shweV1Jk5T5EiA18B+7QWlIdslEC4B9XHmeZpVwmVGBZsX46AmUmoWUjcZhXS5Q6VAZvvceVPj4WFX8b053r3R7MWvXQCUxyh3OAukTShXA8guByzvWex8BjuZOxkbn3nZRz0E7aoHH0GshH1RGkhRDHJQJTYBdpHfTFHsm4+OwCTD5a27ifjboIj5cRiv6BYa9rdb13DNvwpysBq0foLEJt9ZBZLLLhkQgbU6BfjH9TEEYc43EnT6gFVG22PJPNGYF0mW5pgoQluUDs6MgW9rTAbkvPzeBZSlnOQdDYhMBoMh3b3MpG+OrP7HJSjWLQTv1BRBRHij7O0NgW3HhwIPpqjHqlmEqCMXD7i+go29twRnKsNEGTHoslrUG6a+pbi1TZ94qvD897CPR+hze/9lXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(1076003)(6666004)(53546011)(6512007)(6506007)(478600001)(38100700002)(66946007)(33656002)(6916009)(6486002)(15974865002)(66476007)(66556008)(316002)(83380400001)(2906002)(8936002)(4326008)(8676002)(41300700001)(5660300002)(44832011)(86362001)(9686003)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUxZN240TVAzNUtzWHRWTThrTjZNQVZZRzlWcWlGRDdPSGpIbnFhZi9QYURq?=
 =?utf-8?B?RitQWDlSb3l6NkdaYXVLNWxyQWgyWWxzWkJadmxvWU9TbUZxejgxSEg2VEE1?=
 =?utf-8?B?TzBOQXBkYWFrMHU0Zm1ZcjZqZithOE4xYXl4dlRmVEJWMDdvdjE0SkVMdVF4?=
 =?utf-8?B?ZlVnV2dmUHZTMUpMVjZxYk9EUUQ3c2hvZFhZZlV3L25RVFYzNVJLMXBPTmpt?=
 =?utf-8?B?Y2d0bjJTcTJhb1p2ZUhZSnVIZ2wwQjN1a3VaQVlITUlCK3AyODN5OXY4TTYv?=
 =?utf-8?B?ZVZ2UEIzcktrMHh5SWVyRm5hTmZXN0NWQXFRZHhwYmdzM1R1dk1MRmorb1Zm?=
 =?utf-8?B?YVpidkNlNTkvWkdGYmpTVzBlV2R6MmRZWVhhTXVlQVVrc2xzUkhNTzVaU2tY?=
 =?utf-8?B?bnZuT0tML0hNZXZURnEwbEg5SzR4ZERGN3FodXlUYm1KbHVzb01tUHFGZm9X?=
 =?utf-8?B?eHh6WTVSWUs1TjB2M2xBSTM1MXhsNytSUDNmNEdmV2Z1Q2RQMWJWUFlmSTB6?=
 =?utf-8?B?ZkJtRVhrUzlCN29LMTNGR09YZldRZTUvMmpKZ0p4RUdkSFdqNW54RVNjTFBx?=
 =?utf-8?B?ZVc4NWgzTmlkeU95U0g0dTludnZKV2RlWVRYVWpaYUVJUWg4UFZrcFF1dWZ0?=
 =?utf-8?B?eHRmbmlKUDErTmZvUWxGeFV4dkY4WDAxZHcybGRvU01TYlNmSEs0dzVCQWhx?=
 =?utf-8?B?SlMyWjJlM0lHUmowNnhaM2s5MmlMbk1yaFh0K1pnZVBqVmFNRjkvdWd2QUxY?=
 =?utf-8?B?aWs5NkZxem01ekVYRnZrRGdrRFV4M2pQSFhRc2M0cUhJVEo1K0F4a2lvTEhM?=
 =?utf-8?B?Sk5KdXdhYnlaSDJROWJzUGNsZ1lzbDcyanFqS2hmWGNyS0YwN041TEZDUkl1?=
 =?utf-8?B?U3FpSkwxeUdCdzNXK3B0TXpaVHV6eFBoblhtMko0dzhiV0kyamoycXU1dWFo?=
 =?utf-8?B?UjUzN05Yd1hVKzV2WUJvU3RvWkoxVUpSNUp2dVg4N3d4TTd5dkJmSnk1UHhT?=
 =?utf-8?B?MGc5TnBIK2o5VzFxd0tRNTBEV2RWRlR0clJJUFhoUnNESGplanhBa1JuUisx?=
 =?utf-8?B?M2padTlUMGp6bEVyUTcySjd0akhYSWxHdTJjcTlmV2FCTXJvWUMxOW5pbFJT?=
 =?utf-8?B?cWZxSGdHM3h1WmFSVWpLM1FwdTRzZjdoL1poYzBBWkVTc2hMUUM0Y0pHbDU0?=
 =?utf-8?B?a2lXUFBab2VQalk4Qk0vaVl0cTN3Q0xwNnYyNWtiZWdQSXp2dS8vbzB3YUxn?=
 =?utf-8?B?aGJubGVGUjNNb2JQRFZZczMwR3lPVE9BRWFlVks1N1dSYUl0UDFtZmRmMkVQ?=
 =?utf-8?B?cjhWSlF2aWczZkpDb21qYjR0WVNTS3oxbXJobCtqSUJqZ2hZVkx6Z0N4L3hE?=
 =?utf-8?B?Z3NldjRKbmMrSVZGRDFWMnltUGw2OXNjN2JueVRRSzIyWHNWNk9vaDhQd1pq?=
 =?utf-8?B?RzhVdjJvRHFTci83WEJFRnFtOVFtS2tIMnVFTVNFaEdEMVFkSCswcmZSc3Vn?=
 =?utf-8?B?M3kxK1JKV1E3R3YzMm85bVQzRlFDN3BWWWt0Q21HL0pYTnJ1SDd4L2Rnc1Fy?=
 =?utf-8?B?aTZGRGV3alFESUF1aE5ML1BkOFNVaFRGMkZKV25uempZUlRUVGdYeUJZRE9X?=
 =?utf-8?B?ZTZkMnQyL0h6ZnNYK1ZCZDRWTUo3TUc2MWJuMHdxTzhmWVpnSVIrdjR0T0xW?=
 =?utf-8?B?aWtVWTNiOWhITmg4QlhCbkpRZjVPNGNOd25IdzV3RmxTbkhSNFROMEtLQmU1?=
 =?utf-8?B?MkVCam5KRnV4UEU5eEFvL2pZdklQYzlUcTFZQXFvRkFYL1Y0RmdCaFQ0cmcy?=
 =?utf-8?B?MHNEVTYyYVVsclBjUVJqSDMvYTBMOTN5TFQ5emZnNzZ2YXNrbE1pNGNBekFR?=
 =?utf-8?B?M2NpazVlZndNZ0xxd040dUdBT1JLS1VxeXYzdWVhUnNNd0RUQTB0eHJkMElP?=
 =?utf-8?B?Y0w1VURGR0wxYUJQbm16b3BWSkVJMnQ0elMzYyt5cGlBWDhNSmFScVRrM29x?=
 =?utf-8?B?VzNNb3ZCaWE2UzRTRlV2Z05KMEJJcXhWd0tFbGErQktrM3J5bnFleWZXa1Uw?=
 =?utf-8?B?TTJMelFjWEwxQmE2U09adWFIN0JqTGtjeDZTbU5ISW0zb3JVaTJXL1pmUktG?=
 =?utf-8?B?VzM5QlZHaUtLUlYwMENiMUJQaUVlOHZSc0FJajNSNlJqcTJCYWpoQlZBZHJK?=
 =?utf-8?Q?HQ2wJayLOwqOplO2gPt4uBB0ZgkXPdYBnX8ikL0urHwM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b85549-8269-4a54-063a-08dbcb01fa02
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 09:02:35.9905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFp4RzAat+gY/HaULzkLb8byyX5hxCMaS9eLgp2JEc+Ahf8TfVmIbH8Z/fRbxlGGmqqzPkS3M8ynMUT0jb55sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8964

Hi Matt,

On Wed, Oct 11, 2023 at 06:53:17PM +0200, Matthieu Baerts wrote:
> Hi Geliang, Paolo,
> 
> On 11/10/2023 15:34, Geliang Tang wrote:
> > When closing the msk->first socket in __mptcp_close_ssk(), if there's
> > another subflow available, it's better to avoid resetting it, just shut
> > down it.
> > 
> > This patch adds a new helper __mptcp_subflow_disconnect(), and reuse
> > flag MPTCP_CF_FASTCLOSE in this case. When MPTCP_CF_FASTCLOSE isn't set,
> > we invoke tcp_shutdown() instead of tcp_disconnect().
> > 
> > Co-developed-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  net/mptcp/protocol.c | 28 ++++++++++++++++++++++------
> >  1 file changed, 22 insertions(+), 6 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 30e0c29ae0a4..1a54d55f8bb2 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2366,6 +2366,26 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
> >  #define MPTCP_CF_PUSH		BIT(1)
> >  #define MPTCP_CF_FASTCLOSE	BIT(2)
> >  
> > +/* be sure to send a reset only if the caller asked for it, also
> > + * clean completely the subflow status when the subflow reaches
> > + * TCP_CLOSE state
> > + */
> > +static void __mptcp_subflow_disconnect(struct sock *ssk,
> > +				       struct mptcp_subflow_context *subflow,
> > +				       unsigned int flags)
> > +{
> > +	if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
> > +	    (flags & MPTCP_CF_FASTCLOSE)) {
> > +		/* The MPTCP code never wait on the subflow sockets, TCP-level
> > +		 * disconnect should never fail
> > +		 */
> > +		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
> > +		mptcp_subflow_ctx_reset(subflow);
> > +	} else {
> > +		tcp_shutdown(ssk, SEND_SHUTDOWN);
> 
> I didn't check in detail but should we not also call
> __mptcp_subflow_error_report()?

When the socket shuts down, it's state is TCPF_FIN_WAIT2.
__mptcp_subflow_error_report will return and do nothing in this case:

      if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
              return false;

So no need to call __mptcp_subflow_error_report.

> 
> And maybe other helpers? What is done between the 'goto out' and the
> 'out' label in __mptcp_close_ssk() here below? → what we do when other
> subflows are being closed.

No need to go the following path too:

        sock_put(ssk);

        if (ssk == msk->first)
                WRITE_ONCE(msk->first, NULL);

So we can keep this patch as it.

Thanks,
-Geliang

> 
> Cheers,
> Matt
> 
> > +	}
> > +}
> > +
> >  /* subflow sockets can be either outgoing (connect) or incoming
> >   * (accept).
> >   *
> > @@ -2403,7 +2423,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> >  	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
> >  
> >  	if ((flags & MPTCP_CF_FASTCLOSE) && !__mptcp_check_fallback(msk)) {
> > -		/* be sure to force the tcp_disconnect() path,
> > +		/* be sure to force the tcp_close path
> >  		 * to generate the egress reset
> >  		 */
> >  		ssk->sk_lingertime = 0;
> > @@ -2413,11 +2433,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> >  
> >  	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
> >  	if (!dispose_it) {
> > -		/* The MPTCP code never wait on the subflow sockets, TCP-level
> > -		 * disconnect should never fail
> > -		 */
> > -		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
> > -		mptcp_subflow_ctx_reset(subflow);
> > +		__mptcp_subflow_disconnect(ssk, subflow, flags);
> >  		release_sock(ssk);
> >  
> >  		goto out;
> 
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
