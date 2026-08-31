Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070823B71DF;
	Mon, 31 Aug 2026 04:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788149347; cv=none; b=Sh3aP7SjJJ49uZ1FALH7VhdMggnHiCz4Sl1LR8MLQQdhQynJpPvSplYz9YjQkg6CPEYasH8pkMzERvGa0uW+SpKYFqHrsFEFRSIfeHSzcfbATw9/7QlZAaZYYAf6EDfKvE39MxOPusH1vjcntY7UYW+z+hXUwsZBGYFEivPjpc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788149347; c=relaxed/simple;
	bh=SYLPKJwPVb8TOL1Tnw+rYAn2PAvvHlPtxwfP85MImHs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YqDHuQBrqZ1LMZhrSsiANx2leq1v3WTxvTNSWJYBlRmNSy8kn5z05DoZoXpU3xjOkDihKoaBpngzIBftDSIIs8nTUXw18pCuyI4GLMJPZe0G7SbzHS+40sAv/QuCnSdEispSln4JUiVZL3OmXc8hEiotJZaCtVdT5z4ohTw1/+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOnDKeaO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOnDKeaO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147071F00A3E;
	Mon, 31 Aug 2026 04:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788149345;
	bh=/ph9w7cuFjdMlI9pMSwhn/gmRZwiHl3sIDZaHz+Xc6Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OOnDKeaO4dBtt5gbCQXNC0+03hVmoc2n3c80kAeOrNZeUeD8fe/QLzoorm5Noxf0L
	 qUuPpioWzCAx0SSwgL096WSDZcHWli8AXYfaJy9LA4vq0zy3EmMOgOB85MJ8aSqxqG
	 scd27akD3Kjsi7+o6U1GLwZqjRn+T556bFch2xVZlrEIw8Hl+4pOidM0jRuKx20ehZ
	 Z2w3YGObrYDS8A5EdmU8jEZ5UyQzk9MkfSZZqGtklpm2RIAqAS1NXKUAP1GSk1e3x0
	 +SlkXhwdCAtKe/sHXAMPidw2UzzyKX1d91Ap53AtONPd95mKjHF5nZ3UDfvM0puGar
	 E59fs7PVyzBRA==
Message-ID: <c0bf0918bd97105ee50f1436e6ff729e84cedf03.camel@kernel.org>
Subject: Re: [PATCH 3/6] landlock: Add MPTCP bind and connect access rights
From: Geliang Tang <geliang@kernel.org>
To: =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>, 
 =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=
	 <mic@digikod.net>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>,  Mikhail Ivanov
 <ivanov.mikhail1@huawei-partners.com>, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, 	linux-security-module@vger.kernel.org
Date: Mon, 31 Aug 2026 12:09:00 +0800
In-Reply-To: <20260830201650.67050-4-gnoack3000@gmail.com>
References: <20260830201650.67050-1-gnoack3000@gmail.com>
	 <20260830201650.67050-4-gnoack3000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Günther,

