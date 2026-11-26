Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681244;
	b=wUxLU0dnq45bY08RellqHtuxhxtT0vlqPlNccCru0gAPmFr+O/5pfZHyXEjBNxifVRVn
	 Glk3X2Z7R+/F5qx83vJRV5zXRpOurbEMYC/SOuM5JDIx0OdaeV3KGKuQPsj9nODMoklNw
	 eOH6gE89lqpg+iGeBSBU9wuuCX0OQ2ir5P1ACzVtfLDhg1SqF/5wiMPgxiN+k2zW+Ea33
	 nvtDMPficLyrPNW+FblWiPfr2dBqRgB1fEZYWgPf6/5q7EtxT+j0V8TqCQQxSeut2IAev
	 Oee5AKfX2lUzpqs1RbBGOsOXErg/e7KjTbpWuDbxePWyeutTIXus+X7Eq+lOb8ZklEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681244;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0+gP73+QLITwAOLfZXIopVBXnESuNTo3XGjUirLDXXw=;
	b=YtxZ1odFqJcVPxAVHlezO40+wZL+6znwOumb5NVCtMpkryG0dSQoJy3/OGbLruD+OczZ
	 lconN/jSn4vujfUoZCmhTjkWf6e1IqCGD3nSRkFWVoem7mO4pYEaSyaqpmiZknemafnfw
	 Vkru0SzQnfmPO+M53+R6zp3bFs3UByf4rFZzeo2MuDGQgszyn3yy5I3benHzkckiophpL
	 WlqYwaMV7LdtoxN6A/d/zD7h3qGa5tYrBFXa07Vw88DcJwqAb3zqZ1JhSPpeYNV3SLdqA
	 iYJp/pgrTo4VA0FxaIeBRAQLPl/6xiLDI4FXwbPK6SovG5kjmSw9ylA71OJNcPlhpxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D4/Ukuke";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7548A606A321
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4/Ukuke
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C081F000CA;
	Thu, 26 Nov 2026 08:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795681243;
	bh=0+gP73+QLITwAOLfZXIopVBXnESuNTo3XGjUirLDXXw=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=D4/UkukeXrqdYzH2cRlgL6Au8MndrSK7YvftVB8iyMDG0DXkJFTOXdJ28CkYX2bbS
	 obY9XdUeqtm9GsfinAlURoqwWtbl9aGfWUxY9m7sHuAeTDlmQZjUFFgCxf0aW8Lz/2
	 RR76O28XsebkoRyFAtGKmCWEPsZmPLnDBF2SWySbFcV0R8RBg7vDt6P3GpyPQ8GGze
	 hfrLJKaxwgybHujRIyig/EOi9rQqwEev4fOz6FXojPSDuk9apSoOd9GQbOjXhUL7a0
	 uX3Jxler2nJFP6PPuPwTjN9XWkLH30iWNpdineEgfANuADglpqrwLz9azEjFUKdD7s
	 PR1Ne8sGl1Gag==
Message-ID: <dd53bb0e7fe24c1f6469a0395d6bb12f6b3974b7.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3 19/50] mptcp: fastopen: keep listeners and
 connections
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Thu, 26 Nov 2026 16:20:37 +0800
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-19-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
	 <20261124-mptcp-cmason-fixes-v3-19-416c0920c73f@kernel.org>
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
> A sendmsg() with MSG_FASTOPEN on an MPTCP listener fails, e.g. with
> EISCONN, as with TCP, but it also closes the listener: after any error,
> mptcp_sendmsg_fastopen() retries the disconnect that could have failed
> in __inet_stream_connect(), while there is nothing to retry for a
> listener. On a connection closed by both sides, with data still to be
> read, the same retry also drops this data and the end of the stream.
> 
> Skip this disconnect for a listener and for a connected socket:
> __inet_stream_connect() returned without trying to disconnect them. They
> are then kept as they are, as with TCP.
> 
> This issue has been found by an AI code review agent, while reviewing
> "mptcp: report sf aborts during deferred connect", and confirmed with a
> new Packetdrill test: sendto() with MSG_FASTOPEN on a listener, then a
> SYN. Without this patch, the SYN got a reset instead of a SYN-ACK:
> 
>   listen_sendto_fastopen.pkt:14: error handling packet: live packet field ipv4_total_length: expected: 60 (0x3c) vs actual: 40 (0x28)
> 
> The case of the closed connection has been found by an AI code review
> agent (Clashiko), while reviewing a previous version of this patch, and
> confirmed with another Packetdrill test: after a shutdown(), data and a
> DATA_FIN are received, then sendto() with MSG_FASTOPEN fails with
> EISCONN. Without this patch, the data could no longer be read:
> 
>   closed_sendto_fastopen.pkt:30: runtime error in read call: Expected result 1000 but got -1 with errno 107 (Transport endpoint is not connected)
> 
> Fixes: 7d803344fdc3 ("mptcp: fix deadlock in fastopen error path")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks good. Thanks!

    Reviewed-by: Geliang Tang <geliang@kernel.org>

> ---
> v2: new, for an issue found by a review agent
> v3: also skip it for a connected socket, not to drop unread data
>     (Clashiko)
> 
> Note (Clashiko on v2): only retrying a disconnect that failed, with
> SS_DISCONNECTING, would leave a deferred socket stuck after an early
> error from tcp_sendmsg_fastopen(), DEFER_CONNECT being cleared on the
> msk: then, the disconnect is still retried, as before.
> ---
>  net/mptcp/protocol.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6c712f677220..d529cfb582a5 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2004,11 +2004,14 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>  		 */
>  		if (ret && ret != -EINPROGRESS && ret != -ERESTARTSYS && ret != -EINTR)
>  			*copied_syn = 0;
> -	} else if (ret && ret != -EINPROGRESS) {
> +	} else if (ret && ret != -EINPROGRESS && sk->sk_state != TCP_LISTEN &&
> +		   sk->sk_socket->state != SS_CONNECTED) {
>  		/* The disconnect() op called by tcp_sendmsg_fastopen()/
>  		 * __inet_stream_connect() can fail, due to looking check,
>  		 * see mptcp_disconnect().
>  		 * Attempt it again outside the problematic scope.
> +		 * A listener or a connected socket is not disconnected there,
> +		 * as with TCP.
>  		 */
>  		if (!mptcp_disconnect(sk, 0)) {
>  			sk->sk_disconnects++;
