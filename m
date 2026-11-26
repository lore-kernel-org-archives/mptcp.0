Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795725845;
	b=qbcbRwVR+9s4GlZ5SFuaJjW4jn3nGekVoqxlameqD/EAcPGiP54/9m+zDiJsRcycKhE/
	 Wbt7V3Dz+oc5cUw3zdrROVDuiG1JYQWoVGa1+JnnONfK+xwsQgT6DuRpTH2ME0rl0OzJ6
	 iIP/9UUqK1Tm3Wzxxc+waSjTX/KkqSYFS6DiMfKMNMAPbdmQVtwPJD66LGlMJMj/vLTRT
	 EGFGkuJj7MvAWrypRKjLQV+zIqLi0Ae3+UvENjpaVg1mudpgzh5xBJJZbL6lSBgFz/0wY
	 /UYOD1pzEak6bLUsFrSvvld5NnXlVczWI63g5sLgkfSPldcDdi2FL02O7+30jIQBEbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725845;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+1LdW0+9eeK/n5JwMFKXMYxxGfYxQkNjX71qdqG+qj0=;
	b=zLowZYcGZ7gS1I8e3LniO9EL6bXWqioehvDp/c6xZcUFlyXKXP5NYpI/qB913ZLt4Gqh
	 dLfuY6O3JgqLeIGZJDHLFi15PhKtMth30vDgPED1lTdHdADPP0rwu/3GzPucU6eJBzIho
	 HX8B+Q5VLvbJUUqtMuCwNURcyzKO10UKddEmgPOOYRxLV0GcDq7jje1yjtTgdBEmRwRvn
	 I7XIkLf2BX98mbxG2SwcELgEjjoyjwEM4tvkEXKgQg8MeYMjLBQHJLjdx5jw/kiDxIwxM
	 73ZEOKo/6d8nszjOAB+FVYVs+gT6m5DhwKV/okZPzIarPEykJ2oiRT+68QZboEiSPlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAmzVxM2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929EE606A6B3
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAmzVxM2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2697C1F000C1;
	Thu, 26 Nov 2026 20:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795725845;
	bh=+1LdW0+9eeK/n5JwMFKXMYxxGfYxQkNjX71qdqG+qj0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UAmzVxM2tJrWL8N0Ic57pMVglYLDHwztTRP8YqzIVOL11tUKrGFWNYO95OrRdgWIN
	 0E3ipG5fMQzdMDAnT22iBtRa9oV7t2/LLRuidxwHxD4ooOB7zPAUn1HUP4ytLdBiL9
	 ZaU9whxtDapgN5ARjRshOg3vOEYfY/qp5FelGUR+xImtSHEk/aAYysCqN4EeKFdNIL
	 nDVDdsBOytCv+zpp72G6Q37nSOprFwtDleIkjOasdBAvXQEOJukzdBcEwviZumu9VO
	 87RfVRXi/zTCWSV6LKSUXA+rkpzT2QYC4AF4b31NuJrmQm5MYBWzN+3s2nTuu50odr
	 9waUCKC4Bq4hQ==
Subject:
 Re: [PATCH mptcp-next v9 6/7] selftests: net: msg_zerocopy: add MPTCP support
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 20:44:04 +0000
Message-ID: <179572584472.3133.9042620065604383437@kernel.org>
In-Reply-To: <89bb061e82fa0cf48cf44697041947bf9c99b110.1795591278.git.tanggeliang@kylinos.cn>
References: <89bb061e82fa0cf48cf44697041947bf9c99b110.1795591278.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds `$0 4 mptcp -t 1` and `$0 6 mptcp -t 1` to the
  default (no-argument) suite in…
- [Low] The header comment of tools/testing/selftests/net/msg_zerocopy.c
  lists the 'supported protocols and modes', including protocol variants…

--

selftests: net: msg_zerocopy: add MPTCP support

This patch adds an "mptcp" test mode to msg_zerocopy.c. The new mode opens
SOCK_STREAM sockets with IPPROTO_MPTCP, with a fallback definition for
older headers. msg_zerocopy.sh is also changed to run IPv4 and IPv6 MPTCP
tests in the default test suite.

> diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
> index 1d5d3c4e7e872..3a130f80d662f 100644
> --- a/tools/testing/selftests/net/msg_zerocopy.c
> +++ b/tools/testing/selftests/net/msg_zerocopy.c

[ ... ]

> @@ -816,6 +820,8 @@ int main(int argc, char **argv)
>  		do_test(cfg_family, SOCK_RAW, IPPROTO_RAW);
>  	else if (!strcmp(cfg_test, "tcp"))
>  		do_test(cfg_family, SOCK_STREAM, 0);
> +	else if (!strcmp(cfg_test, "mptcp"))
> +		do_test(cfg_family, SOCK_STREAM, IPPROTO_MPTCP);

[Severity: Low]
This isn't a bug, but should the header comment at the top of
msg_zerocopy.c also list the new mode? It currently says:

 * Send traffic between two processes over one of the supported
 * protocols and modes:
 *
 * PF_INET/PF_INET6
 * - SOCK_STREAM
 * - SOCK_DGRAM
 * - SOCK_DGRAM with UDP_CORK
 * - SOCK_RAW
 * - SOCK_RAW with IP_HDRINCL

Other protocol variants such as "SOCK_RAW with IP_HDRINCL" are listed
there, but SOCK_STREAM with IPPROTO_MPTCP is not. The usage string in
msg_zerocopy.sh was updated to include mptcp.

>  	else if (!strcmp(cfg_test, "udp"))
>  		do_test(cfg_family, SOCK_DGRAM, 0);
>  	else if (!strcmp(cfg_test, "rds"))
> diff --git a/tools/testing/selftests/net/msg_zerocopy.sh b/tools/testing/selftests/net/msg_zerocopy.sh
> index 28178a38a4e7b..83424758c452a 100755
> --- a/tools/testing/selftests/net/msg_zerocopy.sh
> +++ b/tools/testing/selftests/net/msg_zerocopy.sh
> @@ -31,6 +31,8 @@ if [[ "$#" -eq "0" ]]; then
>  	$0 6 tcp -t 1 || ret=1
>  	$0 4 udp -t 1 || ret=1
>  	$0 6 udp -t 1 || ret=1
> +	$0 4 mptcp -t 1 || ret=1
> +	$0 6 mptcp -t 1 || ret=1

[Severity: Medium]
Will this make the whole default suite fail on kernels where MPTCP, or
MPTCP SO_ZEROCOPY, is not available? Previously only tcp and udp ran here.
These new cases run unconditionally, and there is no feature check or
kselftest skip (exit 4).

On kernels without CONFIG_MPTCP, or for the IPv6 run without
CONFIG_MPTCP_IPV6, socket() fails. The tx side hits a hard error in
do_setup_tx():

	fd = socket(domain, type, protocol);
	if (fd == -1)
		error(1, errno, "socket t");

do_setup_rx() fails the same way with "socket r".

On kernels that have MPTCP but not "mptcp: handle SO_ZEROCOPY in
setsockopt", the "-z" run calls do_setsockopt(fd, SOL_SOCKET,
SO_ZEROCOPY, 1). In that case mptcp_setsockopt_sol_socket() ends with:

	 * SO_ZEROCOPY is currently unsupported, TODO in sndmsg
	 * SO_TXTIME is currently unsupported
	 */

	return -EOPNOTSUPP;

do_setsockopt() then calls error(1, ...), and the script sets ret=1.

msg_zerocopy.sh is in the net TEST_PROGS. The last patch in the series,
"selftests: mptcp: cover msg_zerocopy test", also links this script into
the MPTCP selftests. Those are often run on stable and older kernels, and
that patch does not add a feature check either.

Could the mptcp cases detect missing MPTCP or SO_ZEROCOPY support and
report a skip instead of a failure?

>  
>  	[[ "$ret" == "0" ]] && echo "OK. All tests passed"
>  	exit $ret

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795591278.git.tanggeliang%40kylinos.cn
