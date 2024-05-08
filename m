Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4E2127E2A
	for <mptcp@lists.linux.dev>; Wed,  8 May 2024 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183064; cv=none; b=EKH/9gWKnBTNu0PJH+iGVDcELchC+NHfVh4WIgqMXzC8NPwk47Yoy5x18DI1HjIH+ZqOUzqZcX/M0CNZneTCWtSvV0XJfrAdwZPgVMHlDonZJrMhoZkMM/RnKob4pbgKP8lm3zQ3BrV1KVqcNi3y5h6Z41z7jvYu7v+NoY4R8Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183064; c=relaxed/simple;
	bh=S1k9zJUq1BqoF/tbskzPPeg4IdxDxLdEpT3gF4yqOUM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9CLRS7dupS4zgfaK45PelNiws7hiDhFbMmU890Ru+f3O/WP2jLEMazd2bbu/c4WWh7qb0LECBLfdODW84Xr314TQ5p9jqauZb+4t5KpZhRJg9b6lmPl80UCvOQ7SukmyhwDi7ozNEXDn7TkClQZbSnc24kD+CM3JnKwdPgEFRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BoD4T3Rb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoD4T3Rb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715183061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=N/0IzuaRXKVXNYVhdBe3a7eHkFvCM71pEGP0pUkAPBs=;
	b=BoD4T3Rbz3ts5VXcxz7S0H+PoDmOi+kAfhbtNyPGSSpfCDIPXLAUQkvrSOc+WPiTrgVM7u
	MiPHNjndtQLGtL7tbvZt0wnmnbNriD4lzivxVgSSaIlLf6271/Tsn5GZrKGnvYS0omkPBy
	ZNc5uqtv7TlWnIqnlXR832F8zH1gBbg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-imm1nsg_N2qinmUUoC5_xA-1; Wed, 08 May 2024 11:44:20 -0400
X-MC-Unique: imm1nsg_N2qinmUUoC5_xA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2e1fc66f6d8so7380611fa.2
        for <mptcp@lists.linux.dev>; Wed, 08 May 2024 08:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715183059; x=1715787859;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HqP3OnVRzQGD0cZ0SyaOwm34zrh3K//DGYeNO5wjY4w=;
        b=NTMEmPLaw/fHmBZ0mBqJwK9LIX5o32GtsAi+GkjM3YfHO4m6o7qz9ybqzQMB/7rQ+O
         ORmnGpWrfq5JA1RcC9koDo0hDs6078GMKHFyDJkzd2guKlB2Gldq5diM3IoEp22JONGc
         YknjNv5HHUhV65kxj6Ug594AUkRyI16t5KAmNNvzy8O701kIX5aaklf+4/sZEUjhRsU2
         DZznaVaKcWlcRAT9FqvPgSUTLwUt+IM1pLMXf5EO/u+N/uRR+bffM1No7UuEZrmYqCgs
         CZCvvU6LEVKvPPclsFUCBV9usgnZijcMTsog2IJ9Jr6vcDreyc3Zl8SjluujwJ0Lxdil
         sZwA==
X-Forwarded-Encrypted: i=1; AJvYcCUOj6qbSHapWEuZxZZjXhjzoz0r7OZlJCYBtzLvE4KABnZdMqjZe8iTAf+jX+f2dX3lOrOT2oizL9EbISdYNTbT29TvYXQ=
X-Gm-Message-State: AOJu0YwSDW05uSKC2ouBqk6xdtB8hIeB0jOHdXI1CiMzfEwUYu8159S6
	WAsivWIeG9bOJ9+3IX7kvup98gVeojuMaMQjycap86fLkM/dPJcFOEM0TUkvvDQYrNpMiEisir3
	IYsbs/vZiGCwE3qO3HaxV+KvDF83qA1Yko1VXAgDyqkMIjshDJtBO
X-Received: by 2002:a2e:b0ca:0:b0:2de:d4ef:47d8 with SMTP id 38308e7fff4ca-2e4477b4f34mr18554501fa.3.1715183058554;
        Wed, 08 May 2024 08:44:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5XDSS5nJaQhXfUkhh3FX7LKjbI3imNbnGxlBLJM/Qyne71K1brBV8CnRdBJNQgii53MjVbw==
