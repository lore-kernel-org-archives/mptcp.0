Content-Type: multipart/mixed; boundary="===============2758485177652066353=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v6 mptcp-next 8/9] mptcp: add the mibs for
 ADD_ADDR with port
Date: Wed, 25 Nov 2020 13:15:19 +0100
Message-ID: <69a4e888a57afadbbf5d79faf623ebfbdb9d4666.camel@redhat.com>
In-Reply-To: 4d94e1a6-d54a-04c5-d738-8f25716ab566@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6930

--===============2758485177652066353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-11-25 at 11:31 +0100, Matthieu Baerts wrote:
> I think it is not a bad thing to have these new counters :)
> But maybe we should prefix the PORTSYN/SYNACK/ACK ones with JOIN? (e.g. =

> MPTCP_MIB_JOINPORTSYNRX and MPJoinPortSynRx ; or with "Port" at the end)
> It is still an MP_JOIN we receive but to a different port.
> =

> Do you mean we might not need them?

No, I agree we need them. I was looking for uniform naming and/or
collected events.

Cheers,

Paolo

--===============2758485177652066353==--
