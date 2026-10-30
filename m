Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793328975;
	b=ggz/Hf1mC1YrY5YB/3cXWHzEdLcFnc1bU2KfVLdqVAEoS1ndMBe4RraT4KYOt57dSBhm
	 gD+sMiW6v+my1lR8AaV6eqgYIwS4CtG6ZjUbTsV76bOVphl5FjWKABwRV7QrENqiyXG01
	 ZnIZU072YrpBPMMCVuQ5Itnop6XIWwxhlgOyLFf5zvk5pJaKAe0dd8sxSROr+7v/XdaMn
	 xP8zA+oSWMNTe6m5hMd3uSkuCZyxUamJMPv8v3ESBBgbNawLuAOiUgYf0RuPFspwS6+ux
	 Ncabe+8+zWaNYzXMc+QochR+wxz+LQrVACMUtMEBC7/4SdeRVp+q2635LJuBDRq31mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793328975;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Rq78i59Z7xV5KqHKZijdntodWAuhOwHFPWO5NPUa2lI=;
	b=doTL+EDiuiH0Ovt4nHLS7aYbUWcOBHQR3Lf5BAii0uwqqtlYbQJbjgVaCXqV7Gegdiwf
	 srFeSAL9HsaWgNaq3KPv+BNVn9nrm5JFIDtPxyb5YM3Q4DebaOaKrufpUxT5aL0GNbHyl
	 LC5WcirCG0dIfAp2KZMrDgLwT8ibuQssS24awp+MtNgyC3QOhy3q/lwQ0skkFuJdrMak6
	 SI3U+dFeIaaGAoha8EMjQQhFNC6UiOLF84hVY6Hu1PY3bFnux/LG8Hd1Ny/8OyV1ya09x
	 fL00IREf15aa9LJRTwDFnhvp9PUxO/jw3eJ8+2I5TlyK8X+GaO+EIkqUt8qunrIDa7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RTAjjvcX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904D8606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 02:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RTAjjvcX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6C91F000C1;
	Fri, 30 Oct 2026 02:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793328975;
	bh=Rq78i59Z7xV5KqHKZijdntodWAuhOwHFPWO5NPUa2lI=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=RTAjjvcXl5iseeTsZxb2AIobrWN+wIipOYq4Qi/CeueDJlxwYUBoR07wBn9lRj4aO
	 jpk8bvZQF1Op56HQgSuKWZX4wHGhXBdn/nu3DPw1WOLxs4OPz/dmcY0gGkT2/JxhH0
	 PEr2qIXz2IlpfsO8pEYbrtdy664Xx3F9EtG+GOC0ytMjqUy+OAghTJ2yqMi0W5TZ03
	 U4b2T0RXMtftfm0N3XcZVEBdxjWvKdLka6K7Nl5QyjTV4kZc6bbqTKeqq/hSf/U8LQ
	 8Lj2m4KkKxFEnrLjpF0YS7Vqm/EftlQq8ihun7u+a6gKp+6yB35K7VYWBCZBFDK4cO
	 OQVFE3t4pb6Zg==
Message-ID: <122666ba3f9d26e354912096f62a1aa0e334f328.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 3/3] mptcp: options: reset parsing in case
 of invalidity
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Fri, 30 Oct 2026 10:56:11 +0800
In-Reply-To: <20261029-mptcp-mib-inval-opt-v3-3-428f42a35674@kernel.org>
References: <20261029-mptcp-mib-inval-opt-v3-0-428f42a35674@kernel.org>
	 <20261029-mptcp-mib-inval-opt-v3-3-428f42a35674@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10build1 
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2026-10-29 at 22:05 +0100, Matthieu Baerts (NGI0) wrote:
> When an invalid option is detected -- any unexpected suboptions
> combinations or use of invalid sizes -- the current behaviour is to
> ignore the currently parsed option.
> 
> Receiving such invalid options is suspicious: either this is coming
> from
> a buggy host, or an attacker. In these cases, it seems safer to drop
> any
> previously parsed MPTCP option from such packets. This will likely
> lead
> to a fallback to TCP or a subflow reject, which seems to be a good
> reaction in these situations.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v2: break the while-loop, not the switch-case.
> ---
>  net/mptcp/options.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 10a150e2ad69..b068f4f1861e 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -20,7 +20,7 @@ static bool mptcp_cap_flag_sha256(u8 flags)
>  	return (flags & MPTCP_CAP_FLAG_MASK) ==
> MPTCP_CAP_HMAC_SHA256;
>  }
>  
> -static void mptcp_parse_option(const struct sock *sk, const struct
> sk_buff *skb,
> +static bool mptcp_parse_option(const struct sock *sk, const struct
> sk_buff *skb,
>  			       const unsigned char *ptr, int opsize,
>  			       struct mptcp_options_received
> *mp_opt)
>  {
> @@ -214,14 +214,8 @@ static void mptcp_parse_option(const struct sock
> *sk, const struct sk_buff *skb,
>  		 * RFC 8684 Section 3.3.0 checks later in
> subflow_data_ready
>  		 */
>  		if (opsize != expected_opsize &&
> -		    opsize != expected_opsize +
> TCPOLEN_MPTCP_DSS_CHECKSUM) {
> -			mp_opt->dsn64 = 0;
> -			mp_opt->use_map = 0;
> -			mp_opt->ack64 = 0;
> -			mp_opt->use_ack = 0;
> -			mp_opt->data_fin = 0;
> +		    opsize != expected_opsize +
> TCPOLEN_MPTCP_DSS_CHECKSUM)
>  			goto invalid;
> -		}
>  
>  		mp_opt->suboptions |= OPTION_MPTCP_DSS;
>  		if (mp_opt->use_ack) {
> @@ -424,10 +418,11 @@ static void mptcp_parse_option(const struct
> sock *sk, const struct sk_buff *skb,
>  		break;
>  	}
>  
> -	return;
> +	return true;
>  
>  invalid:
>  	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OPTINVALID);
> +	return false;
>  }
>  
>  void mptcp_get_options(const struct sock *sk, const struct sk_buff
> *skb,
> @@ -464,9 +459,12 @@ void mptcp_get_options(const struct sock *sk,
> const struct sk_buff *skb,
>  				return;
>  			if (opsize > length)
>  				return;	/* don't parse
> partial options */
> -			if (opcode == TCPOPT_MPTCP)
> -				mptcp_parse_option(sk, skb, ptr,
> opsize,
> -						   mp_opt);
> +			if (opcode == TCPOPT_MPTCP &&
> +			    !mptcp_parse_option(sk, skb, ptr,
> opsize, mp_opt)) {
> +				/* invalid option, drop previously
> parsed opt */
> +				*(u32 *)&mp_opt->status = 0;

I hesitated at first on why clearing status alone is sufficient to
replace clearing all the individual bit fields. After a closer look at
struct_group(status, ...), it covers suboptions and all the bit fields
(use_map, dsn64, data_fin, use_ack, ack64, etc.) in one shot - more
thorough than the old per-field clearing, and better for future
extensibility as new fields added to the group are automatically
covered.

So this patch looks good.

	Reviewed-by: Geliang Tang <geliang@kernel.org>

> +				return;
> +			}
>  			ptr += opsize - 2;
>  			length -= opsize;
>  		}