On Sun, 2026-08-30 at 22:16 +0200, Günther Noack wrote:
> MPTCP sockets have equivalent bind(2) and connect(2) operations as
> TCP
> sockets, but can not currently be restricted with Landlock without
> explicit MPTCP access rights.  As MPTCP operates on the same TCP port
> number space as TCP, this is a gap in Landlock's policies.
> 
> Add access rights for MPTCP bind(2) and connect(2) operations
> and document them in the header.
> 
> Treat TCP Fast Open the same as done for plain TCP in
> commit 33cb713db016 ("landlock: Fix TCP Fast Open connection bypass")
> 
> The port numbers used in MPTCP subflows are negotiated by the kernel
> and therefore not subject to these access rights.
> 
> Bump the Landlock ABI version to 12.
> 
> Closes: https://github.com/landlock-lsm/linux/issues/54
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  include/linux/landlock.h                     |  5 +-
>  include/uapi/linux/landlock.h                | 24 +++++++
>  security/landlock/limits.h                   |  2 +-
>  security/landlock/net.c                      | 68 ++++++++++++++----
> --
>  security/landlock/syscalls.c                 |  2 +-
>  tools/testing/selftests/landlock/base_test.c |  2 +-
>  6 files changed, 79 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/landlock.h b/include/linux/landlock.h
> index 004cbd0b9298..b04ffc7caa21 100644
> --- a/include/linux/landlock.h
> +++ b/include/linux/landlock.h
> @@ -46,7 +46,10 @@
>  	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_CONNECT_TCP,
> "connect_tcp"), \
>  	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_BIND_UDP,
> "bind_udp"), \
>  	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP, \
> -			     "connect_send_udp")
> +			     "connect_send_udp"), \
> +	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_BIND_MPTCP,
> "bind_mptcp"), \
> +	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_CONNECT_MPTCP, \
> +			     "connect_mptcp")
>  
>  #define _LANDLOCK_SCOPE_NAMES \
>  	_LANDLOCK_NAME_ENTRY(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET, \
> diff --git a/include/uapi/linux/landlock.h
> b/include/uapi/linux/landlock.h
> index cceda3b3b961..2a953ba7ce25 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -448,6 +448,9 @@ struct landlock_net_port_attr {
>   * - %LANDLOCK_ACCESS_NET_CONNECT_TCP: Connect TCP sockets to the
> given
>   *   remote port. Support added in Landlock ABI version 4.
>   *
> + * .. note:: These rights do not apply to MPTCP sockets, which have
> their own
> + *   access rights (see below).
> + *
>   * And similarly for UDP port numbers:
>   *
>   * - %LANDLOCK_ACCESS_NET_BIND_UDP: Bind UDP sockets to the given
> local
> @@ -474,12 +477,33 @@ struct landlock_net_port_attr {
>   * .. note:: Sending datagrams to an ``AF_UNSPEC`` destination
> address
>   *   family is not supported for IPv6 UDP sockets: you will need to
> use a
>   *   ``NULL`` address instead.
> + *
> + * MPTCP sockets (created with ``IPPROTO_MPTCP``) use TCP port
> numbers, but
> + * they are controlled by their own access rights:
> + *
> + * - %LANDLOCK_ACCESS_NET_BIND_MPTCP: Bind MPTCP sockets to the
> given local
> + *   port. Support added in Landlock ABI version 12.
> + * - %LANDLOCK_ACCESS_NET_CONNECT_MPTCP: Connect MPTCP sockets to
> the given
> + *   remote port. Support added in Landlock ABI version 12.
> + *
> + * .. note:: The TCP and the MPTCP access rights are independent,
> even though
> + *   they refer to the same port number space. Handling only
> + *   %LANDLOCK_ACCESS_NET_BIND_TCP and
> %LANDLOCK_ACCESS_NET_CONNECT_TCP leaves
> + *   MPTCP sockets unrestricted, and vice versa. A sandbox that
> wants to
> + *   control all TCP-based traffic needs to handle both sets.
> + *
> + * .. note:: These MPTCP access rights restrict the ports passed to
> + *   :manpage:`bind(2)` and :manpage:`connect(2)`. The ports used in
> MPTCP
> + *   subflows are negotiated in the MPTCP protocol by the kernel and
> are not
> + *   subject to these restrictions.
>   */
>  /* clang-format off */
>  #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
>  #define
> LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
>  #define LANDLOCK_ACCESS_NET_BIND_UDP			(1ULL << 2)
>  #define LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP		(1ULL << 3)
> +#define LANDLOCK_ACCESS_NET_BIND_MPTCP			(1ULL << 4)
> +#define LANDLOCK_ACCESS_NET_CONNECT_MPTCP		(1ULL << 5)
>  /* clang-format on */
>  
>  /**
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 1a7c5fb8f6fd..d25e056b7ca2 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -23,7 +23,7 @@
>  #define
> LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
>  #define
> LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
>  
> -#define
> LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP
> +#define
> LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_MPTCP
>  #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET
> << 1) - 1)
>  #define
> LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
>  
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index 8f2aaac54b33..8541b0c07d64 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -11,6 +11,7 @@
>  #include <linux/net.h>
>  #include <linux/socket.h>
>  #include <net/ipv6.h>
> +#include <net/mptcp.h>
>  
>  #include "common.h"
>  #include "cred.h"
> @@ -53,6 +54,26 @@ int landlock_append_net_rule(struct
> landlock_ruleset *const ruleset,
>  	return err;
>  }
>  
> +static bool sk_is_mptcp_socket(const struct sock *sk)
> +{
> +	return sk_is_inet(sk) && sk->sk_type == SOCK_STREAM &&
> +	       sk->sk_protocol == IPPROTO_MPTCP;
> +}

This helper should be placed in include/net/mptcp.h. I had already
implemented one in [1], called sk_is_msk(), to differentiate it from
sk_is_mptcp(). If you have no concerns with my implementation, please
feel free to pick it up and use it in your series.

Thanks,
-Geliang

[1]
https://patchwork.kernel.org/project/mptcp/patch/e2727ba40084f261545f1cbb140a3fb9d295ba25.1765505775.git.tanggeliang@kylinos.cn/

> +
> +static bool is_connect_access(const access_mask_t access_request)
> +{
> +	return access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
> +	       access_request == LANDLOCK_ACCESS_NET_CONNECT_MPTCP
> ||
> +	       access_request ==
> LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
> +}
> +
> +static bool is_bind_access(const access_mask_t access_request)
> +{
> +	return access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
> +	       access_request == LANDLOCK_ACCESS_NET_BIND_MPTCP ||
> +	       access_request == LANDLOCK_ACCESS_NET_BIND_UDP;
> +}
> +
>  static bool unmask_layers_net(const struct landlock_domain *const
> domain,
>  			      const struct landlock_id id,
>  			      struct layer_masks *masks,
> @@ -104,6 +125,7 @@ static int current_check_access_socket(struct
> socket *const sock,
>  	switch (address->sa_family) {
>  	case AF_UNSPEC:
>  		if (access_request ==
> LANDLOCK_ACCESS_NET_CONNECT_TCP ||
> +		    access_request ==
> LANDLOCK_ACCESS_NET_CONNECT_MPTCP ||
>  		    (access_request ==
> LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP &&
>  		     connecting)) {
>  			/*
> @@ -147,17 +169,15 @@ static int current_check_access_socket(struct
> socket *const sock,
>  					});
>  				return -EACCES;
>  			}
> -		} else if (access_request ==
> LANDLOCK_ACCESS_NET_BIND_TCP ||
> -			   access_request ==
> LANDLOCK_ACCESS_NET_BIND_UDP) {
> +		} else if (is_bind_access(access_request)) {
>  			/*
>  			 * Binding to an AF_UNSPEC address is
> treated
>  			 * differently by IPv4 and IPv6 sockets. The
> socket's
>  			 * family may change under our feet due to
>  			 * setsockopt(IPV6_ADDRFORM), but that's ok:
> we either
> -			 * reject entirely for IPv6 or require
> -			 * %LANDLOCK_ACCESS_NET_BIND_TCP or
> -			 * %LANDLOCK_ACCESS_NET_BIND_UDP for IPv4,
> so it cannot
> -			 * be used to bypass the policy.
> +			 * reject entirely for IPv6 or require the
> relevant bind
> +			 * access right for IPv4, so it cannot be
> used to bypass
> +			 * the policy.
>  			 *
>  			 * IPv4 sockets map AF_UNSPEC to AF_INET for
>  			 * retrocompatibility for bind accesses,
> only if the
> @@ -204,12 +224,10 @@ static int current_check_access_socket(struct
> socket *const sock,
>  		addr4 = (struct sockaddr_in *)address;
>  		port = addr4->sin_port;
>  
> -		if (access_request ==
> LANDLOCK_ACCESS_NET_CONNECT_TCP ||
> -		    access_request ==
> LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
> +		if (is_connect_access(access_request)) {
>  			audit_net.dport = port;
>  			audit_net.v4info.daddr = addr4-
> >sin_addr.s_addr;
> -		} else if (access_request ==
> LANDLOCK_ACCESS_NET_BIND_TCP ||
> -			   access_request ==
> LANDLOCK_ACCESS_NET_BIND_UDP) {
> +		} else if (is_bind_access(access_request)) {
>  			audit_net.sport = port;
>  			audit_net.v4info.saddr = addr4-
> >sin_addr.s_addr;
>  		} else {
> @@ -228,12 +246,10 @@ static int current_check_access_socket(struct
> socket *const sock,
>  		addr6 = (struct sockaddr_in6 *)address;
>  		port = addr6->sin6_port;
>  
> -		if (access_request ==
> LANDLOCK_ACCESS_NET_CONNECT_TCP ||
> -		    access_request ==
> LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
> +		if (is_connect_access(access_request)) {
>  			audit_net.dport = port;
>  			audit_net.v6info.daddr = addr6->sin6_addr;
> -		} else if (access_request ==
> LANDLOCK_ACCESS_NET_BIND_TCP ||
> -			   access_request ==
> LANDLOCK_ACCESS_NET_BIND_UDP) {
> +		} else if (is_bind_access(access_request)) {
>  			audit_net.sport = port;
>  			audit_net.v6info.saddr = addr6->sin6_addr;
>  		} else {
> @@ -331,6 +347,8 @@ static int hook_socket_bind(struct socket *const
> sock,
>  
>  	if (sk_is_tcp(sock->sk))
>  		access_request = LANDLOCK_ACCESS_NET_BIND_TCP;
> +	else if (sk_is_mptcp_socket(sock->sk))
> +		access_request = LANDLOCK_ACCESS_NET_BIND_MPTCP;
>  	else if (sk_is_udp(sock->sk))
>  		access_request = LANDLOCK_ACCESS_NET_BIND_UDP;
>  	else
> @@ -349,6 +367,8 @@ static int hook_socket_connect(struct socket
> *const sock,
>  
>  	if (sk_is_tcp(sock->sk))
>  		access_request = LANDLOCK_ACCESS_NET_CONNECT_TCP;
> +	else if (sk_is_mptcp_socket(sock->sk))
> +		access_request = LANDLOCK_ACCESS_NET_CONNECT_MPTCP;
>  	else if (sk_is_udp(sock->sk))
>  		access_request =
> LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
>  	else
> @@ -377,12 +397,20 @@ static int hook_socket_sendmsg(struct socket
> *const sock,
>  	access_mask_t access_request;
>  	int ret = 0;
>  
> -	if ((msg->msg_flags & MSG_FASTOPEN) && address &&
> sk_is_tcp(sock->sk)) {
> -		ret = current_check_access_socket(
> -			sock, address, addrlen,
> LANDLOCK_ACCESS_NET_CONNECT_TCP,
> -			true);
> -		if (ret != 0)
> -			return ret;
> +	if ((msg->msg_flags & MSG_FASTOPEN) && address) {
> +		access_mask_t fastopen_access = 0;
> +
> +		if (sk_is_tcp(sock->sk))
> +			fastopen_access =
> LANDLOCK_ACCESS_NET_CONNECT_TCP;
> +		else if (sk_is_mptcp_socket(sock->sk))
> +			fastopen_access =
> LANDLOCK_ACCESS_NET_CONNECT_MPTCP;
> +
> +		if (fastopen_access) {
> +			ret = current_check_access_socket(
> +				sock, address, addrlen,
> fastopen_access, true);
> +			if (ret != 0)
> +				return ret;
> +		}
>  	}
>  
>  	if (sk_is_udp(sock->sk))
> diff --git a/security/landlock/syscalls.c
> b/security/landlock/syscalls.c
> index 1d02d57f4c48..cc54d4f1d502 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -172,7 +172,7 @@ static const struct file_operations ruleset_fops
> = {
>   * If the change involves a fix that requires userspace awareness,
> also update
>   * the errata documentation in Documentation/userspace-
> api/landlock.rst .
>   */
> -const int landlock_abi_version = 11;
> +const int landlock_abi_version = 12;
>  
>  /**
>   * sys_landlock_create_ruleset - Create a new ruleset
> diff --git a/tools/testing/selftests/landlock/base_test.c
> b/tools/testing/selftests/landlock/base_test.c
> index d20ab8f0862c..58fe322d8637 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -76,7 +76,7 @@ TEST(abi_version)
>  	const struct landlock_ruleset_attr ruleset_attr = {
>  		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
>  	};
> -	ASSERT_EQ(11, landlock_create_ruleset(NULL, 0,
> +	ASSERT_EQ(12, landlock_create_ruleset(NULL, 0,
>  					     
> LANDLOCK_CREATE_RULESET_VERSION));
>  
>  	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
