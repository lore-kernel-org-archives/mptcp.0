Content-Type: multipart/mixed; boundary="===============2896979610565639371=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 4/4] mptcp: avoid acquiring the msk lock in
 mptcp_finisch_connect()
Date: Mon, 09 Dec 2019 18:30:37 -0800
Message-ID: <alpine.OSX.2.21.1912091829030.11558@mjmartin-mac01.local>
In-Reply-To: ed8c7ad0df1e4a085a37ebf1021172cd4419999c.1575934525.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2856

--===============2896979610565639371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Dec 2019, Paolo Abeni wrote:

> Move the mptcp_copy_inaddrs() into mptcp_finish_connect(), so that
> the mks lock is no longer required. Just document the unlocked access
> with WRITE_ONCE().
>
> Since we now always acquire msk -> ssk lock in order, we can also
> avoid the msk lock/subflow lookup()/get()/ msk unlock()/ subflow op/ subf=
low put
> dance in most ops - simply keep the msk lock held the whole time.
>
> Additionally we can simplify mptcp_getname(), as now the address informat=
ion
> are always available in the msk.
>
> RFC -> v1:
> - move mptcp_copy_inaddrs() into finish_connect()
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 211 +++++++++++++++++--------------------------
> 1 file changed, 83 insertions(+), 128 deletions(-)
>

Code changes look good to me - it does clean things up nicely to keep the =

msk lock in those operations.

Thanks,

--
Mat Martineau
Intel
--===============2896979610565639371==--
