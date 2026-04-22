Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AB93876C5
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776845140; cv=none; b=WJvxtg/IT74ba1x/EagzG+N2G9T7oWuMfz0tE6gfST1Pc0Jwet0GWR5cIdfCSBc+rOh5IXNXMRSqumwNTtkidabD6ncBrefGr6Gjv5ob6m3jZXzijviaJF0gm7K1krJGffRD1WN3e28lpw81VdBtBVRpbYO54MJG3iwsJNxG27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776845140; c=relaxed/simple;
	bh=LvEQSOni6lINuC/pnUL6dNp9CZJczPp+r6HyEVXRjBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqofJ/VG3GnMPcvlkvcpzJGvzBWE34omkEJSFBS7j+sm5eeZh1TyyYGrjidokxsKPCD4a/kL/Z84XbgZ8BKdeJ744RZht6JWXApIzfDcQpnQaxk9m/Mum6IjuoM4TLuMVvnSxZTH0ibsDjsULuIkPn/hHwwZkf9TWiv8f27UVwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CiRNjF0u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiRNjF0u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776845137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cg4/TBn1W/JqIMEC8H/U5fInb7DYoqDDSkX5YnU+nlc=;
	b=CiRNjF0uIbSZA5YtL0j83mUbwm7YepxtjhpcYfexZd1d7c6bonwyVEfR/8803GY+GmG8f+
	D50Kdz2W5Xi/TiDcYDT6BVMYD1NCPHslHWfuNx7LVXquZ3/n4+2pWOHzALnsbsMym2cCYM
	5/9bEx7WhBUc3NR+Nyq2cqhmm75e6eA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-ssWob9bwMXmWMQAWHzqk7w-1; Wed, 22 Apr 2026 04:05:36 -0400
X-MC-Unique: ssWob9bwMXmWMQAWHzqk7w-1
X-Mimecast-MFC-AGG-ID: ssWob9bwMXmWMQAWHzqk7w_1776845135
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d103e46c3so3610037f8f.3
        for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 01:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776845135; x=1777449935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cg4/TBn1W/JqIMEC8H/U5fInb7DYoqDDSkX5YnU+nlc=;
        b=jLWAy6yd5NX/G4qr4P9QEUaZbek/1oLUHeT9gHpGWKyeOzFPROAxj6YFgS8pKr3zGb
         G81XqGsGHQNLlcBZjA0QaM/zOs8g6YdaxJ0IpcVjsnhfi61CkTi2YvbeBZzQBOyZH15d
         n6XC4DxY/SyviLEkZjd8wb1FUnlM36v4GEMxiS5I609g3bZM49PO8qyCvrTIwxridLyg
         V7+wx0josF68I5J4Ig3OuTUW9nmGgClzKtFqDROzuUaTmoF155sbZjHqXEBCK50u3bJq
         Uxf+eORbUcWG3u97MZps+H5e1oOi1Irzc834a6ktY7qF4V8Ns4DV1WqaxV1C245SNXsg
         C90g==
X-Forwarded-Encrypted: i=1; AFNElJ+ENKGai7UztzIKiki/Z6NITe2yNDl4zdS9iZ5E79VGD3USTKru0ck4XY6fZGN1VEdXQmXPxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKqSCZPwOsCLAfDGAi4/rf5Pk0WyY0fxQMS78LX5KLdV8XwwsL
	r1uJ0Ax320xy6Na2bjCyV3daVS5vpRBVH8EuRvgBLtbj381U0Bah//ojSXD04R18bK4vXLcyH8i
	Mm/+KmIoWsIXnl6ndyec0hriLeYZzURm/ZVVcXfmpYIZyoz0ef7gpvIWs
X-Gm-Gg: AeBDieuOs+DMdCJjsOOTHTE7ZneksdrQD6gG1eHHMWE4eCnbyDonepkPUjN/aM72hjk
	as9lfknlTTzmt0/AQx1sMDwDsXvWB3iyvBUesn2Tqi4W4ypSTGTy2eg7yFhj5VkEV6Qlb4NhsdS
	mhDQf6vx0i4kAcUUwZ0Ei0ghRy+JDMMVz6EfRbekSvcsF4tUJWpzsmy1AN0ZFNE6Q2b9KW5VPmP
	qk1ZbV5Im22rt1mAfJ2ymHSgN/y2Tb+JbvvVxa68MMZdNudYDnleMzeGy4qowgs2QW5cyrqUXi/
	DK3VQGlJ7OCDy0hRHV97mTR9NqW+IgVuahvKZeKf6FaYvu01VUCDy3zcVvmb7ces3azpMTg3WZO
	0HBX8Wj+vC5tzIZNs5Fa61qpHYvTXgr0hKHzwocdljj0AdIb7M5wKQgKuJvAQovLznLM=
X-Received: by 2002:a05:6000:25c7:b0:43c:f0c0:c571 with SMTP id ffacd0b85a97d-43fe3e12b2bmr34616254f8f.47.1776845134967;
        Wed, 22 Apr 2026 01:05:34 -0700 (PDT)
X-Received: by 2002:a05:6000:25c7:b0:43c:f0c0:c571 with SMTP id ffacd0b85a97d-43fe3e12b2bmr34616150f8f.47.1776845134284;
        Wed, 22 Apr 2026 01:05:34 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4633bsm43236968f8f.26.2026.04.22.01.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 01:05:33 -0700 (PDT)
Message-ID: <e5dbdb08-f666-47d6-83b6-c157c7e9036c@redhat.com>
Date: Wed, 22 Apr 2026 10:05:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 1/3] mptcp: propagate RECVERR sockopts to
 subflows
