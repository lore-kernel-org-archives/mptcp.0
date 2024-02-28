Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B0F175BE
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109115; cv=none; b=h5ORSb9zaHFi+TXKstkIJWwhD8n9zXQ4wpB/MdWJpqMaNwGrppE8uc1kHeH9+cQM+g2cyNFevEfL7Qjg0Ken8nAeNKi6cm40xBDzK6EGmT6maDhsVtSJ848HdM60+zFsS2OoBN691alcBRIIF1sc5xgCunW9lNtYEGeoq+454Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109115; c=relaxed/simple;
	bh=mduGhiDoQku/DM9jyXoCBQuCIqXDq3n7FZhPwPGR21c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CtULOlsEtYRMcO26JWhs85+4L25xAyXWbn8rt16n89zt9iifeEsi1+RmDUoYfKJZrwF90PAjptKNVr85XZVkRvxZpeif4iuH3uU2bmBUGG5OQ5x5pKsxib8ZKfbmQHPb/vqg0pREXFelRhCcpFY7jSs6XqjIFkTMK8MoCsHU7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNXqxT5G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNXqxT5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF99C433C7;
	Wed, 28 Feb 2024 08:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709109115;
	bh=mduGhiDoQku/DM9jyXoCBQuCIqXDq3n7FZhPwPGR21c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZNXqxT5G2Bm4mJqtkcvMllwKcxVeQhf/OzlEXbGUgj0vtWcSE2Qcs6g1Rljmc40TG
	 jUEELscdn2vxbQKDcVBlW4587e/ELDdZI0jAwwrmXViHzMNVXGySArB/9GUld2Ovk0
	 EqjJB9VZuQA6ZDu65AD+FPsBuSCV55VAN5mdnUDcIxdmptV/RDWUkkVyR+osC2ghP+
	 0xPmGngf7L9N/+SgjeZ3vy6mlash/5cZEI5oXvsarCcEy2ASmaJPuqLLZPerOM9Jj3
	 5cyv3q/c+iCO/D+wd4LGCnelblU2QpSg3B3tHqGCwnfYS+OdkDVccSPuEP8ypOLC7m
	 w8ghEjQ8ICFQA==
Message-ID: <363e7902613b1a9a8c256f5732106a4341e93d13.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 06/12] selftests: mptcp: connect: print
 out ping tests info
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 28 Feb 2024 16:31:50 +0800
In-Reply-To: <8657b9cd-7b16-42c2-b874-2049bb138014@kernel.org>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
	 <77c1b641cefdf9832b96759e2544e41330161a7c.1708939962.git.tanggeliang@kylinos.cn>
	 <8657b9cd-7b16-42c2-b874-2049bb138014@kernel.org>
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
> On 26/02/2024 10:43, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >=20
> > 'ping tests' shows in the test results of mptcp_connect.sh:
> >=20
> > 1..68
> > ok 1 - mptcp_connect: New MPTCP socket can be blocked via sysctl
> > ok 2 - mptcp_connect: ping tests
> > ok 3 - mptcp_connect: loopback v4: ns1 MPTCP -> ns1
> > (10.0.1.1:10000) MPTCP
> > ok 4 - mptcp_connect: loopback v4: ns1 MPTCP -> ns1
> > (10.0.1.1:10001) TCP
> >=20
> > But not in the test output of this script:
> >=20
> > New MPTCP socket can be blocked via sysctl			=C2=A0=C2=A0
> > [ OK ]
> > INFO: validating network environment with pings
> > INFO: Using loss of 0.01% delay 30 ms reorder 94% 9% with delay 7ms
> > on
> > ns1 MPTCP -> ns1 (10.0.1.1:10000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ) MPTCP	=
(duration=C2=A0=C2=A0=C2=A0 79ms)
> > [ OK ]
> > ns1 MPTCP -> ns1 (10.0.1.1:10001=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ) TCP=C2=
=A0=C2=A0	(duration=C2=A0=C2=A0=C2=A0 49ms)
> > [ OK ]
> >=20
> > This patch fixes this by adding ping tests in test output.
> >=20
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > =C2=A0tools/testing/selftests/net/mptcp/mptcp_connect.sh | 3 +++
> > =C2=A01 file changed, 3 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > index 68073b255983..06e945914ace 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > @@ -861,6 +861,9 @@ mptcp_lib_result_code "${ret}" "ping tests"
> > =C2=A0
> > =C2=A0stop_if_error "Could not even run ping tests"
> > =C2=A0
> > +echo -e "ping tests"
>=20
> Maybe replace the "INFO: validating network environment with pings"
> message, no?
>=20
> > +mptcp_lib_print_ok "\t\t\t\t\t\t\t\t=C2=A0=C2=A0 [ OK ]"
>=20
> Please use the new helper suggested in previous comments, to have
> something like:
>=20
> =C2=A0 print_test "Ping tests"
> =C2=A0 (...)
> =C2=A0 mptcp_lib_print_success

I forgot to update this. A squash-to patch just sent out.

Thanks,
-Geliang

>=20
> > +
> > =C2=A0[ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root
> > netem loss random $tc_loss delay ${tc_delay}ms
> > =C2=A0echo -n "INFO: Using loss of $tc_loss "
> > =C2=A0test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
>=20
> Cheers,
> Matt

