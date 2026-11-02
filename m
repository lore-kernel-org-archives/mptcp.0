Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620852;
	b=r8sdoH5OlmAb5Evl52Dh0nRBKwoipfUrTlNEa/AVyvci43CPooJs3uVUPlel72v5xE8w
	 xFMJ7WEVbhTJeo9smwVsMxHd5dqSw0rLsuRYrYTu2DkgtKtciEc/GYfj4nqUAuaU/ghZl
	 nZPKkYI1kuGUGFR1a53qRPOw4z40ZRSpqa3cFGOwvNBRFMLQEjXag492Rs601YJisT/2I
	 cpRxO9NNDLJwrGHQF2bX1EhlrmXVuQ0Od3EiE4D/GSpb1ng5HHnnoTzKxhCA0hxZAX3Bw
	 n/Bj9UeT4bpOxIkngWV35+3DMf+5kyNfd8uDE3xTzko84Ov5BinlJkVmWNupjIacukA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620852;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=MEoaEaicZ8UabmGzlYhn/6ARhms0F79uQ8/+EuSSrl0=;
	b=zNptnO1csucsxCsjGtXxi5EEbSw4pb1NidRj9HzOtsXfMQ2CY0ey+P2nV7KcRuu31Jxs
	 zjgAsKWc9eDHBmxCfA9DEEQE7c5fRzPEwdr99NJmVoTNFtiajZhIc6JO5kqYIUxD77R81
	 Qtm6Ja/5U3aXB6pBWYgJSXEGmnZdWxBUXYjK4YC4igCfp6By+8V5OyQ0DBI7mTEvyi55A
	 bc2mAs024mU6PSj+hbBmQiGYPDLejCFL3vYip5ZBcmC0OSrHd3q1RGsx/ysoGIBCoETkC
	 n1GPQN1xEOtzLJfsgbXduRWkVDKBi0IAjVsQAF5e5l0U37ODComitQ715hM+EUKWfdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=m6VHEImO;
	arc=none smtp.remote-ip=95.215.58.72
