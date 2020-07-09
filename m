Content-Type: multipart/mixed; boundary="===============3964328816265069295=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: add MPTCP socket diag
 interface"
Date: Thu, 09 Jul 2020 10:45:12 +0200
Message-ID: <8565ec49-b999-3411-ec51-eb3157e72d53@tessares.net>
In-Reply-To: 20200707171327.180346-1-pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4955

--===============3964328816265069295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Davide,

On 07/07/2020 19:13, Paolo Abeni wrote:
> Davide reported build issues when compiling without
> CONFIG_MPTCP_KUNIT_TESTS. We need to always export
> mptcp_token_get_sock(), for diag's sake.
> =

> The following text should be inserted into the squash to
> commit:
> """
> Additionally export mptcp_token_get_sock(), as it
> also will be used by the diag module.
> """
> =

> just before:
> """
> It will be used by the next patch, but keep the API generic,
> as we plan to use this later for PM's sake.
> """

Thank you for the patch and the instructions!

I guess you wanted me to squash the patch in "mptcp: add msk interations =

helper" commit, not in "mptcp: add MPTCP socket diag interface", right?

- 9b8b971fb7cb: "squashed" in "mptcp: add msk interations helper"
- 5ed0672e64fa: tg:msg: info about mptcp_token_get_sock()
- 287977a070ee..e08dbaf46bc8: result

Tests and export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3964328816265069295==--
