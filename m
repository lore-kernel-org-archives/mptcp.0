Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600615;
	b=PTevMnpTXw5+T1EgLM8iu3SkYh6sMjoYCxpLayHpyO9SalkckqLng1mQSw2UuG8IGG0g
	 THjWE5xVZmwp7+UibT7Ld8tmjKOL05abZm0mhUnpCjG+ZVSLwpVeUqDG14gu+yglQfzk0
	 z2+041oVulAHnNvtlCFKAI1ypzXMOzxXkdm4BRh+aVlR5abfCuYyiQ56z7YeRmb35KskR
	 d/GT2OrUkpwezVaN9XqNcJE6hqGqyUmWlXhBWFdNFk7JXPRGFY/oNK7DXs5Bm546nCQFK
	 wv4umkJvMu6alJg4pTEXGaxnwi1PxR6m4/2cuV4upclGjUqxmJ890OuQ07RjAnhvNrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600615;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pnvn85uCz4KQiQDcqAE1uqGvm4H0Dc/0KsPcKHffwCU=;
	b=4CXIKBxfDowaQqlMtXiFurXVoqpFE3GfNdZiHnoGGvCS8WiuyjOu3CztLseMR5qJVbbm
	 8kn7quCQdEsMMiLqtpALfg6P/5AnJNkF71USvoxR3VXqClcbvJLJSUe+HJ1mMvKULy6eJ
	 PKEExMe1rA9r9hZQG5rn+hVczcyzLIaSvrsemPh5ELp148yVbVWMzojbP+zwGa+SxLJc8
	 GJrWC8GXKUZdlyyCU8kIlokGXRpJKeC0WrSX/Eq1sUZpryQcnICERYC+cZWDx7mceOL7Z
	 9i31ve4BU68hPUEFwmc/uk5u5VIFGIa79XojAhhLYNE+F1EKPir+PcFQqpR9zPRl5qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MV8ZIX7h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425D4606A319
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MV8ZIX7h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D591F000C1;
	Wed, 21 Oct 2026 16:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792600615;
	bh=pnvn85uCz4KQiQDcqAE1uqGvm4H0Dc/0KsPcKHffwCU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MV8ZIX7hZUv3yYR3cPHfWY0JWjKTLmV1O0vqoWCvGXlQQfdoHWs7o/bcoqPr0awGk
	 zyPZrY5gYcJj0ni1+3tCfhnGh9AtFLxh3jkSU9Mpj1xTpf15/ITSOdwAKXwx2Nsp+K
	 BMDLQFg/pmQkpkwrNwK8kGYs0SmyxyaewEPl2x1pjA7FaIjQZ37Hm/GduMA/qYMwsW
	 p31Nm2+XSqxoHYoxIrRlIWPJtKqMZ1T1SgGnYSa90BvbkF4ANIkamkrVYT2YsDR9gg
	 FoMV/Cn9COxfHcSMXnHtL2MHdJsaNlqd+Wznq5ozGuIDlQHn451Be/w+HXE5FNXR4S
	 2irobuTk7ySkQ==
Subject: Re: [PATCH mptcp-next v7 4/6] mptcp: pm: in-kernel: retry subflows
 closed after an error
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Wed, 21 Oct 2026 16:36:54 +0000
Message-ID: <179260061448.3133.10825671379220141321@kernel.org>
In-Reply-To: <20261020031711.1896660-5-anilkaushikwireless@gmail.com>
References: <20261020031711.1896660-5-anilkaushikwireless@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new paragraph in Documentation/networking/mptcp.rst (lines
  76-85) does not match what the code does in three ways.

--

mptcp: pm: in-kernel: retry subflows closed after an error

With the in-kernel PM, a subflow that TCP closes after a retransmission
or keepalive timeout is now re-created with the same addresses. The new
subflow's SYN retries are set from the subflow-retries limit. Subflows
reset by the peer or the path, never established, aborted locally, or
using a removed address are not retried.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440

> diff --git a/Documentation/networking/mptcp.rst b/Documentation/networking/mptcp.rst
> index b6753ffb9c9a6..0f07d4a29b6b7 100644
> --- a/Documentation/networking/mptcp.rst
> +++ b/Documentation/networking/mptcp.rst
> @@ -73,6 +73,17 @@ To be able to use multiple IP addresses on a host to create multiple *subflows*
>  addresses can be used. This can be configured with ``ip mptcp endpoint`` for
>  example.
>  
> +When TCP gives up on an established subflow initiated by the in-kernel path
> +manager, after a retransmission or keepalive timeout, the path manager creates
> +it again, with the ``subflow-retries`` limit as its number of SYN retries, like
> +``TCP_SYNCNT``. A subflow reset by the peer, or by anything on the path, is not
> +created again. TCP only gives up on a subflow after ``tcp_retries2``

[Severity: Low]
Does this paragraph match what mptcp_pm_kernel_retry_check() and
mptcp_pm_kernel_retry() do? I see three differences.

First, the text says only subflows "initiated by the in-kernel path
manager" are re-created. The scope check in mptcp_pm_kernel_retry_check()
is:

net/mptcp/pm_kernel.c:mptcp_pm_kernel_retry_check() {
    ...
	/* Only re-create subflows initiated by this side: MP_JOIN ones, or the
	 * initial one on the client side.
	 */
	if (!subflow->request_join &&
	    (subflow->mp_join || READ_ONCE(msk->pm.server_side)))
		return false;
    ...
}

On the client side, the initial MP_CAPABLE subflow has request_join,
mp_join and server_side all at 0, so it passes this check and gets
re-created. That subflow came from the application's connect(), not
from the PM.

Second, re-creating the initial subflow takes one of the "subflows"
limit slots. mptcp_pm_kernel_retry() always does:

	if (allowed)
		msk->pm.extra_subflows++;

The original initial subflow never decremented that counter when it
closed, because mptcp_pm_subflow_check_next() only updates it when
request_join or mp_join is set.

So once the initial subflow is re-created, later endpoints or announced
addresses have one less slot. With a "subflows" limit of 0, the initial
subflow is never re-created at all.

Third, the re-creation only happens once. A re-created subflow that does
not connect within its SYN retries never becomes fully_established, so
this check stops it from being tried again:

	if (!READ_ONCE(subflow->fully_established))
		return false;

The commit message covers the second and third points ("Re-creating the
initial subflow uses one of the additional subflows allowed by the
limits" and "If this new subflow cannot connect, it is not retried
again"). Could mptcp.rst describe the scope correctly and mention these
two points as well?

> +retransmissions, about 15 minutes by default: shorter outages are handled by
> +TCP itself. A subflow that only receives data does not notice that its path
> +stopped working: the application should then enable TCP keepalive on the
> +MPTCP socket (``SO_KEEPALIVE``, ``TCP_KEEPIDLE``, ``TCP_KEEPINTVL`` and
> +``TCP_KEEPCNT``), which MPTCP applies to all its subflows.
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020031711.1896660-1-anilkaushikwireless%40gmail.com
