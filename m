Content-Type: multipart/mixed; boundary="===============0272902121997502997=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/2] Fix bug processing options
Date: Thu, 31 Oct 2019 16:34:22 +0100
Message-ID: <5c3ea1f9-262a-3874-3b13-bec424e172c6@tessares.net>
In-Reply-To: c8b8201f-765a-74c2-be31-0ca4b23c7537@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2375

--===============0272902121997502997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

It seems this email I wanted to send end of last week didn't go through.

On 26/10/2019 10:04, Matthieu Baerts wrote:
> Hi Peter, Mat,
> =

> On 26/10/2019 01:40, Mat Martineau wrote:
>>
>> On Tue, 22 Oct 2019, Peter Krystad wrote:
>>
>>> Do not process incoming options if the subflow is not MPTCP.
>>>
>>> Observed crash when running against out-of-tree kernel with
>>> mis-matched checksum options.
>>>
>>> Peter Krystad (2):
>>> =C2=A0mptcp: Ignore incoming MPTCP options when not MP_CAPABLE
>>> =C2=A0mptcp: Ignore incoming MPTCP options when not MP_CAPABLE
>>>
>>> net/mptcp/options.c | 3 +++
>>> 1 file changed, 3 insertions(+)
>>>
>>
>> Both changes look good to me. Thanks, Peter!
> =

> Thank you for the patches and the reviews!
> =

> - 6eb607af7475: "squashed" patch 1/2 in "mptcp: Implement MPTCP receive =

> path"
> - ea443b296417: "squashed" patch 2/2 in "mptcp: Add handling of outgoing =

> MP_JOIN requests"
> - 22b6803a0c48..a89f2feb5b90: result
> =

> Tests are still OK!

I had to do a small change to allow the compilation of each commit:


diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ca589ab9a02a..bbf9e9aa53da 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -391,6 +391,7 @@ bool mptcp_synack_options(const struct request_sock =

*req, unsigned int *size,
  void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
                             struct tcp_options_received *opt_rx)
  {
+       struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
         struct mptcp_options_received *mp_opt;
         struct mptcp_ext *mpext;


The subflow variable is declared later on in "mptcp: Add path manager =

interface"

- c559c9eb4f9f: "squashed" in "mptcp: Implement MPTCP receive path"
- 9c984d940c41: conflict in t/mptcp-Add-path-manager-interface
- no diff at the end.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0272902121997502997==--
