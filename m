Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFF843932C
	for <mptcp@lists.linux.dev>; Thu,  9 Jul 2026 05:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575793; cv=none; b=s2J4wksZkcjQewNbVY1Dllu3bt0NtWac7JEhJzm1yNix2QoWqvaaZfEWrf2bSbO7JmRkHbRPgWnntSP4pAq9Oe17GIj18RNEjYTZ75doADZqjhi1GjFimom29bEGsBHBQL2L7ZIEpEAaLtVNK+JF1yRS5ARR2ZU0urM52eXM5qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575793; c=relaxed/simple;
	bh=6h5p7n5No64QiJEYCYCEU+E9AgD/KFjcbLGyq0ar2ak=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Xs3j3AWZUc8VTVyQGOF72lJODcbcQIuC5bLl1zXbLi3yamHfri4t91dPu85nE+ux/NIvmdOnLGHPVnDz/AV9qfpSonNfCZV6+Q4rjSBWo2daaMw3c0vV2AMJiwPFgaKrvptgxIYi+CbS6qLRKjeIHRSdyWQQOyPWPZJyE+AMmT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gjsb3iVN; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gjsb3iVN"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783575788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OifTvRzURu2dVot9IJ7DSNor84sK2OfO99KNA1PqW3o=;
	b=gjsb3iVNpJg/gmcCx0Qy34R7WBozs3vsPK68JOyg0MagmcNwIFUdHKAhk5RsQVcMXghLDw
	tp+20OZUINZu6ZR8ZPElq2PdqMK/UlIrl5nJOKYjUVv6dB2RgilM3FFLUrd/g6/MwnL3QL
	8RDGR/CLBTvt6R47KXfJ8MyOaSELXyY=
Date: Thu, 09 Jul 2026 05:43:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <8155514655323d8c4a07da86d2b2ccdd7244c125@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] mptcp: only set DATA_FIN when a mapping is present
To: "Michael Bommarito" <michael.bommarito@gmail.com>, "Matthieu Baerts"
 <matttbe@kernel.org>, "Mat Martineau" <martineau@kernel.org>
Cc: "Geliang Tang" <geliang@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 mptcp@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260707171730.2679013-1-michael.bommarito@gmail.com>
References: <2edcb1cd-f2db-4d0c-a0e3-fd2b4dd820fe@redhat.com>
 <20260707171730.2679013-1-michael.bommarito@gmail.com>
X-Migadu-Flow: FLOW_OUT

July 8, 2026 at 1:17 AM, "Michael Bommarito" <michael.bommarito@gmail.com=
 mailto:michael.bommarito@gmail.com?to=3D%22Michael%20Bommarito%22%20%3Cm=
ichael.bommarito%40gmail.com%3E > wrote:

Hi Michael

Thanks for the patch.


