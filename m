Content-Type: multipart/mixed; boundary="===============1139486131792806193=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 2/4] mptcp: cleanup fallback handling
Date: Tue, 10 Dec 2019 17:29:16 -0800
Message-ID: <alpine.OSX.2.21.1912101708280.2679@mmazumd1-mobl.amr.corp.intel.com>
In-Reply-To: ce07ef989e196a098b4eb81822b350db3a346325.1575999260.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2869

--===============1139486131792806193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Dec 2019, Paolo Abeni wrote:

> The 'fallback' field has many different meanings:
> tcp fallback socket, first subflow, listening socket.
> Enforcing the correct usage is not easy - currently we have
> several problems:
>
> 1) this will fail, but it should not:
> fd =3D socket(AF_INET{,6}, SOCK_STREAM, MPTCP_PROTO);
> setsockopt(fd, SOL_IP{,V6}, //...) =3D -1 EOPNOTSUPP (Operation not suppo=
rted)
>
> 2) this will report success, but it should not:
> fd =3D socket(AF_INET{,6}, SOCK_STREAM, MPTCP_PROTO);
> connect(fd, //)
> bind(fd, //) =3D 0
>
> 3) this will report success, but it should not:
> fd =3D socket(AF_INET{,6}, SOCK_STREAM, MPTCP_PROTO);
> listen(fd, // )
> s =3D accept(fd, )
> bind(s, ...) =3D 0
>

It would be good to add these problems to the self tests! Not considering =

that a blocker for merging this patch, though.

Patch otherwise looks good, thanks for the readability fixes.

Mat


> This patch:
>
> - explicitly handle the msk socket status in some missing places
> - wrap msk->subflow access with helpers describing the expected
>  semantic
> - use the above to enforce correct syscall behavior
> - create on demand the subflow socket for setsockopt(), if possible
>
> v1 -> v2:
> - use MPTCP_SAME_STATE macro (Mat)
> - drop dumb comment (Mat)
>
> RFC -> v1:
> - drop __mptcp_first_socket() helper, always use __mptcp_nmpc_socket()
>   instead
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 178 +++++++++++++++++++++++++++----------------
> 1 file changed, 111 insertions(+), 67 deletions(-)
>

--
Mat Martineau
Intel
--===============1139486131792806193==--
