Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27E1DDDD
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757529948; cv=none; b=Jeh4syuUihJRgu/k1/rXsLG4I0YD0qXhAJBchPKVNfRx/EKJWgEpOaPDvtSGc9uKNNieAOWqsDX+HN5clz/FLLLCDw1f/hE5SoYi2jb0NQDVEDZnn+QJILmEpZi8r9mUhDjabb1F0Gyabp8ZkVKC7CQ3wtFNFZJs5pnVTiu26uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757529948; c=relaxed/simple;
	bh=YBLZU/tluiWd69sbYuhRnP9ta4A/ZMuMXdgjv+RbN+s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rZNMRG5EkGKGmSilvbT0FGLFxT7u8uTWBxHhINk+9v49Mw9wmYvRWcc6YPi2glv5JZs47cBCAF5kNwx9vxHF9uriYzzQCx6V4Rtr6hvVocuWDtbxHz86WNnJZW9MzTarJ6X6hcmJwLJVhiTTl9BJhFF6nHOibyYMK7poqjDa8uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkUFTwYo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkUFTwYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70319C4CEEB;
	Wed, 10 Sep 2025 18:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757529947;
	bh=YBLZU/tluiWd69sbYuhRnP9ta4A/ZMuMXdgjv+RbN+s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=QkUFTwYo0b2b+3fQ3HI7YN6Sj1o01TV4D1EpPISwNyYrAwqn8iMC4gbNtlENnWF6d
	 aNuocXT9VJUBFoocF8xyHfLlP6TMHW2BWcdRB+wCSxrPqeAXkXJ75533ZUKNppP1MH
	 ++b1xkpMvZILtMIS0E6rif0VHn0IWsD0csUFXQ82nnJkEbZwWtd/nAGW1eYU37ZSIG
	 xuZo6zfaj0/LLMsIqX4KUPmmkjzyUgZouxipcTQ2GnNAalj7mB9JShDm8k/r38CNQB
	 SRcHTKaBCZgVV917/lBxVFOcM+WytjUGV/TzAAl5JHu1yo++A1TGwiQ116L4AXbzP/
	 98sKciVRIoqvw==
Date: Wed, 10 Sep 2025 11:45:46 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net v3 5/5] selftests: mptcp: connect: print pcap
 suffix
In-Reply-To: <20250910-sft-mptcp-disc-err-v3-5-6799fa467d77@kernel.org>
Message-ID: <84941759-e288-3ab6-220e-f455a9f5ecf4@kernel.org>
References: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org> <20250910-sft-mptcp-disc-err-v3-5-6799fa467d77@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 10 Sep 2025, Matthieu Baerts (NGI0) wrote:

> To be able to find which capture files have been produced after several
> runs.
>
> This suffix was not printed anywhere before.
>

One quick change before upstreaming: s/suffix/prefix/

Otherwise LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> While at it, always use the same prefix by taking info from ns1, instead
> of "$connector_ns", which is sometimes ns1, sometimes ns2 in the
> subtests.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index c2ab9f7f0d2133559bb18ce884b613d21d1ec5f0..47ecb5b3836eb5c64787bda0f6f1cc7c3af338aa 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -211,6 +211,11 @@ if $checksum; then
> 	done
> fi
>
> +if $capture; then
> +	rndh="${ns1:4}"
> +	mptcp_lib_pr_info "Packet capture files will have this prefix: ${rndh}-"
> +fi
> +
> set_ethtool_flags() {
> 	local ns="$1"
> 	local dev="$2"
> @@ -361,7 +366,6 @@ do_transfer()
>
> 	if $capture; then
> 		local capuser
> -		local rndh="${connector_ns:4}"
> 		if [ -z $SUDO_USER ] ; then
> 			capuser=""
> 		else
>
> -- 
> 2.51.0
>
>
>
