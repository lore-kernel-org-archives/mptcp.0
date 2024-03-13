Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0AD60B87
	for <mptcp@lists.linux.dev>; Wed, 13 Mar 2024 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355754; cv=none; b=huQzq5Re+tG7g22zYqgqENiJ2ZJ7FRekrCfVddsAR/iavRqFUSx5aj4xBsFvtCjqQU5OrS1ZtbcOkzrXU8gPLlfKAI1wQyEe81sCZFaDIhyiykHn1Wl+fVn6j6wivrSZU1tgHCLo3HJFxrquNG3iJfce6+L/6YOa53grtTJ5lLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355754; c=relaxed/simple;
	bh=DpJHJ4aGI52sgPoSr/Db7ZYWZjRvBQp4a6NPe6jXWvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/+ntmBWX8ouSHi4PNfObqtJLBaTvWTx69Lm862lTXg0hyoJ8DtoRVAwK3IbDeEFRg8PpFHXGbeQPxfgNiXR3scOkKmjQ4wfc78WkhHw5vva/+083a+RwNd7llkAUYKS0hU7x1m92CVV6mrNxEwlXXnMFNPthyk9g+U2mcOliFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+EFCisT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+EFCisT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AB1C433C7;
	Wed, 13 Mar 2024 18:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710355754;
	bh=DpJHJ4aGI52sgPoSr/Db7ZYWZjRvBQp4a6NPe6jXWvk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I+EFCisTjm2cGt5lbpDPmoHXqdTG8Zmy/NeJjmKXD6/Zwbhpkg8aQGrD0XGbZErxN
	 btzhgFAq3K7p6tekGRhyQkgk0NDXkC4M1EilCL/eQHD/00M8on7JR6wWED8TZx27tI
	 muYhWMMgkJ8/W8Ay6+LBdjUDamKqNMmU5PcYyfVmyCE2CipBnlqbpst07zmqIB8hCC
	 pgOGhcMDQriHJZOFenZhjaBDCar0HjrKLnJ/Sld02bNayaxSq6tOmigRf4aelFtoYK
	 YENJRcY7zcSnaZ/+7bQipN7YWioXe1oHe8V1OPzLL4/d4KJCChuH3vtvaj9AevntVg
	 RiO2rR00tvPVA==
Message-ID: <9a81819c-7f3d-4fbb-9505-f678d81fc63b@kernel.org>
Date: Wed, 13 Mar 2024 19:49:10 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 06/10] selftests: mptcp: netlink: add outputs
 for ip_mptcp
Content-Language: en-US
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1710121590.git.tanggeliang@kylinos.cn>
 <c8bc708a1b492fcbbd370b55983e8575de9baec8.1710121590.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <c8bc708a1b492fcbbd370b55983e8575de9baec8.1710121590.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 11/03/2024 02:48, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The outputs of 'ip mptcp' are different from that of 'pm_nl_ctl'. This
> patch adds corresponding outputs of 'ip mptcp' together with 'pm_nl_ctl'.
> Use mptcp_lib_is_ip_mptcp() helper to test whether ip_mptcp is set. If
> it it, use 'ip mptcp' format outputs for check().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/pm_netlink.sh | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> index 00949f73153a..2096c52b3a4b 100755
> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> @@ -72,6 +72,7 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
>  default_limits="$(ip netns exec $ns1 ./pm_nl_ctl limits)"
>  if mptcp_lib_expect_all_features; then
>  	limits=$'accept 0\nsubflows 2'
> +	mptcp_lib_is_ip_mptcp && limits="add_addr_accepted 0 subflows 2 "

Do you think new helpers could be added to avoid all these
mptcp_lib_is_ip_mptcp in the test description? e.g.

  get_limits() {
      local accept="${1}"
      local subflows="${2}"

      if mptcp_lib_is_ip_mptcp; then
          # with a space at the end
          printf "add_addr_accepted %d subflows %d \n" \
                 "${accept}" "${subflows} "
      else
          printf "accept %d\nsubflows %d\n" "${accept}" "${subflows}"
      fi
  }

  (...)

  limits="$(get_limits 0 2)"

That's clearer when you check what the test is doing.


Same idea for the dumps/endpoints below, we could have:

  # format: <id>,<ip>,<flags>,<dev>
  get_endpoints() {
      local entry id ip flags dev

      for entry in "${@}"; do
          IFS=, read -r id ip flags dev <<< "${entry}"
          if mptcp_lib_is_ip_mptcp; then
              echo -n "${ip} id ${id}"
              [ -n "${flags}" ] && echo -n " ${flags}"
              [ -n "${dev}" ] && echo -n " dev ${dev}"
              echo " " # always a space at the end
          else
              echo -n "id ${id} flags ${flags//" "/","}"
              [ -n "${dev}" ] && echo -n " dev ${dev}"
              echo "${ip}"
          fi
      done
  }

  (...)
  endpoint="$(get_endpoints "1,10.0.1.1")
  (...)
  dump="$(get_endpoints "1,10.0.1.1" "2,10.0.1.2,subflow backup,lo")"

WDYT?

>  	check "ip netns exec $ns1 ./pm_nl_ctl limits" "${limits}" "defaults limits"
>  fi
(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

