Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553C22C9C
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 10:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641380153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fAB1aRGLDClo6Tozbhv4Qm4doKP9vqIlv0n+a77jBWQ=;
	b=SfIvw4u444lQvun2/IzQzWqY7+cCTwaK8xu9xzYS8S+fea/qOTtSJ8hdtfgJcFwB11EEHf
	75tkCQrN6ewc26pJQxmQ3UF/gWnMGDsavZDfhpilu8nNffXKFlpfiF5LpC79BAMUV28X7U
	Y9buGXk93jcA+QEZiuIfWas1BbmBweE=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-PjCwhzBQOoK9XzcvUHvcuQ-1; Wed, 05 Jan 2022 11:55:52 +0100
X-MC-Unique: PjCwhzBQOoK9XzcvUHvcuQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVWT7NRufgvevhvL5X1mijW0uw4sR+iR2+2yTicKJ09ugxnILEBFsiS7gAOb7ZkyrWvao9S4sKOSminmsEmUgsRA6p6JS6usn6oY/mWg/i4Mp5Rj3iHe0ZDyevgOWx4RvK1HXOuvZOejH2Wm3IRs2o08Zk4xttnW9T2YnglQa1NVZCHC/8IhFpJ4YHLBi0cYsCXHDhOY3gRcm3VH55FxhkBTxiQ+OIoO98ATuqOwDbkbMlnoKXrOHBSd3n0tDSE7qpWohOV/lsuImZWM4Uh7ady81+UfS6Z7jfiJgc7cVmygM4wGFENbPo8l2lUqAOz0IU3gQ09j/i9vYJtNnuYz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAB1aRGLDClo6Tozbhv4Qm4doKP9vqIlv0n+a77jBWQ=;
 b=bz7isElpHeUvbUZcRDx+by0jqC9pSnBNY6pKVGCT9EIjXoppSRNUoggQ74nS9MtXweINSvzee2J7QK+LwtD500XNx83iVdQHo7zxwLBD9Yk2GFUHfXvVxsIV5UxTCv1waxxvuwxkqCQA8OvcYazbTT6OltGtpJyzZfWdkHB/PXhK6Og7Zhwb0oelXNOwWac/16Z7dCz8445ygKh7oItmjvB1RJibk/hABv2S1qXsiY7eL+FZm8uUR/l3pJvdy0Rt0cKPB2gVT4CJhSmKfAmdo6nuNeR/MfZMtHZRm1UoHuzHGHJucX2m1CLRTb0b5aB873JBgJiEZqeld31Qv4DLtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2636.eurprd04.prod.outlook.com (2603:10a6:3:89::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 10:55:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 10:55:50 +0000
Date: Wed, 5 Jan 2022 18:55:40 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 1/4] Squash to "mptcp: implement fastclose
 xmit path"
