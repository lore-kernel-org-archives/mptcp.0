Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC51317736
	for <mptcp@lists.linux.dev>; Fri,  5 Sep 2025 00:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757033657; cv=none; b=a9co1yi15pYECy2avLsElcjo0vvoR3aTiIRkNgN96NQ1fAw24tjVzzFm3o0S0l4DSoq9rNndKVzWjVlUv8zPYUBdLgXysWEbzOEIFRhLdJ8xD2+OuvBNdI1eqA36ayLz0LTMP5LW6WwG1sXxN4MIH21aJrxJIc6XZ1KQWNHo1wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757033657; c=relaxed/simple;
	bh=dOzxsjgwzQTZPyWdvC4sHkG/Ip9IPRogXOPADDYHuFQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tpRbN4OC2mlsf/3Dbh9XLbVM181B+n7zmrWcMk1uqP3uG740B8LRsKyH6OG7dyNSy5F2eGoCCdDsDulH4tfaAbOF17W7p2tYLh96CB7BqL7dYs3MYx21Kes+JFgJE7ujYzIawey9mNyzC3Z4YPvDxSO8BxGAi6eEuoqHIxDJQU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQuzFDCc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQuzFDCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB8DC4CEF0;
	Fri,  5 Sep 2025 00:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757033657;
	bh=dOzxsjgwzQTZPyWdvC4sHkG/Ip9IPRogXOPADDYHuFQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=FQuzFDCcgbpy5q3z3/XRXLNEurrCoqbrTdVtIE2wLWWPQ1Z21oo8lUvaU+1TSmIia
	 he6tM6btJGvbPnuPBCfk/BbBJRq4nCHur+nmtPKPAoYqnt/Z0aveQJ3GXkbjMvm0yj
	 fD3lFQs3C6ObvzJbMTcuhULwoamldDp63i4Xo8pk9pnpXrATbQQJNvVRrc0gazq+ic
	 eQ75LS3zkCWcR0gEZDob3JAL4tq9SlvgvZ2k3MF8qAr976j4qb0Rar6Jurj/v3x7YU
	 FmSg1hIbqH8hLSpfUuLnX6xn8ipBv3olQulxVgjakZ2YWn9eiW9F1qp/qXytXeBvZ4
	 Fej2Yl6Q2R1lA==
Date: Thu, 4 Sep 2025 17:54:16 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RFC mptcp-net 7/7] mptcp: pm: nl: announce deny-join-id0
 attribute
In-Reply-To: <20250829-mptcp-pm-user-c-flag-v1-7-78b25dda7708@kernel.org>
Message-ID: <c0361d0e-bbe8-d04b-2afd-4f27c3d30546@kernel.org>
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org> <20250829-mptcp-pm-user-c-flag-v1-7-78b25dda7708@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 29 Aug 2025, Matthieu Baerts (NGI0) wrote:

> During the connection establishment, a peer can tell the other that it
> cannot establish new subflows to the initial IP address and port by
> setting the 'C' flag [1]. Doing so makes sense when the sender is behind
> a strict NAT, operating behind a legacy Layer 4 load balancer, or using
> anycast IP address for example.
>
> When this 'C' flag is set, the path-managers must then not try to
> establish new subflow to the other peer's initial IP address and port.
> The in-kernel PM has access to this info, but the userspace PM didn't.
>
> When a new connection is created and established, the Netlink events
> will now contain a new deny-join-id0 attribute. When set to 1, it means
> no other subflow to the initial IP address and port -- which is part of
> the event -- can be established.
>
> Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.1-20.6 [1]
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/532
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> This patch is marked as an RFC, just so we can agree on the attribute
> type: should we use a new dedicated attribute, or start using flags? It
> even looks like we have defined a "flags" attribute, but it is currently
> not used. Using "flags" would allow us to save some bytes, and in this
> case, 'server-side' should have used "flags" too. The problem with the
> flags is that the userspace cannot tell if a new flag is unset because
> the kernel doesn't support it, or because it doesn't need to be set. But
> is it really an issue? If the kernel doesn't support it, the userspace
> will probably not know what to do anyway. So fine to use flags? Or not
> needed, because it is unlikely to add new attributes later on?
>
> If yes, I suggest:

Hi Matthieu -

I do prefer 'flags' for this. It is the "C flag" after all :)

> - switching 'flags' to u32 instead of u16 because it doesn't change
>  anything, and it is currently not used

