Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A2923A4
	for <mptcp@lists.linux.dev>; Sat,  9 Sep 2023 16:03:53 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2bcfd3220d3so49639721fa.2
        for <mptcp@lists.linux.dev>; Sat, 09 Sep 2023 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694275432; x=1694880232; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VasQe3nsdM0wzhDQpujuRvDajYSd+1YF/YB7C7ukHSg=;
        b=mal3omNaKaSglfPF83L/2jmc8tnwImWrW+2l0yPsP21a0NIO4HEMy9EQRXwaz3u41i
         Fvd/JHNS4QnWFKq1W94/TeTO5tczERVcsoVAbtySiuULfVDwYplLHehPZ5LzhBW4qgiK
         SgRIBFmvOkCJPalkDRUnzRcx1jRoV4q6KXskpaiTmGRTEJqd4rT3QoL7WjPGUVMzyNCu
         wFUCPhreatlS5gWSzI1oOEJpE/v3F6SawOp9MNOqyXBnAC6GcaM27KQJQKOJWUO6NiXa
         yo9gNdLOK+f0WSk9KP6VD3hr4Jl8xW5gT9h1+5J5Htxr7XxBQ3wPRYnIyUk7791znOFa
         zrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694275432; x=1694880232;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VasQe3nsdM0wzhDQpujuRvDajYSd+1YF/YB7C7ukHSg=;
        b=X6NG5iXSivxr6eb7dbVjVEgJ/Nq8WhbWncPitbAYmBlRNJU8IyHAgr+VmcHFZXWwHR
         QuiUX0l4r7bt8bOrv4qtJXS/ao2EJD/X2pYrbfx9qbpP9iH3eOVLowMGOd/nbnNLx1z6
         XqpeL0n5k4kKdJqfv501diJmbBeLnwyFcsY3R6reKvQqk3uC22m02idzHlZMb7Nf8g8x
         UfulL3G8OYrdticHouGo2vXVRWFs4ziZCZgzX395IyPeJSr2KnWLPBU4mEB+EWi4V3Hh
         A7l8y2guqwCkFL2VFtJIldNjdWZOge2L4EDn512b5jUj681Nb4Njt72fOUMzxFMMm1jl
         sJ/g==
X-Gm-Message-State: AOJu0YzxIerf5L76Bw63pI7dnaqUII0JKAmTj5suLIXffoYqeOI4jwji
	XCtNBJ6OJdugO2CFDYf7Y4XkZg==
X-Google-Smtp-Source: AGHT+IFSSefuZQJESKZTMakm/hijZpfmyyfFE+0DGNWB0gqNFiqLnAdliF64IW5E2/x202yk5bZRVA==
X-Received: by 2002:a19:914e:0:b0:4fd:c84f:30d4 with SMTP id y14-20020a19914e000000b004fdc84f30d4mr4114187lfj.36.1694275431550;
        Sat, 09 Sep 2023 09:03:51 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:91e4:ea9f:cc1e:927a? ([2a02:578:8593:1200:91e4:ea9f:cc1e:927a])
        by smtp.gmail.com with ESMTPSA id x7-20020a19f607000000b004fe47879d93sm666222lfe.106.2023.09.09.09.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 09:03:51 -0700 (PDT)
Message-ID: <c3d26a5d-03d7-4c09-bbe0-dc3a02e364f2@tessares.net>
Date: Sat, 9 Sep 2023 18:03:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v5 2/2] mptcp: fix dangling connection hang-up
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1693988314.git.pabeni@redhat.com>
 <c6eb12bdaa092d1f98ae15adb99729c8192d8939.1693988314.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <c6eb12bdaa092d1f98ae15adb99729c8192d8939.1693988314.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 06/09/2023 10:30, Paolo Abeni wrote:
> According to RFC 8684 section 3.3:
> 
>   A connection is not closed unless [...] or an implementation-specific
>   connection-level send timeout.
> 
> Currently the MPTCP protocol does not implement such timeout, and
> connection timing-out at the TCP-level never move to close state.
> 
> Introduces a catch-up condition at subflow close time to move the
> MPTCP socket to close, too.
> 
> That additionally allow removing similar existing inside the worker.
> 
> Finally, allow some additional timeout for plain ESTABLISHED mptcp
> sockets, as the protocol allows creating new subflows even at that
> point and making the connection functional again.
> 
> The issues is actually present since the beginning, but it basically
> impossible to solve without a long chain of functional pre-requisites
> topped by the blamed commit below.

Thank you for the update!

(...)

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 4fcce9ad7d04..74889f072d2d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -726,6 +726,30 @@ void mptcp_get_options(const struct sk_buff *skb,
>  void mptcp_finish_connect(struct sock *sk);
>  void __mptcp_set_connected(struct sock *sk);
>  void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout);
> +
> +static inline void mptcp_stop_tout_timer(struct sock *sk)
> +{
> +	if (!inet_csk(sk)->icsk_mtup.probe_timestamp)
> +		return;
> +
> +	sk_stop_timer(sk, &sk->sk_timer);
> +	inet_csk(sk)->icsk_mtup.probe_timestamp = 0;
> +}
> +
> +static inline void mptcp_set_close_tout(struct sock *sk, unsigned long tout)
> +{
> +	/* avoid 0 timestamp, at that means no close timeout */
> +	inet_csk(sk)->icsk_mtup.probe_timestamp = tout;
> +	if (!inet_csk(sk)->icsk_mtup.probe_timestamp)
> +		inet_csk(sk)->icsk_mtup.probe_timestamp = 1;

Small detail: maybe more readable with:

  /* avoid 0 timestamp, as that means no close timeout */
  inet_csk(sk)->icsk_mtup.probe_timestamp = tout ? : 1;


I can do the modification when applying the patch if that's OK.

> +}
> +
> +static inline void mptcp_start_tout_timer(struct sock *sk)
> +{
> +	mptcp_set_close_tout(sk, tcp_jiffies32);
> +	mptcp_reset_tout_timer(mptcp_sk(sk), 0);
> +}
> +
>  static inline bool mptcp_is_fully_established(struct sock *sk)
>  {
>  	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