Message-ID: <20220105105540.GA9181@dhcp-10-157-36-190>
References: <20211230191651.1831507-1-matthieu.baerts@tessares.net>
 <20211230191651.1831507-2-matthieu.baerts@tessares.net>
 <20220105085043.GA3255@dhcp-10-157-36-190>
 <9dcec4f1-26ea-ade8-7547-93fef53922b0@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dcec4f1-26ea-ade8-7547-93fef53922b0@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0155.apcprd02.prod.outlook.com
 (2603:1096:201:1f::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b663083-4b14-483c-30c9-08d9d039ef91
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2636:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB26368A471015B3FE64E8F731F84B9@HE1PR0401MB2636.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fuXW47cofWrwed74wbVdNJDj7Qb0Vc/1eLmZRuwQfhpyXuyll6r7iJ1K4YivDqfgNwDfVAmgtD8+4KNWr6pB/wIi6o9INOTpCBWB9c+Cgb0cUMxiZojX4BHtti4XRQMDC0YtWQpehjiS0vFNOF6ygNKWhb6TSt+2nHH7wTtsExo0GGeOjmFjSuVGN8bVbkdIyamAAOynpDFECsoWRGGYeUpk050v9Cs0I8u5yOjCO+JzJEq7ETgj10tYwotXosGMOn9WrLn9RYL0fa1JAJj6xiGPnOTaDFLoOkzjDsC8tkOnE+6MHy6/x8tekGrHS74K/8nJ5kZQsjqky3wcSpeYdXSwzPELqggVSE+Cbss3OT3m4iLJHudIAxWKBK1mStTSZphWH+NRKK1bkLvp6BJBf8jpkFq/HonrxMXHRD0sUOt1wIQFyxTgkkG04UhiD8xZNAV2B7Q/Cl8aYZTrP4IT5vkJT2PDP8mqmk5sRoS0ncilnfoj5r5C2ggfAnKx91I0WHGwoz/hjLGCAegCADu2+ZdnuopktBllkX8tlvCFzC64pVc3unWKNxMfztCiF9VxJaIlmiGpNJEiVAVfTNRc/ahwMMFVcwPn9RlnbOVyKXGnfczj8d3pb4upwkq1dXz+2S14EwJgjdhexc6Cw6fg89pPqLGTv5p0dWHPE6jj3EENzhBlcg/vh0RV9ZsS8NmRekTIcNjK+iIb3JFX5fLlzDSYpYVKIIYSc7U77aWEEL8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(53546011)(6506007)(8936002)(6512007)(55236004)(508600001)(26005)(33716001)(6916009)(6486002)(8676002)(6666004)(15974865002)(186003)(83380400001)(86362001)(33656002)(38100700002)(9686003)(316002)(4326008)(1076003)(2906002)(44832011)(5660300002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Si/HiksDnyve9/tbIECyNuMTKmpdy5E40wxROhQHQoAmIbiw0Z9OIE84gIIo?=
 =?us-ascii?Q?NnTRVIph6/kSiBMY0W9zE+1dj+dcZkKj7vo3Yermp02D6FjLr2tGMCjIK85w?=
 =?us-ascii?Q?x46u3bqPdtErfqs3Dz9YYjmCOIvh/h2Bbn/8TApcAAEsDR5Ycds34tV4cKua?=
 =?us-ascii?Q?Qi1V0OFYZHh/aQgvhVvEIxATY1lhqT/phQd1gax/zZ4YepfOV2uNvDBs/bKP?=
 =?us-ascii?Q?Bhr9esJ8J64DXA5O1q5oTQq3cUeeF4LXOfSYfs6mAQcsFZOEahDJP1XD8OPi?=
 =?us-ascii?Q?gAOsmHRx00+Uomm2PiZ5DuP8L40Tpf7FZppYMZ2enQPa/BaqBLR9307vui8s?=
 =?us-ascii?Q?N1TCuzDLJ1pLNtoIMduByiIzpsR5juX7dDLfsUSoD8b/rIaTWF6dqndaxWC9?=
 =?us-ascii?Q?I0cV9CVyShfU3FnDvMTWDWL20KGK3l+hS1K44dNflW/BgW45Px67HpfcW+K6?=
 =?us-ascii?Q?Rxv0fns3yVRfol1jKxHrG7nDLfQzmEaxwJZKRgJG/0uWzLmioMJOfByrNo/K?=
 =?us-ascii?Q?xtW+3KnAcS2+KplVnX5Mr54YulDW3Fga6LAolSJ3ScRMeqI31HXHFgY2+P4H?=
 =?us-ascii?Q?UiUumjhu+vY8ElcbUCaakv+rrRJKIQTOnZVuewK15VMJC0J+nBi2nbbDG3BV?=
 =?us-ascii?Q?I1WKzLO3poXJa7YK+I0up6OCiSTiLds36YWnkdPShUtbwO3SmoG4pOp5dgt0?=
 =?us-ascii?Q?VaYpk6Kys7DDiuZhPG4Wf1nU+za8IrrpUzly43RJAWSR9kepNMGaCTP185fM?=
 =?us-ascii?Q?hLEXBUKXOQ4Aup1fVnYzhwTWG+PZAh4fXfd3RKipC9zFJziNO4QABAhYP6/j?=
 =?us-ascii?Q?TR/IHwIr+R0GLZYon3oEzRNemObLzU+Xek1tFB9BrtPPAxW9c21TAs7bEYEC?=
 =?us-ascii?Q?ZlmcC6pS+D5/6sIgns0Ye132rPaR2LYplDCaasmONwJMrk37E3JQPFN0GewK?=
 =?us-ascii?Q?eTMfxVksW231/Y5GsaT7C70p7JbshqnonyNxhXH+GJe2kV2iADBz9RU2SMo3?=
 =?us-ascii?Q?u5Hkwbn848GESXWxmS0OltfDZzaWEsKNDS8C2UTud5GSR97u9LSGMDyZL0Z/?=
 =?us-ascii?Q?xKXQsDgi+cO17x7l2KoNLYu7KBciFITRveg9FUu+HcKxAjvCK2BxNwm38p8w?=
 =?us-ascii?Q?qPFeknltdMi2NDhZzfVREZNiz/sTiBS00NtwAyjoG9BLy23rnAVHVZnUEUYV?=
 =?us-ascii?Q?sHT2NlBBjwcdzDucWeKRgpnjV1abE4vsqLQtO+wEi1BFQhesmQl5s6GjN4Bt?=
 =?us-ascii?Q?Izw6geO9zoYTeVWe1IBbP4/WWHaspyoyFQHt3GcIES5FIWZGvVOoxAVqJlkd?=
 =?us-ascii?Q?gxWf1zAeB9HgqXo373WNSQ5XPfH/d0DkCeUqxqT8br3271iFV2tG/JuvGtsp?=
 =?us-ascii?Q?yKIDJ9X68xJIsEhTYAV2X+cwF/NO53AE5NA8tUddmcuJpzoFelmwPSg2KYrr?=
 =?us-ascii?Q?EB/5lxZ9e2/8PD9z3b3pJ6CEreiP9CIM46S2ZNDYaufj3CKfVEqcI8WXdvWF?=
 =?us-ascii?Q?6uKB5yAA2M37pdmGeG1gzwMZ/NsOPZUDEdXU/RgNfWV+fYILOkUOU7gSwc/P?=
 =?us-ascii?Q?inaopudolXbos2QBWumW7BL9+8c+LErz908b8KtrluwTs9qUypxUm1HFn0sK?=
 =?us-ascii?Q?xmHZWg3rPRtb4yXugKd03ic=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b663083-4b14-483c-30c9-08d9d039ef91
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 10:55:50.3899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pm9kgvdH7zgbGx8P30LtpBn0jrTivw4fRH4lWTYoJkphLDDriLFxYmHMsvNQliTYQ1Z5bdc8Hbuy4Nwle/XbBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2636

On Wed, Jan 05, 2022 at 11:01:59AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 05/01/2022 09:50, Geliang Tang wrote:
> > On Thu, Dec 30, 2021 at 08:16:48PM +0100, Matthieu Baerts wrote:
> >> From: Geliang Tang <geliang.tang@suse.com>
> >>
> >> MP_FAIL could be sent with RST or DSS, and FASTCLOSE can be sent with
> >> RST too. So we should use a similar xmit logic for FASTCLOSE and
> >> MP_FAIL in both mptcp_write_options() and mptcp_established_options*().
> >>
> >> Cc: Paolo Abeni <pabeni@redhat.com>
> >> Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> >> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> >> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> >> ---
> >>  net/mptcp/options.c | 66 ++++++++++++++++++++++++++++-----------------
> >>  1 file changed, 41 insertions(+), 25 deletions(-)
> >>
> >> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> >> index c6726e8389ec..9d2c1c9edbe6 100644
> >> --- a/net/mptcp/options.c
> >> +++ b/net/mptcp/options.c
> >> @@ -829,8 +829,12 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> >>  
> >>  	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
> >>  		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
> >> -		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
> >> -		    mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
> >> +		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
> >> +			*size += opt_size;
> >> +			remaining -= opt_size;
> >> +		}
> >> +		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
> >> +		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
> >>  			*size += opt_size;
> >>  			remaining -= opt_size;
> >>  		}
> >> @@ -1257,21 +1261,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
> >>  void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> >>  			 struct mptcp_out_options *opts)
> >>  {
> >> -	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
> >> -		const struct sock *ssk = (const struct sock *)tp;
> >> -		struct mptcp_subflow_context *subflow;
> >> -
> >> -		subflow = mptcp_subflow_ctx(ssk);
> >> -		subflow->send_mp_fail = 0;
> >> -
> >> -		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
> >> -				      TCPOLEN_MPTCP_FAIL,
> >> -				      0, 0);
> >> -		put_unaligned_be64(opts->fail_seq, ptr);
> >> -		ptr += 2;
> >> -	}
> > 
> > Hi Matt,
> > 
> > Sorry, this patch doesn't work on my test. We write both DSS + MP_FAIL,
> > but MP_FAIL is lost on the received side. Only DSS is received.
> > 
> > If we write MP_FAIL + DSS like the orignal code, MP_FAIL and DSS will be
> > received correctly.
> > 
> > I haven't figured out why yet.
> > 
> > Could we just keep this MP_FAIL writting code still at the beginning of
> > the function just like the orignal code did?
> 
> Thank you for having tested and reviewed the series!
> 
> Is this issue here fixed by your patch you sent a couple of minutes ago
> (mptcp: fix a DSS option writting error)
> 
> That would make sense as the only thing I did was to send the MP_FAIL
> after the DSS option.
> 
> Do you mind if I send a v8 series with your new fix the missing 'ptr +=
> 2;' below and have the code moving the writing of the MP_FAIL option
> later in a dedicated commit?

