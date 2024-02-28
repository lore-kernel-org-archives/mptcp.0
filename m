Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E282562C
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709107625; cv=none; b=P4plNTKyPlyp1qoSlpD4gTkSGTzr0BJbr7WnZNGJOBU5xRndXqiPwS6QU9YsZ/npfoxqt9Ew+aj3W0KmqBC0eoowWJLR3tOkqp8c1cLus4GXGdnnztBNWtODrLVMAq1yX0OJKrF7RBJ13aenpCLG2Kv3VHGYUifjqsvijUOATGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709107625; c=relaxed/simple;
	bh=2wAMKThE7UkbTDesclMnPfjqPK4r8OhGErjksK1mGAc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dmFqfQfsvTnMlvqZrnaypzdKK5I7SB6CyZjNGJvGGU96M0TyQl4mE4XisFgyKQCkmGPvvNIp22qfNBubHfXddDd2FfZKyUL9s8aq0TVmLz7Dp5NleYmFA2ovkR9RL7IfKIUWVa5Je4eZ9oRXQlTE7H93UxH3cLnveJrIBfVCF20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jyz97Cda; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jyz97Cda"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C946C433C7;
	Wed, 28 Feb 2024 08:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709107624;
	bh=2wAMKThE7UkbTDesclMnPfjqPK4r8OhGErjksK1mGAc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Jyz97CdabeUIASbFrShUq4XUvVHWBjYLazMNi6TvZhWLoWp/SbOVMamt4AHGQNqa7
	 QRqOlorWYXkZwF93SGzyXRlgmtR5SrJMXJB3TP/ewiadiYCLsMPU/2y8C3MUVbLIBr
	 uvf/n/iKgyQ7WTwWlf43TLGf6Z/zo3srAMx71N4YvTnUwbbbLm7BcDSFmVqs5VAVYL
	 TCYvojigJVH0S+U8/C6IPHp9SmS5g1nzILFPwAfgwFnyg+sdB5GLy067qpStPYepbT
	 nvvxBH1kzWfsylsZ0rpQl2fEc+5Kp8Fn9MKd1x/vxSqvNolMbTDeqf6cIyRdHPqHP9
	 S1JSnhgm2D4Uw==
Message-ID: <346f74e97854afa4c63a56294e284594b3c54a9f.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 04/12] selftests: mptcp: print test
 results with colors
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 28 Feb 2024 16:06:58 +0800
In-Reply-To: <b6d67726-0633-48d0-981e-793cc6902052@kernel.org>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
	 <b1013ed7936552b2fe1a3c9cd1f5065a19931b16.1708939962.git.tanggeliang@kylinos.cn>
	 <b6d67726-0633-48d0-981e-793cc6902052@kernel.org>
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

On Mon, 2024-02-26 at 13:41 +0100, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 26/02/2024 10:43, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >=20
> > The helper mptcp_lib_verify_listener_events() will be added latter
> > in
> > mptcp_lib.sh, and be used by mptcp_join.sh and userspace_pm.sh. The
> > former prints colored output while the latter is not. It makes
> > sense
> > to unify them.
>=20
> (not sure if we need this explanation about
> mptcp_lib_verify_listener_events)

Dropped.

> >=20
> > This patch uses mptcp_lib_print_ok(), _warn(), _err() and _info()
> > helpers
> > in scripts diag.sh, mptcp_connect.sh, mptcp_sockopt.sh,
> > pm_netlink.sh,
> > simult_flows.sh and userspace_pm.sh to print test results with
> > colors.
> >=20
> > Having colors helps to quickly identify issues when looking at a
> > long
> > list of output logs and results.
>=20
> I think this patch will look better if
> mptcp_lib_print_success/fail/skip
> helpers are used.
>=20
> In this case, you should not need to use mptcp_lib_print_ok/err/warn,
> only _info, right?
>=20
> If you still need to use '_ok/err/warn' in the new version, please
> justify it. But I think these should be "internal" functions, or for
> specific need.

Updated.

