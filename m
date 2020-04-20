Content-Type: multipart/mixed; boundary="===============7700772211859673167=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 3/4] ss: allow dumping MPTCP subflow information
Date: Mon, 20 Apr 2020 18:47:21 +0200
Message-ID: <c07afd2b-017e-4e04-3b5c-3de0378c395a@tessares.net>
In-Reply-To: 075c9ea7d3368d21972405166574cb7e4efe34ce.1587139599.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4207

--===============7700772211859673167==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

Thank you for the new version!

On 17/04/2020 18:08, Paolo Abeni wrote:
> From: Davide Caratti <dcaratti(a)redhat.com>
> =

>   [root(a)f31 packetdrill]# ss -tni
> =

>   ESTAB    0        0           192.168.82.247:8080           192.0.2.1:3=
5273
>            cubic wscale:7,8 [...] tcp-ulp-mptcp flags:Mec token:0000(id:0=
)/5f856c60(id:0) seq:b810457db34209a5 sfseq:1 ssnoff:0 maplen:190
> =

> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>   man/man8/ss.8 |  5 +++++
>   misc/ss.c     | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 67 insertions(+)
> =

> diff --git a/man/man8/ss.8 b/man/man8/ss.8
> index 023d771b..c80853f9 100644
> --- a/man/man8/ss.8
> +++ b/man/man8/ss.8
> @@ -261,6 +261,11 @@ the pacing rate and max pacing rate
>   .TP
>   .B rcv_space:<rcv_space>
>   a helper variable for TCP internal auto tuning socket receive buffer
> +.P
> +.TP
> +.B tcp-ulp-mptcp flags:[MmBbJjecv] token:<rem_token(rem_id)/loc_token(lo=
c_id)> seq:<sn> sfseq:<ssn> ssnoff:<off> maplen:<maplen>
> +MPTCP subflow information
> +.P

Do you think we can also add what each of "MmBbJjecv" means? :-)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7700772211859673167==--