>=20
>=20mptcp_get_options() clears only the status group of struct
> mptcp_options_received; data_seq, subflow_seq and data_len are filled i=
n
> by mptcp_parse_option() exclusively inside the DSS mapping block, which
> runs only when the DSS M (mapping present) bit is set.
>=20
>=20A peer can send a DSS option with the DATA_FIN flag set but the mappi=
ng
> bit clear. The parser then records mp_opt->data_fin while leaving
> data_len and data_seq uninitialized. For a zero-length segment
> mptcp_incoming_options() evaluates
>=20
>=20 if (mp_opt.data_fin && mp_opt.data_len =3D=3D 1 &&
>  mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))
>=20
>=20which reads the uninitialized data_len and data_seq; KMSAN reports an
> uninit-value in mptcp_incoming_options(). The stale data_seq can also b=
e
> fed into the receive-side DATA_FIN sequence tracking.
>=20
>=20Record the DATA_FIN flag only when the DSS option carries a mapping, =
so
> data_fin is never set without data_seq and data_len also being present.
> data_fin is part of the status group that mptcp_get_options() clears up
> front, so on the no-map path it stays zero and the zero-length DATA_FIN
> branch is simply skipped. A DATA_FIN is always transmitted together wit=
h
> a mapping (mptcp_write_data_fin() sets use_map along with data_seq and
> data_len), so legitimate DATA_FIN handling is unaffected.
>=20
>=20Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state ma=
chine")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> v2: adopt Paolo Abeni's suggested approach - do not set mp_opt->data_fi=
n
>  at all unless a mapping is present, rather than gating the consumer in
>  mptcp_incoming_options() (v1). data_fin then defaults to the value
>  mptcp_get_options() already clears it to (0) on the no-map path, so
>  the uninitialized data_len/data_seq are never read.
>=20
>=20 net/mptcp/options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
>=20diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index dff3fd5d3b559..6d003b24b969f 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -157,7 +157,6 @@ static void mptcp_parse_option(const struct sk_buff=
 *skb,
>  ptr++;
>=20
>=20 flags =3D (*ptr++) & MPTCP_DSS_FLAG_MASK;
> - mp_opt->data_fin =3D (flags & MPTCP_DSS_DATA_FIN) !=3D 0;
>  mp_opt->dsn64 =3D (flags & MPTCP_DSS_DSN64) !=3D 0;
>  mp_opt->use_map =3D (flags & MPTCP_DSS_HAS_MAP) !=3D 0;
>  mp_opt->ack64 =3D (flags & MPTCP_DSS_ACK64) !=3D 0;
> @@ -178,6 +177,7 @@ static void mptcp_parse_option(const struct sk_buff=
 *skb,
>  }
>=20
>=20 if (mp_opt->use_map) {
> + mp_opt->data_fin =3D (flags & MPTCP_DSS_DATA_FIN) !=3D 0;
>  if (mp_opt->dsn64)
>  expected_opsize +=3D TCPOLEN_MPTCP_DSS_MAP64;
>  else

One minor thing I noticed while reviewing: Sashiko previously pointed out
in a comment that the 'pr_debug' logging 'mp_opt->data_fin' might be
problematic because it's printed before data_fin is actually assigned
(since data_fin is now set only inside the if (mp_opt->use_map) block).=
=20

I=20think it would be cleaner to move the pr_debug call after the data_fi=
n
assignment, so the logged value is always meaningful and consistent with
the actual parsed state, like:

'''
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b924209a9b74..f58eb24f4d35 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -162,11 +162,6 @@ static void mptcp_parse_option(const struct sk_buff =
*skb,
                mp_opt->ack64 =3D (flags & MPTCP_DSS_ACK64) !=3D 0;
                mp_opt->use_ack =3D (flags & MPTCP_DSS_HAS_ACK);
=20
-=20              pr_debug("data_fin=3D%d dsn64=3D%d use_map=3D%d ack64=
=3D%d use_ack=3D%d\n",
-                        mp_opt->data_fin, mp_opt->dsn64,
-                        mp_opt->use_map, mp_opt->ack64,
-                        mp_opt->use_ack);
-
                expected_opsize =3D TCPOLEN_MPTCP_DSS_BASE;
=20
=20               if (mp_opt->use_ack) {
@@ -184,6 +179,11 @@ static void mptcp_parse_option(const struct sk_buff =
*skb,
                                expected_opsize +=3D TCPOLEN_MPTCP_DSS_MA=
P32;
                }
=20
+=20              pr_debug("data_fin=3D%d dsn64=3D%d use_map=3D%d ack64=
=3D%d use_ack=3D%d\n",
+                        mp_opt->data_fin, mp_opt->dsn64,
+                        mp_opt->use_map, mp_opt->ack64,
+                        mp_opt->use_ack);
+
                /* Always parse any csum presence combination, we will en=
force
                 * RFC 8684 Section 3.3.0 checks later in subflow_data_re=
ady
                 */
'''

This change isn't critical to the fix itself, so feel free to let Paolo/M=
att and
other Maintainers decide if it should go in now, later, or not at all.

A couple of additional notes for future submissions (just friendly remind=
ers):

- The subject-prefix convention for MPTCP patches is typically [PATCH mpt=
cp-net]
  for bug fixes targeting the net tree, or [PATCH mptcp-next] for new fea=
tures.
  Since this is a fix, something like [PATCH mptcp-net v2] would be more =
appropriate.

- It's also helpful to include a Link: to the previous version (v1) in th=
e changelog,
  so reviewers can easily track the discussion history.

Looking forward to seeing more of your work on the MPTCP mailing list!

Thanks,
Gang
> --
> 2.53.0
>
