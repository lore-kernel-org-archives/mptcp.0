Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795675231;
	b=F6eGJAzzp9boudnjWAZK56gxAKhpmplm0r3JsgwXisW0563xOlJky9vxkfE2+Hoa/LqI
	 QbW/H0Oe8j7u9/Q2nQ97hg+Rfaj+tufNRuly5MSrNRKacc0D3JKYA2s/lDWyWukj/kufq
	 5/OF14D5QqimIx8qw9fPqlnNNCb7ngrAAGCUJ/x88EdNfTAyTswmHWyxACyN0Oc4RXC23
	 bBLbeLHzv5o7isnxuCUJl1v4f7HGo+dlA495qwIj1gJ2jvIgULHPLIQyV/52U03M1+BvI
	 C3g1MnB1Bjcrit2g4SXcytnkQLGm88EFrb8HIJQLs52sUVbpcTyl3eEqZAqcEYidwyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675231;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4g2yDX0mLXwc/EHbvlXdep9FnEwepwdIAuK0zHw8yDE=;
	b=RWP0CG1p0vgq9FRQreyyqcq1DTZiBHe+2BsvrKARl07m6pfyF9mC1wGjTM9U2hMKaHQ6
	 k3JwbB41thxcLCsaZt4FRqXJNv9aPpwSuHn1EWPMHhD21asEAIBjgAsXWOVgbqfAOjnzB
	 u0WJdtVSSFmyf1kQKS1I7aW4npHnepHjDs4UT2LylW0BFayqoK6zhd7e3KgcCtMpknuZv
	 8SKiS9Qt8e669GCcIXBKeRq0jWPC2ik4X5YX8GI4bsP9IRUmeoKHQubdeXnfkpj5aJLF+
	 c7Ib9oQHk5pvB2BRsQ72bgWE+gNaxUXS7EQTSq4dFWy26mI66/kq10Uph/ABinrB2bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFJDQJHj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5565F606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFJDQJHj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10E61F000CA;
	Thu, 26 Nov 2026 06:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795675231;
	bh=4g2yDX0mLXwc/EHbvlXdep9FnEwepwdIAuK0zHw8yDE=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=CFJDQJHjs3M93DC8dpskvXGAOhSurkYWAlnBmNl+ECTFRjJNoRF0QYsongI1fmwOL
	 LNVWdkE+S3SUbwxvN3lUMMBlpyY3LmNoh0NCD17g1CxabeRkyUhLE2wPGvahjpU5hM
	 C+dFRhBqFwIi8pqwpnZys7Rck/FY5P39V9Fa61mKS/cyUFBU8ZRLIyns8aLvS5oemR
	 jzEiSntbQNsDbWRZFY9CmSTyGUmvma2BFQhQ0E0TuHBLCSRosDqPbIbJnFDecDWAH3
	 lHXQnhm4+ItepWp4ACUWpnWZrAuHw8qXq9rXnIFc9GiUAg9vcyU0m4z7SEf/rtVGN5
	 rE4qdsSssuScQ==
Message-ID: <16b6809a6e7f12a4f611442fcb04d91b0bae48de.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3 15/50] mptcp: clear sk_err on connect(), as
 TCP does
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Thu, 26 Nov 2026 14:40:26 +0800
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-15-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
	 <20261124-mptcp-cmason-fixes-v3-15-416c0920c73f@kernel.org>
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
Content-Transfer-Encoding: 7bit

Hi Matt,

On Tue, 2026-11-24 at 22:59 +0100, Matthieu Baerts (NGI0) wrote:
> After a disconnect with connect(AF_UNSPEC), an error from the previous
> connection, e.g. a reset not reported yet to the application, was still
> reported for the next connection, by poll(), SO_ERROR, and the first
> send() or recv(). TCP clears it in tcp_connect_init(): do the same,
> once the subflow connect() succeeded, so an early failure keeps it.
> 
> This issue has been found by an AI code review agent, while reviewing
> other fixes, and confirmed with a reproducer: the peer resets the
> connection, the error is not read, then the socket is disconnected and
> connected again. SO_ERROR then reported ECONNRESET each time, while TCP
> reported no error, as MPTCP now does.
> 
> Fixes: 3d1d6d66e156 ("mptcp: implement support for user-space disconnect")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Thanks for this fix. Looks good to me!

    Reviewed-by: Geliang Tang <geliang@kernel.org>

> ---
> v2: new, for an issue found by a review agent
> ---
>  net/mptcp/protocol.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ff1dcf306723..6328815ad273 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4452,6 +4452,8 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>  	if (err < 0)
>  		goto out;
>  
> +	/* as tcp_connect_init(): drop an error from a previous connection */
> +	WRITE_ONCE(sk->sk_err, 0);

tcp_connect_init() also calls sock_reset_flag(sk, SOCK_DONE) here; maybe MPTCP
needs this sock_reset_flag(sk, SOCK_DONE) too.

Thanks,
-Geliang

>  	inet_assign_bit(DEFER_CONNECT, sk, inet_test_bit(DEFER_CONNECT, ssk));
>  
>  out:
