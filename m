Content-Type: multipart/mixed; boundary="===============6370330642065411443=="
MIME-Version: 1.0
From: Paul Moore <paul at paul-moore.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] selinux: handle MPTCP consistently with TCP
Date: Thu, 03 Dec 2020 18:30:22 -0500
Message-ID: <CAHC9VhTVc07P_MhWm7YRF6LXdMRQOcDEKe7SB+fpJJizdKOvEg@mail.gmail.com>
In-Reply-To: 539f376-62c2-dbe7-fbfd-6dc7a53eafa@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7030

--===============6370330642065411443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 3, 2020 at 12:24 PM Mat Martineau
<mathew.j.martineau(a)linux.intel.com> wrote:
> On Wed, 2 Dec 2020, Paolo Abeni wrote:
> > On Wed, 2020-12-02 at 11:31 +0100, Paolo Abeni wrote:
> >> The MPTCP protocol uses a specific protocol value, even if
> >> it's an extension to TCP. Additionally, MPTCP sockets
> >> could 'fall-back' to TCP at run-time, depending on peer MPTCP
> >> support and available resources.
> >>
> >> As a consequence of the specific protocol number, selinux
> >> applies the raw_socket class to MPTCP sockets.
> >>
> >> Existing TCP application converted to MPTCP - or forced to
> >> use MPTCP socket with user-space hacks - will need an
> >> updated policy to run successfully.
> >>
> >> This change lets selinux attach the TCP socket class to
> >> MPTCP sockets, too, so that no policy changes are needed in
> >> the above scenario.
> >>
> >> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> >> ---
> >>  security/selinux/hooks.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >> index 6b1826fc3658..9a6b4bf1bc5b 100644
> >> --- a/security/selinux/hooks.c
> >> +++ b/security/selinux/hooks.c
> >> @@ -1120,7 +1120,8 @@ static inline u16 inode_mode_to_security_class(u=
mode_t mode)
> >>
> >>  static inline int default_protocol_stream(int protocol)
> >>  {
> >> -    return (protocol =3D=3D IPPROTO_IP || protocol =3D=3D IPPROTO_TCP=
);
> >> +    return (protocol =3D=3D IPPROTO_IP || protocol =3D=3D IPPROTO_TCP=
 ||
> >> +            protocol =3D=3D IPPROTO_MPTCP);
> >>  }
>
> This looks like a good default to me.
>
> >>
> >>  static inline int default_protocol_dgram(int protocol)
> >> @@ -1152,7 +1153,7 @@ static inline u16 socket_type_to_security_class(=
int family, int type, int protoc
> >>                              return SECCLASS_TCP_SOCKET;
> >>                      else if (extsockclass && protocol =3D=3D IPPROTO_=
SCTP)
> >>                              return SECCLASS_SCTP_SOCKET;
> >> -                    else
> >> +                    elseextsockclass
> >
> > Whoops, my bad! I don't know how this chunk slipped-in. I'll fix it in
> > the formal submission for inclusion, if there is agreement on this
> > change.
>
> Ok, looks fine to send after fixup.

I'm not very well versed in MPTCP, but this *seems* okay to me, minus
the else-crud chunk.  Just to confirm my understanding, while MPTCP
allows one TCP connection/stream to be subdivided and distributed
across multiple interfaces, it does not allow multiple TCP streams to
be multiplexed on a single connection, yes?

> I think there may be a small fix required to smack too, but that's an
> entirely different patch.

It would probably be a good idea to CC the LSM list just to make sure
all of the LSMs are made aware (done on this email).

-- =

paul moore
www.paul-moore.com
--===============6370330642065411443==--
