Content-Type: multipart/mixed; boundary="===============2626945699172767359=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 2/2] mptcp: drop MP_JOIN request sock on syn
 cookies
Date: Wed, 17 Jun 2020 11:14:28 -0700
Message-ID: <alpine.OSX.2.22.394.2006171113260.1663@mjmartin-mac01.local>
In-Reply-To: 3aff0acec0b89a55fdae02194036f34be56b545c.1592388398.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4721

--===============2626945699172767359==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jun 2020, Paolo Abeni wrote:

> Currently any MPTCP socket using syn cookies will fallback to
> TCP at 3rd ack time. In case of MP_JOIN requests, the RFC mandate
> closing the child and sockets, but the existing error paths
> do not handle the syncookie scenario correctly.
>
> Address the issue always forcing the child shutdown in case of
> MP_JOIN fallback.
>
> Fixes: ae2dd7164943 ("mptcp: handle tcp fallback when using syn cookies")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/subflow.c | 18 ++++++++++--------
> 1 file changed, 10 insertions(+), 8 deletions(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============2626945699172767359==--
