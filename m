Content-Type: multipart/mixed; boundary="===============5890066976652692063=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: allow picking
 different xmit subflows"
Date: Fri, 11 Sep 2020 12:51:53 +0200
Message-ID: <a1cdecf5-24a4-d73e-8ec2-089f39cc671f@tessares.net>
In-Reply-To: 5c2b7b0df753a7f8c9be71a513e2542f58f8d7c0.1599780534.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5800

--===============5890066976652692063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Florian,

On 11/09/2020 01:30, Paolo Abeni wrote:
> In case of fallback we still need to check for avail space
> on the only subflow, or we will trigger issues/83.

Thank you for the patch and the review!

- e09eaf25342a: "squashed" in "mptcp: allow picking different xmit subflows"
- 895b3d8264e8..341c313c53a5: result

Can we close issue 83 now?

Tests + export will be started soon (after having applied your other =

patches).

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5890066976652692063==--
