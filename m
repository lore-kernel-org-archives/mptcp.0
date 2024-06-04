Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3689171BA
	for <mptcp@lists.linux.dev>; Tue,  4 Jun 2024 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519758; cv=none; b=KDmp+N6hjA0t1jd7ymzAZYw6fVwU3nYEIUetmckP5YhEVzhwo9wzCAXGaBhNDtOzE5oN2nH8vf17VI5lQEvtztlYIsvJ8udbL6zRJKATDlBJ0LZqILJO6LUuyz8+l/HEloC+Ayos0/RlotWkb89oq8GV/gxvzWS4qrWzypqqmQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519758; c=relaxed/simple;
	bh=DeRkU8DmVmIRX3oK/Vty5otMUghPGx1cY/A7jUxjIMA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ta21AIb7mQVDipa3dEcf+yzAIf56ZL4UzeZaFKZvfrWJlZOwiMZ+3B9N0+8YPQ4/D2qIImkklHb4j4/4tNiSUkoqgYF9hs+f514NVcADVmy/6uXerqb5sGJdre09aLwrPvaKy4U91TtZ3wtNYxpQM79OpE2Mb8ZpCq3U+JYXXBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frzkPGua; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frzkPGua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A3EC32786;
	Tue,  4 Jun 2024 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717519758;
	bh=DeRkU8DmVmIRX3oK/Vty5otMUghPGx1cY/A7jUxjIMA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=frzkPGuaoGymcyIjT8FIxfHTId+NWBoAeJ22QRCdL/rsEHRJh8bL9pSouZyrV3tj3
	 yIiTyGJGi57qe//6oltuTdpgtnwoqyyauwhbws9EDBm5OWKSMSoDZjwCKNM19R57wg
	 dm72axDPpZKOH8mZGBZz+PC/NAH1QKZT/dVImgeFDVY3U/23bHkyfWHaRYfRxrcrFx
	 mlO7L6Os9xKH4u4O+xlq8YIgdokBB/0Jc23JU9/VpRmdElmBE+eDAyxPcfcgfrXwL/
	 D72Dhb8pfCjQNdvqNC7/jWGu4KIztEk5HGXtpH0/gBzDwVfPINhzx/53xnZ4LZ5jX4
	 TP0J52pr8naAw==
Date: Tue, 4 Jun 2024 09:49:16 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: ensure snd_una is properly initialized
 on connect
In-Reply-To: <61aae3730b8c35c2e0b8b70f5f2fe5170067f5c8.1717512099.git.pabeni@redhat.com>
Message-ID: <2c7981d3-10d0-0ea5-90a8-1089decd6240@kernel.org>
References: <61aae3730b8c35c2e0b8b70f5f2fe5170067f5c8.1717512099.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 4 Jun 2024, Paolo Abeni wrote:

> This is strictly related to commit fb7a0d334894 ("mptcp: ensure snd_nxt
> is properly initialized on connect"). It turns out that syzkaller can
> trigger the retransmit after fallback and before processing any other
> incoming packet - so that snd_una is still left uninitialized.
>
> Address the issue explicitly initializing snd_una together with snd_nxt
> and write_seq.
>
> Suggested-by: Mat Martineau <martineau@kernel.org>
> Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous connect")
> Cc: stable@vger.kernel.org
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/485
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2f8f32cd31d3..1c5b7796daaf 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3735,6 +3735,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
>
> 	WRITE_ONCE(msk->write_seq, subflow->idsn);
> 	WRITE_ONCE(msk->snd_nxt, subflow->idsn);
> +	WRITE_ONCE(msk->snd_una, subflow->idsn);
> 	if (likely(!__mptcp_check_fallback(msk)))
> 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVE);

Thanks Paolo, LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>
