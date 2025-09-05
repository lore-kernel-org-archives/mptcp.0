Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1457BA4A
	for <mptcp@lists.linux.dev>; Fri,  5 Sep 2025 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757116189; cv=none; b=VM1fuKgnkn+XZ2xjy8JZDyRvpznHKR2bNfInHwT98iVpUbNcdgup8zGgYN3Zv32e6OYb03yYf8EuO+zdqGeiGf6b9sm9TxqdVf9xuJIyiiN+gd9Bz7Wy9xgfDXMa1XMWO45rVmjfFCxg3/m8smdZ6ntatjkndH7JpqJOsc8FAdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757116189; c=relaxed/simple;
	bh=yM7W2oSvoTKPL3cpKqLsScGs0TNYS39p6i+a8S+OiV8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rq4OF7nLxQgIy8i2mAIeSJX714EBBa/sdxBiGHzObggLcCfD7hnbBKghds8eEpFKI6yE4U+j0xLWlsHY9hEAF58SR7TNlDJlUJ6HBT0Tr6fjpX0kmmcmMR85N3+1K/MsTPMN2Dpo9izNsUtDl3NF3nsJGxib76FrVq635inVAxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5gwJXU5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5gwJXU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42DBC4CEF1;
	Fri,  5 Sep 2025 23:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757116187;
	bh=yM7W2oSvoTKPL3cpKqLsScGs0TNYS39p6i+a8S+OiV8=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=S5gwJXU53Nms2F2t7P5owYAIWPL6muCDgxgi7A0qVmSM1ZgBq3znQCastnAi9aUHn
	 1tXCsfX6ezofEDnWzLV13nJkgQp/OPbCbChxteuhYTYFxWVJwP/D30wHVjLGRGac+k
	 akG+0OyDRaze84PxS67UpoYHx4mNvu0AceuGugkvY9s38qesChC0lYLQvVGFUBOKtf
	 8xc9uUKoZb898pizOTS2VZ3pILBtERqD/EVhi95mbd4u5aijUBIOJ4zXl7y63XHmtW
	 WvtBNTdgPyJ8xe4PG0c6039YYqQdXfH5Vcbx+g0IcRI2WFFYmT8bMf2dnNRkfErrbF
	 Jm6rO6GgmB2Vw==
Message-ID: <39e9e5644c96315181e19d5db1b2b44cb48fbf8a.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 2/5] selftests: mptcp: connect: catch IO
 errors on listen side
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Sat, 06 Sep 2025 07:49:44 +0800
In-Reply-To: <20250905-sft-mptcp-disc-err-v2-2-dfb3b6b4a877@kernel.org>
References: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
	 <20250905-sft-mptcp-disc-err-v2-2-dfb3b6b4a877@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2025-09-05 at 20:18 +0200, Matthieu Baerts (NGI0) wrote:
> IO errors were correctly printed to stderr, and propagated up to the
> main loop for the server side, but the returned value was ignored. As
> a
> consequence, the program for the listener side was no longer exiting
> with an error code in case of IO issues.
> 
> Because of that, some issues might not have been seen. But very
> likely,
> most issues either had an effect on the client side, or the file
> transfer was not the expected one, e.g. the connection got reset
> before
> the end. Still, it is better to fix this.
> 
> The main consequence of this issue is the error that was reported by
> the
> selftests: the received and sent files were different, and the MIB
> counters were not printed. Also, when such errors happened during the
> 'disconnect' tests, the program tried to continue until the timeout.
> 
> Now when an IO error is detected, the program exits directly with an
> error.
> 
> Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index
> 4f07ac9fa207cb08a934582b98d688d0b9512f97..c1586a7286123a509495ac319fd
> 624b98f0bfd18 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -1112,6 +1112,8 @@ int main_loop_s(int listensock)
>  	salen = sizeof(ss);
>  	remotesock = accept(listensock, (struct sockaddr *)&ss,
> &salen);
>  	if (remotesock >= 0) {
> +		int err;
> +
>  		maybe_close(listensock);
>  		check_sockaddr(pf, &ss, salen);
>  		check_getpeername(remotesock, &ss, salen);
> @@ -1125,7 +1127,9 @@ int main_loop_s(int listensock)
>  		SOCK_TEST_TCPULP(remotesock, 0);
>  
>  		memset(&winfo, 0, sizeof(winfo));
> -		copyfd_io(fd, remotesock, 1, true, &winfo);
> +		err = copyfd_io(fd, remotesock, 1, true, &winfo);
> +		if (err)
> +			return err;

The file descriptor (fd) should be closed before returning.

Thanks,
-Geliang

>  	} else {
>  		perror("accept");
>  		return 1;
