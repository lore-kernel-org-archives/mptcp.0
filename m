Content-Type: multipart/mixed; boundary="===============2827110215195308653=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [Weekly meetings] MoM - 25th of April 2019
Date: Thu, 02 May 2019 17:53:03 +0200
Message-ID: <20190502155303.er6eqhxw5n3libcs@breakpoint.cc>
In-Reply-To: 9389e3991a4f5c600a6cb70724b2a4c3c1bc976b.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1109

--===============2827110215195308653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Mon, 2019-04-29 at 11:02 -0700, Mat Martineau wrote:
> > If we can merge the beginning of the patch set in our repo, I think it =

> > will be much easier to coordinate our work by appending commits rather =

> > than constantly revising the whole series. I think we're getting close =
to =

> > that point, and after the pushing RFCv10 we may be in a good position t=
o =

> > merge the earlier patches and then focus on new commits (or commits tha=
t =

> > can be easily squashed).
> =

> I agree with this kind of approach. I would take it to the extent of
> accepting the patchset as is, and than handle whatever is needed with
> incremental patches.

Also agree.  Squashing simple changes (test case improvements, spelling
fixes and so on) is fine but for everything else I would prefer new commits.

There can be one larger rebase/squash effort once its decided that a
netdev rfc submission is to be made.

Until then, constant rebasing is just a waste of time imo.

New commits-on-top would make it easier to track development too.

--===============2827110215195308653==--
