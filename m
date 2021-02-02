Content-Type: multipart/mixed; boundary="===============2467874818433239319=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 0/2] mptcp: handle socket errors
Date: Tue, 02 Feb 2021 15:58:50 -0800
Message-ID: <a82e7bd0-a56b-1333-2196-f12a8765234@linux.intel.com>
In-Reply-To: cover.1612201708.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7600

--===============2467874818433239319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Feb 2021, Paolo Abeni wrote:

> This introduces the initial support for msk-level socket error
> handling.
>
> Currently subflow socket errors are always ignored. That is almost
> correct - I think - because the single subflow status does not
> affect the msk-level connection.
>
> There a couple of notable exceptions:
> - fallen-back msk
> - error at connect time on the MPC subflow
> both should be propagated at msk level.
>
> patch 1 implement the relevant infra
> patch 2 is actuall a bug fix, for some edge cases that become
> apparent testing the above.
>
> I'll push a bunch of pktdrill test case which will cover the above.
>
> Paolo Abeni (2):
>  mptcp: deliver ssk errors to msk
>  mptcp: fix poll after shutdown
>
> net/mptcp/protocol.c | 11 ++++++++++-
> net/mptcp/protocol.h |  4 ++++
> net/mptcp/subflow.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 57 insertions(+), 1 deletion(-)
>
> -- =

> 2.26.2

Hi Paolo -

Both patches look good to me, and local build & selftests were good. =

Thanks!

--
Mat Martineau
Intel
--===============2467874818433239319==--
