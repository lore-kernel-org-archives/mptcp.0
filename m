Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB7E25577
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709107035; cv=none; b=O9ftyE+u+GkIsX/12BiKVG5PqYBzm5nrDAvuGoD930ncYq/pBcySNbqZZE1GWcDEZfKVx9d6sT2cr406UWsAftblGjmOapPMdTHnam+AT8cB+xsplLsgU79lUl0zgIgZaRXccAWzpuqxzPY55tIF8w3ihZdgp26OCb+/5+tzX+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709107035; c=relaxed/simple;
	bh=HXrpL67my23OHfRyr6F9rGrRsBeFZfZcnHFE3JmtFY0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vFfl2Yw1dyHE2iewM+4/gChY6d9nmAPhQal+sh0eHCvRSQbJMEpo5EJ5zoPT5Lrhyh6hpg6KBYNZichhzYQV85VTFbCZUnj+n0TRuS7zhVRD6vRf/SoOJ6BoJ5lvBOgxHmyjGLdQfFyLRw/FHtshEDxbQIlbfFmgQvg3KNpUhX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1xXx1V0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1xXx1V0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B949C433C7;
	Wed, 28 Feb 2024 07:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709107035;
	bh=HXrpL67my23OHfRyr6F9rGrRsBeFZfZcnHFE3JmtFY0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=i1xXx1V0JF5VRJkbPZ0NCiZ7Q8ts83OlFeQ1vfBN+0YRSu/8XQpXYArfi7Z8E22L/
	 0iXSeDDfg5ZjhKpzmPF6t86tbvP52iEkDn9IE5Z1jORDvLXmL1RrkSPfYw+Fbiz8Mj
	 z1J5CkJrytQQbPuwXIM0+BJttx7LaiXRufeukS0HfnRVdffh7tmu2Uq/2Knm/vFhgC
	 O+A+WeXLhbpJuwG8hanZun5dGAD4jgHYBj7ey2FPILUvnoOxHI/PySNmFB1D/I82YE
	 DRxVTbcjK4GFYTPpVQldC7awM7N6T80OHcKSDT3j0Pqlmm+W4uSwLSHhWmQX2Mfi0H
	 argGdKJuuNAJQ==
Message-ID: <0118dbd0fbf33d5a1f4ea98dc606b3be91af49db.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 02/12] selftests: mptcp: sockopt: print
 every test result
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 28 Feb 2024 15:57:09 +0800
In-Reply-To: <405e2ab8-7483-4bf7-a9a5-a94c631af404@kernel.org>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
	 <1aa6a9af7ebd8690e595bfbbdde5f54f684f51e8.1708939962.git.tanggeliang@kylinos.cn>
	 <405e2ab8-7483-4bf7-a9a5-a94c631af404@kernel.org>
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

On Mon, 2024-02-26 at 13:40 +0100, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 26/02/2024 10:43, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >=20
> > Only total test results are printed out in mptcp_sockopt.sh:
> >=20
> > =C2=A0PASS: all packets had packet mark set
> > =C2=A0PASS: SOL_MPTCP getsockopt has expected information
> > =C2=A0PASS: TCP_INQ cmsg/ioctl -t tcp
> > =C2=A0PASS: TCP_INQ cmsg/ioctl -6 -t tcp
> > =C2=A0PASS: TCP_INQ cmsg/ioctl -r tcp
> > =C2=A0PASS: TCP_INQ cmsg/ioctl -6 -r tcp
> >=20
> > This patch prints more info for every test result in each test
> > group:
> >=20
> > transfer ipv4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 [ OK ]
> > mark ipv4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 [ OK ]
> > transfer ipv6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 [ OK ]
> > mark ipv6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 [ OK ]
> > PASS: all packets had packet mark set
> > sockopt v4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 [ OK ]
> > sockopt v6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 [ OK ]
> > PASS: SOL_MPTCP getsockopt has expected information
> > TCP_INQ: -t tcp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ OK ]
> > PASS: TCP_INQ cmsg/ioctl -t tcp
> > TCP_INQ: -6 -t tcp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ OK ]
> > PASS: TCP_INQ cmsg/ioctl -6 -t tcp
> > TCP_INQ: -r tcp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ OK ]
> > PASS: TCP_INQ cmsg/ioctl -r tcp
> > TCP_INQ: -6 -r tcp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ OK ]
> > PASS: TCP_INQ cmsg/ioctl -6 -r tcp
> > TCP_INQ: -r tcp -t tcp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ OK ]
>=20
> Please clearly explain why this is interesting, even if it looks
> obvious.
>=20
> Here, I don't know if this patch makes sense or not: to me, the
> output
> is now confusing because there is a mix of '[ OK ]' and 'PASS'.
> Maybe:
>=20
> - remove all the "PASS: xxx"? =E2=86=92 I don't see what it brings more
> - (or convert existing "PASS: xxx" and "FAIL: xxx" to use "[ OK ]"?
> But
> there are fewer details)

This patch uses to match the output of this script:

INFO: PASS: all packets had packet mark set
INFO: PASS: SOL_MPTCP getsockopt has expected information
INFO: PASS: TCP_INQ cmsg/ioctl -t tcp
INFO: PASS: TCP_INQ cmsg/ioctl -6 -t tcp
INFO: PASS: TCP_INQ cmsg/ioctl -r tcp
INFO: PASS: TCP_INQ cmsg/ioctl -6 -r tcp
INFO: PASS: TCP_INQ cmsg/ioctl -r tcp -t tcp

with the test results of it:

