Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE202D593E
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130162; cv=none; b=T4Dn/IQhW2axH8if+Z6l/Gv1PlVJDg+Hrhvv81MbA8lX5Y35+LOCidopPgnP/5qf2jeInBGUMdN67kXf3fTCMIlithkrDJQRJJh6rWlJ5wgYaeg1ts2leptQwHXe2cCZLcdRRcmrIkoX1UUaHl/PK9R4gHn7Fz38TmVXSffgn1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130162; c=relaxed/simple;
	bh=cmA4Ftfdgn00A0PV1Pj9m8lM7l4i8na4kYeGuN0fAGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hVCm5uaiPZrRN92mb/VkgENMMYApFbxA0wMUwi662GTNTi8e+xloYBL521ruziau/KDbQ+zH6sIzh3dnTghKLPhTpFInzL9WugoiEr8/wK8U72DjojMQt/tKIalNj7kCYqCLdRpTLfgXJvndaF9OwYBXWz9HTp0E9R6fG7vePVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1MCjf+s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1MCjf+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4151F00A3D;
	Wed, 19 Aug 2026 09:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787130160;
	bh=tRY9lGH+1vLIBTjgCnLPSoWYKBuVno5RN9uKP3pESBs=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=B1MCjf+sqMaSlM+6eJIO2XrQsVIQovc5ZF1Z3j2/Dim0MyU882CXantNYW4O0+mZk
	 GFeUhAo6vn1T8q8nEsCuo0133iHWnkxMqQWPtfEdtG1PoOUvzax26ng/cpODVHy4y0
	 z3XVrILcO7bubwpdhjw1Noncz8Z+vDX5BnpLjOMbnRrvSg7h6ElB1DDLBRDxXyySld
	 0uL9B51X+FEBc41wuOIcB8rN/QZ4UTnWp6L9t8IBwwNAYV68cjnWLwqKCwVWU2Ylnp
	 ColIJukbXXIRhSLU55+nyUEVcAKb9ps7eIx3tTiU2CvgSTOQmErUeXmIhuTW+Lbml6
	 x4WkP4LFkHEUA==
Message-ID: <3e2f5944-2c0f-4bee-ac18-16835b19c4e2@kernel.org>
Date: Wed, 19 Aug 2026 11:02:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 2/2] selftests: mptcp: lib: get counters for the
 right test
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
References: <20260813-sft-mptcp-nstat-hist-v1-0-5bb96bae7ef6@kernel.org>
 <20260813-sft-mptcp-nstat-hist-v1-2-5bb96bae7ef6@kernel.org>
 <001a333947659c88e41d9fc7847ce35778ea821c.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <001a333947659c88e41d9fc7847ce35778ea821c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 19/08/2026 10:34, Geliang Tang wrote:
> Hi Matt,
> 
> On Thu, 2026-08-13 at 12:29 +0200, Matthieu Baerts (NGI0) wrote:
>> When the value for a MIB counter is required, mptcp_lib_get_counter
>> is
>> called. It tries to use the cache, if available. If not it falls back
>> to
>> calling 'nstat' directly by looking at the absolute counters.
>>
>> That's an issue for tests that don't recreate the netns for each
>> subtest. In this case, 'nstat -a' will look at the counters for the
>> netns.
>>
>> Instead, it should look at the increment for the current test, by
>> using
>> the history recorded in /tmp/<ns>.nstat, if available, and not using
>> '-a' which was dumping the absolute values.
>>
>> While at it, rename the previous 'hist' variable to 'cache' as it was
>> used to look at the cache, not the nstat history.
>>
>> Fixes: 71388a9f331d ("selftests: mptcp: lib: get counters from nstat
>> history")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_lib.sh | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> index da1da414c30f..b9d14647f401 100644
>> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> @@ -416,19 +416,21 @@ mptcp_lib_nstat_get() {
>>  }
>>  
>>  # $1: ns, $2: MIB counter
>> -# Get the counter from the history (mptcp_lib_nstat_{init,get}()) if
>> available.
>> -# If not, get the counter from nstat ignoring any history.
>> +# Get the counter from the cache (mptcp_lib_nstat_{init,get}()) if
>> available.
>> +# If not, get the counter from nstat ignoring any cache, but using
>> the history.
>>  mptcp_lib_get_counter() {
>>  	local ns="${1}"
>>  	local counter="${2}"
>> -	local hist="/tmp/${ns}.out"
>> +	local cache="/tmp/${ns}.out"
>> +	local hist="/tmp/${ns}.nstat"
>>  	local count
>>  
>> -	if [[ -s "${hist}" && "${counter}" == *"Tcp"* ]]; then
>> -		count=$(awk "/^${counter} / {print \$2; exit}"
>> "${hist}")
>> +	if [[ -s "${cache}" && "${counter}" == *"Tcp"* ]]; then
>> +		count=$(awk "/^${counter} / {print \$2; exit}"
>> "${cache}")
>>  	else
>> -		count=$(ip netns exec "${ns}" nstat -asz
>> "${counter}" |
>> -			awk 'NR==1 {next} {print $2}')
>> +		count=$(NSTAT_HISTORY="${hist}" ip netns exec
>> "${ns}" \
>> +			nstat -sz "${counter}" |
>> +				awk 'NR==1 {next} {print $2}')
>>  	fi
>>  	if [ -z "${count}" ]; then
>>  		mptcp_lib_fail_if_expected_feature "${counter}
>> counter"
> 
> I noticed that the code being modified in mptcp_lib_pr_nstat and
> mptcp_lib_get_counter is duplicated. I'm wondering if we could remove
> this redundancy - for example, by creating a new helper for this logic.

Thank you for the review and suggestion.

> # $1: ns ; $@: nstat arguments
> # If cache exists, return it; otherwise run nstat.
> mptcp_lib_nstat_cmd() {
>     local ns="${1}"
>     local cache="/tmp/${ns}.out"
>     local hist="/tmp/${ns}.nstat"
> 
>     if [ -s "${cache}" ]; then
>         cat "${cache}"
>     else
>         NSTAT_HISTORY="${hist}" ip netns exec "${ns}" nstat -sz "${@}"
>     fi
> }
> 
> Then mptcp_lib_pr_nstat can be simplified to:
> 
> mptcp_lib_pr_nstat() {
>     local ns="${1}"
> 
>     mptcp_lib_nstat_cmd "${ns}" |
>             awk '/Tcp/ { print "  "$0 }'
> }
> 
> And mptcp_lib_get_counter can be simplified to:
> 
> mptcp_lib_get_counter() {
>     local ns="${1}"
>     local counter="${2}"
>     local count
> 
>     count=$(mptcp_lib_nstat_cmd "${ns}" "${counter}" |
>             awk -v c="${counter}" '$1 == c {print $2; exit}')

The cache cannot be used to check non-Tcp counters because it only
contains *Tcp* counters. Then that makes this code adding extra
conditions, and I'm not sure the new helper is worth it. WDYT?

Maybe it could be added if other modifications are needed around these
helpers, but here, I wouldn't do that in a series targeting -net.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

