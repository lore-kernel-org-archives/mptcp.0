Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4696C1BB37
	for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 18:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F34C433C8;
	Fri, 28 Jul 2023 18:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690568699;
	bh=F0cpj5eFahOn9ypg3aXKx/HpClVUIQLTE+rKq9Oo4Do=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=n+9h4U2ZONMRE4P833s1w495xwWVr6SHG2yeU+EDJaHZeyoWEbsvrHjagLjL0VYtZ
	 cAAC7ys4p+Ro8/dVx0R6NWrM18qtAT/b4naAGY2uElRwvWdRknVNPAOp/iVTqDcuZU
	 AnRIW/5rQUXvjqlA+8qdnoZOmMDTuj8YGbxEf3hfJfmrP6mjuwGP1v+jFc2L2z+QGQ
	 hS795srjc//VMkSngRR7ffzN0z066JIJObmsAYLko2xXRYabPcZhF9oL1oCWOJVCom
	 rs88XgHXCq65R4gSaIiyM00vQGShxFgPSZ9PImmdbz7mG3flBSDFC1kzliNR5Gh5M0
	 8VwplteLQk3cQ==
Date: Fri, 28 Jul 2023 11:24:59 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: pm_nl_ctl: always
 look for errors"
In-Reply-To: <20230728152845.1020528-1-matthieu.baerts@tessares.net>
Message-ID: <a473db82-70fa-7c50-478d-095b197f577c@kernel.org>
References: <20230728152845.1020528-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 28 Jul 2023, Matthieu Baerts wrote:

> mptcp_join.sh selftest tries to add a bad endpoint on purpose ("ID
> change is prevented") so it is normal to see this error:
>
>   114 implicit EP
>         creation                            [ ok ]
>         mptcp_info subflows=1:1             [ ok ]
>         mptcp_info add_addr=1:1             [ ok ]
>   netlink error -22 (Invalid argument)
>   ./pm_nl_ctl: bailing out due to netlink error[s]
>         ID change is prevented              [ ok ]
>         modif is allowed                    [ ok ]
>
> We can mute the output because we expect an error.
>
> We also need to edit the commit message to mention mptcp_join.sh
> selftest also need to be modified, not just pm_netlink.sh.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>
> Notes:
>    to be squashed in "selftests: mptcp: pm_nl_ctl: always look for errors"
>

Also fine with me to squash this one, thanks for tidying up the confusing 
output.

- Mat

> tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index d23004ddd0b5..ee1f89a872b3 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3454,7 +3454,7 @@ endpoint_tests()
> 		chk_mptcp_info subflows 1 subflows 1
> 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
>
> -		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
> +		pm_nl_add_endpoint $ns2 10.0.2.2 id 33 2>/dev/null
> 		pm_nl_check_endpoint "ID change is prevented" \
> 			$ns2 10.0.2.2 id 1 flags implicit
>
>
> base-commit: 7ba82a61fdc510b19dde7a394d08cd214e5e280a
> -- 
> 2.40.1
>
>
>
