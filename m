Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794739993;
	b=0du+5rDoF/UWidtBHRmvl/yy9XutZTMfFHGHXie2g9Q0WN5eTWxCD0m+cV7e3un9lw+8
	 ovuENcasd0CC9ofIvk8eI2B1tpfQhEIzH93x9MHFivPzKBLKMj000WW01Fi0hLeFTfRdG
	 VD4QZdXfuD8Y2lc8f1hH9EiUzmyvmRrKXFLfEewXS0B1v2ixPEdDNaA/NUDZpqREIKYgH
	 Ozdy+yC7mEzaIZX+a3oW3ae9q+F3/QrEf9WXA/rQn6aHKrCSGzPZ8bqkR1tekS0ZDcF54
	 v9O+lV6MkV1rFXOWRp4tCZq+P2Df/uJKkJ5Bwc99pe8KBy6Ab6sDWuS88Bo7A6Fy7aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794739993;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ty18tLj0CF5OgQyR/HVdu+dQPBLZ+Teuz2xCP33f+QI=;
	b=DxgCszES1dbFdypJ9k/qNEqRpsh+UPwOSiw1szTQQvUw/Xd21+ftK4I4YaFTrVCFdoel
	 tHu7m0uyF9MlGB+u8jfHbCr6kbUeJVCoXn31+CLfOVD27qvKMfjnH4U7LOOC5IUOV5C6b
	 HU6ZWL7Kgie9MS48kw9NI0R5QLpRew2ZMEdvMJlcDu//57I9P0uKKBqp2eFgygMOJKmfd
	 RjA5ZHH+XFnA3lDW1zW4YlSi0lgaP3aeIYQuYU8JTn/xBIfsSfwZnLR23Yt/cLxamFbBo
	 egXp3QhawzB8m3czBkZyiYa9B4aaMtjopV1pkE+ZC3ybHUgkuioE5ZO+MYtmKuNux5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nl77pNuk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6362D606A329
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nl77pNuk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A691D1F000CE;
	Sun, 15 Nov 2026 10:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794739992;
	bh=Ty18tLj0CF5OgQyR/HVdu+dQPBLZ+Teuz2xCP33f+QI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Nl77pNuk5zY5ufc2J/OElB/nSltG2fCP1wxRkUaCCXVEeFExY7Hu8PdejF9sD75G9
	 gS4d2F7usOmcpMKVjgP6hlUzjuvFsX1ILrAGrnDPAvg+gsmZH31pTZiHOtvr4FaBKd
	 ivbBI7vzAYzZWEnBxss9P2yinFXNnZ/C3PRfzODh/3gBMbcvParnTQ4Dzky5tHvPBR
	 47VQLDR22bwL7ReSYxx0McR+iP5JqlJIcYIaJ7HYAAMxrdNpS/uuzq+SchJ99uRV3Y
	 eBZQOCnIQGBiTDlwI4sm6RvmfVzp+nuBJIkVzbQmwSe5k7FRmLAQkwyFVRKyPCo20R
	 QrBpMFVMpgQgA==
Subject: Re: [PATCH mptcp-net 31/34] mptcp: don't charge a subflow twice when
 it joins during accept()
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc:
 mptcp@lists.linux.dev, mason@kernel.org, pabeni@redhat.com, kuba@kernel.org
Date: Sun, 15 Nov 2026 10:53:12 +0000
Message-ID: <179473999226.488855.14600375594919978614@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-31-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-31-9205b77e9a2f@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch makes mptcp_graft_subflows() (net/mptcp/protocol.c)
  skip some of the subflows that were pending in msk->join_list, but it…

--

mptcp: don't charge a subflow twice when it joins during accept()

A subflow can join between __inet_accept() and mptcp_graft_subflows(). In
that window mptcp_finish_join()->mptcp_sock_check_graft() already gives it
the memcg and charges it, and the loop in mptcp_graft_subflows() then
charges it again. The fix makes mptcp_graft_subflows() skip subflows that
already have a memcg.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2a47107001fc2..afc122e476cd5 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4503,7 +4503,8 @@ static void mptcp_graft_subflows(struct sock *sk)
>  		if (!ssk->sk_socket)
>  			mptcp_sock_graft(ssk, sk->sk_socket);
>  
> -		if (!mem_cgroup_sk_enabled(sk))
> +		/* Got the memcg when joining: its memory is already charged */
> +		if (!mem_cgroup_sk_enabled(sk) || mem_cgroup_from_sk(ssk))
>  			goto unlock;

[Severity: Low]
This isn't a bug, but should the block comment earlier in
mptcp_graft_subflows() be updated as well? It still says:

	/* Subflows joining after __inet_accept() will get the
	 * mem CG properly initialized at mptcp_finish_join() time,
	 * but subflows pending in join_list need explicit
	 * initialization by the loop below.
	 */

mptcp_stream_accept() holds the msk lock from before __inet_accept() until
after mptcp_graft_subflows(). So a subflow that joins in that window goes
through the sock_owned_by_user(parent) branch of mptcp_finish_join():

	} else {
		sock_hold(ssk);
		list_add_tail(&subflow->node, &msk->join_list);
		...
		mptcp_sock_check_graft(parent, ssk);
	}

Since msk->sk_socket is already set at that point,
mptcp_sock_check_graft() calls __mptcp_inherit_cgrp_data() and
__mptcp_inherit_memcg(). Such a subflow both joined after __inet_accept()
and is pending in join_list.

The older comment says the loop initializes it, while the new check and its
comment skip it. Could the block comment say that the loop only initializes
subflows that joined before msk->sk_socket was set, i.e. the ones where
mptcp_sock_check_graft() did nothing?

>  
>  		__mptcp_inherit_cgrp_data(sk, ssk);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f%40kernel.org
