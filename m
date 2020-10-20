Content-Type: multipart/mixed; boundary="===============1011275872640180586=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [mptcp-dev] mptcp code in kernel 5.8
Date: Tue, 20 Oct 2020 16:36:21 +0200
Message-ID: <2371fbd8-1e8c-6ccc-4142-a1aac15069af@tessares.net>
In-Reply-To: CABbBbOtCThc1VP-XMBy05AyuntypDRfxVWDdZzNHT1Xav=eo1Q@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6365

--===============1011275872640180586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sandeep,

On 20/10/2020 16:19, Sandeep Irlanki wrote:
> So, MPTCP flow doesn't work if client is installed with MPTCP V1 and =

> server with MPTCP V0? In this case, Client falls back to TCP in initial =

> handshake itself?

Yes, that's correct.

This could work if the client was able to do a fallback to MPTCP v0 but =

the upstream implementation doesn't support v0 mainly because this =

version was recently deprecated and to simplify the code and maintenance.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1011275872640180586==--
