Content-Type: multipart/mixed; boundary="===============0901350959835986979=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/8] Add IPv6 Support
Date: Wed, 13 Nov 2019 21:44:26 +0100
Message-ID: <0cc1b36e-7daf-bb3f-6a1d-32f753824391@tessares.net>
In-Reply-To: 9256d3c468cb189953e30b8c0efe829e77ef4220.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2519

--===============0901350959835986979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo,

On 13/11/2019 19:36, Paolo Abeni wrote:
> On Tue, 2019-11-12 at 22:45 -0800, Peter Krystad wrote:
>> This patchset is a replacement for the single "Add IPv6 Support"
>> commit, with the chunks broken into seperate squash-able commits.
>>
>> Peter Krystad (8):
>>    mptcp: Add IPv6 support for MPTCP socket stubs
>>    mptcp: Add IPv6 support for Associate MPTCP context
>>    mptcp: Add IPV6 support for outgoing connections
>>    mptcp: Add IPv6 support for mptcp_poll
>>    mptcp: Add IPV6 support for incoming connections
>>    mptcp: Add IPv6 support for key generation
>>    mptcp: Add IPv6 support for shutdown()
>>    mptcp: Add IPv6 support for new sysctl initialization
>>
>>   include/net/mptcp.h  | 10 +++++++
>>   net/ipv6/tcp_ipv6.c  |  7 +++++
>>   net/mptcp/ctrl.c     | 11 ++++++++
>>   net/mptcp/protocol.c | 62 +++++++++++++++++++++++++++++++++++++++++---
>>   net/mptcp/protocol.h |  6 +++++
>>   net/mptcp/subflow.c  | 61 +++++++++++++++++++++++++++++++++++++++++--
>>   6 files changed, 151 insertions(+), 6 deletions(-)
> =

> it's hard to verify it without doing the full squash exercise, but the
> split LGTM.

Thank you for the split and the review!
Also thank you for having put them in the right order for the rebase :)

- 920d3c461f9a: "squashed" patch 1/8 in "mptcp: Add MPTCP socket stubs"
- 6ec9145015c0: "squashed" patch 2/8 in "mptcp: Associate MPTCP context =

with TCP socket"
- 1c9a07550d4c: "squashed" patch 3/8 in "mptcp: Handle MP_CAPABLE =

options for outgoing connections"
- 65bea9aec6ac: "squashed" patch 4/8 in "mptcp: add mptcp_poll"
- e353abeb746a: "squashed" patch 5/8 in "mptcp: Create SUBFLOW socket =

for incoming connections"
- d1f01b804dbd: "squashed" patch 6/8 in "mptcp: Add key generation and =

token tree"
- 87425a0c3c06: "squashed" patch 7/8 in "mptcp: Add shutdown() socket =

operation"
- 16fafed481ee: conflict in t/mptcp-Implement-MPTCP-receive-path
- b6522b9ca7cf: conflict in =

t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
- df91c7f6f3bf: "squashed" patch 8/8 in "mptcp: new sysctl to control =

the activation per NS"
- e963d103665b: "Signed-off-by" + "Co-developed-by"
- 023d3b14d1b5..ca1c4ffe6b8d: result



After this, "mptcp: Add IPv6 support" is almost empty:

=3D=3D=3D

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c7e6b9dd14df..564a6204649e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -751,10 +751,7 @@ static int mptcp_bind(struct socket *sock, struct =

sockaddr *uaddr, int addr_len)
  {
         struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
         struct socket *ssock;
-       int err =3D -ENOTSUPP;
-
-       if (uaddr->sa_family !=3D AF_INET) // @@ allow only IPv4 for now
-               return err;
+       int err;

         ssock =3D mptcp_socket_create_get(msk);
         if (IS_ERR(ssock))

=3D=3D=3D

Can I move this to "mptcp: Create SUBFLOW socket for incoming connections"?

Tests are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0901350959835986979==--
