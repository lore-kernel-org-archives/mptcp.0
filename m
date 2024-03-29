Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EFD2904
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711728947; cv=none; b=mAdyn4wCYGNyqXJd4r0SHpre66ZBq0+yWslpL6Wi0A1qs9VCgKQzrAQHXWglvCE64swPogz1pQaWLssXb51CkQekp2+NyFLHUfCQwynUt9YHMITJp/st6go3rSUS49ROlTlRZTtGLW6PmgqXkgpF5Abh5K7ZjETF8DIAzn29F+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711728947; c=relaxed/simple;
	bh=hV2sGEkZwb/SoUANHngLruExoutV6mAtwNQuMfNwqCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GD6CoVapdeGBoM34ns66cPVS0q4AO46Ww8laJb3rHkQtQhbWB+sK21jdldGlDgPqtuoJPRoUBNxSaOVHiUE/yJG6D9aXQH0ZpMgBr8p1PxPLVJI37th/bzUICMiU51eo/y+i6xJoox5zuk4ezhmqu1LVeW5NlUXCfB/Ru9Ha1SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDdQ/iwc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDdQ/iwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680CFC433F1;
	Fri, 29 Mar 2024 16:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711728946;
	bh=hV2sGEkZwb/SoUANHngLruExoutV6mAtwNQuMfNwqCA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UDdQ/iwccjwQIOmKWRl+EhwScjhH3oXG9YPFXvR9m19T/wPbxceyB6Y4uy4ReVUEB
	 jEeD//hs/ch2wsIRjCp2LMxoGaCc4lQwQnEQgnFtSg0GydK3GYrb4+8VEME424lyGG
	 wmrtY6ivUrZWG/lC+GayA16OJT6KSBLPS/k0obZPYd7ksgTC1ChEpmPtEMaKxeBG5P
	 t8obF2f9Zq6hHJyE3iMWTwz9oNp8+E4EziDvbR7q92SUgrkTQnA5xEHcG42HZxNRh9
	 JVquUSlJHfKIRjJ5lPpKd0ZbikCoPBFe+EXbrPfUIyAKrN38mphbl1ZhnhEiOFYuvx
	 P8f3Wecu1hVVA==
Message-ID: <d74027a8-fcb7-4dd5-b203-876858a75c49@kernel.org>
Date: Fri, 29 Mar 2024 17:15:43 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 3/3] selftests: mptcp: add last time actions
 tests
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1711702915.git.tanggeliang@kylinos.cn>
 <5dd35f7df3332535dc938d1dfcc1c41ee7c717f0.1711702915.git.tanggeliang@kylinos.cn>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <5dd35f7df3332535dc938d1dfcc1c41ee7c717f0.1711702915.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 29/03/2024 10:07, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a new helper chk_msk_info() to show the counters in
> mptcp_info of the given infos, and check that the timestamps move
> forward. Use it to show newly added last_data_sent, last_data_recv
> and last_ack_recv in mptcp_info in diag.sh.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/diag.sh | 24 +++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index bc97ab33a00e..6e865f95f85e 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -200,6 +200,27 @@ chk_msk_cestab()
>  		 "${expected}" "${msg}" ""
>  }
>  
> +chk_msk_info()
> +{
> +	local info
> +
> +	for info in "${@}"; do
> +		local cnt1 cnt2 msg
> +
> +		cnt1=$(ss -N ${ns} -inmHM | mptcp_lib_get_info_value "$info" "$info")

Mmh, when there are many connections in parallel or a fallback to TCP,
what are you going to look at? Would it not be better to restrict this
test only when there is one connection ("after MPC handshake"), using a
counter for the client side and one for the server side, using ss
'[sd]port ${port}' filter?

Also, do you need 'ss -m' here?

> +		cnt2=$(ss -N ${ns} -inmHM | mptcp_lib_get_info_value "$info" "$info")

Should you maybe wait half a second between the two call of 'ss', just
to be sure data have been exchanged on very slow environments? By doing
that, you can additionally check that the timestamps are different by at
least 250ms, no?

> +		msg="....chk ${info:0:15}=$cnt1:$cnt2"

${msg} is used in mptcp_lib_result_XXX(), which mean it is used as title
for the subtest in the TAP format. This title should always have the
same name in case of error or success for the same test. Here, the same
test will always have a different name, that's not OK.

(It is also important to have different names for different subtests, so
if the helper is used multiple time, you cannot just show '${info:0:15}'
here)

> +		mptcp_lib_print_title "${msg}"
> +		if [ "${cnt1}" -lt "${cnt2}" ]; then
> +			mptcp_lib_pr_ok
> +			mptcp_lib_result_pass "${msg}"
> +		else
> +			mptcp_lib_pr_skip
> +			mptcp_lib_result_skip "${msg}"

(the fail part is missing, but I see you added it in a squash-to patch
later, I will comment there).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

