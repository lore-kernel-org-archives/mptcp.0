Content-Type: multipart/mixed; boundary="===============8909775342184862557=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 11th of June 2020
Date: Fri, 12 Jun 2020 16:52:51 +0200
Message-ID: <5a20fc04-c6ef-4cd2-aa00-60b0fc904b1f@tessares.net>
In-Reply-To: f3a5e140-0cc1-7ad3-3e92-dc61be603e8f@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4660

--===============8909775342184862557==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 11/06/2020 19:01, Matthieu Baerts wrote:

(...)

>  =C2=A0 20=C2=A0 implement msk diag interface [enhancement]:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - could be possible now that the token co=
ntainer has been refactor
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - there is an API issue with IPPROTO_MPTCP
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "Florian said that the diag handler for=
 IPPROTO_RAW already =

> uses it"
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adding something in '/proc/net/mptcp'?:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - instead of a re=
al diag interface
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - *Matth* : TODO:=
 we said something about that at the LPC, =

> check that

It is still unclear to me if having an interface similar to =

/proc/net/tcp could be accepted upstream. It seems some people already =

forgot this interface still exists :)

     https://youtu.be/Y64n_R14GtI?t=3D1722

(but it is useful on embedded devices with limited tools)

Maybe a good justification could be OK :)
But people might expect to have everything via sock_diag.

I hope this info will help :)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8909775342184862557==--
