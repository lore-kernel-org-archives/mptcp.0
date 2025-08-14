Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB2B1AAE28
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182167; cv=none; b=AmcV/l79D2OF8AhuT36bbRvRC22KLFxIlWrunohj0VZljEvx0iRzM+euDEsNfyoiZHp8Zv4azHcDkXFbh86d1IMCSxCKYUw/uKGTPaAcEpfgEWYxNP+cqP6NBr8xWzodmqwKqAAZSdUKJiw0sBNQe74IpH53jTwUHjwitUhBJ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182167; c=relaxed/simple;
	bh=DcO4ZZitkEdwD2MEtSdqVvCb/f5KC26g9S2t+C6rliE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F+nmcPjL5MoEXkLTBRPnha7EeF2ib15LVBiGs5H2Quw8BOuLcfN3FCkGmMkTVi3BgIIWKSlPtbnoYBZO7yEym12KwCg3Anj5F2bU8LItDJuuhJq1d6BsR+iqaM1RnC54bTTz4dbnyQEvYc+RGE6oDpl8xV5P75ASkfXQH9OYzhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=op/LqTEn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="op/LqTEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60785C4CEEF;
	Thu, 14 Aug 2025 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755182167;
	bh=DcO4ZZitkEdwD2MEtSdqVvCb/f5KC26g9S2t+C6rliE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=op/LqTEntUMEAPH/Wa1HDiCxEp8nTLaENcisXwnYrdaA+htwTY0C/QHTilLol0WZC
	 EpwiN0tQJqJMTO8un/aZONXiuOWLe+q8mrsT9eKcI+o5FYM87uYtdVFHTSTYMlNS1h
	 RT8knoqTUzddk09fgSGK6db2/GpN1PVYaXLyFnfERGtAqG3ED0awHY3rC6IWwdCB6O
	 MoRicL263lXDRy4OIyJuByRlz8rhT8097q0sjKpF5n5k0RcazZeiPH9hHfq2Or6WvX
	 ToNw0XLiGowJX4+NVzWvpT5WAHI62MqhePXpBA/UuIaJDpYcJ18jRWB7V/1GVy2hnw
	 WdF2RffhI2SfA==
Message-ID: <077fb775-f533-4709-abef-44d95e676ee8@kernel.org>
Date: Thu, 14 Aug 2025 16:36:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 2/2] selftests: net: mptcp: add fallback
 checks in chk_join_nr
Content-Language: en-GB, fr-BE
To: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
References: <cover.1755139312.git.yangang@kylinos.cn>
 <9140453b80a6c0f31118b733785b8d498c17836b.1755139312.git.yangang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <9140453b80a6c0f31118b733785b8d498c17836b.1755139312.git.yangang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/08/2025 05:16, Gang Yan wrote:
> This patch can track these counters in each namespace and check if they
> don't have unexpected values in tests.
> 
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 2c1f0704bc17..ac9e9d4fed59 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -74,6 +74,8 @@ unset join_create_err
>  unset join_bind_err
>  unset join_connect_err
>  
> +unset ns1_fb
> +unset ns2_fb
>  unset infinite_map_tx_fb
>  unset dss_corruption_fb
>  unset simult_conn_fb
> @@ -1582,6 +1584,20 @@ chk_join_nr()
>  	join_syn_tx="${join_syn_tx:-${syn_nr}}" \
>  		chk_join_tx_nr
>  
> +	if [[ -n "$ns1_fb" ]]; then

Detail: you can use simple [], like in most places in this file.

> +		eval "$ns1_fb" \
> +			chk_fallback_nr ${ns1}
> +	else
> +		chk_fallback_nr ${ns1}
> +	fi
> +
> +	if [[ -n "$ns2_fb" ]]; then

Same here for simple [].

> +		eval "$ns2_fb" \
> +			chk_fallback_nr ${ns2}
> +	else
> +		chk_fallback_nr ${ns2}
> +	fi

This will print this for each test:

   #       check fallback nr                   [ OK ]
   #       check fallback nr                   [ OK ]

Not pretty... Also, it might be confusing to have all these "fallback"
lines when we don't expect any fallbacks.

What about printing it only in case of error? (or only once? but still
confusing / not worth it when printed for all tests?)


You could have another helper containing the code here above, and instead:

  rc=${KSFT_PASS}
  chk_fallback_nr_all || rc=${?}

  if [ "$rc" != "${KSFT_PASS}" ]; then
      print_results "fallback" ${rc}
  fi

> +
>  	if $validate_checksum; then
>  		chk_csum_nr $csum_ns1 $csum_ns2
>  		chk_fail_nr $fail_nr $fail_nr
> @@ -3435,6 +3451,7 @@ fail_tests()
>  		join_csum_ns1=+1 join_csum_ns2=+0 \
>  			join_fail_nr=1 join_rst_nr=0 join_infi_nr=1 \
>  			join_corrupted_pkts="$(pedit_action_pkts)" \
> +			ns1_fb="dss_fb=1" ns2_fb="infinite_map_tx_fb=1" \
>  			chk_join_nr 0 0 0
>  		chk_fail_nr 1 -1 invert
>  	fi

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

