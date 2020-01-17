Content-Type: multipart/mixed; boundary="===============8568271189870188384=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: handle ipv4-mapped ipv6 address.
Date: Fri, 17 Jan 2020 18:17:07 +0100
Message-ID: <1c38c7f4-53f2-2663-bc17-61476d751192@tessares.net>
In-Reply-To: 5bf3d350-decb-53b4-9531-240e60e64d05@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3402

--===============8568271189870188384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Matt

On 17/01/2020 17:50, Matthieu Baerts wrote:
> Hi Paolo, Mat,
> =

> On 17/01/2020 02:24, Mat Martineau wrote:
>>
>> On Thu, 16 Jan 2020, Paolo Abeni wrote:
>>
>>> The TCP code unconditionally overwrite in a few places =

>>> 'icsk->icsk_af_ops',
>>> which lead to the wrong oops being called for ipv4-mapped ipv6 address.
>>> e.g. Kasan notice a invalid slub access running packetdrill ipv4-mapped
>>> tests.
>>>
>>> This patch try to address the issue building ipv4-mapped=C2=A0 mptcp ic=
sk ops
>>> and using it when appropriate:
>>> - on connect() for ipv4 mapped address (and ev. failure)
>>> - on syn_recv_sock() - passive socket creation
>>>
>>> Additionally subflow_v6_conn_request() should call into =

>>> subflow_v4_conn_request()
>>> for ipv4 packets, otherwise we always fallback on passive socket =

>>> bound to
>>> ipv4 mapped addresses.
>>>
>>> Note: this still touches af_ops twice. If we do differently, alike:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0if (sk_is_mptcp(newsk))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_handle_ipv6_mapped(sk,=
 true);
>>> =C2=A0=C2=A0=C2=A0=C2=A0else
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inet_csk(newsk)->icsk_af_ops=
 =3D &ipv6_mapped;
>>>
>>> we need either:
>>> - additionally handle the #ifnef CONFIG_MPTCP_IPV6 case in
>>> as mptcp_handle_ipv6_mapped(), as we risk to skip 'icsk_af_ops'
>>> initialization otherwise.
>>> - wrap the above mptcp_handle_ipv6_mapped() call under
>>> a preprocessor's conditional (CONFIG_MPTCP_IPV6).
>>>
>>> v1 -> v2:
>>> - fixed mptcp_handle_ipv6_mapped() argument on 2nd call (mat)
>>> - add squash-to tag
>>
>> v2 looks good to me, thanks Paolo.
> =

> Thank you for the patches and the reviews!
> =

> - 77c6b6aec34b: "squashed" in "mptcp: Handle MP_CAPABLE options for =

> outgoing connections"
> - d685ef032e97: conflict in t/mptcp-Add-key-generation-and-token-tree
> - c95635052d13: conflict in t/mptcp-Implement-MPTCP-receive-path

The conflict resolution was not correct. Thank you Paolo for having saw =

that!

- 1b74bd5e517b: fix in t/mptcp-Implement-MPTCP-receive-path
- 899bafd7d1a1..2000db04936b: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8568271189870188384==--
