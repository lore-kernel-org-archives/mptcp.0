Content-Type: multipart/mixed; boundary="===============4854020229786283367=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 1/2] mptcp: more strict state checking for acks
Date: Tue, 12 Jan 2021 13:37:48 -0800
Message-ID: <cf5db42-8431-da6f-422-da51da18a119@linux.intel.com>
In-Reply-To: 5566ba1c4409a652440d84ff49b99e58ca998a0e.1610471474.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7334

--===============4854020229786283367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Jan 2021, Paolo Abeni wrote:

> Syzkaller found a way to trigger division by zero
> in mptcp_subflow_cleanup_rbuf().
>
> The current checks implemented into tcp_can_send_ack()
> are too week, let's be more accurate.
>
> Reported-by: Christoph Paasch <cpaasch(a)apple.com>
> Fixes: ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling")
> Fixes: fd8976790a6c ("mptcp: be careful on MPTCP-level ack.")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============4854020229786283367==--
