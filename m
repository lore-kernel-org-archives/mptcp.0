Content-Type: multipart/mixed; boundary="===============6416320288590665501=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 0/3] mptcp: fix MP_JOIN failure
 handling
Date: Fri, 15 May 2020 12:30:59 -0700
Message-ID: <20200515.123059.151278519835306555.davem@davemloft.net>
In-Reply-To: cover.1589558049.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4402

--===============6416320288590665501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Fri, 15 May 2020 19:22:14 +0200

> Currently if we hit an MP_JOIN failure on the third ack, the child socket=
 is
> closed with reset, but the request socket is not deleted, causing weird
> behaviors.
> =

> The main problem is that MPTCP's MP_JOIN code needs to plug it's own
> 'valid 3rd ack' checks and the current TCP callbacks do not allow that.
> =

> This series tries to address the above shortcoming introducing a new MPTCP
> specific bit in a 'struct tcp_request_sock' hole, and leveraging that to =
allow
> tcp_check_req releasing the request socket when needed.
> =

> The above allows cleaning-up a bit current MPTCP hooking in tcp_check_req=
().
> =

> An alternative solution, possibly cleaner but more invasive, would be
> changing the 'bool *own_req' syn_recv_sock() argument into 'int *req_stat=
us'
> and let MPTCP set it to 'REQ_DROP'.
> =

> v1 -> v2:
>  - be more conservative about drop_req initialization
> =

> RFC -> v1:
>  - move the drop_req bit inside tcp_request_sock (Eric)

Series applied, thanks Paolo.
--===============6416320288590665501==--
