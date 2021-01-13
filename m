Content-Type: multipart/mixed; boundary="===============0601914156944666655=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 mptcp-next 0/4] mptcp: re-enable snd buf
 autotune
Date: Wed, 13 Jan 2021 19:05:21 +0100
Message-ID: <8c5f2462-e48d-0b0b-cc9f-925b19463760@tessares.net>
In-Reply-To: cover.1610449705.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7347

--===============0601914156944666655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 12/01/2021 12:09, Paolo Abeni wrote:
> WRT to the previous iteration, this clean-up patch 2/4 dropping the
> left over 'use_backup' field, as suggested by Mat. No other change
> =

> Relevant bits from the previous cover letter:
> =

> There are still some sporadic self-test failures for assimetric links.
> Looks like they are caused by retransmissions/receiver dropping packets
> due to MPTCP level OoO check.
> =

> I'll try to address that asap, but I still consider this series for
> inclusion, so that it can stage a bit in the export branch.
> =

> Note: the last patch re-introduces the workqueue usage for the datapath (=
yes,
> it makes me feel sick, sad and tired :(. I was unable to avoid it.

Thank you for these new patches and the reviews!

Just added in the tree without dot at the end of the commit titles and =

Mat's Reviewed-by tag:

- 19c774f1761a: mptcp: always graft subflow socket to parent
- 3d489e89a9d6: mptcp: re-enable sndbuf autotune
- b8a4e1a17113: mptcp: do not queue excessive data on subflows
- 2e4cfdb68e07: mptcp: schedule work for better snd subflow selection
- Results: 591445962c81..bdff08d2ce0e

Tests + export have been scheduled!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0601914156944666655==--
