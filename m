Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795784761;
	b=c2pXeGxvyKsGcV5QwLCYQPyYS/kN5jkthOtCxypN6et6xD37ga0mUi2UR8J45JXtHZLC
	 kPo3c2i3B2Pm8CbTcqeygX6BTTfbkuXZ1wznU8WVe4AXnDKjNs7fCCh3sNz4ktXz77s5l
	 ogEUg9MY4XEQjo2eHqs/rNMrgQb5ukTGx6dy+HAHnZfkDoFLqfZKRn8RZp1b9uKlGUbSx
	 xoOLnNPiVbU4LjcpbYZylucC9hClsOqQwpcUXwHvDhlJ3/qVYY/iAAIZnYq4JCftV5Mpy
	 7vmtHF6B+Wcakixe+ovpbkwWD6qkEYe5qGG9krBteU+uoj8H/NglWLIZ+g0ahzeCKpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795784761;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hYCn48p/fRfMl+LxYCSXtOeWwRJU2kYuk9rnREXaAJ8=;
	b=xMeQ+nItVzLwjesmPFSJtSHhEm4+ImcWU9VumKLKSnMhFEcHrH6K2EViqLCd1GeBpSn6
	 QaPPc2vQ7senxAXH45PoDYci7fNTzBcNgAloMui66bWZv+KthtjFfgGBhQSmlBJduJ4sy
	 pauZ5TjSQxNKVaeIeWMRUi9l4x8CSX7jfTotJZuOqucepNL5f2D5iIjUNBf/gGm6O2GDa
	 rRnw0+hyVFzZ71U+0rHrQCGfcP2JOdGpbof8P5SL6jiEcoY+b4/q9Tdj/tZsncs9o18ZE
	 tEiahT5eo45Bt8cwWUCWPfLRqSjyjGDSNnEAyWZyZpZ0G9RRFUV6m9KglQ50dh9OCUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+f3ILtf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BE1606A321
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+f3ILtf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8680F1F000C1;
	Fri, 27 Nov 2026 13:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795784760;
	bh=hYCn48p/fRfMl+LxYCSXtOeWwRJU2kYuk9rnREXaAJ8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=i+f3ILtfRgesECRqJT3a1SwPYRkW1r9tbltF0TbUoUVN+Q37eYsNO6Jm3fmmMs2kY
	 s4dTxuPWN+FfW9vqCpMVOuKexXep91Maq5WSefxazpES/wQckihhA0+GZsAgya17Sz
	 DZxMTWso9reP1c7Z9/kfRtqVkVZD7JKjq3UpW2miaIGV4xQnNnfeJN50HmGtZ0OY4a
	 e2zEu3XgsYQzdn8vWRZAHJHow2xwpabhQAA1zFbJCZb8/TlPo8lkpPfE6rbY523edv
	 BfC/meNNumCIgDooR/p4HbVKexmdB1c3onNDbXlIDXcR29KRyJTzv74rM0H5+9pzuY
	 Hc+KmiJi1H7Qw==
Message-ID: <sashiko-outbox-237461@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v11 7/7] selftests: mptcp: cover msg_zerocopy
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <52f67bef0305ff81d900244811035f639a16bd05.1795783388.git.tanggeliang@kylinos.cn>
References: <cover.1795783388.git.tanggeliang@kylinos.cn>
 <52f67bef0305ff81d900244811035f639a16bd05.1795783388.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 13:06:00 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] mptcp: missing skb zerocopy tracking in mptcp_sendmsg_frag()
  without SG
- [Medium] mptcp: broken zerocopy handling for fastopen in
  mptcp_sendmsg()
- [Low] selftests: mptcp: pass -z before positional test arg in
  msg_zerocopy.sh
--

commit f03babdacde6ac2c280f3aacb29db133993b9706
Author: Geliang Tang <geliang@kernel.org>

selftests: mptcp: cover msg_zerocopy test

This commit adds a msg_zerocopy.sh wrapper script and build rules to the
MPTCP selftest suite to run the net msg_zerocopy test when MPTCP zerocopy
is supported.

