Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B832439A
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 01:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY6O6+Jy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25938C433C8;
	Wed, 11 Oct 2023 01:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696986640;
	bh=PGYer/AZsQq7dBANWEnVl1vBk+nnLEZqb9/tkQwgSH8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=eY6O6+Jy7y6Uh4hfajd39ioxDNykGU1KMZwJnstOvlhSySa4gcsMjZLArm3h7l5db
	 RlSeBrLaT6PFI6vew4OzAETOzMbUJFady3eRb3jGkrAgUS8HXI2Hn286Py1uHxlhpc
	 C0veOsXAqrDEF2OEtfyy/Fg9rvLt7V91y9Vtbh7UMwzhmBAoYpKFxspU5QsRRKprFE
	 4/eJl5Gl3an2B8weiObKSDvdTKXXKuBZaF2sDWbpXKk6X2PkOtcFqksD94mYiloY14
	 0Wx7DSnOaQX1behO3oE3fpSkD3X69TEbNP5yS3XQsxgxnslWHVmXnxptAUGjfGrrBv
	 xsiqEkFSZAqcQ==
Date: Tue, 10 Oct 2023 18:10:39 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-net 1/2] selftests: mptcp: join: correctly check
 for no RST
In-Reply-To: <20231010-mptcp-remove-id-0-rst-v1-1-5ce17026f748@kernel.org>
Message-ID: <681b720f-35b5-e70b-cac5-e31342891865@kernel.org>
References: <20231010-mptcp-remove-id-0-rst-v1-0-5ce17026f748@kernel.org> <20231010-mptcp-remove-id-0-rst-v1-1-5ce17026f748@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 10 Oct 2023, Matthieu Baerts wrote:

> The commit mentioned below was more tolerant with the number of RST seen
> during a test because in some uncontrollable situations, multiple RST
> can be generated.
>
> But it was not taking into account the case where no RST are expected:
> this validation was then no longer reporting issues for the 0 RST case
> because it is not possible to have less than 0 RST in the counter. This
> patch fixes the issue by adding a specific condition.
>
> Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
> Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index ae38b428e42e..01480663c102 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1432,7 +1432,9 @@ chk_rst_nr()
> 	count=$(get_counter ${ns_tx} "MPTcpExtMPRstTx")
> 	if [ -z "$count" ]; then
> 		print_skip
> -	elif [ $count -lt $rst_tx ]; then
> +	# accept more rst than expected except if we don't expect any

That comment is tricky to say out loud :)

Patch 1 LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> +	elif { [ $rst_tx -ne 0 ] && [ $count -lt $rst_tx ]; } ||
> +	     { [ $rst_tx -eq 0 ] && [ $count -ne 0 ]; }; then
> 		fail_test "got $count MP_RST[s] TX expected $rst_tx"
> 	else
> 		print_ok
> @@ -1442,7 +1444,9 @@ chk_rst_nr()
> 	count=$(get_counter ${ns_rx} "MPTcpExtMPRstRx")
> 	if [ -z "$count" ]; then
> 		print_skip
> -	elif [ "$count" -lt "$rst_rx" ]; then
> +	# accept more rst than expected except if we don't expect any
> +	elif { [ $rst_rx -ne 0 ] && [ $count -lt $rst_rx ]; } ||
> +	     { [ $rst_rx -eq 0 ] && [ $count -ne 0 ]; }; then
> 		fail_test "got $count MP_RST[s] RX expected $rst_rx"
> 	else
> 		print_ok
>
> -- 
> 2.40.1
>
>
>
