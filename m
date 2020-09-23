Content-Type: multipart/mixed; boundary="===============6702680518592769995=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] mptcp: Wake up MPTCP worker when
 DATA_FIN found on a TCP FIN packet
Date: Wed, 23 Sep 2020 17:56:01 +0200
Message-ID: <519553b06e21824d9ed28c37943e8e03ef92d859.camel@redhat.com>
In-Reply-To: alpine.OSX.2.23.453.2009181548210.2091@klin3-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5989

--===============6702680518592769995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-09-18 at 15:52 -0700, Mat Martineau wrote:
> I had been thinking the multipath-tcp.org interop problem was a
> variation =

> of the bug fixed by this patch, but it looks like a separate (and
> very =

> different) issue with mptcp_close(). I will send this patch to netdev
> now =

> and open a separate issue on github.

https://github.com/multipath-tcp/mptcp_net-next/issues/92

I'm looking at the same problem from a different perspective.

To support correct snd wnd enforcing, we need the mptcp equivalent of
tcp_push_pending_frames(): data must be queued into the msk and pushed
to substream only when the MPTCP-level wnd is open.

As a side effect, at shutdown/close time we may end-up with data queued
into the msk that never reached any subflow. To allow the MPTCP and
later TCP stack to spool them we need to keep the ssk around.

And here we hit some nasty problems: at mptcp_close() time we need to
orphan all subflows sharing the same 'struct socket' as the msk - as
the latter is going to be deleted just after mptcp_close() completes.

But as soon as we orphan them, the tcp stack may async delete the
subflow via tcp_done(). That will free also the related subflow
context. In subflow_ulp_release() we can't acquire the msk socket lock,
so we can't remove the deleted subflow from the conn_list.

TL;DR: UaF in later MPTCP operation (e.g. [re]transmit) touching the
subflows, not easy to solve.

/P

--===============6702680518592769995==--
