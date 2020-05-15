Content-Type: multipart/mixed; boundary="===============6014367845933004911=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 1/3] mptcp: add new sock flag to deal
 with join subflows
Date: Fri, 15 May 2020 11:09:04 -0700
Message-ID: <alpine.OSX.2.22.394.2005151108130.36555@rasanche-mobl.amr.corp.intel.com>
In-Reply-To: a5acf97e4f39de13ba178a3a007eedd83b418702.1589558049.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4398

--===============6014367845933004911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 15 May 2020, Paolo Abeni wrote:

> MP_JOIN subflows must not land into the accept queue.
> Currently tcp_check_req() calls an mptcp specific helper
> to detect such scenario.
>
> Such helper leverages the subflow context to check for
> MP_JOIN subflows. We need to deal also with MP JOIN
> failures, even when the subflow context is not available
> due allocation failure.
>
> A possible solution would be changing the syn_recv_sock()
> signature to allow returning a more descriptive action/
> error code and deal with that in tcp_check_req().
>
> Since the above need is MPTCP specific, this patch instead
> uses a TCP request socket hole to add a MPTCP specific flag.
> Such flag is used by the MPTCP syn_recv_sock() to tell
> tcp_check_req() how to deal with the request socket.
>
> This change is a no-op for !MPTCP build, and makes the
> MPTCP code simpler. It allows also the next patch to deal
> correctly with MP JOIN failure.
>
> v1 -> v2:
> - be more conservative on drop_req initialization (Mat)
>
> RFC -> v1:
> - move the drop_req bit inside tcp_request_sock (Eric)
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> include/linux/tcp.h      |  3 +++
> include/net/mptcp.h      | 17 ++++++++++-------
> net/ipv4/tcp_minisocks.c |  2 +-
> net/mptcp/protocol.c     |  7 -------
> net/mptcp/subflow.c      |  3 +++
> 5 files changed, 17 insertions(+), 15 deletions(-)
>

Thanks for the initialization fix, patch looks good.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============6014367845933004911==--