> diff --git a/tools/testing/selftests/net/mptcp/msg_zerocopy.sh b/tools/te=
sting/selftests/net/mptcp/msg_zerocopy.sh
> new file mode 100755
> index 0000000000000..de2807df225a0
> --- /dev/null
> +++ b/tools/testing/selftests/net/mptcp/msg_zerocopy.sh
> @@ -0,0 +1,15 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +. "$(dirname "${0}")/mptcp_lib.sh"
> +
> +mptcp_lib_check_mptcp
> +
> +BIN=3D"$(dirname "${0}")/msg_zerocopy"
> +if ! "${BIN}" -4 -t 1 check || ! "${BIN}" -4 -t 1 check -z; then

[Severity: Low]
Does passing -z after check fail in parse_opts() when getopt() does not
permute argv (such as with musl libc or POSIXLY_CORRECT)?

tools/testing/selftests/net/msg_zerocopy.c:parse_opts() stops option
parsing at the non-option argument check and requires optind =3D=3D argc - =
1,
aborting via usage() when -z trails the positional test name.  The same
"${BIN} -4 -t 1 check -z" argument order appears in commit "selftests:
net: msg_zerocopy: add MPTCP support" in
tools/testing/selftests/net/msg_zerocopy.sh; passing -z before check
("${BIN}" -4 -t 1 -z check) avoids both failures.

> +	mptcp_lib_pr_skip "MPTCP zerocopy not supported"
> +	mptcp_lib_fail_if_expected_feature "MPTCP zerocopy"
> +	exit "${KSFT_SKIP}"
> +fi
> +
> +exec "$(dirname "${0}")/../msg_zerocopy.sh" "$@"

[Severity: High]
In commit "mptcp: add MSG_ZEROCOPY support" earlier in this series, does
mptcp_sendmsg_frag() attach a pinned user page to the subflow skb without
zerocopy tracking when the subflow route lacks NETIF_F_SG?

net/mptcp/protocol.c:mptcp_sendmsg_frag() {
	...
	} else {
		get_page(dfrag->page);
		skb_fill_page_desc(skb, i, dfrag->page, offset, copy);

		if (dfrag->ubuf && !skb_zcopy(skb) &&
		    ssk->sk_route_caps & NETIF_F_SG) {
			skb_zcopy_set(skb, dfrag->ubuf, NULL);
			skb_shinfo(skb)->flags |=3D SKBFL_PURE_ZEROCOPY;
			zc =3D true;
		}
	}
	...
}

mptcp_sendmsg_zerocopy_iter() pins the user page into dfrag->page without
checking subflow NETIF_F_SG, and mptcp_sendmsg_frag() unconditionally adds
dfrag->page to the skb.  When ssk->sk_route_caps does not have NETIF_F_SG,
skb_zcopy_set() is skipped, so the skb holds a reference to the user page
with no ubuf reference or SKBFL_ZEROCOPY_FRAG flag: dfrag_clear() can
complete the zerocopy notification while the skb still references the user
page, and skb_orphan_frags_rx() skips skb_copy_ubufs() on local delivery.

[Severity: Medium]
Also in commit "mptcp: add MSG_ZEROCOPY support", does the fastopen path
in mptcp_sendmsg() mishandle ubuf for both MSG_FASTOPEN and DEFER_CONNECT?

net/mptcp/protocol.c:mptcp_sendmsg() {
	...
	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
		     msg->msg_flags & MSG_FASTOPEN)) {
		int copied_syn =3D 0;

		if (zc && (msg->msg_flags & MSG_FASTOPEN)) {
			uarg_to_msgzc(ubuf)->zerocopy =3D 0;
			zc =3D false;
		}

		ret =3D mptcp_sendmsg_fastopen(sk, msg, len, &copied_syn,
					     zc ? ubuf : NULL);
		copied +=3D copied_syn;
		if (ret =3D=3D -EINPROGRESS && copied_syn > 0)
			goto out;
	...
}

When MSG_FASTOPEN is set, clearing zc before the call makes zc ? ubuf :
NULL evaluate to NULL, so tcp_send_syn_data() takes no reference on ubuf
and the goto out path drops the only reference via net_zcopy_put(ubuf),
queuing the completion notification before the SYN data is acknowledged.
When DEFER_CONNECT (TCP_FASTOPEN_CONNECT) is used without MSG_FASTOPEN,
uarg_to_msgzc(ubuf)->zerocopy remains 1 even though tcp_send_syn_data()
copies the SYN payload into a kernel page frag, so the completion
notification omits SO_EE_CODE_ZEROCOPY_COPIED.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795783388.gi=
t.tanggeliang@kylinos.cn?part=3D7
