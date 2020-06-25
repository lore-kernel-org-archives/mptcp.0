Content-Type: multipart/mixed; boundary="===============0949640020837526307=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/3] mptcp: msk diag support
Date: Thu, 25 Jun 2020 12:37:06 +0200
Message-ID: <0a80b8cc6c3947f494c21ce90a3e71d2bb875543.camel@redhat.com>
In-Reply-To: cover.1593080104.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4803

--===============0949640020837526307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-06-25 at 12:22 +0200, Paolo Abeni wrote:
> This introduces basic mptcp sockets diag support.
> As IPPROTO_MPTCP excedes 8 bits, we need some changes at the inet_diag le=
vel:
> a new attribute is introduced to allow user-space providing u32 protocol
> values.
> =

> Patch 2 introduces new token APIs to allow traversing the existing msks, =
while
> patch 3 bring in the actual diag implementation.
> =

> Paolo Abeni (3):
>   inet_diag: support for wider protocol numbers
>   mptcp: add msk interations helpers
>   mptcp: add MPTCP socket diag interface
> =

>  include/uapi/linux/inet_diag.h |   1 +
>  include/uapi/linux/mptcp.h     |  15 ++++
>  net/core/sock.c                |   1 +
>  net/ipv4/inet_diag.c           |  63 +++++++++----
>  net/mptcp/Kconfig              |   4 +
>  net/mptcp/Makefile             |   2 +
>  net/mptcp/mptcp_diag.c         | 160 +++++++++++++++++++++++++++++++++
>  net/mptcp/options.c            |   6 +-
>  net/mptcp/protocol.h           |   3 +
>  net/mptcp/token.c              |  83 +++++++++++++++++
>  10 files changed, 318 insertions(+), 20 deletions(-)
>  create mode 100644 net/mptcp/mptcp_diag.c

Additional note: I'll try do add some basic functional self-tests using
mptcp_connect and iproute2 tool. Will create a new script in the mptcp
self-tests dir

/P

--===============0949640020837526307==--
