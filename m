Content-Type: multipart/mixed; boundary="===============8303523352623455839=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "tcp: coalesce/collapse must respect
 MPTCP extensions"
Date: Fri, 20 Dec 2019 19:53:44 +0100
Message-ID: <d5604fba-abfe-8ba5-582c-eaa0f241aeee@tessares.net>
In-Reply-To: alpine.OSX.2.21.1912201027150.52347@mkavai-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3238

--===============8303523352623455839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 20/12/2019 19:29, Mat Martineau wrote:
> =

> On Fri, 20 Dec 2019, Paolo Abeni wrote:
> =

>> clarify mptcp ext usage
>>
>> to be added to squashed commit changelog:
>> """
>> v5 -> v6:
>> =C2=A0- clarify MPTCP must always be cleared at allocation time
> =

> "clarify MPTCP skb extensions must always be cleared at allocation time"
> =

>> """
>> ---
>> include/net/mptcp.h | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>> index 7d693d0a38ff..8825da7538dd 100644
>> --- a/include/net/mptcp.h
>> +++ b/include/net/mptcp.h
>> @@ -48,6 +48,9 @@ static inline void mptcp_skb_ext_move(struct sk_buff =

>> *to,
>> static inline bool mptcp_ext_matches(const struct mptcp_ext *to_ext,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct mptcp_ext *fr=
om_ext)
>> {
>> +=C2=A0=C2=A0=C2=A0 /* MPTCP always clear the ext when adding it to the =
skb, so
> =

> s/clear/clears/

Thank you for the patch, the review and the improvement!

- 8b2a7b366d45: "squashed" in "tcp: coalesce/collapse must respect MPTCP =

extensions"
- [t/tcp-Prevent-coalesce-collapse-when-skb-has-MPTCP-extensions =

b443e354be32] mptcp: fix typo in comment
- bcfc31d5bde4..418ff4851eb5: result

Tests + export in progress!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8303523352623455839==--
