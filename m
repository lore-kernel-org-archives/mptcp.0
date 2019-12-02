Content-Type: multipart/mixed; boundary="===============8341035039996532074=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/3] sendmsg: fix pending issues.
Date: Mon, 02 Dec 2019 16:30:06 +0100
Message-ID: <6425f277f105b20357fd975c79b5fb87b35cb129.camel@redhat.com>
In-Reply-To: b995fb4b-fb96-dd8d-b27e-dd9bcdd66194@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2742

--===============8341035039996532074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-12-02 at 13:57 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 02/12/2019 11:24, Paolo Abeni wrote:
> > This is just a rebase of the initial RFC post.
> =

> Thank you for the rebase!
> =

> > The patch 1 should be inserted just after "tcp: clean ext on tx recycle"
> > =

> > The patches 2 and 3 have explicit individual squash-to tags, but will c=
asue a
> > lot of conflicts, the uneasy ones to solve are on patch
> > "mptcp: rework mptcp_sendmsg_frag to accept optional dfrag"
> > =

> > A tree rebased with the above patches applied is available at:
> > =

> > https://github.com/pabeni/mptcp/tree/sendmsg_fix_2
> =

> I hope you don't mind if I don't use your branch directly. I was going =

> to apply Mat's data-FIN patch. And look at the code on your branch in =

> case of conflicts.

WFM :)

Whatever is easier for you.

It looks like we have some pending conflicting patches - I hope v1
support should land soon, too... - so really whatever works best for
you will work for me, too.

Thanks,

Paolo

--===============8341035039996532074==--
