Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1A314A4F9
	for <mptcp@lists.linux.dev>; Mon, 13 May 2024 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596735; cv=none; b=ES1v9WRkdXr0QgNSNwbN9B10zrAbhCbEqRq7dCdQJmLEQd0DkmJxIdSPCkXDmA7hx/v+6vwn941qrQMhj/cTq6WPS9v22NFElMzP4yYmiDE7teYmGMEWJ+f17Pa/C7LeLv3t84PqThfORIRl56DRPcUcHlgfwGMTCUi1iycEDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596735; c=relaxed/simple;
	bh=DcelCX/qe62Cf0jK0De6jmYEw6xGnirHs9Nis4XO1hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+/2iB2G9mSag/4i8Xb+EJSk2NImEFm8vK/zSp7obHWhN34L0PohPMotQViyS5HBxd6vQv2OtqU2Lb6b2OXNVwB64WDBZF/me2cklqJfq9FoccYr3lFDPsVHVlYanu2yICgrCDYEwuuzaj82DY6AB6vJ1B4e3pLXeBmaVChwMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVn1R/H7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVn1R/H7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1187FC113CC;
	Mon, 13 May 2024 10:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715596735;
	bh=DcelCX/qe62Cf0jK0De6jmYEw6xGnirHs9Nis4XO1hI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TVn1R/H7mTNoU/MbwIK4Z8RCYQSG7lnDJNtLKt2VDVNbVpkNUfG5UMu/Fbw0jAIc4
	 22Vnp0D5QSPolTb2/cwTdeBNKEA38irYvQvGPzUgCH2IIq5Mf9KPVExdyunNRXSLVq
	 KFg6X9TFJyyncIxjKUJE2DcEd/CxDQX3zgcA1sve7aZcFui2Ebbrqzm32k8yJFiRTS
	 BT+jaZSgqvTMVXW2mgkcERA7nK+vQTy9ac4w58W1q5koLiZTqs6xPzeF4WJghKAOAW
	 /MK5xAWZmaQR5veXwpZqdIfo8oTgCHf66zTTn/VYwdw3zPp82A76dtk/JUBHfLi/NO
	 aoKmdAnDg/P9Q==
Message-ID: <8c5f3bbf-16a9-4588-b2d3-bd9e31c4cd1e@kernel.org>
Date: Mon, 13 May 2024 12:38:51 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 2/3] Squash to "selftests/bpf: Add mptcp
 subflow subtest"
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1715503185.git.tanggeliang@kylinos.cn>
 <77d5112c49fac9e8f77c09c7c1c057b8ea25a60f.1715503185.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <77d5112c49fac9e8f77c09c7c1c057b8ea25a60f.1715503185.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 12/05/2024 10:41, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Use pm_nl_ctl when 'ip mptcp' fails.
> Use SYS_NOFAIL in _ss_search() and drop 'ss -M'.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/prog_tests/mptcp.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 793b4b9c2bd2..2459c0e2a794 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -362,7 +362,10 @@ static int endpoint_init(char *flags)
>  	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
>  	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
>  	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
> -	SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
> +	if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags)) {
> +		SYS(fail, "ip netns exec %s ./mptcp_pm_nl_ctl add %s flags %s",
> +		    NS_TEST, ADDR_2, flags);

As I mentioned in the v1, I would prefer only using 'ip mptcp', and I
find it strange to have a CI validating networking feature using an old
version of IPRoute2. But if we need an alternative method for the BPF
CI, I would prefer also having our CI using this method, to prevent any
issue with this method, and only realising that when upstreaming
patches, delaying them and causing confusions.

But feel free to add a command:

  /* It would be better to use  "ip -net %s mptcp endpoint add %s %s",
   * but the BPF CI is using an old version of IPRoute (5.5.0).
   */


> +	}
>  
>  	return 0;
>  fail:
> @@ -371,16 +374,8 @@ static int endpoint_init(char *flags)
>  
>  static int _ss_search(char *src, char *dst, char *port, char *keyword)
>  {
> -	char cmd[128];
> -	int n;
> -
> -	n = snprintf(cmd, sizeof(cmd),
> -		     "ip netns exec %s ss -Menita src %s dst %s %s %d | grep -q '%s'",
> -		     NS_TEST, src, dst, port, PORT_1, keyword);
> -	if (n < 0 || n >= sizeof(cmd))
> -		return -1;
> -
> -	return system(cmd);
> +	return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d | grep -q '%s'",
> +			  NS_TEST, src, dst, port, PORT_1, keyword);
>  }
>  
>  static int ss_search(char *src, char *keyword)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

