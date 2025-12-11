Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9D42DAFCB
	for <mptcp@lists.linux.dev>; Thu, 11 Dec 2025 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765477330; cv=none; b=GgoxPYo8cDdCab2c0Lhmt2xhpb9g+taQxYQTKkX73TsAgbHkIQv8h1o0w7e+S73YVlbJILNUuKLoGlbSO5mwI5O+7hQbovXGw2D9D1vXrEMmne6C1cZwT6HdeLGFDFJ8FnNjWudlwSaEt8uiTzHtv/Isc5moXYZ0yODuu9vC2as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765477330; c=relaxed/simple;
	bh=5xkmie2GPpuGnWYmaqF1+ZOPCOdaVa4CWIzMJ+PB40A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jaA2zEDTqVtvm68+C0zBFUCpttkWHrtMGI/FpnOmGN1o/mjJxFl/I5ljYFdlOFfKKOMcOzKiEdPUjryu/QVfLVII/DFcxzUiIcqQOzsGBCGxx3VQJsBFlC/WbiRfpV5dluFgD75kTd5Tw4JevUSHxid1aCm9NVSaclQtdJ+9A5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMBnCTvk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMBnCTvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBB3C4CEF7;
	Thu, 11 Dec 2025 18:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765477329;
	bh=5xkmie2GPpuGnWYmaqF1+ZOPCOdaVa4CWIzMJ+PB40A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JMBnCTvkfJd1KT/67I8gfwFmJoBc5WSaZqE1LkHUBgrqPOmeaPGDNjGoCr6Hc+BMA
	 v+9mJeBq/nbHw/ds6lcWZ9nZDEi0V5/UGI+GtNEMqPIAwB/u2r+npeEShiPX8bHmqx
	 excp/lbfDIpkjGwAuLL47vTs8VHthofe1+DA703sqp11i3ltFnGO1XgF8LnVqCM0fq
	 Ny15QZhYNRuubEE78LQ4CX+giYhnoHfTvALL7DRwQ+axxWDvuIbAEGKIY5ImcbuCbp
	 o9B9TA3Wd+iDAJdcYbw/XwfqTVf2zYgwPnN+YvgDSTxF9eapzjZEQivTG6D7rYtklP
	 eQap6olgc9Vng==
Message-ID: <a3838d83-64a5-4c6f-99a4-b69ad515836c@kernel.org>
Date: Thu, 11 Dec 2025 19:22:06 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v15 2/6] mptcp: implement .read_sock
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Hannes Reinecke <hare@kernel.org>,
 mptcp@lists.linux.dev
References: <cover.1765023923.git.tanggeliang@kylinos.cn>
 <6d5470547063a740c0eb2f80655fafd7dc47716e.1765023923.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <6d5470547063a740c0eb2f80655fafd7dc47716e.1765023923.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for working on that!

On 06/12/2025 13:33, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> nvme_tcp_try_recv() needs to call .read_sock interface of struct
> proto_ops, but it's not implemented in MPTCP.
> 
> This patch implements it with reference to __tcp_read_sock() and
> __mptcp_recvmsg_mskq().
> 
> Corresponding to tcp_recv_skb(), a new helper for MPTCP named
> mptcp_recv_skb() is added to peek a skb from sk->sk_receive_queue.
> 
> Compared with __mptcp_recvmsg_mskq(), mptcp_read_sock() uses
> sk->sk_rcvbuf as the max read length. The LISTEN status is checked
> before the while loop, and mptcp_recv_skb() and mptcp_cleanup_rbuf()
> are invoked after the loop. In the loop, all flags checks for
> __mptcp_recvmsg_mskq() are removed.

(...)

> +static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
> +			   sk_read_actor_t recv_actor)
> +{
> +	return __mptcp_read_sock(sk, desc, recv_actor, false);

In this series, it looks like __mptcp_read_sock() is only called here,
always with noack == false then. Will you call this helper with noack
set to true in another series?

(Maybe the extension could be introduced later, but if the next series
follows, that's fine to keep it like that.)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

