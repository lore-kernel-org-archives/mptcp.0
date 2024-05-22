Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E34CA50
	for <mptcp@lists.linux.dev>; Wed, 22 May 2024 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716337636; cv=none; b=pZFYjWAP0TK9iyP4pJ1wuqCBfDuHnjhmmvixDel0y396IFhBqSI2sPka+Dxo45h25F2XjwFH3IJR6fjvIBnbRGTq0W8tmM7juyoeDPy8wCm7TygJWqioQQkZGJFbcB8zPMXmamOlKMFqy6Qo4W7TpG+nnguqFlnUtSOFfSvAdOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716337636; c=relaxed/simple;
	bh=KGVS/Yg60Sf5z72VV6dBdf/8qxTU5L8R6nLzV2YUnyY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p//CbCRcU2PwElka5tK0I9DnqK++Sa4R8OEyZPbDnOJ+7sLsQcME9IiWyl3Bd93NXRy31+oLtR4Jh431MFXHFOYQU5Ji8ImbOioXTIX9/PiAhLjdqVDWoAUla7ZNj1hgrT2OdFZnTs/w67sVFXtHStaw24glbtePGy+rsBNECDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXbULbwN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXbULbwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC32DC2BD11;
	Wed, 22 May 2024 00:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716337636;
	bh=KGVS/Yg60Sf5z72VV6dBdf/8qxTU5L8R6nLzV2YUnyY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=QXbULbwNnAkHCSSDWVtXll7lU9GNXLEJiqIA6JfOQx+gHpFtMS+WVyjgueZ56w1jR
	 QiA4vwLJ88Q15tDeii24XuDgRVqnDUyHEYayXnjvEZjCza6Rwpsoy8oLFOlvgUxTBH
	 +Poh1HocKBT2/Fs77r8oa4fBnf7UPuQzT9i/AEnLSE4SOAAUWYKvkSI/Zjpfe/0ges
	 mGOB2y6TRpR+9LKevOG/fOhLyZ96OyrO3I0FAVue4RLYXAp2M3CJ+wJbpuQjeilh56
	 quI4S1CheIx7gtAoR97iS8pI10CI1sVwlpS/tl8devZLqNCJ8sae8ACMuJMyGKmCr+
	 C6wEfWaOo8Reg==
Date: Tue, 21 May 2024 17:27:15 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 1/4] selftests: mptcp: lib: support flaky
 subtests
In-Reply-To: <20240521-selftests-mptcp-disable-flaky-v2-1-eba143bcbad0@kernel.org>
Message-ID: <3a5062b1-98aa-77fe-a3ee-331456de7388@kernel.org>
References: <20240521-selftests-mptcp-disable-flaky-v2-0-eba143bcbad0@kernel.org> <20240521-selftests-mptcp-disable-flaky-v2-1-eba143bcbad0@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 21 May 2024, Matthieu Baerts (NGI0) wrote:

> Some subtests can be unstable, failing once every X runs. Fixing them
> can take time: there could be an issue in the kernel or in the subtest,
> and it is then important to do a proper analysis, not to hide real bugs.
>
> To avoid creating noises on the different CIs, it is important to have a
> simple way to mark subtests as flaky, and ignore the errors. This is
> what this patch introduces: subtests can be marked as flaky by setting
> MPTCP_LIB_SUBTEST_FLAKY env var to 1, e.g.
>
>  MPTCP_LIB_SUBTEST_FLAKY=1 <run flaky subtest>
>
> The subtest will be executed, and errors (if any) will be ignored. It is
> still good to run these subtests, as it exercises code, and the results
> can still be useful for the on-going investigations.
>
> Note that the MPTCP CI will continue to track these flaky subtests, and
> a ticket should be created before marking a subtest as flaky.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> tools/testing/selftests/net/mptcp/mptcp_lib.sh | 38 ++++++++++++++++++++------
> 1 file changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index ad2ebda5cb64..44febbc11131 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -21,6 +21,7 @@ declare -rx MPTCP_LIB_AF_INET6=10
>
> MPTCP_LIB_SUBTESTS=()
> MPTCP_LIB_SUBTESTS_DUPLICATED=0
> +MPTCP_LIB_SUBTEST_FLAKY=0
> MPTCP_LIB_TEST_COUNTER=0
> MPTCP_LIB_TEST_FORMAT="%02u %-50s"
> MPTCP_LIB_IP_MPTCP=0
> @@ -41,6 +42,18 @@ else
> 	readonly MPTCP_LIB_COLOR_RESET=
> fi
>
> +# SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
> +# features using the last version of the kernel and the selftests to make sure
> +# a test is not being skipped by mistake.
> +mptcp_lib_expect_all_features() {
> +	[ "${SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES:-}" = "1" ]
> +}

Hi Matthieu -

This is overloading SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES to also 
override any "flaky" flags, and treat those tests normally, correct?

I think it's preferable to add an environment varaible specific to this 
(like SELFTESTS_MPTCP_LIB_OVERRIDE_FLAKY), what do you think?

- Mat

> +
> +mptcp_lib_subtest_is_flaky() {
> +	# If all features are expected, do not threat them as flaky
> +	[ "${MPTCP_LIB_SUBTEST_FLAKY}" = 1 ] && ! mptcp_lib_expect_all_features
> +}
> +
> # $1: color, $2: text
> mptcp_lib_print_color() {
> 	echo -e "${MPTCP_LIB_START_PRINT:-}${*}${MPTCP_LIB_COLOR_RESET}"
> @@ -72,20 +85,21 @@ mptcp_lib_pr_skip() {
> }
>
> mptcp_lib_pr_fail() {
> -	mptcp_lib_print_err "[FAIL]${1:+ ${*}}"
> +	local title
> +
> +	if mptcp_lib_subtest_is_flaky; then
> +		title="IGNO"
> +	else
> +		title="FAIL"
> +	fi
> +
> +	mptcp_lib_print_err "[${title}]${1:+ ${*}}"
> }
>
> mptcp_lib_pr_info() {
> 	mptcp_lib_print_info "INFO: ${*}"
> }
>
> -# SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
> -# features using the last version of the kernel and the selftests to make sure
> -# a test is not being skipped by mistake.
> -mptcp_lib_expect_all_features() {
> -	[ "${SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES:-}" = "1" ]
> -}
> -
> # $1: msg
> mptcp_lib_fail_if_expected_feature() {
> 	if mptcp_lib_expect_all_features; then
> @@ -208,7 +222,13 @@ mptcp_lib_result_pass() {
>
> # $1: test name
> mptcp_lib_result_fail() {
> -	__mptcp_lib_result_add "not ok" "${1}"
> +	if mptcp_lib_subtest_is_flaky; then
> +		# It might sound better to use 'not ok # TODO' or 'ok # SKIP',
> +		# but some CIs don't understand 'TODO' and treat SKIP as errors.
> +		__mptcp_lib_result_add "ok" "${1} # IGNORE"
> +	else
> +		__mptcp_lib_result_add "not ok" "${1}"
> +	fi
> }
>
> # $1: test name
>
> -- 
> 2.43.0
>
>
>
