Content-Type: multipart/mixed; boundary="===============4131917017818874497=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/3] mptcp: Use correct address family when
 creating subflows
Date: Tue, 22 Oct 2019 14:35:45 +0200
Message-ID: <4a33621a6b7dfc1ed11064d9f771463c45e4814d.camel@redhat.com>
In-Reply-To: 2734366d-ad01-1bb8-cd65-17861a35102b@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2257

--===============4131917017818874497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-22 at 13:12 +0200, Matthieu Baerts wrote:
> On 22/10/2019 10:35, Paolo Abeni wrote:
> > but what if the peer sends an ADD_ADDR v4,
> > and the local msk socket is a v6 (or vice versa)?

Sorry, I was not clear enough. With the posted code, when msk is v6, =

pernet->has_announce_v6 is 1 and ADD_ADDR is ipv4 (pm->remote_family =3D=3D
AF_INET), I think mptcp_pm_create_subflow6() will end-up using
uninitialized bytes for mptcp_subflow_connect().

To avoid that, we should check that the local and the remote address
used to establish the connection belong to the same family.

> So accept a mix of v4 and v6 later? =


The idea would be to keep the code as simple as possible. The listening
socket in the current status can't accept easily a mix of ipv4 and ipv6
subflow, I think.

On the flip side, should be quite straigh-forward support mixed family
for client sockets; that was my overall proposal here.

> It would make sense but it will need =

> to be documented somewhere with a TODO I guess :)

Agreed.

> PS: Paolo: is it OK for you if I apply the first patch of the series?

too late, but... "yes"

Cheers,

Paolo

--===============4131917017818874497==--