X-Received: by 2002:a2e:b0ca:0:b0:2de:d4ef:47d8 with SMTP id 38308e7fff4ca-2e4477b4f34mr18554301fa.3.1715183057964;
        Wed, 08 May 2024 08:44:17 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b09b:b810::f71])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c4ecc00b0041892857924sm2693466wmq.36.2024.05.08.08.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:44:17 -0700 (PDT)
Message-ID: <dbaa4e59f1dbdbcf77634349ee968b4199b786f7.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 2/2] mptcp: fix full TCP keep-alive support
From: Paolo Abeni <pabeni@redhat.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 08 May 2024 17:44:16 +0200
In-Reply-To: <20240508-mptcp-tcp-keepalive-sockopts-v1-2-fdf7e03e14c4@kernel.org>
References: <20240508-mptcp-tcp-keepalive-sockopts-v1-0-fdf7e03e14c4@kernel.org>
	 <20240508-mptcp-tcp-keepalive-sockopts-v1-2-fdf7e03e14c4@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-05-08 at 11:44 +0200, Matthieu Baerts (NGI0) wrote:
> SO_KEEPALIVE support has been added a while ago, as part of a series
> "adding SOL_SOCKET" support. To have a full control of this keep-alive
> feature, it is important to also support TCP_KEEP* socket options at the
> SOL_TCP level.
>=20
> Supporting them on the setsockopt() part is easy, it is just a matter of
> remembering each value in the MPTCP sock structure, and calling
> tcp_sock_set_keep*() helpers on each subflow. If the value is not
> modified (0), calling these helpers will not do anything. For the
> getsockopt() part, the corresponding value from the MPTCP sock structure
> or the default one is simply returned.
>=20
> It looks important for kernels supporting SO_KEEPALIVE, to also support
> TCP_KEEP* options as well: some apps seem to (wrongly) consider that if
> the former is supported, the latter ones will be supported as well. But
> also, not having this simple and isolated change is preventing MPTCP
> support in some apps, and libraries like GoLang [1]. This is why this
> patch is seen as a fix.
>=20
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/383
> Fixes: 1b3e7ede1365 ("mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIOR=
ITY")
> Link: https://github.com/golang/go/issues/56539 [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/protocol.h |  3 +++
>  net/mptcp/sockopt.c  | 57 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 60 insertions(+)
>=20
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index c09357e04f23..8c7ab1d50c75 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -309,6 +309,9 @@ struct mptcp_sock {
>  =09=09=09in_accept_queue:1,
>  =09=09=09free_first:1,
>  =09=09=09rcvspace_init:1;
> +=09u8=09=09keepalive_cnt;
> +=09unsigned int=09keepalive_idle;
> +=09unsigned int=09keepalive_intvl;

It's a bit a pity we have to duplicate such values in all the subflows
_and_ in the msk...

>  =09u32=09=09notsent_lowat;
>  =09struct work_struct work;
>  =09struct sk_buff  *ooo_last_skb;
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index d9f0d36e24ad..794d8b63024a 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -622,6 +622,30 @@ static int mptcp_setsockopt_sol_tcp_congestion(struc=
t mptcp_sock *msk, sockptr_t
>  =09return ret;
>  }
> =20
> +static int __mptcp_setsockopt_set_val(struct mptcp_sock *msk, int max,
> +=09=09=09=09      int (*set_val)(struct sock *, int),
> +=09=09=09=09      unsigned int *msk_val, int val)
> +{
> +=09struct mptcp_subflow_context *subflow;
> +=09int ret =3D 0;
> +
> +=09if (val < 1 || val > max)
> +=09=09return -EINVAL;

I think it would be better just skip this check, to avoid copying more
logic from TCP, and do the store and sockopt_seq_inc() only when the
operation is successful on all the subflows.

> +
> +=09*msk_val =3D val;
> +=09sockopt_seq_inc(msk);
> +
> +=09mptcp_for_each_subflow(msk, subflow) {
> +=09=09struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +
> +=09=09lock_sock(ssk);
> +=09=09ret |=3D set_val(ssk, val);

the above produces 'reasonable' return code only if all 'set_val' calls
will return the same error code.

That expectation should be respected by the existing code, but what
about keeping the first error code only? e.g:

=09int err, ret;
=09// ...

=09=09ret =3D set_val(ssk, val);
=09=09err =3D err ?: ret;

=09// ...
=09return err;

> +=09=09release_sock(ssk);
> +=09}
> +
> +=09return ret;
> +}
> +
>  static int __mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, int v=
al)
>  {
>  =09struct mptcp_subflow_context *subflow;
> @@ -818,6 +842,22 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_soc=
k *msk, int optname,
>  =09case TCP_NODELAY:
>  =09=09ret =3D __mptcp_setsockopt_sol_tcp_nodelay(msk, val);
>  =09=09break;
> +=09case TCP_KEEPIDLE:
> +=09=09ret =3D __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPIDLE,
> +=09=09=09=09=09=09 &tcp_sock_set_keepidle_locked,
> +=09=09=09=09=09=09 &msk->keepalive_idle, val);
> +=09=09break;
> +=09case TCP_KEEPINTVL:
> +=09=09ret =3D __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPINTVL,
> +=09=09=09=09=09=09 &tcp_sock_set_keepintvl,
> +=09=09=09=09=09=09 &msk->keepalive_intvl, val);
> +=09=09break;
> +=09case TCP_KEEPCNT:
> +=09=09ret =3D __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPCNT,
> +=09=09=09=09=09=09 &tcp_sock_set_keepcnt,
> +=09=09=09=09=09=09 (unsigned int *)&msk->keepalive_cnt,

