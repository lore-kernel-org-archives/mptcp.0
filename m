Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.237
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632521;
	b=4xaBL0YfOBVyCq9bdmEiz4hbeVMOMYzXfOkhfvL8gIs6SFo170HwwzAtPWXroisSKsGK
	 rrFJt9J296u3hrBVMbgSSk+kX+vL6WaveBsCSK/bq/36tdAMdT/yaw8J0mK3aFqbLIW0o
	 9ukh59MWOc/71tK2uK27oMifE8n5xOodeqhK0tCGuLwf/aBzl05uOaXKD8tDUYV//+12H
	 anICaGzJ66CTbU7pnqYcF+oopfKr3XZ4tyNPAq9ZzQjfGbXysXIsb5TU3pWgP53u41ZJw
	 hdhPxR8Q9uniiVtDIDmGV9vMLfzwSo3SdJ17r04Pu9Ci5sutDdWHv9eSL/+7DfEm/Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632521;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=kwKzSEXHVuEjJqvTeRRPA4mrqN9EE7qy4XgSv3TiNWc=;
	b=CfYlC+1UG7yV1+a7LVES7s3fdwcEuzj1wg2bZcnJayYyVYD5SOP+1AR5HEFfoWIDzs6y
	 JvdV6tfjXSKdYqSZaqIs7K8P9ZC0XzzvTTfz1UuUWXcD3eVdNNOV5cIT+DW/jGWixAIsQ
	 xkp1LQNrbWEi8VBJHWGwt0ohAyxgsEPD28ZM4qqz7h4M5oEnGNzm5YNTb06JSpubkpw+P
	 b/blT8n87n+TMKEXvwVkFa2Yn4DXIkz5ZX4hSto0dkXYN/qJEStnytuidFt6IA0jUK0CN
	 mnLAngIKGOdmVGBmHT1BFp1sICaMHv3Lkcll44ygqP6c5/W8D7zxq4z34IVdBRx8rkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="XJN/a6sZ";
	arc=none smtp.remote-ip=91.218.175.237
Received: from mta0.migadu.com (out-237.mta0.migadu.com [91.218.175.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC65606E03E
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 15:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EC65606E03E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XJN/a6sZ
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=mD1ETE2e7HukgmRWNL4DzC5n+RUd7grBANDiKh/A4zE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793632518; v=1; x=1794237318;
 b=XJN/a6sZE7I25E3l0dbLjo3bh1sQLxRtyE0dTMZf1SEVnYohGzYv4L7+Vz5Qe5FN1JxQ/UN/
 iM0zc0rVPnVhCEWfJVG9P05f1qLjuwhdCwxDN38o2UTpAuMDYvXGP14N9prSIByfdflX+8mbYwR
 fvYzGB6ATxLWj+jLbPNcVVJ4=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id c5af6c99b6d8b8d8;
	Mon, 02 Nov 2026 15:15:14 +0000
X-Mizu-Trace-ID: c5af6c99b6d8b8d8
X-Migadu-Flow: FLOW_OUT
Message-ID: <ae49619c-d2de-4189-b6ac-2a70f8ef1891@linux.dev>
Date: Mon, 2 Nov 2026 23:15:03 +0800
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
Subject: Re: [PATCH bpf v2 09/15] bpf, sockmap: Check the TCP state in
 recvmsg()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-10-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-10-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Chris Mason <mason@kernel.org>
>
> With an sk_skb verdict prog, tcp_bpf_recvmsg_parser() copies data from the
> psock. Then it calls __tcp_cleanup_rbuf() to calculate the receive window
> and to send an ACK. The window and the ACK need a connection on the socket.
> But tcp_disconnect() keeps the socket in the sockmap and the data on the
> psock. For a TCP socket sock_map_redirect_allowed() rejects only
> TCP_LISTEN. Thus the psock can also get data after tcp_disconnect().
>
> __tcp_select_window() divides by icsk_ack.rcv_mss, which can be 0 in
> TCP_CLOSE. In TCP_SYN_SENT the new peer can get an ACK with the sequence
> numbers of the old connection.
>
> Call __tcp_cleanup_rbuf() only when tcp_can_send_ack() returns true.
> recvmsg() returns the data as before. Move tcp_can_send_ack() from MPTCP to
> tcp.h. It also returns false for a fastopen child in TCP_SYN_RECV. From its
> peer the child has only the SYN data, and the SYN-ACK acknowledges it.
>
> Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>  include/net/tcp.h    | 6 ++++++
>  net/ipv4/tcp_bpf.c   | 3 ++-
>  net/mptcp/protocol.c | 6 ------
>  3 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 3560adddf821..23a22d70718e 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1845,6 +1845,12 @@ static inline void tcp_adjust_rcv_ssthresh(struct sock *sk)
>  void tcp_cleanup_rbuf(struct sock *sk, int copied);
>  void __tcp_cleanup_rbuf(struct sock *sk, int copied);
>  
> +/* Is the socket in a state in which TCP may send an ACK? */
> +static inline bool tcp_can_send_ack(const struct sock *sk)
> +{
> +	return !((1 << inet_sk_state_load(sk)) &
> +	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
> +}
>  
>  /* We provision sk_rcvbuf around 200% of sk_rcvlowat.
>   * If 87.5 % (7/8) of the space has been consumed, we want to override
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index ef2e15de0fe3..3d703f1517d8 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -343,7 +343,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  	if (!peek)
>  		WRITE_ONCE(tcp->copied_seq, seq);
>  	tcp_rcv_space_adjust(sk);
> -	if (copied > 0)
> +	/* Data on the psock outlives the connection that it came in on */
> +	if (copied > 0 && tcp_can_send_ack(sk))
>  		__tcp_cleanup_rbuf(sk, copied);
>  
>  unlock:
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7a22e9388e0e..d62cfbf2d490 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -619,12 +619,6 @@ static void mptcp_set_timeout(struct sock *sk)
>  	__mptcp_set_timeout(sk, tout);
>  }
>  
> -static inline bool tcp_can_send_ack(const struct sock *ssk)
> -{
> -	return !((1 << inet_sk_state_load(ssk)) &
> -	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
> -}
> -
>  void __mptcp_subflow_send_ack(struct sock *ssk)
>  {
>  	if (tcp_can_send_ack(ssk))
