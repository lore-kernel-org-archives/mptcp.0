Content-Type: multipart/mixed; boundary="===============1873582936713236252=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 1/6] net: mptcp: improve fallback to TCP
Date: Mon, 29 Jun 2020 16:29:32 -0700
Message-ID: <alpine.OSX.2.23.453.2006291624250.11066@jlbliss-mobl.amr.corp.intel.com>
In-Reply-To: 48551241b592f237f236361276b5b42774d2ba69.1593461586.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4854

--===============1873582936713236252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jun 2020, Davide Caratti wrote:

> Keep using MPTCP sockets and a use "dummy mapping" in case of fallback
> to regular TCP. When fallback is triggered, skip addition of the MPTCP
> option on send.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/11
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/22
> Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
> net/mptcp/options.c  |  9 +++-
> net/mptcp/protocol.c | 98 ++++++++++++--------------------------------
> net/mptcp/protocol.h | 33 +++++++++++++++
> net/mptcp/subflow.c  | 47 +++++++++++++--------
> 4 files changed, 98 insertions(+), 89 deletions(-)
>

Thanks Davide and Paolo! Appreciate the simplification of the fallback =

code.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============1873582936713236252==--
