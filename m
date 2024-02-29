Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194D658AB0
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198323; cv=none; b=ethzqVKTpkYEibLP8xjYsYTqCrqb08nYWpYdQ5eCjV0iIVznlNUI62Mx5xkmdHwXbqV7hbev/1l7EkMJ0HyFCqf7oOMNvWu6fuLDZfy2K1//gwf1h+6K/wvM0r/s6EiFfNb5y+uNUQmU6c/SMd3RVnElnsR/ajxvHU1AwfB0p/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198323; c=relaxed/simple;
	bh=/klabyVrWe+YN5k9qeQDhN1Usn3/WP8vuyu0LbiY8Y8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IaqhiEu7Rv1yerQwWiyMJVz+E7PoLethJwM1rpaH8hO1hqB2jZ4SFgOSy62FjhwmQW+ytlhX4NGm7XcOFG9aWudlv6K8WswKXCgSgscA3jynMEZnEeaPjnsMyeqSFGnN7SOKjOGegvAW958eaKn7d0slHGzuoElYbXFkiDOrsNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fe1aW8EJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fe1aW8EJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795FEC433C7;
	Thu, 29 Feb 2024 09:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709198323;
	bh=/klabyVrWe+YN5k9qeQDhN1Usn3/WP8vuyu0LbiY8Y8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Fe1aW8EJddGtZdehv+wJx+WH3BG4Qhfk3m2l2YgtkbyxZZZbTPRY/Iu9SfqGZbrjJ
	 LKlsf2gF9AH80PQN/7W+gjUgL/34nOk55mpRFIBINsViIk8p4HZ3eyDyoEUETHybMI
	 dJ4VDZXErBOFmSqcuZeUVZjfszut8Bi771/teq9ZF5gnmSzgg3XdA8y/CI7k/+qR9E
	 qwwanyoKUErYUfDSwx3A8Tx7tLvjp5X4k+rsJRnp/wYJc8ChP1mlzrjLihSkBKV3u5
	 5sA2K/ooW7EpSUwjD5zobbOgWDU9CBDub+bhzJrPcbRFIJJtqUo1zgRYev2Vr7CHIL
	 6Igk4ErFd3tnA==
Message-ID: <90251e8855c97cb8f88509fff8fab7b3be6ffe12.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v6 1/9] selftests: mptcp: add
 mptcp_lib_pr_ok/skip/fail/info
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 29 Feb 2024 17:18:37 +0800
In-Reply-To: <d47680f0-c91f-497b-9ecd-b6a1375e4b60@kernel.org>
References: <cover.1709105922.git.tanggeliang@kylinos.cn>
	 <d7732e6238909444e5c3d8a67aa06f2fa4b3e79b.1709105922.git.tanggeliang@kylinos.cn>
	 <d47680f0-c91f-497b-9ecd-b6a1375e4b60@kernel.org>
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

Hi Matt,

On Wed, 2024-02-28 at 11:31 +0100, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 28/02/2024 08:43, Geliang Tang wrote:
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
> > to print out [ OK ], [SKIP], [FAIL] and 'INFO:' with colors. Use
> > them in mptcp_join.sh and userspace_pm.sh first, and then use them
> > in all scripts in the next commit.
>=20
> Please add: please note that the mptcp_join.sh tests will now print
> these keywords with capital letters, like most of the other tests.
>=20
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > =C2=A0.../testing/selftests/net/mptcp/mptcp_join.sh |=C2=A0 6 ++---
> > =C2=A0.../testing/selftests/net/mptcp/mptcp_lib.sh=C2=A0 | 23
> > +++++++++++++++++++
> > =C2=A0.../selftests/net/mptcp/userspace_pm.sh=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 13 ++++-------
> > =C2=A03 files changed, 30 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index 1df2d24979a0..53d51a5f68f9 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -190,17 +190,17 @@ print_info()
> > =C2=A0
> > =C2=A0print_ok()
> > =C2=A0{
> > -	mptcp_lib_print_ok "[ ok ]${1:+ ${*}}"
> > +	mptcp_lib_pr_ok "${@}"
> > =C2=A0}
> > =C2=A0
> > =C2=A0print_fail()
> > =C2=A0{
> > -	mptcp_lib_print_err "[fail]${1:+ ${*}}"
> > +	mptcp_lib_pr_fail "${@}"
> > =C2=A0}
> > =C2=A0
> > =C2=A0print_skip()
> > =C2=A0{
> > -	mptcp_lib_print_warn "[skip]${1:+ ${*}}"
> > +	mptcp_lib_pr_skip "${@}"
> > =C2=A0}
> > =C2=A0
> > =C2=A0# [ $1: fail msg ]
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > index 763a2989ca6d..3f5b16fe5220 100644
> > --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > @@ -48,6 +48,29 @@ mptcp_lib_print_err() {
> > =C2=A0	mptcp_lib_print_color "${MPTCP_LIB_COLOR_RED}${*}"
> > =C2=A0}
> > =C2=A0
> > +mptcp_lib_pr_ok() {
> > +	mptcp_lib_print_ok "[ OK ]"
>=20
> Here, you will potentially have more info to print (at least from
> mptcp_join.sh, it can be called with extra args to print):
>=20
> =C2=A0 mptcp_lib_print_ok "[ OK ]${1:+ ${*}}"

I have to use '[ OK ]' here, shellcheck complains about '[ OK ]${1:+
${*}}':

