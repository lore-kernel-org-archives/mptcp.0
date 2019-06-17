Content-Type: multipart/mixed; boundary="===============4162403560293027646=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/3] MP_JOIN handling: v3 from Peter
Date: Mon, 17 Jun 2019 22:42:14 +0200
Message-ID: <404bf12b126e7b5def2ca096eeb256f4680aa634.camel@redhat.com>
In-Reply-To: 20190617141142.6782-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1421

--===============4162403560293027646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 2019-06-17 at 16:11 +0200, Matthieu Baerts wrote:
> Peter recently sent a v3 of his patch-set but I had already applied it in=
 the
> repo. Here is what I extracted from the v3 using diff.
> =

> If Paolo (or others) is OK, I can include this in what we are going to se=
nd to
> Eric.
> =

> Peter Krystad (3):
>   squash to: mptcp: Add path manager interface
>   squash to: mptcp: Add ADD_ADDR handling
>   squash to: mptcp: Add handling of incoming MP_JOIN requests
> =

>  include/linux/tcp.h  |  9 +++++--
>  include/net/mptcp.h  |  6 +++--
>  net/mptcp/options.c  | 56 +++++++++++++++++++++-----------------------
>  net/mptcp/pm.c       | 23 +++++++++---------
>  net/mptcp/protocol.c |  2 +-
>  net/mptcp/protocol.h |  9 +++++++
>  net/mptcp/subflow.c  |  9 ++++---
>  7 files changed, 65 insertions(+), 49 deletions(-)
> =


I'm unable to give a real review, because I'm currently relocating (yep
in 2 days will leave the family alone in the worse possible caos -
that's true love ;)

Anyhow it LGTM with a very cursory look,

Cheers,

Paolo


--===============4162403560293027646==--