To: David Carlier <devnexen@gmail.com>, mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <20260421223338.52743-1-devnexen@gmail.com>
 <20260421223338.52743-2-devnexen@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260421223338.52743-2-devnexen@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZFK_C_ThNAgdEAi83jMc7QHiVCN7FetwS1sxV7LJPvg_1776845135
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/26 12:33 AM, David Carlier wrote:
> Propagate IP_RECVERR/IP_RECVERR_RFC4884 and
> IPV6_RECVERR/IPV6_RECVERR_RFC4884 from the MPTCP socket to
> existing and future subflows.
> 
> Apply the matching sockopt according to the subflow family so mixed-
> family subflows stay aligned with the parent socket configuration,
> including disable-time errqueue purge semantics.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>

You should drop this line, only a single SoB tag is needed.

[...]
> +#if IS_ENABLED(CONFIG_IPV6)

Is this compiler guard strictly needed?

> +static int mptcp_setsockopt_v6_recverr(struct mptcp_sock *msk, int optname,
> +				       sockptr_t optval, unsigned int optlen)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +	int ret;
> +
> +	ret = ipv6_setsockopt(sk, SOL_IPV6, optname, optval, optlen);
> +	if (ret)
> +		return ret;
> +
> +	lock_sock(sk);
> +	sockopt_seq_inc(msk);
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		bool rfc4884 = optname == IPV6_RECVERR_RFC4884;
> +
> +		ret = mptcp_subflow_set_recverr(sk, ssk, rfc4884);

The above looks a bit overcomplicated?!? It looks like you could
leverage mptcp_setsockopt_all_sf() in  and drop the
mptcp_subflow_set_recverr() and mptcp_recverr_enabled() helpers.

@Mattbe: it's not clear to me why mptcp_setsockopt_all_sf() does not
call sockopt_seq_inc(msk) or sync the setsockopt_seq, possibly an
unrelated bug?

[...]
> @@ -760,6 +834,33 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
>  	return 0;
>  }
>  
> +static int mptcp_setsockopt_v4_recverr(struct mptcp_sock *msk, int optname,
> +				       sockptr_t optval, unsigned int optlen)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +	int err;
> +
> +	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
> +	if (err)
> +		return err;
> +
> +	lock_sock(sk);
> +	sockopt_seq_inc(msk);
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		bool rfc4884 = optname == IP_RECVERR_RFC4884;
> +
> +		err = mptcp_subflow_set_recverr(sk, ssk, rfc4884);
> +		if (err)
> +			break;

Same note here WRT possible mptcp_setsockopt_all_sf() usage.

> +		subflow->setsockopt_seq = msk->setsockopt_seq;
> +	}
> +	release_sock(sk);
> +
> +	return err;
> +}
> +
>  static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
>  			       sockptr_t optval, unsigned int optlen)
>  {
> @@ -771,6 +872,9 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
>  		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
>  	case IP_TOS:
>  		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
> +	case IP_RECVERR:
> +	case IP_RECVERR_RFC4884:
> +		return mptcp_setsockopt_v4_recverr(msk, optname, optval, optlen);
>  	}
>  
>  	return -EOPNOTSUPP;
> @@ -1459,6 +1563,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
>  	case IP_LOCAL_PORT_RANGE:
>  		return mptcp_put_int_option(msk, optval, optlen,
>  				READ_ONCE(inet_sk(sk)->local_port_range));
> +	case IP_RECVERR:
> +		return mptcp_put_int_option(msk, optval, optlen,
> +				inet_test_bit(RECVERR, sk));
> +	case IP_RECVERR_RFC4884:
> +		return mptcp_put_int_option(msk, optval, optlen,
> +				inet_test_bit(RECVERR_RFC4884, sk));
>  	}
>  
>  	return -EOPNOTSUPP;
> @@ -1479,6 +1589,12 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
>  	case IPV6_FREEBIND:
>  		return mptcp_put_int_option(msk, optval, optlen,
>  					    inet_test_bit(FREEBIND, sk));
> +	case IPV6_RECVERR:
> +		return mptcp_put_int_option(msk, optval, optlen,
> +					    inet6_test_bit(RECVERR6, sk));
> +	case IPV6_RECVERR_RFC4884:
> +		return mptcp_put_int_option(msk, optval, optlen,
> +					    inet6_test_bit(RECVERR6_RFC4884, sk));
>  	}
>  
>  	return -EOPNOTSUPP;
> @@ -1536,6 +1652,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>  {
>  	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
>  	struct sock *sk = (struct sock *)msk;
> +	bool recverr, recverr_rfc4884;
>  	bool keep_open;
>  
>  	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
> @@ -1586,6 +1703,18 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>  	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
>  	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
>  	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
> +	recverr = mptcp_recverr_enabled(sk, false);
> +	recverr_rfc4884 = mptcp_recverr_enabled(sk, true);
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (ssk->sk_family == AF_INET6) {
> +		inet6_assign_bit(RECVERR6, ssk, recverr);
> +		inet6_assign_bit(RECVERR6_RFC4884, ssk, recverr_rfc4884);
> +	} else
> +#endif
> +	{
> +		inet_assign_bit(RECVERR, ssk, recverr);
> +		inet_assign_bit(RECVERR_RFC4884, ssk, recverr_rfc4884);
> +	}

Instead of the above you could add a pre req patch converting the
existing inet_assign_bit() to something alike:

#define MPTCP_INET_FLAGS_MASK (INET_FLAGS_TRANSPARENT |
INET_FLAGS_FREEBIND /* ... */ )

	inet_sk(ssk)->inet_flags = inet_sk(sk)->inet_flags & MPTCP_INET_FLAGS_MASK;

and just expand the MPTCP_INET_FLAGS_MASK.

/P

