Content-Type: multipart/mixed; boundary="===============7773446633714623720=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3] mptcp: fix option length of mp_capable syn/ack
Date: Mon, 02 Dec 2019 11:25:27 +0100
Message-ID: <d3bf330f-4c55-4018-9797-fa4a0e50a177@tessares.net>
In-Reply-To: 6941c970fd9ce038972887af590fc685746f4427.1575279172.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2732

--===============7773446633714623720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 02/12/2019 11:04, Davide Caratti wrote:
> in current MPTCP, the server sends the client's key back in the syn/ack
> packet. Because of that, both tcpdump and packetdrill refuse to parse
> the mp_capable option in the syn/ack. Both RFC6824 and RFC6824bis don't
> require this in section 3.1, only the server's key should be sent in
> the syn/ack.
> =

> - change TCPOLEN_MPTCP_MPC_SYNACK from 20 (4+8+8) to 12 (4+8)
> - don't write the client's key in mp_capable syn/ack
> - adjust tests in mptcp_parse_option() to cope with the changed
>    value of TCPOLEN_MPTCP_MPC_SYNACK

[...]

> v2: more conservative behavior when parsing received options
> v3: adjust tests in mptcp_parse_option() to catch all possible
>      values of MP_CAPABLE option length specified by v0 protocol,
>      thanks Matthieu Baerts.

Thank you for this new version! It looks good to me.

I will wait for Paolo and/or Christoph's ACK as you added them in cc =

(for the discussion in the MPTCPv1 patches).

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7773446633714623720==--
