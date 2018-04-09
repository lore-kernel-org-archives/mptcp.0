Content-Type: multipart/mixed; boundary="===============1519108867094424251=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 1/9] Modify tcp structures to support function
 pointers
Date: Sun, 08 Apr 2018 21:41:01 -0700
Message-ID: <20180409044101.GW16289@MacBook-Pro-6.local>
In-Reply-To: 619b7db7-0613-4eb6-b3a9-08d21bed1b99@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 522

--===============1519108867094424251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 30/03/18 - 10:32:23, Rao Shoaib wrote:
> =

> =

> On 03/27/2018 02:36 AM, Christoph Paasch wrote:
> > =

> > it is important to explain (in the commit-message) for each of these ca=
llbacks
> > why they are needed for an MPTCP implementation and why it can't be done
> > without them.
> > =

> > This is important to allow people to understand why the change is neces=
sary and
> > where it is leading to. Ignoring potential performance hits for a momen=
t,
> > callbacks also increase the code-maintenance overhead and thus each of =
them
> > will need to justified.
> > =

> > =

> > Christoph
> > =

> > =

> > =

> These callbacks are needed to make the code more readable and maintainabl=
e.
> These will be replace by the macro anyways so this does not matter.

Even with the macros, it is important to describe to the reviewer in the
commit message why each of these changes is there for.


Christoph


--===============1519108867094424251==--