Hi Matt,

I think about it again. How about just using the v2 of this patch
(https://patchwork.kernel.org/project/mptcp/patch/5a8c6024481d6106c662c3e892ae5e499b4a7f76.1638156809.git.geliang.tang@suse.com/)
as a squash-to patch (We have reached an agreement on this part), and move
all the other code in this v7 as a new patch (It still needs to be
improved)?

Thanks,
-Geliang

> 
> > 
> >> -
> >> -	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
> >> +	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and FAIL are mutually exclusive,
> >>  	 * see mptcp_established_options*()
> >>  	 */
> >>  	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
> >> @@ -1328,6 +1318,10 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> >>  						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
> >>  			}
> >>  		}
> >> +
> >> +		/* We might need to add MP_FAIL options in rare cases */
> >> +		if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions))
> >> +			goto mp_fail;
> >>  	} else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
> >>  		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
> >>  
> >> @@ -1460,19 +1454,41 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> >>  				ptr += 1;
> >>  			}
> >>  		}
> >> -	} else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
> >> -		/* RST is mutually exclusive with everything else */
> >> -		*ptr++ = mptcp_option(MPTCPOPT_RST,
> >> -				      TCPOLEN_MPTCP_RST,
> >> -				      opts->reset_transient,
> >> -				      opts->reset_reason);
> >> -		return;
> >>  	} else if (unlikely(OPTION_MPTCP_FASTCLOSE & opts->suboptions)) {
> >> -		/* FASTCLOSE is mutually exclusive with everything else */
> >> +		/* FASTCLOSE is mutually exclusive with others except RST */
> >>  		*ptr++ = mptcp_option(MPTCPOPT_MP_FASTCLOSE,
> >>  				      TCPOLEN_MPTCP_FASTCLOSE,
> >>  				      0, 0);
> >>  		put_unaligned_be64(opts->rcvr_key, ptr);
> > 
> > Here, 'ptr += 2;' is needed.
> 
> Good catch!
> 
> Note related to my modification but to "mptcp: implement fastclose xmit
> path" so it should be in this squash-to patch!
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

