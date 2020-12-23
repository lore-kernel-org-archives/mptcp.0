Content-Type: multipart/mixed; boundary="===============5269213654501380188=="
MIME-Version: 1.0
From: Paul Moore <paul at paul-moore.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] linux: handle MPTCP consistently with TCP
Date: Wed, 23 Dec 2020 10:28:58 -0500
Message-ID: <CAHC9VhQxrGNMNj9FN3LYVbqt+Rwgbrv98GySzg4Tzb=jcNWN3g@mail.gmail.com>
In-Reply-To: 8650019f70725323545e41c5ecf6b1344671b4fa.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7247

--===============5269213654501380188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2020 at 10:10 AM Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Wed, 2020-12-23 at 09:53 -0500, Paul Moore wrote:
> > On Wed, Dec 16, 2020 at 6:55 AM Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > The MPTCP protocol uses a specific protocol value, even if
> > > it's an extension to TCP. Additionally, MPTCP sockets
> > > could 'fall-back' to TCP at run-time, depending on peer MPTCP
> > > support and available resources.
> > >
> > > As a consequence of the specific protocol number, selinux
> > > applies the raw_socket class to MPTCP sockets.
> > >
> > > Existing TCP application converted to MPTCP - or forced to
> > > use MPTCP socket with user-space hacks - will need an
> > > updated policy to run successfully.
> > >
> > > This change lets selinux attach the TCP socket class to
> > > MPTCP sockets, too, so that no policy changes are needed in
> > > the above scenario.
> > >
> > > Note that the MPTCP is setting, propagating and updating the
> > > security context on all the subflows and related request
> > > socket.
> > >
> > > Link: https://lore.kernel.org/linux-security-module/CAHC9VhTaK3xx0hEG=
ByD2zxfF7fadyPP1kb-WeWH_YCyq9X-sRg(a)mail.gmail.com/T/#t
> > > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > > ---
> > >  security/selinux/hooks.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > Based on our discussion in the previous thread, the patch below seems
> > fine, although it needs to wait until after the merge window closes.
> >
> > Paolo, it sounded like there was at least one other small MPTCP fix
> > needed, likely in the stack itself and not the LSM/SELinux code, has
> > that patch been submitted already?
>
> Yes, it's already in the Linus's tree:

Perfect, thank you.

> commit 0c14846032f2c0a3b63234e1fc2759f4155b6067
> Author: Paolo Abeni <pabeni(a)redhat.com>
> Date:   Wed Dec 16 12:48:32 2020 +0100
>
>     mptcp: fix security context on server socket
>
> Thanks for the feedback && happy new year;)

Thanks, you too!

-- =

paul moore
www.paul-moore.com
--===============5269213654501380188==--
