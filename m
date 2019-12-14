Content-Type: multipart/mixed; boundary="===============8306692346878211914=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 06/15] mptcp: Add key generation and token tree
Date: Sat, 14 Dec 2019 09:11:59 +0100
Message-ID: <ce134d2a-81af-b1f7-dca6-ff2532dfe9c4@tessares.net>
In-Reply-To: 6a9dc16c1f5fa7cbf648bd6a4f85ea45a0436032.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3066

--===============8306692346878211914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 14/12/2019 06:14, Peter Krystad wrote:
> On Fri, 2019-12-13 at 21:50 +0100, Matthieu Baerts wrote:
>> From: Peter Krystad <peter.krystad(a)linux.intel.com>
>>
>> Generate the local keys, IDSN, and token when creating a new socket.
>> Introduce the token tree to track all tokens in use using a radix tree
>> with the MPTCP token itself as the index.
> =

> Add here:
> =

> Override the rebuild_header callback in inet_connection_sock_af_ops for
> creating the local key on a new outgoing connection.
> =

> Override the init_req callback of tcp_request_sock_ops for creating the l=
ocal
> key on a new incoming connection.

A small detail but I see that init_req callback was already overriden =

before. Here, only the destructor callback is overriden (more extended).

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8306692346878211914==--