>=20
> (...)
>=20
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > index 72be905bab1f..c7483902026b 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > @@ -254,7 +254,8 @@ check_mptcp_disabled()
> > =C2=A0
> > =C2=A0	# net.mptcp.enabled should be enabled by default
> > =C2=A0	if [ "$(ip netns exec ${disabled_ns} sysctl
> > net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
> > -		echo -e "net.mptcp.enabled sysctl is not 1 by
> > default\t\t\t=C2=A0=C2=A0 [FAIL]"
> > +		echo -n -e "net.mptcp.enabled sysctl is not 1 by
> > default"
>=20
> See the comments on previous patches, would be better with a helper
> to
> print =E2=86=91 without 'echo -n -e', and =E2=86=93, we would just have
> 'mptcp_lib_print_fail'.

Add a helper print_title.

>=20
> Same below
>=20
> > +		mptcp_lib_print_err "\t\t\t=C2=A0=C2=A0 [FAIL]"
> > =C2=A0		mptcp_lib_result_fail "net.mptcp.enabled sysctl is
> > not 1 by default"
> > =C2=A0		ret=3D1
> > =C2=A0		return 1
> > @@ -267,13 +268,15 @@ check_mptcp_disabled()
> > =C2=A0	mptcp_lib_ns_exit "${disabled_ns}"
> > =C2=A0
> > =C2=A0	if [ ${err} -eq 0 ]; then
> > -		echo -e "New MPTCP socket cannot be blocked via
> > sysctl\t\t\t=C2=A0=C2=A0 [FAIL]"
> > +		echo -n -e "New MPTCP socket cannot be blocked via
> > sysctl"
> > +		mptcp_lib_print_err "\t\t\t=C2=A0=C2=A0 [FAIL]"
> > =C2=A0		mptcp_lib_result_fail "New MPTCP socket cannot be
> > blocked via sysctl"
> > =C2=A0		ret=3D1
> > =C2=A0		return 1
> > =C2=A0	fi
> > =C2=A0
> > -	echo -e "New MPTCP socket can be blocked via
> > sysctl\t\t\t=C2=A0=C2=A0 [ OK ]"
> > +	echo -n -e "New MPTCP socket can be blocked via sysctl"
> > +	mptcp_lib_print_ok "\t\t\t=C2=A0=C2=A0 [ OK ]"
> > =C2=A0	mptcp_lib_result_pass "New MPTCP socket can be blocked via
> > sysctl"
> > =C2=A0	return 0
> > =C2=A0}
> > @@ -503,7 +506,7 @@ do_transfer()
> > =C2=A0	fi
> > =C2=A0
> > =C2=A0	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
> > -		printf "[ OK ]"
> > +		mptcp_lib_print_ok "[ OK ]"
> > =C2=A0		mptcp_lib_result_pass "${TEST_GROUP}:
> > ${result_msg}"
> > =C2=A0	else
>=20
> Maybe good to add a comment here, e.g.
>=20
> =C2=A0 # "FAIL" message has been printed before.
>=20
> > =C2=A0		mptcp_lib_result_fail "${TEST_GROUP}:
> > ${result_msg}"
> > @@ -534,7 +537,6 @@ do_transfer()
> > =C2=A0			"${expect_ackrx}" "${stat_ackrx_now_l}"
> > =C2=A0	fi
> > =C2=A0
> > -	echo
> > =C2=A0	cat "$capout"
> > =C2=A0	[ $retc -eq 0 ] && [ $rets -eq 0 ]
> > =C2=A0}
> > @@ -708,7 +710,7 @@ EOF
> > =C2=A0		return
> > =C2=A0	fi
> > =C2=A0
> > -	echo "INFO: test $msg"
> > +	mptcp_lib_print_info "INFO: test $msg"
> > =C2=A0
> > =C2=A0	TEST_COUNT=3D10000
> > =C2=A0	local extra_args=3D"-o TRANSPARENT"
> > @@ -721,12 +723,12 @@ EOF
> > =C2=A0	ip -net "$listener_ns" route del local $local_addr/0 dev
> > lo table 100
> > =C2=A0
> > =C2=A0	if [ $lret -ne 0 ]; then
> > -		echo "FAIL: $msg, mptcp connection error" 1>&2
> > +		mptcp_lib_print_err "FAIL: $msg, mptcp connection
> > error" 1>&2
>=20
> (I guess it is fine here to print this to stdout, like all the
> others,
> that's part of the unification I think -- but as mentioned in patch
> 2/12, we can probably remove this FAIL message, and the PASS one here
> as
> well)

"FAIL:" is removed, keep '1>&2' unchanged.

>=20
> > =C2=A0		ret=3D$lret
> > =C2=A0		return 1
> > =C2=A0	fi
> > =C2=A0
> > -	echo "PASS: $msg"
> > +	mptcp_lib_print_ok "PASS: $msg"
> > =C2=A0	return 0
> > =C2=A0}
> > =C2=A0
>=20
> (...)
>=20
> > diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh
> > b/tools/testing/selftests/net/mptcp/simult_flows.sh
> > index 58cfdaf1db25..79cb377ee0bd 100755
> > --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> > +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> > @@ -187,12 +187,12 @@ do_transfer()
> > =C2=A0	printf "%-16s" " max $max_time "
> > =C2=A0	if [ $retc -eq 0 ] && [ $rets -eq 0 ] && \
> > =C2=A0	=C2=A0=C2=A0 [ $cmpc -eq 0 ] && [ $cmps -eq 0 ]; then
> > -		echo "[ OK ]"
> > +		mptcp_lib_print_ok "[ OK ]"
> > =C2=A0		cat "$capout"
> > =C2=A0		return 0
> > =C2=A0	fi
> > =C2=A0
> > -	echo " [FAIL]"
> > +	mptcp_lib_print_err " [FAIL]"
>=20
> I guess we don't need the extra space before '[FAIL]', right?

Yes. Replaced by mptcp_lib_pr_fail.

>=20
> > =C2=A0	echo "client exit code $retc, server $rets" 1>&2
> > =C2=A0	echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
> > =C2=A0	ip netns exec ${ns3} ss -nita 1>&2 -o "sport =3D :$port"
> > diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> > b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> > index b0cce8f065d8..33bbb0d5807f 100755
> > --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> > +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> > @@ -61,7 +61,7 @@ _printf() {
> > =C2=A0
> > =C2=A0print_title()
> > =C2=A0{
> > -	_printf "INFO: %s\n" "${1}"
> > +	mptcp_lib_print_info "INFO: ${1}"
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
> > +	mptcp_lib_print_ok "[ OK ]"
> > =C2=A0	mptcp_lib_result_pass "${test_name}"
> > =C2=A0}
> > =C2=A0
> > =C2=A0test_skip()
> > =C2=A0{
> > -	print_results "SKIP"
> > +	mptcp_lib_print_warn "[SKIP]"
> > =C2=A0	mptcp_lib_result_skip "${test_name}"
> > =C2=A0}
> > =C2=A0
> > =C2=A0# $1: msg
> > =C2=A0test_fail()
> > =C2=A0{
> > -	print_results "FAIL"
> > +	mptcp_lib_print_err "[FAIL]${1:+ ${*}}"
>=20
> The error will be repeated twice then, no? ...

"[FAIL]" is dropped here in v6.

>=20
> > =C2=A0	ret=3D1
> > =C2=A0
> > =C2=A0	if [ -n "${1}" ]; then
>=20
> ... maybe you can remove this block?
>=20
> Cheers,
> Matt

