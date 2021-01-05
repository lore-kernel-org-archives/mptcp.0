Content-Type: multipart/mixed; boundary="===============1343385829655758364=="
MIME-Version: 1.0
From: Paul Moore <paul at paul-moore.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] linux: handle MPTCP consistently with TCP
Date: Mon, 04 Jan 2021 19:47:07 -0500
Message-ID: <CAHC9VhTVOZLPh32mgpV3aC7RFPETNACQU1_EC7iKoFG=pwNRtA@mail.gmail.com>
In-Reply-To: CAHC9VhTUain0=AXvxu3k7e46DCnFuQtcrgQFrEsz9b0uNQnqtQ@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7249

--===============1343385829655758364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2020 at 9:53 AM Paul Moore <paul(a)paul-moore.com> wrote:
> On Wed, Dec 16, 2020 at 6:55 AM Paolo Abeni <pabeni(a)redhat.com> wrote:
> >
> > The MPTCP protocol uses a specific protocol value, even if
> > it's an extension to TCP. Additionally, MPTCP sockets
> > could 'fall-back' to TCP at run-time, depending on peer MPTCP
> > support and available resources.
> >
> > As a consequence of the specific protocol number, selinux
> > applies the raw_socket class to MPTCP sockets.
> >
> > Existing TCP application converted to MPTCP - or forced to
> > use MPTCP socket with user-space hacks - will need an
> > updated policy to run successfully.
> >
> > This change lets selinux attach the TCP socket class to
> > MPTCP sockets, too, so that no policy changes are needed in
> > the above scenario.
> >
> > Note that the MPTCP is setting, propagating and updating the
> > security context on all the subflows and related request
> > socket.
> >
> > Link: https://lore.kernel.org/linux-security-module/CAHC9VhTaK3xx0hEGBy=
D2zxfF7fadyPP1kb-WeWH_YCyq9X-sRg(a)mail.gmail.com/T/#t
> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> >  security/selinux/hooks.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Based on our discussion in the previous thread, the patch below seems
> fine, although it needs to wait until after the merge window closes.

I just merged this into my selinux/next tree, you should see it in the
kernel.org repos later tonight.  Thanks!

-- =

paul moore
www.paul-moore.com
--===============1343385829655758364==--
