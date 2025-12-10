Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625B8137750
	for <mptcp@lists.linux.dev>; Wed, 10 Dec 2025 01:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765330250; cv=none; b=rHHYQgH6UBOIMgydORu9l8PFypXQJhOhCRBckTVMjGp3jqfugIEmh6sWKtWu6XDooG+NGDQwPJCmTIfRiqSs1dx16bQNYcaYqBdHiHcyGRVQc/nXq36yHHClPDNIbWkqWSE/Yf2zY/YJZMSsW9tks7HJHnxuZV+yczOsvC1e9e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765330250; c=relaxed/simple;
	bh=eZoPAa58/45HD77dUuCenN7ZVDVQyFORyNCrz8IqgS4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=I1BsaLVa3VNCuGw31QAbQhHCVZ1JMTrLeUxYQyPcKSnxjG2grMnB0DkjjUF5HBxsWUqEVKDPx+gSz5xP/8Cw1ARXDsLYrwWonc541SkTw/5J3AVet8z9h/uQaZTYx4R1KYr7Njt/LHbVQC/x/+Icldt3qIIHnYxpaRMN1PI95fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmMiK4vI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmMiK4vI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A82C4CEF5;
	Wed, 10 Dec 2025 01:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765330250;
	bh=eZoPAa58/45HD77dUuCenN7ZVDVQyFORyNCrz8IqgS4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=dmMiK4vIjxkYfwuWOf3ZCUZ3e+pTWz05R+vMAGAhiCuNWmxZ2h3vEOJqKHhNg4uQS
	 hjvUR1o8bC16mRfZ1riL9hYiTIXsA4+QLW+YX5J6y3fPIvlo+rp333sthwRCris5vF
	 xONnaLwultXV2t1yHOOVNj2aTQQ7tRQWlZaDqLrr8TvNS3A3IFvCHg87wWXeUYASki
	 ki0g+Wg2gE7WxbO4s6sg/+tx23MAU5b6s+kIlI50tbwj07nx8AvuHxCJjjGb/LnjGM
	 WZMJnin0UhXvPjWJ6vnhgW5amFyzCTxQ3sKQq5CaPeySXgm7PvgwrADbhQuNSrLC08
	 MYLMF4ELdoIog==
Date: Tue, 9 Dec 2025 17:30:49 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>, 
    Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next v14 3/8] tcp: add recv_should_stop helper
In-Reply-To: <67d9afa587bcd654db6e63350d9cba395d7778fd.1763974740.git.tanggeliang@kylinos.cn>
Message-ID: <b9dd8325-d785-d50b-715c-39ddccf94c43@kernel.org>
References: <cover.1763974740.git.tanggeliang@kylinos.cn> <67d9afa587bcd654db6e63350d9cba395d7778fd.1763974740.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 24 Nov 2025, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Factor out a new helper tcp_recv_should_stop() from tcp_recvmsg_locked()
> and tcp_splice_read() to check whether to stop receiving. It will be used
> for MPTCP too.
>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> include/net/tcp.h | 23 +++++++++++++++
> net/ipv4/tcp.c    | 73 ++++++++---------------------------------------
> 2 files changed, 35 insertions(+), 61 deletions(-)
>

Acked-by: Mat Martineau <martineau@kernel.org>

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 0deb5e9dd911..94a50a9daf65 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2942,4 +2942,27 @@ enum skb_drop_reason tcp_inbound_hash(struct sock *sk,
> 		const void *saddr, const void *daddr,
> 		int family, int dif, int sdif);
>
> +static inline int tcp_recv_should_stop(struct sock *sk, long timeo)
> +{
> +	if (sock_flag(sk, SOCK_DONE))
> +		return -ENETDOWN;
> +
> +	if (sk->sk_err)
> +		return sock_error(sk);
> +
> +	if (sk->sk_shutdown & RCV_SHUTDOWN)
> +		return -ESHUTDOWN;
> +
> +	if (sk->sk_state == TCP_CLOSE)
> +		return -ENOTCONN;
> +
> +	if (!timeo)
> +		return -EAGAIN;
> +
> +	if (signal_pending(current))
> +		return sock_intr_errno(timeo);
> +
> +	return 0;
> +}
> +
> #endif	/* _TCP_H */
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 5265a9453814..8b4917a7f262 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -842,26 +842,14 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
> 		if (ret < 0)
> 			break;
> 		else if (!ret) {
> +			int err;
> +
> 			if (spliced)
> 				break;
> -			if (sock_flag(sk, SOCK_DONE))
> -				break;
> -			if (sk->sk_err) {
> -				ret = sock_error(sk);
> -				break;
> -			}
> -			if (sk->sk_shutdown & RCV_SHUTDOWN)
> -				break;
> -			if (sk->sk_state == TCP_CLOSE) {
> -				/*
> -				 * This occurs when user tries to read
> -				 * from never connected socket.
> -				 */
> -				ret = -ENOTCONN;
> -				break;
> -			}
> -			if (!timeo) {
> -				ret = -EAGAIN;
> +			err = tcp_recv_should_stop(sk, timeo);
> +			if (err < 0) {
> +				if (err != -ENETDOWN && err != -ESHUTDOWN)
> +					ret = err;
> 				break;
> 			}
> 			/* if __tcp_splice_read() got nothing while we have
> @@ -873,10 +861,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
> 			ret = sk_wait_data(sk, &timeo, NULL);
> 			if (ret < 0)
> 				break;
> -			if (signal_pending(current)) {
> -				ret = sock_intr_errno(timeo);
> -				break;
> -			}
> 			continue;
> 		}
> 		tss.len -= ret;
> @@ -887,9 +871,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
> 		release_sock(sk);
> 		lock_sock(sk);
>
> -		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
> -		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
> -		    signal_pending(current))
> +		if (tcp_recv_should_stop(sk, timeo))
> 			break;
> 	}
>
> @@ -2732,42 +2714,11 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
> 		if (copied >= target && !READ_ONCE(sk->sk_backlog.tail))
> 			break;
>
> -		if (copied) {
> -			if (!timeo ||
> -			    sk->sk_err ||
> -			    sk->sk_state == TCP_CLOSE ||
> -			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
> -			    signal_pending(current))
> -				break;
> -		} else {
> -			if (sock_flag(sk, SOCK_DONE))
> -				break;
> -
> -			if (sk->sk_err) {
> -				copied = sock_error(sk);
> -				break;
> -			}
> -
> -			if (sk->sk_shutdown & RCV_SHUTDOWN)
> -				break;
> -
> -			if (sk->sk_state == TCP_CLOSE) {
> -				/* This occurs when user tries to read
> -				 * from never connected socket.
> -				 */
> -				copied = -ENOTCONN;
> -				break;
> -			}
> -
> -			if (!timeo) {
> -				copied = -EAGAIN;
> -				break;
> -			}
> -
> -			if (signal_pending(current)) {
> -				copied = sock_intr_errno(timeo);
> -				break;
> -			}
> +		err = tcp_recv_should_stop(sk, timeo);
> +		if (err < 0) {
> +			if (!copied && err != -ENETDOWN && err != -ESHUTDOWN)
> +				copied = err;
> +			break;
> 		}
>
> 		if (copied >= target) {
> -- 
> 2.43.0
>
>
>
