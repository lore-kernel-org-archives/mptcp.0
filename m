Content-Type: multipart/mixed; boundary="===============2819481862549350281=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Next steps discussion
Date: Thu, 01 Mar 2018 11:38:47 -0800
Message-ID: <20180301193847.GV2038@MacBook-Pro-4.local>
In-Reply-To: CAKuKrBnwqGth+dGqwBiJHgh90fCUhg9AWgy+VVUxRWdNjx8zLg@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 335

--===============2819481862549350281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 01/03/18 - 18:05:40, Matthieu Baerts wrote:
> Hi Christoph,
> =

> On Wed, Feb 28, 2018 at 11:41 PM, Christoph Paasch <cpaasch(a)apple.com>
> wrote:
> =

> > Yeah, feedback was disappointingly scarce :/
> >
> > It probably was not what he had completely in mind, as he didn't talk a=
bout
> > a TCP-option framework but simply about moving TCP-MD5 code out of the
> > TCP-stack. So, with our proposal we went a bit further.
> >
> =

> Or maybe simply unlucky with who was available at this time to have a look
> at them :)
> =

> =

> > TLS is a good example. They actually do have a lookup table where the
> > driver
> > is calling back into the TCP-stack to get the TLS-record information.
> >
> > We had discussed this with people from Mellanox that proposed the
> > TLS hardware offloading: https://lists.01.org/
> > pipermail/mptcp/2017-November/000165.html
> =

> =

> Thank you for the link!
> =

> Yes, that would be good! Just a short weekly sync could be useful.
> >
> > Do you have a Webex or other means to set this up?
> >
> =

> I think I can setup a webex (even if it is less fun to use that on a Linux
> desktop :) ). We already used talky.io, more Linux friendly if we need to
> share screen and others, maybe not needed.

talky.io is fine for me as well.

> Another issue may be the time. I think you are all in the west coast of t=
he
> US :-)
> But I am sure I can find time on the evening for a short meeting!

Ideally for me, it would be at 9am (for you 6pm). Otherwise, I can make 8am
as well (5pm for you).

I don't know what the opinion of the others is on the timing.


Christoph


> =

> =

> > Looking forward to the netlink PM! :-)
> >
> =

> I hope I will have time very soon to clean this.
> Mat, do you prefer to talk about that directly by commenting the patches =
on
> mptcp-dev ML?
> =

> Matthieu
> -- =

> [image: Tessares SA] <http://www.tessares.net> Matthieu Baerts | R&D
> Engineer
> matthieu.baerts(a)tessares.net
> Tessares SA | Hybrid Access Solutions
> www.tessares.net
> 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
> <https://www.google.com/maps?q=3D1+Avenue+Jean+Monnet,+1348+Ottignies-Lou=
vain-la-Neuve,+Belgium>
> =

> -- =

> =

> ------------------------------
> DISCLAIMER.
> This email and any files transmitted with it are confidential and intende=
d =

> solely for the use of the individual or entity to whom they are addressed=
. =

> If you have received this email in error please notify the system manager=
. =

> This message contains confidential information and is intended only for t=
he =

> individual named. If you are not the named addressee you should not =

> disseminate, distribute or copy this e-mail. Please notify the sender =

> immediately by e-mail if you have received this e-mail by mistake and =

> delete this e-mail from your system. If you are not the intended recipien=
t =

> you are notified that disclosing, copying, distributing or taking any =

> action in reliance on the contents of this information is strictly =

> prohibited.

--===============2819481862549350281==--