There is already iproute2 code that references the 16-bit flags, even if 
it is just for 'ip mptcp monitor'. Better to not alter the existing 
userspace API here, especially in a -net patch.

> - deprecating the 'server-side' attribute, and adding it in the flags
>  (but keeping it for the moment, maybe we can remove it in a few
>  versions?)

Good idea, can duplicate the information between the server-side attribute 
and flag for now. Then update mptcpd to prefer the flag version and remove 
from the kernel sometime after that.

> - adding deny-join-id0 as a flag: MPTCP_PM_EVENT_FLAG_DENY_JOIN_ID0

Sounds like a good plan!


- Mat


> If no, we can use what is proposed here.
>
> In any cases, I would like to add a test. I initially added one in
> userspace_pm.sh, but due to "mptcp: pm: userspace: respect deny_join_id0
> attr", it is no longer possible to set allow_join_initial_addr_port
> sysctl knob to 0 there, as the value is no longer ignored by the
> userspace PM. Probably best to add a test in mptcp_join.sh.
> ---
> Documentation/netlink/specs/mptcp_pm.yaml | 7 +++++--
> include/uapi/linux/mptcp_pm.h             | 5 +++--
> net/mptcp/pm_netlink.c                    | 4 ++++
> 3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
> index d15335684ec3d6256505f2b3887ce5818eb57462..0b53d8b5b4524b6026009cfa4510e7a6e141acf1 100644
> --- a/Documentation/netlink/specs/mptcp_pm.yaml
> +++ b/Documentation/netlink/specs/mptcp_pm.yaml
> @@ -28,13 +28,13 @@ definitions:
>           traffic-patterns it can take a long time until the
>           MPTCP_EVENT_ESTABLISHED is sent.
>           Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
> -          dport, server-side.
> +          dport, server-side, deny-join-id0.
>       -
>         name: established
>         doc: >-
>           A MPTCP connection is established (can start new subflows).
>           Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
> -          dport, server-side.
> +          dport, server-side, deny-join-id0.
>       -
>         name: closed
>         doc: >-
> @@ -266,6 +266,9 @@ attribute-sets:
>       -
>         name: server-side
>         type: u8
> +      -
> +        name: deny-join-id0
> +        type: u8
>
> operations:
>   list:
> diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
> index 6ac84b2f636ca22935c191c645449fb62b673899..6c751c488e51d6ab711607189041d5e2ea222e4e 100644
> --- a/include/uapi/linux/mptcp_pm.h
> +++ b/include/uapi/linux/mptcp_pm.h
> @@ -16,10 +16,10 @@
>  *   good time to allocate memory and send ADD_ADDR if needed. Depending on the
>  *   traffic-patterns it can take a long time until the MPTCP_EVENT_ESTABLISHED
>  *   is sent. Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6,
> - *   sport, dport, server-side.
> + *   sport, dport, server-side, deny-join-id0.
>  * @MPTCP_EVENT_ESTABLISHED: A MPTCP connection is established (can start new
>  *   subflows). Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6,
> - *   sport, dport, server-side.
> + *   sport, dport, server-side, deny-join-id0.
>  * @MPTCP_EVENT_CLOSED: A MPTCP connection has stopped. Attribute: token.
>  * @MPTCP_EVENT_ANNOUNCED: A new address has been announced by the peer.
>  *   Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
> @@ -126,6 +126,7 @@ enum mptcp_event_attr {
> 	MPTCP_ATTR_RESET_REASON,
> 	MPTCP_ATTR_RESET_FLAGS,
> 	MPTCP_ATTR_SERVER_SIDE,
> +	MPTCP_ATTR_DENY_JOIN_ID0,
>
> 	__MPTCP_ATTR_MAX
> };
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 50aaf259959aeaf36e7ab954c6f7957eaf2bc390..93455b63ef80395ff19f40d84cd28438a3578b98 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -415,6 +415,10 @@ static int mptcp_event_created(struct sk_buff *skb,
> 	if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, READ_ONCE(msk->pm.server_side)))
> 		return -EMSGSIZE;
>
> +	if (nla_put_u8(skb, MPTCP_ATTR_DENY_JOIN_ID0,
> +		       READ_ONCE(msk->pm.remote_deny_join_id0)))
> +		return -EMSGSIZE;
> +
> 	return mptcp_event_add_subflow(skb, ssk);
> }
>
>
> -- 
> 2.50.1
>
>
>
