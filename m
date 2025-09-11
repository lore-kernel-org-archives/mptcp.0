Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1608E2E0B4B
	for <mptcp@lists.linux.dev>; Thu, 11 Sep 2025 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578519; cv=none; b=bSK2FgYAtXu4c+MoVZdcO019VCAhaRyb3BVfUHp4JJX7wieq3TedBPIsMqFzy6M0gOM8pGtF8y+SuAEFLi9ot3SEehUqfrviM8KBT3tHsP8mHKfqjvVqFgAfodJ5PNx5ENCTfiskSgMxW2c3Ut+CqSLbIxY2vg/RguUMsF2zdIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578519; c=relaxed/simple;
	bh=UWiLXvmKFwVyt5blNoKoJOQQOHUDV5nQy2aWT+wk60o=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cy6SjnyGDSIR/at7eKovbKwMyUsRIAIfMgL0LiOP9w6dJct8dcDPJUS0hOPWxYpMm7kEqEBWVoEi0KynUnCYLz0BezEjE8/FxozTp0YdlC7T+UXU0NHuhxu+QowJ2TwAvGVd+WzPL4dBjMAxh3ApqVD31r2bLTPfV4UwBoc7pHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+eY8xk/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+eY8xk/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E13C4CEF8;
	Thu, 11 Sep 2025 08:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757578518;
	bh=UWiLXvmKFwVyt5blNoKoJOQQOHUDV5nQy2aWT+wk60o=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=M+eY8xk/RjhYzdiiHEPPHvCDJap7dnOUQ2uWvhm26UIq95jvVGX0o6mOPy+4dLALZ
	 UE9XVN7gul5hL4HFhm5syluTpb/VPM2tu+sFyEF39UY/y7zS8GC9OsG4EWoJGyFOou
	 U6kyjb2qRopkzJnFAxZu32jPbxkuKdkF1ahu/2Kq6kU/8h4bTBS6TMArOzOI6tOEDh
	 DsGDz9PtWtIsvjUQ9shnUgI5NxSpBdZFVWYNTfd7OqdtdEcSUwXMbVMFb2uCGJP1cn
	 boWkB66UEuZC8GblJdv8wbRmZmIc1D2BOwSvRX4vjjHDGhxZUl3NCHWTkcB4z81RJm
	 sGHBLmWRkc7jw==
Message-ID: <732d1d85e092148ff8d8d1c82f311929a5d53ff3.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/4] mptcp: pm: netlink: only add server-side
 attr when true
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Thu, 11 Sep 2025 16:15:14 +0800
In-Reply-To: <20250909-mptcp-pm-user-server-side-flag-v1-1-cb8e2b8d1c0c@kernel.org>
References: 
	<20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
	 <20250909-mptcp-pm-user-server-side-flag-v1-1-cb8e2b8d1c0c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Tue, 2025-09-09 at 18:30 +0200, Matthieu Baerts (NGI0) wrote:
