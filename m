Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB546374E5C
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117577; cv=none; b=U51olwl4oH0ND/zG9u1xkmPFa7oSPBMS4zjuArxNIVxaPJFtcT1lz3CxLNPsLaq6K5l09hQOJ9qNyWkWGGgOix2JGrCaSgst4rEMX2BDCjrahP1xxSWUScRxqP+pYCli5RIP/cGh2zcpFzMfoRqpkoPmHEWjOKLayrL2F/LEm/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117577; c=relaxed/simple;
	bh=QTHIFgZYyHJhMTqKgnRwLCJZuxpM5BYat3A7t+QtIis=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OFv5L2mUM1mKIt4c2RnCrsiIQkGRcpt4urBWYE4JPiMA/plNUea/dbmzpfEdcfJbIJDfdkXoDycOvhBC+TrvBNvJ0QaIu1etL8qiBeV4MSnKnatzaCW1uviJlhQK1Ya67o04HX67M3VsSpPozWVfO+BvupZW7dOf2/NDNzcZGT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQmyke7q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQmyke7q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779117574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rY/rFsU4LjO1LrSRztAxQgY9KH0+Ewr+H0Nnba3LAWE=;
	b=WQmyke7qsppfP23BTO5AH6VubVVKswxUUyzvdfXCSOxhnxLO4ENyt0UCkSRDap/VejmcUZ
	3kky4mcsMKJ807AbFCTFifF0u/5lMD9ahJ7dagU/tA+VYXFohg/BzLfzEb9l3en+N1nzD8
	VF7xpGp4LV7blBgthp8jpxSw47hGHQE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-l6qNz5EeOVeT0NxTk-7dxQ-1; Mon, 18 May 2026 11:19:33 -0400
X-MC-Unique: l6qNz5EeOVeT0NxTk-7dxQ-1
X-Mimecast-MFC-AGG-ID: l6qNz5EeOVeT0NxTk-7dxQ_1779117572
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45b7ff2140eso2204323f8f.3
        for <mptcp@lists.linux.dev>; Mon, 18 May 2026 08:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117572; x=1779722372;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rY/rFsU4LjO1LrSRztAxQgY9KH0+Ewr+H0Nnba3LAWE=;
        b=PNRDkdcsOWbjLsaSjeoJ390unABZKdpCytv0RJp/B0br061ZlC/Gs2fj8d1HH3ewB0
         CPPkNDpJ02ysZeIYrYGJ56g8btTThZ8gZJUig5Wgl/waCIbjaScEmyU80yiiT0QGlLNI
         PBOB8wsHh9B01Vw1SnrQUJ71seJWoF9J8N6DNHaG9s2ESWNkqRbQYzMFN6pm5zJOi7mB
         ScbBPmPkyGMKoOAPgdNsYR3IFlDQyo8vFDmnPoSskqA4mmzLu0mqWvU2NA35bOvhH8uU
         xXhZjg59Z3QZXi5wCjvK/FNTVnvopRr4cFow0zcuOPlnzJhp09PvEGn3Eaj6UnERkt0i
         PzCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9PMv++lgjSUU/yNrNTKlUNdhmfijl116139rOS3uLwnTL/OGfoAmSyH4YHxpcNw1NTNAsoCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZZ3gIlFmZfK2RIsQIqb3/D2y1Nn/4jcWQkpoCx3jkwkQJBeij
	ANYi8k61HZXL0wSZ7zdnecYVgCzOx3YstVqBQcufaa6fnsK0Zqyhwq/xvK0hONUO46nSyCohAPO
	xtpq1XV38/EwczFueF8kfJPPVvNMxVZwDqwqTSgBpALZjdGzVuCQECKs9J+7Wd015
