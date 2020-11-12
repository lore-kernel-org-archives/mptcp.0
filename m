Content-Type: multipart/mixed; boundary="===============1994261043492348867=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 00/13] mptcp: improve multiple xmit
 streams support
Date: Thu, 12 Nov 2020 07:40:25 -0800
Message-ID: <20201112074025.5b932eaa@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: cover.1605175834.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6685

--===============1994261043492348867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Nov 2020 11:47:58 +0100 Paolo Abeni wrote:
> This series improves MPTCP handling of multiple concurrent
> xmit streams.
> =

> The to-be-transmitted data is enqueued to a subflow only when
> the send window is open, keeping the subflows xmit queue shorter
> and allowing for faster switch-over.
> =

> The above requires a more accurate msk socket state tracking
> and some additional infrastructure to allow pushing the data
> pending in the msk xmit queue as soon as the MPTCP's send window
> opens (patches 6-10).
> =

> As a side effect, the MPTCP socket could enqueue data to subflows
> after close() time - to completely spooling the data sitting in the =

> msk xmit queue. Dealing with the requires some infrastructure and =

> core TCP changes (patches 1-5)
> =

> Finally, patches 11-12 introduce a more accurate tracking of the other
> end's receive window.
> =

> Overall this refactor the MPTCP xmit path, without introducing
> new features - the new code is covered by the existing self-tests.

Hi Paolo!

Would you mind resending? Looks like patchwork got confused about patch
6 not belonging to the series.
--===============1994261043492348867==--
