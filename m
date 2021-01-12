Content-Type: multipart/mixed; boundary="===============3151085889908236068=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 1/4] mptcp: always graft subflow
 socket to parent.
Date: Mon, 11 Jan 2021 16:42:30 -0800
Message-ID: <39fa217b-b82a-762a-df80-fc0748f9499@linux.intel.com>
In-Reply-To: 7dd1113da19bbf0c033fcb1046430c4d074edd31.1610359105.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7317

--===============3151085889908236068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Jan 2021, Paolo Abeni wrote:

> Currently incoming subflow uses link to the parent socket,
> while outgoing one link to a per subflow socket. The latter
> is not really needed, except at initial connect() time and
> for the first subflow.
>
> Always graft the outgoing subflow to the parent socket and
> free the unneeded ones early.
>
> This allows some code cleanup, reduces the amount of memory
> used and will simplify the next patch
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 36 ++++++++++--------------------------
> net/mptcp/protocol.h |  1 +
> net/mptcp/subflow.c  |  3 +++
> 3 files changed, 14 insertions(+), 26 deletions(-)
>

Looks good to me, appreciate the cleanup and it's good to reduce the =

differences between incoming and outgoing sockets.

--
Mat Martineau
Intel
--===============3151085889908236068==--
