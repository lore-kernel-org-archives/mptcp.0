Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FD579CD
	for <mptcp@lists.linux.dev>; Sun, 30 Mar 2025 00:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743293705; cv=none; b=C8U8BdtP8HZd6EsB07aSmkbUFR7dhJ2P8QZ6/f//M/GlngfLb8daMJSl7Z47606uIWt4svYmnYEIGifgMf6t8Ydg8gdY5Zghcy2PSEk7r/kcm5EIlmjlPbBU6fJt5ccVgVsM1oXM7hPaiWjlzB+y2+m1j/rIgz96Bw9iry+j5Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743293705; c=relaxed/simple;
	bh=dGSE6GFnlZWJrQ9xtvi/aBI/MLYcz+9IdpIdXj9yzAM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g04dSgHf8vMuFVQP1FHtNE4fIaH9Nhur29+zh675iKa0gqbSs4dlQCD0e3Z1IKcx62yuNv6rYtcibzleNmXdRQsJIsd/amqTyI+QuIAVEue4FOzoyDlzOSIds/EWbSVykIaQnh2DP2iQyngVGIKUUrszGd4+w4sYgN7Z8M3tLSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cojNBNCq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cojNBNCq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5051FC4CEE2;
	Sun, 30 Mar 2025 00:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743293705;
	bh=dGSE6GFnlZWJrQ9xtvi/aBI/MLYcz+9IdpIdXj9yzAM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=cojNBNCqeMwUl+XmXLmfNlBoz7IpZTdhKV9V7uu/TTkk2erdz/tPQq5uEfXZZB5aC
	 CBKt4frFihsSgwlp4kh1peZrpDGZX40o6tcGPRGN3lZ7B7Yd040b+SOpXWuhyMgfP0
	 PTYMAifIAe6cyoDi8D/Us3zhq7ljovS9rxOuIGWnwxiZU3mPmbKurr+Ub1kbJOgNip
	 AGWSxATKlPcxz07Urc3rtJPAdNGDIkojKjkdygZrp6eRTH7YauqqoXRMANa78J3y4/
	 rLdwJe2EyGT7lziURrIKhC0V60rW+w1hSc+yi/yP3plRLb9BrlHtHtT6s3VLbIlcoI
	 9WWlJTYoBW6fg==
Message-ID: <36791aea3d151d35234f88c57b8205abcc1cca69.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 2/5] selftests: mptcp: validate MPJoin
 HMacFailure counters
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Sun, 30 Mar 2025 08:15:01 +0800
In-Reply-To: <20250329-mptcp-mpj-reject-v1-2-2396d5666e8f@kernel.org>
References: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
	 <20250329-mptcp-mpj-reject-v1-2-2396d5666e8f@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi Matt,

Thanks for this patch.

On Sat, 2025-03-29 at 17:26 +0100, Matthieu Baerts (NGI0) wrote:
> The parent commit fixes an issue around these counters where one of
> them
> -- MPJoinAckHMacFailure -- was wrongly incremented in some cases.
> 
> This makes sure the counter is always 0. It should be incremented
> only
> in case of corruption, or a wrong implementation, which should not be
> the case in these selftests.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Note: this can go to mptcp-net as well, with the parent patch.
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 18
> ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index
> 13a3b68181ee14eb628a858e5738094c3c936b74..5060b7e24f94550246c2b1f0465
> dcaf42b869313 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1441,6 +1441,15 @@ chk_join_nr()
>  		fi
>  	fi
>  
> +	count=$(mptcp_lib_get_counter ${ns2}
> "MPTcpExtMPJoinSynAckHMacFailure")
> +	if [ -z "$count" ]; then
> +		rc=${KSFT_SKIP}
> +	elif [ "$count" != "0" ]; then
> +		rc=${KSFT_FAIL}
> +		print_check "ack HMAC"

Should here be "synack HMAC"...

> +		fail_test "got $count JOIN[s] synack HMAC failure
> expected 0"
> +	fi
> +
>  	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckRx")
>  	if [ -z "$count" ]; then
>  		rc=${KSFT_SKIP}
> @@ -1450,6 +1459,15 @@ chk_join_nr()
>  		fail_test "got $count JOIN[s] ack rx expected
> $ack_nr"
>  	fi
>  
> +	count=$(mptcp_lib_get_counter ${ns1}
> "MPTcpExtMPJoinAckHMacFailure")
> +	if [ -z "$count" ]; then
> +		rc=${KSFT_SKIP}
> +	elif [ "$count" != "0" ]; then
> +		rc=${KSFT_FAIL}
> +		print_check "synack HMAC"

... and here be "ack HMAC"?

Thanks,
-Geliang

> +		fail_test "got $count JOIN[s] ack HMAC failure
> expected 0"
> +	fi
> +
>  	print_results "join Rx" ${rc}
>  
>  	join_syn_tx="${join_syn_tx:-${syn_nr}}" \
> 