keepalive_cnt is 'u8' so the above will be technically a buffer
overflow ;) If we keep 'keepalive_cnt' in msk, it has to become
an=C2=A0'unsigned int'

> +=09=09=09=09=09=09 val);
> +=09=09break;
>  =09default:
>  =09=09ret =3D -ENOPROTOOPT;
>  =09}
> @@ -1332,6 +1372,8 @@ static int mptcp_put_int_option(struct mptcp_sock *=
msk, char __user *optval,
>  static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>  =09=09=09=09    char __user *optval, int __user *optlen)
>  {
> +=09struct sock *sk =3D (void *)msk;
> +
>  =09switch (optname) {
>  =09case TCP_ULP:
>  =09case TCP_CONGESTION:
> @@ -1352,6 +1394,18 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_s=
ock *msk, int optname,
>  =09=09return mptcp_put_int_option(msk, optval, optlen, msk->nodelay);
>  =09case TCP_NOTSENT_LOWAT:
>  =09=09return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowa=
t);
> +=09case TCP_KEEPIDLE:
> +=09=09return mptcp_put_int_option(msk, optval, optlen,
> +=09=09=09=09=09    msk->keepalive_idle ? :
> +=09=09=09=09=09    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_tim=
e) / HZ);

If we force the first subflow to be present/allocated at setsockopt
time, then here we could:

=09case TCP_KEEPIDLE:
=09case TCP_KEEPIDLE:
=09case TCP_KEEPCNT:
=09=09return do_tcp_getsockopt(msk->first, SOL_TCP,
optname,=C2=A0
=09=09=09=09=09USER_SOCKPTR(optval),
=09=09=09=09=09USER_SOCKPTR(optlen));

> +=09case TCP_KEEPINTVL:
> +=09=09return mptcp_put_int_option(msk, optval, optlen,
> +=09=09=09=09=09    msk->keepalive_intvl ? :
> +=09=09=09=09=09    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_int=
vl) / HZ);
> +=09case TCP_KEEPCNT:
> +=09=09return mptcp_put_int_option(msk, optval, optlen,
> +=09=09=09=09=09    msk->keepalive_cnt ? :
> +=09=09=09=09=09    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_pro=
bes));
>  =09}
>  =09return -EOPNOTSUPP;
>  }
> @@ -1467,6 +1521,9 @@ static void sync_socket_options(struct mptcp_sock *=
msk, struct sock *ssk)
>  =09=09tcp_set_congestion_control(ssk, msk->ca_name, false, true);
>  =09__tcp_sock_set_cork(ssk, !!msk->cork);
>  =09__tcp_sock_set_nodelay(ssk, !!msk->nodelay);
> +=09tcp_sock_set_keepidle_locked(ssk, msk->keepalive_idle);
> +=09tcp_sock_set_keepintvl(ssk, msk->keepalive_intvl);
> +=09tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
> =20
>  =09inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
>  =09inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
>=20

