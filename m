Content-Type: multipart/mixed; boundary="===============8116345027885176779=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] mptcp: fix DATA_FIN generation on early
 shutdown.
Date: Mon, 15 Feb 2021 16:29:06 +0100
Message-ID: <d56e9a35-952c-8b2b-7665-c3a56fcd7147@tessares.net>
In-Reply-To: 23fa447e02e5b0a342408a2065d15281c223e32b.1613081583.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7807

--===============8116345027885176779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 11/02/2021 23:13, Paolo Abeni wrote:
> If the msk is closed before sending or receiving any data,
> no DATA_FIN is generated, instead an MPC ack packet is
> crafted out.
> =

> In the above scenario, the MPTCP protocol create and send a
> pure ack and such packets matches also the criteria for an
> MPC ack and the protocol tries first to insert MPC options,
> leading the described error.
> =

> This change address the issue skipping MPC option for DATA_FIN
> packets or if the subflow is not established.
> =

> To avoid doing multiple times the same test, fetch the data_fin
> flag in a bool variable and pass it to both the interested
> helpers.
> =

> Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data pac=
kets")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Thank you for the patch and the review!

> ---
> The scenario is tested by a specific pktdrill tested,
> already pushed

Thank you for that! (and for having use "mptcp-net" :) even if we can =

change that if it is not OK).
I just applied your patch at the bottom of the tree, after a patch from =

Florian (mptcp: reset last_snd on subflow close). With Mat's RvB tag and =

without a dot at the end of the title:

- b7ee76d557c4: mptcp: fix DATA_FIN generation on early shutdown
- Results: 655ef2e493c8..82aaf8587e26

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8116345027885176779==--
