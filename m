Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896984657F5
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787139805; cv=none; b=MBqfBGxFEF+BvxO8/xqKzt2PgEilwMRR+z02H9wz83BYK/1j1Wyqvg9wOXcud2sb2KQSZ4b72+DfimjEPcN4bEEfRLGkFZQ/4woZFKEnMZl6sYJi9Mi+ZSKtqCyAJlLgY3OYyFDDtWM8zAMPwXiOHWsDJv6NcZ8daOJ3xuT+YYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787139805; c=relaxed/simple;
	bh=N+5XtOzIgeeWPlRc+/c9d6sWeA1tzOjEd/Skvyh3ORc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G6QXVaXHeQA4whG7mxECNegCB0EJ/VmN47M6CFt78JIm1kGuakLPiRwnTSapKjgWVLWtHfaNwasijA4PPsenKQvByE/NWGpQxy6SPTAbMVW+yc/C9+FzoEMK7yJnV9xPUgJedwRIAzN9sm0+x8NZ2U3sObBCQmx9moRizskJ3nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYNJZ72w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYNJZ72w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0334F1F000E9;
	Wed, 19 Aug 2026 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787139797;
	bh=BDZTNUwiuvVXsTdpOcXN5QI6b4OelFET4Cg2OvjS6FE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bYNJZ72wWGL+TUHVTgjV50zPzvtvi7vmkYaHMiROXmM78w4+2tJFKNRUHB3jTysms
	 PrMV8pWkXVqeSOpN8sisyyDuItcauQXW2fBj88ZkTbSiVlXDOvFJ3wRcxQ4BW5NXqp
	 e3ReLp+WmZc7N811BvOCjBeuo2DbrP7p9BIZeR5vBv0AAVahLTtG4ME4ag5eqXH7d4
	 OtQ1pN6XC6ziop7xwsJAhf7wKS8D+IGBJ0I2p71buJfEadKaObbR0LZHdPg8wGT5Bm
	 ZyzXzfQfjsFWnkahtbrtrgNzYhXRHXYYcabiDgSpsuGvbL3zpxeg54qj5K+9gGuqKC
	 bqYdQTETPMdEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next RFC v5 2/3] mptcp: fallback immediately on
 MP_FAIL reception
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chenguang Zhao" <chenguang.zhao@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260819112112.1985121-3-chenguang.zhao@linux.dev>
References: <20260819112112.1985121-1-chenguang.zhao@linux.dev>
 <20260819112112.1985121-3-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:43:16 +0000
Message-Id: <20260819114317.0334F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] State Machine Violation: Executing receive logic and queueing data=
 on a closed socket
- [High] Logic Bug: Premature fallback evaluation uses stale MPTCP queue st=
ate
--

--- Patch [2]: [PATCH mptcp-next RFC v5 2/3] mptcp: fallback immediately on=
 MP_FAIL reception ---
commit 293c264f04a7af047f95b678acf86f3fe06f4d7d
Author: Chenguang Zhao <zhaochenguang@kylinos.cn>

mptcp: fallback immediately on MP_FAIL reception
   =20
Call mptcp_try_fallback() right after the MP_FAIL response
ACK, and simplify mptcp_update_infinite_map() accordingly.

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d7c5b50b34cc9..351f9c998d7b6 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -895,6 +895,11 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 =
fail_seq)
>  		pr_debug("MP_FAIL response received\n");
>  		WRITE_ONCE(subflow->fail_tout, 0);
>  	}
> +
> +	if (!mptcp_try_fallback(sk, MPTCP_MIB_MPFAILFALLBACK)) {
> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_FALLBACKFAILED);
> +		mptcp_subflow_reset(sk);

[Severity: High]
Does this synchronously reset the socket to TCP_CLOSE during the RX path?

If mptcp_try_fallback() fails, we call mptcp_subflow_reset() which sets
the socket state to TCP_CLOSE. However, this is called from
mptcp_incoming_options() when parsing the MP_FAIL option:

net/mptcp/options.c:mptcp_incoming_options() {
    ...
		if (mp_opt.suboptions & OPTION_MPTCP_FAIL) {
			mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
		}
    ...
		if (!(mp_opt.suboptions & OPTION_MPTCP_DSS))
			return true;
}

If mptcp_incoming_options() then returns true without checking if the socket
was closed, won't the TCP stack continue normal packet processing? This cou=
ld
cause tcp_data_queue() to queue the packet's payload onto the closed socket,
and tcp_rcv_established() to proceed with an invalid state.

[Severity: High]
Does premature fallback evaluation here use stale MPTCP queue state?

Evaluating mptcp_try_fallback() synchronously in the softirq receive path
creates a race condition with the asynchronous MPTCP worker.
mptcp_try_fallback() checks if msk->out_of_order_queue is empty, but because
MPTCP queues are populated asynchronously by the MPTCP worker, this state is
inherently stale.

Since the current packet hasn't even been added to the TCP receive queue
yet, couldn't a gap be correctly filled by data sitting in the subflow's TCP
queue that hasn't been pulled into the MPTCP queue yet? This would cause
fallback to erroneously fail and lead to unwarranted subflow resets.

> +	}
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819112112.1985=
121-1-chenguang.zhao@linux.dev?part=3D2
