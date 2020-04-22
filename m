Content-Type: multipart/mixed; boundary="===============6228543887596617948=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC] net: mptcp: improve fallback after successful
 3-way-handshake
Date: Wed, 22 Apr 2020 15:56:15 +0200
Message-ID: <2252c191ff8ab71355b665544e727ab6ce2f522c.camel@redhat.com>
In-Reply-To: 7606ab2761aa50987f553d6d838229638e09e5e7.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4222

--===============6228543887596617948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-04-22 at 15:53 +0200, Paolo Abeni wrote:
>  prescindere c'e' un punto da gestire. In caso di fallback sul 4 ack,
> adesso becchiamo:
>         WARN_ON_ONCE(subflow->can_ack);
> in check_fully_established() che probabilmente andrebbe tolto.

fammelo provare, a me non succede
-- =

davide

--===============6228543887596617948==--
