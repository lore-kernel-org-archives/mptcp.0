Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC0A20B0E
	for <mptcp@lists.linux.dev>; Wed, 27 Mar 2024 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506521; cv=none; b=SwlMmrzNhD215lm+ioN1I8ibWRRI6J6t70hEhN/zmp4nhYrawPgidz9JMygjYtVBmyhU6JZtIFTmS+HDjr8iep1v80ldsWvory/T0WzbnFdUA5jLUDhtGT4KiRIgl6h5JkhBRgsZn2IuX4Wn04MZrsNnmHgUWbsRzMGDVTYvMoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506521; c=relaxed/simple;
	bh=kgw28FXBAsnit9xbrsqN9J6YDVUhMumvZQoQjnPRdTM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l+4Jkb0OHG4MWi+dXa4S/RDch+2GcsUKECAZddkI1GWyFtQg7ZYZtQcdxpHr9+Irp8FTJ6nXKIIs5vqgA6ur7Y2Jwh9lZXdRt63D6oVq5FXJJGoq7rT+kjFFN5xOvfM2fFSEPwyKfSflpQFaV6pfnVF4wTO85uqoWqormjvJSfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smt4Esge; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smt4Esge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D2FC433F1;
	Wed, 27 Mar 2024 02:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711506520;
	bh=kgw28FXBAsnit9xbrsqN9J6YDVUhMumvZQoQjnPRdTM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=smt4EsgefCA+VAJbr++B7TvuojMMDV728vOT4d9noiCjGCptsrAWdhgzDGdu/H6eC
	 qH7vVP3hJ+t94ZZZw4tV4GocSNYD7nyedeoI3NQeAoWEEVOhjxZ0p4pF7mpTBjVa9V
	 EDn9cqpxTbi7INJAdBnV6cb0jUzVQ+LgXSk1kytFVoOdUOwK6YimGDtnGpO/vuQC7r
	 1AeugxdWERkWOfjdnZBCHd4sLYyetrcpirfR8qlwwqkdg78gC19zr6FMi+wDk3EvCC
	 MVEx3KSxd4PJxzNigON1uaCp9+5CW8nIKFWmuU/q2uiyNtaZ7huYjglL3cXN7WnDRJ
	 4/T5dgwJvM0pg==
Date: Tue, 26 Mar 2024 19:28:40 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 3/3] selftests: mptcp: add last time actions
 tests
In-Reply-To: <031f4529f5e9daf33e4818b48693e1b0eb25814d.1710748923.git.tanggeliang@kylinos.cn>
Message-ID: <53b36c3c-371a-9514-e082-51063bbf2e90@kernel.org>
References: <cover.1710748923.git.tanggeliang@kylinos.cn> <031f4529f5e9daf33e4818b48693e1b0eb25814d.1710748923.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 18 Mar 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> This patch adds a new helper show_mptcp_info() to show the counters in
> mptcp_info of the given infos. Use it to show newly added last_data_sent,
> last_data_recv and last_ack_recv in mptcp_info in endpoint_tests().
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 21 +++++++++++++++++++
> 1 file changed, 21 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 70621cbbab09..6a6caf472d68 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

Hi Geliang -

diag.sh would be a better location for new mptcp_info tests. Could check 
that the timestamps move forward when data is sent or received, that would 
verify functionality more than the informational messages below.

Thanks,

Mat


> @@ -1855,6 +1855,25 @@ chk_subflows_total()
> 	fi
> }
>
> +show_mptcp_info()
> +{
> +	local info
> +
> +	for info in "${@}"; do
> +		local cnt1
> +		local cnt2
> +
> +		cnt1=$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value "$info" "$info")
> +		cnt2=$(ss -N $ns2 -inmHM | mptcp_lib_get_info_value "$info" "$info")
> +		print_check "mptcp_info ${info:0:15}=$cnt1:$cnt2"
> +		if [ -z "$cnt1" ] || [ -z "$cnt2" ]; then
> +			print_skip
> +		else
> +			print_ok
> +		fi
> +	done
> +}
> +
> chk_link_usage()
> {
> 	local ns=$1
> @@ -3589,6 +3608,7 @@ endpoint_tests()
> 			$ns2 10.0.2.2 id 1 flags implicit
> 		chk_mptcp_info subflows 1 subflows 1
> 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
> +		show_mptcp_info last_data_sent last_data_recv last_ack_recv
>
> 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33 2>/dev/null
> 		pm_nl_check_endpoint "ID change is prevented" \
> @@ -3612,6 +3632,7 @@ endpoint_tests()
> 		wait_mpj $ns2
> 		chk_subflow_nr "before delete" 2
> 		chk_mptcp_info subflows 1 subflows 1
> +		show_mptcp_info last_data_sent last_data_recv last_ack_recv
>
> 		pm_nl_del_endpoint $ns2 2 10.0.2.2
> 		sleep 0.5
> -- 
> 2.40.1
>
>
>
