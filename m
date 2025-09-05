Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C20283FF5
	for <mptcp@lists.linux.dev>; Fri,  5 Sep 2025 23:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757115772; cv=none; b=cRhxJ+pbnxHmUf+SUgArV/d0RJHNAgl2QYmTSdcFG8MYlAnDYev0gSOcqEtY4/ACJXMS+Ir4yWEyl4rfzh2/49J0hqqM3SMsTZWj0T1MSaKt7bhpPXHJgqynvIiqcm2Rmjtbv+ljl4A9ogeUk1o+VhzPwiArsqt7ClPcsAmoMi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757115772; c=relaxed/simple;
	bh=4pegDz6mA+HSowRpao6lmvY23H6o4Q6EaOnalmDKvXE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lj8jYGna8CJsE+pIp4kUjUzTMbd/oXid/Bb+5GC0ResXyRSBUDyMyuo/vlGpC461j767PiSKW75IcCKPZ2mFk0xjZ1xK/aeTX3g7ivyItqBp1FAQ24Zcm7KttWNuyy2T0zZSJddqqVy78e77c87S2mUu8HT5gBX5vt6nOEMD8BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNSTmUcS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNSTmUcS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8555CC4CEF1;
	Fri,  5 Sep 2025 23:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757115772;
	bh=4pegDz6mA+HSowRpao6lmvY23H6o4Q6EaOnalmDKvXE=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=WNSTmUcSRKnkPPledAbFDhWG48N0Ocj0oM56YDgxPaYrbN6PTjArNDxPQjfoJzOeh
	 dixhwjq2MrVNl8/3QbiLJTSWGvpCY5uopQkTyFP0/G/ls021VzqkXvXD+MOE/aN3Eu
	 V9XgCz1dUko/urckJrhU6TwSQyPwz1FrukSdelwzJ4z7aOuvFO0jHKxiFlpkG7/1HI
	 N0P9bJUg//4kj/OUCfz/XQMfk2yv4ne60Of0aye6vUEGFKQQrMtCGA3QTim2qFvuwf
	 OblfmQyAw9sTl6j43Aq7kUqoVMagZNbSlNPm41icxV6CcL7ivBJKkR520GCSZRYqRu
	 fqkbqZ/fkWSRA==
Message-ID: <0ebf9d7a70ebc16b66b6c609606b28791a145d04.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 4/5] selftests: mptcp: print trailing bytes
 with od
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Sat, 06 Sep 2025 07:42:49 +0800
In-Reply-To: <20250905-sft-mptcp-disc-err-v2-4-dfb3b6b4a877@kernel.org>
References: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
	 <20250905-sft-mptcp-disc-err-v2-4-dfb3b6b4a877@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2025-09-05 at 20:18 +0200, Matthieu Baerts (NGI0) wrote:
> This is better than printing random bytes in the terminal.
> 
> Note Jakub suggested 'hexdump', but Mat found out that this tool is
> not
> often installed by default. 'od' can do a similar job, and it is in
> the
> POSIX specs and available in coreutils, so it should be on more
> systems.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v2: switch to 'od', and no more check for its presence (Mat)
> ---
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index
> 09cd24b2ae466205dacbdf8289eb86c08534c475..d62e653d48b0f2ef7a01e289fa0
> be8907825667d 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -384,7 +384,7 @@ mptcp_lib_make_file() {
>  mptcp_lib_print_file_err() {
>  	ls -l "${1}" 1>&2
>  	echo "Trailing bytes are: "
> -	tail -c 27 "${1}"
> +	tail -c 32 "${1}" | od -x | head -n2

nit:

It shows more bytes (32) here, but it wasn't mentioned in the commit
log.

Thanks,
-Geliang

>  }
>  
>  # $1: input file ; $2: output file ; $3: what kind of file
