Content-Type: multipart/mixed; boundary="===============7770139445093309821=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] mptcp: Wake up MPTCP worker when
 DATA_FIN found on a TCP FIN packet
Date: Wed, 23 Sep 2020 17:06:36 -0700
Message-ID: <alpine.OSX.2.23.453.2009231704520.43028@kamurph1-mobl5.amr.corp.intel.com>
In-Reply-To: 519553b06e21824d9ed28c37943e8e03ef92d859.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5994

--===============7770139445093309821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Sep 2020, Paolo Abeni wrote:

> On Fri, 2020-09-18 at 15:52 -0700, Mat Martineau wrote:
>> I had been thinking the multipath-tcp.org interop problem was a
>> variation
>> of the bug fixed by this patch, but it looks like a separate (and
>> very
>> different) issue with mptcp_close(). I will send this patch to netdev
>> now
>> and open a separate issue on github.
>
> https://github.com/multipath-tcp/mptcp_net-next/issues/92
>
> I'm looking at the same problem from a different perspective.
>
> To support correct snd wnd enforcing, we need the mptcp equivalent of
> tcp_push_pending_frames(): data must be queued into the msk and pushed
> to substream only when the MPTCP-level wnd is open.
>
> As a side effect, at shutdown/close time we may end-up with data queued
> into the msk that never reached any subflow. To allow the MPTCP and
> later TCP stack to spool them we need to keep the ssk around.
>
> And here we hit some nasty problems: at mptcp_close() time we need to
> orphan all subflows sharing the same 'struct socket' as the msk - as
> the latter is going to be deleted just after mptcp_close() completes.
>
> But as soon as we orphan them, the tcp stack may async delete the
> subflow via tcp_done(). That will free also the related subflow
> context. In subflow_ulp_release() we can't acquire the msk socket lock,
> so we can't remove the deleted subflow from the conn_list.
>
> TL;DR: UaF in later MPTCP operation (e.g. [re]transmit) touching the
> subflows, not easy to solve.

This is exactly the problem I'm running in to (UaF on later call to =

subflow_state_change), and so far hasn't been easy to solve. Would help to =

talk it over at the Thursday meeting!

--
Mat Martineau
Intel
--===============7770139445093309821==--
