Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDAC2B9BD
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951324; cv=none; b=Nz+C4mKVMjYj5HKJtdgk6y3QKLf2ec6EHhHQk88ls53RfnyJmEaLpAbeSvr+oPr3IKOID8mREyMkdaOl/I2G5YsAb5o/0lvCTK5BI99c7oArWhs3658hn2dqBazkOTE/dpFSZWZFeh2VpBPw8pPoWabkej2YjNO69So/o4X25V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951324; c=relaxed/simple;
	bh=tW1q7z+erREUYkj4oUsZ4YZQ/z2VCCgOgKOcw8AHmro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUSF+9FI8ZL1979VAM7ObCh5gTyQkVLOKXcJZyC0HdRXx9mLD5aAz2dlCiQ8hRGlfbzDBWVkshNHcrbAC3zjTZewBNiyIyRbkvcqqWmKsKDNbiXqlvJ//aK+tb5tyrL5Au/Ifaul5hhJbA49pqyOq36u6C7ruVgUWhADoPMmE8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORBrJGsy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORBrJGsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03D5C433F1;
	Mon, 26 Feb 2024 12:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708951324;
	bh=tW1q7z+erREUYkj4oUsZ4YZQ/z2VCCgOgKOcw8AHmro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ORBrJGsyiyie7+K3ARC4tQWeG7Mm5UOu9nwP/LlWJ4qUzsoZH83Say0U4jSolwq3M
	 ro/0F75n02LQpmS0Fwv20zrB0LyMcV76g0PPOhxIKMpZIP/lXk7KGk17XeoS0RRP70
	 /RLZ48q2bLwat8mrJsEFWTQRmNeSAYJjBDpwI2mUaxlV8BUuJ1N0swQ62CWY9QmdtH
	 8ONEPvKrYhJXU79SRRU4vhg2zKXKl8xqmJG5WXHbYr7x+mNlab1X+ftcOpzfekE/H0
	 tV0t6leG0lvcRXPrbi6M7NmFIEZzQ/kKdw9cRWp1lQQ96RQ8ranh9K3+z3KZ1iza8q
	 fpLN2tH0C7NIA==
Message-ID: <d0f1a146-d5e4-45f9-992b-82e3ed18f239@kernel.org>
Date: Mon, 26 Feb 2024 13:42:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v5 10/12] selftests: mptcp: export event macros
 in mptcp_lib
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
 <b8df72d8c39dd8760cc408fcf3c2ec21d76b6051.1708939962.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b8df72d8c39dd8760cc408fcf3c2ec21d76b6051.1708939962.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 26/02/2024 10:43, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> SUB_ESTABLISHED, LISTENER_CREATED, LISTENER_CLOSED, AF_INET and AF_INET6
> are defined in both mptcp_join.sh and userspace_pm.sh, export all event
> macros into mptcp_lib.sh. Add MPTCP_LIB_ prefix for the first three and
> add readonly for the last two.

Why not doing that (prefix + readonly) for both?

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index ed0013b47edb..5feb11801469 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -2,6 +2,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  # Some variables are used below but indirectly, see check_expected_one()
> +# MPTCP_LIB_ANNOUNCED and AF_INET

Better to "export" them then instead

>  #shellcheck disable=SC2034
>  
>  readonly KSFT_PASS=0
> @@ -11,6 +12,16 @@ readonly KSFT_SKIP=4
>  # shellcheck disable=SC2155 # declare and assign separately
>  readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
>  
> +MPTCP_LIB_ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
> +MPTCP_LIB_REMOVED=7          # MPTCP_EVENT_REMOVED
> +MPTCP_LIB_SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
> +MPTCP_LIB_SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
> +MPTCP_LIB_LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
> +MPTCP_LIB_LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED

Please use the "readonly" attribute, and align the "#".

Also, probably clearer to add '_EVENT', e.g.

  export MPTCP_LIB_EVENT_ANNOUNCED=6

> +
> +readonly AF_INET=2
> +readonly AF_INET6=10

Prefix with 'MPTCP_LIB_' + export?

> +
>  MPTCP_LIB_SUBTESTS=()
>  MPTCP_LIB_SUBTESTS_DUPLICATED=0
>  
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index 3f475ae44d0b..6d358b7e47e9 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -19,16 +19,6 @@ if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
>  fi
>  mptcp_lib_check_tools ip
>  
> -ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
> -REMOVED=7          # MPTCP_EVENT_REMOVED
> -SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
> -SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
> -LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
> -LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
> -
> -AF_INET=2
> -AF_INET6=10

Instead of modifying hundreds of lines, probably best to do:

  ANNOUNCED=${MPTCP_LIB_EVENT_ANNOUNCED}
  (...)

Same in mptcp_join.sh? (Maybe that's fine, there are just a few there)

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
