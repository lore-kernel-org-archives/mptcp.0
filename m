Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC823CCA02
	for <mptcp@lists.linux.dev>; Fri,  8 May 2026 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778240232; cv=none; b=W9I1eS04MqoM0Kldq0EoCqpyNenhJ3aGB9/Yk988fzMZneKcABjkJqP5Y3XZ+AFIVQya66qyeGQCx9dxhA6IbfxVZ0Lm8Qvl+UuulHLvIKiMz5UpzH9c0AUIDTTMguNffrbgkzbpBtzqkluwUzKv4CYXbAfrdNNal1NWzF6A11o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778240232; c=relaxed/simple;
	bh=pAR+h2H4STiQkaiMdObC8kHoIpi4mW1ElDih26JofLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ikl+E6B5aRf1hxMdMgEbjRNFc/S6/skI99gslaAywOCsvBus89mYUww+LricjjdnsjTQrKDjT0Z0fYlox3PSKkqHROuldNOTZ7yIdRSaOvjhILJRJTEThbQkSoZjxJarGV8dkksM8smo0rl09iuZEelpH3ITn7tS8hKFiUK/TOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRelA+hE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRelA+hE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85CAC2BCB0;
	Fri,  8 May 2026 11:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778240232;
	bh=pAR+h2H4STiQkaiMdObC8kHoIpi4mW1ElDih26JofLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vRelA+hEdj1skWiRhAaA9taSlw4kZurPGe1p566/ulWoNHayzJMzIQ2ff+NgyJ6aM
	 fHtZ9ylWCeumlTttSTBK0nBViLs7XJc5VcIFJ62XhHU1LrLKIM6Lsxvq+FZoounPkd
	 GUZfVVfZXHjpzpo8CjSGsEtXrBsTB17y0MjQqxiQJUWEAg1qnt/xFCmkwTKMPmADUt
	 UYNhGZs2OWhFYeu9K6d8cIg+PGOkW5QGpeVruCqXdNJ+xTGJCin29jEHzhIu8LsTiN
	 EU8sBJqnAZqgiosSvQ6EpvPTqZayp5zdRWsxZfxZeJbxuoqS+VYseBQnPRZrY5filJ
	 3KFblQcq9vjUw==
Message-ID: <c4bf25d5-46c7-4a3e-a59a-b8ab9105cf2f@kernel.org>
Date: Fri, 8 May 2026 13:37:08 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3 2/2] selftests: mptcp: join: cover ADD_ADDR
 tx drop and list progress
Content-Language: fr
To: Li Xiasong <lixiasong1@huawei.com>, mptcp@lists.linux.dev
Cc: weiyongjun1@huawei.com, yuehaibing@huawei.com, zhangchangzhong@huawei.com
References: <20260507125224.3536507-1-lixiasong1@huawei.com>
 <20260507125224.3536507-3-lixiasong1@huawei.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260507125224.3536507-3-lixiasong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Li,

On 07/05/2026 14:52, Li Xiasong wrote:
> Extend add_addr_ports_tests with IPv6 signaling cases that exercise
> ADD_ADDR tx-space shortage when tcp_timestamps are enabled.
> 
> Add one case to verify PM still progresses to later signal endpoints
> after the first one is dropped.
> 
> This covers both failure accounting and the non-blocking behavior of
> the announce list after a tx-space drop on pure ACK.
> 
> Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index beec41f6662a..5acd12021e6e 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

(...)

> @@ -3278,6 +3294,21 @@ add_addr_ports_tests()
>  
>  		chk_mpc_endp_attempt ${retl} 1
>  	fi
> +
> +	# first signal address drops, second one still progresses
> +	if reset "signal addr list progresses after tx drop"; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 1 0
> +		ip netns exec $ns1 sysctl -q net.ipv4.tcp_timestamps=1
> +		ip netns exec $ns2 sysctl -q net.ipv4.tcp_timestamps=1
> +
> +		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal port 10100
> +		pm_nl_add_endpoint $ns1 dead:beef:3::1 flags signal
> +		run_tests $ns1 $ns2 dead:beef:1::1
> +		chk_add_drop_tx_nr 1
> +		chk_add_tx_nr 1 1

It would be good to call chk_add_drop_tx_nr from chk_add_tx_nr, similar
to what is done with chk_join_tx_nr from chk_join_nr. For example, by
default, assuming there is no drop, except when add_addr_drop_tx_nr=X is
passed when calling chk_add_tx_nr. Or as a new optional argument for
chk_add_tx_nr.

But that's more mptcp-next material, so I'm not going to block this
patch for that! But if you are whiling to add this, don't hesitate to :)

> +		chk_add_nr 1 1 0
> +	fi
>  }
>  
>  bind_tests()

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

