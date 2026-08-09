Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D861A9F97;
	Sun,  9 Aug 2026 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786298621; cv=none; b=PQLpWrcUdtssBqcKT9EXwD3SmAEvZKZBk2vo5hYDiUt+7ymfQnOfdaJNK/QcKHzuhGcPjl34AHb1hrRSP8mp6HQDcE1vvD46QPMGK4SQRxPkuh0qQL9m5uTQsco8gOIvAqY//Xpr3mhPbAObOB5DYxdRwR8AUq7kNC2E1hSq64c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786298621; c=relaxed/simple;
	bh=a/EftZtQS7ASezEqXYlNIwKxlARantvOPOdduisv4+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T33mEbkO9b7/8bdCp2v/xcen7XezDllKggp8Y2K16gpg/gWlnmRdFJglUzkPSkwD/6lYbdFevv+C5j5+SgvLRw8z0o80dnYfyf18z7TwCWfhSQJd/3kC46z7DQ5kYedNXDETiVl9rhHO5Vk4g2hd/V78mVebfgG1pwL+7jVN1I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hii7hPjp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hii7hPjp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0E41F000E9;
	Sun,  9 Aug 2026 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786298619;
	bh=61cs1Wdrbr0AZr0ie9jpePC83AtXC1J7PEfOU0Q2Jnk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Hii7hPjpXFAbBtDs0FtOyGAsqGtqI8MkZqXaK/mz0iwM09wQ53RsN93zUfWZLx/Hy
	 JNh89DbHT/P8pTsm/SPs6b3yKML8jE1B1iTCBfWAr6BTIcs4SmgyG+6i10ZokC9mh/
	 VQgcxjboCkvmWccduJK3csEkmRrxhFtxWYVol0t9VO6m+ofx9pZV3L9rt8vT6wsJVx
	 ytHTowm+za+T1pVEy7cy61kiCyinnMBhfdVvEy9iopIHruJi7ZNZS0NVyv5DYBOGrk
	 4FgI08bZ07uOd8vQPEx0Z5e7cPn21yzmSmP9/XYYB5SfXe3S7lzZ6aAYJs3wSxdNFB
	 PAseBB/6ivxdQ==
Message-ID: <5ac3773c-4a6f-4796-a43f-545c3c42271c@kernel.org>
Date: Sun, 9 Aug 2026 20:03:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v3 2/2] mptcp: fix MP_CAPABLE token migration when
 cloning reqsk
Content-Language: fr
To: Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org, mptcp@lists.linux.dev
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, daniel@iogearbox.net, kafai@fb.com,
 kylebot@openai.com, david.lee@trailofbits.com, vega@nebusec.ai,
 caoruide123@gmail.com, sashiko-bot@kernel.org
References: <cover.1785995291.git.caoruide123@gmail.com>
 <a12d76b7f2305b5a8d64c3d6c3585e39684ff792.1785995291.git.caoruide123@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a12d76b7f2305b5a8d64c3d6c3585e39684ff792.1785995291.git.caoruide123@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ren, Ruide,

On 06/08/2026 13:14, Ren Wei wrote:
> From: Ruide Cao <caoruide123@gmail.com>
> 
> TCP request migration clones pending request sockets with
> inet_reqsk_clone().  For MPTCP MP_CAPABLE requests this byte-copies the
> token_node hlist state into the clone even though the token table still
> names the original request.
> 
> Moving the token only after inet_ehash_insert() succeeds leaves a window
> where the cloned request is already globally visible from the ehash but
> the token table still points at the original request.  Reordering the
> move after clone but before ehash exposure closes that window, but
> concurrent RX can still race on the old request and observe that the
> token was already moved.
> 
> Move MP_CAPABLE token request ownership during MPTCP request cloning
> under the token bucket lock.  Make mptcp_token_accept() and
> mptcp_token_destroy_request() re-check token_node under the same lock and
> treat an already moved or removed request as a normal race instead of
> warning.
> 
> If the passive MP_CAPABLE socket cannot claim the token, fail
> mptcp_sk_clone_init() and let the subflow fall back instead of
> installing a socket with mismatched token ownership.

Thank you for the new version!

I have one major comment, please see below:
> Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123%40gmail.com
> Signed-off-by: Ruide Cao <caoruide123@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> ---
>  net/mptcp/protocol.c   | 12 +++++----
>  net/mptcp/protocol.h   |  4 ++-
>  net/mptcp/subflow.c    |  2 ++
>  net/mptcp/token.c      | 61 +++++++++++++++++++++++++++++++++++++-----
>  net/mptcp/token_test.c |  4 +--
>  5 files changed, 68 insertions(+), 15 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ca644ec53eed..07eaa6858d05 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3608,17 +3608,19 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
>  	 */
>  	mptcp_set_state(nsk, TCP_ESTABLISHED);
>  
> +	if (!mptcp_token_accept(subflow_req, msk)) {
> +		mptcp_release_sched(msk);
> +		inet_csk_prepare_forced_close(nsk);
> +		tcp_done(nsk);

Here, you cannot call tcp_done(nsk): nsk is an MPTCP socket, not a TCP
one. You probably want to destroy the msk instead.

(In theory, your reproducer launched on a kernel with your patches
applied on top of MPTCP's export branch [1] should produce a warning)

Apart from that, Clashiko has a few comments. Do you mind checking them
and reply to each comment here, before sending a new version, whether
you agree/disagree or if it is unclear, please?

[1] https://github.com/multipath-tcp/mptcp_net-next/

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
pw-bot: cr

