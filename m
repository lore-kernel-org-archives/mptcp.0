Content-Type: multipart/mixed; boundary="===============7017073978327107020=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 1/6] mptcp: open code mptcp variant for
 lock_sock
Date: Mon, 30 Nov 2020 15:43:07 -0800
Message-ID: <97e78fe-e4aa-cf9f-f76f-1746df5b5eb4@linux.intel.com>
In-Reply-To: fd92953c74dde2aa43d34fcdb681392f1a481d1a.1606413118.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6992

--===============7017073978327107020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Nov 2020, Paolo Abeni wrote:

> This allows invoking an additional callback under the
> socket spin lock.
>
> Will be used by the next patches to avoid additional
> spin lock contention.
>
> Acked-by: Florian Westphal <fw(a)strlen.de>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> include/net/sock.h   |  1 +
> net/core/sock.c      |  2 +-
> net/mptcp/protocol.h | 13 +++++++++++++
> 3 files changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============7017073978327107020==--
