Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D8B188596
	for <mptcp@lists.linux.dev>; Thu, 26 Feb 2026 01:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772071103; cv=none; b=KHsKY7dmHJvSS3/KzS6zNxTbMzdp+Tmu/L10HQT89F9b4tMOoDU8ilCC5iiYTnlNYtqv/TkxnNwARvR+zsbT3vrqy+mn9lUQb1FNTL6Mlzu2PYl9E9YMBWfcIlEUguEHP6E3OQ0ZJhqHv3hpxMMZdHkz4v3qakrn40aQ/7COwlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772071103; c=relaxed/simple;
	bh=EH6qt7A/lPhMF83YDzKxiOLcX65WituiwQ/fUCpmwl4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n23frIS7WFRxfnlAy3KMIZtFdN0fLhNnMSF1DsPIL0xbyTE51TfF7+vSxps0/ynBM7cIefHKvvStCIFlUoJA1WSRkyWYm7uoENXUVK0kezvV2EmThMWiuWfZsyZ6Dx1Rf1C+jgrUOtzN4/HY1qLjYA8kT8ii1YaMT2LVb51LQL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdRfQ8vb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdRfQ8vb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8B9C116D0;
	Thu, 26 Feb 2026 01:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772071103;
	bh=EH6qt7A/lPhMF83YDzKxiOLcX65WituiwQ/fUCpmwl4=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=pdRfQ8vb7SP1lDzqwdhLgxqFVPo3wiQ5NaBpqj0WuqwzNtSNYFAnrmSak59zuP7he
	 JMkVNEh6an83Xuv6lByxas6sh910JzvrQ53pW86D4Uyail3BD/tyky7En98vl/P4fk
	 rTuuMBHLJc2tVejsOKDV8RdTjeWJCyqMyHYVMNeKQ/TslfxHWa8kKyLYlWzh252yzJ
	 8tUmJB6hbmHtt/5qjuKpqpBwXtVuKZNi/7pu6RnrXvQkABE8I4xMAVduLql3WF+i64
	 elZghDdHpptuV9gFM6eUXpjgN7koZWlzJ02Eft5rtS0Aq9SBEKHxlero6ItHbkazGY
	 6bo3FH9cNFZ7Q==
Message-ID: <b84b2296e37d0835c309947c1eaa2da86af13374.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: join: recreate signal endp
 with same ID
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Thu, 26 Feb 2026 09:58:19 +0800
In-Reply-To: <20260223-mptcp-sft-re-use-id-v1-1-ec648a8bda22@kernel.org>
References: <20260223-mptcp-sft-re-use-id-v1-1-ec648a8bda22@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this patch.

On Mon, 2026-02-23 at 19:46 +0100, Matthieu Baerts (NGI0) wrote:
> In this "delete re-add signal" MPTCP Join subtest, the endpoint
> linked
> to the initial subflow is removed, but readded once with different
> ID.
> 
> It appears that there was an issue when reusing the same ID, recently
> fixed by commit d191101dee25 ("mptcp: pm: in-kernel: always set ID as
> avail when rm endp"). The test then now reuses the same ID the first
> time, but continue to use another one (88) the second time.
> 
> This should then cover more cases.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/615
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks good to me.

    Reviewed-by: Geliang Tang <geliang@kernel.org>

-Geliang

> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index dc1f200aaa81..e22ed8cab27e 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4294,13 +4294,13 @@ endpoint_tests()
>  		chk_mptcp_info subflows 2 subflows 2
>  		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
>  
> -		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
>  		wait_mpj 4
>  		chk_subflow_nr "after re-add ID 0" 3
>  		chk_mptcp_info subflows 3 subflows 3
>  		chk_mptcp_info add_addr_signal 3 add_addr_accepted 2
>  
> -		pm_nl_del_endpoint $ns1 99 10.0.1.1
> +		pm_nl_del_endpoint $ns1 42 10.0.1.1
>  		sleep 0.5
>  		chk_subflow_nr "after re-delete ID 0" 2
>  		chk_mptcp_info subflows 2 subflows 2
> 
> ---
> base-commit: db54d4a79a413b2702191c0dc1d855bc3c9e1a98
> change-id: 20260223-mptcp-sft-re-use-id-c06c69316205
> 
> Best regards,
