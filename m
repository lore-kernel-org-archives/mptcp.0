Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F412A20EB
	for <mptcp@lists.linux.dev>; Fri, 22 Aug 2025 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755824692; cv=none; b=Sx5xaiw3LJSvNtGOPONpq+BPZpfbLff4S238VS8518Su//0qwhMcAVGFTzLIlrhAWi0JsDHZGfJ0igW5s8UgW3R0eBc1Y5RtaVCTO+KcyNnYbrQn9kj1+zkIRI4UuEYWc7Ql9Nwqu2qOXQHNG/2sh+mrl5uZtmJ2KwR2vYnYWtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755824692; c=relaxed/simple;
	bh=gHd/wSUWdt8ehHl6nzTyd6xf1ZckuW7ljm2srabTdmg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iUc2VDupwmUOL0kd+VHl6FPsRdqHtFywzjvKLqWaebl8u2bstW9xrGqS29p1CAPludBWQbozk/YOOa8urxnxvO+ivA66e20E/W/nGkzDnE+S9prgg2rzEWsgqGG3JI71rB+7W9mCq/IuWcCshZ/HlznNDmUN6kO7EB/TPS5g558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lospt6fz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lospt6fz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694D8C4CEEB;
	Fri, 22 Aug 2025 01:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755824691;
	bh=gHd/wSUWdt8ehHl6nzTyd6xf1ZckuW7ljm2srabTdmg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Lospt6fzKGdEB/ETkxbul2Wc4Bu0kDaXBNfvG0LGBiG0p+S71KF9JAN5pGVBEz4Bz
	 wS5+VuuhB5k0OBnL0DEEZIWoQaMLsV/GsI3rdrTgdfn+JAqKzeGLx2Qxr4sNUpIZJ/
	 DuewpNBo+u6asVXHBLct8YnG5Ony35QXPozsOKzGlntFsmYyCzDBKVAF1ARcYTGsHw
	 lw+jUT81KRLw3tyiqclNB2gIbeOsC4wSROCXhot3EMfT4hGCtYJnlcB3l7Oj9wQeyh
	 dD0pQ2MsMm4mZu2ftPX6e0N3KCiADtz1TE02SsU73Nv12/wLhTrmNqG7YhgCl95FhQ
	 4q+2ISQbyerxQ==
Date: Thu, 21 Aug 2025 18:04:50 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 3/3] selftests: mptcp: print trailing bytes
 with hexdump
In-Reply-To: <20250819-sft-mptcp-disc-err-v1-3-9d0cf296bc13@kernel.org>
Message-ID: <63cac2fd-a90f-e165-c0b3-85584e81ef37@kernel.org>
References: <20250819-sft-mptcp-disc-err-v1-0-9d0cf296bc13@kernel.org> <20250819-sft-mptcp-disc-err-v1-3-9d0cf296bc13@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 19 Aug 2025, Matthieu Baerts (NGI0) wrote:

> If hexdump or busybox hexdump is available.
>
> This is better than printing random bytes in the terminal.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> tools/testing/selftests/net/mptcp/mptcp_lib.sh | 12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 09cd24b2ae466205dacbdf8289eb86c08534c475..20ce95c9d35538a03c1c3cac843657d258fc9715 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -382,9 +382,19 @@ mptcp_lib_make_file() {
>
> # $1: file
> mptcp_lib_print_file_err() {
> +	local end
> +
> 	ls -l "${1}" 1>&2
> 	echo "Trailing bytes are: "
> -	tail -c 27 "${1}"
> +	end=$(tail -c 32 "${1}")
> +	if command -v hexdump >/dev/null; then

Hi Matthieu -

How about:

tail -c 32 "${1}" | od -t x1

'od' is in the posix spec so it should be on more systems than hexdump 
(it's in coreutils along with 'tail', for example). Also, today I learned 
that 'od' can format hexadecimal...


> +		echo "${end}" | hexdump -C | head -n2
> +	elif busybox hexdump --help 2>/dev/null; then
> +		echo "${end}" | busybox hexdump -C | head -n2
> +	else
> +		echo "${end}"

Would be best to avoid fallback to raw binary (hence the 'od' suggestion 
above).

- Mat


> +		echo
> +	fi
> }
>
> # $1: input file ; $2: output file ; $3: what kind of file
>
> -- 
> 2.50.0
>
>
>
