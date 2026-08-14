Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1740F370D5E
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732848; cv=none; b=FVW9iD788IoxaAnBNKai8yTaM5nyyAhWp1KRtdj2JtnQJHAZxl3FT9SFWLCQoKsqkzgW+D7I4j/RaAW9650gpF506+j6tvozYi6jOCzvvjBKMbWuozieVl61rOBBncQJ1dEcHW8DN6kJiLe/eLW6nueAXWdsqiQMqSjJ4/Iq5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732848; c=relaxed/simple;
	bh=+ar7rKvPaM96hrfB6gRKEgMDKSKxDTP67UsNkmX6Dlk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N3Ma0x5T8GwKjeiJveY+naSLFGqka1URDGUE/j6ChYZcM28AE6eXt3aimbGvrrNvPn/SldAd7VAPv80S4LmHy1yeRa/wkzldyMb3c920o9M3laxpKXPBBaWJFKPjFg/9bTYdh+EoyePs2tHEGhwUGij4h2Hgt797PhTthM+L4l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYdawQ03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYdawQ03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552631F000E9;
	Fri, 14 Aug 2026 18:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786732846;
	bh=atSw+Fyu9wpH5+Us60ouMfJcN6xUjOxwm69K1mikE1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JYdawQ03QUGe0uSLmcr29Tjerk7CEPbQfjkdLqvkdXMfx3udxWxA4VNjBIIhIBOd4
	 oLqkHKlhlJOP+qzIFiB03UugOUWtjQCaqTjck1ouLoEnbDYsrngr/QTSQVXK0Mn98Y
	 1lTkgQ/mlJlzA8ffrZNmrpcxns3CK/BirGQ+IGgt648WggIBD7FGInBPgULMBNSaOc
	 7SrNxwrg/X7nHuCy5uQg4qFaofLqOXD+hl2Ogkza6+6QktaLz3oS5lh9BWhBYfVBMY
	 AfNkApCYVsnify/IQiYdNbWSztCbVxUUHTxTh2mNUgOQv7x6DC1n3RD0F1oHNnMMiH
	 Yxi79onmpYFkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next RFC 2/3] mptcp: reject MP_JOIN earlier
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260814-mptcp-reset-mpj-early-v1-2-3ca3260f9474@kernel.org>
References: <20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org>
 <20260814-mptcp-reset-mpj-early-v1-2-3ca3260f9474@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 18:40:45 +0000
Message-Id: <20260814184046.552631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The selftest checks for a non-existent MIB counter `MPTcpExtMPJo=
inDisallowed` due to a typo in the counter name.
--

--- Patch [2]: [PATCH mptcp-next RFC 2/3] mptcp: reject MP_JOIN earlier ---
commit 70d57e8c1f9f68365a9aab7308b481ca3d231b17
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: reject MP_JOIN earlier

This commit checks if an MP_JOIN is allowed earlier when a SYN + MP_JOIN is
received, rather than waiting for subflow establishment. It also adds a new
MIB counter to track this behavior and updates the relevant selftests to
verify it.

> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index 608cb568897cf..988755b41a5ab 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -34,6 +34,7 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
>  	SNMP_MIB_ITEM("MPJoinAckNoCtx", MPTCP_MIB_MPJOINACKNOCTX),
>  	SNMP_MIB_ITEM("MPJoinRejected", MPTCP_MIB_JOINREJECTED),
>  	SNMP_MIB_ITEM("MPJoinNotEstablished", MPTCP_MIB_MPJOINNOTESTABLISHED),
> +	SNMP_MIB_ITEM("MPJoinDisallow", MPTCP_MIB_MPJOINDISALLOWED),
>  	SNMP_MIB_ITEM("MPJoinSynTx", MPTCP_MIB_JOINSYNTX),

[ ... ]

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 18ce7136a2b0e..1924ff488c8dd 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1723,6 +1725,13 @@ chk_join_nr()
>  		fail_test "got $count JOIN[s] no id found expected $no_id_found"
>  	fi
> =20
> +	count=3D$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinDisallowed")

[Severity: Medium]
Does this selftest query the correct MIB counter name?

The kernel code in mptcp_snmp_list[] exports this counter as "MPJoinDisallo=
w",
but the test script checks for "MPTcpExtMPJoinDisallowed".=20

Because the names don't match, mptcp_lib_get_counter will return an empty
string. The subsequent [ -n "$count" ] check will then evaluate to false,
causing the test to silently skip validating this new behavior altogether.

> +	if [ -n "$count" ] && [ "$count" !=3D "$disallowed" ]; then
> +		rc=3D${KSFT_FAIL}
> +		print_check "join disallowed"
> +		fail_test "got $count JOIN[s] disallowed expected $disallowed"
> +	fi
> +
>  	print_results "join Rx" ${rc}
> =20
>  	join_syn_tx=3D"${join_syn_tx:-${syn_nr}}" \

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-mptcp-rese=
t-mpj-early-v1-0-3ca3260f9474@kernel.org?part=3D2
