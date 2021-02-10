Content-Type: multipart/mixed; boundary="===============2695465805028968942=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 0/3] SYNRX: MPTCP -> MPTCP: expect x,
 got y
Date: Tue, 09 Feb 2021 16:39:06 -0800
Message-ID: <af402368-90d2-c58c-62d0-d2e7ae736cd6@linux.intel.com>
In-Reply-To: 20210208174548.493800-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7727

--===============2695465805028968942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 8 Feb 2021, Matthieu Baerts wrote:

> While working on issue #148, I also found a small typo: SYN info were
> printed instead of ACK ones, see patch 1/3.
>
> Then I put everything on one line and remove duplicated code, see patch
> 2/3.
>
> The last patch marks the test as failed if we found less MPC SYN/3rd
> ACK than expected. This will close:
>
>  https://github.com/multipath-tcp/mptcp_net-next/issues/148
>
> But at the end, just some small Bash modifications, nothing important
> ;-)
>
> Matthieu Baerts (3):
>  selftests: mptcp: fix ACKRX debug message
>  selftests: mptcp: display warnings on one line
>  selftests: mptcp: fail if not enough SYN/3rd ACK
>
> .../selftests/net/mptcp/mptcp_connect.sh      | 80 +++++++++++++------
> 1 file changed, 54 insertions(+), 26 deletions(-)
>
> -- =

> 2.29.2

Series looks good to me, had to modify mptcp_connect.sh to force =

some error output on my VM. Thanks Matthieu.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============2695465805028968942==--
