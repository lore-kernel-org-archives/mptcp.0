Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AA21A267
	for <mptcp@lists.linux.dev>; Thu,  2 Jul 2026 05:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782970690; cv=none; b=llTu9IiooXukMgZpXCeefTcBt2FCCisWuAj2tkNjST+0aHfBwE0PVoQXnVdsvw/D7h4Pn1EeHug96mmFWPEJBTNnlGgFHlitQUmSAKCUtHxm2ADxW9dhVBkeejEZAgFjXWDHeiT8pnQtiggTN78gIkMp0EHtaYh73+36Uyfc4V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782970690; c=relaxed/simple;
	bh=xUA76QlejOY8po4mE7snPR8pwYhHOfvpD1vHFhONGX4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=apGsr3tDGFyBb/kP0bXPJScqBJNHbU+Cqu4v01Lk7MHEB4oEFbj5EoC7MunPCRKhaBZDet98TATh25dBX0obnjZ8Mx6PpaM55XQsohEOoDk7FpTrNoaBIVEbW+vwOPznP67OC+S48K655IJAQ6A5RseAsVPpm+TS+q8kSMuuDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMRvMSA9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMRvMSA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4819C1F000E9;
	Thu,  2 Jul 2026 05:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782970687;
	bh=cCT19X1WZ+VWOtR9ixoLZ8rrXhB6P4gyYBMBt9T/Khs=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=ZMRvMSA9xRiIFoYyNULAH+6KFLBNa+KSfcuzNkA5OPFBocI4URZXefzZldESbzVPl
	 OEcBW4u02g/KTgmLjR0Ls0Y7iThYbURNmG3q1PV/ppgwY8d4owLta6B0unCPDzfpOR
	 4EohAHjdwjzqv71uR03QOHHlFO/5kMcaBdqO8Kohbe+YSBT2SlZQwRG4ROSt0MOW5r
	 gP+iIYalGRNIOX7jZifQmncar3OajcopEjic4QKTiRM0zst6Y7Chmc29jyhLPzi+4Z
	 xAdr5UAl5zocxg36vS9ik2QZoSYncY/I/6FjLEBxZddUBJ/5xQDHMdwbEmXEe4U1k0
	 9vt/W2qiDbllw==
Message-ID: <90819ea85ce4e27d901f1d67114b01de8ea485bf.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 4/4] mptcp: use READ_ONCE() over sysctls
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Thu, 02 Jul 2026 13:37:59 +0800
In-Reply-To: <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-4-d7c842e80446@kernel.org>
References: 
	<20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-0-d7c842e80446@kernel.org>
	 <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-4-d7c842e80446@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this patch.

On Mon, 2026-06-01 at 18:27 +1000, Matthieu Baerts (NGI0) wrote:
> To avoid KCSAN issues.
> 
> This patch is in theory for -net, and will need to be split in
> multiple
> patches, with different Fixes tags. But I prefer to wait for Eric's
> patches, as I noticed he already started to modify mptcp_is_enabled:
> 
>  
> https://lore.kernel.org/CANn89iLdwhhwLyO6zRjWMEY3t9g60ZE8ZhOVx33ucg_uRETbmQ@mail.gmail.com
> 
> Still, keeping this patch in this series, not to forget about it.
> 
> Reported-by: Eric Dumazet <edumazet@google.com>
> Closes:
> https://lore.kernel.org/CANn89iL=os-60kDKqMDdyiXuPF5CG=eejS0vmthwpDGXz_Bp8A@mail.gmail.com
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/ctrl.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 63c5747f0f63..1dee42601700 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -50,39 +50,39 @@ static struct mptcp_pernet
> *mptcp_get_pernet(const struct net *net)
>  
>  int mptcp_is_enabled(const struct net *net)
>  {
> -	return mptcp_get_pernet(net)->mptcp_enabled;
> +	return READ_ONCE(mptcp_get_pernet(net)->mptcp_enabled);
>  }
>  
>  unsigned int mptcp_get_add_addr_timeout(const struct net *net)
>  {
> -	return mptcp_get_pernet(net)->add_addr_timeout;
> +	return READ_ONCE(mptcp_get_pernet(net)->add_addr_timeout);
>  }
>  
>  int mptcp_is_checksum_enabled(const struct net *net)
>  {
> -	return mptcp_get_pernet(net)->checksum_enabled;
> +	return READ_ONCE(mptcp_get_pernet(net)->checksum_enabled);
>  }
>  
>  int mptcp_allow_join_id0(const struct net *net)
>  {
> -	return mptcp_get_pernet(net)->allow_join_initial_addr_port;
> +	return READ_ONCE(mptcp_get_pernet(net)-
> >allow_join_initial_addr_port);
>  }
>  
>  unsigned int mptcp_stale_loss_cnt(const struct net *net)
>  {
> -	return mptcp_get_pernet(net)->stale_loss_cnt;
> +	return READ_ONCE(mptcp_get_pernet(net)->stale_loss_cnt);
>  }
>  
>  unsigned int mptcp_close_timeout(const struct sock *sk)
>  {
>  	if (sock_flag(sk, SOCK_DEAD))
>  		return TCP_TIMEWAIT_LEN;
> -	return mptcp_get_pernet(sock_net(sk))->close_timeout;
> +	return READ_ONCE(mptcp_get_pernet(sock_net(sk))-
> >close_timeout);
>  }
>  
>  int mptcp_get_pm_type(const struct net *net)
>  {
> -	return mptcp_get_pernet(net)->pm_type;
> +	return READ_ONCE(mptcp_get_pernet(net)->pm_type);
>  }
>  
>  const char *mptcp_get_path_manager(const struct net *net)
> @@ -551,7 +551,7 @@ void mptcp_active_detect_blackhole(struct sock
> *ssk, bool expired)
>  
>  	net = sock_net(ssk);
>  	timeouts = inet_csk(ssk)->icsk_retransmits;
> -	to_max = mptcp_get_pernet(net)-
> >syn_retrans_before_tcp_fallback;
> +	to_max = READ_ONCE(mptcp_get_pernet(net)-
> >syn_retrans_before_tcp_fallback);
>  
>  	if (timeouts == to_max || (timeouts < to_max && expired)) {
>  		subflow->mpc_drop = 1;
> 

I hesitated for a moment about why READ_ONCE() was not added in
mptcp_get_path_manager() and mptcp_get_scheduler(), and the result is
that they are defined as arrays rather than pointers, so READ_ONCE() is
not applicable.

So this patch looks good to me.

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang


