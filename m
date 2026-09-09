Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7C95867CB
	for <mptcp@lists.linux.dev>; Wed,  9 Sep 2026 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963307; cv=none; b=QcO/XtZySCksZ5CBGTmZmuTK7dC/gdr2vB5Oqi+ScGSU3rVE+rGVrGsR7iRpgWcS+R0d4IxT3lp7NAfFyel4QVNcCBLoTOeu3cpXBcT7RGq0xy8s3zU9vPOPlV4tVnh6P1K700BhS8+S27lBUTq4wFvExlUEv+b4uMCmAPPaGVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963307; c=relaxed/simple;
	bh=VNc1F2AV0E0x729VMMOZlIi583Rwgx+whiCrHG2L5LU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P66Ko18CBL4bPZzP3LyPuqqry0q/CaWTDc0zKs10DhsCzEZjrQh3v9bfNiF773tT4SdpLXXR6t/Ux1GW52fLz1/BAB0MgCEMO/kOcXdUtDXsLsXIjEGAU2uCkFXv9FksoKYeKJP4E8zfLRO8U5yV1qpyzSMsizQeD4zD9N08N9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToMaPBDy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToMaPBDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384121F00A3E;
	Wed,  9 Sep 2026 14:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963306;
	bh=CdDchicwO5CtadRiujswbn3WOvWK6gfuS7s03XFbqQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ToMaPBDy2a136zOIuB8a6o2uPEtEpCb1vWABo5iTZuFtmlUq3OxzODBqQiPay2L5i
	 wt7lXCFa8Y3wx7ex77KusJEVaRmuDWhe62p0vvypTQCQV8yzdvObAzTwFQrXGFNkFu
	 qKLu4sEt7N4aW7rE11Pg5wjRTTI5wkVamrTwv8Jv8DXqz+lKKJbsb1ayqWNPC249WE
	 bnOCMKne9Vmj6ygBBilJ9rreLtWQ+fO9XHEUwV691QNd8F2XinMOzH4kfHihCXff+s
	 iWI3I1TKBu9ncwAWW/qJ4YevQPp0tNDBriHph3EJrEhTr1+dG3Yo6aRcsmS+0Aa+U6
	 /82Rn3/+QOj+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 12/15] selftests: mptcp: lib: get counters for
 the right test
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-12-df1de70348b6@kernel.org>
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
 <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-12-df1de70348b6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:15:05 +0000
Message-Id: <20260909141506.384121F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Insecure use of predictable temporary file paths in /tmp allows lo=
cal privilege escalation via a symlink attack (TOCTOU).
--

commit 706f0812739080817c63b8f13d5f3a60fbeddf0a
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

selftests: mptcp: lib: get counters for the right test

This commit updates the mptcp_lib_get_counter function to use nstat history
instead of absolute counters when extracting MIB values. It renames the
previous variable to cache and introduces a new history file variable.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testi=
ng/selftests/net/mptcp/mptcp_lib.sh
> index da1da414c30f2..b9d14647f4019 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh

[ ... ]

> @@ -416,19 +416,21 @@ mptcp_lib_nstat_get() {
>  }
> =20
>  # $1: ns, $2: MIB counter
> -# Get the counter from the history (mptcp_lib_nstat_{init,get}()) if ava=
ilable.
> -# If not, get the counter from nstat ignoring any history.
> +# Get the counter from the cache (mptcp_lib_nstat_{init,get}()) if avail=
able.
> +# If not, get the counter from nstat ignoring any cache, but using the h=
istory.
>  mptcp_lib_get_counter() {
>  	local ns=3D"${1}"
>  	local counter=3D"${2}"
> -	local hist=3D"/tmp/${ns}.out"
> +	local cache=3D"/tmp/${ns}.out"
> +	local hist=3D"/tmp/${ns}.nstat"

[Severity: High]
This isn't a bug introduced by this patch, but was already present in the
script for .out and .nstat files. Is there a risk of a local privilege
escalation via a symlink attack here?

Because the file path is constructed in mptcp_lib_get_counter() using the
globally visible namespace name, an unprivileged attacker could monitor
/var/run/netns/ for new network namespace names and preemptively create a
symlink at /tmp/${ns}.nstat pointing to a sensitive file like /etc/shadow.

>  	local count
> =20
> -	if [[ -s "${hist}" && "${counter}" =3D=3D *"Tcp"* ]]; then
> -		count=3D$(awk "/^${counter} / {print \$2; exit}" "${hist}")
> +	if [[ -s "${cache}" && "${counter}" =3D=3D *"Tcp"* ]]; then
> +		count=3D$(awk "/^${counter} / {print \$2; exit}" "${cache}")
>  	else
> -		count=3D$(ip netns exec "${ns}" nstat -asz "${counter}" |
> -			awk 'NR=3D=3D1 {next} {print $2}')
> +		count=3D$(NSTAT_HISTORY=3D"${hist}" ip netns exec "${ns}" \
> +			nstat -sz "${counter}" |
> +				awk 'NR=3D=3D1 {next} {print $2}')

[Severity: High]
When nstat is executed here as root with NSTAT_HISTORY pointing to the
predictable /tmp/ path, could it follow the attacker's symlink and
overwrite the target file?

>  	fi
>  	if [ -z "${count}" ]; then
>  		mptcp_lib_fail_if_expected_feature "${counter} counter"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-net-mptcp-=
misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org?part=3D12
