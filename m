Content-Type: multipart/mixed; boundary="===============2931211396532640939=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v4 mptcp-net-next 00/12] Code-removal out of
 mptcp-net-next
Date: Fri, 21 Dec 2018 10:25:45 -0800
Message-ID: <20181221182544.GD87545@MacBook-Pro-19.local>
In-Reply-To: alpine.OSX.2.21.1812211018340.53308@samaxfie-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 968

--===============2931211396532640939==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 21/12/18 - 10:19:33, Mat Martineau wrote:
> =

> On Fri, 21 Dec 2018, Christoph Paasch wrote:
> =

> > Series removing a lot of code out of mptcp-net-next.
> > =

> > Before:
> > $ git diff --shortstat  1464193107da..mptcp-net-next/master
> > 54 files changed, 14663 insertions(+), 375 deletions(-)
> > =

> > After:
> > $ git diff --shortstat  1464193107da..HEAD
> > 50 files changed, 12213 insertions(+), 349 deletions(-)
> > =

> > =

> > v4: Minor left-over removals that were missing - identified by Mat
> > v3: Minor left-over removals that were missing - identified by Matthieu
> > v2: Some minor fixes - see notes in the sub-patches 4/12 and 12/12
> > =

> =

> Thanks Christoph. I've applied the patches and will merge mptcp_net-next
> with net-next.

Awesome!!!

I am sending my next set properly with gerrit ;-)


Christoph


--===============2931211396532640939==--
