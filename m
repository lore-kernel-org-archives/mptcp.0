Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7E66931E
	for <mptcp@lists.linux.dev>; Fri,  1 Mar 2024 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709277415; cv=none; b=qfsIfs+3rzoz2KQuJ5FJZctC9v54TBw3nN6HZhl67jVoCSoT5KnLccUQyHmx0JadWqVXkoXJsxaTDuGk2B5Ee0k+3nTGsJwFUMSsn4GM+2LCkS9mp4z8bIiaT4Cf8wR8zU5PnbrQi8a8hygzuXnrA6BQvObb2VDRwdbtFtr0bb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709277415; c=relaxed/simple;
	bh=EQfmlX6Df/VRdhY/+5mZZUBM3nJYNG5aKzEcibcuTPg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N+ZHgpyWzeZho6jtkyOob2e/9VPY4GlLmdW/+Alc12MRlNzVV4j4fKtxX8OIcVqdLgzVlctz/OovQyfxqVa81Cm7e3Y1OrqorleNYxRjEK1bt+wO07PRNBFaiZrG5DW2e6RAPq1m+uGsA92B92dz7rGMDW4nJMSu0Viv4I/kxjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YX7f7cE6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YX7f7cE6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5E4C433F1;
	Fri,  1 Mar 2024 07:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709277414;
	bh=EQfmlX6Df/VRdhY/+5mZZUBM3nJYNG5aKzEcibcuTPg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YX7f7cE66nEReqjzbwoQZBbBp4d9BCny3PgSL93TjaHHGC5jrqJHzkKGErZ81JDNY
	 dNT5hkTEyvzhNVfZFEbhiEzWoqEmyTOjhJjzrenj1ff0T+3Ji3i17PrZ2AhLWp/RhU
	 NRe0a7o6CKsYYYgbSb4n7kSVbZSnrAoYG4bgEiJiR0v5qoUz1frq1W1tAXS/PhjfNH
	 ZPQli3hO/D9Z0MtL91UjSeBNoqr0wx92nVXfDTesRX6fn5osxNDa6Rc4VNuNox8TCl
	 L0QbEFutBceS4FF7N6bqd4paYCfiXYYL9gNXIx6ewBhSjI3vyGcIj86yz9lMSbMSW6
	 iwfIrZn4VSF+A==
Message-ID: <8f8665ba6e41497e0b5f90ec3022cf69abbc0037.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v7 8/8] selftests: mptcp: print test results
 with colors
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 01 Mar 2024 15:16:41 +0800
In-Reply-To: <409065cf-bab0-413b-8533-0b80b28862d4@kernel.org>
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
	 <81fd6204fc60dd90a4410b3435ab4552402b71c0.1709200070.git.tanggeliang@kylinos.cn>
	 <409065cf-bab0-413b-8533-0b80b28862d4@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Thu, 2024-02-29 at 14:04 +0100, Matthieu Baerts wrote:
> On 29/02/2024 10:51, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >=20
> > To unify the output formats of all test scripts, this patch adds
> > four more helpers:
> >=20
> > 	mptcp_lib_pr_ok()
> > 	mptcp_lib_pr_skip()
> > 	mptcp_lib_pr_fail()
> > 	mptcp_lib_pr_info()
> >=20
> > to print out [ OK ], [SKIP], [FAIL] and 'INFO: ' with colors. Use
> > them
> > in all scripts to print the "ok/skip/fail/info' using the same
> > 'format'.
> >=20
> > Having colors helps to quickly identify issues when looking at a
> > long
> > list of output logs and results.
> >=20
> > Note that the mptcp_join.sh tests will now print these keywords
> > with
> > capital letters, like most of the other tests.
>=20
> I think it is not just mptcp_join.sh that was using different
> keywords.
>=20
> =C2=A0 Note that now all print the same keywords, which was not the case
> =C2=A0 before, but it is good to uniform that.
>=20
> (...)
>=20
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > index 096ff8941c5b..70acbb19f568 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>=20
> (...)
>=20
> > @@ -534,7 +534,6 @@ do_transfer()
> > =C2=A0			"${expect_ackrx}" "${stat_ackrx_now_l}"
> > =C2=A0	fi
> > =C2=A0
> > -	echo
>=20
> Just to be sure: do we still have something good in case of error?
>=20
> I mean: why were we not printing a new line before? Maybe there was
> no
> reason, or maybe sometimes we print more details? (syn cookies?)
>=20
> Maybe that's fine with the new output, it is just to know if you
> checked
> that.

This 'echo' does need to be dropped. Here use mptcp_lib_pr_ok instead
of 'printf "[ OK ]"'. 'printf "[ OK ]"' needs a new line but
mptcp_lib_pr_ok don't need:

 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
-		printf "[ OK ]"
+		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
 	else
 		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
@@ -540,7 +540,6 @@  do_transfer()
 			"${expect_ackrx}" "${stat_ackrx_now_l}"
 	fi
=20
-	echo
 	cat "$capout"

>=20
> > =C2=A0	cat "$capout"
> > =C2=A0	[ $retc -eq 0 ] && [ $rets -eq 0 ]
> > =C2=A0}
>=20
> (...)
>=20
> > @@ -810,7 +809,7 @@ log_if_error()
> > =C2=A0	local msg=3D"$1"
> > =C2=A0
> > =C2=A0	if [ ${ret} -ne 0 ]; then
> > -		echo "FAIL: ${msg}" 1>&2
> > +		mptcp_lib_pr_fail "${msg}"
>=20
> Good to mention in the commit message that all errors messages are
> printed to 'stdout' now, as part of the uniformation. (or do that in
> an
> dedicated commit)

