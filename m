Content-Type: multipart/mixed; boundary="===============7608465869716156046=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 3/3] mptcp: emit tcp reset when a join
 request fails
Date: Tue, 01 Dec 2020 14:33:20 -0800
Message-ID: <73ccf7ca-258c-475-c7e8-7ee9d1a2d94@linux.intel.com>
In-Reply-To: 20201130153631.21872-4-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7001

--===============7608465869716156046==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Nov 2020, Florian Westphal wrote:

> RFC 8684 says:
> If the token is unknown or the host wants to refuse subflow establishment
> (for example, due to a limit on the number of subflows it will permit),
> the receiver will send back a reset (RST) signal, analogous to an unknown
> port in TCP, containing an MP_TCPRST option (Section 3.6) with an
> "MPTCP specific error" reason code.
>
> mptcp-next doesn't support MP_TCPRST yet, this can be added in another
> change.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/subflow.c | 47 ++++++++++++++++++++++++++++++++++-----------
> 1 file changed, 36 insertions(+), 11 deletions(-)
>

Thanks for the patch, Florian. Hopefully the first two in the series are =

ok with those maintainers, and for this one I can add:

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============7608465869716156046==--
