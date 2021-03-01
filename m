Content-Type: multipart/mixed; boundary="===============7942953881142249261=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Fwd: possible deadlock in ipv6_sock_mc_close
Date: Mon, 01 Mar 2021 15:36:32 +0100
Message-ID: <7cc24035-0ed1-0cf8-74ab-db54dd878e56@tessares.net>
In-Reply-To: 52f32eac6b3ee60b236d24c48f69d7e79db39013.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7973

--===============7942953881142249261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 01/03/2021 15:25, Paolo Abeni wrote:
> On Mon, 2021-03-01 at 14:58 +0100, Matthieu Baerts wrote:
>> This report from syzbot mentioned an possible deadlock with MPTCP
>> socket. I don't know if the commit from nfsd is really causing that.
>>
>> I'm then sharing this with the list just in case someone saw similar
>> issues :)
> =

> Looks like the deadlock report is valid, we should not invoke
> ipv6_sock_mc_close() under the socket lock.
> =

> I'm unsure why syzbot bisect to an nfs commit.
> =

> I'll test a fix via syzbot soon.

Thank you for looking at that!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7942953881142249261==--
