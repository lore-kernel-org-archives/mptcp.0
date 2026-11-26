Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795675290;
	b=2i+LFXpSr/kEngkyTBjNAfxL38Nti8Zk4ZJz5UZtwRDoI7UJcj5Ed/dCA2Iz6OLurWny
	 id7lLrWbzjPv88uyw7TX5/DainetrqS3bfmDeFB951ZmtGbsmR8xQKKQK7IH14w7HQxVn
	 zgF1rLhH6evAimGMHlI0OCD+raQSKecmZtRviTRZTLjE3FmjhPrhU0/NuUkDudzEIchhh
	 7356zgy9SGgnFcCeXvTePFAvDmRNzZ27f3WRSg9a6MQvNRkr5GqTDnUbFpsdZmxEgol02
	 srAiXoxO4dbD87oNEcIwHcG0rQvHbUmdE3ovj7U/9ZbsCntfFTF6vAx8N4Nt4ZD+1mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675290;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hDk2GqmWiW2v9Qrz56Iu1odTHftcjaONQzs2gSCkNyM=;
	b=pWtCKEe+PdmMiysF3VjbaqO3jfH7kg7ldplKxB+oeh7+S+M0O1LuRhYUwZK2AkatuIEg
	 F12NimSYu2eNuKWiqosUF4ce8dZFJuXRxf+WZeUEielv9yr2N4NhpPvc+X/by+hKk8F6L
	 DZyMXQbYwVLNPCZ/h0M6sm6KX8ptQMizgUlwmJfr06wiLr2WSrn9WW7Klgun3a/gTa6B3
	 obxon63sJO0F76V9XhTMWAqVuRbuOqYohEyK7JjxW0RoBouNT/tkq61W2Dpsz3dRMrRKD
	 4iutlXjAlLgJQhCdCZJNIUBF9Y4UhinxGHzufzHcAP9G1lbu39+LxMSJ84keUPh20fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqvB92Qa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB28606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 06:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqvB92Qa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485CE1F000D1;
	Thu, 26 Nov 2026 06:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795675290;
	bh=hDk2GqmWiW2v9Qrz56Iu1odTHftcjaONQzs2gSCkNyM=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=mqvB92Qa2NYTaQixaE8gx30b3msJjP2Zz/8tlEhBQlMqDZrTZPwlzvUnY1L+o5sTt
	 yWXcL7HEl7yYty30vpbFXYSwywl8iBbf9v46+iuDVWMKqOzPKtI7vmN5oCa1Jp9KFb
	 AaRGm5fxvPO4b+nSxaiV+Guk6eUjKr5SCrjQJRhjrXVg4pXVF0s/MbueHR5niN9OuY
	 6rmX5Ft/A7BNjHONnu/tfZTf60Zk8OUsmXVDINsp1uo0GkXTetwViFgpMK1M9cKgzN
	 GBQg6pxbO4C/g+5qkH9wLEmECUeR1FUxWax1Pj4ydEO6rkrdOwlSiz9hnAnhOnaDLN
	 6nZbNY23SU4rA==
Message-ID: <6da8ac5a8885dc847f8d8f3d2d41c445cdbaf4eb.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3 16/50] mptcp: clear DEFER_CONNECT on
 disconnect
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Thu, 26 Nov 2026 14:41:25 +0800
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-16-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
	 <20261124-mptcp-cmason-fixes-v3-16-416c0920c73f@kernel.org>
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
> With TCP_FASTOPEN_CONNECT, mptcp_connect() copies the DEFER_CONNECT bit
> of the first subflow to the msk. This bit is cleared on the first
> write(), but not when the msk is disconnected, e.g. with
> connect(AF_UNSPEC) before any write().
> 
> tcp_disconnect() clears this bit on the subflow, but mptcp_disconnect()
> leaves it set on the msk. The next write() then goes through
> mptcp_sendmsg_fastopen(), and tries to connect the msk again with a NULL
> address: mptcp_connect() moves the msk back to SYN_SENT, possibly
> allocates a token and increments the MPCapableActive counter, before the
> subflow connect() fails. -EINVAL is then returned, instead of -EPIPE.
> The stale bit is also reported by the diag interface.
> 
> Clear DEFER_CONNECT in mptcp_disconnect(), like tcp_disconnect() does.
> 
> This issue has been found by an AI code review agent, while fixing a
> similar issue, and confirmed with a new Packetdrill test: a deferred
> connect, then connect(AF_UNSPEC), then send(). Without this patch,
> send() failed with EINVAL:
> 
>   client-TCP_FASTOPEN_CONNECT-disconnect.pkt:35: runtime error in send call: Expected errno 32 (Broken pipe) but got 22 (Invalid argument)
> 
> Fixes: a42cf9d18278 ("mptcp: poll allow write call before actual connect")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks good to me, thanks.

    Reviewed-by: Geliang Tang <geliang@kernel.org>

> ---
> v2: new, for an issue found by a review agent
> ---
>  net/mptcp/protocol.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6328815ad273..257c851c8a76 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3828,6 +3828,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
>  
>  	mptcp_check_listen_stop(sk);
>  	mptcp_set_state(sk, TCP_CLOSE);
> +	inet_clear_bit(DEFER_CONNECT, sk);
>  
>  	/* The later subflow close can not kick again the tout timer,
>  	 * as the msk is already in closed status.
