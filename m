Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CD0208AD
	for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455845; cv=none; b=YagZdcRnwD6/NBto2S4r2EwTdjoNhDrX6I4x04bKPiA823V0k9jFXEHd204Rdxe0ALF+3kwvVfipbDZhdpy6OYv4pwTJYsQBnYu/+shhWLttuogTwmx8ceDlD+LkXMmGRLDqFw2+Wkqj0tDMIgQCRLOADCXJiIbvYrWCVr0HgL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455845; c=relaxed/simple;
	bh=V6hM8Dp8vbcID3w3JWoQqGj9Tu/Gnz6VVuB4RI/0lZs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PWdnBKDjFlEsvFcxHt/v65iTftb1YTegxo1G2OfFWQTIQaOkywokGA838KjXIgMo7sBAUk1MNTNPyA5fDI9Xl2ZbbOacvoo1d7cbZXxb6PSfx30i9hVzuyyhJIJoeu7hYoHLDRT1HUaNGz6ZaEkt7RY6KFiS6OL4Fg4QMMfOaFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4te8lyI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4te8lyI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F02C19424;
	Tue, 18 Nov 2025 08:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763455844;
	bh=V6hM8Dp8vbcID3w3JWoQqGj9Tu/Gnz6VVuB4RI/0lZs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=N4te8lyIleYQ/jTUkaNWtNW3BYJzOViAruynrJxkqpOyJDCcOULuTS1EhNwiJE6yj
	 RiAFHn0Bi4OISqbdbpMd0pyPee1AqOhEfD4ECozWbXe1b8eWacFC1CEakxJJMENWOz
	 UTHjEXM5HLFVxz2ouCWbevtcaBrMgKNsViD8ix8ne0ZrQU2oWUISyI1pJZSjWbvRuY
	 gsI3WA1XqCNk4PWhHNTRNwwyfjJPNNH2rpfoPt5/B5YWaoA/5n4/ARPwlvCofTAbBR
	 YNJ7Qjd4mdEXYmka85ylNv3H8fVk9UaGogxjVP8ph0AVwf1LvICguehiAulVuxtSlZ
	 UnHwo3i2DCPSQ==
Message-ID: <7f7380f782e729263e63c715cf5a0fecb34c501d.camel@kernel.org>
Subject: Re: [RFC mptcp-next 08/10] selftests: mptcp: connect: skip TLS in
 disconnect tests
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 18 Nov 2025 16:50:41 +0800
In-Reply-To: <0f303e07ce390055d0e68195530ae30ac33a2a5a.1763438045.git.tanggeliang@kylinos.cn>
References: <cover.1763438045.git.tanggeliang@kylinos.cn>
	 <0f303e07ce390055d0e68195530ae30ac33a2a5a.1763438045.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2025-11-18 at 12:01 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Modify disconnect test scenarios to bypass TLS socket configuration
> since TLS setup can interfere with connection teardown validation.
> Add cfg_disconnect flag to control this behavior.

tls_disconnect() returning EOPNOTSUPP caused the MPTCP connect's
disconnect tests to fail:

static int tls_disconnect(struct sock *sk, int flags)
{
        return -EOPNOTSUPP;
}

This patch can be dropped now that MPTCP support has been added to
tls_disconnect() like this:

static int tls_disconnect(struct sock *sk, int flags)
{
        if (sk->sk_protocol == IPPROTO_MPTCP)
                return mptcp_disconnect(sk, flags);
        return -EOPNOTSUPP;
}

Thanks,
-Geliang

> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index deafcff7a2c8..e43874610297 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -79,6 +79,7 @@ static char *cfg_input;
>  static int cfg_repeat = 1;
>  static int cfg_truncate;
>  static int cfg_rcv_trunc;
> +static int cfg_disconnect = 0;
>  
>  struct cfg_cmsg_types {
>  	unsigned int cmsg_enabled:1;
> @@ -434,7 +435,7 @@ static int sock_connect_mptcp(const char * const
> remoteaddr,
>  	}
>  
>  	freeaddrinfo(addr);
> -	if (sock != -1)
> +	if (sock != -1 && cfg_disconnect == 0)
>  		SOCK_TEST_TCPULP(sock, proto, is_mptcp(sock));
>  	return sock;
>  }
> @@ -1381,7 +1382,9 @@ int main_loop(void)
>  again:
>  	check_getpeername_connect(fd);
>  
> -	SOCK_TEST_TCPULP(fd, cfg_sock_proto, -1);
> +	/* Don't let TLS break disconnect tests */
> +	if (cfg_disconnect == 0)
> +		SOCK_TEST_TCPULP(fd, cfg_sock_proto, -1);
>  
>  	if (cfg_rcvbuf)
>  		set_rcvbuf(fd, cfg_rcvbuf);
> @@ -1540,6 +1543,7 @@ static void parse_opts(int argc, char **argv)
>  			break;
>  		case 'I':
>  			cfg_repeat = atoi(optarg);
> +			cfg_disconnect = 1;
>  			break;
>  		case 'l':
>  			listen_mode = true;
