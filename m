Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823263501
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207898; cv=none; b=rgbS2IakcS1Y7q/SbTZ8nkb0PwYCPByjFa1RgDxiAXbz24VppltlZUeDnjkb1pBxZ3Q1ZZ/XopwMbUiVfi94EFYcChKAId7dJjuMAYJUgNrB8EghNMHKX5IVV2zgalfzTZ2arDHPpGOgGnN5nQK3zqm+vMgnvnQsUuYtUf+tT2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207898; c=relaxed/simple;
	bh=gOFSEXlsysWTqI8/5O1ww8dmUVgaC2tluhOdXeAY97I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngAw2umwglDaY8HNRKQV4cwYC0HCTXD5Zn1MRD+Hxtyc3451Wd1rnapm370ofG6xKTCzCu8DflYq+sig9ISFA3FAGypjqlTyYNFv6pK1hJWd1RVcskraWbn3FqOyl5Soj97pg6dwx03btP+fbrdXUr8C88LaS4ZUIwG9tXKlD3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEQkX1qM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEQkX1qM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F86C433F1;
	Thu, 29 Feb 2024 11:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709207898;
	bh=gOFSEXlsysWTqI8/5O1ww8dmUVgaC2tluhOdXeAY97I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CEQkX1qMJlyIB2av2GON90H85hr2CxKg/yabt/5+JNKrXANgv/YH/7+ML2dSIDBdg
	 09o2G14y6KO4Z2F8qOwXocIFgoPhGtCWtgI25RsEx6RVukbKN/wmTKH/EUOWPvqiFC
	 XGgLIi4oDKB2Lo1FJslVs/znID2AuW5hxTMnAV3bFESTFek9zbiMZFnXb8OwCVcsAr
	 4drlBURYTwNTaUd0yFcNWTJ3sirQLO+F2dmrYcZn+xUp/8r89zcn8Fy83y18wV+sl2
	 yFA9YaoYsA4NipJT83uhn93XJgAYHcjL2/XXwHQ96ADa3BENEOQhh6EqPhDyqistFQ
	 aVhzp0qHJK98Q==
Message-ID: <fea0084f-665b-4ea2-96cd-f9c025c02a28@kernel.org>
Date: Thu, 29 Feb 2024 12:58:15 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v7 6/8] selftests: mptcp: add test counter
 helpers
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
 <9a31a17605edb4546467a172d8619eff3f15a002.1709200070.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <9a31a17605edb4546467a172d8619eff3f15a002.1709200070.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 29/02/2024 10:51, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds two vars in mptcp_lib.sh, MPTCP_LIB_TEST_COUNTER for
> the test counter and MPTCP_LIB_TEST_FORMAT for the test print format.
> Also add two helpers, mptcp_lib_inc_test_counter(), increase the test
> counter, and mptcp_lib_pr_title_counter(), print the test title with
> counter. They are used in mptcp_join.sh first.

Please add the reason, something like: Each MPTCP selftest is having
subtests, and it helps to give them a number to quickly identify them.
This can be managed by mptcp_lib.sh, reusing what has been done here.
The following commit will use these new helpers in the other tests.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 ++++++++--------
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 17 +++++++++++++++++
>  2 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 1df2d24979a0..7acc6064eb17 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -48,7 +48,6 @@ declare -A all_tests
>  declare -a only_tests_ids
>  declare -a only_tests_names
>  declare -A failed_tests
> -TEST_COUNT=0
>  TEST_NAME=""
>  nr_blank=6
>  
> @@ -172,7 +171,8 @@ cleanup()
>  
>  print_title()
>  {
> -	printf "%03u %s\n" "${TEST_COUNT}" "${TEST_NAME}"
> +	MPTCP_LIB_TEST_FORMAT="%03u %s\n"

No need to re-set it all the time, this line can be moved just before
"sourcing" mptcp_lib.sh I think, with a comment like:

  # Here, we have more than 100 tests, having multiple checks
  MPTCP_LIB_TEST_FORMAT="%03u %s\n"

  . "$(dirname "${0}")/mptcp_lib.sh"

> +	mptcp_lib_pr_title_counter "${TEST_NAME}"
>  }
>  
>  print_check()

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 763a2989ca6d..cbf0dd2cc4cb 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -411,3 +411,20 @@ mptcp_lib_events() {
>  	ip netns exec "${ns}" ./pm_nl_ctl events >> "${evts}" 2>&1 &
>  	pid=$!
>  }
> +
> +MPTCP_LIB_TEST_COUNTER=0
> +MPTCP_LIB_TEST_FORMAT=""

Can you declare them at the top, around the other ones?
(MPTCP_LIB_SUBTESTS, etc.)

And I think you should set the default value there too, like what I was
suggesting in patch 07/12 from v5:

  : "${MPTCP_LIB_TEST_FORMAT:="%02u %-50s"}"
  MPTCP_LIB_TEST_COUNTER=0

So we can change the format by setting MPTCP_LIB_TEST_FORMAT before
"sourcing" mptcp_lib.sh.

No?

*If* we need to alter the format just for one title, we can always do:

  MPTCP_LIB_TEST_FORMAT="..." \
      mptcp_lib_pr_title_counter "<title>"

But best to avoid that.

> +
> +mptcp_lib_inc_test_counter() {
> +	: "${MPTCP_LIB_TEST_COUNTER:?}"

I don't think that's needed, it has been defined in the file, no?

> +
> +	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
> +}
> +
> +#shellcheck disable=SC2059

Please always justify why you need to ignore a rule.

Also, always try to reduce the scope as much as possible: just for one
line, for one function, for the whole file → here, move it just before
calling 'printf':

  # shellcheck disable=SC2059 # the format is in a variable
  printf "${MPTCP_LIB_TEST_FORMAT}" (...)

(and add a space after '#')

> +mptcp_lib_pr_title_counter() {
> +	: "${MPTCP_LIB_TEST_COUNTER:?}"
> +	: "${MPTCP_LIB_TEST_FORMAT:="%02u %-50s"}"
> +
> +	printf "${MPTCP_LIB_TEST_FORMAT}" "${MPTCP_LIB_TEST_COUNTER}" "${*}"

I didn't check: can you not print the title and increment the counter
(via mptcp_lib_inc_test_counter) from here? I think that would be a good
practice to do that instead of having to deal with the counter in
different places.

We would only call "mptcp_lib_inc_test_counter()" from other scripts
when a test is skipped.

> +}

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
