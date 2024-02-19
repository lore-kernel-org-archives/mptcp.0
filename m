Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC3B2AD39
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345310; cv=none; b=irvyfV0zvCaoMq0BflC2Ae291Jb5boqOmthgZLKcYysXLakoARhS5hO9Zg4WoFGGhUOVd0f64jCH2ZBBJs1P6fFH1L+/+ms45ckWMJdsXmbbj1b0STAuWA0EyDsc1NV5z02Z+fuUdvBg1SOTy1j3stMJCv6ToC1eREg/Eqj1OkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345310; c=relaxed/simple;
	bh=m9eYGtX+kVsJChSlxjOWK5nYXTa0DodOb0q6iPE/IhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZgWME7RjRGHR/hF63ox1CCiPfFD6VIS+LKMQudwSLMtMtW81HEYxW7CiSeGBVE1tWj2AeLRNkDwhune83oMAiTifYl69m4PKtLOYplahk7K0+LVzKBBAAyf+4fUK1YZDvjxWM7nmZO8nkvTqi2TGU2O91J2ZZ4wDTr2pLSjksA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKsnrj5S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKsnrj5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C42C433C7;
	Mon, 19 Feb 2024 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708345310;
	bh=m9eYGtX+kVsJChSlxjOWK5nYXTa0DodOb0q6iPE/IhA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kKsnrj5SZEVxIF7yaanGsiqfhEb8fndPJFa03NTtg4u9+rXJE0Yy1L7Y4vFHY5hHV
	 S/sKevHgQ/urAqaCjiV8gjVnoKt+SkeNC/nXNCNEvQzxQ/z5ohf1AoDDLaw8KphedU
	 TFxv48tscrJMrSDSPtdjG/slLBssyUd58jXjQzBxBjMugA/vqnkSQhMYsHfDh6IwNr
	 RC4quoCpWi/owzcavdmFMeFc2YbDuxwZGI+qErmiw32l8iFH2BOYW5HqIADGM1PXTd
	 GOcaONirdzlhkJvL0HZesx/g+79KnpxrOQa2KPGjo1a7RkhMf52O938agubQqXD/Zx
	 NRPxQ2ObNIMig==
Message-ID: <3923dab2-84bb-49b8-b286-d8015a3ad67e@kernel.org>
Date: Mon, 19 Feb 2024 13:21:49 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 2/5] selftests: mptcp: add mptcp_lib_ns_*
 helpers
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708334850.git.tanggeliang@kylinos.cn>
 <b231398375e6569da10c36f931be69d161a5e31b.1708334850.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b231398375e6569da10c36f931be69d161a5e31b.1708334850.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 19/02/2024 10:29, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Add helpers mptcp_lib_ns_init() and mptcp_lib_ns_exit() in mptcp_lib.sh to
> init all namespaces ns1, ns2, ns3 and ns4. Then every test script can
> invoke these helpers and use all namespaces.

Good idea to move duplicated code to the _lib.sh file.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 6d9a2af85a8d..bfc535594675 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -350,3 +350,62 @@ mptcp_lib_check_tools() {
>  		esac
>  	done
>  }
> +
> +rndh=""

I guess you "export" it because it is needed for the captured files,
right? If yes, why not using the "${ns}" variables in a dedicated commit
before to ease this refactoring?

> +ns1=""
> +ns2=""
> +ns3=""
> +ns4=""

I really don't think it is a good idea to hide these variables: if you
open 'mptcp_connect.sh', it will be confusing not to see where these
variables have been declared. If you declare variables (or functions) in
the lib, they should be prefixed MPTCP_LIB_ (or mptcp_lib_ for the
functions) I think.

Instead, I think you should keep the ns* variables declared at the top
of each file, but call "mptcp_lib_ns_init" with the variables to
initiate, e.g.

  ns1=""
  ns2=""
  ns_disabled=""

  (...)

  mptcp_lib_ns_init ns1 ns2 ns_disabled

in mptcp_lib_ns_init(), you can do something like:

  (...)

  local ns_i
  for ns_i in "${@}"; do
      eval "${ns_i}=${ns_i}-${rndh}"

      ip netns add "${!ns_i}" || (...)

(so you can use the version with '!' in the for loop)

> +mptcp_lib_ns_init() {
> +	: "${rndh?}"
> +	: "${ns1?}"
> +	: "${ns2?}"
> +	: "${ns3?}"
> +	: "${ns4?}"
> +
> +	local nr="${1:-4}"
> +	local i=1
> +	local sec
> +
> +	sec=$(date +%s)
> +	rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
> +
> +	ns1="ns1-$rndh"
> +	ns2="ns2-$rndh"
> +	ns3="ns3-$rndh"
> +	ns4="ns4-$rndh"

In this mptcp_lib.sh, probably good to continue to use {} around
variables ('${rndh}' instead of '$rndh') like in the rest of the file:
clearer, and we avoid typos.

> +
> +	local netns
> +	for netns in "$ns1" "$ns2" "$ns3" "$ns4"; do
> +		if [ "$i" -gt "$nr" ]; then
> +			break
> +		fi

(see above)

> +		ip netns add "$netns" || exit ${KSFT_SKIP}
> +		ip -net "$netns" link set lo up
> +
> +		ip netns exec "$netns" sysctl -q net.ipv4.conf.all.rp_filter=0
> +		ip netns exec "$netns" sysctl -q net.ipv4.conf.default.rp_filter=0

Mmh, is it OK to do that for all netns? We were not doing that before
for diag.sh, but I suppose that's because it was not communicating with
other netns, right? So fine to do that everywhere?

That's a behaviour change. Please always clearly mention behaviour
changes in the commit message when you do such refactoring, where we
would expect no behaviour changes.

While at it, maybe we want to add:

  ip netns exec "${!ns_i}" sysctl -q net.mptcp.enabled=1

That should be the default value. If not, good to override. (I think it
is needed for some RHEL versions.) If yes, please add that in the commit
message as well.

> +		i=$((i + 1))
> +	done
> +}
> +
> +mptcp_lib_ns_exit() {
> +	: "${ns1:?}"
> +	: "${ns2:?}"
> +	: "${ns3:?}"
> +	: "${ns4:?}"
> +
> +	local nr="${1:-4}"
> +	local i=1
> +
> +	local netns
> +	for netns in "$ns1" "$ns2" "$ns3" "$ns4"; do
> +		if [ "$i" -gt "$nr" ]; then
> +			break
> +		fi

Same here, best to clearer to pass the variables names and accept a
variable number of parameters:


  mptcp_lib_ns_exit "${ns1}" "${ns2}"

  local ns_i
  for ns_i in "${@}"; do
      ip netns del "${ns_i}"

> +		ip netns del "$netns"
> +		rm -f /tmp/"$netns".{nstat,out}

Here, it is also a behaviour change. I guess that's fine, but still,
please mention that in the commit message.

> +		i=$((i + 1))
> +	done
> +}

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
