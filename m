Content-Type: multipart/mixed; boundary="===============3994639278450226918=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 0/3] mptcp: netlink event fixes
Date: Tue, 02 Feb 2021 17:28:33 -0800
Message-ID: <695d572f-3a1b-f687-cf31-d26e684f6a74@linux.intel.com>
In-Reply-To: 20210202174754.6861-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7601

--===============3994639278450226918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Feb 2021, Florian Westphal wrote:

> While testing upcoming mptcp reset option support i found a few
> issues with netlink events.
>
> 1. When remote side is closing, the subflow close event will
> be delayed until after the mptcp socket has shut down.
>
> Schedule the worker to do a cleanup scan to avoid this.
>
> 2. When the mptcp socket is closing we can avoid sending
>   individual 'subflow is closing' events; entire connection
>   is going down so might as well wait for the normal mptcp-level
>   close event.
>

Those two fixes look good for the export branch.

> 3. Move the subflow close loop after dead check.
>   This is not a fix, it would be fine to leave things as-is
>   if you prefer -- its just that the extra conn_list walk
>   can be avoided if the msk is already dead.

This also skips the MPTCP_EVENT_SUB_CLOSED events when the whole socket is =

closed, right? That's worthwhile. It doesn't look like delaying the ssk =

close(s) will change the other calls that might happen for the PM / EOF / =

DATA_FIN stuff, so I think the patch is ok. If there's a problem we can =

drop it from the export branch.

Thanks!

Mat


>
> Florian Westphal (3):
>  mptcp: schedule worker when subflow is closed
>  mptcp: skip MPTCP_EVENT_SUB_CLOSED event when mptcp socket isn't
>    established
>  mptcp: move subflow close loop after sk close check
>
> net/mptcp/protocol.c | 9 +++++----
> net/mptcp/subflow.c  | 7 +++++++
> 2 files changed, 12 insertions(+), 4 deletions(-)
>
> -- =

> 2.26.2

--
Mat Martineau
Intel
--===============3994639278450226918==--
