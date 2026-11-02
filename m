Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622758;
	b=q5pxwes1gqQpUtQwAhlm1vFrDrnbmVAzQSGc/T8hO4zA0k2wJmgNpHvtnnDVBC8Vmq8n
	 dwfngWv95TLyD6/YxyKYz5z6pv+hxocMksEJQMRWCQSDQUCzYjqS31LyitW5A6KLQICdt
	 0a6yx0+hBZ5GKEg6t4++VDOsQLc9P0t4ES6eszOppCx/x2oC9eCa0V863b5QwLKKXvc97
	 oI9nzROlMXw+yBujQoGc85j/JREoIZz1h0BXPy5zwYhV8+yDQfIStvxnFzni96idEjDLV
	 tcMdm3Gh7jhNOLDGXpBnwJBBkdhNFxwcQeoVgyOAaVBKAcDsCiTHFien+iGgc1Tc66g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622758;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=w6jqiUBD5ibgJFs0ugALEEDB7b768frs2A7MQ2xTHQM=;
	b=yw7g3Zz1BeELDHIypaW4bAlKLAFUqMuc2OA74beg5dnrTrDt9nM2fDMmV1+UPBWpDzWL
	 cUWimXf8Rv4MUt0Z+RAw/CH8pEiIqpLnq+ewwJs8aY+fKoy5M6N23ADNxo33SfXtS3lml
	 4hLLNXzenp0D/44QvgieilxWSgUzyELll6C6MoamPsXvueYz5druIzyXnC7bjZ6pqRNsw
	 nF8iD+XiPksfGTVfzsCk64TwK/gd8LqZrlJi7J/St2MQH71XwCZSzy58Rj1+3dIRGSLCy
	 QECh+RQ+7cCzFs8JX8gGZExK2rqCfxgKKhLx5szBgtnINfaXhDZ04sFNtWh+ZvUV5zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cL9ESvBY;
	arc=none smtp.remote-ip=91.218.175.246
Received: from mta0.migadu.com (out-246.mta0.migadu.com [91.218.175.246])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77330606A33D
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 12:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77330606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cL9ESvBY
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=SiiP3R6iGc96rRdu87RGjK9ajivgC01xWOp9SC3ZPUw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793622754; v=1; x=1794227554;
 b=cL9ESvBYAL63kpZebLoC7cMqDXiUTe+XViIZ37bDaSZ1Q0a0JYe1iNSmZibWd9qWMknh82ox
 +sJiP+jk4U4LQOo4MKjH4kFkR/e3J8KhK1a8fMaCfur/n4+t6U8TYvgWeqAbtbaXIgi/RG7n2Nn
 IgCgEQpNcYUnpO4gLchGeCIA=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id b39a93dc725c8c73;
	Mon, 02 Nov 2026 12:32:34 +0000
X-Mizu-Trace-ID: b39a93dc725c8c73
X-Migadu-Flow: FLOW_OUT
Message-ID: <69e66c9c-f2ab-41a7-972d-d1562a6387b8@linux.dev>
Date: Mon, 2 Nov 2026 20:32:24 +0800
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
Subject: Re: [PATCH bpf v2 07/15] bpf, sockmap: Check the target of an egress
 redirect before each send
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-8-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-8-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Chris Mason <mason@kernel.org>
>
> tcp_sendmsg_locked() expects a caller that has the socket open. It uses
> sk->sk_socket and the wait queue sk->sk_wq. For an egress redirect of an
> sk_msg prog the sender calls it on the target without a reference to the
> target's file. Both pointers are NULL before accept() and after close().
> close() can occur while the sender sleeps. Then the kernel crashes.
>
> Fail the redirect when the target has no struct socket, or when the sender
> has to wait for the connection. The error is EINVAL. After close() it is
> EPIPE, as today. sk_stream_wait_connect() calls remove_wait_queue() without
> a test of SOCK_DEAD. sk_stream_wait_memory() has this test, but it can
> still use sk_wq after the sleep. This patch does not change that. The
> target can change while the sender sleeps there. Thus do both checks before
> each call of tcp_sendmsg_locked(). Clear MSG_FASTOPEN, so that the sender
> does not call the connect code of the target, which uses both pointers.
>
> Today the sender can send before accept() and waits in SYN_SENT. send()
> with MSG_FASTOPEN sends the data. Today it fails with EISCONN. When the
> redirect of a cork fails, send() returns success and the kernel drops the
> data, as today.
>
> The Fixes tags are for the two checks and for MSG_FASTOPEN, in this order.
>
> Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
> Fixes: b8b8315e39ff ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
> Fixes: c5c37af6ecad ("tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES")
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  net/ipv4/tcp_bpf.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index fd443350f9b8..ef2e15de0fe3 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -88,6 +88,24 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
>  	return ret;
>  }
>  
> +/*
> + * The target of a redirect belongs to somebody else. A child that nobody has
> + * accepted yet, and an orphan, have no struct socket and no wait queue.
> + * tcp_sendmsg_locked() needs both. See sendmsg_locked() in skbuff.c.
> + * The sender holds no reference to the file of the target, which can be closed
> + * whenever tcp_sendmsg_locked() sleeps. sk_stream_wait_connect() and
> + * inet_wait_for_connect() go back to the wait queue when they wake up, so the
> + * sender must not wait for a connect.
> + */
> +static bool tcp_bpf_redir_allowed(const struct sock *sk)
> +{
> +	if (!sk->sk_socket)
> +		return false;
> +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
> +		return tcp_passive_fastopen(sk);
> +	return true;
> +}
> +
>  static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
>  			int flags, bool uncharge)
>  {
> @@ -109,6 +127,10 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
>  		page = sg_page(sge);
>  
>  retry:
> +		/* Only a redirect sends data which is not charged to sk */
> +		if (!uncharge && unlikely(!tcp_bpf_redir_allowed(sk)))
> +			return sock_flag(sk, SOCK_DEAD) ? -EPIPE : -EINVAL;
> +


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

I can trigger it by redirecting data to a non-accept sk.

==================================================================
BUG: KASAN: null-ptr-deref in tcp_sendmsg_locked+0xfb8/0x4550
Write of size 8 at addr 0000000000000008 by task repro/488
Tainted: [W]=WARN
Call Trace:
 <TASK>
 dump_stack_lvl+0x91/0xf0
 print_report+0x442/0x630
 kasan_report+0xf3/0x130
 kasan_check_range+0x11c/0x200
 __kasan_check_write+0x14/0x30
 tcp_sendmsg_locked+0xfb8/0x4550
 tcp_bpf_push+0x3d0/0xbc0
 tcp_bpf_sendmsg_redir+0x639/0x1050
 tcp_bpf_sendmsg+0xa32/0x1b90
 inet_sendmsg+0xdf/0x100
 __sys_sendto+0x3ed/0x4f0
 __x64_sys_sendto+0xe0/0x1b0
 x64_sys_call+0x1375/0x27e0
 do_syscall_64+0xe5/0x610


