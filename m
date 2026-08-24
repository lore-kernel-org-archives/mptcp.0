Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9921A34D916
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787556113; cv=none; b=Xy0vwhNB5n1QlliG5KRLbNJ4GKr1ElxUe5KgF6kJCW+G6Rwjq+uJKbtNfPVPyse+UPM10M1OgyVjAwUBgNOd/y8gadm7P+ha49BR3CTVGIBZWDBhNPsGkqn2TGDhYpjIQfK0gAUFW+yhlsrTQs6tfDmdiZcYioBG3rJN9EXPtw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787556113; c=relaxed/simple;
	bh=cIhWPX+ui6Rh8uvr1g7741xdpHXLjlRVhjqEEKPb+f0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ORze0/fASveFCNdtE31yhK1JMCwll6k2K8GvSH2/e829H2MY+IXZ9znva2/c4D5tFdWY7gkWLDZtgKPVL56O0UJHKu3DbK5ygNL6UQnC67Ljc5VoBHBPEQ9YgPkCZSCqbW4iF5L8lskJ3IO/xAamoqlDTKHmM9+aw62NRoHDP0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DO+5+gxg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO+5+gxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0711F000E9;
	Mon, 24 Aug 2026 07:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787556112;
	bh=Rh2CIltUR5+WYRDTJN21L/giOGK9b70oS5Bk3Ziw9GA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DO+5+gxgHr0Rjsi8AOdNy5UM/go7gjMBTDSAcNq7oDUBefBFb2VDQ8rKU9DGW/Uo4
	 jB9atiw8oPv4LYhAZFiJIpek0rhBZHLwN3hwc7QDnNYq47l+u5tMkNMqdvz/C/3XXM
	 oeCM16yoyC3qe3+AnqMxj/754OC/5Yb3FeQE0VPdUvnr7bZQ0V7K5xRpQHUiY0Gfiw
	 6UrJLqIh9bj37hLWbpJBEJi94eJXbjbdvU2mylhPozoYfT0Nf9vd0TUVeVkPBS16co
	 o4cDefwF7nSGkab4M3HnJlZbLImVNRPCpeVIMKqJ2KW7obFceADH9jCJ0RaN4Gv7GV
	 FByba8jnqqdVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v4 5/5] selftests/bpf: Update sockmap tests
 for MPTCP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <1cb449fc7531df4bade69ee95cbbe217db85c1cb.1787554581.git.tanggeliang@kylinos.cn>
References: <cover.1787554581.git.tanggeliang@kylinos.cn>
 <1cb449fc7531df4bade69ee95cbbe217db85c1cb.1787554581.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 07:21:51 +0000
Message-Id: <20260824072152.1D0711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Incomplete test conversion for `test_sockmap_with_mptcp` that co=
ntradicts the commit message.

Pre-existing issues:
- [High] Unchecked `skb_pull()` in `mptcp_read_skb()` causes a kernel panic=
 if the partial read offset exceeds the linear data length.
--

--- Patch [5]: [PATCH mptcp-next v4 5/5] selftests/bpf: Update sockmap test=
s for MPTCP ---
commit a45d03b16d520c3cfcda9a50c975aef36b416a66
Author: Geliang Tang <geliang@kernel.org>

selftests/bpf: Update sockmap tests for MPTCP

This commit updates sockmap tests to reflect new MPTCP support. It allows
MPTCP sockets in sockmap and adjusts the test expectations. It also adds
explicit map updates for server_fd1 and server_fd2 since sockops fires on T=
CP
subflows which return -EOPNOTSUPP for MPTCP connections.

> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testi=
ng/selftests/bpf/prog_tests/mptcp.c
> index d77c9f8c53c75..4f8727dbcbfd0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
[ ... ]
> @@ -500,30 +500,36 @@ static void test_subflow(void)
[ ... ]
>  	server_fd1 =3D accept(listen_fd, NULL, 0);
> +	err =3D bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
> +				  &zero, &server_fd1, BPF_NOEXIST);
> +	if (!ASSERT_OK(err, "sockmap:add server_fd1"))
> +		goto end;
> +
>  	skel->bss->sk_index =3D 1;
>  	client_fd2 =3D connect_to_fd_opts(listen_fd, NULL);
> -	if (!ASSERT_OK_FD(client_fd2, "sockmap-fb:connect_to_fd"))
> +	if (!ASSERT_OK_FD(client_fd2, "sockmap:connect_to_fd"))
>  		goto end;
> =20
>  	server_fd2 =3D accept(listen_fd, NULL, 0);

[Severity: Medium]
Does this code miss the changes for client_fd2 and server_fd2 that were
mentioned in the commit message?

The commit message states:
"Add server_fd1 and server_fd2 to the sockmap explicitly from userspace via
bpf_map_update_elem() instead of relying on the sockops program."

However, that map update appears to be missing here for server_fd2.

Additionally, client_fd2 is still created using connect_to_fd_opts() with
NULL options, creating a TCP fallback socket rather than an MPTCP socket.
Should client_fd2 also be converted to use connect_to_fd(listen_fd, 0) to
fully test the MPTCP support for the second socket pair?


[Severity: High]
This is a pre-existing issue, but can the unchecked skb_pull() in
mptcp_read_skb() located in net/mptcp/protocol.c cause a kernel panic?

If a user creates an MPTCP socket, receives a packet where the payload is
stored in page fragments, reads a partial amount of data, and then attaches
the socket to a sockmap, mptcp_read_skb() can be invoked.

net/mptcp/protocol.c:mptcp_read_skb() {
    ...
        if (offset)
            skb_pull(skb, offset);
    ...
}

If the partial read offset exceeds the linear data length, the skb_pull() c=
all
without prior bounds checking will trigger a BUG() inside __skb_pull(). Sho=
uld
this offset be validated against the available linear region before pulling?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787554581.gi=
t.tanggeliang@kylinos.cn?part=3D5
