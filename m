Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB44168
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 08:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641372659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yF3X/l7V2uQsaPIKfJtZBGLZFSuxty78N4kucJgfqco=;
	b=R6IOoLfaLr1TJNuvM63TAzZsXJxDqaSDAQF/JiOA+aNWqi2porggJ7dHMd2B7iflz2GXP0
	ztkhao+usyhDzM+XelheMK0/3XTl5BWyEELfEaIxaP3yGCwTp1PoBaBPbV0sob3PFhV6GL
	T/wQwm0DsMfxitch9dsxuQRuy72BD2Y=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2058.outbound.protection.outlook.com [104.47.0.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-dt4_q3IvM_ONyJqSEP193w-1; Wed, 05 Jan 2022 09:50:58 +0100
X-MC-Unique: dt4_q3IvM_ONyJqSEP193w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjoRT/7McMfEnRVPwn9xAT0TZOAz5n7/JPFYC1cVwDK5ZUYryJnlGoqHfN8oLYpA2TLTk5RmYE6Qi6iteOups2UUDGYFbR37fEiKcKyXCUajBktWs5Bt/muhe7P+zz+MyN3QuJ/MpxBpJO6A2BD0Lc0mvE5kDU/ACBAIXwzmfip+wx+imjGGIlSoGYr6zOOXHU9ppXVKDXJCjzSd3m7v5zhBxBOQ9gAT/wxGvvxYLc7MtdGPdIBi4l/hVrY1e8vxQjt34Boywr4CU+87Srp168dMvLEElpCm9VkOHMXUMj/PcIFw/nu0isGnT9obBq/fImP16goHwCFnR01aJ9r8SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yF3X/l7V2uQsaPIKfJtZBGLZFSuxty78N4kucJgfqco=;
 b=QhAPgO/Sb9KC7gMUlHuH+TBVfN2j1+9aL/2uLllmAvDhOF2TNRoH1N+pPc4rif9DtW159Z0RyWym/uoH8dPp1upM9jKB8szClzsip3CE4Wpw9rrcRDVcaZG8ecT892500e5cxRZ2pXxpgwMhC8hj4vaODAZvt5Sa6Oyqd1kK+nZ9OarkKJc3WUdAbVvPoXZTQwuUYAxrvtuOtLAlXmS1p/0xCFtOA8Zwp8DmF9tUt2b0N0PqKyPPC5hnqUJ1EDloIaeWme+FhoHHzDwTreiFilx8jgHNvnQD8nP1i+211VamB4JPVSrW4d+Q4v8JDLaxQ2EuPigDJXeHvHk9L03R8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3067.eurprd04.prod.outlook.com (2603:10a6:7:18::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 08:50:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 08:50:56 +0000
Date: Wed, 5 Jan 2022 16:50:43 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 1/4] Squash to "mptcp: implement fastclose
 xmit path"
Message-ID: <20220105085043.GA3255@dhcp-10-157-36-190>
References: <20211230191651.1831507-1-matthieu.baerts@tessares.net>
 <20211230191651.1831507-2-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230191651.1831507-2-matthieu.baerts@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0206.apcprd02.prod.outlook.com
 (2603:1096:201:20::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51965778-7fb9-4946-42fc-08d9d0287c9f
X-MS-TrafficTypeDiagnostic: HE1PR04MB3067:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB306786BE6617C6E45DE8D065F84B9@HE1PR04MB3067.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Txr2+HVFF5YdDAVjy60gQV4wfsY69Z1vGOf9ApYa7MoNBijgqXkP1pL4pTbNxJsD/HnhNeh3ujW+Crh9B+EFeQDLbDXDb+/MQAL/NWlyD8Jwt1KTUKGo4eIB01pF1Ml8thuCgQPWgY3y10Bh4hZCn3SwXImpvtuVgKVsu8jj/SVtz39Dn698wFzPGsVS2kx7iepsj6lm+D8pX/EKS4+jv5m7O3hFx9anl70eVE+EC2qD/r4aANq4j2yu5+XsDfbwAbIzLvVomzSeK30H/lM/bXyIhq6bSnDIZs4UwURIWmbNiPHzkL1YTp2i6Gzj09+f+nMP7ouxaqVjcM9WTyTyt1lARjJcYF8G2sYE8ZQf1c/K+sKH6ru5SNA6UCQEcwqgEgJbU5DMkJQ9UKql78ktcEbDzTE6iVTkL3zWODUgVyLYuj+bCSNn9pRU+SWGCe0iMkw4yrX83/CGzrBtNQV05Utzu4no1N8RGZ7x4uTVkAgUFGh4FkSkm/LEv3A7VvMPZOGCFuAcULYYq7uTMqHCGOPnjogb+UMPVBWXa8X9/6r0Yz4D1vA9ZSCGIlYe5qN0LtRObsMxtI/F+Q6A9EKE3MqJgvS3PokKMswNz57OEY+w4Mwlf+euvT2A6t4whiR3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6512007)(1076003)(6506007)(508600001)(4326008)(6666004)(316002)(66476007)(86362001)(9686003)(26005)(38100700002)(66556008)(6486002)(55236004)(83380400001)(6916009)(8676002)(5660300002)(44832011)(2906002)(66946007)(33656002)(186003)(33716001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GfVCKg4K4XRLsaASidloZAqFWkg6PiHvI3DuU79EfUEsJdIk2UQLB2zHEyIS?=
 =?us-ascii?Q?+ZTjSOo47ioWB2Ahz6zHRf7jApCnoy90MnEsyUEbResGWpf5ZlknMNCOozSt?=
 =?us-ascii?Q?shLhLJArF5MLYnOKhLYuPFP8wktGpEZVoTqCGnTGg2H7LTUvhTR1PnpkHcA4?=
 =?us-ascii?Q?VsBN7ME6RloKqr390hYP0CBcgiQsJ7HguSznReEgHEzWwVq8pnqHyi19J7Er?=
 =?us-ascii?Q?oMp3Ncpahp6FX+T4pS0f7z0penU66y5EdkDWnhHb9/E99hIhJ8Cdi+moJAoA?=
 =?us-ascii?Q?XVeksPUs/V2D9hUnauhsQhg6ouWtlxZprpsBIExsUH9/h5aOBEXJvAcgEoOi?=
 =?us-ascii?Q?6E9yVxC89WWQz7lwgf1wuyWTDcM5o0yFFRkaQLsnJtGubm1UUUEMNdhY6kx2?=
 =?us-ascii?Q?CaNX8pa8iXOmdYmgsE+MNZy2xNPnx2aFcumpFXEaXJQl3qpqsvBMKkxojoF2?=
 =?us-ascii?Q?7DNds8mSMqNxsP99AfDSVochn6zw/AB+3Qndj72AI4pFWXv86G1FXb+RVX8V?=
 =?us-ascii?Q?SAsbI9S6EzmulBP1bJCh3aU9upMd52Nacy1TRU1mmpTni68lVyTs/fX7xxGp?=
 =?us-ascii?Q?+S5bp0BD9GRxhj0TLiPJMidjDUKYH7TkjK7JmenWyUyMfHRYaSRLAzKdVXe3?=
 =?us-ascii?Q?wst5OuykrPmpNyHM/dTUHLWM66pZiYpwzzJm/GMVv0N6GF0eX9hVbeWGYTIE?=
 =?us-ascii?Q?OjXb3b70EPQyugI1ItHGEeDnRSVYc/eyYqM1XtaCboPCwxkp4SPT9itxT2+7?=
 =?us-ascii?Q?jkXfcPn6NEbbunesVTde/ylvD+oMaE/UEKeoVFwb0+EotKzUIFhgkm9XiPSX?=
 =?us-ascii?Q?918JzcUDXhIYUbz4+z+7/9H1+bRL+Re4TtrBRy/lr2osGZfrhNUVXD/zUIXT?=
 =?us-ascii?Q?Hi8a6VNW03ZpmvGEdAUmWI3RI4HDiP2CromQNg9u9Bp7UeGhZQsAxhZYfATu?=
 =?us-ascii?Q?iIB6c+ZcEgg8rBDKnKRf3/8zIsDGjPesBGAUa490g49pR7RqKeR6CVuj4e+4?=
 =?us-ascii?Q?GBL9QqVsvIUcmdrHgE8V8k99+Xrp1w12gCEH0IOpJscXLQEeB9f5nNSYf6ab?=
 =?us-ascii?Q?DhG+esMOh7E8aHi2EI4iya0exhwKepfXE5GY5RyFeWj+NA+jv1ZQPS4Bz79+?=
 =?us-ascii?Q?Ie/qqBjIzyXIdCv7hF5kmo3wO/DGZuTOavFrB5xuo4vFyWRZ5ZaSsTmvQVjP?=
 =?us-ascii?Q?cx/TmY+r7UScXldFRS3Vl+OmkdJxgjGBfen6PglrFgQ8RM3EnWd4DCZ9pLAx?=
 =?us-ascii?Q?YUi+4gLM70p6zCiP2kMDQ5ath8QD55WChtMeTAeFFcxeMrlJVp1G0dJ+zWqI?=
 =?us-ascii?Q?kvSAYtbM8JNP4UtGvZDf7kXrVsuata6LDe/g8Sc4/sLIf/rMJVn9c5t5Ts0f?=
 =?us-ascii?Q?40npzvYd7YVgN32NBIkDkihOtbzpzTNrpSzE0gIGMfbMOckVeWYMYYheUfha?=
 =?us-ascii?Q?j2Qbl3YunkzNfz6k3/bxnsaWoE9bY5fPYWna1jz1l8+EhIOvNOLI2DLwJFfZ?=
 =?us-ascii?Q?bHYRu9zt22GX2yjwGaEHaD79Bcdfn3hWB76/98wbxSatj/dNTF5jcHM82vVX?=
 =?us-ascii?Q?Q080fGV/6lE5kha7V6plHAE8UqJZaI9TsiyUfApiDyMmOBKiWJaME7nTurXK?=
 =?us-ascii?Q?2jNdFG+h3eoy2HZpHtVw1k4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51965778-7fb9-4946-42fc-08d9d0287c9f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 08:50:56.2716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNH6gBoEH4bRFoHWqhYloP9wVubm5/NrujmSh5+xB1Ka5W19AUsnpz5UNaDWoQMcfFUlyyxd8vaWr9j5cdOz4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3067

On Thu, Dec 30, 2021 at 08:16:48PM +0100, Matthieu Baerts wrote:
> From: Geliang Tang <geliang.tang@suse.com>
> 
> MP_FAIL could be sent with RST or DSS, and FASTCLOSE can be sent with
> RST too. So we should use a similar xmit logic for FASTCLOSE and
> MP_FAIL in both mptcp_write_options() and mptcp_established_options*().
> 
> Cc: Paolo Abeni <pabeni@redhat.com>
> Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/options.c | 66 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 41 insertions(+), 25 deletions(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index c6726e8389ec..9d2c1c9edbe6 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -829,8 +829,12 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>  
>  	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
>  		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
> -		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
> -		    mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
> +		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
> +			*size += opt_size;
> +			remaining -= opt_size;
> +		}
> +		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
> +		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
>  			*size += opt_size;
>  			remaining -= opt_size;
>  		}
> @@ -1257,21 +1261,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
>  void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>  			 struct mptcp_out_options *opts)
>  {
> -	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
> -		const struct sock *ssk = (const struct sock *)tp;
> -		struct mptcp_subflow_context *subflow;
> -
> -		subflow = mptcp_subflow_ctx(ssk);
> -		subflow->send_mp_fail = 0;
> -
> -		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
> -				      TCPOLEN_MPTCP_FAIL,
> -				      0, 0);
> -		put_unaligned_be64(opts->fail_seq, ptr);
> -		ptr += 2;
> -	}

