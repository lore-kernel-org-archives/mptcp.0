Received: from mta1.migadu.com (out-118.mta1.migadu.com [95.215.58.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F7535F18B
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358350; cv=none; b=Z9AeES9/0ny4dScWoKCIWmYePadLQ5yIXqrnNjHIic6lRB8dmpHw1fSxlByGD2chswqtfe/ToHijPZ1Q2FpnaDX5r6boKPRr1XOJzxuudZrqHuntbkE34WRK/DXrts4/eAsTZXN1UAsAHBpHX6tbJLfnKoDJWcfWdlYYV+cmntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358350; c=relaxed/simple;
	bh=W7b5bnaFNjMh4W/Tp38RDotWj8dBqgWV6+5uiy7EAEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7V9gYrQgbOcHt3p4VnjaoX4cTnZojQbvfHxgZFrhukOsyquXwTkj+IhNkYhbr94Rgaf9lDdUgmedj5UqP8x7jGR0kdhqmC3WA8m9N8Icu0H9Qw9TYLr3fUyEF8ExBLY4ndB2ngfKUkjHigFg5eCd7m7YjKtK9ND2TillT1WFE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pvn9iXyl; arc=none smtp.client-ip=95.215.58.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pvn9iXyl"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=W7b5bnaFNjMh4W/Tp38RDotWj8dBqgWV6+5uiy7EAEA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788358345; v=1; x=1788963145;
 b=pvn9iXyl7K4x8sIvTRmyqEl+pOPk8qHucKnlUb7So7Y/gnrt2/8hclA09L/5YK1qnDGn84lh
 +zF9KJHpRxOj+m4ECiWUE8MQ7EwIqXPA6fvarKULOD6gq4PVTAkV2vTgnnDfpACY5qnzgrdkY2v
 y/aa8xkyAPlyo0kahAHNjCqU=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 3d4233997ff0b34f;
	Wed, 02 Sep 2026 14:12:25 +0000
X-Mizu-Trace-ID: 3d4233997ff0b34f
X-Migadu-Flow: FLOW_OUT
Message-ID: <44162dd1-fec7-47be-bf48-186c69be6dd9@linux.dev>
Date: Wed, 2 Sep 2026 22:12:18 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcp: fastopen: check rsk_drop_req() in
 tcp_fastopen_create_child()
To: Yilin Zhang <yilinzhang@moonshot.ai>, Mat Martineau
 <martineau@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 Kimi Security Team <bug-report@moonshot.ai>
References: <20260902121247.3248539-1-yilinzhang@moonshot.ai>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260902121247.3248539-1-yilinzhang@moonshot.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


on 9/2/26 8:12 PM, Yilin Zhang wrote:
> subflow_syn_recv_sock() destroys the freshly cloned child for an MP_JOIN
> SYN under the fatal fallback and hands it back with drop_req=true to
> tell the caller to drop both the request and the child. Of the three
> syn_recv_sock() callers, tcp_check_req() and the cookie path honor that
> contract; tcp_fastopen_create_child() only checks child != NULL.
>
> With an MPTCP listener and server-side Fast Open enabled, this can
> become a use-after-free:
>
>    1. fetch a TFO cookie,
>    2. complete a normal MP_CAPABLE handshake to learn the server's key
>       and compute the token offline,
>    3. send an MP_JOIN SYN carrying that token and the valid TFO cookie,
>    4. a subsequent accept() hands the freed socket to userspace, and
>       any fd operation triggers slab-use-after-free, leading to a
>       denial of service.
>
> Fixes: 90bf45134d55 ("mptcp: add new sock flag to deal with join subflows")
> Reported-by: Kimi Security Team <bug-report@moonshot.ai>
> Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
> ---
>   net/ipv4/tcp_fastopen.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 6a031a1a6c9f..7a0b58b39a2c 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -337,6 +337,11 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
>   	if (!child)
>   		return NULL;
>   
> +	if (own_req && rsk_drop_req(req)) {
> +		sock_put(child);


The child is still locked by inet_csk_clone_lock.


We should do this instead:

diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 471c78be5513..22494ff746c7 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -337,6 +337,12 @@ static struct sock 
*tcp_fastopen_create_child(struct sock *sk,
         if (!child)
                 return NULL;

+       if (own_req && rsk_drop_req(req)) {
+               bh_unlock_sock(child);
+               sock_put(child);
+               return NULL;
+       }
+
         spin_lock(&queue->fastopenq.lock);
         queue->fastopenq.qlen++;
         spin_unlock(&queue->fastopenq.lock);


> +		return NULL;


tcp_conn_request will still send a SYN-ACK, but the RST was already sent


It's not clean. Maybe we should do something like this instead (untested)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0f60a1dbf927..d371845d601a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7775,6 +7775,10 @@ int tcp_conn_request(struct request_sock_ops 
*rsk_ops,
                 READ_ONCE(sk->sk_data_ready)(sk);
                 bh_unlock_sock(fastopen_sk);
                 sock_put(fastopen_sk);
+       } else if (rsk_drop_req(req)) {
+               reqsk_free(req);
+               dst_release(dst);
+               return 0;
         } else {
                 tcp_rsk(req)->tfo_listener = false;
                 if (!want_cookie &&



BTW, since this is reported by LLM I think it is not difficult to have 
the LLM write a     reproducer and test this patch.

