Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46F835F0C
	for <mptcp@lists.linux.dev>; Mon, 18 Mar 2024 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710764864; cv=none; b=eG73zh4fiepyzZKU9kQXOxQ9Is4utjVw4n/xn66NRbxGdQBvqi7/X7x09SS0y6no7wqErdFxAf/EjgdJd0rLtZC7xb/sEjXHQ1xJFrryKEVx4CmsSgP9pKvf+v9RpxYg8jYIYNP2KM16IsknX5+SuXvV3TL5rvW1eTmaCqbETJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710764864; c=relaxed/simple;
	bh=ESGX47m5F0Oizi9bHu0UFAH4JujW2q+Qn1MuZ8OPXvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fl05XookLOvsDLJESFOtCfcAkzBPoJm1TKGve9CSSTzd9awXh/yJipIj7d4wqACpnCCmWnvIc06bK4MC+Wy9njKK7p7k0VI6kS2cDgchm9E0VmR125jZCGBA3Y++xSmbn3So3rfPywRPD6PuZpCpG8xqyjPw0g7jhQcLS68ZPTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTmf5cb1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTmf5cb1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9041AC433F1;
	Mon, 18 Mar 2024 12:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710764864;
	bh=ESGX47m5F0Oizi9bHu0UFAH4JujW2q+Qn1MuZ8OPXvA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CTmf5cb1tjgacODWUQutaoDbEX0EEIP6Y4UsEK/yKSDuccsMDFeh8oIvUXPCjzjpz
	 Laky2youckyn/1yBAzcr+iNDvysQ1fg+Dm4bqj+sVtIwdt7wRlrs9dR2+MkJk2PkG0
	 9CSElsuKN0iIW7+niZawTZDVmgJfVw0eJO2IJ13SYbL7D6grBxuQzywhe1NmN2tkmo
	 EYAj3TjK9DqMHEyJURPpPbMxLhh+uFKZcCSmQhdujt1Tip/tiBeJHeCrywZchO0nKD
	 I+E4fNJsx7oX91VBrFPB+YC0wZmWWIFNgSUJBonMGvseMm+6DLMPygqQXhxb01yeKJ
	 gicLpqOzyyaWw==
Message-ID: <88757971-7727-4630-84a9-f79c41d33bb2@kernel.org>
Date: Mon, 18 Mar 2024 13:27:42 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 07/12] selftests: mptcp: add get_endpoint
 helper
Content-Language: en-US
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1710636726.git.tanggeliang@kylinos.cn>
 <c845f5894ba4cd21bfd9e74af2cb59a191dabbda.1710636726.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <c845f5894ba4cd21bfd9e74af2cb59a191dabbda.1710636726.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 17/03/2024 01:58, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> All endpoints are showed in show_endpoints(). This patch adds another
> helper named get_endpoint() to show a specofic endpoint identified by
> the given address ID.
> 
> Usage:
> 	All endpoints - show_endpoints $ns
> 	One endpoint - get_endpoint $ns $id
> 
> Use this new helper in mptcp_join.sh and pm_netlink.sh to replace all
> 'pm_nl_ctl get' commands.

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 92b89f3a7605..d83a67922b17 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -577,3 +577,14 @@ mptcp_lib_format_endpoints() {
>  		fi
>  	done
>  }
> +
> +mptcp_lib_pm_nl_get_endpoint() {
> +       local ns=${1}
> +       local id=${2}
> +
> +       if mptcp_lib_is_ip_mptcp; then
> +               ip -n "${ns}" mptcp endpoint show id "${id}"
> +       else
> +               ip netns exec "${ns}" ./pm_nl_ctl get "${id}"
> +       fi

Spaces are used here in this function, instead of tabs.

> +}
> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> index 95e393c95017..28c89b576d1f 100755
> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> @@ -78,7 +78,7 @@ fi
>  ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
>  ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
>  ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 flags signal,backup
> -check "ip netns exec $ns1 ./pm_nl_ctl get 1" \
> +check "mptcp_lib_pm_nl_get_endpoint ${ns1} 1" \
>  	"$(mptcp_lib_format_endpoints "1,10.0.1.1")" "simple add/get addr"

See my comment from patch 6/12, we could have:

  check "get_endpoint 1" "$(format_endpoints "1,10.0.1.1")" \
        "simple add/get addr"

(and squashed with patch 6/12?)

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

