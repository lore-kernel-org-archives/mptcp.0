Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0963441612A
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 05:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791954826; cv=none; b=WAFxqoI1v5l7OZ/NJWrbJIxEXBiqqOM+qDrdwFHnPqVSlSuWsX17y0fwRAKl4WI5sYVxV3gUPAwrryx4U9mESfZ7Ei9VNZAaYrwzm3nk7vGD9eFzis0ebDnU6AlIDSvxnsKIGOU2/tld1IcI2X3/8rOt0SADkJO2Vkvxd+F1zPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791954826; c=relaxed/simple;
	bh=n7UQH2dAB6e7eCUTrqRrbBz4vi+fqy9kbHXf2oy+oxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L63jbLxY+dmsymDZhPGSGY+26PqEyWzDjHJKlFPb+SyZ2ary15id7krccTD9ucvUotZJ6hoDHXk9PrEu8W6MUJn7X5PMwU42920tB3eIrjsU22IXYlqkRL4X3NY+a9tiaFwAC7XPOdwXZ1lRBTRh96pMlMYdka+Vym/Fue4GC2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5x3xKVw; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5x3xKVw"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso133818f8f.1
        for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 22:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791954823; x=1792559623; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A6eKNCXYVr5WLXmMwH40qQ+TRWBdLnu+ATms5IRKfPU=;
        b=A5x3xKVwNyJ3Hwj4DFp0u5rmecjkFui4z+hZhKIRodXJiox2FVJf5qQU4li2pbvH2x
         eOU4LJoVX2mI7iLXaY7wJMMWe1gkmZv+wbKnKjoy9/d1or0bDhCQi2k2otzbqicNrOyS
         vXPsMrOey5Glf72Y6YaTXhYimqasyskan5nFgdk2ITqYrKIITc21NciXrT5H4nyMYR88
         GYHwFhLSGzzUhEpGLcRnxVedmlrkbeE9LdvsgLawPr6OheiECOkgdmfuJcKa2VNcH9tS
         lThVJkP3NwhqN/VkMzjb0o/R53t7p5sTcGa09ENXkS0xRZoOFXyXeNetKc9lYWEkq9Il
         vTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791954823; x=1792559623;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A6eKNCXYVr5WLXmMwH40qQ+TRWBdLnu+ATms5IRKfPU=;
        b=Yil29nBd7ctsEwWvNANtuwoX8F9/Tr0aEBRHISK7W8u4E+sxOMyx/YPLdJ2xoVWi3K
         kE6YYTbj6Ogg0n+jp3pIIUwvaNri2cgmguLY0hvH9nSgpxcnkfvLcmO0Z0so37Il5O5y
         FQsZmWxmF08YXwxto95CvFYCoCL/Ddi1W6knjQI0z/sHEfPWulj1hST1WmfwnnKUu0SJ
         +NeljNXWfYBY8O7KzPBcOBbeFOFfyekF4LE2M/Odz5GANrs+ccxuxpN96ldhaT329F52
         aAY6ub/Z1P2m8XmRFrI/GPQ6R5ILZaF8ndANWFFd2x2wUbsn+HADbMsqQQtT+uIKwCtW
         xqqQ==
X-Gm-Message-State: AFq9FYLlKEHej0nfpeO8+pAtE0c10obB6R3cyYjTE5ouSEVH8r/N86uD
	V8rGcnckmPQDK1ZfsLxf18ggSARPuW9mbmkJZ0B44UX80hFn6Jt8bxE8
