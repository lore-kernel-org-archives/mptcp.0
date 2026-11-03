Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793679900;
	b=wfyCr0S1VddNwnjAiayhUz3SgOXDVxzynfxh9+VQ0z8It6QhPQTeP3i5V0hrk1lCOxzS
	 Ly0jpyVsGr3YZ56u3J3BpjI/vFavG5xqy0/OLLO2DvPA5Gjgna9fxjdH8zSI9RYezT3Y0
	 CdaSOyDIN+YOS6rmOD7c2rXV49ft7cZbpsYc9cUNdMM8plPa0pDpqTSCG93GGD0VcTMy3
	 DbMFnPIz+uHXo6E4wRGx970yPvmrpPY/1X8Xk+/79w7XFRMynseFbPJQeumq1Rj2YTmid
	 6fLF4QZ5/lPwhktVdR6ehN+0TOirtqUkXD4gnQSEquQ3udl1RozzrackSe+9d63ek1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793679900;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PNSz3DJiu1GQyeIB9wh/IZobQZv4Hvltt8nmMHUXDUI=;
	b=D1GUcVXl54BdvOLxdE1tA+x6tqemaedVvnfyNI+zKS+wnNaY0GvkXq2PUvHxBEMyyecF
	 h+LH7hWsvCwAyCGk6GXf5/cGI/ddueqHxIL7HjZqh6SIqbfFF+BoQba5n6nloYX2IpJ13
	 HmEEe0yGREN+k14e5E+epcF2YoeX7cA3Umdzrnx+/LFbQgo6S3nDT70Q9PTDaM1o1eGiu
	 Iei/GH+Zwhug+si6bVpxDfEPEu+mKR8hiVleRN7GmxgPql2pEhd/hvWbOZhpdOrJa/BEc
	 qowWMaA7jGq81G65hemBYIQOtfnre2hq0S07InkMtSOY4ZSwf6kef2yzVki+cJZEJ4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWHGBQor;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0820E606A324
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 04:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWHGBQor
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0A41F000C1;
	Tue,  3 Nov 2026 04:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793679899;
	bh=PNSz3DJiu1GQyeIB9wh/IZobQZv4Hvltt8nmMHUXDUI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UWHGBQormtE0wJISvUQJuFa1y5EI0mtTggilQ6YgV9JMsb5km4zvAllMbQBZEL9AO
	 8hlDQBgeOq8KonjFJ0BwhIiyqeWh1tpzYBsguLJHIJ2NVYI23FYcpJtaGFvvPQWLn3
	 /yTEJgM0DlTfHFMXnY4PPvIODsgkpdMKNA5n06UV0UkBcv3D4/jiJasJvHhhMbNc82
	 nX+xEC1I2ZRUbqTZdbJ1gQM590fRvAAmbP+dRSd04XIA9CFF0TS9opKXujsS7fw2FM
	 +WZhWN3tOLTm/AGJOozeGjoWSNrKj4O57jv9l/Xlzeyc+mDf2dE3eBUwttQsMHUYqC
	 plIWWr8VPjAtA==
Message-ID: <d5798edb938a01d174e01a95596dd5ec608b0680.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 2/7] mptcp: use mptcp_data_avail in
 mptcp_inq_hint
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 03 Nov 2026 12:24:56 +0800
In-Reply-To: <ccd9f70eddb3df2c311b75f559d9acea3233295f.1793676064.git.tanggeliang@kylinos.cn>
References: <cover.1793676064.git.tanggeliang@kylinos.cn>
	 <ccd9f70eddb3df2c311b75f559d9acea3233295f.1793676064.git.tanggeliang@kylinos.cn>
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

Hi Matt,

On Tue, 2026-11-03 at 11:29 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Update mptcp_inq_hint() to compute available bytes using mptcp_data_avail()
> (bytes_received - bytes_consumed) instead of ack_seq minus the head skb's
> map_seq.
> 
> This change aligns mptcp_inq_hint() with mptcp_inq() and provides more
> consistent behavior across different connection types, including passive
> TFO connections where the TFO skb has map_seq set to -skb->len (data
> before IASN). Using mptcp_data_avail() avoids potential overflow issues
> when ack_seq is set to iasn.
> 
> The EOF hint behavior (returning 1 when socket is closed with no data)
> is preserved by checking if avail is zero and the socket state indicates
> closure or shutdown.

Sorry, I forgot to update the commit log:

'''
Update mptcp_inq_hint() to compute available bytes using mptcp_data_avail()
(bytes_received - bytes_consumed) instead of ack_seq minus the head skb's
map_seq.

On passive TFO connections, the TFO skb has map_seq set to -skb->len
(representing data before IASN). When ack_seq is later set to iasn (a
large positive value), the subtraction ack_seq - map_seq overflows,
causing SIOCINQ and TCP_CM_INQ to return INT_MAX instead of the actual
byte count. Using mptcp_data_avail() avoids this overflow by tracking
bytes directly without depending on map_seq.

The EOF hint behavior (returning 1 when socket is closed with no data)
is preserved by checking if hint_val is zero and the socket state indicates
closure or shutdown.
'''

Thanks,
-Geliang

> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/protocol.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0caa31525b90..1704e689bc93 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2402,22 +2402,16 @@ static bool mptcp_move_skbs(struct sock *sk)
>  static unsigned int mptcp_inq_hint(const struct sock *sk)
>  {
>  	const struct mptcp_sock *msk = mptcp_sk(sk);
> -	const struct sk_buff *skb;
> +	u64 hint_val = mptcp_data_avail(msk);
>  
> -	skb = skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)-
> >map_seq;
> +	if (hint_val >= INT_MAX)
> +		return INT_MAX;
>  
> -		if (hint_val >= INT_MAX)
> -			return INT_MAX;
> -
> -		return (unsigned int)hint_val;
> -	}
> -
> -	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
> +	if (!hint_val &&
> +	    (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
>  		return 1;
>  
> -	return 0;
> +	return (unsigned int)hint_val;
>  }
>  
>  static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
