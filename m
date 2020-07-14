Content-Type: multipart/mixed; boundary="===============1072956361323701476=="
MIME-Version: 1.0
From: David Ahern <dsahern at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH iproute2-next 2/2] ss: mptcp: add msk diag
 interface support
Date: Tue, 14 Jul 2020 17:59:08 -0600
Message-ID: <b3b053a5-186e-a272-0576-65d0950295d4@gmail.com>
In-Reply-To: f99042572923cd0d569f3fa89393ca9b384ad1bf.1594388640.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5012

--===============1072956361323701476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 7/10/20 7:52 AM, Paolo Abeni wrote:
> This implement support for MPTCP sockets type, comprising
> extended socket info. Note that we need to add an extended
> attribute carrying the actual protocol number to the diag
> request.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  misc/ss.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 105 insertions(+), 10 deletions(-)
> =


applied to iproute2-next. Thanks


--===============1072956361323701476==--
