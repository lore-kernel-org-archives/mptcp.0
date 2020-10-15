Content-Type: multipart/mixed; boundary="===============2391698345307266884=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [mptcp-dev] mptcp code in kernel 5.8
Date: Thu, 15 Oct 2020 10:30:10 +0200
Message-ID: <380c19a3-1fe4-fa68-6b0c-0ef730eb9c3b@tessares.net>
In-Reply-To: CAO=PVE_C_hYEhAJbNuzBUqFMhAjUUxf1rb11H=ZrPOfduAi=-Q@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6311

--===============2391698345307266884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yoshi,

On 15/10/2020 10:09, yoshi nishida wrote:
> Hmm. I've tried v0.95 mptcp kernel and kernel5.8 on ubuntu20.10.
> I tried both version 0 and 1 on v.95, but didn't work. But, I might
> miss something.

I guess you are referring to a sysctl parameter, right? If yes, on =

v0.95, there is a partial support of MPTCPv1 regarding the modifications =

around ADD_ADDR (with or without HMAC I think) but that's it.

The v0.95 doesn't support the new way of initiating an MPTCP connection =

making v0 and v1 incompatible. Of course, except if a fallback from v1 =

to v0 is implemented, which is not the case in the upstream version.

But in other words, v0.95 is not compatible with MPTCPv1. Only =

mptcp_trunk is:

https://github.com/multipath-tcp/mptcp/tree/mptcp_trunk

> I will dig into this a bit more as well as some minor issues I noticed
> during the weekend.

Thanks!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2391698345307266884==--
