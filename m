Content-Type: multipart/mixed; boundary="===============5294844649820227853=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 00/13] mptcp: improve multiple xmit
 streams support
Date: Thu, 12 Nov 2020 17:49:30 +0100
Message-ID: <3fd7c25aa80db27949f1f18ece6b77e615955360.camel@redhat.com>
In-Reply-To: 20201112074025.5b932eaa@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com
X-Status: 
X-Keywords:                  
X-UID: 6687

--===============5294844649820227853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-11-12 at 07:40 -0800, Jakub Kicinski wrote:
> On Thu, 12 Nov 2020 11:47:58 +0100 Paolo Abeni wrote:
> > This series improves MPTCP handling of multiple concurrent
> > xmit streams.
> > =

> > The to-be-transmitted data is enqueued to a subflow only when
> > the send window is open, keeping the subflows xmit queue shorter
> > and allowing for faster switch-over.
> > =

> > The above requires a more accurate msk socket state tracking
> > and some additional infrastructure to allow pushing the data
> > pending in the msk xmit queue as soon as the MPTCP's send window
> > opens (patches 6-10).
> > =

> > As a side effect, the MPTCP socket could enqueue data to subflows
> > after close() time - to completely spooling the data sitting in the =

> > msk xmit queue. Dealing with the requires some infrastructure and =

> > core TCP changes (patches 1-5)
> > =

> > Finally, patches 11-12 introduce a more accurate tracking of the other
> > end's receive window.
> > =

> > Overall this refactor the MPTCP xmit path, without introducing
> > new features - the new code is covered by the existing self-tests.
> =

> Hi Paolo!
> =

> Would you mind resending? Looks like patchwork got confused about patch
> 6 not belonging to the series.

Sure, no problem.

AFAICS, the headers look correct ?!? in 6/13:

Message-Id: <653b54ab33745d31c601ca0cd0754d181170838f.1605175834.git.pabeni=
(a)redhat.com>
In-Reply-To: <cover.1605175834.git.pabeni(a)redhat.com>

In 0/13:
Message-Id: <cover.1605175834.git.pabeni(a)redhat.com>

Cheers,

Paolo

--===============5294844649820227853==--
