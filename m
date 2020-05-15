Content-Type: multipart/mixed; boundary="===============0771010551608041625=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 3/3] mptcp: cope better with MP_JOIN
 failure
Date: Fri, 15 May 2020 11:10:05 -0700
Message-ID: <alpine.OSX.2.22.394.2005151109510.36555@rasanche-mobl.amr.corp.intel.com>
In-Reply-To: 4dc2d07bafebc2dde162fe1dc1c25f0c4cb602e1.1589558049.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4400

--===============0771010551608041625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 15 May 2020, Paolo Abeni wrote:

> Currently, on MP_JOIN failure we reset the child
> socket, but leave the request socket untouched.
>
> tcp_check_req will deal with it according to the
> 'tcp_abort_on_overflow' sysctl value - by default the
> req socket will stay alive.
>
> The above leads to inconsistent behavior on MP JOIN
> failure, and bad listener overflow accounting.
>
> This patch addresses the issue leveraging the infrastructure
> just introduced to ask the TCP stack to drop the req on
> failure.
>
> The child socket is not freed anymore by subflow_syn_recv_sock(),
> instead it's moved to a dead state and will be disposed by the
> next sock_put done by the TCP stack, so that listener overflow
> accounting is not affected by MP JOIN failure.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> Reviewed-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
> net/mptcp/subflow.c | 15 +++++++++------
> 1 file changed, 9 insertions(+), 6 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============0771010551608041625==--
