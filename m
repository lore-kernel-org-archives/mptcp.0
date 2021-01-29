Content-Type: multipart/mixed; boundary="===============8006313571779617761=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][RFC mptcp-next 0/6] add trace events
Date: Fri, 29 Jan 2021 16:50:15 +0100
Message-ID: <866985d7f86eb25ec273b59182269458699691f3.camel@redhat.com>
In-Reply-To: cover.1611667027.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7534

--===============8006313571779617761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, 2021-01-26 at 21:21 +0800, Geliang Tang wrote:
> This patchset addressed issues 131, replace some/most pr_debug with trace
> events.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/131
> =

> Geliang Tang (6):
>   mptcp: add tracepoints for data operations
>   mptcp: add echo field in mptcp_out_options
>   mptcp: add tracepoints for options operations
>   mptcp: add mptcpi_local_addr_* in mptcp_info
>   mptcp: add tracepoints for PM operations
>   mptcp: add tracepoints for subflow operations

I'm sorry for the late feedback.

I think we should first agree on which functions we want to
instrument/where we want to add the tracepoint.

I suggest avoiding functions invoked not frequently (pr_debug would
probably suffice there) and avoiding exposing data accessible elsewhere
e.g. packet capture.

I think it would be nice to instrument the packet scheduler and the
mapping status. I would not add much more tracepoints than that.

Additionally, I suggest dropping the pr_debug() from places where
tracepoints are added.

I'd love to ear others opinions, too!

Cheers,

Paolo

--===============8006313571779617761==--
