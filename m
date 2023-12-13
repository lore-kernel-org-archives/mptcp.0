Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E351F24B36
	for <mptcp@lists.linux.dev>; Wed, 13 Dec 2023 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBssAhbq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A621C433C8;
	Wed, 13 Dec 2023 11:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702467838;
	bh=uBLnlT3wO2gPHOKHBTh6gz2kIYmz+VD9NPgr44jSmiE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=hBssAhbqj/fkb+RyVQPi6rSNgpmCciuVsoAlWvbEUn7LR9tmd9Hr/5zxmrifWBgvg
	 59LvuttkntRBo6dETDq0kGvwekoWec4OHcLX25bmLsB9X3dw8vNtx9dqeIT/wTl75r
	 eUerXy7yoQgz3EFwN1sTOlgQKo2/JDRcZc6aECwA8bZ8IMI/vQgwwutsdSFjPGcvQJ
	 cIH9skodBKXKSplxuPAvuZMesy9WTuGHySxEdv/ufnFeTUeSYeiRh4d07W4WIgkiBb
	 ZNHfd3s7fExh4e76HwWKKkZKNxkDVksPilIA1hXzl1VAaV5Z8bKDfTi6Y2Gjj7vGoc
	 heK5+cFVheCjw==
Message-ID: <ee4dedf0-a0b8-43ea-b12f-12fabe449013@kernel.org>
Date: Wed, 13 Dec 2023 12:43:55 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v5 3/3] selftests: mptcp: check CURRESTAB
 counters
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@linux.dev>, mptcp@lists.linux.dev
References: <cover.1702446832.git.geliang.tang@linux.dev>
 <6b76a198cc11f69bf8c4621f1c8a5cd0c9d1a6ff.1702446832.git.geliang.tang@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <6b76a198cc11f69bf8c4621f1c8a5cd0c9d1a6ff.1702446832.git.geliang.tang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 13/12/2023 06:56, Geliang Tang wrote:
> This patch adds a new helper chk_cestab_nr() to check the current
> established connections counter MIB_CURRESTAB. Set the newly added
> variables cestab_ns1 and cestab_ns2 to indicate how many connections
> are expected in ns1 or ns2.
> 
> Invoke check_cestab() to check the counter during the connection in
> do_transfer() and invoke chk_cestab_nr() to re-check it when the
> connectin closed. These checks are embedded in add_tests().
> 
> Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 45 ++++++++++++++++---
>  1 file changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 87590a43b50d..3cd066e6e2b0 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

(...)

>  unset fullmesh
> @@ -976,6 +978,33 @@ pm_nl_set_endpoint()
>  	fi
>  }
>  
> +chk_cestab_nr()
> +{
> +	local ns=$1
> +	local cestab=$2
> +	local count
> +
> +	print_check "cestab $cestab"
> +	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCurrEstab")
> +	if [ -z "$count" ]; then
> +		print_skip
> +	elif [ "$count" != "$cestab" ]; then
> +		fail_test "got $count current establish[s] expected $cestab"
> +	else
> +		print_ok
> +	fi
> +}
> +
> +check_cestab()
> +{
> +	if [ -n "${cestab_ns1}" ]; then
> +		chk_cestab_nr $1 1
> +	fi
> +	if [ -n "${cestab_ns2}" ]; then
> +		chk_cestab_nr $2 1

Maybe clearer to add a comment (or use local variables?) to say what is
$1 and $2, no?

And maybe best to replace 1 by the value of cestab_ns[12]?

  chk_cestab_nr ${2} ${cestab_ns2}

(but we only create one MPTCP connection at a time... it is just that
'cestab_ns2' seems to refer to a counter, not an action
'chk_cestab_ns2'? Or use it as a counter?)

> +	fi
> +}
> +
>  do_transfer()
>  {
>  	local listener_ns="$1"

In this selftest, we only create one MPTCP connection at a time. Should
we not test this feature in diag.sh as well/instead? Similar to what we
do with chk_msk_inuse(). WDYT?

We can also do that after having reviewed and applied your series
modifying the selftests if it is easier.

Anyway, that's not blocking the series.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