ok 1 - mptcp_sockopt: mark ipv4
ok 2 - mptcp_sockopt: transfer ipv4
ok 3 - mptcp_sockopt: mark ipv6
ok 4 - mptcp_sockopt: transfer ipv6
ok 5 - mptcp_sockopt: sockopt v4
ok 6 - mptcp_sockopt: sockopt v6
ok 7 - mptcp_sockopt: TCP_INQ: -t tcp
ok 8 - mptcp_sockopt: TCP_INQ: -6 -t tcp
ok 9 - mptcp_sockopt: TCP_INQ: -r tcp
ok 10 - mptcp_sockopt: TCP_INQ: -6 -r tcp
ok 11 - mptcp_sockopt: TCP_INQ: -r tcp -t tcp

This patch is prepared for the coming printing counter patch, otherwise
the two output results may have different serial numbers, which can be
confusing.

>=20
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > =C2=A0tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 12
> > ++++++++++++
> > =C2=A01 file changed, 12 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> > b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> > index 6ed4aa32222f..f84185b5dc9f 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> > @@ -161,6 +161,7 @@ do_transfer()
> > =C2=A0	wait $spid
> > =C2=A0	local rets=3D$?
> > =C2=A0
> > +	printf "%-50s" "transfer ${ip}"
>=20
> Best to use a helper to avoid repeating '"%-50s"', and to be able to
> change how the titles are displayed from a single place. (same below
> of
> course)

Add a new helper print_title() to do this.

>=20
> Also, probably looking better if you use 'Transfer' instead of
> 'transfer'.

Updated in v6.

>=20
> > =C2=A0	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
> > =C2=A0		echo " client exit code $retc, server $rets" 1>&2
> > =C2=A0		echo -e "\nnetns ${listener_ns} socket stat for
> > ${port}:" 1>&2
> > @@ -169,12 +170,15 @@ do_transfer()
> > =C2=A0		echo -e "\nnetns ${connector_ns} socket stat for
> > ${port}:" 1>&2
> > =C2=A0		ip netns exec ${connector_ns} ss -Menita 1>&2 -o
> > "dport =3D :$port"
> > =C2=A0
> > +		mptcp_lib_print_err "[FAIL]"
> > =C2=A0		mptcp_lib_result_fail "transfer ${ip}"
> > =C2=A0
> > =C2=A0		ret=3D1
> > =C2=A0		return 1
> > =C2=A0	fi
> > +	mptcp_lib_print_ok "[ OK ]"
>=20
> (here as well, we could use 'mptcp_lib_print_success/fail/skip'
> suggested in patch 1/12)


Replaced by mptcp_lib_pr_ok.

>=20
> > =C2=A0
> > +	printf "%-50s" "mark ${ip}"
>=20
> Same here: 'Mark' vs 'mark'.

Yes, updated.

>=20
> > =C2=A0	if [ $local_addr =3D "::" ];then
> > =C2=A0		check_mark $listener_ns 6 || retc=3D1
> > =C2=A0		check_mark $connector_ns 6 || retc=3D1
> > @@ -190,8 +194,10 @@ do_transfer()
> > =C2=A0	mptcp_lib_result_code "${rets}" "transfer ${ip}"
> > =C2=A0
> > =C2=A0	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
> > +		mptcp_lib_print_ok "[ OK ]"
> > =C2=A0		return 0
> > =C2=A0	fi
> > +	mptcp_lib_print_err "[FAIL]"
> > =C2=A0
> > =C2=A0	return 1
> > =C2=A0}
> > @@ -220,23 +226,27 @@ do_mptcp_sockopt_tests()
> > =C2=A0	ip netns exec "$ns_sbox" ./mptcp_sockopt
> > =C2=A0	lret=3D$?
> > =C2=A0
> > +	printf "%-50s" "sockopt v4"
>=20
> Maybe 'SOL_MPTCP getsockopt v4'?

Updated.

>=20
> > =C2=A0	if [ $lret -ne 0 ]; then
> > =C2=A0		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
> > =C2=A0		mptcp_lib_result_fail "sockopt v4"
> > =C2=A0		ret=3D$lret
> > =C2=A0		return
> > =C2=A0	fi
> > +	mptcp_lib_print_ok "[ OK ]"
> > =C2=A0	mptcp_lib_result_pass "sockopt v4"
> > =C2=A0
> > =C2=A0	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
> > =C2=A0	lret=3D$?
> > =C2=A0
> > +	printf "%-50s" "sockopt v6"
> > =C2=A0	if [ $lret -ne 0 ]; then
> > =C2=A0		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
> > =C2=A0		mptcp_lib_result_fail "sockopt v6"
> > =C2=A0		ret=3D$lret
> > =C2=A0		return
> > =C2=A0	fi
> > +	mptcp_lib_print_ok "[ OK ]"
> > =C2=A0	mptcp_lib_result_pass "sockopt v6"
> > =C2=A0}
> > =C2=A0
> > @@ -259,6 +269,7 @@ run_tests()
> > =C2=A0
> > =C2=A0do_tcpinq_test()
> > =C2=A0{
> > +	printf "%-50s" "TCP_INQ: $*"
> > =C2=A0	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
> > =C2=A0	local lret=3D$?
> > =C2=A0	if [ $lret -ne 0 ];then
> > @@ -267,6 +278,7 @@ do_tcpinq_test()
> > =C2=A0		mptcp_lib_result_fail "TCP_INQ: $*"
> > =C2=A0		return $lret
> > =C2=A0	fi
> > +	mptcp_lib_print_ok "[ OK ]"
> > =C2=A0
> > =C2=A0	echo "PASS: TCP_INQ cmsg/ioctl $*"
> > =C2=A0	mptcp_lib_result_pass "TCP_INQ: $*"
>=20
> Cheers,
> Matt

