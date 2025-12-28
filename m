Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B371DFFD
	for <mptcp@lists.linux.dev>; Sun, 28 Dec 2025 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766890481; cv=none; b=dFK5dGvfx3xvhmmUQYW6V3OJco5f3K6VuqDezsmRzptedtLWj6dOOxK0iZap2/J+JxtvklpUCJ9mN/SiW7TP5KEiIytBWOFoEyWsqNePefVVMNs6Q0JTPjx8jwtayp2wVBaigNCQQTJefbW8ClwbSh1iORaPmy5JYudz9W2DH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766890481; c=relaxed/simple;
	bh=l8uW9ihCT82NcG5JJFpvF2wrXWBGDWkTaDg8zQCqMWk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQUFXepGNr44mamlJ9OJkRRiYWJdr126V4iiEKeugcZhamtxnVuWvDM6OZpgHHOUPDaIsoYk6KkwHRtLoxbRvXF6WjkSEzbQ1FoZmZfO0Ta88F+0H81qSLmQVeYmaA4h4qkHeBeg26y2jBXjLXGO8QpBeizgLwhjQb//f6XNjqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thTStfX4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thTStfX4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D29C4CEF1;
	Sun, 28 Dec 2025 02:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766890480;
	bh=l8uW9ihCT82NcG5JJFpvF2wrXWBGDWkTaDg8zQCqMWk=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=thTStfX4fl+hmjAzWZYvk3NX9Zlq5d2k1ORJ5coDgEg8MDAtIYJSz8gKnXtpgjrzy
	 V0oCaV8AeDtA2f6fJIgXnAK5qTx5Wfpp9AqMc/6Nq2c9g/YEmOjMJKiVOgIEJ5dDeJ
	 ggORMwKI9LfYKkjFMec3xM0CRWcGUDa7S+EARTruKDpMfBuVSHB7bnXZZF9rRU8X6c
	 eQnY3b8aZd2EVUCceTUn87nCoHI2QhjXoo64L85BO5HHpfvR21stkCNA6V1/uEFnfQ
	 altltuvFPMc4nZ4n8JEvI58bv0zA1Cv6mVsobnlgiIAzrQhXJ7KzCM/sGRhTogpgYp
	 BJxqvzxp001IA==
Message-ID: <1bc66b28aa41d97ae8180705747015f6b6a4bb2c.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 10/11] selftests: mptcp: connect: fix
 maybe-uninitialize warn
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Sun, 28 Dec 2025 10:54:37 +0800
In-Reply-To: <20251226-mptcp-issue-603-v1-10-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
	 <20251226-mptcp-issue-603-v1-10-bb30e331b839@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this fix. In my previous commit "selftests: mptcp: connect:
fix uninitialized peer warning" [1], I also fixed this.

[1]
https://patchwork.kernel.org/project/mptcp/patch/43931d38bed6e47b1b68d3bdf0a13916a926d190.1763546473.git.tanggeliang@kylinos.cn/

On Fri, 2025-12-26 at 07:40 +0100, Matthieu Baerts (NGI0) wrote:
> This warning can be seen with GCC 15.2:
> 
>   mptcp_connect.c: In function ‘main_loop’:
>   mptcp_connect.c:1422:37: warning: ‘peer’ may be used uninitialized
> [-Wmaybe-uninitialized]
>    1422 |                 if (connect(fd, peer->ai_addr, peer-
> >ai_addrlen))
>         |                                 ~~~~^~~~~~~~~
>   mptcp_connect.c:1377:26: note: ‘peer’ was declared here
>    1377 |         struct addrinfo *peer;
>         |                          ^~~~
> 
> This variable is set in sock_connect_mptcp() in some conditions. If
> not,
> this helper returns an error, and the program stops. So this is a
> false
> positive, but better remove it by initialising peer to NULL.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

    Reviewed-by: Geliang Tang <geliang@kernel.org>

-Geliang

> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index b82df82e0594..27a93a25b142 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -1353,8 +1353,8 @@ void xdisconnect(int fd)
>  
>  int main_loop(void)
>  {
> +	struct addrinfo *peer = NULL;
>  	int fd = 0, ret, fd_in = 0;
> -	struct addrinfo *peer;
>  	struct wstate winfo;
>  
>  	if (cfg_input && cfg_sockopt_types.mptfo) {
