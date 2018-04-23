Content-Type: multipart/mixed; boundary="===============3272597600421816237=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP Upstreaming wiki
Date: Mon, 23 Apr 2018 13:11:15 -0700
Message-ID: <f4ba293a-8cd4-8996-4400-579de2e46532@oracle.com>
In-Reply-To: alpine.OSX.2.21.1804201707090.3140@hunteral-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 544

--===============3272597600421816237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/20/2018 05:17 PM, Mat Martineau wrote:
>
> Hello -
>
> I've set up a wiki for our project:
>
> https://github.com/multipath-tcp/mptcp_net-next/wiki
>
> To start with I've added some information that was otherwise buried in =

> our mailing list archives. This includes a summary of what the =

> community has shared so far, meeting information, and pointers to =

> relevant resources.
>
> Regards,
>
> -- =

> Mat Martineau
> Intel OTC
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
Hi Mat,

Why is the following a requirement for the initial implementation

"Move away from meta-sockets, treating each subflow more like a regular =

TCP connection. The overall MPTCP connection is coordinated by an upper =

layer socket that is distinct from tcp_sock."

This can be done later.

Shoaib

--===============3272597600421816237==--
