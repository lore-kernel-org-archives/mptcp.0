Content-Type: multipart/mixed; boundary="===============4568722147931298999=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp:diag: prefix exposed items
Date: Mon, 07 Oct 2019 09:25:21 +0200
Message-ID: <e97f7c8e3d5cde18b978f1db9a55bfb576389189.camel@redhat.com>
In-Reply-To: 20191005084906.8960-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2026

--===============4568722147931298999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-10-05 at 10:49 +0200, Matthieu Baerts wrote:
> To conform with the rest.
> =

> And only exposed one init function for diag.c
> =

> Suggested-by: Davide Caratti <dcaratti(a)redhat.com>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
> =

> Notes:
>     To be squashed in "mptcp: allow dumping subflow context to userspace"
>     v2:
>      - MPTCP_SUBFLOW_FLAGS_ -> MPTCP_SUBFLOW_FLAG_ (Davide)
>      - only exposed a new function: mptcp_diag_subflow_init (Davide, Paol=
o)
> =

>  include/uapi/linux/mptcp.h | 18 +++++++++---------
>  net/mptcp/diag.c           | 28 +++++++++++++++++-----------
>  net/mptcp/protocol.h       |  3 +--
>  net/mptcp/subflow.c        |  4 ++--
>  4 files changed, 29 insertions(+), 24 deletions(-)
> =


hello Matthieu,

LGTM, thanks for following up!

-- =

davide


--===============4568722147931298999==--