Hi Matt,

Sorry, this patch doesn't work on my test. We write both DSS + MP_FAIL,
but MP_FAIL is lost on the received side. Only DSS is received.

If we write MP_FAIL + DSS like the orignal code, MP_FAIL and DSS will be
received correctly.

I haven't figured out why yet.

Could we just keep this MP_FAIL writting code still at the beginning of
the function just like the orignal code did?

> -
> -	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
> +	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and FAIL are mutually exclusive,
>  	 * see mptcp_established_options*()
>  	 */
>  	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
> @@ -1328,6 +1318,10 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>  						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
>  			}
>  		}
> +
> +		/* We might need to add MP_FAIL options in rare cases */
> +		if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions))
> +			goto mp_fail;
>  	} else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
>  		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
>  
> @@ -1460,19 +1454,41 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>  				ptr += 1;
>  			}
>  		}
> -	} else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
> -		/* RST is mutually exclusive with everything else */
> -		*ptr++ = mptcp_option(MPTCPOPT_RST,
> -				      TCPOLEN_MPTCP_RST,
> -				      opts->reset_transient,
> -				      opts->reset_reason);
> -		return;
>  	} else if (unlikely(OPTION_MPTCP_FASTCLOSE & opts->suboptions)) {
> -		/* FASTCLOSE is mutually exclusive with everything else */
> +		/* FASTCLOSE is mutually exclusive with others except RST */
>  		*ptr++ = mptcp_option(MPTCPOPT_MP_FASTCLOSE,
>  				      TCPOLEN_MPTCP_FASTCLOSE,
>  				      0, 0);
>  		put_unaligned_be64(opts->rcvr_key, ptr);

Here, 'ptr += 2;' is needed.

Thanks,
-Geliang

> +
> +		if (OPTION_MPTCP_RST & opts->suboptions)
> +			goto mp_rst;
> +		return;
> +	} else if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions))
> +mp_fail:
> +	{
> +		/* MP_FAIL is mutually exclusive with others except RST */
> +		const struct sock *ssk = (const struct sock *)tp;
> +		struct mptcp_subflow_context *subflow;
> +
> +		subflow = mptcp_subflow_ctx(ssk);
> +		subflow->send_mp_fail = 0;
> +
> +		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
> +				      TCPOLEN_MPTCP_FAIL,
> +				      0, 0);
> +		put_unaligned_be64(opts->fail_seq, ptr);
> +		ptr += 2;
> +
> +		if (OPTION_MPTCP_RST & opts->suboptions)
> +			goto mp_rst;
> +		return;
> +	} else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
> +mp_rst:
> +		*ptr++ = mptcp_option(MPTCPOPT_RST,
> +				      TCPOLEN_MPTCP_RST,
> +				      opts->reset_transient,
> +				      opts->reset_reason);
>  		return;
>  	}
>  
> -- 
> 2.33.1
> 

