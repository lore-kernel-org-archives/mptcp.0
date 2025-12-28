Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04D018AE3
	for <mptcp@lists.linux.dev>; Sun, 28 Dec 2025 02:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766888733; cv=none; b=q1vMzKetJPfL7goO/Ioz6wpjYqpnDt//vTkpsyyQZ28Lo8qEX0dpUGh9hKSDnJEy+CuIGmy+W9kgYgKetEl0QEc7oU4/lHrJnVwN3tQ9VtyY2n3a5GO7TKjyneYUdtTzwDrEOGp55v3z7Lf76L8V9dTfwYqKLZ/oL8LcJlnTJgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766888733; c=relaxed/simple;
	bh=hRHS5jnzhh5H85KH9wlfX2O1V9Y1E9WGqLvoIlvPjSc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QhYX7Bkv+N/NlHmsV/7T3DvQr3v8R4sGVLqKPe/ftuibHGZwl3dJn0q/ehBsGWbK5v+/u520A+wV1m1ez/ZoyihuvzifH5MHpzTBsnYKp3UbEGv3K7vPJ9s0cOD6AZQ2UGROGvp+3Ka56bNUycs5do4oUGLHZESj6Fi10iMHHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xrq/9tXP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xrq/9tXP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF4FC4CEF1;
	Sun, 28 Dec 2025 02:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766888732;
	bh=hRHS5jnzhh5H85KH9wlfX2O1V9Y1E9WGqLvoIlvPjSc=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Xrq/9tXPL6ZzpnLFK0/9D3g2QF7UMt/gohuzi7GqLTjrhK/ZpioItfRg05iYXVeU5
	 jNAk8Mz0dyt4yefXlBuVH3ib7iEeppokXsF2CiOlq2Kf6qDqL+Cxqj0F0AUJHH5GkQ
	 0KbympVcZWJ0rJg884pIfAoNdIzYmNy8d/b3ls8YNsDGNb7w0p3a4YvuO/u14u23xy
	 0R2rFkIvbHKsmIJeHdczwAlwHmR+hxNnzdVxfStMHoQSjMXPWzMrbuIpYNhSxMOt7f
	 l/EFz6WP968KVPCnvZ7MzdioO8O7qmD3asmZPpWnzzMcp9khKR3jAfaDDE012EZ5uW
	 5x6FyO2qijs7A==
Message-ID: <f7bd1668def5a8062f7deef87b88a7444e037587.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 08/11] selftests: mptcp: join chk_stale_nr:
 avoid dup stats
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Sun, 28 Dec 2025 10:25:29 +0800
In-Reply-To: <20251226-mptcp-issue-603-v1-8-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
	 <20251226-mptcp-issue-603-v1-8-bb30e331b839@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this patch.

On Fri, 2025-12-26 at 07:40 +0100, Matthieu Baerts (NGI0) wrote:
> nstat outputs are already printed when calling 'fail_test', no need
> to
> do it again.
> 
> While at it, no need to use the dump_stats variable, print the extra
> stats directly. And use 'ip -n $ns' instead of 'ip netns exec $ns',
> shorter and clearer.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 63a84a4d43a6..80e03168b419 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1648,7 +1648,6 @@ chk_stale_nr()
>  	local stale_min=$2
>  	local stale_max=$3
>  	local stale_delta=$4
> -	local dump_stats
>  	local stale_nr
>  	local recover_nr
>  
> @@ -1664,16 +1663,11 @@ chk_stale_nr()
>  		fail_test "got $stale_nr stale[s] $recover_nr
> recover[s], " \
>  		     " expected stale in range
> [$stale_min..$stale_max]," \
>  		     " stale-recover delta $stale_delta"
> -		dump_stats=1
> +		echo $ns stats
> +		ip -n $ns -s link show
>  	else
>  		print_ok
>  	fi
> -
> -	if [ "${dump_stats}" = 1 ]; then
> -		echo $ns stats
> -		ip netns exec $ns ip -s link show
> -		ip netns exec $ns nstat -as | grep MPTcp

mptcp_lib_pr_nstat() is called in fail_test(), it's slightly different
from the above line:

        ip netns exec "${ns}" nstat -as | grep Tcp

So, is it necessary for us to keep the above line?

Thanks,
-Geliang

> -	fi
>  }
>  
>  chk_add_nr()