X-Gm-Gg: Acq92OFswDCXnzIp53s51X90hipfN94bJF8h4SEgxNEV03vaSbzZGlO7+V77wqrdhQ0
	GSgerGIO9+VJfgOhNEH+NmQae4eJAViXkEwbo564CTtTOnrJSQ7nEd3Xl1gEuBdx1VYBn52ziej
	ARDN5czP9o/B7qIgYqWEP6r77QeAAxrBXPYepBeX+n+wpOUuPFlBeg7MveHETir4JvMBstLqNQ6
	XOIP1xDPMlogLfMGljia2xAn6xvJKNMPyMHiJ8PZcCjX6k5DqO6EYeco4KQp49wU0ezCTJBvU5B
	YhQFC3iCFbb2GFQKt2GbRI2kpSetDkGgm9Jrth/9RcrDRdBsY+g2/euhmE3XzmGL2/OTv9svhMg
	7kXqcWF5xZJ1tWcTYRWs2uyDiqRcn8GWIhp2fOA4VfgG5pGKehqkmbyo=
X-Received: by 2002:a05:600c:a406:b0:48a:6798:52e9 with SMTP id 5b1f17b1804b1-48fe59b06acmr205621895e9.0.1779117571703;
        Mon, 18 May 2026 08:19:31 -0700 (PDT)
X-Received: by 2002:a05:600c:a406:b0:48a:6798:52e9 with SMTP id 5b1f17b1804b1-48fe59b06acmr205621445e9.0.1779117571204;
        Mon, 18 May 2026 08:19:31 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57943b2sm268333155e9.8.2026.05.18.08.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 08:19:30 -0700 (PDT)
Message-ID: <9878b113-59e9-4100-92b8-fed412466097@redhat.com>
Date: Mon, 18 May 2026 17:19:29 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 03/12] mptcp: pm: drop TCP TS with ADD_ADDRv6 +
 port
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 MPTCP Linux <mptcp@lists.linux.dev>
References: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
 <20260518-mptcp-add-addr6-port-ts-v1-3-f1ca26977fcd@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260518-mptcp-add-addr6-port-ts-v1-3-f1ca26977fcd@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: isfOqwLPgDM8mfFpDKldzTiPUiDRqHutvyn1SEAvylk_1779117572
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/18/26 2:59 PM, Matthieu Baerts (NGI0) wrote:
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 47647a99e324..3dcc6880fd44 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1182,11 +1182,15 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>  	if (sk_is_mptcp(sk)) {
>  		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
>  		unsigned int opt_size = 0;
> +		bool drop_ts = opts->options & OPTION_TS;

Minor nit: reverse christmas tree order above.

>  
>  		if (mptcp_established_options(sk, skb, &opt_size, remaining,
> -					      &opts->mptcp)) {
> +					      &drop_ts, &opts->mptcp)) {

What about passing `opts` instead of both `drop_ts` and `opts->mptcp` ?

Also possibly move this hooking change in a separate patch to help
reviewers?

> @@ -825,15 +824,17 @@ static bool mptcp_established_options_mp_fail(struct sock *sk,
>  
>  bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>  			       unsigned int *size, unsigned int remaining,
> -			       struct mptcp_out_options *opts)
> +			       bool *drop_ts, struct mptcp_out_options *opts)
>  {
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>  	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>  	unsigned int opt_size = 0;
>  	bool snd_data_fin;
>  	bool ret = false;
> +	bool has_ts = *drop_ts;

Minor nit: reverse christmas tree order above.

> @@ -948,6 +949,13 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
>  		if (!*drop_other_suboptions)
>  			goto out_unlock;
>  
> +		if (*drop_ts && mptcp_add_addr_v6_port_drop_ts(net)) {
> +			/* OK without TCP Timestamp? */
> +			*len -= TCPOLEN_TSTAMP_ALIGNED;
> +			if (remaining >= *len)
> +				goto drop_ts;

A label with the same name of a local variable is IMHO a little
confusing, possibly pass here `opt`  (tcp options ptr) instead of `drop_ts`

Side note: possibly even the sysctl changes deserve their own patch.

/P