mptcp_lib_pr_ok
                ^-------------^ SC2119 (info): Use mptcp_lib_pr_ok "$@"
if function's $1 should mean script's $1.

Thanks,
-Geliang

>=20
>=20
> > +}
> > +
> > +mptcp_lib_pr_skip() {
> > +	local msg=3D"[SKIP]"
> > +
> > +	mptcp_lib_print_warn "${msg}"
>=20
> Same here:
>=20
> =C2=A0 mptcp_lib_print_warn "[SKIP]${1:+ ${*}}"
>=20
> > +}
> > +
> > +mptcp_lib_pr_fail() {
> > +	local msg=3D"[FAIL]"
> > +
> > +	if [ "${#}" -gt 0 ]; then
> > +		msg+=3D"${1:+ ${*}}"
> > +	fi
> > +	mptcp_lib_print_err "${msg}"
>=20
> And here, it can be simplified:
>=20
> =C2=A0 mptcp_lib_print_err "[FAIL]${1:+ ${*}}"
>=20
> > +}
> > +
> > +mptcp_lib_pr_info() {
> > +	mptcp_lib_print_info "INFO:${1:+ ${*}}"
>=20
> I guess here, we will always have arguments, no?
>=20
> =C2=A0 mptcp_lib_print_info "INFO: ${*}"
>=20
> > +}
> > +
> > =C2=A0# SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when
> > validating all
> > =C2=A0# features using the last version of the kernel and the selftests
> > to make sure
> > =C2=A0# a test is not being skipped by mistake.
> > diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> > b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> > index b0cce8f065d8..5f32ac451596 100755
> > --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> > +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> > @@ -61,7 +61,7 @@ _printf() {
> > =C2=A0
> > =C2=A0print_title()
> > =C2=A0{
> > -	_printf "INFO: %s\n" "${1}"
> > +	mptcp_lib_print_info "INFO: ${1}"
>=20
> Use mptcp_lib_pr_info() directly, no?
>=20
> > =C2=A0}
> > =C2=A0
> > =C2=A0# $1: test name
> > @@ -72,27 +72,22 @@ print_test()
> > =C2=A0	_printf "%-68s" "${test_name}"
> > =C2=A0}
> > =C2=A0
> > -print_results()
> > -{
> > -	_printf "[%s]\n" "${1}"
> > -}
> > -
> > =C2=A0test_pass()
> > =C2=A0{
> > -	print_results " OK "
> > +	mptcp_lib_pr_ok
> > =C2=A0	mptcp_lib_result_pass "${test_name}"
> > =C2=A0}
> > =C2=A0
> > =C2=A0test_skip()
> > =C2=A0{
> > -	print_results "SKIP"
> > +	mptcp_lib_pr_skip
> > =C2=A0	mptcp_lib_result_skip "${test_name}"
> > =C2=A0}
> > =C2=A0
> > =C2=A0# $1: msg
> > =C2=A0test_fail()
> > =C2=A0{
> > -	print_results "FAIL"
> > +	mptcp_lib_pr_fail "${1:+ ${*}}"
>=20
> I guess you can pass "${@}", no?
>=20
> =C2=A0 mptcp_lib_pr_fail "${@}"
>=20
> > =C2=A0	ret=3D1
> > =C2=A0
> > =C2=A0	if [ -n "${1}" ]; then
>=20
> Here, I guess you don't need the 'if' to print more info, there will
> be
> printed with 'mptcp_lib_pr_fail "${@}"' just before, no?
>=20
> Cheers,
> Matt

