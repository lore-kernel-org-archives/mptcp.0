Content-Type: multipart/mixed; boundary="===============1028013921969600743=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/4] mptcp: fallback socket cleanup
Date: Tue, 10 Dec 2019 17:47:07 -0800
Message-ID: <alpine.OSX.2.21.1912101736200.2679@mmazumd1-mobl.amr.corp.intel.com>
In-Reply-To: cover.1575999260.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2870

--===============1028013921969600743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Dec 2019, Paolo Abeni wrote:

> This addresses feedback from Mat on v1
>
> From the original cover letter:
> ---
>
> After all the above, performance for connection fallen back to plain TCP =
should
> be almost the same of TCP connection on unpacked kernel.
>
> Addittionally 'nc' and 'netperf' now run successfully when forced to MPTC=
P.
> The latter still report a non fatal error at connection closing time as it
> performs:
>
> getsockopt(4, SOL_TCP, TCP_MAXSEG, //...);
> getsockopt(4, SOL_TCP, TCP_INFO, //...);
>
> which is still unsupported after that the mp capable handshake is started.
>
> For the records on the debug build I'm using netperf scores better result
> with MPTCP that with plain TCP ;) [agreed, completely irrelevant, still n=
ice]
>

Hi Paolo -

The series looks good to me, and tests out ok on my side too when applied =

to today's export branch. Given the locking changes I think it would be =

helpful to have more than one reviewer.

> The series applies at selftests and is unsquashed - will require quite a =
bit
> of work there and more work to rebase/adjust the patches after kselftest.
> I'll start that after the pending patches are in.

That was going to be my next question! Thanks for starting on that.


Mat


>
> _Any_ feedback _very_ welcome!
>
> Paolo Abeni (4):
>  mptcp: clear 'is_tcp' socket flag when the MP_CAPABLE handshake fails
>  mptcp: cleanup fallback handling
>  mptcp: add subflow to conn_list early
>  mptcp: avoid acquiring the msk lock in mptcp_finisch_connect()
>
> net/mptcp/options.c  |   3 +
> net/mptcp/protocol.c | 353 ++++++++++++++++++++-----------------------
> net/mptcp/subflow.c  |   2 +
> 3 files changed, 169 insertions(+), 189 deletions(-)

--
Mat Martineau
Intel
--===============1028013921969600743==--
