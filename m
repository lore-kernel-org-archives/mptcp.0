Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD43F18FC80
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505342; cv=none; b=QJtgH44tJZhMVFEWFiu9bmyZzeEABu1dKpz8a7HPnAeFWfEuTijsXbXRkHhirepldYX6AHURugkVJLi2ez5D3XEtWxZVeWY5ti21gU1X4Cuu2d9RmKwdyftReCQbK3lHGEkVEYTVEWS7YoD+1CPKJ+e03p08ryk25aJBO2zKrN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505342; c=relaxed/simple;
	bh=fZ8j15ApyrlcTVr7yedIUdWCnme8P5ekiS5dINLCYm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dvlwzt2QrCdnx8Ko1eR8+Qq7N4UYeB/Vjh+uyC39z+TBUIUmXwSyAYdCcvleGuqD01m8PZMNRlK9ajKuYuPAqrqa8BqO0Ki3VHF5I6UlRCTdh3o94u8FJLWK9l2nz4xcd8+3o8jevwBY6r5aLq80oxo+QI/5n9CRBef4C+8FWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdMmNnSm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdMmNnSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC9DC4CED6;
	Fri, 10 Jan 2025 10:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736505342;
	bh=fZ8j15ApyrlcTVr7yedIUdWCnme8P5ekiS5dINLCYm4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=JdMmNnSmAXL/4OoiHB74/LnxK4N7TvBqdeepms74hBBexQO5G135r647c1PMf6O/n
	 Gfi5r0sLD1NOlJPhdKTbGo3Y6oF459KYh+RT7cTiqH1ecwkNnHyuS96UFj/G7FCip3
	 p4JCeuyS+zJeeYPdiBtwQ9PS8xbedEBAuGz0v+gWTHmK/gXIrOBukIqB7RUAdhyTtG
	 GO/5TbZwK9hgJxMhFieOHvAg5KzisMmrlVIqk2uwxbAFfqIKVchh0FXJuWs3Ws4gdk
	 VSoFFES72xSmQY6pkZgIIvX0p25k+6T6eksaJqRPNrfqrLq3XWwnrzrKHUxqZej8OJ
	 npCeCv+S8OpXg==
Message-ID: <8c360ded-d7a4-4149-aa70-854292655073@kernel.org>
Date: Fri, 10 Jan 2025 11:35:39 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/5] selftests: mptcp: simult_flows: unify
 errors msgs
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
 <20250108-slft-mptcp-conn-misc-impr-v1-1-bdfbdba48a1f@kernel.org>
 <e94e771e8993b4b40e151959fccb7716a8d29a86.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e94e771e8993b4b40e151959fccb7716a8d29a86.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 10/01/2025 09:16, Geliang Tang wrote:
> Hi Matt,
> 
> On Wed, 2025-01-08 at 19:40 +0100, Matthieu Baerts (NGI0) wrote:
>> In order to unify what is printed in case of error, similar to what
>> is
>> done in mptcp_connect.sh and mptcp_join.sh, it is interesting to do
>> the
>> following modifications in simult_flows.sh:
>>
>> - Print the rc errors at the end of the line.
>>
>> - Print the MIB counters.
>>
>> - Use the same ss options: add -M (MPTCP sockets) and -e (detailed
>>   socket information).
>>
>> While at it, also print of the 'max' time only in case of success,
>> because 'mptcp_connect.c' will already print this info in case of
>> error,
>> e.g.:
>>
>>   transfer slower than expected! runtime 11948 ms, expected 11921 ms
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/net/mptcp/simult_flows.sh | 21
>> ++++++++++++++++-----
>>  1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh
>> b/tools/testing/selftests/net/mptcp/simult_flows.sh
>> index
>> 8fa77c8e9b651171a34c89bfd5c9ded0288a5bde..e98e5907d52c2d0e9c0152efda8
>> 2176861905cf1 100755
>> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
>> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
>> @@ -155,6 +155,11 @@ do_transfer()
>>   sleep 1
>>   fi
>>  
>> + NSTAT_HISTORY=/tmp/${ns3}.nstat ip netns exec ${ns3} \
>> + nstat -n
>> + NSTAT_HISTORY=/tmp/${ns1}.nstat ip netns exec ${ns1} \
>> + nstat -n
>> +
>>   timeout ${timeout_test} \
>>   ip netns exec ${ns3} \
>>   ./mptcp_connect -jt ${timeout_poll} -l -p $port -T $max_time \
>> @@ -180,25 +185,31 @@ do_transfer()
>>   kill ${cappid_connector}
>>   fi
>>  
>> + NSTAT_HISTORY=/tmp/${ns3}.nstat ip netns exec ${ns3} \
>> + nstat | grep Tcp > /tmp/${ns3}.out
>> + NSTAT_HISTORY=/tmp/${ns1}.nstat ip netns exec ${ns1} \
>> + nstat | grep Tcp > /tmp/${ns1}.out
> 
> Here I got "nstat: history is aged out, resetting" warnings, and I
> don't know how to fix it:
> 
> Selftest Test: ./simult_flows.sh
> TAP version 13
> 1..1
> [    1.022664] ip (155) used greatest stack depth: 12280 bytes left
> [    1.316990] netem: version 1.3
> # 01 balanced bwidth                                            
> 7401nstat: history is aged out, resetting
> # nstat: history is aged out, resetting
> #  max 7906       [ OK ]
> # 02 balanced bwidth - reverse direction                         7394
> max 7906       [ OK ]

Interesting: I already saw this message on NIPA, but I could not
reproduce it on my side.

Could you eventually try to find out what it is? Maybe the stats from
files in /tmp are wrong inside your VM?

The code of nstat is in the iproute2 repo:

https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/tree/misc/nstat.c#n691

  if (!ignore_history) {
      FILE *tfp;
      long uptime = -1;

      if ((tfp = fopen("/proc/uptime", "r")) != NULL) {
          if (fscanf(tfp, "%ld", &uptime) != 1)
              uptime = -1;
          fclose(tfp);
      }
      if (uptime >= 0 && time(NULL) >= stb.st_mtime+uptime) {
          fprintf(stderr, "nstat: history is aged out, resetting\n");
          if (ftruncate(fileno(hist_fp), 0) < 0)
              perror("nstat: ftruncate");
      }
  }

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

