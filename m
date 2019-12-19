Content-Type: multipart/mixed; boundary="===============4117697917448959266=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3] Squash-to: "tcp: Prevent coalesce/collapse
 when skb has MPTCP extensions"
Date: Thu, 19 Dec 2019 21:26:12 +0100
Message-ID: <0f6b9fa1-3267-8c91-1471-11fdec2f6781@tessares.net>
In-Reply-To: 580478d5584a2b4f4d68ed2676cbcb85b9ae44a5.1576773662.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3181

--===============4117697917448959266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Florian, Mat, Christoph,

On 19/12/2019 17:47, Paolo Abeni wrote:
> Allow coalescing when mptcp extensions are equal or 'from' lacks such ext=
ensions.
> =

> Note: we could be a little less restrictive allowing coalescing with
> different data_ack, but this simplify the code a bit, we can improve
> later and at least mptcp_net-next do not generate almost identical
> DSS with different data_ack.
> =

> With the above assumption, we don't need any special action when
> moving bits from skb1 to skb2, as the mapping in skb2 will already
> fit, and mapping in skb1 will be dropped as/if needed.
> =

> When coalescing to a newly allocated skb, we transfer the relevant
> extension to. An MPTCP specific helper is added for that goal,
> possibly we could use/create a generic one.
> =

> Rebased tree available at:
> https://github.com/pabeni/mptcp/tree/mptcp_net-next_export_v4.3
> =

> v2  -> v3:
>   - refine mptcp_ext_matches() checks -> matches if !from_ext
>     (was from_ext =3D=3D to_ext, which was more restrictive)
> =

> v1  -> v2:
>   - mptcp_skb_ext_move() is a no-op if from lack an MPTCP ext (Christoph)
>   - clean-up mptcp_skb_ext_move() as per Florian's suggestions
> =

> RFC -> v1:
>   - changed helpers checks as per Florian && Mat feedback
>   - added comments (Florian)
>   - fixed check in tcp_try_coalesce() (Mat)
>   - fixed memcpy (Mat && Florian)
>   - dropped now unused mptcp_skb_ext_exist()
>   - move the mptcp_skb_can_collapse() into the 2nd group of checks in
>     tcp_coalese()
> =

> This latter point is somewhat relevant. An unpatched kernel allows
> collapsing a single skb with 'old' bits (seq lower than 'start'). Than
> really means shrink a bit the current skb, possibly without any fourther
> action. This change preserve this behavior, but add the restriction to
> respect MPTCP coalescing test when trying to collapsing to the next one.
> Overall consequences are not 110% clear to me!

Thank you for the patch and the reviews!

- f21b48165301: "squashed" in "tcp: Prevent coalesce/collapse when skb =

has MPTCP extensions"
- 4dc8f2357520: "Signed-off-by" + "Co-developed-by"
- 5f651be5c6db: conflict in t/mptcp-Add-MPTCP-socket-stubs
- bc6adc5c4e02: conflict in t/mptcp-Handle-MPTCP-TCP-options
- 63a1588ffa98: conflict in =

t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections
- f38f78ba4f29: conflict in t/mptcp-Implement-MPTCP-receive-path
- 59fa1bb6f670..869248dbe005: result

Tests are in progress!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4117697917448959266==--