Received: from mta1.migadu.com (out-72.mta1.migadu.com [95.215.58.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5191E606A330
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 12:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5191E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=m6VHEImO
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=7gLJfEV4JiyV472NGbIbZrTv/A7Ww4dsXKKMsPQL+jc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793620849; v=1; x=1794225649;
 b=m6VHEImOTkeTThdA8cWZkoQG3TcYT2x2HnT3qqxNRLGtBbjXbinH+/LzmUn21dtKQ5c6ISeZ
 DutDDRta/1ca2Ko4VAHl73xKc9sMFUqMsOW26dsqfJje3zb7C8gKcRveVa9Cnddxe2+IZyPoiUB
 mPwK5ozgtllNKrBtZPzmKn/o=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 626a1368d0b9c9a1;
	Mon, 02 Nov 2026 12:00:49 +0000
X-Mizu-Trace-ID: 626a1368d0b9c9a1
X-Migadu-Flow: FLOW_OUT
Message-ID: <dff8a7bd-f819-401e-8dea-04ba2b9415ac@linux.dev>
Date: Mon, 2 Nov 2026 20:00:39 +0800
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 06/15] bpf, sockmap: Give no progs to a TCP
 listener
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-7-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Chris Mason <mason@kernel.org>
>
> A psock with a verdict prog replaces sk_data_ready and sk_write_space of
> its socket. It saves the old callbacks, and the new callbacks call them.
> sock_map_link() does this to a TCP listener too. Its new sk_data_ready
> cannot read and does not call the old one. Thus it does not wake accept().
>
> sk_clone() copies the new callbacks to each child, but not the psock.
> tcp_bpf_clone() restores only sk_prot. Without a psock the child loses data
> or does not wake its reader. If it gets a psock, the psock saves the copies
> as the old callbacks. Then sk_psock_verdict_data_ready() calls itself until
> the stack overflows. sk_psock_write_space() calls itself too, without end.
>
> Give no progs to a TCP listener, as before the first commit below. A
> listener receives and sends no data. It stays in the map and keeps its own
> callbacks. Add this exception to map_sockmap.rst. A listener no longer gets
> -EBUSY from a second map with progs of the same kind.
>
> Since the second commit below, a socket keeps its psock when TCP unhashes
> it. sock_map_link() does not see the state that the socket gets later. Do
> not depend on TCP to keep such a socket out of TCP_LISTEN. Set both
> callbacks in tcp_bpf_clone() to the TCP defaults.
>
> Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
> Fixes: b8b8315e39ff ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  Documentation/bpf/map_sockmap.rst |  4 +++-
>  net/core/sock_map.c               |  9 +++++++++
>  net/ipv4/tcp_bpf.c                | 15 +++++++++++++--
>  3 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/bpf/map_sockmap.rst b/Documentation/bpf/map_sockmap.rst
> index 2d630686a00b..eb466b86df17 100644
> --- a/Documentation/bpf/map_sockmap.rst
> +++ b/Documentation/bpf/map_sockmap.rst
> @@ -33,7 +33,9 @@ of ``__SK_DROP``, ``__SK_PASS``, or ``__SK_REDIRECT``.
>  
>  When a socket is inserted into one of these maps, its socket callbacks are
>  replaced and a ``struct sk_psock`` is attached to it. Additionally, this
> -``sk_psock`` inherits the programs that are attached to the map.
> +``sk_psock`` inherits the programs that are attached to the map. A TCP listener
> +is an exception. It gets a ``struct sk_psock``, but it keeps its callbacks and
> +inherits no programs.
>  
>  A sock object may be in multiple maps, but can only inherit a single
>  parse or verdict program. If adding a sock object to a map would result
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index efe49551caba..282c6a4b2b05 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -228,6 +228,14 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
>  	struct sk_psock *psock;
>  	int ret;
>  
> +	/*
> +	 * A listener receives no data. With the callbacks of a verdict program
> +	 * or a parser it would no longer wake accept(), and its children would
> +	 * copy them.
> +	 */
> +	if (sk_is_tcp(sk) && sk->sk_state == TCP_LISTEN)
> +		goto no_progs;
> +
>  	stream_verdict = READ_ONCE(progs->stream_verdict);
>  	if (stream_verdict) {
>  		stream_verdict = bpf_prog_inc_not_zero(stream_verdict);
> @@ -262,6 +270,7 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
>  		}
>  	}
>  
> +no_progs:
>  	psock = sock_map_psock_get_checked(sk);
>  	if (IS_ERR(psock)) {
>  		ret = PTR_ERR(psock);
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 36d1bf46353a..fd443350f9b8 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -785,7 +785,18 @@ void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
>  {
>  	struct proto *prot = newsk->sk_prot;
>  
> -	if (is_insidevar(prot, tcp_bpf_prots))
> -		newsk->sk_prot = sk->sk_prot_creator;
> +	if (!is_insidevar(prot, tcp_bpf_prots))
> +		return;
> +
> +	newsk->sk_prot = sk->sk_prot_creator;
> +	/*
> +	 * sock_map_link() gives a listener no programs, but a socket which got
> +	 * them in another state and listens now has the psock's sk_data_ready
> +	 * and sk_write_space, and sock_copy() has copied them.
> +	 * sk_psock_init() refuses a socket that has sk_user_data or a ULP, so
> +	 * what the psock replaced were the defaults of a TCP socket.
> +	 */
> +	newsk->sk_data_ready = sock_def_readable;
> +	newsk->sk_write_space = sk_stream_write_space;




Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


I guess the scenario is: connect(AF_UNSPEC) unhashes a connected socket
that is still in the map, then listen() turns it into a listener. Since
we no longer have an unhash handler to drop the psock, the callbacks have
to be reset in tcp_bpf_clone().


