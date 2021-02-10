Content-Type: multipart/mixed; boundary="===============0836253508202031099=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 0/3] mptcp: improve mptcp release
 callback
Date: Tue, 09 Feb 2021 17:09:47 -0800
Message-ID: <2442fc5f-7932-5c75-377f-9e67a31db5e8@linux.intel.com>
In-Reply-To: cover.1612869198.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7728

--===============0836253508202031099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 9 Feb 2021, Paolo Abeni wrote:

> The current callback implementation is probe to some race
> and still use some suboptimal code from older times.
>
> This series clean-up the code a bit, fixing the race
> and hopefully simplifying future wider usage of delegated
> actions
>
> Paolo Abeni (3):
>  mptcp: factor out __mptcp_retrans helper()
>  mptcp: fix race in release_cb
>  mptcp: clean-up the rtx path.
>
> net/mptcp/protocol.c | 164 +++++++++++++++++++++----------------------
> net/mptcp/protocol.h |   1 +
> 2 files changed, 81 insertions(+), 84 deletions(-)
>
> -- =

> 2.26.2

Thanks Paolo, series looks good:

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============0836253508202031099==--
