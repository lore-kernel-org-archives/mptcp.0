Content-Type: multipart/mixed; boundary="===============1789402798144593050=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 3/3] Squash-to: "selftests: add test-cases for
 MPTCP MP_JOIN"
Date: Tue, 17 Mar 2020 16:00:15 -0700
Message-ID: <alpine.OSX.2.22.394.2003171559560.25711@fvaldivi-mobl1.amr.corp.intel.com>
In-Reply-To: 78a193c9d8dcc2f27ec3022c4527effadefcda9c.1584370791.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3973

--===============1789402798144593050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 16 Mar 2020, Paolo Abeni wrote:

> ADD_ADDR opt may be delayed till the very end of [short] MPTCP
> connection, so ADD_ADDR related self-tests can sometimes fail.
>
> Leave some additional time before closing the connection,
> to catch this late messages
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> tools/testing/selftests/net/mptcp/mptcp_connect.c | 11 +++++++++--
> tools/testing/selftests/net/mptcp/mptcp_join.sh   |  8 ++++++--
> 2 files changed, 15 insertions(+), 4 deletions(-)
>

Looks good to me, thanks Paolo.

--
Mat Martineau
Intel
--===============1789402798144593050==--
