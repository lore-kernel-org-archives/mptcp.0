Content-Type: multipart/mixed; boundary="===============7346593587541442226=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] net: mptcp: improve fallback to TCP
Date: Tue, 16 Jun 2020 16:18:02 +0200
Message-ID: <6c04233494742fb42935ebf4d8617cf8bbf736a9.camel@redhat.com>
In-Reply-To: 99da6ce722b8af16ea76e57ca8d1bf5d13fc14c1.1592250531.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4699

--===============7346593587541442226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-06-15 at 21:54 +0200, Davide Caratti wrote:
> keep using MPTCP sockets and a use "dummy mapping" in case of fallback to
> regular TCP. When fallback is triggered, skip addition of the MPTCP option
> on send.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/11
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/22
> Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
>  net/mptcp/options.c  |  9 ++++-
>  net/mptcp/protocol.c | 81 ++++++++++----------------------------------
>  net/mptcp/protocol.h | 34 +++++++++++++++++++
>  net/mptcp/subflow.c  | 47 ++++++++++++++++---------
>  4 files changed, 91 insertions(+), 80 deletions(-)

forgot to mention, this patch is code-wise the same as the one alrready
merged. Just the commit message is changed (and 'BugLink:' tags converted
in 'Closes:').

-- =

davide

--===============7346593587541442226==--
