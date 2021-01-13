Content-Type: multipart/mixed; boundary="===============4431151780492350578=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 mptcp-next 0/4] mptcp: re-enable snd buf
 autotune
Date: Tue, 12 Jan 2021 16:23:05 -0800
Message-ID: <c5decfac-eca2-2a9b-7976-528aa728748f@linux.intel.com>
In-Reply-To: cover.1610449705.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7336

--===============4431151780492350578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 12 Jan 2021, Paolo Abeni wrote:

> WRT to the previous iteration, this clean-up patch 2/4 dropping the
> left over 'use_backup' field, as suggested by Mat. No other change
>
> Relevant bits from the previous cover letter:
>
> There are still some sporadic self-test failures for assimetric links.
> Looks like they are caused by retransmissions/receiver dropping packets
> due to MPTCP level OoO check.
>
> I'll try to address that asap, but I still consider this series for
> inclusion, so that it can stage a bit in the export branch.
>
> Note: the last patch re-introduces the workqueue usage for the datapath (=
yes,
> it makes me feel sick, sad and tired :(. I was unable to avoid it.
>
>
> Paolo Abeni (4):
>  mptcp: always graft subflow socket to parent.
>  mptcp: re-enable sndbuf autotune
>  mptcp: do not queue excessive data on subflows.
>  mptcp: schedule work for better snd subflow selection
>
> net/mptcp/protocol.c | 104 +++++++++++++++++--------------------------
> net/mptcp/protocol.h |  20 +++++++++
> net/mptcp/subflow.c  |  13 +++++-
> 3 files changed, 73 insertions(+), 64 deletions(-)
>
> -- =

> 2.26.2

Thanks Paolo. I think v3 of the series looks good to stage on the export =

branch.

--
Mat Martineau
Intel
--===============4431151780492350578==--
