Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CFB315D37
	for <mptcp@lists.linux.dev>; Fri,  5 Sep 2025 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757115594; cv=none; b=FhhDs9vYiIsHlX68NEuYrL9Z8hT4DjoONOnPxISuowmFW6QcenDREsO7ocpcKm0068lMVs4ES3uogLmjeL/hdD+ffbUxMiWoWOQYAHpJn6PwgeGQmso8cO51cooD9LWn0iFxFXnZA8G/qZT0WY7RQEcUgqi9ifBpg+ImHoK2Ifg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757115594; c=relaxed/simple;
	bh=TbeWnRfJCSR6+ylR88WRtM8ouszJaNM9hQDPTu1tAZU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r1wTmKFRkcXWHz1DxIL2lFnPG9ojcrBsz6Jwk93+pGmwa2V26fVfqGCge1nYSd7SGtjAl9Kby47g/Fk+lz/ZaGdO50qgl/1y4hHT+5xSGiqU2Mds8wlgU4MFfuSnm1Z9v+n/PuS/JhStOOnXIjE0UpwhtXfArL7gXWoH/vjEfH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz3JiUBW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz3JiUBW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D349DC4CEF1;
	Fri,  5 Sep 2025 23:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757115593;
	bh=TbeWnRfJCSR6+ylR88WRtM8ouszJaNM9hQDPTu1tAZU=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=hz3JiUBWGN8uYTuprSeYQgxtQnzfiVH9c1jg2jMirOKrC0Pvk60q8NsAapeAFo3W6
	 cB3gKYYuV82F33KpeMADtrg51VAzuaLqfPOwwIhJ5CvazlanuDzt1jQRBtDfkqfBPk
	 rDLiTHHCrJ5O8gHpbUViqc5mBLxuglhKWIJXuWdJG3Q8kTrrC9ckvI/NyOmZgc/q1h
	 TS7EMBd2J3w8GJE1Cz4J7ONoxKWLied+adfK3CuXIAEICUL5JdUM/5UDkYKFqgq1ks
	 2bhP5bqv8KmWpy0QuEaEw43pnA1IFzPRN7jQoK8WOL+a/FBLAqDcqgv9RPORgloR8L
	 nI3CqVQVjJH+A==
Message-ID: <5ee562f1700818c635d79828b057a94943527e80.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 5/5] selftests: mptcp: connect: print pcap
 suffix
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Sat, 06 Sep 2025 07:39:50 +0800
In-Reply-To: <20250905-sft-mptcp-disc-err-v2-5-dfb3b6b4a877@kernel.org>
References: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
	 <20250905-sft-mptcp-disc-err-v2-5-dfb3b6b4a877@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this v2.

On Fri, 2025-09-05 at 20:18 +0200, Matthieu Baerts (NGI0) wrote:
> To be able to find which capture files have been produced after
> several
> runs.
> 
> This suffix was not printed anywhere before.
> 
> While at it, always use the same prefix by taking info from ns1,
> instead
> of "$connector_ns", which is sometimes ns1, sometimes ns2 in the
> subtests.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 +++++-

Just wondering, is it necessary to synchronize this modification to
mptcp_join.sh to maintain consistency?

-Geliang

>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index
> 5e3c56253274a1f938d2ed9986c4290fcea8b96b..19e2bd3000ec8be470a34d503ec
> 034404e798fec 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -211,6 +211,11 @@ if $checksum; then
>  	done
>  fi
>  
> +if $capture; then
> +	rndh="${ns1:4}"
> +	mptcp_lib_pr_info "Packet capture files will have this
> prefix: ${rndh}-"
> +fi
> +
>  set_ethtool_flags() {
>  	local ns="$1"
>  	local dev="$2"
> @@ -361,7 +366,6 @@ do_transfer()
>  
>  	if $capture; then
>  		local capuser
> -		local rndh="${connector_ns:4}"
>  		if [ -z $SUDO_USER ] ; then
>  			capuser=""
>  		else