X-Gm-Gg: AYBFou3VQr2rD1SST8cVjIp4HFIUVYP9GJlqBV1Vnu7QSOmlNa5CAHVSgNielev6BPL
	6BHLmkmHU2mdgbdZ4ckc06ExamErcW/vnaXZTWNLrSHZY+1hqmM2E0h33dQxVE5/+LsagnsXTAG
	B2KqFNULRKFjm+14ES3pWdEaCqbjoxAx27Tn4+cz6DXrKEPT6A6MGBYuhPyMRBnw4VcFjNkpS+t
	sStX+txc9kPpJMbuh8+Aumt1TT+Voz8VACJiWQkgYXliCZq4Bef+TEWSjRUoIXfaZ006+HtgI6J
	dFj17wjEc4BsC/lpRAqbLeVIW2010pX3oB5Z9n97GZsYyLlYpPcjLMWi4WoCSJQm4EYXtalQqi+
	fJLgF1MM4A7W0kgIITf6DfxdfORI0lzlYqQDea87S/BXQWMlXqB2lHL80iHhoI8n2mUwhgwQ5uT
	ZgYR4N/boB7zV/aTfGoA5N56CU7T58ouigDu0r+8OzFtqNmpOc15byUK3q1n6H7HBjQb65vZl3x
	O30iinwuipQyI4P4JHfJqY=
X-Received: by 2002:a05:6000:288a:b0:488:8568:bb02 with SMTP id ffacd0b85a97d-48dba9e6727mr26830117f8f.23.1791954823039;
        Tue, 13 Oct 2026 22:13:43 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaaad1sm9155942f8f.17.2026.10.13.22.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 22:13:42 -0700 (PDT)
Date: Wed, 14 Oct 2026 07:13:36 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>,
	linux-security-module@vger.kernel.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Subject: Re: [PATCH mptcp-next 1/2] mptcp: add msk_is_mptcp() helper
Message-ID: <20261014.8253317f0919@gnoack.org>
References: <cover.1791873760.git.tanggeliang@kylinos.cn>
 <1b21558a40905ae312d2ac987de4db0a04db3c02.1791873760.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b21558a40905ae312d2ac987de4db0a04db3c02.1791873760.git.tanggeliang@kylinos.cn>

On Tue, Oct 13, 2026 at 02:56:46PM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Introduce msk_is_mptcp() to check whether a socket is an MPTCP socket
> (IPPROTO_MPTCP on SOCK_STREAM), modeled after sk_is_tcp(). Unlike
> sk_is_mptcp() which tests a subflow socket, this helper takes an
> MPTCP parent socket directly.
> 
> The naming follows the convention of rsk_is_mptcp() to distinguish it
> from sk_is_mptcp(). This helper will be used in net/core/sock_map.c
> alongside sk_is_tcp() to add MPTCP support for BPF sockmap, and in
> other places where MPTCP parent socket type checking is needed.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/mptcp.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 30f0e8ba88a8..8943d9f2b48b 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -150,6 +150,13 @@ static inline bool rsk_drop_req(const struct request_sock *req)
>  	return tcp_rsk(req)->is_mptcp && tcp_rsk(req)->drop_req;
>  }
>  
> +static inline bool msk_is_mptcp(const struct sock *sk)
> +{
> +	return sk_is_inet(sk) &&
> +	       sk->sk_type == SOCK_STREAM &&
> +	       sk->sk_protocol == IPPROTO_MPTCP;
> +}
> +
>  void mptcp_space(const struct sock *ssk, int *space, int *full_space);
>  bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
>  		       unsigned int *size, struct mptcp_out_options *opts);
> @@ -261,6 +268,11 @@ static inline bool rsk_drop_req(const struct request_sock *req)
>  	return false;
>  }
>  
> +static inline bool msk_is_mptcp(const struct sock *sk)
> +{
> +	return false;
> +}
> +
>  static inline bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
>  				     unsigned int *size,
>  				     struct mptcp_out_options *opts)
> -- 
> 2.55.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

Thank you Geliang!  This is exactly the helper we'd need for the
Landlock MPTCP patch as well, and I'll happily rebase my patch set on
that and use this more central helper!

(Landlock is currently a bit bottlenecked on code reviews, so that
review is moving a bit slower, but we'll get to it.)

–Günther
