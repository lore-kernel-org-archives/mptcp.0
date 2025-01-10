Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8F4257D
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497019; cv=none; b=FNhgFOEvrwBIHVli8rTeAjx+ZgqHGnwfVt3r36XwNwE2GH+YrPLX0x2pATQTGnQ8XF1NG04/Tl6o1ndFMuIqYdHcprlGMEg4sXjJZXwI47vWelAFcm7/dfP2kHV6Gjn0h8JsRxxiug/AwyLM6nN3TKLlgpiM4FFiC+mhYiOjyBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497019; c=relaxed/simple;
	bh=8KFkLP+uSj6xJsQHDCjOrCbGH0aNXMHZw/BRcpcQvpM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gNPsYFw4JD3BoT5HvJqEauClCnNPuivpJO+7Y1anT6y3DnTAzVz6rGaMOWt5qpM5ZrsRcSP9Qjri1Q2DfKHAzAtgYpQHfHSqUjhOUMYj2Kks6gYkGOLluU1A4pgW85jHKzDEb32xOv5m6WB391fZTdaoXHm5+bL4IGSFpwCcIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aP7zL4PG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aP7zL4PG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02796C4CED6;
	Fri, 10 Jan 2025 08:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736497018;
	bh=8KFkLP+uSj6xJsQHDCjOrCbGH0aNXMHZw/BRcpcQvpM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=aP7zL4PGrQS1MeRstPvGarsGkWSiPf2H8b/tCZP1OYeE6IpCHEA7Xxnl2A439Z4Mo
	 pCBMoqvD6O4GDN58Yxs4gvakN2PvO2roQj/UZ4Hw/1ZJYUfKU2t3q6bG0bvl5AvPQv
	 zmQ/UcdvghRKysTumrNqtzoOY1kJrK+s0oXgDztOcIoqxsIgePMKx0t8HGPK43o1ch
	 kKtbc0/EXDZPhCdlgqJ8HAPCOiUoyw7xINTyVmua13W4AtVS67UZgsGudgUWWzCUa6
	 32h0RjMxSRYB/6TBRmPvoffZNEpybVVRQEfJpyHjOxnKA/Gt7pEiS7R8U/p/fk1wHX
	 tiMGJRfW/aISw==
Message-ID: <e94e771e8993b4b40e151959fccb7716a8d29a86.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/5] selftests: mptcp: simult_flows: unify
 errors msgs
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Fri, 10 Jan 2025 16:16:54 +0800
In-Reply-To: <20250108-slft-mptcp-conn-misc-impr-v1-1-bdfbdba48a1f@kernel.org>
References:
	 	<20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
		 <20250108-slft-mptcp-conn-misc-impr-v1-1-bdfbdba48a1f@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Wed, 2025-01-08 at 19:40 +0100, Matthieu Baerts (NGI0) wrote:
> In order to unify what is printed in case of error, similar to what
> is
> done in mptcp_connect.sh and mptcp_join.sh, it is interesting to do
> the
> following modifications in simult_flows.sh:
> 
> - Print the rc errors at the end of the line.
> 
> - Print the MIB counters.
> 
> - Use the same ss options: add -M (MPTCP sockets) and -e (detailed
>   socket information).
> 
> While at it, also print of the 'max' time only in case of success,
> because 'mptcp_connect.c' will already print this info in case of
> error,
> e.g.:
> 
>   transfer slower than expected! runtime 11948 ms, expected 11921 ms
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/simult_flows.sh | 21
> ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh
> b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index
> 8fa77c8e9b651171a34c89bfd5c9ded0288a5bde..e98e5907d52c2d0e9c0152efda8
> 2176861905cf1 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -155,6 +155,11 @@ do_transfer()
>   sleep 1
>   fi
>  
> + NSTAT_HISTORY=/tmp/${ns3}.nstat ip netns exec ${ns3} \
> + nstat -n
> + NSTAT_HISTORY=/tmp/${ns1}.nstat ip netns exec ${ns1} \
> + nstat -n
> +
>   timeout ${timeout_test} \
>   ip netns exec ${ns3} \
>   ./mptcp_connect -jt ${timeout_poll} -l -p $port -T $max_time \
> @@ -180,25 +185,31 @@ do_transfer()
>   kill ${cappid_connector}
>   fi
>  
> + NSTAT_HISTORY=/tmp/${ns3}.nstat ip netns exec ${ns3} \
> + nstat | grep Tcp > /tmp/${ns3}.out
> + NSTAT_HISTORY=/tmp/${ns1}.nstat ip netns exec ${ns1} \
> + nstat | grep Tcp > /tmp/${ns1}.out

Here I got "nstat: history is aged out, resetting" warnings, and I
don't know how to fix it:

Selftest Test: ./simult_flows.sh
TAP version 13
1..1
[    1.022664] ip (155) used greatest stack depth: 12280 bytes left
[    1.316990] netem: version 1.3
# 01 balanced bwidth                                            
7401nstat: history is aged out, resetting
# nstat: history is aged out, resetting
#  max 7906       [ OK ]
# 02 balanced bwidth - reverse direction                         7394
max 7906       [ OK ]

> +
>   cmp $sin $cout > /dev/null 2>&1
>   local cmps=$?
>   cmp $cin $sout > /dev/null 2>&1
>   local cmpc=$?
>  
> - printf "%-16s" " max $max_time "
>   if [ $retc -eq 0 ] && [ $rets -eq 0 ] && \
>      [ $cmpc -eq 0 ] && [ $cmps -eq 0 ]; then
> + printf "%-16s" " max $max_time "
>   mptcp_lib_pr_ok
>   cat "$capout"
>   return 0
>   fi
>  
> - mptcp_lib_pr_fail
> - echo "client exit code $retc, server $rets" 1>&2
> + mptcp_lib_pr_fail "client exit code $retc, server $rets"
>   echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
> - ip netns exec ${ns3} ss -nita 1>&2 -o "sport = :$port"
> + ip netns exec ${ns3} ss -Menita 1>&2 -o "sport = :$port"
> + cat /tmp/${ns3}.out
>   echo -e "\nnetns ${ns1} socket stat for $port:" 1>&2
> - ip netns exec ${ns1} ss -nita 1>&2 -o "dport = :$port"
> + ip netns exec ${ns1} ss -Menita 1>&2 -o "dport = :$port"
> + cat /tmp/${ns1}.out
>   ls -l $sin $cout
>   ls -l $cin $sout
>  
> 

