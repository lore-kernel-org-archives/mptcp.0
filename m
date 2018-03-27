Content-Type: multipart/mixed; boundary="===============7203017517501430309=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Fwd: Re: Few questions about submitting patches
Date: Mon, 26 Mar 2018 18:27:42 -0700
Message-ID: <alpine.OSX.2.21.1803261815180.1473@anandur-mobl3.amr.corp.intel.com>
In-Reply-To: 3b8f175a-3485-6725-ebc3-52f6d2e6ce47@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 421

--===============7203017517501430309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Rao -

On Wed, 21 Mar 2018, Rao Shoaib wrote:

> =

> There has been some misunderstanding on what an RFC patch is and what sta=
ndards it needs to meet. Following is the official response of David
> Miller.
>
> Based on those guidelines the RFC patch we submitted meets and exceeds th=
e requirements. So please review it. Replacement of function pointers
> will be addressed later as a separate issue.

Given what David has said, I still think it's better to structure the =

patch set according to the guidelines I pointed to before. Required? No, =

but I think it's worth the effort. You might not agree, and that's ok.

I know at least one other community member is taking a look at the first =

version of your patches. You mentioned that you are reworking your changes =

to invoke MPTCP functions using macros instead of indirect calls, so my =

personal plan is to take a closer look after you post v2.

> =

> In case there are other procedural issues that would prohibit technical d=
iscussion please site the written rules or first ask David Miller.
> =

> There are a lot of technical issues to discuss, so if possible lets not g=
et tied up on process and bureaucracy. Looking forward to detailed
> technical comments.
>

In my experience, a lot of the work involved in getting patches merged has =

been the unglamourous stuff to get the patches set up for review and =

upstreaming. My goal has been to help others and pass on that knowledge. =

But, to be clear, I'm not waiting for review based on the patch set =

structural changes, I want to look at everything in context with the =

macro/indirect call changes.

Thanks,

Mat


> =

> =

> -------- Forwarded Message --------
> Subject:
> Re: Few questions about submitting patches
> Date:
> Wed, 21 Mar 2018 12:46:17 -0400 (EDT)
> From:
> David Miller <davem(a)davemloft.net>
> To:
> rao.shoaib(a)oracle.com
> CC:
> netdev(a)vger.kernel.org, eric.dumazet(a)gmail.com
> =

> From: Rao Shoaib <rao.shoaib(a)oracle.com>
> Date: Wed, 21 Mar 2018 09:41:13 -0700
> =

> > I am new to Linux. I would like to understand the rules and etiquettes
> > of engaging with the community. I have read the materials that I could
> > find. As I work with Linux I come across situations for which I can
> > not seem to find any answers. Hopefully folks on the list can answer
> > them.
> > =

> > * Submitting an RFC Patch
> > =

> > As I understand, an RFC patch is submitted to solicit comments and is
> > not for inclusion. Is it sufficient for an RFC patch to have the
> > correct coding style and compile, or does it need more? For example,
> > If the patch consists of a series of patches, does each patch have to
> > compile independently etc etc.
> =

> It should build and function, unless you explicitly state that the
> patch is not build nor functionally tested and is intended to show
> the design of the change.
> =

> > * #ifdef FOO
> > =

> > In a regular patch consisting of a series of patches, can the above
> > #ifdef be used in a patch before the patch that allows the selection
> > of FOO. That patch is part of the series but comes later.
> =

> It is better to introduce them at the same time.
> =

> But if it is prohibitively difficult to do so, yet at the same
> time properly split up your changes into manageable pieces, it
> can be OK.
> =

> It is definitely determined on a case by case basis.
> =

>

--
Mat Martineau
Intel OTC

--===============7203017517501430309==--