> This attribute is a boolean. No need to add it to set it to 'false'.
> 
> Indeed, the default value when this attribute is not set is naturally
> 'false'. A few bytes can then be saved by not adding this attribute
> if
> the connection is not on the server side.
> 
> This prepares the future deprecation of its attribute, in favour of a
> new flag.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  Documentation/netlink/specs/mptcp_pm.yaml         | 4 ++--
>  include/uapi/linux/mptcp_pm.h                     | 4 ++--
>  net/mptcp/pm_netlink.c                            | 4 +++-
>  tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 +-
>  4 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/mptcp_pm.yaml
> b/Documentation/netlink/specs/mptcp_pm.yaml
> index
> d1b4829b580ad09baf4afd73b67abd7b4ef6883a..fc47a2931014c0304efd3215cc2
> 4485ea22e1ede 100644
> --- a/Documentation/netlink/specs/mptcp_pm.yaml
> +++ b/Documentation/netlink/specs/mptcp_pm.yaml
> @@ -28,13 +28,13 @@ definitions:
>            traffic-patterns it can take a long time until the
>            MPTCP_EVENT_ESTABLISHED is sent.
>            Attributes: token, family, saddr4 | saddr6, daddr4 |
> daddr6, sport,
> -          dport, server-side, [flags].
> +          dport, [server-side], [flags].
>        -
>          name: established
>          doc: >-
>            A MPTCP connection is established (can start new
> subflows).
>            Attributes: token, family, saddr4 | saddr6, daddr4 |
> daddr6, sport,
> -          dport, server-side, [flags].
> +          dport, [server-side], [flags].
>        -
>          name: closed
>          doc: >-
> diff --git a/include/uapi/linux/mptcp_pm.h
> b/include/uapi/linux/mptcp_pm.h
> index
> 7359d34da446b94be148b363079120db03ba8549..bf44a5cf5b5a1e6d789632682a9
> bedbf8090feb9 100644
> --- a/include/uapi/linux/mptcp_pm.h
> +++ b/include/uapi/linux/mptcp_pm.h
> @@ -16,10 +16,10 @@
>   *   good time to allocate memory and send ADD_ADDR if needed.
> Depending on the
>   *   traffic-patterns it can take a long time until the
> MPTCP_EVENT_ESTABLISHED
>   *   is sent. Attributes: token, family, saddr4 | saddr6, daddr4 |
> daddr6,
> - *   sport, dport, server-side, [flags].
> + *   sport, dport, [server-side], [flags].
>   * @MPTCP_EVENT_ESTABLISHED: A MPTCP connection is established (can
> start new
>   *   subflows). Attributes: token, family, saddr4 | saddr6, daddr4 |
> daddr6,
> - *   sport, dport, server-side, [flags].
> + *   sport, dport, [server-side], [flags].
>   * @MPTCP_EVENT_CLOSED: A MPTCP connection has stopped. Attribute:
> token.
>   * @MPTCP_EVENT_ANNOUNCED: A new address has been announced by the
> peer.
>   *   Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index
> 483ddbb9ec406a3e965376ee5a833ae295896a02..33a6bf536c020b59717472aca2d
> 38add26255419 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -413,7 +413,9 @@ static int mptcp_event_created(struct sk_buff
> *skb,
>  	if (err)
>  		return err;
>  
> -	if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, READ_ONCE(msk-
> >pm.server_side)))
> +	/* only set when it is the server side */
> +	if (READ_ONCE(msk->pm.server_side) &&
> +	    nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, 1))

In patch 2, this will be modified to use two 'if':

	if (READ_ONCE(msk->pm.server_side)) {
		flags |= MPTCP_PM_EV_FLAG_SERVER_SIDE;

		/* only set when it is the server side */
		if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, 1))
			return -EMSGSIZE;
	}

Why don't we just use two 'if' statements here, which will make patch 2
simpler:

       if (READ_ONCE(msk->pm.server_side)) {
               /* only set when it is the server side */
               if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, 1))
                       return -EMSGSIZE;
       }

WDYT?

Thanks,
-Geliang

>  		return -EMSGSIZE;
>  
>  	if (READ_ONCE(msk->pm.remote_deny_join_id0))
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index
> 0801d57a9710406a5942af742719f694e3907558..189bfc5bf86611575381542fe59
> b86660f335294 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -241,7 +241,7 @@ make_connection()
>  
>  	print_test "Established IP${is_v6} MPTCP Connection ns2 =>
> ns1"
>  	if [ "${client_token}" != "" ] && [ "${server_token}" != ""
> ] &&
> -	   [ "${client_serverside}" = 0 ] && [
> "${server_serverside}" = 1 ] &&
> +	   [ "${client_serverside:-0}" = 0 ] && [
> "${server_serverside:-0}" = 1 ] &&
>  	   [ "${client_nojoin:-0}" = 1 ] && [ "${server_nojoin:-0}"
> = 0 ]
>  	then
>  		test_pass
