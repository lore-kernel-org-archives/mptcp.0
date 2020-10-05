Content-Type: multipart/mixed; boundary="===============0656292230342666928=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: don't skip needed ack
Date: Mon, 05 Oct 2020 14:59:39 -0700
Message-ID: <alpine.OSX.2.23.453.2010051459040.9753@srinathb-mobl.amr.corp.intel.com>
In-Reply-To: 515e80a174ee9bad5e2c6a8338d9362eb43d39b7.1601894086.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6206

--===============0656292230342666928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Oct 2020, Paolo Abeni wrote:

> Currently we skip calling tcp_cleanup_rbuf() when packets
> are moved into the OoO queue or simply dropped. In both
> cases we still increment tp->copied_seq, and we should
> ask the TCP stack to check for ack.
>
> Fixes: c76c6956566f ("mptcp: call tcp_cleanup_rbuf on subflows")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============0656292230342666928==--
