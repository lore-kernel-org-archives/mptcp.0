Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA418EAB
	for <mptcp@lists.linux.dev>; Sat, 15 Nov 2025 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763170373; cv=none; b=n2INsGkuklAVuknCvQMaF3CjfFc8FbccNDkxWsnr0OJ0uk+/VFvTH/maDWKp4fPHXnppb0GhHiDZviFlDFksr8rnzXT8kykz8xrQSIHDHvb+vXgdefIDQtNjY2wywC0Pl8oCwGwK6xjNdebZ6F6uZPCVicdPswSaZx2/Vpe0apQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763170373; c=relaxed/simple;
	bh=t9bnYN0Vpp5RsoaO9WG3yLmh5ixhkOMxRMPJ7B4dfmc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ILjfLrS3sAL/QnbfxHM+6zSWo1qPnC1ea1WdnfJjH9rg+xZoxDmBckhZjaj06TxjauXh7YU4vDQvsIvXFgoYVQDt10d6Nucee2GYvZJ47KYa/T6Ul8nE44Ck99xuogMw8ZtAWeSCiqIMOlOGuSi2E6dUEw/W84EAGNhI/zJ+wtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzhUOgNH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzhUOgNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7354C4CEFB;
	Sat, 15 Nov 2025 01:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763170372;
	bh=t9bnYN0Vpp5RsoaO9WG3yLmh5ixhkOMxRMPJ7B4dfmc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=UzhUOgNHqZ0oDSWvijXyLeWUd6CnNzE0UW0HYA8SKop47lJ28dipt3lOMJqFCvZTw
	 t+I2hiHEHjiUwbr9Lmsjl4tCPhs47wdt/4IqXHdAwejYFBdKwGLPmhCaiggL8TZVBZ
	 SQEWa+obEEWm1wT/9O506L52JBkEUVGU3E7S69HIK5sAVsEkUKYfrsvNKlfZpUFo+3
	 A6K++T18XQqU7nl8FFGx0iwh9lwSolE4bc72vIzNszdJwhdZTGCTJomkZOwY343ic2
	 k+sakcjqFP543OIzIHk2xWdmERKnBqZ4eB1aeYH9FuqaMYYlE34HgI1SOnv91Ll4z5
	 3/IqE3peQOLow==
Date: Fri, 14 Nov 2025 17:32:52 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v4 mptcp-next 6/6] mptcp: add receive queue awareness in
 tcp_rcv_space_adjust()
In-Reply-To: <ba459ac039f30f4b81cb97be2d0963e7b5216e05.1762940290.git.pabeni@redhat.com>
Message-ID: <67facdd8-cc0b-6146-4f3b-05745f0652d5@kernel.org>
References: <cover.1762940290.git.pabeni@redhat.com> <ba459ac039f30f4b81cb97be2d0963e7b5216e05.1762940290.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 12 Nov 2025, Paolo Abeni wrote:

> This is the mptcp counter-part of commit ea33537d8292 ("tcp: add receive
> queue awareness in tcp_rcv_space_adjust()").
>
> Prior to this commit:
>
> ESTAB 33165568 0      192.168.255.2:5201 192.168.255.1:53380 \
> 	skmem:(r33076416,rb33554432,t0,tb91136,f448,w0,o0,bl0,d0)
>
> After:
> ESTAB 3279168 0      192.168.255.2:5201 192.168.255.1]:53042 \
> 	skmem:(r3190912,rb3719956,t0,tb91136,f1536,w0,o0,bl0,d0)
> (same tput)
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Mat Martineau <martineau@kernel.org>

