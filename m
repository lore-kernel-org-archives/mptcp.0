Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102242AD25
	for <mptcp@lists.linux.dev>; Thu,  1 Aug 2024 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506718; cv=none; b=ss1W+p+8lp0WOOUXVUjQORGjIg0S2xWBmjGpkrIiKMKnyp9zrTc6IV+9K75Heei+pxdddkSbGW2qzgkhWa3f3oKUcQPKJgoIRnLd5bTnckAkllXGVa9G0p/a/+0lseNqc6YO/2jGVxjGMolIGjXYYqJc9PfvWVj7p+niPBvi6z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506718; c=relaxed/simple;
	bh=w9hem0hY76FIz2/wyQCnez9qI0tko0iEKalv+X0fI5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ujp2JwxAmwE37s1X+yukgUEJKxQZRSjcxxoA0c/WYJU9r862tK4fWAExoknvDZqH6dk4YfXoKRTWpsNaGA3x4VA8CTuya4bX5EQECO8jsTlYSScbuPLDgpbbnBlIcbQLVYmjW+pC9jq/Z+P7Sln/vGLlkpfTHS7K1LlW5FLLV3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmK8UbXI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmK8UbXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B464C32786;
	Thu,  1 Aug 2024 10:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722506717;
	bh=w9hem0hY76FIz2/wyQCnez9qI0tko0iEKalv+X0fI5w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UmK8UbXIogzWddOAmtGWWrZsxpiQOTF+kEdPaJpDQdJc5eutU6TtqP/V+xq6K/+J1
	 eYfGlYlHpb8DlkkaNFfcOfu5Uhok39Of9QfigM7yow7MvrHDtXAyr9UEWhMXa8HfnQ
	 4Qvc1fhLGucGhi2y2MbIXFgDedagUCvkl5CtB3/8LqGQbEXrQkgRhpxJcekc32b9Jh
	 CzoIFhZ0DZLb+4t6GnbCJW7afNyD/zVlqMN07EsKVBfKPHogDf7MkNFPOWnlSSGzY5
	 bvtFMdmaQVHgeEnaG7GgC82Zkp6LpzPx2czZtkeg3ygAZMImNPggDs8JM0NVHffZET
	 Qf4V07KBjYZuw==
Message-ID: <650b8368-a911-4546-b306-d6f16598e92f@kernel.org>
Date: Thu, 1 Aug 2024 12:05:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 4/4] selftests: mptcp: join: add io thread
 tests
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1722502941.git.tanggeliang@kylinos.cn>
 <30fbc6cffaf0617640cd1dbb0afd8b056dcab684.1722502941.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <30fbc6cffaf0617640cd1dbb0afd8b056dcab684.1722502941.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 01/08/2024 11:21, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This io thread mode is used in BPF selftests bpf_tcp_ca and MPTCP, and
> it is not very stable for MPTCP sched tests. This patch adds them into
> mptcp_join tests (-T) to make sure this scene is also covered.

Do you need to have multiple subflows to reproduce the issue? Can we not
have this test in mptcp_connect.sh instead?

For example, would it help to modify the CI to run:

  ./mptcp_connect.sh -m thread


> 
> These tests only run in ns1 for 100 times. The failed output looks like:
> 
>  001 io thread tests
>  recv 2884500 expected 10485760
>  send 8005500 expected 10485760
>  Failed in thread_ret -11
>  Test no. 12 failed.
>        syn                        [FAIL] got 12 JOIN[s] syn expected 100
>        synack                     [ OK ]
>        ack                        [FAIL] got 12 JOIN[s] ack expected 100
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 01c1e0871aca..ecba07aac776 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3663,6 +3663,24 @@ endpoint_tests()
>  	fi
>  }
>  
> +io_thread_tests()
> +{
> +	if reset "io thread tests"; then
> +		local nr=0 max=100
> +		mptcp_lib_pm_nl_set_limits $ns1 8 8
> +		mptcp_lib_pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
> +		while [ $nr -lt $max ]; do
> +			nr=$((nr + 1))
> +			ip netns exec $ns1 ./mptcp_connect -l 10.0.1.1 -m "thread" -O 3000

When you read this, it doesn't look obvious it is going to send and
receive data with itself. Can we not have a client and server? If not,
at least an explicit option, not making '-m "thread"' doing that.

> +			if [ $? -ne 0 ]; then

Shellcheck will not like that I guess:

  if ! ip netns exec (...); then

> +				echo "Test no. $nr failed."
> +				break;
> +			fi
> +		done
> +		chk_join_nr $max 0 $max
> +	fi
> +}
> +
>  # [$1: error message]
>  usage()
>  {
> @@ -3711,6 +3729,7 @@ all_tests_sorted=(
>  	F@fail_tests
>  	u@userspace_tests
>  	I@endpoint_tests
> +	T@io_thread_tests
>  )
>  
>  all_tests_args=""

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

