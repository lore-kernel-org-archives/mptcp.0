Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282F333BBD7
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792115070; cv=none; b=lIH9k7qTCgHhvqGycerwmkgjLLS9H8uHnlENyrbuAZMEhNc5/ShHFlDTh7oxjmiVr+LirraBuAOKRAKaI5tkpal8ve3KP07I2etbwINWwTVckjpJTQWdV+jdhOHGE0AK4eb74NTgXBA6AyDO18ElmaLo8iArfPdHA1WCeQxn0Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792115070; c=relaxed/simple;
	bh=UkiRgWpTMqV0uGkD2Lu2MZrJ8I6VbU1RlHCCGcrBDZk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gsREXa6nGOn3j+v8xOrC/bJoXqr1UFU7KfcDvzxW8h9idNf808tLs2HlFPZ3CsbJhKhJAZwaTIjBVL1bOgj05leLUYEPshnaDnlzlHh7Bkd9EF4w7snPHqaVEMayfFE2dzSArzeJM1zQgPoD5F7JFJKfnn3Ln2cTGxQT+NTFOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clNE+CQU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clNE+CQU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674271F000C4;
	Fri, 16 Oct 2026 01:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792115068;
	bh=O4SrLMEk/UEXMQchFDErtVAZ/Xl+qXUetltCVRCbuks=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=clNE+CQUHhccuvIYoLF0Z44+A+vG0KSRcWtNfuEYNw/yhiuOWd58T33CDXEjJhuI1
	 nHUbTVW7Lnq+JQTQmnXOeCHnibO5QQVBKMP8w5D5S461ESH+CZ1Ov5iejERWGt1CFL
	 SmM6CbjeoGCersFsILPFC8nOuu+oWCgoGi0MBGWuVuuoT75QIpDlyqhp/ObKd7ubXZ
	 i2Ex3D+JuVkLxQMbQWwIzxFG8/YENhJ/77fMNQKIdpwHRS7zreMJwJ4R0wgm5Qp5au
	 UUmWHiKQwKNLUlJYORtaifnEXlr8RjwJKVpjy2gPkqrPxvW/4Cb63xmaftP5uMPya4
	 yd0zbFy6iLE6Q==
Message-ID: <7855c469ddb6d3d672023adc9ca482681be39a4e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/2] mptcp: add msk_is_mptcp() helper
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, =?ISO-8859-1?Q?G=FCnther?= Noack
	 <gnoack3000@gmail.com>
Date: Fri, 16 Oct 2026 09:44:23 +0800
In-Reply-To: <1b21558a40905ae312d2ac987de4db0a04db3c02.1791873760.git.tanggeliang@kylinos.cn>
References: <cover.1791873760.git.tanggeliang@kylinos.cn>
	 <1b21558a40905ae312d2ac987de4db0a04db3c02.1791873760.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10build1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Tue, 2026-10-13 at 14:56 +0800, Geliang Tang wrote:
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

The commit log needs to be updated. We rarely say "MPTCP parent socket"
- "MPTCP socket" is sufficient:

'''
Introduce msk_is_mptcp() to check whether a socket is an MPTCP socket
(IPPROTO_MPTCP on SOCK_STREAM), modeled after sk_is_tcp(). Unlike
sk_is_mptcp() which tests a subflow socket, this helper takes an
MPTCP socket directly.

The naming follows the convention of rsk_is_mptcp() to distinguish it
from sk_is_mptcp(). This helper will be used in net/core/sock_map.c
alongside sk_is_tcp() to add MPTCP support for BPF sockmap, and in
other places where MPTCP socket type checking is needed.
'''

Thanks,
-Geliang

> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/mptcp.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 30f0e8ba88a8..8943d9f2b48b 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -150,6 +150,13 @@ static inline bool rsk_drop_req(const struct
> request_sock *req)
>  	return tcp_rsk(req)->is_mptcp && tcp_rsk(req)->drop_req;
>  }
>  
> +static inline bool msk_is_mptcp(const struct sock *sk)
> +{
> +	return sk_is_inet(sk) &&
> +	       sk->sk_type == SOCK_STREAM &&
> +	       sk->sk_protocol == IPPROTO_MPTCP;
> +}
> +
>  void mptcp_space(const struct sock *ssk, int *space, int
> *full_space);
>  bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
>  		       unsigned int *size, struct mptcp_out_options
> *opts);
> @@ -261,6 +268,11 @@ static inline bool rsk_drop_req(const struct
> request_sock *req)
>  	return false;
>  }
>  
> +static inline bool msk_is_mptcp(const struct sock *sk)
> +{
> +	return false;
> +}
> +
>  static inline bool mptcp_syn_options(struct sock *sk, const struct
> sk_buff *skb,
>  				     unsigned int *size,
>  				     struct mptcp_out_options *opts)
