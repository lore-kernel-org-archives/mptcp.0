Content-Type: multipart/mixed; boundary="===============2543329838614291483=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 5/5] mptcp: add netlink event support
Date: Wed, 20 Jan 2021 18:23:57 +0100
Message-ID: <e8d51f52-c29a-b728-b345-416f85d84d67@tessares.net>
In-Reply-To: 20210120171921.GQ19605@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 7463

--===============2543329838614291483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 20/01/2021 18:19, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>>> +	sk_err =3D ssk->sk_err;
>>
>> Could we have an error set on the msk? (sk->sk_err)
> =

> Userspace interacts with the msk so it should already
> get proper errnos via syscalls, no?

I think likely the module (e.g. mptcpd) interacting with this in-kernel =

Netlink PM is not the one which initiated the connection (msk).

On the other hand, we also check that the msk is still in established =

mode. What kind of error could we have?

In mptcp.org, we might have taken the one from the meta "just in case".

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2543329838614291483==--