A new commit added in v9.

>=20
> > =C2=A0
> > =C2=A0		final_ret=3D${ret}
> > =C2=A0		ret=3D0
> > @@ -858,11 +857,11 @@ done
> > =C2=A0mptcp_lib_result_code "${ret}" "ping tests"
> > =C2=A0
> > =C2=A0stop_if_error "Could not even run ping tests"
> > -echo "[ OK ]"
> > +mptcp_lib_pr_ok
> > =C2=A0MPTCP_LIB_TEST_FORMAT=3D"%02u %-50s"
> > =C2=A0
> > =C2=A0[ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root
> > netem loss random $tc_loss delay ${tc_delay}ms
> > -echo -n "INFO: Using loss of $tc_loss "
>=20
> Here, it was using 'echo -n' ...

I keep this 'echo -n' unchanged.

>=20
> > +mptcp_lib_pr_info "Using loss of $tc_loss "
>=20
> Now a new line will be printed at the end (with a trailing
> whitespace)
>=20
> > =C2=A0test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
>=20
> And this will be printed in a new line, it will look strange I think
>=20
> Maybe use a variable to store all the info?
>=20
> =C2=A0 tc_info=3D"loss of $tc_loss "
> =C2=A0 test "$tc_delay" -gt 0 && tc_info+=3D"delay $tc_delay ms "
> =C2=A0 (...)
> =C2=A0 mptcp_lib_pr_info "Using ${tc_info}"
>=20
> > =C2=A0
> > =C2=A0reorder_delay=3D$((tc_delay / 4))
>=20
> (...)
>=20
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > index 358d5b77fc0f..53867f9d212d 100644
> > --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > @@ -48,6 +48,23 @@ mptcp_lib_print_err() {
> > =C2=A0	mptcp_lib_print_color "${MPTCP_LIB_COLOR_RED}${*}"
> > =C2=A0}
> > =C2=A0
> > +#shellcheck disable=3DSC2120
>=20
> Add a space after '#' and add a comment justifying the exception,
> like
> the one I shared in patch 1/9 from v6:
>=20
> =C2=A0 # shellcheck disable=3DSC2120=C2=A0 # parameters are optional
>=20
> Out of curiosity, we don't need this for 'skip' and 'fail'?

Not a single parameter was passed to mptcp_lib_pr_ok at a time.But 'skip' o=
r 'fail' sometimes has parameters passed in.

Thanks,
-Geliang

>=20
> > +mptcp_lib_pr_ok() {
> > +	mptcp_lib_print_ok "[ OK ]${1:+ ${*}}"
> > +}
> > +
> > +mptcp_lib_pr_skip() {
> > +	mptcp_lib_print_warn "[SKIP]${1:+ ${*}}"
> > +}
> > +
> > +mptcp_lib_pr_fail() {
> > +	mptcp_lib_print_err "[FAIL]${1:+ ${*}}"
> > +}
> > +
> > +mptcp_lib_pr_info() {
> > +	mptcp_lib_print_info "INFO: ${*}"
> > +}
> > +
> > =C2=A0# SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when
> > validating all
> > =C2=A0# features using the last version of the kernel and the selftests
> > to make sure
> > =C2=A0# a test is not being skipped by mistake.
>=20
> (...)
>=20
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> > b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> > index a797e13d3fe7..d695561fbf46 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
>=20
> (...)
>=20
> > @@ -217,7 +218,7 @@ do_mptcp_sockopt_tests()
> > =C2=A0	local lret=3D0
> > =C2=A0
> > =C2=A0	if ! mptcp_lib_kallsyms_has "mptcp_diag_fill_info$"; then
> > -		echo "INFO: MPTCP sockopt not supported: SKIP"
> > +		mptcp_lib_pr_skip "MPTCP sockopt not supported"
> > =C2=A0		mptcp_lib_result_skip "sockopt"
> > =C2=A0		return
> > =C2=A0	fi
> > @@ -227,12 +228,12 @@ do_mptcp_sockopt_tests()
> > =C2=A0
> > =C2=A0	mptcp_lib_print_title "SOL_MPTCP sockopt v4"
> > =C2=A0	if [ $lret -ne 0 ]; then
> > -		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
> > +		mptcp_lib_pr_fail "SOL_MPTCP getsockopt"
>=20
> No need to repeat what is already in the title. (I didn't check them
> all, but I guess some other subtests here repeat stuff already in the
> title, e.g. the same for v6)
>=20
> > =C2=A0		mptcp_lib_result_fail "sockopt v4"
> > =C2=A0		ret=3D$lret
> > =C2=A0		return
> > =C2=A0	fi
> > -	echo "[ OK ]"
> > +	mptcp_lib_pr_ok
> > =C2=A0	mptcp_lib_result_pass "sockopt v4"
> > =C2=A0
> > =C2=A0	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
>=20
> (...)
>=20
> > @@ -288,7 +289,7 @@ do_tcpinq_tests()
> > =C2=A0	local lret=3D0
> > =C2=A0
> > =C2=A0	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
> > -		echo "INFO: TCP_INQ not supported: SKIP"
> > +		mptcp_lib_pr_skip "INFO: TCP_INQ not supported"
>=20
> You can remove 'INFO: ' I=C2=A0 suppose.
>=20
> > =C2=A0		mptcp_lib_result_skip "TCP_INQ"
> > =C2=A0		return
> > =C2=A0	fi
>=20
> (...)
>=20
> Cheers,
> Matt


