Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B6F35677E
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128452; cv=none; b=lBvO/PxYnobWbCRLxNWxv8wCvcbFX61o+BS7NlvIhqBebnxCFczBdpF7TFAJnFm1Gl7dCN2WAYtRSrxaFs6W+ezVHhVA1u6fJMDLyMZ68lf3RA7+yZv9epWjsqSp1Fg20M8218Ib6rPZ/IWKuVTNAucE1v1KO0OuLAje5kHezA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128452; c=relaxed/simple;
	bh=UZ1p2BkL/L+xrrfYraE6aHU7gcQeEb1jpJpjuDf7LWM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ORdj1UUvV54rb2S344naj9XcKO83YDAm1R0ilF61OBzD/RaAqOSu+TNp2SqD/YDKWB1phexohwF0vJEpzjnA0X3wbhMLZMLAkEpBZi1xRvFMmETXIvhqc5SAM2vfutQOCd/V0iBOm3enxfrLyAe2APcs7urvVGvrcwq+yWEnzUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xq2Ic780; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xq2Ic780"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95211F000E9;
	Wed, 19 Aug 2026 08:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787128451;
	bh=0q9C+8B4GGBNWT+q6f3qejPzWirHdb80tW0SERlQ5NY=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Xq2Ic780hIQnBE7GukarKpAhqKnMK9dGXfSphpzYEkhbPhDvqVv7HdwCf5uOps8MQ
	 VoVZkPbZdh4MT40eCOkU8y8pX3Bt4s3Kb0yNNv3325dG+V9PL3mm5mmUgG44SVKCUB
	 okhuryUhQ6fTXEsYoW5mMHk+X5/vgSqrK6X2fyu9weyuI2WXcMH7at+By9xw9awm9z
	 iSSUXBghddywehsFKBbtrjdqMLdRjz0EvCVVQJHsM7IGrBK0G89A9EbKmXKK5ACz0A
	 HWOCN5iGVKVFxzGCRMFF1FOT32kBuVtBTjWXZkWJ86NnWm0A2yBoxnniBX8BE2jL0G
	 xL6BC38KhkvIA==
Message-ID: <001a333947659c88e41d9fc7847ce35778ea821c.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 2/2] selftests: mptcp: lib: get counters for
 the right test
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Wed, 19 Aug 2026 16:34:08 +0800
In-Reply-To: <20260813-sft-mptcp-nstat-hist-v1-2-5bb96bae7ef6@kernel.org>
References: <20260813-sft-mptcp-nstat-hist-v1-0-5bb96bae7ef6@kernel.org>
	 <20260813-sft-mptcp-nstat-hist-v1-2-5bb96bae7ef6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2026-08-13 at 12:29 +0200, Matthieu Baerts (NGI0) wrote:
> When the value for a MIB counter is required, mptcp_lib_get_counter
> is
> called. It tries to use the cache, if available. If not it falls back
> to
> calling 'nstat' directly by looking at the absolute counters.
> 
> That's an issue for tests that don't recreate the netns for each
> subtest. In this case, 'nstat -a' will look at the counters for the
> netns.
> 
> Instead, it should look at the increment for the current test, by
> using
> the history recorded in /tmp/<ns>.nstat, if available, and not using
> '-a' which was dumping the absolute values.
> 
> While at it, rename the previous 'hist' variable to 'cache' as it was
> used to look at the cache, not the nstat history.
> 
> Fixes: 71388a9f331d ("selftests: mptcp: lib: get counters from nstat
> history")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index da1da414c30f..b9d14647f401 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -416,19 +416,21 @@ mptcp_lib_nstat_get() {
>  }
>  
>  # $1: ns, $2: MIB counter
> -# Get the counter from the history (mptcp_lib_nstat_{init,get}()) if
> available.
> -# If not, get the counter from nstat ignoring any history.
> +# Get the counter from the cache (mptcp_lib_nstat_{init,get}()) if
> available.
> +# If not, get the counter from nstat ignoring any cache, but using
> the history.
>  mptcp_lib_get_counter() {
>  	local ns="${1}"
>  	local counter="${2}"
> -	local hist="/tmp/${ns}.out"
> +	local cache="/tmp/${ns}.out"
> +	local hist="/tmp/${ns}.nstat"
>  	local count
>  
> -	if [[ -s "${hist}" && "${counter}" == *"Tcp"* ]]; then
> -		count=$(awk "/^${counter} / {print \$2; exit}"
> "${hist}")
> +	if [[ -s "${cache}" && "${counter}" == *"Tcp"* ]]; then
> +		count=$(awk "/^${counter} / {print \$2; exit}"
> "${cache}")
>  	else
> -		count=$(ip netns exec "${ns}" nstat -asz
> "${counter}" |
> -			awk 'NR==1 {next} {print $2}')
> +		count=$(NSTAT_HISTORY="${hist}" ip netns exec
> "${ns}" \
> +			nstat -sz "${counter}" |
> +				awk 'NR==1 {next} {print $2}')
>  	fi
>  	if [ -z "${count}" ]; then
>  		mptcp_lib_fail_if_expected_feature "${counter}
> counter"

I noticed that the code being modified in mptcp_lib_pr_nstat and
mptcp_lib_get_counter is duplicated. I'm wondering if we could remove
this redundancy - for example, by creating a new helper for this logic.

# $1: ns ; $@: nstat arguments
# If cache exists, return it; otherwise run nstat.
mptcp_lib_nstat_cmd() {
    local ns="${1}"
    local cache="/tmp/${ns}.out"
    local hist="/tmp/${ns}.nstat"

    if [ -s "${cache}" ]; then
        cat "${cache}"
    else
        NSTAT_HISTORY="${hist}" ip netns exec "${ns}" nstat -sz "${@}"
    fi
}

Then mptcp_lib_pr_nstat can be simplified to:

mptcp_lib_pr_nstat() {
    local ns="${1}"

    mptcp_lib_nstat_cmd "${ns}" |
            awk '/Tcp/ { print "  "$0 }'
}

And mptcp_lib_get_counter can be simplified to:

mptcp_lib_get_counter() {
    local ns="${1}"
    local counter="${2}"
    local count

    count=$(mptcp_lib_nstat_cmd "${ns}" "${counter}" |
            awk -v c="${counter}" '$1 == c {print $2; exit}')
    if [ -z "${count}" ]; then
        mptcp_lib_fail_if_expected_feature "${counter} counter"
        return 1
    fi

    echo "${count}"
}

What do you think - would this work?

Thanks,
-Geliang
