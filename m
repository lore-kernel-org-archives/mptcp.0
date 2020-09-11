Content-Type: multipart/mixed; boundary="===============2537483411040752047=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 1/2] Squash-to: "mptcp: allow picking
 different xmit subflows"
Date: Fri, 11 Sep 2020 12:48:31 +0200
Message-ID: <da901f26-7bc7-9945-7224-d32c5787b2af@tessares.net>
In-Reply-To: 49dbfbe2c7bfbdaabe83b34e508d3d5c6905ef80.1599659504.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5798

--===============2537483411040752047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat, Florian,

On 09/09/2020 15:52, Paolo Abeni wrote:
> This improves the current packet scheduler for scenarios
> where the msk sockets is using different links with different
> bandwith limits.
> =

> The commit comment should be changed into:
> =

> """
> Update the scheduler to less trivial heuristic: cache
> the last used subflow, and try to send on it a reasonably
> long burst of data.
> =

> When the burst or the subflow send space is exhausted, pick
> the subflow with the lower ratio between write space and
> send buffer - that is, the subflow with the greater relative
> amount of free space.
> """
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Thank you for the patch and the reviews!

- 145c1405c183: "squashed" patch 1/2 in "mptcp: allow picking different =

xmit subflows"
- a2332e5650da: tg:msg: explain new heuristic
- b5e4b1109338..4822f58422e9: result

Tests + export will be started soon (after having applied your other =

patches)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2537483411040752047==--
